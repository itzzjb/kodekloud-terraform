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

Terraform uses **HCL (HashiCorp Configuration Language)** which is a simple declarative language to define the infrastructure resources to be provisioned as blocks of code. All of these resources can be defined within configuration files that has a `.tf` extension.

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

Terraform records the state of the infrastructure as it is seen in the real world (in a file called `terraform.tfstate`) and based on this it can determine what actions to take when updating resources.

Terraform can **ensure that the entire infrastructure is always in the defined state at all times**. State is blueprint of the infrastructure deployed by terraform.

Terraform cloud and Terraform Enterprise provide additional features that allows simplifies collaboration between teams, managing infrastructure, improved security and centralized UI to manage terraform deployments.

# HCL

HCL file consists of blocks and arguments. A **block is defined with in curly braces** and it **contains a set of arguments in key value pair format** representing the configuration data.

```hcl
<block> <parameters> {
    key1 = value1
    key2 = value2
}
```

The following is are some examples for configuration files in terraform.

```hcl
resource "local_file" "pet" {
  filename = "/root/pet.txt"
  content = "We love pets!"
}
```

```hcl
resource "aws_instance" "webserver" {
  ami = "ami-005fc0f236362e99f"
  instance_type = "t2.micro"
}
```

# Terraform Workflow

A simple terraform workflow consists of 4 steps.

1. **_Write_** the configuration file
2. Run the `terraform init` command
3. After that review the execution plan using `terraform plan` command
4. Finally, once we are ready apply the changes using `terraform apply` command

Let's get the previous example of the local_file here as well.

1. The configuration file is already written an ready.
2. First we are running the `terraform init` command. This command will check the configuration file and initialize the working directory containing the `.tf` file. This command does is understand that we are making use of the local provider based on the resource type declared in the resource block. It will then download the plugin to be able to work on the resources declared in the `.tf` file. From the output of the command we can see that a plugin called local has being installed.
3. Before we are creating the resource we can see the execution plan that would be carried out by terraform, we can use the command `terraform plan`. This command will show the actions that will be carried out by terraform to create the resource. The resources that need to be created and need to be removed are shows using `+` and `-` signs. This includes all the arguments that we specified in the `.tf` file and there might be some default and optional arguments we didn't specifically declared as well. This step will not create the infrastructure resource yet, thins information is provided to the user to review and ensure that all the actions to be performed in this execution plan is desired.
4. After the review we can create the resource. And to do this we make use of the `terraform apply` command. This command will display the execution plan once again and it will then ask the user to confirm by typing `yes` to proceed. Then it will proceed with the creation of the resource.
5. We can use the `terraform show` within the configuration directory to see the details of the resource that we just created. This command inspects the state file and displays the resource details.

# Update and Delete Infrastructure

Once we do a update to the `.tf` file like changing the name of the `pet.txt` file to `pets.txt`, from the output of `terraform plan` command we can see that the file will be replaced. `-/+` symbol in the resource plan implies that the resource will be deleted and re-created. This type of infrastructure is called a **_immutable infrastructure_**.

If you want to go ahead with the change, use the `terraform apply` command to update. Upon confirmation the existing resource will be deleted and recreated. To delete the infrastructure completely, run the terraform destroy command. Same as `terraform apply` this shows the execution plan and you can see every resources and arguments have `-` in front of them. To go ahead with this you need to confirm `yes` with a prompt. This will delete all the resources in the current configuration directory.

# Terraform providers

After we write a terraform configuration file, the first thing to do is to initialize the directory with the `terraform init` command. When we run that command **_within a directory containing the configuration files_**, terraform downloads and installs plugins for the providers used within the configuration. This can be plugins for cloud providers such as AWS or something as simple as the local provider.

Terraform uses a plugin based architecture to work with hundreds of such infrastructure platforms. Terraform providers are distributed by HashiCorp and are publicly available in the terraform registry at url [registry.terraform.io](registry.terraform.io).

There are 3 tiers of providers.

| Provider                | Examples                            | Description                                                                                                                          |
| ----------------------- | ----------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------ |
| **Official** Provider   | AWS, GCP, Azure, Local              | These are owned and maintained by HashiCorp.                                                                                         |
| **Verified** Provider   | bigip, heroku, digitalocean         | These are owned and maintained by a third party technology company, that has gone through a partner provider process with HashiCorp. |
| **Community** Providers | activedirectory, ucloud, netapp-gcp | These are published and maintained by individual contributors of the HashiCorp community.                                            |

The output of the `terraform init` command shows the version of the plugin as well.

The plugins are downloaded into a hidden directory called `.terraform/plugins` in the working directory containing the configuration files.

The plugin name that we can see in the output of the `terraform init` command is also known as the **source address**. This is an identifier that is used by terraform to locate and download the plugin from the registry.

