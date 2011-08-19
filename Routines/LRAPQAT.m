LRAPQAT ;AVAMC/REG/CYM - TC CODE SEARCH ;7/31/97  09:38
 ;;5.2;LAB SERVICE;**72,85,173**;Sep 27, 1994
 D END,A^LRAPD G:'$D(Y) END D W G:%'=1 END
 W ! F B=1:1 D ASK Q:Z=""!(Z[U)
 G:B<2 END W ! D B^LRU G:Y<0 END S LRA=LRSDT-.01,LRLDT=LRLDT+.99
 W !!,"Also print cumulative path data summaries " S %=2 D YN^LRU G:%<1 END S:%=1 LRG=1
 S ZTRTN="QUE^LRAPQAT" D BEG^LRUTL G:POP!($D(ZTSK)) END
QUE U IO K ^TMP($J) S (LRZ,LRM("NONE"))=0,LRQ(9)=1,LRM("NONE",0)="" D L^LRU,S^LRU,XR^LRU,H S LR("F")=1
 F LRX=0:0 S LRA=$O(^LR(LRXR,LRA)) Q:'LRA!(LRA>LRLDT)  F LRDFN=0:0 S LRDFN=$O(^LR(LRXR,LRA,LRDFN)) Q:'LRDFN  F LRI=0:0 S LRI=$O(^LR(LRXR,LRA,LRDFN,LRI)) Q:'LRI  I $P($P($G(^LR(LRDFN,LRSS,LRI,0)),U,6)," ")=LRABV S X=^(0),Y=$P(X,U,14) D X
 S LRA=-1 F LRB=0:0 S LRA=$O(LRM(LRA)) Q:LRA=""!(LR("Q"))  D:$Y>(IOSL-6) H Q:LR("Q")  W !!,"TC Code: ",LRA," ",LRM(LRA,0) S LRP=0 D P
 D H2 Q:LR("Q")  W !,LR("%") I LRZ=0 W !!?15,"No Accesions in Time period" Q
 W !!?10,"TC Code",?20,"Count",?30,"% of Accessions" S LRA=-1 F LRB=0:0 S LRA=$O(LRM(LRA)) Q:LRA=""!(LR("Q"))  W !?12,LRA,?20,$J(LRM(LRA),5),?35,$J(LRM(LRA)*100/LRZ,5,2)
 W !?20,"-----",!,"Total",?20,$J(LRZ,5),! S LRA=-1 F LRB=0:0 S LRA=$O(LRM(LRA)) Q:LRA=""  W !,"TC Code: ",LRA,?12,LRM(LRA,0)
 D:$D(LRG) ^LRAPQAT1 D END,END^LRUTL Q
P F LRC=0:0 S LRP=$O(^TMP("LRAP",$J,LRP)) Q:LRP=""  F LRDFN=0:0 S LRDFN=$O(^TMP("LRAP",$J,LRP,LRDFN)) Q:'LRDFN  S LRX=^(LRDFN) D Y
 Q
Y Q:'$D(^TMP($J,LRA,LRDFN))  F LRD=0:0 S LRD=$O(^TMP($J,LRA,LRDFN,LRD)) Q:'LRD!(LR("Q"))  D D
 Q
D S LRE=0 F LRF=0:0 S LRE=$O(^TMP($J,LRA,LRDFN,LRD,LRE)) Q:LRE=""!(LR("Q"))  D:$Y>(IOSL-6) H1 Q:LR("Q")  W !,LRP,?32,$P(LRX,"^"),?46,$J(LRE,5),?62 S Y=LRD D D^LRU W Y
 Q
X S LRZ=LRZ+1,A=$P(X,"^",6) S:A="" A="?" I Y="" S LRM("NONE")=LRM("NONE")+1,^TMP($J,"NONE",LRDFN,+X,A)="" D B Q
 I $D(LRM(Y)) S ^TMP($J,Y,LRDFN,+X,A)="",LRM(Y)=LRM(Y)+1 D B
 Q
B S X=^LR(LRDFN,0),Y=$P(X,"^",3),(LRDPF,LR)=$P(X,"^",2),X=^DIC(LR,0,"GL"),X=@(X_Y_",0)"),SSN=$P(X,"^",9) D SSN^LRU S ^TMP("LRAP",$J,$P(X,"^"),LRDFN)=SSN_"^"_$S(LR=2:Y,1:"")_"^"_$P(X,"^",3)_"^"_$P(X,"^",2) Q
 ;
ASK W !,"Select a number from 0 to 9 (Choice# ",B,"): " R Z:DTIME Q:Z=""!(Z[U)  I Z'?1N W $C(7),!!?18,"Only numbers 0,1,2,3,4,5,6,7,8 or 9 allowed.",!?18,"A repeat selection replaces the original one.",! G ASK
A S L(1)="S",L=68,X=Z D ^LRUB
C W !,"ENTER IDENTIFYING COMMENT: ",X,"// " R X(1):DTIME I '$T!(X(1)[U) W $C(7),!,"You must enter an identifying comment <SELECTION DELETED>",! K LRM(Z) S B=B-1 G ASK
 S:X(1)="" X(1)=X I X(1)["?" S L(1)="S" D Q^LRUB G A
 I X(1)["@" W $C(7),!,"Deletion not allowed" G A
 I X(1)'?1ANP.ANP!($L(X(1))<1)!($L(X(1))>68)!(X(1)["?") W $C(7),!!,"Enter free text 2-68 characters." G A
 S LRM(Z,0)=X(1),LRM(Z)=0 Q
H2 I $D(LR("F")),$E(IOST,1,2)="C-" D M^LRU Q:LR("Q")
 D F^LRU W !,LRO(68)," -TC Code Search from ",LRSTR," to ",LRLST Q
H D H2 W !,"Patient",?35,"SSN",?45,"Acc#",?60,"Date obtained",!,LR("%") Q
H1 D H W !!,"TC Code: ",LRA," ",LRM(LRA,0) Q
 ;
END K ^TMP("LRAP",$J) D V^LRU Q
W W !!?10,LRO(68)," (",LRABV,") -TC CODE SEARCH",!!,"This report may take a while and should be queued to print at non-peak hours.",!?32,"OK to continue " S %=2 D YN^LRU Q
