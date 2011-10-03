GMRCSTAT ;SLC/DCM - List Manager Ancilliary routine - Restrict display of consults to a given status or satuses on List Manager Screen ;5/20/98  14:21
 ;;3.0;CONSULT/REQUEST TRACKING;**1**;DEC 27, 1997
 ;;This routine calles the appropriate routines to prompt for the status of consults to be printed in List Manager and call routines to collect that data
 ;;and reformat the List Manager global to print the data on the CRT.
EN ; -- main entry point for GMRCACTM CHANGE STATUS VIEW
 I $D(IOTM),$D(IOBM),$D(IOSTBM) D FULL^VALM1
 S GMRCQUIT=0
 D STS^GMRCSLM Q:GMRCQUIT  D AD^GMRCSLM1
 D INIT,HDR
 I $D(IOTM),$D(IOBM) S VALMBCK="R"
 D EXIT
 Q
 ;
HDR ; -- header code
 D HDR^GMRCSLM
 Q
 ;
INIT ; -- init variables and list array
 K ^TMP("GMRCR",$J,"LIST")
 S DSPLINE=0,VALMAR="^TMP(""GMRCR"",$J,""LIST"")"
 F LINE=1:1:LNCT S DSPLINE=$O(^TMP("GMRCR",$J,"CS",DSPLINE)) Q:DSPLINE=""!(DSPLINE?1A.E)  S DATA=^(DSPLINE,0) D SET^VALM10(LINE,DATA)
 S VALMBCK="R",VALMPGE=1,VALMBG=1,VALMLST=LNCT
 S VALMCNT=LNCT
 K DSPLINE,DATA,LINE
 Q
 ;
EXIT ;Kill off local variables and exit
 Q
