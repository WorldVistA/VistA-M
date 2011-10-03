ORLPSRA ;SLC/RAF - Continuation of ORLPSR ; 3/31/08 6:24am
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**243**;Dec 17, 1997;Build 242
 ;
LOOP ;called from ORLPSR
 ;goes thru the "ALPS" xref in 100 for order dates - called from ORLPSR
 S RPDT="""Report Date: "",$$FMTE^XLFDT($$NOW^XLFDT),""  Sort Range From: "",SDT,""   To: "",EDT",STOP=0
 S PAT="" F  S PAT=$O(^OR(100,"ALPS",PAT)) Q:'PAT!STOP  D
 .Q:$P(^DPT(+PAT,0),U,21)  ;Quit if test patient
 .S DATE=0 F  S DATE=$O(^OR(100,"ALPS",PAT,DATE)) Q:'DATE!STOP  I DATE>SDATE,DATE<EDATE D
 ..S IEN=0 F  S IEN=$O(^OR(100,"ALPS",PAT,DATE,IEN)) Q:'IEN!STOP  D
 ...S SUB=0 F  S SUB=$O(^OR(100,"ALPS",PAT,DATE,IEN,SUB)) Q:'SUB!STOP  D
 ....I $D(^OR(100,IEN,8,SUB,0)) D
 .....;W !,DATE
 .....;I TYPE=1 Q:+$P(^(0),U,15)=11
 .....;I TYPE=3 Q:+$P(^(0),U,15)'=11
 .....N LTYPE S LTYPE=$G(^OR(100,"ALPS",PAT,DATE,IEN,SUB))
 .....I LTYPE="DELAYED ORDER" S LTYPE="DO"
 .....N LDATE S LDATE=""
 .....S (LOC,DIV)="**DELAYED ORDER/NOT ENTERED" ;Reset values as delayed orders may not have these values yet
 .....I $D(^VA(200,+$P(^OR(100,IEN,8,SUB,0),U,3),0)) S PROV=$$USER^ORLPSR(+$P(^OR(100,IEN,8,SUB,0),U,3))
 .....I $D(^VA(200,+$P(^OR(100,IEN,8,SUB,0),U,3),5)),$L($P(^(5),U)) S SER=$$SER^ORLPSR(+$P(^VA(200,+$P(^OR(100,IEN,8,SUB,0),U,3),5),U))
 .....E  S SER="MISSING from file 200"
 .....I $D(^VA(200,+$P(^OR(100,IEN,8,SUB,0),U,13))) S WHO=$$USER^ORLPSR(+$P(^OR(100,IEN,8,SUB,0),U,13))
 .....I $G(^OR(100,IEN,6)) I $P(^(6),U)=9&($P(^(6),U,5)="AUTO DC") S WHO=$$USER^ORLPSR(+$P(^OR(100,IEN,8,1,0),U,13)) ;If DCd nature is auto and text is auto dc set entered by to original entry person
 .....S DFN=+$P(^OR(100,IEN,0),U,2) D DEM^VADPT S SSN=VA("BID"),PNM=$E(VADM(1),1,24)
 .....I $D(^OR(100,IEN,3)),$P(^(3),U,3) S STATUS=$$STAT^ORLPSR(+$P(^(3),U,3))
 .....I $D(^OR(100,IEN,0)),$P(^(0),U,10) S LOC=$$LOC^ORLPSR(+$P(^(0),U,10))
 .....I $D(^OR(100,IEN,0)),$P(^(0),U,10) S DIV=$$DIV^ORLPSR(+$P(^(0),U,10))
 .....I $D(^OR(100,IEN,8,SUB,0)),$P(^(0),U) S WHEN=$$FMTE^XLFDT($P($P(^(0),U),"."))
 .....I $D(^OR(100,IEN,10)),$P(^(10),U) S LDATE=$$FMTE^XLFDT($P($P(^(10),U),"."))
 .....I $L(LTYPE) S STATUS=STATUS_"("_LTYPE_")"
 .....I SORT=1 S ^TMP("ORUNS",$J,SER,PROV,IEN)=SER_U_PROV_U_WHO_U_PNM_U_SSN_U_STATUS_U_IEN_U_WHEN_U_LDATE
 .....I SORT=2 S ^TMP("ORUNS",$J,PROV,PNM,IEN)=PROV_U_WHO_U_PNM_U_SSN_U_STATUS_U_IEN_U_WHEN_U_LDATE
 .....I SORT=3 S ^TMP("ORUNS",$J,PNM,PROV,IEN)=PNM_U_SSN_U_PROV_U_WHO_U_STATUS_U_IEN_U_WHEN_U_LDATE
 .....I SORT=4 S ^TMP("ORUNS",$J,LOC,PROV,IEN)=LOC_U_PROV_U_WHO_U_PNM_U_SSN_U_STATUS_U_IEN_U_WHEN_U_LDATE
 .....I SORT=5 S ^TMP("ORUNS",$J,WHO,PNM,IEN)=WHO_U_PROV_U_PNM_U_SSN_U_STATUS_U_IEN_U_WHEN_U_LDATE
 .....I SORT=6 S ^TMP("ORUNS",$J,DIV,LOC,PROV,IEN)=DIV_U_LOC_U_PROV_U_WHO_U_PNM_U_SSN_U_STATUS_U_IEN_U_WHEN_U_LDATE
PROV ;loops thru the TMP global for output sort by provider
 I SORT=2&('$D(LONER)) D
 .I TYPE=1 S HDR="!!?30,""List of RELEASED but UNSIGNED orders by PROVIDER"""
 .I TYPE=2 S HDR="!!?40,""List of LAPSED orders by PROVIDER"""
 .I TYPE=3 S HDR="!!?30,""List of UNSIGNED/UNRELEASED orders by PROVIDER"""
 .S HDR1="!!,""PROVIDER"",?25,""ENTERED BY"",?50,""PATIENT"",?75,""SSN"",?81,""STATUS"",?91,""ORDER #"",?104,""ORDER DATE"",?118,""LAPSE DATE"""
 .S PAGE=0 D HDR^ORLPSR
 .I '$D(^TMP("ORUNS",$J)) W !,"No lapsed orders found" Q
 .S PROV="" F  S PROV=$O(^TMP("ORUNS",$J,PROV)) Q:PROV=""!STOP  D
 ..S PNM="" F  S PNM=$O(^TMP("ORUNS",$J,PROV,PNM)) S CNT=0 Q:PNM=""!STOP  D
 ...S IEN=0 F  S IEN=$O(^TMP("ORUNS",$J,PROV,PNM,IEN)) S CNT=CNT+1 Q:'IEN!STOP  D
 ....I 'SUMONLY W $P(^(IEN),U),?25,$P(^(IEN),U,2),?50,$P(^(IEN),U,3),?75,$P(^(IEN),U,4),?81,$P(^(IEN),U,5),?91,$P(^(IEN),U,6),?104,$P(^(IEN),U,7),?118,$P(^(IEN),U,8),! D:$Y>(IOSL-4) HDR^ORLPSR Q:STOP
 ....S ^TMP("ORSTATS",$J,PROV,PNM)=CNT
