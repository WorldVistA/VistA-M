LRAPEDC ;AVAMC/REG/WTY - EDIT ANATOMIC PATH COMMENTS ;11/20/01
 ;;5.2;LAB SERVICE;**72,259**;Sep 27, 1994
 ;
 N LRREL,LRFLD,LRFILE,LRMSG
 S LRDICS="SPCYEM" D ^LRAP Q:'$D(Y)
 D XR^LRU
ASK ;
 W !?14,"1. Enter/edit specimen comment(s)"
 W !?14,"2. Enter/edit delayed report comment(s)"
 R !,"CHOOSE (1-2): ",X:DTIME
 G:X=""!(X[U) END
 I X'=1&(X'=2) D  G ASK
 .W $C(7),!,"Must select either a '1' or a '2'"
 S DR=$S(X=1:.99,1:.97),LR("C")=$S(X=1:"specimen",1:"delayed report")
 W !!,"EDIT ",LRO(68)," ",LR("C")," comments for ",LRH(0)," "
 S %=1 D YN^LRU G:%<1 END
 I %=2 D  G:Y<1 END
 .S %DT="AE",%DT(0)="-N",%DT("A")="Enter YEAR: "
 .D ^%DT K %DT
 .Q:Y<1
 .S LRAD=$E(Y,1,3)_"0000",Y=LRAD D D^LRU S LRH(0)=Y
 S LRC=$E(LRAD,1,3)
G ;
 W !!,"Enter ",LRO(68)," Accession #: "
 R LRAN:DTIME G:LRAN=""!(LRAN[U) END
 I LRAN'?1N.N W $C(7)," ENTER NUMBERS ONLY" G G
 D EDIT
 G G
EDIT ;
 S LRDFN=$O(^LR(LRXREF,LRC,LRABV,LRAN,0))
 I 'LRDFN W $C(7),"  Not in file" Q
 I '$D(^LR(LRDFN,0)) K ^LR(LRXREF,LRC,LRABV,LRAN,LRDFN) Q
 S X=^LR(LRDFN,0) D ^LRUP
 W !,LRP," ID: ",SSN," OK "
 S %=1 D YN^LRU Q:%'=1
 S LRI=+$O(^LR(LRXREF,LRC,LRABV,LRAN,LRDFN,0))
 I '$D(^LR(LRDFN,LRSS,LRI,0)) D  Q
 .W $C(7),!,"Entry in x-ref but not in file ! X-ref deleted."
 .K ^LR(LRXREF,LRC,LRABV,LRAN,LRDFN,LRI)
 S LRFLD=$S(LRSS="SP":8,LRSS="CY":9,LRSS="EM":2,1:"")
 Q:LRFLD=""
 S LRFILE=+$$GET1^DID(63,LRFLD,"","SPECIFIER")
 S LRREL=+$$GET1^DIQ(LRFILE,LRI_","_LRDFN_",",.11,"I")
 I LRREL D  Q
 .K LRMSG
 .S LRMSG=$C(7)_"Report released.  Edit not allowed from this option."
 .D EN^DDIOL(LRMSG,"","!!")
 S X=^LR(LRDFN,LRSS,LRI,0)
 I $P($P(X,"^",6)," ")'=LRABV Q
 S LRD=$P(X,"^",10),DA=LRI,DA(1)=LRDFN,DIE="^LR(LRDFN,LRSS,"
 S (LRB,Y)=+X D D^LRU W !,"Specimen date: ",Y
 D ^DIE
 Q
END ;
 D V^LRU
 Q
