PXRMXDUT ; SLC/PJH - Date utilities for reminder reports. ;05/05/2006
 ;;2.0;CLINICAL REMINDERS;**4**;Feb 04, 2005;Build 21
 ;
BDHELP(HTEXT,TYPE) ;Write the beginning date help.
 I $D(HTEXT) D HELP(.HTEXT)
 I '$D(HTEXT) D
 . N BDHTEXT
 . S BDHTEXT(1)="This is the beginning date for "_TYPE_" to be included in the creation of"
 . S BDHTEXT(2)="this report."
 . D HELP^PXRMXDUT(.BDHTEXT)
 Q
 ;
EDHELP(HTEXT,TYPE) ;Write the ending date help.
 I $D(HTEXT) D HELP(.HTEXT)
 I '$D(HTEXT) D
 . N EDHTEXT
 . S EDHTEXT(1)="This is the ending date for "_TYPE_" to be included in the creation"
 . S EDHTEXT(2)="of this report."
 . D HELP^PXRMXDUT(.EDHTEXT)
 Q
 ;
SDHELP(HTEXT) ;Write the single date help.
 I $D(HTEXT) D HELP(.HTEXT)
 I '$D(HTEXT) D
 . N SDHTEXT
 . S SDHTEXT(1)="This is the date of reminder evaluation for the report"
 . D HELP^PXRMXDUT(.SDHTEXT)
 Q
 ;
FDR(BDATE,EDATE,TYPE,BHTEXT,EHTEXT) ;Get a future date range.
FBDATE ;Select the beginning date.
 N X,Y,DIR
 K DIROUT,DIRUT,DTOUT,DUOUT
 S DIR(0)="DA^"_DT_"::EFTX"
 S DIR("A")="Enter "_TYPE_" BEGINNING DATE AND TIME: "
 S DIR("B")=$$FMTE^XLFDT($$DT^XLFDT,"D")
 S DIR("PRE")="S X=$$DCHECK^PXRMDATE(X) K:X=-1 X"
 S DIR("?")="This must be a future date. For detailed help type ??"
 S DIR("??")=U_"D BDHELP^PXRMXDUT(.BHTEXT,TYPE)"
 W !
 D ^DIR K DIR
 I $D(DIROUT) S DTOUT=1
 I $D(DTOUT)!($D(DUOUT)) Q
 S BDATE=Y
 I $E(Y,6,7)="00" W $C(7),"  ?? Enter exact date" G FBDATE
 ;
FEDATE ;Select the ending date.
 S DIR(0)="DA^"_BDATE_"::ETFX"
 S DIR("A")="Enter "_TYPE_" ENDING DATE AND TIME: "
 S DIR("PRE")="S X=$$DCHECK^PXRMDATE(X) K:X=-1 X"
 S DIR("?")="This must be a future date and not before "_$$FMTE^XLFDT(BDATE,"P")_". For detailed help type ??"
 S DIR("??")=U_"D EDHELP^PXRMXDUT(.EHTEXT,TYPE)"
 D ^DIR K DIR
 I $D(DIROUT) S DTOUT=1
 I $D(DTOUT) Q
 I $D(DUOUT) G FBDATE
 S EDATE=Y
 I EDATE<DT W !,"This must be a past date. For detailed help type ??" G FEDATE
 I EDATE<BDATE W !,"The ending date cannot be before the beginning date" G FEDATE
 I $E(Y,6,7)="00" W $C(7),"  ?? Enter exact date" G FEDATE
 K DIROUT,DIRUT,DTOUT,DUOUT
 Q
 ;
GDR(BDATE,EDATE,TYPE,BHTEXT,EHTEXT) ;Get a general date range.
GBDATE ;Select the beginning date.
 N X,Y,DIR
 K DIROUT,DIRUT,DTOUT,DUOUT
 S DIR(0)="DA^::ETX"
 S DIR("A")="Enter "_TYPE_" BEGINNING DATE: "
 S DIR("PRE")="S X=$$DCHECK^PXRMDATE(X) K:X=-1 X"
 S DIR("?")="This must be a date. For detailed help type ??"
 S DIR("??")=U_"D BDHELP^PXRMXDUT(.BHTEXT,TYPE)"
 W !
 D ^DIR K DIR
 I $D(DIROUT) S DTOUT=1
 I $D(DTOUT)!($D(DUOUT)) Q
 S BDATE=Y
 I BDATE<DT W !,"This must be a past date. For detailed help type ??" G FBDATE
 ;
