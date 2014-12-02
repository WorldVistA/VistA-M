SD44AUDI ;ALB/DHE - Audit print of file 44 fields ;4/29/14  16:51
 ;;5.3;Scheduling;**568,616**;Aug 13, 1993;Build 3
EN ;entry point from option
 ;Init variables and sort array
 N QFLG,SORT,SDX,SDNAM,SDSD,SDED,SDDT,SDNAME,SDST,SDSEQ,STCODE,D0,SDXPORT ;616
 ;
 S QFLG=0
 W !!,"This option prints a log of the changes made to Clinic Locations"
 ;
 ;Get sort
 D GETSORT Q:QFLG
 D DTRNG Q:QFLG
 S SDXPORT=$$EXPORT Q:SDXPORT=-1  ;616
 I '$G(SDXPORT) W !!,"** REPORT REQUIRES 132 COLUMNS TO PRINT CORRECTLY **" ;616
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
 N L,DIR,DIC,DIA,FLDS,DHD,BY,FR,TO,DIOBEG,SDFIL,PG,SDFLG,IOP ;616
 S SDFIL=44,SDFLG=0
 S L=0,DIC="^DIA("_SDFIL_"," S DIOBEG=$S('$G(SDXPORT):"I $E(IOST,1,2)=""C-"" W @IOF",1:"W ""USER NAME^DATE/TIME CHANGED^CLINIC IEN^CLINIC NAME^FIELD NAME^OLD VALUE^NEW VALUE""") ;616
 I '$G(SDXPORT) D  ;616
 .S FLDS=".04;L23,.02;C25;L20,D CLINIEN^SD44AUDI;C47;L10,D CLINM^SD44AUDI;C59;L18," ;616
 .S FLDS=FLDS_"1.1;C79;L10,D STCODE^SD44AUDI(2);C90;L19,D STCODE^SD44AUDI(3);C110;L15" ;616
 I $G(SDXPORT) S FLDS=".04;X,""^"",.02;X,""^"",D CLINIEN^SD44AUDI;X,""^"",D CLINM^SD44AUDI;X,""^"",1.1;X;L40,""^"",D STCODE^SD44AUDI(2);X,""^"",D STCODE^SD44AUDI(3);X" ;616
 S DHD=$S('$G(SDXPORT):"W ?0 D RPTHDR^SD44AUDI",1:"@@") ;616
 I SORT=1 D
 .S BY=".04,.02",FR="A,"_SDSD,TO="Zz,"_SDED
 I SORT=2 D
 .S BY=".02,.04",FR=SDSD_",A",TO=SDED_",Zz"
 I $G(SDXPORT) D EXPDISP Q:IOP="^"  ;616
 D EN1^DIP
 I 'SDFLG,'$D(^DIA(SDFIL)) D
 .W !,"NO RECORDS FOUND"
 .I $E(IOST,1,2)="C-",'$G(SDXPORT) S DIR(0)="E" D ^DIR ;616
 I $G(SDXPORT) D  ;616
 .W !!,"Turn off your logging..."
 .W !,"...Then, pull your export text file into your spreadsheet.",!
 .S DIR(0)="E",DIR("A")="Press any key to continue" D ^DIR
 .D HOME^%ZIS
 Q
 ;
CLINM ;Clinic name
 I $G(X) D
 . W $E($P($G(^SC(+X,0)),"^"),1,18)
 Q
CLINIEN ;section added in 616
 W +X Q
 ;
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
EXPORT() ;Function indicates if report output is going to a device or to the screen in exportable format - API added in patch 616
 N DIR,DIRUT,DTOUT,DUOUT,DIROUT,X,Y,VAL
 W !
 S DIR("?",1)="Enter yes if you want the data to be displayed in an '^' delimited format",DIR("?")="that can be captured for exporting."
 S DIR(0)="SA^Y:YES;N:NO",DIR("B")="NO",DIR("A")="Do you want the output in exportable format? "
 D ^DIR
 S VAL=$S($D(DIRUT):-1,Y="N":0,1:1)
 I VAL=1 W !!,"Gathering data for export..."
 Q VAL
 ;
EXPDISP ;Displays report in exportable format.  API added in patch 616
 N I,%ZIS,POP,DIR,DTOUT,DIRUT,X,Y,DUOUT,ION
 W !!,"To ensure all data is captured during the export:"
 W !!,"1. Select 'Logging...' from the File Menu. Select your file, and where to save."
 W !,"2. On the Setup menu, select 'Display...',then 'screen' tab and modify 'columns'",!,"   setting to at least 225 characters."
 W !,"3. The DEVICE input for the columns should also contain a large enough",!,"   parameter (e.g. 225).  The DEVICE prompt is defaulted to 0;225;99999 for you.",!,"   You may change it if need be."
 W !,"Example: DEVICE: 0;225;99999 *Where 0 is your screen, 225 is the margin width",!?17,"and 99999 is the screen length."
 W !!,"NOTE:  In order for all number fields, such as SSN and Feeder Key, to be",!,"displayed correctly in the spreadsheet, these fields must be formatted as Text",!,"when importing the data into the spreadsheet.",!
 S %ZIS="N",%ZIS("B")="0;225;99999" D ^%ZIS S:POP IOP="^" S:'POP IOP=ION_";"_$G(IOM)_";"_$G(IOSL)
