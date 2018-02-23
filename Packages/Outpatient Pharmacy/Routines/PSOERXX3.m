PSOERXX3 ;ALB/BWF - eRx xml utilities ; 8/3/2016 5:14pm
 ;;7.0;OUTPATIENT PHARMACY;**467**;DEC 1997;Build 153
 ;
 Q
PATIENT(GBL,IEN) ;
 N F,PATREL,LNAME,FNAME,MNAME,SUFF,PREF,GENDER,DOB,ADDL1,ADDL2,CITY,STATE,ZIP,PLQ,CUNIT,BED,ROOM,PSDAT,ILOOP
 N ITYP,IVAL,CLOOP,CNUM,CQUAL,PIEN,PIENS,PSSN
 S F=52.46
 S PIEN=$$GET1^DIQ(52.49,IEN,.04,"I") Q:'PIEN
 S PIENS=PIEN_","
 D GETS^DIQ(F,PIENS,"**","IE","PSDAT")
 S PATREL=$G(PSDAT(F,PIENS,1.7,"I"))
 S LNAME=$$SYMENC^MXMLUTL($G(PSDAT(F,PIENS,.02,"E")))
 S FNAME=$$SYMENC^MXMLUTL($G(PSDAT(F,PIENS,.03,"E")))
 S MNAME=$$SYMENC^MXMLUTL($G(PSDAT(F,PIENS,.04,"E")))
 S SUFF=$$SYMENC^MXMLUTL($G(PSDAT(F,PIENS,.05,"E")))
 S PREF=$$SYMENC^MXMLUTL($G(PSDAT(F,PIENS,.06,"E")))
 S GENDER=$G(PSDAT(F,PIENS,.07,"I"))
 ; DOB NEEDS TO BE CONVERTED
 S DOB=$G(PSDAT(F,PIENS,.08,"I")) I DOB S DOB=$P($$EXTIME^PSOERXO1(DOB),"T")
 S ADDL1=$$SYMENC^MXMLUTL($G(PSDAT(F,PIENS,3.1,"E")))
 S ADDL2=$$SYMENC^MXMLUTL($G(PSDAT(F,PIENS,3.2,"E")))
 S CITY=$$SYMENC^MXMLUTL($G(PSDAT(F,PIENS,3.3,"E")))
 S STATE=$G(PSDAT(F,PIENS,3.4,"I"))
 I STATE S STATE=$$GET1^DIQ(5,STATE,1,"E")
 S ZIP=$G(PSDAT(F,PIENS,3.5,"E"))
 S PLQ=$G(PSDAT(F,PIENS,1.6,"E"))
 S PSSN=$G(PSDAT(F,PIENS,1.4,"E"))
 ; FUTURE ENHANCEMENT, GRAB CUNIT/BED/ROOM FROM CORRECT LOCATIONS. THIS LOGIC IS NOT ACTIVE WITH VERSION 2 
 S CUNIT=$$SYMENC^MXMLUTL($G(PSDAT(F,PIENS,1,"E")))
 S BED=$$SYMENC^MXMLUTL($G(PSDAT(F,PIENS,1,"E")))
 S ROOM=$$SYMENC^MXMLUTL($G(PSDAT(F,PIENS,1,"E")))
 D C S @GBL@(CNT,0)="<Patient>"
 I $L(PATREL) D C S @GBL@(CNT,0)="<PatientRelationship>"_PATREL_"</PatientRelationship>"
 I '$O(^PS(52.46,PIEN,5,0)) D
 .I PSSN D
 ..D C S @GBL@(CNT,0)="<Identification>"
 ..D C S @GBL@(CNT,0)="<SocialSecurity>"_PSSN_"</SocialSecurity>"
 ..D C S @GBL@(CNT,0)="</Identification>"
 I $O(^PS(52.46,PIEN,5,0)) D
 .D C S @GBL@(CNT,0)="<Identification>"
 .S ILOOP=0 F  S ILOOP=$O(^PS(52.46,PIEN,5,ILOOP)) Q:'ILOOP  D
 ..S ITYP=$$GET1^DIQ(52.465,ILOOP_","_PIENS,.01,"E")
 ..S IVAL=$$GET1^DIQ(52.465,ILOOP_","_PIENS,.02,"E")
 ..D IDENT^PSOERXX2(.GBL,ITYP,IVAL)
 .D C S @GBL@(CNT,0)="</Identification>"
 D C S @GBL@(CNT,0)="<Name>"
 I $L(LNAME) D C S @GBL@(CNT,0)="<LastName>"_LNAME_"</LastName>"
 I $L(FNAME) D C S @GBL@(CNT,0)="<FirstName>"_FNAME_"</FirstName>"
 I $L(MNAME) D C S @GBL@(CNT,0)="<MiddleName>"_MNAME_"</MiddleName>"
 I $L(SUFF) D C S @GBL@(CNT,0)="<Suffix>"_SUFF_"</Suffix>"
 I $L(PREF) D C S @GBL@(CNT,0)="<Prefix>"_PREF_"</Prefix>"
 D C S @GBL@(CNT,0)="</Name>"
 I $L(GENDER) D C S @GBL@(CNT,0)="<Gender>"_GENDER_"</Gender>"
 I $L(DOB) D
 .D C S @GBL@(CNT,0)="<DateOfBirth>"
 .D C S @GBL@(CNT,0)="<Date>"_DOB_"</Date>"
 .D C S @GBL@(CNT,0)="</DateOfBirth>"
 I $L(ADDL1) D
 .D C S @GBL@(CNT,0)="<Address>"
 .I $L(ADDL1) D C S @GBL@(CNT,0)="<AddressLine1>"_ADDL1_"</AddressLine1>"
 .I $L(ADDL2) D C S @GBL@(CNT,0)="<AddressLine2>"_ADDL2_"</AddressLine2>"
 .I $L(CITY) D C S @GBL@(CNT,0)="<City>"_CITY_"</City>"
 .I $L(STATE) D C S @GBL@(CNT,0)="<State>"_STATE_"</State>"
 .I $L(ZIP) D C S @GBL@(CNT,0)="<ZipCode>"_ZIP_"</ZipCode>"
 .I $L(PLQ) D C S @GBL@(CNT,0)="<PlaceLocationQualifier>"_PLQ_"</PlaceLocationQualifier>"
 .D C S @GBL@(CNT,0)="</Address>"
 I $O(^PS(52.46,PIEN,3,0)) D
 .D C S @GBL@(CNT,0)="<CommunicationNumbers>"
 .S CLOOP=0 F  S CLOOP=$O(^PS(52.46,PIEN,3,CLOOP)) Q:'CLOOP  D
 ..S CNUM=$$GET1^DIQ(52.462,CLOOP_","_PIENS,.01,"E")
 ..S CQUAL=$$GET1^DIQ(52.462,CLOOP_","_PIENS,.02,"I")
 ..D COMMNUM^PSOERXX2(.GBL,CNUM,CQUAL)
 .D C S @GBL@(CNT,0)="</CommunicationNumbers>"
 I $L(CUNIT)!($L(BED))!($L(ROOM)) D
 .D C S @GBL@(CNT,0)="<PatientLocation>"
 .I $L(CUNIT) D C S @GBL@(CNT,0)="<FacilityUnit>"_CUNIT_"</FacilityUnit>"
 .I $L(BED) D C S @GBL@(CNT,0)="<Bed>"_BED_"</Bed>"
 .I $L(ROOM) D C S @GBL@(CNT,0)="<Room>"_ROOM_"</Room>"
 .D C S @GBL@(CNT,0)="</PatientLocation>"
 D C S @GBL@(CNT,0)="</Patient>"
 Q
