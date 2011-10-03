LRMIZAP ;SLC/BA - MICRO CONVERSION ; 8/5/87  18:18 ;
 ;;5.2;LAB SERVICE;;Sep 27, 1994
 ;Only to be used once for conversion of version 2 or version 3 lab to version 4
ZAP S U="^",(LREND,LRDFN)=0 I $O(^TMP("LRMIZAP",0)) S J=$O(^TMP("LRMIZAP",0)),LRDFN=$S($D(^TMP("LRMIZAP",J,"ZAP")):^("ZAP"),1:1)-1
 K ^TMP("LRMIZAP") D X I $D(^TMP("LRMIZAP")) D CONVERT
END I 'LREND W !!,"ALL DONE",!! I '$D(^TMP("LRMIZAP")) W "NOTHING NEEDED TO BE CHANGED",!
 K ^TMP("LRMIZAP"),%,B,C,C2,C4,C6,I,J,L,LRBN,LRBUGN,LRCHECK,LRCNT,LRDFN,LREND,LRIDT,LRINTP,LRISR,LRN,LRORIDE,LROVERR,LRRES,LRSUB,LRSUB1,N,T,X,Y
 Q
X S LRSUB=0 F I=0:0 S LRSUB=+$O(^LAB(62.06,LRSUB)) Q:LRSUB<1  I $D(^(LRSUB,0)) S LRN=$P(^(0),U,2),LRSUB1=0 F I=0:0 S LRSUB1=+$O(^LAB(62.06,LRSUB,1,LRSUB1)) Q:LRSUB1<1  I $D(^(LRSUB1,0)) S LRRES=$P(^(0),U),LRINTP=$P(^(0),U,2) D AC
 Q
AC I $O(^LAB(62.06,LRSUB,1,LRSUB1,0))<1,LRRES=LRINTP Q
 S ^TMP("LRMIZAP",$J,LRN,LRRES)=LRINTP
 I +$O(^LAB(62.06,LRSUB,1,LRSUB1,0))>0 S ^TMP("LRMIZAP",$J,LRN,LRRES)=LRINTP_U_"*"_U_LRSUB_U_LRSUB1
 Q
CONVERT I LRDFN W !!,"THE CONVERSION WILL PICKUP WHERE IT LEFT OFF",!,"STARTING WITH LRDFN ",LRDFN,! S L=LRDFN D XX^LRMIZAP1 Q
 W !,"If you are using the microbiology portion of the lab package to report",!,"microbiology results, you will need to run this conversion program",!,"in order to convert previous patient microbiology results to be compatible"
 W !,"with the current lab software.",!!,"The program will go thru all lab patients and make any needed changes.",!,"The lab patient number (LRDFN) will be displayed on every hundredth patient.",!,"If you must stop this program from running,"
 W " the next time it is started",!,"it will begin where it left off.  It will display 'ALL DONE' when finished."
 W !!,"THIS PROGRAM SHOULD BE RUN DURING OFF-HOURS.",!
 F I=0:0 W !!,"Do you wish to run this program" S %=2 D YN^DICN Q:%  W !,"Answer 'Y'es or 'N'o"
 I %'=1 S LREND=1 Q
 W !,"CONVERTING PATIENT DATA",! S L=LRDFN D XX^LRMIZAP1
 Q
UNZAP S U="^",(LREND,LRDFN)=0 I $O(^TMP("LRMIZAP",0)) S J=$O(^TMP("LRMIZAP",0)),LRDFN=$S($D(^TMP("LRMIZAP",J,"UNZAP")):^("UNZAP"),1:1)-1
 K ^TMP("LRMIZAP") D X I $D(^TMP("LRMIZAP")) W "CONVERTING PATIENT DATA",! W:LRDFN !,"STARTING WITH LRDFN ",LRDFN,! S L=LRDFN D ZZ^LRMIZAP1
 D END
 Q
XREF ;reindex the "AD" x-ref for micro accessions
 S U="^" W !,"This will reindex the cross reference used by the INFECTION CONTROL SURVEY." F I=0:0 W !,"Do you want to reindex" S %=2 D YN^DICN Q:%  W "  answer YES or NO"
 Q:%'=1  W !,"...THIS WILL TAKE AWHILE...",!
 S LRAA=0 F I=0:0 S LRAA=$O(^LRO(68,LRAA)) Q:LRAA<1  I $P(^(LRAA,0),U,2)="MI" S LRAD=0 F I=0:0 S LRAD=$O(^LRO(68,LRAA,1,LRAD)) Q:LRAD=""  K ^(LRAD,1,"AD") D SETAD
 K %,I,LRAA,LRAD,LRAN,LRTEST,LRTK
 Q
SETAD S LRAN=0 F I=0:0 S LRAN=$O(^LRO(68,LRAA,1,LRAD,1,LRAN)) Q:LRAN<1  S LRTEST=0 F I=0:0 S LRTEST=$O(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRTEST)) Q:LRTEST<1  S LRTK=$P(^(LRTEST,0),U,5) I $L(LRTK) S ^LRO(68,LRAA,1,LRAD,1,"AD",LRTK\1,LRAN)=""
 Q
