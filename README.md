# Fever

Docker implementation of Fever ([http://feedafever.com/](http://feedafever.com/)).

## Important Notes

### Persistence

If you want to persist your configuration settings (Fever key, database settings) you will need to mount the container's ```/var/www/html``` to your host machine.  This will prevent the app from getting reinstalled every run.

#### Timezone

The PHP pages will warn of timezone problems if the timezone is not set.  To set the timezone, pass TZ as an environment variable at run time:  ``` -e TZ="America/Denver"``` for example.

## First run

In order to have Fever install itself when you run this container for the first time, go to http://yourserver.com:80/boot.php (or whatever port you set).  Basically add ```/boot.php``` to the end of the URL for your container.

## Example Run
```
docker run -d --link mysql:mysql --name=fever -e TZ="America/Denver" -v $PWD/html:/var/www/html -p 80:80 furiousgeorge/fever
```

