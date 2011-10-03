ORS100B ;SLC/RAF - Continuation of ORS100A  ;10/19/00  13:36
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**50**;Dec 17, 1997
 ;
WHO ;loops thru the TMP global for output sort by entering person
 I SORT=5&('$D(LONER)) D
 .I TYPE=1 S HDR="!!?30,""List of RELEASED but UNSIGNED orders by ENTERING PERSON"""
 .I TYPE=2 S HDR="!!?40,""List of UNSIGNED orders by ENTERING PERSON"""
 .I TYPE=3 S HDR="!!?30,""List of UNSIGNED/UNRELEASED orders by ENTERING PERSON"""
 .S HDR1="!!,""ENTERED BY"",?25,""PROVIDER"",?50,""PATIENT"",?75,""SSN"",?81,""STATUS"",?95,""ORDER #"",?110,""ORDER DATE"""
 .S PAGE=0 D HDR^ORS100
 .I '$D(^TMP("ORUNS",$J)) W !,"No unsigned orders found" Q
 .S WHO="" F  S WHO=$O(^TMP("ORUNS",$J,WHO)) Q:WHO=""!STOP  D
 ..S PNM="" F  S PNM=$O(^TMP("ORUNS",$J,WHO,PNM)) S CNT=0 Q:PNM=""!STOP  D
 ...S IEN=0 F  S IEN=$O(^TMP("ORUNS",$J,WHO,PNM,IEN)) S CNT=CNT+1 Q:'IEN!STOP  D
 ....I 'SUMONLY W $P(^(IEN),U),?25,$P(^(IEN),U,2),?50,$P(^(IEN),U,3),?75,$P(^(IEN),U,4),?81,$P(^(IEN),U,5),?95,$P(^(IEN),U,6),?110,$P(^(IEN),U,7),! D:$Y>(IOSL-4) HDR^ORS100 Q:STOP
 ....S ^TMP("ORSTATS",$J,WHO,PNM)=CNT
SWHO ;sorts for a single provider/entering person
 I SORT=5&($D(LONER)) S LONER="",PAGE=0 F  S LONER=$O(LONER(LONER)) Q:LONER=""!STOP  D
 .I TYPE=1 S HDR="!!?30,""List of RELEASED but UNSIGNED orders for "",LONER"
 .I TYPE=2 S HDR="!!?30,""List of UNSIGNED orders for "",LONER"
 .I TYPE=3 S HDR="!!?30,""List of UNSIGNED/UNRELEASED orders for "",LONER"
 .S HDR1="!!,""ENTERED BY"",?25,""PROVIDER"",?50,""PATIENT"",?75,""SSN"",?81,""STATUS"",?95,""ORDER #"",?110,""ORDER DATE"""
 .D HDR^ORS100
 .S WHO=LONER I $D(^TMP("ORUNS",$J,WHO)) D
 ..S PNM="" F  S PNM=$O(^TMP("ORUNS",$J,WHO,PNM)) S CNT=0 Q:PNM=""!STOP  D
 ...S IEN=0 F  S IEN=$O(^TMP("ORUNS",$J,WHO,PNM,IEN)) S CNT=CNT+1 Q:'IEN!STOP  D
 ....I 'SUMONLY W $P(^(IEN),U),?25,$P(^(IEN),U,2),?50,$P(^(IEN),U,3),?75,$P(^(IEN),U,4),?81,$P(^(IEN),U,5),?95,$P(^(IEN),U,6),?110,$P(^(IEN),U,7),! D:$Y>(IOSL-4) HDR^ORS100 Q:STOP
 ....S ^TMP("ORSTATS",$J,WHO,PNM)=CNT
 .I '$D(^TMP("ORUNS",$J,WHO)) W !!,"No unsigned orders found for "_LONER
DIV ;loops thru the TMP global for output sort by division
 I SORT=6&('$D(LONER)) D
 .I TYPE=1 S HDR="!!?30,""List of RELEASED but UNSIGNED orders by DIVISION"""
 .I TYPE=2 S HDR="!!?30,""List of UNSIGNED orders by DIVISION"""
 .I TYPE=3 S HDR="!!?30,""List of UNSIGNED/UNRELEASED orders by DIVISION"""
 .S HDR1="!!?15,""ENTERED BY"",?40,""PATIENT"",?65,""SSN"",?71,""STATUS"",?88,""ORDER #"",?100,""ORDER DATE"""
 .S PAGE=0 D HDR^ORS100
 .I '$D(^TMP("ORUNS",$J)) W !,"No unsigned orders found" Q
 .S DIV="" F  S DIV=$O(^TMP("ORUNS",$J,DIV)) Q:DIV=""!STOP  W:'SUMONLY "Division: ",DIV D
 ..S LOC="" F  S LOC=$O(^TMP("ORUNS",$J,DIV,LOC)) Q:LOC=""!STOP  W:'SUMONLY !?5,"Location: ",LOC D
 ...S PROV="" F  S PROV=$O(^TMP("ORUNS",$J,DIV,LOC,PROV)) Q:PROV=""!STOP  W:'SUMONLY !?10,"Provider: ",PROV,! S CNT=0 D
 ....S IEN=0 F  S IEN=$O(^TMP("ORUNS",$J,DIV,LOC,PROV,IEN)) S CNT=CNT+1 Q:'IEN!STOP  D
 .....W:'SUMONLY ?15,$S(PROV'=$P(^TMP("ORUNS",$J,DIV,LOC,PROV,IEN),U,4):$P(^(IEN),U,4),1:""),?40,$P(^(IEN),U,5),?65,$P(^(IEN),U,6),?71,$P(^(IEN),U,7),?88,$P(^(IEN),U,8),?100,$P(^(IEN),U,9),! D:$Y>(IOSL-4) HDR^ORS100 Q:STOP
 .....S ^TMP("ORSTATS",$J,DIV,LOC,PROV)=CNT
SDIV ;sorts for a single division
 I SORT=6&($D(LONER)) S LONER="",PAGE=0 F  S LONER=$O(LONER(LONER)) Q:LONER=""!STOP  D
 .I TYPE=1 S HDR="!!?30,""List of RELEASED but UNSIGNED orders for "",LONER"
 .I TYPE=2 S HDR="!!?30,""List of UNSIGNED orders for "",LONER"
 .I TYPE=3 S HDR="!!?30,""List of UNSIGNED/UNRELEASED orders for "",LONER"
 .S HDR1="!!,""PROVIDER"",?25,""ENTERED BY"",?50,""PATIENT"",?75,""SSN"",?80,""STATUS"",?95,""ORDER #"",?110,""ORDER DATE"""
 .D HDR^ORS100
 .S DIV=LONER I $D(^TMP("ORUNS",$J,DIV)) D
 ..S LOC="" F  S LOC=$O(^TMP("ORUNS",$J,DIV,LOC)) Q:LOC=""!STOP  W:'SUMONLY ?5,"Location: ",LOC,! D  W:'SUMONLY !
 ...S PROV="" F  S PROV=$O(^TMP("ORUNS",$J,DIV,LOC,PROV)) S CNT=0 Q:PROV=""!STOP  D
 ....S IEN="" F  S IEN=$O(^TMP("ORUNS",$J,DIV,LOC,PROV,IEN)) S CNT=CNT+1 Q:'IEN!STOP  D
 .....W:'SUMONLY $P(^(IEN),U,3),?25,$P(^(IEN),U,4),?50,$P(^(IEN),U,5),?75,$P(^(IEN),U,6),?80,$P(^(IEN),U,7),?95,$P(^(IEN),U,8),?110,$P(^(IEN),U,9),! D:$Y>(IOSL-4) HDR^ORS100 Q:STOP
 .....S ^TMP("ORSTATS",$J,DIV,LOC,PROV)=CNT
 .I '$D(^TMP("ORUNS",$J,DIV)) W !!,"No unsigned orders found for "_LONER
SERV ;loops thru the TMP global for output sort by service
 I SORT=1&('$D(LONER)) D
 .I TYPE=1 S HDR="!!?30,""List of RELEASED but UNSIGNED orders by SERVICE/SECTION"""
 .I TYPE=2 S HDR="!!?30,""List of UNSIGNED orders by SERVICE/SECTION"""
 .I TYPE=3 S HDR="!!?30,""List of UNSIGNED/UNRELEASED orders by SERVICE/SECTION"""
 .S HDR1="!!,""PROVIDER"",?25,""ENTERED BY"",?50,""PATIENT"",?75,""SSN"",?81,""STATUS"",?95,""ORDER #"",?110,""ORDER DATE"""
 .S PAGE=0 D HDR^ORS100
 .I '$D(^TMP("ORUNS",$J)) W !,"No unsigned orders found" Q
 .S SER="" F  S SER=$O(^TMP("ORUNS",$J,SER)) Q:SER=""!STOP  W:'SUMONLY "Service/Section: ",SER,! D  W:'SUMONLY !
 ..S PROV="" F  S PROV=$O(^TMP("ORUNS",$J,SER,PROV)) S CNT=0 Q:PROV=""!STOP  D
 ...S IEN=0 F  S IEN=$O(^TMP("ORUNS",$J,SER,PROV,IEN)) S CNT=CNT+1 Q:'IEN!STOP  D
 ....W:'SUMONLY $P(^TMP("ORUNS",$J,SER,PROV,IEN),U,2),?25,$P(^(IEN),U,3),?50,$P(^(IEN),U,4),?75,$P(^(IEN),U,5),?81,$P(^(IEN),U,6),?95,$P(^(IEN),U,7),?110,$P(^(IEN),U,8),! D:$Y>(IOSL-4) HDR^ORS100 Q:STOP
 ....S ^TMP("ORSTATS",$J,SER,PROV)=CNT
SSERV ;sorts for a single service/section
 I SORT=1&($D(LONER)) S LONER="",PAGE=0 F  S LONER=$O(LONER(LONER)) Q:LONER=""!STOP  D
 .I TYPE=1 S HDR="!!?30,""List of RELEASED but UNSIGNED orders for "",LONER"
 .I TYPE=2 S HDR="!!?30,""List of UNSIGNED orders for "",LONER"
 .I TYPE=3 S HDR="!!?30,""List of UNSIGNED/UNRELEASED orders for "",LONER"
 .S HDR1="!!,""PROVIDER"",?25,""ENTERED BY"",?50,""PATIENT"",?75,""SSN"",?81,""STATUS"",?95,""ORDER #"",?110,""ORDER DATE"""
 .D HDR^ORS100
 .S SER=LONER I $D(^TMP("ORUNS",$J,SER)) D
 ..S PROV="" F  S PROV=$O(^TMP("ORUNS",$J,SER,PROV)) S CNT=0 Q:PROV=""!STOP  D
 ...S IEN=0 F  S IEN=$O(^TMP("ORUNS",$J,SER,PROV,IEN)) S CNT=CNT+1 Q:'IEN!STOP  D
 ....W:'SUMONLY $P(^(IEN),U,2),?25,$P(^(IEN),U,3),?50,$P(^(IEN),U,4),?75,$P(^(IEN),U,5),?81,$P(^(IEN),U,6),?95,$P(^(IEN),U,7),?110,$P(^(IEN),U,8),! D:$Y>(IOSL-4) HDR^ORS100 Q:STOP
 ....S ^TMP("ORSTATS",$J,SER,PROV)=CNT
 .I '$D(^TMP("ORUNS",$J,SER)) W !!,"No unsigned orders found for "_LONER
 Q
