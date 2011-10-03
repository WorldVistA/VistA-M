DGPFLMD ;ALB/RPM - PRF DISPLAY ACTIVE FLAG ASSIGNMENTS LM ; 5/20/03 2:49pm
 ;;5.3;Registration;**425**;Aug 13, 1993
 ;
 ;no direct entry
 QUIT
 ;
EN(DGDFN,DGPFAPI) ;DGPF ACTIVE ASSIGNMENTS list template main entry point
 ;
 ;  Input:
 ;      DGDFN - IEN of record in PATIENT (#2) file
 ;    DGPFAPI - data array of active patient record flag assignments
 ;
 ; Output: None
 ;
 ;
 ;quit if required input not defined
 Q:+$G(DGDFN)'>0
 Q:'$D(DGPFAPI)
 ;
 ;display wait msg to user
 D WAIT^DICD
 ;
 ;invoke DISPLAY list template
 D EN^VALM("DGPF ACTIVE ASSIGNMENTS")
 Q
 ;
 ;
HDR ;Header Code
 ;
 D BLDHDR^DGPFLMU(DGDFN,.VALMHDR)
 S VALMHDR(3)=" "
 S VALMHDR(4)=$$CJ^XLFSTR("<<< Active Patient Record Flag Assignments >>>",80)
 Q
 ;
 ;
INIT ;Init variables and list array
 ;
 D BLD
 ;
 Q
 ;
 ;
BLD ;Build flag detail screen (list area)
 ;
 D CLEAN^VALM10
 K VALMHDR
 K ^TMP("DGPFACT",$J)
 ;
 ;init number of lines in list
 S VALMCNT=0
 ;
 ;build header
 D HDR
 ;
 ;build list area for flag detail
 D EN^DGPFLMD1("DGPFACT",.DGPFAPI,.VALMCNT)
 ;
 Q
 ;
 ;
HELP ;Help Code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
 ;
EXIT ;Exit Code
 ;
 D CLEAN^VALM10
 D CLEAR^VALM1
 K ^TMP("DGPFACT",$J)
 Q
 ;
 ;
EXPND ;Expand Code
 Q
