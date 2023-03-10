XTVSHLP1 ;Albany FO/GTS - VistA Package Sizing Manager; 25-JAN-2019
 ;;7.3;TOOLKIT;**143**;Apr 25, 1995;Build 116
 ;
LNTXT ; Help Text [Extract Manager]
 ;;Descriptions:
 ;; 
 ;;  Extract Package Data - This action extracts pertinent data from the local
 ;;    Package file and loads it into the ^XTMP("XTSIZE",$J) global.  The extract
 ;;    is added to the Extract Manager list.  If an extract in the ^XTMP("XTSIZE")
 ;;    global with the same $JOB value exists, the user is prompted to confirm
 ;;    overwrite of the existing ^XTMP global.
 ;; 
 ;;  Delete Extract - This action prompts the user for an extract to delete.
 ;;    The ^XTMP extract global is selected by entry of the Process ID.
 ;; 
 ;;  Display Extract - This action prompts the user for an extract to display.
 ;;    The ^XTMP extract global is selected by entry of the Process ID.  The
 ;;    Display Extract list presents the extract in a user readable format.
 ;;$PAUSE
 ;; 
 ;;  Convert Extract to Parameter list - This action prompts the user for a Process
 ;;    ID and displays the Package Parameters list.  The Package Parameters list
 ;;    includes actions to assist review of the parameters for accuracy.
 ;; 
 ;;  Email Extract Global - This action prompts the user for a Process ID and
 ;;    sends the ^XTMP("XTSIZE",$J) global to entered Email addresses.  This
 ;;    allows the extract to be sent to a fully patched VistA instance.
 ;; 
 ;;  Remote VistA Extract Query - This action prompts the user for a VistA site
 ;;    to query a Package file extract.  If Forum is queried, the user has the
 ;;    option of requesting a VistA Package size report for all packages on Forum.
 ;;    NOTE: VistA Size Reports returned from Forum will use the Package file
 ;;    extract (returned with the request) to calculate package sizes.
 ;; 
 ;; 
 ;;  NOTE: Delete Extract, Display Extract, Convert Extract to Parameter list, and
 ;;        Email Extract Global require an ^XTMP("XTSIZE") global to exist before
 ;;        they may be invoked.  (E.G. An extract must be listed)
 ;; 
 ;;$PAUSE
 ;;$END
 ;
LPTXT ; Help Text [Parameter Display]
 ;;Descriptions:
 ;; 
 ;;  Display Package Overlap List - This action compares package file and
 ;;    prefix assignments.  It reports files and prefixes that are assigned
 ;;    to multiple packages.
 ;; 
 ;;  Display Captioned Parameters - This action redisplays the data elements
 ;;    in the Parameter Display in a user readable form with the data element
 ;;    caption.  The Captioned List display includes actions to edit package
 ;;    parameters, delete packages and save changes to the Package Parameter
 ;;    file.
 ;; 
 ;;$PAUSE
 ;;  Display Parameter File Data Map - This action lists the data elements
 ;;    delimited by the up caret (^).  It also indicates the data element
 ;;    name and the field in the Forum system Package file where the source
 ;;    data is usually extracted.  This information can be helpful when reading
 ;;    the Parameter file listed.
 ;; 
 ;;  Parameter File Comparison - This action prompts the user for a Parameter
 ;;    File to compare to the displayed Parameter File.  It then lists the
 ;;    differences between the two files.
 ;; 
 ;;$END
 ;
