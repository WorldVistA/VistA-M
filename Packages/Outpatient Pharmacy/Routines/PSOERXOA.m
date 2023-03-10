PSOERXOA ;ALB/BWF - eRx parsing Utilities ; 11/14/2019 3:46pm
 ;;7.0;OUTPATIENT PHARMACY;**581,617**;DEC 1997;Build 110
 ;
 Q
RENEWREQ(PSOIEN,RXIEN,ORNUM,PSOSITE,MESSID,REFREQ) ;Renewal request
 ;return receipt,request reference #, urgency indicator code, follow up req in header
 N ERXIEN,GBL,PSOIENS,CNT,SUPIEN,FUPRES,PRESIEN,PATIEN,MTYPE,RESVAL
 Q:'PSOIEN ""
 S MTYPE=$$GET1^DIQ(52.49,PSOIEN,.08,"I"),RESVAL=$$GET1^DIQ(52.49,PSOIEN,52.1,"I")
 S GBL=$NA(^TMP("RENEWREQ^PSOERXOA",$J)) K @GBL
 S CNT=0
 D MSG(.GBL,1)
 ; header
 S MESSID=$$HEADER(.GBL,PSOIEN)
 ; body header
 D BHF(.GBL,1)
  ; request type header
 D RTYPE(GBL,"RxRenewalRequest",1)
 D OBENEFIT^PSOERXOB(GBL,.CNT,PSOIEN) ;outbound benefits coordination section
 D OFAC^PSOERXOB(GBL,.CNT,PSOIEN) ;outbound facility segment
 D PATIENT^PSOERXOC(GBL,.CNT,PSOSITE,PSOIEN) ;outbound patient segment
 D OPHARM^PSOERXOD(GBL,.CNT,PSOSITE,PSOIEN)
 D PERSON^PSOERXOE(GBL,.CNT,PSOSITE,PSOIEN,"PR") ; PRESCRIBER
 D OOBSERVE^PSOERXOB(GBL,.CNT,PSOIEN) ;outbound observation segment
 D MEDDIS^PSOERXOF(GBL,.CNT,PSOIEN,RXIEN,ORNUM,REFREQ) ; outbound medication DISPENSED segment
 I MTYPE'="RE" D MEDS^PSOERXOG(GBL,.CNT,PSOIEN,"P") ; outbound medication PRESCRIBED segment
 I MTYPE="RE" D MEDS^PSOERXOG(GBL,.CNT,PSOIEN,"MR") ; outbound medication PRESCRIBED segment
 D PERSON^PSOERXOE(GBL,.CNT,PSOSITE,PSOIEN,"S") ; SUPERVISOR
 D PERSON^PSOERXOE(GBL,.CNT,PSOSITE,PSOIEN,"FU") ; FOLLOW UP PRESCRIBER
 D RTYPE(GBL,"RxRenewalRequest",2)
 D BHF(.GBL,2)
 D MSG(.GBL,2)
 Q GBL
