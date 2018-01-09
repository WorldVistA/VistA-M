PSOERXX2 ;ALB/BWF - eRx xml utilities ; 8/3/2016 5:14pm
 ;;7.0;OUTPATIENT PHARMACY;**467**;DEC 1997;Build 153
 ;
 Q
MSG(GBL,HF) ;
 Q:'HF
 I HF=1 D C S @GBL@(CNT,0)="<?xml version=""1.0"" encoding=""UTF-8""?><Message version=""010"" release=""006"" HighestVersionSupported="""" xmlns=""http://www.ncpdp.org/schema/SCRIPT"">" Q
 I HF=2 D C S @GBL@(CNT,0)="</Message>"
 Q
HDR(GBL,IEN) ;
 N F,TOQUAL,TOVAL,FRQUAL,FRVAL,MID,STIME,STERTID,RTERTID,PON,RETREC,REQREF,PSDAT,INST,SSECID,RSECID
 N RTMID
 S F=52.49
 S IENS=IEN_","
 D GETS^DIQ(F,IENS,"**","IE","PSDAT")
 ; 'TO' values come from the 'FROM' fields of the eRx.
 S TOQUAL=$G(PSDAT(F,IENS,22.2,"I"))
 S TOVAL=$G(PSDAT(F,IENS,22.1,"E"))
 ; 'FROM' values come from the 'TO' fields of the eRx.
 S FRQUAL=$G(PSDAT(F,IENS,22.4,"I"))
 S FRVAL=$G(PSDAT(F,IENS,22.3,"E"))
 S INST=DUZ(2)
 ; message ID needs to be unique from vista - Site#.DUZ.erxIEN.date.time??
 S MID=INST_"."_DUZ_"."_PSOIEN_"."_$$NOW^XLFDT
 S RTMID=$G(PSDAT(F,IENS,25,"E"))
 ;
 S PON=$G(PSDAT(F,IENS,.09,"E"))
 ; return receipt and request reference # currenly not stored. Do we need to add a field in 52.49?
 S RETREC=$G(PSDAT(F,IENS,1,"E"))
 S REQREF=$G(PSDAT(F,IENS,1,"E"))
 S RETREC="ACA",REQREF=""
 S SSECID=$G(PSDAT(F,IENS,24.5,"E"))
 ; leaving this in place for now CH wanted the tertiary ID to be TECHNATOMY. I suspect this will
 ; need to be something different in the long run
 ;S STERTID=$G(PSDAT(F,IENS,24.6,"E"))
 S STERTID="TECHNATOMY"
 S RSECID=$G(PSDAT(F,IENS,24.3,"E"))
 ;S RTERTID=$G(PSDAT(F,IENS,24.4,"E"))
 S RTERTID="ERXPAD"
 D C S @GBL@(CNT,0)="<Header><To Qualifier="""_TOQUAL_""">"_TOVAL_"</To>"
 D C S @GBL@(CNT,0)="<From Qualifier="""_FRQUAL_""">"_FRVAL_"</From>"
 D C S @GBL@(CNT,0)="<MessageID>"_MID_"</MessageID>"
 I $L(RTMID) D C S @GBL@(CNT,0)="<RelatesToMessageID>"_RTMID_"</RelatesToMessageID>"
 D C S @GBL@(CNT,0)="<SentTime>"_$$EXTIME^PSOERXO1()_"</SentTime>"
 D C S @GBL@(CNT,0)="<Security>"
 ; todo -  missing UsernameToken
 D C S @GBL@(CNT,0)="<Sender>"
 ; for now we are not using secondary identifications, this will stay in place for future activation.
 ;I $L(SSECID) D C S @GBL@(CNT,0)="<SecondaryIdentification>"_SSECID_"</SecondaryIdentification>"
 I $L(STERTID) D C S @GBL@(CNT,0)="<TertiaryIdentification>"_STERTID_"</TertiaryIdentification>"
 D C S @GBL@(CNT,0)="</Sender>"
 D C S @GBL@(CNT,0)="<Receiver>"
 ;I $L(RSECID) D C S @GBL@(CNT,0)="<SecondaryIdentification>"_RSECID_"</SecondaryIdentification>"
 I $L(RTERTID) D C S @GBL@(CNT,0)="<TertiaryIdentification>"_RTERTID_"</TertiaryIdentification>"
 D C S @GBL@(CNT,0)="</Receiver>"
 D C S @GBL@(CNT,0)="</Security>"
 ; missing 'Mailbox' - note for future enhancement. Was not needed for CH certification.
 ;D C S @GBL@(CNT,0)="<PrescriberOrderNumber>"_PON_"</PrescriberOrderNumber>"
 I $L(PON) D C S @GBL@(CNT,0)="<RxReferenceNumber>"_PON_"</RxReferenceNumber>"
 D C S @GBL@(CNT,0)="</Header>"
 Q
 ; body header/footer
BHF(GBL,HF) ;
 Q:'$D(HF)
 D C
 S @GBL@(CNT,0)=$S(HF=1:"<Body>",HF=2:"</Body>",1:"")
 Q
 ;HF   1 - header
 ;     2 - footer
RTYPE(GBL,RTYPE,HF) ;
 Q:'HF
 D C
 S @GBL@(CNT,0)=$S(HF=1:"<"_RTYPE_">",HF=2:"</"_RTYPE_">",1:"")
 Q
REQUEST(GBL,RETREC,REQREF) ;
 D C S @GBL@(CNT,0)="<Request>"
 D C S @GBL@(CNT,0)="<ReturnReceipt>"_RETREC_"</ReturnReceipt>"
 D C S @GBL@(CNT,0)="<RequestReferenceNumber>"_REQREF_"</RequestReferenceNumber>"
 D C S @GBL@(CNT,0)="</Request>"
 Q
VAPHARM(GBL,PSOSITE,PSOIEN) ;
 N F,F2,NCPID,NPI,SPEC,LNAME,FNAME,MNAME,SUFF,PREF,STNM,ADDL1,ADDL2,CITY,STATE,PLQ,TELE,UIENS
 N PHIEN,PHIENS,EXPHIEN,EXPHIENS,PHARDAT,PHARDAT,PSDAT,AREA,FTELE,FULLNM,PDAT,PHRMCIST,SIENS
 N EIEN,EIENS,CMNUM,ID,IDTYP,IDVAL,CMVAL,CMQUAL
 S F=52.47,F2=52.48
 ; this is the vista pharmacy/pharmacist
 S EIEN=$$GET1^DIQ(52.49,PSOIEN,2.5,"I")
 S EIENS=EIEN_","
 S PHIEN=$$GET1^DIQ(52.49,PSOIEN,2.2,"I")
 S PHIENS=PHIEN_","
 D GETS^DIQ(F,EIENS,"**","IE","PHARDAT")
 S NCPID=$G(PHARDAT(F,EIENS,.02,"E"))
 D GETS^DIQ(F2,PHIENS,"**","IE","PHRMCIST")
 ;S FULLNM=$G(PHRMCIST(F2,UIENS,.01,"E"))
 S LNAME=$G(PHRMCIST(F2,PHIENS,.02,"E"))
 S FNAME=$G(PHRMCIST(F2,PHIENS,.03,"E"))
 S MNAME=$G(PHRMCIST(F2,PHIENS,.04,"E"))
 S SUFF=$G(PHRMCIST(F2,PHIENS,.05,"E"))
 S PREF=$G(PHRMCIST(F2,PHIENS,.06,"E"))
 S NPI=$G(PHRMCIST(F2,PHIENS,1.5,"E"))
 S STNM=$$SYMENC^MXMLUTL($G(PHARDAT(F,EIENS,.01,"E")))
 S ADDL1=$$SYMENC^MXMLUTL($G(PHARDAT(F,EIENS,1.1,"E")))
 S ADDL2=$$SYMENC^MXMLUTL($G(PHARDAT(F,EIENS,1.2,"E")))
 S CITY=$$SYMENC^MXMLUTL($G(PHARDAT(F,EIENS,1.3,"E")))
 S STATE=$G(PHARDAT(F,EIENS,1.4,"E"))
 S STATE=$$FIND1^DIC(5,,,STATE,"B") I STATE S STATE=$$GET1^DIQ(5,STATE,1,"E")
 S ZIP=$G(PHARDAT(F,EIENS,1.5,"E")),ZIP=$TR(ZIP,"-","")
 ; address missing from NewRx
 I '$L(ADDL1) D
 .S ADDL1=$$GET1^DIQ(59,PSOSITE,.02,"E")
 .S ADDL2=""
 .S CITY=$$GET1^DIQ(59,PSOSITE,.07,"E")
 .S STATE=$$GET1^DIQ(59,PSOSITE,.08,"I")
 .I STATE S STATE=$$GET1^DIQ(5,STATE,1,"E")
 .S ZIP=$E($$GET1^DIQ(59,PSOSITE,.05,"E"),1,5)
 D C S @GBL@(CNT,0)="<Pharmacy>"
 I $O(^PS(52.47,EIEN,2,0)) D
 .D C S @GBL@(CNT,0)="<Identification>"
 .S ID=0 F  S ID=$O(^PS(52.47,EIEN,2,ID)) Q:'ID  D
 ..S IDTYP=$$GET1^DIQ(52.472,ID_","_EIEN_",",.01,"E")
 ..S IDVAL=$$GET1^DIQ(52.472,ID_","_EIEN_",",.02,"E")
 ..D C S @GBL@(CNT,0)="<"_IDTYP_">"_IDVAL_"</"_IDTYP_">"
 .D C S @GBL@(CNT,0)="</Identification>"
 ;D C S @GBL@(CNT,0)="<Specialty>"_SPEC_"</Specialty>"
 I $L(LNAME) D
 .D C S @GBL@(CNT,0)="<Pharmacist>"
 .I $L(LNAME) D C S @GBL@(CNT,0)="<LastName>"_LNAME_"</LastName>"
 .I $L(FNAME) D C S @GBL@(CNT,0)="<FirstName>"_FNAME_"</FirstName>"
 .I $L(MNAME) D C S @GBL@(CNT,0)="<MiddleName>"_MNAME_"</MiddleName>"
 .I $L(SUFF) D C S @GBL@(CNT,0)="<Suffix>"_SUFF_"</Suffix>"
 .I $L(PREF) D C S @GBL@(CNT,0)="<Prefix>"_PREF_"</Prefix>"
 .D C S @GBL@(CNT,0)="</Pharmacist>"
 I $L(STNM) D C S @GBL@(CNT,0)="<StoreName>"_STNM_"</StoreName>"
 I $L(ADDL1)!($L(ADDL2))!($L(CITY))!($L(STATE))!($L(ZIP)) D
 .D C S @GBL@(CNT,0)="<Address>"
 .I $L(ADDL1) D C S @GBL@(CNT,0)="<AddressLine1>"_ADDL1_"</AddressLine1>"
 .I $L(ADDL2) D C S @GBL@(CNT,0)="<AddressLine2>"_ADDL2_"</AddressLine2>"
 .I $L(CITY) D C S @GBL@(CNT,0)="<City>"_CITY_"</City>"
 .I $L(STATE) D C S @GBL@(CNT,0)="<State>"_STATE_"</State>"
 .I $L(ZIP) D C S @GBL@(CNT,0)="<ZipCode>"_ZIP_"</ZipCode>"
 .;D C S @GBL@(CNT,0)="<PlaceLocationQualifier>"_PLQ_"</PlaceLocationQualifier>"
 .D C S @GBL@(CNT,0)="</Address>"
 I '$O(^PS(52.47,EIEN,3,0)) D
 .S CMVAL=$$GET1^DIQ(59,PSOIEN,.03,"E")
 .S CMVAL=CMVAL_$$GET1^DIQ(59,PSOIEN,.04,"E")
 .I '$L(CMVAL) S CMVAL="0000000000"
 .S CMVAL=$TR(CMVAL,"-","")
 .S CMQUAL="TE"
 .D C S @GBL@(CNT,0)="<CommunicationNumbers>"
 .D COMMNUM(.GBL,CMVAL,CMQUAL)
 .D COMMNUM(.GBL,"0000000000","FX")
 .D C S @GBL@(CNT,0)="</CommunicationNumbers>"
 I $O(^PS(52.47,EIEN,3,0)) D
 .D C S @GBL@(CNT,0)="<CommunicationNumbers>"
 .S CMNUM=0 F  S CMNUM=$O(^PS(52.47,EIEN,3,CMNUM)) Q:'CMNUM  D
 ..S CMVAL=$$GET1^DIQ(52.473,CMNUM_","_EIEN_",",.01,"E")
 ..S CMQUAL=$$GET1^DIQ(52.473,CMNUM_","_EIEN_",",.02,"I")
 ..D COMMNUM(.GBL,CMVAL,CMQUAL)
 .D C S @GBL@(CNT,0)="</CommunicationNumbers>"
 D C S @GBL@(CNT,0)="</Pharmacy>"
 Q
 ; GBL - global for xml storage
 ; IENS - ien string for the current entry
 ; FIL - top level file number
 ; SUBFIL - subfile number
COMMNUM(GBL,COMMNUM,QUAL) ;
 D C S @GBL@(CNT,0)="<Communication>"
 D C S @GBL@(CNT,0)="<Number>"_$$SYMENC^MXMLUTL(COMMNUM)_"</Number>"
 D C S @GBL@(CNT,0)="<Qualifier>"_QUAL_"</Qualifier>"
 D C S @GBL@(CNT,0)="</Communication>"
 Q
IDENT(GBL,TYPE,VAL) ;
 D C S @GBL@(CNT,0)="<"_TYPE_">"_VAL_"</"_TYPE_">"
 Q
 ; GBL - GLOBAL WHERE DATA IS STORED
 ; IEN - IEN TO 52.49
PRESCRIB(GBL,IEN) ;
 N F,DEAN,NPI,SPEC,CLINIC,LNAME,FNAME,MNAME,SUFF,PREF,ADDL1,ADDL2,CITY,STATE,ZIP,PLQ,ALNAME,AFNAME,AMNAME,ASUFF,APREF
 N PSDAT,CLOOP,CNUM,CQUAL,ILOOP,ITYP,IVAL,PIEN,PIENS
 S F=52.48,IENS=IEN_","
 S PIEN=$$GET1^DIQ(52.49,IEN,2.1,"I") Q:'PIEN
 S PIENS=PIEN_","
 D GETS^DIQ(F,PIENS,"**","IE","PSDAT")
 S DEAN=$G(PSDAT(F,PIENS,1.6,"E"))
 S NPI=$G(PSDAT(F,PIENS,1.5,"E"))
 S SPEC=$G(PSDAT(F,PIENS,1.2,"E"))
 S CLINIC=$G(PSDAT(F,PIENS,2.1,"E"))
 S LNAME=$$SYMENC^MXMLUTL($G(PSDAT(F,PIENS,.02,"E")))
 S FNAME=$$SYMENC^MXMLUTL($G(PSDAT(F,PIENS,.03,"E")))
 S MNAME=$$SYMENC^MXMLUTL($G(PSDAT(F,PIENS,.04,"E")))
 S SUFF=$$SYMENC^MXMLUTL($G(PSDAT(F,PIENS,.05,"E")))
 S PREF=$$SYMENC^MXMLUTL($G(PSDAT(F,PIENS,.06,"E")))
 S ADDL1=$$SYMENC^MXMLUTL($G(PSDAT(F,PIENS,4.1,"E")))
 S ADDL2=$$SYMENC^MXMLUTL($G(PSDAT(F,PIENS,4.2,"E")))
 S CITY=$G(PSDAT(F,PIENS,4.3,"E"))
 S STATE=$G(PSDAT(F,PIENS,4.4,"I"))
 I STATE S STATE=$$GET1^DIQ(5,STATE,1,"E")
 S ZIP=$G(PSDAT(F,PIENS,4.5,"E"))
 S PLQ=$G(PSDAT(F,PIENS,2.2,"E"))
 S ALNAME=$$SYMENC^MXMLUTL($G(PSDAT(F,PIENS,5.1,"E")))
 S AFNAME=$$SYMENC^MXMLUTL($G(PSDAT(F,PIENS,5.2,"E")))
 S AMNAME=$$SYMENC^MXMLUTL($G(PSDAT(F,PIENS,5.3,"E")))
 S ASUFF=$$SYMENC^MXMLUTL($G(PSDAT(F,PIENS,5.4,"E")))
 S APREF=$$SYMENC^MXMLUTL($G(PSDAT(F,PIENS,5.5,"E")))
 D C S @GBL@(CNT,0)="<Prescriber>"
 I $O(^PS(52.48,PIEN,6,0)) D
 .D C S @GBL@(CNT,0)="<Identification>"
 .S ILOOP=0 F  S ILOOP=$O(^PS(52.48,PIEN,6,ILOOP)) Q:'ILOOP  D
 ..S ITYP=$$GET1^DIQ(52.486,ILOOP_","_PIENS,.01,"E")
 ..S IVAL=$$GET1^DIQ(52.486,ILOOP_","_PIENS,.02,"E")
 ..D IDENT(.GBL,ITYP,IVAL)
 .D C S @GBL@(CNT,0)="</Identification>"
 I $L(SPEC) D C S @GBL@(CNT,0)="<Specialty>"_SPEC_"</Specialty>" ; ***SLASH AT THE END???
 I $L(CLINIC) D C S @GBL@(CNT,0)="<ClinicName>"_CLINIC_"</ClinicName>" ; ***SLASH AT THE END???
 D C S @GBL@(CNT,0)="<Name>"
 I $L(LNAME) D C S @GBL@(CNT,0)="<LastName>"_LNAME_"</LastName>"
 I $L(FNAME) D C S @GBL@(CNT,0)="<FirstName>"_FNAME_"</FirstName>"
 I $L(MNAME) D C S @GBL@(CNT,0)="<MiddleName>"_MNAME_"</MiddleName>"
 I $L(SUFF) D C S @GBL@(CNT,0)="<Suffix>"_SUFF_"</Suffix>"
 I $L(PREF) D C S @GBL@(CNT,0)="<Prefix>"_PREF_"</Prefix>"
 D C S @GBL@(CNT,0)="</Name>"
 D C S @GBL@(CNT,0)="<Address>"
 I $L(ADDL1) D C S @GBL@(CNT,0)="<AddressLine1>"_ADDL1_"</AddressLine1>"
 I $L(ADDL2) D C S @GBL@(CNT,0)="<AddressLine2>"_ADDL2_"</AddressLine2>"
 I $L(CITY) D C S @GBL@(CNT,0)="<City>"_CITY_"</City>"
 I $L(STATE) D C S @GBL@(CNT,0)="<State>"_STATE_"</State>"
 I $L(ZIP) D C S @GBL@(CNT,0)="<ZipCode>"_ZIP_"</ZipCode>"
 I $L(PLQ) D C S @GBL@(CNT,0)="<PlaceLocationQualifier>"_PLQ_"</PlaceLocationQualifier>"
 D C S @GBL@(CNT,0)="</Address>"
 I $O(^PS(52.48,PIEN,3,0)) D
 .D C S @GBL@(CNT,0)="<CommunicationNumbers>"
 .S CLOOP=0 F  S CLOOP=$O(^PS(52.48,PIEN,3,CLOOP)) Q:'CLOOP  D
 ..S CNUM=$$GET1^DIQ(52.483,CLOOP_","_PIENS,.01,"E")
 ..S CQUAL=$$GET1^DIQ(52.483,CLOOP_","_PIENS,.02,"I")
 ..D COMMNUM(.GBL,CNUM,CQUAL)
 .D C S @GBL@(CNT,0)="</CommunicationNumbers>"
 I $L(ALNAME) D
 .D C S @GBL@(CNT,0)="<PrescriberAgent>"
 .I $L(ALNAME) D C S @GBL@(CNT,0)="<LastName>"_ALNAME_"</LastName>"
 .I $L(AFNAME) D C S @GBL@(CNT,0)="<FirstName>"_AFNAME_"</FirstName>"
 .I $L(AMNAME) D C S @GBL@(CNT,0)="<MiddleName>"_AMNAME_"</MiddleName>"
 .I $L(ASUFF) D C S @GBL@(CNT,0)="<Suffix>"_ASUFF_"</Suffix>"
 .I $L(APREF) D C S @GBL@(CNT,0)="<Prefix>"_APREF_"</Prefix>"
 .D C S @GBL@(CNT,0)="</PrescriberAgent>"
 D C S @GBL@(CNT,0)="</Prescriber>"
 Q
SUPERVIS(GBL,IEN) ;
 N F,SLN,DEAN,SPEC,LNAME,FNAME,MNAME,SUFF,PREF,CLNAME,ADDL1,ADDL2,CITY,STATE,ZIP,PLQ,PSDAT,ILOOP,ITYP,IVAL
 N SIEN,SIENS
 S F=52.48
 S IENS=IEN_","
 S SIEN=$$GET1^DIQ(52.49,IEN,2.6,"I") Q:'SIEN
 S SIENS=SIEN_","
 D GETS^DIQ(F,SIENS,"**","IE","PSDAT")
 S SLN=$G(PSDAT(F,SIENS,1.8,"E"))
 S DEAN=$G(PSDAT(F,SIENS,1.6,"E"))
 S SPEC=$G(PSDAT(F,SIENS,1.2,"E"))
 S LNAME=$$SYMENC^MXMLUTL($G(PSDAT(F,SIENS,.02,"E")))
 S FNAME=$$SYMENC^MXMLUTL($G(PSDAT(F,SIENS,.03,"E")))
 S MNAME=$$SYMENC^MXMLUTL($G(PSDAT(F,SIENS,.04,"E")))
 S SUFF=$$SYMENC^MXMLUTL($G(PSDAT(F,SIENS,.05,"E")))
 S PREF=$$SYMENC^MXMLUTL($G(PSDAT(F,SIENS,.06,"E")))
 S CLNAME=$G(PSDAT(F,SIENS,2.1,"E"))
 S ADDL1=$$SYMENC^MXMLUTL($G(PSDAT(F,SIENS,4.1,"E")))
 S ADDL2=$$SYMENC^MXMLUTL($G(PSDAT(F,SIENS,4.2,"E")))
 S CITY=$$SYMENC^MXMLUTL($G(PSDAT(F,SIENS,4.3,"E")))
 S STATE=$G(PSDAT(F,SIENS,4.4,"I"))
 I STATE S STATE=$$GET1^DIQ(5,STATE,1,"E")
 S ZIP=$G(PSDAT(F,SIENS,4.5,"E"))
 S PLQ=$G(PSDAT(F,SIENS,2.2,"E"))
 D C S @GBL@(CNT,0)="<Supervisor>"
 I $O(^PS(52.48,SIEN,6,0)) D
 .D C S @GBL@(CNT,0)="<Identification>"
 .S ILOOP=0 F  S ILOOP=$O(^PS(52.48,SIEN,6,ILOOP)) Q:'ILOOP  D
 ..S ITYP=$$GET1^DIQ(52.486,ILOOP_","_SIENS,.01,"E")
 ..S IVAL=$$GET1^DIQ(52.486,ILOOP_","_SIENS,.02,"E")
 ..D IDENT(.GBL,ITYP,IVAL)
 .D C S @GBL@(CNT,0)="</Identification>"
 D C S @GBL@(CNT,0)="<Specialty>"_SPEC_"</Specialty>"
 D C S @GBL@(CNT,0)="<Name>"
 D C S @GBL@(CNT,0)="<LastName>"_LNAME_"</LastName>"
 D C S @GBL@(CNT,0)="<FirstName>"_FNAME_"</FirstName>"
 D C S @GBL@(CNT,0)="<MiddleName>"_MNAME_"</MiddleName>"
 D C S @GBL@(CNT,0)="<Suffix>"_SUFF_"</Suffix>"
 D C S @GBL@(CNT,0)="<Prefix>"_PREF_"</Prefix>"
 D C S @GBL@(CNT,0)="</Name>"
 D C S @GBL@(CNT,0)="<ClinicName>"_CLNAME_"</ClinicName>"
 D C S @GBL@(CNT,0)="<Address>"
 D C S @GBL@(CNT,0)="<AddressLine1>"_ADDL1_"</AddressLine1>"
 D C S @GBL@(CNT,0)="<AddressLine2>"_ADDL2_"</AddressLine2>"
 D C S @GBL@(CNT,0)="<City>"_CITY_"</City>"
 D C S @GBL@(CNT,0)="<State>"_STATE_"</State>"
 I $L(ZIP) D C S @GBL@(CNT,0)="<ZipCode>"_ZIP_"</ZipCode>"
 D C S @GBL@(CNT,0)="<PlaceLocationQualifier>"_PLQ_"</PlaceLocationQualifier>"
 D C S @GBL@(CNT,0)="</Address>"
 D C S @GBL@(CNT,0)="<CommunicationNumbers>"
 S CLOOP=0 F  S CLOOP=$O(^PS(52.48,SIEN,3,CLOOP)) Q:'CLOOP  D
 .S CNUM=$$GET1^DIQ(52.483,CLOOP_","_SIENS,.01,"E")
 .S CQUAL=$$GET1^DIQ(52.483,CLOOP_","_SIENS,.02,"I")
 .D COMMNUM(.GBL,CNUM,CQUAL)
 ; ***COMMUNICATION NUMBERS***
 D C S @GBL@(CNT,0)="</CommunicationNumbers>"
 D C S @GBL@(CNT,0)="</Supervisor>"
 Q
FACIL(GBL,IENS) ;
 N F,NPI,NAME,ADDL1,ADDL2,CITY,STATE,ZIP,PLQ,PSDAT
 S F=52.49
 ; FOR NOW, JUST BUILD HEADER AND FOOTER
 Q
 D C S @GBL@(CNT,0)="<Facility>"
 D C S @GBL@(CNT,0)="</Facility>"
 Q
 ; complete this as a future enhancement
 D GETS^DIQ(F,IENS,"**","IE","PSDAT")
 S NPI=$G(PSDAT(F,IENS,1,"E"))
 S NAME=$$SYMENC^MXMLUTL($G(PSDAT(F,IENS,1,"E")))
 S ADDL1=$$SYMENC^MXMLUTL($G(PSDAT(F,IENS,1,"E")))
 S ADDL2=$$SYMENC^MXMLUTL($G(PSDAT(F,IENS,1,"E")))
 S CITY=$$SYMENC^MXMLUTL($G(PSDAT(F,IENS,1,"E")))
 S STATE=$G(PSDAT(F,IENS,1,"I"))
 I STATE S STATE=$$GET1^DIQ(5,STATE,1,"E")
 S ZIP=$G(PSDAT(F,IENS,1,"E"))
 S PLQ=$G(PSDAT(F,IENS,1,"E"))
 D C S @GBL@(CNT,0)="<Facility>"
 I $L(NPI) D
 .D C S @GBL@(CNT,0)="<Identification>"
 .D C S @GBL@(CNT,0)="<NPI>"_NPI_"<NPI>"
 .D C S @GBL@(CNT,0)="</Identification>"
 D C S @GBL@(CNT,0)="<FacilityName>"_NAME_"</FacilityName>"
 D C S @GBL@(CNT,0)="<Address>"
 D C S @GBL@(CNT,0)="<AddressLine1>"_ADDL1_"</AddressLine1>"
 D C S @GBL@(CNT,0)="<AddressLine2>"_ADDL2_"</AddressLine2>"
 D C S @GBL@(CNT,0)="<City>"_CITY_"</City>"
 D C S @GBL@(CNT,0)="<State>"_STATE_"</State>"
 I $L(ZIP) D C S @GBL@(CNT,0)="<ZipCode>"_ZIP_"</ZipCode>"
 D C S @GBL@(CNT,0)="<PlaceLocationQualifier>"_PLQ_"</PlaceLocationQualifier>"
 D C S @GBL@(CNT,0)="</Address>"
 ;***COMMUNICATION NUMBERS
 D C S @GBL@(CNT,0)="</Facility>"
 Q
C ;
 S CNT=$G(CNT)+1
 Q
