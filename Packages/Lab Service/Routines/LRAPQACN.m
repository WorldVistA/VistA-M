LRAPQACN ;AVAMC/REG - CONSULTATION RPTS ;8/12/95  12:05
 ;;5.2;LAB SERVICE;**72,242,252**;Sep 27, 1994
 W !!,"Consultation search with report.",!,"This report may take a while and should be queued to print at non-peak hours.",!,"OK to continue " S %=2 D YN^LRU G:%'=1 END
 D ^LRAP G:'$D(Y) END S LRN="065" F B=1:1 D ASK Q:X[U!(X="")!(X["ALL")
 G:B<2&(X="") END S:X=""&(B=2) LRN=$O(LRQ(0)) W !
 D B^LRU G:Y<0 END S LRSDT=LRSDT-.01,LRLDT=LRLDT+.99
 S ZTRTN="QUE^LRAPQACN" D BEG^LRUTL G:POP!($D(ZTSK)) END
QUE U IO K ^TMP($J),^TMP("LRAP",$J) S S=LRSS,LR("DIWF")="W",LRO="",(LR,LR("A"),LR(1),LR(2),LR(3))=0 D L^LRU,S^LRU,XR^LRU,EN^LRUA
 S S(7)="PROCEDURE",LRSN=61.5,V=4,S(2)="ALL"
 S ^TMP($J,0)=S(2)_U_"FS"_U_LRO(68)_U_S(7)
 F X=0:0 S LRSDT=$O(^LR(LRXR,LRSDT)) Q:'LRSDT!(LRSDT>LRLDT)  D @($S(LRSS="AU":"LRDFN^LRAUSM",1:"LRDFN^LRAPSM"))
 D ^LRAPSM1,EN2^LRUA,SET^LRUA,S^LRU S (LRS(5),LR("W"),LRQ(3),LRQ(9),LRA)=1
 F A=0:0 S A=$O(^TMP($J,A)) Q:'A  S X=A,%DT="" D ^%DT S LRY=$E(X,1,3) F B=0:0 S B=$O(^TMP($J,A,B)) Q:'B  S ^TMP("LRAP",$J,LRY,B)=""
 I LRSS'="AU" D H S LRQ(3)=1,LR("F")=1
 F LRY=0:0 S LRY=$O(^TMP("LRAP",$J,LRY)) Q:'LRY!(LR("Q"))  F LRAN=0:0 S LRAN=$O(^TMP("LRAP",$J,LRY,LRAN)) Q:'LRAN!(LR("Q"))  S LRDFN=$O(^LR(LRXREF,LRY,LRABV,LRAN,0)) D @$S(LRSS'="AU":"B",1:"AU")
OUT K ^TMP("LRAP",$J) D END^LRUTL,END Q
B S LRI=$O(^LR(LRXREF,LRY,LRABV,LRAN,LRDFN,0)) D:$Y>(IOSL-6) H Q:LR("Q")  D P W !,LRP,?36,SSN D EN^LRAPPF1 Q:LR("Q")  W !,LR("%") Q
AU D P S SEX=$P(X,"^",2),Y=$P(X,"^",3),SSN=$P(X,"^",9) D D^LRU,SSN^LRU S DOB=$S(Y[1700:"",1:Y) D ^LRAPT2 Q
 ;
P S X=^LR(LRDFN,0),Y=$P(X,"^",3),(LRDPF,X)=$P(X,"^",2),X=^DIC(X,0,"GL"),X=@(X_Y_",0)"),LRP=$P(X,"^"),SSN=$P(X,"^",9) D SSN^LRU Q
H I $D(LR("F")),IOSL?1"C".E D M^LRU Q:LR("Q")
 D F^LRU W !?23,LRO(68)," CONSULTATIONS",!,LR("%") Q
END D V^LRU Q
ASK K A("B") W !,"Choice #",$J(B,2),": Select consultation code (must begin with 065): " R X:DTIME Q:X=""!(X[U)  I X["ALL" S LRN(1)="065",LRM(1)=3 Q
 D CK^LRAUSM G:$D(A("B")) ASK I $E(X,1,3)'="065" W $C(7),!,"First 3 characters must be '065'" G ASK
 S LRN(X)=X,LRM(X)=$L(X) Q