FILLST(GBL,FTYPE,FNOTE) ;
 D C S @GBL@(CNT,0)="<FillStatus>"
 D C S @GBL@(CNT,0)=$S(FTYPE="F":"<Filled>",FTYPE="P":"<PartialFill>",1:"")
 D C S @GBL@(CNT,0)="<Note>"_FNOTE_"</Note>"
 D C S @GBL@(CNT,0)=$S(FTYPE="F":"</Filled>",FTYPE="P":"</PartialFill>",1:"")
 D C S @GBL@(CNT,0)="</FillStatus>"
 Q
BENEFITS(GBL,IEN) ;
 N F,NCPDPID,NCPDPID,PAYNAME,CARDID,LNAME,FNAME,MNAME,SUFF,PREF,GID,PSDAT,BIENS,BLOOP
 S IENS=IEN_","
 S F=52.4918
 I '$O(^PS(52.49,IEN,18,0)) Q
 D C S @GBL@(CNT,0)="<BenefitsCoordination>"
 S BLOOP=0 F  S BLOOP=$O(^PS(52.49,IEN,18,BLOOP)) Q:'BLOOP  D
 .S BIENS=BLOOP_","_IENS
 .D GETS^DIQ(F,BIENS,"**","IE","PSDAT")
 .; FUTURE ENHANCEMENT - the IDENTIFICATION multiple is where the NCPDPID info belongs, USE IDENTIFICATION MULTIPLE IN THE PAYER SUBFILE
 .;S NCPDPID=$G(PSDAT(F,IENS,1,"E"))
 .;FUTURE ENHANCEMENT - STORE PAYER NAME DIFFERENTLY AN..35
 .S PAYNAME=$E($G(PSDAT(F,BIENS,.03,"E")),1,35)
 .S CARDID=$G(PSDAT(F,BIENS,.01,"E"))
 .S LNAME=$G(PSDAT(F,BIENS,1,"E"))
 .S FNAME=$G(PSDAT(F,BIENS,2,"E"))
 .S MNAME=$G(PSDAT(F,BIENS,3,"E"))
 .S SUFF=$G(PSDAT(F,BIENS,4,"E"))
 .S PREF=$G(PSDAT(F,BIENS,5,"E"))
 .S GID=$G(PSDAT(F,BIENS,.02,"E"))
 .; FUTURE ENHANCEMENT, INCLUDE PAYER IDENTIFICATION INFORMATION
 .;D C S @GBL@(CNT,0)="<PayerIdentification>"
 .;S IDLOOP=0 F  S IDLOOP=$O(^PS(52.49,IEN,18,BLOOP,6,IDLOOP)) Q:'IDLOOP  D
 .;.S ITYP=$$GET1^DIQ(52.49186,IDLOOP_","_BLOOP_","_IENS,.01,"E")
 .;.S IVAL=$$GET1^DIQ(52.49186,IDLOOP_","_BLOOP_","_IENS,.02,"E")
 .;.D IDENT(.GBL,ITYP,IVAL)
 .;D C S @GBL@(CNT,0)="</PayerIdentification>"
 .;D C S @GBL@(CNT,0)="<PayerName>"_PAYNAME_"</PayerName>"
 .I $L(CARDID) D C S @GBL@(CNT,0)="<CardholderID>"_CARDID_"</CardholderID>"
 .D C S @GBL@(CNT,0)="<CardHolderName>"
 .I $L(LNAME) D C S @GBL@(CNT,0)="<LastName>"_LNAME_"</LastName>"
 .I $L(FNAME) D C S @GBL@(CNT,0)="<FirstName>"_FNAME_"</FirstName>"
 .I $L(MNAME) D C S @GBL@(CNT,0)="<MiddleName>"_MNAME_"</MiddleName>"
 .I $L(SUFF) D C S @GBL@(CNT,0)="<Suffix>"_SUFF_"</Suffix>"
 .I $L(PREF) D C S @GBL@(CNT,0)="<Prefix>"_PREF_"</Prefix>"
 .D C S @GBL@(CNT,0)="</CardHolderName>"
 .I $L(GID) D C S @GBL@(CNT,0)="<GroupID>"_GID_"</GroupID>"
 D C S @GBL@(CNT,0)="</BenefitsCoordination>"
 Q
