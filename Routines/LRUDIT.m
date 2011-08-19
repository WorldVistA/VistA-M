LRUDIT ;AVAMC/REG - DATA CHANGE AUDIT ;4/19/89  14:25 ;
 ;;5.2;LAB SERVICE;**247**;Sep 27, 1994
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
EN D END S (BY,FLDS)="[LRUCNG]",L=0,DIC="^LRO(69.2," K IOP G EN1^DIP
 ;
EN1 ;from LRBLS,LRMIS
 G:'$D(LRAA)#2 END W !!,"Delete ",LRAA(1)," data change audits",!
 D B^LRU G:Y<0 END S LRLDT=LRLDT+.99,LRSDT=LRSDT-.00001
 W !!,"OK to delete audits" S %=2 D YN^LRU G:%'=1 END
 W ! S X=LRSDT F A=0:1 S X=$O(^LRO(69.2,LRAA,999,X)) Q:'X!(X>LRLDT)  W:A#10=0 "." K ^LRO(69.2,LRAA,999,X)
 I A S X(1)=$O(^LRO(69.2,LRAA,999,0)) S:'X(1) X(1)=0 L +^LRO(69.2,LRAA,999) S X=^LRO(69.2,LRAA,999,0),^(0)=$P(X,"^",1,2)_"^"_X(1)_"^"_$S(X(1)=0:X(1),1:($P(X,"^",4)-A)) L -^LRO(69.2,LRAA,999)
 W $C(7),!,"DONE" G END
 ;
END D V^LRU Q
