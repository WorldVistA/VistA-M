LRAPMV ;AVAMC/REG/CYM - MOVE AP ACCESSION ;4/1/98  11:53 ;
 ;;5.2;LAB SERVICE;**72,231,259**;Sep 27, 1994
 W !!?17,"Move an accession from one patient to another"
 ;Add Quit to ensure this option does not execute
 W !!?18,"*** THIS OPTION IS NO LONGER AVAILABLE ***"
 Q
 S LRDICS="SPCYEM" D ^LRAP G:'$D(Y) END D XR^LRU
 W !!,"Accession Year: ",LRH(0)," " S %=1 D YN^LRU G:%<1 END I %=2 S %DT="AE",%DT(0)="-N",%DT("A")="Enter YEAR: " D ^%DT K %DT G:Y<1 END S LRAD=$E(Y,1,3)_"0000",LRH(0)=$E(Y,1,3)+1700
 I '$O(^LRO(68,LRAA,1,LRAD,1,0)) W $C(7),!!,"NO ",LRO(68)," ACCESSIONS IN FILE FOR ",LRH(0),!! Q
W K X,Y,LR("CK") R !!,"Move Accession Number: ",LRAN:DTIME G:LRAN=""!(LRAN[U) END I LRAN'?1N.N!($E(LRAN)=0) W $C(7),!,"Enter a number, no leading zero's" G W
 D REST G W
REST W "  for ",LRH(0) I '$D(^LRO(68,LRAA,1,LRAD,1,LRAN,0)) W $C(7),!!,LRO(68)," Accession # ",LRAN," for ",LRH(0)," not in ACCESSION file",!! Q
 S X=^LRO(68,LRAA,1,LRAD,1,LRAN,0),LRDFN=+X Q:'$D(^LR(LRDFN,0))  S X=^(0) D ^LRUP
 W !,LRP,"  ID: ",SSN,!,"File: ",$P($G(^DIC(+P("F"),0)),U)
 S LRI=+$P($G(^LRO(68,LRAA,1,LRAD,1,LRAN,3)),"^",5) I '$D(^LR(LRDFN,LRSS,LRI,0)) W $C(7),!,"Inverse date missing or incorrect in Accession Area file for",!,LRAA(1),"  Year: ",$E(LRAD,2,3),"  Accession: ",LRAN Q
 S DIE="^LR(LRDFN,LRSS,",DA=LRI D CK^LRU Q:$D(LR("CK"))  S LRO=LRDFN
 W !,"Move accession to " D ^LRDPA
 I Y=-1 D FRE^LRU Q
 W !,"File: ",$P($G(^DIC(+LRDPF,0)),U)
 I LRO=LRDFN W $C(7),!,"No need to move accession to the same patient" D FRE^LRU Q
 I $D(^LR(LRDFN,LRSS,LRI)) W $C(7),!,LRP,"already has an accession with the same internal file number." D FRE^LRU Q
 K DIR W $C(7),! S DIR(0)="YO",DIR("A")=" OK TO MOVE  YES/NO// ",DIR("B")="NO"
 S DIR("?")="Answer YES if this accession is to be moved to a new patient"
 D ^DIR I Y'=1 D FRE^LRU K DIR Q
 S:'$D(^LR(LRDFN,LRSS,0)) ^(0)="^"_LRSF_"DA^^"
 S %X="^LR(LRO,LRSS,LRI,",%Y="^LR(LRDFN,LRSS,LRI," D %XY^%RCR S $P(^LRO(68,LRAA,1,LRAD,1,LRAN,0),"^")=LRDFN
 ; The following line send notification to WHP that an accession has been moved. ; cym 4/5/1999
 I "SPCY"[LRSS D MOVE^LRWOMEN
 K ^LR(LRO,LRSS,LRI) S X=^LR(LRO,LRSS,0),X(1)=$O(^(0)),^(0)=$P(X,"^",1,2)_"^"_X(1)_"^"_($P(X,"^",4)-1)
 S X=^LR(LRDFN,LRSS,0),^(0)=$P(X,"^",1,2)_"^"_LRI_"^"_($P(X,"^",4)+1),X=+$P(^LR(LRDFN,LRSS,LRI,0),"^",10),^LR(LRXR,X,LRDFN,LRI)="",^LR(LRXREF,$E(LRAD,1,3),LRABV,LRAN,LRDFN,LRI)=""
 K ^LR(LRXR,X,LRO,LRI),^LR(LRXREF,$E(LRAD,1,3),LRABV,LRAN,LRO,LRI)
 ; Following code updates the AP report queue
 S (LRFINAL,LRNODE)=""
 I "SPEMCY"[LRSS D
 . S LRNODE=^LR(LRDFN,LRSS,LRI,0)
 . Q:LRNODE']""  I $P(LRNODE,U,3)]"" S LRFINAL=1
 I LRFINAL=1 D
 . Q:$P($G(^LRO(69.2,LRAA,2,LRAN,0)),U)=LRDFN
 . I $P($G(^LRO(69.2,LRAA,2,LRAN,0)),U)=LRO D
 .. S DIK="^LRO(69.2,LRAA,2,",DA=LRAN D ^DIK
 . S FDAIEN(1)=LRAN
 . S FDA(1,69.23,"+1,"_+LRAA_",",.01)=LRDFN
 . S FDA(1,69.23,"+1,"_+LRAA_",",1)=LRI
 . D UPDATE^DIE("","FDA(1)","FDAIEN")
 I LRFINAL="" D
 . Q:$P($G(^LRO(69.2,LRAA,1,LRAN,0)),U)=LRDFN
 . I $P($G(^LRO(69.2,LRAA,1,LRAN,0)),U)=LRO D
 .. S DIK="^LRO(69.2,LRAA,1,",DA=LRAN D ^DIK
 . S FDAIEN(1)=LRAN
 . S FDA(1,69.21,"+1,"_+LRAA_",",.01)=LRDFN
 . S FDA(1,69.21,"+1,"_+LRAA_",",1)=LRI
 . D UPDATE^DIE("","FDA(1)","FDAIEN")
 D FRE^LRU Q
 ;
END K FDAIEN,FDA,LRFINAL,LRNODE D V^LRU Q
