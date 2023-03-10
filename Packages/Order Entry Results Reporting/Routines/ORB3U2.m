ORB3U2 ; SLC/CLA - OE/RR 3 Notifications Utilities routine two ;Dec 06, 2021@15:40
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**9,74,105,179,498,405**;Dec 17, 1997;Build 211
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
WHRECIP(ORBADUZ,ORN,ORBDFN,ORBU) ;returns Women's Health notif recipients
 N ORSOURCE,ORTYPE,ORREF,ORPROV,ORDIV,ORSTATUS,ORPKG,ORSUBSCRIPT,ORINVDATE
 N ORLABDFN,OREXIT,DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 I $G(ORN)=86 D  Q:$D(DUOUT) 0
 .F  D  Q:($G(ORDIV)>0)!($G(OREXIT))
 ..S DIR(0)="NAO"_U_"::2"_U,DIR("A")="ORDER NUMBER: "
 ..S DIR("?",1)="When a laboratory pregnancy test result indicates a status that conflicts with"
 ..S DIR("?",2)="the pregnancy status stored in the Women's health package, the PREGNANCY STATUS"
 ..S DIR("?",3)="REVIEW notification uses the order associated with that result to determine"
 ..S DIR("?",4)="alert recipients. Enter the order number associated with the laboratory"
 ..S DIR("?",5)="pregnancy test result. Order number must be entered as a whole number"
 ..S DIR("?")="(e.g. 458829) and is optional."
 ..S DIR(0)=DIR(0)_"I ($P($G(^OR(100,X,0)),U,2)'="""_ORBDFN_";DPT("")"
 ..S ORSTATUS=+$O(^ORD(100.01,"B","COMPLETE",0))
 ..I ORSTATUS<1 D  Q
 ...W !,"Could not find an entry named COMPLETE in the ORDER STATUS file (#100.01).",!
 ...W "Selection of a laboratory order is not possible at this time.",!
 ...S OREXIT=1
 ..S DIR(0)=DIR(0)_"!($P($G(^OR(100,X,3)),U,3)'="_ORSTATUS_")"
 ..S ORPKG=$$FIND1^DIC(9.4,"","","LAB SERVICE")
 ..I ORPKG="" D  Q
 ...D MSG^DIALOG("WE")
 ...K ^TMP("DIERR",$J)
 ...W !,"Selection of a laboratory order is not possible at this time.",!
 ...S OREXIT=1
 ..S DIR(0)=DIR(0)_"!($P($G(^OR(100,X,0)),U,14)'="_ORPKG_")"
 ..S DIR(0)=DIR(0)_"!($P($G(^OR(100,X,4)),"";"",4)="""")"
 ..S DIR(0)=DIR(0)_"!($P($G(^OR(100,X,4)),"";"",5)="""") K X"
 ..D ^DIR
 ..I +Y<1 S OREXIT=1 Q
 ..S ORREF=$G(^OR(100,+Y,4)),ORPROV=+$P($G(^OR(100,+Y,0)),U,4)
 ..K DIR,X,Y
 ..I ORPROV>0 S ORBADUZ(ORPROV)="ORDERING PROVIDER"
 ..S ORLABDFN=+$G(^DPT(ORBDFN,"LR"))
 ..I (ORLABDFN=0)!('$D(^LR(ORLABDFN))) D  Q
 ...W !,"Could not find the patient's entry in the LAB DATA file (#63).",!
 ...W "Selection of a laboratory order is not possible at this time.",!
 ...S OREXIT=1
 ..S ORSUBSCRIPT=$P(ORREF,";",4),ORINVDATE=$P(ORREF,";",5)
 ..S ORDIV=+$G(^LR(ORLABDFN,ORSUBSCRIPT,ORINVDATE,"RF"))
 ..I ORDIV<1 D  Q
 ...W !,"Could not retrieve the releasing site from the LAB DATA file (#63).",!
 ...K ORDIV
 ..S ORSOURCE="LAB"
 I $G(ORSOURCE)="" D  Q:$D(DIRUT) 0
 .S DIR(0)="PA"_U_"44:EQV",DIR("A")="LOCATION FOR CURRENT ACTIVITY (req'd): "
 .S DIR("?",1)="When an ICD code is added to an encounter or a problem is added to the problem"
 .S DIR("?",2)="list, the notification uses the location for current activities at the time of"
 .S DIR("?",3)="addition to determine the alert recipients. Enter the location associated with"
 .S DIR("?")="the hypothetical activity."
 .S DIR("S")="I (""C""[$P($G(^SC(Y,0)),U,3)),($$ACTLOC^ORWU(Y))"
 .D ^DIR
 .Q:$D(DIRUT)
 .S ORDIV=$P($G(^SC(+Y,0)),U,4)
 .I +ORDIV<1 D
 ..S ORDIV=+$$SITE^VASITE(,+$P($G(^SC(+Y,0)),U,15))
 ..I ORDIV>0 Q
 ..W !,"Unable to obtain a valid location; using your sign-on division instead.",!
 ..S ORDIV=DUZ(2)
 .S ORSOURCE="CODE"
 S ORTYPE=$E($P($G(^ORD(100.9,ORN,0)),U,1),1)
 D GETRECIPS^WVRPCPT1(.ORBADUZ,ORBDFN,ORSOURCE,ORTYPE,1,$G(ORDIV))
 I $G(ORBADUZ(0))'="" D
 .S ORBU=1+$G(ORBU),ORBU(ORBU)="WOMEN'S HEALTH: "_$P(ORBADUZ(0),U,2)
 .K ORBADUZ(0)
 Q 1
GETRCPNT(ORY,ALERTID) ;
 N I,IDX,USERNAME,XQALUSRS,FIRST,SORT
 D USERLIST^XQALBUTL(ALERTID)
 S IDX=0,FIRST=1
 S I=0 F  S I=$O(XQALUSRS(I)) Q:'I  D
 . S USERNAME=$P(XQALUSRS(I),U,2)
 . I $L(USERNAME) D
 . . I FIRST S FIRST=0,IDX=IDX+1,ORY(IDX)="Alert Recipients:"
 . . S SORT(USERNAME)=""
 I $D(SORT) S I="" F  S I=$O(SORT(I)) Q:I=""  S IDX=IDX+1,ORY(IDX)="  "_I
 Q
