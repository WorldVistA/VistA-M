PSXSYS ;BIR/WPB-Display CMOP System Status ;11 SEP 1998  8:38 AM
 ;;2.0;CMOP;**1,18,23,41**;11 Apr 97
 ;Reference to ^DIC(4.2 supported by DBIA #1966
 ;
 S SYSFLAG=0
SYSTEM ;displays the system status - called from the CMOP MGR menu
 S SY=$O(^PSX(550,"C",""))
 S DIC(0)="AEQMZ",DIC("A")="Enter CMOP System:  ",DIC("B")=$S(SYSFLAG=0:$G(SY),1:""),DIC=550 D ^DIC K DIC G:Y<0!($D(DUOUT))!($D(DTOUT)) EXIT S SS=+Y,SYSTEM=$P($G(Y),U,2) W !
 S MMM=$P($G(^PSX(550,+SS,0)),U,4),XCMOP=$$GET1^DIQ(4.2,MMM,.01)
M I SYSFLAG=1 S DIC(0)="AEQMZ",DIC("A")="Enter mailman domain:  ",DIC("B")=$G(XCMOP),DIC=4.2,DIC("S")="I $P($G(^DIC(4.2,+Y,0)),U,1)[""CMOP-"""
 I  D ^DIC K DIC G:(Y<1)!($D(DUOUT))!($D(DTOUT)) EXIT S PSXMDM=+Y
 I SYSFLAG=1 L +^PSX(550,+SS):30 W:'$T !!,"The CMOP System file is in use try later." Q:'$T  S DA=+SS,DIE="^PSX(550,",DR="3////"_PSXMDM D ^DIE K DIE,DA,DR,DIRUT,DTOUT,DUOUT L -^PSX(550,+SS)
SYS S CDOM=$P($G(^PSX(550,+SS,0)),U,4) S:(CDOM'="") CMOP=$$GET1^DIQ(4.2,CDOM,.01)
 S SYSSTAT=$$GET1^DIQ(550,+SS,1)
 I $D(^PSX(550,+SS,"P",0))  D
 .S PP=0 F  S PP=$O(^PSX(550,+SS,"P",PP)) Q:PP'>0  S PURG=PP,Y=$P($G(^PSX(550,+SS,"P",$G(PURG),0)),U,1) X ^DD("DD") S PDTTM=Y K Y
 I '$D(^PSX(550,+SS,"P",0)) S PURG="Files have not been purged."
 K TSK D OPTSTAT^XUTMOPT("PSXR SCHEDULED NON-CS TRANS",.TSK)
 S AUTO=$S(+$G(TSK(1)):"YES",1:"NO")
 K TSK D OPTSTAT^XUTMOPT("PSXR SCHEDULED CS TRANS",.TSK)
 S AUTOCS=$S(+$G(TSK(1)):"YES",1:"NO")
 S TSKS=+$$TSKRUN S TSKS=$S(+TSKS'>1:"NO",1:"YES")
 S XMIT=$$GET1^DIQ(550,+SS,3)
 W !!,?30,"CMOP SYSTEM STATUS"
 W !!,SYSTEM,"   (",SYSSTAT,")",?27," :",?30,XMIT
 S XX=$P($G(^PSX(550,+SS,3)),U,1) I XX S XX=$$GET1^DIQ(550.2,XX,.01)
 W !,"Last Batch Transmitted",?28,":",?30,XX K XX
 ;I $G(PURG)'="" W !,"CMOP RX Queue purged",?28,":",?30,$G(PDTTM)
 W !,"Auto Transmission setup",?28,":",?30,AUTO
 W !,"Auto CS Transmission setup",?28,":",?30,AUTOCS
 K AA,AUTO,CC,CMOP,ON,XMDUZ,XCMOP,J,AUTOCS
 I SYSFLAG=0 G EXIT
 I SYSFLAG=1 D AC^PSXSITE
 Q
EXIT K SYSFLAG,SYSTEM,SS,SY,Y,CDOM,FDOM,SYSSTAT,PP,PURG,PDTTM,XX,XMIT,STAT,AA,MMM,DTOUT,DUOUT,DIC,DIR,DIRUT,DIROUT,ACT,XMDUZ,XCMOP,J,TSK,TSKS
 Q
SET Q:'$D(^PSX(550,"C"))
 S (S1,DA)=$$KSP^XUPARAM("INST"),DIC="4",DIQ(0)="IE",DR=".01;99",DIQ="PSXUTIL" D EN^DIQ1 S S3=$G(PSXUTIL(4,S1,99,"I")),S2=$G(PSXUTIL(4,S1,.01,"E")) K DA,DIC,DIQ(0),DR
 S PSXSYS=+$O(^PSX(550,"C",""))_"^"_$G(S3)_"^"_$G(S2)
 I $G(S3)="" S PSXER=$G(PSXER)_"^"_11 D ER1^PSXERR K PSXER Q
 K S3,S2,S1,PSXUTIL
 Q
DEACT W !!
 D DEACT^PSXRHLP
 S ACT=0 F  S ACT=$O(^PSX(550,"C",ACT)) Q:ACT'>0  S (DA,SS)=ACT,SYSTEM=$P($G(^PSX(550,SS,0)),U,1)
 Q:SYSTEM=""
 S DIR(0)="Y",DIR("A")="Do you want to Inactivate the "_SYSTEM_" system",DIR("A",1)=SYSTEM_" is the current active CMOP system."
 S DIR("A",2)=" ",DIR("B")="NO" D ^DIR K DIR G:(Y=0)!($D(DIRUT)) EXIT K DIR,DIRUT,DUOUT,DTOUT
 W !!
 S DIR(0)="Y",DIR("A")="Are you sure",DIR("A",1)=" ",DIR("B")="NO"
 D ^DIR K DIR G:(Y=0)!($D(DIRUT)) EXIT K DIR,DIRUT,DUOUT,DTOUT
 L +^PSX(550,SS):30 I '$T W !!,"The CMOP System file is in use, try later." Q
 S STAT="I",DIE="^PSX(550,",DA=SS,DR="1////"_STAT D ^DIE K DIE,DA L -^PSX(550,SS) W !
 ;I $D(^PSX(550,"AT")) S ATREC=$O(^PSX(550,"AT","")),PTSK=$P($G(^PSX(550,1,"T",ATREC,0)),"^",7) S DIE="^PSX(550,1,""T"",",DR=".01////2;6////@",DA(1)=+$G(PSXSYS),DA=ATREC D ^DIE K DIE,DR,DA,ATREC S ZTSK=PTSK D KILL^%ZTLOAD K PTSK,ZTSK
 D RESCH^XUTMOPT("PSXR SCHEDULED NON-CS TRANS","@") ;remove scheduling
 D RESCH^XUTMOPT("PSXR SCHEDULED CS TRANS","@")
 F XX=13,14 S ZTSK=$$GET1^DIQ(550,+PSXSYS,XX) I ZTSK D KILL^%ZTLOAD ;remove pending tasks
 K DR,DIC,DA,DIE
 S DIE=550,DA=+PSXSYS,DR="2////H;13///@;14///@" L +^PSX(550,DA) D ^DIE
 L -^PSX(550,DA) K DR,DA,DIC,DIE
 S SYSFLAG=0 D NOTE^PSXSITE
 S DIR(0)="Y",DIR("A")="Activate another system",DIR("A",1)="The "_SYSTEM_" system has been inactivated.",DIR("B")="NO" D ^DIR K DIR G:(Y=0)!($D(DIRUT)) EXIT
 K Y,DIRUT,DUOUT,DTOUT
 S SYSFLAG=1
 K ACT
 D SYSTEM^PSXSYS
 Q
TSKRUN() ;return list of tasks if tasks are running/pending or 1 if Transmitting only ;; 2:"TR",13:"AE",14:"AF",9:"AG" ;
 I '$D(^PSX(550,"AE")),'$D(^PSX(550,"AF")),'$D(^PSX(550,"AG")),'$D(^PSX(550,"TR","T")),'$D(^PSX(550,"TR","R")) Q 0
 N XX,YY,ZZ S ZZ=""
 F XX="AE","AF","AG" F YY=0:0 S YY=$O(^PSX(550,XX,YY)) Q:YY'>0  S ZZ=ZZ_YY_"^"
 S:'+ZZ ZZ=1 ; "TR","T" or "TR","R" found
 Q ZZ
