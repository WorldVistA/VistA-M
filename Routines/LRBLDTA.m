LRBLDTA ;AVAMC/REG/CYM - ABNORMAL DONOR TESTS ;6/28/96  09:04 ;
 ;;5.2;LAB SERVICE;**72,247**;Sep 27, 1994
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 D END S X="BLOOD BANK" D ^LRUTL G:Y=-1 END
 W !!?20,"Blood donor- Abnormal Test List"
A R !!,"Start with DONOR UNIT ID: ",X:DTIME G:X=""!(X[U) END D C G:'$D(X) A
 S A=$A(X,$L(X))-1,A=$C(A),LRA=$E(X,1,$L(X)-1)_A
B R !,"Go    to   DONOR UNIT ID: ",X:DTIME G:X=""!(X[U) END D C G:'$D(X) B
 S LRB=X,ZTRTN="QUE^LRBLDTA" D BEG^LRUTL G:POP!($D(ZTSK)) END
 ;
QUE U IO F A=12:1:20 D FIELD^DID(65.54,A,"","LABEL","LRA") S LRA(A)=LRA("LABEL")
 D L^LRU,S^LRU,H S A=LRA,LR("F")=1 F B=0:0 S A=$O(^LRE("C",A)) Q:A=""!(A]LRB)!(LR("Q"))  D F
 D END^LRUTL,END Q
F S I=$O(^LRE("C",A,0)),LRIDT=+$O(^(I,0)) Q:'$D(^LRE(I,5,LRIDT,0))  S Y=$P(+^(0),".",1) D D^LRU S LRT=Y
 S F=0 F E=0:0 S E=$O(LRA(E)) Q:'E  I $D(^LRE(I,5,LRIDT,E)),+^(E) S F=F+1,Z=^(E) D G
 I F W !,LR("%")
 Q
G D:$Y>(IOSL-5) H Q:LR("Q")  W:F=1 !,LRT,?14,A,?26,I W:F>1 ! W ?36,LRA(E)," ",$P(Z,"^",3)
 Q
 ;
H I $D(LR("F")),IOST?1"C".E D M^LRU Q:LR("Q")
 D F^LRU W !,"LABORATORY SERVICE",?23,"ABNORMAL TEST RESULTS FOR DONORS"
 W !,"Donation Date",?14,"Unit ID",?26,"DONOR",?36,"TEST",!,LR("%") Q
 ;
C I X'?.UN!($L(X)<6)!($L(X)>11) W $C(7)," Entry must be 6-11 digits &/or UPPER CASE letters" K X
 Q
 ;
END D V^LRU Q
