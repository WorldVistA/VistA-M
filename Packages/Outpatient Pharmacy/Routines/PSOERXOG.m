PSOERXOG ;ALB/BWF - eRx parsing Utilities ; 11/14/2019 3:46pm
 ;;7.0;OUTPATIENT PHARMACY;**581**;DEC 1997;Build 126
 ;
 Q
 ; GBL - Global location for XML storage
 ; CNT - counter, passed by reference
 ; ERXIEN - ien of the ERx
 ; MTYP - medication type to build
 ; NOTEOVR - note override for rxchangerequest messages
MEDS(GBL,CNT,ERXIEN,MTYPE,NOTEOVR) ;
 N MEDIEN,MEDDAT,F,TYPE,DRUGDESC,DCPCODE,DCPCQUAL,DCSTRVAL,DCSTRFRM,DCSTRUOM,DCDDBC,DCDQUAL,DCDEASCH,QVAL,QCLQUAL
 N QUOM,DAYS,WDATE,SFDATE,SUBS,NUMREF,PRAUTH,PRAUTHST,NOTE,SNOMED,FMT,DONOTFIL,TZID,TZDIFF,OCAPMETH
 N REA4SUBS,SPSCRIPT,RXFILL,DELREQ,DELLOC,DIABFREQ,DIABINDC,DIABDEP,DEAVDEV,DIABNOTE,DIABDEV
 N INJREL,TREATIND,PROPHEPI,TREATCYC,NUMCYCLE,PRESREMS,RESMRISK,REMSAUTH,PHRITRTE,FLAVREQ,PHRMDOSE,NUMPACK
 N NNLDATE,NNLREAS,PSOPROD,PROVAUTH,HTAG,TAG,DIAVDEV,IENS,LFDATE,PHTITRTE,REMSRISK,MESTYPE,RESVAL
 Q:'$O(^PS(52.49,ERXIEN,311,"C",MTYPE,0))
 S MESTYPE=$$GET1^DIQ(52.49,ERXIEN,.08,"I"),RESVAL=$$GET1^DIQ(52.49,ERXIEN,52.1,"I")
 S HTAG=0
 S MEDIEN=0 F  S MEDIEN=$O(^PS(52.49,ERXIEN,311,"C",MTYPE,MEDIEN)) Q:'MEDIEN  D
 .K MEDDAT
 .S IENS=MEDIEN_","_ERXIEN_","
 .S F=52.49311
 .D GETS^DIQ(F,IENS,"**","IE","MEDDAT")
 .;populate 2017 vars
 .S TYPE=$$GET1^DIQ(F,IENS,.02,"I")
 .S TAG=$S((TYPE="P")!((MESTYPE="RE")):"MedicationPrescribed",TYPE="D":"MedicationDispensed",TYPE="R":"MedicationRequested",1:"")
 .Q:TAG=""
 .; if the header tag has not yet been built, build it. Otherwise bypass
 .I 'HTAG D
 ..D C S @GBL@(CNT,0)="<"_TAG_">" S HTAG=1
 .S DRUGDESC=$G(MEDDAT(F,IENS,.03,"E"))
 .S DCPCODE=$G(MEDDAT(F,IENS,1.1,"E"))
 .S DCPCQUAL=$G(MEDDAT(F,IENS,1.2,"E"))
 .S DCSTRVAL=$G(MEDDAT(F,IENS,1.3,"E"))
 .S DCSTRFRM=$G(MEDDAT(F,IENS,1.4,"E"))
 .S DCSTRUOM=$G(MEDDAT(F,IENS,1.5,"E"))
 .S DCDDBC=$G(MEDDAT(F,IENS,1.6,"E"))
 .S DCDQUAL=$G(MEDDAT(F,IENS,1.7,"E"))
 .S DCDEASCH=$G(MEDDAT(F,IENS,1.8,"E")) ; come back - failing to file, no result at $$presolv^psoerxa1
 .S QVAL=$G(MEDDAT(F,IENS,2.1,"E"))
 .S QCLQUAL=$G(MEDDAT(F,IENS,2.2,"E"))
 .S QUOM=$G(MEDDAT(F,IENS,2.3,"E"))
 .S DAYS=$G(MEDDAT(F,IENS,2.4,"E"))
 .S WDATE=$G(MEDDAT(F,IENS,2.5,"I")) ; will convert in future with outbound date function, yet to be built
 .S WDATE=$P(WDATE,"@",1)
 .I $G(WDATE) S WDATE=$P($$EXTIME^PSOERXO1(WDATE),"T")
 .S LFDATE=$G(MEDDAT(F,IENS,2.6,"I")) ; will convert in future with outbound date function, yet to be built
 .I $G(LFDATE) S LFDATE=$P($$EXTIME^PSOERXO1(LFDATE),"T")
 .S SUBS=$G(MEDDAT(F,IENS,2.7,"I"))
 .S NUMREF=$G(MEDDAT(F,IENS,2.8,"E"))
 .S PRAUTH=$G(MEDDAT(F,IENS,4.1,"E"))
 .S PRAUTHST=$G(MEDDAT(F,IENS,4.2,"I"))
 .S NOTE=$S($G(NOTEOVR)]"":$G(NOTEOVR),1:(MEDDAT(F,IENS,5,"E")))
 .S SNOMED=$G(MEDDAT(F,IENS,9.1,"E"))
 .S FMT=$G(MEDDAT(F,IENS,9.2,"E"))
 .S DONOTFIL=$G(MEDDAT(F,IENS,16.1,"I"))
 .S TZID=$G(MEDDAT(F,IENS,16.2,"I"))
 .S TZDIFF=$G(MEDDAT(F,IENS,16.3,"E"))
 .S OCAPMETH=$G(MEDDAT(F,IENS,16.4,"I"))
 .S REA4SUBS=$G(MEDDAT(F,IENS,16.5,"I"))
 .S SPSCRIPT=$G(MEDDAT(F,IENS,16.6,"I"))
 .S RXFILL=$G(MEDDAT(F,IENS,16.7,"E"))
 .S DELREQ=$G(MEDDAT(F,IENS,18.1,"I"))
 .S DELLOC=$G(MEDDAT(F,IENS,18.2,"I"))
 .S DIABFREQ=$G(MEDDAT(F,IENS,19.1,"E"))
 .S DIABINDC=$G(MEDDAT(F,IENS,19.2,"I"))
 .S DIABDEP=$G(MEDDAT(F,IENS,19.3,"I"))
 .S DIABDEV=$G(MEDDAT(F,IENS,19.4,"I"))
 .S DIABNOTE=$G(MEDDAT(F,IENS,19.5,"E"))
 .S INJREL=$G(MEDDAT(F,IENS,20.1,"I"))
 .S TREATIND=$G(MEDDAT(F,IENS,45.1,"I"))
 .S PROPHEPI=$G(MEDDAT(F,IENS,45.2,"I"))
 .S TREATCYC=$G(MEDDAT(F,IENS,45.3,"E"))
 .S NUMCYCLE=$G(MEDDAT(F,IENS,45.4,"E"))
 .S PRESREMS=$G(MEDDAT(F,IENS,47,"I"))
 .S REMSRISK=$G(MEDDAT(F,IENS,48.1,"E"))
 .S REMSAUTH=$G(MEDDAT(F,IENS,48.2,"E"))
 .S PHTITRTE=$G(MEDDAT(F,IENS,49.1,"E"))
 .S FLAVREQ=$G(MEDDAT(F,IENS,55.1,"I"))
 .S PHRMDOSE=$G(MEDDAT(F,IENS,56.1,"E"))
 .S NUMPACK=$G(MEDDAT(F,IENS,58.1,"E"))
 .S NNLDATE=$G(MEDDAT(F,IENS,63.1,"E"))
 .S NNLREAS=$G(MEDDAT(F,IENS,63.2,"E"))
 .S PSOPROD=$G(MEDDAT(F,IENS,63.3,"E"))
 .S PROVAUTH=$G(MEDDAT(F,IENS,63.4,"I"))
 .;BEGIN 2017 OUTBOUND BUILDING
 .D BL(GBL,.CNT,"DrugDescription",DRUGDESC)
 .I $L(DCPCODE_DCPCQUAL_DCSTRVAL_DCSTRFRM_DCSTRUOM_DCDDBC_DCDQUAL_DCDEASCH) D
 ..D C S @GBL@(CNT,0)="<DrugCoded>"
 ..I $L(DCPCODE_DCPCQUAL) D
 ...D C S @GBL@(CNT,0)="<ProductCode>"
 ...D BL(GBL,.CNT,"Code",DCPCODE)
 ...D BL(GBL,.CNT,"Qualifier",DCPCQUAL)
 ...D C S @GBL@(CNT,0)="</ProductCode>"
 ..I $L(DCSTRVAL_DCSTRFRM_DCSTRUOM) D
 ...D C S @GBL@(CNT,0)="<Strength>"
 ...D BL(GBL,.CNT,"StrengthValue",DCSTRVAL)
 ...I $L(DCSTRFRM) D
 ....D C S @GBL@(CNT,0)="<StrengthForm>"
 ....D BL(GBL,.CNT,"Code",DCSTRFRM)
 ....D C S @GBL@(CNT,0)="</StrengthForm>"
 ...I $L(DCSTRUOM) D
 ....D C S @GBL@(CNT,0)="<StrengthUnitOfMeasure>"
 ....D BL(GBL,.CNT,"Code",DCSTRUOM)
 ....D C S @GBL@(CNT,0)="</StrengthUnitOfMeasure>"
 ...D C S @GBL@(CNT,0)="</Strength>"
 ..I $L(DCDDBC_DCDQUAL) D
 ...D C S @GBL@(CNT,0)="<DrugDBCode>"
 ...D BL(GBL,.CNT,"Code",DCDDBC)
 ...D BL(GBL,.CNT,"Qualifier",DCDQUAL)
 ...D C S @GBL@(CNT,0)="</DrugDBCode>"
 ..I $L(DCDEASCH) D
 ...D C S @GBL@(CNT,0)="<DEASchedule>"
 ...D BL(GBL,.CNT,"Code",DCDEASCH)
 ...D C S @GBL@(CNT,0)="</DEASchedule>"
 ..D C S @GBL@(CNT,0)="</DrugCoded>"
 .D C S @GBL@(CNT,0)="<Quantity>"
 .D BL(GBL,.CNT,"Value",QVAL)
 .D BL(GBL,.CNT,"CodeListQualifier",QCLQUAL)
 .I $L(QUOM) D
 ..D C S @GBL@(CNT,0)="<QuantityUnitOfMeasure>"
 ..D BL(GBL,.CNT,"Code",QUOM)
 ..D C S @GBL@(CNT,0)="</QuantityUnitOfMeasure>"
 .D C S @GBL@(CNT,0)="</Quantity>"
 .D BL(GBL,.CNT,"DaysSupply",DAYS)
 .D C S @GBL@(CNT,0)="<WrittenDate>"
 .D BL(GBL,.CNT,"Date",WDATE)
 .D C S @GBL@(CNT,0)="</WrittenDate>"
 .I $L(LFDATE) D
 ..D C S @GBL@(CNT,0)="<LastFillDate>"
 ..D BL(GBL,.CNT,"Date",LFDATE)
 ..D C S @GBL@(CNT,0)="</LastFillDate>"
 .D BL(GBL,.CNT,"Substitutions",SUBS)
 .D BL(GBL,.CNT,"NumberOfRefills",NUMREF)
 .;talk to Brad about adding the refills field to satisfy med dispensed
 .D ODIAG^PSOERXOH(GBL,.CNT,ERXIEN,MEDIEN) ; outbound diagnosis
 .D BL(GBL,.CNT,"PriorAuthorization",PRAUTH)
 .D BL(GBL,.CNT,"Note",NOTE)
 .D ODUE^PSOERXOH(GBL,.CNT,ERXIEN,MEDIEN) ; outbound drug use evaluation
 .D ODCS^PSOERXOH(GBL,.CNT,ERXIEN,MEDIEN) ; outbound drug coverage status
 .D BL(GBL,.CNT,"PriorAuthorizationStatus",PRAUTHST)
 .D SIG^PSOERXOI(GBL,.CNT,ERXIEN,MEDIEN)
 .D BL(GBL,.CNT,"ReasonForSubstitutionCodeUsed",REA4SUBS)
 .D OOPHAFF^PSOERXOL(GBL,.CNT,ERXIEN,MEDIEN) ;outbound office of pharmacy affairs segment ; COME BACK - FILING ISSUE
 .I $L(DIABFREQ_DIABNOTE_DIABINDC_DIABDEP_DIABDEV) D
 ..D C S @GBL@(CNT,0)="<DiabeticSupply>"
 ..D BL(GBL,.CNT,"TestingFrequency",DIABFREQ)
 ..D BL(GBL,.CNT,"TestingFrequencyNotes",DIABNOTE)
 ..D BL(GBL,.CNT,"SupplyIndicator",DIABINDC)
 ..D BL(GBL,.CNT,"InsulinDependent",DIABDEP)
 ..D BL(GBL,.CNT,"HasAutomatedInsulinDevice",DIABDEV)
 ..D C S @GBL@(CNT,0)="</DiabeticSupply>"
 .D BL(GBL,.CNT,"InjuryRelated",INJREL)
 .D OAGENCY^PSOERXOL(GBL,.CNT,ERXIEN,MEDIEN) ;outbound agency segment
 .D OIVA^PSOERXOL(GBL,.CNT,ERXIEN,MEDIEN) ; outbound IV segment ; *****
 .D BL(GBL,.CNT,"TreatmentIndicator",TREATIND)
 .D BL(GBL,.CNT,"ProphylacticOrEpisodic",PROPHEPI)
 .D BL(GBL,.CNT,"CurrentTreatmentCycle",TREATCYC)
 .D BL(GBL,.CNT,"NumberOfCyclesPlanned",NUMCYCLE)
 .D OWOUND^PSOERXOL(GBL,.CNT,ERXIEN,MEDIEN) ;outbound wound segment
 .D OTITDSMS^PSOERXOM(GBL,.CNT,ERXIEN,MEDIEN) ; titration
 .D BL(GBL,.CNT,"FlavoringRequested",FLAVREQ)
 .D OCOMPINF^PSOERXOM(GBL,.CNT,ERXIEN,MEDIEN) ; compound ingredients
 .D BL(GBL,.CNT,"NumberOfPackagesToBeDispensed",NUMPACK)
 .D OPTCODNT^PSOERXOM(GBL,.CNT,ERXIEN,MEDIEN) ; patient codified notes
 .D OFACSPE^PSOERXOM(GBL,.CNT,ERXIEN,MEDIEN) ; facility spec admin timing
 .D OOTHMEDT^PSOERXOM(GBL,.CNT,ERXIEN,MEDIEN) ; other medication date
 .D BL(GBL,.CNT,"PlaceOfServiceNonSelfAdministeredProduct",PSOPROD)
 .D BL(GBL,.CNT,"ProviderExplicitAuthorizationToAdminister",PROVAUTH)
 D C S @GBL@(CNT,0)="</"_TAG_">"
 Q
BL(GBL,CNT,TAG,VAR) ;
 Q:VAR=""
 D C S @GBL@(CNT,0)="<"_TAG_">"_$$SYMENC^MXMLUTL(VAR)_"</"_TAG_">"
 Q
C ;
 S CNT=$G(CNT)+1
 Q
