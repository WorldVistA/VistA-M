LRMINEW2 ;DALOI/STAFF - NEW DATA TO BE REVIEWED/VERIFIED ;Nov 10, 2008
 ;;5.2;LAB SERVICE;**350**;Sep 27, 1994;Build 230
 ;
Q2 ;
 ;
 N DIR,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="Y",DIR("B")="YES"
 S DIR("?")="Answer ""NO"" if  you want to look at it now!"
 S DIR("?",1)="Answer ""YES"" to queue printing"
 S DIR("A")="Do you want to queue the data to print and review/approve it later"
 D ^DIR
 I $D(DIRUT) Q
 I Y=1 S %ZIS="MQ",%ZIS("B")="",IOP="Q"
 W ! S ZTRTN="DQ^LRMINEW2" D IO^LRWU
 Q
 ;
 ;
DQ ;
 ;
 N LRAN,LRLOCA,LRPG
 U IO K ^TMP($J) S LREND=0,LRONETST="",LRONESPC=""
 S LRAN=0
 F  S LRAN=+$O(^LRO(68,LRAA,1,LRAD,"AC",LRSB,LRAN)) Q:LRAN<1!($G(LREND))  D:+^(LRAN)=LRDXZ!(LRDXZ=0) SORT
 S LRLOCA="",LRPG=1
 F  S LRLOCA=$O(^TMP($J,LRLOCA)) Q:LRLOCA=""!($G(LREND))  D
 . S LRLTR=$E(LRLOCA,1,4),LRPG=1
 . W @IOF I $E(IOST,1,2)'="C-" D ^LRLTR
 . S LRAN=0
 . F  S LRAN=+$O(^TMP($J,LRLOCA,LRAN)) Q:LRAN<1!($G(LREND))  D SENDUP Q:LREND
 ;
 K ^TMP($J),LRWRDVEW
 ;
 I $D(ZTQUEUED) S ZTREQ="@"
 Q
 ;
 ;
SORT ;
 Q:'$D(^LRO(68,LRAA,1,LRAD,1,LRAN,0))  S LRLOCA=$P(^(0),U,7)
 I LRLOCA'="" S ^TMP($J,LRLOCA,LRAN)=""
 Q
 ;
 ;
SENDUP ;
 Q:'$D(^LRO(68,LRAA,1,LRAD,1,LRAN,3))!($G(LREND))  S LRIDT=9999999-^(3),LRDFN=+^(0)
 S LRLLT=^LR(LRDFN,"MI",LRIDT,0),LRACC=$P(LRLLT,U,6),LRCMNT=$S($D(^(99)):^(99),1:"")
 D EN^LRMIPSZ1
 I $E(IOST,1,2)'="C-" W @IOF
 Q
