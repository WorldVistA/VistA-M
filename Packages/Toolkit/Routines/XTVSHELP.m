XTVSHELP ;Albany FO/GTS - VistA Package Sizing Manager; 31-DEC-2018
 ;;7.3;TOOLKIT;**143**;Apr 25, 1995;Build 116
 ;
LPERTXT2 ; ?? Help Text [Prefix/File Overlap]
 ;;An explanation of Prefix and File Overlaps (intersections):
 ;; 
 ;;  - Prefix Overlaps identify packages that have the same Prefix defined
 ;;      in either the 'Primary Prefix' or 'Additional Prefixes' data elements.
 ;;      Prefix overlaps mean that Routine tallies & size, Options, Protocols,
 ;;      RPCs, and Templates named with those prefixes will be counted for both
 ;;      packages.
 ;; 
 ;;  - File Overlaps identify file number assignment to duplicate packages.
 ;;      File overlaps mean that the listed file numbers will be counted for both
 ;;      packages.  Additionally, fields in those files will be counted for both
 ;;      packages.
 ;;$PAUSE
 ;;   ...CONTINUING 'Prefix Overlaps'...
 ;; 
 ;; A Prefix [AKA 'package namespace'] is the first letters of the name of
 ;;  a package component.  A package component is counted for two packages
 ;;  when the first letters in the name of the component equal a Prefix
 ;;  assigned to the package and the letters are not included in the 'Excepted
 ;;  Prefixes' data element.
 ;; 
 ;;  For example:
 ;;    - Package AB TEST has a 'Primary Prefix' of "AB"
 ;;    - Package XY TEST has a 'Primary Prefix' of "XY" and an 'Additional
 ;;       Prefix' of "ABL"
 ;; 
 ;;    A Routine named "ABLRTN1" will be counted in the size report for both
 ;;    packages UNLESS package AB TEST includes "ABL" in the 'Excepted Prefixes'
 ;;    data element.
 ;; 
 ;;    EXCEPTION: If "AB" is the 'Primary Prefix' or KIDS Build Prefix for Package
 ;;      "AB TEST" and also defined as an 'Additional Prefix' for Package XY, then
 ;;      components beginning with "AB" will only be counted for Package AB.
 ;;      See ??? help for Prefix priority when overlaps exist with 'Primary Prefix'
 ;;      or a KIDS Build Prefix. 
 ;;$PAUSE
 ;;   ...CONTINUING 'File Overlaps'...
 ;; 
 ;; The data elements in the Parameter file [which indicate package file
 ;;  assignment] are 'File Ranges', '*Lowest File#' & '*Highest File#', and
 ;;  'File Numbers'.  This overlap report follows the VistA Package Size
 ;;  Report rules for selecting the Parameter file data element to use for
 ;;  identifying package files.  Only one is used by the VistA Package Size
 ;;  report tool to count files and fields assigned to a package.
 ;; 
 ;;  RULES for finding files assigned to a package:
 ;;  The data elements are checked in the order below.
 ;;  The first defined data element(s) found is used to count assigned files.
 ;;    1) 'File Ranges' [Files only counted once for a package when ranges overlap]
 ;;    2) '*Lowest File#' & '*Highest File#' [Both must be defined]
 ;;    3) 'File Numbers'
 ;;    4) None of the above defined - no File overlaps or totals are reported
 ;; 
 ;;  Package SMEs correcting package parameters only need to validate the 'File
 ;;    Ranges' data element.  With a correct 'File Ranges' data element, the 
 ;;    VistA Package Size Report will include correct totals for package files
 ;;    and fields.
 ;;$PAUSE
 ;; 
 ;;$END
 ;
