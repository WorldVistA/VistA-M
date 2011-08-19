LRBLJR ;AVAMC/REG/CYM - RELEASE FROM XMATCH ;6/20/96  12:11 ;
 ;;5.2;LAB SERVICE;**72,247,267,408**;Sep 27, 1994;Build 8
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 Q  D END S X="BLOOD BANK" D ^LRUTL G:Y=-1 END I LRCAPA S X="UNIT RELEASE" D X^LRUWK G:'$D(X) END
ASK K DIC,LRZ W ! D ^LRDPA G:LRDFN=-1 END K A,LRV D R G ASK
 ;
R W ! S LRX=0 F A=1:1 S LRX=$O(^LRD(65,"AP",LRDFN,LRX)) Q:'LRX  I $D(^LRD(65,LRX,0)) S W=^(0),M=$P(^(2,LRDFN,0),"^",2),A(A)=LRX D:A=1 H D W
 I A=1 W $C(7),!!,"No units crossmatched for ",LRP Q
 D DT^LRBLU I A=2 S LRV=1 D RES G OUT:$D(LRZ),REL
SEL W !,"Select units (1-",A-1,") for release: " R X:DTIME Q:X=""!(X[U)  I X["?" W !,"Enter numbers from 1 to ",A-1,!,"For 2 or more selections separate each with a ',' (ex. 1,3,4)",!,"Enter 'ALL' for all units." G SEL
 G:X="ALL" ALL
 I X?.E1CA.E!($L(X)>200) W $C(7),!,"No CONTROL CHARACTERS, LETTERS or more than 200 characters allowed" G SEL
 I '+X W $C(7),!,"START with a NUMBER !!",! G SEL
 S LRQ=X D RES G:$D(LRZ) OUT F LRA=0:0 S LRV=+LRQ,LRQ=$E(LRQ,$L(LRV)+2,$L(LRQ)) D:LRV REL Q:'$L(LRQ)
 Q
REL I '$D(A(LRV)) W !!,$C(7),"Selection ",LRV," doesn't exist.",! Q
 I P(LRV)]"",P(LRV)'["BLOOD BANK" W $C(7),!!,$P(^LRD(65,A(LRV),0),"^")," not returned to BLOOD BANK.  Cannot release." Q
 S A=1,LRX=A(LRV) I '$D(LRV(2)) S W=^LRD(65,LRX,0) W ! D W W !?25,"Ok to release " S %=1 D YN^LRU Q:%'=1
 K ^LRD(65,"AP",LRDFN,LRX) S X=$P(^LRD(65,LRX,2,LRDFN,0),"^",3),^(0)=LRDFN
 I X S X=$O(^LRD(65,LRX,2,LRDFN,1,"B",X,0)) I X,$D(^LRD(65,LRX,2,LRDFN,1,X,0)) S $P(^(0),"^",10)=LRV(1)
 W:'$D(LRV(2)) !?3,"Released",! D:LRCAPA ^LRBLW Q
 ;
ALL S LRV(2)=1 D RES G:$D(LRZ) OUT F LRV=0:0 S LRV=$O(A(LRV)) Q:'LRV  D REL
 W !!?3,"All valid releases completed." Q
 ;
W D:A#20=0 M S P=+$O(^LRD(65,LRX,3,0)) S P(A)=$S($D(^(P,0)):$P(^(0),"^",4),1:"")
 W A,")",?3,$P(W,"^"),?17,$J($P(W,"^",7),2),?20,$P(W,"^",8),?24,$E($P(^LAB(66,$P(W,"^",4),0),"^"),1,20),?45 S T=$P(W,"^",6) D T^LRBLJX W T,?58 I M S T=M D T^LRBLJX W T
 W ?70,$E(P(A),1,10),! Q
H W !,"#",?3,"Unit ID",?17,"ABO/Rh",?24,"Component",?45,"Exp date",?58,"Xmatch date",?70,"Location",! Q
M R "Press RETURN",X:DTIME W $C(13),$J("",15),$C(13) Q
RES R !,"Reason for release: ",X:DTIME I X=""!(X[U) S:X[U LRZ=1 K X G SET
 I X="TRANSFUSED" W $C(7),"   Not allowed, try again." G RES
 I X["?"!($E(X)=" ") D  G RES
 . N HLP D FIELD^DID(65.02,.1,"","HELP-PROMPT","HLP")
 . S HLP=HLP("HELP-PROMPT") W !,HLP
 . S L(1)="B" D Q^LRUB
 N CHK S CHK=$$GET1^DID(65.02,.1,"","INPUT TRANSFORM") X CHK I '$D(X) W $C(7),!,"Reason not valid, try again " S %=1 D YN^LRU G:%=1 RES
SET S LRV(1)=$S($D(X):X,1:"No release reason given") Q
OUT W $C(7)," Unit(s) not released." Q
END D V^LRU Q
