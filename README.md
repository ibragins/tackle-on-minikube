# tackle-on-minikube
Purpose of this repo is to share script that will deploy minikube with konveyor tackle on top of it. 
Script deployes environment and can be run as is out of the box. Additional tweaks can be done by providing respective system variables: 
+ __MINIKUBE_DRIVER__
Driver that will be used to run env, default value is `docker`. 
+ __MINIKUBE_MEMORY__
Amount of RAM to be dedicated to minikube, default value is `10g` (10GB)
+ __FEATURE_AUTH_REQUIRED__
Responsible for enabling UI auth, by default is `true`.
