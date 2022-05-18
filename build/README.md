# Scripts For Automating the Creation of the App

This directory will include build scripts of Bash and PowerShell in order to allow you to automate the creation, addition, and destruction of your site

## Build-Server
Assuming you can log onto the IIT 430 server through the network or via VPN
* ssh -i ~/.ssh/id_ed25519_"yourgithubusername"_key "githubusername"@192.168.172.44
* Clone the team repo by issuing the command: `git clone "your team repo clone address"` Should be done once.
  * cd into the team repository on the server
  * cd into /build/packer-build-templates/ubuntu_20043_vanilla-multi-build
  * type command ' packer validate . ' and hit enter
  * If you get the message "The configuration is valid." then type command ' packer build . ' and hit enter
  * You are now building the 5 boxes needed to run the application. This can take anywhere to 15-40 minutes depending on speed of the internet.
* After completion of boxes, you will have a new directory named 'Project' with the built boxes.
 <img src ="https://github.com/illinoistech-itm/2022-team10w/blob/main/screenshots/Screenshot%20(118).png">

## Local Machine
Assuming you have pulled the latest version of the team repo to your local machine
* Depending on the machine which you are using, CD into the appropriate directory: bash or powershell.
  * Run the remove-and-retrieve-and-add-vagrant-boxes 10 script. 10 is for our Team #.
  * Now the boxes will be pulled from the index site and put locally unto your machine
   <img src ="https://github.com/illinoistech-itm/2022-team10w/blob/main/screenshots/Screenshot%20(119).png">
* You can now run the "up" script to get the boxes up and running
* Once your boxes are up and assuming that the nginx is actively running on the load balancer, you can view the website at [http://192.168.56.101](http://192.168.56.101).

## Updated boxes
* For any time the boxes are updated, please run the remove-and-retrieve-and-add-vagrant-boxes command.
* This will replace all outdated boxes during installation. 