RXCHREQ(PSOIEN,PSOSITE) ;RxChange request
 ;return receipt,request reference #, urgency indicator code, follow up req in header
 N GBL,PSOIENS,CNT,CONTINUE,REQCODE,REQNOTE,CODES,MEDREQ,CONTINUE,CONT2,X,CRFOUND,S2017,ESTAT,RTHID
 I '$D(^XUSEC("PSDRPH",DUZ)),'($D(^XUSEC("PSO ERX ADV TECH",DUZ))) D  Q
 .W !,"You do not have the appropriate key to access this option." S DIR(0)="E" D ^DIR K DIR
 Q:'PSOIEN ""
 S S2017=$$GET1^DIQ(52.49,ERXIEN,312.1,"I")
 S ESTAT=$$GET1^DIQ(52.49,ERXIEN,1,"E")
 S GBL=$NA(^TMP("CREQ^PSOERXOA",$J)) K @GBL
 S X=0 F  S X=$O(^PS(52.49,PSOIEN,201,"B",X)) Q:'X  D
 .I $$GET1^DIQ(52.49,X,.08,"I")="CR" S CRFOUND=1 Q
 I $G(CRFOUND) D  Q
 .W !,"An RxChange Request has already been sent for this eRx.",!,"A second change request cannot be sent.",!
 .D DIRE^PSOERXX1
 I $$GET1^DIQ(52.49,ERXIEN,.08,"I")'="N"!('S2017)!(ESTAT="RJ")!(ESTAT="RM")!(ESTAT="CAN")!(ESTAT="CAC")!($E(ESTAT)="H") D  Q
 .W !,"Change Request may not be used for this record type." D DIRE^PSOERXX1
 .S VALMBCK="R"
 S CNT=0
 D FULL^VALM1
 S VALMBCK="R"
 D MSG(.GBL,1)
 ; header
 S MESSID=$$HEADER(.GBL,PSOIEN)
 ; body header
 D BHF(.GBL,1)
  ; request type header
 D RTYPE(.GBL,"RxChangeRequest",1)
 ; body goes here
 ; MESSAGE REQUEST CODE/SUBCODES
 S CONTINUE=$$GETCODES^PSOERXON(PSOIEN,.CODES)
 I 'CONTINUE W !,"RxChangeRequest cancelled." D DIRE^PSOERXX1 Q
 S REQCODE=$G(CODES("MRCODE"))
 I REQCODE="P"!(REQCODE="U") S REQNOTE=$G(CODES("NOTE"))
 D MEDCODES^PSOERXON(GBL,.CNT,.CODES)
 ; call prompting logic
 ; RETURN RECEIPT, REQUESTREFERENCENUMBER, URGENCY INDICATOR CODE, FOLLLOWUP REQUEST (DO WE ADD THESE?)
 D OALLERGY^PSOERXOB(GBL,.CNT,PSOIEN) ;(ONLY 1 INSTANCE - XSD IS 0..1)
 D OBENEFIT^PSOERXOB(GBL,.CNT,PSOIEN) ;outbound benefits coordination section
 D OFAC^PSOERXOB(GBL,.CNT,PSOIEN) ;outbound facility segment
 D PATIENT^PSOERXOC(GBL,.CNT,PSOSITE,PSOIEN) ;outbound patient segment
 D OPHARM^PSOERXOD(GBL,.CNT,PSOSITE,PSOIEN) ; brad/steve
 D PERSON^PSOERXOE(GBL,.CNT,PSOSITE,PSOIEN,"PR") ; PRESCRIBER - brad/steve
 D OOBSERVE^PSOERXOB(GBL,.CNT,PSOIEN) ;outbound observation segment
 ; reqnote is used for P and U types, and over-rides the medication prescribed note, per Surescripts
 ; this is due to the lack of a medication requested segment for these 2 request types.
 I $G(REQNOTE)]"" D MEDS^PSOERXOG(GBL,.CNT,PSOIEN,"P",$G(REQNOTE)) ; outbound medication PRESCRIBED segment
 I $G(REQNOTE)']"" D MEDS^PSOERXOG(GBL,.CNT,PSOIEN,"P")
 ; medication request, [0..9]
 S CONT2=$$CHREQ^PSOERXON(GBL,PSOIEN,.CNT,.MEDREQ,REQCODE)
 I 'CONT2 K @GBL Q
 I REQCODE'="P",REQCODE'="U",'$O(MEDREQ(0)) Q
 D PERSON^PSOERXOE(GBL,.CNT,PSOSITE,PSOIEN,"FU") ; FOLLOW UP PRESCRIBER - brad/steve
 D RTYPE(GBL,"RxChangeRequest",2)
 D BHF(.GBL,2)
 D MSG(.GBL,2)
 ; send message
 N PSSRET,HUBID,VADAT,NPIINST,INNAME,STATION,NPI,DIV
 S NPIINST=$$GET1^DIQ(59,PSOSITE,101,"I")
 S INNAME=$$NAME^XUAF4(NPIINST)
 S STATION=$$WHAT^XUAF4(NPIINST,99)
 S NPI=$$NPI^XUSNPI("Organization_ID",NPIINST) I $P(NPI,U)<1 D
 .S NPI=$$WHAT^XUAF4(NPIINST,41.99)
 I '$G(NPI) W !!,"NPI could not be established. Cannot create renewal request." D DIRE^PSOERXX1 Q
 S DIV=INNAME_U_NPI
 S RXIEN=$$GET1^DIQ(52.49,PSOIEN,.13,"I")
 S PSSRET=$$RESTPOST^PSOERXO1(.PSSRET,.GBL)
 ; if the post was unsuccessful, inform the user and quit.
 I $P(PSSRET(0),U)<1 W !,$P(PSSRET(0),U,2) S DIR(0)="E" D ^DIR K DIR Q
 I $D(PSSRET("errorMessage")) W !,PSSRET("errorMessage") S DIR(0)="E" D ^DIR K DIR Q
 S HUBID=$G(PSSRET("outboundMsgId")) I 'HUBID W !,"The eRx Processing hub did not return a Hub identification number." S DIR(0)="E" D ^DIR K DIR Q
 ; vista generated message will be V12345 (V concatenated to the hubId)
 S HUBID="V"_HUBID
 N RES,I,XXL1
 S I=0 F  S I=$O(@GBL@(I)) Q:'I  D
 .S XXL1=$G(XXL1)_$G(@GBL@(I,0))
 S VADAT=DUZ
 S RTHID=$$GET1^DIQ(52.49,PSOIEN,.01,"E")
 S HUBID=HUBID_U_U_RTHID
 D INCERX^PSOERXI1(.RES,.XXL1,"","","",STATION,DIV,HUBID,"","",VADAT,"")
 I $P(RES,U)=0 D
 .W !,"A problem was encountered while trying to file the RxChange request."
 .W !,"RxChange Request was not filed in vista."
 .W !!,"ERROR: "_$P(RES,U,2)
 .S DIR(0)="E" D ^DIR K DIR
 W !,"eRx Change Request sent." D DIRE^PSOERXX1
 D UPDSTAT^PSOERXU1(PSOIEN,"HC")
 K @GBL
 Q
