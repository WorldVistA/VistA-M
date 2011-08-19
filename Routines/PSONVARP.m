PSONVARP ;BHM/MFR - Non-VA Med Usage Report - Input ; 5/3/10 5:57pm
 ;;7.0;OUTPATIENT PHARMACY;**132,118,326,355**;13 Feb 97;Build 1
 ;External reference to ^%DT is supported by DBIA 10003
 ;External reference to ^%ZTLOAD is supported by DBIA 10063
 ;External reference to ^%ZIS is supported by DBIA 10086
 ;External reference to ^DIR is supported by DBIA 10026
 ;External reference to ^XLFSTR is supported by DBIA 10104
 ;
HID ; - Entrhy point from the Hidden Action in the Medication Profile
 N PSOHDFLG S PSOHDFLG=1
 ;
EN N PSOSD,PSOED,PSOST,PSOSRT,PSOAPT,PSOAOI,PSOST,PSOOC,PSOAPT,PSOAOI,I,Y
 N OK,X,C,%DT
 ;
 ; - Ask for FROM DATE DOCUMENTED
 S %DT(0)=-DT,%DT="AEP",%DT("A")="FROM DATE DOCUMENTED: "
 W ! D ^%DT I Y<0!($D(DTOUT)) G END
 S PSOSD=Y\1-.00001
 ;
ENDT ; - Ask for TO DATE DOCUMENTED
 S %DT(0)=PSOSD+1\1,%DT("A")="TO DATE DOCUMENTED: "
 W ! D ^%DT I Y<0!($D(DTOUT)) G END
 S PSOED=Y\1+.99999
 ;
 ; - Reported called from a Hidden Action menu
 I $G(PSOHDFLG) D  G DEV
 . S:'$G(DFN) DFN=PSODFN
 . S PSOPT(DFN)="",PSOAPT=0,PSOAOI=1,PSOST="B",PSOOC="B",PSOSRT="4,2"
 ;
SORT ; - Ask for SORT BY
 K DIR S DIR("B")="PATIENT NAME" D HL1("A")
SORT1 S PSOSRT="",(PSOAPT,PSOAOI)=1,(PSOST,PSOOC)="B"
 S DIR("A")="SORT BY",DIR(0)="FO" D HL1("?")
 W ! D ^DIR K DIR I $D(DIRUT) G END
 ;
 S OK=1,C=15 W !
 F I=1:1:$L(Y,",") D
 . S X=$P(Y,",",I) S:X'?.N X=$$TRNS(X) I PSOSRT[X Q
 . W !?(C-10),$S(I=1:"SORT BY ",1:"THEN BY ") S C=C+5
 . I X<1!(X>5) W X,"???",$C(7) S OK=0 Q
 . W $P("PATIENT NAME^ORDERABLE ITEM^DATE DOCUMENTED^STATUS^ORDER CHECKS","^",X)
 . S PSOSRT=PSOSRT_","_X
 I 'OK S DIR("B")=Y G SORT1
 S $E(PSOSRT)=""
 ;
 S OK=1
 F I=1:1:$L(PSOSRT,",") D  I 'OK Q
 . S X=$P(PSOSRT,",",I) D:X'=3 @("SRT"_X)
 I 'OK S DIR("B")="PATIENT NAME" G SORT1
 ;
DEV W ! K %ZIS,IOP,POP,ZTSK S %ZIS="QM" D ^%ZIS K %ZIS I POP G END
 I $D(IO("Q")) D  G END
 . N G K IO("Q"),ZTIO,ZTSAVE,ZTDTH,ZTSK
 . S ZTRTN="EN^PSONVAR1",ZTDESC="Non-VA Meds Usage Report"
 . F G="PSOSD","PSOED","PSOSRT","PSOPT","PSOOI" S:$D(@G) ZTSAVE(G)=""
 . F G="PSOST","PSOOC","PSOAPT","PSOAOI" S:$D(@G) ZTSAVE(G)=""
 . S:$D(PSOPT) ZTSAVE("PSOPT(")="" S:$D(PSOOI) ZTSAVE("PSOOI(")=""
 . D ^%ZTLOAD W:$D(ZTSK) !,"Report is Queued to print !!" K ZTSK
 ;
 G EN^PSONVAR1
 ;
END Q
 ;
