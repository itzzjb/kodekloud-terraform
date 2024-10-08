# Traditional IT and Challenges

### Disadvantages of the traditional model:

1. The turnover time can range between weeks to months. This is just to get the system to ready state to begin the application deployment. Includes the time it takes to the system to be procured and hand it over between teams. Also scaling up and scaling down infrastructure on demand cannot be achieved quickly.
2. The overall cost to deploy and maintain this model is generally quiet high.
3. While some aspects of the infrastructure profiling process can be automated, several steps like rack and stack, cabling and other deployment procedures are manual and slow.
4. With so many teams are working on so many different tasks chances of human error are high and this results in inconsistent environments.
5. Another major disadvantage of this model is the under utilization of the compute resources. The infrastructure sizing activity will generally carried out well in advance and the severs are sized considering the peak utilization. The inability to scala up or down easily means most of these resources would not be used during off-peak hours.

### Advantages of moving to cloud

1. The time to spin up the infrastructure and time to market for applications are significantly reduced. This is because in cloud you do not have to invest in or manage the actual hardware assets. The data center, hardware assets and services are managed by the cloud provider. A virtual machine can be spun up in a cloud environment in a matter of minutes. Time to market is reduced from several months to weeks.
2. Infrastructure costs are reduced when compared to additional data center management and human resources cost.
3. Cloud infrastructure comes with support to APIs. And that opens up a whole new world of opportunity for automation.
4. The built in auto scaling and elastic functionality of cloud infrastructure reduces resource wastage.

# Infrastructure as Code (IaC)

We can use the management console of various cloud providers. The better way to provision cloud infrastructure is to codify the entire provisioning process. This way we can write and execute code to define, provision, configure, update and destroy infrastructure resources. This is called **Infrastructure as Code** (IaC).

It's not easy to manage shell script (or other types of scripts) that we can use to provision the infrastructure. It requires programming and development skills to build and maintain. There's a lot of logic you need to code and it's not reusable.

That is where tools like **Terraform and Ansible** comes in. They help with code by making it easy to learn, human readable and easy to maintain. A large shell script can be converted into a simple terraform configuration file. This is written is a **human readable high level language**.

# IaC Tools

Even thought we can possibly make use of any of these tools to design similar solutions, they have all being created to address a very specific goal.

| Type                     | Examples                                    | Description                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| ------------------------ | ------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Configuration Management | Ansible, Chef, Puppet, Salt Stack           | Commonly **used to install and manage software on existing infrastructure resources**. These tools maintain a consistent and standard structure of code. These can be checked into a version control repository. Most important feature is that they are **idempotent**. This means that you can run the code multiple times, and every time you run it will only make changes that are necessary to bring the environment to a defined state. |
| Server Templating        | Docker, HashiCorp Packer, HashiCorp Vagrant | Can be used to **create custom image of a virtual machine or a container**. These images already contain all the software and dependencies that is required already on them. ( custom AMIs in AWS, docker images in dockerhub). These also promote **immutable** infrastructure. We update the image and redeploy a new instance using the updated image.                                                                                      |
| Provisioning Tools       | HashiCorp Terraform, Cloud Formation        | These tools are **used to provision infrastructure components using a simple declarative code**. While cloud formation is specifically designed to deploy services in AWS, terraform support provider plugins for almost all major cloud providers.                                                                                                                                                                                            |

# Terraform

Terraform ia a IaC tool which is specifically useful as a infrastructure provisioning tool. This is a free and open-source tool.

One of the biggest advantage of terraform is it's **ability to deploy infrastructure across multiple platforms including private and public clouds**. This is achieved through **providers**.

Provider helps terraform manage third party platforms through their API. The third party platforms may be cloud platforms,network infrastructure, monitoring and data management tools, databases and version control systems.

Terraform uses **HCL (HashiCorp Configuration Language)** which is a simple declarative language to define the infrastructure resources to be provisioned as blocks of code. All of these resources can be defined within configuration files that has a **.tf** extension.

These codes are declarative and can be maintained in a version control system.

### Declarative ?

The code that we define is the **desired state that we want our infrastructure to be in**. Terraform will **take care of what is required to go from the current state to the desired state** without us having to worry about how to get there.

Terraform works in 3 phases:

1. **init**:
   - Terraform initializes the process and identifies the providers to be used for the target environment.
2. **plan**:
   - Terraform graphs a plan to get to the target state from the current state.
3. **apply**:
   - Terraform makes the necessary changes required on the target environment ro bring it to the desired state.

### Resource ?

Every object that terraform manages is called a "**resource**". This can be a compute instance, a database server in the cloud or in a physical server.

Terraform **manages the lifecycle of a resource from provisioning, to configuration to decommissioning**.

Terraform records the state of the infrastructure as it is seen in the real world (in a file called terraform.tfstate) and based on this it can determine what actions to take when updating resources.

Terraform can **ensure that the entire infrastructure is always in the defined state at all times**. State is blueprint of the infrastructure deployed by terraform.

Terraform cloud and Terraform Enterprise provide additional features that allows simplifies collaboration between teams, managing infrastructure, improved security and centralized UI to manage terraform deployments.
