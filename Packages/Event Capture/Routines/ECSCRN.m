ECSCRN ;BIR/MAM,JPW,RKH,TTH-Enter Event Code Screens ;1 May 96
 ;;2.0; EVENT CAPTURE ;**4,5,33,47**;8 May 96
 I $O(^DIC(4,"LOC",""))="" W !!,"You have no locations flagged for event capture.",!,"See your program coordinator.",!! W "Press <RET> to continue  " R X:DTIME K X Q
 W @IOF,!,"Event Code Screens (Create)",! F XX=0:1:79 W "-"
 S (MSG1,MSG2)=0
UNIT W ! K DIC S ECNOPE="",DIC=724,DIC(0)="QEAMZ",DIC("A")="Select DSS Unit : ",DIC("S")="I $P($G(^(0)),""^"",8)=1,'$P(^(0),""^"",6)" D ^DIC G:Y<0 END S ECD=+Y,ECDN=$P(Y,"^",2)
 S ECS=$P(^ECD(ECD,0),"^",2),ECM=$P(^(0),"^",3),ECPCE="U~"_$S($P($G(^(0)),"^",14)]"":$P(^(0),"^",14),1:"N"),ECSN=$P(^DIC(49,ECS,0),"^"),ECMN=$P(^ECC(723,ECM,0),"^")
 K ECN,ECL
 D BRO I $D(ECERR) G END
 G PRO
