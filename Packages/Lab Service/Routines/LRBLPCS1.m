LRBLPCS1 ;AVAMC/REG/CYM - COMPONENT SELECTION CK PT SPEC ;7/22/97  08:13 ;
 ;;5.2;LAB SERVICE;**1,72,90,247**;Sep 27, 1994
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 S (H,M)=0
 S X=$P(^LAB(66,C,0),"^",16) S:'X X=72 S Z=X*60,X="N",%DT="T" D ^%DT K %DT S X=Y,X(1)=Y_"000" D H^%DTC S %H=%H-(Z\1440),Z=Z#1440 I Z S %H=%H-1,Z=1440-Z,H=Z\60,M=Z#60
 I 'H,'M S H=$E(X(1),9,10),M=$E(X(1),11,12)
 D D^LRUT S X=X_"."_$E("00",1,2-$L(H))_H_$E("00",1,2-$L(M))_M,G=9999999-X
 ; Following 10 lines check spec. age during LRBLPLOGIN
 I '$D(LRQ) D
 . K Z S A=0 F B=0:0 S B=$O(^LR(LRDFN,"BB",B)) Q:'B!(B>G)  S X=^(B,0),S=$P(X,"^",5) I S=LRBBSPEC,LRABV=$P($P(X,"^",6)," ") S Y=$P(X,"^",10) S:'Y Y=+X S A=A+1,Z(A)=Y_"^"_B_"^"_$P(X,"^",6) Q:$D(LRJ)
 . I '$D(Z),'$D(LRQ) W $C(7),!?18,"No patient blood sample within required time",!?9,"Obtain a new sample from the patient for compatibility testing",!
 . S Y="^" Q
 I $D(LRQ) D
 . K Z S A=0 F B=0:0 S B=$O(^LR(LRDFN,"BB",B)) Q:'B!(B>G)  S X=^(B,0),S=$P(X,"^",5) I S=E,LRABV=$P($P(X,"^",6)," ") S Y=$P(X,"^",10) S:'Y Y=+X S A=A+1,Z(A)=Y_"^"_B_"^"_$P(X,"^",6) Q:$D(LRJ)
 . Q:'$D(LRCDT)
 . N LRINVDT S LRINVDT=(9999999-LRCDT)
 . I LRINVDT>G W $C(7),!,?18,"Log in specimen collection date/time NOT within required time",!,?9,"Obtain a new sample from the patient for compatibility testing",!
 S Y="^" Q
 ;
EN ;
 S:'$D(LRAA)#2 LRAA=$O(^LRO(68,"B","BLOOD BANK",0)) Q:'LRAA
 I LRAA<1 S LRAA=$O(^LRO(68,"B","BLOOD BANK",0)) Q:'LRAA
 I '$D(^LRO(69.2,LRAA,8,0)) S ^(0)="^69.31A^^"
 I '$D(^LRO(69.2,LRAA,8,66,0)) S ^(0)=66,X=^LRO(69.2,LRAA,8,0),^(0)="^69.31A^66^"_($P(X,"^",4)+1)
 L +^LRO(69.2,LRAA,8,66):5 I '$T W $C(7),!!,"I Cannot add this request to the Inappropriate transfusion requests report at this time ",!!,"Please make note ...",!! Q
 S:'$D(^LRO(69.2,LRAA,8,66,1,0)) ^(0)="^69.32A^^"
 F A=0:0 S A=$O(LRK(A)) Q:'A  I $D(^LR(LRDFN,1.8,A,0)) S X(2)=^(0),A(3)=$P(X(2),"^",3),Y=$P(X(2),"^",5),A(1)=$P(^LAB(66,A,0),"^") D D^LRU,B
 L -^LRO(69.2,LRAA,8,66) Q
B I '$D(^LRO(69.2,LRAA,8,66,1,A,0)) S ^(0)=A(1),X=^LRO(69.2,LRAA,8,66,1,0),^(0)=$P(X,"^",1,2)_"^"_A_"^"_($P(X,"^",4)+1),^LRO(69.2,LRAA,8,66,1,"B",A(1),A)=""
 S:'$D(^LRO(69.2,LRAA,8,66,1,A,1,0)) ^(0)="^69.321DA^^" S X(1)=^(0),X=$P(X(1),"^",4)
A S X=X+1 G:$D(^LRO(69.2,LRAA,8,66,1,A,1,X,0)) A
 S ^LRO(69.2,LRAA,8,66,1,A,1,0)=$P(X(1),"^",1,2)_"^"_X_"^"_($P(X(1),"^",4)+1),^(X,0)=A(3)_"^"_PNM_"^"_SSN,^(1,0)="^69.3211A^^"
 S ^LRO(69.2,LRAA,8,66,1,A,1,X,1,1,0)="Pre-op:"_$S($P(X(2),"^",2):"Yes",1:"No"),^LRO(69.2,LRAA,8,66,1,A,1,X,1,2,0)="Date wanted: "_Y_"  #Units:"_$P(X(2),"^",4)_"  Requestor:"_$P(X(2),"^",9)
 S ^LRO(69.2,LRAA,8,66,1,A,1,X,1,3,0)="Request entered by: "_$P(^VA(200,DUZ,0),"^")
 S X(3)=0,X(4)=3
 I $D(^LR(LRDFN,1.8,A,2)) S X(3)=^(2) S:$P(X(3),"^")]"" X(4)=X(4)+1,^LRO(69.2,LRAA,8,66,1,A,1,X,1,X(4),0)=$P(X(3),"^") S:$P(X(3),"^",2)]"" X(4)=X(4)+1,^LRO(69.2,LRAA,8,66,1,A,1,X,1,X(4),0)="Approved by: "_$P(X(3),"^",2)
 S Y=$P(X(3),"^",3) I Y,$D(^DIC(45.7,Y,0)) S Y=$P(^(0),"^"),Y(1)=^LRO(69.2,LRAA,8,66,1,A,1,X,1,1,0),^(0)=Y(1)_"  Treating Specialty: "_Y
 F B=0:0 S B=$O(C(A,B)) Q:'B  F E=0:0 S E=$O(C(A,B,E)) Q:'E  D C
 I $D(LRK(A,1)) S X(4)=X(4)+1,^LRO(69.2,LRAA,8,66,1,A,1,X,1,X(4),0)=LRK(A,1)
 S Y=^LRO(69.2,LRAA,8,66,1,A,1,X,1,0),^(0)=$P(Y,"^",1,2)_"^"_X(4)_"^"_X(4) Q
C Q:'$D(S(B,E))  S Y=S(B,E),X(4)=X(4)+1,^LRO(69.2,LRAA,8,66,1,A,1,X,1,X(4),0)=$P(Y,"^",3)_"  "_$P(Y,"^",2)_":"_$P(Y,"^")_" "_$P(Y,"^",4)_"  "_$P(Y,"^",5) Q