SPROV ;sorts for a single provider
 I SORT=2&($D(LONER)) S LONER="",PAGE=0 F  S LONER=$O(LONER(LONER)) Q:LONER=""!STOP  D
 .I TYPE=1 S HDR="!!?30,""List of RELEASED but UNSIGNED orders for "",LONER"
 .I TYPE=2 S HDR="!!?30,""List of LAPSED orders for "",LONER"
 .I TYPE=3 S HDR="!!?30,""List of UNSIGNED/UNRELEASED orders for "",LONER"
 .S HDR1="!!,""PROVIDER"",?25,""ENTERED BY"",?50,""PATIENT"",?75,""SSN"",?81,""STATUS"",?91,""ORDER #"",?104,""ORDER DATE"",?118,""LAPSE DATE"""
 .D HDR^ORLPSR
 .S PROV=LONER I $D(^TMP("ORUNS",$J,PROV)) D
 ..S PNM="" F  S PNM=$O(^TMP("ORUNS",$J,PROV,PNM)) S CNT=0 Q:PNM=""!STOP  D
 ...S IEN=0 F  S IEN=$O(^TMP("ORUNS",$J,PROV,PNM,IEN)) S CNT=CNT+1 Q:'IEN!STOP  D
 ....I 'SUMONLY W $P(^(IEN),U),?25,$P(^(IEN),U,2),?50,$P(^(IEN),U,3),?75,$P(^(IEN),U,4),?81,$P(^(IEN),U,5),?91,$P(^(IEN),U,6),?104,$P(^(IEN),U,7),?118,$P(^(IEN),U,8),! D:$Y>(IOSL-4) HDR^ORLPSR Q:STOP
 ....S ^TMP("ORSTATS",$J,PROV,PNM)=CNT
 .I '$D(^TMP("ORUNS",$J,PROV)) W !!,"No lapsed orders found for "_LONER
