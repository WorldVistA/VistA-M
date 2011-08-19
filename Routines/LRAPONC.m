LRAPONC ;AVAMC/REG - FIND MALIGNANCIES FOR ONCOLOGY ;5/21/91  11:43
 ;;5.2;LAB SERVICE;;Sep 27, 1994
 D END W !!?31,"Find Malignancies for Oncology" D A G:'$D(Y) END D XR^LRU
 I LRSS="CY" W !!,"Include suspicious for malignancy cases " S %=1 D YN^LRU G:%<1 END S:%=1 LRB=1
 S S(2)="ALL",S(1)=3
 W ! D B^LRU G:Y<0 END S LRSDT=LRSDT-.01,LRLDT=LRLDT+.99
 F X=8,9 F Y=1,2,3,6,9 S Z=X_"***"_Y,LRM(Z)=5,LRN(Z)=Z
 I $D(LRB) S LRM(69760)=5,LRN(69760)=69760
 D WAIT^LRU
 F LR=0:0 S LRSDT=$O(^LR(LRXR,LRSDT)) Q:'LRSDT!(LRSDT>LRLDT)  D LRDFN
 Q
Y I $E(X,1,Y(1))=Y(2) S I=1 Q
Y1 S I=1 F I(1)=1:1:Y(1) S I(2)=$E(Y(2),I(1)) I I(2)'="*",I(2)'=$E(X,I(1)) S I=0 Q
 Q
LRDFN F LRDFN=0:0 S LRDFN=$O(^LR(LRXR,LRSDT,LRDFN)) Q:'LRDFN  D @$S(LRSS'="AU":"LRI",1:"AU")
 Q
LRI F LRI=0:0 S LRI=$O(^LR(LRXR,LRSDT,LRDFN,LRI)) Q:'LRI  D T
 Q
T F T=0:0 S T=$O(^LR(LRDFN,LRSS,LRI,2,T)) Q:'T  S LRT=+^(T,0) D M
 Q
M F M=0:0 S M=$O(^LR(LRDFN,LRSS,LRI,2,T,2,M)) Q:'M  S X=^(M,0),LRD=+X,LRM=$P(X,"^",2) D MX
 Q
MX Q:'$D(^LAB(61.1,LRD,0))  S W=^(0),X=$P(W,"^",2),Y=0 F Z=1:1 S Y=$O(LRN(Y)) Q:Y=""  S Y(1)=LRM(Y),Y(2)=LRN(Y) D Y I I S ^TMP($J,LRDFN,LRI)=""
 Q
AU S LRI=9999999 F T=0:0 S T=$O(^LR(LRDFN,"AY",T)) Q:'T  S LRT=+^(T,0) D AUM
 Q
AUM F M=0:0 S M=$O(^LR(LRDFN,"AY",T,2,M)) Q:'M  S X=^(M,0),LRD=+X,LRM=$P(X,"^",2) D MX
 Q
L S X=^LR(LRDFN,0),Y=$P(X,"^",3),(LRDPF,X)=^DIC($P(X,"^",2),0,"GL"),LRPPT=@(X_Y_",0)")
 S LRQ=0,LRP=$P(LRPPT,"^"),SEX=$P(LRPPT,"^",2),Y=$P(LRPPT,"^",3),SSN=$P(LRPPT,"^",9) D D^LRU,SSN^LRU S DOB=$S(Y[1700:"",1:Y)
 Q
A ;
 W ! S DIC=68,DIC(0)="AEOQMZ",DIC("A")="Select ANATOMIC PATHOLOGY section: ",DIC("S")="I ""AUSPCYEM""[$P(^(0),U,2)&($P(^(0),U,2)]"""")" D ^DIC K DIC G:Y<1 END
 D ^LRUTL G:Y=-1 END Q
 ;
END D V^LRU Q
