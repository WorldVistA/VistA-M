LRBLAA ;AVAMC/REG - XM:TX BY TREATING SPECIALTY REPORT ;9/11/95  14:02 ;
 ;;5.2;LAB SERVICE;**72,247**;Sep 27, 1994
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 D END,CK^LRBLPUS G:Y=-1 END
 W !!?5,"Crossmatch:Transfusion Report by Treating Specialty and Physician",!
 D B^LRU G:Y<0 END S LRLDT=LRLDT+.99,LRSDT=LRSDT-.0001
 W !!,"Print only summary of crossmatches and transfusions " S %=1 D YN^LRU G:%<1 END S LRF=$S(%=1:0,1:1)
 S ZTRTN="QUE^LRBLAA" W ! D BEG^LRUTL G:POP!($D(ZTSK)) END
QUE U IO S LR("M")=$P($G(^LAB(69.9,1,8.1,+DUZ(2),0)),U,6),LRQ(2)=$S(LRF:1,1:0) K ^TMP($J) D L^LRU,S^LRU,H S (LRL,LRM)=0 I LRF D B S LR("F")=1
 D C Q:LR("Q")  I LRF W !!,"ALL TREATING SPECIALTIES",?32,"Total Xm'd:",?43,$J(LRL,4),?52,"Tx'd:",?55,$J(LRM,4),?65,"C/T: " W $S(LRM:$J(LRL/LRM,5,3),1:"NA")
 S LRQ(2)=0 D:LRF H Q:LR("Q")  D A,^LRBLAA1
 W ! W:IOST'?1"C".E @IOF D END^LRUTL,END Q
C F A=LRSDT:0 S A=$O(^LRD(65,"AN",A)) Q:'A!(A>LRLDT)  F I=0:0 S I=$O(^LRD(65,"AN",A,I)) Q:'I  F P=0:0 S P=$O(^LRD(65,"AN",A,I,P)) Q:'P  F B=0:0 S B=$O(^LRD(65,"AN",A,I,P,B)) Q:'B  D SET
 S A=0 F A(1)=1:1 S A=$O(^TMP($J,A)) Q:A=""!(LR("Q"))  S (LRJ,LRT)=0 D:A(1)>1&(LRF) H Q:LR("Q")  W:LRF !?20,"TREATING SPECIALTY: ",A D M
 Q
M S B=0 F B(1)=0:0 S B=$O(^TMP($J,A,B)) Q:B=""!(LR("Q"))  D:$Y>(IOSL-6)&(LRF) H1 Q:LR("Q")  S (LRK,LRD)=0 W:LRF !!?29,"PHYSICIAN: ",B D P
 Q:LR("Q")  S ^TMP($J,A)=LRJ_"^"_LRT I LRF D:$Y>(IOSL-6) H Q:LR("Q")  W !!!,A,?32,"Units Xm'd:",?43,$J(LRJ,4),?52,"Tx'd:",?55,$J(LRT,4),?65,"C/T: " W $S(LRT:$J(LRJ/LRT,5,3),1:"NA")
 Q
P F LRDFN=0:0 S LRDFN=$O(^TMP($J,A,B,LRDFN)) Q:'LRDFN!(LR("Q"))  D:$Y>(IOSL-6)&(LRF) H2 Q:LR("Q")  D W
 Q:LR("Q")  S ^TMP($J,A,B)=LRK_"^"_LRD I LRF W !!,B,?32,"Units Xm'd:",?43,$J(LRK,4),?52,"Tx'd:",?55,$J(LRD,4),?65,"C/T: " W $S(LRD:$J(LRK/LRD,5,3),1:"NA")
 Q
W I LRF S X=^LR(LRDFN,0),Y=$P(X,"^",3),(LRDPF,X)=$P(X,"^",2),X=^DIC(X,0,"GL"),X=@(X_Y_",0)"),LRP=$P(X,"^"),SSN=$P(X,"^",9) D SSN^LRU W !,LRP,?32,SSN
 F F=0:0 S F=$O(^TMP($J,A,B,LRDFN,F)) Q:'F!(LR("Q"))  S Y=F D DT^LRU S LRY=Y D U
 Q
U F G=0:0 S G=$O(^TMP($J,A,B,LRDFN,F,G)) Q:'G!(LR("Q"))  S LRE=^(G) D:$Y>(IOSL-6)&(LRF) H3 Q:LR("Q")  S X=$P(LRE,"^"),Y=$P(LRE,"^",2) D V
 Q
V W:LRF !,LRY,?19,$P(LRE,"^",4),?20,$P(LRE,"^",3),?35,$P(LRE,"^",2),?38,X I LR("M"),LRF W ?60,$E($P($G(^DIC(4,+$P($G(^LRD(65,G,0)),U,16),0)),U),1,19)
 I Y="C"!(Y="IG") S LRJ=LRJ+1,LRK=LRK+1,LRL=LRL+1 I X="TRANSFUSED" S LRT=LRT+1,LRD=LRD+1,LRM=LRM+1
 Q
SET S X=^LRD(65,I,0),V=$S($D(^(8)):$P(^(8),"^",3),1:0),C=$P(X,"^",4),Z=$P(X,"^"),C=+$P(^LAB(66,C,0),"^",26),X=^LRD(65,I,2,P,1,B,0),Y=$P(X,"^",4),T=$S($P(X,"^",2)]"":$P(X,"^",2),1:"UNKNOWN"),M=$S($P(X,"^",3)]"":$P(X,"^",3),1:"UNKNOWN")
 S ^TMP($J,T,M,P,+X,I)=$P(X,"^",10)_"^"_$S(Y]"":Y,1:"?")_"^"_Z_"^"_$S(V="A":"*",1:"")
 Q
 ;
H I $D(LR("F")),IOST?1"C".E D M^LRU Q:LR("Q")
 D F^LRU W !,LRO(68)," CROSSMATCH:TRANSFUSIONS (from: ",LRSTR," to ",LRLST,")"
 W:LRQ(2) !,"PATIENT",?19,"* = AUTOLOGOUS",?35,"SSN",!,"BLOOD SAMPLE DATE",?20,"UNIT ID",?35,"XM"
 W !,LR("%") Q
H1 D H Q:LR("Q")  W !?20,"TREATING SPECIALTY: ",A Q
H2 D H1 Q:LR("Q")  W !?29,"PHYSICIAN: ",B Q
H3 D H2 Q:LR("Q")  W !,LRP,?32,SSN,?45,"(Cont'd from pg ",LRQ-1,")" Q
A W !,"This report includes the following administrative categories:",!,"WHOLE BLOOD, RBC, FROZEN RBC, DEGLYC RBC, LEUCODEPLETED RBC, and WASHED RBC." Q
 ;
B D A W !!,"The following abbreviations are used to indicate crossmatch results:",!,"C=COMPATIBLE",!,"CD=COMPATIBLE, DON'T TRANSFUSE",!,"CF=COMPATIBLE, FURTHER STUDY NEEDED",!,"I=INCOMPATIBLE, UNSAFE TO TRANSFUSE"
 W !,"IG=INCOMPATIBLE, GIVE WITH BLOOD BANK DIRECTOR APPROVAL",!,"CD, CF, and I are not included in crossmatch-transfusion calculations.",!,LR("%") Q
END D V^LRU Q
 ;^TMP($J,Rx Specialty,MD,Patient,Date,Unit)=Tx
