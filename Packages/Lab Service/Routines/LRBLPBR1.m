LRBLPBR1 ;AVAMC/REG/CYM - BB TESTS REPORT ;2/23/98  12:02 ;
 ;;5.2;LAB SERVICE;**203,247,267**;Sep 27, 1994
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 ;from LRBLPBR, LRBLSUM
 S LR(2)=0,LRMD=$P(LR,"^",5) D H S LR("F")=1
 I $D(^LR(LRDFN,1.7)) W !?4,"Antibodies identified: " F LR(9)=0:0 S LR(9)=$O(^LR(LRDFN,1.7,LR(9))) Q:'LR(9)!(LR("Q"))  D:$Y>(IOSL-9) FT,H1 Q:LR("Q")  W:$X>(IOM-15) !?4 W $P(^LAB(61.3,LR(9),0),"^"),"; "
 D:$Y>(IOSL-9) FT,H Q:LR("Q")  I $D(LRN(2)) D C
 D DT S LRI=0 F A=1:1 S LRI=$O(^LR(LRDFN,LRSS,LRI)) Q:'LRI!(LR("Q"))  S LR(5)=^(LRI,0) I $P(LR(5),"^",3) D:$Y>(IOSL-9) H2 Q:LR("Q")  S T=+LR(5) D T W !?4,T D W
FT Q:LR("Q")  F X=1:1 Q:$Y>(IOSL-9)  W !
 W !,LR("%")
 W !,N,?31,$P(LR,"^",2),?45,DOB,?56,$J($P(LR,"^",3),2),?59,$P(LR,"^",4),!,"Location: ",G,?39,"Physician: ",LRMD,!,"CUMULATIVE BLOOD BANK TEST REPORT",?50,"PERMANENT COPY",!,"(discard earlier copies)" Q
W S X=$S($D(^LR(LRDFN,LRSS,LRI,10)):^(10),1:""),LRN(10.3,3)=$P(X,"^",3) W ?21,$J($P(X,"^"),2) S X=$S($D(^(11)):^(11),1:""),LRN(11.3,3)=$P(X,"^",3) W ?24,$P(X,"^")
 S X=$S($D(^LR(LRDFN,LRSS,LRI,2)):^(2),1:""),LRN(2.91,3)=$P(X,"^",10) F H=1,4,6,9 S Y=$P(X,"^",H) W ?(30+$S(H=4:5,H=6:10,H=9:15,1:0)),$S(Y="N":"Neg",Y="P":"Pos",H=9&(Y="I"):"Invalid",1:Y)
 S X=$S($D(^LR(LRDFN,LRSS,LRI,6)):^(6),1:""),Y=$P(X,"^") W ?62,$S(Y="N":"Neg",Y="P":"Pos",1:Y)
 F X=10.3,11.3,2.91 I LRN(X,3)]"" W !,LRN(X),":",LRN(X,3)
 F J=0:0 S J=$O(^LR(LRDFN,LRSS,LRI,"EA",J)) Q:'J!(LR("Q"))  D:$Y>(IOSL-9) H Q:LR("Q")  W !,"ELUATE ANTIBODY: ",$S($D(^LAB(61.3,J,0)):$P(^(0),"^"),1:J)
 S J=0 F  S J=$O(^LR(LRDFN,LRSS,LRI,5,J)) Q:'J!(LR("Q"))  D:$Y>(IOSL-9) H Q:LR("Q")  W !,"SERUM ANTIBODY IDENTIFIED: ",$S($D(^LAB(61.3,J,0)):$P(^(0),"^"),1:J)
 F J=0:0 S J=$O(^LR(LRDFN,LRSS,LRI,4,J)) Q:'J!(LR("Q"))  S J(1)=^(J,0) D:$Y>(IOSL-9) H Q:LR("Q")  W !,LRN(8),":",J(1)
 F J=0:0 S J=$O(^LR(LRDFN,LRSS,LRI,99,J)) Q:'J!(LR("Q"))  S J(1)=^(J,0) D:$Y>(IOSL-9) H Q:LR("Q")  W !?8,J(1)
 Q
