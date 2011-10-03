LRAPPF ;AVAMC/REG - ANATOMIC PATH FILE SORT ;8/13/95  21:59 ;
 ;;5.2;LAB SERVICE;**72**;Sep 27, 1994
 D ^LRAP G:'$D(Y) END W !!?10,LRO(68),!?10,"Entries by Patient & Accession # Index",!! D B^LRU G:Y<0 END
 S LRSDT=LRSDT-.01,LRLDT=LRLDT+.99
 S ZTRTN="QUE^LRAPPF" D BEG^LRUTL G:POP!($D(ZTSK)) END
QUE U IO K ^TMP($J) S S=LRSS D XR^LRU,L^LRU,S^LRU,EN^LRUA
 F A=0:0 S LRSDT=$O(^LR(LRXR,LRSDT)) Q:'LRSDT!(LRSDT>LRLDT)  D L
 D ^LRAPPF1 K ^TMP($J) D END^LRUTL,END Q
L F LRDFN=0:0 S LRDFN=$O(^LR(LRXR,LRSDT,LRDFN)) Q:'LRDFN  D P
 Q
P I '$D(^LR(LRDFN,0)) K ^LR(LRXR,LRSDT,LRDFN) Q
 S F=$P(^LR(LRDFN,0),"^",2),N=$P(^(0),"^",3),F(1)=$S(F=2:"",1:$P(^DIC(F,0),"^")),X=^DIC(F,0,"GL"),N=@(X_N_",0)"),N(1)=$P(N,"^"),N(9)=$P(N,"^",9)
 I LRSS="AU" Q:$P($P($G(^LR(LRDFN,"AU")),U,6)," ")'=LRABV  S Y=^("AU"),H(1)=+Y,H(2)=$E(H(1),1,3),LRI=9999999-H(1),N=+$P($P(Y,"^",6)," ",3) D GL Q
 F LRI=0:0 S LRI=$O(^LR(LRXR,LRSDT,LRDFN,LRI)) Q:'LRI  I $P($P($G(^LR(LRDFN,LRSS,LRI,0)),U,6)," ")=LRABV S X=^(0),H(2)=$E($P(X,"^",10),1,3),N=+$P($P(X,"^",6)," ",3) S:'H(2) H(2)="?" S:'N N="???" D GL
 Q
GL S ^TMP($J,F,N(1),LRDFN,LRI)="",^TMP($J,"S",H(2),N)=F(1)_"^"_N(1)_"^"_N(9) Q
 ;
END D V^LRU Q
