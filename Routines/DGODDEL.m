DGODDEL ;ALB/EG - PURGE DISCRETIONARY WORKLOAD ; APR 24, 1989
 ;;5.3;Registration;;Aug 13, 1993
 W !!,*7,"DISCRETIONARY WORKLOAD OPTIONS ARE NO LONGER AVAILABLE!",!! Q
 ;;V 4.5
EN S DGDB=0,U="^" R !,"Purge single (M)onth or (A)ll or (^ to quit): MONTH// ",DGQQ:DTIME G:'$T END S DGQQ=$S(DGQQ'="":$E(DGQQ,1,1),1:"M") I DGQQ="?" D HLP G EN
 Q:"Q^"[DGQQ  I "MA"'[DGQQ W *7 G END
 I DGQQ="A" D BG G:%=2 END W !,?1,"SITE",?10,"REPORT",?20,"MONTH/YR",?30,"RUN DATE",! D:%=1 DST
 I DGQQ="M" D STH Q:Y<0  D BG G:%=2 END W !,?1,"SITE",?10,"REPORT",?20,"MONTH/YR",?30,"RUN DATE",! S DGDT=Y D:(%=1) D0
END W:DGDB=0 !,"Nothing purged, all your data is current"
 K DGA,DGDA,DGDB,DGDT,DGDV,DGI,DGJ,DGK,DGQQ,DGREP,DIC,DIC(0),DIC("S")
 Q
DST S DGDT="" F DGA=0:0 S DGDT=$O(^VAT(408,"AE",DGDT)) Q:DGDT=""  D D0
 Q
D0 Q:$D(^VAT(408,"AD",1,DGDT))>0  S DGDV="" F DGI=0:0 S DGDV=$O(^VAT(408,"AE",DGDT,DGDV)) Q:DGDV=""  D D1
 Q
D1 S DGREP="" F DGJ=0:0 S DGREP=$O(^VAT(408,"AE",DGDT,DGDV,DGREP)) Q:DGREP=""  D D2
 Q
D2 S DGDA="" F DGK=0:0 S DGDA=$O(^VAT(408,"AE",DGDT,DGDV,DGREP,DGDA)) Q:DGDA=""  I $O(^VAT(408,"AE",DGDT,DGDV,DGREP,DGDA))'="" D D3
 Q
D3 ;does deletion using ^DIK
 W !,?1,DGDV,?10,DGREP,?20,DGDT,?30,DGDA
 S DGDB=1,DIK="^VAT(408,",DA=DGDA D ^DIK K DIK,DA W ?50,"...deleted"
 Q
STH ;select entries to purge
 S U="^",DIC="^VAT(408,",DIC(0)="AEM",D="C",DZ="?" D DQ^DICQ K DO
 S %DT="PANE",%DT("A")="Select MONTH/YEAR to PURGE: " D ^%DT
 Q:Y<0
 I (+$E(Y,6,7)>0)!($D(^VAT(408,"C",Y))=0) W !!,*7,"SELECT ENTRY FROM LIST IN MONTH/YEAR FORMAT.",!,"IF JANUARY 1988 WAS LISTED YOU WOULD ENTER 01/88",! G STH
 Q
BG S %=2 W !,"ARE YOU SURE YOU WISH TO PURGE YOUR FILE " D YN^DICN S:(%<0)!(%=2) %=2
 Q
HLP ;
 F I=0:1 Q:$F($T(HLPT+I),";;")=0  W !,$P($T(HLPT+I),";;",2)
 Q
HLPT ;;MONTHLY will allow you to select a specific MONTH/YR to purge
 ;;ALL will purge your entire file, leaving only the most recent
 ;;generation for each month.
 ;;
 ;;This option will allow you to purge entries in your file up to but
 ;;not including your most recent.  If you have generated OCT 88 in
 ;;Nov, Dec, and Jan you will have 3 entries in your file corresponding
 ;;to OCT workload.  Say you generate OCT again in Feb 89 and purge
 ;;by using this option, Nov through Jan will be purged and you will
 ;;only have the most recent run remaining.  We recommend the use of
 ;;this option to keep your files small and tidy.
 ;;
