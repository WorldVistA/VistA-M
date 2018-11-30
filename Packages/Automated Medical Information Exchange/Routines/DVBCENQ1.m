DVBCENQ1 ;ALB/GTS,557/THM - 2507 INQUIRY DISPLAY ; 10/14/2009  1:00 PM
 ;;2.7;AMIE;**17,57,143,149**;Apr 10, 1995;Build 16
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 G START
CON K OUT I IOST?1"C-".E W !,"Press [RETURN] to continue or ""^"" to stop   " R ANS:DTIME S:ANS=U!('$T) OUT=1 Q:$D(OUT)  D HDR
 I IOST?1"P-".E,$Y>45 W @IOF D HDR
 Q
 ;
START S PGHD="COMPENSATION AND PENSION EXAM INQUIRY",PG=0
 D HDR
 W !?2,"Name: ",PNAM,?56,"SSN: ",SSN
 W !?51,"C-Number: ",CNUM
 W !?56,"DOB: " S Y=DOB X ^DD("DD") W Y
 W !?4,"Address: ",ADR1
 W ! W:ADR2]"" ?13,ADR2
 W ! W:ADR3]"" ?13,ADR3
 W !!?7,"City: ",CITY
 I $$ISFORGN^DVBCUTIL(COUNTRY) D
 . W !?3,"Province: ",PROVINCE,?48,"Res Phone: ",HOMPHON
 . W !,"Postal Code: ",POSTALCD,?48,"Bus Phone: ",BUSPHON
 E  D
 . W !?6,"State: ",STATE,?48,"Res Phone: ",HOMPHON
 . W !?6,"Zip+4: ",ZIP,?48,"Bus Phone: ",BUSPHON
 I COUNTRY>0 D
 . W !?4,"Country: ",$$GETCNTRY^DVBCUTIL(COUNTRY),!
 E  D
 . W !
 W !,"Entered active service: " S Y=EOD X ^DD("DD") S:Y="" Y="Not specified" W Y,! S Y=RAD X ^DD("DD") S:Y="" Y="Not specified" W "Released active service: " W Y,!
 F LINE=1:1:80 W "="
 W !! D CON Q:$D(OUT)  D ^DVBCENQ2,CON Q:$D(OUT)  D ^DVBCEEXM,CON Q:$D(OUT)  S REQDT=$P(^DVB(396.3,REQDA,0),U,2)
 W !,"This request was initiated on " S Y=REQDT X ^DD("DD") W $P(Y,"@",1)," at ",$P(Y,"@",2),!!?17,"Requester: ",REQN,!,"Requesting Regional Office: ",RONAME,!
 W "VHA Division Processing Request: "_$P($$SITE^VASITE(,$P(^DVB(396.3,REQDA,1),U,4)),U,2),!
 I $D(^DVB(396.4,"C",REQDA)) W !?3,"Exams on this request: " D TST^DVBCUTL2 W !
 I '$D(^DVB(396.4,"C",REQDA)) W !?3,"(No exams have yet been entered)",!
 W !,"** Status of request: " S (XSTAT,STAT)=$P(^DVB(396.3,REQDA,0),U,18)
 S STAT=$S(XSTAT="N":"New",XSTAT="P":"Pending, reported to MAS",XSTAT="T":"Transcribed",XSTAT="S":"Scheduled",XSTAT="R":"Released, not printed",XSTAT="C":"Completed",XSTAT="CT":"Completed, transferred out",XSTAT="NT":"New, transferred in",1:"")
 I STAT]"" W STAT
 I XSTAT="R"!(XSTAT="C") W !!?9,"Released on " S Y=$P(^DVB(396.3,REQDA,0),U,14) X ^DD("DD") W Y," by " S RELBY=$P(^DVB(396.3,REQDA,0),U,15),RELBY=$S($D(^VA(200,+RELBY,0)):$P(^(0),U,1),1:"Unknown user") W RELBY,!
 I XSTAT="C" W "Printed by the RO on " S Y=$P(^DVB(396.3,REQDA,0),U,16) X ^DD("DD") W Y," by " S PRBY=$P(^DVB(396.3,REQDA,0),U,17),PRBY=$S($D(^VA(200,+PRBY,0)):$P(^(0),U,1),1:"Unknown user") W PRBY,!
 I STAT="" S STAT=$S(XSTAT="X":"Cancelled by MAS",XSTAT="RX":"Cancelled by RO",1:"Unknown") W STAT I STAT["Cancelled" W "  (Cancelled on " S CANDT=$P(^DVB(396.3,REQDA,0),U,19) W $$FMTE^XLFDT(CANDT,"5DZ"),")"
 ;S X=$S($D(^DVB(396.3,REQDA,4)):$P(^(4),U,1),1:"") I X="y" W !,"Exam(s) transferred to another site -- see pending report.",!
 I $D(^DVB(396.3,REQDA,1)),$P(^(1),U,3)="Y" W !,"This request was faxed to the regional office.",!
 S FEXAM=$P(^DVB(396.3,REQDA,0),U,9) I FEXAM="Y" W !!,"*** Exams done on a FEE BASIS ***  ",! K FEXAM
 W ! F LINE=1:1:79 W "-"
 W ! D DDIS Q:$D(OUT)  D CON Q:$D(OUT)
 I IOST?1"P-".E,$Y>45 W @IOF D HDR
 W !!,"Other Disabilities:",!!?2,OTHDIS,! I $D(^DVB(396.3,REQDA,1)) W ?2,OTHDIS1,!?2,OTHDIS2
 W !!,"General Remarks:",!!
 K ^UTILITY($J,"W")
 F LINE=0:0 S LINE=$O(^DVB(396.3,REQDA,2,LINE)) Q:LINE=""  S X=^(LINE,0),DIWL=5,DIWR=75,DIWF="NW" D ^DIWP I IOST?1"C-".E,$Y>19 D CON W !!,"General Remarks, continued",!!!
 D ^DIWW
END K ANS I IOST?1"C-".E W !!,"Press [RETURN] to continue or ""^"" to stop   " R ANS:DTIME S:'$T!(ANS=U) OUT=1 I $D(OUT) Q:OUT=1
 Q
 ;
DDIS1 W ?2,DX,?37,$J(PCT,3,0)," %",?50,$S(SC=1:"Yes",1:"No"),?58,DXCOD,!
 I $Y>19 D CON
 Q
 ;
DDIS I $Y>12 D CON Q:$D(OUT)
 I '$D(^DPT(DFN,.372)) W !?25,"No rated disabilities on file",!! Q
 W !?2,"Rated Disability",?37,"Percent",?50,"SC ?",?58,"Dx Code",! W ?2 F LINE=1:1:63 W "-"
 W !!
 F JII=0:0 S JII=$O(^DPT(DFN,.372,JII)) Q:JII=""  S DXNUM=$P(^DPT(DFN,.372,JII,0),U,1),PCT=$P(^(0),U,2),SC=$P(^(0),U,3),DX=$S($D(^DIC(31,DXNUM)):$P(^(DXNUM,0),U,1),1:"Unknown"),DXCOD=$S($D(^DIC(31,DXNUM)):$P(^(DXNUM,0),U,3),1:"Unknown") D DDIS1
 W !!
 Q
 ;
HDR S PG=PG+1 W:(IOST?1"C-".E) @IOF
 W !,"Date: ",FDT(0),?(80-$L(PGHD)\2),PGHD,?71,"Page: ",PG W !,?(80-$L($$SITE^DVBCUTL4)\2),$$SITE^DVBCUTL4 I PG>1 W !!,"Name: ",PNAM,?44,"SSN: ",SSN,?63,"C-NUM: ",CNUM
 W ! F XLINE=1:1:80 W "="
 W ! Q
