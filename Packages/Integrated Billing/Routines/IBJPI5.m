IBJPI5 ;ENS/GSS - IBJP5 eIV SITE PARAMETERS SCREEN ;30-AUG-2010
 ;;2.0;INTEGRATED BILLING;**438**;31-AUG-10;Build 52
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; eIV - Electronic Insurance Verification Site Selected Service Type Codes
 ;
 Q
 ;
EN ; main entry point for IBJP EIV SITE SELECTED CODES
 N DIR,I,IBDIRS,IBFLD,IBMAXDSC,IBMAXSSC,IBSTCACT,IBSTCARY,IBSTCCK,IBSTCDF
 N IBSTCDFC,IBSTCDFI,IBSTCDSC,IBSTCIEN,IBSTCR
 N IBSTCSS,IBSTCSSI,IBSTCSSX,IBSTCX,IBTMP,IBTMPCT,IBVALID,X,Y
 ;
 D INIT,BLD
 ;
EXIT ; Exit
 K ^TMP("IBJPI5",$J)
 S VALMBCK="R"
 Q
 ;
INIT ; Initialize
 S IBMAXSSC=9   ; max # SITE SELECTD STCS
 S IBMAXDSC=11  ; max # of DEFAULT STCs
 ; IBSTCDF=default STC IENs which herein remain unchanged
 S IBSTCDF=$G(^IBE(350.9,1,60)),IBSTCDFI=U_IBSTCDF_U
 D GET
 Q
 ;
GET ; Get site selected STCs from db and define variables and arrays for AS and DS options
 K ^TMP("IBJPI5",$J),IBSTCARY
 ; IBSTCSS=delimited string of existing Site Selected STC IENs
 S IBSTCSS=$G(^IBE(350.9,1,61)),IBSTCSSI=U_IBSTCSS_U
 ; IBSTCIEN = A Site Selected Service Type Code (SSSTC) IEN
 S IBSTCIEN=0
 ; Create ^TMP global of available STCs by external ID to be used as site selected STCs - used in LS 
 F  S IBSTCIEN=$O(^IBE(365.013,IBSTCIEN)) Q:IBSTCIEN="B"  D
 . S IBSTCR=^IBE(365.013,IBSTCIEN,0)
 . ; Not a useable STC if STC is inactive, STC is already a DEFAULT STC, or STC already a Site Specific STC
 . I $P(IBSTCR,U,3)'=""!($F(IBSTCDFI,U_IBSTCIEN_U))!$F(IBSTCSSI,U_IBSTCIEN_U) Q
 . S ^TMP("IBJPI5",$J,$P(IBSTCR,U,1))=$P(IBSTCR,U,1)_" "_$P(IBSTCR,U,2)
 ; IBSTCSSX = Delimited string of SS STC external codes corresponding to IBSTCSS sequence of IENs
 ; IBDIRS   = String list of SSSTCs as options for deletion
 ; IBTMP    = Temporary string of SSSTCs to rebuild IBSTCSSS after STC to delete selected
 S (IBDIRS,IBSTCSSX,IBTMP)="",IBTMPCT=0
 F I=1:1:IBMAXSSC S IBSTCIEN=$P(IBSTCSS,U,I) Q:IBSTCIEN=""  D
 . ; Use an array to keep codes in order by external code - used in AS
 . S IBSTCR=^IBE(365.013,IBSTCIEN,0)
 . S IBSTCARY($P(IBSTCR,U,1))=IBSTCIEN_U_$P(IBSTCR,U,2)
 . ; Setting up IBDIRS - used in DS
 . S $P(IBSTCSSX,U,I)=$P(IBSTCR,U,1)
 . S IBDIRS=IBDIRS_";"_$P(IBSTCR,U,1)_":"_$P(IBSTCR,U,2)
 ; end of what was in AS
 Q
 ;
SET ; Set service type codes to db
 ; Store IENs of Site Selected Service Type Codes
 S ^IBE(350.9,1,61)=IBSTCSS
 D GET
 Q
 ;
A ; List
 N DIR,X,Y
 D FULL^VALM1 W @IOF
 S (IBSTCX,X)=""
 S DIR(0)="FO",DIR("A")="Enter RETURN to continue, code mnemonic/# to add, or '^' to exit"
 S DIR("?")="Enter RETURN to list more valid codes, enter a code, or '^' to quit."
 F I=1:1 S IBSTCX=$O(^TMP("IBJPI5",$J,IBSTCX)) Q:IBSTCX=""  D  Q:X'=""
 . I I#23=0 D ^DIR Q:X=U
 . I X'="" D AV S X=U Q
 . W !,^TMP("IBJPI5",$J,IBSTCX)
 I IBSTCX="" D PAUSE^VALM1
 Q
 ;
 ; AV tag entry point for adding code from LS function