OBSERVE(GBL,IEN) ;
 N F,DIMENS,VALUE,OBDATE,MDQ,MSC,MUC,OBNOTE,PSDAT,OIENS,OLOOP
 S F=52.4914
 S IENS=IEN_","
 S OLOOP=0 F  S OLOOP=$O(^PS(52.49,IEN,14,OLOOP)) Q:'OLOOP  D
 .S OIENS=OLOOP_","_IENS
 .D GETS^DIQ(F,OIENS,"**","IE","PSDAT")
 .S DIMENS=$G(PSDAT(F,OIENS,.02,"E"))
 .S VALUE=$G(PSDAT(F,OIENS,.03,"E"))
 .; convert observation date
 .S OBDATE=$G(PSDAT(F,OIENS,.04,"I")) I OBDATE S OBDATE=$P($$EXTIME^PSOERXO1(OBDATE),"T")
 .S MDQ=$G(PSDAT(F,OIENS,.05,"I"))
 .S MSC=$G(PSDAT(F,OIENS,.06,"E"))
 .S MUC=$G(PSDAT(F,OIENS,.07,"E"))
 .S OBNOTE=$G(PSDAT(F,OIENS,15,"E"))
 .D C S @GBL@(CNT,0)="<Observation>"
 .D C S @GBL@(CNT,0)="<Measurement>"
 .D C S @GBL@(CNT,0)="<Dimension>"_DIMENS_"</Dimension>"
 .D C S @GBL@(CNT,0)="<Value>"_VALUE_"</Value>"
 .I $L(OBDATE) D
 ..D C S @GBL@(CNT,0)="<ObservationDate>"
 ..D C S @GBL@(CNT,0)="<Date>"_OBDATE_"</Date>"
 ..D C S @GBL@(CNT,0)="</ObservationDate>"
 .I $L(MDQ) D C S @GBL@(CNT,0)="<MeasurementDataQualifier>"_MDQ_"</MeasurementDataQualifier>"
 .I $L(MSC) D C S @GBL@(CNT,0)="<MeasurementSourceCode>"_MSC_"</MeasurementSourceCode>"
 .I $L(MUC) D C S @GBL@(CNT,0)="<MeasurementUnitCode>"_MUC_"</MeasurementUnitCode>"
 .D C S @GBL@(CNT,0)="</Measurement>"
 .I $L(OBNOTE) D
 ..D C S @GBL@(CNT,0)="<ObservationNotes>"_OBNOTE_"</ObservationNotes>"
 .D C S @GBL@(CNT,0)="</Observation>"
 Q
