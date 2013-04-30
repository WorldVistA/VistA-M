LRWRKLST ;DALOI/STAFF - LONG ACCESSION LIST ;02/28/12  19:21
 ;;5.2;LAB SERVICE;**1,17,38,153,185,221,268,362,350**;Sep 27, 1994;Build 230
 ;
 N LRDICS
 ;
 ; Save and restore DIC("S") if micro long form accession option (LRMIACC1).
 I $D(DIC("S")) S LRDICS=DIC("S")
 D LREND
 I $D(LRDICS) S DIC("S")=LRDICS
 ;
 S LRDT=$$FMTE^XLFDT($$NOW^XLFDT,"5MZ")
 ;
 S LREND=0
 S DIC="^LRO(68,",DIC(0)="AEMOQ"
 D ^DIC S LRAA=+Y,LRNAME=$P(Y,U,2)
 I LRAA<1 D LREND Q
 ;
 ; Ask if list by date rather than accession number
 I $P(^LRO(68,LRAA,0),U,3)="Y" D STAR^LRWU3 S LRLAST=$G(LAST)
 I LREND D LREND Q
 ; List by accession number
 I '$D(LRSTAR) D PHD
 I LREND D LREND Q
 ;
W ; from LRVER, LRVR
 ; Added to protect "%*" variables from %ZTLOAD corruption
 N %,%A,%A0,%B,%B1,%B2,%B3,%BA,%BU,%C,%D1,%D2,%DT,%E,%G,%H,%I,%J
 N %J1,%K,%M,%N,%P,%S,%T,%W,%W0,%X,%Y
 N A0,C,D,DD,DDH,DDQ,DDSV,DG,DH,DIC,DIFLD,DIR,DIRO,DIROUT,DIRUT
 N DIX,DIY,DISYS,DO,DP,DQ,DTOUT,DU,DZ,X1,XQH
 ;
 I '$D(^LRO(68,LRAA,1,LRAD,1,0)),'$D(LRSTAR) D LREND Q
 ;
 S (LRUNC,LRTSE)=0
 S:'$D(LRNAME) LRNAME=$P(^LRO(68,LRAA,0),U,1)
 ;
 S DIR(0)="YO",DIR("A")="Do you want a specific test",DIR("B")="NO"
 D ^DIR
 I $D(DIRUT) D LREND Q
 I Y=1 D
 . N DIC,X,Y
 . S DIC="^LAB(60,",DIC(0)="AEZOQ"
 . D ^DIC
 . I Y>0 S LRTSE=+Y
 ;
 K DIR
 S DIR(0)="YO",DIR("A")="Do you want only incomplete entries",DIR("B")="YES"
 D ^DIR
 I $D(DIRUT) D LREND Q
 S LRUNC=Y
 ;
 S %ZIS="Q" D ^%ZIS
 I POP D ^%ZISC,LREND Q
 ;
 ; Queue report via Taskman
 I $D(IO("Q")) D  Q
 . N ZTDESC,ZTSK,ZTRTN,ZTIO,ZTSAVE,%T
 . S ZTRTN="ENT^LRWRKLST",ZTDESC="Long form accession list",ZTSAVE("LR*")=""
 . D ^%ZTLOAD,^%ZISC
 . W !,"Task ",$S($G(ZTSK):ZTSK,1:"NOT")," Queued"
 . D LREND K IO("Q")
 ;
ENT ;
 ;
 N LRTST
 ;
 I $D(ZTQUEUED) S ZTREQ="@"
 S (LREND,LRSTOP)=0
 ;
 ;
 U IO
 D HED,URG^LRX
 ;
 ; Process by accession date
 I '$D(LRSTAR) D
 . S LRAN=LRFAN-1
 . F  S LRAN=$O(^LRO(68,LRAA,1,LRAD,1,LRAN)) Q:'LRAN!(LRAN>LRLAN)  D  Q:LRSTOP
 . . S LREND=0 D TD
 . . I LREND Q
 . . D LST,TESTS
 ;
 ; Process by date received in lab - yearly accession area
 I $D(LRSTAR) D
 . F  S LRAD=$O(^LRO(68,LRAA,1,LRAD)) Q:LRAD<1!(LRAD>LRWDTL)  D AC  Q:LRSTOP
 ;
 D ^%ZISC,LREND
 Q
 ;
 ;
TD ; Check tests on accession to determine if meets criteria to display.
 ; If incomplete only (LRUNC=1) and complete date then skip
 ; If not specific test selected (LRTSE=file #60 ien) then skip
 ; Otherwise set LRTST array with file #60 ien.
 ;
 K LRTST
 ;
 I '$D(^LRO(68,LRAA,1,LRAD,1,LRAN,0)) S LREND=1 Q
 S LRSN=+$P(^LRO(68,LRAA,1,LRAD,1,LRAN,0),U,5),LRDAT=+$P(^(0),U,4)
 S LRI=0
 F  S LRI=$O(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRI)) Q:LRI<.5  D
 . I LRTSE,LRTSE'=+^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRI,0) Q
 . I LRUNC,$P(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRI,0),"^",5) Q
 . S LRTST(LRI)=""
 ;
 I '$D(LRTST) S LREND=1
 Q
 ;
 ;
