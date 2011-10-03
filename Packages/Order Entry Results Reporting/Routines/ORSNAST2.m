ORSNAST2 ;SLC/RAF - continuation of nature/status search ;10/20/00  14:32
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**50,190**;Dec 17, 1997
 ;
NATURE ;goes thru the "AF" xref in 100 for order dates for nature or order
1 I SORT=1 D  I ('$D(^TMP("ORNS",$J)))&(FORMAT=1) W !,"No orders found." Q
 .D:('PAGE)&(FORMAT=1) HDR^ORS100
 .S DATE=SDATE F  S DATE=$O(^OR(100,"AF",DATE)) Q:'DATE!STOP  Q:DATE>EDATE  D
 ..S IEN=0 F  S IEN=$O(^OR(100,"AF",DATE,IEN)) Q:'IEN!STOP  I $D(^OR(100,IEN)) D
 ...S SUB=0 F  S SUB=$O(^OR(100,"AF",DATE,IEN,SUB)) Q:'SUB!STOP  D
 ....I $P($G(^OR(100,IEN,8,SUB,0)),U,12)=SEARCH D
 .....I $D(^VA(200,+$P(^OR(100,IEN,8,SUB,0),U,3),0)) S PROV=$$USER^ORS100(+$P(^OR(100,IEN,8,SUB,0),U,3))
 .....I $D(^VA(200,+$P(^OR(100,IEN,0),U,4),5)),$L($P(^(5),U)) S SER=$$SER^ORS100(+$P(^VA(200,+$P(^OR(100,IEN,0),U,4),5),U))
 .....E  S SER="MISSING from file 200"
 .....I $D(^VA(200,+$P(^OR(100,IEN,8,SUB,0),U,13))) S WHO=$$USER^ORS100(+$P(^OR(100,IEN,8,SUB,0),U,13))
 .....S DFN=+$P(^OR(100,IEN,0),U,2) Q:$P(^DPT(DFN,0),U,21)  D DEM^VADPT S SSN=VA("BID"),PNM=VADM(1)
 .....I $D(^OR(100,IEN,3)),$P(^(3),U,3) S STATUS=$$STAT^ORS100(+$P(^(3),U,3))
 .....I $D(^OR(100,IEN,8,SUB,0)) S WHEN=$$FMTE^XLFDT($P(^(0),U)) S SIGNED=$$FMTE^XLFDT($P(^(0),U,6))
 .....E  S SIGNED=""
 .....S ^TMP("ORNS",$J,WHO,PROV,IEN)=WHO_U_PROV_U_PNM_U_SSN_U_STATUS_U_IEN_U_WHEN_U_SIGNED
 .....S ^TMP("ORSERV",$J,SER,WHO,IEN)=SER_U_WHO_U_PROV_U_PNM_U_SSN_U_STATUS_U_IEN_U_WHEN_U_SIGNED
DETAILS .....;detailed output which includes the order text
 .....I FORMAT=1 D
 ......W !,"NATURE OF ORDER: ",SNAME,?54,"Order Action: ",$P(^OR(100,IEN,8,SUB,0),U,2) D:$Y>(IOSL-4) HDR^ORS100 Q:STOP
 ......W !,"STATUS: ",STATUS,?52,"ORIFN(Order #): ",IEN D:$Y>(IOSL-4) HDR^ORS100 Q:STOP
 ......W !,"OBJECT OF ORDER(Patient name): ",$G(PNM),?63,"SSN: ",$G(SSN) D:$Y>(IOSL-4) HDR^ORS100 Q:STOP
 ......I $P(^ORD(100.98,$P(^OR(100,+IEN,0),U,11),0),U)="NON-VA MEDICATIONS" D
 .......W !,"DOCUMENTED BY: ",$P($G(^VA(200,+$P(^OR(100,IEN,8,SUB,0),U,3),0)),U),?53,"VEILED ORDER?: ",$S($P(^OR(100,IEN,3),U,8)=1:"YES",1:"NO") D:$Y>(IOSL-4) HDR^ORS100 Q:STOP
 ......E  W !,"ORDERED BY: ",$P($G(^VA(200,+$P(^OR(100,IEN,8,SUB,0),U,3),0)),U),?53,"VEILED ORDER?: ",$S($P(^OR(100,IEN,3),U,8)=1:"YES",1:"NO") D:$Y>(IOSL-4) HDR^ORS100 Q:STOP
 ......W !,"ENTERED BY: ",$P($G(^VA(200,+$P(^OR(100,IEN,8,SUB,0),U,13),0)),U)," ON ",$$FMTE^XLFDT($P(^OR(100,IEN,0),U,7)) D:$Y>(IOSL-4) HDR^ORS100 Q:STOP
 ......W !,"RELEASED BY: " I +$P(^OR(100,IEN,8,SUB,0),U,16) W $P($G(^VA(200,+$P(^OR(100,IEN,8,SUB,0),U,17),0)),U)," ON ",$$FMTE^XLFDT($P(^OR(100,IEN,8,SUB,0),U,16)) D:$Y>(IOSL-4) HDR^ORS100 Q:STOP
 ......W !,"SIGNED BY: " I +$P(^OR(100,IEN,8,SUB,0),U,6) W $P($G(^VA(200,+$P(^OR(100,IEN,8,SUB,0),U,5),0)),U)," ON ",$$FMTE^XLFDT($P(^OR(100,IEN,8,SUB,0),U,6)) D:$Y>(IOSL-4) HDR^ORS100 Q:STOP
 ......W !,"ORDER TEXT: " S ORIGVIEW=2 D TEXT^ORQ12(.TEXT,IEN_";"_SUB,(IOM-13)) S TEXTSUB="" F  S TEXTSUB=$O(TEXT(TEXTSUB)) Q:'+TEXTSUB!(TEXTSUB=4)!STOP  W:TEXTSUB'=1 ?12 W TEXT(TEXTSUB),! D:$Y>(IOSL-4) HDR^ORS100 Q:STOP
 ......I 'STOP I TEXTSUB=4 W !,"***There is more order text.  It is limited to 3 lines for this report***"
 ......K TEXT,TEXTSUB
 ......I 'STOP K DASH S $P(DASH,"-",IOM)="" W !,DASH
COLUMNS ;this section uses the TMP global for the columnar format
 I '$G(SERVICE)&(FORMAT=2) D
 .S HDR1="!,""Provider"",?25,""Patient"",?50,""SSN"",?56,""Status"",?75,""Order #"",?87,""Order Date"",?110,""Signed"""
 .S HDR="!,""Search for orders with a nature of order of ""_SNAME"
 .D HDR^ORS100
 .I '$D(^TMP("ORNS",$J)) W !,"No orders found." Q
 .S WHO="" F  S WHO=$O(^TMP("ORNS",$J,WHO)) Q:WHO=""!STOP  W "Entered by: ",WHO,!  D  W !
 ..S PNM="" F  S PNM=$O(^TMP("ORNS",$J,WHO,PNM)) Q:PNM=""!STOP  D
 ...S IEN=0 F  S IEN=$O(^TMP("ORNS",$J,WHO,PNM,IEN)) Q:'IEN!STOP  D
 ....W $P(^(IEN),U,2),?25,$P(^(IEN),U,3),?50,$P(^(IEN),U,4),?56,$P(^(IEN),U,5),?75,$P(^(IEN),U,6),?87,$P(^(IEN),U,7),?110,$P(^(IEN),U,8),! D:$Y>(IOSL-4) HDR^ORS100
SERV I $G(SERVICE)&(FORMAT=2) D
 .S HDR1="!,""Provider"",?25,""Patient"",?50,""SSN"",?56,""Status"",?75,""Order #"",?87,""Order Date"",?110,""Signed"""
 .S HDR="!,""Search for orders with a nature of order of ""_SNAME"
 .D HDR^ORS100
 .I '$D(^TMP("ORSERV",$J)) W !,"No orders found." Q
 .S REF=$S($D(LONER):"LONER(SER)",1:"^TMP(""ORSERV"",$J,SER)")
 .S SER="" F  S SER=$O(@REF) Q:SER=""!STOP  W "Service/Section: ",SER,! D
 ..I '$D(^TMP("ORSERV",$J,SER)) W "No orders found.",!! Q
 ..S WHO="" F  S WHO=$O(^TMP("ORSERV",$J,SER,WHO)) Q:WHO=""!STOP  W ?5,"Entered by: ",WHO,!  D  W !
 ...S IEN=0 F  S IEN=$O(^TMP("ORSERV",$J,SER,WHO,IEN)) Q:'IEN!STOP  D
 ....W $P(^(IEN),U,3),?25,$P(^(IEN),U,4),?50,$P(^(IEN),U,5),?56,$P(^(IEN),U,6),?75,$P(^(IEN),U,7),?87,$P(^(IEN),U,8),?110,$P(^(IEN),U,9),! D:$Y>(IOSL-4) HDR^ORS100
 Q
