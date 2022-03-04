# Accessing Private EC2 instances with AWS System Manager

There are occasions when you want to SSH onto your EC2 instance. One way to do this is to set up a bastion host and configure security group access to it via a public IP address. However, what if your EC2 instance is on a private subnet - say for example that your organisation prohibits SSH access from the world. Normally they will have ways to get in - e.g. via VPN or VPC peering. However, it is possible to use AWS System Manager to gain direct access to the EC2 instance without a huge amount of network configuration. Here's how.

How it works is this:

1. On boot, an agent on the EC2 instance contacts SSM to let it know it is manageable
2. When you use the SSM cli agent to connect to the instance, the SSM services talk to the agent to establish a terminal session iver HTTPS

## Checklist

1. Grant SSM assume role access to the instance
2. Set up VPC endpoints to allow SSM services into your subnet
3. Create security groups to allow the SSM agent and SSM services to communicate
4. Install the SSM agent on the instance, if it is not already
5. Connect via the SSM cli plugin

## SSM AssumeRole access

See [iam.tf](terraform/iam.tf) for the role configuration. This role is assigned as the `iam_instance_profile` attribute in the [EC2 instance](terraform/ec2.tf).

This role is assumed by the SSM agent on the EC2 instance, allowing it to perform the appropriate actions to register itself with SSM.

## VPC endpoints

See [vpc.tf](terraform/vpc.tf) for the VPC endpoint configuration.

VPC endpoints are local connections to specific AWS services, allowing a subnet's occupants to communicate directly with those services without the need for publicly routable configuration, such as internet gateways and route tables. The VPC endpoints get bound to IPs on the subnet(s) and assigned a security group to allow this communication. In our case, we just need the SSM services (3 separate VPC endpoints) to be able to communicate with the agents [on port 443](terraform/sg.tf) on each EC2 instance.

## Installing the SSM agent

Amazon-supplied AMIs come with the SSM agent pre-installed. For vendor-supplied AMIs (or ones we roll ourselves), we have to install the agent. This can be done by uploading the installation script as `user_data` (though this might conflict with the AMI if it already expects its own data).

See [install-ssm-agent-dpkg.sh](terraform/static/install-ssm-agent-dpkg.sh) for an example. Obviously the package manager depends on the AMI operating system.