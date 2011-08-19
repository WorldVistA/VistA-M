SD44AUDI ;ALB/DHE - Audit print of file 44 fields ;12/8/10  10:17
 ;;5.3;Scheduling;**568**;Aug 13, 1993;Build 14
 ;;3.0;DSS EXTRACTS;**92**;Dec 22, 1997;Build 30
EN ;entry point from option
 ;Init variables and sort array
 N QFLG,SORT,SDX,SDNAM,SDSD,SDED,SDDT,SDNAME,SDST,SDSEQ,STCODE,D0
 ;
 S QFLG=0
 W !!,"This option prints a log of the changes made to Clinic Locations"
 ;
 ;Get sort
 D GETSORT Q:QFLG
 W !!,"** REPORT REQUIRES 132 COLUMNS TO PRINT CORRECTLY **"
 D DTRNG Q:QFLG
 D PRINT
 Q
GETSORT ;Prompt for sorting order for report
 N DIR,X,Y,DIRUT
 S DIR(0)="SO^1:USER NAME;2:DATE CHANGED"
 S DIR("A")="Select sort for Clinic Edit Log",DIR("B")=1
 D ^DIR
 I $D(DIRUT) S QFLG=1 Q
 S SORT=Y
 Q
PRINT ;Print report using fileman EN1^DIP 
 N L,DIR,DIC,DIA,FLDS,DHD,BY,FR,TO,DIOBEG,SDFIL,PG,SDFLG
 S SDFIL=44,SDFLG=0
 S L=0,DIC="^DIA("_SDFIL_",",DIOBEG="I $E(IOST,1,2)=""C-"" W @IOF"
 S FLDS=".04;L23,.02;C25;L20,.01;C47;L10,D CLINM^SD44AUDI;C59;L18,"
 S FLDS=FLDS_"1.1;C79;L10,D STCODE^SD44AUDI(2);C90;L19,D STCODE^SD44AUDI(3);C110;L15"
 S DHD="W ?0 D RPTHDR^SD44AUDI"
 I SORT=1 D
 .S BY=".04,.02",FR="A,"_SDSD,TO="Zz,"_SDED
 I SORT=2 D
 .S BY=".02,.04",FR=SDSD_",A",TO=SDED_",Zz"
 D EN1^DIP
 I 'SDFLG,'$D(^DIA(SDFIL)) D
 .W !,"NO RECORDS FOUND"
 .I $E(IOST,1,2)="C-" S DIR(0)="E" D ^DIR
 Q
 ;
CLINM ;Clinic name
 I $G(X) D
 . W $E($P($G(^SC(+X,0)),"^"),1,18)
 Q
SEQ ;retain sequence number
 S SDST=0 I $G(D0) D
 . S SDSEQ=D0
 . I $D(^DIA(44,SDSEQ,0)) D
 . I $P(^DIA(44,SDSEQ,0),"^",3)=8!($P(^(0),"^",3)=2503) D
 . . S SDST=1
 Q
STCODE(FLD) ;Get AMIS Stop Code #
 D SEQ
 D
 . I '$D(^DIA(44,D0,FLD)) S STCODE="" Q
 . I SDST=1 D
 . . S STCODE=$S(FLD=2:$P($G(^DIA(44,D0,2.1)),U),1:$P($G(^DIA(44,D0,3.1)),U))
 . . I $D(^DIC(40.7,+STCODE,0)) S STCODE=$P(^DIC(40.7,STCODE,0),"^",2)
 . . ;if stcode name has been changed then just print free txt
 . . I STCODE="" S STCODE=^DIA(44,D0,FLD)
 . . W $E(STCODE,1,18)
 . E  D
 . . W $E(^DIA(44,D0,FLD),1,18)
 Q
RPTHDR ;report header
 N LN
 S PG=$G(PG)+1,SDFLG=1
 W "CLINIC EDIT LOG ",?115,"Page ",PG,!
 W "Printed on ",$$HTE^XLFDT($H)," for ",SDSD," to ",SDED,!
 W "USER NAME",?24,"DATE/TIME CHANGED",?46,"CLINIC IEN",?58
 W "CLINIC NAME",?78,"FIELD NAME",?89,"OLD VALUE",?109,"NEW VALUE",!
 S $P(LN,"-",130)="" W LN,!
 Q
DTRNG ;report date range
 N %DT,ECDT,X,Y
DTREP S %DT="AEX",%DT("A")="Starting with Date: ",%DT(0)="-NOW" D ^%DT
 I Y<0 S QFLG=1 Q
 S SDDT=Y,SDSD=$$FMTE^XLFDT(Y,2)
 S %DT="AEX",%DT("A")="Ending with Date: ",%DT(0)="-NOW" D ^%DT
 I Y<0 S QFLG=1 Q
 I Y<SDDT D  G DTREP
 .W !!,"The ending date cannot be earlier than the starting date.",!
 I $E(Y,1,5)'=$E(SDDT,1,5) D  G DTREP
 .W !!,"Beginning and ending dates must be in the same month and year.",!
 S SDED=$$FMTE^XLFDT(Y,2)
 Q
