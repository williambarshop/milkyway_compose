Uploading files to MilkyWay via the R/Shiny interface
=============================================================

############
Accessing the MilkyWay R/Shiny interface
############

By default, the MilkyWay R/Shiny interface can be accessed at the same IP/hostname, on port :3838.
For example, if you access the MilkyWay galaxy server at http://myServerName/ -- you will find the R/Shiny application at http://myServerName:3838/ by default.

Once connected to the R/Shiny interface, the username and passwords are drawn from the Galaxy instance.  Use the same uname/password as you would use there.
For a fresh installation of the MilkyWay system, the default username is "admin@galaxy.org" and the default password is "admin".

############
Handling Multiple Concurrent Users on R/Shiny
############

Please keep in mind that since R/Shiny is naturally limited to a single thread by the Global Interpreter Lock (GIL), if multiple users attempt to use the R/Shiny interface concurrently they may have to wait for the others' calculations to finish before their own page will render.

To sidestep this issue, we provide an additional repository at http://github.com/wohllab/milkyway_shinyproxy which allows users to sidestep this problem.
For deployment of ShinyProxy, please follow the instructions provided in that repository.

############
Uploading Files to MilkyWay
############

File Upload for MilkyWay is handled through the dashboard's left tab "Galaxy Job Submitter".


Since MilkyWay supports multiple different experimental analyses, we have provided two different upload workflows.

First, "LFQ Intensity Based Analysis (DIA or DDA)" which will take in DDA or DIA datasets (mutually exclusive).

Second, "LFQ Intensity Comparative Analysis (DDA-ID+DIA-Quant)" which will take in BOTH DDA AND DIA data simultaneously.  In this workflow, DDA data will be used to generate the spectral libraries (identifications) which are used as targets during the DIA intensity based analysis.


As a note: DIA datasets generated using custom methods, like variable windows, will need to be accompanied by a simple tsv/csv file defining the start and end m/z values of each window in the acquisition.
We implicitly assume that all DIA datasets are generated using the same method and windows.

