LRGP1 ;DALOI/CJS/RWF - COMMON PARTS TO INSTRUMENT GROUP VERIFY/CHECK ;5/13/03  13:21
 ;;5.2;LAB SERVICE;**112,269,286**;Sep 27, 1994
 ;
 N %DT,%ZIS,DIC,I,J
 ;
 S LRWT="",LREND=0
 S LRTM60=9999999-$$HTFM^XLFDT($H-$P($G(^LAB(69.9,1,0)),U,7),1)
 ;
 S DIC="^LRO(68.2,",DIC(0)="AEMZQ" D ^DIC
 I Y<1 D LREND Q
 S LRLL=+Y,LRWT=$P(Y(0),U,8),LRMAXCUP=$P(Y(0),U,4)
 ;
 S LRPROF=$O(^LRO(68.2,LRLL,10,0))
 I LRPROF<1 W !,"No profile defined." D LREND Q
 ; If multiple profile then ask which profile
 S B=$O(^LRO(68.2,LRLL,10,LRPROF))
 I B>0 S DIC="^LRO(68.2,"_LRLL_",10," D ^DIC G LREND:Y<1 S LRPROF=+Y
 S LRPANEL=$P(^LRO(68.2,LRLL,10,LRPROF,0),U,1),LRLIST=$O(^LRO(68.2,LRLL,1,LRPROF,1,0))
 ;
 W !
 ;
 ; Select performing laboratory to use
 I '$D(LRGVP) D
 . N X,LRX
 . S X=$P(^LRO(68.2,LRLL,10,LRPROF,0),"^",5)
 . S LRX=$$SELPL^LRVERA($S(X:X,1:DUZ(2)))
 . I LRX<1 D LREND Q
 . I LRX,LRX'=DUZ(2) S LRDUZ(2)=LRX
 ;
 D EXPLODE
 I $O(LRVTS(0))<1 D LREND Q
 ;
 S I=0
 F  S I=$O(LRORD(I)) Q:I<1  S J=LRORD(I),X=$P(^LAB(60,J,0),U,5),LRORD(I)=$P(X,";",2)
 ;
 K LRAA
 I $L($P(^LRO(68.2,LRLL,10,LRPROF,0),U,2)) S LRAA=$P(^(0),U,2),LRNAME=$P(^LRO(68,LRAA,0),U,1)
 ;
 I '$D(LRAA) D  Q:LRAA<1
 . S DIC="^LRO(68,",DIC(0)="AEMOQ"
 . D ^DIC
 . S LRAA=+Y,LRNAME=$P(Y,U,2)
 . I LRAA<1 D LREND
 I $P(LRPARAM,U,14),$P($G(^LRO(68,LRAA,0)),U,16) D AUTO^LRCAPV
 I LREND Q
 ;
 ; If "VERIFY BY" field empty then ask user
 I LRWT="" D  Q:LREND
 . N DA,DIR,DIRUT,DTOUT,DUOUT,X,Y
 . S DIR(0)="68.2,.08"
 . D ^DIR
 . I $D(DIRUT) D LREND Q
 . S LRWT=Y
 ;
 D ACC:LRWT="A",TRAY:LRWT="T",MACHSQ:LRWT="M",WRKLST:LRWT="W"
 Q
 ;
 ;
LREND ;
 S LREND=1
 Q
 ;
 ;
ACC ; Select accession date to verify
 ;
 N %DT,LRLAN
 ;
 S LRVBY=1
 ; Only ask if verifying, not group printing (LRGP)
 I '$D(LRGVP) D
 . S LRVBY=$$SELBY^LRWU4("Verify by")
 . I LRVBY=0 D LREND
 I LREND Q
 I LRVBY=2 Q
 ;
 ; Select accession date
 D ADATE^LRWU
 I LREND Q
 ;
 ; Select starting and ending accession numbers
 D LRAN^LRWU3
 I LREND Q
 S LRFAN=LRFAN-1,LRLIX=LRLAN
 Q
 ;
 ;
TRAY ; Select starting and ending tray/cup
 ;
 N DIR,DIRUT,DTOUT,DUOUT,X,Y
 ;
 ; Find existing first and last trays on loadlist
 S LRFTRAY=$O(^LRO(68.2,LRLL,1,0))
 I 'LRFTRAY S LRFTRAY=1
 S LRLTRAY=$O(^LRO(68.2,LRLL,1,""),-1)
 I 'LRLTRAY S LRLTRAY=LRFTRAY
 ;
 ; Find existing first and last cups on loadlist
 S LRFCUP=$O(^LRO(68.2,LRLL,1,LRFTRAY,1,0))
 I 'LRFCUP S LRFCUP=1
 S LRLCUP=$O(^LRO(68.2,LRLL,1,LRLTRAY,1,""),-1)
 I 'LRLCUP S LRLCUP=LRMAXCUP
 ;
 S DIR(0)="NO^1:9999999:0",DIR("A")="Starting tray",DIR("B")=1
 D ^DIR
 I $D(DIRUT) D LREND Q
 S LRFTRAY=Y
 ;
 S DIR(0)="NO^1:9999999:0",DIR("A")="Starting cup",DIR("B")=1
 D ^DIR
 I $D(DIRUT) D LREND Q
 S LRFCUP=Y
 ;
 S DIR(0)="NO^"_LRFTRAY_":"_LRLTRAY_":0",DIR("A")="Ending tray",DIR("B")=LRLTRAY
 D ^DIR
 I $D(DIRUT) D LREND Q
 S LRLTRAY=Y
 ;
 S DIR(0)="NO^"_LRFCUP_":"_LRLCUP_":0",DIR("A")="Ending cup",DIR("B")=LRLCUP
 D ^DIR
 I $D(DIRUT) D LREND Q
 S LRLCUP=Y
 ;
 Q
 ;
 ;
MACHSQ ; Select starting and ending machine sequence
 ;
 N DIR,DIRUT,DTOUT,DUOUT,X,Y
 ;
 S DIR(0)="NO^1:9999999:0",DIR("A")="Starting sequence number",DIR("B")=1
 D ^DIR
 I $D(DIRUT) D LREND Q
 S LRSQ=Y
 ;
 S DIR(0)="NO^1:9999999:0",DIR("A")="Ending sequence number",DIR("B")=9999999
 D ^DIR
 I $D(DIRUT) D LREND Q
 S LRESEQ=Y
 Q
 ;
 ;
WRKLST ; Select starting and ending worklist numbers
 ;
 N DIR,DIRUT,DTOUT,DUOUT,X,Y
 ;
 S DIR(0)="NO^1:9999999:0",DIR("A")="Starting worklist number",DIR("B")=1
 D ^DIR
 I $D(DIRUT) D LREND Q
 S LRCUP=Y
 ;
 S DIR(0)="NO^1:9999999:0",DIR("A")="Ending worklist number",DIR("B")=9999999
 D ^DIR
 I $D(DIRUT) D LREND Q
 S LRECUP=Y
 Q
 ;
 ;
EXPLODE ;
 K LRORD
 D EXPLODE^LRGP2
 Q
