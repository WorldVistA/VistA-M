ECRUDSS ;ALB/DAN - DSS unit access by user report ;11/22/11  17:00
 ;;2.0;EVENT CAPTURE;**112**;8 May 96;Build 18
 ;
STRPT ;Main entry point for report
 N IEN,CNT,UNIT
 K ^TMP($J,"ECRUDSS") ;Temporary storage of information
 U IO
 S IEN=ECDUZ
 S UNIT=0 F  S UNIT=$O(^VA(200,IEN,"EC","B",UNIT)) Q:'+UNIT  S ^TMP($J,"ECRUDSS",$$GET1^DIQ(724,UNIT,".01"))=""
 I ECPTYP="E" D  Q  ;Put into parsable format
 .S CNT=0,UNIT=""
 .S CNT=CNT+1,^TMP($J,"ECRPT",CNT)="NAME^IEN^PERSON CLASS/CLASSIFICATION^DSS UNIT"
 .F  S UNIT=$O(^TMP($J,"ECRUDSS",UNIT)) Q:UNIT=""  S CNT=CNT+1 S:CNT=2 ^TMP($J,"ECRPT",CNT)=$$GET1^DIQ(200,IEN,".01")_U_IEN_U_$P($$GET^XUA4A72(IEN,DT),U,3) S $P(^TMP($J,"ECRPT",CNT),U,4)=UNIT
 .K ^TMP($J,"ECRUDSS")
 ;
 D HDR
 S UNIT=""
 W $$GET1^DIQ(200,IEN,".01"),?32,IEN,?46,$E($P($$GET^XUA4A72(IEN,DT),U,3),1,52)
 F  S UNIT=$O(^TMP($J,"ECRUDSS",UNIT)) Q:UNIT=""  D
 .W ?100,UNIT,!
 .I (IOSL-$Y)<5 W @IOF D HDR
 K ^TMP($J,"ECRUDSS")
 Q
 ;
HDR ;Print header for report
 W !,"DSS Unit access by selected user",?$S($G(IOM):(IOM-18),1:62),$$FMTE^XLFDT($$NOW^XLFDT,"1M"),!!
 W "USER NAME",?32,"IEN",?46,"PERSON CLASS/CLASSIFICATION",?100,"DSS UNIT",!,$$REPEAT^XLFSTR("-",$S($G(IOM):IOM,1:132)),!
 Q
