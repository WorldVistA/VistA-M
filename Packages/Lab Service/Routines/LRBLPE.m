LRBLPE ;AVAMC/REG - BB DATA ENTRY BY ACC # ;8/11/97
 ;;5.2;LAB SERVICE;**35,72,100,121,247,408**;Sep 27, 1994;Build 8
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 Q  D EN^LRBLPE1 G:'$D(LRAA) END
L R !!,"Select Accession Number: ",LRAN:DTIME G:LRAN=""!(LRAN[U) END I LRAN'?1N.N W $C(7),"  Enter numbers only." G L
 S (LR(1),LR(2))="" D REST G L
REST W "  for ",LRH(0) I '$D(^LRO(68,LRAA,1,LRAD,1,LRAN,0)) W $C(7),!!,"Accession # ",LRAN," for ",LRH(0)," not in ACCESSION file",!! Q
 N LRODT,LRSN S X=^LRO(68,LRAA,1,LRAD,1,LRAN,0),LRSVC=$P(X,"^",9),LRLLOC=$P(X,"^",7),LRDFN=+X,LRODT=$P(X,"^",4),LRSN=$P(X,"^",5) Q:'$D(^LR(LRDFN,0))  S X=^(0)
 S LRABO=$P(X,"^",5),LRRH=$P(X,"^",6),DFN=$P(X,"^",3),(LRDPF,X)=$P(X,"^",2),X=^DIC(X,0,"GL"),X=@(X_DFN_",0)"),LRP=$P(X,"^"),SSN=$P(X,"^",9) D SSN^LRU
 S S=$S($D(^LRO(68,LRAA,1,LRAD,1,LRAN,5,1,0)):+^(0),1:"") I +S S S=$S($D(^LAB(61,+S,0)):$P(^(0),"^"),1:"")
 W !,LRP,"  ID: ",SSN," ABO: ",LRABO," Rh: ",LRRH,!,"Specimen: ",S D ^LRDPA2 W !
 S LRI=$P(^LRO(68,LRAA,1,LRAD,1,LRAN,3),"^",5)
 F LRT=0:0 S LRT=$O(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRT)) Q:'LRT  I $P(^LAB(60,LRT,0),"^",4)'="WK" D TEST
 Q
TEST S (LRW(2.1),LRW(2.4),LRW(2.6),LRW)=0 I $P(^LAB(60,LRT,0),"^",4)'=LRSS W $C(7),!!,$P(^(0),"^")," does not belong in ",LRAA(1)," accession area !",!,"Test deleted",!! D K^LRBLPE1 Q
 I '$D(LRT(LRT)) S X=^LAB(60,LRT,0),Y=$P(X,"^",14),LRT(LRT)=$P(X,"^") I Y,$D(^LAB(62.07,Y,.1)) S X=Y,Y=^(.1),LRT(LRT)=LRT(LRT)_"^"_Y_"^"_X
 I $P(LRT(LRT),"^",2)="" W $C(7),!!,"Cannot continue without execute code for ",$P(LRT(LRT),U) Q
 K L W !,"Test:",$P(LRT(LRT),"^") X $P(LRT(LRT),"^",2) S DIE="^LR(",DA=LRDFN L +^LR(LRDFN,"BB"):1 I '$T W !,$C(7),"ANOTHER TERMINAL IS EDITING THIS ENTRY!" Q
 D:DR="[LRBLPAG]" PH
 W ! D ^DIE L -^LR(LRDFN,"BB") D OR D:'$D(Y) ^LRBLPEW D:DR="[LRBLPAG]" SET D:$D(LRMED) ^LRBLPE1
 D
 . N CORRECT S CORRECT=0 I $P($G(^LR(LRDFN,"BB",+LRI,0)),"^",3) S CORRECT=1
 . D NEW^LR7OB1(LRODT,LRSN,"RE")
 K DA,DIE,DR,LRMED Q
 ;
PH I '$O(^LR(LRDFN,1,0)),'$O(^LR(LRDFN,1.5,0)) Q
 W !?40,"Antigen(s) present",?60,"| Antigen(s) absent",!,LR("%"),!,"Patient's Phenotype Record:"
 S E=1,(F(1),G)="" F B=0:0 S B=$O(^LR(LRDFN,1,B)) Q:'B  S I=$P(^LAB(61.3,B,0),"^"),F(E)=F(E)_I_" ",G=G+1 I $L(F(E))>19 S F(E)=$P(F(E)," ",1,G-1),E=E+1,F(E)=I_" ",G=""
 S K=E,E=1,(J(1),G)="" F B=0:0 S B=$O(^LR(LRDFN,1.5,B)) Q:'B  S I=$P(^LAB(61.3,B,0),"^"),J(E)=J(E)_I_" ",G=G+1 I $L(J(E))>18 S J(E)=$P(J(E)," ",1,G-1),E=E+1,J(E)=I_" ",G=""
 S:E>K K=E F E=1:1:K W:E>1 ! W:$D(F(E)) ?40,$J(F(E),19) W:$D(J(E)) ?60,"|",$J(J(E),18)
 Q
SET S C=0 F A=0:0 S A=$O(^LR(LRDFN,"BB",LRI,1.1,A)) Q:'A  I '$D(^LR(LRDFN,1,A)) S ^(A,0)=A,C=C+1
 I C S:'$D(^LR(LRDFN,1,0)) ^(0)="^63.13PA^^" S X=^(0),X(1)=$O(^(0)),^(0)=$P(X,"^",1,2)_"^"_X(1)_"^"_($P(X,"^",4)+1)
 S C=0 F A=0:0 S A=$O(^LR(LRDFN,"BB",LRI,1.2,A)) Q:'A  I '$D(^LR(LRDFN,1.5,A)) S ^(A,0)=A,C=C+1
 I C S:'$D(^LR(LRDFN,1.5,0)) ^(0)="^63.016PA^^" S X=^(0),X(1)=$O(^(0)),^(0)=$P(X,"^",1,2)_"^"_X(1)_"^"_($P(X,"^",4)+1)
 S DA(2)=LRDFN,DA(1)=LRI F LRM=0:0 S LRM=$O(LRM(LRM)) Q:'LRM  F M=0:0 S M=$O(LRM(LRM,M)) Q:'M  I '$D(^LR(LRDFN,"BB",LRI,LRM,M)) S O=M,X="deleted",Z=LRM(LRM,M)_",.01" D EN^LRUD
 K M,LRM,O Q
END D V^LRU Q
OR ;Call to OE/RR 2.5 status update
 I $$VER^LR7OU1>2.5 Q
 N LRODT,LRSN,LRTST,LRIEN
 S LRODT=$P(^LRO(68,LRAA,1,LRAD,1,LRAN,0),"^",4),LRSN=$P(^(0),"^",5),LRTST=$O(^(4,0)) Q:LRTST<1
 I $D(^LRO(69,LRODT,1,LRSN,2)) S LRIEN=$O(^(2,"B",LRTST,0)) Q:LRIEN<1  S ORIFN=$P(^LRO(69,LRODT,1,LRSN,2,LRIEN,0),"^",7)
 S ORETURN("ORSTS")=2 D RETURN^ORX
 Q
