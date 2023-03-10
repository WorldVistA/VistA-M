XUPROD ;ISF/RWF - Is this a PROD account. ;18/06/20
 ;;8.0;KERNEL;**284,440,542,717,742**;Jul 10, 1995;Build 1
 ;;Per VHA Directive 6402, this routine should not be modified.
 ;
 ;IA# 4440
PROD(FORCE) ;Return 1 if this is a production account
 ;A non-zero flag will force a real check
 ;This call just checks a flag in the KSP, Other code will compair
 ;with registered ID.
 I $$CFG("PRO") Q 1
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
 ;
CFG(CFG) ; RETURN BOOLEAN CHECK FOR CONFIGURATION TYPE
 ;I $G(^|"%SYS"|SYS("ZCFG"))[CFG Q $S(^|"%SYS"|SYS("ZCFG")[("-"_CFG):0,1:1)
 N X,Y S X=$$INSTNM("U")
 I CFG="PRO" I ($E(X,6)="P")&("PS0^PAD^PRD^PSH"'[$E(X,6,8)) Q 1
 I CFG="TST" I ($E(Y,1,3)=195)!($E(X,6)="T")!($L(X)=7&($E(X)="T")) Q:"TAD^TRD"[$E(X,6,8) 0 Q 1
 I CFG="BE",$E(X,7,9)="SVR" Q 1
 I CFG="FE",$E(X,7,8)="A0"!($E(X,7,8)="TM") Q 1
 I CFG="MS" I $E(X,6,9)="SHMS"!($E(X,6,8)="SSM") Q 1
 I CFG="LS" I $E(X,7,9)="LDR"!($E(X,6,8)="SSL") Q 1
 I CFG="VRO" I $E(X,6,9)="SHDW"!($E(X,6,8)="SS0")!($E(X,6,8)="SS1") Q 1
 I CFG="DR" I $E(X,7,9)="SHD"!($E(X,6,8)="PS0")!($E(X,6,8)="DR0") Q 1
 I CFG="MDR" I $E(X,6,8)="MDR" Q 1
 I CFG="HC" I $E(X,4,5)="HC" Q 1
 I CFG="PM" Q $SYSTEM.Mirror.IsPrimary()
 I CFG="BM" Q $SYSTEM.Mirror.IsBackup()
 I CFG="AM" Q $SYSTEM.Mirror.IsAsyncMember()
 I CFG="MM" Q $SYSTEM.Mirror.IsMember() ;Returns 1 for Failover members, 2 for Async members
 I CFG="CDW" I 0 Q 1
 I CFG="HS" I $SYSTEM.Version.GetMajor()>2016,$SYSTEM.Version.GetISCProduct()=3 Q 1 ; 1 = Cache, 2 = Ensemble, 3 = Healthshare, 4 = Iris
 Q 0
 ;
INSTNM(CASE) ; RETURNS INSTANCE NAME
 N XUCASE S XUCASE=$G(CASE,"U") ; PASS L for lowercase, U for UPPERCASE (DEFAULT)
 Q $ZCVT(##Class(%SYS.System).GetInstanceName(),XUCASE)
 ;
