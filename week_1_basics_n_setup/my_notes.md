# connect to virtual machine on gcp

- configure ssh key
- run `ssh -i ~/.ssh/gcp camilo.ramirez@34.76.85.172`


# check processes in linux
htop

# my gc instance params

name : data engineering practice
project number : 675549462098
project id : plucky-imprint-375522

# connnecting to a remote server

Edit ~/.ssh/config to include host (gc instance)

Connect to the remote server specifying the name of the instance given in config `ssh de-instance`

## Transfer files to remote server

Use `sftp de-instance` to connect to the remote instance

inside ftp connection, go to desired location and write `put {name of file}` to upload files

## Save/update GCP key to instance in order to be able to use APIs

```bash
export GOOGLE_APPLICATION_CREDENTIALS=~/.gc/plucky.json
```

Now authenticate: 

```bash
gcloud auth activate-service-account --key-file $GOOGLE_APPLICATION_CREDENTIALS
```

## persisting postgres config

Note: to make pgAdmin configuration persistent, create a folder `data_pgadmin`. Change its permission via

```bash
sudo chown 5050:5050 data_pgadmin
```

and mount it to the `/var/lib/pgadmin` folder:

```yaml
services:
  pgadmin:
    image: dpage/pgadmin4
    volumes:
      - ./data_pgadmin:/var/lib/pgadmin
    ...
```