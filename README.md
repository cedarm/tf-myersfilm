# tf-myersfilm

## GitHub token

GITHUB_TOKEN environment variable must be set to deploy aws_codepipeline!

## Database

A single `drupal-shared` database is used by all Drupal apps.  You must create db users and databases manually.

    CREATE USER d8test NOCREATEROLE NOCREATEDB PASSWORD 'secret';
    GRANT d8test TO postgres ;
    CREATE DATABASE d8test OWNER d8test;

[ec2-user@ip-172-31-30-107 default]$ sudo chown apache:apache /mnt/efs/d8-gaia.stage/files
[ec2-user@ip-172-31-30-107 default]$ sudo chown apache:apache /mnt/efs/d8-gaia.production/files
