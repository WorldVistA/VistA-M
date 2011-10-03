DGPFLMA ;ALB/KCL - PRF ASSIGNMENT LISTMAN SCREEN ; 4/24/03 4:34pm
 ;;5.3;Registration;**425**;Aug 13,1993
 ;
 ;
EN ;Main entry point for DGPF RECORD FLAG ASSIGNMENT option.
 ;
 ;  Input: None
 ; Output: None
 ;
 ;display wait msg to user
 D WAIT^DICD
 ;
 ;invoke list manager and load list template 
 D EN^VALM("DGPF RECORD FLAG ASSIGNMENT")
 Q
 ;
 ;
HDR ;Header Code
 S VALMHDR(1)="Patient: No Patient Selected"
 S VALMHDR(2)=""
 Q
 ;
 ;
INIT ;Init variables and list array
 N DGTEXT
 S DGTEXT="   A patient has not been selected.  Please select a patient."
 D SET^VALM10(1,"")
 D SET^VALM10(2,DGTEXT)
 D CNTRL^VALM10(2,4,$L(DGTEXT),$G(IOINHI),$G(IOINORM))
 S VALMCNT=2
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
 K DGDFN
 K DGPFA
 K DGPFAH
 D CLEAN^VALM10
 D CLEAR^VALM1
 Q
 ;
 ;
EXPND ;Expand Code
 Q
