PSOERXX4 ;ALB/BWF - eRx xml utilities ; 8/3/2016 5:14pm
 ;;7.0;OUTPATIENT PHARMACY;**467**;DEC 1997;Build 153
 ;
 Q
 ; GBL - global location
 ; IEN - erx ien
 ; REQOR - refill qualifier override (optional)
MEDPRES(GBL,IEN,REQOR) ;
 N F,DRUGDES,PRODCODE,PCQUAL,STRENGTH,DDBCODE,DDBCQUAL,FSCODE,FCODE,SSCODE,SCODE,DEASCH,QTYVAL,CLQUAL,USCODE,PUC,DAYSUPP
 N DIRECT,NOTE,REQUAL,SUB,WDATE,LFDATE,EXDATE,EFDATE,PEND,DOD,DATEVAL,PAQUAL,PAVAL,DCS,PAS,REVAL,PSDAT,DCS,DCSVAL,DCLOOP
 N IENS,SIENS,SLOOP
 S IENS=IEN_","
 S F=52.49
 D GETS^DIQ(F,IENS,"**","IE","PSDAT")
 S DRUGDES=$G(PSDAT(F,IENS,3.1,"E"))
 S PRODCODE=$G(PSDAT(F,IENS,4.1,"E"))
 S PCQUAL=$G(PSDAT(F,IENS,4.2,"I"))
 S STRENGTH=$G(PSDAT(F,IENS,4.3,"E"))
 S DDBCODE=$G(PSDAT(F,IENS,4.4,"E"))
 S DDBCQUAL=$G(PSDAT(F,IENS,4.11,"E"))
 S FSCODE=$G(PSDAT(F,IENS,4.5,"I"))
 S FCODE=$G(PSDAT(F,IENS,4.6,"E"))
 S SSCODE=$G(PSDAT(F,IENS,4.7,"I"))
 S SCODE=$G(PSDAT(F,IENS,4.8,"E"))
 S DEASCH=$G(PSDAT(F,IENS,4.9,"E"))
 S QTYVAL=$G(PSDAT(F,IENS,5.1,"E"))
 S CLQUAL=$G(PSDAT(F,IENS,5.2,"I"))
 S USCODE=$G(PSDAT(F,IENS,5.3,"I"))
 S PUC=$G(PSDAT(F,IENS,5.4,"E"))
 S DAYSUPP=$G(PSDAT(F,IENS,5.5,"E"))
 S DIRECT=$G(PSDAT(F,IENS,7,"E"))
 S NOTE=$G(PSDAT(F,IENS,8,"E"))
 S REVAL=$G(PSDAT(F,IENS,5.6,"E"))
 S REQUAL=$G(PSDAT(F,IENS,5.7,"I")) I REQUAL="R" S REQUAL="P"
 S SUB=$G(PSDAT(F,IENS,5.8,"I"))
 S WDATE=$G(PSDAT(F,IENS,5.9,"I")) I WDATE S WDATE=$P($$EXTIME^PSOERXO1(WDATE),"T")
 S LFDATE=$G(PSDAT(F,IENS,6.1,"I")) I LFDATE S LFDATE=$P($$EXTIME^PSOERXO1(LFDATE),"T")
 S EXDATE=$G(PSDAT(F,IENS,6.2,"I")) I EXDATE S EXDATE=$P($$EXTIME^PSOERXO1(EXDATE),"T")
 S EFDATE=$G(PSDAT(F,IENS,6.3,"I")) I EFDATE S EFDATE=$P($$EXTIME^PSOERXO1(EFDATE),"T")
 S PEND=$G(PSDAT(F,IENS,6.4,"I")) I PEND S PEND=$P($$EXTIME^PSOERXO1(PEND),"T")
 S DOD=$G(PSDAT(F,IENS,6.5,"I")) I DOD S DOD=$P($$EXTIME^PSOERXO1(DOD),"T")
 S DATEVAL=$G(PSDAT(F,IENS,6.6,"I")) I DATEVAL S DATEVAL=$P($$EXTIME^PSOERXO1(DATEVAL),"T")
 S PAQUAL=$G(PSDAT(F,IENS,10.3,"E"))
 S PAVAL=$G(PSDAT(F,IENS,10.2,"E"))
 S PAS=$G(PSDAT(F,IENS,10.4,"I"))
 D C S @GBL@(CNT,0)="<MedicationPrescribed>"
 D C S @GBL@(CNT,0)="<DrugDescription>"_DRUGDES_"</DrugDescription>"
 I $L(PRODCODE)!($L(PCQUAL))!($L(STRENGTH))!($L(DDBCODE))!($L(DDBCQUAL))!($L(FSCODE))!($L(FCODE))!($L(SSCODE))!($L(SCODE))!($L(DEASCH)) D
 .D C S @GBL@(CNT,0)="<DrugCoded>"
 .I $L(PRODCODE) D C S @GBL@(CNT,0)="<ProductCode>"_PRODCODE_"</ProductCode>"
 .I $L(PCQUAL) D C S @GBL@(CNT,0)="<ProductCodeQualifier>"_PCQUAL_"</ProductCodeQualifier>"
 .I $L(STRENGTH) D C S @GBL@(CNT,0)="<Strength>"_STRENGTH_"</Strength>"
 .I $L(DDBCODE) D C S @GBL@(CNT,0)="<DrugDBCode>"_DDBCODE_"</DrugDBCode>"
 .I $L(DDBCQUAL) D C S @GBL@(CNT,0)="<DrugDBCodeQualifier>"_DDBCQUAL_"</DrugDBCodeQualifier>"
 .I $L(FSCODE) D C S @GBL@(CNT,0)="<FormSourceCode>"_FSCODE_"</FormSourceCode>"
 .I $L(FCODE) D C S @GBL@(CNT,0)="<FormCode>"_FCODE_"</FormCode>"
 .I $L(SSCODE) D C S @GBL@(CNT,0)="<StrengthSourceCode>"_SSCODE_"</StrengthSourceCode>"
 .I $L(SCODE) D C S @GBL@(CNT,0)="<StrengthCode>"_SCODE_"</StrengthCode>"
 .I $L(DEASCH) D C S @GBL@(CNT,0)="<DEASchedule>"_DEASCH_"</DEASchedule>"
 .D C S @GBL@(CNT,0)="</DrugCoded>"
 I $L(QTYVAL)!($L(CLQUAL))!($L(USCODE))!($L(PUC)) D
 .D C S @GBL@(CNT,0)="<Quantity>"
 .I $L(QTYVAL) D C S @GBL@(CNT,0)="<Value>"_QTYVAL_"</Value>"
 .I $L(CLQUAL) D C S @GBL@(CNT,0)="<CodeListQualifier>"_CLQUAL_"</CodeListQualifier>"
 .I $L(USCODE) D C S @GBL@(CNT,0)="<UnitSourceCode>"_USCODE_"</UnitSourceCode>"
 .I $L(PUC) D C S @GBL@(CNT,0)="<PotencyUnitCode>"_PUC_"</PotencyUnitCode>"
 .D C S @GBL@(CNT,0)="</Quantity>"
 I $L(DAYSUPP) D C S @GBL@(CNT,0)="<DaysSupply>"_DAYSUPP_"</DaysSupply>"
 I $L(DIRECT) D C S @GBL@(CNT,0)="<Directions>"_DIRECT_"</Directions>"
 I $L(NOTE) D C S @GBL@(CNT,0)="<Note>"_NOTE_"</Note>"
 I $L(REQUAL)!($L(REVAL)) D
 .D C S @GBL@(CNT,0)="<Refills>"
 .I $L(REQUAL) D C S @GBL@(CNT,0)="<Qualifier>"_REQUAL_"</Qualifier>"
 .I $L(REVAL) D C S @GBL@(CNT,0)="<Value>"_REVAL_"</Value>"
 .D C S @GBL@(CNT,0)="</Refills>"
 I $L(SUB) D C S @GBL@(CNT,0)="<Substitutions>"_SUB_"</Substitutions>"
 I $L(WDATE) D
 .D C S @GBL@(CNT,0)="<WrittenDate>"
 .D C S @GBL@(CNT,0)="<Date>"_WDATE_"</Date>"
 .D C S @GBL@(CNT,0)="</WrittenDate>"
 I $L(LFDATE) D
 .D C S @GBL@(CNT,0)="<LastFillDate>"
 .D C S @GBL@(CNT,0)="<Date>"_LFDATE_"</Date>"
 .D C S @GBL@(CNT,0)="</LastFillDate>"
 I $L(EXDATE) D
 .D C S @GBL@(CNT,0)="<ExpirationDate>"
 .D C S @GBL@(CNT,0)="<Date>"_EXDATE_"</Date>"
 .D C S @GBL@(CNT,0)="</ExpirationDate>"
 I $L(EFDATE) D
 .D C S @GBL@(CNT,0)="<EffectiveDate>"
 .D C S @GBL@(CNT,0)="<Date>"_EFDATE_"</Date>"
 .D C S @GBL@(CNT,0)="</EffectiveDate>"
 I $L(PEND) D
 .D C S @GBL@(CNT,0)="<PeriodEnd>"
 .D C S @GBL@(CNT,0)="<Date>"_PEND_"</Date>"
 .D C S @GBL@(CNT,0)="</PeriodEnd>"
 I $L(DOD) D
 .D C S @GBL@(CNT,0)="<DeliveredOnDate>"
 .D C S @GBL@(CNT,0)="<Date>"_DOD_"</Date>"
 .D C S @GBL@(CNT,0)="</DeliveredOnDate>"
 I $L(DATEVAL) D
 .D C S @GBL@(CNT,0)="<DateValidated>"
 .D C S @GBL@(CNT,0)="<Date>"_DATEVAL_"</Date>"
 .D C S @GBL@(CNT,0)="</DateValidated>"
 ;***DO DIAGNOS, IT IS A MULTIPLE***
 I $L(PAQUAL)!($L(PAVAL)) D
 .D C S @GBL@(CNT,0)="<PriorAuthorization>"
 .I $L(PAQUAL) D C S @GBL@(CNT,0)="<Qualifier>"_PAQUAL_"</Qualifier>"
 .I $L(PAVAL) D C S @GBL@(CNT,0)="<Value>"_PAVAL_"</Value>"
 .D C S @GBL@(CNT,0)="</PriorAuthorization>"
 ;***DO DRUG USE EVAL***
 S DCLOOP=0 F  S DCS=$O(^PS(52.49,IEN,28,DCLOOP)) Q:'DCLOOP  D
 .S DCSVAL=$$GET1^DIQ(52.4928,DCLOOP_","_IENS,.02,"E")
 .D C S @GBL@(CNT,0)="<DrugCoverageStatusCode>"_DCSVAL_"</DrugCoverageStatusCode>"
 I $L(PAS) D C S @GBL@(CNT,0)="<PriorAuthorizationStatus>"_PAS_"</PriorAuthorizationStatus>"
 S SLOOP=0 F  S SLOOP=$O(^PS(52.49,IEN,11,SLOOP)) Q:'SLOOP  D
 .S SIENS=SLOOP_","_IEN_","
 .D STRUCSIG^PSOERXX5(.GBL,SIENS)
 ; STRUCTURED SIG GOES HERE
 D C S @GBL@(CNT,0)="</MedicationPrescribed>"
 Q
 ; IEN - 52.49 IEN
 ; RXIEN - Prescription IEN (file #52)
MEDDIS(GBL,RXIEN,ORIEN,PSOIEN) ;
 N DRUGDES,PRODCODE,PCQUAL,STRENGTH,DDBCODE,DDBCQUAL,FSCODE,FCODE,SSCODE,SCODE,DEASCH,VALUE,CLQUAL,USCODE,PUC,DAYSUPP
 N F,DIRECT,NOTE,REQUAL,SUB,WDATE,LFDATE,EXDATE,EFDATE,PEND,DOD,DATEVAL,PAQUAL,PAVAL,DCS,PAS
 N RXDAT,RXIENS,DRUGDES,QTY,RXDAT,RVAL
 ;S F=52.49
 ; this is the section we will likely be using
 S RXIENS=RXIEN_","
 D GETS^DIQ(52,RXIENS,"1;6;7;8;9;10;10.2;101","IE","RXDAT")
 S DRUGDES=$G(RXDAT(52,RXIENS,6,"E"))
 S QTY=$G(RXDAT(52,RXIENS,7,"E"))
 ; FUTURE ENHANCEMENTS
 ; - the qualifier may change between rxfill and refill request
 ; - consider modifying quantity code list qualifier in 52.49 to be a set of codes.
 ; this is a refill request, so the codelistqualifier will always be 38 - original quantity
 ;38 Original Quantity
 ;40 Remaining Quantity
 ;87 Quantity Received
 ;QS Quantity sufficient as determined by the dispensing pharmacy.
 ;   Quantity to be based on established dispensing protocols between
 ;   the prescriber and pharmacy/pharmacist.
 ; FUTURE - WHEN THIS IS USED, CLQUAL MAY NEED TO BE CALCULATED AND NOT HARD CODED
 S CLQUAL=38
 ; how to determine Unit Source Code?
 ;AA - NCI values of Diagnostic, Therapeutic, and Research Equipment - Pharmaceutical Dosage Form (http://www.cancer.gov/cancertopics/terminologyresources/page4- NCI Thesaurus)
 ;AB - NCI values of Units of Presentation (http://www.cancer.gov/cancertopics/terminologyresources/page4- NCI Thesaurus)
 ;AC - NCI values of Property or Attribute - Unit of Measure - Unit of Category - Potency Unit (http://www.cancer.gov/cancertopics/terminologyresources/page4- NCI Thesaurus)
 ; FOR NOW SET IT TO AA
 S USCODE="AA"
 ; FUTURE ENHANCEMENT - find out how to identify potency unit code, for now use C38046 - Not Stated explicity or in detail
 S PUC="C38046"
 S DAYSUPP=$G(RXDAT(52,RXIENS,8,"E"))
 ; DIRECTIONS COME FROM SIG, FIELD 10
 ; FUTURE ENHANCEMENT - SHOULD WE GRAB ALL INFORMATION FROM THE SIG1 MULTIPLE? 52,10.2
 S DIRECT=$E($G(^PSRX(RXIEN,"SIG1",1,0)),1,140)
 S REQUAL=$$GET1^DIQ(52.49,PSOIEN,5.7,"I") I REQUAL="R" S REQUAL="P"
 S RVAL=$G(RXDAT(52,RXIENS,9,"E"))
 ; CONVERT DATE types, ALSO MAKE SURE WE NEED TO POPULATE THESE.. MAY NOT BE NEEDED
 S LFDATE=$G(RXDAT(52,RXIENS,101,"I")) I LFDATE S LFDATE=$P($$EXTIME^PSOERXO1(LFDATE),"T")
 S EXDATE=$G(RXDAT(52,RXIENS,26,"I")) I EXDATE S EXDATE=$P($$EXTIME^PSOERXO1(EXDATE),"T")
 S WDATE=$G(RXDAT(52,RXIENS,1,"I")) I WDATE S WDATE=$P($$EXTIME^PSOERXO1(WDATE),"T")
 S EFDATE=""
 D C S @GBL@(CNT,0)="<MedicationDispensed>"
 D C S @GBL@(CNT,0)="<DrugDescription>"_DRUGDES_"</DrugDescription>"
 D C S @GBL@(CNT,0)="<Quantity>"
 D C S @GBL@(CNT,0)="<Value>"_QTY_"</Value>"
 D C S @GBL@(CNT,0)="<CodeListQualifier>"_CLQUAL_"</CodeListQualifier>"
 D C S @GBL@(CNT,0)="<UnitSourceCode>"_USCODE_"</UnitSourceCode>"
 D C S @GBL@(CNT,0)="<PotencyUnitCode>"_PUC_"</PotencyUnitCode>"
 D C S @GBL@(CNT,0)="</Quantity>"
 D C S @GBL@(CNT,0)="<DaysSupply>"_DAYSUPP_"</DaysSupply>"
 D C S @GBL@(CNT,0)="<Directions>"_DIRECT_"</Directions>"
 I $L(REQUAL)!($L(RVAL)) D
 .D C S @GBL@(CNT,0)="<Refills>"
 .I $L(REQUAL) D C S @GBL@(CNT,0)="<Qualifier>"_REQUAL_"</Qualifier>"
 .I $L(RVAL) D C S @GBL@(CNT,0)="<Value>"_RVAL_"</Value>"
 .D C S @GBL@(CNT,0)="</Refills>"
 I $L(WDATE) D
 .D C S @GBL@(CNT,0)="<WrittenDate>"
 .D C S @GBL@(CNT,0)="<Date>"_WDATE_"</Date>"
 .D C S @GBL@(CNT,0)="</WrittenDate>"
 I $L(LFDATE) D
 .D C S @GBL@(CNT,0)="<LastFillDate>"
 .D C S @GBL@(CNT,0)="<Date>"_LFDATE_"</Date>"
 .D C S @GBL@(CNT,0)="</LastFillDate>"
 I $L(EXDATE) D
 .D C S @GBL@(CNT,0)="<ExpirationDate>"
 .D C S @GBL@(CNT,0)="<Date>"_EXDATE_"</Date>"
 .D C S @GBL@(CNT,0)="</ExpirationDate>"
 I $L(EFDATE) D
 .D C S @GBL@(CNT,0)="<EffectiveDate>"
 .D C S @GBL@(CNT,0)="<Date>"_EFDATE_"</Date>"
 .D C S @GBL@(CNT,0)="</EffectiveDate>"
 D C S @GBL@(CNT,0)="</MedicationDispensed>"
 Q
MEDREQ(GBL,IEN,DDAT) ;
 N DRUGDES,PRODCODE,PCQUAL,STRENGTH,DDBCODE,DDBCQUAL,FSCODE,FCODE,SSCODE,SCODE,DEASCH,VALUE,CLQUAL,USCODE,PUC,DAYSUPP
 N F,DIRECT,NOTE,REQUAL,SUB,WDATE,LFDATE,EXDATE,EFDATE,PEND,DOD,DATEVAL,PAQUAL,PAVAL,DCS,PAS
 S F=52.49
 ; FUTURE ENHANCEMENT - FOR NOW BUILD HEADER AND FOOTER AND QUIT. tHIS MAY NEED TO LOOK AT 52.41 OR 52 FOR DATA
 S DRUGDES=$G(DDAT("DRUG"))
 S QTY=$G(DDAT("QTY"))
 S DAYSUPP=$G(DDAT("DSUP"))
 S RVAL=$G(DDAT("REF"))
 S DIRECT=$G(DDAT("DIR"))
 S REQUAL="R"
 S CLQUAL="TEST"
 S USCODE="TEST"
 S PUC="TEST"
 D C S @GBL@(CNT,0)="<MedicationRequested>"
 D C S @GBL@(CNT,0)="<DrugDescription>"_DRUGDES_"</DrugDescription>"
 D C S @GBL@(CNT,0)="<Quantity>"
 D C S @GBL@(CNT,0)="<Value>"_QTY_"</Value>"
 D C S @GBL@(CNT,0)="<CodeListQualifier>"_CLQUAL_"</CodeListQualifier>"
 D C S @GBL@(CNT,0)="<UnitSourceCode>"_USCODE_"</UnitSourceCode>"
 D C S @GBL@(CNT,0)="<PotencyUnitCode>"_PUC_"</PotencyUnitCode>"
 D C S @GBL@(CNT,0)="</Quantity>"
 D C S @GBL@(CNT,0)="<DaysSupply>"_DAYSUPP_"</DaysSupply>"
 D C S @GBL@(CNT,0)="<Directions>"_DIRECT_"</Directions>"
 D C S @GBL@(CNT,0)="<Refills>"
 D C S @GBL@(CNT,0)="<Qualifier>"_REQUAL_"</Qualifier>"
 D C S @GBL@(CNT,0)="<Value>"_RVAL_"</Value>"
 D C S @GBL@(CNT,0)="</Refills>"
 D C S @GBL@(CNT,0)="</MedicationRequested>"
 Q
C ;
 S CNT=$G(CNT)+1
 Q
