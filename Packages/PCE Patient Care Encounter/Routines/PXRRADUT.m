PXRRADUT ;ISL/PKR - Age and date utilities for PCE reports. ;6/26/97
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**10,18**;Aug 12, 1996
 ;
 ;=======================================================================
AGE(TYPE,NEWLINE) ;Get a patient age.
 N X,Y
 K DIRUT,DTOUT,DUOUT
 S DIR(0)="NO"
 S DIR("A")="Enter "_TYPE_" AGE"
 S DIR("?")="Enter an age in years"
 S DIR("??")=U_"D AGEHELP^PXRRADUT(TYPE)"
 I NEWLINE W !
 D ^DIR K DIR
 I $D(DIROUT) S DTOUT=1
 I $D(DTOUT)!($D(DUOUT)) Q -1
 Q Y
 ;
 ;
AGEHELP(TYPE) ;Write the age selection help.
 W !!,"This is the ",TYPE," patient age for selecting encounters."
 Q
 ;
 ;=======================================================================
BDHELP(HTEXT,TYPE) ;Write the beginning date help.
 I $D(HTEXT) D HELP^PXRRADUT(.HTEXT)
 I '$D(HTEXT) D
 . N BDHTEXT
 . S BDHTEXT(1)="This is the beginning date for "_TYPE_" to be included in the creation of"
 . S BDHTEXT(2)="this report."
 . D HELP^PXRRADUT(.BDHTEXT)
 Q
 ;
 ;=======================================================================
DOBFA(AGE) ;Given an age in years return the corresponding date of birth.
 N DOB
 I (AGE=0)!(AGE="") Q 0
 S DOB=DT-(AGE*10000)
 Q DOB
 ;
 ;=======================================================================
EDHELP(HTEXT,TYPE) ;Write the ending date help.
 I $D(HTEXT) D HELP^PXRRADUT(.HTEXT)
 I '$D(HTEXT) D
 . N EDHTEXT
 . S EDHTEXT(1)="This is the ending date for "_TYPE_" to be included in the creation"
 . S EDHTEXT(2)="of this report."
 . D HELP^PXRRADUT(.EDHTEXT)
 Q
 ;
 ;=======================================================================
FDR(BDATE,EDATE,TYPE,BHTEXT,EHTEXT) ;Get a future date range.
FBDATE ;Select the beginning date.
 N X,Y
 K DIROUT,DIRUT,DTOUT,DUOUT
 S DIR(0)="DA^"_DT_"::EFTX"
 S DIR("A")="Enter "_TYPE_" BEGINNING DATE: "
 S DIR("B")=$$FMTE^XLFDT($$DT^XLFDT,"D")
 S DIR("?")="This must be a future date. For detailed help type ??"
 S DIR("??")=U_"D BDHELP^PXRRADUT(.BHTEXT,TYPE)"
 W !
 D ^DIR K DIR
 I $D(DIROUT) S DTOUT=1
 I $D(DTOUT)!($D(DUOUT)) Q
 S BDATE=Y
 I $E(Y,6,7)="00" W $C(7),"  ?? Enter exact date" G FBDATE
 ;
FEDATE ;Select the ending date.
 S DIR(0)="DA^"_BDATE_"::ETFX"
 S DIR("A")="Enter "_TYPE_" ENDING DATE: "
 S DIR("?")="This must be a future date and not before "_$$FMTE^XLFDT(BDATE,"D")_". For detailed help type ??"
 S DIR("??")=U_"D EDHELP^PXRRADUT(.EHTEXT,TYPE)"
 D ^DIR K DIR
 I $D(DIROUT) S DTOUT=1
 I $D(DTOUT) Q
 I $D(DUOUT) G FBDATE
 S EDATE=Y
 I $E(Y,6,7)="00" W $C(7),"  ?? Enter exact date" G FEDATE
 K DIROUT,DIRUT,DTOUT,DUOUT
 Q
 ;
 ;=======================================================================
GDR(BDATE,EDATE,TYPE,BHTEXT,EHTEXT) ;Get a general date range.
GBDATE ;Select the beginning date.
 N X,Y
 K DIROUT,DIRUT,DTOUT,DUOUT
 S DIR(0)="DA^::ETX"
 S DIR("A")="Enter "_TYPE_" BEGINNING DATE: "
 S DIR("?")="This must be a date. For detailed help type ??"
 S DIR("??")=U_"D BDHELP^PXRRADUT(.BHTEXT,TYPE)"
 W !
 D ^DIR K DIR
 I $D(DIROUT) S DTOUT=1
 I $D(DTOUT)!($D(DUOUT)) Q
 S BDATE=Y
 I $E(Y,6,7)="00" W $C(7),"  ?? Enter exact date" G GBDATE
 ;
GEDATE ;Select the ending date.
 S DIR(0)="DA^"_BDATE_"::ETX"
 S DIR("A")="Enter "_TYPE_" ENDING DATE: "
 S DIR("?")="This must be a date and not before "_$$FMTE^XLFDT(BDATE,"D")_". For detailed help type ??"
 S DIR("??")=U_"D EDHELP^PXRRADUT(.EHTEXT,TYPE)"
 D ^DIR K DIR
 I $D(DIROUT) S DTOUT=1
 I $D(DTOUT) Q
 I $D(DUOUT) G GBDATE
 S EDATE=Y
 I $E(Y,6,7)="00" W $C(7),"  ?? Enter exact date" G GEDATE
 K DIROUT,DIRUT,DTOUT,DUOUT
 Q
 ;
 ;=======================================================================
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
 D HELP^%DTC
 Q
 ;
 ;=======================================================================
PDR(BDATE,EDATE,TYPE,BHTEXT,EXTEXT) ;Get a past date range.
PBDATE ;Select the beginning date.
 N X,Y
 K DIROUT,DIRUT,DTOUT,DUOUT
 S DIR(0)="D^:"_DT_":EPTX"
 S DIR("A")="Enter "_TYPE_" BEGINNING DATE"
 S DIR("?")="This must be a past date. For detailed help type ??"
 S DIR("??")=U_"D BDHELP^PXRRADUT(.BHTEXT,TYPE)"
 W !
 D ^DIR K DIR
 I $D(DIROUT) S DTOUT=1
 I $D(DTOUT)!($D(DUOUT)) Q
 S BDATE=Y
 I $E(Y,6,7)="00" W $C(7),"  ?? Enter exact date" G PBDATE
 ;
PEDATE ;Select the ending date.
 S DIR(0)="DA^"_BDATE_":"_DT_":EPTX"
 S DIR("A")="Enter "_TYPE_" ENDING DATE: "
 S DIR("?")="This must be a past date, but not before "_$$FMTE^XLFDT(BDATE,"D")_". For detailed help type ??"
 S DIR("??")=U_"D EDHELP^PXRRADUT(.EHTEXT,TYPE)"
 D ^DIR K DIR
 I $D(DIROUT) S DTOUT=1
 I $D(DTOUT) Q
 I $D(DUOUT) G PBDATE
 S EDATE=Y
 I $E(Y,6,7)="00" W $C(7),"  ?? Enter exact date" G PEDATE
 K DIROUT,DIRUT,DTOUT,DUOUT
 Q
 ;
