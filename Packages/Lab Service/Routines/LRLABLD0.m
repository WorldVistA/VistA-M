LRLABLD0 ;DALOI/FHS/DRH/JMC - LABELS ON DEMAND FOR FUTURE LAB COLLECT ;8/29/94 12:36
 ;;5.2;LAB SERVICE;**1,65,121,161,218**;Sep 27, 1994
EN ;
 W !?5,"Future Lab, Immediate, Ward Collect and Send Patient Orders"
 W !?5,"Enter each date to print separately",!!
 N %DT,%ZIS,DIR,DIRUT,DTOUT,DUOUT,LRBATCH,LRCHLOC,LRCT0,LRDTC,X,Y,ZTSK
 S (LN,LRSTOP,CNT,LREND)=0,(LRLOCF,LRCHLOC)="",LRBATCH=1
 S DT=$$DT^XLFDT
 S %DT("A")="Print for what date(s): ",%DT="AEFX"
 S %DT(0)=DT ; Only allow future dates( >=DT)
 F  D ^%DT Q:Y<1  S LRCT0(Y)="" I '$O(^LRO(69,+Y,1,0)) W !?10,"No Orders For "_$$FMTE^XLFDT(Y) K LRCT0(Y)
 I '$O(LRCT0(0)) W !!?10,"Nothing selected ",!,$C(7) G END
 D LRPICK G:$G(LREND) END
 K DIR
 S DIR(0)="S^1:Selected Locations;2:All Locations"
 S DIR("A")="Choose one of the following",DIR("?")="Enter 1 or 2."
 D ^DIR
 I $D(DIRUT) D END Q
 S LRCHLOC=Y
SELLOC I LRCHLOC=1 D
 . N DIC,DTOUT,DUOUT,X,Y
 . S DIC="^SC(",DIC(0)="AEMQZ"
 . F  D  Q:Y<0
 . . D ^DIC
 . . I $D(DUOUT)!($D(DTOUT)) S LREND=1
 . . I Y>0 S LRLOCF(+Y)=$P(Y(0),U)
 . I '$O(LRLOCF(0)) W !!?10,"No Locations Selected ",$C(7) S LREND=1
 I LREND D END Q
 D SELCOLTY
 I LREND D END Q
 S %ZIS="Q" D ^%ZIS G END:POP
 I $D(IO("Q")) D  Q
 . N LRION
 . S LRION=ION
 . S ZTSAVE("LR*")="",ZTRTN="QUE^LRLABLD0",ZTDESC="Print future collection labels"
 . D ^%ZTLOAD,^%ZISC
 . W !?10,$S($G(ZTSK):"Queued to "_LRION,1:"Task NOT queued"),!
 . D END
 ;
QUE ; Tasked entry and interactive point.
 K ^TMP($J),LRDTC
 S ^TMP($J)=$$NOW^XLFDT_"^"_$$FMADD^XLFDT(DT,1,0,0,0)
 S (LN,LRSTOP,CNT,LRRB)=0
 S LRODT=0
 F  S LRODT=$O(LRCT0(LRODT)) Q:LRODT=""  D
 . S LRSN=0
 . F  S LRSN=$O(^LRO(69,LRODT,1,LRSN)) Q:LRSN<1  D
 . . N LREND
 . . S LRSN(0)=$G(^LRO(69,LRODT,1,LRSN,0)),LRSN(1)=$G(^LRO(69,LRODT,1,LRSN,1))
 . . ; Skip lab controls
 . . I $P($G(^LR(+LRSN(0),0)),"^",2)=62.3 Q
 . . ; Not selected location
 . . I $O(LRLOCF(0)),'$D(LRLOCF(+$P(LRSN(0),U,9))) Q
 . . ; No collection type
 . . I $P(LRSN(0),U,4)="" Q
 . . ; Not selected collection type.
 . . I '$D(LRCOLTY($P(LRSN(0),U,4))) Q
 . . S LREND=0 D CHK^LRLABLDS Q:LREND
 . . S LRDFN=+LRSN(0) D BLDTMP
 D ^LRLABELF
 D END^LRLABELF
 Q
 ;
