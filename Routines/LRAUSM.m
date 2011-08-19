LRAUSM ;AVAMC/REG - AUTOPSY SNOMED SEARCH ;8/14/95  09:53
 ;;5.2;LAB SERVICE;**72,253**;Sep 27, 1994
 S IOP="HOME",LR("S")=$P(^LRO(69.2,LRAA,0),U,8) D ^%ZIS W @IOF,?20,LRAA(1)," search by ",S(7)," code"
 S (LR,LR(1),LR(2),LR(3))=0
TP K A("B") W !!,"TOPOGRAPHY (Organ/Tissue)",!?5,"Select 1 or more characters of the code:",!?5 R "For all sites type 'ALL' : ",X:DTIME Q:X=""!(X[U)  I X["ALL" S S(2)="ALL"
 E  D CK G:$D(A("B")) TP S S(2)=X,S(1)=$L(X)
 K LRN,LRM S (LRO,LRN)="" W !!,S(7) I LRSN=61.5 D POS^LRAPSM Q:'$D(LRO)
 W !?5,"For all diagnoses type 'ALL'" F B=1:1 D ASK Q:X[U!(X="")!(LRN="ALL")
 Q:B<2&(LRN="")  S:LRN=""&(B=2) LRN=$O(LRN(0)) W ! D B^LRU Q:Y<0  S LRSDT=LRSDT-.01,LRLDT=LRLDT+.99
 S ZTRTN="QUE^LRAUSM" D BEG^LRUTL Q:POP!($D(ZTSK))
QUE U IO K ^TMP($J) D L^LRU,S^LRU,XR^LRU S ^TMP($J,0)=S(2)_U_LRN_U_"AUTOPSY"_U_S(7)
 F X=0:0 S LRSDT=$O(^LR(LRXR,LRSDT)) Q:'LRSDT!(LRSDT>LRLDT)  D LRDFN
 D ^LRAPSM1,END^LRUTL Q
Y I $E(X,1,Y(1))=Y(2) S I=1 Q
Y1 S I=1 F I(1)=1:1:Y(1) S I(2)=$E(Y(2),I(1)) I I(2)'="*",I(2)'=$E(X,I(1)) S I=0 Q
 Q
LRDFN S:'$D(LR("S")) LR("S")=$P(^LRO(69.2,LRAA,0),U,8) F LRDFN=0:0 S LRDFN=$O(^LR(LRXR,LRSDT,LRDFN)) Q:'LRDFN  I $P($P($G(^LR(LRDFN,"AU")),U,6)," ")=LRABV S LR(2)=LR(2)+1,LR(4)=^("AU") D T
 Q
T S LRAC=$P(LR(4),"^",6),LRAN=+$P(LRAC," ",3),LRYR=$E(LR(4),1,3)
 Q:'$D(^LR(LRDFN,"AY",0))  S T=0 F LR(20)=0:1 S T=$O(^LR(LRDFN,"AY",T)) Q:'T  S LR(7)=+^(T,0) D TG
 S LR=LR+LR(20) Q  ;# organ/tissues
TG Q:'$D(^LAB(61,LR(7),0))  S LR(11)=^(0),LR(5)=$P(LR(11),"^"),LR(11)=$P(LR(11),"^",2) I S(2)'="ALL",$E(LR(11),1,S(1))'=S(2) Q:S(2)'["*"  S Y(1)=S(1),X=LR(11),Y(2)=S(2) D Y1 Q:'I
 S LR(1)=LR(1)+1 D M Q  ;Tot of organ/tissues searched for
M F M=0:0 S M=$O(^LR(LRDFN,"AY",T,V,M)) Q:'M  S X=^(M,0),LR(8)=+X,LRM=$P(X,"^",2) D @($S(LRSN'=61.2:"MX",1:"E"))
 Q
E F E=0:0 S E=$O(^LR(LRDFN,"AY",T,V,M,1,E)) Q:'E  S LR(8)=+^(E,0) D MX
 Q
MX Q:'$D(^LAB(LRSN,LR(8),0))  S W=^(0) I $D(LRO),LRO]"",LRO'=LRM Q
 I LRN="ALL" S:'$D(^TMP($J,LRYR,LRAN,LR(7),0)) ^(0)=LR(5) S W(2)=$P(W,"^",2) S:W(2)="" W(2)="?????" S ^(W(2))=$P(W,"^") G PRT
 S X=$P(W,"^",2),Y=-1 F Z=1:1 S Y=$O(LRN(Y)) Q:Y=""  S Y(1)=LRM(Y),Y(2)=LRN(Y) D Y I I S:'$D(^TMP($J,LRYR,LRAN,LR(7),0)) ^(0)=LR(5) S ^(Y)=$P(W,"^")
 Q:'$D(^TMP($J,LRYR,LRAN))
PRT S LRPF=^DIC($P(^LR(LRDFN,0),"^",2),0,"GL"),LRFLN=+$P(@(LRPF_"0)"),"^",2),DFN=$P(^LR(LRDFN,0),"^",3),LRDPF=$P(^(0),U,2) Q:'$D(@(LRPF_DFN_",0)"))
 S LRPPT=@(LRPF_DFN_",0)"),LRP=$P(LRPPT,"^"),SSN=$P(LRPPT,"^",9)
 S SEX=$P(LRPPT,"^",2),DOB=$P(LRPPT,"^",3),LRYR=$E($P(LR(4),"^"),1,3)
 D SSN^LRU
 S LRAC=$P(LR(4),"^",6),LRAN=+$P(LRAC," ",3),X1=$P(LR(4),"^"),X2=DOB D ^%DTC S AGE=X\365.25
 S:AGE<1 AGE="<1"
 S ^TMP($J,LRYR,LRAN)=LRAC_"^"_AGE_"^"_SEX_"^"_LRP_"^"_SSN(1)_"^"_+$E($P(LR(4),"^"),4,5)_"/"_+$E($P(LR(4),"^"),6,7)_"^"_LRFLN,^TMP($J,"B",LRP,LRYR,LRAN)=""
 Q
CK ;from LRAPC, LRAPSM
 I X'?1PUN.PUN!($L(X)>7) S A("B")=1 G SHW
 S I=0 F I(1)=1:1:$L(X) I "0123456789*ABCDEFXY"'[$E(X,I(1)) S A("B")=1 Q
SHW Q:'$D(A("B"))  W $C(7),!!,"Enter up to 7 characters.",!,"Entry can only contain digits, letters ABCDEFXY or '*' (for wild cards).",!,"One character entered -> most general  All 7 characters -> most specific",! Q
ASK K A("B") W !,"Choice #",$J(B,2),": Select 1 or more characters of the code: " R X:DTIME Q:X=""!(X[U)  I X["ALL" S LRN="ALL" Q
 D CK G:$D(A("B")) ASK S LRN(X)=X,LRM(X)=$L(X) Q
