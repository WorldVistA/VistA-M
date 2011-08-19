PXRRPAD ;ISL/PKR,ALB/Zoltan - Driver for PCE Patient Activity Reports.;9/22/98
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**18,61**;Aug 12, 1996
MAIN ;
 N PXRRPAJB,PXRRPAST,PXRRIOD,PXRROPT,PXRRQUE,PXRRXTMP
 S PXRRXTMP=$$PXRRXTMP^PXRRWLD("PXRRPA")
 S ^XTMP(PXRRXTMP,0)=$$FMADD^XLFDT(DT,7)_U_DT_U_"PXRR Patient Activity"
 ;
 ;Establish the selection criteria.
FAC ;Get the facility list.
 N NFAC,PXRRFAC,PXRRFACN
 D FACILITY^PXRRLCSC
 I $D(DTOUT)!$D(DUOUT) G EXIT
 ;
LOC ;Get the location list.
 N NCS,NHL,PXRRCS,PXRRLCHL,PXRRLCSC
 D LOC^PXRRLCSC("Determine patient activity for","HS")
 I $D(DTOUT) G EXIT
 I $D(DUOUT) G FAC
 ;
NEWPAGE ;See if the user wants each location to start a new page.
 N PXRRLCNP
 S PXRRLCNP=0
 I (+$G(NCS)>1)!(+$G(NHL)>1)!($P(PXRRLCSC,U,1)="CA")!($P(PXRRLCSC,U,1)="HA") D
 . D NEWPAGE^PXRRLCSC
 I $D(DTOUT) G EXIT
 I $D(DUOUT) G LOC
 ;
APDR ;Get the appointment date range.
 N BHT,EHT,PXRRBADT,PXRREADT
 S BHT(1)="Enter the beginning date to use for identifying patients"
 S BHT(2)="with appointments for a location. This date can be a past"
 S BHT(3)="or future date. For example, if you want to include patients"
 S BHT(4)="you'll be seeing next week, the date"
 S BHT(5)="range might be next Monday's date for the APPOINTMENT"
 S BHT(6)="BEGINNING DATE and next Friday's date for the APPOINTMENT"
 S BHT(7)="ENDING DATE."
 S EHT(1)="Enter the ending date to use for identifying patients"
 S EHT(2)=BHT(2)
 S EHT(3)=BHT(3)
 S EHT(4)=BHT(4)
 S EHT(5)=BHT(5)
 S EHT(6)=BHT(6)
 S EHT(7)=BHT(7)
 D GDR^PXRRADUT(.PXRRBADT,.PXRREADT,"PATIENT APPOINTMENT",.BHT,.EHT)
 I $D(DTOUT) G EXIT
 I $D(DUOUT) G NEWPAGE
 ;
ACDR ;Get the activity date range.
 N PXRRBCDT,PXRRECDT
 K BHT,EHT
 S BHT(1)="Enter the beginning date for reporting patient activities."
 S BHT(2)="This date cannot be a future date. Patient activities include"
 S BHT(3)="inpatient activities, emergency room visits, and critical"
 S BHT(4)="lab values. For example, if you want to see the last 90"
 S BHT(5)="days of patient activity for patients with appointments"
 S BHT(6)="within the appointment date range then this date would be"
 S BHT(7)="T-90 and the PATIENT ACTIVITY ENDING DATE would be T (today)."
 S EHT(1)="Enter the ending date for reporting patient activities."
 S EHT(2)="This date cannot be future date or previous to the beginning"
 S EHT(3)="date. For example, if you want to see the last 90"
 S EHT(4)="days of patient activity for patients with appointments"
 S EHT(5)="within the appointment date range then then the PATIENT"
 S EHT(6)="PATIENT ACTIVITY BEGINNING DATE would be T-90"
 S EHT(7)="and this date T (today), the default."
 D PDR^PXRRADUT(.PXRRBCDT,.PXRRECDT,"PATIENT ACTIVITY",.BHT,.EHT)
 I $D(DTOUT) G EXIT
 I $D(DUOUT) G APDR
 ;
FUTDR ;Get the future appointment date range.
 N PXRRBFDT,PXRREFDT
 K BHT,EHT
 S BHT(1)="Enter the beginning date for searching for future"
 S BHT(2)="patient appointments. This cannot be a past date, the"
 S BHT(3)="default is T (today)."
 S EHT(1)="Enter the ending date for searching for future"
 S EHT(2)="patient appointments."
 D FDR^PXRRADUT(.PXRRBFDT,.PXRREFDT,"FUTURE APPOINTMENT",.BHT,.EHT)
 I $D(DTOUT) G EXIT
 I $D(DUOUT) G ACDR
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
 . S DESC="Patient Activity Report - sort appointments"
 . S IODEV=""
 . S ROUTINE="SORT^PXRRPASA"
 . S ^XTMP(PXRRXTMP,"SORTZTSK")=$$QUE^PXRRQUE(DESC,IODEV,ROUTINE,"SAVE^PXRRPAD")
 .;
 . S DESC="Patient Activity Report - patient activities"
 . S IODEV=""
 . S ROUTINE="PAT^PXRRPAPI"
 . S ZTDTH="@"
 . S ^XTMP(PXRRXTMP,"PATZTSK")=$$QUE^PXRRQUE(DESC,IODEV,ROUTINE,"SAVE^PXRRPAD")
 .;
 . S DESC="Patient Activity Report - print"
 . S IODEV=PXRRIOD
 . S ROUTINE="PXRRPAPR"
 . S ZTDTH="@"
 . S ^XTMP(PXRRXTMP,"PRZTSK")=$$QUE^PXRRQUE(DESC,IODEV,ROUTINE,"SAVE^PXRRPAD")
 E  D SORT^PXRRPASA
 Q
 ;
 ;=======================================================================
EXIT ;
 D EXIT^PXRRGUT
 Q
 ;
 ;=======================================================================
SAVE ;Save the variables for queing.
 S ZTSAVE("PXRRBADT")="",ZTSAVE("PXRREADT")=""
 S ZTSAVE("PXRRBCDT")="",ZTSAVE("PXRRECDT")=""
 S ZTSAVE("PXRRBFDT")="",ZTSAVE("PXRREFDT")=""
 S ZTSAVE("PXRRCS(")="",ZTSAVE("NCS")=""
 S ZTSAVE("PXRRFAC(")="",ZTSAVE("NFAC")=""
 S ZTSAVE("PXRRFACN(")=""
 S ZTSAVE("PXRRIOD")=""
 S ZTSAVE("PXRRLCHL(")="",ZTSAVE("NHL")=""
 S ZTSAVE("PXRRLCNP")=""
 S ZTSAVE("PXRRLCSC")=""
 S ZTSAVE("PXRRQUE")=""
 S ZTSAVE("PXRRXTMP")=""
 Q
 ;
