ECXPHAU ;ALB/JAM - Print Pharmacy Volume Edit Log (IVP,PRE,UDP) ; 11/2/06 8:54am
 ;;3.0;DSS EXTRACTS;**92**;Dec 22, 1997;Build 30
EN ;entry point from option
 ;Init variables and sort array
 N QFLG,SORT,ECXX,ECXNAM,ECSD,ECED
 ;
 S QFLG=0
 W !!,"This option prints a log of the changes made to the Pharmacy"
 W !,"Extracts: PRE, IVP or UDP",!
 ;
 ;Get Extract
 D EXTRT Q:QFLG
 ;Get sort
 D GETSORT Q:QFLG
 W !!,"** REPORT REQUIRES 132 COLUMNS TO PRINT CORRECTLY **"
 D DTRNG Q:QFLG
 D PRINT
 Q
EXTRT ;Prompt for extract to report on
 N DIR,DIRUT
 S DIR(0)="SO^P:PRE;I:IVP;U:UDP"
 S DIR("A")="Which extract log do you need?"
 D ^DIR I $D(DIRUT) S QFLG=1 Q
 S ECXX=Y,ECXNAM=Y(0)
 Q
GETSORT ;Prompt for sorting order for report
 N DIR,X,Y,DIRUT
 S DIR(0)="SO^1:USER NAME;2:DATE CHANGED"
 S DIR("A")="Select sort for Pharmacy Volume Edit Log",DIR("B")=1
 D ^DIR
 I $D(DIRUT) S QFLG=1 Q
 S SORT=Y
 Q
PRINT ;Print report using fileman EN1^DIP for IVP
 N L,DIR,DIC,DIA,FLDS,DHD,BY,FR,TO,DIOBEG,ECXFIL,PG,ECXFLG
 S ECXFIL=$S(ECXX="P":"727.81",ECXX="I":"727.819",1:"727.809"),ECXFLG=0
 S L=0,DIC="^DIA("_ECXFIL_",",DIOBEG="I $E(IOST,1,2)=""C-"" W @IOF"
 S FLDS=".04;L23,.02;C25;L20,.01;C47;L14,D EXTNOI^ECXPHAU;C62;L9,"
 S FLDS=FLDS_"1.1;C74;L15,2;C90;L19,3;C110;L15"
 S DHD="W ?0 D RPTHDR^ECXPHAU"
 I SORT=1 D
 .S BY=".04,.02",FR="A,"_ECSD,TO="Zz,"_ECED
 I SORT=2 D
 .S BY=".02,.04",FR=ECSD_",A",TO=ECED_",Zz"
 D EN1^DIP
 I 'ECXFLG,'$D(^DIA(ECXFIL)) D
 .W !,"NO RECORDS FOUND"
 .I $E(IOST,1,2)="C-" S DIR(0)="E" D ^DIR
 Q
 ;
EXTNOI ;Extract Number
 I $G(X) W $P($G(^ECX(ECXFIL,+X,0)),"^",3)
 Q
RPTHDR ;report header
 N LN
 S PG=$G(PG)+1,ECXFLG=1
 W "PHARMACY VOLUME EDIT LOG FOR "_ECXNAM,?115,"Page ",PG,!
 W "Printed on ",$$HTE^XLFDT($H)," for ",ECSD," to ",ECED,!
 W "USER NAME",?24,"DATE/TIME CHANGED",?46,"SEQUENCE #",?61
 W "EXTRACT #",?73,"FIELD NAME",?89,"OLD VALUE",?109,"NEW VALUE",!
 S $P(LN,"-",130)="" W LN,!
 Q
DTRNG ;report date range
 N %DT,ECDT,X,Y
DTREP S %DT="AEX",%DT("A")="Starting with Date: ",%DT(0)="-NOW" D ^%DT
 I Y<0 S QFLG=1 Q
 S ECDT=Y,ECSD=$$FMTE^XLFDT(Y,2)
 S %DT="AEX",%DT("A")="Ending with Date: ",%DT(0)="-NOW" D ^%DT
 I Y<0 S QFLG=1 Q
 I Y<ECDT D  G DTREP
 .W !!,"The ending date cannot be earlier than the starting date.",!
 I $E(Y,1,5)'=$E(ECDT,1,5) D  G DTREP
 .W !!,"Beginning and ending dates must be in the same month and year.",!
 S ECED=$$FMTE^XLFDT(Y,2)
 Q
