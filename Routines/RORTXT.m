RORTXT ;HCIOFO/SG - TEXT RESOURCE UTILITIES ; 12/13/02 11:15am
 ;;1.5;CLINICAL CASE REGISTRIES;;Feb 17, 2006
 ;
 ;***** RETURNS THE TEXT RESOURCE
 ;
 ; DIALOG        Dialog number (in the DIALOG file)
 ;
 ; .RORDST       Reference to a local variable where the text
 ;               will be stored.
 ;
 ; [FLAGS]       Flags that define the mode of execution
 ;
 ;                 A  Append the text to the content of RORDST.
 ;
 ;                 S  Suppress the blank line that is normally
 ;                    inserted between discrete blocks of text
 ;                    (in Append mode).
 ;
 ;                 F  Format the local array similar to the default
 ;                    output format of the ^TMP global (see the
 ;                    BLD^DIALOG documentation for more detailes).
 ;
TEXT(DIALOG,RORDST,FLAGS) ;
 N DIERR,DIHELP,DIMSG
 K:'($G(FLAGS)["A") RORDST
 D BLD^DIALOG(DIALOG,,,"RORDST",$TR($G(FLAGS),"A"))
 Q
