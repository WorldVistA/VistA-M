DGPFLF ;ALB/KCL - PRF FLAG MANAGEMENT LM SCREEN ; 3/10/03
 ;;5.3;Registration;**425**;Aug 13, 1993
 ;
 ;- no direct entry
 QUIT
 ;
EN ;Main entry point for DGPF RECORD FLAG MANAGEMENT option.
 ;
 ;  Input: None
 ; Output: None
 ;
 ;- invoke DGPF RECORD FLAG MANAGEMENT list template
 D EN^VALM("DGPF RECORD FLAG MANAGEMENT")
 Q
 ;
 ;
HDR ;Header Code
 ;
 N DGHDR
 S VALMHDR(1)="Flag Category: "_$S(DGCAT=1:"I (National)",DGCAT=2:"II (Local)",1:"Unknown")
 S DGHDR="Sorted By: "_$S(DGSRTBY="N":"Flag Name",DGSRTBY="T":"Flag Type",1:"Unknown")
 S VALMHDR(1)=$$SETSTR^VALM1(DGHDR,VALMHDR(1),57,$L(DGHDR))
 Q
 ;
 ;
INIT ;Init variables and list array
 ;
 ;- init flag categorey to list (default=National)
 S DGCAT=1
 ;
 ;init list sort by criteria (default=Flag Name)
 S DGSRTBY="N"
 ;
 ;build record flag list area
 D BLD
 ;
 Q
 ;
 ;
BLD ;Build record flag screen (list area)
 ;
 D CLEAN^VALM10
 K DGARY,VALMHDR
 K ^TMP("DGPFSORT",$J)
 ;
 ;- init array that will contain list of items to display
 S DGARY="DGPFLAG"
 K ^TMP(DGARY,$J)
 ;
 ;init # of lines in list
 S VALMCNT=0
 ;
 ;build header area
 D HDR
 ;
 ;build list area for flag screen
 D EN^DGPFLF1(DGARY,DGCAT,DGSRTBY,.VALMCNT)
 ;
 Q
 ;
 ;
HELP ;Help Code
 ;
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
 ;
EXIT ;Exit Code
 ;
 D CLEAN^VALM10
 D CLEAR^VALM1
 K DGCAT
 K DGSRTBY
 K ^TMP("DGPFSORT",$J)
 K ^TMP(DGARY,$J)
 K ^TMP(DGARY,"IDX",$J)
 K DGARY
 Q
 ;
 ;
EXPND ;Expand Code
 Q
