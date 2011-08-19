PRCFACR3 ;WISC@ALTOONA/CTB-KEYPUNCH A CODE SHEET ;2/19/93  10:59
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 I '$D(PRCFASYS) S PRCFASYS="FEEFENIRSCLI"
 W !!,"This option will allow you to keypunch a "_$S('$D(PRCHLOG):"",1:"LOG "),"Code Sheet when there",!,"is no other way to get it into the system."
 S PRCF("X")="AS" D ^PRCFSITE G:'% OUT
SE S X="Select "_$S('$D(PRCHLOG):"Transaction Type.Status Code",1:"LOG Transaction Type")_": " W !!,X R X:$S($D(DTIME):DTIME,1:120)
 G:X=""!(X["^") OUT S DIC=420.4,DIC(0)="EMNZ" D ^DIC K DIC
 S PRCFA("TTLEN")=$S(Y>0:$P(Y(0),"^",8),$D(PRCHLOG):80,1:"")
 S PRCFA("SYS")=$S(Y>0:$P(Y(0),"^",6),$D(PRCHLOG):"LOG",1:"")
 I Y<0 S XZ=X,%A="Transaction Type "_XZ_" not found in file.",%A(1)="Is it OK if I use "_XZ_" anyway",%=2,%B="If you answer 'YES', I will use "_XZ_" as the Transaction Type for this code sheet." D ^PRCFYN G:%<1 OUT G:%=2 SE S Y="^"_XZ K XZ
 S PRCFA("TT")=$P(Y,"^",2),PRCFA("EDIT")="",PRCFA("KP")=""
AM4 D NEWCS^PRCFAC I '$D(DA) S X="No new code sheet created - Files inaccessible at this time.*" D MSG^PRCFQ G OUT
 S PRCFA("CSDA")=DA
 S DIE="^PRCF(423,",DR="4;112" D ^DIE I $D(Y)'=0!('$D(^PRCF(423,DA,"KEY"))) D DEL^PRCFACXM G V
 G OUT:'$D(^PRCF(423,DA,"KEY",0)),OUT:+$P(^(0),"^",3)=0 S N=0,LNTH=80 D RE1,XM,XM^PRCFACXM
 W !! S %A="Do you wish to enter another code sheet",%=1,%B="Answer YES if you wish to enter an additional code sheet" D ^PRCFYN G:%'=1 OUT G V
 Q
RE1 I $D(^PRCF(423,DA,"KEY",0)),$P(^(0),"^",3)>0 K PRCFCS S N=0 F I=0:1 S N=$O(^PRCF(423,DA,"KEY",N)) Q:'N  S PRCFCS(I)=^(N,0)
RENUM S N=$O(PRCFCS(N)) Q:N=""  S LN=$L(PRCFCS(N))
 G:LN=LNTH RENUM S X=N
SHORT I LN<LNTH S X=$O(PRCFCS(X)) Q:X'=+X  S A=LNTH-LN,PRCFCS(N)=PRCFCS(N)_$E(PRCFCS(X),1,A) S:$L(PRCFCS(X))>0 PRCFCS(X)=$E(PRCFCS(X),A+1,$L(PRCFCS(X))) S LN=$L(PRCFCS(N)) G RENUM:LN=LNTH,SHORT
LONG I LN>LNTH S X=$O(PRCFCS(X)) S X=$S(X=+X:N+X/2,1:N+1),PRCFCS(X)=$E(PRCFCS(N),LNTH+1,999),PRCFCS(N)=$E(PRCFCS(N),1,LNTH),LN=$L(PRCFCS(X)),N=X G SHORT:LN<LNTH,LONG:LN>LNTH,RENUM
 G RENUM
XM ;K ^PRCF(423,DA,"KEY")
 S X=1,N=-1 K ^PRCF(423,DA,"CODE")
XM2 S ^PRCF(423,DA,"CODE",0)="^423.06^^" F I=1:1 S N=$O(PRCFCS(N)) Q:N=""  I PRCFCS(N)]"" S ^PRCF(423,DA,"CODE",X,0)=PRCFCS(N) S X=X+1 G XM2
 S $P(^PRCF(423,DA,"CODE",0),"^",3)=X,$P(^(0),"^",4)=X
 Q
OUT K B,D,D0,DG,DIC,DIE,DIG,DIH,DIU,DIV,DIW,DLAYGO,DR,K,Q,PRCFCS,S,X,XL1 Q
 I $S('$D(PRCFASYS):0,PRCFASYS="":0,'$D(PRCFA("TTF")):0,PRCFA("TTF")="":0,'$D(PRC("SITE")):0,PRC("SITE")="":0,'$D(PRC("PER")):0,PRC("PER")="":0,1:1) S %=0 Q
 D TT^PRCFAC K PRCFA("TTF") Q:'%  S PRCFA("EDIT")="",PRCHAUTO="",PRCFA("KP")="" D NEWCS^PRCFAC K PRCHAUTO,PRCFA("KP") I '$D(PRCFA("CSNAME")) S %=0 Q
