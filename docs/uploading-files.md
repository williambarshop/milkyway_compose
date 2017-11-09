Uploading files to MilkyWay via the R/Shiny interface
=============================================================

############
Accessing the MilkyWay R/Shiny interface
############

By default, the MilkyWay R/Shiny interface can be accessed at the same IP/hostname, on port :3838.
For example, if you access the MilkyWay galaxy server at http://myServerName/ -- you will find the R/Shiny application at http://myServerName:3838/ by default.

Once connected to the R/Shiny interface, the username and passwords are drawn from the Galaxy instance.  Use the same uname/password as you would use there.
For a fresh installation of the MilkyWay system, the default username is "admin@galaxy.org" and the default password is "admin".


Please keep in mind that since R/Shiny is naturally limited to a single thread by the Global Interpreter Lock (GIL), if multiple users attempt to use the R/Shiny interface concurrently they may have to wait for the others' calculations to finish before their own page will render.

To sidestep this issue, we provide an additional repository at http://github.com/wohllab/milkyway_shinyproxy which allows users to sidestep this problem.
For deployment of ShinyProxy, please follow the instructions provided in that repository.




############
Uploading Files to MilkyWay
############

This file will contain information about using the R/Shiny server in the default deployment of MilkyWay to move files into the MilkyWay Galaxy environment.
