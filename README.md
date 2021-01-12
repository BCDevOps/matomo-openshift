---
title: Matomo OpenShift
description: Get started with docs and resources for Matomo, a fully featured web analytics server. It's a great alternative to Google Analytics when data ownership and privacy compliance are a concern.
author: esune
resourceType: Components
personas: 
  - Developer
  - Product Owner
  - Designer
labels:
  - matomo
  - google
  - analytics
  - web
---
# Matomo OpenShift
Matomo is a fully featured web analytics server and is a great alternative to Google Analytics when data ownership and privacy compliance are a concern.

[Matomo OpenShift](https://github.com/BCDevOps/matomo-openshift) provides a set of OpenShift configurations to set up an instance of the Matomo web analytics server. See: [matomo.org](https://matomo.org/) for additional details regarding Matomo.

## Architecture
The service is composed by the following components:
- *matomo*: includes two containers within a single pod, the matomo analytics instance and matomo-proxy, which is the nginx used to proxy http requests.
- *matomo-db*: a [mariadb](https://mariadb.org) instance that will be used to store the analytics data.

## Deployment / Configuration
The templates provided in the `openshift` folder include everything that is necessary to create the required builds and deployments.  

To run Matomo on openshift you **MUST** install [openshift-developer-tools](https://github.com/BCDevOps/openshift-developer-tools) and have them available on your path  

By default, Matomo uses the artifactory docker registry. If you are going to keep the default settings artifactory **MUST** be enabled in your OCP cluster, otherwise you will have to tweak the param file to specify your docker registry.  


##### Running with Artifactory/docker.io:
There should already be a "artifacts-default-\*\*\*\*\*\*" secret in the tools environment of your openshift cluster. Copy the username and password of this.
Follow the instructions on [artifactory](https://developer.gov.bc.ca/Artifact-Repositories) to create an artifactory secret in each of the environments
you will be building/deploying to.

If you want to use your docker hub account, do the same command as for artifactory but use your docker.io login credentials.
##### Deploy:

Once the secret is created, use the manage script in the openshift folder to deploy your project  
>./manage -n 4a9599 init  
  
This will generate local param files, make sure to go through each of the param files, uncomment NAMESPACE_NAME, and set it to your project namespace. In this case, 4a9599.  

***If you're using a custom docker registry*** you will also need to uncomment and change DOCKER_REG and PULL_CREDS in `matomo-proxy-build.local.param` and SOURCE_IMAGE_NAME in `matomo-build.local.param`  

Next we can build and deploy  
>./manage build
>./manage -e dev deploy  

_The deployment will have created two sets of secrets for you to referance while completing the initial configuration; **matomo-db**, containing the database info and randomly generated credentials and **matomo-admin**, containing randomly generated credentials for your main super-user account._

For full script documentation run `./manage -h`.

## First Run
Once everything is up and running in OpenShift, follow the [instructions](https://matomo.org/docs/installation/#the-5-minute-matomo-installation) to create your superuser, set-up the connection to the database and initialize the Matomo dashboard.

To start tracking, copy the snippet for the appropriate website in the Matomo dashboard and place it in your website.
