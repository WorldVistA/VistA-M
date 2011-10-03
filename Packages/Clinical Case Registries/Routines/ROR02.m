ROR02 ;HCIOFO/SG - CLINICAL CASE REGISTRIES (VARIABLES) ; 7/22/05 11:11am
 ;;1.5;CLINICAL CASE REGISTRIES;;Feb 17, 2006
 ;
 ; RORCACHE ------------ IN-MEMORY CACHE
 ;
 ; RORCACHE(
 ;   "XMLENT",...)       XML elements and attributes
 ;                       (see the $$XEC^RORTSK11 function)
 ;
 ; RORERRDL ------------ DEFAULT ERROR LOCATION
 ;
 ; RORERROR ------------ ERROR PROCESSING DATA
 ;
 ; RORERROR("ES",        Index of the top of the stack
 ;   Index,                ^1: Error code
 ;                         ^2: Message text
 ;     1)                Place of the error (LABEL^ROUTINE)
 ;     2,Seq#)           Additional information (opt'l)
 ;
 ; RORERROR("DBS",       The $$DBS^RORERR function stores a list of
 ;   ErrCode)            FileMan DBS error codes here (as subnodes).
 ;
 ; RORPARM ------------- PACKAGE-WIDE CONSTANTS AND VARIABLES
 ;
 ; RORPARM("DEBUG")      Debug mode (opt'l):
 ;                         0  Disabled (default)
 ;                         1  Enabled
 ;                         2  Enabled; and all messages are not only
 ;                            logged but displayed on the screen too
 ;                         3  The same as 2 but registry update or
 ;                            data extraction is aborted immediately
 ;                            after processing a patient with errors
 ;
 ; RORPARM("DEVELOPER")  If this node is defined and not zero,
 ;                       national definitions (registry parameters,
 ;                       selection rules, etc) can be edited.
 ;                       Otherwise, editing is prohibited.
 ;
 ; RORPARM("ERR")        Enable/disable extended error processing:
 ;                         0  Disabled (default)
 ;                         1  Enabled
 ;
 ; RORPARM("KIDS",       This node is defined and non-zero only during
 ;                       the KIDS installation process:
 ;                         1  Pre-install
 ;                         2  Post-install
 ;   ParamName)          Value of an installation parameter
 ;
 ; RORPARM("LOG",        Enable/disable log collection:
 ;                         0  Disabled (default)
 ;                         1  Enabled
 ;   Type)               Enable (1) collection of only particular
 ;                       events (optional, all events by default)
 ;                       See the LOG EVENT field in the ROR REGISTRY
 ;                       PARAMETERS file #798.1 for possible values.
 ;
 ; RORPARM("SETUP")      This node is defined and non-zero only
 ;                       during the registry setup.
 ;
 Q
