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

- This is where we specify the default value for a variable. This is also **_optional_**.

**type**:

- This is **_optional_**. But when used if enforces the type of variablle beign used. The basic types that can used are **_string, number, bool & any_**. If the type is not specified in the variable block it is set to the type **_any_** by default.
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

- This is **_optional_**. But it is a good practice to use this argument to describe what the variable is used for.

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
    type = list(string)
}
```

### Map

In a map the data is **_represented in the format of key-value pairs_**. In the default value section we can have as many key-value pairs as needed. 

To access a specific value from the within the terraform configuration file we can use key matching. 

**main.tf**
```hcl
resource "local_file" "pet" {
    filename = "C:/Users/januda.bethmin.de.si/Desktop/kodekloud-terraform/map-example/pet.txt"
    # we need to use key matching to access the values of the map
    # here we are using the value of the key statement2
    content = var.content["statement2"]
}
```

**variables.tf**
```hcl
variable "content" {
    # We are specifying the type as map
    # we can specify the data type of the map we want
    type = map(string)
    # we specify as many key value pairs enclosed within curly braces
    default = {
        # statement1 and statement2 are Keys and the data following them are Values
        "statement1" = "We love pets!"
        "statement2" = "We love animals!"
    }
}
```
>[!NOTE]
> If the data type incorrect after we implemented type constraint there will be an error in the outputs of `terraform plan` or `terraform apply` commands. 

### Set

The difference between a Set and a List is that **a Set cannot have duplicate elements**. 

Trying to access a specific index of a set, which is not possible in Terraform. We need to convert it to a list.

**main.tf**
```hcl
resource "random_pet" "my-pet" {
    # Convert the set to a list and get the first element
    prefix = tolist(var.prefix)[0]
}
```

**variables.tf**
```hcl
variable "prefix-list" {
    type = list(string)
    # in lists we can use the same value multiple time
    default = ["Mr", "Mr", "Mr"]
}

variable "prefix" {
    type = set(string)
    # in sets each value should be unique
    default = [ "Mr", "Mrs", "Sir" ]
}
```

### Objects

With objects we can create complex data structures by combining all the variable types. 

**variables.tf**
```hcl
variable "bella" {
    # just like type = list(string)
    # but here instead of string we are giving a datastructure as a data type
    # it's defined in another {}
    type = object ({
        name = string
        color = string
        age = number
        food = list(string)
        favourite_pet = bool
    })
    # setting the default values of the above specified fields
    default = {
        name = "bella"
        color = "brown"
        age = 7
        food = ["fish", "chicken", "turkey"]
        favourite_pet = true
    }
}
```
### Tuples

Tuple is similar to a list, and consists of a sequence of elements. The difference between a tuple and list is that list uses elements of the same variable type. But in case of **_we can make use of elements of different variable types_**. The type of variable to be used in a tuple is defined within the squre brackets. 

**variables.tf**
```hcl
variable "kitty" {
    # we can define the type of variables that we use in the tuple inside []
    # the variables that need to be passed to this should exactly be 3 in number and of that specific type for it to work
    type = tuple([string, number, bool])
    default = ["cat", 7, true]
}
```

Adding additional elements or incorrect type will result in an error as seen here. You will get an error in the output of the `terraform plan` or `terraform apply` command. 

# Different ways of using variables in Terraform

### Interactive Mode

In `variables.tf` the default value for the variables are options. You can keep them empty if needed.

```hcl
variable "filename" {
    # default values are not defined
}

