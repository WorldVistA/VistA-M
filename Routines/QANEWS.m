QANEWS ;HISC/GJC-EARLY WARNING SYSTEM ;6/18/91
 ;;2.0;Incident Reporting;**14**;08/07/1992
 ;
EN1 ;Check date range.
 D ^QAQDATE I QAQQUIT W !!,*7,"Invalid date range, no report will be produced." Q
EN2 ;Check dates.
 S (QANIN,QANOUT)=0
 F QAN=0:0 S QAN=$O(^QA(742.4,QAN)) Q:QAN'>0  S QANZER0=$G(^QA(742.4,QAN,0)) I QANZER0]"" S QANDATE=$P(QANZER0,U,3) I QANDATE'<QAQNBEG,(QANDATE'>QAQNEND),(+$P(QANZER0,U,2)=1) S ^UTILITY($J,"QAN DATE",QAN)=""
 S QAN1="" F QAN=0:0 S QAN=+$O(^UTILITY($J,"QAN DATE",QAN)) Q:QAN=0  S QAN1=+$O(^QA(742,"BCS",QAN,QAN1)) Q:QAN1=0  S QANZERO=$G(^QA(742,QAN1,0)) I QANZERO]"" D TAB
 D BULL
KILL D KILL^QAQDATE K C,QAN,QANNCDT,QANINC0,QANIPAT,QANZER0,QANZERO,Y,^UTILITY($J)
 Q
BULL ;
 D KILL^XM S QANAFRM=+$S($D(^QA(740,1,"QAN"))#2:$P(^("QAN"),U,2),1:"")
 S QANSIEN=+$P(^QA(740,1,0),U) W:QANSIEN'>0 !!,"Site not specified, chec the QA Site Parameter File." Q:QANSIEN'>0
 S QANMIEN=+$S($D(^QA(740,1,"QAN"))#2:$P(^("QAN"),U),1:"") Q:QANAFRM'>0!(QANMIEN'>0)
 S XMY(QANSERV_"@"_QANDOM)=""
 S XMSUB=^DD("SITE")_" ("_^DD("SITE",1)_") QAN INCIDENT EVENT",XMDUZ=.5
 I $D(^DIC(4,QANSIEN,0)) S X="Suicide^"_$P(^DIC(4,QANSIEN,0),U)_"^"_$S($D(^DIC(4,QANSIEN,99))#2:$P(^DIC(4,QANSIEN,99),U),1:""),QANMAIL(1)=$S(X]"":X,1:"")
 S X=QAQNBEG_"^"_QAQNEND,QANMAIL(2)=$S(+X?1N.N:X,1:"")
 S X=$S(QANIN>0:QANIN,1:0) S QANMAIL(3)=X
 S X=$S(QANOUT>0:QANOUT,1:0) S QANMAIL(4)=X
 S ^UTILITY($J,1)=QANMAIL(1)_"^"_QANMAIL(2)_"^"_QANMAIL(3)_"^"_QANMAIL(4)_"^"
 S XMTEXT="^UTILITY($J," D ^XMD,KILL^XM K X,Y,XMB,QANMAIL,QANAFRM,QANMIEN,QANSIEN,QANSITE,XMHOLD,XMANS,XMDUZ,XMSUB,XMTEXT,XMY
 Q
TAB ;
 S:$P(QANZERO,U,6)']"" QANOUT=QANOUT+1
 S:$P(QANZERO,U,6)]"" QANIN=QANIN+1
 Q
HDR ;Header
 I ($E(IOST,1)="C"),(PAGE) K DIR S DIR(0)="E" D ^DIR K DIR S:+Y=0 QAXIT=1
 Q:QAXIT  W:$Y @IOF S PAGE=PAGE+1
 W !,"Date: ",TODAY,?$S(IOM=132:107,1:65),"Page: ",PAGE
 W !!?(IOM-$L(HEAD(1))\2),HEAD(1),!?(IOM-$L(HEAD(0))\2),HEAD(0)
 W !?(IOM-$L(HEAD(10))\2),HEAD(10)
 W !!,HEAD(2),?10,HEAD(3),?45,HEAD(4),?60,HEAD(5),!
 W $S(IOM=132:HEAD(7),1:HEAD(6)),!
 Q
CHECK ;Checks for inaccurate patient data; part of patch QAN*2*14.
 S (PAGE,QAXIT)=0,Y=DT X ^DD("DD") S TODAY=Y
 S HEAD(0)="For mismatched patients and patient identifiers."
 S HEAD(1)="QA Incident Reporting Patient List"
 S HEAD(10)="(Where 'number' is the internal entry number in file 742.)"
 S HEAD(2)="Number",HEAD(3)="Patient",HEAD(4)="SSN",HEAD(5)="Patient ID"
 S $P(HEAD(6),"_",81)="",$P(HEAD(7),"_",133)=""
 W !?5,"This routine will check the accuracy of the patient data." H 5
 K IOP,%ZIS S %ZIS("A")="Print on device: ",%ZIS="Q" W ! D ^%ZIS
 I POP D TERM Q
 I $D(IO("Q")) D  G XIT
 . S ZTRTN="STRT^QANEWS"
 . S ZTDESC="Print for QAN mismatched patients and patient identifiers."
 . S (ZTSAVE("HEAD("),ZTSAVE("PAGE"),ZTSAVE("QAXIT"),ZTSAVE("TODAY"))=""
 . D ^%ZTLOAD W !,$S($D(ZTSK):"Request queued properly.",1:"Queue request failed.")
STRT U IO D HDR
 F QA=0:0 S QA=$O(^QA(742,QA)) Q:QA'>0!(QAXIT)  D
 . S QA742=$G(^QA(742,QA,0)) Q:QA742']""
 . S QAINC=+$P(QA742,U,3) Q:'QAINC
 . S QA7424=$G(^QA(742.4,QAINC,0)) Q:QA7424']""
 . S CASE=$P(QA7424,U) Q:$E($P(CASE,"."),$L($P(CASE,".")),999)?1L
 . S QADPT=$G(^DPT(+$P(QA742,U),0)) Q:QADPT']""
 . S QAPAT=$P(QADPT,U),QASSN=$P(QADPT,U,9),QAPID=$P(QA742,U,2)
 . S PID=$E($P(QAPAT,",",2))_$E($P(QAPAT," ",2))_$E($P(QAPAT,","))_$E(QASSN,6,9)
 . I QAPID'=PID D
 .. W !,QA,?10,QAPAT,?45,QASSN,?60,QAPID
 . D:$Y>(IOSL-4) HDR Q:QAXIT
XIT W ! D ^%ZISC,HOME^%ZIS
TERM K CASE,HEAD,PAGE,PID,QA,QA742,QA7424,QADPT,QAINC,QAXIT,QAPAT,QAPID
 K DIRUT,DTOUT,DUOUT,DIROUT,QASSN,TODAY,X,Y,ZTDESC,ZTRTN,ZTSAVE,ZTSK
 Q
