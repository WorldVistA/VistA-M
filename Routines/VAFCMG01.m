VAFCMG01 ;ALB/JRP,LTL-DEMOGRAPHIC MERGE SCREEN ;18-OCT-1996
 ;;5.3;Registration;**149**;Aug 13, 1993
 ;
 ;NOTE: This routine contains line tags used to implement a
 ;      List Manager user interface
 ;
EN(VAFCDFN,VAFCARR,VAFCFROM,VAFCEVDT) ;Main entry point
 ; - calls List Manager interface
 ;
 ;Input  : VAFCDFN - Pointer to entry in PATIENT file (#2) to merge
 ;                   data into
 ;         VAFCARR - Array contain data to merge (full global reference)
 ;                   Defaults to ^TMP("VAFC-MERGE-FROM",$J)
 ;                   VAFCARR() should be set as follows:
 ;                     VAFCARR(File,Field) = Value
 ;                       Where File = File number Value is from
 ;                             Field = Field number Value is from
 ;                             Value = Info to merge
 ;                       Notes: Dates must be in FileMan format
 ;                            : Special considerations for Value
 ;                                "@"  - Displays <DELETE> and deletes
 ;                                       local value if merged
 ;                                "^text"  - Displays text and ignores
 ;                                           field if merged
 ;                                NULL  - Displays <UNSPECIFIED> and
 ;                                        ignores field if merged
 ;                                Doesn't exist  - Displays <UNSPECIFIED>
 ;                                                 and ignores field
 ;                                                 if merged
 ;         VAFCFROM - Text denoting where merge data came from (1-35)
 ;                      Example: ALBANY VAMC
 ;                      Example: CIRN
 ;                    Defaults to local facility name
 ;         VAFCEVDT - Date/time merge data was instantiated (FileMan)
 ;                      Example: Date/time data changed at remote site
 ;                    Defaults to current date/time
 ;Output : -21 - User exited via '^^' and differences exits
 ;         -20 - User exited via '^^' and no differences
 ;         -11 - User exited via '^' and differences exits
 ;         -10 - User exited via '^' and no differences
 ;          -1 - Error occurred / bad input
 ;           0 - User quit and no differences
 ;           1 - User quit and differences exist
 ;          10 - User done and no differences
 ;          11 - User done and differences exist
 ;          20 - User rejected data and no differences
 ;          21 - User rejected data and differences exist
 ;
 ;Notes  : File 2 is the only file currently supported (i.e. multiples
 ;         are not supported)
 ;       : The following fields are the only fields currently supported
 ;           .01, .02, .03, .05, .08, .09, .111, .1112, .112, .113
 ;           .114, .115, .117, .131, .132, .211, .219, .2403, .301
 ;           .302, .31115, .323, .351, 391, 1901
 ;
 ;Check input
 S VAFCDFN=+$G(VAFCDFN)
 Q:('VAFCDFN) -1
 Q:('$D(^DPT(VAFCDFN))) -1
 S VAFCARR=$G(VAFCARR)
 S:(VAFCARR="") VAFCARR="^TMP(""VAFC-MERGE-FROM"","_$J_")"
 Q:('$O(@VAFCARR@(2,0))) -1
 S VAFCEVDT=+$G(VAFCEVDT)
 S:('VAFCEVDT) VAFCEVDT=$$NOW^VAFCMGU0(1)
 S VAFCFROM=$G(VAFCFROM)
 S:(VAFCFROM="") VAFCFROM=$P($$SITE^VASITE(),"^",2)
 S VAFCFROM=$E(VAFCFROM,1,35)
 ;Declare variables
 N VAFCDONE,VAFCDIFF,VAFCRJCT,VAFCEXIT,FRSTDGT,LASTDGT,OUTPUT
 ;Initialize 'Done' flag
 S VAFCDONE=0
 ;Initialize 'Differences' flag
 S VAFCDIFF=0
 ;Initialize 'Reject' flag
 S VAFCRJCT=0
 ;Initialize 'Exit' flag
 S VAFCEXIT=0
 ;Call List Manager interface
 D EN^VALM("VAFC EXCPT MERGE SCREEN")
 ;Determine last digit of output
 ;No differences
 S LASTDGT=0
 ;Differences exist
 S:(VAFCDIFF) LASTDGT=1
 ;Determine first digit of output
 ;User quit
 S FRSTDGT=0
 ;User done
 S:(VAFCDONE) FRSTDGT=1
 ;User rejected data
 S:(VAFCRJCT) FRSTDGT=2
 ;User aborted via up arrow
 S:(VAFCEXIT) FRSTDGT=0-VAFCEXIT
 ;Combine digits of output
 S OUTPUT=FRSTDGT_LASTDGT
 ;Done
 Q OUTPUT
 ;
HEADER ;Entry point to build header
 ;
 ;Input  : VAFCDFN - Pointer to entry in PATIENT file (#2) data is
 ;                   being merged into
 ;         VAFCFROM - Text denoting where merge data came from
 ;         VAFCEVDT - Date/time merge data was instantiated (FileMan)
 ;         All variables set by List Manager interface
 ;Output : Header to use for List Manager interface
 ;Notes  : Existance/validity of input variables is assumed
 ;
 ;Declare variables
 N DATA,LINE,IENS,PATDATA,ERRDATA
 ;Get patient info needed to build header
 D GETDATA^VAFCMGU0(VAFCDFN,1,"PATDATA","ERRDATA")
 ;Build patient portion of header
 S IENS=VAFCDFN_","
 ;Add name
 S DATA=$G(PATDATA(2,IENS,.01))
 S:(DATA="") DATA="PATIENT NAME NOT ON FILE"
 S LINE=DATA
 ;Add last four of SSN
 S DATA=$E($G(PATDATA(2,IENS,.09)),6,10)
 S:(DATA="") DATA="????"
 S DATA=" ("_DATA_")"
 S LINE=LINE_DATA
 ;Add date of birth
 S DATA=$G(PATDATA(2,IENS,.03))
 I (DATA'="") D
 .S DATA=$$EX2INDT^VAFCMGU0(DATA)
 .S DATA=$$IN2EXDT^VAFCMGU0($P(DATA,".",1))
 S:(DATA="") DATA="UNKNOWN"
 S DATA="DOB: "_DATA
 S LINE=$$INSERT^VAFCMGU0(DATA,LINE,44)
 ;Add date of death
 S DATA=$G(PATDATA(2,IENS,.351))
 I (DATA'="") D
 .S DATA=$$EX2INDT^VAFCMGU0(DATA)
 .S DATA=$$IN2EXDT^VAFCMGU0($P(DATA,".",1))
 S:(DATA="") DATA="N/A"
 S DATA="DOD: "_DATA
 S LINE=$$INSERT^VAFCMGU0(DATA,LINE,63)
 S VALMHDR(1)=LINE
 ;Build remote portion of header
 ;Add where data came from
 ;S LINE="Data From: "_VAFCFROM
 ;Last local edit, check for audit
 S (DATA,LINE)="" D:$O(^DIA(2,"B",VAFCDFN,0))
 .S DATA=$P($G(^DIA(2,0)),U,3)+1
 .S DATA=$O(^DIA(2,"B",VAFCDFN,DATA),-1)
 .S DATA=$$FMTE^XLFDT($P($G(^DIA(2,DATA,0)),U,2),"2P")
 ;if no audit, check pivot file
 D:DATA']""&($O(^VAT(391.71,"C",VAFCDFN,0)))
 .S DATA=$P($G(^VAT(391.71,0)),U,3)+1
 .S DATA=$O(^VAT(391.71,"C",VAFCDFN,DATA),-1)
 .S DATA=$$FMTE^XLFDT($P($G(^VAT(391.71,DATA,0)),U),"2P")
 S DATA="Last Local Edit: "_$S(DATA]"":DATA,1:"Unknown")
 S LINE=$$INSERT^VAFCMGU0(DATA,LINE,0)
 ;Add event date/time
 S DATA=$E(VAFCFROM,1,28)_" Event Date: "_$$IN2EXDT^VAFCMGU0($P(VAFCEVDT,".",1))
 S LINE=$$INSERT^VAFCMGU0(DATA,LINE,40)
 S VALMHDR(2)=LINE
 ;Done
 Q
 ;
INITSCRN ;Entry point to build screen
 ;
 ;Input  : VAFCDFN - Pointer to entry in PATIENT file (#2) to merge
 ;                   data into
 ;         VAFCARR - Array contain data to merge (full global reference)
 ;                   VAFCARR() should be set as follows:
 ;                     VAFCARR(File,Field) = Value
 ;                       Where File = File number Value is from
 ;                             Field = Field number Value is from
 ;                             Value = Info to merge
 ;                       Notes: Dates must be in FileMan format
 ;                            : Special considerations for Value
 ;                                "@"  - Displays <DELETE> and deletes
 ;                                       local value if merged
 ;                                "^text"  - Displays text and ignores
 ;                                           field if merged
 ;                                NULL  - Displays <UNSPECIFIED> and
 ;                                        ignores field if merged
 ;                                Doesn't exist  - Displays <UNSPECIFIED>
 ;                                                 and ignores field
 ;                                                 if merged
 ;         VAFCFROM - Text denoting where merge data came from (1-35)
 ;         VAFCEVDT - Date/time merge data was instantiated (FileMan)
 ;         All variables set by List Manager Interface
 ;Output : Display area and variables required List Manager interface
 ;         Display
 ;           VALMAR(Line,0) = Line of text in display
 ;         Indexes
 ;           VALMAR("IDX",Line,Entry) = ""
 ;           VALMAR("E2F",Entry,N) = File^Field
 ;             N => Allows for multiple fields per entry (starts with 1)
 ;           VALMAR("E2G",Entry) = Group entry is contained in
 ;           VALMAR("GRP",Group) = First line of group in display
 ;             Note: The E2F and E2G indexes are only set if the data
 ;                   to merge does not match the local data
 ;Notes  : Existance/validity of input variables is assumed
 ;
 ;Declare variables
 D CHGCAP^VALM("VAFLOCAL",$P($$SITE^VASITE(),U,2))
 D CHGCAP^VALM("REMOTE",$G(VAFCFROM))
 N VAFCDOTS
 S VAFCDOTS=1
 ;Initialize global locations
 K @VALMAR,^TMP("VAFC-UNDO")
 ;Build entire display
 S VALMCNT=1
 D BLDALL^VAFCMGB
 ;No differences found
 S:('$D(@VALMAR@("E2F"))) VALMSG="** No differences found **"
 ;Done
 S VALMCNT=VALMCNT-1
 S VALMBG=1
 Q
 ;
CLEANUP ;Entry point to clean up
 ;
 ;Input  : All variables set by List Manager interface
 ;Output : None
 ;
 ;Up arrow out ?
 I (Y=-1) D
 .;Single up arrow
 .S VAFCEXIT=1
 .;Double up arrow
 .S:($E(X,1,2)="^^") VAFCEXIT=2
 ;Differences exist ?
 S:($D(@VALMAR@("E2F"))) VAFCDIFF=1
 ;Clean up global locations used
 K @VALMAR,^TMP("VAFC-UNDO")
 ;Switch to full screen
 D FULL^VALM1
 ;Done
 Q