SETUP ; Called by LRLABELF
 S Y2=1,LRRB=0,N=1
 S (Y1,Y)=LRCT
 S LRDAT=$TR($$FMTE^XLFDT(LRCT,"2M"),"@"," ") ; Date/time with "@" --> " "
 S NODE=$G(^LRO(69,LRODT,1,LRSN,0)) Q:'$L(NODE)  S LRCE=$G(^(.1))
 S LRCLTY=$P(NODE,U,4)
 S LRDFN=+NODE,DFN=$P($G(^LR(LRDFN,0)),U,3) Q:'DFN  S LRDPF=$P(^(0),U,2),LRINFW=$G(^(.091))
 D PT^LRX
 S LRLLOC=$P(NODE,U,7),LRTVOL=0
 S LRTJ=$P(NODE,U,3)
 I '$G(LRSING),$G(LRNEWL)'=LRLLOC D SEP
 S LRTJDATA=$S($D(^LAB(62,+LRTJ,0)):^(0),1:"")
 S LRTOP=$P(LRTJDATA,U,3),S1=$P(LRTJDATA,U,4)
 S S2=$P(LRTJDATA,U,5) D:LRTOP="" LRTOP
 D T
 S LRN=$S(+S1=0:1,1:LRTVOL\S1+$S(LRTVOL#S1:1,LRTVOL=0:1,1:0))+LRXL
 D P
 Q
T ;
 Q:LRODT'>0
 K LRTS,LRURG
 S LRURG0=9,(LRXL,T)=0
 F  S T=$O(^LRO(69,LRODT,1,LRSN,2,T)) Q:T<.5  D
 . Q:'$G(^LRO(69,LRODT,1,LRSN,2,T,0))  S LRTV=^(0)
 . I $P(LRTV,"^",11) Q
 . D T1
 . S LRTS(T)=$S($D(^LAB(60,+LRTV,.1)):$P(^(.1),U,1),1:"")
 . S LRXL=LRXL+$P(^LAB(60,+LRTV,0),U,15) ;Extra labels
 Q
T1 ;
 N X
 S LRVOL="" S:$P(LRTV,U,2)<3 LRURG=1
 I $P(LRTV,U,2),$P(LRTV,U,2)<LRURG0 S LRURG0=$P(LRTV,U,2)
 S X=0 F  S X=$O(^LAB(60,+LRTV,3,X)) Q:X<1  I +$G(^(X,0))=$P(NODE,U,3) S LRVOL=$P(^(0),U,4),LRTVOL=LRTVOL+LRVOL
 Q
LRTOP ;
 S LRTOP=$G(^LRO(69,LRODT,1,LRSN,4,1,0)) ; Specimen from file #69
 S T=$P($G(^LAB(62,+$P($G(NODE),U,3),0)),U,1) ; Collection sample from file #69
 S LRTOP=$P($G(^LAB(61,+LRTOP,0)),U)
 S LRTOP=T_$S(LRTOP'=T:"  "_LRTOP,1:"")
 Q
P ;
 I '$G(LRSING) D:$S('$D(LRNEWL):1,(LRNEWL'=LRLLOC):1,1:0) SEP
 Q:LRN<1
 N LRAA,LRBAR
 S LRAA=0
 D LBLTYP^LRLABLD
 D LRBAR^LRLABLD
 S LRACC=$P($P($$FMTE^XLFDT(LRCT,2),"@",2),":",1,2)_" "_LRCLTY
 D UID^LRLABLD,BARID^LRLABLD ; Setup UID and barcode ID.
 S LRURGA=$$URGA^LRLABLD(LRURG0) ; Setup urgency abbreviation
 U IO
 F LRI=1:1:LRN D
 . S I=LRI,N=LRN ; Label routines use "I" and  "N"
 . N LRI,LRN
 . S LRPREF=$S(S2="":"",LRTVOL>S2:"LARGE ",1:"SMALL "),LRTVOL=LRTVOL-S1
 . D @LRLABEL
 Q
QUIT ;
END ;
 D END^LRLABELF
 Q
SEP ;
 N LRAA,LRAN,LRACC,LRBAR,LRCE,LRURG0,LRXL
 N PNM,LRDAT,LRRB,SSN,LRTOP,LRINFW,LRTS,LRPREF,LRUID,I,N
 S:'$D(LRLLOC) LRLLOC="" S LRNEWL=LRLLOC
 S PNM="*** "_LRLLOC_" ***"
 N LRLLOC S LRLLOC="LAB"
 S LRDAT="XX/XX/XX",LRAN="0000"
 S SSN="000-00-0000",LRACC="*NEW LOC*",LRCE="000"
 S LRRB=1,LRPREF="SMALL ",LRURG0=9
 S LRTOP="TEST TUBE",LRTS(1)="DON'T USE",LRTS(2)="This label"
 D LBLTYP^LRLABLD
 D LRBAR^LRLABLD
 D UID^LRLABLD,BARID^LRLABLD ; Setup UID and barcode ID.
 S LRURGA=$$URGA^LRLABLD(LRURG0) ; Setup urgency abbreviation
 S LRINFW=" ",I=1,N=2,LRXL=0
 U IO
 D @LRLABEL
 Q
 ;
LRPICK ; Choose type of output
 K LRPICK
 N DIR,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="SO^1:List;2:Labels",DIR("?")="Enter 1 or 2."
 S DIR("A")="Print a list or labels"
 D ^DIR
 I $D(DIRUT) S LREND=1
 E  S LRPICK=Y
 Q
 ;
SELCOLTY ; Select collection Type(s) to Print
 N DIR,DIRUT,DTOUT,DUOUT,LRCNT,X,Y
 W !
 K LRCOLTY
 S LRCOLTY="I:IMM. LAB COLLECT;LC:LAB COLLECT;SP:SEND PATIENT;WC:WARD COLLECT"
 F I=1:1 Q:$P(LRCOLTY,";",I)=""  D
 . S LRCNT=I ; number of items
 . S DIR("A",I)=$J(I,5)_"  "_$P($P(LRCOLTY,";",I),":",2)_" ("_$P($P(LRCOLTY,";",I),":",1)_")"
 S DIR("A",LRCNT+1)=" "
 S DIR("A")="Select Collection Type(s)"
 S DIR(0)="LO^1:"_LRCNT_":0"
 D ^DIR
 I $D(DIRUT) S LREND=1 Q
 F I=1:1 Q:'$P(Y,",",I)  S LRCOLTY($P($P(LRCOLTY,";",$P(Y,",",I)),":"))=$P($P(LRCOLTY,";",$P(Y,",",I)),":",2)
 Q
 ;
BLDTMP ; Build TMP global with order info.
 ; Called from above, LRLABLDS
 N LRORDLOC
 S DFN=+$P($G(^LR(LRDFN,0)),U,3),LRDPF=+$P(^(0),U,2)
 I 'DFN!('LRDPF) Q
 D PT^LRX
 S LRORDLOC=$$GET1^DIQ(44,+$P(LRSN(0),U,9)_",",.01) ; Ordering location
 I LRORDLOC="" S LRORDLOC="Unknown"
 S ^TMP($J,"LR",LRODT,+$P(LRSN(0),U,8),$S($L(LRWRD):LRWRD_"/",1:"")_LRORDLOC,PNM,"*"_LRSN)=""
 Q
