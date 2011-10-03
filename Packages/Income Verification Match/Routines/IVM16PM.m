IVM16PM ;HEC/KSD; Manual functions to fix some problems during BETA; ; 5/17/02 1:43pm
 ;;2.0;INCOME VERIFICATION;**34**;
 ;
COMPEND(QIEN) ;
 ; Complete Pending HL7 transmissions.  In the process of completing
 ; the HL7 transmission the transmission will also be removed from the
 ; outgoing queue.
 ;
 ;Input
 ;     QIEN = IEN OF THE LOGICAL LINK QUEUE
 ;
 W !
 S QIEN=$G(QIEN) Q:QIEN=""
 S F773="",CNT=0
 F  S F773=$O(^HLMA("AC","O",QIEN,F773)) Q:F773=""  D
 . S F773R1=$G(^HLMA(F773,"MSH",1,0))
 . Q:F773R1=""
 . S F772P1=+^HLMA(F773,0)
 . S F772R1=$G(^HL(772,F772P1,"IN",1,0))
 . I F772R1'="" D
 . . I ($P(F772R1,"^")="QRD")&($P(F772R1,"^",10)="OTH") D
 . . . S HLTCP=1
 . . . D STATUS^HLTF0(F773,3,,,1)
 . . . S CNT=CNT+1
 . . . S ^TMP($J,"ZZTEST2",F773)=""
 . . . S ^TMP($J,"ZZTEST2")=CNT
 . . . I '(CNT#100) W "."
 Q
 ;
DGENDT ;
 ; Date/Time fields in ^DGEN(27.12) were getting filled with 1.
 ; Change to be $$NOW^XLFDT.  Updating fields
 ; .02  DT/TM SENT
 ; .09  FIRST DT/TM
 S END=$P(^DGEN(27.12,0),"^",3),IEN=0
 F  S IEN=$O(^DGEN(27.12,IEN)) Q:IEN=END  D
 . S P01=$$GET1^DIQ(27.12,IEN,.01,"I")
 . I $$GET1^DIQ(27.12,IEN,.02,"I")=1 S DATA(.02)=$$NOW^XLFDT
 . I $$GET1^DIQ(27.12,IEN,.09,"I")=1 S DATA(.09)=$$NOW^XLFDT
 . I $D(DATA) D
 . . S DATA(.01)=P01
 . . S X=$$UPD^DGENDBS(27.12,IEN,.DATA)
FIXQ ;
 S IEN=""
 S DT=$P($$NOW^XLFDT,".")
 F  S IEN=$O(^DGEN(27.12,"ADS",1,IEN)) Q:IEN=""  D
 . S ^DGEN(27.12,"ADS",DT,IEN)=""
 . K ^DGEN(27.12,"ADS",1,IEN)
 Q
