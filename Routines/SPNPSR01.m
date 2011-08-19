SPNPSR01 ;HIRMFO/DAD,WAA-HUNT: AGE ;8/1/95  14:16
 ;;2.0;Spinal Cord Dysfunction;**14**;01/02/1997
 ;
EN1(D0,BAGE,EAGE) ; *** Search entry point
 ; Input:
 ;  ACTION,SEQUENCE = Search ACTION,SEQUENCE number
 ;  D0       = SCD (SPINAL CORD) REGISTRY file (#154) IEN
 ;  ^TMP($J,"SPNPRT",ACTION,SEQUENCE,"BEGINNING AGE") = Age ^ Age
 ;  ^TMP($J,"SPNPRT",ACTION,SEQUENCE,"ENDING AGE") = Age ^ Age
 ;   SPNAGE = Patient age
 ; Output:
 ;  $S( D0_Meets_Search_Criteria : 1 , 1 : 0 )
 ;
 N AGE,DFN,I,MEETSRCH,VA,VADM,VAERR
 S MEETSRCH=0
 S DFN=+$P($G(^SPNL(154,+D0,0)),U)
 D DEM^VADPT
 I 'VAERR D
 . S AGE=$G(VADM(4))
 . I AGE'<BAGE,AGE'>EAGE S MEETSRCH=1
 . Q
 Q MEETSRCH
 ;
EN2(ACTION,SEQUENCE) ; *** Prompt entry point
 ; Input:
 ;  ACTION,SEQUENCE = Search ACTION,SEQUENCE number
 ; Output:
 ;  SPNLEXIT = $S( User_Abort/Timeout : 1 , 1 : 0 )
 ;  ^TMP($J,"SPNPRT",ACTION,SEQUENCE,"BEGINNING AGE") = Age ^ Age
 ;  ^TMP($J,"SPNPRT",ACTION,SEQUENCE,"ENDING AGE") = Age ^ Age
 ;..^TMP($J,"SPNPRT",ACTION,SEQUENCE,0) = $$EN1^SPNPSR01(D0,BAGE,EAGE)
 ;
 N AGE,DIR,DIRUT,DTOUT,DUOUT,I
 K ^TMP($J,"SPNPRT",ACTION,SEQUENCE),DIR
 S DIR(0)="NOA^1:130"
 S DIR("A")="Age range start value: "
 S DIR("?")="Enter a number from 1 to 130"
 D ^DIR S (AGE("BEGINNING AGE"),BAGE)=Y
 S SPNLEXIT=$S($D(DTOUT):1,$D(DUOUT):1,1:0)
 Q:BAGE=""  Q:BAGE="^"
 I 'SPNLEXIT D
 . K DIR S DIR(0)="NOA^"_$P(AGE("BEGINNING AGE"),U)_":130"
 . S DIR("A")="Age range end value:   "
 . S DIR("?")="Enter a number from "_$P(AGE("BEGINNING AGE"),U)_" to 130"
 . D ^DIR S (AGE("ENDING AGE"),EAGE)=Y
 . Q
 S SPNLEXIT=$S($D(DTOUT):1,$D(DUOUT):1,1:0)
 Q:EAGE=""
 I 'SPNLEXIT F I="BEGINNING AGE","ENDING AGE" D
 . S ^TMP($J,"SPNPRT",ACTION,SEQUENCE,0)="$$EN1^SPNPSR01(D0,"_BAGE_","_EAGE_")"
 . S ^TMP($J,"SPNPRT",ACTION,SEQUENCE,I)=$G(AGE(I))_U_$G(AGE(I))
 . Q
 Q
