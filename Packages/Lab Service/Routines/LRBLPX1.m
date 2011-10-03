LRBLPX1 ;AVAMC/REG - XMATCH RESULTS (COND'T) ; 08/17/01 3:30 PM ;
 ;;5.2;LAB SERVICE;**247,267,275**;Sep 27, 1994
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 S LRI=+LRJ I '$D(^LRD(65,LRI,0)) K ^LR(LRDFN,1.8,E,1,B,0),^TMP($J,LRV) S X=^LR(LRDFN,1.8,E,1,0),X(1)=$O(^(0)),^(0)=$P(X,"^",1,2)_"^"_X(1)_"^"_$S(X(1)="":"",1:($P(X,"^",4)-1)),LRV=LRV-1 Q
 W:LRV=1 !?6,"Unit for XMATCHING",?52,"Exp date",?68,"Loc"
EN ;from LRBLPX
 K F(1),F(2)
 D:'$D(LR("%")) L^LRU
 S X=^LRD(65,LRI,0),A=$P(X,"^",7),H=$P(X,"^",8),L=$O(^(3,0)),LRE=^LAB(66,$P(X,"^",4),0),L=$S(L:$P(^LRD(65,LRI,3,L,0),"^",4),1:"Blood Bank")
 W !!,$J(LRV,2),")",?6,$P(X,"^"),?20,$E($P(LRE,"^"),1,23),?45,$J(A,2),?48,H,?52 S Y=$P(X,"^",6) D DT^LRU S:L<0 L="Blood bank" W Y,?68,$E(L,1,12)
 S X=$S($D(^LRD(65,LRI,10)):$P(^(10),"^"),1:"") S:X="ND" X="" I X="" W $C(7),!,"ABO not rechecked"
 I X]"",X'=A W $C(7),!,"ABO recheck (group ",X,") does not match ABO group of unit.  Resolve discrepancy." S F(2)=1
 S X=$S($D(^LRD(65,LRI,11)):$P(^(11),"^"),1:"") S:X="ND" X="" I H="NEG",X="" W $C(7),!,"Rh NEG unit not rechecked"
 I X]"",X'=H W $C(7),!,"Rh recheck (type ",X,") does not match Rh  type  of unit.  Resolve discrepancy." S F(2)=1
 ;
 ; LR*5.2*275 Specific Requirement 3,4, and 5 from SRS
 ; BNT 
 S X=$P(LRJ,"^",2)
 ; Initialize ABO/RH to false (No Results associated with this accn)
 S (X(10),X(11))=0
 ;
 ; Get ABO/RH Interpretation from file 63 for this accession
 I $D(^LR(LRDFN,LRSS,X,10)) D
 . ; Check if results are null or Not Done (ND) for ABO
 . S X(10)=$S($P(^LR(LRDFN,LRSS,X,10),"^")="":0,$P(^(10),"^")="ND":0,1:1)
 . ; Check if results match patient historical ABO rusults
 . ; LRPABO is ABO GROUP of 0 node in file 63
 . I 'X(10) Q
 . I $P(^LR(LRDFN,LRSS,X,10),"^")'=LRPABO S F(2)=1
 ;
 I $D(^LR(LRDFN,LRSS,X,11)) D
 . ; Check if results are null or Not Done (ND) for RH
 . S X(11)=$S($P(^LR(LRDFN,LRSS,X,11),"^")="":0,$P(^(11),"^")="ND":0,1:1)
 . ; Check if results match patient historical RH results
 . ; LRPRH is RH TYPE of 0 node in file 63
 . I 'X(11) Q
 . I $P(^LR(LRDFN,LRSS,X,11),"^")'=LRPRH S F(2)=1
 ;
 ; If results don't match historical ABO or RH, display warning message
 ; and don't proceed.
 I $D(F(2)) D  Q
 . N LRACN,LRERRMSG
 . S LRACN=$P(^LR(LRDFN,LRSS,X,0),"^",6)
 . S LRERRMSG(1)="Results on "_LRACN_" do not match the Patient's previous ABO/Rh history"
 . S LRERRMSG(1,"F")="$C(7),!!"
 . S LRERRMSG(2)="Resolve the discrepancy before proceeding "
 . S LRERRMSG(2,"F")="!!"
 . S LRERRMSG(3,"F")="!"
 . D EN^DDIOL(.LRERRMSG)
 S X(6)=$S('$D(^LR(LRDFN,LRSS,X,6)):0,$P(^(6),"^")="":0,1:1)
 ;
 ; ************* END Patch LR*5.2*275 *************
 ;
 S X=^LR(LRDFN,LRSS,X,0),(LRJ,^TMP($J,LRV))=LRJ_"^"_+X_"^"_$P(X,"^",6)_"^"_X(10)_"^"_X(11)_"^"_X(6) K X
 I '$P(LRJ,"^",6)!'$P(LRJ,"^",7) W $C(7),!?4,"No patient ABO &/or Rh results" S (F(1),X)=1
 I '$P(LRJ,"^",8) W !?4,"No antibody screen results" S (F(6),X)=1
 I $D(X) S Y=$P(LRJ,"^",4) D DT^LRU W ?31,"(spec date:",Y," acc#:",$P($P(LRJ,"^",5)," ",3),")"
C S Z(1)=0 I $D(R),$P(LRE,"^",9)=1,$P(LRE,"^",25)'=1 W ! F Z=0:0 S Z=$O(R(Z)) Q:'Z  I Z'=LRB,'$D(^LRD(65,LRI,70,Z,0)) W !,$P(^LAB(61.3,Z,0),"^"),$E("..............",$X,14),?15,"RBC ANTIGEN" S Z(1)=1
 I Z(1) W $C(7),!,"Above antigen(s) not entered in RBC ANTIGEN ABSENT field"
 Q
STF Q:'$D(^LRO(68,LRAA,1,LRAD,1,LRAN,0))#2
 I '$D(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRT,0)) S ^(0)=LRT_"^50^^"_DUZ_"^"_LRK,^(1,0)="^68.14P^^",X=^LRO(68,LRAA,1,LRAD,1,LRAN,4,0),^(0)=$P(X,"^",1,2)_"^"_LRT_"^"_($P(X,"^",4)+1)
 F A=0:0 S A=$O(LRT(A)) Q:'A  D:'$D(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRT,1,A,0)) A S Y=^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRT,1,A,0),Z=$P(Y,U,3),X=$S('Z:$P(Y,U,2)+1,1:1),$P(Y,U,2,3)=X_U_0,$P(Y,U,7)=DUZ,$P(Y,U,6)=LRK,^(0)=Y
 S ^LRO(68,"AA",LRAA_"|"_LRAD_"|"_LRAN_"|"_LRT)="",$P(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRT,0),"^",5)=LRK Q
A S ^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRT,1,A,0)=A_"^0^0^0^^"_LRK_"^"_DUZ_"^"_DUZ(2)_"^"_LRAA_"^"_LRAA_"^"_LRAA,X=^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRT,1,0),^(0)=$P(X,"^",1,2)_"^"_A_"^"_($P(X,"^",4)+1) Q
 ;
CK S LRT=$O(^LAB(60,"B","WKLD CROSSMATCH",0)) I LRT F B=0:0 S B=$O(^LAB(60,LRT,9,B)) Q:'B  S LRT(B)=""
 Q:$D(LRT)=11
 W $C(7),!,"Must have test in LAB TEST file (#60) called 'WKLD CROSSMATCH' with WKLD CODES." K LRT Q
