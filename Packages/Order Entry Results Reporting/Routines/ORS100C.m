ORS100C ; slc/dcm - OE/RR Controlled Substance RX w/Missing Digital Sig Report;Nov 04, 2020@16:11:29
 ;;3.0;ORDER ENTRY RESULTS REPORTING;**498**;Dec 17, 1997;Build 38
 ;CAC Report showing Orders for Controlled Substances where the Digital Signature is missing since the installation of CPRS V29 (OR*3.0*306v29t21)
EN ;
 N DIR,SDATE,SD1,SDT,DTOUT,DUOUT,EDATE,SD2,OREDT,POP,ZTIO,ZTRTN,ZTSAVE,ZTSK,ZTDESC,VA,VADM,VAERR
 N X,X0,Y,IFN,V29DT,IDT,ORIFN,ORACT,TYPE,PSIFN,NODE,RXN,STAT,PROV,ENTBY,ORVP,OR0,OR3,CNT,H,HDR,HDR1,PAGE,RX0,RX2,RX3,STOP,INCLDRX,YDIV
 K ^TMP("PS",$J),^TMP("ORUNS",$J),^TMP("ORSTATS",$J),YDIV
SDATE ;sets DIR call to ask the user for a starting date - Look up Install date for CPRS V29
 S IFN=0,V29DT=""
 F  S IFN=$O(^XPD(9.7,"B","OR*3.0*306",IFN)) Q:IFN=""  I $P($G(^XPD(9.7,IFN,1)),"^",3) S:V29DT="" V29DT=$P(^(1),"^",3) D
 . I $P(^XPD(9.7,IFN,1),"^",3)<V29DT S V29DT=$P(^(1),"^",3)
 W !!,"Search for Controlled Subscription orders with missing Digital Signatures",!
 W !!,"This report may take a long time to run",!
 W !,"CPRS V29 containing Controlled Subscription functionality was installed on "_$$FMTE^XLFDT($$FMTE^XLFDT(V29DT))
 S DIR(0)="DA^::ETX"
 S DIR("A")="Enter a starting date: "
 S DIR("B")=$P($$FMTE^XLFDT($$FMTE^XLFDT(V29DT)),"@")
 S DIR("?")="Enter the date or date/time that you want the search to start with. This field can be used to ignore pre-CPRS v29 orders by entering the date of your CPRS v29 installation."
 D ^DIR S:+Y>0 (SDATE,SD1)=(9999999-Y),SDT=$$FMTE^XLFDT(Y) K DIR I $D(DTOUT)!$D(DUOUT) G EXIT
EDATE ;sets DIR call to ask the user for an ending date (optional)
 S DIR(0)="DA^::ETX"
 S DIR("A")="Enter an ending date: "
 S DIR("B")="T"
 S DIR("?")="Enter the date or date/time that you want the search to end with."
 D ^DIR Q:'Y
 I '$L($P(Y,".",2)) S Y=Y_"."_2359
 S (EDATE,SD2)=(9999999-Y),OREDT=$$FMTE^XLFDT(Y) K DIR I $D(DTOUT)!$D(DUOUT) G EXIT
SWITCH ;takes the date input from the user and does a switcheroo so things work
 I EDATE'>SDATE S EDATE=SD1,SDATE=SD2
 ;
 S INCLDRX=0