T S Y=T D DD^LRX S T=Y Q
 ;
C S A=0 F B=1:1 S A=$O(^LRD(65,"AP",LRDFN,A)) Q:'A!(LR("Q"))  D N
 Q:LR("Q")  I B=1 W !,"No UNITS assigned/xmatched",!
 W ! S A=0 F B=0:1 S A=$O(^LR(LRDFN,1.8,A)) Q:'A!(LR("Q"))  S F=^(A,0) D:'B R D L
 Q:LR("Q")  I 'B W "No component requests",!
 Q
N W:B=1 !!?6,"Unit assigned/xmatched:",?47,"Exp date",?68,"Loc"
 I '$D(^LRD(65,A,0)) K ^LRD(65,"AP",LRDFN,A) Q
 S F=^LRD(65,A,0),L=$O(^(3,0)) S:'L L="Blood Bank" I L S L=$P(^(L,0),"^",4)
 S M=^LAB(66,$P(F,"^",4),0) D:$Y>(IOSL-9) H3 Q:LR("Q")  W !,$J(B,2),")",?4,$P(F,"^"),?19,$E($P(M,"^"),1,19),?40,$P(F,"^",7)_" "_$P(F,"^",8),?47 S Y=$P(F,"^",6) D D^LRU S:L<0 L="Blood bank" W Y,?68,$E(L,1,12) Q
 ;
L I '$D(^LAB(66,+F,0)) L +^LR(LRDFN,1.8) K ^LR(LRDFN,1.8,+F) S X=^LR(LRDFN,1.8,0),X(1)=$O(^LR(LRDFN,1.8,0)),^LR(LRDFN,1.8,0)=$P(X,"^",1,2)_"^"_X(1)_"^"_$S(X(1)="":"",1:($P(X,"^",4)-1)) L -^LR(LRDFN,1.8) Q
 W !,$E($P(^LAB(66,+F,0),"^"),1,26),?26,$J($P(F,"^",4),2),?31 S T=$P(F,"^",3) D T W T,?48 S T=$P(F,"^",5) D T W T,?65,$E($P(F,"^",9),1,12),?77,$S($P(F,"^",8)="":"",$D(^VA(200,$P(F,"^",8),0)):$P(^(0),"^",2),1:$P(F,"^",8)) Q
 ;
H I $D(LR("F")),IOST?1"C".E D M^LRU Q:LR("Q")
 D F^LRU W !?20,"BLOOD BANK TEST REPORT",!,LR("%")
 W !?10,"Patient",?34,"SSN",?43,"Birth Date",?55,"ABO",?59,"Rh",!,?10,"-------",?34,"---",?43,"----------",?55,"---",?59,"--"
 S T=+LR D T S DOB=T W !,N,?31,$P(LR,"^",2),?44,T,?56,$J($P(LR,"^",3),2),?59,$P(LR,"^",4),!!
 Q
H1 D H Q:LR("Q")  W !!?4,"Antibodies identified (cond't from pg ",LR(2)-1,")" Q
H2 D FT,H Q:LR("Q")  D DT Q
DT W !!,?30,"|---",?39,"AHG(direct)",?55,"---|",?62,"|-AHG(indirect)-|",!?4,"Date/time",?20,"ABO",?24,"Rh",?30,"POLY",?35,"IgG",?40,"C3",?45,"Interpretation",?62,"(Antibody screen)"
 W !?4,"---------",?20,"---",?24,"--",?30,"----",?35,"---",?40,"---",?45,"--------------",?62,"-----------------" Q
H3 D H Q:LR("Q")  W !!?6,"Unit assigned/xmatched:",?47,"Exp date",?68,"Loc" Q
R W !,"Component requests",?25,"Units",?32,"Request date",?48,"Date wanted",?65,"Requestor",?77,"By" Q
