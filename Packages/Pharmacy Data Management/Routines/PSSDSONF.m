PSSDSONF ;BIR/RTR-Dosing On/Off Parameter ;07/09/12
 ;;1.0;PHARMACY DATA MANAGEMENT;**160**;9/30/97;Build 76
 ;
EN ;Turn Dosing On and Off
 N PSSDONA,PSSDONLK,PSSDONR,PSSDONTS,DIC,DIE,DA,DR,DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 S PSSDONA=$P($G(^PS(59.7,1,81)),"^"),PSSDONTS=1 I '$$PROD^XUPROD S PSSDONTS=0
 W !!?5,$S(PSSDONA:"Dosing Order Checks are currently ENABLED.",1:"WARNING! Dosing Order Checks are currently DISABLED.")
 I PSSDONA G ON
 W !!,"No Dosing Order Checks will be performed during order entry in CPRS or",!,"Pharmacy while Dosing Order Checks are disabled!!!"
 D LCK I 'PSSDONLK D END Q
 W ! K DIR,DTOUT,DUOUT S DIR(0)="Y",DIR("B")="YES",DIR("A")="Do you wish to ENABLE Dosing Order Checks"
 S DIR("?",1)="Enter 'YES' to enable all Dosing Order Checks for Outpatient Pharmacy,"
 S DIR("?")="Inpatient Medications and Computerized Patient Record System (CPRS)."
 D ^DIR K DIR I Y'=1!($D(DTOUT))!($D(DUOUT)) W !!?5,"WARNING! Dosing Order Checks remain DISABLED." D  D UNLCK,END Q
 .W !!,"NO Dosing Order Checks will be performed during order entry in CPRS",!,"or Pharmacy while Dosing Order Checks are disabled!!!"
 K PSSDONR K ^TMP("DIERR",$J) S PSSDONR(59.7,"1,",95)=1 D FILE^DIE("","PSSDONR") K ^TMP("DIERR",$J)
 I '$P($G(^PS(59.7,1,81)),"^") W !!?5,"UNABLE to enable Dosing Order Checks! Please contact",!?5,"local support for assistance." D UNLCK,END Q
 W !!?5,"Dosing Order Checks ENABLED.",! D TMES
 D SEND(1,0),SEND(1,1) D UNLCK,END Q
 Q
 ;
 ;
ON ;
 D LCK I 'PSSDONLK D END Q
 W ! K DIR,DTOUT,DUOUT S DIR(0)="Y",DIR("B")="NO",DIR("A")="Do you wish to DISABLE Dosing Order Checks"
 S DIR("?",1)="Enter 'YES' to disable all Dosing Order Checks for Outpatient Pharmacy,"
 S DIR("?")="Inpatient Medications and CPRS."
 D ^DIR K DIR I Y'=1!($D(DTOUT))!($D(DUOUT)) W !!?5,"Dosing Order Checks remain ENABLED." D UNLCK,END Q
 W ! K DIR,DTOUT,DUOUT S DIR(0)="Y",DIR("B")="NO",DIR("A")="to take this action"
 S DIR("A",1)="Have you received authorization from Pharmacy Benefits Management (PBM)"
 S DIR("?",1)="To turn Dosing Off, authorization must first come from Pharmacy",DIR("?")="Benefits Management (PBM)."
 D ^DIR I Y'=1!($D(DTOUT))!($D(DUOUT)) W !!?5,"Dosing Order Checks remain ENABLED." D UNLCK,END Q
 W !!,"NO Dosing Order Checks will be performed during order entry in CPRS"
 W !,"or Pharmacy while Dosing Order Checks are disabled!!!",!!,"Notification of this action will be sent to PBM and local VistA"
 W !,"PSS ORDER CHECKS mail group."
 W ! K DIR,DTOUT,DUOUT S DIR(0)="Y",DIR("B")="NO",DIR("A")="Are you sure you want to DISABLE Dosing Order Checks"
 S DIR("?",1)="Enter 'YES' to disable all Dosing Order Checks for Outpatient Pharmacy,"
 S DIR("?")="Inpatient Medications and CPRS."
 D ^DIR K DIR I Y'=1!($D(DTOUT))!($D(DUOUT)) W !!?5,"Dosing Order Checks remain ENABLED." D UNLCK,END Q
 K PSSDONR K ^TMP("DIERR",$J) S PSSDONR(59.7,"1,",95)=0 D FILE^DIE("","PSSDONR") K ^TMP("DIERR",$J)
 I $P($G(^PS(59.7,1,81)),"^") W !!?5,"UNABLE to disable Dosing Order Checks! Please contact",!?5,"local support for assistance." D UNLCK,END Q
 W !!?5,"Dosing Order Checks DISABLED.",! D TMES
 D SEND(0,0),SEND(0,1) D UNLCK,END Q
 Q
 ;
 ;
