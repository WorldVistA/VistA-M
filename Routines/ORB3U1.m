ORB3U1 ; slc/CLA - Utilities which support OE/RR 3 Notifications ;12/15/97
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**9,74,88,91,105,179,220,250**;Dec 17, 1997;Build 1
 Q
LIST(Y) ;return list of notifications from Notification File [#100.9]
 ; RETURN IEN^NAME^URGENCY
 N I,J,V
 S I=1
 S J=0 F  S J=$O(^ORD(100.9,"B",J)) Q:J=""  S V=0,V=$O(^ORD(100.9,"B",J,V)) S Y(I)=V_"^"_J_"^"_^ORD(100.9,V,3),I=I+1
 Q
 ;
ALRTHX ;report the recipients for an alert, when received, action taken
 N ORBDFN,ORBSDT,ORBEDT
 ;prompt for patient (required):
 K DIC S DIC="^DPT(",DIC("A")="PATIENT (req'd): ",DIC(0)="AEQNM" D ^DIC
 I Y<1 K DIC,Y Q
 S ORBDFN=+Y,ORBPT=$P(Y,U,2)
 K DIC,Y,DUOUT,DTOUT
 ;
 S %DT="AET",%DT("A")="Start Date/Time (req'd): ",%DT("B")="T-30" D ^%DT
 I Y<1 K %DT,Y Q
 S ORBSDT=Y
 ;
 S %DT="AET",%DT("A")="End Date/Time (req'd): ",%DT("B")="NOW" D ^%DT
 I Y<1 K %DT,Y Q
 S ORBEDT=Y
 ;
 ;get alerts for this patient from the alert tracking file:
 D PATIENT^XQALERT("^TMP(""ORB"",$J)",ORBDFN,ORBSDT,ORBEDT)
 W !!,"Processing..."
 ;
 D EN^VALM("OR PATIENT ALERTS")
 Q
SELECT ;if one or more alerts selected, display/print recipient data:
 N ORN,ORNUMS,ORI,ORJ,ORBAL,ORBAID,ORBSMSG,ORY,DESC,HDR
 S ORNUMS=$P(XQORNOD(0),"=",2)
 Q:'$L(ORNUMS)
 D FULL^VALM1
 ;
 S ORJ=1
 F ORI=1:1:$L(ORNUMS,",")-1 D
 .S ORN=$P(ORNUMS,",",ORI)
 .S ORBAL=$G(^TMP("OR",$J,"ALERTS","IDX",ORN)) I $L(ORBAL) D
 ..S ORBAID=$P(ORBAL,U)
 ..S ORBSMSG=$P(ORBAL,U,2)
 ..S ORY(ORJ)="RECIPIENTS OF ALERT: "_ORBSMSG,ORJ=ORJ+1
 ..D GETRECS(ORBAID)  ;get recipient data
 ..S ORJ=ORJ+1,ORY(ORJ)="",ORJ=ORJ+1,ORY(ORJ)="",ORJ=ORJ+1
 S DESC="Recipients of a Kernel Alert"
 S HDR="RECIPIENTS OF ALERTS FOR PATIENT: "_ORBPT
 D OUTPUT(.ORY,DESC,HDR)
 S VALMBCK="R"
 Q
LMHDR ; header for ListMgr display
 S VALMHDR(1)="Alerts for "_ORBPT
 Q
LMHELP ; help for List Mgr display
 N X
 D FULL^VALM1 S VALMBCK="R"
 W !!,"Enter the display number of the alert whose recipients you wish to review in detail."
 W !!,"Press <return> to continue ..."
 R X:DTIME
 Q
LMEXIT ; exit code for List Mgr display
 D CLEAR^VALM1
 K ORBPT,^TMP("OR",$J,"ALERTS"),XQORM("ALT"),^TMP("ORB",$J)
 Q
LMALT ; alternative selection code
 D FULL^VALM1
 S VALMBCK="R"
 Q
LMENTRY ; entry code for List Mgr display
 N ORBA,ORBAID,ORBDT,ORBMSG,ORBX,ORNUM,ORDATA,ORAD,LCNT,NUM
 N ORX,ORY,ORBMSGP1,ORBMSGP2
 ;
 D CLEAN^VALM10
 ;
 S ORBA="" F  S ORBA=$O(^TMP("ORB",$J,ORBA)) Q:ORBA=""  D
 .S ORBX=$G(^TMP("ORB",$J,ORBA)) I $L(ORBX) D
 ..S ORBAID=$P(ORBX,U,2)
 ..Q:$P(ORBAID,",")'="OR"  ;quit if not "OR" (OE/RR Notifications) alert
 ..W "."
 ..;
 ..;get alert details:
 ..D ALERTDAT^XQALBUTL(ORBAID,"ORAD")
 ..S ORBMSG=ORAD(1.01) I $L(ORBMSG) D
 ...S ORBDT=$P(ORAD(.02),U)
 ...S ORDATA=$G(ORAD(2))
 ...S ORNUM=""
 ...I ORDATA["@" S ORNUM=$P(ORDATA,"@")
 ...S ORNUM=$S(+$G(ORNUM)>0:"["_+ORNUM_"]",1:"")
 ...S ORBMSG=$P(ORBMSG,"): ",2)
 ...S ORBMSGP1=$P(ORBMSG,":",1)   ;jeh
 ...S ORBMSGP2=$P(ORBMSG,":",2,3)   ;jeh 
 ...I $G(ORBMSGP1)="Order(s) needing clarification" D    ;jeh Shorten output to make room for OR IEN 
 ....S ORBMSGP1="Order needs clarifying"  ;jeh
 ....S ORBMSG=ORBMSGP1_":"_ORBMSGP2   ;jeh
 ...S ORBMSG=$E(ORBMSG_$S($L(ORNUM):" "_$G(ORNUM),1:"")_U_"                                                            ",1,60)
 ...S ^TMP("OR",$J,"ALERTS","B",9999999-ORBDT_ORBAID)=ORBAID_U_$P(ORBMSG,U)_U_$$FMTE^XLFDT($E(ORBDT,1,12),"2")
 ;
 S (LCNT,NUM)=0
 S ORX="" F  S ORX=$O(^TMP("OR",$J,"ALERTS","B",ORX)) Q:ORX=""  D
 .S ORY=^TMP("OR",$J,"ALERTS","B",ORX)
 .S ORBMSG=$P(ORY,U,2)
 .S ORBDT=$P(ORY,U,3)
 .S LCNT=LCNT+1,NUM=NUM+1
 .S ^TMP("OR",$J,"ALERTS","IDX",NUM)=ORY   ;alert id^text^date/time
 .S ^TMP("OR",$J,"ALERTS",LCNT,0)=$$LJ^XLFSTR(NUM,4)_$$LJ^XLFSTR(ORBMSG,61)_$$LJ^XLFSTR(ORBDT,15)
 .D CNTRL^VALM10(LCNT,1,5,IOINHI,IOINORM)
 ;
 S ^TMP("OR",$J,"ALERTS",0)=LCNT_U_NUM_U_"Patient Alerts"
 S ^TMP("OR",$J,"ALERTS","#")=$O(^ORD(101,"B","OR SELECT ALERTS",0))_"^1:"_NUM
 K VALMHDR
 S VALMCNT=LCNT,VALMBG=1,VALMBCK="R"
 Q
GETRECS(ORBAID)  ;get recipient data for an alert
 N ORX,ORBI,ORBR,ORBHX
 D AHISTORY^XQALBUTL(ORBAID,"ORBHX")
 S:$L($G(ORBHX(20,0))) ORX=$P(ORBHX(20,0),U,4)
 F ORBI=1:1:ORX D
 .S ORBR=ORBHX(20,ORBI,0)
 .S ORY(ORJ)="",ORJ=ORJ+1
 .S ORY(ORJ)=$P(^VA(200,$P(ORBR,U),0),U),ORJ=ORJ+1
 .S ORY(ORJ)="  1st displayed to recipient: "_$$FMTE^XLFDT($P(ORBR,U,2),"1"),ORJ=ORJ+1
 .S ORY(ORJ)="  1st selected by recipient:  "_$$FMTE^XLFDT($P(ORBR,U,3),"1"),ORJ=ORJ+1
 .S ORY(ORJ)="  Processed by recipient:     "_$$FMTE^XLFDT($P(ORBR,U,4),"1"),ORJ=ORJ+1
 .S ORY(ORJ)="  Deleted:                    "_$$FMTE^XLFDT($P(ORBR,U,5),"1"),ORJ=ORJ+1
 .S ORY(ORJ)="  Auto deleted:               "_$$FMTE^XLFDT($P(ORBR,U,6),"1"),ORJ=ORJ+1
 .S ORY(ORJ)="  Forwarded by:               "_$S($P(ORBR,U,7):$P(^VA(200,$P(ORBR,U,7),0),U),1:""),ORJ=ORJ+1
 .S ORY(ORJ)="  Forwarded to recipient:     "_$$FMTE^XLFDT($P(ORBR,U,8),"1"),ORJ=ORJ+1
 .S ORY(ORJ)="  Non-process deletion by:    "_$S($P(ORBR,U,9):$P(^VA(200,$P(ORBR,U,9),0),U),1:""),ORJ=ORJ+1
 Q
RECIPS ;determine/report the list of recipients for a notification
 N ORY,ORN,ORBDFN,ORNUM,ORBADUZ,DESC,HDR,ORBPR,ORDIV
 ;prompt for patient (required):
 K DIC S DIC="^DPT(",DIC("A")="PATIENT (req'd): ",DIC(0)="AEQNM" D ^DIC Q:Y<1
 S ORBDFN=+Y
 Q:$D(DUOUT)
 K DIC,Y,DUOUT,DTOUT
 ;
 ;prompt for notification (required):
 S DIC="^ORD(100.9,",DIC("A")="NOTIFICATION (req'd): ",DIC(0)="AEQN" D ^DIC Q:Y<1
 S ORN=+Y
 Q:$D(DUOUT)
 K DIC,Y,DUOUT,DTOUT
 ;
 S ORBPR=$$GET^XPAR("DIV^SYS^PKG","ORB PROVIDER RECIPIENTS",ORN,"I")
 ;
 ;prompt for order num if notif processes order num or is a flagged oi:
 I (ORN=32)!(ORN=41)!(ORN=60)!(ORN=61)!(ORN=64)!(ORN=65)!(ORBPR["O")!(ORBPR["E") D
 .K DIR S DIR(0)="NAO^::2",DIR("A")="ORDER NUMBER: "
 .S DIR("?",1)="This notification uses order number to help determine alert recipients."
 .S DIR("?",2)="Enter the order number associated with the alert for most accurate results."
 .S DIR("?",3)="Order number must be entered as a whole number (e.g. 458829)."
 .;
 .S DIR("?")=" "
 .D ^DIR
 .S ORNUM=+Y
 .I +$G(ORNUM)>0 D
 ..S ORDIV=$$ORDIV^ORB31(ORNUM)
 ..S:+$G(ORDIV)>0 ORBPR=$$GET^XPAR(ORDIV_";DIV(4,^SYS^PKG","ORB PROVIDER RECIPIENTS",ORN,"I")
 Q:$D(DUOUT)
 K DIR,Y,X,DTOUT,DUOUT,DIRUT
 ;
 ; get recipients for Lab Threshold notif:
 I ORN=68 D LABTHR^ORB3U2(.ORBADUZ,ORBDFN,$G(ORNUM))
 ;
 ;prompt for pkg-defined recips if normally occurs with notif:
 I (ORN=21)!(ORN=22)!(ORN=23)!(ORN=27)!(ORN=30)!(ORN=51)!(ORN=52)!(ORN=53)!(ORN=63) D
 .F  K DIC,Y S DIC="^VA(200,",DIC(0)="AEQN",DIC("A")="RECIPIENT(S) FROM PACKAGE WHEN NOTIF WAS TRIGGERED: " D ^DIC Q:Y<1  S ORBADUZ(+Y)=""
 Q:$D(DUOUT)
 K DIC,Y,DUOUT,DTOUT
 ;
 ;prompt for recips entered at special GUI recipients prompts:
 I (ORN=6)!(ORN=33) D
 .F  K DIC,Y S DIC="^VA(200,",DIC(0)="AEQN",DIC("A")="RECIPIENT(S) ENTERED AT GUI PROMPTS: " D ^DIC Q:Y<1  S ORBADUZ(+Y)=""
 Q:$D(DUOUT)
 K DIC,Y,DUOUT,DTOUT
 ;
 W !,"Processing, please stand by..."
 ;determine recipients and why:
 S ORY="1"
 D UTL^ORB3(.ORY,ORN,ORBDFN,$G(ORNUM),.ORBADUZ,"","")
 S DESC="Determine Notification Recipients Report"
 S HDR="DETERMINE NOTIFICATION RECIPIENTS REPORT"
 D OUTPUT(.ORY,DESC,HDR)
 Q
OUTPUT(ORY,ORBDESC,ORBHDR) ;prompt for device and send report
 N POP
 ;prompt for device:
 S %ZIS="Q"  ;prompt for Queueing
 D ^%ZIS
 Q:$G(POP)>0
 I $D(IO("Q")) D  ;queue the report
 .S ZTRTN="PRINT^ORB3U1"
 .S ZTSAVE("ORY(")="",ZTSAVE("ORBHDR")=""
 .S ZTDESC=ORBDESC
 .D ^%ZTLOAD
 .K ZTDESC,ZTRTN,ZTSAVE
 .I $D(ZTSK)[0 W !!?5,"Report canceled!"
 .E  W !!?5,"Report queued."
 .D HOME^%ZIS
 K %ZIS
 I $D(IO("Q")) K IO("Q") Q
PRINT ;print body of Determine Notification Recipients Report
 N END,PAGE,X
 S (END,PAGE,I)=0
 U IO
 D @("HDR"_(2-($E(IOST,1,2)="C-")))
 F  S I=$O(ORY(I)) Q:I=""!(END=1)  D
 .D HDR:$Y+5>IOSL
 .Q:END=1
 .W !,ORY(I)
 I END=1 W !!,"           - Report Interrupted -",!
 E  W !!!,"           - End of Report -",!
 I ($E(IOST,1,2)="C-") W !,"Press RETURN to continue: " R X:DTIME
 D ^%ZISC
 D:$G(ZTSK) KILL^%ZTLOAD
 Q
HDR ;print header of report
 I PAGE,($E(IOST,1,2)="C-") D
 .W !,"Press RETURN to continue or '^' to exit: "
 .R X:DTIME S END='$T!(X="^")
 Q:END=1
HDR1 W:'($E(IOST,1,2)='"C-"&'PAGE) @IOF
HDR2 S PAGE=PAGE+1 W ?20,ORBHDR
 W ?(IOM-10),"Page: ",$J(PAGE,3),!!
 Q
