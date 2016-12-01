ECDSSSNR ;ALB/DAN - DSS units set to send no records report ;10/15/15  15:56
 ;;2.0;EVENT CAPTURE;**131**;8 May 96;Build 13
 ;
START ;
 N NAME,UNIT,CNT,DSS0
 S CNT=1
 S NAME="" F  S NAME=$O(^ECD("B",NAME)) Q:NAME=""  S UNIT=0 F  S UNIT=$O(^ECD("B",NAME,UNIT)) Q:'+UNIT  D
 .S DSS0=$G(^ECD(UNIT,0))
 .I $P(DSS0,U,6) Q  ;Unit is inactive
 .I $P(DSS0,U,14)'="N" Q  ;Only report units with send to pce set to send no records ("N")
 .S CNT=CNT+1
 .S ^TMP($J,"ECRPT",CNT)=UNIT_U_NAME_U_$$GET1^DIQ(40.7,$P(DSS0,U,10)_",",1)_U_$$GET1^DIQ(40.7,$P(DSS0,U,13)_",",1)_U_$$GET1^DIQ(728.441,$P(DSS0,U,15),.01) ;Store DSS unit data
 I $G(ECPTYP)="E" S ^TMP($J,"ECRPT",1)="DSS UNIT IEN^DSS UNIT NAME^STOP CODE^CREDIT STOP^CHAR4" Q  ;If exporting, create header line
 ;
PRINT ; Display results
 N RDATE,LINE,NUM,PAGE
 U IO
 S RDATE=$$FMTE^XLFDT($E($$NOW^XLFDT,1,12),"5P")
 D HDR
 I '$D(^TMP($J,"ECRPT")) W !,"No active DSS units are set to Send No Records." Q  ;Nothing to report
 S NUM=1
 F  S NUM=$O(^TMP($J,"ECRPT",NUM)) Q:'+NUM  D
 .S LINE=^TMP($J,"ECRPT",NUM)
 .W !,$P(LINE,U,2)_" ("_$P(LINE,U)_")",?50,$P(LINE,U,3)_"/"_$P(LINE,U,4)_"/"_$P(LINE,U,5)
 .I $Y>(IOSL-4) D HDR
 Q
 ;
HDR ;Display header for report
 W @IOF
 S PAGE=$G(PAGE)+1
 W "DSS UNITS SET TO SEND NO RECORDS TO PCE",?41,"Run date:",RDATE,?72,"Page:",PAGE
 W !!,"DSS UNIT NAME (IEN)",?50,"STOP CODE/CREDIT STOP/CHAR4",!,$$REPEAT^XLFSTR("-",80),!
 Q
