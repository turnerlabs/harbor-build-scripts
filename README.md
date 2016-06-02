# Harbor Build Scripts

Builds and deploy scripts for creating Docker Images for use within the Harbor ecosystem.


## How to Use

At minimum, you need these two environment variables set:

* `NAME` Name of your image

* `VERSION` Version of this build of the image

The only other thing you need to do is place the root of this repo in a subdirectory of your code at
build time, and run `$subdirectory/bin/build`.


### Using the TURNER_METADATA file

In order to ease the burden of setting these values, we support (and encourage) the use of a
`TURNER_METADATA`.

These are the values that we support:

#### Required Values

* `NAME`: The name of your finished Docker Image (best formatted as property-project-component, for
example cnn-coolnew-api)

* `VERSION`: The version number (ex: 0.1.0)


#### Optional Values

* `PRE_RELEASE_LABEL`: If set, VERSION will become VERSION-PRE_RELEASE_LABEL in the registry. Good for
multiple builds of the same version, ex: attaching the Bamboo build number.

* `TARBALL`: TARBALL determines what build tarball (with Dockerfile in root), is sent to the Docker
build service. If TARBALL=git, it assumes where the script is run is inside a git repo and uses the
last checkin of current branch, if it begins with http:// or https://, it downloads the tarball,
otherwise it is a local file path to tarball (Defaults to git).

* `INSECURE`: If INSECURE=1 allow TARBALL download from insecure HTTPS.

* `NO_CATALOGIT`: If NO_CATALOGIT=1, the image is not added to CatalogIt. Which will mean people will
not be able to use it in Harbor. Use only for Base Images.

* `WEBHOOK`: If set, the build script will POST json data to this location about the build and if it
was successful.


#### Development Values

These values are meant for development of the Harbor ecosystem purposes and should not be used
unless you need use development Harbor services.

* `CATALOGIT_URL`: The URL for CatalogIt

* `DOCKER_PRODUCT`: The Product used for building Docker image

* `DOCKER_ENVIRONMENT`: The environment for the Product

* `DOCKER_LOCATION`: The location of the Product

* `DOCKER`: Override Docker API discovery with static server

* `REGISTRY_PRODUCT`: The Product for the Docker Registry

* `REGISTRY_ENVIRONMENT`: The Registry Product environment

* `REGISTRY_LOCATION`: The Registry Product location

* `REGISTRY`: Override Registry discovery with static server


### Using the Deploy Script

Typically, the deploy script is run in conjunction with the build script, and most of the values
needed for deploy are set at build time. The values can be set either as flags or as environment
variables. Flag values will override the environment variables.


#### Values

* `NAME` or `-n` flag: The name of the Container.

* `VERSION` or `-v`: The version of the Container.

* `SHIPMENT` or `-s`: The Shipment to deploy.

* `ENVIRONMENT` or `-e`: The Shipment environment to deploy.

* `BUILD_TOKEN` or `-t`: The build token from the Shipment for authorization to deploy the Shipment.


## Additional Reading

* [Bamboo and CI/CD in Harbor](http://blog.harbor.inturner.io/articles/bamboo-ci/)
