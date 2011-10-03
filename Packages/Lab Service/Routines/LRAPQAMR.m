LRAPQAMR ;AVAMC/REG/CYM - MALIGNANCY REVIEW ;10/3/96  08:56
 ;;5.2;LAB SERVICE;**72,134,242,252**;Sep 27, 1994
 D A^LRAPD G:'$D(Y) END
 W !!?31,"Malignancy review",!,"This report may take a while and should be queued to print at non-peak hours.",!,"OK to continue " S %=2 D YN^LRU G:%'=1 END
 I LRSS="CY" W !!,"Include suspicious for malignancy cases " S %=1 D YN^LRU G:%<1 END S:%=1 LRB=1
ASK W !!?18,"1. Bone and soft tissue",!?18,"2. Female genital tract",!?18,"3. Other topography" R !,"Select 1,2, or 3: ",X:DTIME G:X["^"!(X="") END I +X'=X!(X<1)!(X>3) W !!,$C(7),"Enter a number from 1 to 3" G ASK
 I X'=3 S S(1)=1,S(2)=$S(X=1:1,1:8) G CUM
TP K A("B") W !!,"TOPOGRAPHY (Organ/Tissue)",!?5,"Select 1 or more characters of the code",!?5 R "For all sites type 'ALL' : ",X:DTIME Q:X=""!(X[U)  I X["ALL" S S(2)="ALL"
 E  D CK^LRAUSM G:$D(A("B")) TP S S(2)=X,S(1)=$L(X)
CUM D ASK^LRAPQAFS G:%<1 END S:'$D(LRC) LRC=0
 W ! D B^LRU G:Y<0 END S LRSDT=LRSDT-.01,LRLDT=LRLDT+.99
 K Y S ZTRTN="QUE^LRAPQAMR" D BEG^LRUTL G:POP!($D(ZTSK)) END
QUE U IO K ^TMP($J),^TMP("LRAP",$J) S LRN="MALIGNANT",(LRS(99),LR("W"),LRLR("DIWF"),LRQ(3),LRS(5),LRQ(9))=1,LR("DIWF")="W",(LR,LR("A"),LR(1),LR(2),LR(3),LRQ(2))=0,LRO=""
 D L^LRU,S^LRU,XR^LRU,L1^LRU,EN^LRUA S S(7)="MORPHOLOGY",LRSN=61.1,V=2
 F X=8,9 F Y=1,2,3,6,9 S Z=X_"***"_Y,LRM(Z)=5,LRN(Z)=Z
 I $D(LRB) S LRM(69760)=5,LRN(69760)=69760
 S ^TMP($J,0)=S(2)_U_"MR"_U_LRAA(1)_U_S(7)
 F X=0:0 S LRSDT=$O(^LR(LRXR,LRSDT)) Q:'LRSDT!(LRSDT>LRLDT)  D LRDFN^LRAPSM
 D ^LRAPSM1 G:LR("Q") OUT D EN2^LRUA,SET^LRUA S LRQ=0,LRA=1
 I LRQA F A=0:0 S A=$O(^TMP($J,A)) Q:'A  S X=A,%DT="" D ^%DT S LRY=$E(X,1,3) F B=0:0 S B=$O(^TMP($J,A,B)) Q:'B  S ^TMP("LRAP",$J,LRY,B)=""
 F LRY=0:0 S LRY=$O(^TMP("LRAP",$J,LRY)) Q:'LRY!(LR("Q"))  F LRAN=0:0 S LRAN=$O(^TMP("LRAP",$J,LRY,LRAN)) Q:'LRAN!(LR("Q"))  S LRDFN=$O(^LR(LRXREF,LRY,LRABV,LRAN,0)) Q:'LRDFN  S LRI=$O(^(LRDFN,0)) Q:'LRI   D EN^LRSPRPT Q:LR("Q")  D:LRC L
OUT K ^TMP("LRAP",$J) D END^LRUTL,END Q
L ;also used by LRAPQAR,LRAPQAFS
 S X=^LR(LRDFN,0),Y=$P(X,"^",3),(LRDPF,X)=^DIC($P(X,"^",2),0,"GL"),LRPPT=@(X_Y_",0)")
 S LRQ=0,LRP=$P(LRPPT,"^"),SEX=$P(LRPPT,"^",2),Y=$P(LRPPT,"^",3),SSN=$P(LRPPT,"^",9) D D^LRU,SSN^LRU S DOB=$S(Y[1700:"",1:Y)
 G:'$D(^LR(LRDFN,"SP"))&('$D(^LR(LRDFN,"CY")))&('$D(^LR(LRDFN,"EM"))) AU
 D ^LRAPT1 Q:LR("Q")
AU I $D(^LR(LRDFN,"AU")),+^("AU") D ^LRAPT2
 Q
 ;
END D V^LRU Q
