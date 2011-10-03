LRAPSEM ;AVAMC/REG - MULTIAXIAL SNOMED SEARCH ;8/15/95  09:53 ;
 ;;5.2;LAB SERVICE;**72**;Sep 27, 1994
 S IOP="HOME" D ^%ZIS W @IOF,!?10,LRO(68)," multiaxial SNOMED search"
 I LRSS="AU" W $C(7),!!?26,"Not yet available" Q
 S (LR,LRD,LRD(0),LRD(1),LR(1),LR(2),LR(3))=0
TP K A("B") W !!,"TOPOGRAPHY (Organ/Tissue)",!?5,"Select 1 or more characters of the code",!?5 R "For all sites type 'ALL' : ",X:DTIME Q:X=""!(X["^")  I X["ALL" S S(2)="ALL"
 E  D CK^LRAUSM G:$D(A("B")) TP S S(2)=X,S(1)=$L(X)
 K LRN,LRM S LRO=""
 F LRX="2^MORPHOLOGY","4^PROCEDURE","1^DISEASE","3^FUNCTION" Q:X["^"  W !!,$P(LRX,U,2) D:+LRX=4 POS^LRAPSM W !?5,"For all choices type 'ALL'" F B=1:1 D ASK Q:X["^"!(X="")  Q:LRN(+LRX,X)="ALL"!("^")
 Q:'$D(LRN)  S:'$D(LRO) LRO="" W ! D B^LRU Q:Y<0  S LRSDT=LRSDT-.01,LRLDT=LRLDT+.99
 W !!,"List by accession number with specimens and microscopic dx " S %=2 D YN^LRU Q:%<1  I %=1 S (LRD(0),LRD(1))=1
 D S
C R !!,"Enter SEARCH COMMENT: ",X:DTIME Q:X["^"  I X["?" D R G C
 I X]"",$L(X)<2!($L(X)>68)!(X'?.ANP) D R G C
 W ! S LRH=X,ZTRTN="QUE^LRAPSEM" D BEG^LRUTL Q:POP!($D(ZTSK))
QUE U IO S (LR(2),LRB)=0 K ^TMP("LR",$J),^TMP($J) D EN^LRUA,L^LRU,XR^LRU F X=1:1:4 S LRSN(X)=$S(X=1:"61.4^D",X=2:"61.1^M",X=3:"61.3^F",X=4:"61.5^P",1:"")
 F LRX=0:0 S LRSDT=$O(^LR(LRXR,LRSDT)) Q:'LRSDT!(LRSDT>LRLDT)  D LRDFN
END D ^LRAPSEM1,END^LRUTL Q
Y I $E(X,1,Y(1))=Y(2) S LRF=1 Q
Y1 S LRF=1 F I(1)=1:1:Y(1) S I(2)=$E(Y(2),I(1)) I I(2)'="*",I(2)'=$E(X,I(1)) S LRF=0 Q
 Q
LRDFN F LRDFN=0:0 S LRDFN=$O(^LR(LRXR,LRSDT,LRDFN)) Q:'LRDFN  S LR(2)=LR(2)+1 D I
 Q
I F LRI=0:0 S LRI=$O(^LR(LRXR,LRSDT,LRDFN,LRI)) Q:'LRI  D T
 Q
T Q:$P($P($G(^LR(LRDFN,LRSS,LRI,0)),U,6)," ")'=LRABV  S LR(4)=^(0),LR(12)=$P(LR(4),"^",10),LRY=$E(LR(12),1,3),LRAC=$P(LR(4),"^",6),LRAN=+$P(LRAC," ",3),LR(3)=LR(3)+1
 S T=0 F LR(9)=0:1 S T=$O(^LR(LRDFN,LRSS,LRI,2,T)) Q:'T  S LRT=+^(T,0) D TG
 S LR=LR+LR(9) Q  ;Number of organ/tissues searched
TG Q:'$D(^LAB(61,LRT,0))  S X=^(0),LR(5)=$P(X,"^"),X=$P(X,"^",2) I S(2)'="ALL",$E(X,1,S(1))'=S(2) Q:S(2)'["*"  S Y(1)=S(1),Y(2)=S(2) D Y1 Q:'LRF
 S LRF=0,LR(1)=LR(1)+1 ;Total organ/tissue found
 F V=2,4,1,3 I $D(LRN(V)) D M Q:'LRF
 D:LRF PRT Q
M I $D(LRN(V,"Z")) S X=$O(^LR(LRDFN,LRSS,LRI,2,T,V,0)) S LRF=$S(X:1,1:0) D:LRF&(V=4)&(LRO]"") PR Q:V'=2  Q:'LRF  D:$D(LRN(2,"Z","Z")) O Q
 S LRF=0 F M=0:0 S M=$O(^LR(LRDFN,LRSS,LRI,2,T,V,M)) Q:'M  S X=^(M,0),LR(8)=+X,LRM=$P(X,"^",2) D N Q:LRF
 Q
N Q:'$D(^LAB(+LRSN(V),LR(8),0))  S W=$P(^(0),"^",2) I LRO]"",V=4,LRO'=LRM Q
 S A=-1 F F=0:0 S A=$O(LRN(V,A)) Q:A=""!(A="Z")  S X=W,Y(2)=A,Y(1)=LRN(V,A) D Y Q:LRF&(V'=2)  D:LRF E Q:LRF
 Q
E Q:$O(LRN(2,A,-1))=""  I $D(LRN(2,A,"Z")) S X=M D O Q
 S LRF=0 F E=0:0 S E=$O(^LR(LRDFN,LRSS,LRI,2,T,V,M,1,E)) Q:'E!(LRF)  S LR(8)=+^(E,0) I $D(^LAB(61.2,LR(8),0)) S W=$P(^(0),"^",2) S B=-1 F G=0:0 S B=$O(LRN(V,A,B)) Q:B=""!(B="Z")  S X=W,Y(2)=B,Y(1)=LRN(V,A,B) D Y Q:LRF
 Q
O S LRF=0 F Y=0:0 S Y=$O(^LR(LRDFN,LRSS,LRI,2,T,2,X,1,Y)) Q:'Y  I Y S LRF=1 Q
 Q
PRT S X=^LR(LRDFN,0),(LRDPF,LRA)=$P(X,"^",2),Y=$P(X,"^",3),X=^DIC(LRA,0,"GL") Q:'$D(@(X_Y_",0)"))
 S X=@(X_Y_",0)"),LRP=$P(X,"^"),SSN=$P(X,"^",9),SEX=$P(X,"^",2),DOB=$P(X,"^",3),X1=$P(LR(4),"^"),X2=DOB D ^%DTC,SSN^LRU S AGE=X\365.25
 S ^TMP("LR",$J,LRY,LRAN)=LRAC_"^"_AGE_"^"_SEX_"^"_LRP_"^"_SSN_"^"_+$E(LR(12),4,5)_"/"_$E(LR(12),6,7)_"^"_LRA_"^"_LRDFN_"^"_LRI
 S ^TMP("LR",$J,"B",LRP,LRY,LRAN)="" Q
PR S LRF=0 F X=0:0 S X=$O(^LR(LRDFN,LRSS,LRI,2,T,4,X)) Q:'X  I $P(^(X,0),"^",2)=LRO S LRF=1 Q
 Q
ASK K A("B") W !,$P(LRX,"^",2),?12,"choice #",$J(B,2),": Select 1 or more characters of the code: " R X:DTIME Q:X=""!(X["^")  I X["ALL" S X="Z",LRN(+LRX,"Z")="ALL" D:+LRX=2 ET S:+LRX=2 X=LRE Q
 D CK^LRAUSM G:$D(A("B")) ASK S LRN(+LRX,X)=$L(X) D:+LRX=2 ET S:+LRX=2 X=LRE Q
ET S LRE=X
 W !?5,"ETIOLOGY  (for all choices type 'ALL')" F A=1:1 D AE Q:X["^"!(X="")  Q:LRN(2,LRE,X)="ALL"
 Q
AE K A("B") W !?15,"Choice #",$J(A,2),": Select 1 or more characters of the code: " R X:DTIME Q:X=""!(X["^")  I X["ALL" S X="Z",LRN(2,LRE,"Z")="ALL" Q
 D CK^LRAUSM G:$D(A("B")) AE S LRN(2,LRE,X)=$L(X) Q
R W !,"Enter 2-68 character free text comment to appear at top of each page of search." Q
S W !!,"List special studies " S %=2 D YN^LRU S:%=1 LRD=1
 S LRD(2)=0 Q:'LRD(0)  W !!,"Include SNOMED CODES on report " S %=2 D YN^LRU S:%=1 LRD(2)=1 Q
