ECXSCX3 ;ALB/DHE- DSS Clinic & Stop Codes Validity Report 728.44 ; 6/11/09 3:21pm
 ;;3.0;DSS EXTRACTS;**120**;Dec 22, 1997;Build 43
EN ;entry point from option
 ;
 N ZTDESC,ZTRTN,ZTSAVE,ZTSK,ZUSR,ZTDTH,POP
 W !!,"This report will display stop code information of the ACTIVE ",!,"clinics in the Clinics and Stop Code file (#728.44).  It will",!,"display stop codes that do not conform to the Business Rules for ",!,"Valid Stop Codes.",!!
 I '$D(^ECX(728.44)) W !,"DSS Clinic stop code file does not exist",!! R X:5 K X Q
 S %ZIS="Q" D ^%ZIS G:POP EXIT
 I $D(IO("Q")) D  Q
 . K ZTSAVE S ZTDESC="DSS Identify Invalid Stop and Credit Stop Codes",ZTRTN="START^ECXSCX3",ZTDTH=$H
 . D ^%ZTLOAD
 . D ^%ZISC,HOME^%ZIS
 . W !,$S($D(ZTSK):"REQUEST QUEUED!",1:"REQUEST CANCELLED!")
 D START
EXIT D ^%ZISC,HOME^%ZIS
 Q
START ; queued entry to print report
 U IO
 N CLIEN,CODE,ERR,QUIT,WRN,TOT,CODE1,CODE2,CODE3,CODE4,CLNAME,DATE
 N I,INACT,Y,HEAD,NONAME,QFLG,LN,PG,DAT,REACT
 K WARNING,ECXERR,TYPE
 S QFLG=0,$P(LN,"-",80)="",PG=0
 S TOT=0,QUIT=""
 D HEAD
 S CLIEN=0 F  S CLIEN=$O(^ECX(728.44,CLIEN)) Q:'CLIEN  D  Q:QUIT
 . Q:'$D(^ECX(728.44,CLIEN,0))
 . S DAT=$G(^SC(CLIEN,"I")),INACT=+DAT,REACT=$P(DAT,"^",2)
 . ;S INACT=$P(^ECX(728.44,CLIEN,0),"^",10)
 . ;I (INACT'>DT)&(INACT'="") Q
 . I INACT,('REACT),INACT'>DT Q
 . I INACT,INACT'>DT I REACT,DT<REACT Q
 . S CLNAME=$S($G(CLIEN)>0:$E($$GET1^DIQ(44,CLIEN,.01,"E"),1,30),1:NONAME)
 . K WARNING,ECXERR,TYPE,ERR,WRN
 . S DATE=DT
 . S CODE1=$P(^ECX(728.44,CLIEN,0),"^",2),TYPE="Stop Code" D STOP^ECXSTOP(CODE1,TYPE,CLIEN,DATE)
 . S CODE2=$P(^ECX(728.44,CLIEN,0),"^",3),TYPE="Credit Stop Code" D STOP^ECXSTOP(CODE2,TYPE,CLIEN,DATE)
 . S CODE3=$P(^ECX(728.44,CLIEN,0),"^",4),TYPE="DSS Stop Code" D STOP^ECXSTOP(CODE3,TYPE,CLIEN,DATE)
 . S CODE4=$P(^ECX(728.44,CLIEN,0),"^",5),TYPE="DSS Credit Stop Code" D STOP^ECXSTOP(CODE4,TYPE,CLIEN,DATE)
 . I $D(ECXERR)!($D(WARNING)) S TOT=TOT+1 D  Q:QUIT
 . . I $Y>(IOSL-5) D HEAD
 . . W !!,CLIEN,?6,CLNAME,?46,$G(CODE1),?54,$G(CODE2),?62,$G(CODE3),?70,$G(CODE4)
 . . I $D(ECXERR) W !,"ERRORS:" D
 . . . S I=0 F  S I=$O(ECXERR(I)) Q:'I  D  Q:QUIT
 . . . . W !?6,ECXERR(I) D ADD
 . . I $D(WARNING) W !,"WARNINGS:" D
 . . . S I=0 F  S I=$O(WARNING(I)) Q:'I  D  Q:QUIT
 . . . . W !?6,WARNING(I) D ADD
 Q:QUIT
 ;
OUT ;
 I TOT'>0 W !!!?6,"NO PROBLEMS FOUND."
 E  W !!!,?10,TOT," PROBLEM CLINICS FOUND."
 W:$Y @IOF D ^%ZISC S ZTREQ="@"
 K QFLG,PG,LN,ECXERR,WARNING
 D ^ECXKILL
 Q
 ;
HEAD ; header for worksheet
 W:$E(IOST,1,2)["C-"!(PG>1) @IOF S PG=PG+1
 W !,"DSS CLINIC & STOP CODES VALIDITY REPORT",?71,"Page: ",PG
 W !!,"IEN#",?6,"CLINIC NAME",?46,"PRIM",?54,"2NDARY",?62,"DSS",?70,"DSS"
 W !?46,"STOP",?54,"CREDIT",?62,"PRIM",?70,"2NDARY"
 W !?46,"CODE",?54,"STOP",?62,"STOP",?70,"CREDIT"
 W !?54,"CODE",?62,"CODE",?70,"CODE"
 W !,LN
 Q
 ;
PAUSE N DIR,DIRUT,X,Y
 F  Q:$Y>(IOSL-3)  W !
 S DIR(0)="E"
 D ^DIR
 I ('(+Y))!($D(DIRUT)) S QUIT=1
 Q
ADD I $E(IOST,1,2)="C-",($Y>(IOSL-5)) D
 . D PAUSE Q:QUIT
 . D HEAD
 I $E(IOST,1,2)'="C-",($Y>(IOSL-5)) D HEAD
 Q
 ;
