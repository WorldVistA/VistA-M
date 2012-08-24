LRHYF1 ;DALOI/HOAK - LAB ARRIVAL AND DRAW TIME UPDATER ;4/13/1999
 ;;5.2;LAB SERVICE;**405**;Sep 27, 1994;Build 93
 ;
 ;
PAT ;
 ;
 ; This routine is used by lab to display updated lab arrival
 ; and collection time as well as the phlebotomist and the provider
 ; as well as the date time ordered.
 ;
 ;
 QUIT
ORD ;
 ;
 QUIT
 ;
SINGLE ;
 K LRAA,LRAN,LRAD,LRUID,LRACC6
 ; This block calls up the testing demographics.
 ;
 W !!
 S LRACC="" K LRHN0
 D ^LRHYU4
 I $G(LRORD) D ORD
 I LRAN<1 D END QUIT
 I $L(X)'=10 S X=$G(^LRO(68,LRAA,1,LRAD,1,LRAN,.3))
 I X S LRUID=X
 ;
 I '$D(^LRO(68,LRAA,1,LRAD,1,LRAN,0)) W !,"Doesn't exist." G SINGLE
 ; KUNKE OPTION TY-IN
KUNKE ;
 S LRUNC=1
 S LRDAT=+$P(^LRO(68,LRAA,1,LRAD,1,LRAN,0),U,4),LRSN=+$P(^(0),U,5)
 D:'$G(LRKUNKE) LST1^LRHYLS1
 ;
 ;
 ;  Adding urgency to the display
 S LRTEST=0
 K LRURG2
 F  S LRTEST=$O(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRTEST)) Q:+LRTEST'>0  D
 .  W !,$P($G(^LAB(60,LRTEST,0)),U)
 .  S LRURG7=$P($G(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRTEST,0)),U,2)
 .  I LRURG7=1 S LRURG=LRURG7
 .  I LRURG7=2 S LRURG2=2
 I $G(LRURG2)=2 D
 .  Q:$G(LRURG)=1  S LRURG=2
 ;
 ;
 ; Blink urgency if MED-EMERGE
 S LRURG=$G(LRURG,LRURG7)
 W !,$S($D(^LAB(62.05,+LRURG,0)):$P(^(0),U),1:"")," "
 ;
 ;
 D EDIT
 ;
 ;
 I $G(LREND) W !,"Please start over..." K LREND,LRIDTNEW
 D END
 I $G(LRKUNKE) G SINGLE^LRHYT1 QUIT
 G SINGLE
 ;
 QUIT
 ;
END ;
 K LRAA,LRAD,LRAN,LRBLOOD,LRARIVE,LRBLOOD,LRCE,LRDAT,LRDFN,LRIDT
 K LRDLA,LRDLC,LRDPF,LRDRAW,LRDT0,LRDTO,LRHYDUZ,LRHYNISH,LRPRAC
 K LRSN,LRTEST,LRURG,PNM,SSN,VAIN,VADM
 QUIT
 ;
EDIT ;
 Q:LRAA=-1
 S LRDFN=$P(^LRO(68,LRAA,1,LRAD,1,LRAN,0),U)
 S LRIDT=$P(^LRO(68,LRAA,1,LRAD,1,LRAN,3),U,5) ; old LRIDT
CHECK ;
 ;  Check for results. Quit if results present
 ;
 ;
PAST ;
 K LRHYDUZ
 ; look at Micro And CH subscripted tests
 I $D(^LR(LRDFN,"CH",LRIDT)) S LRSS="CH"
 E  S LRSS="MI"
 ;
 ;  run review option here and show it there has been a previous 
 ;  updating of this accession
 I $G(LRKUNKE)'=1 I $D(^XUSEC("LRLAB",DUZ)) D EDIT^LRHYF2
 K LRARIVE
 ;
 ;
 W !
 ;  WE need an event to stop non-LRLAB key holders from entering
 ;  LAB ARRIVAL TIME
