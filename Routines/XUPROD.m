XUPROD ;ISF/RWF - Is this a PROD account. ;04/12/10  14:04
 ;;8.0;KERNEL;**284,440,542**;Jul 10, 1995;Build 5
 ;
 ;IA# 4440
PROD(FORCE) ;Return 1 if this is a production account
 ;A non-zero flag will force a real check
 ;This call just checks a flag in the KSP, Other code will compair
 ;with registered ID.
 N LC,SID
 S SID=$G(^XTV(8989.3,1,"SID"))
 I '$L($P(SID,"^",3))!($P(SID,"^",3)'=$G(DT))!$G(FORCE) D
 . D CHECK S SID=$G(^XTV(8989.3,1,"SID"))
 Q +$P(SID,"^",1)
 ;
CHECK ;Check if SID matched stored value, Set field 501
 N CSID,SSID,FDA
 L +^XTV(8989.3,1,"SID"):2
 S CSID=$$SID^%ZOSV,SSID=$P($G(^XTV(8989.3,1,"SID")),"^",2)
 S FDA(8989.3,"1,",501)=(CSID=SSID),FDA(8989.3,"1,",503)=$$DT^XLFDT
 D FILE^DIE("","FDA")
 L -^XTV(8989.3,1,"SID")
 Q
 ;
SSID(SID) ;Set the SID into KSP.
 N FDA
 S FDA(8989.3,"1,",502)=SID,FDA(8989.3,"1,",503)="@"
 L +^XTV(8989.3,1,"SID"):2
 D FILE^DIE("","FDA")
 L -^XTV(8989.3,1,"SID")
 Q
ASK ;Ask user if this is prod.
 N DIR,P,P2,T,Y S P=$$PROD
 S DIR(0)="YO",DIR("A")="Is this a Production Account",DIR("B")=$S(P:"Yes",1:"No")
 S DIR("A",1)=""
 S DIR("A",2)="This is currently a "_$S(P:"PRODUCTION",1:"TEST")_" account."
 S DIR("A",3)=" "
 S DIR("A",4)="Only answer YES if this is the full time Production Account."
 S DIR("A",5)="Answer No for all other accounts.",DIR("A",6)=""
 D ^DIR S T=Y Q:$D(DIRUT)
 K DIR
 S DIR(0)="YO"
 S DIR("A",1)="",DIR("A",2)="Are you sure you want to change from a "_$S(P:"PRODUCTION",1:"TEST")_" account"
 S DIR("A")="to a "_$S(Y:"PRODUCTION",1:"TEST")_" account",DIR("B")="No"
 D:P'=Y ^DIR
 I Y=1 D SSID($$SID^%ZOSV):T=1,SSID("2~TEST~999"):T=0
 S P2=$$PROD
 W !!,"This is "_$S(P=P2:"still",1:"now")_" a "_$S(P2:"PRODUCTION",1:"TEST")_" account.",!
 Q
 ;
EDIT ;Edit Logical - Physical fields
 N DIE,DA,DR
 L +^XTV(8989.3,1,"SID"):$G(DILOCKTM,5) E  W !,"Busy, Please try again later.",! Q  ;p542
 W !!,"This is only valid in a Cache v5.2 client/server configuration."
 W !,"This lets you edit the fields that support the"
 W !,"LOGICAL to PHYSICAL translation for the System ID.",!!
 S DA=1,DIE="^XTV(8989.3,",DR="504;505" D ^DIE
 L -^XTV(8989.3,1,"SID")
 Q
