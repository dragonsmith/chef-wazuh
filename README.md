# wazuh

A cookbook to install & configure wazuh manager & agent. No ELK stack configuration though.

## How to use

First of all, see attributes for possible configuration options. Also, see Wazuh [Reference docs](https://documentation.wazuh.com/current/user-manual/reference/ossec-conf/index.html)

Simply include `recipe[wazuh::server]` into your run_list after you set the desired attributes.

It will install:

* wazuh-manger and its components
* Wazuh API nodejs app
* Filebeat for shipping logs and events to ELK stack.

You will need to create SSL certificated by yourself if you want to enable TLS

## How to use SSL certificates

Let's say you already have a set of certificates for your setup. You should create the data bag called `wazuh::tls`. Name keys as a corresponding TLS certificate file names.

E.g. if you've set some attribute to  `/var/ossec/etc/manager.crt` name the key inside `wazuh::tls` data bag `manager.crt` (basename() is used to get the content of a file, so use different file names for different certificates)

## How to configure HTTP basic auth for API app

HTTP basic auth for Wazuh API app requires `htpasswd` file. It is generated using `wazuh::htpasswd` data bag. Set key `users` to a Hash like `{ "user": "passwd"}, { "user": "passwd"}, ...`