AV ; VALIDITY CHECKS
 I X=U Q
 I $P(IBSTCSS,U,IBMAXSSC)'="" D ERR("A MAXIMUM OF "_IBMAXSSC_" SITE SELECTED CODES ALLOWED") Q
 ; Could just check ^TMP for available STCs but then error message to user would not be specific
 ;   as to the reason the code could not be used, thus the seemingly redundant checks.
 S X=$TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 S IBSTCIEN="",IBSTCIEN=$O(^IBE(365.013,"B",X,IBSTCIEN))
 I IBSTCIEN="" D ERR("NO SUCH CODE IN DATABASE") Q
 I $G(IBSTCARY(X))'="" D ERR(X_" IS ALREADY A SITE SELECTED CODE") Q
 S IBSTCR=^IBE(365.013,IBSTCIEN,0)
 I $P(IBSTCR,U,3)'=""  D ERR(X_" IS NOT AN ACTIVE CODE") Q
 S IBSTCCK=U_IBSTCIEN_U,IBSTCDFC=U_^IBE(350.9,1,60)_U
 I $F(IBSTCDFC,IBSTCCK) D ERR(X_" IS ALREADY A SYSTEM WIDE DEFAULT CODE") Q
 ; Code entered passed all checks thus add it
 S IBSTCARY(X)=IBSTCIEN_U_$P(IBSTCR,U,2)
 ; Recreate IBSTCSS string of codes in external code order
 S (IBSTCSS,X)=""
 F  S X=$O(IBSTCARY(X)) Q:X=""  S IBSTCSS=IBSTCSS_U_$P(IBSTCARY(X),U,1)
 S IBSTCSS=$E(IBSTCSS,2,999)
 D SET
 W "..",$P(IBSTCR,U,2)," ADDED"
 Q
 ;
D ; Delete a Site Selected Service Type Code
 N DIR,X,Y
 D FULL^VALM1
 S DIR(0)="S^"_$E(IBDIRS,2,$L(IBDIRS)),DIR("A")="Delete Service Type Code"
 D ^DIR
 F I=1:1:IBMAXSSC Q:$P(IBSTCSSX,U,I)=""  D
 . I $P(IBSTCSSX,U,I)'=X S IBTMPCT=IBTMPCT+1,$P(IBTMP,U,IBTMPCT)=$P(IBSTCSS,U,I)
 S IBSTCSS=IBTMP
 D SET
 I X'="^" W "..Deleted"
 Q
 ;
BLD ; Build screen and prompt for action
 N DIR,X,Y
 W @IOF,IORVON,"Service Type Codes",IORVOFF
 W !!,IOUON,"Default Service Type Codes",IOUOFF
 F IBFLD=1:1:IBMAXDSC D
 . S IBSTCR=^IBE(365.013,$P(IBSTCDF,U,IBFLD),0)
 . W:IBFLD#2=1 !
 . W:IBFLD#2=0 ?40 W $J($P(IBSTCR,U,1),2)," - ",$P(IBSTCR,U,2)
 W !!,IOUON,"Site Selected Service Type Codes",IOUOFF
 F IBFLD=1:1:IBMAXSSC D
 . S IBSTCIEN=$P(IBSTCSS,U,IBFLD)
 . I IBSTCIEN="" W !,"" Q
 . S IBSTCR=^IBE(365.013,IBSTCIEN,0)
 . W !,$J($P(IBSTCR,U,1),2)," - ",$P(IBSTCR,U,2)
 W !,IORVON,"          Enter ?? for more information                                         ",IORVOFF
 W !,"AS  Add a Service Type Code       DS  Delete a Service Type Code",!,"EX  Exit"
 S DIR("A")="Select Action: Exit//"
 S DIR(0)="SAO^AS:Add a Service Type Code from a list of available codes;DS:Delete a Service Type Code from a list of existing codes;EX:Exit^"
 S DIR("?")="^D HELP1^IBJPI5"
 S DIR("??")="^D HELP2^IBJPI5"
 D ACTN
 I $F("^E",X) Q
 I $F("AD",X) D @X
 G BLD
 ;
ACTN ;
 D ^DIR
 S X=$E(X,1),X=$TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 I '$F("^ADE",X) G ACTN
 ;
ERR(IBERVB) ; Display error 
 S DIR(0)="FAOU",DIR("A")=IBERVB_" - Enter <RETURN> to continue."
 D ^DIR
 Q
 ;
HELP1 ; Display actions in response to '?' entry
 D FULL^VALM1
 W @IOF
 Q
 ;
HELP2 ; Text to display in response to '??' entry
 N DIR
 D FULL^VALM1
 W @IOF
 W !,"The DEFAULT SERVICE TYPE CODES are not editable but defined by CBO."
 W !,"The SITE SELECTED SERVICE TYPE CODES are defined by each site and"
 W !,"are editable by authorized personnel of that site."
 W !,"Please do not use a DEFAULT SERVICE TYPE CODES as a SITE SELECTED"
 W !,"SERVICE TYPE CODE. Use only ACTIVE Service Type Codes which are"
 W !,"not DEFAULT SERVICE TYPE CODES as SITE SELECTED SERVICE TYPE CODES."
 W !,"Actions available are 'AS' to list and add codes or 'DS' to delete"
 W !,"codes. Enter '^' to quit."
 Q
