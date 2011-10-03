PXRRWLD ;ISL/PKR,ALB/Zoltan - Driver for PCE encounter summary report.;12/1/98
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**20,61**;Aug 12, 1996
MAIN ;
 N PXRRIOD,PXRRWLJB,PXRRWLST,PXRROPT,PXRRQUE,PXRRXTMP
 S PXRRXTMP=$$PXRRXTMP("PXRRWL")
 S ^XTMP(PXRRXTMP,0)=$$FMADD^XLFDT(DT,7)_U_DT_U_"PXRR Encounter Summary"
 ;
 ;Establish the selection criteria.
FAC ;Get the facility list.
 N NFAC,PXRRFAC,PXRRFACN
 D FACILITY^PXRRLCSC
 I $D(DTOUT)!$D(DUOUT) G EXIT
 ;
LORP ;See if the report is to be by location or provider.
 N PXRRWLSC
 D WHICH("L")
 I $D(DTOUT) G EXIT
 I $D(DUOUT) G FAC
 ;
LOC ;Get the location(s) for the report.
 N NCS,NHL,PXRRCS,PXRRLCHL,PXRRLCSC
 I $P(PXRRWLSC,U,1)="L" D
 . S PXRRLCSC=""
 . D LOC^PXRRLCSC("Select ENCOUNTER LOCATION CRITERIA","HS")
 . I $P(PXRRLCSC,U,1)["C" D BYLOC^PXRRLCSC
 I $D(DTOUT) G EXIT
 I $D(DUOUT) G LORP
 ;
PRV ;Get the provider(s) for the report.
 N NCL,NPL,PXRRPECL,PXRRPRLL,PXRRPRPL,PXRRPRSC
 N PXRRMPR
 S PXRRMPR=0
 I $P(PXRRWLSC,U,1)="P" D
 . D PRV^PXRRPRSC
 . I ('$D(DTOUT))&('$D(DUOUT)) D
 .. K DIRUT,DTOUT,DUOUT
 .. S DIR(0)="YA"
 .. S DIR("A",1)="Do you want providers broken out by location?"
 .. S DIR("A")="Enter Y (YES) or N (NO) "
 .. S DIR("B")="N"
 .. W !
 .. D ^DIR K DIR
 .. I $D(DIROUT) S DTOUT=1
 .. S PXRRPRLL=Y
 I $D(DTOUT) G EXIT
 I $D(DUOUT) G LORP
 ;
DR ;Get the date range.
 N PXRRBDT,PXRREDT
 D PDR^PXRRADUT(.PXRRBDT,.PXRREDT,"ENCOUNTER")
 I $D(DTOUT) G EXIT
 I $D(DUOUT) G LORP
 ;
SCAT ;Get the service categories.
 N PXRRSCAT
 D SCAT^PXRRECSC
 I $D(DTOUT) G EXIT
 I $D(DUOUT) G DR
 ;
ENTY ;Get the encounter types.
 N PXRRENTY
 D ENTYPE^PXRRECSC
 I $D(DTOUT) G EXIT
 I $D(DUOUT) G SCAT
 ;
 ;Determine whether the report should be queued.
 S %ZIS="QM"
 W !
 D ^%ZIS
 I POP G EXIT
 S PXRRIOD=ION_";"_IOST_";"_IOM_";"_IOSL
 S PXRRQUE=$G(IO("Q"))
 ;
 I PXRRQUE D 
 . ;Queue the report.
 . N DESC,IODEV,ROUTINE
 . S DESC="Encounter Summary Report - sort encounters"
 . S IODEV=""
 . S ROUTINE="SORT^PXRRWLSE"
 . S ^XTMP(PXRRXTMP,"SEZTSK")=$$QUE^PXRRQUE(DESC,IODEV,ROUTINE,"SAVE^PXRRWLD")
 .;
 . S DESC="Encounter Summary Report - sort appointments"
 . S IODEV=""
 . S ROUTINE="SORT^PXRRWLSA"
 . S ZTDTH="@"
 . S ^XTMP(PXRRXTMP,"SAZTSK")=$$QUE^PXRRQUE(DESC,IODEV,ROUTINE,"SAVE^PXRRWLD")
 .;
 . S DESC="Encounter Summary Report - print"
 . S IODEV=PXRRIOD
 . S ROUTINE="PXRRWLPR"
 . S ZTDTH="@"
 . S ^XTMP(PXRRXTMP,"PRZTSK")=$$QUE^PXRRQUE(DESC,IODEV,ROUTINE,"SAVE^PXRRWLD")
 ;
 E  D SORT^PXRRWLSE
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
 S ZTSAVE("PXRRENTY")=""
 S ZTSAVE("PXRRFAC(")="",ZTSAVE("NFAC")=""
 S ZTSAVE("PXRRFACN(")=""
 S ZTSAVE("PXRRIOD")=""
 S ZTSAVE("PXRRLCHL(")="",ZTSAVE("NHL")=""
 S ZTSAVE("PXRRLCSC")=""
 S ZTSAVE("PXRRPECL(")="",ZTSAVE("NCL")=""
 S ZTSAVE("PXRRPRLL")=""
 S ZTSAVE("PXRRPRPL(")="",ZTSAVE("NPL")=""
 S ZTSAVE("PXRRPRSC")=""
 S ZTSAVE("PXRRQUE")=""
 S ZTSAVE("PXRRSCAT")=""
 S ZTSAVE("PXRRXTMP")=""
 S ZTSAVE("PXRRWLSC")=""
 S ZTSAVE("PXRRMPR")=""
 Q
 ;
 ;=======================================================================
WHICH(DEFAULT) ;Find out if the report is to be by location or provider.
 N X,Y
 K DIROUT,DIRUT,DTOUT,DUOUT
 S DIR(0)="S"_U_"L:Location;"
 S DIR(0)=DIR(0)_"P:Provider"
 S DIR("A")="Do the report by"
 S DIR("B")=DEFAULT
 W !!,"This report may be done by location or provider"
 D ^DIR K DIR
 I $D(DIROUT) S DTOUT=1
 I $D(DTOUT)!($D(DUOUT)) Q
 S PXRRWLSC=Y_U_Y(0)
 Q
 ;
PXRRXTMP(PXPFX) ; Extrinsic variable.
 ; Gets a unique PXRRXTMP value.
 S PFPFX=$G(PXPFX,"PXRRXTMP") ; Unizue ^XTMP prefix.
 N PXRRXTMP ; Value to return.
 N PXDONE
 I '$D(^XTMP("PXRRXTMP")) D
 . N PXCREATE ; ^XTMP Creation date.
 . N PXPURGE ; ^XTMP Purge date.
 . L +^XTMP("PXRRXTMP",0):300
 . S PXCREATE=$$DT^XLFDT ; Today's date.
 . S PXPURGE=$$HTFM^XLFDT($H+365) ; Not more than one year from today.
 . S ^XTMP("PXRRXTMP",0)=PXCREATE_"^"_PXPURGE_"^PXRR XTMP Coordination"
 . L -^XTMP("PXRRXTMP",0)
 L +^XTMP("PXRRXTMP",1):300
 S PXDONE=0
 F  D  Q:PXDONE
 . S (^XTMP("PXRRXTMP",1),PXRRXTMP)=$G(^XTMP("PXRRXTMP",1),0)+1
 . S PXRRXTMP=PXPFX_PXRRXTMP
 . Q:$D(^XTMP(PXRRXTMP))
 . Q:$D(^TMP(PXRRXTMP))
 . Q:$D(^TMP($J,PXRRXTMP))
 . S PXDONE=1
 L -^XTMP("PXRRXTMP",1)
 Q PXRRXTMP
