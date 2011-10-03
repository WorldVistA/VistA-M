PRSARPT2 ; HISC/FPT-Un-Transmitted Employees Report ;8/14/95  12:03
 ;;4.0;PAID;;Sep 21, 1995
 ;
 ; IEN      = employee's internal entry number (file 450)
 ; NAME     = employee's name
 ; PAGE     = page number of report
 ; PP       = pay period
 ; PPIEN    = pay period internal entry number (file 458)
 ; STATUS   = 8b record status
 ; TL       = time and leave unit
 ; YN       = variable to stop terminal scrolling
 ;
 K DIC S DIC="^PRST(458,",DIC(0)="AEMQZ" S PPIEN=$P($G(^PRST(458,0)),U,3) I PPIEN<1 D KILL Q
 S DIC("B")=$P(^PRST(458,PPIEN,0),U,1) D ^DIC K DIC I +Y<1 D KILL Q
 S PPIEN=+Y
R0 R !!,"Select T&L Unit (or ALL): ",X:DTIME G:'$T!("^"[X) KILL S X=$TR(X,"al","AL") I X="ALL" S TLE=""
 E  K DIC S DIC="^PRST(455.5,",DIC(0)="EMQ" D ^DIC G KILL:$D(DTOUT),R0:Y<1 S TLE=$P(Y,"^",2)
 K %ZIS S %ZIS="MQ" W ! D ^%ZIS I POP D KILL Q
 I $D(IO("Q")) S ZTDESC="8B Un-Transmitted Employees List",ZTRTN="PRINT^PRSARPT2",ZTSAVE("PPIEN")="",ZTSAVE("TLE")="" D ^%ZTLOAD D KILL,HOME^%ZIS Q
 U IO D PRINT D ^%ZISC
KILL K %,%ZIS,DIR,DIROUT,DIRUT,DTOUT,DUOUT,IEN,NAME,PAGE,POP,PP,PPIEN,STATUS,TL,TLE,X,Y,YN,ZTDESC,ZTREQ,ZTRTN,ZTSAVE,ZTSTOP
 Q
PRINT ; print report
 I $D(ZTQUEUED) S ZTREQ="@"
 S PAGE=0,PP=$P(^PRST(458,PPIEN,0),U),YN=""
 D HEADER I TLE'="" S ATL="ATL"_TLE,TL=TLE G P1
 S ATL="ATL00" F  S ATL=$O(^PRSPC(ATL)) Q:ATL'?1"ATL".E!(YN="^")  S TL=$E(ATL,4,6) D P1
 Q
P1 S NAME="" F  S NAME=$O(^PRSPC(ATL,NAME)) Q:NAME=""!(YN="^")  S IEN=0 F  S IEN=$O(^PRSPC(ATL,NAME,IEN)) Q:IEN<1!(YN="^")  D
 .S STATUS=$P($G(^PRST(458,PPIEN,"E",IEN,0)),"^",2)
 .Q:"X"[STATUS
 .I $Y>(IOSL-4) D:IOST?1."C".E SCROLL D:$D(ZTQUEUED) STOPCHK Q:YN["^"  D HEADER
 .W !,$P($G(^PRSPC(IEN,0)),"^",1),?35,TL,?46,$S(STATUS="T":"Timekeeper",STATUS="P":"Payroll",1:"")
 Q
HEADER ; page/screen header
 W:$Y>0 @IOF
 S PAGE=PAGE+1 D NOW^%DTC S Y=% X ^DD("DD")
 W !!,"Un-Transmitted Employees for ",PP,?46,Y,?70,"Page ",PAGE
 W !,"NAME",?35,"T&L",?46,"STATUS"
 W !,$$REPEAT^XLFSTR("-",79)
 Q
SCROLL ; screen hold
 K DIR,DIROUT,DIRUT,DTOUT,DUOUT
 W ! S DIR(0)="E" D ^DIR
 S:$D(DIRUT)!(Y=0) YN="^"
 Q
STOPCHK ; check for user request to stop a background print job
 I $$S^%ZTLOAD S ZTSTOP=1,YN="^" K ZTREQ W !?10,"*** Output stopped at user's request ***"
 Q