LPCTXT ; ?? Help Text [Parameter Compare]
 ;;HINTS for using the Comparison Report:
 ;;  The 'Selected' file is the one you are reviewing.  It is reported as the
 ;;    'SEL' file.  One way to use this report is to identify updates needed in
 ;;    the 'SEL' file and add the changes to make it the most up-to-date Package
 ;;    Parameter file.  In this use-case, the 'SEL' file might be derived from
 ;;    the most recent VistA Package file extract.
 ;; 
 ;;  The 'Comparison' file can be used as a baseline from which to find changes
 ;;    needed to create a new Parameter file.  This report identifies it as the
 ;;    'CPR' file and differences between it and the 'SEL' file are reported.
 ;;    One use-case is to select the most up-to-date Package Parameters file
 ;;    and compare it to the 'SEL' (Selected) file.
 ;; 
 ;;  The Comparison Report answers the question: What was done to the 'SEL' file
 ;;    to make the differences between it and the 'CPR' file?  For example...
 ;;      - If package A in the 'CPR' file has a 'File Numbers' list of '7|8|9|'
 ;;        and the 'SEL' file does not have any files defined in the 'File Numbers'
 ;;        list (for package A), the report would be:
 ;;          Package: A
 ;;            Files
 ;;              Deleted entire list in SEL file:
 ;;                7|8|9
 ;;$PAUSE
 ;;  This report is designed for use by package Subject Matter Experts (SMEs).
 ;;    Package SMEs have the technical knowledge of package components to
 ;;    cleanup incorrect parameters and add missing parameters.
 ;;
 ;;  It is important to remember that new Package Parameter files may be created
 ;;    by updating Package Parameter data derived from a Vista Package file
 ;;    extract.  When an old Package Parameter file is used for comparison [CPR],
 ;;    it may have been previously reviewed by an SME.  An SME may have corrected
 ;;    data in the 'CPR' Package Parameter file that has long been incorrect in
 ;;    a new VistA Package file extract.  [The SME should contact the VistA
 ;;    DBA to update the Package definition in the Forum Package File (#9.4).]
 ;; 
 ;;  In the above instance, the Comparison Report might indicate that data has been
 ;;    deleted from a 'SEL' Package Parameter file.  If the 'CPR' Package Parameter
 ;;    file was updated by an SME and the data is missing from the 'SEL' Parameter
 ;;    file, the missing data may need to be added to the 'SEL' Parameter file
 ;;    again.
 ;; 
 ;;    {See the example on the following screen}
 ;;$PAUSE
 ;;    For example:
 ;;     1) VistA Package file entry 'APP A' does not include Additional Prefix "A".
 ;;     2) An SME created Package Parameter file "X" from a VistA Package file
 ;;          extract and added Additional Prefix "A" to the 'APP A' package.
 ;;     3) A User extracts data from the VistA Package file with 'APP A' still
 ;;          missing Additional Prefix "A".
 ;;     4) The User creates Package Parameter file "Y" from the new VistA Package
 ;;          file extract.
 ;;     5) A comparison of old Parameter file "X" [CPR] to new Parameter file "Y"
 ;;          [SEL] reports that Additional Prefix "A" is missing from 'APP A' in
 ;;          the new Package Parameter file "Y" [SEL].
 ;;
 ;;     An SME analysis of Package Parameter file "Y" could determine...
 ;;        a) Additional Prefix "A" needs to be added to 'APP A' in the Package
 ;;           Parameter file "Y".
 ;;      OR
 ;;        b) Additional Prefix "A" was removed from 'APP A' in the VistA Package
 ;;           file since the last extract, and the Package Parameter file "Y" is
 ;;           correct.
 ;;
 ;;     Unless a new Package definition change has been made to VistA, the
 ;;       correction is to add Additional Prefix "A" to Package Parameter file "Y".
 ;;$PAUSE
 ;;$END
 ;