SRT1 ; - Selection of PATIENTS to print on the Report
 N DIC,X,I K PSOPT S PSOAPT=0
 W !!,?5,"You may select a single or multiple PATIENTS,"
 W !,?5,"or enter ^ALL to select all PATIENTS.",!
 S DIC(0)="QEAM",DIC("A")="     PATIENT: "
 F  D EN^PSOPATLK S Y=PSOPTLK Q:+Y<1  S:'$$DEAD(+Y,1) PSOPT(+Y)="" K DIC("B"),PSOPTLK
 I Y="^ALL" S PSOAPT=1 K PSOPT,DUOUT Q
 I $D(DUOUT)!($D(DTOUT)) S OK=0 Q
 I '$D(PSOPT),Y<1 S OK=0 Q
 Q
 ;
SRT2 ; - Selection of ORDERABLE ITEMS to print on the Report
 N DIC,X,I K PSOOI S PSOAOI=0
 W !!,?5,"You may select a single or multiple ORDERABLE ITEMS,"
 W !,?5,"or enter ^ALL to select all ORDERABLE ITEMS.",!
 S DIC=50.7,DIC(0)="QEAM",DIC("A")="     ORDERABLE ITEM: "
 F  D ^DIC Q:Y<0  S PSOOI(+Y)="" K DIC("B")
 I X="^ALL" S PSOAOI=1 K PSOOI,DUOUT Q
 I $D(DUOUT)!($D(DTOUT)) S OK=0 Q
 I '$D(PSOOI)&(Y<0) S OK=0 Q
 Q
 ;
SRT4 ; - Selection of STATUS to print on the Report
 N DIR,X,I K PSOST
 W !!,?5,"You may select (A)CTIVE, (D)ISCONTINUED or (B)OTH status.",!
 S DIR(0)="SAO^A:ACTIVE;D:DISCONTINUED;B:BOTH"
 S DIR("A")="     STATUS: ",DIR("B")="ACTIVE" D ^DIR
 I $D(DIRUT) S OK=0 Q
 S PSOST=Y
 Q
 ;
SRT5 ; - Selection of ORDER CHECKS to print on the Report
 N DIR,X,OP1,OP2 K PSOOC
 S OP1="ORDERS WITH ORDER CHECKS ONLY"
 S OP2="ORDERS WITHOUT ORDER CHECKS ONLY"
 W !!,?5,"You may select 'Y' to print ",OP1,","
 W !?5,"'N' to print ",OP2," or 'B' for BOTH.",!
 S DIR(0)="SAO^Y:"_OP1_";N:"_OP2_";B:BOTH"
 S DIR("A")="     ORDER CHECKS: ",DIR("B")="BOTH" D ^DIR
 I $D(DIRUT) S OK=0 Q
 S PSOOC=Y
 Q
 ;
TRNS(X) ; - Translates Alpha into the corresponding Sorting Code
 N L,UPX S L=$L(X),UPX=$$UP^XLFSTR(X)
 I $E("PATIENT NAME",1,L)=UPX Q 1
 I $E("ORDERABLE ITEM",1,L)=UPX Q 2
 I $E("DATE DOCUMENTED",1,L)=UPX Q 3
 I $E("STATUS",1,L)=UPX Q 4
 I $E("ORDER CHECKS",1,L)=UPX Q 5
 Q X
 ;
DEAD(DFN,DSPL) ; Check if Patient has a Date Of Death on File
 N VADM,Y
 I '$G(DFN) Q 0
 D DEM^VADPT I $G(VADM(6))="" Q 0
 I $G(DSPL) W !?10,$P($G(VADM(1)),"^")," (",$P($G(VADM(2)),"^",2),") DIED ",$P($G(VADM(6)),"^",2),$C(7)
 Q 1
 ;
HL1(S) ; - Help for the SORT BY prompt
 S DIR(S,1)="    Enter the SORT field(s) for this Report:"
 S DIR(S,2)=" "
 S DIR(S,3)="       1 - PATIENT NAME"
 S DIR(S,4)="       2 - ORDERABLE ITEM"
 S DIR(S,5)="       3 - DATE DOCUMENTED"
 S DIR(S,6)="       4 - STATUS"
 S DIR(S,7)="       5 - ORDER CHECKS"
 S DIR(S,8)=" "
 S DIR(S,9)="    Or any combination of the above, separated by comma,"
 S DIR(S,10)="    as in these examples:"
 S DIR(S,11)=" "
 S DIR(S,12)="       2,1  - BY ORDERABLE ITEM, THEN BY PATIENT NAME"
 S DIR(S,13)="      5,1,4 - BY ORDER CHECKS, THEN BY PATIENT NAME, THEN BY STATUS"
 S DIR(S,14)=" "
 S DIR(S)=" "
 Q
