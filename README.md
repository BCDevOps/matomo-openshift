# matomo-openshift
This is a set of OpenShift configurations to set up an instance of the Matomo web analytics server. See: [matomo.org](https://matomo.org/).

## Architecture
The service is composed by the following components:
- *matomo*: includes two pods under the same name, the `matomo` analytics instance and `matomo-proxy`, which is the nginx used to proxy http requests.
- *matomo-db*: a [mariadb](https://mariadb.org) instance that will be used to store the analytics data.

## Deployment / Configuration
The templates provided in the `openshift` folder include everything that is necessary to create the required builds and deployments.

Since there are interdependencies between deployment configurations, please make sure to follow this order when creating them for the first time:
1) build and deploy the database
2) build and deploy the Matomo analytics server and proxy

The scripts in [openshift-developer-tools](https://github.com/BCDevOps/openshift-developer-tools) can be used to manage the builds and deployments.

## First Run
Once everything is up and running in OpenShift, follow the [instructions](https://matomo.org/docs/installation/#the-5-minute-matomo-installation) to create your superuser, set-up the connection to the database and initialize the Matomo dashboard.

To start tracking, copy the snippet for the appropriate website in the Matomo dashboard and place it in your website.