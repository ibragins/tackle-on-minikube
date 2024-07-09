# tackle-on-minikube

The purpose of this repository is to share a Bash script that will deploy minikube with Konveyor Tackle (upstream) on top of it.  

After you have deployed tackle-on-minikube, access it from the URL: [http://192.168.49.2/](http://192.168.49.2/).
  
The script deploys an environment. Furthermore, you can run it as is, out of the box. 

Perform additional tweaks to be performed by providing the following system variables: 
+ __MINIKUBE_DRIVER__  
Select the driver that will be used to run the environment; the default value is `docker`. 
+ __MINIKUBE_MEMORY__  
Specify the amount of RAM you want to dedicate to minikube; the default value is `10g` (10GB)
+ __FEATURE_AUTH_REQUIRED__  
Enable the UI auth; the default value is `true`.
