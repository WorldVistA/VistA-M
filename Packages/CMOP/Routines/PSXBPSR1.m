PSXBPSR1 ;BHAM ISC/MFR - CMOP/ECME ACTIVITY REPORT - continuation ;09/01/2006
 ;;2.0;CMOP;**65**;11 Apr 97;Build 31
 ;External reference to ^PSRX( supported by IA #1221
 ;External reference to ^PS(59 supported by IA #1976
 ;External reference to ^PSOBPSUT supported by IA #4701
 ;External reference to ^BPSUTIL supported by IA #4410
 ;External reference to ^IBNCPDPI supported by IA #4729
 ; 
 ;
 ; Enter Date Range
 ;
 ; Return Value -> P1^P2
 ; 
 ;           where P1 = From Date
 ;                    = ^ Exit
 ;                 P2 = To Date
 ;                    = blank for Exit
 ;                 
SELDATE() N DIR,DIRUT,DTOUT,DUOUT,VAL,X,Y
 S VAL=""
 S DIR(0)="DA^^W:Y'=U "" (""_$$FMTE^XLFDT(Y)_"")"""
 S DIR("A")="ENTER BEGINNING TRANSMISSION DATE: "
 D ^DIR
 ;
 ;Check for "^", timeout, or blank entry
 I ($G(DUOUT)=1)!($G(DTOUT)=1)!($G(X)="") S VAL="^"
 ;
 I VAL="" D
 .S $P(VAL,U)=Y
 .S DIR(0)="DA^"_VAL_"^W:Y'=U "" (""_$$FMTE^XLFDT(Y)_"")"""
 .S DIR("A")="ENTER ENDING TRANSMISSION DATE: "
 .D ^DIR
 .;
 .;Check for "^", timeout, or blank entry
 .I ($G(DUOUT)=1)!($G(DTOUT)=1)!($G(X)="") S VAL="^" Q
 .;
 .;Define Entry
 .S $P(VAL,U,2)=Y
 ;
 Q VAL
 ;
 ;Select Divisions
 ;
 ; Returns Arrays -> DIVNM("names of divisions") = selection number
 ;                   DIVDA("iens of divisions") = name of division
SELDIV N DIR,DIV,DIVX,DIRUT,DUOUT,DTOUT,I,X,Y
 W !!,"SELECTION OF DIVISION(S)",!
 S DIV="" F I=1:1 S DIV=$O(^PS(59,"B",DIV)) Q:DIV=""  S DIVNM(I)=DIV,DIVNM(DIV)=I,DIVDA=$O(^PS(59,"B",DIV,0)),DIVNM(I,"I")=DIVDA
 S I=I-1
 K DIR S DIR(0)="S^A:ALL DIVISIONS;S:SELECT DIVISIONS"
 ;
 D ^DIR
 ;
 ;Check for "^", timeout, or blank entry
 I ($G(DUOUT)=1)!($G(DTOUT)=1)!($G(Y)="^") K DIVNM Q
 ;
 ;All Divisions
 I Y="A" D ALL Q
 ;
 ;Select Divisions
 I Y="S" D SELECT(I),ALL
 Q
 ;
 ;Select which divisions to display
SELECT(I) N C,DIR,DIVX,DIRUT,DUOUT,DTOUT,X,Y
 F C=1:1:I S DIR("A",C)=C_"    "_DIVNM(C)
 S DIR(0)="LO^1:"_I,DIR("A")="Select Division(s) "
 D ^DIR
 ;
 ;Check for "^", timeout, or blank entry
 I ($G(DUOUT)=1)!($G(DTOUT)=1)!($G(Y)="^")!('+Y) K DIVNM Q
 ;
 M DIVX=DIVNM K DIVNM
 F I=1:1 S X=$P(Y,",",I) Q:'X  M DIVNM(X)=DIVX(X) S DIVNM=DIVX(X),DIVNM(DIVNM)=X
 Q
 ;
SELTYPE() ; set Summary or Detail report type
 N DIR
 S DIR(0)="S^S:Summary;D:Detail"
 S DIR("A")="Display (S)ummary or (D)etail format"
 S DIR("B")="Detail"
 D ^DIR
 Q $S($G(Y)="S":Y,$G(Y)="D":Y,1:"^")
 ;;
SELPATS(ARRAY) ; select Patient(s)
 N X,Y,DIC,RESULT
 W !,"You may select a single or multiple PATIENTS,"
 W !,"or enter ^ALL to select all PATIENTS."
 S RESULT=0
 S Y=0
 S DIC="^DPT("
 S DIC(0)="AEM"
 F  Q:Y=-1  D
 .D ^DIC
 .S Y=$P(Y,"^")
 .S ARRAY(Y)=X
 .S:Y>0 RESULT=1
 S:ARRAY(-1)="^ALL" RESULT=1
 Q RESULT
 ;;
 ;Display selected divisions
ALL N DA,DIR,DIV,DIRUT,DUOUT,DTOUT,X,Y
 Q:'$D(DIVNM)
 W !!,"You have selected:",! S DIV=0 F  S DIV=$O(DIVNM(DIV)) Q:'DIV  W !,DIV,?5,DIVNM(DIV)
 S DIR(0)="Y",DIR("A")="Is this correct",DIR("B")="YES" D ^DIR
 K DIR
 I Y=1 S DIV=0 F  S DIV=$O(DIVNM(DIV)) Q:'DIV  S DA=DIVNM(DIV,"I"),DIVDA(DA)=DIVNM(DIV) K DIVNM(DIV)
 ;
 ;Check for "^", timeout, or non-yes entry
 I ($G(DUOUT)=1)!($G(DTOUT)=1)!($G(Y)'=1) K DIVNM
 Q
 ;
 ; Include Rxs - (R)ELEASED or (N)OT RELEASED or (A)LL
 ;
 ;    Input Variable -> DFLT = 3 NOT RELEASED
 ;                             2 RELEASED
 ;                             1 ALL
 ;                          
 ;    Return Value ->   3 = NOT RELEASED
 ;                      2 = RELEASED
 ;                      1 = ALL
 ;                      ^ = Exit
 ;
SELRLNRL(DFLT) N DIR,DIRUT,DTOUT,DUOUT,X,Y
 S DFLT=$S($G(DFLT)=1:"ALL",$G(DFLT)=3:"NOT RELEASED",1:"RELEASED")
 S DIR(0)="S^R:RELEASED;N:NOT RELEASED;A:ALL"
 S DIR("A")="Include Rxs - (R)ELEASED or (N)OT RELEASED or (A)LL",DIR("B")=DFLT
 D ^DIR
 ;
 ;Check for "^", timeout, or blank entry
 I ($G(DUOUT)=1)!($G(DTOUT)=1)!($G(X)="") S Y="^"
 ;
 S Y=$S(Y="A":1,Y="R":2,Y="N":3,1:Y)
 ;
 Q Y