MSG(GBL,HF) ; 2017071 MSG segment
 N XL1,XL2
 Q:'HF
 I HF=1 D
 .S XL1="<?xml version=""1.0"" encoding=""UTF-8""?><Message DatatypesVersion=""20170715"" TransportVersion=""20170715"" TransactionDomain=""SCRIPT"" TransactionVersion=""20170715"" "
 .S XL2="StructuresVersion=""20170715"" ECLVersion=""20170715"" xmlns:xsi=""http://www.w3.org/2001/XMLSchema-instance"">"
 .D C S @GBL@(CNT,0)=XL1_XL2
 I HF=2 D C S @GBL@(CNT,0)="</Message>"
 Q
 ;
HEADER(GBL,IEN) ; Adapted from PSOERXX2
 N ERXHID,F,FRQUAL,FRVAL,IENS,INST,MID,PON,PSDAT,REQREF,RETREC,RSECID,RTERTID,RTMID,SSECID
 N SENTTIME,STERTID,STIME,TOQUAL,TOVAL,TXT
 S F=52.49
 S IENS=IEN_","
 D GETS^DIQ(F,IENS,"**","IE","PSDAT")
 D CONVXML^PSOERXX1("PSDAT")
 S ERXHID=$G(PSDAT(F,IENS,.01,"E"))
 ; 'TO' values come from the 'FROM' fields of the eRx.
 S TOQUAL=$G(PSDAT(F,IENS,22.2,"I"))
 S TOVAL=$G(PSDAT(F,IENS,22.1,"E"))
 ; 'FROM' values come from the 'TO' fields of the eRx.
 S FRQUAL=$G(PSDAT(F,IENS,22.4,"I"))
 S FRVAL=$G(PSDAT(F,IENS,22.3,"E"))
 S INST=DUZ(2)
 ; message ID needs to be unique from vista - Site#.erxIEN.date.time
 S MID=INST_"."_IEN_"."_$$NOW^XLFDT
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
 S STERTID="TECHNATOMY"
 S RSECID=$G(PSDAT(F,IENS,24.3,"E"))
 S SENTTIME=$$EXTIME^PSOERXO1()
 S RTERTID="ERXPAD"
 I TOQUAL'="",TOVAL'="",FRQUAL'="",FRVAL'="",MID'="",SENTTIME'="" D
 .D C S @GBL@(CNT,0)="<Header>"
 .D C S @GBL@(CNT,0)="<To Qualifier="""_TOQUAL_""">"_TOVAL_"</To>"
 .D C S @GBL@(CNT,0)="<From Qualifier="""_FRQUAL_""">"_FRVAL_"</From>"
 .D C S @GBL@(CNT,0)="<MessageID>"_MID_"</MessageID>"
 .; relatesToMessageID is the CH messageID - FIELD 25
 .D BL(GBL,.CNT,"RelatesToMessageID",RTMID)
 .D C S @GBL@(CNT,0)="<SentTime>"_SENTTIME_"</SentTime>"
 .I $L(STERTID_RTERTID) D
 ..D C S @GBL@(CNT,0)="<Security>"
 ..; bwf -  missing UsernameToken - consider as part of v4 if needed
 ..I STERTID'="" D
 ...D C S @GBL@(CNT,0)="<Sender>"
 ...; for now we are not using secondary identifications, this will stay in place for future activation.
 ...;I $L(SSECID) D C S @GBL@(CNT,0)="<SecondaryIdentification>"_SSECID_"</SecondaryIdentification>"
 ...D C S @GBL@(CNT,0)="<TertiaryIdentification>"_STERTID_"</TertiaryIdentification>"
 ...D C S @GBL@(CNT,0)="</Sender>"
 ..I RTERTID'="" D
 ...D C S @GBL@(CNT,0)="<Receiver>"
 ...;I $L(RSECID) D C S @GBL@(CNT,0)="<SecondaryIdentification>"_RSECID_"</SecondaryIdentification>"
 ...D C S @GBL@(CNT,0)="<TertiaryIdentification>"_RTERTID_"</TertiaryIdentification>"
 ...D C S @GBL@(CNT,0)="</Receiver>"
 ..D C S @GBL@(CNT,0)="</Security>"
 .D C S @GBL@(CNT,0)="<SenderSoftware>"
 .D BL(GBL,.CNT,"SenderSoftwareDeveloper","VA")
 .D BL(GBL,.CNT,"SenderSoftwareProduct","VA-Inbound eRx")
 .D BL(GBL,.CNT,"SenderSoftwareVersionRelease","V5.0")
 .D C S @GBL@(CNT,0)="</SenderSoftware>"
 .; missing 'Mailbox' - note for future enhancement. Was not needed for CH certification.
 .D BL(GBL,.CNT,"RxReferenceNumber",ERXHID)
 .D BL(GBL,.CNT,"PrescriberOrderNumber",PON)
 .D C S @GBL@(CNT,0)="</Header>"
 Q MID
 ;
BHF(GBL,HF) ;
 Q:'$D(HF)
 D C
 S @GBL@(CNT,0)=$S(HF=1:"<Body>",HF=2:"</Body>",1:"")
 Q
 ;HF   1 - header
 ;     2 - footer
BL(GBL,CNT,TAG,VAR) ;
 Q:VAR=""
 D C S @GBL@(CNT,0)="<"_TAG_">"_$$SYMENC^MXMLUTL(VAR)_"</"_TAG_">"
 Q
C ;
 S CNT=$G(CNT)+1
 Q
RTYPE(GBL,RTYPE,HF) ;
 Q:'HF
 D C
 S @GBL@(CNT,0)=$S(HF=1:"<"_RTYPE_">",HF=2:"</"_RTYPE_">",1:"")
 Q