Let's take the example,

```sh
* hashicorp/local: version = "~> 2.00"
```

**hashicorp**: organizational namespace
**local**: type (name of the provider)

The plugin name can also **_optionally have a hostname_** is front. The hostname is the name of the name of the registry where the plugin is located. If omitted it defaults to `registry.terraform.io` which is HashiCorp's public registry.

```sh
* registry.terraform.io/hashicorp/local: version = "~> 2.00"
```

By default terraform installs the **latest version** of the provider. We can lock down our configuration files to make use of a specific provider version as well.

# Configuration Directory

We can create multiple configuration files in a single directory (configuration directory). When applied terraform will consider every file with the `.tf` extension within the configuration directory.

Another common practice is to have **single configuration file that contains all the resource blocks** required to provision the infrastructure. A single configuration file can have as many configuration blocks as you need. A common naming convention used for such configuration file is `main.tf`.

There are multiple types of configuration files that can be created within a directory.

| File name      | Purpose                                                |
| -------------- | ------------------------------------------------------ |
| `main.tf`      | Main configuration file containing resource definition |
| `variables.tf` | Contains variable declarations                         |
| `outputs.tf`   | Contains outputs from the resources                    |
| `provider.tf`  | Containers provider definition                         |

# Multiple Providers

Terraform also allows to have multiple providers within the same configuration.

```hcl
# local provider
resource "local_file" "pet" {
    filename = "C:/Users/januda.bethmin.de.si/Desktop/kodekloud-terraform/multiple-example/pet.txt"
    content = "We love pets!"
}

# random provider
# this resource type provided by the random provider creates random pet name
resource "random_pet" "my_pet" {
  prefix = "Mr."
  separator = "."
  length = "1"
}
```

Once you use the `terraform init` command only the providers that are not in the `.terraform/providers` will be downloaded and installed. Others will be reused.

# Variables

When writing configuration files for resources, we would need to assign values to different types of arguments. But harcoding values directly in the configuration files is not a good idea. It limits the reusability of the code which defeats the purpose of IaC. We must be **able to use the same code again and again based on a set of input variables that can be provided during the execution**.

To assign varibale we can make a new configuration file called `variables.tf`.

**variable.tf**

```hcl
# We use the Variable block here
# we are passing in the variable name after the block name
# even though we give any name for the variable, we
variable "filename" {
    # we are passing in the default value we are giving the variable
    default = "C:/Users/januda.bethmin.de.si/Desktop/kodekloud-terraform/variables-example/pets.txt"
}

variable "content" {
    default = "We love pets!"
}

variable "prefix" {
    default = "Mr."
}

variable "separator" {
    default = "."
}

variable "length" {
    default = "1"
}
```

**main.tf**

```hcl
# we can use the variables assigned in the variables.tf file in main.tf file
# var.<variable_name>
resource "local_file" "pet" {
    filename = var.filename
    content = var.content
}

resource "random_pet" "my-pet" {
    prefix = var.prefix
    separator = var.separator
    length = var.length
}
```

Variables will be automatically assigned when we use the `terraform apply` command. If we want to make some updates to the resources by making changes to the existing arguments, we can do that by just updating the `variables.tf` file. The `main.tf` will not be modified.

## More about variable block

Varible block can take 3 arguments. (**default, type, description**)

**default** :

- This is where we specify the default value for a variable.

**type**:

- This is optional. But when used if enforces the type of variablle beign used. The basic types that can used are **_string, number, bool & any_**. If the type is not specified in the variable block it is set to the type **_any_** by default.
- Besided these 3 main varible types terraform also supports additional data types such as **_list, map, object, tuple_**.
  | Type | Example |
  | --- | --- |
  | string | "/root/pets.txt" |
  | number | 1 |
  | bool | true/false |
  | any | Default Value |
  | list | ["cat", "dog"] |
  | map | pet1 = cat pet2=dog |
  | object | Complex Data Structure |
  | tuple | Complex Data Structure |

**descriptiom**:

- This is optional. But it is a good practice to use this argument to describe what the variable is used for.

### List

List is a numbered collection of values. We call it a numbered collection because **_each value/element can be referenced by the number or index within that list_**. The index of a list always begins at 0.

These varibles can be accesed within a configuration file by using the index specified within the square brackets. 

**main.tf**
```hcl
resource "random_pet" "my-pet" {
    # we can use different values of the list through the index
    prefix = var.prefix[0]
}
```
**variables.tf**
```hcl
variable "prefix" {
    # these are the values we are a
    default = ["Mr", "Mrs", "Sir"]
    # We are specifying the type as list
    type = list
}
```

### Map

In a map the data is **_represented in the format of key-value pairs_**. In the default value section we can have as many key-value pairs as needed. 

To access a specific value from the within the terraform configuration file we can use key matching. 