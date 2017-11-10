Uploading files to MilkyWay via the R/Shiny interface
=============================================================================

###### Accessing the MilkyWay R/Shiny interface

By default, the MilkyWay R/Shiny interface can be accessed at the same IP/hostname, on port :3838.
For example, if you access the MilkyWay galaxy server at `http://myServerName/` -- you will find the R/Shiny application at `http://myServerName:3838/` by default.

Once connected to the R/Shiny interface, the username and passwords are drawn from the Galaxy instance.  Use the same uname/password as you would use there.
For a fresh installation of the MilkyWay system, the default username is `admin@galaxy.org` and the default password is `admin`.

###### Handling Multiple Concurrent Users on R/Shiny

Please keep in mind that since R/Shiny is naturally limited to a single thread by the Global Interpreter Lock (GIL), if multiple users attempt to use the R/Shiny interface concurrently they may have to wait for the others' calculations to finish before their own page will render.

To sidestep this issue, we provide an additional repository at `http://github.com/wohllab/milkyway_shinyproxy` which allows users to sidestep this problem.
For deployment of ShinyProxy, please follow the instructions provided in that repository.

###### Uploading Files to MilkyWay

File Upload for MilkyWay is handled through the dashboard's left tab "Galaxy Job Submitter".


Since MilkyWay supports multiple different experimental analyses, we have provided two different upload workflows.

First, "LFQ Intensity Based Analysis (DIA or DDA)" which will take in DDA or DIA datasets (mutually exclusive).

Second, "LFQ Intensity Comparative Analysis (DDA-ID+DIA-Quant)" which will take in BOTH DDA AND DIA data simultaneously.  In this workflow, DDA data will be used to generate the spectral libraries (identifications) which are used as targets during the DIA intensity based analysis.


As a note: DIA datasets generated using custom methods, like variable windows, will need to be accompanied by a simple tsv/csv file defining the start and end m/z values of each window in the acquisition.
We implicitly assume that all DIA datasets are generated using the same method and windows.

###### A few critical notes!
* RAW File Naming Constraints and General Advice:
- Don't use underscores!  Please replace these with a different character.  At the time of writing this, msgf2pin does not support underscores in filenames and will return uninterpretable results which can't be properly associated back to files.
- Try not to use file names which are subsets of other file names.  For example, one should try and avoid "2017-10-08-HEK293.raw" and "2017-10-08-HEK293-plus-treatment.raw".  You'll notice that I am referring to the basenames.  While subset naming should be supported by our workflows, I still try to avoid this as a matter of practice.
- If you are a user of a non-Thermo instrument, you will be uploading mzML files into MilkyWay.  You will need to copy the desired workflow you want to execute, and exclude msconvert as an initial step, instead passing the mzML files to the appropriate inputs of tools.

* Skyline Files and DIA Window Definition Files:
- We have provided a few convenient examples to try to make your life easier to get started with analyses in MilkyWay.  [They can be found here, on Github](https://github.com/wohllab/milkyway_proteomics/tree/master/exampleSkylineFiles).
- Please note, MilkyWay is a force multiplier to facilitate rapid analysis of data... It is not a turn-key solution for analysis! End users must familiarize themselves with [Skyline, and the file setup proceedure to understand what the Skyline parameters mean and do.](https://skyline.ms/wiki/home/software/Skyline/page.view?name=tutorials)
- We have provided an example file for DDA analysis which we use from our Lumos data (including 8ppm XIC windows for the M, M+1, M+2 isotopic peaks for identified peptides-- only fully tryptic peptides with no missed cleavage events and no KP/RP sequences are elligible for analysis in the default settings).
- Additionally, we have provided example DIA Skyline file for our internal use vDIA method.  The windows for this method are also provided.  Window placement has been balanced relative to a HEK293 whole cell lysate.  Please review the Skyline file (by opening it in Skyline) to examine the settings!
