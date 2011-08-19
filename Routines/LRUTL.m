LRUTL ;AVAMC/REG/CYM - GENERAL LAB UTILITY ;3/12/98  07:53
 ;;5.2;LAB SERVICE;**72,201**;Sep 27, 1994
 I $D(DUZ)'=11 S Y=-1 Q
 D ^LRPARAM Q:$G(LREND)
 I X="BLOOD BANK" S LRAA(2)="BB" D BB Q:Y=-1
 S DIC=68,DIC(0)="MOXZ" I X="" S DIC(0)="AEMQZ"
A D ^DIC K DIC Q:$D(DUOUT)!$D(DTOUT)!(X="")  I Y<1 W $C(7),!!,X," Not in Accession Area file (#68)",!,"Tell responsible person to enter ",X," in file." Q
 S LR("K")=$P(Y(0),U,14) I LR("K"),$D(^DIC(19.1,LR("K"),0)) S LR("K")=$P(^(0),U) I LR("K")]"",'$D(^XUSEC(LR("K"),DUZ)) W $C(7),!!,"You do not have the appropriate security key to select this section.",! S Y=-1 Q
 S LRAA=+Y,(LRO(68),LRAA(1))=$P(Y,U,2),LRAA(2)=$P(Y(0),U,2),LRABV=$P(Y(0),U,11),LRSS=$P(Y(0),U,2) Q:'$L(LRSS)
 I LRSS="BB" S LRAA(1)="BLOOD BANK",LR(69.981)=LRAA
 I "SPCYEMAU"[LRSS S LRAA(1)=$S(LRSS="SP":"SURGICAL PATHOLOGY",LRSS="CY":"CYTOPATHOLOGY",LRSS="AU":"AUTOPSY",1:"EM")
 S X=^DIC(4,DUZ(2),0),LRAA(4)=$P(X,"^"),LRAA(5)=$E($P($G(^(1)),"^",3),1,30),X=+$P(X,"^",2),LRAA(6)=$P($G(^DIC(5,X,0)),"^",2) ;LRAA(4)=institution name, LRAA(5)=city, LRAA(6)=state
 S LRAX=$O(^DD(63,"B",LRAA(1),0)) S:LRAX'>0 LRAX=+$O(^DD(63,"B",LRAA(2),0)) S LRSF=$S($D(^DD(63,LRAX,0)):+$P(^(0),"^",2),1:"")
 S LRCAPA=$P(^LAB(69.9,1,0),"^",14)&$P(^LRO(68,LRAA,0),"^",16),LRT="" ;workload flag
 I 'LRSF,"BBCYEMSP"[LRSS W $C(7),!!,"LAB DATA FILE(#63) is missing one of the following:",!?3,"BLOOD BANK (63.01)",!?3,"EM (63.02)",!?3,"SURGICAL PATHOLOGY (63.08)",!?3,"CYTOPATHOLOGY (63.09)",!!?29,"Please tell IRM STAFF" D V^LRU S Y=-1 Q
 I '$D(^LRO(69.2,LRAA,0)) S ^(0)=LRAA_"^"_$P(Y(0),"^",11),^LRO(69.2,"B",LRAA,LRAA)="",^LRO(69.2,"C",$P(Y(0),"^",11),LRAA)="",X=^LRO(69.2,0),^(0)=$P(X,"^",1,2)_"^^"_($P(X,"^",4)+1)
 S:'$D(^LRO(69.2,LRAA,1,0)) ^(0)="^69.21A^0^0" S:'$D(^LRO(69.2,LRAA,3,0)) ^(0)="^69.29A^0^0" S:'$D(^LRO(69.2,LRAA,2,0)) ^(0)="^69.23A^0^0"
 S X=$S($D(^VA(200,DUZ,0)):$P(^(0),U,2),1:"") D C^LRUA S LRWHO=X,LRDPAF=1,Y=DT K DR,DIE,DIC
 D LRAD^LRU
EN ;
 S LRU=$O(^LAB(61,"C","00001",0)) I 'LRU Q:'$D(^LAB(61,0))  S X="UNKNOWN",(DIC,DIE)=61,DIC(0)="LMO",DR="2///00001",DLAYGO=61 D ^DIC S (LRU,DA)=+Y D ^DIE K DIC,DIE,DR,DLAYGO
 Q
BEG ;
 K IOP,ZTSK,%ZIS S %ZIS="Q" D ^%ZIS Q:POP!(IO(0)=IO)&('$D(IOCPU))  I '$D(IO("Q")) G W
 G QUE
END ;
 W:'$D(LR("LINE")) ! W:$E(IOST,1,2)="P-"&('$D(LR("FORM"))) @IOF S:$D(ZTQUEUED) ZTREQ="@" D:'$D(ZTQUEUED) ^%ZISC Q
 ;
BB S (A,B)=0 F  S A=$O(^LRO(68,A)) Q:'A  I $P($G(^LRO(68,A,0)),"^",2)=LRAA(2),$G(^(3,DUZ(2),0)) S B=B+1,B(B)=A
 I B=0 W $C(7),!!,"There are no accession areas for blood bank.",!,"Please have responsible person enter one in Accession File (#68)." S Y=-1 Q
 I B=1!($D(LR("M"))) S X=$P(^LRO(68,B(B),0),U),Y=1 K A,B Q
 S DIC=68,DIC(0)="AEQM",DIC("S")="I $P(^(0),U,2)=""BB""&(+$G(^(3,+DUZ(2),0)))" D ^DIC K DIC S X=$P(Y,U,2) Q
 ;
QUE K IO("Q") I '$D(ZTRTN)!(IOF="") S POP=1 Q
 S:'$D(ZTDESC) ZTDESC=""
 S ZTIO=ION S:'$D(ZTSAVE) ZTSAVE("*")="" D ^%ZTLOAD W:$D(ZTSK) !,"Report Queued to device ",ION K ZTIO S:'$D(ZTSK) POP=1 D ^%ZISC Q
 ;
W W !?13,"Do you want to queue this report " S %=2 D YN^LRU I %<1 S POP=1 Q
 G:%=1 QUE S IOP=ION D ^%ZIS I POP W $C(7),!,"PRINTER BUSY, TRY LATER"
 Q
STF(LRAA,LRAD,LRAN,LRT,TIME) ;Set ^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRT,0) entries into
 W !,LRAA,!,LRAD,!,LRAN,!,LRT,!,TIME
 ;accession file. Used with workload data collection functions. LRRC=yyymmdd.mmss
 ;A default of 50 (Wkld) urgency is stuffed for each entry.
 ; LRT=internal pointer to ^LAB(60,
 S LRERR=$S('$G(LRAA):1,'$G(LRAD):1,'$G(LRAN):1,'$G(LRT):1,$D(^LRO(68,LRAA,1,LRAD,1,LRAN,0))[0:1,1:0) Q:LRERR
 N X,LRRC
 S LRRC=$S($P(TIME,".",2):TIME,1:$$NOW^XLFDT)
 S:$D(^LRO(68,LRAN,1,LRAD,1,LRAN,4,0))[0 ^(0)="^68.04PA^"
 I '$D(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRT,0)) S ^(0)=LRT_"^50^^"_DUZ_"^"_LRRC D
 .S X=^LRO(68,LRAA,1,LRAD,1,LRAN,4,0),^(0)=$P(X,"^",1,2)_"^"_LRT_"^"_($P(X,"^",4)+1),^LRO(68,LRAA,1,LRAD,1,LRAN,4,"B",LRT,LRT)=""
 S:$D(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRT,1,0))[0 ^(0)="^68.14P^^" Q
 Q
