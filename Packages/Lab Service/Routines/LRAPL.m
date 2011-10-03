LRAPL ;SLC/BA/AVAMC/REG/CYM - ANATOMIC PATH LABELS ;2/13/98  12:27 ;
 ;;5.2;LAB SERVICE;**72,201**;Sep 27, 1994
 S LRDICS="SPCYEM" D ^LRAP G:'$D(Y) END
ASK S %DT="",X="T" D ^%DT S LR(5)=$E(Y,1,3)+1700 W !,"Enter year: ",LR(5),"// " R X:DTIME G:'$T!(X[U) END S:X="" X=LR(5)
 S %DT="EQ" D ^%DT G:X["?" ASK G:Y<1 END S LR(2)=$E(Y,1,3) W "  ",LR(2)+1700
R R !!,"Start with accession number: ",X:DTIME G:X=""!(X[U) END S LR(3)=X I +X'=X D HELP G R
RR R !,"Go    to   accession number: LAST// ",LR(4):DTIME G:'$T!(LR(4)[U) END S:LR(4)="" LR(4)=9999999 I LR(4)'=+LR(4) D HELP G RR
 S:'LR(4) LR(4)=9999999
 I LR(4)<LR(3) S X=LR(3),LR(3)=LR(4),LR(4)=X
 W !!?33,"REMEMBER TO",!?13,"ALIGN THE PRINT HEAD ON THE FIRST LINE OF THE LABEL"
 S LR(3)=LR(3)-1,LR(1)=$S($D(^LRO(69.2,LRAA,0)):$P(^(0),U,7),1:"")
I W !!?20,"ENTER  NUMBER OF LINES  FROM",!?20,"TOP OF ONE LABEL TO ANOTHER: ",LR(1),$S(LR(1):"// ",1:"") R X:DTIME Q:'$T!(X[U)  S X=$S(X="":LR(1),$L(X)>2:X=1,1:X)
A X $P(^DD(69.2,.07,0),U,5,99) I '$D(X) W:$D(^DD(69.2,.07,3)) !,$C(7),^(3) X:$D(^(4)) ^(4) G I
 I X["?" S X="ZZZ" G A
 S LR(1)=X
 S ZTRTN="QUE^LRAPL",ZTDESC="Anatomic Path Labels",ZTSAVE("LR*")="" D BEG^LRUTL G:POP!($D(ZTSK)) END
QUE U IO D XR^LRU
 F A=LR(3):0 S A=$O(^LR(LRXREF,LR(2),LRABV,A)) Q:'A!(A>LR(4))  S LRDFN=+$O(^(A,0)),LRI=+$O(^(LRDFN,0)) D W
 D END^LRUTL,END Q
W S LRX=$G(^LR(LRDFN,LRSS,LRI,0)) I LRX="" K ^LR(LRXREF,LR(2),LRABV,A,LRDFN,LRI) Q
 Q:$P($P(LRX,U,6)," ")'=LRABV
 S W=^LR(LRDFN,0),Y=$P(W,"^",3),(LRDPF,P)=$P(W,"^",2),X=^DIC(P,0,"GL"),X=@(X_Y_",0)") S P(1)=$P(X,"^"),SSN=$P(X,"^",9),S(6)=$P(LRX,"^",6),LRSPECDT=+LRX D SSN^LRU
 F B=0:0 S B=$O(^LR(LRDFN,LRSS,LRI,.1,B)) Q:'B  S S(2)=^(B,0) D P
 Q
P W !,S(6),"  Taken: ",$$FMTE^XLFDT(LRSPECDT,"D")
 W !,P(1)," ",SSN
 W !,$P(S(2),"^") F X=4:1:LR(1) W !
 Q
HELP W $C(7),!!,"Enter numbers only",! Q
END K LRSPECDT D V^LRU Q
