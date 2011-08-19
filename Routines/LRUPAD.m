LRUPAD ;AVAMC/REG/WTY - LAB ACCESSION LIST BY DATE ;9/25/00
 ;;5.2;LAB SERVICE;**72,248**;Sep 27, 1994
 ;
 ;Reference to ^%DT supported by IA #10003
 ;Reference to ^DIC supported by IA #10006
 ;
 I '$D(LRAA)!('$D(LRAA(1))) D ^LRUBYDIV G:'$D(Y) END
 K C S %DT="",X="T" D ^%DT S (Q(1),Q(2),Z(4))=0 D D^LRU,EN^LRUTL S Z(1)=Y
 S:'$D(LRO(68)) LRO(68)=LRAA(1) W !!?20,LRO(68)," ACCESSION LIST"
 D B^LRU G:Y<0 END
 S LRLDT=LRLDT+.99,X=$P(^LRO(68,LRAA,0),U,3),V(1)=$S(X="Y":$E(LRSDT,1,3)_"0000",1:LRSDT),V=$S(X="Y":$E(LRLDT,1,3)_"0000",1:LRLDT)
L W !!,"List by (A)ccession number  (P)atient  ",$S("CHMI"[LRSS:"(C)ollection Sample ",1:""),": " R X:DTIME G:X=""!(X[U) END I $A(X)'=65&($A(X)'=67)&($A(X)'=80) D S G L
 I "AP"'[$E(X)&(X?1"C".E&("CHMI"'[LRSS)) D H G L
 W:$L(X)=1 $S(X="P":"atient",X="A":"ccession number",1:"ollection Sample") G:X?1"P".E ^LRUPAD2
 I X?1"C".E S DIC="62",DIC(0)="AEMOQ",DIC("A")="Select COLLECTION SAMPLE: " D ^DIC K DIC G:Y<1 END S C(1)=+Y,C=$P(Y,U,2)
 S ZTRTN="QUE^LRUPAD" D BEG^LRUTL G:POP!($D(ZTSK)) END
QUE U IO S LRU(1)=+$O(^LAB(62,"B","UNKNOWN",0)) D L^LRU,S^LRU,H S LR("F")=1
 S V(1)=V(1)-1
 F I=V(1):0 S I=$O(^LRO(68,LRAA,1,I)) Q:'I!(I>V)!(LR("Q"))  S LRSA=LRSDT-.01 F B=LRSA:0 S B=$O(^LRO(68,LRAA,1,I,1,"E",B)) Q:'B!(B>LRLDT)!(LR("Q"))  I $P(B,".")=I!($E(I,6,7)="00") D O
 I 'LR("Q"),LRSS="CY" D:$Y>(IOSL-8) H Q:LR("Q")  W !?72,"-----",!,"Cell block (b) count: ",Q(1),?58,"Slide count:",?72,$J(Q(2),5)
 W:IOST'?1"C".E&($E(IOST,1,2)'="P-"!($D(LR("FORM")))) @IOF
 D END^LRUTL,END Q
O F N=0:0 S N=$O(^LRO(68,LRAA,1,I,1,"E",B,N)) Q:'N!(LR("Q"))  S LRC(5)=$S($D(^LRO(68,LRAA,1,I,1,N,3)):$P(^(3),"^",6),1:"") D ^LRUPAD1
 Q
H ;from LRUPAD1
 I $D(LR("F")),IOST?1"C".E D M^LRU Q:LR("Q")
 D F^LRU
 W !,LRO(68)," (",LRSTR,"-",LRLST,")",! W:$D(C)#2 "Collection Sample: ",C,!
 W "# = Not VA patient  ",$S(LRSS="CY":"* = Reviewed by pathologist",1:""),?57,$S("AUSPCYEMMI"[LRSS:"% =Incomplete",1:"")
 W ?60,$S("CH"[LRSS:"%=Test not verified",1:"") I LRSS="CY" W ?72,"Slide"
 W !,"Acc #",?8,"Date",?14,$S(LRSS="MI":"Patient/Source",1:"Patient"),?34,"ID",?40,"Loc" W:LRSS'="AU" ?46,$S("SPCYEM"[LRSS:"Physician",1:"Spec/sample") I LRSS="CY" W ?72,"Count"
 I "CHMI"[LRSS W ?62,"Test",?76,"Tech",!,LR("%") Q
 W:LRSS="AU" ?46,"Date/time of Autopsy" W !,LR("%") Q
S W !!,"Enter following letter for appropriate listing:"
 W !?5,"'A'  for listing by accession number"
 W !?5,"'P'  for listing by patient"
 W:"AUCYEMSP"'[LRSS !?5,"'C'  for listing by collection sample"
 Q
 ;
END D V^LRU Q
