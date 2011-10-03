DGPFLMAD ;ALB/KCL - PRF DISPLAY ASSIGNMENT DETAIL LM SCREEN ; 4/25/03 3:22pm
 ;;5.3;Registration;**425**;Aug 13, 1993
 ;
 ;no direct entry
 QUIT
 ;
EN ;Main entry point for DGPF RECORD FLAG DETAIL list template.
 ;
 ;  Input:
 ;     DGDFN - ien of PATIENT (#2) file
 ;     DGIEN - ien of PRF ASSIGNMENT (#26.13) file
 ;
 ; Output: None
 ;
 ;quit if required input parameters not defined
 Q:'$G(DGDFN)
 Q:'$G(DGIEN)
 ;
 ;display wait msg to user
 D WAIT^DICD
 ;
 ;invoke list manager and load list template
 D EN^VALM("DGPF ASSIGNMENT DETAIL")
 Q
 ;
 ;
HDR ;Header Code
 D BLDHDR^DGPFLMU(DGDFN,.VALMHDR)
 Q
 ;
 ;
INIT ;Init variables and list array
 D BLD
 Q
 ;
 ;
BLD ;Build record flag detail LM screen
 D CLEAN^VALM10
 K VALMHDR
 K ^TMP("DGPFDET",$J)
 ;
 ;init number of lines in list
 S VALMCNT=0
 ;
 ;build header
 D HDR
 ;
 ;build list area for record flag detail
 D EN^DGPFLMU1("DGPFDET",DGIEN,DGDFN,.VALMCNT)
 ;
 Q
 ;
 ;
HELP ;Help Code
 N X
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
 ;
EXIT ;Exit Code
 D CLEAN^VALM10
 D CLEAR^VALM1
 K ^TMP("DGPFDET",$J)
 Q
 ;
 ;
EXPND ;Expand Code
 Q