TESTS ;
 N S1,S2
 ;
 D CHKPAGE^LRWRKLS1
 Q:LRSTOP!LREND
 ;
 Q:'$D(^LRO(68,LRAA,1,LRAD,1,LRAN,4,0))
 ;
 S LRSPEC=+$G(^LRO(68,LRAA,1,LRAD,1,LRAN,5,1,0)),LRSAMP=$S(LRSPEC:$P(^(0),U,2),1:"")
 S S1=$P($G(^LAB(61,+LRSPEC,0)),U,1)
 S S2=$P($G(^LAB(62,+LRSAMP,0)),U,1)
 ;
 W !,"  SAMPLE: ",S1_$S(S1'=S2:"  "_S2,1:"")
 S LN=LN+1
 ;
 S LRLO69=$G(^LRO(69,LRDAT,1,LRSN,0))
 I LRLO69'="",$D(^LRO(69,LRDAT,1,LRSN,1)),$L($P(^(1),U,6)) W !,$P(^(1),U,6) S LN=LN+1
 ;
 K LRNAC
 S LRI=0
 F  S LRI=$O(LRTST(LRI)) Q:'LRI  D TS2
 ;
 I '$D(LRNAC),$L($P($G(^LRO(68,LRAA,1,LRAD,1,LRAN,3)),U,4)) D
 . W !,"ALL COMPLETED",!!
 . S LN=LN+3
 Q
 ;
 ;
TS2 ;
 ;
 D CHKPAGE^LRWRKLS1
 Q:LRSTOP!LREND
 ;
 S LRXXX=$G(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRI,0)),LRURG=+$P(LRXXX,U,2)
 W !,"  TEST: ",$P($G(^LAB(60,+LRXXX,0),"deleted test"),"^")
 S LN=LN+1
 ;
 W ?40,$S($D(LRURG(LRURG)):LRURG(LRURG),1:"")
 I $P(LRXXX,U,3)'="" W ?55," LIST: ",$P($G(^LRO(68.2,+$P(LRXXX,U,3),0)),U,1)," ",$P($P(LRXXX,U,3),";",2,3)
 ;
 I $D(^LRO(69,LRDAT,1,LRSN,2,"B",LRI)) D
 . N I,X
 . S X=$O(^LRO(69,LRDAT,1,LRSN,2,"B",LRI,0))
 . I X,$O(^LRO(69,LRDAT,1,LRSN,2,X,1,0)) D
 . . S I=0
 . . F  S I=$O(^LRO(69,LRDAT,1,LRSN,2,X,1,I)) Q:I<1  W !?3,": "_^(I,0)
 ;
 D REF
 ;
 I $P(LRXXX,U,5) W !,"  COMPLETED: ",$$FMTE^XLFDT($P(LRXXX,U,5),"MZ") S LN=LN+1
 E  S LRNAC=""
 Q
 ;
 ;
REF ; if referred test, display status and manifest
 ;
 N LRDFN,LRDN,LREVNT,LRIDT,LRIENS,LRMAN,LRSCFG,LRSS,LRUID,LRY
 ;
 S LRUID=$P($G(^LRO(68,LRAA,1,LRAD,1,LRAN,.3)),"^")  Q:LRUID=""
 S LRMAN=$P(LRXXX,"^",10),LRSCFG=""
 I LRMAN D
 . S LRSCFG=$P($G(^LAHM(62.8,LRMAN,0)),"^",2)
 . I LRSCFG S LRSCFG(0)=$G(^LAHM(62.9,LRSCFG,0),"Unknown/deleted")
 . S LRMAN=$P($G(^LAHM(62.8,LRMAN,0)),"^")
 S LREVNT=$$STATUS^LREVENT(LRUID,+LRXXX,LRMAN)
 I LREVNT'="" D
 . W !,?4,"REFERRAL STATUS..: "_$P(LREVNT,"^")_" ("_$P(LREVNT,"^",2)_")"
 . W !,?4,"SHIPPING MANIFEST: "_$P(LREVNT,"^",3)
 . S LN=LN+2
 . I LRSCFG D
 . . W " using shipping config "_$P(LRSCFG(0),"^")
 . . W !,?4,"SHIPPED TO.......: "_$P($$NS^XUAF4($P(LRSCFG(0),"^",3)),"^")
 . . S LN=LN+1
 ;
 ; Display external order info (placer/filler) if any.
 S LRDFN=+LRDX
 S LRY=$G(^LRO(68,LRAA,1,LRAD,1,LRAN,3))
 S LRIDT=$P(LRY,"^",5),LRSS=$P($G(^LRO(68,LRAA,0)),"^",2)
 S LRDN=0,LRTEST=+LRXXX
 I LRSS="CH" D LR60DN(.LRDN,LRTEST,.LRTST)
 ;
 S LRDN=0
 F  S LRDN=$O(LRDN(LRDN)) Q:LRDN<1  D
 . S LRIENS=LRDFN_","_LRSS_","_LRIDT_","_LRDN
 . F LRTYPE=3,4 I $D(^LR(LRDFN,"EPR","AD",LRIENS,LRTYPE)) D
 . . N LRDATA,LRON,LRREF,LRJ
 . . S LRJ=$O(^LR(LRDFN,"EPR","AD",LRIENS,LRTYPE,0)),LRREF=LRJ_","_LRDFN_","
 . . D GETDATA^LRUEPR(.LRDATA,LRREF)
 . . S LRON=$G(LRDATA(63.00013,LRREF,1,"I")),LRON(0)="Unknown"
 . . I LRON="" Q
 . . I $P($G(LRDATA(63.00013,LRREF,.03,"I")),";",2)="DIC(4," S LRON(0)=$P($$NS^XUAF4(+LRDATA(63.00013,LRREF,.03,"I")),"^")
 . . W !,?4,LRON(0)_$S(LRTYPE=3:" placer",1:" filler")_" order # "_LRON
 ;
 Q
 ;
 ;
