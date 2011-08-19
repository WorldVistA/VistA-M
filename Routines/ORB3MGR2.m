ORB3MGR2 ; SLC/AEB - Utilities for Manager Options - Notifications Parameters ;4/23/96  16:53
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**9,74,85,105**;Dec 17, 1997
 ;
USERDEL ; Purge undesired alerts/notifications for a user
 N ORBDUZ,XQ1
 W !!,"This option purges an existing alert/notification for a recipient/user.",!?5,"*** USE WITH CAUTION ***"
UDEL2 D USERDEL^XQALERT
 Q
RECIPURG ; Purge existing alerts/notifications for a user
 N ORBDUZ,XQ1
 W !!,"This option purges all existing alerts/notifications for a recipient/user.",!?5,"*** USE WITH CAUTION ***"
 ;  Get user DUZ number
 K DIC,Y S DIC="^VA(200,",DIC(0)="AEQ",DIC("A")="Enter user's name: ",DIC("B")=DUZ D ^DIC Q:Y<1
 S ^TMP("ORB",$J,"ORBDUZ")=$S(Y'<1:$P(Y,"^"),1:DUZ) K DIC,Y,DUOUT,DTOUT
 S ORBDUZ=^TMP("ORB",$J,"ORBDUZ")
 S XQ1=$S($D(^TMP("ORB",$J,"ORBDUZ")):^TMP("ORB",$J,"ORBDUZ"),1:DUZ)
 W !!,$C(7),"Do you want to purge all alerts/notifications for ",$P(^VA(200,XQ1,0),"^") S %=2 D YN^DICN D
 .I %=0 W !,"Enter 'YES' if you want to purge all existing alerts for this person.",!,"Do you want to purge all notifications for this recipient" S %=2 D YN^DICN
 Q:%'=1  W !!,"Purging alerts/notifications...",!
 K %
 D RECIPURG^XQALBUTL(XQ1)
 K ^TMP("ORB",$J)
 Q
PTPURG ; Purge existing alerts/notifications for a patient
 W !!,"This option purges all existing alerts/notifications for a patient.",!?5,"*** USE WITH CAUTION ***"
 K DIC S DIC="^DPT(",DIC(0)="AENQM",DIC("A")="Enter alert/notification patient's name: " D ^DIC Q:Y<1
 K DIC,DUOUT,DTOUT
 W !!,$C(7),"Do you want to purge all alerts/notifications for patient ",$P(Y,"^",2),"?" S %=2 D YN^DICN Q:%'=1  W !!,"Purging alerts/notifications...",!
 K %
 D PTPURG^XQALBUTL(+Y)
 K Y
 Q
NOTIPURG ; Purge all instances of a notification
 W !!,"This option purges all existing instances of a notification.",!?5,"*** USE WITH CAUTION ***"
 K DIC S DIC="^ORD(100.9,",DIC(0)="AENQ",DIC("A")="Enter notification name: " D ^DIC Q:Y<1
 K DIC,DUOUT,DTOUT
 W !!,$C(7),"Do you want to purge all instances of notification ",$P(Y,"^",2),"?" S %=2 D YN^DICN Q:%'=1  W !!,"Purging all instances of this notification...",!
 K %
 D NOTIPURG^XQALBUTL(+Y)
 K Y
 Q
ERASEALL ; Edit ORB ERASE ALL parameter for a User
 N PIEN
 S PIEN=0,PIEN=$O(^XTV(8989.51,"B","ORB ERASE ALL",PIEN)) Q:PIEN=""
 D TITLE^ORB3MGR1("Set User's Ability to Erase All His Notifications/Alerts")
 D PROC^ORB3MGR1(PIEN)
 Q
USRNOTS ; List notifications a user could receive
 N ORBUSR
 ;  Get user DUZ number
 K DIC,Y S DIC="^VA(200,",DIC(0)="AEQ",DIC("A")="Enter user's name: ",DIC("B")=DUZ D ^DIC Q:Y<1
 S ORBUSR=$S(Y'<1:$P(Y,"^"),1:DUZ) K DIC,Y,DUOUT,DTOUT
 D USRNOTS^ORB3U2(ORBUSR)
 Q
LABTHRES ; set lab threshold parameter for user
 N ORBT,ORBLAB,ORBSP,ORBTHRES,ORBERR,DIC,DIR,Y
 N ORBUSR,ORBGL,ORBLABN,ORBSPN
 ;
 W !,$C(7),"Do you want to add, modify or remove lab thresholds" S %=1 D YN^DICN D
 .I %=0 W !,"Enter 'YES' if you want to add, modify or remove lab thresholds for alerts.",!,"(Enter '0' (zero) at the THRESHOLD prompt to remove a threshold.)",!,"Do you want to add, modify or remove lab thresholds" S %=1 D YN^DICN
 Q:%'=1  K %
 ;
 F  D  Q:$D(DTOUT)!($D(DUOUT))!($D(DIRUT))
 .W !
 .S DIC="^VA(200,",DIC(0)="AEQ",DIC("A")="Enter user's name (""^"" to exit): "
 .S DIC("B")=$S($G(ORBUSR):ORBUSR,1:DUZ) D ^DIC Q:Y<1
 .S ORBUSR=$S(Y'<1:$P(Y,"^"),1:DUZ) K DIC,Y,DUOUT,DTOUT
 .;
 .D DISPTHR(ORBUSR,">")
 .D DISPTHR(ORBUSR,"<")
 .W !
 .;
 .;get Lab test:
 .S DIC=60,DIC(0)="AEMQ",DIC("A")="Select LAB TEST: " D ^DIC K DIC Q:Y<1
 .S ORBLAB=+Y,ORBLABN=$P(Y,U,2)
 .;
 .;get test Specimen:
 .S DIC=61,DIC(0)="AEMQ",DIC("A")="Select SPECIMEN: " D ^DIC K DIC Q:Y<1
 .S ORBSP=+Y,ORBSPN=$P(Y,U,2)
 .;
 .S ORBLABSP=ORBLAB_";"_ORBSP
 .;
 .;get greater than or less than:
 .K DIR S DIR(0)="SO^>:Greater Than;<:Less Than",DIR("A")="Operator on Lab Value: "
 .S DIR("?")="Enter '>' to be alerted for results GREATER than the lab value or '<' to be alerted for results LESS than the lab value."
 .D ^DIR K DIR Q:$D(DIRUT)
 .S ORBGL=Y
 .;
 .;get threshold value:
 .K DIR S DIR(0)="NA^::4",DIR("A")="Enter THRESHOLD: ",DIR("?")="Enter numeric threshold value. Results above/below this value will send alert. Enter '0' (zero) to remove a threshold."
 .D ^DIR K DIR Q:$D(DIRUT)
 .S ORBTHRES=Y
 .;
 .I $G(ORBTHRES)=0 D
 ..W !,"Removing "_ORBGL_" threshold for "_ORBLABN_" "_ORBSPN_"..."
 ..D DEL^XPAR(ORBUSR_";VA(200,","ORB LAB "_ORBGL_" THRESHOLD",ORBLABSP,.ORBERR)
 ..I ORBERR W !,"Error removing lab threshold: ",$P(ORBERR,U,2)
 .I $G(ORBTHRES)>0 D
 ..D EN^XPAR(ORBUSR_";VA(200,","ORB LAB "_ORBGL_" THRESHOLD",ORBLABSP,ORBTHRES,.ORBERR)
 ..I ORBERR W !,"Error adding lab threshold: ",$P(ORBERR,U,2)
 .;
 .D DISPTHR(ORBUSR,ORBGL)
 ;I $L($G(ORBGL)),('$D(DIRUT)) D DISPTHR(ORBUSR,ORBGL)
 Q
DISPTHR(ORBUSR,ORBGL) ;display uer's ORB LAB THRESHOLD parameter values
 N ORBT,ORBA,ORBLAB,ORBLABN,ORBSP,ORBSPN
 D GETLST^XPAR(.ORBT,"USR.`"_ORBUSR,"ORB LAB "_ORBGL_" THRESHOLD","I")
 Q:+$G(ORBT)<1
 W !!,"Current "_ORBGL_" lab thresholds for ",$$GET1^DIQ(200,ORBUSR_",",.01),":"
 S ORBLAB="" F  S ORBLAB=$O(ORBT(ORBLAB)) Q:ORBLAB=""  D
 .S ORBSP=$P(ORBLAB,";",2)
 .S ORBLABN=$P(^LAB(60,+ORBLAB,0),U)
 .S ORBSPN=$P(^LAB(61,ORBSP,0),U)
 .S ORBA(ORBLABN,ORBSPN)=ORBT(ORBLAB)
 S ORBLABN="" F  S ORBLABN=$O(ORBA(ORBLABN)) Q:ORBLABN=""  D
 .S ORBSPN="" F  S ORBSPN=$O(ORBA(ORBLABN,ORBSPN)) Q:ORBSPN=""  D
 ..W !?2,ORBLABN
 ..W ?40,ORBSPN
 ..W ?65,ORBA(ORBLABN,ORBSPN)
 Q
