LRBLPUS ;AVAMC/REG/CYM - PATIENT UNIT SELECTION ;08/15/01 1:15 pm
 ;;5.2;LAB SERVICE;**72,247,267,275,408**;Sep 27, 1994;Build 8
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 Q  D END,CK G:Y=-1 END
 S LRB=$O(^LAB(61.3,"C",50710,0))
 I 'LRB D EN1^LRBLU
 W !!,?24,"Selection of units for a patient",!!?28,LRAA(4),!?12,"Accession Area: ",LRO(68)
 S LR(3)="",LRU(2)=1 D BAR^LRBLB
 W !!?15,"Select only unassigned/uncrossmatched units "
 S %=1 D YN^LRU G:%<1 END S:%=1 LRK=1
P W ! K S,V,DIC
 D ^LRDPA K DIC,DIE,DR
 W ! G:LRDFN=-1 END
 D ^LRBLPA K Z
 G:$D(Q("Q"))!(LRDFN=-1) P D REST G P
REST Q:LRLLOC["DIED"
 W !,LRP," ",SSN(1),?37,$J(LRPABO,2),?40,LRPRH D EN
 I '$O(^LR(LRDFN,1.8,0)) W $C(7),!!,"Must have blood component request(s) on record to select units",! Q
 S A=0 F B=1:1 S A=$O(^LRD(65,"AP",LRDFN,A)) Q:'A  D N
 W ! S A=0 F B=0:1 S A=$O(^LR(LRDFN,1.8,A)) Q:'A  S X=^(A,0) W:'B !,"Component(s) requested",?24,"Units",?30,"Request date/time",?48,"Wanted date/time",?65,"Requestor",?77,"By" D L
C K X W !! S X=$$READ^LRBLB("Blood component for unit selection: ") Q:X=""!(X[U)
 I LR,$E(X,1,$L(LR(2)))=LR(2) D
 .D P^LRBLB
 E  W $$STRIP^LRBLB(.X)  ; Strip off the data identifiers just in case
 I '$D(X) W $C(7),!,"Code not entered in BLOOD PRODUCT file or not product label.",!
 S DIC="^LR(LRDFN,1.8,",DIC(0)="EQMZ" D ^DIC K DIC,G
 G:Y<1 C D G G C
G S C=+Y,X=^LAB(66,C,0),LRV=$P(X,"^",10),C(19)=$P(X,"^",19),C(9)=$P(X,"^",9),C(7)=$P(X,"^",7),C(8)=$P(X,"^",8),C(1)=$P(Y,"^",2)
 ;
 ; LR*5.2*275 - Specific Requirement 1 from SRS
 ; BNT - Added K LRJ
 I C(9)=1 K LRJ D ^LRBLPCS1 Q:'$D(Z)
 ;
 S B=0 I $D(Z) S A=0 F B=0:1 S A=$O(Z(A)) Q:'A  S Y=+Z(A) D DD^LRX W !,A,") ",Y," Acc # ",$P(Z(A),"^",3)
 I B=1 S G=Z(1) G R
S I B W !,"Select patient blood sample (1-",B,"): " R X:DTIME Q:X=""!(X[U)  I X<1!(X>B)!(+X'=X) W !,"Select a number from 1 to ",B,! G S
 S:B G=Z(X)
R I $D(G) S G(1)=$P(+G,".",1),G(3)=$P(G,"^",3) S:G(3)'=+G(3) G(3)=$P(G(3)," ",3),G(6)=""
 I $D(G),C(9)=1 S G(4)=$P(G,U,2),G(5)=$P(G,U,3) D
 . S LRSPABO=$P($G(^LR(LRDFN,"BB",G(4),10)),U)
 . S LRSPRH=$P($G(^LR(LRDFN,"BB",G(4),11)),U)
 . Q:LRSPABO=""  Q:LRSPRH=""
 . I LRSPABO'=LRPABO!(LRSPRH'=LRPRH) W $C(7),!!,"Results on "_G(5)_" do not match the Patient's previous ABO/Rh history",!!,"Resolve the discrepancy before proceeding ",! S G(6)=1 K LRSPABO,LRSPRH
 I $D(G),G(6)=1 Q
 G ^LRBLPUS1
 ;
N W:B=1 !?6,"Unit assigned/xmatched:",?46,"Exp date",?67,"Location"
 I '$D(^LRD(65,A,0)) K ^LRD(65,"AP",LRDFN,A) Q
 S X=^LRD(65,A,0),L=$O(^(3,0)) S:'L L="Blood Bank" I L S L=$P(^(L,0),"^",4)
 S M=^LAB(66,$P(X,"^",4),0)
 W !,$J(B,2),")",?6,$P(X,"^"),?17,$E($P(M,"^"),1,19),?38,$P(X,"^",7)_" "_$P(X,"^",8),?44
 S Y=$P(X,"^",6) D DD^LRX S:L<0 L="Blood bank" W Y,?64,L Q
 ;
L W !,$E($P(^LAB(66,+X,0),"^"),1,23),?24,$J($P(X,"^",4),3),?30 S Y=$P(X,"^",3) D M W Y,?48 S Y=$P(X,"^",5) D M W Y,?65,$P(X,"^",9),?77,$S($P(X,"^",8)="":"",$D(^VA(200,$P(X,"^",8),0)):$P(^(0),"^",2),1:$P(X,"^",8)) Q
M D DD^LRX
 Q
EN ; from LRBLJL
 S M=0 F A=0:0 S A=$O(^LRD(65,"AU",LRDFN,A)) Q:'A  I $S('$D(^LRD(65,A,4)):1,$P(^(4),"^")="":1,1:0),$D(^(8)) S C=^(8),M=M+1 W:M=1 !,$C(7),"Units restricted for ",LRP S X=^(0) W !,$P(X,"^"),?15,$P(^LAB(66,$P(X,"^",4),0),"^")
 Q
CK ;called by LRBLPX,LRBLJLA,LRBLAA,LRBLJL,LRBLPCS
 S LR("M")=1,X="BLOOD BANK" D ^LRUTL Q:Y=-1
 I LRSS'="BB" W $C(7),!!,"MUST BE BLOOD BANK" S Y=-1 Q
 S LRI=$O(^LAB(60,"B","TRANSFUSION REQUEST",0)) I 'LRI W $C(7),!,"TRANSFUSION REQUEST must be entered in LAB TEST file (#60).",! S Y=-1 Q
 S LRAA=+$P($G(^LAB(60,LRI,8,+DUZ(2),0)),U,2) I 'LRAA W !!,$C(7),!!,"TRANSFUSION REQUEST in LAB TEST file (#60) must have an accession area",!,"assigned to your DIVISION.",! S Y=-1 Q
 S X=$G(^LRO(68,LRAA,0)),LRO(68)=$P(X,U),LRABV=$P(X,U,11)
 I X="" W $C(7),!!,"There is no accession area for ",LRAA,!,"in the accession area file (#68)." S Y=-1 Q
 I LRABV="" W !!,$C(7),"There is no abbreviation entered for ",LRO(68),!,"in the accession area file (#68)." S Y=-1
 Q
 ;
END D V^LRU Q
