LRBLPE1 ;AVAMC/REG/CYM - PATIENT DRUG LIST ;6/13/96  15:41
 ;;5.2;LAB SERVICE;**72,247**;Sep 27, 1994
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 K ^TMP($J) S R="" W @IOF,$C(7),$P(LRP,"^"),?30,$P(LRP,"^",9),!,"Patient has positive direct AHG(BS) test  MEDICATIONS:" S A(1)=$Y+21
 F X=0:0 S X=$O(^PS(55,DFN,"P",X)) Q:'X  I $D(^(X,0)) S Y=+^(0) I $D(^PSRX(Y,0)) S ^TMP($J,+$P(^(0),"^",6))=0
 F X=0:0 S X=$O(^TMP($J,X)) Q:'X  I $D(^PSDRUG(X,0)) D:$Y>A(1)!'$Y R Q:R[U  W !,"OUTPATIENT PHARMACY ITEM: ",$P(^(0),"^")
 K ^TMP($J) F X=0:0 S X=$O(^PS(55,DFN,"IV",X)) Q:'X!(R[U)  F Y=0:0 S Y=$O(^PS(55,DFN,"IV",X,"AD",Y)) Q:'Y!(R[U)  S ^TMP($J,+^(Y,0))=""
 F X=0:0 S X=$O(^TMP($J,X)) Q:'X  I $D(^PS(52.6,X,0)) D:$Y>A(1)!'$Y R Q:R[U  W !,"IV DRUG: ",$P(^(0),"^")
 K ^TMP($J) F X=0:0 S X=$O(^PS(55,DFN,5,X)) Q:'X!(R[U)  F Y=0:0 S Y=$O(^PS(55,DFN,5,X,1,Y)) Q:'Y!(R[U)  S ^TMP($J,+^(Y,0))=""
 F X=0:0 S X=$O(^TMP($J,X)) Q:'X  I $D(^PSDRUG(X,0)) D:$Y>A(1)!'$Y R Q:R[U  W !,"INPATIENT  PHARMACY ITEM: ",$P(^(0),"^")
 Q
R R !,"'^' TO STOP ",R:DTIME S:'$T R="^" Q:R["^"
 S A(1)=A(1)+21 S:$Y<22 A(1)=$Y+21 W $C(13),$J("",15),$C(13) Q
 ;
EN D V^LRU S X="BLOOD BANK" D ^LRUTL G:Y=-1 END S LRW(0,86250)=$O(^LAM("E","86250.0000",0)) I 'LRW(0,86250) W $C(7),!!,"Enter 86250.0000 as 'Antihuman Globulin Test' in WKLD CODE file (#64)" G END
 W !!?6,"Division: ",LRAA(4),!,"Accession Area: ",LRO(68)
 W !!,LRAA(1)," Patient data entry for ",LRH(0)," " S %=1 D YN^LRU G:%<1 END I %=2 S %DT="AEX",%DT(0)="-N" D ^%DT K %DT G:Y<1 END S LRAD=Y D D^LRU S LRH(0)=Y
 I '$D(^LRO(68,LRAA,1,LRAD,0)) W $C(7),!!,"NO ",LRAA(1)," ACCESSIONS IN FILE FOR ",LRH(0),!! G END
 S LRC=1 W !,"Enter TEST COMMENT(s) " S %=2 D YN^LRU G:%<1 END I %=1 K LRC
 I $D(^XUSEC("LRBLSUPER",DUZ)) S LRE=1 W !,"Edit SPECIMEN COMMENT(s) " S %=2 D YN^LRU G:%<1 END I %=1 K LRE
 K LRS D L^LRU D:'$D(^LAB(69.9,1,8,3,0)) C^LRBLS S X=$P(^LAB(69.9,1,8,3,0),"^",2) S:'X LRS=1 Q
 ;
K L +^LRO(68,LRAA,1,LRAD,1,LRAN,4):5 I '$T W $C(7),!!,"I can't uncount this workload now 'cause someone else is editing this record. ",!!,"Use the Workload manual input option to delete workload data ",!! Q
 K ^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRT,0),^LRO(68,LRAA,1,LRAD,1,LRAN,4,"B",LRT,LRT)
 S Y=0 F A=0:1 S Y=$O(^LRO(68,LRAA,1,LRAD,1,LRAN,4,Y)) Q:'Y
 S X=^LRO(68,LRAA,1,LRAD,1,LRAN,4,0),X(1)=$O(^(0)),^(0)=$P(X,"^",1,2)_"^"_X(1)_"^"_$S(X(1)="":"",1:A) L -^LRO(68,LRAA,1,LRAD,1,LRAN,4) Q
 ;
END D V^LRU Q