GEDATE ;Select the ending date.
 S DIR(0)="DA^"_BDATE_"::ETX"
 S DIR("A")="Enter "_TYPE_" ENDING DATE: "
 S DIR("PRE")="S X=$$DCHECK^PXRMDATE(X) K:X=-1 X"
 S DIR("?")="This must be a date and not before "_$$FMTE^XLFDT(BDATE,"D")_". For detailed help type ??"
 S DIR("??")=U_"D EDHELP^PXRMXDUT(.EHTEXT,TYPE)"
 D ^DIR K DIR
 I $D(DIROUT) S DTOUT=1
 I $D(DTOUT) Q
 I $D(DUOUT) G GBDATE
 S EDATE=Y
 I $E(Y,6,7)="00" W $C(7),"  ?? Enter exact date" G GEDATE
 K DIROUT,DIRUT,DTOUT,DUOUT
 Q
 ;
HELP(HTEXT) ;General help text routine. Write out the text in the HTEXT
 ;array.
 N DIWF,DIWL,DIWR,IC
 S DIWF="C70",DIWL=0,DIWR=70
 K ^UTILITY($J,"W")
 S IC=""
 F  S IC=$O(HTEXT(IC)) Q:IC=""  D
 . S X=HTEXT(IC)
 . D ^DIWP
 W !
 S IC=0
 F  S IC=$O(^UTILITY($J,"W",0,IC)) Q:IC=""  D
 . W !,^UTILITY($J,"W",0,IC,0)
 K ^UTILITY($J,"W")
 W !
 N %DT,MODE
 S MODE=$G(TYPE),%DT="F",%DT(0)=DT
 I (MODE="ADMISSION")!(MODE="ENCOUNTER") S %DT="P",%DT(0)=-DT
 D HELP^%DTC
 Q
 ;
PDR(BDATE,EDATE,TYPE,BHTEXT,EXTEXT) ;Get a past date range.
PBDATE ;Select the beginning date.
 N X,Y,DIR
 K DIROUT,DIRUT,DTOUT,DUOUT
 S DIR(0)="D^:"_DT_":EPTX"
 S DIR("A")="Enter "_TYPE_" BEGINNING DATE"
 S DIR("PRE")="S X=$$DCHECK^PXRMDATE(X) K:X=-1 X"
 S DIR("?")="This must be a past date. For detailed help type ??"
 S DIR("??")=U_"D BDHELP^PXRMXDUT(.BHTEXT,TYPE)"
 W !
 D ^DIR K DIR
 I $D(DIROUT) S DTOUT=1
 I $D(DTOUT)!($D(DUOUT)) Q
 S BDATE=Y
 I $P(BDATE,".")>DT W !,"This must be a past date. For detailed help type ??" G PBDATE
 I $E(Y,6,7)="00" W $C(7),"  ?? Enter exact date" G PBDATE
 ;
PEDATE ;Select the ending date.
 S DIR(0)="DA^"_BDATE_":"_DT_":EPTX"
 S DIR("A")="Enter "_TYPE_" ENDING DATE: "
 S DIR("PRE")="S X=$$DCHECK^PXRMDATE(X) K:X=-1 X"
 S DIR("?")="This must be a past date, but not before "_$$FMTE^XLFDT(BDATE,"D")_". For detailed help type ??"
 S DIR("??")=U_"D EDHELP^PXRMXDUT(.EHTEXT,TYPE)"
 D ^DIR K DIR
 I $D(DIROUT) S DTOUT=1
 I $D(DTOUT) Q
 I $D(DUOUT) G PBDATE
 S EDATE=Y
 I $P(EDATE,".")>DT W !,"This must be a past date. For detailed help type ??" G PEDATE
 I $E(Y,6,7)="00" W $C(7),"  ?? Enter exact date" G PEDATE
 I EDATE<BDATE W !,"The ending date cannot be less then the beginning date." G PEDATE
 K DIROUT,DIRUT,DTOUT,DUOUT
 Q
 ;
SDR(SDATE,BHTEXT,EHTEXT) ;Get a date.
SBDATE ;Select the date.
 N X,Y,DIR
 K DIROUT,DIRUT,DTOUT,DUOUT
 S DIR(0)="DA^::ETX"
 S DIR("A")="Enter EFFECTIVE DUE DATE: "
 S DIR("B")=$$FMTE^XLFDT($$DT^XLFDT,"D")
 S DIR("PRE")="S X=$$DCHECK^PXRMDATE(X) K:X=-1 X"
 S DIR("?")="Enter date for reminder evaluation. For detailed help type ??"
 S DIR("??")=U_"D SDHELP^PXRMXDUT(.BHTEXT)"
 W !
 D ^DIR K DIR
 I $D(DIROUT) S DTOUT=1
 I $D(DTOUT)!($D(DUOUT)) Q
 I $E(Y,6,7)="00" W $C(7),"  ?? Enter exact date" G SBDATE
 S SDATE=Y
 K DIROUT,DIRUT,DTOUT,DUOUT
 Q
 ;
