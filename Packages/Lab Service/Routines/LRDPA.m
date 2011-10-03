LRDPA ;SLC/RWF/WTY/KLL - FILE OF FILES LOOKUP ON ENTITIES ; 2/28/03 4:10pm
 ;;5.2;LAB SERVICE;**137,121,153,202,211,248,305,360**;Sep 27, 1994;Build 1
 ;
 ;Reference to ^DIC( supported by IA #916
 ;Reference to ^DIC("AC" supported by IA #511
 ;Reference to ^ORD(100.99 supported by IA #2414
 ;Reference to ^DIC supported by IA #10006
 ;Reference to LK^ORX2 supported by IA #867
 ;Reference to ULK^ORX2 supported by IA #867
 ;Reference to $$DTIME^XUP supported by IA # -none available-
 ;Reference to EN^DDIOL supported by IA #10142
 ;
 ;IF '$D(DIC) USE PATIENT FILE, ALLOW "FILE:NAME" EXTENDED SYNTAX
 ;IF DIC=0 ASK FILE NAME, IF PATIENT FILE, USE DPA, 
 ;  OTHERWISE ^DIC LOOK-UP
 ;IF DIC=N^GLOBAL, LOOK-UP ON FILE N
 ;RETURN (DFN,Y)=IFN, LRDPF=N^GLOBAL, '$D(DIC), LRDFN=IFN OF ^LR 
 ; GLOBAL  PNM=NAME,SSN=SSN,SSN(1)=LAST4,SSN(2)=SSN WITHOUT '-'
 ;ROUTINE SSN^LRU CONTROLS SSN FORMAT
 ;ALSO WILL RETURN LRLABKY variable if not defined.
 ;LRLOOKUP=1 blocks ability to add new entries (lookup only)
 S:$G(LRREFFL) DIC="67^LRT(67"
 G:$G(LRORDRR)="R" ^LRDPAREF
 S X="",U="^",DTIME=$$DTIME^XUP(DUZ)
 S DIC(0)=$S('$D(DIC(0)):"EMQZ",DIC(0)["A":"EMQZ",1:DIC(0))
 S:DIC(0)'["Z" DIC(0)=DIC(0)_"Z"
 K DLAYGO I '($D(DIC)[0),DIC'=0,'$P(DIC,"^") S DIC=0
DPA ;from LRUPS
 D:'$D(LRLABKY) LABKEY^LRPARAM
 K VADM,VAIN,VA
 S LRDPF="" G ANY:'($D(DIC)[0)
 R !,"Select Patient Name: ",X:DTIME
DPA1 ;Entry point from PNAME^LRAPDA
 I X'?1"%"9N.E,X=""!(X["^") S DFN=-1 K DLAYGO G END
 ;The X'?1"%"9N.E was added since the VIC data stream contains a carat.
 I X="??" W !,"You may enter patient identification or enter a file name followed by "":"".",!,"You may enter ""?:?"" for more extended help." G DPA
EN1 ;from LRUG, LRUPS
 I X[":" S LRX=$P(X,":",2),X=$P(X,":",1),DIC=0 K:LRX="" LRX G ANY:X=""!(X["?") W !," File: ",X G FL
EN ;
 S:DIC(0)'["Z" DIC(0)=DIC(0)_"Z"
 S DIC="^DPT(",LRDPF="2^DPT(",VA200=""
 ; DLAYGO not allowed for DPT( on first pass
 S DIC("S")="S:X?1""%""9N.E1""?"" X=$E(X,2,10) I 1"
 ;The DIC("S") was added to preprocess any data from a VIC card. The VIC
 ;card data has guard codes before and after the patient data. The SSN
 ;is extracted if these guard codes exist. DIC("S") was added in several
 ;places and in all instances it is being killed immediately after use.
 D ^DIC K DIC("S"),DLAYGO K:Y>0 DUOUT
 ;Since VIC card data contains carats, DUOUT will be returned whenever
 ;the VIC card is used.  If the user ^'s out, Y will be equal to -1.
 ;If Y is greater than 0 the data is valid and DUOUT should be ignored.
 I Y<1 K DIC D LAYG G DPA
 S DFN=+Y,PNM=$P(Y(0),"^") D PT^LRX D:DOD'="" WARN G END
 ;
LAYG ;Don't allow DLAYGO on second pass.
 K DLAYGO S DIC(0)="EQMZ" Q
 Q:'$P($G(LRPARAM),"^",6)
 Q:'$D(LRLABKY)
 S DLAYGO=2 S DIC(0)="EQMZL"
 Q
ANY S:DIC'=0 LRDPF=+DIC_^DIC(+DIC,0,"GL") G FL1:DIC'=0 D FILE
 G NONE:Y=-1,FL0
 ;
FL S DIC="^DIC(",DIC(0)=$S(X]"":"EMQZ",1:"AEMQZ"),DIC("S")="I $D(^DIC(""AC"",""LR"",+Y))" D ^DIC G NONE:Y=-1
FL0 S LRDPF=+Y_^DIC(+Y,0,"GL"),DIC=LRDPF I +$G(LRDPF)=2 K DIC G LRDPA
FL1 ;
 D:'$D(LRLABKY) LABKEY^LRPARAM
 ;DLAYGO not allowed for DPT(
 I +LRDPF'=2,'$G(LRLOOKUP) S DLAYGO=+LRDPF
 S DIC="^"_$P(LRDPF,"^",2),DIC(0)=$S($D(LRX):"EMQZ",1:"AEMQZ")
 I '$G(LRLOOKUP) D
 .S DIC(0)=DIC(0)_$S(+LRDPF>60&(+LRDPF<70)&$D(LRLABKY):"L",+LRDPF>1000:"L",1:"")
 .S:DIC(0)["L" DLAYGO=+LRDPF
 S:$D(LRX) X=LRX K LRX,DIC("S")
 I X["?" S DIC("S")="S:X?1""%""9N.E1""?"" X=$E(X,2,10) I 1" D ^DIC K DIC("S") K:Y>0 DUOUT S:DIC(0)'["A" DIC(0)=DIC(0)_"A"
 W:DIC(0)'["A" "   Entry: ",X
 S DIC("S")="S:X?1""%""9N.E1""?"" X=$E(X,2,10) I 1"
 S:DIC="^LAB(62.3," DIC("S")=DIC("S")_" "_"I '$P(^LAB(62.3,Y,0),U,4)"
 D ^DIC K DIC("S") G NONE:Y=-1 S DFN=+Y,PNM=$P(Y(0),"^") D PT^LRX
 G END
NONE S Y=-1,DFN=-1,LRDFN=-1,LRDPF="0^NULL("
 K DIC,VAIN,VADM,VA S VA200="" Q
 Q
REASK S DFN=-1,DIC("S")="S:X?1""%""9N.E1""?"" X=$E(X,2,10) I 1",DIC(0)=DIC(0)_"A"
 D ^DIC K:Y>0 DUOUT K DIC("S") G:Y<1 END S DFN=+Y,PNM=$P(Y(0),"^") D PT^LRX
END ;from LROR, LRSETUP
 S:'$D(DFN) DFN=-1 S Y=DFN
 I DFN=-1 D  Q
 .S LRDFN=-1 K DIC,DLAYGO S VA200=""
 S X="^"_$P(LRDPF,"^",2)_Y_",""LR"")",LRDFN=+$S($D(@X):@X,1:-1)
 G E3:LRDFN>0
 L +^LR(0):5 I '$T D  Q
 .S MSG="The LAB DATA file is locked.  Please try again later."
 .D EN^DDIOL(MSG,"","!!") K MSG
 .S (DFN,LRDFN)=-1,VA200=""
 .K DIC,DLAYGO
 S LRDFN=$P(^LR(0),"^",3)+1
 I $D(@X) L -^LR(0) K DIC,DLAYGO G LRDPA
E2 I $D(^LR(LRDFN)) S LRDFN=LRDFN+1 G E2
 S ^LR(LRDFN,0)=LRDFN_"^"_+LRDPF_"^"_DFN,@X=LRDFN,^(0)=$P(^LR(0),"^",1,2)_"^"_LRDFN_"^"_(1+$P(^(0),"^",4)),^LR("B",LRDFN,LRDFN)="" L -^LR(0)
E3 I '$D(^LR(LRDFN,0))#2 W !!,"Internal patient ID incorrect in ^LR( for ",PNM,".  Contact Lab Coordinator.",$C(7) S LRDFN=-1 Q
 I LRDFN>0,$P(^LR(LRDFN,0),"^",2)'=+LRDPF!($P(^(0),"^",3)'=DFN) W !,$C(7),"Internal patient ID incorrect for ",PNM,".  Contact Lab Coordinator." S LRDFN=-1 Q
 D INF^LRX
 D ^LRDPA1:($D(LRDPAF)&(LRDFN>0)) K DIC,DLAYGO S VA200=""
 I DFN,$P($G(^ORD(100.99,1,"CONV")),"^")=0 D EN^LR7OV2(DFN_";"_$P(LRDPF,"^",2),1)
 Q
 ;
FILE I X'["?" W !,"Select FILE: " R X:DTIME I X["^"!(X="") S X="",Y=-1 Q
 D DICQ:X["?" G FILE:X=""
 S DIC="^DIC(",DIC(0)="EMQZ"
 S DIC("S")="I $D(^DIC(""AC"",""LR"",+Y)),+Y'=44"
 D ^DIC K DIC("S") I Y=-1 G FILE
 Q
DICQ ;
 S DIC="^DIC(",DIC(0)="EQZ",D="AC",X="LR"
 S DIC("S")="I +Y'=44"  D IX^DIC
 I Y=-1 S X="" Q
 S X=Y(0,0)
 K D,DIC S Y=1
 Q
% R %:DTIME Q:%=""!(%["N")!(%["Y")  W !,"Answer 'Y' or 'N': " G %
 ;
EN2(DFN,LOCK,TALK) ;Patient Lock
 ;TALK 1:write, 0:silent
 ;LOCK 1:lock, 0:unlock
 Q:'$G(DFN)
 S:'$D(LOCK) LOCK=0 S:'$D(TALK) TALK=0
 S X=DFN_";DPT("
 I LOCK D LK^ORX2
 I 'LOCK D ULK^ORX2
 Q
WARN ;Warn the user the patient has died and display date of death (LR*5.2*360)
 S Y=DOD D DD^LRX
 W !?10,@LRVIDO,"Patient ",PNM," died on: ",Y,@LRVIDOF,!
 S DIR(0)="Y"
 S DIR("A")="Do you wish to continue with this patient [Yes/No]"
 S DIR("T")=120
 D ^DIR K DIR
 I Y=0!($D(DIRUT)) S DFN=-1
 K DIRUT
 Q
