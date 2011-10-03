DGPTMSG1 ;ALB/AS - Format PTF Messages ; 7 NOV 89 @ 0800
 ;;5.3;Registration;**61**;Aug 13, 1993
 ;
DICN ; -- add message entry
 I $P(^DG(43,1,0),"^",40)=0 S Y=-1 G DICNQ
DICN1 S DINUM=$P(^DGM(0),"^",3)
L S DINUM=DINUM+1 L ^DGM(DINUM):1 I '$T!($D(^DGM(DINUM))) L  G L
 S DIC="^DGM(",DIC("DR")="[DG PTF ADD MESSAGE]",DIC(0)="L",X=DINUM K DD,DO D FILE^DICN
DICNQ K DINUM,DIC Q
 ;
DS ;called for Deleted Discharge Date Message
 S Y=$S($D(DGPMP):$E(+DGPMP,1,12),1:"") X ^DD("DD") S DGMSG="A discharge date"_$S($D(DGPMP):" of "_Y,1:" ")_" was deleted by "_$P(^VA(200,+DUZ,0),U)_". Please verify PTF files."
 D MSG Q
 ;
MSG ; -- generic call to add DGMSG to PTF MESSAGE file
 ;    input: DFN and DGMSG
 ;
 D DICN
 I +Y>0 S DA=+Y,DGADMTY=$P(DGPMAN,"^",4) D QU
 K DGMSG,DGMSG1 Q
 ;
MOV ; -- called for Patient Admitted Message, Diagnosis Change Message
 Q:'$D(DGPMCA)!('$D(DGPMDA))
 K DGMSG D DICN G MOVQ:Y<0 S DA=+Y
 F X=0:0 S X=$O(^DGPM(DGPMDA,"DX",X)) Q:X'>0  S ^DGM(DA,"M",X,0)=^DGPM(DGPMDA,"DX",X,0)
 S ^DGM(DA,"M",0)=$S($D(^DGPM(DGPMDA,"DX",0)):^(0),1:"")
 S DGADMTY=$P(^DGPM(DGPMCA,0),"^",4) D QU
MOVQ Q
 ;
QU ; -- que message to print
 G QUQ:'$P(^DG(43,1,0),"^",31)
 S DGADMTY=$S($D(DGADMTY):DGADMTY,1:""),DGMISD=""
 I $D(^DIC(42,+$P(DGPMAN,"^",6),0)) S DGZ=$P(^(0),"^",11),DGMISD=$S($D(^DG(40.8,+DGZ,"DEV")):$P(^("DEV"),"^",4),1:"")
 I DGMISD="" S DGMISD=$P(^DG(43,1,0),"^",19) G QUQ:DGMISD=""
 S DGPGM="PR^DGPTMSG",DGVAR="DGADMTY^DA",ZTIO=DGMISD,DGUTQND=""
 D Q1^DGUTQ I '$G(DGQUIET) W !!,"**** "_$S($D(DGMSG1):DGMSG1_" ",1:"")_"Message Transmitted to MIS ****",!
QUQ K DGMSG1,DGMSG,DGADMTY,DGPGM,DGUTQND,DGVAR,DIC,DGZ,X,Y,DA,DGMISD Q