PAT ;loops thru the TMP global for output sort by patient
 I SORT=3&('$D(LONER)) D
 .I TYPE=1 S HDR="!!?30,""List of RELEASED but UNSIGNED orders by PATIENT"""
 .I TYPE=2 S HDR="!!?40,""List of LAPSED orders by PATIENT"""
 .I TYPE=3 S HDR="!!?30,""List of UNSIGNED/UNRELEASED orders by PATIENT"""
 .S HDR1="!!,""PATIENT"",?25,""SSN"",?30,""PROVIDER"",?55,""ENTERED BY"",?81,""STATUS"",?91,""ORDER #"",?104,""ORDER DATE"",?118,""LAPSE DATE"""
 .S PAGE=0 D HDR^ORLPSR
 .I '$D(^TMP("ORUNS",$J)) W !,"No lapsed orders found" Q
 .S PNM="" F  S PNM=$O(^TMP("ORUNS",$J,PNM)) Q:PNM=""!STOP  D
 ..S PROV="" F  S PROV=$O(^TMP("ORUNS",$J,PNM,PROV)) S CNT=0 Q:PROV=""!STOP  D
 ...S IEN=0 F  S IEN=$O(^TMP("ORUNS",$J,PNM,PROV,IEN)) S CNT=CNT+1 Q:'IEN!STOP  D
 ....I 'SUMONLY W $P(^(IEN),U),?25,$P(^(IEN),U,2),?30,$P(^(IEN),U,3),?55,$P(^(IEN),U,4),?81,$P(^(IEN),U,5),?91,$P(^(IEN),U,6),?104,$P(^(IEN),U,7),?118,$P(^(IEN),U,8),! D:$Y>(IOSL-4) HDR^ORLPSR Q:STOP
 ....S ^TMP("ORSTATS",$J,PNM,PROV)=CNT
 ....;I $E(IOST)="E",$Y>(IOSL-105) W @IOF,@HDR
SPAT ;sorts for a single patient
 I SORT=3&($D(LONER)) S LONER="",PAGE=0 F  S LONER=$O(LONER(LONER)) Q:LONER=""!STOP  D
 .I TYPE=1 S HDR="!!?30,""List of RELEASED but UNSIGNED orders for "",LONER"
 .I TYPE=2 S HDR="!!?30,""List of LAPSED orders for "",LONER"
 .I TYPE=3 S HDR="!!?30,""List of UNSIGNED/UNRELEASED orders for "",LONER"
 .S HDR1="!!,""PATIENT"",?25,""SSN"",?30,""PROVIDER"",?55,""ENTERED BY"",?81,""STATUS"",?91,""ORDER #"",?104,""ORDER DATE"",?118,""LAPSE DATE"""
 .D HDR^ORLPSR
 .S PNM=LONER I $D(^TMP("ORUNS",$J,PNM)) D
 ..S PROV="" F  S PROV=$O(^TMP("ORUNS",$J,PNM,PROV)) S CNT=0 Q:PROV=""!STOP  D
 ...S IEN=0 F  S IEN=$O(^TMP("ORUNS",$J,PNM,PROV,IEN)) S CNT=CNT+1 Q:'IEN!STOP  D
 ....I 'SUMONLY W $P(^(IEN),U),?25,$P(^(IEN),U,2),?30,$P(^(IEN),U,3),?55,$P(^(IEN),U,4),?81,$P(^(IEN),U,5),?91,$P(^(IEN),U,6),?104,$P(^(IEN),U,7),?118,$P(^(IEN),U,8),! D:$Y>(IOSL-4) HDR^ORLPSR Q:STOP
 ....S ^TMP("ORSTATS",$J,PNM,PROV)=CNT
 .I '$D(^TMP("ORUNS",$J,PNM)) W !!,"No lapsed orders found for "_LONER
WARD ;loops thru the TMP global for output sort by location
 I SORT=4&('$D(LONER)) D
 .I TYPE=1 S HDR="!!?30,""List of RELEASED but UNSIGNED orders by LOCATION"""
 .I TYPE=2 S HDR="!!?30,""List of LAPSED orders by LOCATION"""
 .I TYPE=3 S HDR="!!?30,""List of UNSIGNED/UNRELEASED orders by LOCATION"""
 .S HDR1="!!,""PROVIDER"",?25,""ENTERED BY"",?50,""PATIENT"",?75,""SSN"",?81,""STATUS"",?91,""ORDER #"",?104,""ORDER DATE"",?118,""LAPSE DATE"""
 .S PAGE=0 D HDR^ORLPSR
 .I '$D(^TMP("ORUNS",$J)) W !,"No lapsed orders found" Q
 .S LOC="" F  S LOC=$O(^TMP("ORUNS",$J,LOC)) Q:LOC=""!STOP  W:'SUMONLY "Location: ",LOC,! D
 ..S PROV="" F  S PROV=$O(^TMP("ORUNS",$J,LOC,PROV)) S CNT=0 Q:PROV=""!STOP  D
 ...S IEN=0 F  S IEN=$O(^TMP("ORUNS",$J,LOC,PROV,IEN)) S CNT=CNT+1 Q:'IEN!STOP  D
 ....I 'SUMONLY W $P(^TMP("ORUNS",$J,LOC,PROV,IEN),U,2),?25,$P(^(IEN),U,3),?50,$P(^(IEN),U,4),?75,$P(^(IEN),U,5),?81,$P(^(IEN),U,6),?91,$P(^(IEN),U,7),?104,$P(^(IEN),U,8),?118,$P(^(IEN),U,9),! D:$Y>(IOSL-4) HDR^ORLPSR Q:STOP
 ....S ^TMP("ORSTATS",$J,LOC,PROV)=CNT
 ..W !
 ;
SWARD ;sorts for a single location
 I SORT=4&($D(LONER)) S LONER="",PAGE=0 F  S LONER=$O(LONER(LONER)) Q:LONER=""!STOP  D
 .I TYPE=1 S HDR="!!?30,""List of RELEASED but UNSIGNED orders for "",LONER"
 .I TYPE=2 S HDR="!!?30,""List of LAPSED orders for "",LONER"
 .I TYPE=3 S HDR="!!?30,""List of UNSIGNED/UNRELEASED orders for "",LONER"
 .S HDR1="!!,""PROVIDER"",?25,""ENTERED BY"",?50,""PATIENT"",?75,""SSN"",?81,""STATUS"",?91,""ORDER #"",?104,""ORDER DATE"",?118,""LAPSE DATE"""
 .D HDR^ORLPSR
 .S LOC=LONER I $D(^TMP("ORUNS",$J,LOC)) D
 ..S PROV="" F  S PROV=$O(^TMP("ORUNS",$J,LOC,PROV)) S CNT=0 Q:PROV=""!STOP  D
 ...S IEN=0 F  S IEN=$O(^TMP("ORUNS",$J,LOC,PROV,IEN)) S CNT=CNT+1 Q:'IEN!STOP  D
 ....I 'SUMONLY W $P(^TMP("ORUNS",$J,LOC,PROV,IEN),U,2),?25,$P(^(IEN),U,3),?50,$P(^(IEN),U,4),?75,$P(^(IEN),U,5),?81,$P(^(IEN),U,6),?91,$P(^(IEN),U,7),?104,$P(^(IEN),U,8),?118,$P(^(IEN),U,9),! D:$Y>(IOSL-4) HDR^ORLPSR Q:STOP
 ....S ^TMP("ORSTATS",$J,LOC,PROV)=CNT
 .I '$D(^TMP("ORUNS",$J,LOC)) W !!,"No lapsed orders found for "_LONER
 I SORT=1 D SERV^ORLPSRB
 I SORT=5 D WHO^ORLPSRB
 I SORT=6 D DIV^ORLPSRB
 I 'STOP D STATS^ORLPSR
EXIT K ^TMP("ORUNS",$J),^TMP("ORSTATS",$J)
 D ^%ZISC
 Q
