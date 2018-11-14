DGPFLMT ;ALB/RBS - PRF TRANSMISSION ERRORS LM SCREEN ; 4/27/05 12:00pm
 ;;5.3;Registration;**650,960**;Aug 13, 1993;Build 22
 ; Last Edited: SHRPE/SGM - May 30, 2018 11:01
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
 N DGSORT,DGSRTBY
 S DGSRTBY="N"
 Q:'$$PROMPT
 ;
 D EN^VALM("DGPF TRANSMISSION ERRORS")
 Q
 ;
 ;
HDR ;Header Code
 N X,Y
 S Y=$S($G(DGSORT("BY"))="N":"Patient Name",1:"Date Error Received")
 S X="List Sorted By: "_Y
 S VALMHDR(2)=""
 S VALMHDR(2)=$$SETSTR^VALM1(X,VALMHDR(2),1,$L(X))
 S Y=$G(DGSORT("FLAG")) S:Y="" Y="A"
 S X="Active, Locally-Owned, Category I Flag"
 S X=X_$S(Y="A":"s:  ALL",1:":  "_$P(Y,U,2))
 S VALMHDR(1)=""
 S VALMHDR(1)=$$SETSTR^VALM1(X,VALMHDR(1),1,$L(X))
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
 S:$G(DGSRTBY)="" DGSRTBY="N" S DGSORT("BY")=DGSRTBY
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
 D EN^DGPFLMT1(DGARY,DGSORT("BY"),.VALMCNT)
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
 Q
 ;
 ;
EXPND ;Expand Code
 Q
 ;
PROMPT() ; ----- prompts before LM invoked
 ;  Set local variables to be available throughout the LM actions
 ;  I '$$PROMPT then quit the Option
 ;  DGSORT("BY")   = "N"
 ;  DGSORT("FLAG") = "A" or variable_pointer^flagname
 ;  DGSORT("STAT") = 1 - active assignments
 ;  DGSORT("OWN")  = 1 - OWNER SITE is from local facility
 ;
 N X,Y
 ;-- sort list (default="N"=Patient Name, also "E"=Date Error Received)
 S DGSORT("BY")=DGSRTBY
 ;
 ;-- prompt for all flags or single flag
 ;-- prompt for selection of a single flag or all flags
 ;   DGSORT("FLAG") = "A" or a flag variable pointer
 ;   list (A)ll flags if user selects Both Category's
 S X=$P($$FLAG^DGPFUT7,U) I X'="A",X'="S" Q 0
 S DGSORT("FLAG")=X
 ;
 ;   if single flag, now prompt for name of flag
 I DGSORT("FLAG")="S" D  I X<1 Q 0
 . S X=$$ONEFLAG^DGPFUT7("I",0) I X>0 S DGSORT("FLAG")=X
 . Q
 ;
 ;-- setup filters, allow only active, locally owned assignments
 S DGSORT("OWN")=1
 S DGSORT("STAT")=1
 ;
 Q 1
