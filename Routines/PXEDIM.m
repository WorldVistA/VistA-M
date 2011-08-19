PXEDIM ;ISL/PKR - Main driver for letting users look at PCE device interface errors. ;6/7/96
 ;;1.0;PCE PATIENT CARE ENCOUNTER;;Aug 12, 1996
 ;
 ;Give the user a choice on how to look up errors.
 N TEMP,X,Y
 K DIRUT,DTOUT,DUOUT
 S DIR(0)="SO"_U_"ERN:Error Number;PDT:Processing Date and Time;EDT:Encounter Date and Time;PAT:Patient Name"
 S DIR("A")="Look up PCE device interface errors based on"
 S DIR("B")="ERN"
 S TEMP="You may look up PCE device interface errors by Error Number, Error Date and Time,"
 S TEMP=TEMP_"  Encounter Date and Time, or by Patient Name."
 S DIR("?")=TEMP
 D ^DIR K DIR
 I Y=(U_U) S DTOUT=1
 I ($D(DTOUT))!($D(DUOUT)) Q
 ;
 ;Get the detailed look up information.
 N BERN,BENDT,BERDT,EERN,EENDT,EERDT
 N OPT,PATIENT,NPATIENT
 S OPT=Y
 I OPT="EDT" D DT^PXEDILUD(.BENDT,.EENDT,"ENCOUNTER")
 I OPT="ERN" D EN^PXEDILUD(.BERN,.EERN)
 I OPT="PAT" D PAT^PXEDILUD
 I OPT="PDT" D DT^PXEDILUD(.BERDT,.EERDT,"PROCESSING")
 I ($D(DTOUT))!($D(DUOUT)) Q
 ;
 ;Make sure the scratch array is initialized.
 K ^TMP("PXEDI",$J)
 ;
 ;Look up the errors.
 I OPT="ERN" D ERN^PXEDIELU
 I OPT="PDT" D PDT^PXEDIELU
 I OPT="EDT" D EDT^PXEDIELU
 I OPT="PAT" D PAT^PXEDIELU
 ;
 I '$D(^TMP("PXEDI",$J)) D  Q
 . W !!,"There are no PCE device interface errors to process!",!
 ;
 ;Determine where the listing will be printed.
 S %ZIS="QM"
 W !
 D ^%ZIS
 I POP G END
 ;
 ;Queue the report.
 N DESC,IODEV
 I $D(IO("Q")) D 
 . S DESC="Print PCE device interface errors"
 . S IODEV=ION_";"_IOST_";"_IOM_";"_IOSL
 . S ZTSAVE("^TMP(""PXEDI"",$J,")=""
 . S ZTSAVE("BERN")="",ZTSAVE("EERN")=""
 . S ZTSAVE("BENDT")="",ZTSAVE("EENDT")=""
 . S ZTSAVE("BERDT")="",ZTSAVE("EERDT")=""
 . S ZTSAVE("PATIENT(")="",ZTSAVE("NPATIENT")=""
 . S ZTSAVE("OPT")=""
 . S ZTDESC=DESC
 . S ZTIO=IODEV
 . S ZTDTH=$$NOW^XLFDT
 . S ZTRTN="PR^PXEDIP"
 . D ^%ZTLOAD
 . I $D(ZTSK)[0 W !!,DESC_" cancelled"
 . E  W !!,DESC_" has been queued, task number "_ZTSK
 ;Non queued output.
 E  D PR^PXEDIP
 ;
END ;
 D HOME^%ZIS
 K IO("Q")
 K POP
 K ^TMP("PXEDI",$J)
 Q