PRO W:$D(ECN) !,"DSS UNIT: "_ECDN,! K DIC,DIR,DUOUT S DIR(0)="720.3,52.1",DIR("A")="Select Procedure" D ^DIR K DIR G:$D(DUOUT)!($D(DTOUT)) END
 I X=""!("@"[X) G END
 S ECFIL="^"_$P(Y,";",2)
 S ECZERO=@(ECFIL_+Y_",0)"),DSERR=0
 I $E(ECFIL,2)="E" D  I DSERR S DSERR=0 G PRO
 .I $P($G(ECZERO),U,3) W !,"Selected procedure is inactive at this time.",! S DSERR=1 Q
 I $E(ECFIL,2)="I" D  I DSERR S DSERR=0 G PRO
 .I '$P($$CPT^ICPTCOD(+Y),"^",7) W !,"Selected procedure is inactive at this time.",! S DSERR=1
 S ECP=Y,ECPN=$P(Y,"^",2)
 W @IOF S ECANS=0 D ASK2^ECSCR G:$D(DIRUT) END I '$G(ECANS) D END1 W ! G UNIT
 D:'$D(ECL) ^ECSCR G:'$D(ECL) END
 D ASK I $D(DIRUT)!(Y=0) D END2 G RESEL
 I $G(ECLOC)=1 S ECLALL=0 F I=0:0 S ECLALL=$O(LOC1(ECLALL)) Q:'ECLALL  S ECL=$P(LOC1(ECLALL),"^",2),ECLN=$P(LOC1(ECLALL),"^") D STUFF I ECOUT G END
 I $G(ECLOC)=0 S ECLALL=0 F I=0:0 S ECLALL=$O(LOC(ECLALL)) Q:'ECLALL  S ECL=$P(LOC(ECLALL),"^",2),ECLN=$P(LOC(ECLALL),"^") D STUFF I ECOUT G END
RESEL D MORE G:X="^" END D END2 G PRO
STUFF ; stuff entries
 S ECCH=ECL_"-"_ECD_"-"_ECC_"-"_ECP
 I $D(^ECJ("B",ECCH)) D INACT Q
 S X=ECCH,DIC="^ECJ(",DIC(0)="L",DLAYGO=720.3 K DD,DO D FILE^DICN K DIC
 S ECFN=+Y
 W !!,"Entering screen for "_ECLN_" with procedure ",$$NAM^ECSCR,"..."
 S $P(^ECJ(ECFN,0),"^",3)=DT
 S $P(^ECJ(ECFN,"PRO"),U)=ECP
 S DA=ECFN,DIK="^ECJ(" D IX^DIK
 S ^ECJ("AP",ECL,ECD,ECC,ECP,ECFN)=""
 S ^ECJ("APP",ECL,ECD,ECP,ECFN)=""
 ;
 ;ALB/ESD - Ask procedure reason indicator
 S DA=ECFN,DIE=720.3
 S DR=$S($P(ECPCE,"~",2)="N":"",1:"55T//^S X=$G(DEFASCLN);")_"53T;54T;56T"
 D ^DIE K DIE,DA,DR I $D(Y) S ECOUT=1
 I $P(ECPCE,"~",2)'="N" D
 . S DIC="^SC(",DIC(0)="N",X=$P($G(^ECJ(ECFN,"PRO")),U,4)
 . D ^DIC S DEFASCLN=$P(Y,U,2) K DIC
 ;
 ;ALB/ESD - If proc reasons indictor is YES, ask procedure reasons
 I $P($G(^ECJ(ECFN,"PRO")),"^",5)=1 D ADREAS^ECDSUTIL(ECFN)
 ;
 ;ALB/ESD - Always ask associated clinic and do active clinic check
 ;ALB/JAM - Only ask for associated clinic if DSS Unit sends data to PCE
 I $P(ECPCE,"~",2)'="N" D CLIN
 Q
MORE W !!,"Press <RET> to continue  " R X:DTIME S:'$T X="^" Q:X="^"
 K ECP,Y,ECCH
 W @IOF,!,"Event Code Screen Information:"
 W !,"----------------------------",!
 W !,"DSS Unit: "_ECDN,!,"Category: "_ECCN,!!
 Q
 ;
END ;Kill variables.
 W @IOF
END1 K ECNOPE,ECZERO,DEFASCLN D ^ECKILL
END2 K C,CNT,DIR,DSERR,ECANS,ECFIL,ECL,ECLASS,ECLN,ECP,ECPN,ECS,ECWORK,ECS
 K ECZERO,LOC1,NUM,X,Y
 Q
BRO ; check for category  use in data entry
 I '$P(^ECD(ECD,0),U,11) S ECC=0,ECCN="None" W !,"Category: "_ECCN,!! Q
 I $P(^ECD(ECD,0),U,11) D
 .S DIC=726,DIC(0)="AEQMZ",DIC("A")="Select Category : ",DIC("S")="I '$P(^(0),U,3)!(+$P(^(0),U,3)>DT)"
 .D ^DIC K DIC I Y<0 S ECERR=1 Q
 .S ECC=+Y,ECCN=Y(0,0)
 Q
INACT ; check to determine if inactive
 S ECX=$O(^ECJ("B",ECCH,0)) I '$P(^ECJ(ECX,0),"^",2) W !!,"This screen has already been created for "_ECLN_"." Q
 S Y=$$FMTE^XLFDT($P(^ECJ(ECX,0),"^",2))
 W !!,"This event code for "_ECLN_"  inactivated on "_Y_".",!,"Do you want to reactivate it ?  NO//  " R ECYN:DTIME I '$T!(ECYN="^") Q
 S ECYN=$E(ECYN) S:ECYN="" ECYN="N" I "YyNn"'[ECYN W !!,"Enter YES if this code should be reactivated for event code",!,"procedures, or <RET> to continue with another procedure." G INACT
 Q:"Nn"[ECYN  W !!,"Reactivating Event Code Screen...  " K DR,DIE S DA=ECX,DIE="^ECJ(",DR="1///@" D ^DIE S ^ECJ("AP",ECL,ECD,ECC,ECP,DA)="",^ECJ("APP",ECL,ECD,ECP,DA)="" K DR,DIE,DA
 Q
ASK ;Ask user to verify update.
 W ! S DIR(0)="Y",DIR("B")="YES",DIR("A")="Are you sure that you want to create the screen"
 D ^DIR Q:$D(DIRUT)  S ECANS=+Y
 Q
CLIN ;check for active associated clinic
 S MSG1=1,MSG2=0
 S EC4=$P($G(^ECJ(+ECFN,"PRO")),"^",4) I EC4']"" S MSG2=1
 D CLIN^ECPCEU
 I 'ECPCL D
 .W !!,"The clinic ",$S(MSG1:"associated with",1:"you selected for")," this event code screen ",$S(MSG2:"has not been entered",1:"is inactive"),"."
 .W !,"Workload data cannot be sent to PCE for this event code screen with ",!,$S(MSG2:"a missing",1:"an inactive")," clinic."
 .W !!,"Please use the Procedure Synonym/Default Volume (Enter/Edit) option to enter",!,"an active clinic.",!!
 S (MSG1,MSG2)=0
 Q
