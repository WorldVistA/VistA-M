SPNPSR03 ;HIRMFO/DAD,WAA-HUNT: RACE ;8/7/95  15:29
 ;;2.0;Spinal Cord Dysfunction;**18**;01/02/1997
 ;
EN1(D0,SPNRACE) ; *** Search entry point
 ; Input:
 ;  ACTION,SEQUENCE = Search ACTION,SEQUENCE number
 ;  D0       = SCD (SPINAL CORD) REGISTRY file (#154) IEN
 ;  ^TMP($J,"SPNPRT",ACTION,SEQUENCE,"RACE") = Internal ^ External
 ;  SPNRACE = Internal race
 ; Output:
 ;  $S( D0_Meets_Search_Criteria : 1 , 1 : 0 )
 ;
 N DFN,MEETSRCH,RACE,VA,VADM,VAERR
 S MEETSRCH=0
 S DFN=+$P($G(^SPNL(154,+D0,0)),U)
 D DEM^VADPT
 I 'VAERR D
 . S RACE=$P($G(VADM(12,1)),U)
 . I RACE]"",RACE=SPNRACE S MEETSRCH=1
 . Q
 Q MEETSRCH
 ;
EN2(ACTION,SEQUENCE) ; *** Prompt entry point
 ; Input:
 ;  ACTION,SEQUENCE = Search ACTION,SEQUENCE number
 ; Output:
 ;  SPNLEXIT = $S( User_Abort/Timeout : 1 , 1 : 0 )
 ;  ^TMP($J,"SPNPRT",ACTION,SEQUENCE,"RACE") = Internal ^ External
 ;  ^TMP($J,"SPNPRT",ACTION,SEQUENCE,0) = $$EN1^SPNPSR(D0,RACE)
 ;
 N DIR,DIRUT,DTOUT,DUOUT,RACE
 K ^TMP($J,"SPNPRT",ACTION,SEQUENCE),DIR
 S DIR(0)="POA^10:AEMNQZ"
 S DIR("A")="Patient race: "
 S DIR("?")="Enter a race from the list shown"
 D ^DIR S RACE=Y
 S SPNLEXIT=$S($D(DTOUT):1,$D(DUOUT):1,1:0)
 I 'SPNLEXIT,Y'="" D
 . S ^TMP($J,"SPNPRT",ACTION,SEQUENCE,"RACE")=RACE
 . S ^TMP($J,"SPNPRT",ACTION,SEQUENCE,0)="$$EN1^SPNPSR03(D0,"""_$P(RACE,U)_""")"
 Q
