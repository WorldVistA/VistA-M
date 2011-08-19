LRAPSM ;AVAMC/REG - SNOMED SEARCH ;8/14/95  09:49
 ;;5.2;LAB SERVICE;**72,253,355,362**;Sep 27, 1994;Build 11
 S IOP="HOME" D ^%ZIS W @IOF,!?20,LRO(68)," search by ",S(7)," code"
 S (LR,LR(1),LR(2),LR(3))=0
TP K A("B") W !!,"TOPOGRAPHY (Organ/Tissue)",!?5,"Select 1 or more characters of the code",!?5 R "For all sites type 'ALL' : ",X:DTIME Q:X=""!(X[U)  I X["ALL" S S(2)="ALL"
 E  D CK^LRAUSM G:$D(A("B")) TP S S(2)=X,S(1)=$L(X)
 K LRN,LRM S (LRO,LRN)="" W !!,S(7) I LRSN=61.5 D POS Q:'$D(LRO)
 W !?5,"For all choices type 'ALL'" F B=1:1 D ASK Q:X[U!(X="")!(LRN="ALL")
 Q:B<2&(LRN="")  S:LRN=""&(B=2) LRN=$O(LRN(0)) W ! D B^LRU Q:Y<0  S LRSDT=LRSDT-.01,LRLDT=LRLDT+.99
 S ZTRTN="QUE^LRAPSM" D BEG^LRUTL Q:POP!($D(ZTSK))
QUE U IO K ^TMP($J) D L^LRU,S^LRU,XR^LRU
 S ^TMP($J,0)=S(2)_U_LRN_U_LRO(68)_U_S(7)
 F X=0:0 S LRSDT=$O(^LR(LRXR,LRSDT)) Q:'LRSDT!(LRSDT>LRLDT)  D LRDFN
END D ^LRAPSM1,END^LRUTL,V^LRU Q
Y I $E(X,1,Y(1))=Y(2) S I=1 Q
Y1 S I=1 F I(1)=1:1:Y(1) S I(2)=$E(Y(2),I(1)) I I(2)'="*",I(2)'=$E(X,I(1)) S I=0 Q
 Q
LRDFN S LRDFN=0 F  S LRDFN=$O(^LR(LRXR,LRSDT,LRDFN)) Q:'LRDFN  S LR(2)=LR(2)+1 D I
 Q
I F LRI=0:0 S LRI=$O(^LR(LRXR,LRSDT,LRDFN,LRI)) Q:'LRI  D T
 Q
T Q:$P($P($G(^LR(LRDFN,LRSS,LRI,0)),U,6)," ")'=LRABV
 S LR(4)=^LR(LRDFN,LRSS,LRI,0),LR(12)=$P(LR(4),"^",10)
 S H(2)=$E(LR(12),1,3),LRAC=$P(LR(4),"^",6),LRAN=+$P(LRAC," ",3)
 S LR(3)=LR(3)+1
 S T=0 F LR(9)=0:1 S T=$O(^LR(LRDFN,LRSS,LRI,2,T)) Q:'T  S LR(7)=+^(T,0) D TG
 S LR=LR+LR(9) Q  ;Number of organ/tissues
TG Q:'$D(^LAB(61,LR(7),0))  S LR(11)=^(0),LR(5)=$P(LR(11),"^"),LR(11)=$P(LR(11),"^",2) I S(2)'="ALL",$E(LR(11),1,S(1))'=S(2) Q:S(2)'["*"  S Y(1)=S(1),X=LR(11),Y(2)=S(2) D Y1 Q:'I
 S LR(1)=LR(1)+1 D M Q  ;Total of the organ/tissue searched for
M F M=0:0 S M=$O(^LR(LRDFN,LRSS,LRI,2,T,V,M)) Q:'M  S X=^(M,0),LR(8)=+X,LRM=$P(X,"^",2) D @($S(LRSN'=61.2:"MX",1:"E"))
 Q
E F E=0:0 S E=$O(^LR(LRDFN,LRSS,LRI,2,T,V,M,1,E)) Q:'E  S LR(8)=+^(E,0) D MX
 Q
MX Q:'$D(^LAB(LRSN,LR(8),0))  S W=^(0) I $D(LRO),LRO]"",LRO'=LRM Q
 I LRN="ALL" S:'$D(^TMP($J,H(2),LRAN,LR(7),0)) ^(0)=LR(5) S ^($S($P(W,"^",2)'="":$P(W,"^",2),1:"99999999"))=$P(W,"^")_"^"_LRM G PRT
 S X=$P(W,"^",2),Y=0 F Z=1:1 S Y=$O(LRN(Y)) Q:Y=""  S Y(1)=LRM(Y),Y(2)=LRN(Y) D Y I I S:'$D(^TMP($J,H(2),LRAN,LR(7),0)) ^(0)=LR(5) S ^(X)=$P(W,"^")_"^"_LRM
 Q:'$D(^TMP($J,H(2),LRAN))
PRT S X=^LR(LRDFN,0),(LRDPF,LR(14))=$P(X,"^",2),LRPF=^DIC(LR(14),0,"GL"),DFN=$P(X,"^",3) Q:'$D(@(LRPF_DFN_",0)"))
 S X=@(LRPF_DFN_",0)"),LRP=$P(X,"^"),SSN=$P(X,"^",9),SEX=$P(X,"^",2),DOB=$P(X,"^",3),X1=$P(LR(4),"^"),X2=DOB D ^%DTC,SSN^LRU S AGE=X\365.25
 S:AGE>130 AGE="?"
 S ^TMP($J,H(2),LRAN)=LRAC_"^"_AGE_"^"_SEX_"^"_LRP_"^"_SSN(1)_"^"_+$E(LR(12),4,5)_"/"_$E(LR(12),6,7)_"^"_LR(14)
 S ^TMP($J,"B",LRP,H(2),LRAN)=""
 Q
ASK K A("B") W !,"Choice #",$J(B,2),": Select 1 or more characters of the code: " R X:DTIME Q:X=""!(X[U)  I X["ALL" S LRN="ALL" Q
 D CK^LRAUSM G:$D(A("B")) ASK S LRN(X)=X,LRM(X)=$L(X) Q
POS ;also from LRAPSEM
 W !,"Select only procedures with results " S %=2 D YN^LRU I %<1 K LRO Q
 I %=2 S LRO="" Q
C W !,"Enter 1 for positive results or 0 for negative results: " R X:DTIME Q:X=""!(X[U)  I X'=1,X'=0 W $C(7)," Enter '1' or '0'" G C
 S LRO=X Q
