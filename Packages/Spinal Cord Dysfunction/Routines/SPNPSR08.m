SPNPSR08 ;HIRMFO/DAD,WAA-HUNT: SCI LEVEL OF INJURY ;8/1/95  14:29
 ;;2.0;Spinal Cord Dysfunction;**12**;01/02/1997
 ;
EN1(D0,BNLOI,ENLOI) ; *** Search entry point
 ; Input:
 ;  ACTION,SEQUENCE = Search ACTION,SEQUENCE number
 ;  D0       = SCD (SPINAL CORD) REGISTRY file (#154) IEN
 ;  ^TMP($J,"SPNPRT",ACTION,SEQUENCE,"BEGINNING SCI LEVEL") = NLOI# ^NLOI
 ;  ^TMP($J,"SPNPRT",ACTION,SEQUENCE,"ENDING SCI LEVEL") = NLOI# ^ NLOI
 ;    BNLOI = Beginning NLOI
 ;    ENLOI = Ending NLOI
 ; Output:
 ;  $S( D0_Meets_Search_Criteria : 1 , 1 : 0 )
 ;
 N DFN,I,MEETSRCH,NLOI
 S MEETSRCH=0
 S NLOI=$$NLOI($P($G(^SPNL(154,D0,2)),U))
 I NLOI'<BNLOI,NLOI'>ENLOI S MEETSRCH=1
 Q MEETSRCH
 ;
EN2(ACTION,SEQUENCE) ; *** Prompt entry point
 ; Input:
 ;  ACTION,SEQUENCE = Search ACTION,SEQUENCE number
 ; Output:
 ;  SPNLEXIT = $S( User_Abort/Timeout : 1 , 1 : 0 )
 ;  ^TMP($J,"SPNPRT",ACTION,SEQUENCE,"BEGINNING SCI LEVEL") = NLOI# ^NLOI
 ;  ^TMP($J,"SPNPRT",ACTION,SEQUENCE,"ENDING SCI LEVEL") = NLOI# ^ NLOI
 ;  ^TMP($J,"SPNPRT",ACTION,SEQUENCE,0) = $$EN1^SPNPSR08(D0,BNLOI,ENLOI)
 ;
 N DIR,DIRUT,DTOUT,DUOUT,I,NLOI
 K ^TMP($J,"SPNPRT",ACTION,SEQUENCE),DIR
 S DIR(0)="POA^154.01:AEMNQZ"
 S DIR("A")="SCI Level start value: "
 S DIR("?")="Enter the top-most vertebral level desired"
 D ^DIR S NLOI("BEGINNING SCI LEVEL")=Y,BNLOI=$$NLOI(Y)
 S SPNLEXIT=$S($D(DTOUT):1,$D(DUOUT):1,1:0)
 I 'SPNLEXIT D
 . K DIR S DIR(0)="POA^154.01:AEMNQZ^K:$$NLOI^SPNPSR08(Y)<$$NLOI^SPNPSR08(NLOI(""BEGINNING SCI LEVEL"")) X"
 . S DIR("A")="SCI Level end value:   "
 . S DIR("?")="Enter the bottom-most vertebral level desired"
 . D ^DIR S NLOI("ENDING SCI LEVEL")=Y I Y'="" S ENLOI=$$NLOI(Y)
 . Q
 S SPNLEXIT=$S($D(DTOUT):1,$D(DUOUT):1,1:0)
 I 'SPNLEXIT,Y'="" D 
 . F I="BEGINNING SCI LEVEL","ENDING SCI LEVEL" S ^TMP($J,"SPNPRT",ACTION,SEQUENCE,I)=$$NLOI(NLOI(I))_U_$P(NLOI(I),U,2)
 . S ^TMP($J,"SPNPRT",ACTION,SEQUENCE,0)="$$EN1^SPNPSR08(D0,"_BNLOI_","_ENLOI_")"
 . Q
 Q
NLOI(D0) ; *** Convert NLOI to number
 ; Input:
 ;  D0 = SCD NLOI CATEGORY file (#154.01) IEN
 ; Output:
 ;  Cervical=1, Thoracic=2, Lumbar=3, Sacral=4, Unknown=999
 ;  e.g., T05 ==> 205
 N X S X=$P($G(^SPNL(154.01,+D0,0)),U)
 Q $S(X="UNK":999,X?1U2N:$TR(X,"CTLS","1234"),1:0)
