YSCEN41 ;ALB/ASF-TEST LOOKUP CONT ;4/3/90  10:31 ;
 ;;5.01;MENTAL HEALTH;**37**;Dec 30, 1994
EN ;
 W !?5 I '$D(^YTD(601.2,YSDFN,1,"B")) W " NO PSYCHOLOGICAL TESTS OR INTERVIEWS HAVE BEEN COMPLETED",! Q
TLST ;
 D TESTS,N,REC2 K YSDOT,F1,F2,F5,I,J,K,M,N,YSNT,YSTLST,YSTY,X,Y Q
N ;
 S A="" F  S A=$O(YSTLST(A)) Q:A'?3ANP.E  W:$X+7>IOM ! W $J(A,5)," ",YSTLST(A)
 K YSTLST W ! Q
YSDOT ;
 W $$FMTE^XLFDT(YSDOT,"5ZD")," "
 Q
DTS ;
 S YSDOT=0
DT0 ;
 S YSDOT=$O(^MR(YSDFN,M,"B",YSDOT)) I YSDOT D YSDOT G DT0
 Q
TESTS ;
 K YSTLST S ZZ=0 F  S ZZ=$O(^YTD(601.2,YSDFN,1,ZZ)) Q:'ZZ  S J=0 F  S J=$O(^YTD(601.2,YSDFN,1,ZZ,1,J)) Q:'J  I $D(^(J,1)) S A=$P($G(^YTT(601,ZZ,0)),U) S:A]"" YSTLST(A)=$$FMTE^XLFDT(J,"5ZD")
 Q
 ;
REC ;
 S X="T-45" D ^%DT S YSRD=Y F YSTY="YT","YI" D TESTS
 W !?9,"RECENT TESTS:  " S (F2,F1)=0
 S F5="" F  S F5=$O(YSTLST(F5)) Q:F5'?3ANP.E  S F1=0 D REC1
 W:'F2 " NONE  " D REC2 Q
REC1 ;
 F K=1:1 S X=$P(YSTLST(F5)," ",K) Q:X=""  D ^%DT IF YSRD<Y W:'F1 F5 S F1=1,F2=1 W " ",X,"  " W:$X>69 !?11
 Q
REC2 ;
 I $D(^PTX(YSDFN,"HX"))>1 W "LAST Hx " S YSDOT=$O(^PTX(YSDFN,"HX",0)) I YSDOT S YSDOT=9999999-YSDOT D YSDOT
 I $D(^MR(YSDFN,"PE","B"))>1 W "PHYSICAL  " S M="PE" D DTS
 I $D(^PTX(YSDFN,"PN"))>1 W "LAST P. NOTE " I $D(^("PN",0))#2 S YSDOT=$O(^PTX(YSDFN,"PN",0)) I YSDOT S YSDOT=9999999-YSDOT D YSDOT
 Q
INS ;
 W @IOF,! F ZZ=0:1 S X=$T(Z+ZZ) Q:X=""  W !,$P(X,";;",2)
 G CH^YSCEN4
Z ;;   INPATIENT TEST LOOK UP OPTIONS
 ;;
 ;;   This option searches all patients on a ward by team.
 ;;If ALL TESTS are selected all administrations are displayed.
 ;;If RECENT TESTS are selected only administrations within the past 45 days
 ;; are displayed.
 ;;
 ;;If either CUSTOM or STANDARD batteries are selected, the names and a running
 ;;count of these patients are displayed. Test NAMES are printed
 ;;out (whether there was an actual test administration or not). An XXXXXXXX
 ;;indicates no completion was found. You may enter as many
 ;;tests or interviews as you like. Enter test one at a time without
 ;;punctuation.
 ;;
 ;;Administration dates are also displayed. If only the last date is selected
 ;;(optional) the last administration date is displayed along with a letter.
 ;;This letter denotes the number of times a particular test was completed
 ;;by the patient. An 'a' indicates only one test completion was found
 ;;while an 'e' indicates 5 test completions.
 ;;If all dates are selected the date of each administration will be shown.
 ;;
