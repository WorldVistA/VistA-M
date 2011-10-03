LRUL ;AVAMC/REG - PATIENT UTILITY LIST ;6/14/92  11:03
 ;;5.2;LAB SERVICE;**247**;Sep 27, 1994
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 D S,K
G W ! K DIC D ^LRDPA Q:DFN=-1  W !,"Is this the patient " S %=1 D YN^LRU G:%'=1 G
 S:'$D(^LRO(69.2,LRAA,7,DUZ,1,0)) ^(0)="^69.3PA^^" I '$D(^(LRDFN,0)) S X=^LRO(69.2,LRAA,7,DUZ,1,0),^(0)=$P(X,"^",1,2)_"^"_LRDFN_"^"_($P(X,"^",4)+1),^(LRDFN,0)=LRDFN_"^"_PNM_"^^^^^^^^"_SSN,^LRO(69.2,LRAA,7,DUZ,1,"C",PNM,LRDFN)=""
 W !!,"Another patient: " S %=2 D YN^LRU G G:%=1
 Q
K I $O(^LRO(69.2,LRAA,7,DUZ,1,0)) D L W $C(7),!,"The above entries not yet printed.  Do you want to delete them " S %=2 D YN^LRU I %'=1 S $P(^LRO(69.2,LRAA,7,DUZ,0),U,2)=LRT Q
EN K ^LRO(69.2,LRAA,7,DUZ) S ^LRO(69.2,LRAA,7,DUZ,0)=DUZ_"^"_LRT,^(1,0)="^69.3PA^^" Q
L W ! S LRDFN=0 F A=1:1 S LRDFN=$O(^LRO(69.2,LRAA,7,DUZ,1,LRDFN)) Q:'LRDFN  S X=^LR(LRDFN,0),Y=$P(X,"^",3),X=^DIC($P(X,U,2),0,"GL"),X=@(X_Y_",0)") W:A#2=1 ! W:A#2=0 ?40 W $P(X,U)," ",$E($P(X,U,9),6,10)
 Q
R Q:$P($G(^LRO(69.2,LRAA,7,DUZ,1,0)),U,4)>0  K ^LRO(69.2,LRAA,7,DUZ) L +^LRO(69.2,LRAA,7) S X=^LRO(69.2,LRAA,7,0),X(1)=$O(^(0)),^(0)=$P(X,"^",1,2)_"^"_X(1)_"^"_($P(X,"^",4)-1) L -^LRO(69.2,LRAA,7) Q
 ;
S S X="T",%DT="" D ^%DT S LRT=Y
 S:'$D(^LRO(69.2,LRAA,7,0)) ^(0)="^69.28PA^^" I '$D(^LRO(69.2,LRAA,7,DUZ)) L +^LRO(69.2,LRAA,7) S X=^LRO(69.2,LRAA,7,0),^(0)=$P(X,U,1,2)_U_DUZ_U_($P(X,U,4)+1) L -^LRO(69.2,LRAA,7)
 Q
