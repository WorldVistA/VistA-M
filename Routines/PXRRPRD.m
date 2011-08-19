PXRRPRD ;ISL/PKR,ALB/Zoltan - PCE Provider Encounter reports driver.;9/22/98
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**3,10,12,18,61,189**;Aug 12, 1996;Build 13
MAIN ;
 N PXRRIOD,PXRRPRJB,PXRRPRST,PXRROPT,PXRRQUE,PXRRXTMP
 S PXRRXTMP=$$PXRRXTMP^PXRRWLD("PXRRPR")
 S ^XTMP(PXRRXTMP,0)=$$FMADD^XLFDT(DT,7)_U_DT_U_"PXRR Provider Encounter Count"
 ;
 ;Establish the selection criteria.
FAC ;Get the facility list.
 N NFAC,PXRRFAC,PXRRFACN
 D FACILITY^PXRRLCSC
 I $D(DTOUT)!$D(DUOUT) G EXIT
 ;
DR ;Get the date range.
 N PXRRBDT,PXRREDT
 D PDR^PXRRADUT(.PXRRBDT,.PXRREDT,"ENCOUNTER")
 I $D(DTOUT) G EXIT
 I $D(DUOUT) G FAC
 ;
SCAT ;Get the service categories.
 N PXRRSCAT
 D SCAT^PXRRECSC
 I $D(DTOUT) G EXIT
 I $D(DUOUT) G DR
 ;
PRV ;Get the provider list.
 N NCL,NPL,PXRRPECL,PXRRPRPL,PXRRPRSC
 D PRV^PXRRPRSC
 I $D(DTOUT) G EXIT
 I $D(DUOUT) G SCAT
 ;
PRTY ;Get the report type (detailed or summary).
 N PXRRPRTY
 D PRTYPE^PXRRPRSC
 I $D(DTOUT) G EXIT
 I $D(DUOUT) G PRV
 ;
 ;Determine whether the report should be queued.
 S %ZIS="QM"
 W !
 D ^%ZIS
 I POP G EXIT
 S PXRRIOD=ION_";"_IOST_";"_IOM_";"_IOSL
 S PXRRQUE=$G(IO("Q"))
 ;
 ;Queue the report.
 I PXRRQUE D 
 . N DESC,IODEV,ROUTINE
 . S DESC="Provider Encounter Count Report - sort"
 . S IODEV=""
 . S ROUTINE="SORT^PXRRPRSE"
 . S ^XTMP(PXRRXTMP,"SORTZTSK")=$$QUE^PXRRQUE(DESC,IODEV,ROUTINE,"SAVE^PXRRPRD")
 .;
 . S DESC="Provider Encounter Report - print"
 . S IODEV=PXRRIOD
 . I $P(PXRRPRTY,U,1)="D" S ROUTINE="PXRRPRDP"
 . E  S ROUTINE="PXRRPRSP"
 . S ZTDTH="@"
 . S ^XTMP(PXRRXTMP,"PRZTSK")=$$QUE^PXRRQUE(DESC,IODEV,ROUTINE,"SAVE^PXRRPRD")
 E  D SORT^PXRRPRSE
 Q
 ;=======================================================================
EXIT ;
 D EXIT^PXRRGUT
 Q
 ;
 ;=======================================================================
SAVE ;Save the variables.
 S ZTSAVE("PXRRBDT")="",ZTSAVE("PXRREDT")=""
 S ZTSAVE("PXRRCS(")="",ZTSAVE("NCS")=""
 S ZTSAVE("PXRRFAC(")="",ZTSAVE("NFAC")=""
 S ZTSAVE("PXRRFACN(")=""
 S ZTSAVE("PXRRIOD")=""
 S ZTSAVE("PXRRPECL(")="",ZTSAVE("NCL")=""
 S ZTSAVE("PXRRPRPL(")="",ZTSAVE("NPL")=""
 S ZTSAVE("PXRRPRSC")=""
 S ZTSAVE("PXRRPRTY")=""
 S ZTSAVE("PXRRQUE")=""
 S ZTSAVE("PXRRSCAT")=""
 S ZTSAVE("PXRRXTMP")=""
 S ZTSAVE("NONVA")=""
 Q
 ;
