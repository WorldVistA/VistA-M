LRUD ;AVAMC/REG - STUFF DATA CHANGES ;3/10/95  14:39 ;
 ;;5.2;LAB SERVICE;**35,247**;Sep 27, 1994
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
N S F("Z")=1
 S Z(2)="",N=$S($D(DUZ):DUZ,1:"") I N S Z(2)=$P(^VA(200,N,0),"^")
 S Z(3)=$S(A:F(A),1:F(0)),Z(3)=$P(^DD(Z(3),Z(7),0),"^")
 S %DT="T",X="N" D ^%DT S Z(10)=Y,Z(1)=Y
 S Z(4)=Z(5),Z(6)=Z D SET S Z(5)=Z(4) Q
SET S X=@("^DD("_Z(6)_",0)"),Z(3)=$P(X,"^"),X(1)=$P(X,"^",2) I X(1)'["F"&(X(1)'["N") D @($S(X(1)["P":"P",X(1)["S":"S",X(1)["D":"D",1:"V"))
 I $D(@("^DD("_Z(6)_",2.1)")) S Y=Z(4) X ^(2.1) S Z(4)=Y
 Q
D I F("Z") S Y=O D D^LRU S O=$S(Y[1700:"",1:Y)
 S Y=Z(4) D D^LRU S Z(4)=$S(Y[1700:"",1:Y) Q
P S X(1)="^"_$P(X,"^",3) I F("Z"),O,$D(@(X(1)_O_",0)")) S O=$P(^(0),"^")
 S:Z(4) Z(4)=$P(@(X(1)_Z(4)_",0)"),U,1) Q
S S X(1)=$P(X,"^",3) I F("Z") S:O]"" O=O_":",O=$P($P(X(1),O,2),";",1)
 S:Z(4)]"" Z(4)=Z(4)_":",Z(4)=$P($P(X(1),Z(4),2),";",1) Q
V Q
EN ;
 Q:'$D(LRAA)  S (Z(0),Z(5))=X,Z(7)=$P(Z,",",2) K A,B,F,X,Y S X("U")=+Z,F("Z")=0
 F A=0:1 S B=$S($D(^DD(X("U"),0,"UP")):^("UP"),1:0) Q:'B  S X=$O(^DD(B,"SB",X("U"),0)),X(A)=""""_$P($P(^DD(B,X,0),"^",4),";",1)_"""",X("U")=B
 S B=0 F X=0:0 S X=$O(DA(X)) Q:'X  S B=X S:$D(X(X)) F(A-X,"S")=X(X)
 I A S Y(B)=DA,Y(0)=DA(B),F(A,"S")=X(0),B(1)=B-1 F X=1:1:B(1) S Y(X)=DA(B-X)
 I 'A S Y(0)=$S(B:DA(B),1:DA)
 D T,N L +^LRO(69.2,LRAA) I '$D(^LRO(69.2,LRAA,0)) S Z(6)=$P(^LRO(68,LRAA,0),"^",11),^(0)=LRAA_"^"_Z(6),^LRO(69.2,"B",LRAA,LRAA)="",^LRO(69.2,"C",Z(6),LRAA)="",X=^LRO(69.2,0),^(0)=$P(X,"^",1,2)_"^"_LRAA_"^"_($P(X,"^",4)+1)
 S:'$D(^LRO(69.2,LRAA,999,0)) ^(0)="^69.299DA^^" S X=^(0),^(0)=$P(X,"^",1,2)_"^"_Z(10)_"^"_($P(X,"^",4)+1)
E I $D(^LRO(69.2,LRAA,999,Z(10),0)) S Z(10)=Z(10)+.00001 G E
 I Z(0)="Deleted",Z(5)="" S Z(5)=Z(0)
 S ^LRO(69.2,LRAA,999,Z(10),0)=Z(1)_"^"_Z(2)_"^"_Z(3)_"^"_O_"^"_Z(5)_"^"_F(0,"N")_"^"_F(0,"E")_"^"_F(0,"I") L -^LRO(69.2,LRAA)
 S X=0 F A=0:1 S X=$O(F(X)) Q:'X  S ^LRO(69.2,LRAA,999,Z(10),1,X,0)=F(X,"N")_"^"_$S($D(F(X,"E")):F(X,"E"),1:"")_"^"_F(X)
 S:A ^LRO(69.2,LRAA,999,Z(10),1,0)="^69.37A^"_A_"^"_A I $D(LRSS),$D(L(LRSS)) D @(LRSS_"^LRUD1")
 K A,B,F,O,X,Y S Y="^",X=Z(0) K Z Q
 ;
T I 'A S F(0)=+Z,F(0,"N")=$O(^DD(+Z,0,"NM",0)),X=^DIC(+Z,0,"GL"),Z(4)=$P(@(X_Y(0)_",0)"),"^"),Z(6)=+Z_",.01" D SET D:+Z=63 F S F(0,"E")=Z(4),F(0,"I")=Y(0) Q
 S (X("U"),F(A))=+Z,A=A-1
 F B=A:-1:0 S F(B)=$S($D(^DD(X("U"),0,"UP")):^("UP"),1:""),X("U")=F(B),F(B+1,"N")=$O(^("NM",0)) D:'B TT
 S V=V(0) F X=0:0 S X=$O(F(X)) Q:'X!('$D(Y(X)))  S V(X)=V_F(X,"S")_","_Y(X)_",",V=V(X)
 S A=A+1 F B=1:1:A I $D(V(B)),$D(Y(B)) S Z(4)=$S($D(@(V(B)_"0)")):$P(@(V(B)_"0)"),"^"),1:""),Z(6)=F(B)_",.01" D SET S F(B,"E")=Z(4)
 Q
TT S F(0,"N")=$O(^DD(X("U"),0,"NM",0)),F(0,"I")=Y(0),(X,F(0,"S"))=^DIC(F(0),0,"GL"),V(0)=F(0,"S")_Y(0)_",",Z(4)=$P(@(V(0)_"0)"),"^"),Z(6)=F(0)_",.01" D SET D:F(0)=63 F S F(0,"E")=Z(4) Q
F S X=^LR(Z(4),0),Y=$P(X,"^",3),X=$P(X,"^",2),X=^DIC(X,0,"GL"),Z(4)=$P(@(X_Y_",0)"),"^") Q
A ;from [LRBLSCREEN] file 63
 K L W !,$C(7),"Is present testing OK " S %=2 D YN^LRU S LR("YN")=% S:%=1 L("BB")=1 D EN Q
 ;;Z=FILE,FIELD
 ;;Z(1)=DATA CHANGE DATE
 ;;Z(2)=PERSON CHANGING DATA
 ;;Z(3)=DATA ELEMENT
 ;;Z(4)=ENTRY IN FILE
 ;;O OLD INFORMATION
 ;;Z(5) NEW INFORMATION