variable "content" {
    # default values are not defined
}
```
When we run `terraform apply` now, **_we will be prompted to enter values for each variables used in an interactive mode_** one at a time.

### Command line flags

If we wan't we can also use command line flags with the `terraform apply` command. We can use the `-var "<variable_name>=<value>"`.

```sh
terraform apply -var "filename=/root/pets.txt" -var "content=We love Pets!" -var "prefix=Mrs" -var "separator=." -var "length=2"
```

### Environment Variables

We can also make use of environment variables.

```sh
export TF_VAR_filename="/root/pets.txt"
export TF_VAR_content="We love pets!"
export TF_VAR_prefix="Mrs"
export TF_VAR_separator="."
export TF_VAR_length="2"
terraform apply
```

Here for one example, `TF_VAR_filename` sets the value of filename variable to value "/root/pets.txt". 

### Variable Definition Files

Finally **_when we are dealing with lots of variables_**, we can load values by using a variable definition file. These variable definition files can be named anything and always should end with `.tfvars` or `.tfvars,json`.

If you use `terraform.tfvars` , `terraform.tfvars.json`, `*.auto.tfvars` or `*.auto.tfvars.json`, this file will be **automatically** picked up by Terraform. 

If you use any other filename, such as `variables.tfvars` you will have to pass along that with a command line flag called `-var-file`.
```sh
terraform apply -var-file variables.tfvars
```
**terraform.tfvars**
```hcl
# This is using the same syntax as the hcl file, but only consists of variable assignments
filename = "/root/pets.txt"
content = "We love pets!"
prefix = "Mrs"
seperator = "."
length = "2"
```
>[!NOTE]
> We can use any of the options above to assign values to the variables, but if we use multiple ways to assign values to the same variable terraform follows a **_variable definition precedence_** to understand which value it should accept. 

**Order of Acceptance**
| Order | Option |
| --- | --- |
| 1 | Environment Variables |
| 2 | terraform.tfvars |
| 3 | *.auto.tfvars (alphebetical order) |
| 4 | -var or -var-file (command line flags) |

If **_every method is used, the -var of -var-file_** will be used.

# Resource Attribute Reference

In a real world scenario there will be multiple resources that depends on each other. We **_might need to get the output of one resource and use it as a input for another one_**. 

You can use the documentation of the resource type from the terraform registry. In the **_attribute reference_** section you will be able to find the **_list of attributes return back from resource_** after you run `terraform apply`. 

We can use these returning attributes of a resource in another resource.

**main.tf**
```hcl
resource "local_file" "pet" {
  filename = var.filename
  # the random_pet resource will return a attribute called id as a output that contains the pet name
  # we can use that attribute called id here in the local_file resource
  content = "My favourite pet is ${random_pet.my-pet.id}"
  # You can use it directly like this as well
  # content = random_pet.my-pet.id
}

resource "random_pet" "my-pet" {
  prefix = var.prefix
  separator = var.seperator
  length = var.length
}
```
# Resource Dependencies in Terraform

We can link one resource to another rosource using reference attributes. When terraform creates these resources it knows about the dependency. For example as above, the local_file resource depends on random_pet resource. As a result, first terraform creates the random_pet resource and then it creates the local_file resource. When resources are deleted terraform deletes it on the reverce order.

This types of dependency is called **_implicit dependency_**. We are not explicitly specifying which resource is dependant on which other resource. Terraform figures it out by it self. 

There is another way to specify dependencies whithin the configuration file. 

**main.tf**
```hcl
resource "local_file" "pets" {
  filename = var.filename
  content = var.content
  # if there is no implicit dependency, we can create a explicit dependency as needed.
  # we can do that by usinf depends_on argument
  depends_on = [ 
    # here are are mentioning the <resource_type>.<resource_name> that depends on
    random_pet.my-pet 
  ]
}

resource "random_pet" "my-pet" {
  prefix = var.prefix
  separator = var.seperator
  length = var.length
}
```
This type of dependency is called **_explicit dependency_**. Explicitly specifying a dependency is only neccesary **_when a resource relies on some other resource indirectly and it does not make use of a reference expression_**.

# Output Variables

Along with input variables, terraform also supports output variables. This output variables **_can be used to store a value of a reference expression in terraform_**. 

The synatax used here is.
```hcl
output "<variable_name>" {
    # here the mandatory argument value get the value of the reference expression
    value =  "<variable_value>"
    <other_arguments>
}
```
After declaring, once you run the `terraform apply` command the output variable will be printed in the screen.

**main.tf**
```hcl
resource "local_file" "pets" {
  filename = var.filename
  content = var.content
}

