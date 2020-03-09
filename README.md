# ApacheDS Docker image

  Dockerfile to build an ApacheDS container providing an LDAP and optionally a Kerberos service.

## Branches and Tags

  The `latest` is not production ready because new features will be tested on it first.
  The tags like `2.0.0.AM26` are used to track the releases of ApacheDS. Approved new features will be tested in master branch then included in the next [release](https://github.com/openfrontier/docker-apacheds/releases).

  * openfrontier/apacheds:latest -> 2.0.0.AM26

## Container Quickstart

  1. Initialize and start gerrit.

  ```shell
    docker run -d -p 389:10389 openfrontier/apacheds
  ```
  2. Open your [Apache Directory Studio](https://directory.apache.org/studio/) and create a new ldap connection to ldap://<docker host url>:389 with `uid=admin,ou=system` as the BindDN and `secret` as the bind BindPassword.

## Use a docker named volume as the storage.
  **DO NOT** mount host volumes in particular directories under the home directory like `~/apacheds` as a volume!!! Use [named volume](https://success.docker.com/article/different-types-of-volumes) instead!!!
  1. Create a named volume for the ApacheDS.
  ```shell
    docker volume create apacheds_data
  ```
  2. Initialize and start ApacheDS using the volume created above.
  ```shell
    docker run -d -p 389:10389 -v apacheds_data:/var/lib/apacheds openfrontier/apacheds
  ```
