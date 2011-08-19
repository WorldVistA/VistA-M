LRCYPCT ;AVAMC/REG - CYTOPATH %POS,NEG,SUSP, & UNSAT ;8/13/95  15:41 ;
 ;;5.2;LAB SERVICE;**72**;Sep 27, 1994
 S LRDICS="CY" D ^LRAP G:'$D(Y) END S IOP="HOME" D ^%ZIS W @IOF,!,LRO(68)," (",LRABV,") Cytology Specimens:"
 I $O(^LRO(69.2,LRAA,12,0)) W !,"Use morphology list " S %=1 D YN^LRU G:%<1 END I %=1 D M G:$D(LRA) TO
 F X=80013,69760,"09460","09010" S Y=$O(^LAB(61.1,"C",X,0)) W !?25,$S(Y:"% "_$P(^LAB(61.1,Y,0),"^"),1:"No entry in Morphology file for SNOMED code: "_X) G:'Y OUT S LRA(Y)=$P(^(0),"^")
TO W ! K LRN,LRM I $O(^LRO(69.2,LRAA,11,0)) W !,"Use topography category list " S %=1 D YN^LRU G:%<1 END I %=1 D SET G:$D(LRN) DATE
 W ! F B=1:1 D ASK Q:X[U!(X="")
DATE G:B<2 END W ! D B^LRU G:Y<0 END S LRSDT=LRSDT-.01,LRLDT=LRLDT+.99 W !!,"Include locations for each morphology " S %=2 D YN^LRU G:%<1 END S LRP=$S(%=1:1,1:0)
 S ZTRTN="QUE^LRCYPCT" D BEG^LRUTL G:POP!($D(ZTSK)) END
QUE U IO K ^TMP($J) S LR=0 D L^LRU,S^LRU,XR^LRU,H S LR("F")=1
 F X=0:0 S LRSDT=$O(^LR(LRXR,LRSDT)) Q:'LRSDT!(LRSDT>LRLDT)  D LRDFN
 D P K ^TMP($J) D END^LRUTL,END Q
LRDFN F LRDFN=0:0 S LRDFN=$O(^LR(LRXR,LRSDT,LRDFN)) Q:'LRDFN  D I
 Q
I F LRI=0:0 S LRI=$O(^LR(LRXR,LRSDT,LRDFN,LRI)) Q:'LRI  I $P($P($G(^LR(LRDFN,LRSS,LRI,0)),U,6)," ")=LRABV D T
 Q
T F O=0:0 S O=$O(^LR(LRDFN,LRSS,LRI,2,O)) Q:'O  S T=^(O,0) D TG
 Q
TG Q:'$D(^LAB(61,T,0))  S T=$P(^(0),"^",2) S A=0 F E=0:0 S A=$O(LRN(A)) Q:A=""  I A=$E(T,1,LRM(A)) D G Q
 Q
G S:'$D(^TMP($J,A)) ^(A)=0 S X=^(A),^(A)=X+1 S LRL=$P(^LR(LRDFN,LRSS,LRI,0),"^",8) S:LRL="" LRL="??"
 F M=0:0 S M=$O(^LR(LRDFN,LRSS,LRI,2,O,2,M)) Q:'M  S M(1)=^(M,0) I $D(LRA(M(1))) S:'$D(^TMP($J,A,M(1))) ^(M(1))=0 S X=^(M(1)),^(M(1))=X+1 S:'$D(^TMP($J,A,M(1),LRL)) ^(LRL)=0 S X=^(LRL),^(LRL)=X+1 Q
 Q
P S LRN=0 F A=0:0 S LRN=$O(^TMP($J,LRN)) Q:LRN=""!(LR("Q"))  S S=^(LRN),LR=LR+S D:$Y>(IOSL-6) H Q:LR("Q")  W !!,LRN(LRN,0)," (",LRN,"): ",?55,$J(S,5) D S
 Q:LR("Q")  D:$Y>(IOSL-10) H Q:LR("Q")  W !!,"Total specimens found: ",?55,$J(LR,5) F B=0:0 S B=$O(LRA(B)) Q:'B!(LR("Q"))  W !?3,$P(LRA(B),"^") S X=$P(LRA(B),"^",2) Q:'LR  W ?36,$J(X,5)," (",$J(X/LR*100,4,1),"%)"
 Q
S F B=0:0 S B=$O(^TMP($J,LRN,B)) Q:'B!(LR("Q"))  S T=^(B) D:$Y>(IOSL-6) H1 Q:LR("Q")  W !?3,$P(LRA(B),"^"),?36,$J(T,5)," (",$J(T/S*100,4,1),"%)" S $P(LRA(B),"^",2)=$P(LRA(B),"^",2)+T D:LRP L
 Q
L S LRL=0 F C=0:0 S LRL=$O(^TMP($J,LRN,B,LRL)) Q:LRL=""!(LR("Q"))  S L=^(LRL) D:$Y>(IOSL-6) H2 Q:LR("Q")  W !?5,$E(LRL,1,23),?30,$J(L,3)
 Q
ASK K A("B") W !,"Select 1 or more characters of SNOMED TOPOGRAPHY code (Choice# ",B,"): " R X:DTIME Q:X=""!(X[U)
 D CK G:$D(A("B")) ASK S LRN(X)="",LRM(X)=$L(X)
C R !,"ENTER IDENTIFYING COMMENT: ",X(1):DTIME I X(1)=""!(X[U) K LRN(X),LRM(X) W $C(7),!!,"You must enter an identifying comment <ENTRY DELETED>",! G ASK
 I X(1)'?1ANP.ANP!($L(X(1))<2)!($L(X(1))>30)!(X(1)["?") W $C(7),!!,"Enter free text 2-30 characters",!," (Ex. for 2 you may want to enter Respiratory System)",! G C
 S LRN(X,0)=X(1) Q
 ;
H I $D(LR("F")),IOST?1"C".E D M^LRU Q:LR("Q")
 D F^LRU W !,LRO(68)," Counts From ",LRSTR," To ",LRLST,! W:LRP ?5,"Location",?25,"Location Count" W ?55,"Count",!,LR("%") Q
H1 D H Q:LR("Q")  W !,LRN(LRN,0),?55,$J(S,5) Q
H2 D H1 Q:LR("Q")  W !?3,$P(LRA(B),U),?36,$J(T,5)," (",$J(T/S*100,4,1),"%)" Q
OUT W !!,$C(7),?12,"Please have appropriate person enter missing SNOMED code",!?24,"in the MORPHOLOGY FIELD file (#61.1)" D V^LRU Q
CK I X'?1UN.UN!($L(X)>6) S A("B")=1 G SHW
 S I=0 F I(1)=1:1:$L(X) I "0123456789ABCDEFXY"'[$E(X,I(1)) S A("B")=1 Q
SHW Q:'$D(A("B"))  W $C(7),!!,"Enter up to 6 characters.",!,"Entry can only contain digits, letters 'X' and 'Y'.",!,"One character entered -> most general  All 6 characters -> most specific",! Q
 ;
SET S X=0 F B=0:0 S X=$O(^LRO(69.2,LRAA,11,"B",X)) Q:X=""  F C=0:0 S C=$O(^LRO(69.2,LRAA,11,"B",X,C)) Q:'C  S E=$P(^LRO(69.2,LRAA,11,C,0),"^",2),LRN(X)="",LRM(X)=$L(X),LRN(X,0)=E W !,X," ",E
 S:$D(LRN) B=2 Q
M F B=0:0 S B=$O(^LRO(69.2,LRAA,12,B)) Q:'B  S LRA(B)=$P(^LAB(61.1,B,0),"^") W !,LRA(B)
 Q
 ;
END D V^LRU Q
