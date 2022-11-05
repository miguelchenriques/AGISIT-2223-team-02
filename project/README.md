## AGISIT - Project

### Authors
Group 02
Members:
102148 - Miguel Henriques
102150 - Bernardo Várzea
102152 - Filipe Barroso

***

### Description
Our solution's overall architecture consists of a frontend that displays the calculator and the history, backends with the microservices used by the application, a storage cluster built on MongoDB with replication, and a monitoring system that gathers metrics about all instances using Prometheus and Node Exporter and displays them in an interface on Grafana. Instances of the frontend and backend microservices are served by three load balancers (one for the frontend and one for each microservice, which are two).
The web application for our microservices calculator serves as the basis for our solution. A reliable and highly available infrastructure running on Google Cloud Compute Engine will be used to deploy this application (along with all of the microservices).


### Prerequisites
To deploy our solution there are some programs/tools needed, which are:
- Vagrant
- Virtualbox
- Virtualbox extension pack
- Vscode
- GCP account with credits


### Configuration
In Google Cloud Platform:
- Enable Google Compute Engine API;
- Create a Service Account (Dashboard - IAM and Administrator - Service Account - Manage Keys - Create a new Key - Export JSON);

In the project directory run:
- vagrant up
- vagrant ssh project-mgmt

Copy the .json key inside terraform files
In gcpcloud folder:
- Open `terraform-gcp-variables.tf`
- Replace your variables

In the mgmt virtual machine:
- Generate an ssh key by running the command `ssh-keygen -t rsa -b 4096`

In the mgmt virtual machine inside gcpcloud folder, run:
- terraform init
- terraform plan
- terraform apply
- terraform output (this command is not mandatory)
- ansible all -m ping (this command is not mandatory but checks if is ready for configuration)
- ansible-playbook ansible-gcp-servers-setup-all.yml 

### Design

Our foundation was based on the example of the open source application “A Browser-based Calculator”, where we took inspiration for our solution that we built from scratch.
We decided to create the frontend in ReactJS, one microservice in NodeJs and the other microservice with Python. These decisions were made based on the experience/preference of each element of the group.
Our next step was configuring the vagrant, terraform and ansible files and deploy the frontend and microservices.
With these services deployed we advanced to the monitoring and database topics. For the database we decided to use MongoDB because all members of the group already had some experience with it and with its replication features.

### Architecture
To implement our solution we used Google Cloud Platform where every component is in a n1-standart-1 instance running Ubuntu 20.04. 
The frontend, balancer and databases are in the europe-west2-b zone, the microservices and monitor are in the europe-west1-b zone.
For every component except the monitor the firewall rules allow the port 9100, the databases have the port 27017 open, the balancers have ports 80 and 443 open, the microservices and frontend servers have the port 3000 open and the monitor has the ports 9090 and 3000 open.
The Architecture of our base solution consist of the following main services:
- Frontend: the entry point (ingress) that exposes a React web server;
- Backend services: provide the desired functionalities (one provides the sum/subtraction the other provides multiplication/division);
- Database: persistent data storage, stores every calculation made by the microservices.
- Monitoring Server: provides insight over the system resources.
- HaProxy load balancers: provide load balancing between each of the microservices and frontend web servers.


### Implementation options

The web application is implemented in a microservices architecture with high availability, using the architecture explained in the methodology section, that operates with load balancing. For it to have a record of the completed operations, that is the history, it leverages a mongo database replica set that also contributes to the load balancing architecture, which is the persistent storage of the project.

### Tools used

- Google Cloud Platform
- Terraform
- Ansible
- Vagrant
- Virtual box
- Nodejs - React(frontend) and Express(multiplier backend)
- Python Fast Api
- Prometheus
- Grafana
