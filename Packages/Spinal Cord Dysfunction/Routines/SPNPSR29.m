SPNPSR29 ;SD/WDE/ Annual Rehab VA search ;04/14/2001
 ;;2.0;Spinal Cord Dysfunction;**15**;01/02/1997
 ;
EN1(D0,SPNFANN) ; *** Search entry point
 ; Input:
 ;  ACTION,SEQUENCE = Search ACTION,SEQUENCE number
 ;  D0       = SCD (SPINAL CORD) REGISTRY file (#154) IEN
 ;  ^TMP($J,"SPNPRT",ACTION,SEQUENCE,"ADDITIONAL CARE VA") = Internal ^ External
 ;  SPNFANN = Internal VALUE
 ; Output:
 ;  $S( D0_Meets_Search_Criteria : 1 , 1 : 0 )
 ;
 N DFN,MEETSRCH,SPNTEST,VA,VADM,VAERR
 S MEETSRCH=0
 ;
 ;
 S SPNTEST=$P($G(^SPNL(154,+D0,3)),U,3)
 I SPNTEST]"",SPNTEST=SPNFANN S MEETSRCH=1
 Q MEETSRCH
 ;
EN2(ACTION,SEQUENCE) ; *** Prompt entry point
 ; Input:
 ;  ACTION,SEQUENCE = Search ACTION,SEQUENCE number
 ; Output:
 ;  SPNLEXIT = $S( User_Abort/Timeout : 1 , 1 : 0 )
 ;  ^TMP($J,"SPNPRT",ACTION,SEQUENCE,"ANNUAL REHAB VA") = Internal ^ External
 ;  ^TMP($J,"SPNPRT",ACTION,SEQUENCE,0) = $$EN1^SPNPSR(D0,SPNTEST)
 ;
 N DIR,DIRUT,DTOUT,DUOUT
 K ^TMP($J,"SPNPRT",ACTION,SEQUENCE),DIR
 S DIR(0)="POA^4:AEMNQZ"
 S DIR("A")="Annual Rehab VA Facility: "
 S DIR("?")="Enter a Facility from the list shown"
 D ^DIR S SPNFANN=Y I Y<1 S SPNLEXIT=1 Q:Y<1
 S SPNLEXIT=$S($D(DTOUT):1,$D(DUOUT):1,1:0)
 I 'SPNLEXIT,Y'="" D
 . S ^TMP($J,"SPNPRT",ACTION,SEQUENCE,"ANNUAL REHAB VA")=SPNFANN
 . S ^TMP($J,"SPNPRT",ACTION,SEQUENCE,0)="$$EN1^SPNPSR29(D0,"""_$P(SPNFANN,U)_""")"
 Q
