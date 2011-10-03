PRCTRED ;WISC@ALTOONA/RGY-ENTER AND COMPILE REPORT ;5/6/91  15:44
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 I DUZ(0)'["@" W !,"Sorry, only programmers are allowed to use this option!",! Q
 S DIC="^PRCT(446.5,",DIC(0)="QEAML",DLAYGO=446.5 D ^DIC G:Y<0 Q S DA=+Y,DIE=DIC,DR="[PRCT BASIC PARAM]" D ^DIE G:'$D(DA) Q D COMP G PRCTRED
COMP ;
 K ^PRCT(446.5,DA,3),^(4) W !!,"Checking report integrity ..." D ^PRCTRCH W "... Done." I ERR W !!,"NOTICE: Report NOT compiled due to error(s).",! G Q
 W !,"Compiling report ..." S (NL,N0,COMP,T,T1)=0,(JUS,MULT,FLDS)="" D PRE
 S:$D(^PRCT(446.5,DA,1,1,0)) Y=^(0) D MULTI,PRE1
 F LN=0:0 S LN=$O(^PRCT(446.5,DA,1,LN)) Q:'LN  S NL=1,Y=^(LN,0) D:'MULT MULTI W "." F P=1:1 S X=$P(Y,"|",P) Q:P>$L(Y,"|")  D EVAL:X]""
 D POST,SET W "... Done." S ^PRCT(446.5,DA,3,0)="^^"_T_"^"_T_"^"_DT,^PRCT(446.5,DA,4,0)="^^"_T1_"^"_T1_"^"_DT
Q K JUS,MULT,FLD,FLDS,N0,LN,NL,T,DIE,DA,DR,DLAYGO,ERR,%DT,COMP,D0,D1,DQ,J,P,T1 Q
EVAL ;
 I P#2 S FLD="S X="""_X_"""" D CHK G Q1
 S N0=$S($D(^PRCT(446.5,DA,2,X,0)):^(0),1:0) Q:'N0  I $P(N0,"^",2)=1 D MULT
 I $P(N0,"^",2)=3 S FLD="W @IOF" D CHK G Q1
 I $P(N0,"^",10) S FLD="W ?"_$P(N0,"^",10) D CHK
 I $P(N0,"^",3) S FLD="I $D(IOST(0)),$D(^%ZIS(2,IOST(0),""BAR1"")),^(""BAR1"")]"""" S X="""_$P("S^M^L","^",$P(N0,"^",3))_""" W @^(""BAR1"") S X=""""" D CHK
 I $P(N0,"^",2)=2 S FLD=$S($D(^PRCT(446.5,DA,2,X,1)):^(1),1:"S X=""NO-XECUTABLE CODE""") D CHK
 I $P(N0,"^",5)]"" S FLD="S X="""_$P(N0,"^",5)_"""" D CHK
 I $P(N0,"^",2)=1 S FLD=$S($P(N0,"^",4)[",":$P($P(N0,"^",4),",",$L($P(N0,"^",4),",")),1:$P(N0,"^",4)) D:FLD!(FLD="NUMBER") JUS,CHK
 I $P(N0,"^",2)=0 S FLD="S:'$D(PRCTA(0,"_DA_"."_X_")) PRCTA(0,"_DA_"."_X_")="_$P(N0,"^",7)_" S X=PRCTA(0,"_DA_"."_X_"),PRCTA(0,"_DA_"."_X_")=PRCTA(0,"_DA_"."_X_")+"_$P(N0,"^",8) D CHK
 I $P(N0,"^",6)]"" S FLD="S X="""_$P(N0,"^",6)_"""" D CHK
 I $P(N0,"^",3) S FLD="I $D(IOST(0)),$D(^%ZIS(2,IOST(0),""BAR0"")),^(""BAR0"")]"""" W @^(""BAR0"")" D CHK
Q1 Q
CHK D:'MULT SET S:FLD'="NUMBER"&'FLD T1=T1+1,^PRCT(446.5,DA,4,T1,0)=FLD,FLD="S PRCT="""_DA_"^"_T1_""" D XEC^PRCTLAB"
 I $L(FLDS)+$L(FLD)+10>240 D SET S FLDS=$S(MULT:MULT,1:"")
 S FLDS=FLDS_$S(FLDS]"":",",1:"")_FLD_";"_$S(NL:"C1",1:"Y1")_JUS D:'MULT SET S JUS="" S:NL NL=0 Q
 ;D:'MULT SET S:FLD'="NUMBER"&'FLD T1=T1+1,^PRCT(446.5,DA,4,T1,0)=FLD,FLD="S PRCT="""_DA_"^"_T1_""" D XEC^PRCTLAB" S FLDS=FLDS_$S(FLDS]"":",",1:"")_FLD_";"_$S(NL:"C1",1:"Y1")_JUS D:'MULT SET S JUS="" S:NL NL=0 Q:$L(FLDS)<75
SET Q:FLDS=""  S T=T+1,^PRCT(446.5,DA,3,T,0)=FLDS S FLDS="" Q
MULT Q:$P($P(N0,"^",4),",",1,$L($P(N0,"^",4),",")-1)=MULT!($P(N0,"^",2)'=1)  S MULT=$P($P(N0,"^",4),",",1,$L($P(N0,"^",4),",")-1)
 Q
MULTI F P=2:2 Q:P>$L(Y,"|")  S N0=$S($D(^PRCT(446.5,DA,2,$P(Y,"|",P),0)):^(0),1:0) Q:'N0  I $P(N0,"^",2)=1,$P(N0,"^",4)["," S (MULT,FLDS)=$P($P(N0,"^",4),",",1,$L($P(N0,"^",4),",")-1) Q
 Q
JUS S JUS=$S($P(N0,"^",11):";L"_$P(N0,"^",11),$P(N0,"^",12):";R"_$P(N0,"^",12),1:"") Q
PRE ;
 I $P(^PRCT(446.5,DA,0),"^",6) S FLD="S X="""" I '$D(PRCTSC) S PRCTSC=1 S PRCT="""_+$P(^(0),"^",6)_"^1"" D SPC^PRCTLAB" D CHK Q
PRE1 S FLD="S PRCT="""_+$P(^PRCT(446.5,DA,0),"^",6)_"^2"" D SPC^PRCTLAB" D CHK
 Q
POST ;
 S FLD="S:'$D(PRCTCP) PRCTCP=PRCTCPY S PRCTCP=PRCTCP-1 S:PRCTCP D0=D0-.0001 K:PRCTCP=0 PRCTCP S X=""""" D CHK
 I $P(^PRCT(446.5,DA,0),"^",6) S FLD="S PRCT="""_+$P(^(0),"^",6)_"^3"" D SPC^PRCTLAB" D CHK
 Q