TMES ;Write final message
 I 'PSSDONTS W !,"Note: This is a TEST account. This request will NOT be sent forward to PBM",!,"on Outlook mail." Q
 W !,"NOTIFICATION OF THIS ACTION has been forwarded to PBM and local",!,"VistA PSS ORDER CHECKS mail group."
 Q
 ;
 ;
SEND(PSSDONW,PSSDONAB) ;Send mail message
 I 'PSSDONTS,PSSDONAB Q
 N XMTEXT,XMY,XMSUB,XMDUZ,XMMG,XMSTRIP,XMROU,XMDUN,DIFROM,XMYBLOB,XMZ,X,Y,%,%H,%I,%DT,PSSDONSC,PSSDONLC,PSSDONDZ
 S XMSUB="DOSING ORDER CHECKS "_$S(PSSDONW:"ENABLED",1:"DISABLED")
 S XMDUZ=DUZ
 D NOW^%DTC S Y=%,%DT="S" D DD^%DT S PSSDONSC=Y
 S PSSDONLC=$P($$SITE^VASITE(),"^",2)
 S PSSDONDZ=$$GET1^DIQ(200,DUZ_",",.01)
 K ^TMP($J,"PSSDSOTX")
 I PSSDONAB D
 .S ^TMP($J,"PSSDSOTX",1,0)=$G(PSSDONDZ)_" from "_$G(PSSDONLC)
 .S ^TMP($J,"PSSDSOTX",2,0)="has "_$S(PSSDONW:"ENABLED",1:"DISABLED")_" Dosing Order Checks on "_$G(PSSDONSC)_"."
 I 'PSSDONAB D
 .S ^TMP($J,"PSSDSOTX",1,0)=$G(PSSDONDZ)_" has "_$S(PSSDONW:"ENABLED",1:"DISABLED")_" Dosing Order Checks on "_$G(PSSDONSC)_"."
 S XMTEXT="^TMP($J,""PSSDSOTX"","
 I 'PSSDONAB D 
 .S XMY(DUZ)=""
 .S XMY("G.PSS ORDER CHECKS")=""
 I PSSDONTS,PSSDONAB  S XMY("MOCHADOSINGDISCONNECTNOTIFY@domain.ext")=""
 D ^XMD
 K ^TMP($J,"PSSDSOTX")
 Q
 ;
 ;
LCK ;Lock node
 S PSSDONLK=0 L +^PS(59.7,1,81):$S($G(DILOCKTM)>0:DILOCKTM,1:3) I '$T W !!,"Another person is editing the Dosing On/Off Switch." Q
 S PSSDONLK=1
 Q
 ;
 ;
UNLCK ;Unlock node
 L -^PS(59.7,1,81)
 Q
 ;
 ;
END ;
 K DIR W ! S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR K DIR W !
 Q
 ;
 ;
ACLOG ;Set activity log multiple for DOSING ON/OFF switch.
 I $G(X1(1))=$G(X2(1)) Q
 N PSSDHAH,PSSDHAHX,%,%H,%I,X
 S PSSDHAH("DA")=DA
 D NOW^%DTC S PSSDHAHX(59.782,"+1,"_PSSDHAH("DA")_",",.01)=%
 S PSSDHAHX(59.782,"+1,"_PSSDHAH("DA")_",",1)=$G(DUZ)
 S PSSDHAHX(59.782,"+1,"_PSSDHAH("DA")_",",2)=$G(X2(1))
 K ^TMP("DIERR",$J)
 D UPDATE^DIE("","PSSDHAHX")
 K ^TMP("DIERR",$J)
 Q 
