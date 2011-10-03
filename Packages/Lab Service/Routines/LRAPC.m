LRAPC ;AVAMC/REG - ANAT TOPOGRAPHY COUNTS ;8/14/95  08:36 ;
 ;;5.2;LAB SERVICE;**72**;Sep 27, 1994
 S LRDICS="SPCYEM" D ^LRAP G:'$D(Y) END W !!,LRO(68)," (",LRABV,") TOPOGRAPHY COUNTS",!!
 D XR^LRU S S(1)=LRO(68)
 K T S T="" W !!,"TOPOGRAPHY (Organ/Tissue)" F B=1:1 D ASK Q:X[U!(X="")
 G:B<2&(T="") END S:T=""&(B=2) T=$O(T(-1)) W ! D B^LRU G:Y<0 END S LRSDT=LRSDT-.01,LRLDT=LRLDT+.99
 S ZTRTN="QUE^LRAPC" D BEG^LRUTL G:POP!($D(ZTSK)) END
QUE U IO S (O,C,C(1),C(2))=0 K ^TMP($J) D L^LRU,S^LRU
 F A=0:0 S LRSDT=$O(^LR(LRXR,LRSDT)) Q:'LRSDT!(LRSDT>LRLDT)  D L
 D H,TOT K ^TMP($J) D END^LRUTL,END Q
TOT S LR("F")=1,T=-1 F X=1:1 S T=$O(O(T)) Q:T=""!(LR("Q"))  D:$Y>(IOSL-8) H Q:LR("Q")  W !?2,"T-",T,$E(".....",1,5-$L(T)),?14,$J(O(T),5),?22 W:C(2) $J(O(T)/C(2)*100,5,2),"%"
 S X=0 F A=0:1 S X=$O(^TMP($J,X)) Q:'X!(LR("Q"))
 Q:LR("Q")  W !!,"# Patients: ",A,!,"# accessions: ",C(1),!,"# organ/tissues: ",C(2),!,"% = % of organ/tissues" Q
L F LRDFN=0:0 S LRDFN=$O(^LR(LRXR,LRSDT,LRDFN)) Q:'LRDFN  D I
 Q
I F I=0:0 S I=$O(^LR(LRXR,LRSDT,LRDFN,I)) Q:'I  D T
 Q
T S X=$G(^LR(LRDFN,LRSS,I,0)) Q:$P($P(X,U,6)," ")'=LRABV  S ^TMP($J,LRDFN)="",C(1)=C(1)+1 ;set pt in utility global C(1)= acc # count
 S T=0 F B=0:1 S T=$O(^LR(LRDFN,LRSS,I,2,T)) Q:'T  S W=+^(T,0) D TG
 S C(2)=C(2)+B Q  ;Number of organ/tissues
TG Q:'$D(^LAB(61,W,0))  S W(1)=^(0),X=$P(W(1),"^",2),Y=-1 F C=0:1 S Y=$O(T(Y)) Q:Y=""  I $E(X,1,L(Y))=T(Y) S:'$D(O(Y)) O(Y)=0 S O(Y)=O(Y)+1
 Q
ASK K A("B") W !,"Choice #",$J(B,2),": Select 1 or more characters of the code: " R X:DTIME Q:X=""!(X[U)
 D CK^LRAUSM G:$D(A("B")) ASK S T(X)=X,L(X)=$L(X) Q
H I $D(LR("F")),IOST?1"C".E D M^LRU Q:LR("Q")
 D F^LRU W !,LRO(68)," (",LRABV,") TOPOGRAPHY COUNTS"
 W !,"Topography",?14,"Count",?22,"From:",LRSTR,"  To:",LRLST,!,LR("%") Q
 ;
END D V^LRU Q
