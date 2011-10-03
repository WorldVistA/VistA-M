IBBASWCH ;OAK/ELZ - PFSS MASTER SWITCH FUNCTIONS ;15-MAR-2005
 ;;2.0;INTEGRATED BILLING;**260**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
SWSTAT() ;get current switch status
 N IBBRTRN,X
 S X=$G(^IBBAS(372,1,1))
 S IBBRTRN=+$P(X,"^",1)_"^"_+$P(X,"^",2)
 Q IBBRTRN
 ;
ONOFF ;set switch
 N DIR,DIRUT,DUOUT,IBBDUZ,IBBTURN,IBBCURST,IBBNEWST,IBBREAS,IBBQUE,IBBSTAT,IBBDTTM,IBBFOK,X,Y,XX
 S IBBDUZ=DUZ,XX=$$CHKKEY(IBBDUZ)
 I 'XX D  Q
 .W !!,"You do not have the Security Key required to use this option.",!,"Exiting...",!!
 ;
 I XX D
 .S IBBCURST=+$G(^IBBAS(372,1,1))
 .S IBBNEWST=$S(IBBCURST:0,1:1),IBBTURN=$S(IBBNEWST:"ON",1:"OFF")
 .;
 .W !
 .K DIR,DIRUT,DUOUT,X,Y
 .S DIR(0)="YA",DIR("A")="Should the PFSS On/Off Switch be turned "_IBBTURN_" ? (Y/N): "
 .D ^DIR
 .Q:$D(DIRUT)  Q:$D(DUOUT)
 .Q:'Y
 .W !
 .K DIR,DIRUT,DUOUT,X,Y
 .S DIR(0)="FA^10:80",DIR("A")="REASON: "
 .S DIR("?")="What is the reason for changing the PFSS On/Off Switch status? [10-80 characters]"
 .D ^DIR
 .Q:$D(DIRUT)  Q:$D(DUOUT)
 .Q:(Y="^")
 .W !
 .S IBBREAS=Y
 .K DIR,DIRUT,DUOUT,X,Y
 .S DIR(0)="YA",DIR("A")="Are you sure the PFSS On/Off Switch should be turned "_IBBTURN_"? (Y/N): "
 .D ^DIR
 .Q:$D(DIRUT)  Q:$D(DUOUT)
 .Q:'Y
 .W !
 .S IBBQUE=0
 .K DIR,DIRUT,DUOUT,X,Y
 .S DIR(0)="YA",DIR("A")="Do you wish to queue this change for a later date/time ? (Y/N): "
 .S DIR("?",1)="You may queue this change to the PFSS On/Off Switch for a later date/time."
 .S DIR("?",2)="For example, you may want the change to take place during non-business"
 .S DIR("?",3)="hours."
 .S DIR("?",4)=" "
 .S DIR("?")="If you opt not to queue the change, then it will be effective immediately."
 .D ^DIR
 .Q:$D(DIRUT)  Q:$D(DUOUT)
 .Q:(Y="^")
 .I Y S IBBQUE=1
 .I 'IBBQUE D
 ..W !!,"One moment please...",!
 ..D FILE
 ..I $G(IBBFOK) W !,"The PFSS On/Off Switch is now "_IBBTURN_".",!!
 ..I '$G(IBBFOK) D
 ...W !,"No update made to PFSS On/Off Switch.",!
 ...K X,Y S IBBSTAT=$$SWSTAT^IBBAPI(),IBBTURN=$S(+IBBSTAT:"ON",1:"OFF"),Y=$P(IBBSTAT,"^",2)
 ...D DD^%DT S IBBDTTM=$P(Y,"@",2)_" on "_$P(Y,"@",1)
 ...W !,"The PFSS On/Off Switch was set to "_IBBTURN_" at "_IBBDTTM_".",!
 .I IBBQUE D
 ..S TASK=$$TASK(IBBDUZ,IBBCURST,IBBNEWST,IBBREAS,IBBTURN)
 ..I TASK W !!,"PFSS On/Off Switch change queued as Task #"_TASK_".",!
 ..I 'TASK W !!,"PFSS On/Off Switch change could not be queued.",!
 Q
 ;
FILE ;file switch status in #372
 N CURRENT,IBB,IBBIEN,IBBIENS,IBBMSG,IBBEFFDT
 ;multiple queued tasks could be for same update to switch status;
 ;do not continue if new status=current status
 S IBBFOK=0
 Q:'$$CHKKEY(IBBDUZ)
 S CURRENT=+$P($G(^IBBAS(372,1,1)),"^",1)
 I IBBNEWST=CURRENT Q
 L +^IBBAS(372,1,1):5
 I IBBNEWST'=CURRENT D
 .;change switch status
 .S IBBIEN(1)=""
 .S IBBIENS="+1,1,"
 .S IBBMSG="IBB(""DIERR"")"
 .S IBBEFFDT=$$NOW^XLFDT()
 .S FDA(372.01,IBBIENS,.01)=IBBEFFDT
 .S FDA(372.01,IBBIENS,.02)=IBBCURST
 .S FDA(372.01,IBBIENS,.03)=IBBDUZ
 .S FDA(372.01,IBBIENS,.04)=IBBREAS
 .D UPDATE^DIE("","FDA","IBBIEN",IBBMSG)
 .I '$D(IBB("DIERR")) S ^IBBAS(372,1,1)=IBBNEWST_"^"_IBBEFFDT
 L -^IBBAS(372,1,1)
 S IBBFOK=1
 Q
 ;
TASK(IBBDUZ,IBBCURST,IBBNEWST,IBBREAS,IBBTURN) ;queue switch change via TaskManager
 N ZTRTN,ZTDESC,ZTDTH,ZTSAVE,ZTSK
 Q:'$$CHKKEY(IBBDUZ) 0
 S ZTDTH=""
 S ZTIO="",ZTDESC="Set PFSS On/Off Switch to "_IBBTURN_" by "_IBBDUZ
 S ZTSAVE("IBBDUZ")="",ZTSAVE("IBBCURST")="",ZTSAVE("IBBNEWST")="",ZTSAVE("IBBREAS")=""
 S ZTRTN="FILE^IBBASWCH"
 W !
 D ^%ZTLOAD
 Q $G(ZTSK)
 ;
CHKKEY(IBBDUZ) ;does user hold security key IBB MASTER SWITCH?
 N X,Y,IBBKEY,DIC
 S IBBKEY=0
 S DIC=19.1,DIC(0)="MXZ",X="IBB MASTER SWITCH"
 D ^DIC
 I +Y'>0 Q IBBKEY
 K X,Y
 S DIC="^VA(200,"_IBBDUZ_",51,",DIC(0)="MXZ",X="IBB MASTER SWITCH"
 D ^DIC
 I +Y'>0 Q IBBKEY
 S IBBKEY=+Y
 Q IBBKEY
