DGPFLMQ ;ALB/RPM - PRF QUERY LISTMAN SCREEN ; 1/24/06 13:47
 ;;5.3;Registration;**650**;Aug 13,1993;Build 3
 ;
 Q  ;no direct entry
 ;
EN(DGORF) ;Main entry point for DGPF RECORD FLAG QUERY list.
 ;
 ;  Input: 
 ;    DGORF - parsed ORF segments data array
 ;    
 ; Output: None
 ;
 Q:$G(DGORF)=""
 ;
 ;display wait msg to user
 D WAIT^DICD
 ;
 ;invoke list manager and load list template 
 D EN^VALM("DGPF RECORD FLAG QUERY")
 Q
 ;
 ;
HDR ;Header Code
 D BLDHDR^DGPFLMQ1(DGORF,.VALMHDR) Q
 Q
 ;
INIT ;Init variables and list array
 D BLDLIST^DGPFLMQ1(DGORF)
 Q
 ;
HELP ;Help Code
 N X
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
 ;
EXIT ;Exit Code
 ;
 D CLEAN^VALM10
 D CLEAR^VALM1
 Q
 ;
 ;
EXPND ;Expand Code
 Q
