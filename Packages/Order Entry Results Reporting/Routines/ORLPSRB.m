ORLPSRB ;SLC/RAF - Continuation of ORLPSRA  ; 3/31/08 6:23am
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**243**;Dec 17, 1997;Build 242
 ;
WHO ;loops thru the TMP global for output sort by entering person
 I SORT=5&('$D(LONER)) D
 .I TYPE=1 S HDR="!!?30,""List of RELEASED but UNSIGNED orders by ENTERING PERSON"""
 .I TYPE=2 S HDR="!!?40,""List of LAPSED orders by ENTERING PERSON"""
 .I TYPE=3 S HDR="!!?30,""List of UNSIGNED/UNRELEASED orders by ENTERING PERSON"""
 .S HDR1="!!,""ENTERED BY"",?23,""PROVIDER"",?46,""PATIENT"",?71,""SSN"",?77,""STATUS"",?87,""ORDER #"",?100,""ORDER DATE"",?118,""LAPSE DATE"""
 .S PAGE=0 D HDR^ORLPSR
 .I '$D(^TMP("ORUNS",$J)) W !,"No lapsed orders found" Q
 .S WHO="" F  S WHO=$O(^TMP("ORUNS",$J,WHO)) Q:WHO=""!STOP  D
 ..S PNM="" F  S PNM=$O(^TMP("ORUNS",$J,WHO,PNM)) S CNT=0 Q:PNM=""!STOP  D
 ...S IEN=0 F  S IEN=$O(^TMP("ORUNS",$J,WHO,PNM,IEN)) S CNT=CNT+1 Q:'IEN!STOP  D
 ....I 'SUMONLY W $P(^(IEN),U),?23,$P(^(IEN),U,2),?46,$P(^(IEN),U,3),?71,$P(^(IEN),U,4),?77,$P(^(IEN),U,5),?87,$P(^(IEN),U,6),?100,$P(^(IEN),U,7),?118,$P(^(IEN),U,8),! D:$Y>(IOSL-4) HDR^ORLPSR Q:STOP
 ....S ^TMP("ORSTATS",$J,WHO,PNM)=CNT
SWHO ;sorts for a single provider/entering person
 I SORT=5&($D(LONER)) S LONER="",PAGE=0 F  S LONER=$O(LONER(LONER)) Q:LONER=""!STOP  D
 .I TYPE=1 S HDR="!!?30,""List of RELEASED but UNSIGNED orders for "",LONER"
 .I TYPE=2 S HDR="!!?30,""List of LAPSED orders for "",LONER"
 .I TYPE=3 S HDR="!!?30,""List of UNSIGNED/UNRELEASED orders for "",LONER"
 .S HDR1="!!,""ENTERED BY"",?23,""PROVIDER"",?46,""PATIENT"",?71,""SSN"",?77,""STATUS"",?87,""ORDER #"",?100,""ORDER DATE"",?118,""LAPSE DATE"""
 .D HDR^ORLPSR
 .S WHO=LONER I $D(^TMP("ORUNS",$J,WHO)) D
 ..S PNM="" F  S PNM=$O(^TMP("ORUNS",$J,WHO,PNM)) S CNT=0 Q:PNM=""!STOP  D
 ...S IEN=0 F  S IEN=$O(^TMP("ORUNS",$J,WHO,PNM,IEN)) S CNT=CNT+1 Q:'IEN!STOP  D
 ....I 'SUMONLY W $P(^(IEN),U),?23,$P(^(IEN),U,2),?46,$P(^(IEN),U,3),?71,$P(^(IEN),U,4),?77,$P(^(IEN),U,5),?87,$P(^(IEN),U,6),?100,$P(^(IEN),U,7),?118,$P(^(IEN),U,8),! D:$Y>(IOSL-4) HDR^ORLPSR Q:STOP
 ....S ^TMP("ORSTATS",$J,WHO,PNM)=CNT
 .I '$D(^TMP("ORUNS",$J,WHO)) W !!,"No lapsed orders found for "_LONER
DIV ;loops thru the TMP global for output sort by division
 I SORT=6&('$D(LONER)) D
 .I TYPE=1 S HDR="!!?30,""List of RELEASED but UNSIGNED orders by DIVISION"""
 .I TYPE=2 S HDR="!!?30,""List of LAPSED orders by DIVISION"""
 .I TYPE=3 S HDR="!!?30,""List of UNSIGNED/UNRELEASED orders by DIVISION"""
 .S HDR1="!!?15,""ENTERED BY"",?40,""PATIENT"",?65,""SSN"",?71,""STATUS"",?90,""ORDER #"",?102,""ORDER DATE"",?118,""LAPSE DATE"""
 .S PAGE=0 D HDR^ORLPSR
 .I '$D(^TMP("ORUNS",$J)) W !,"No lapsed orders found" Q
 .S DIV="" F  S DIV=$O(^TMP("ORUNS",$J,DIV)) Q:DIV=""!STOP  W:'SUMONLY "Division: ",DIV D
 ..S LOC="" F  S LOC=$O(^TMP("ORUNS",$J,DIV,LOC)) Q:LOC=""!STOP  W:'SUMONLY !?5,"Location: ",LOC D
 ...S PROV="" F  S PROV=$O(^TMP("ORUNS",$J,DIV,LOC,PROV)) Q:PROV=""!STOP  W:'SUMONLY !?10,"Provider: ",PROV,! S CNT=0 D
 ....S IEN=0 F  S IEN=$O(^TMP("ORUNS",$J,DIV,LOC,PROV,IEN)) S CNT=CNT+1 Q:'IEN!STOP  D
 .....W:'SUMONLY ?15,$S(PROV'=$P(^TMP("ORUNS",$J,DIV,LOC,PROV,IEN),U,4):$P(^(IEN),U,4),1:""),?40,$P(^(IEN),U,5),?65,$P(^(IEN),U,6),?71,$P(^(IEN),U,7),?90,$P(^(IEN),U,8),?102,$P(^(IEN),U,9),?118,$P(^(IEN),U,10),! D:$Y>(IOSL-4) HDR^ORLPSR Q:STOP
 .....S ^TMP("ORSTATS",$J,DIV,LOC,PROV)=CNT
SDIV ;sorts for a single division
 I SORT=6&($D(LONER)) S LONER="",PAGE=0 F  S LONER=$O(LONER(LONER)) Q:LONER=""!STOP  D
 .I TYPE=1 S HDR="!!?30,""List of RELEASED but UNSIGNED orders for "",LONER"
 .I TYPE=2 S HDR="!!?30,""List of LAPSED orders for "",LONER"
 .I TYPE=3 S HDR="!!?30,""List of UNSIGNED/UNRELEASED orders for "",LONER"
 .S HDR1="!!,""PROVIDER"",?23,""ENTERED BY"",?46,""PATIENT"",?69,""SSN"",?72,""STATUS"",?87,""ORDER #"",?100,""ORDER DATE"",?116,""LAPSE DATE"""
 .D HDR^ORLPSR
 .S DIV=LONER I $D(^TMP("ORUNS",$J,DIV)) D
 ..S LOC="" F  S LOC=$O(^TMP("ORUNS",$J,DIV,LOC)) Q:LOC=""!STOP  W:'SUMONLY ?5,"Location: ",LOC,! D  W:'SUMONLY !
 ...S PROV="" F  S PROV=$O(^TMP("ORUNS",$J,DIV,LOC,PROV)) S CNT=0 Q:PROV=""!STOP  D
 ....S IEN="" F  S IEN=$O(^TMP("ORUNS",$J,DIV,LOC,PROV,IEN)) S CNT=CNT+1 Q:'IEN!STOP  D
 .....W:'SUMONLY $P(^(IEN),U,3),?23,$P(^(IEN),U,4),?46,$P(^(IEN),U,5),?69,$P(^(IEN),U,6),?72,$P(^(IEN),U,7),?87,$P(^(IEN),U,8),?100,$P(^(IEN),U,9),?116,$P(^(IEN),U,10),! D:$Y>(IOSL-4) HDR^ORLPSR Q:STOP
 .....S ^TMP("ORSTATS",$J,DIV,LOC,PROV)=CNT
 .I '$D(^TMP("ORUNS",$J,DIV)) W !!,"No lapsed orders found for "_LONER
SERV ;loops thru the TMP global for output sort by service
 I SORT=1&('$D(LONER)) D
 .I TYPE=1 S HDR="!!?30,""List of RELEASED but UNSIGNED orders by SERVICE/SECTION"""
 .I TYPE=2 S HDR="!!?30,""List of LAPSED orders by SERVICE/SECTION"""
 .I TYPE=3 S HDR="!!?30,""List of UNSIGNED/UNRELEASED orders by SERVICE/SECTION"""
 .S HDR1="!!,""PROVIDER"",?23,""ENTERED BY"",?46,""PATIENT"",?71,""SSN"",?77,""STATUS"",?87,""ORDER #"",?104,""ORDER DATE"",?120,""LAPSE DATE"""
 .S PAGE=0 D HDR^ORLPSR
 .I '$D(^TMP("ORUNS",$J)) W !,"No lapsed orders found" Q
 .S SER="" F  S SER=$O(^TMP("ORUNS",$J,SER)) Q:SER=""!STOP  W:'SUMONLY "Service/Section: ",SER,! D  W:'SUMONLY !
 ..S PROV="" F  S PROV=$O(^TMP("ORUNS",$J,SER,PROV)) S CNT=0 Q:PROV=""!STOP  D
 ...S IEN=0 F  S IEN=$O(^TMP("ORUNS",$J,SER,PROV,IEN)) S CNT=CNT+1 Q:'IEN!STOP  D
 ....W:'SUMONLY $P(^TMP("ORUNS",$J,SER,PROV,IEN),U,2),?23,$P(^(IEN),U,3),?46,$P(^(IEN),U,4),?71,$P(^(IEN),U,5),?77,$P(^(IEN),U,6),?87,$P(^(IEN),U,7),?104,$P(^(IEN),U,8),?120,$P(^(IEN),U,9),! D:$Y>(IOSL-4) HDR^ORLPSR Q:STOP
 ....S ^TMP("ORSTATS",$J,SER,PROV)=CNT
SSERV ;sorts for a single service/section
 I SORT=1&($D(LONER)) S LONER="",PAGE=0 F  S LONER=$O(LONER(LONER)) Q:LONER=""!STOP  D
 .I TYPE=1 S HDR="!!?30,""List of RELEASED but UNSIGNED orders for "",LONER"
 .I TYPE=2 S HDR="!!?30,""List of LAPSED orders for "",LONER"
 .I TYPE=3 S HDR="!!?30,""List of UNSIGNED/UNRELEASED orders for "",LONER"
 .S HDR1="!!,""PROVIDER"",?23,""ENTERED BY"",?46,""PATIENT"",?71,""SSN"",?77,""STATUS"",?87,""ORDER #"",?104,""ORDER DATE"",?120,""LAPSE DATE"""
 .D HDR^ORLPSR
 .S SER=LONER I $D(^TMP("ORUNS",$J,SER)) D
 ..S PROV="" F  S PROV=$O(^TMP("ORUNS",$J,SER,PROV)) S CNT=0 Q:PROV=""!STOP  D
 ...S IEN=0 F  S IEN=$O(^TMP("ORUNS",$J,SER,PROV,IEN)) S CNT=CNT+1 Q:'IEN!STOP  D
 ....W:'SUMONLY $P(^(IEN),U,2),?23,$P(^(IEN),U,3),?46,$P(^(IEN),U,4),?71,$P(^(IEN),U,5),?77,$P(^(IEN),U,6),?87,$P(^(IEN),U,7),?104,$P(^(IEN),U,8),?120,$P(^(IEN),U,9),! D:$Y>(IOSL-4) HDR^ORLPSR Q:STOP
 ....S ^TMP("ORSTATS",$J,SER,PROV)=CNT
 .I '$D(^TMP("ORUNS",$J,SER)) W !!,"No lapsed orders found for "_LONER
 Q