PHD ;
 Q:LREND
 S LREND=0,U="^"
 D ADATE^LRWU Q:LREND
 D LRAN^LRWU3
 Q
 ;
LST ;
 D HED:($E(IOST)="P"&($Y+11>IOSL)),LST1^LRWRKLS1
 Q
 ;
HED ;
 W @IOF,!,"LONG FORM",?30,"NOT FOR WARD USE",!
 W "Accession Area: ",LRNAME,?40,LRDT,!!
 S LN=4
 Q
 ;
AC ;
 I LRSTOP!LREND Q
 ;
 S LRTK=LRSTAR-.00001
 F  S LRTK=$O(^LRO(68,LRAA,1,LRAD,1,"E",LRTK)) Q:LRTK<1!(LRTK\1>LRLAST)  D  Q:LRSTOP
 . S LRAN=0
 . F  S LRAN=$O(^LRO(68,LRAA,1,LRAD,1,"E",LRTK,LRAN)) Q:LRAN<1!(LRSTOP)  D
 . . I '$D(^LRO(68,LRAA,1,LRAD,1,LRAN,0)) Q
 . . S LREND=0 D TD
 . . I LREND Q
 . . D LST,TESTS
 Q
 ;
 ;
LREND ;
 D KVAR^VADPT
 K %,%DT,%ZIS
 K LN,LRA,AGE,DFN,DIC,DIR,DIRUT,DOB,DTOUT,DUOUT,K,LAST
 K LRACC,LRDLA,LRDLC,LRDX,LRI,LRLO69,LRSAMP,LRSPEC
 K LRURG,LRWRD,LRACO,DIC,LRUNC,LRDAT,LRAA,LRAD
 K LRNAC,LRAN,LRCE,LRDPF,LRSN,LRDTO,LRLAST,LRPRAC,LRSTAR,LRXXX
 K LRB,LRLAN,LRDT,LREND,LRFAN,LRIX,LRNAME,LRTSE,LRTST
 K LRDFN,LREDT,LRLLOC,LRSDT,LRTK,LRWDTL,POP,LRSTOP
 K PNM,SEX,SSN,X,X1,X2,Y,Z,ZTSK
 Q
 ;
 ;
EN ;
SINGLE ;
 ;
 N LRAA,LRACC,LRAD,LRAN,LREND,LRSTOP,LRTSE,LRUNC,LRURG
 ;
 D URG^LRX
 ;
 F  D  Q:LREND!LRSTOP
 . S (LREND,LRUNC,LRSTOP,LRTSE)=0
 . S LRACC="" D ^LRWU4
 . I LRAN<1 S LREND=1 Q
 . I '$D(^LRO(68,LRAA,1,LRAD,1,LRAN,0)) W !,"Doesn't exist." Q
 . D TD,LST1^LRWRKLS1,TESTS
 . W !
 ;
 D LREND
 Q
 ;
 ;
LR60DN(LRDN,LR60,LRTST) ; Retreive CH subscript dataname for a test
 N LRX,LRY
 ;
 S LRX=$P($G(^LAB(60,LR60,.2)),"^")
 I LRX>0 S LRDN(LRX)="" Q
 ;
 ; Expand and check panel tests
 S LRY=0
 F  S LRY=$O(^LAB(60,LR60,2,LRY)) Q:LRY<1  D
 . S LRY(0)=$P($G(^LAB(60,LR60,2,LRY,0)),"^")
 . I LRY(0)<1 Q
 . I $D(LRTST(LRY(0))) Q  ; test on panel also on accession as individual test
 . D LR60DN(.LRDN,LRY(0))
 ;
 Q
