ORB3U2 ; slc/CLA - OE/RR 3 Notifications Utilities routine two ;5/19/97  11:07 [ 04/02/97  2:09 PM ]
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**9,74,105,179**;Dec 17, 1997
 Q
USRNOTS(ORBUSR) ;  generate a list of notifs indicating user's recip status
 I +$G(ORBUSR)<1 S ORBUSR=DUZ
 N ORY,ORYI,ORBY,ORBIEN,ORBNAM,NODE,ORX,DESC,HDR,ORBENT,ORDIV,ORZ
 ;
 ;get ORBUSR's Division:
 I $$DIV4^XUSER(.ORZ,ORBUSR) D
 .S ORDIV=0,ORDIV=$O(ORZ(ORDIV))
 .I +$G(ORDIV)>0 S ORBENT=ORDIV_";DIC(4,^SYS^PKG"
 I '$L($G(ORBENT)) S ORBENT="SYS^PKG"
 ;
 S ORYI=1
 ;
 ;prompt for additional information:
 W !!,"Would you like help understanding the list of notifications" S %=2 D YN^DICN I %=1 D HLPMSG
 K %
 ;
 ;see if notification system is disabled:
 S ORX=$$GET^XPAR(ORBENT,"ORB SYSTEM ENABLE/DISABLE",1,"I")
 I ORX="D" D
 .S ORY(ORYI)="Notifications is disabled. No notifications will be processed or delivered."
 .S DESC="Notification possibilities for a user"
 .S NODE=$G(^VA(200,ORBUSR,0)) S:$L($G(NODE)) HDR="Notification List for "_$P(NODE,U)
 .D OUTPUT(.ORY,DESC,HDR)
 Q:ORX="D"
 ;
 W !!,"This will take a moment or two, please stand by."
 ;
 S ORY(ORYI)="Notification                      ON/OFF For This User and Why",ORYI=ORYI+1
 S ORY(ORYI)="--------------------------------  ---------------------------------------------",ORYI=ORYI+1
 ;
 ;loop thru all notifications and determine recipient status:
 S ORBNAM="" F  S ORBNAM=$O(^ORD(100.9,"B",ORBNAM)) Q:ORBNAM=""  D
 .S ORBIEN=0,ORBIEN=$O(^ORD(100.9,"B",ORBNAM,ORBIEN)) I +$G(ORBIEN)>0 D
 ..S ORBY(ORBNAM)=ORBIEN
 ..S ORX=$$ONOFF^ORB3USER(ORBIEN,ORBUSR,"","") I $L($G(ORX)) D
 ...W "."
 ...S ORBNAM=$E(ORBNAM_"                                ",1,32)
 ...S ORY(ORYI)=ORBNAM_"  "_$E($P(ORX,U)_"   ",1,5)_$P(ORX,U,3),ORYI=ORYI+1
 ;
 S ORYI=ORYI+1,ORY(ORYI)="",ORYI=ORYI+1,ORY(ORYI)="",ORYI=ORYI+1
 S DESC="Notification possibilities for a user"
 S NODE=$G(^VA(200,ORBUSR,0)) S:$L($G(NODE)) HDR="Notification List for "_$P(NODE,U)
 D OUTPUT(.ORY,DESC,HDR)
 Q