resource "random_pet" "my-pet" {
  prefix = var.prefix
  separator = var.separator
  length = var.length
}

# We can get the reference expression "id" given by the random_pet resource as an output
# for that we would need to use the output block
output "pet-name" {
  value = random_pet.my-pet
  # the description is optional
  description = "Record the value of pet ID generated by the random_pet resource"
}
```

Once the resources has been created, we can use the following command.
```sh
# list all the output variables and values defined in all the files in the current configuration directory
terraform output
```
```sh
# to specifically get the value of an existing output variable
terraform output pet-name
```
The output variables are **_not used to get the output from one resource block as an input to another block_**. We can use reference expressions for that.

The best use of terraform output variables is **_when you want to quickly display details about a provision resource_** on the screen. Or to **_feed the output variables to other iac tools_** like add-on script and ansible playbook. 

# Purpose of State

Terraform uses the state file to map the resource configuration to the real-world infrastructure. This **_allows terraform to create execution plans when a drift is identified between the resource configuration files and the state_**. 

When terraform creates an entity it records it's identity in the state. Each resource created and managed by terraform would **_have a unique id which is used to identify the resources in the realworld_**. 

The state file **_also tracks metadata details_** such as resource dependencies. When we applied these configuration using `terraform apply` command, the resources are creatred according to the implicit dependencies. And they will be deleted in the reverce order to avoid conflicts. You can clearly see those dependencies between resources in the `terraform.tfvars` file. 

Another benefit of using state is **_performance_**. In the real world terraform would manage hundreds of thousands of resources. And these resources will be distributed to multiple providers specially in the cloud. So, it is not feasible to terraform to reconsile the state for every terraform operation. 

This is because ot will take several minutes to terraform to fetch details from every single resource from all the providers. So, **_instead of reconsiling the terraform state can be used as the single source of truth_**. This would improve the performance significantly. Terraform stores the cashe of attribute values for all resources in the state. 

We can specifically make terraform to refer to the state file alone while running commands and bypass having to refresh state every time. 
```sh
# we can use the --refresh=false here
# terraform doesn't refresh state instrad it relies on the cashed attributes
terraform plan --refresh=false
```

The final benefit of state is **_collaboration_** when working as a team. The terraform state file is stored in the same configuration directory in a file called `terraform.tfstate`. The state file resides in the folder or the directory in the end user's laptop. Every user in the **_team should always have the latest state data_** before running terraform, and need to **_make sure no body else run terraform at the same time_**.

It's hightly recommended to save the the `terraform.tfstate` file in a **_remote repository_**. This allows the state to be shared between all the members of the team. 

Example for remote state services are _AWS S3, Google Cloud Storage, HashiCorp Cloud , Terraform Cloud and etc._. 

# Terraform State Considerations

Terraform state is the **_single source of truth_** to terraform to understand what is deployed in the real world. Terraform state is a non-optional feature in terraform. 

The state file contains **_sensitive information_**. So, we need to make sure that the state file is stored in a secure storage. The state file is **_not recommended to store in the git repository_**. Instead the state **_will be stored in a remote backend system_** like _AWS S3, Google Cloud Storage, HashiCorp Cloud, Terraform Cloud and etc._.

State file is a json data structure that is meant to internal use within terraform. We should **_never manually attemt to edit status files by our selves_**.

However, there would be **_situations where we want to make changes to the state file_** and in such cases we should rely on **_terraform state commands_**.

# Terraform Commands

```sh
# this command is used to validate if the syntax of the configuration is correct
terraform validate
```

```sh
# this is the terraform format command
# scans the configuration files of the current working directory and formats the code to a canonical format
# this is useful to improve the readerbility of the configuration file
terraform fmt
```

```sh
# prinfts the current state of the infrastructure as seen by terraform
terraform show
# if you want to print the content on json formal we can use the -json flag
terraform show -json
```

```sh
# to see a list of all providers used in the configuration directory
terraform providers
```

```sh
# can use to copy the provider plugins needed for the current configuration to another directory
terraform providers mirror /root/terraform/new_local_file
```

```sh
# to print all output variables in the configuration directory
terraform output
# to print the value of a specific variable
terraform output pet-name
```

```sh
# used to sync terraform with the realworld infrastructure
# if there is any change made to a resource created by terraform outside it's control such as a manual update
# terraform pick it up and update the state file
# this command won't modify any infrastructure resource, but it will modify the state file
# this command will automatically run with commands like terraform plan and terraform apply
terraform refresh
```

```sh
# this is used to create a visual representation of the dependencies in a terraform configuration or an execution plan
# this command can be run as soon as you have the configuration file ready even before you initialize the configuration with terraform init
# this is generated in a format called dot
# this is hard to comprehend as it is, might need to use a graph visualization software like graphiz to make more sense
terraform graph
```

# Mutable vs Immutable Infrastructure

When terraform updates a resource, it first destroys it and then recreates a new one. This is because terraform has a immutable infrastructure. 

### Mutable

Let's say we have a webserver running nginx. When a new verion of nginx releases we upgrade the software running on this webserver. This can be done using multiple ways. One simple approach is to download the desired version of mginx and use it to **_manually upgrade the software during a maintainance window_**. Also we can make use of tools such as configuration management tools such as ansible to achieve this. 

For higher availablity, instead of relying on one web server we can have pool of web servers all running the same software and code. We would **_need to have the same software upgrade lifecycle for each of these servers using the same approach used for the first web server_**. This type of update is known as **_in place upgrade_**. And this is because the **_underline infrastructure remains the same but the software and the configuration on these servers change_** as part of the update. 

When we try to upgrade the version of multiple servers, if for some reason one of the server might not get upgraded. So, overtime with multiple updates and changes to this pool of servers there is a posibility that each of these servers vary from one another. This is known as a **_Configuration drift_**. 

This can leave the infrastucture in a complex state, making it difficult to plan and carry out subsequent upgrades. Troubleshooting issues will also be a difficult task. As each server would behave slightly different form the other because of the configuration drift. 

### Immutable

Instead of updating this software versions of the web servers, **_we can spin up new web servers with the updated software versions_**. Then, we can **_delete the old web server_**. If the update goes throught successfully the old web servers will be deleted. And the new ones with the new version of software will be there. 

Immutable means **_unchanged_**. With immutable infrastructure we cannnot carry out in-place updates any more. 

Even though we use the immutable infrastructure, it doesn't mean that updating web servers doesn't lead to failures. If the upgrade fails for any reason, the **_old web server will be left intact_**. The **_failed server will be removed_**. 

As a result we **_don't leave much room for configuration drift to occur_** between our servers. Ensuring that it is left in a simple easy to understand state. 

Terraform as a infrastucture provisioning tool uses this approach. 

# Life Cycle Rules

When terraform updates a resource, if **_first deletes the resource before creating a new one_** with the updated configuration. 

Some times, this may not be a desirable approach for all cases. Sometimes we _may want the updated version of the resource to be created first before the older one is deleted_ or you _may not want to delete the resource at all_. This can be done using Life Cycle rules.

These rules goes inside the resouce block as a new block called lifecycle. inside the lifecycle block we add the rule that we want terraform to adhere when creating resources.  

```hcl
resource "local_file" "pet1" {
  filename = var.filename1
  content = var.content
  file_permission = var.file_permission
  # we will add the life cycle rules here
  lifecycle {
    # this is one of the argumennt/rule that we can pass into the lifecycle block
    # this ensures that a new resource will be created first before deleting the old one.
    create_before_destroy = true
    # lifecycle rule we applied caused the local file to the created first and the same file to be destroyed
    # This goes to show that it is not always advisable to use this rule!
  }
}

