QAPSTAT1 ;557/THM-SURVEY GENERATOR STATISTICS, PART 2 [ 08/28/95  2:16 PM ]
 ;;2.0;Survey Generator;;Jun 20, 1995
 Q  ;enter properly
 ;
PRINT K ^TMP($J),TOTPART,TOTANS
 U IO S (QAPOUT,PG,TOTPART,TOTANS)=0
 S BANNER="S T A T I S T I C S"
 S QAPDATE=$E(DT,4,5)_"/"_$E(DT,6,7)_"/"_$E(DT,2,3),$P(LINE,"-",IOM)="",QAPDATE=$E(DT,4,5)_"/"_$E(DT,6,7)_"/"_$E(DT,2,3)
 I IOST?1"P-".E!(IOST?1"PK-".E) S TOF="I $Y>(IOSL-8) W !!,""Continued on next page"",! D HDR Q:$D(DIRUT)"
 I IOST?1"C-".E S TOF="I $Y>(IOSL-4) D PAUSE Q:$D(DIRUT)  D HDR"
 S SITE=$P($$SITE^VASITE,U),SITE=$P($G(^DIC(4,+SITE,0)),U,1),SITE=$S(+SITE>10000:"",1:"V A Medical Center ")_SITE ;is a VA hosp or other?
 F PART=0:0 S PART=$O(^QA(748.3,"B",SURVEY,PART)) Q:PART=""  I $P(^QA(748.3,PART,0),U,3)="c" DO  S TOTPART=TOTPART+1,LPART=PART,^TMP($J,"QAPZ",PART)="" ;only completed responses
 .F QNUM=0:0 S QNUM=$O(^QA(748.3,PART,1,QNUM)) Q:QNUM=""!(+QNUM=0)  S ANS=$P(^QA(748.3,PART,1,QNUM,0),U,2) DO
 ..I ANS="",$O(^QA(748.3,PART,1,QNUM,0))="" Q  ;aborted WP response
 ..I ANS="",$O(^QA(748.3,PART,1,QNUM,0))]"" S ^TMP($J,QNUM,"WP")="WP"_U_QNUM Q
 ..I ANS]"" S:'$D(^TMP($J,QNUM,ANS)) ^TMP($J,QNUM,ANS)="0^" S $P(^TMP($J,QNUM,ANS),U,1)=$P(^TMP($J,QNUM,ANS),U,1)+1,PQUES=$P(^QA(748.3,PART,1,QNUM,0),U) ;PQUES is the question pointer
 ..K ^XTMP($J) S (ANSX,CNTR)=0 F  S ANSX=$O(^QA(748.25,SURVEY,1,PQUES,3,ANSX)) Q:ANSX=""!(+ANSX=0)  S CNTR=CNTR+1,^XTMP($J,SURVEY,1,PQUES,3,CNTR,0)=^QA(748.25,SURVEY,1,PQUES,3,ANSX,0) ;put in answer order to compare
 ..I +ANS>0 S $P(^TMP($J,QNUM,ANS),U,2)=$S($P($G(^XTMP($J,SURVEY,1,PQUES,3,ANS,0)),U)]"":$P(^(0),U),1:ANS)
 ..I +ANS=0 S $P(^TMP($J,QNUM,ANS),U,2)=$S($P($G(^XTMP($J,SURVEY,1,PQUES,3,($A(ANS)-96),0)),U)]"":$P(^(0),U),1:ANS)
 ;LPART is the ifn of the last participant examined.  It is kept
 ;as a link to file 748.3
 I TOTPART=0 D HDR W !!!?20,"No one has yet participated in this survey.",! D:IOST?1"C-".E PAUSE G EXIT
 ;print the question
 D HDR F DISP=0:0 S DISP=$O(^QA(748.25,"E",SURVEY,DISP)) Q:DISP=""!($D(DIRUT))  F QNUM=0:0 S QNUM=$O(^QA(748.25,"E",SURVEY,DISP,QNUM)) Q:QNUM=""  DO
 .W ! X TOF W ! X TOF
 .W DISP,".  " F I=0:0 S I=$O(^QA(748.25,SURVEY,1,QNUM,2,I)) D:I=""!(+I=0)  Q:I=""!(+I=0)!($D(DIRUT))  S X=$P(^QA(748.25,SURVEY,1,QNUM,2,I,0),U,1) W X,! X TOF
 ..S ANSTYPE=$P(^QA(748.25,SURVEY,1,QNUM,0),U,3),GRADIENT=$P(^(0),U,4) I ANSTYPE="l" S QUES=QNUM D LIKRTLAB^QAPCHX W ! K QUES
 ..S QUES=$O(^QA(748.3,LPART,1,"B",QNUM,0)) Q:QUES=""!($D(DIRUT))  W ! X TOF
 ..S ANS="" F  S ANS=$O(^TMP($J,QUES,ANS)) Q:ANS=""!($D(DIRUT))  S DTA=$G(^TMP($J,QUES,ANS)) Q:DTA=""  S TOTANS=$P(DTA,U,1),ANSTEXT=$P(^TMP($J,QUES,ANS),U,2) DO
 ...;reduce participants by # of skipped or n/a questions
 ...S BLANKS=0 I BYPASS=2,ANS'=" " S BLANKS=+$P($G(^TMP($J,QUES," ")),U,1),TOTPART=TOTPART-BLANKS
 ...S BLANKNA=0 I BYPASSNA=2,ANS'="NA" S BLANKNA=+$P($G(^TMP($J,QUES,"NA")),U,1),TOTPART=TOTPART-BLANKNA
 ...I ANS="WP" S QUES1=$P(DTA,U,2) D WP Q
 ...I ANSTEXT]"","^ ^T^F^Y^N^NA^"[ANS S ANSTEXT=$S(ANS="NA":"Not applicable",ANS="T":"True",ANS="F":"False",ANS="Y":"Yes",ANS="N":"No",ANS=" ":"did not respond",1:"???")
 ...S PCNT=0 I TOTPART>0 S PCNT=$J((TOTANS/TOTPART)*100,4,1)
 ...S RESPD=" participant"_$S(TOTANS=1:"",1:"s")
 ...W ?9,TOTANS,$S(ANS=" "&(BYPASS=2):RESPD_" ",ANS="NA"&(BYPASSNA=2):RESPD_" ",1:" or "_PCNT_"% "),$S(ANS'=" ":"responded ",1:""),ANSTEXT,! X TOF
 ...I BYPASS=2,ANS'=" " S TOTPART=TOTPART+BLANKS ;add back skipped questions
 ...I BYPASSNA=2,ANS'="NA" S TOTPART=TOTPART+BLANKNA ;add back NA questions
 I '$D(DIRUT),IOST?1"C-".E K DIR,DIRUT S DIR(0)="E" D ^DIR
 ;
EXIT K ^XTMP($J),ANSX,CNTR G EXIT^QAPUTIL
 ;
WP ;WP responses
 I $D(WPPRT),WPPRT=2 Q
 F PART1=0:0 S PART1=$O(^TMP($J,"QAPZ",PART1)) Q:PART1=""!($D(DIRUT))  W:$O(^QA(748.3,PART1,1,QUES1,1,0))]"" !?3,"----------",! X TOF DO
 .F QZ=0:0 S QZ=$O(^QA(748.3,PART1,1,QUES1,1,QZ)) Q:QZ=""!($D(DIRUT))  S QY=^QA(748.3,PART1,1,QUES1,1,QZ,0) W ?3,QY,! X TOF
 Q
 ;
HDR S PG=PG+1 W:PG>1!(IOST?1"C-".E) @IOF W !,QAPDATE,?(IOM-$L(TITLE)\2),TITLE,?(IOM-12),"Page: ",PG,!,?(IOM-$L(SITE)\2),SITE,!,?(IOM-$L(BANNER)\2),BANNER,!
 W:PG=1 !,"Total responses: ",TOTPART,?49,$S(BYPASSNA=2:"Not including",1:"Including")_" 'NA' answers",!?49,$S(BYPASS=2:"Not including",1:"Including")_" bypassed answers"
 W !,LINE,!
 Q
 ;
PAUSE I IOST?1"C-".E W ! K DIR,DIRUT S DIR(0)="E" D ^DIR Q:$D(DIRUT)
 Q