BD W !!,"Include orders written/renewed by Pharmacy 'backdoor'? No//" R X:DTIME S:X="" X="N" S:'$T X="^" I X["^" Q
 I "?"[X W !,"Enter Yes or No" G BD
 S:"Yy"[$E(X) INCLDRX=1
MCD W !!,"Include all Medical Center Divisions? Yes//"  R X:DTIME S:X="" X="Y" S:'$T X="^" I X["^" Q
 I "?"[X W !,"Enter Yes or No" G MCD
 I "Nn"[$E(X) D DIV I '$O(YDIV(0)) G MCD
TASK ;
 S %ZIS="Q" D ^%ZIS I POP Q
 I $D(IO("Q")) D  K IO("Q") Q
 . S ZTIO=ION,ZTDESC="File 100 Controlled Substance with no Digital Sig search"
 . S ZTRTN="LOOP^ORS100C",ZTSAVE("SORT")="",ZTSAVE("TYPE")=""
 . S ZTSAVE("SDATE")="",ZTSAVE("EDATE")=""
 . S ZTSAVE("SDT")="",ZTSAVE("OREDT")="",ZTSAVE("INCLDRX")="",ZTSAVE("YDIV")=""
 . D ^%ZTLOAD I $D(ZTSK) W !,?32,"REQUEST QUEUED"
 U IO D LOOP^ORS100C
 Q
 ;
LOOP ;Produce Controlled Substance, no Dig Sig Report
 N ORX,RPDT,X,Y,IFN,V29DT,IDT,SIDT,ORIFN,ORACT,TYPE,PSIFN,NODE,RXN,STAT,PROV,ORVP,OR0,OR3,LOC,DIV,SCH,IDI,ORIO
 N DFN,SSN,PNM,RDAT,RX,DRUG,QTY,LRDAT,ORPSO,PKG,STOP,COMMENT,CNT,SCNT
 K ^TMP("PS",$J),^TMP("ORUNS",$J),^TMP("ORSTATS",$J)
 S ^TMP("ORSTATS",$J)=0
 S CNT=0,SCNT=0,ORPSO=$O(^DIC(9.4,"B","OUTPATIENT PHARMACY",""))
 I 'ORPSO Q  ;Missing Outpatient pharmacy in PACKAGE file "B" x-ref
 S RPDT="""Report Date: "",$$FMTE^XLFDT($$NOW^XLFDT),""  From: "",SDT,""  To: "",OREDT",STOP=0
 S IDT=9999999-EDATE,SIDT=9999999-SDATE
 S (LOC,DIV)="**DELAYED ORDER/NOT ENTERED" ;Reset values as delayed orders may not have these values yet
 F  S IDT=$O(^OR(100,"AF",IDT)) Q:IDT=""  Q:IDT>SIDT  S ORIFN=0 F  S ORIFN=$O(^OR(100,"AF",IDT,ORIFN)) Q:ORIFN=""  D
 . S ORACT=0 F  S ORACT=$O(^OR(100,"AF",IDT,ORIFN,ORACT)) Q:ORACT=""!(ORACT>1)  D
 .. S OR0=$G(^OR(100,ORIFN,0)) Q:'$L(OR0)
 .. Q:$P(OR0,U,14)'=ORPSO  ;Only look for OUTPATIENT PHARMACY orders
 .. I $P(OR0,U,10),$D(^SC(+$P(OR0,U,10),0)) S LOC=$$LOC^ORS100(+$P(OR0,U,10))
 .. I $P(OR0,U,10),$D(^SC(+$P(OR0,U,10),0)) S DIV=$$DIV^ORS100(+$P(OR0,U,10))
 .. S Y=1 I $O(YDIV(0)) S Y=0,I=0 F  S I=$O(YDIV(I)) Q:'I  I YDIV(I)=$P(OR0,U,10) S Y=1 Q
 .. I 'Y,'$O(YDIV(0)) Q
 .. S OR3=$G(^OR(100,ORIFN,3)) Q:'$L(OR3)
 .. S COMMENT="",CNT=CNT+1
 .. I '$D(ZTSK),CNT>1000 W "." S CNT=0
 .. S ORTYPE=$P(OR3,"^",11) I ORTYPE="P" S COMMENT="*" I 'INCLDRX Q  ;P for Package - Backdoor order
 .. S ORPREV=$P(OR3,"^",6) I ORPREV]"",$P($G(^OR(100,ORPREV,6)),"^",5)="Renewed by Pharmacy" S COMMENT="~"_COMMENT I 'INCLDRX Q
 .. S STAT=$P(OR3,"^",3),STAT=$P($G(^ORD(100.01,+STAT,0)),"^",2)
 .. S ORVP=$P(OR0,"^",2),TYPE=$P(OR0,"^",12),PSIFN=$G(^OR(100,ORIFN,4)) Q:'$L(PSIFN)
 .. S DFN=+$P(^OR(100,ORIFN,0),U,2) D DEM^VADPT S SSN=VA("BID"),PNM=$E(VADM(1),1,24)
 .. S:TYPE="O" PSIFN=$TR(PSIFN,"S","P")_$S(PSIFN?1.N:"R",1:"")
 .. D OEL^PSOORRL(+ORVP,PSIFN_";"_TYPE)  ;DBIA 2400
 .. S NODE=$G(^TMP("PS",$J,0)),RX=$G(^("RXN",0)) Q:'$L(RX)
 .. S DRUG=$P(NODE,"^"),QTY=$P(NODE,"^",8),RXN=$P(RX,"^"),LRDAT=$P(RX,"^",2)
 .. S X=$G(^OR(100,ORIFN,8,ORACT,2)),X0=$G(^(0)) ;Q:$L($P(X,"^",3))
 .. S STOP=0
 .. S RDAT=$$FMTE^XLFDT($P($P(X0,"^",16),".")),PROV=$P(X0,"^",3),PROV=$P($G(^VA(200,+PROV,0)),"^"),ENTBY=$P(OR0,"^",6),ENTBY=$P($G(^VA(200,+ENTBY,0)),"^")
 .. D DEA Q:STOP
 .. S IDI=0 F  S IDI=$O(^OR(100,ORIFN,.1,IDI)) Q:'IDI  S ORIO=+$G(^(IDI,0)) I ORIO D
 ... D CSCHECK^ORDEA(.SCH,ORIO,"O") I +SCH=1 D
 .... S SCNT=SCNT+1,^TMP("ORUNS",$J,IDT,ORIFN)=RXN_U_ENTBY_U_QTY_U_PNM_U_RDAT_U_DRUG_U_PROV_U_DIV_U_LOC_U_STAT_U_LRDAT_U_COMMENT
 ;
DISP ; Display results
 S H=$S(INCLDRX:"""* indicates backdoor entry   ~ Renewed by Pharmacy""",1:""" """)
 S HDR="!?8,""List of CONTROLLED SUBSTANCE orders without DIGITAL SIGNATURE"""
 S HDR1="!,""RX #"",?14,""QTY"",?18,""PATIENT"",?43,""RELEASE DATE"",?59,""ORD #"",!?2,""DRUG"",?43,""PROVIDER"",!?2,""DIVISION"",?43,""LOCATION"",!?2,""ENTERED BY"",?23,"_H
 S STOP=0
 S PAGE=0 D HDR^ORS100
 I '$D(^TMP("ORUNS",$J)) W !,"No orders found" D EXIT Q
 S IDT="" F  S IDT=$O(^TMP("ORUNS",$J,IDT)) Q:IDT=""!STOP  D
 . S ORIFN="" F  S ORIFN=$O(^TMP("ORUNS",$J,IDT,ORIFN)) Q:ORIFN=""!STOP  S ORX=^(ORIFN) D
 .. W !,$P(ORX,U),?14,$P(ORX,U,3),?18,$P(ORX,U,4),?43,$P(ORX,U,5),?59,ORIFN
 .. W !?2,$P(ORX,U,6),?43,$P(ORX,U,7),!?2,$P(ORX,U,8),?43,$P(ORX,U,9),!?2,$P(ORX,U,2),?33,$P(ORX,U,12),! D:$Y>(IOSL-5) HDR^ORS100 Q:STOP
 S ^TMP("ORSTATS",$J)=CNT
 I '$D(^TMP("ORUNS",$J)) W !,"No orders found" D EXIT Q
 W !!?10,"TOTAL FOUND: "_SCNT
 D EXIT
 Q
DEA ; Check ORDER DEA ARCHIVE file (#101.52) for Digital signature
 N IN S IN=0
 I '$O(^ORPA(101.52,"B",ORIFN,0)) S COMMENT=COMMENT_"No matching entry in DEA ARCHIVE file (101.52)" Q
 F  S IN=$O(^ORPA(101.52,"B",ORIFN,IN)) Q:'IN  D  Q:STOP
 . I '$D(^ORPA(101.52,IN,0)) S COMMENT=COMMENT_"Broken pointer in B xref, file 101.52" Q
 . I $P(^ORPA(101.52,IN,0),"^",3)="" S COMMENT=COMMENT_"No Digital Signature in file 101.52" Q
 . S STOP=1
 Q
DIV ;Select Divisions to include on report
 N DIC,Y,DTOUT,DUOUT
 F  D  Q:(Y=-1)!$D(DTOUT)!$D(DUOUT)
 . S DIC="^DG(40.8,",DIC(0)="QEAMZ" D ^DIC I (Y=-1)!$D(DTOUT)!$D(DUOUT) Q
 . S YDIV(+Y)=""
 Q
EXIT ;
 K ^TMP("ORUNS",$J),^TMP("ORSTATS",$J),^TMP("PS",$J)
 D ^%ZISC
