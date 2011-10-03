DGPFLMT ;ALB/RBS - PRF TRANSMISSION ERRORS LM SCREEN ; 4/27/05 12:00pm
 ;;5.3;Registration;**650**;Aug 13, 1993;Build 3
 ;
 ;- no direct entry
 QUIT
 ;
 ;
EN ;Main entry point for DGPF TRANSMISSION ERRORS option.
 ;
 ;  Input: None
 ; Output: None
 ;
 ;invoke DGPF TRANSMISSION ERRORS list template
 N DGSRTBY
 ;- sort list (default="N"=Patient Name, also "E"=Date Error Received)
 S DGSRTBY="N"
 ;
 D EN^VALM("DGPF TRANSMISSION ERRORS")
 Q
 ;
 ;
HDR ;Header Code
 N DGHDR
 S DGHDR="List Sorted By: "_$S($G(DGSRTBY)="N":"Patient Name",1:"Date Error Received")
 S VALMHDR(1)=""
 S VALMHDR(1)=$$SETSTR^VALM1(DGHDR,VALMHDR(1),1,$L(DGHDR))
 Q
 ;
 ;
INIT ;Init variables and list array
 D BLD
 Q
 ;
 ;
BLD ;Build HL7 Transmission Log "RJ" Rejected Status message list
 D CLEAN^VALM10
 K DGARY,VALMHDR
 K ^TMP("DGPFSORT",$J)
 ;
 ;- init array that will contain list of items to display
 S DGARY="DGPFLMT"
 K ^TMP(DGARY,$J)
 ;
 ;build header area
 D HDR
 ;
 ;init # of lines in list
 S VALMCNT=0
 ;
 ;- call to build list area for error messages
 D EN^DGPFLMT1(DGARY,DGSRTBY,.VALMCNT)
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
 K ^TMP("DGPFSORT",$J)
 K ^TMP(DGARY,$J)
 K DGARY
 K DGSRTBY
 Q
 ;
 ;
EXPND ;Expand Code
 Q
