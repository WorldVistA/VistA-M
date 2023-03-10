PSOERXOF ;ALB/BWF - eRx parsing Utilities ; 11/14/2019 3:46pm
 ;;7.0;OUTPATIENT PHARMACY;**581,635**;DEC 1997;Build 19
 ;
 Q
 ; REFREQ - # of refills requested (rxrenewal request messages).
MEDDIS(GBL,CNT,PSOIEN,RXIEN,ORIEN,REFREQ) ;
 N DRUGDES,PRODCODE,PCQUAL,STRENGTH,DDBCODE,DDBCQUAL,FSCODE,FCODE,SSCODE,SCODE,DEASCH,VALUE,CLQUAL,USCODE,PUC,DAYSUPP
 N F,DIRECT,NOTE,REQUAL,SUB,WDATE,LFDATE,EXDATE,EFDATE,PEND,DOD,DATEVAL,PAQUAL,PAVAL,DCS,PAS,SIGTXT,SIGLOOP
 N RXDAT,RXIENS,DRUGDES,QTY,RXDAT,RVAL,DRUGIEN,DNDC,SUBST,LESS,I,DCLOOP,DCSVAL,MEDIEN,QUOM,CLQUAL
 N ERXSFIEN,MTYPE,RESVAL,NODE,ORIGQTY
 ; this is the section we will likely be using
 S RXIENS=RXIEN_","
 S MTYPE=$$GET1^DIQ(52.49,PSOIEN,.08,"I"),RESVAL=$$GET1^DIQ(52.49,PSOIEN,52.1,"I")
 D GETS^DIQ(52,RXIENS,"1;6;7;8;9;10;10.2;101","IE","RXDAT")
 D CONVXML^PSOERXX1("RXDAT")
 S DRUGDES=$G(RXDAT(52,RXIENS,6,"E"))
 S DRUGIEN=$G(RXDAT(52,RXIENS,6,"I"))
 ;Reference to $$GETNDC^PSSNDCUT supported by IA 4707
 I DRUGIEN S DNDC=$$GETNDC^PSSNDCUT(DRUGIEN,$G(PSOSITE)),DNDC=$TR(DNDC,"-","")
 S QTY=$G(RXDAT(52,RXIENS,7,"E"))
 I QTY[".",$P(QTY,".",2)="" S QTY=$P(QTY,".")
 ;38 Original Quantity
 ;40 Remaining Quantity
 ;87 Quantity Received
 ;QS Quantity sufficient as determined by the dispensing pharmacy.
 ;   Quantity to be based on established dispensing protocols between
 ;   the prescriber and pharmacy/pharmacist.
 ; FUTURE - WHEN THIS IS USED, CLQUAL MAY NEED TO BE CALCULATED AND NOT HARD CODED
 S NODE=$S(MTYPE="N":"P",(MTYPE="RE"):"MR",1:"P")
 S ERXSFIEN=$O(^PS(52.49,PSOIEN,311,"C",NODE,0))
 ; PSO*7*635 - if the original quantity does not match the dispense quantity, return 'Unspecified - C38046'
 S ORIGQTY=$$GET1^DIQ(52.49311,ERXSFIEN_","_PSOIEN_",",2.1,"E")
 S CLQUAL=$$GET1^DIQ(52.49311,ERXSFIEN_","_PSOIEN_",",2.2,"E")
 I ORIGQTY=QTY S QUOM=$$GET1^DIQ(52.49311,ERXSFIEN_","_PSOIEN_",",2.3,"E")
 I ORIGQTY'=QTY S QUOM="C38046"
 ; PSO*7*635 - end fix
 ; how to determine Unit Source Code?
 ;AA - NCI values of Diagnostic, Therapeutic, and Research Equipment - Pharmaceutical Dosage Form (http://www.cancer.gov/cancertopics/terminologyresources/page4- NCI Thesaurus)
 ;AB - NCI values of Units of Presentation (http://www.cancer.gov/cancertopics/terminologyresources/page4- NCI Thesaurus)
 ;AC - NCI values of Property or Attribute - Unit of Measure - Unit of Category - Potency Unit (http://www.cancer.gov/cancertopics/terminologyresources/page4- NCI Thesaurus)
 ; FOR NOW SET IT TO AA
 S USCODE="AA"
 S DAYSUPP=$G(RXDAT(52,RXIENS,8,"E"))
 ; DIRECTIONS COME FROM SIG, FIELD 10
 ; FUTURE ENHANCEMENT - SHOULD WE GRAB ALL INFORMATION FROM THE SIG1 MULTIPLE? 52,10.2
 S SIGLOOP=0 F  S SIGLOOP=$O(^PSRX(RXIEN,"SIG1",SIGLOOP)) Q:'SIGLOOP  D
 .I '$D(SIGTXT) S SIGTXT=$G(^PSRX(RXIEN,"SIG1",SIGLOOP,0)) Q
 .S SIGTXT=SIGTXT_" "_$G(^PSRX(RXIEN,"SIG1",SIGLOOP,0))
 S SIGTXT=$$SYMENC^MXMLUTL(SIGTXT)
 S REQUAL=$$GET1^DIQ(52.49,PSOIEN,5.7,"I")
 I REQUAL="R" S REQUAL="P"
 S SUBST=$$GET1^DIQ(52.49,PSOIEN,5.8,"I")
 S RVAL=$S($D(REFREQ):REFREQ,1:$G(RXDAT(52,RXIENS,9,"E")))
 I $D(REFREQ) S REQUAL="P"
 ; CONVERT DATE types, ALSO MAKE SURE WE NEED TO POPULATE THESE.. MAY NOT BE NEEDED
 S LFDATE=$G(RXDAT(52,RXIENS,101,"I")) I LFDATE S LFDATE=$P($$EXTIME^PSOERXO1(LFDATE),"T")
 S EXDATE=$G(RXDAT(52,RXIENS,26,"I")) I EXDATE S EXDATE=$P($$EXTIME^PSOERXO1(EXDATE),"T")
 S WDATE=$G(RXDAT(52,RXIENS,1,"I")) I WDATE S WDATE=$P($$EXTIME^PSOERXO1(WDATE),"T")
 S EFDATE=""
 D C S @GBL@(CNT,0)="<MedicationDispensed>"
 D C S @GBL@(CNT,0)="<DrugDescription>"_DRUGDES_"</DrugDescription>"
 I $L($G(DNDC)) D
 .D C S @GBL@(CNT,0)="<DrugCoded>"
 .D C S @GBL@(CNT,0)="<ProductCode>"
 .D BL(GBL,.CNT,"Code",DNDC)
 .D BL(GBL,.CNT,"Qualifier","ND")
 .D C S @GBL@(CNT,0)="</ProductCode>"
 .D C S @GBL@(CNT,0)="</DrugCoded>"
 D C S @GBL@(CNT,0)="<Quantity>"
 D C S @GBL@(CNT,0)="<Value>"_QTY_"</Value>"
 D C S @GBL@(CNT,0)="<CodeListQualifier>"_CLQUAL_"</CodeListQualifier>"
 D C S @GBL@(CNT,0)="<QuantityUnitOfMeasure>"
 D BL(GBL,.CNT,"Code",QUOM)
 D C S @GBL@(CNT,0)="</QuantityUnitOfMeasure>"
 D C S @GBL@(CNT,0)="</Quantity>"
 D C S @GBL@(CNT,0)="<DaysSupply>"_DAYSUPP_"</DaysSupply>"
 I $L(WDATE) D
 .D C S @GBL@(CNT,0)="<WrittenDate>"
 .D C S @GBL@(CNT,0)="<Date>"_WDATE_"</Date>"
 .D C S @GBL@(CNT,0)="</WrittenDate>"
 I $L(LFDATE) D
 .D C S @GBL@(CNT,0)="<LastFillDate>"
 .D C S @GBL@(CNT,0)="<Date>"_LFDATE_"</Date>"
 .D C S @GBL@(CNT,0)="</LastFillDate>"
 I $L(SUBST) D C S @GBL@(CNT,0)="<Substitutions>"_SUBST_"</Substitutions>"
 S MEDIEN=$O(^PS(52.49,PSOIEN,311,0))
 S DCLOOP=0 F  S DCLOOP=$O(^PS(52.49,PSOIEN,311,MEDIEN,7,DCLOOP)) Q:'DCLOOP  D
 .S DCSVAL=$$GET1^DIQ(52.493117,DCLOOP_","_MEDIEN_","_PSOIEN_",",.02,"E")
 .D C S @GBL@(CNT,0)="<DrugCoverageStatusCode>"_DCSVAL_"</DrugCoverageStatusCode>"
 D C S @GBL@(CNT,0)="<Sig>"
 D BL(GBL,.CNT,"SigText",SIGTXT)
 D C S @GBL@(CNT,0)="</Sig>"
 I $G(REFREQ) D BL(GBL,.CNT,"PharmacyRequestedRefills",REFREQ)
 D C S @GBL@(CNT,0)="</MedicationDispensed>"
 Q
BL(GBL,CNT,TAG,VAR) ;
 Q:VAR=""
 D C S @GBL@(CNT,0)="<"_TAG_">"_$$SYMENC^MXMLUTL(VAR)_"</"_TAG_">"
 Q
C ;
 S CNT=$G(CNT)+1
 Q
