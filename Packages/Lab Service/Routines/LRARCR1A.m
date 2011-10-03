LRARCR1A ;DALISC/CKA - ARCHIVED WKLD REP GENERATOR-SELECT ;
 ;;5.2;LAB SERVICE;**59**;August 31, 1995
 ;same as LRCAPR1A except now references archived files
ACCN ;
 K DIC S DIC=68,DIC(0)="AEMQZ" D ^DIC Q:Y=-1  S LRX=$P(Y,U,2),LRAA=+Y Q
DATE ;
 K LRSDT,LREDT
 D ^LRWU3 Q:$G(LREND)  S LRSDT=(LRSDT-.5),LREDT=$S(LREDT'=1000000:LREDT,1:DT)
 S LRFRV=+LRSDT,LRFR=$P(+LRSDT,".") S LRFRD=$$DTF^LRAFUNC1(LRSDT)
 S LRTOV=+LREDT,LRTO=$P(+LREDT,".") S LRTOD=$$DTF^LRAFUNC1(LREDT)
 S LRDTH="From: "_LRFRD_" --- To: "_LRTOD
 Q
SPEC ;
 K DIC S DIC="^LAB(61,"
 S DIC(0)="AEMQ",DIC("A")="Topography or Specimen : ALL/ "
 F I=1:1 D ^DIC Q:Y=-1  S LRSP(+Y)=+Y,DIC("A")=" Select another specimen: ",LRSP=I
 Q
COLL ;
 K DIC S DIC="^LAB(62,",DIC(0)="AEMQ"
 F I=1:1 D ^DIC Q:Y=-1  S DIC("A")="Select another Collection Sample: ",LRCOL(+Y)=+Y,LRCOL=I
 Q
TEST ;
 K DIC S DIC="^LAB(60,",DIC(0)="AEMQ"
 S DIC("A")="Select LABORATORY TEST: All//"
 F I=1:1 D ^DIC Q:Y=-1  S LRTSTS(+Y)=$P(Y,U),LRTSTS=I,DIC("A")=" Select another LAB test: "
 Q
CAP ;
 K DIC S DIC="^LAM(",DIC(0)="AEMQ",DIC("A")="Select WKLD CODES: All//"
 F I=1:1 D ^DIC Q:Y=-1  S LRCAPS(+Y)=$P(^(0),U,2),LRCAPS=I,DIC("A")="Select another WKLD code:"
 Q
INSTR ;
 K DIC S DIC=64.2
 S DIC(0)="AEMQ",DIC("A")="Select INSTRUMENT or WKLD SUFFIX CODE: All//"
 F I=1:1 D ^DIC Q:Y=-1  S LRCPSX($P(^LAB(64.2,+Y,0),U,2))=+Y,LRCPSX=I,DIC("A")="Select another "
 Q
STAT ;
 K DIC S DIC=62.05,DIC(0)="AEMQ"
 S DIC("A")="Select URGENCY to be counted as STAT: ",DIC("B")="STAT"
 F I=1:1 D ^DIC Q:Y=-1  S LRSTAT(+Y)=$P(Y,U,2),LRSTAT(50+Y)=$P($G(^LAB(62.05,(50+Y),0)),U),DIC("A")="Select another: " K DIC("B")
 Q:'$D(LRSTAT)  K DIC,DUOUT
 S %=2 W !!,"Do you want to look up only tests with a STAT urgency"
 S LRSTAT=0 D YN^DICN S:%=1 LRSTAT=1
 Q
LOC ;
 K DIC S DIC="^SC(",DIC(0)="AEMQ",DIC("A")="Select LOCATION NAME: All//"
 F I=1:1 D ^DIC Q:Y=-1  S LRLOC(+Y)=$P(^(0),U),DIC("A")="Select another location: ",LRLOC=I
 Q
IOPAT ;
 K DIR,Y S DIR(0)="SB^I:INPATIENTS;O:OUTPATIENTS;R:OTHER;A:ALL"
 S DIR("B")="ALL",DIR("A")="Select Patient Type: "
 S DIR("?")="-------------------------"
 S DIR("?",1)="The codes are as follows:"
 S DIR("?",2)="-------------------------"
 S DIR("?",3)="   I  -  INPATIENTS      "
 S DIR("?",4)="   O  -  OUTPATIENTS     "
 S DIR("?",5)="   R  -  OTHER PATIENTS  "
 S DIR("?",6)="   A  -  ALL OF THE ABOVE"
 F  D ^DIR D  Q:($D(DUOUT))!($D(DTOUT))!(X="")
 . Q:($D(DUOUT))!($D(DTOUT))!(X="")
 . I Y="A" S LRIOPAT="IORA",X="" Q
 . S LRIOPAT=$S('$D(LRIOPAT):Y,LRIOPAT[Y:LRIOPAT,1:LRIOPAT_Y)
 . I (LRIOPAT["I")&(LRIOPAT["O")&(LRIOPAT["R") S LRIOPAT="IORA",DUOUT=1 Q
 . K DIR("B")
 . S DIR("A")="Select another Patient Type: "
 . S $P(DIR(0),U)="SBO"
 Q
CONTROL ;
 S %=2
 W !!,"Do you want to see a break out of controls for the condensed"
 W " section:",!,"TESTS by INSTRUMENTS"
 S LRCTL=0
 D YN^DICN
 I %=0 W !!,"Enter YES if you want this extra section printed, NO if you don't." G CONTROL
 I %<0 S LREND=1 Q
 S:%=1 LRCTL=1
 Q
REPTYP ;
 K DIR
 S DIR(0)="S^1:All workload;2:LMIP reportable workload;3:Non-LMIP workload"
 S DIR("A")="Enter the number for the workload data to report"
 S DIR("B")=1
 S DIR("?")="    reportable for LMIP."
 S DIR("?",1)="1 - will include all workload data in the file, period."
 S DIR("?",2)=" "
 S DIR("?",3)="2 - will include only workload which is associated with a"
 S DIR("?",4)="    WKLD code that is marked as reportable for LMIP uses."
 S DIR("?",5)=" "
 S DIR("?",6)="3 - will include any workload which is not marked as"
 D ^DIR
 I ($D(DTOUT))!($D(DUOUT)) S LREND=1 Q
 S LRRTYP=Y
 Q
