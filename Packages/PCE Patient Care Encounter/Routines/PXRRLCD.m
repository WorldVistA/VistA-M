PXRRLCD ;ISL/PKR,ALB/Zoltan - PCE Location Encounter reports driver. ;9/22/98
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**3,10,12,18,61**;Aug 12, 1996
MAIN ;
 N PXRRIOD,PXRRLCJB,PXRRLCST,PXRROPT,PXRRQUE,PXRRXTMP
 S PXRRXTMP=$$PXRRXTMP^PXRRWLD("PXRRLC")
 S ^XTMP(PXRRXTMP,0)=$$FMADD^XLFDT(DT,7)_U_DT_U_"PXRR Location Encounter Count"
 ;
 ;Establish the selection criteria.
FAC ;Get the facility list.
 N NFAC,PXRRFAC,PXRRFACN
 D FACILITY^PXRRLCSC
 I $D(DTOUT)!$D(DUOUT) G EXIT
 ;
LOC ;Get the location list.
 N NCS,NHL,PXRRCS,PXRRLCHL,PXRRLCSC
 D LOC^PXRRLCSC("Determine encounter counts for","HA")
 I $D(DTOUT) G EXIT
 I $D(DUOUT) G FAC
 ;
DR ;Get the date range.
 N PXRRBDT,PXRREDT
 D PDR^PXRRADUT(.PXRRBDT,.PXRREDT,"ENCOUNTER")
 I $D(DTOUT) G EXIT
 I $D(DUOUT) G LOC
 ;
SCAT ;Get the service categories.
 N PXRRSCAT
 D SCAT^PXRRECSC
 I $D(DTOUT) G EXIT
 I $D(DUOUT) G DR
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
 . S DESC="Location Encounter Count Report - sort"
 . S IODEV=""
 . S ROUTINE="SORT^PXRRLCSE"
 . S ^XTMP(PXRRXTMP,"SORTZTSK")=$$QUE^PXRRQUE(DESC,IODEV,ROUTINE,"SAVE^PXRRLCD")
 .;
 . S DESC="Location Encounter Count Report - print"
 . S IODEV=PXRRIOD
 . I $P(PXRRLCSC,U,1)["C" S ROUTINE="PXRRLCCP"
 . E  S ROUTINE="PXRRLCHP"
 . S ZTDTH="@"
 . S ^XTMP(PXRRXTMP,"PRZTSK")=$$QUE^PXRRQUE(DESC,IODEV,ROUTINE,"SAVE^PXRRLCD")
 E  D SORT^PXRRLCSE
 Q
 ;=======================================================================
 ;
EXIT ;
 D EXIT^PXRRGUT
 Q
 ;
 ;=======================================================================
SAVE ;Save the variables for queing.
 S ZTSAVE("PXRRBDT")="",ZTSAVE("PXRREDT")=""
 S ZTSAVE("PXRRCS(")="",ZTSAVE("NCS")=""
 S ZTSAVE("PXRRFAC(")="",ZTSAVE("NFAC")=""
 S ZTSAVE("PXRRFACN(")=""
 S ZTSAVE("PXRRIOD")=""
 S ZTSAVE("PXRRLCHL(")="",ZTSAVE("NHL")=""
 S ZTSAVE("PXRRLCSC")=""
 S ZTSAVE("PXRRQUE")=""
 S ZTSAVE("PXRRSCAT")=""
 S ZTSAVE("PXRRXTMP")=""
 Q
 ;