BACK G:'$D(^XUSEC("LRLAB",DUZ)) DRAW
 G DRAW
 K %DT
 D NOW^%DTC
 S %DT="AERSZ"
 D ^%DT
 I Y=-1 S LREND=1 QUIT
 I $D(DTOUT)!($D(DUOUT)) S LREND=1 QUIT
 D NOW^%DTC
 I Y>% W !!,"Can't accept future times!" W *7 G BACK
 S LRARIVE=Y I +LRARIVE'>0 S LRARIVE=$P(^LRO(68,LRAA,1,LRAD,1,LRAN,3),U,3)
 ;
SET ;
 S $P(^LRO(69,LRDAT,1,LRSN,3),U)=$G(LRARIVE)
 ;
 S $P(^LRO(68,LRAA,1,LRAD,1,LRAN,3),U,3)=$G(LRARIVE)
 S $P(^LR(LRDFN,"MI",LRIDT,0),U,10)=$G(LRARIVE)
 I $G(LRARIVE) S ^LRO(68,LRAA,1,LRAD,1,"E",LRARIVE,LRAN)=""
 ;
 ;
DRAW ;
 QUIT
THERE ;
 W !
 K %DT
 D NOW^%DTC
 S %DT="AESRZ"
 S %DT("A")="Please enter updated DRAW/COLLECTION TIME: "
 ;
 ; Only default if lrlab owner
 I +LRDRAW7>0 S LRDRAW7=$$Y2K^LRX(LRDRAW7)
 E  S LRDRAW7=$$Y2K^LRX($P(^LRO(68,LRAA,1,LRAD,1,LRAN,3),U))
 I $D(^XUSEC("LRLAB",DUZ)) S %DT("B")=$P(LRDRAW7,"@")_"@"_$E($P(LRDRAW7,"@",2),1,5)
 ;
 D ^%DT
 I X="" G DRAW
 I $D(DTOUT)!($D(DUOUT)) S LREND=1 QUIT
 I Y=-1 S LRUP="YES"
 E  S LRUP="NO"
 S LRDRAW=Y I +LRDRAW'>0 S LRDRAW=LRDRAW7
 S $P(^LRO(68,LRAA,1,LRAD,1,LRAN,3),U)=LRDRAW
 ;
 ;
 I $D(^XUSEC("LRLAB",DUZ)) G TIC
 ;
GUY ;  COLLECTOR DEMOGRAPHICS stuff this into LR...99 COMMENT FIELD.
 S LRHYNISH=$P(^VA(200,DUZ,0),U,2)
 I '$D(^XUSEC("LRLAB",DUZ)) S LRPON=$P($G(^VA(200,DUZ,0)),U)
 W !!!
 ;
 D
 .  D SCRNON^LRHYUTL
 .  W IOBON
 .  W IORVON
 .  W IODHLT,LRHYNISH
 .  W !
 .  W IODHLB,LRHYNISH
 .  W !!
 .  W IORVOFF
 .  W IOBOFF
 .  D SCRNOFF^LRHYUTL
 ;
 W !!,"Your initials have been captured." D
 .  S DIR(0)="Y" S DIR("B")="YES"
 .  S DIR("A")="Is this correct?"
 .  D ^DIR
 .  I $D(DTOUT)!($D(DUOUT)) QUIT
 .  ;
 .  I Y S LRHYDUZ=LRPON
 .  Q:Y>0
 .  S DIC("A")="Enter collector here."
 .  S DIC="^VA(200,"
 .  S DIC(0)="AEMQZ"
 .  D ^DIC
 .  I +Y>0 S LRHYDUZ=$P(Y(0),U) S LRPON=$P(^VA(200,DUZ,0),U)
 ;
 ; This global serves as an interim solution until lab files can
 ; be updated
TIC ;
 S LRARIVE=$G(LRARIVE,$P(^LRO(68,LRAA,1,LRAD,1,LRAN,3),U,3))
