XTVSHLP2 ;Albany FO/GTS - VistA Package Sizing Manager; 6-MAR-2019
 ;;7.3;TOOLKIT;**143**;Apr 25, 1995;Build 116
 ;
LMTXT2 ; ?? Help Text [Analysis Manager]
 ;;Descriptions:
 ;; 
 ;;  Extract Manager - This action displays an indexed list of Package File
 ;;     extracts stored on the local VistA server in the ^XTMP global.  Provided
 ;;     actions include tools allowing the user to convert a Package File extract
 ;;     into a Package Parameter file that can be used to generate a Package Size
 ;;     report.  Package File extracts can be completed on the local Package File
 ;;     or received from a remote VistA.  The Extract Manager includes an action
 ;;     to Email a Package File extract to a remote VistA using PackMan.  PackMan
 ;;     tools allow a user to load the ^XTMP global locally.  The Extract Manager
 ;;     can then access the [remote VistA] ^XTMP global to create a Package
 ;;     Parameter file.
 ;; 
 ;;$PAUSE
 ;;  Delete Package Parameter File - This action prompts the user to select a
 ;;    Package Parameter file from the displayed list for deletion.
 ;; 
 ;;  Display/Edit Package Parameters - This action prompts the user to select
 ;;    a Package Parameter file from the list.  The action then displays the
 ;;    contents of the Parameter file to the user and provides a set of actions
 ;;    allowing the user to analyze and cleanup package definitions so accurate
 ;;    package size reporting can be provided.
 ;; 
 ;;  Change Host Directory - This action prompts the user for the default host
 ;;    file directory used to store Parameter files and report files created
 ;;    by the Package Size Analysis Manager.
 ;;
 ;;  Unlock Parameter File - This action prompts the user to select a Package
 ;;    Parameter Lock file from a list.  The action then allows the user to
 ;;    delete the Lock on the Parameter file.  ** THIS ACTION SHOULD ONLY BE
 ;;    USED TO REMOVE A CORRUPTED LOCK.  THE USER MUST BE SURE THE PARAMETER
 ;;    FILE THAT IS BEING 'UNLOCKED' IS NOT IN USE! **
 ;; 
 ;;  Remote VistA Size Query - This action prompts the user for a package in
 ;;    the selected Package Parameter file and a VistA server to query.  The
 ;;    report from the remote VistA is sent to the users' VA MailMan address.
 ;;$PAUSE
 ;;  Display VistA Size Report - This action prompts the user for a Parameter
 ;;    file.  It is used to either report the size of all packages or size of a
 ;;    single package.  Accuracy of the size report depends on accurate parameter
 ;;    definitions in the Parameter file AND fully patched package(s) on the VistA
 ;;    instance where the report is created.  There are five options for creating
 ;;    the report for all packages.  The report options are listed below.  Options
 ;;    1 - 3 are human readable reports, options 4 and 5 are up-caret (^) data
 ;;    delimited reports.
 ;;      1. Sorted on PACKAGE NAME
 ;;      2. Sorted on NUMBER of ROUTINES (Highest to Lowest)
 ;;      3. Sorted on TOTAL ROUTINE SIZE (Highest to Lowest)
 ;;      4. Delimited (^) Data, Sorted on PACKAGE NAME
 ;;      5. Delimited (^) Data with PARENT PKG, Sorted by PACKAGE NAME
 ;;
 ;; NOTES:
 ;;  - Extract Manager, Delete Package Parameter File, Display/Edit Package
 ;;      Parameters, Change Host Directory, and Unlock Parameter File require a
 ;;      VistA Security Key.
 ;; 
 ;;  - Extract Manager, Delete Package Parameter File, Display/Edit Package
 ;;      Parameters, Display VistA Size Report, Unlock Parameter File and
 ;;      Remote VistA Size Query require a Host Directory.
 ;;$PAUSE
 ;;$END
 ;
LMTXT3 ; ??? Help Text [Analysis Manager]
 ;;  The purpose of the VistA Package Size Analysis Manager tool is to report
 ;;    the following size data for each package.
 ;;    - Number of Routines
 ;;    - Total size of all routines
 ;;    - Number of Files
 ;;    - Number of Fields
 ;;    - Number of Options
 ;;    - Number of Protocols
 ;;    - Number of RPCs
 ;;    - Number of Fileman Templates
 ;;
 ;;  Accurately reporting this information requires correct package parameter
 ;;    definitions and a VistA instance with all patches applied to the package.
 ;;$PAUSE
 ;;  There are 5 steps for creating a VistA Package Size Report.
 ;;    1) Extract package parameters from the VistA instance that contains the
 ;;        most accurate data available in the Package file
 ;;    2) Move the Package File extract global [^XTMP("XTSIZE",$J)] to a fully
 ;;        patched VistA instance
 ;;    3) Convert the Extract file to a Parameter file
 ;;    4) Apply corrections to the Parameter file
 ;;    5) Create the VistA Size Report
 ;;
 ;;  Tools for Step 1, Package File Extract:
 ;;    On the Extract Manager list...
 ;;     - "Extract Package Data" action will move data from the local Package 
 ;;         File to the ^XTMP("XTSIZE",$J) global.
 ;;     - "Remote VistA Extract Query" action will request a Package file extract
 ;;         from another VistA instance and return it in a VA MailMan message.
 ;;
 ;;  Tools for Step 2, move the Package file extract to a fully patched VistA:
 ;;    On the Extract Manager list...
 ;;     - "Email Extract Global" action will send the ^XTMP("XTSIZE",$J) global
 ;;        to user entered Email addresses including VA MailMan addresses.
 ;;        This can be used to send the extract global to a fully patched VistA
 ;;        instance.  VA PackMan options will load the global on the patched VistA.
 ;;$PAUSE
 ;;  Tools for Step 3, Convert the Extract file to a Package Parameter file:
 ;;    On the Extract Manager list...
 ;;     - "Convert Extract to Parameter List" action will perform basic data
 ;;        integrity checks and cleanup, then display the Package Parameters list.
 ;;    On the Package Parameters list...
 ;;     - "Write Parameter List to File" action will create the Parameter file.
 ;;        [Parameter file name form: XTMPSIZE_{user initials}{mm-dd-yy_hhmm}.DAT]
 ;; 
 ;;  Tools for Step 4, Make corrections in the Package Parameter file:
 ;;    On the Parameter Display list...
 ;;     - "Display Package Overlap List" and "Parameter File Comparison" actions 
 ;;        display reports to support Package Parameter file cleanup.
 ;;     - "Display Captioned Parameters" action will display the package parameters
 ;;        in a user readable format.  This list provides three actions to support
 ;;        editing: "Edit Package Parameters", "Save Package Parameter Changes" and
 ;;        "Delete Package Parameter Entry".
 ;;
 ;;  Tools for Step 5, VistA Size Report:
 ;;    On the VistA Package Size Analysis Manager list...
 ;;     - "Display VistA Size Report" action prompts the user to select a Package
 ;;        Parameter file from the list, select to report for all packages or a
 ;;        single package.
 ;;$PAUSE
 ;;  NOTE: All of the lists in this tool include additional generic actions to
 ;;        review the information presented.
 ;;$END