resource "local_file" "pet2" {
  filename = var.filename2
  content = var.content
  file_permission = var.file_permission
  lifecycle {
    # by using this terraform will reject any changes that will result in resource getting destroyed when usign terraform apply command
    # it will also give and error message as an output
    # this is very useful for prevent resources from getting accidently deleted. 
    # for example a database resource may not be something we want to delete once it provisioned
    prevent_destroy = true
    # note that the resouce will no be destroyed evrn if we make use of the terrafrom destroy command
  }
}

resource "local_file" "pet3" {
  filename = var.filename3
  content = var.content
  file_permission = var.file_permission
  lifecycle {
    # this will prevent a resource from being updated based on a list of attributes that we define within the lifecycle block
    # we can ignore changes to a resouce when specific attributes of the resouce changes
    ignore_changes = [
        # if the content or filename attribute of the resource is changed, all the changes will be ignored
        content,filename
    ]
    # you can also ignore changes for changes done to any (all) argument
    # ignore_changes =  all
  }
}
```

| Order | Option | Description |
| --- | --- | --- |
| 1 | `create_before_destroy` | Creates the resource first and then destroy older |
| 2 | `prevent_destroy` | Prevents destroy of a resource |
| 3 | `ignore_changes` | Ignore changes to a resource attributes (specific/all) |\

# Data Sources

Data sources **_allows terraform to read attributes from resources which are provisioned outside it's control_**. We can use a **_data block_** within the configuration files. This is quiet similar to the resource block.

```hcl
data <resouce_name> {
  # consists of specific arguments for a data source
  <arguments>
}
```

The following is a example use of data sources.
```hcl
resource "local_file" "pet" {
    filename = var.filename
    # to use the data that got from the data source 
    # this is same as usign resource attributes but need to have a prefix called data
    # the local_file data souce expoces content and content_base64 
    content = data.local_file.dog.content
}

