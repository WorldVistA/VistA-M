LRAPQAC ;AVAMC/REG/CYM - AP QA ;7/25/96  09:11 ;
 ;;5.2;LAB SERVICE;**72**;Sep 27, 1994
 D END S X="T",%DT="" D ^%DT S LRT=Y D D^LRU S LRTOD=Y S IOP="HOME" D ^%ZIS
 W @IOF,!?20,"Quality assurance cum path data summaries",!?21,"for accessions from one date to another",!
 D A G:'$D(Y) END W !,"Do you want to specify a site/specimen (Topography) " S %=2 D YN^LRU G:%<1 END D:%=1 TP
 D B^LRU G:Y<0 END S ZTRTN="QUE^LRAPQAC" D BEG^LRUTL G:POP!($D(ZTSK)) END
QUE U IO K ^TMP("LRAP",$J),^TMP($J) S (LR("W"),LRS(5),LRQ(3),LRQ(9))=1,LRSDT=LRSDT-.1,LRLDT=LRLDT+.9 D L^LRU,S^LRU,EN^LRUA
 F LRA=LRSDT:0 S LRA=$O(^LR(LRXR,LRA)) Q:'LRA!(LRA>LRLDT)  F LRDFN=0:0 S LRDFN=$O(^LR(LRXR,LRA,LRDFN)) Q:'LRDFN  D @($S('$D(S(2)):"S",1:"T"))
 F LRDFN=0:0 S LRDFN=$O(^TMP("LRAP",$J,LRDFN)) Q:'LRDFN  S X=^LR(LRDFN,0),Y=$P(X,"^",3),(LRDPF,X)=^DIC($P(X,"^",2),0,"GL"),X=@(X_Y_",0)"),^TMP("LRAP",$J,"B",$P(X,"^"),LRDFN)=X
 S LRA=0 F LRB=0:0 S LRA=$O(^TMP("LRAP",$J,"B",LRA)) Q:LRA=""  F LRDFN=0:0 S LRDFN=$O(^TMP("LRAP",$J,"B",LRA,LRDFN)) Q:'LRDFN!(LR("Q"))  S LRPPT=^(LRDFN) D L
 K ^TMP("LRAP",$J),LRAU W @IOF D END,END^LRUTL Q
L S LRQ=0,LRP=$P(LRPPT,"^"),SEX=$P(LRPPT,"^",2),Y=$P(LRPPT,"^",3),SSN=$P(LRPPT,"^",9) D D^LRU,SSN^LRU S DOB=$S(Y[1700:"",1:Y)
 G:'$D(^LR(LRDFN,"SP"))&('$D(^LR(LRDFN,"CY")))&('$D(^LR(LRDFN,"EM"))) AU
 D ^LRAPT1 Q:LR("Q")
AU I $P($P($G(^LR(LRDFN,"AU")),U,6)," ")=LRABV D ^LRAPT2
 Q
O S ^TMP("LRAP",$J,LRDFN)="" Q
S S LRI=0 F  S LRI=$O(^LR(LRXR,LRA,LRDFN,LRI)) Q:'LRI  I $P($P($G(^LR(LRDFN,LRSS,LRI,0)),U,6)," ")=LRABV D O
 Q
T S LRI=0 F  S LRI=$O(^LR(LRXR,LRA,LRDFN,LRI)) Q:'LRI  I $P($P($G(^LR(LRDFN,LRSS,LRI,0)),U,6)," ")=LRABV S T=0 F  S T=$O(^LR(LRDFN,LRSS,LRI,2,T)) Q:'T  S T(1)=+^(T,0)  Q:'$D(^LAB(61,T(1),0))  S T(2)=$P(^(0),"^",2) D F
 Q
F I $E(T(2),1,S(1))'=S(2) Q:S(2)'["*"  S Y(1)=S(1),X=T(2),Y(2)=S(2) D Y1 Q:'I
 D O Q
TP K A("B") W !!,"TOPOGRAPHY (Organ/Tissue)",!?5,"Select 1 or more characters of the code",!?5 R "For all sites type 'ALL' : ",X:DTIME Q:X=""!(X[U)  I X["ALL" K S(2)
 E  D CK^LRAUSM G:$D(A("B")) TP S S(2)=X,S(1)=$L(X)
 Q
Y1 S I=1 F I(1)=1:1:Y(1) S I(2)=$E(Y(2),I(1)) I I(2)'="*",I(2)'=$E(X,I(1)) S I=0 Q
 Q
A D ^LRAP Q:'$D(Y)  D XR^LRU Q
 ;
END D V^LRU Q
