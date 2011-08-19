LRUMDM ;AVAMC/REG/CYM - MD SELECTED LAB RESULTS ;2/19/98  15:01 ;
 ;;5.2;LAB SERVICE;**201**;Sep 27, 1994
 W !!,"New page for each patient " S %=2 D YN^LRU G:%<1 END S:%=1 LRK=1
 S ZTRTN="QUE^LRUMDM" D BEG^LRUTL G:POP!($D(ZTSK)) END
QUE U IO K ^TMP($J) S LRS="F:FINAL REPORT;P:PRELIMINARY  REPORT;",LRJ=+$O(^LRO(68,"B","MICROBIOLOGY",0)),LRM=$P(^DD(63.05,24,0),U,3)
 D L^LRU,L1^LRU,S^LRU D:'$D(LRK) H S P=0,LR("F")=1 I LRDFN(1) D I G END
 I LRG]""!(LRE) D EN^LRUMDP:LRG]"",EN1^LRUMDP:LRE F R=0:0 S P=$O(^TMP($J,P)) Q:P=""!(LR("Q"))  F LRDFN=0:0 S LRDFN=$O(^TMP($J,P,LRDFN)) Q:'LRDFN!(LR("Q"))  D I
 G:LRG]""!(LRE) END F R=0:0 S P=$O(^LRO(69.2,LRAA,7,DUZ,1,"C",P)) Q:P=""!(LR("Q"))  F LRDFN=0:0 S LRDFN=$O(^LRO(69.2,LRAA,7,DUZ,1,"C",P,LRDFN)) Q:'LRDFN!(LR("Q"))  D I
END W:$E(IOST)="P" @IOF D V^LRU,END^LRUTL Q
I I LRA]"" Q:'$D(^LRO(69.2,LRAA,7,DUZ,1,LRDFN,1))  Q:LRA'=^(1)
 S X=^LR(LRDFN,0),Y=$P(X,"^",3),(LRDPF,X)=$P(X,"^",2),X=^DIC(X,0,"GL"),V=@(X_Y_",0)"),LRP=$P(V,"^"),SSN=$P(V,"^",9),LRL=$S($D(@(X_Y_".1)")):^(.1),$D(^LR(LRDFN,.1)):^(.1),1:"") D SSN^LRU
 D:$Y>(IOSL-6)!($D(LRK)) H Q:LR("Q")  W !,"SSN:",SSN,?19,"LOC:",LRL,?44,"Patient: ",LRP D T
 Q:LR("Q")  W !,LR("%1") Q
T S LRI=LRLDT,W(1)=0 F E=0:0 S LRI=$O(^LR(LRDFN,"MI",LRI)) Q:'LRI!(LRI>LRSDT)!(LR("Q"))  D W,O Q:LR("Q")
 Q
O F LRF=16,5,8,11,1 Q:LR("Q")  D:$Y>(IOSL-6) H1 Q:LR("Q")  D L
 F LRF=3,6,9,12,17 Q:LR("Q")  F B=0:0 D:$Y>(IOSL-6) H1 Q:LR("Q")  S B=$O(^LR(LRDFN,"MI",LRI,LRF,B)) Q:'B!(LR("Q"))  S B(1)=^(B,0),O=$P(^LAB(61.2,+B(1),0),"^") W !?13,O," ",$P(B(1),"^",2) D C
 F LRF=15,2,4,7,10,13,18,19,25,26,99 Q:LR("Q")  F B=0:0 D:$Y>(IOSL-6) H1 Q:LR("Q")  S B=$O(^LR(LRDFN,"MI",LRI,LRF,B)) Q:'B!(LR("Q"))  S X=^(B,0) W !?9,X
 W:W(1) !,LR("%") Q
L I $D(^LR(LRDFN,"MI",LRI,LRF)) S X=^(LRF),Y=+X,Z=$P(X,"^",2)_":" S:Z=":" Z="" D D^LRU W !,$S(LRF=1:"BACT",LRF=5:"PARASITE",LRF=8:"MYCOLOGY",LRF=11:"TB",LRF=16:"VIROLOGY",1:""),?9,"RPT DATE:",Y,?44,$P($P(LRS,Z,2),";") D:LRF=11 M
 Q
W Q:LR("Q")
 S W(1)=W(1)+1,X=^LR(LRDFN,"MI",LRI,0),LRN=$P(X,"^",6),LRC=$P(X,"^",11),Y=+X_"000",T=+$P(X,"^",5),LRJ=$P(LRN," ") S:'$L(LRJ) LRJ=0
 S LRJ=+$O(^LRO(68,"B",LRJ,0))
 S LRDATE=$TR($$Y2K^LRX(Y,"5M"),"@"," ") I LRC,$D(^LAB(62,LRC,0)) S LRC=$P(^(0),"^")
 S LRB=+$P(LRN," ",3),LRB(1)=$E(X,1,3)_"0000" I W(1)=1 D A Q:LR("Q")
 D:$Y>(IOSL-6) H1 Q:LR("Q")  W !,LRDATE,?17,$E($P($G(^LAB(61,T,0)),"^"),1,28),?44,LRC,?62,LRN S X=$S($D(^LR(LRDFN,"MI",LRI,99)):^(99),1:"") W:X]"" !?3,X
 S LRB(2)=0 F LRB(3)=1:1 S LRB(2)=$O(^LRO(68,LRJ,1,LRB(1),1,LRB,4,LRB(2))) Q:'LRB(2)  D:$Y>(IOSL-6) H1 Q:LR("Q")  W ! W:LRB(3)=1 ?3,"Tests:" W ?10,$S($D(^LAB(60,LRB(2),0)):$P(^(0),"^"),1:"")
 Q
M S Z=$P(X,U,3)_":" S:Z=":" Z="" W !?15,$P($P(LRM,Z,2),";")," ",$P(X,U,4) Q
C I LRF=17 W !?15,$P(B(1),"^",11) Q
 F Z=0:0 S Z=$O(^LR(LRDFN,"MI",LRI,LRF,B,1,Z)) Q:'Z!(LR("Q"))  S LRZ=^(Z,0) D:$Y>(IOSL-6) H1 Q:LR("Q")  W:LRF'=6 !?15,LRZ D:LRF=6 C1
 Q
C1 F V=0:0 S V=$O(^LR(LRDFN,"MI",LRI,LRF,B,1,Z,1,V)) Q:'V  S LRZ=^(V,0) D:$Y>(IOSL-6) H1 Q:LR("Q")  W !?15,LRZ
 Q
 ;
H I $D(LR("F")),IOST?1"C".E D M^LRU Q:LR("Q")
 D F^LRU W !,"List for: ",$P(^VA(200,DUZ,0),"^") W:LRA]"" ?40,"PT GRP: ",LRA W:LRE ?40,LRE(1) W:IOST'?1"C".E !,"Work copy- DO NOT PUT IN PATIENT'S CHART" W !,LR("%") Q
H1 D H Q:LR("Q")  I W(1)>1 W !,"SSN:",SSN,?19,"LOC:",LRL,?44,"Patient: ",LRP
A W !,"Date",?13,"Site/specimen",?44,"Collection sample",?62,"Accession number" Q
