NURSAGP1 ;HIRMFO/MD,RM,FT-ADMINISTRATION/EDUCATION REPORT PROMPTS CONTINUED ;2/27/98  14:25
 ;;4.0;NURSING SERVICE;**1,9**;Apr 25, 1997
EN1 ;GENERIC PROMPTS FOR NSPB REPORTS
 W ! S X="^",NSP=0,%DT("A")="Start With ACTION DATE (Press return for all dates): ",%DT="AE" D ^%DT K %DT
 I X="" S NSP=1 Q
 I Y'>0!(X="^") S NUROUT=1 Q
 S NSPC=Y
 W ! S X="^",NSPC(2)=0,%DT("A")="Go To ACTION DATE (Press return for all dates until present date): ",%DT="AE" D ^%DT K %DT
 I X="" S X="T" D ^%DT S NSPC(2)=Y
 I Y'>0!(X="^") S NUROUT=1 Q
 S NSPC(2)=Y
 Q
EN2 ;GENERIC PROMPTS FOR NURSING EDUCATION PROFILE REPORTS
 W ! S NSP=0,DIC("A")="Select NURSING DEGREE (Press return for all nursing degrees): "
 S DIC("S")="I $P(^(0),U,1)[""Nursing"""
 S DIC="^NURSF(212.1,",DIC(0)="AEMZQ",DIC("W")="W ?45,$P(^(0),U,3)" D ^DIC I '$D(DTOUT),X="" S NSP=1 Q
 I $D(DTOUT)!(+Y'>0) S NUROUT=1 Q
 S NSPC=$P(Y(0),"^",3)
 Q
EN3 ;GENRIC PROMPT FOR INDIVIDUAL REPORTS
 W ! S DIC("A")="Select Nursing Staff Name:  ",DIC("W")="I $D(^VA(200,+^NURSF(210,+Y,0),1)),$P(^(1),U,9) W ?$X+5,$P(^(1),U,9) S DA=+Y D EN2^NURSUT0 W:$D(NPSPOS) ?$X+5,NPSPOS_""  """
 S DIC(0)="AEMQI",DIC="^NURSF(210," D ^DIC K DIC
 I "^"[X!'(+Y>0) S NUROUT=1 Q
 I '$D(^VA(200,+^NURSF(210,+Y,0),0))!($P(^(0),U)="") W $C(7),!!,"Missing NEW PERSON Name - Cannot Process",! S NUROUT=1 Q
 S N1=+Y,N2=$P(Y,"^",2)
 Q
EN4 ;GENERIC PROMPTS FOR PROFICIENCY REPORTS
 W ! S X="^",NSP=0,%DT("A")="Select DUE DATE (Press return for all dates): ",%DT="AE" D ^%DT K %DT
 I X="" S NSP=1 Q
 I +Y'>0!(X="^") S NUROUT=1 Q
 S NSPC=Y D:+Y D^DIQ S %DT("B")=Y
 W ! S X="^",NSPC(2)=0,%DT(0)=NSPC,%DT("A")="Go To DUE DATE: ",%DT="AE" D ^%DT K %DT
 I X="" S X="T" D ^%DT S NSPC(2)=Y Q
 I Y'>0!(X="^") S NUROUT=1 Q
 S NSPC(2)=Y
 Q
EN5 ;GENERIC PROMPTS FOR NURSING EDUCATION PROFILE REPORTS
 S NURSER=$$GETSER^NURSUT3 I $G(NURSER)="" W !!,$C(7),"NO NURSING SERVICE ENTRY IN COST CENTER/ORGANIZATION CODE FILE 454.1 CANNOT-CONTINUE: " Q
 I $G(NURSEL)="A" Q
 N Y K DTOUT,DUOUT W !
 S DIC("S")="S DAT=$G(^(0)),NURCLAS=$P($G(DAT),U,2),NURIEN=$G(^PRSE(452,""AK"",NURCLAS,Y)),NURD0=$O(^PRSE(452.1,""B"",NURCLAS,0)) I $P(DAT,U,21)=NURSEL,(NURSER[(U_NURIEN_U)!($P($G(^PRSE(452.1,+NURD0,0)),U,9)=0))"
 S NSP=0,NURSCLS="",DIC("A")="Select TRAINING CLASS (Press return for all classes): "
 S D="AK",DIC="^PRSE(452,",DIC(0)="ASQZE" D IX^DIC K DIC
 I '$D(DTOUT),'$D(DUOUT),X="" S NSP=1 Q
 I $D(DTOUT)!($D(DUOUT))!(+Y'>0) S NUROUT=1 Q
 S (NURSCLS,NSPC)=$P($G(Y(0)),U,2),NURSCLS(0)=+$O(^PRSE(452.1,"B",NSPC,0))
 Q
EN3A ; ENTRY POINT FOR CLASS DATE
 W ! S X="^",NSP(1)=0,%DT("A")="Start With CLASS DATE (Press return for all dates): ",%DT="AE",%DT(0)=-DT D ^%DT K %DT
 I X="" S NSP(1)=1 Q
 I Y'>0!(X="^") S NUROUT=1 Q
 S NSPC(1)=Y
 W ! S X="^",NSPC(2)=0,%DT("A")="Go To CLASS DATE (Press return for all dates until present date): ",%DT="AE" D ^%DT K %DT
 I X="" S X="T" D ^%DT S NSPC(2)=Y Q
 I Y'>0!(X="^") S NUROUT=1 Q
 S NSPC(2)=Y
 Q
EN6 ; FISCAL YEAR SELECTION ROUTINE
 W !,"Select Year: " R X:DTIME I '$T!("^"[X) S NUROUT=1 Q
 S YR=1700+$E(DT,1,3) S YR(1)=YR-1,YR(2)=YR-2
 I X["?"!'(X?4N) D YRHELP G EN6
 S NYR=X I NYR>YR!(NYR<(YR(2))) D YRHELP G EN6
 S %DT="",X="10/1/"_(NYR-1) D ^%DT S FY=+Y,%DT="",X="9/30/"_NYR D ^%DT S FYEND=+Y
 Q
YRHELP W !!,$C(7),"Enter a year designating one of the last three fiscal years (",YR,",",YR(1),",",YR(2),"):",!
 Q
EN7 ; DATE RANGE ENTRY POINT
 W ! S X="T-1" D ^%DT S NDATE(1)=+Y,DIR(0)="DOA^:"_NDATE(1)_":EX",DIR("A")="Start with DATE: ",DIR("?")="^S %DT(0)=-NDATE(1) D HELP^%DTC" D ^DIR K DIR I $G(DIRUT) S NUROUT=1 Q
 S $P(NDATED,U)=+Y,X1=+NDATED,X2=+31 D C^%DTC S (NDATE,Y)=X S NDATE(1)=$S(NDATE>NDATE(1):NDATE(1),1:NDATE),Y=+NDATED D D^DIQ S NURDFLT1=Y,Y=+NDATE(1) D D^DIQ S NURDFLT2=Y
 W ! S DIR(0)="DOA^"_+NDATED_":"_+NDATE(1)_":EX",DIR("A")="Go to DATE: ",DIR("?")="^D HELP^%DTC W !!,?5,""Enter a date between ""_NURDFLT1_"" and ""_NURDFLT2_"".""" S:$G(NURDFLT1)'="" DIR("B")=NURDFLT1 D ^DIR K DIR
 I $G(DIRUT) S NUROUT=1 Q
 S $P(NDATED,U,2)=+Y
 Q
EN8 ; NON RESTRICTED DATE RANGE ENTRY POINT
 W ! S DIR(0)="DO^::EX",DIR("A")="Start with DATE",DIR("?")="^D HELP^%DTC" D ^DIR K DIR I $G(DIRUT) S NUROUT=1 Q
 S $P(NDATED,U)=+Y S X1=+NDATED,X2=+31 D C^%DTC S (NDATE,Y)=X D D^DIQ S NDATE(2)=Y S Y=+NDATED D D^DIQ S NDATE(1)=Y
 W ! S DIR(0)="DOA^"_+NDATED_":"_+NDATE_":EX",DIR("A")="Go to DATE: ",DIR("?")="^D HELP^%DTC W !!,?5,""Enter a date between ""_NDATE(1)_"" and ""_NDATE(2)_"".""" S:$G(NDATE(1))'="" DIR("B")=NDATE(1) D ^DIR K DIR I $G(DIRUT) S NUROUT=1 Q
 S $P(NDATED,U,2)=+Y
 Q
