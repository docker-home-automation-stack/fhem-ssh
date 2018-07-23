# Docker SSH wrapper container for FHEM

### Image flavors
This image provides 2 different variants:

- `latest` (default)
- `dev`

You can use one of those variants by adding them to the docker image name like this:

	docker pull homeautomationstack/fhem-ssh:latest

If you do not specify any variant, `latest` will always be the default.

`latest` will give you the current stable version.
`dev` will give you the latest development version.


### Supported platforms
This is a multi-platform image, providing support for the following platforms:


Linux:

- `x86-64/AMD64` [Link](https://hub.docker.com/r/homeautomationstack/fhem-ssh-amd64_linux/)
- `i386` [Link](https://hub.docker.com/r/homeautomationstack/fhem-ssh-i386_linux/)
- `ARM32v5, armel` [Link](https://hub.docker.com/r/homeautomationstack/fhem-ssh-arm32v5_linux/)
- `ARM32v7, armhf` [Link](https://hub.docker.com/r/homeautomationstack/fhem-ssh-arm32v7_linux/)
- `ARM64v8, arm64` [Link](https://hub.docker.com/r/homeautomationstack/fhem-ssh-arm64v8_linux/)


Windows:

- currently not supported


The main repository will allow you to install on any of these platforms.
In case you would like to specifically choose your platform, go to the platform.related repositories by clicking on the respective link above.

The platform repositories will also allow you to choose more specific build tags beside the rolling tags latest, current and dev.


## Usage

#### Adding your SSH key
Login is only possible using SSH keys.

1. Create data folder on your host together with a file named `authorized_keys`.
2. Put your personal public SSH key into the `authorized_keys` file.
3. Start your container with a specific volume `-v /my/data/path/:/data/` to make that data available to the container.

#### Interactive session
To start an interactive FHEM shell, simply connect to this container, using the user `fhem`:

		ssh fhem@192.0.2.1

#### Run a FHEM command
You may directly interact with FHEM as you would do with any other SSH remote machine:

		ssh fhem@192.0.2.1 help

The session will automatically terminate after the command output was sent back to you.
The [FHEM command `inform`](https://fhem.de/commandref.html#inform) is handled differently with a permanent connection to allow monitoring of FHEM events.

## Customize your container configuration

#### Set FHEM target host
As a default configuration, the container will connect to a host named "fhem" on port 7072 with no password set.
You may adjust those settings by providing respective environment variables through your Docker run command:

    -e FHEM_HOST=198.51.100.200
    -e FHEM_PORT=7073
    -e FHEM_PASSWORD=mysecretpassword


___
[Production ![Build Status](https://travis-ci.com/docker-home-automation-stack/fhem-ssh.svg?branch=master)](https://travis-ci.com/docker-home-automation-stack/fhem-ssh)

[Development ![Build Status](https://travis-ci.com/docker-home-automation-stack/fhem-ssh.svg?branch=dev)](https://travis-ci.com/docker-home-automation-stack/fhem-ssh)
