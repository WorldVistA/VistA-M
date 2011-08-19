LRUER ;AVAMC/REG/CYM - ERROR TRACKING ;2/18/98  07:03 ;
 ;;5.2;LAB SERVICE;**201,290**;Sep 27, 1994
ASK W !!?5,"Find accessions with comments containing",!?20,"1. reported incorrectly as",!?20,"2. specimen rejected",!?5,"Select 1 or 2: " R X:DTIME G:X=""!(X[U) END I +X'=X!(X<1)!(X>2) G ASK
 S LRC(2)="",LRC(1)=$S(X=1:"reported incorrectly as",X=2:"specimen rejected",1:"") W !!,"List accessions with deleted comments " S %=2 D YN^LRU G:%<1 END S:%=1 LRC(2)=1
 D B^LRU G:Y<0 END S LRS=LRSDT-.01,LRE=LRLDT+.99,LRLDT=9999998-LRLDT,LRSDT=9999999-LRSDT
 W !!,"Do you want list of tests ordered for each accession with errors " S %=1 D YN^LRU G:%<1 END S LRF=$S(%=1:1,1:0)
 W !!,"New page for each accession area " S %=1 D YN^LRU G:%<1 END S LRL=$S(%=1:1,1:0)
 W ! S ZTRTN="QUE^LRUER" D BEG^LRUTL G:POP!($D(ZTSK)) END
QUE U IO
 N A,B,C,D,E,G,J,LRDFN,LRX,V,X,Y,Z
 K ^TMP($J),^TMP("LRDFN",$J)
 S LRQ(1)=^DD("SITE"),(LRQ,LR("Q"))=0
 D L^LRU,H S LR("F")=1
 F B=LRS:0 S B=$O(^LRO(69,B)) Q:'B!(B>LRE)  D
 . N X,I
 . S I=0 F  S I=$O(^LRO(69,B,1,I)) Q:'I  S X=+$G(^(I,0)) I X D
 . . S ^TMP("LRDFN",$J,X)=""
 F LRDFN=0:0 S LRDFN=$O(^TMP("LRDFN",$J,LRDFN)) Q:'LRDFN  S LRI=LRLDT F A=0:0 S LRI=$O(^LR(LRDFN,"CH",LRI)) Q:'LRI!(LRI>LRSDT)  D A
 K ^TMP("LRDFN",$J) D W,END^LRUTL,END Q
A I LRC(2),$O(^LR(LRDFN,"CH",LRI,1,"AC",0)) D SET Q
 F B=0:0 S B=$O(^LR(LRDFN,"CH",LRI,1,B)) Q:'B  I ^(B,0)[LRC(1) D SET Q
 Q
SET S X=^LR(LRDFN,"CH",LRI,0),Y=$P(X,"^",6) S:Y="" Y="?? ?? ??" S ^TMP($J,$P(Y," "),$P(Y," ",2,3),+X,LRDFN,LRI)=$P(X,"^",5) Q
 Q
W S (LRA,LRC)="" F A=0:0 S LRA=$O(^TMP($J,LRA)) Q:LRA=""!(LR("Q"))  S LRC=LRC+1 D:LRL&(LRC>1) H Q:LR("Q")  S LRB="" F B=0:0 S LRB=$O(^TMP($J,LRA,LRB)) Q:LRB=""!(LR("Q"))  D W1
 Q
W1 F LRT=0:0 S LRT=$O(^TMP($J,LRA,LRB,LRT)) Q:'LRT!(LR("Q"))  F LRDFN=0:0 S LRDFN=$O(^TMP($J,LRA,LRB,LRT,LRDFN)) Q:'LRDFN!(LR("Q"))  D X
 Q
X F LRI=0:0 S LRI=$O(^TMP($J,LRA,LRB,LRT,LRDFN,LRI)) Q:'LRI!(LR("Q"))  S X=+^(LRI),LRS=$P($G(^LAB(61,X,0)),"^") D P
 Q
P S LRDATE=$$FMTE^XLFDT(LRT,"M")
 S X=^LR(LRDFN,0),Y=$P(X,"^",3),(LRDPF,X)=$P(X,"^",2),X=^DIC(X,0,"GL"),V=@(X_Y_",0)"),LRP=$P(V,"^"),SSN=$P(V,"^",9) D SSN^LRU
 D:$Y>(IOSL-6) H W !!,LRA_" "_LRB,?14,LRDATE,?34,LRP," ",SSN(1),?67,LRS D:LRF TST Q:LR("Q")
 F B=0:0 S B=$O(^LR(LRDFN,"CH",LRI,1,B)) Q:'B!(LR("Q"))  S B(1)=^(B,0) D:$Y>(IOSL-6) H1 Q:LR("Q")  W !?5,B(1)
 F B=0:0 S B=$O(^LR(LRDFN,"CH",LRI,1,"AC",B)) Q:'B!(LR("Q"))  S C="" F E=0:0 S C=$O(^LR(LRDFN,"CH",LRI,1,"AC",B,C)) Q:C=""  D:$Y>(IOSL-6) H1 Q:LR("Q")  D P1
 Q
P1 S X=$G(^VA(200,B,0)) W !?5,$P(^LR(LRDFN,"CH",LRI,1,"AC",B,C),"^",3) W:$X>60 ! W " (deleted by ",$S($P(X,"^",2)]"":$P(X,"^",2),1:$P(X,",")),")" Q
 ;
TST S:'$D(LR(LRA)) LR(LRA)=+$O(^LRO(68,"B",LRA,0)) S X=$P(^LRO(68,LR(LRA),0),"^",3),Z=$P(LRB," ",2),G=$E(LRT,1,3) S:X="D" G=G_$P(LRB," ")
 E  S G=$S(X="Y":G_"0000",X="M":G_$E($P(LRB," "),1,2)_"00",1:G)
 S (C,E,E(1))=0 F E(1)=0:0 S C=$O(^LRO(68,LR(LRA),1,G,1,Z,4,C)) Q:'C!(LR("Q"))  S LRX=^(C,0) I $P(^LAB(60,C,0),U,4)'="WK" D B
 Q
B S E=E+1,J=$P(LRX,U,4),J=$S(J:$P($G(^VA(200,J,0)),"^",2),1:J) D:$Y>(IOSL-6) H2 Q:LR("Q")  W ! W:E=1 "Test(s) ordered:" W ?18,$P($G(^LAB(60,C,0)),"^"),?49,"Tech: ",J Q
 ;
H I $D(LR("F")),IOST?1"C".E D M^LRU Q:LR("Q")
 D F^LRU W !,LRC(1) W:$L(LRC(1))>44 ! W " From: ",LRSTR," To: ",LRLST,!,"Acc #",?14,"Date/Time",?34,"Name/SSN",?67,"Specimen",!,LR("%") Q
H1 D H Q:LR("Q")  W !,LRA," ",LRB,?14,LRDATE,?34,LRP," ",SSN(1)," ",LRS Q
H2 D H1 Q:LR("Q")  W !,"Test(s) ordered:" S E=2 Q
 Q
END D V^LRU Q