DRUGEVAL(GBL,IEN) ;
 N F,SRC,PSC,SERVRC,CAID,CAQ,CSC,AR,PSDAT,DLOOP
 Q
 S F=52.4916
 S DLOOP=0 F  S DLOOP=$O(^PS(52.49,IEN,16,DLOOP)) Q:'DLOOP  D
 .S IENS=IEN_","_DLOOP_","
 .K PSDAT D GETS^DIQ(F,IENS,"**","IE","PSDAT")
 .S SRC=$G(PSDAT(F,IENS,.01,"E"))
 .S PSC=$G(PSDAT(F,IENS,.02,"E"))
 .S SERVRC=$G(PSDAT(F,IENS,.03,"E"))
 .S CAID=$G(PSDAT(F,IENS,.04,"E"))
 .S CAQ=$G(PSDAT(F,IENS,.05,"E"))
 .S CSC=$G(PSDAT(F,IENS,.06,"E"))
 .S AR=$G(PSDAT(F,IENS,1,"E"))
 .D C S @GBL@(CNT,0)="<DrugUseEvaluation>"
 .D C S @GBL@(CNT,0)="<ServiceReasonCode>"_SRC_"</ServiceReasonCode>"
 .D C S @GBL@(CNT,0)="<ProfessionalServiceCode>"_PSC_"</ProfessionalServiceCode>"
 .D C S @GBL@(CNT,0)="<ServiceResultCode>"_SERVRC_"</ServiceResultCode>"
 .D C S @GBL@(CNT,0)="<CoAgent>"
 .D C S @GBL@(CNT,0)="<CoAgentID>"_CAID_"</CoAgentID>"
 .D C S @GBL@(CNT,0)="<CoAgentQualifier>"_CAQ_"</CoAgentQualifier>"
 .D C S @GBL@(CNT,0)="</CoAgent>"
 .D C S @GBL@(CNT,0)="<ClinicalSignificanceCode>"_CSC_"</ClinicalSignificanceCode>"
 .D C S @GBL@(CNT,0)="<AcknowledgementReason>"_AR_"</AcknowledgementReason>"
 .D C S @GBL@(CNT,0)="</DrugUseEvaluation>"
 Q
DIAGNOS(GBL,IENS) ;
 N F,CIQ,PQUAL,PVAL,SQUAL,SVAL,PSDAT
 S F=52.499
 D GETS^DIQ(F,IENS,"**","IE","PSDAT")
 S CIQ=$G(PSDAT(F,IENS,1,"E"))
 S PQUAL=$G(PSDAT(F,IENS,1,"E"))
 S PVAL=$G(PSDAT(F,IENS,1,"E"))
 S SQUAL=$G(PSDAT(F,IENS,1,"E"))
 S SVAL=$G(PSDAT(F,IENS,1,"E"))
 ;FUTURE ENHANCEMENT - FOR NOW JUST BUILD HEADER/FOOTER AND QUIT, LATER BUILD THE REST
 D C S @GBL@(CNT,0)="<Diagnosis>"
 D C S @GBL@(CNT,0)="</Diagnosis>"
 Q
 D C S @GBL@(CNT,0)="<Diagnosis>"
 D C S @GBL@(CNT,0)="<ClinicalInformationQualifier>"_CIQ_"</ClinicalInformationQualifier>"
 D C S @GBL@(CNT,0)="<Primary>"
 D C S @GBL@(CNT,0)="<Qualifier>"_PQUAL_"</Qualifier>"
 D C S @GBL@(CNT,0)="<Value>"_PVAL_"</Value>"
 D C S @GBL@(CNT,0)="</Primary>"
 D C S @GBL@(CNT,0)="<Secondary>"
 D C S @GBL@(CNT,0)="<Qualifier>"_SQUAL_"</Qualifier>"
 D C S @GBL@(CNT,0)="<Value>"_SVAL_"</VALUE>"
 D C S @GBL@(CNT,0)="</Secondary>"
 D C S @GBL@(CNT,0)="</Diagnosis>"
 Q
C ;
 S CNT=$G(CNT)+1
 Q