# the dogs.txt is created after the initial provision that creates the pet.txt.check 
# dogs.txt is outside the management of terraform at this point in time
# we are using this file as the data source and use it's data as contents of our existing file pet.txt

# we will have a seperate data block here
# the block is followed by the type of resource which we are trying to read
# this can be any valid resouce type provided by any valid provider
data "local_file" "dog" {
    # we can file the attributes that a local file exposes using the documentaion
    filename = "/root/datasource/dogs.txt"
}
```

### The difference beween data source and a resource

| Resource | Data Source |
| --- | --- |
| keyword: **resource** | keyword: **data** |
| **Creates, Updates, Destroys** Infrastructure | Only **Reads** Infrastructure |
| Also called **Managed Resources** | Also called **Data Resources** |

# Version Constraints

Providers use plugin based architecture. Most of the popular one are available in the public terraform registry.

Without additional configuration `terraform init` command **_downloads the latest version of provider plugins_** that are needed by the configuration files.

The functionality of a provider plugin may vary drastically from one version to another. Out terraform configuration may not work as expected when using a version different than the one it was written in. We can **_make sure that a specife version of the provider is used_** by terraform when we run the `terraform init` command. 

The instruction to use a specific version of a provider is availble in the provider documentation of the registry. We can get the code block that we need to copy and paste in our configuration for a specific version of provider pluigin.

Here a new block called `terraform` will be used configure settings related to terraform itself including providers. To use a specific version of a provider we need to use another block called `required_providers` inside the `terraform` block. Inside the `required_provider` block we can have multiple arguments for every provider that we use. 

You can create a seperate file called `providers.tf` to have these configuration.

**providers.tf**
```hcl
# instead of the latest version 2.5.2 terraform will now download 2.4.0 version of the plugin
terraform {
  required_providers {
    local = {
      source = "hashicorp/local"
      version = "2.4.0"

      # if we want to specificly as terraform to ask not to download a specific version
      # version =  "!= 2.5.2" 
      # So it now downloads the previous version available version 2.5.1

      # if we want terraform to use a version lesser/higher than a given version
      # we can use comparasion operators
      # version "< 2.4.0"
      # version "> 2.4.0"

      # we can also combine multipe comparison operators together.
      # version = "> 2.2.0, < 2.5.0 != 2.3.0"
    }
  }
}

provider "local" {
  # Configuration options
}
```