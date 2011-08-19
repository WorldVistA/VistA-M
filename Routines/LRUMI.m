LRUMI ;AVAMC/REG - MICRO RREJCTED SPECIMEN REPORT ;10/6/93  11:52 ;
 ;;5.2;LAB SERVICE;;Sep 27, 1994
 D END S DIC=68,DIC(0)="QMZ",X="MICROBIOLOGY" D ^DIC K DIC G:Y<1 END S X=$P(Y,U,2) D ^LRUTL G:Y=-1 END
 D B^LRU G:Y<0 END
 S ZTRTN="QUE^LRUMI" D BEG^LRUTL G:POP!($D(ZTSK)) END
QUE U IO S (LRG,LR("Q"),LRQ)=0,LRQ(1)=^DD("SITE") D L^LRU,H S LR("F")=1
 S LRLDT=LRLDT+.99,LRB=$E(LRSDT,1,3)_"0000",LRE=$E(LRLDT,1,3)_"0000"
 S LRB=LRB-1 F I=LRB:0 S I=$O(^LRO(68,LRAA,1,I)) Q:'I!(I>LRE)!(LR("Q"))  S LRSA=LRSDT-.01 F B=LRSA:0 S B=$O(^LRO(68,LRAA,1,I,1,"E",B)) Q:'B!(B>LRLDT)!(LR("Q"))  D O
 S LRA=0 F LRB=0:0 S LRA=$O(^TMP($J,"L",LRA)) Q:LRA=""!(LR("Q"))  D:$Y>(IOSL-3) H Q:LR("Q")  W !!,"Location: ",LRA,!,"---------" D L
 S LRG=1 D H S LRA=0 F LRB=0:0 S LRA=$O(^TMP($J,"S",LRA)) Q:LRA=""!(LR("Q"))  D:$Y>(IOSL-3) H Q:LR("Q")  W !!,"Specimen: ",LRA,!,"---------" D T
 D END^LRUTL,END Q
L S LRC=0 F LRD=0:0 S LRC=$O(^TMP($J,"L",LRA,LRC)) Q:LRC=""!(LR("Q"))  D:$Y>(IOSL-3) H1 Q:LR("Q")  D A
 Q
T S LRC=0 F LRD=0:0 S LRC=$O(^TMP($J,"S",LRA,LRC)) Q:LRC=""!(LR("Q"))  D:$Y>(IOSL-3) H2 Q:LR("Q")  D A
 Q
O F LRAN=0:0 S LRAN=$O(^LRO(68,LRAA,1,I,1,"E",B,LRAN)) Q:'LRAN  S LRDFN=+^LRO(68,LRAA,1,I,1,LRAN,0),LRI=$P(^(3),"^",5) D S
 Q
S S LRC=$S($D(^LR(LRDFN,"MI",LRI,1)):$P(^(1),"^",5),1:"") I LRC["CON" S LRAC=^(0),LRN=5 D SET
 S LRC=$S($D(^LR(LRDFN,"MI",LRI,99)):^(99),1:"") I LRC["rej"!(X["REJ") S LRAC=^(0),LRN=99 D SET
 F LR=0:0 S LR=$O(^LR(LRDFN,"MI",LRI,4,LR)) Q:'LR  S LRC=^(LR,0) I LRC["rej"!(LRC["REJ") S LRAC=^LR(LRDFN,"MI",LRI,0),LRN=4 D SET Q
 F LR=0:0 S LR=$O(^LR(LRDFN,"MI",LRI,7,LR)) Q:'LR  S LRC=^(LR,0) I LRC["rej"!(LRC["REJ") S LRAC=^LR(LRDFN,"MI",LRI,0),LRN=7 D SET Q
 Q
SET S A=$P(LRAC,"^",6),L=$P(LRAC,"^",8),S=+$P(LRAC,"^",5),S=$S($D(^LAB(61,S,0)):$P(^(0),"^"),1:"") S:S="" S="?" S:L="" L="?"
 S ^TMP($J,"A",A)=LRDFN_"^"_LRI_"^"_L_"^"_S_"^"_+LRAC,^(A,LRN)=LRC,^TMP($J,"L",L,A)="",^TMP($J,"S",S,A)="" Q
A S LRZ=^TMP($J,"A",LRC),LRDFN=+LRZ,LRI=$P(LRZ,"^",2),X=^LR(LRDFN,0),Y=$P(X,"^",3),X=^DIC($P(X,"^",2),0,"GL"),LRY=@(X_Y_",0)") D W
 F LRF=0:0 S LRF=$O(^TMP($J,"A",LRC,LRF)) Q:'LRF!(LR("Q"))  D:$Y>(IOSL-3) H Q:LR("Q")  W !,^TMP($J,"A",LRC,LRF)
 Q
W S Z=$S('LRG:$P(LRZ,"^",4),1:$P(LRZ,"^",3)),Y=$P(LRZ,"^",5) D DT^LRU W !,LRC,?15,$E(Z,1,12),?28,Y,?43,$P(LRY,"^"),?74,$E($P(LRY,"^",9),6,10) Q
 Q
H I $D(LR("F")),IOST?1"C".E D M^LRU Q:LR("Q")
 D F^LRU W !,"MICROBIOLOGY REJECTED SPECIMENS FROM: ",LRSTR," THROUGH: ",LRLST,!,"ACCESSION",?15,$S('LRG:"SPECIMEN",1:"LOCATION"),?28,"DATE TAKEN",?43,"PATIENT",?75,"SSN",!,LR("%") Q
H1 D H Q:LR("Q")  W !!,"Location: ",LRA,!,"---------" Q
H2 D H Q:LR("Q")  W !!,"Specimen: ",LRA,!,"---------" Q
 ;
END D V^LRU Q
