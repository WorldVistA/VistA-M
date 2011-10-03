LRAPBS1 ;AVAMC/REG - BLOCK/SLIDE DATA ENTRY;3/25/2002
 ;;5.2;LAB SERVICE;**121,259**;Sep 27, 1994
 ;
ASK N CORRECT,LRREL,LRMSG
 S %DT="",X="T" D ^%DT S LRY=$E(Y,1,3)+1700 W !!,"Enter year: ",LRY,"// " R X:DTIME G:'$T!(X[U) END S:X="" X=LRY
 S LRN="",%DT="EQ" D ^%DT G:Y<1 ASK S LRY=$E(Y,1,3),LRAD=$E(LRY,1,3)_"0000",LRH(0)=LRY+1700 W "  ",LRH(0)
 I '$O(^LRO(68,LRAA,1,LRAD,1,0)) W $C(7),!!,"NO ",LRAA(1)," ACCESSIONS IN FILE FOR ",LRH(0),!! Q
W ;
 K X,Y,LR("CK")
 W !!,"Select Accession Number: ",LRN,$S(LRN:"// ",1:"")
 R LRAN:DTIME
 I '$T!(LRAN[U)!(LRN=""&(LRAN="")) D END Q
 S:LRAN="" LRAN=LRN
 I LRAN'?1N.N S LRN="" W $C(7),!!,"Enter a number." G W
 S LRN=$O(^LRO(68,LRAA,1,LRAD,1,LRAN)) S:LRN'=+LRN LRN=""
 D OE1^LR7OB63D,REST,OERR^LR7OB63D
 G W
REST ;
 W "  for ",LRH(0)
 I '$D(^LRO(68,LRAA,1,LRAD,1,LRAN,0)) D  Q
 .W $C(7),!!,"Accession # ",LRAN," for ",LRH(0)," not in"
 .W " ACCESSION file",!!
 S X=^LRO(68,LRAA,1,LRAD,1,LRAN,0),LRLLOC=$P(X,"^",7),LRDFN=+X
 Q:'$D(^LR(LRDFN,0))  S X=^(0) D ^LRUP
 W !,LRP,"  ID: ",SSN
 Q:'$D(^LRO(68,LRAA,1,LRAD,1,LRAN,3))  S LRI=$P(^(3),"^",5)
 S LRA=$S("SPCYEM"[LRSS:^LR(LRDFN,LRSS,LRI,0),$D(^LR(LRDFN,"AU")):^("AU"),1:"")
 S LRRC=$S("SPCYEM"[LRSS:$P(LRA,"^",10),1:+LRA)
 ;K LRREL
 ;D RELEASE^LRAPUTL(.LRREL,LRDFN,LRSS,$G(LRI))
 ;I +$G(LRREL(1)) D  Q
 ;.K LRMSG
 ;.S LRMSG=$C(7)_"Report verified.  Cannot use this option."
 ;.D EN^DDIOL(LRMSG,"","!!")
 I LRSS="CY",LRCAPA D C^LRAPCWK Q:LRK<1
 W ! I "AUSPEM"[LRSS S %DT("A")=$S('$D(LRF):"Date/time blocks prepared/modified: ",1:"Date/time Gross Description/Cutting: ") D W^LRAPWU Q:Y<1  S LRK(1)=LRK D CK Q:'$D(Y)  G:$D(LRF) A
 S %DT("A")="Date/time  "_$S("AUSPCY"[LRSS:"slides stained: ",1:"sections prepared: ") D W^LRAPWU Q:Y<1  I LRSS="CY" D CK Q:'$D(Y)
 I "AUSPEM"[LRSS,Y<LRK(1) W $C(7),!,"Date/time must not be before date/time blocks prepared(" S Y=LRK(1),LRN="" D DD^%DT W Y,")." Q
A D EN^LRAPBS2,EN^LRAPST W !!,"Data displayed ok " S %=2 D YN^LRU Q:%<1  I %=1 D EN^LRAPWKA Q
 I LRSS'="AU" S DIE="^LR("_LRDFN_","""_LRSS_""",",DA=LRI,DA(1)=LRDFN D CK^LRU Q:$D(LR("CK"))  D ^DIE D FRE^LRU G A
 S DIE="^LR(",DA=LRDFN L +^LR(LRDFN,"AU"):1 I '$T W !,$C(7),"ANOTHER TERMINAL IS EDITING THIS ENTRY!" Q
 D ^DIE L -^LR(LRDFN,"AU") G A
 ;
CK I LRK<LRRC W $C(7),!,"Date/time must not be before date/time ",$S("SPCYEM"[LRSS:"specimen received (",1:"autopsy performed (") S Y=LRRC D DD^%DT W Y,")" K Y S LRN=""
 Q
SP S J=0,X="PARAFFIN BLOCK" D X^LRUWK S LRW(1)=LRT K LRT
 S X="PARAFFIN BLOCK, ADDITIONAL CUT" D X^LRUWK S LRW(0)=LRT K LRT
 S X="PLASTIC SECTION" D X^LRUWK S LRW(2)=LRT K LRT
 S X="FROZEN SECTION BLOCK RUSH" D X^LRUWK S LRW(3)=LRT K LRT
 S X="FROZEN SECTION BLOCK NOT RUSH" D X^LRUWK S LRW(4)=LRT K LRT
 S X="FROZEN SECTION BLOCK RUSH ADD" D X^LRUWK S LRW(5)=LRT K LRT
 S X="FROZEN SECTION ADDITIONAL CUT" D X^LRUWK S LRW(6)=LRT K LRT
 S X="FROZEN SECTION H & E" D X^LRUWK S LRW(7)=LRT K LRT Q
AU S J=0,X="AUTOPSY SECTION COMPLETE" Q:'LRCAPA  D X^LRUWK S LRW(1)=LRT K LRT
 S X="AUTOPSY H & E" D X^LRUWK S LRW(0)=LRT K LRT
 S X="AUTOPSY UNSTAINED SLIDE" D X^LRUWK S LRW(2)=LRT K LRT Q
 ;
END D V^LRU Q