LPDCTXT ; Help Text [Captioned List]
 ;;Descriptions:
 ;; 
 ;;  Edit Package Parameters - This action prompts the user for a package to
 ;;    edit.  If the package is not defined, the user is prompted to add the
 ;;    package.  Selecting to add the package will prompt for the data elements.
 ;;    Selecting to NOT add the package will prompt to display a list of packages.
 ;;    If the selected package is defined, the user is prompted to enter the
 ;;    data elements.
 ;;
 ;;    NOTE: Rearranging data on "Additional Prefixes', 'Excepted Prefixes'
 ;;          'File Numbers', or 'File Ranges' is NOT a parameter edit and will
 ;;          not be saved.
 ;; 
 ;;$PAUSE
 ;;  Save Package Parameter Changes - When edits (package add, change, or delete)
 ;;    are made to the Parameter list, {EDITED} is displayed in the header to
 ;;    indicate the Parameter list has unsaved edits.  The Save Package Parameter
 ;;    Changes action prompts the user to save the changes to either a new
 ;;    Parameter file or overwrite the displayed Parameter file.  If the Parameter
 ;;    file is overwritten, it is first copied to a file of the same name with a
 ;;    ".BAK" extension.  Only one ".BAK" file is retained with the most recent
 ;;    'before save' copy of the Parameter file.
 ;; 
 ;;  Delete Package Parameter Entry - This action prompts the user for a Package
 ;;    to delete.  The user is then prompted to confirm deletion.  When a package
 ;;    is deleted, {EDITED} is displayed in the header until the deletion is
 ;;    saved to the file.
 ;; 
 ;; 
 ;;  NOTE: Parameter changes are not saved to the disk file until the user either
 ;;        invokes the "Save Package Parameter Changes" action or confirms saving
 ;;        the Parameter file when exiting the parameter Captioned List display
 ;;        with unsaved edits in the Parameter file.
 ;; 
 ;;$PAUSE
 ;;$END
 ;
LRTXT ; ?? Help Text [Package Statistics]
 ;;Descriptions:
 ;; 
 ;;  Create Text File - This action writes the displayed report to a text file
 ;;    in the default host file directory.  The default text file name is in
 ;;    the form:
 ;;      VistAPkgSize_{julian data/time}.txt
 ;;    The user may change the directory where the file is written or the file
 ;;    name at the respective prompts.
 ;; 
 ;;  Email Rpt Attachment - This action prompts the user for Email addresses,
 ;;    bundles the displayed Package Statistics report into a file, includes
 ;;    the file as an attachment in the message and sends the message to the
 ;;    recipients.  The text file name is in the form:
 ;;      VistAPkgSize_{julian data/time}.txt
 ;;    The message indicates the creation date, attached file name and the data
 ;;    in the file.  Alternately, the file text can be sent in the message.
 ;;$PAUSE
 ;;  Remote VistA Size Query - This action prompts the user for a package in
 ;;    the selected Package Parameter file and a VistA server to query.  The
 ;;    report from the remote VistA is sent to the users' VA MailMan address.
 ;;
 ;;  Swap Header - This action is available when a user readable VistA package
 ;;    size report for ALL packages is displayed.  It will toggle the header
 ;;    area on the report screen between the "VistA Package Size Analysis
 ;;    Manager - Package Statistics" heading and the report column headings.
 ;;    This allows a user who has progressed beyond the first screen of the
 ;;    report to display the column headings.  The action is inactive when
 ;;    displaying a size report for a SINGLE package or a caret (^) delimited
 ;;    report of ALL packages.
 ;;      
 ;;
 ;;$PAUSE
 ;; The Package Statistics lists the following size data for each package:
 ;;   - Number of Routines
 ;;   - Total size of all routines  (# of characters)
 ;;   - Number of Files
 ;;   - Number of Fields
 ;;   - Number of Options
 ;;   - Number of Protocols
 ;;   - Number of RPCs
 ;;   - Number of Fileman Templates (Print, Sort, & Input Templates)
 ;;
 ;; NOTE: Namespaces duplicated in 'Additional Prefixes' for multiple packages
 ;;       will not be counted in component totals for any package EXCEPT the
 ;;       Package that has the namespace defined for the 'Primary Prefix'
 ;;       and/or the prefix defined for the KIDS package.
 ;;
 ;;       * THE PARAMETER FILE USED TO CREATE A SIZE REPORT NEEDS TO HAVE    *
 ;;       * CORRECTLY DEFINED PACKAGES AND PARAMETERS FOR A CORRECT REPORT.  *
 ;;$PAUSE
 ;;$END
