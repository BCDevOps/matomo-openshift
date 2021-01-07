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

In order to run Fathom on the openshift cluster, you MUST install [openshift-developer-tools](https://github.com/BCDevOps/openshift-developer-tools)  

There should already be a "artifacts-default-******" secret in the tools environment of your openshift cluster. Copy the username and password of this 
secret and run the following command in each environment you wish to build/deploy to. (example: tools and dev / tools and prod)
~~~
oc create secret docker-registry artifactory-creds \
    --docker-server=docker-remote.artifacts.developer.gov.bc.ca \
    --docker-username=<our username from secret> \
    --docker-password=<our password from secret> \
    --docker-email=unused
oc secrets link default artifactory-creds --for=pull
oc secrets link builder artifactory-creds
~~~  
  
The [manage](./openshift/manage) script makes the process of adding a matomo instance to your project very easy. The script was build on the [openshift-developer-tools](https://github.com/BCDevOps/openshift-developer-tools) scripts.

Once you've cloned the repository, open a bash shell (Git Bash for example) to the `openshift` directory of the working copy.

The following example assumes an OpenShift project set named **ggpixq** ...

1. `./manage -n ggpixq init` - to initialize the configurations to be deployed into your project.  
This will generate local param files, make sure to go through each of the param files, uncomment NAMESPACE_NAME, and set it to your project namespace. In this case, ggpixq.  
next we can build and deploy
1. `./manage build` - to publish the build configuration(s) into your `tools` project and start the build.
1. `./manage -e prod deploy` - to publish the deployment configuration(s) into your `prod` environment and tag the application images to start the deployments.
1. Browse to the deployed application to complete the configuration.

_The deployment will have created two sets of secrets for you to referance while completing the initial configuration; **matomo-db**, containing the database info and randomly generated credentials and **matomo-admin**, containing randomly generated credentials for your main super-user account._

For full script documentation run `./manage -h`.

## First Run
Once everything is up and running in OpenShift, follow the [instructions](https://matomo.org/docs/installation/#the-5-minute-matomo-installation) to create your superuser, set-up the connection to the database and initialize the Matomo dashboard.

To start tracking, copy the snippet for the appropriate website in the Matomo dashboard and place it in your website.