HLPMSG ;display/print help message for a user's notifications
 N ORY,ORYI
 S ORYI=1
 S ORY(ORYI)="The delivery of notifications as alerts is determined from values set for:",ORYI=ORYI+1
 S ORY(ORYI)="Users, OE/RR Teams, Service/Sections, Inpatient Locations,",ORYI=ORYI+1
 S ORY(ORYI)="Hospital Divisions, Computer System and Order Entry/Results Reporting.",ORYI=ORYI+1
 S ORY(ORYI)="Possible values include 'Enabled', 'Disabled' and 'Mandatory'. These values",ORYI=ORYI+1
 S ORY(ORYI)="indicate a User's, OE/RR Team's, Service's, Location's, Division's, System's",ORYI=ORYI+1
 S ORY(ORYI)="and OERR's desire for the notification to be 'Enabled' (sent under most",ORYI=ORYI+1
 S ORY(ORYI)="conditions), 'Disabled' (not sent), or 'Mandatory' (almost always sent.)",ORYI=ORYI+1
 S ORY(ORYI)="",ORYI=ORYI+1
 S ORY(ORYI)="All values, except the OERR (Order Entry) value, can be set by IRM",ORYI=ORYI+1
 S ORY(ORYI)="or Clinical Coordinators. Individual users can set 'Enabled/Disabled/Mandatory'",ORYI=ORYI+1
 S ORY(ORYI)="values for each specific notification via the 'Enable/Disable My Notifications'",ORYI=ORYI+1
 S ORY(ORYI)="option under the Personal Preferences and Notification Mgmt Menu option menus.",ORYI=ORYI+1
 S ORY(ORYI)="'ON' indicates the user will receive the notification under normal conditions.",ORYI=ORYI+1
 S ORY(ORYI)="'OFF' indicates the user normally will not receive the notification.",ORYI=ORYI+1
 S ORY(ORYI)="Notification recipient determination can also be influenced by patient",ORYI=ORYI+1
 S ORY(ORYI)="location (inpatients only.) This list does not consider patient location",ORYI=ORYI+1
 S ORY(ORYI)="when calculating the ON/OFF value for a notification.",ORYI=ORYI+1
 S ORY(ORYI)="",ORYI=ORYI+1,ORY(ORYI)="",ORYI=ORYI+1
 S DESC="Help Message - notification possibilities for a user"
 S HDR="Notification List Help Message"
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
 .K ZTRTN,ZTSAVE,ZTDESC
 .I $D(ZTSK)[0 W !!?5,"Report canceled!"
 .E  W !!?5,"Report queued."
 .D HOME^%ZIS
 K %ZIS
 I $D(IO("Q")) K IO("Q") Q
PRINT ;print body of List User's Notifications Report
 N END,PAGE,I,X
 S (END,PAGE,I)=0
 U IO
 D @("HDR"_(2-($E(IOST,1,2)="C-")))
 F  S I=$O(ORY(I)) Q:I=""!(END=1)  D
 .D HDR:$Y+5>IOSL
 .Q:END=1
 .W !,ORY(I)
 I END=1 W !!,"           - Report Interrupted -",!
 E  W "           - End of Report -",!
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
LABTHR(ORBADUZ,ORBDFN,ORNUM) ;returns Lab Threshold notif recipients
 ;ORBADUZ:  array of notif recipients
 ;ORBDFN:   patient identifier
 ;ORNUM:    order number (may or may not exist)
 ;
 N ORNUMOI,ORLAB,ORSPEC,ORY,ORI,ORSLT,ORLABSP,OROP,ORX,ORERR,ORPENT,ORPVAL
 ;
 I '$L($G(ORNUM)) D  ;prompt for order number
 .K DIR S DIR(0)="NAO^::2",DIR("A")="ORDER NUMBER: "
 .S DIR("?",1)="The Lab Threshold Exceeded notification uses lab order results to determine"
 .S DIR("?",2)="alert recipients. Enter the order number associated with the lab result."
 .S DIR("?",3)="Order number must be entered as a whole number (e.g. 458829)."
 .;
 .S DIR("?")=" "
 .D ^DIR
 .S ORNUM=+Y
 Q:$D(DUOUT)
 K DIR,Y,X,DTOUT,DUOUT,DIRUT
 ;
 Q:+$G(ORNUM)<1
 S ORNUMOI=$$OI^ORQOR2(ORNUM)
 Q:+$G(ORNUMOI)<1
 S ORLAB=+$P(^ORD(101.43,ORNUMOI,0),U,2)
 S ORSPEC=$$VALUE^ORCSAVE2(ORNUM,"SPECIMEN")
 D ORDER^ORQQLR(.ORY,ORBDFN,ORNUM)
 Q:'$D(ORY)  ;quit if no results found
 S ORI=0 F  S ORI=$O(ORY(ORI)) Q:+$G(ORI)<1  D
 .I ORLAB=$P(ORY(ORI),U) S ORSLT=$P(ORY(ORI),U,3)
 Q:+$G(ORSLT)=0  ;quit if result is non-numeric or null
 ;
 S ORLABSP=ORLAB_";"_ORSPEC
 F OROP="<",">" D
 .D ENVAL^XPAR(.ORX,"ORB LAB "_OROP_" THRESHOLD",ORLABSP,.ORERR)
 .Q:+$G(ORERR)'=0
 .Q:+$G(ORX)=0
 .S ORPENT="" F  S ORPENT=$O(ORX(ORPENT)) Q:'ORPENT  D
 ..S ORPVAL=ORX(ORPENT,ORLABSP)
 ..I $L(ORPVAL) D
 ...I $P(ORPENT,";",2)="VA(200,",@(ORSLT_OROP_ORPVAL) D
 ....S ORBADUZ(+ORPENT)=""
 Q