LPERTXT3 ; ??? Help Text [Prefix/File Overlap]
 ;;A description of Primary and KIDS Prefix usage:
 ;; 
 ;; When creating the VistA Size Report from the VistA Package Size Analysis
 ;;  Manager user interface, Prefixes are used to identify namespaced components
 ;;  included in the application package.  The same prefix assigned to multiple
 ;;  packages as an "Additional Prefix" will be used to identify application
 ;;  components counted for both packages.  This is why review by an application
 ;;  Subject Matter Expert to correct package parameter definitions is important
 ;;  to obtain correct size information in the VistA Size Report.
 ;;
 ;;  However, there are instances that will eliminate Prefixes assigned to
 ;;  multiple packages from being used to identify components counted in both
 ;;  packages.  An explanation of these instances is in the following.
 ;; 
 ;;  Three conditions affecting the package size report for a multiply assigned
 ;;  Prefix.
 ;;    1) The packages assigned the Prefix are both in the Package Parameter
 ;;        file.
 ;;    2) The Prefix is a Primary Prefix for one of the packages.
 ;;    3) The Prefix is used in the name of KIDS Builds for one of the packages.
 ;;$PAUSE
 ;; Primary Prefix - Will always be used to identify package components.
 ;;
 ;; KIDS Build Prefix - Will always be used to identify package components.
 ;;   [KIDS Build Prefix is the Prefix used by a Package in the Parameter File
 ;;   to name KIDS Builds for that Packages' patches.]
 ;;
 ;; Additional Prefix - Will be used to identify components in multiple packages
 ;;   when the Prefix is defined for those packages.
 ;;
 ;; Special conditions:
 ;;   When a Prefix is used as a Primary Prefix for one package and a KIDS Build
 ;;   Prefix for a different package, the Prefix will be used to count components
 ;;   for both packages.
 ;;
 ;;   An Additional Prefix will not be used to identify components in a package
 ;;   when another package in the Package Parameter File defines the Prefix as
 ;;   either the KIDS Build Prefix or Primary Prefix.
 ;;
 ;;   An Additional Prefix WILL be used to identify components in a package
 ;;   when it is a SUBSET of a Primary Prefix or a KIDS Build Prefix for a package
 ;;   in the Package Parameter File.
 ;;$PAUSE
 ;;$END
 ;
CPTXT2 ; ?? Help Text [Package Parameters]
 ;;Descriptions:
 ;; 
 ;;  Display Parameter List - This action displays the up caret (^) piece delimited
 ;;    parameters file [created from the extract] to the list screen.  It changes
 ;;    the displayed list to Package Parameters when the Package Parameter
 ;;    Corrections are listed.
 ;; 
 ;;  Write Parameter List to File - This action writes the displayed Parameter List
 ;;    to a file in the default host file directory.  The name will be in the form
 ;;    'XTMPSIZE_{user initials}{mm-dd-yy_hhmm}.DAT' and will be listed with other
 ;;    Package Parameter files.
 ;; 
 ;;$PAUSE
 ;;  Display Parameter Corrections - This action displays the results of the data
 ;;    integrity check and cleanup.  The check and cleanup are completed when
 ;;    the extract is converted to Package Parameters.  The action changes the
 ;;    displayed list to Package Parameter Corrections when Package Parameters are
 ;;    listed.
 ;; 
 ;;  Email Corrections Rpt & Parameters - This action prompts the user for Email
 ;;    addresses, writes the corrections report to an Email message, optionally
 ;;    includes the displayed Package Parameters or bundles them in a file to
 ;;    attach to the message and sends the message to the recipients.
 ;;$PAUSE
 ;;$END
 ;
CPTXT3 ; ??? Help Text [Package Parameters]
 ;;  The Package Parameter data elements are displayed as an up caret (^)
 ;;    delimited list.  Each data element is extracted from the ^XTMP("XTSIZE")
 ;;    global array.  The ^XTMP("XTSIZE") global is an extract of the VistA
 ;;    Package File (#9.4).  Not all VistA instances have a Package File (#9.4)
 ;;    data dictionary that includes all the fields and data needed to create the
 ;;    best initial Parameter file.  So the Package File used for the extract needs
 ;;    to be reviewed prior to the extract for Data Dictionary and Data accuracy.
 ;;
 ;;  The Package File used as the extract source to create the ^XTMP("XTSIZE")
 ;;    file must contain the following fields:
 ;;     - NAME (#.01)
 ;;     - PREFIX (#1)
 ;;     - *LOWEST FILE NUMBER (#10.6) {not critical if LOW-HIGH RANGE defined}
 ;;     - *HIGHEST FILE NUMBER (#11) {not critical if LOW-HIGH RANGE defined}
 ;;     - ADDITIONAL PREFIXES multiple (#14)
 ;;     - EXCLUDED NAMESPACE multiple (#919)
 ;;     - FILE NUMBER multiple (#15001)
 ;;     - LOW-HIGH RANGE multiple (#15001.1)
 ;;     - PARENT PACKAGE (#15003)
 ;;$PAUSE
 ;;Data map for Package Parameter list:
 ;; Location : Data Name
 ;;              [Package File (#9.4) Field name & number]
 ;; ^ pce 1 : Package Name
 ;;              [Source: NAME (#.01)]
 ;; ^ pce 2 : Primary Prefix
 ;;              [Source: PREFIX (#1)]
 ;; ^ pce 3 : *Lowest File #
 ;;              [Source: *LOWEST FILE NUMBER (#10.6)]
 ;; ^ pce 4 : *Highest File #
 ;;              [Source: *HIGHEST FILE NUMBER (#11)]
 ;; ^ pce 5 : Pipe character (|) delimited list of Additional Prefixes
 ;;              [Source: ADDITIONAL PREFIXES multiple (#14)]
 ;; ^ pce 6 : Pipe character (|) delimited list of Excepted Prefixes
 ;;              [Source: EXCLUDED NAME SPACE multiple (#919)]
 ;; ^ pce 7 : Pipe character (|) delimited list of File Number entries
 ;;              [Source: FILE NUMBER multiple (#15001)]
 ;; ^ pce 8 : Pipe character (|) delimited list of File Range entries 
 ;;              [Source: LOW-HIGH RANGE multiple (#15001.1)]
 ;; ^ pce 9 : Parent Package
 ;;              [Source: PARENT PACKAGE field (#15003)]
 ;;$PAUSE
 ;; The "Convert Extract to Parameter list" action performs some data
 ;;  cleanup when creating the Package Parameters list.  Data in the
 ;;  Package File extract from the Package File LOW-HIGH RANGE multiple
 ;;  [File Range (pce 8)] will be "cleaned up" as follows:
 ;; 
 ;;  - Any 'end of range' file number from "LOW-HIGH RANGE" that does
 ;;      not end in a decimal will have ".9999" added to it in the
 ;;      Parameters List File Ranges data.
 ;;      [E.G. "LOW-HIGH RANGE" 'end of range' number 7 becomes 7.9999
 ;;      in File Ranges]
 ;; 
 ;;  - Any number in the "FILE NUMBER" data that does not fall within a
 ;;      "LOW-HIGH RANGE" will be added as a range in the Parameters List
 ;;      File Ranges Data.
 ;;      [E.G. FILE NUMBER 7 adds 7-7.9999 to File Ranges, when 7 is not
 ;;      included in an existing "LOW-HIGH RANGE"]
 ;;
 ;;  NOTE: The "Email Corrections Rpt & Parameters" action can be used to
 ;;        send the corrections report and Parameter file to a Subject
 ;;        Matter Expert so a technical review of package parameter
 ;;        definitions can be verified or updated.
 ;;$PAUSE
 ;;  NOTE: Parameter or Correction list review is assisted with additional
 ;;        actions available.
 ;;$END
