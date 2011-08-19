PSSFIL ;BIR/CML3-SON OF VARIOUS FILES' UPKEEP ; 09/15/97 13:21
 ;;1.0;PHARMACY DATA MANAGEMENT;;9/30/97
 ;
ENDTE ; default team edit
 I '$O(^PS(57.7,DA,1,0)) W !!,"NO TEAMS ENTERED TO CHOOSE FROM!" K X Q
 N DIC,DIE S DIC="^PS(57.7,"_DA_",1,",DIC(0)="EQM" D ^DIC I Y'>0 K X Q
 S X=+Y Q
 ;
ENOAOPT ; order action on patient transfer
 D ENSWT I %<0 K % Q
 K DA,DR S DA=1,DIE="^PS(59.7,",DR="[PSJ OAOPT]" D ^DIE
 S X="PSGSETU" X ^%ZOSF("TEST") I  D ENCV^PSGSETU Q
 ;
ENSWT ; set-up discontinue on all ward transfers
 S X="PSGFILD1" X ^%ZOSF("TEST") I  F  W !!,"Do you want the instructions for auto-discontinue set-up" S %=1 D YN^DICN Q:%  D
 .W !!?2,"Enter ""YES"" to view the instructions for the auto-discontinue set-up.  Enter",!,"""NO"" to bypass the instructions.  Enter ""^"" to abort the set-up."
 Q:%<0  D:%=1 ENWAI^PSGFILD1
 F  W !!,"Do you want the package to set-up all of your wards for auto-discontinue" S %=2 D YN^DICN Q:%  D SWTH
 Q:%'=1  W !!?3,"Working..." K PSGW S PSGW=0 F Q=0:0 S Q=$O(^DIC(42,Q)) Q:'Q  I $D(^(Q,0)) S X=$P(^(0),"^"),PSGW(Q)=$S(X]"":X,1:Q_";DIC(42,"),PSGW=PSGW+1
 I '$D(^PS(59.7,1,22,0)) S ^(0)="^59.722P"
 F PSGX=0:0 S PSGX=$O(PSGW(PSGX)) Q:'PSGX  W !,PSGW(PSGX),"..." D:'$D(^PS(59.7,1,22,PSGX)) SW F PSGY=0:0 S PSGY=$O(PSGW(PSGY)) Q:'PSGY  I PSGX'=PSGY,'$D(^PS(59.7,1,22,PSGX,1,PSGY,0)) D SW1
 K PSGW,PSGX,PSGY S %=0 Q
 ;
SW ;
 W "." K DIC,DA,DD,DO S DIC="^PS(59.7,1,22,",DIC(0)="L",DA(1)=1,(DINUM,X)=PSGX D FILE^DICN S:'$D(^PS(59.7,1,22,PSGX,1,0)) ^(0)="^59.7221P" Q
 ;
SW1 ;
 W "." K DIC,DA,DD,DO S DIC="^PS(59.7,1,22,"_PSGX_",1,",DIC(0)="L",DA(2)=1,DA(1)=PSGX,(DINUM,X)=PSGY D FILE^DICN Q
 ;
SWTH ;
 W !?2,"Enter ""YES"" to have the package set-up all of your wards for auto-discontinue",!,"for you.  Enter ""NO"" if you prefer to set-up the wards individually.  Enter ""^""",!,"to abort the set-up."
 W !!?2,"If you answer YES, you will still be able to add, edit and delete individual",!,"wards.",!!?2,"PLEASE NOTE that this is not a flag for the package, but a one-time action.",!,"If you add new wards to your WARD LOCATION file, you will"
 W " need to add those",!,"wards here." Q
 ;
ENSUEP ; supervisor edit of user parameters
 F  K DIC S DIC="^PS(53.45,",DIC(0)="AELQZ",DIC("A")="Select INPATIENT USER: ",DLAYGO=53.45 W ! D ^DIC K DIC,DLAYGO Q:Y'>0  K DA,DR S DA=+Y,DIE="^PS(53.45,",DR="[PSJ IUP SUPER EDIT]",IU=+Y(0) D  W ! D ^DIE
 .F X=1:1:3 I $D(^XUSEC("PSJ "_$P("RPHARM^RNURSE^PHARM TECH","^",X),IU)) Q
 .S:'$T X=0 S R=$G(^VA(200,IU,"PS")),R=$S('R:0,'$P(R,"^",4):1,1:$P(R,"^",4)>DT)
 .W !!,"This user is a " W:X $P("PHARMACIST^NURSE^PHARMACY TECHNICIAN","^",X) W:'X&'R "WARD CLERK" W:'R "." I R W:X " and a " W "PROVIDER."
 K IU,PSJ,R S X="PSGSETU" X ^%ZOSF("TEST") I  D ENKV^PSGSETU W !!,"PLEASE NOTE: Any changes made will not take effect for the corresponding users",!,"until those users completely exit and re-enter the system." Q
 ;
ENUUEP ;
 S X="PSGSETU" X ^%ZOSF("TEST") I  D ENCV^PSGSETU K DA,DR S DA=PSJSYSP,DIE="^PS(53.45,",DR="[PSJ IUP USER EDIT]" D  W ! D ^DIE K ^XUTL("OR",$J,"PSG") D ENKV^PSGSETU
 .F X=1:1:3 I $D(^XUSEC("PSJ "_$P("RPHARM^RNURSE^PHARM TECH","^",X),DUZ)) Q
 .S:'$T X=0 S R=$G(^VA(200,DUZ,"PS")),R=$S('R:0,'$P(R,"^",4):1,1:$P(R,"^",4)>DT)
 .W !!,"You are a " W:X $P("PHARMACIST^NURSE^PHARMACY TECHNICIAN","^",X) W:'X&'R "WARD CLERK" W:'R "." I R W:X " and a " W "PROVIDER."
 W !!,"PLEASE NOTE: Any changes made take effect immediately." Q
 ;
ENIWPE ; edit inpatient ward parameters
 F  K DIC S DIC="^PS(59.6,",DIC(0)="AELMQ",DIC("A")="Select WARD: ",DLAYGO=59.6 W ! D ^DIC K DIC Q:Y'>0  K DA,DR S DA=+Y,DIE="^PS(59.6,",DR="[PSJ IWP EDIT]" W ! D ^DIE
 K ^TMP("OR",$J,"PSG") S X="PSGSETU" X ^%ZOSF("TEST") I  D ENKV^PSGSETU Q
 ;
ENPDE ; edit primary drug
 F  K DIC S DIC="^PS(50.3,",DIC(0)="AELMQ",DIC("A")="Select PRIMARY DRUG: ",DLAYGO=50.3 W ! D ^DIC K DIC Q:Y'>0  K DA,DR S DA=+Y,DIE="^PS(50.3,",DR="[PSS PD EDIT]" D ^DIE
 K DA,DIC,DIE,DLAYGO,DR,X,Y,PSGS0XT,PSGS0Y Q
 ;
ENALU ; application look-up
 N PSJ S PSJ=DA(1) N DA,DIC,DIE,DIX,DO,DR S DIC="^PS(50.35,",DIC(0)=$E("E",'$D(PSJPRE4))_"IMZ" D DO^DIC1,^DIC I Y'>0 K X Q
 S X=$P(Y(0),"^",2) K:$S(X="":1,1:$D(^PS(50.3,PSJ,1,"B",X))) X Q
 ;
ENAQ ; application query
 S X=DZ N DA,DIC,DIE,DO,DR,DZ S DIC="^PS(50.35,",DIC(0)="EIMQ" D DO^DIC1,^DIC Q
