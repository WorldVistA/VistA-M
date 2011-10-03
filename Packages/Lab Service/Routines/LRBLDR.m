LRBLDR ;AVAMC/REG/CYM - DONOR REGISTRATION FORM 6/28/96  12:53 ;
 ;;5.2;LAB SERVICE;**72,247,408**;Sep 27, 1994;Build 8
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 Q  D END S LRAA=$O(^LRO(68,"B","BLOOD BANK",0)),LRB=$O(^LAB(65.4,"B","DNRHX",0)) I 'LRAA W $C(7),!!,"ENTER ""BLOOD BANK"" IN ACCESSION AREA FILE",!! G END
 I 'LRB W $C(7),!!,"ENTER ""DNRHX"" (BLOOD DONOR HISTORY QUESTIONS) IN BLOOD BANK UTILITY FILE",!! G END
 S:'$D(^LRO(69.2,LRAA,5,0)) ^(0)="^69.24A^0^0" S IOP="HOME" D ^%ZIS
 W !!?20,"Donor registration forms",!!
 I $O(^LRO(69.2,LRAA,5,0)) W "Display list of donors for printing registration forms " S %=2 D YN^LRU G:%<1&(%Y'="@") END D S^LRBLDR1:%=1,D^LRBLDR1:%Y="@"
 W !!,"Add all donors from a GROUP AFFILIATION: " S %=2 D YN^LRU G:%<1 END D:%=1 A^LRBLDR1
DNR S DIC="^LRE(",DIC(0)="AEQM",D="B^C^"_$S("NAFARMY"[DUZ("AG")&(DUZ("AG")]""):"G4^G",1:"D"),DIC("A")="Add Donor Name to list: " D MIX^DIC1 K DIC I Y>0 S ^LRO(69.2,LRAA,5,+Y,0)=+Y_"^65.5^"_$P(Y,U,2),^LRO(69.2,LRAA,5,"C",$P(Y,U,2),+Y)="" G DNR
 I $O(^LRO(69.2,LRAA,5,0))'>0 W $C(7),!!,"No list for printing donor registration forms !",!! G END
 W !!,"Print donor registration forms " S %=2 D YN^LRU G:%'=1 END
 S DIC="^LAB(65.4,",DIC(0)="AEQMZ",DIC("A")="Select COLLECTION SITE to appear on form: ",DIC("S")="I $P(^(0),U,2)[""C""" D ^DIC K DIC G:X[U!(X="") END S S=$P(Y(0),U,3)
 S X="T",%DT="" D ^%DT S LRD=Y D D^LRU S T=Y,%DT="AEQ",%DT("A")="Date to appear on form: ",%DT("B")=T D ^%DT K %DT G:Y<1 END D D^LRU S T=Y
 S ZTRTN="QUE^LRBLDR" D BEG^LRUTL G:POP!($D(ZTSK)) END
QUE U IO D L^LRU,S^LRU S DIWR=IOM-5,DIWL=5,DIWF="W" D FIELD^DID(65.54,1,"","POINTER","LRF") S LRF=LRF("POINTER"),Y=$O(^LAB(65.4,"B","DNRCX",0)) I Y S LRC=0 F X=0:0 S X=$O(^LAB(65.4,Y,3,X)) Q:'X  S J(X)=^(X,0),LRC=LRC+1
 S LRC=LRC+6,C=0 F B=0:0 S C=$O(^LRO(69.2,LRAA,5,"C",C)) Q:C=""!(LR("Q"))  F W=0:0 S W=$O(^LRO(69.2,LRAA,5,"C",C,W)) Q:'W  K A,Z S LRQ=0 D PRT
 K ^LRO(69.2,LRAA,5) S ^LRO(69.2,LRAA,5,0)="^69.24A^0^0" W:IOST'?1"C".E @IOF D END^LRUTL,END Q
PRT I '$D(^LRE(W,0)) K ^LRO(69.2,LRAA,5,"C",C,W),^LRO(69.2,LRAA,5,W) Q
 S Z=^LRE(W,0),N=$P(Z,"^"),SEX=$P(Z,"^",2),DOB=$P(Z,"^",3),E=$P(Z,"^",5),F=$P(Z,"^",6),M=$P(Z,"^",7),R=$P(Z,"^",4),G=$P(Z,"^",10),G(16)=$P(Z,"^",16),SSN=$P(Z,"^",13),Y=DOB D D^LRU S DOB=Y S:DOB[1700 DOB="" D:SSN]"" SSN^LRU
 S Z=$S($D(^LRE(W,1)):^(1),1:""),Z(5)="" S:$P(Z,"^",5) Z(5)=$S($D(^DIC(5,$P(Z,"^",5),0)):$P(^(0),"^"),1:"")
 S A(1)=$P(Z,"^"),A(2)=$P(Z,"^",2),A(3)=$P(Z,"^",3),A(4)=$P(Z,"^",4),A(6)=$P(Z,"^",6),A(7)=$P(Z,"^",7),A(8)=$P(Z,"^",8)
 S X=$O(^LRE(W,5,0)),(LR(65.54,.01),LR(65.54,1))="" I X S:+^(X,0)=LRD X=$O(^LRE(W,5,X)) I X S X=^LRE(W,5,X,0),Y=$P($P(X,"^"),".") D D^LRU S LR(65.54,.01)=Y,X=$P(X,"^",2) I X]"" S X=X_":",X=$P($P(LRF,X,2),";")
 S LR(65.54,1)=X D H S LR("F")=1 W !!,"DONOR HISTORY" K ^TMP($J)
 S K=0 F LRZ=0:1 S K=$O(^LAB(65.4,LRB,2,K)) Q:'K!(LR("Q"))  S LRX=^(K,0) D:$Y>(IOSL-6) H1 Q:LR("Q")  S X=LRX D ^DIWP
 Q:LR("Q")  D:LRZ ^DIWW
 D C Q:LR("Q")  W !!,"Date ..................at .....(time)",?40 F X=1:1:39 W "."
 W !?50,"(Donor)",!!?40 F X=1:1:39 W "."
 W !?50,"(Witness)" D H Q:LR("Q")  D ^LRBLDR1 Q
 ;
C W ! D:$Y>(IOSL-LRC) H1 Q:LR("Q")  K ^TMP($J) S K=0 F LRZ=0:1 S K=$O(J(K)) Q:'K  D:$Y>(IOSL-6) H Q:LR("Q")  S X=J(K) D ^DIWP
 Q:LR("Q")  D:LRZ ^DIWW Q
H I $D(LR("F")),IOST?1"C".E D M^LRU Q:LR("Q")
 D F^LRU W !,"DONOR REGISTRATION",?60,"Date: ",T,!,"Collection site: ",S,!,LR("%")
 W !,N,?31,"Sex: ",SEX,?38,"DOB: ",DOB W ?60,"ABO: ",E," Rh: ",F
 I SSN]"" W !,"SSN: ",SSN
 W !,A(1)," ",A(2)," ",A(3),!,A(4),", ",Z(5)," ",A(6),!,"Home phone: ",A(7),"  Business phone: ",A(8)
 W !,"Employer/Donor Group(s):",?36,"Current donation type:" F X=0:0 S X=$O(^LRE(W,2,X)) Q:'X  S Y=^(X,0) W !?4,$S($D(^LAB(65.4,Y,0)):$P(^(0),"^",3),1:"")
 W !,"Cum donations: ",M,?20,"Previous visit: ",LR(65.54,.01) I LR(65.54,1)]"" W " (",LR(65.54,1) W:LR(65.54,1)'["DONATION" " DONATION" W ")"
 Q
H1 D H Q:LR("Q")  W !!,"Donor History (continued from pg ",LRQ-1,")" Q
 ;
END D V^LRU Q
