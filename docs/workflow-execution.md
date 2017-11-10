Workflow Execution in MilkyWay (Galaxy)
=============================================================

General Tips on Galaxy
-----------------------------------------------------
Workflow execution within the MilkyWay platform occurs through the Galaxy Bioinformatics Workflow Management platform.  Many of you have probably encountered Galaxy at one time or another in the biological sciences.  Galaxy has been around for over a decade, and has proven exceptionally popular in the Genomics sphere.  More recently, Metabolomics and Proteomics groups have increased efforts to provide complex and reproducible analytical workflows (as is the case with MilkyWay).
With this in mind, it is generally a good idea to familiarize yourself with the concepts behind how Galaxy is organized, and how jobs and workflows are executed.
The best place to do this is through the excellent wealth of introductory materials provided by the Galaxy Project directly.


Accessing the Workflows
-----------------------------------------------------
Workflows can be accessed via the "Workflows" button at the top center of the page within the Galaxy interface.
From this page, you will find a populated list of distributed workflows for the MilkyWay system.  These workflows are somewhat modular, and can be bent to the will of the user if properly configured.  This allows us to, for example, add or remove the PTM-localization scoring tools from a more generalized workflow.
It's recommended that you *copy* a workflow before modifying it, so that you have a backup of the original.

If, for whatever reason, your original copies of the workflows are modified without backup, the unmodified distributed workflows for MilkyWay are available through our `milkyway_proteomics` github repository [here](https://github.com/wohllab/milkyway_proteomics/tree/master/workflows "MilkyWay Github Workflows").

Workflow Choice
------------------------------------------------------

Pick the right workflow for what data you've generated, and what question you are asking of your dataset!
A basic interpretation of each workflow is provided below.

###### No intensity based analysis:
* **Identification Analysis:** Use this if you are just searching one (or more) datasets to identify proteins/peptides. This will have no comparative statistics or intensity based analysis.
* **Phospho Identification Analysis:** Use this if you are just searching one (or more) datasets to identify phospho proteins/peptides. This will have no comparative statistics or intensity based analysis, but DOES include PhosphoRS localization scoring algorithm.
* **Qualitative Analysis:** This is the most basic comparative pipeline.  One can think of this as a "classic" proteomics pipeline, generating spectral counts, NSAF values, and SAINT enrichment probability scores.

###### Intensity based analyses (these will still have SpC/NSAF calculations):
* **DDA HighRes:** Use this workflow to search a standard comparative analysis of DDA datasets.  Also use this workflow if you have non-highres data.  The workflow is named this way to ensure that users will adjust appropriately the settings necessary for their instrument, to provide proper tolerances for any MSn level where resolution may be high or low.
* **phosphoRS:** Use this workflow to search a standard comparative analysis of DDA datasets which also contain phosphopeptides of interest.  This will be the same as the DDA workflow immediately above, but with the added localization calculations provided by PhosphoRS.
* **DIAUmpire workflow:** Use this if you have only a DIA dataset, with regularly sized windows.
* **DIAUmpire (window upload):** Use this if you have only a DIA dataset, with variable or custom windows.  This will require you to upload an additional file defining the window start and end m/z values.  An example can be found [here](https://github.com/wohllab/milkyway_proteomics/blob/master/exampleSkylineFiles/400-1600-90window-vDIA.csv).
Workflow Parameters and Execution
* **MSX DIAUmpire:** Use this if you have only MSX-DIA dataset.  You must upload window definitions that match what the start and end m/z values will be for the DECONVOLUTED WINDOW PLACEMENTS after the msconvert deconvolution is run.
* **DDA-ID DIA-Quant:** Use this if you have generated paired data with identifications originating in DDA datasets, and quantitation to be done from DIA datasets.  As above, upload window placement file for the DIA data, even if the data is generated on a regularly sized DIA window method.  The window positions will be required for MSPLIT-DIA to generate "in-run" identifications to aid with retention time alignments.


Workflow Parameters and Execution
------------------------------------------------------
The parameters used for execution of tools can be tricky business.  They must be properly set for the resolution of your data, and may also depend on the nature of the information for which you are attempting to query your data.

I highly recommend in cases of confusion consulting the original tool's publications for insight on parameters and their meanings during execution.  While MilkyWay provides a convenient interface with which to analyze data, it is not magic.  Please take extra care to properly define your parameters before execution of an analysis!


Basic Walkthrough Images
------------------------------------------------------
The images below should provide a basic expectation of what to visually expect when moving through the workflow execution process.

First, you must have finished uploading your dataset through the MilkyWay Job Submission (Upload) tool.  After this, the user must switch into the new history created via the Galaxy interface.
Again, the galaxy interface can be accessed at `http://yourServerName/` by default (port 80, standard HTTP).

* Once you have switched into your new history, you can move back to the Analysis section of Galaxy, at which point you should see [**this view within galaxy**](https://raw.githubusercontent.com/wohllab/milkyway_compose/master/docs/images/workflow_execution/uploaded_files_in_history_workflow_circle.PNG).
    - At this point, if all of your files for the analysis are present, you may click on the highlighted "Workflows" section of Galaxy at the top of the page.
* The workflows section by default provides several different common analyses within MilkyWay.  These workflows can be copied, and tweaked to your hearts' content.  This is one of the beautiful aspects of Galaxy as a workflow management system.
    - You should see [**something like this list of workflows**](https://raw.githubusercontent.com/wohllab/milkyway_compose/master/docs/images/workflow_execution/choose_workflow.PNG).
* At this point, you can click on the appropriate workflow of your choosing, and click "run" to begin setting up execution of the analysis.
    - [**Lastly, you must define the parameters for your analysis.  This, like most proteomics workflows, is an absolutely crucial step.**](https://raw.githubusercontent.com/wohllab/milkyway_compose/master/docs/images/workflow_execution/parameters_and_input_files.PNG)
    - It is exceptionally important that you set up the input files to the correct tools.  Experimental design file, FASTA database, Skyline File, and RAW file collections must be properly associated before workflow execution!
* Finally, once your configuration for the analysis has been completed, click "Run Workflow" at the top of the page to execute, and await your results!
