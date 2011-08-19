DGPFLMQD ;ALB/RPM - PRF QUERY RESULTS DETAIL LM SCREEN ; 1/26/06 11:43
 ;;5.3;Registration;**650**;Aug 13, 1993;Build 3
 ;
 Q  ;no direct entry
 ;
EN(DGSET,DGORF) ;Main entry point for DGPF QUERY DETAIL list template.
 ;
 ;  Input:
 ;     DGSET - query result assignment ID
 ;     DGORF - array of parsed query results
 ;
 ; Output: None
 ;
 ;quit if required input parameters not defined
 Q:'$G(DGSET)
 Q:$G(DGORF)=""
 ;
 ;display wait msg to user
 D WAIT^DICD
 ;
 ;invoke list manager and load list template
 D EN^VALM("DGPF QUERY DETAIL")
 Q
 ;
 ;
HDR ;Header Code
 ;
 D BLDHDR^DGPFLMQ1(DGORF,.VALMHDR)
 Q
 ;
 ;
INIT ;Init variables and list array
 ;
 D BLD
 Q
 ;
 ;
BLD ;Build record flag detail LM screen
 ;
 D CLEAN^VALM10
 K VALMHDR
 K ^TMP("DGPFQDET",$J)
 ;
 ;init number of lines in list
 S VALMCNT=0
 ;
 ;build header
 D HDR
 ;
 ;build list area for record flag detail
 D EN^DGPFLMQ2("DGPFQDET",DGSET,.VALMCNT)
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
 K ^TMP("DGPFQDET",$J)
 Q
 ;
 ;
EXPND ;Expand Code
 Q
