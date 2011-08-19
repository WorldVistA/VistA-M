ENCTRED ;(WASH ISC)/RGY-Compile Generic Bar Code Label ;1-19-93
 ;;7.0;ENGINEERING;;Aug 17, 1993
 ;Copy of PRCTRED
 S DIC="^PRCT(446.5,",DIC(0)="QEAML",DLAYGO=446.5 D ^DIC G:Y<0 Q S DA=+Y S:$P(Y,"^",3) $P(^PRCT(446.5,DA,0),"^",3)=DUZ D:'$P(Y,"^",3) SHOW
 S DIE=DIC,DR="[ENCT BASIC PARAM]" D ^DIE G:'$D(DA) Q D NOW^%DTC S $P(^PRCT(446.5,DA,0),"^",4,5)=%_"^"_DUZ
COMP ;
 K ^PRCT(446.5,DA,3),^(4) W !!,"Checking report integrity ..." D ^ENCTRCH W "... Done." I ERR W !!,"NOTICE: Report NOT compiled due to error(s).",! G Q
 W !,"Compiling report ..." S (NL,N0,COMP,T,T1)=0,(JUS,MULT,FLDS)="" D PRE
 F LN=0:0 S LN=$O(^PRCT(446.5,DA,1,LN)) Q:'LN  S NL=1,Y=^(LN,0) D:'MULT MULTI W "." F P=1:1 S X=$P(Y,"|",P) Q:P>$L(Y,"|")  D EVAL:X]""
 D SET,POST W "... Done." S ^PRCT(446.5,DA,3,0)="^^"_T_"^"_T_"^"_DT,^PRCT(446.5,DA,4,0)="^^"_T1_"^"_T1_"^"_DT
Q K JUS,MULT,FLD,FLDS,N0,LN,NL,T,DIE,DA,DR,DLAYGO,ERR Q
EVAL ;
 I P#2 S FLD="S X="""_X_"""" D CHK G Q1
 S N0=$S($D(^PRCT(446.5,DA,2,X,0)):^(0),1:0) Q:'N0  I $P(N0,"^",2)=1,$P(N0,"^",4)["," D MULT
 I $P(N0,"^",2)=3 S FLD="W @IOF" D CHK G Q1
 I $P(N0,"^",10) S FLD="W ?"_$P(N0,"^",10) D CHK
 I $P(N0,"^",3) S FLD="I $D(IOST(0)),$D(^%ZIS(2,IOST(0),""BAR1"")),^(""BAR1"")]"""" S X="""_$P("S^M^L","^",$P(N0,"^",3))_""" W @^(""BAR1"") S X=""""" D CHK
 I $P(N0,"^",2)=2 S FLD=$S($D(^PRCT(446.5,DA,2,X,1)):^(1),1:"S X=""NO-XECUTABLE CODE""") D CHK
 I $P(N0,"^",5)]"" S FLD="S X="""_$P(N0,"^",5)_"""" D CHK
 I $P(N0,"^",2)=1 S FLD=$S($P(N0,"^",4)[",":$P($P(N0,"^",4),",",$L($P(N0,"^",4),",")),1:$P(N0,"^",4)) D JUS,CHK
 I $P(N0,"^",2)=0 S FLD="S:'$D(ENCTA(0,"_DA_"."_X_")) ENCTA(0,"_DA_"."_X_")="_$P(N0,"^",7)_" S X=ENCTA(0,"_DA_"."_X_"),ENCTA(0,"_DA_"."_X_")=ENCTA(0,"_DA_"."_X_")+"_$P(N0,"^",8) D CHK
 I $P(N0,"^",6)]"" S FLD="S X="""_$P(N0,"^",6)_"""" D CHK
 I $P(N0,"^",3) S FLD="I $D(IOST(0)),$D(^%ZIS(2,IOST(0),""BAR0"")),^(""BAR0"")]"""" W @^(""BAR0"")" D CHK
Q1 Q
CHK D:'MULT SET S:'FLD T1=T1+1,^PRCT(446.5,DA,4,T1,0)=FLD,FLD="S ENCT="""_DA_"^"_T1_""" D XEC^ENCTLAB" S FLDS=FLDS_$S(FLDS]"":",",1:"")_FLD_";"_$S(NL:"C1",1:"Y1")_JUS D:'MULT SET S JUS="" S:NL NL=0 Q
SET Q:FLDS=""  S T=T+1,^PRCT(446.5,DA,3,T,0)=FLDS S FLDS="" Q
SHOW ;
 S Y=^PRCT(446.5,DA,0) W !,"Report was originally created by: ",$S($D(^VA(200,$P(Y,"^",3),0)):$P(^(0),"^"),1:"Unknown"),!?16,"Last modified by: ",$S($D(^VA(200,$P(Y,"^",5),0)):$P(^(0),"^"),1:"Unknown")
 W !?14,"Date/Time modified: " S Y=$P(Y,"^",4) X ^DD("DD") W Y
 Q
MULT Q:$P($P(N0,"^",4),",",1,$L($P(N0,"^",4),",")-1)=MULT!($P(N0,"^",2)'=1)  S MULT=$P($P(N0,"^",4),",",1,$L($P(N0,"^",4),",")-1)
 Q
MULTI F P=2:2 Q:P>$L(Y,"|")  S N0=$S($D(^PRCT(446.5,DA,2,$P(Y,"|",P),0)):^(0),1:0) Q:'N0  I $P(N0,"^",2)=1,$P(N0,"^",4)["," S (MULT,FLDS)=$P($P(N0,"^",4),",",1,$L($P(N0,"^",4),",")-1) Q
 Q
JUS S JUS=$S($P(N0,"^",11):";L"_$P(N0,"^",11),$P(N0,"^",12):";R"_$P(N0,"^",12),1:"") Q
PRE ;
 I $P(^PRCT(446.5,DA,0),"^",6) S FLD="S X="""" I '$D(ENCTSC) S ENCTSC=1 S ENCT="""_+$P(^(0),"^",6)_"^1"" D SPC^ENCTLAB" D CHK S FLD="S ENCT="""_+$P(^PRCT(446.5,DA,0),"^",6)_"^2"" D SPC^ENCTLAB" D CHK
 Q
POST ;
 S FLD="S:'$D(ENCTCP) ENCTCP=ENCTCPY S ENCTCP=ENCTCP-1 S:ENCTCP D0=D0-.0001 K:ENCTCP=0 ENCTCP S X=""""" D CHK
 I $P(^PRCT(446.5,DA,0),"^",6) S FLD="S ENCT="""_+$P(^(0),"^",6)_"^3"" D SPC^ENCTLAB" D CHK
 Q
