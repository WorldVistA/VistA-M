PXRRFDD ;ISL/PKR,ALB/Zoltan - PCE Frequency of Diagnosis report driver.;9/22/98
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**3,10,12,18,31,61**;Aug 12, 1996
MAIN ;
 N PXRRFDJB,PXRRFDST,PXRRIOD,PXRROPT,PXRRQUE,PXRRXTMP
 S PXRRXTMP=$$PXRRXTMP^PXRRWLD("PXRRFD")
 S ^XTMP(PXRRXTMP,0)=$$FMADD^XLFDT(DT,7)_U_DT_U_"PXRR Frequency of Diagnosis"
 ;
 ;Establish the selection criteria.
FAC ;Get the facility list.
 N NFAC,PXRRFAC,PXRRFACN
 D FACILITY^PXRRLCSC
 I $D(DTOUT)!$D(DUOUT) G EXIT
 ;
DR ;Get the encounter date range.
 N PXRRBDT,PXRREDT
 D PDR^PXRRADUT(.PXRRBDT,.PXRREDT,"ENCOUNTER")
 I $D(DTOUT) G EXIT
 I $D(DUOUT) G FAC
 ;
DIAG ;Get the diagnosis screening criteria.
 N PXRRFDDC
 D DIAGSC^PXRRFDSC
 I $D(DTOUT) G EXIT
 I $D(DUOUT) G DR
 ;
EATT ;Get a list of encounter screening attributes.
 N PXRRECAT
 D ECAT^PXRRECSC
 I $D(DTOUT) G EXIT
 I $D(DUOUT) G DIAG
 ;
 ;Process the screening attributes
 ;
SCAT ;Get the service categories.
 N PXRRSCAT
 I PXRRECAT["1" D
 . D SCAT^PXRRECSC
 E  S PXRRSCAT="AI"
 I $D(DTOUT) G EXIT
 I $D(DUOUT) G EATT
 ;
ETYPE ;Get the encounter types.
 ;This section is commented out so it can be easily restored if encounter
 ;types are used later.  The part of ECAT^PXRRECSC relating to this should
 ;also be restored.
 ;N PXRRETYP
 ;I PXRRECAT["2" D
 ;. D ETYPE^PXRRECSC
 ;I $D(DTOUT) G EXIT
 ;I $D(DUOUT) G EATT
 ;
LOC ;Get the locations.
 N NCS,NHL,PXRRCS,PXRRLCHL,PXRRLCSC
 I PXRRECAT["2" D
 . D LOC^PXRRLCSC("Determine frequency of diagnosis for","HS")
 I $D(DTOUT) G EXIT
 I $D(DUOUT) G EATT
 ;
PRV ;Get the provider list.
 N NCL,NPL,PXRRPECL,PXRRPRPL,PXRRPRSC
 I PXRRECAT["3" D
 . D PRV^PXRRPRSC
 I $D(DTOUT) G EXIT
 I $D(DUOUT) G EATT
 ;
DOB ;Get the patient age range.
 N PXRRDOB,PXRRDOBE,PXRRDOBS,PXRRMAXA,PXRRMINA
 I PXRRECAT["4" D
 . S PXRRMINA=$$AGE^PXRRADUT("MINIMUM",1)
 . I '$D(DTOUT)&'$D(DUOUT) D
 .. S PXRRMAXA=$$AGE^PXRRADUT("MAXIMUM",0)
 .;Convert the ages into dates of birth.
 . I +$G(PXRRMAXA)>0 S PXRRDOBS=$$DOBFA^PXRRADUT(PXRRMAXA)
 . I +$G(PXRRMINA)>0 S PXRRDOBE=$$DOBFA^PXRRADUT(PXRRMINA)
 . I ($D(PXRRDOBS))!($D(PXRRDOBE)) S PXRRDOB=1
 I $D(DTOUT) G EXIT
 I $D(DUOUT) G EATT
 ;
RACE ;Get the patient race.
 N NRACE,PXRRRACE
 I PXRRECAT["5" D
 . D RACE^PXRRFDSC
 I $D(DTOUT) G EXIT
 I $D(DUOUT) G EATT
 ;
PSEX ;Get the patient sex.
 N PXRRSEX
 I PXRRECAT["6" D
 . D SEX^PXRRFDSC
 I $D(DTOUT) G EXIT
 I $D(DUOUT) G EATT
 ;
MAX ;Get the maximum number of diagnosis counts to include in the report.
 N PXRRDMAX
 D DMAX^PXRRFDSC
 I $D(DTOUT) G EXIT
 I $D(DUOUT) G EATT
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
 .;Queue the report.
 . N DESC,IODEV,ROUTINE
 . S DESC="Frequency of Diagnosis Report - sort encounters"
 . S IODEV=""
 . S ROUTINE="SORT^PXRRFDSE"
 . S ^XTMP(PXRRXTMP,"SORTEZTSK")=$$QUE^PXRRQUE(DESC,IODEV,ROUTINE,"SAVE^PXRRFDD")
 .;
 . S DESC="Frequency of Diagnosis Report - sort diagnosis data"
 . S IODEV=""
 . S ROUTINE="SORT^PXRRFDSD"
 . S ZTDTH="@"
 . S ^XTMP(PXRRXTMP,"SORTDZTSK")=$$QUE^PXRRQUE(DESC,IODEV,ROUTINE,"SAVE^PXRRFDD")
 .;
 . S DESC="Frequency of diagnosis report - print"
 . S IODEV=PXRRIOD
 . S ROUTINE="PXRRFDP"
 . S ZTDTH="@"
 . S ^XTMP(PXRRXTMP,"PRZTSK")=$$QUE^PXRRQUE(DESC,IODEV,ROUTINE,"SAVE^PXRRFDD")
 E  D SORT^PXRRFDSE
 ;
 Q
 ;
 ;=======================================================================
EXIT ;
 D EXIT^PXRRGUT
 Q
 ;
 ;=======================================================================
SAVE ;Save the variables.
 S ZTSAVE("PXRRBDT")="",ZTSAVE("PXRREDT")=""
 S ZTSAVE("PXRRDOB")=""
 S ZTSAVE("PXRRDOBE")=""
 S ZTSAVE("PXRRDOBS")=""
 S ZTSAVE("PXRRCS(")="",ZTSAVE("NCS")=""
 S ZTSAVE("PXRRDMAX")=""
 S ZTSAVE("PXRRECAT")=""
 S ZTSAVE("PXRRETYP")=""
 S ZTSAVE("PXRRFAC(")="",ZTSAVE("NFAC")=""
 S ZTSAVE("PXRRFACN(")=""
 S ZTSAVE("PXRRFDDC")=""
 S ZTSAVE("PXRRIOD")=""
 S ZTSAVE("PXRRLCHL(")="",ZTSAVE("NHL")=""
 S ZTSAVE("PXRRLCSC")=""
 S ZTSAVE("PXRRMAXA")=""
 S ZTSAVE("PXRRMINA")=""
 S ZTSAVE("PXRRPECL(")="",ZTSAVE("NCL")=""
 S ZTSAVE("PXRRPRPL(")="",ZTSAVE("NPL")=""
 S ZTSAVE("PXRRPRSC")=""
 S ZTSAVE("PXRRQUE")=""
 S ZTSAVE("PXRRSCAT")=""
 S ZTSAVE("PXRRRACE(")="",ZTSAVE("NRACE")=""
 S ZTSAVE("PXRRSEX")=""
 S ZTSAVE("PXRRXTMP")=""
 Q
