SDCCRCOR ;CCRA/LB,PB - Core Tags;APR 4, 2019
 ;;5.3;Scheduling;**707,730,735,764,741,795**;APR 4, 2019;Build 34
 ;;Per VA directive 6402, this routine should not be modified.
 Q
 ;
HL72VATS(HL7TS) ; Converts HL7 formatted timestamps to VA format
 ;  HL7TS - date/time stamp in 24H HL7 format (YYYYMMDDHHMMSS)
 Q $$HL7TFM^XLFDT($G(HL7TS))
VA2HL7TS(VATS) ; Converts VA formatted timestamps to HL7 format
 ;  VATS - date/time stamp in VA format (YYYMMDD.HHMMSS)
 Q $$FMTHL7^XLFDT($G(VATS))
GETPTIEN(PATNAME) ; Returns patient ID or null, name must be perfect match
 ; PATNAME - Patient name - must be exact LAST,FIRST
 N IEN
 I $G(PATNAME)="" Q ""
 I $D(^DPT("B",PATNAME)) D
 . S IEN=$O(^DPT("B",PATNAME,""))
 Q $G(IEN)
GETPTNM(DFN) ; Returns patient name from ^DPT global, given a valid DFN
 ; DFN - Patient ID to look for
 N PATNAME
 I $G(DFN)="" Q ""
 I $D(^DPT(DFN,0)) D
 . S PATNAME=$P(^DPT(DFN,0),"^",1)
 Q $G(PATNAME)
GETLCIEN(LOCNAME) ; Returns Location ID or null, name must be perfect match
 ; PATNAME - Location name - must be exact
 N IEN
 I $G(LOCNAME)="" Q ""
 I $D(^SC("B",LOCNAME)) D
 . S IEN=$O(^SC("B",LOCNAME,""))
 Q $G(IEN)
GETLCNM(LOCID) ; Returns location name from clinic file 44 given a valid clinic IEN
 ; LOCID - Location ID to look for
 Q $$GET1^DIQ(44,$G(LOCID),.01)
GETNMPRV(CLINIC) ; Returns the number of providers associated with a clinic
 ; CLINIC - The Clinic IEN (first piece of DPT 0 node)
 Q $P(^SC($G(CLINIC),"PR",0),"^",4) ;Piece 3 is most recently assigned number, piece 4 is total active.
GETCNGNM(CLINICGROUP) ; Returns the Name of a Clinic's group
 ; CLINICGROUP - The Clinic Group IEN
 Q $P(^SD(409.67,$G(CLINICGROUP),0),"^",1)
GETPRVNM(PROVIEN) ; Returns the provider name, given a provider ID
 ; PROVIEN - The Provider IEN
 Q $P(^VA(200,$G(PROVIEN),0),"^")
ICLNDPRV(CLINIC,PROVIEN) ; Determines if the provider is the default provider for the clinic
 ; CLINIC - The Clinic IEN (first piece of DPT 0 node)
 ; PROVIEN - The Provider IEN
 Q $P(^SC($G(CLINIC),"PR",$$CLNPVIND($G(CLINIC),$G(PROVIEN)),0),"^",2)
CLNPVIND(CLINIC,PROVIEN) ; Determines the line number the provider is listed on for a clinic
 ; CLINIC - The Clinic IEN (first piece of DPT 0 node)
 ; PROVIEN - The Provider IEN
 Q +$QS($Q(^SC($G(CLINIC),"PR","B",$G(PROVIEN))),5)
GTCANRSN(PATIENTIEN,APPTDT) ; Returns the discrete cancellation reason
 ; PATIEN (I,REQ)- Patient ID as in DPT(PATIEN,"S",APPTDAT
 ; APPTDAT (I,REQ) - Appointment date
 Q $P(^SD(409.2,$$APTNODEP^SDCCRGAP($G(PATIENTIEN),$G(APPTDT),0,15),0),"^",1)
GTCNRNTP(PATIENTIEN,APPTDT) ; Gets the cancelation reason type.
 ; PATIEN - Patient ID as in DPT(PATIEN,"S",APPTDAT
 ; APPTDAT - Appointment date
 N VAL,CANTYPE
 S CANTYPE=$$APTNODEP^SDCCRGAP($G(PATIENTIEN),$G(APPTDT),0,15)
 S VAL=$P($G(^SD(409.2,$G(CANTYPE),0)),"^",2)
 Q $S($G(VAL)="B":"C",1:$G(VAL))
ORD2CONS(ORDERID) ;Returns the consult ID linked to the given order
 ; ORDERID       - Order ID
 N CNSLTLNK
 I $G(ORDERID)="" Q ""
 S CNSLTLNK=$G(^OR(100,ORDERID,4))
 I $P(CNSLTLNK,";",2)="GMRC" Q $P(CNSLTLNK,";",1)
 Q ""
INSTRING(VALUE,LIST,DELIM) ; compare a string value to see if it is a list given a particular delimiter
 ; VALUE - value to find in the list.
 ; LIST - The list to check
 ; DELIM - Delimiter that separates the data in the list. Default = ","
 Q $S($G(DELIM)="":(","_$G(LIST)_",")[(","_$G(VALUE)_","),1:($G(DELIM)_$G(LIST)_$G(DELIM))[($G(DELIM)_$G(VALUE)_$G(DELIM)))
INITINC ; Sets temp global that indicates this process is filing an incoming message
 S ^TMP($J,"CCRA-INCINTF")=1
 Q
DONEINC ; Clears temp global that indicates this process is filing an incoming message
 K ^TMP($J,"CCRA-INCINTF")
 Q
INCINTF() ; Checks temp global that indicates whether the process is filing an incoming message
 Q +$G(^TMP($J,"CCRA-INCINTF"))
SETMSGET()    ;SEND AN ERROR MESSAGE OUT AND LOG THE CACHE ERROR+STACK TO ^ERRORS
 N $ETRAP
 S $ETRAP="LOGSEND^SDCCRCOR"
 Q
FMTPHONE(PHONE,EXT) ; Formats a VistA telephone number into an HL7-compliant format
 ; Formats include: (nnn)nnn-nnnn and nnn-nnnn, depending on whether or not there is an area code.
 ; If the number is not in a valid format, does not attempt to do any formatting.
 ; Returns 1 if the number was formatted, 0 otherwise.
 ;
 ; PHONE - Phone number to be formatted
 ; EXT   - Phone number extension (if specified)
 ;
 I $G(PHONE)="" Q 0
 N TEMP,LENGTH
 ;
 ; Extract phone number
 S TEMP=$$STRIP^XLFSTR(PHONE,"-()")  ; Strip certain delimiters
 S TEMP=$TR(TEMP,"x","X")            ; Standardize extension delimiter
 S EXT=$P(TEMP,"X",2)                ; Pull out the extension (if it exists)
 S TEMP=$P(TEMP,"X",1)
 ;
 ; Format based on length
 S LENGTH=$L(TEMP)
 I '$$INSTRING^SDCCRCOR(LENGTH,"7,10",",") Q 0                           ; Length not 7 or 10
 I LENGTH=7 S TEMP=$E(TEMP,1,3)_"-"_$E(TEMP,4,7)                         ; No area code: nnn-nnnn
 I LENGTH=10 S TEMP="("_$E(TEMP,1,3)_")"_$E(TEMP,4,6)_"-"_$E(TEMP,7,10)  ; Area code: (nnn)nnn-nnnn
 ;
 ; Save output
 S PHONE=TEMP
 Q 1
GETLEN(SCH,AIP,AIG) ;Translates duration into Minutes. Assumes minutes unless set to S or SEC for the units
 ;  Only one parameter at a time should be passed-in, depending on what segment is calling this tag
 ;  SCH (I/OPT) - SCH message segment data
 ;  AIP (I/OPT) - AIP message segment data
 ;  AIG (I/OPT) - AIG message segment data
 N DURATION,UNIT
 I $D(SCH) D
 . S DURATION=+$$GET^SDCCRSCU(.SCH,9,1)  ;SCH-9
 . I DURATION=0 D ACK("CE",MID,"SCH",9,1,304,"NO APPOINTMENT DURATION RECIEVED IN SCH",1) S ABORT="1^NO APPOINTMENT DURATION RECIEVED IN SCH" Q 
 . S UNIT=$$GET^SDCCRSCU(.SCH,10,1)     ;SCH-10
 E  I $D(AIP) D
 . S DURATION=+$$GET^SDCCRSCU(.AIP,9,1)  ;AIP-9
 . I DURATION=0 D ACK("CE",MID,"AIP",9,1,304,"NO APPOINTMENT DURATION RECIEVED IN AIP",1) S ABORT="1^NO APPOINTMENT DURATION RECIEVED IN AIP" Q
 . S UNIT=$$GET^SDCCRSCU(.AIP,10,1)     ;AIP-10
 E  I $D(AIG) D
 . S DURATION=+$$GET^SDCCRSCU(.AIG,11,1)  ;AIG-11
 . I DURATION=0 D ACK("CE",MID,"AIG",11,1,304,"NO APPOINTMENT DURATION RECIEVED IN AIG",1) S ABORT="1^NO APPOINTMENT DURATION RECIEVED IN AIG" Q
 . ;S UNIT=$$GET^SDCCRSCU(.AIG,12,1)     ;AIG-12
 ; Translate to minutes
 I $$INSTRING^SDCCRCOR(UNIT,"S,SEC") S DURATION=DURATION/60
 Q $G(DURATION)
COPYMSG(Y) ; Copy HL7 Message to array Y (by reference)
 ; Based on HL*1.6*56 VISTA HL7 Site Manager & Developer Manual
 ; Paragraph 9.7, page 9-4
 I $L($G(HLNEXT)) ;HL7 context
 E  Q
 N I,J
 F I=1:1 X HLNEXT Q:HLQUIT'>0  D
 .S Y(I)=HLNODE,J=0
 .F  S J=$O(HLNODE(J)) Q:'J  D
 ..S Y(I)=Y(I)_HLNODE(J)
 Q
 ;
CHKMSG(Y) ; Check Message for all required segments
 N QUIT,REQSEG,SEGFND,I,SEGTYP,ICN,DFN,ERRMSG,MSGEVN
 S QUIT=0
 F REQSEG="MSH","SCH","PID","PV1","RGS","AIS","AIG","AIL","AIP" D  Q:QUIT
 .S (SEGFND,I)=0
 .F  S I=$O(Y(I)) Q:'I!(SEGFND)  D
 ..S SEGTYP=$E(Y(I),1,3)
 ..I SEGTYP=REQSEG S SEGFND=1
 ..I SEGTYP="MSH" D
 ... I $P(Y(I),FS,10)="" D
 .... S QUIT=1
 .... D ACK("CE",MID,"MSH","",10,101,"MESSAGE CONTROL ID MISSING")
 .... S ABORT="1^MESSAGE CONTROL ID MISSING"
 .... Q:QUIT
 ... I $P($P(Y(I),FS,9),CS,1)'="SIU" D
 .... S QUIT=1
 .... S ERRMSG="Scheduling Message TYPE not received on CCRA scheduling interface. Message type received:"_$P($P(Y(I),FS,9),CS,1)
 .... S ERRMSG=ERRMSG_" for MESSAGE CONTROL ID:"_$P(Y(I),FS,10)
 .... D ACK("CE",MID,"MSH","",9,200,ERRMSG)
 .... S ABORT="1^"_$G(ERRMSG)
 .... Q:QUIT
 ... ;determine scheduling action event from message event
 ... S MSGEVN=$P($P(Y(I),FS,9),CS,2) I $$SETEVENT^SDCCRSEN($G(MSGEVN),.MSGARY)=0 D
 .... S QUIT=1
 .... S ERRMSG="Scheduling Message EVENT could not be determined. Message event received:"_$P($P(Y(I),FS,9),CS,2)
 .... S ERRMSG=ERRMSG_" for MESSAGE CONTROL ID:"_$P(Y(I),FS,10)
 .... D ACK("CE",MID,"MSH","",9,201,ERRMSG)
 .... S ABORT="1^"_$G(ERRMSG)
 .... Q:QUIT
 ... S HDRTIME=$P(Y(I),FS,7)
 .I 'SEGFND D
 ..S QUIT=1
 ..D ACK("CE",MID,REQSEG,"","",100,REQSEG_" SEGMENT MISSING OR OUT OF ORDER")
 .. S ABORT="1^"_$G(REQSEG)_" SEGMENT MISSING OR OUT OF ORDER"
 Q QUIT
DATALKUP(SEG,FILE,FILEPATH,FIELD,ERRCODE,ERRTEXT) ; Translates a data element for a given FileMan file in an HL7 field
 ;Tries using the Title to lookup the data. If that fails uses the ID to lookup
 ;the reason against the title. If that fails tries using the ID against the ID.
 ;SEG (I,REQ) - Message segment to parse
 ;FILE (I,REQ) - FileMan File to lookup
 ;FILEPATH (I,REQ) - global path to the file's storage location for DIC lookup. Make sure to end with a comma ^<glo>(<File>,
 ;FIELD (I,REQ) - message field to look in
 ;ERRCODE (I,OPT) - error to log if failure
 ;ERRTEXT (I,OPT) - error text to log if failure
 ;Check Requirements
 I ($G(FILE)="")!($G(FIELD)="") Q
 N ID,TITLE,DATA,X,Y,DIC
 S DATA=""
 S ID=$$GET^SDCCRSCU(.SEG,FIELD,1)       ;component 1  HL7 ID field
 S TITLE=$$GET^SDCCRSCU(.SEG,FIELD,2)    ;component 2 HL7 Title field
 I (ID=""),(TITLE="") Q ""   ;No data to translate
 ; Try robust mutli tier lookup
 I TITLE'="" S DIC=FILEPATH,DIC(0)="B",X=TITLE D ^DIC S DATA=$P(Y,"^",1)   ;lookup "B" node with the second component
 I DATA'="",DATA'=-1 Q DATA
 I ID'="" d
 . S DIC=FILEPATH,DIC(0)="B",X=ID D ^DIC S DATA=$P(Y,"^",1)   ;lookup "B" node with the first component
 . I DATA'="",DATA'=-1 Q
 . I $$GET1^DIQ(FILE,ID,".01")'="" S DATA=ID    ;check if the ID matches a record in the File. if so use it.
 I DATA'="" Q DATA
 I $G(ERRCODE)'="" D ACK^SDCCRCOR("CE",MID,"","","",ERRCODE,ERRTEXT,1) ;All lookups have failed and data exists so send an error
 Q ""
ACK(STAT,MID,SID,SEG,FLD,CD,TXT,ACKTYP) ; Creates ACKs for HL7 Message
 ;STAT = Status (Acknowledgment Code) (REQUIRED)
 ;MID = Message ID (REQUIRED)
 ;SID = Segment ID (set if ERR occurred in segment) (OPTIONAL)
 ;SEG = Segment location of error (OPTIONAL)
 ;FLD = Field location of error (OPTIONAL)
 ;CD = Error Code (OPTIONAL)
 ;TXT = Text describing error (OPTIONAL)
 ;ACKTYP = Acknowledgment Type (OPTIONAL)
 ;
 N HLA,EID,EIDS,RES,ERRI,CS,FS,RS,ES,SS  ;Jan 21,2020 - PB - patch 735 new and then set FS,CS,RS,ES,SS
 S FS=$G(HL("FS"),"|")
 S CS=$E($G(HL("ECH")),1) S:CS="" CS="^"
 S RS=$E($G(HL("ECH")),2) S:RS="" RS="~"
 S ES=$E($G(HL("ECH")),3) S:ES="" ES="\"
 S SS=$E($G(HL("ECH")),4) S:SS="" SS="&"
 S:STAT="CE" STAT="AE"
 ;
 ;Make sure the parameters are defined
 S STAT=$G(STAT),MID=$G(MID),SID=$G(SID),SEG=$G(SEG)
 S FLD=$G(FLD),CD=$G(CD),TXT=$G(TXT)
 ;
 ;Create MSA Segment
 S HLA("HLA",1)="MSA"_FS_STAT_FS_MID_FS_$G(TXT)
 S EID=$G(HL("EID"))
 S EIDS=$G(HL("EIDS"))
 Q:((EID="")!($G(HLMTIENS)="")!(EIDS=""))
 ;
 S RES=""
 ;If Segment ID (SID) is set, create ERR segment
 D:$L(SID)>0
 . K ERRARY
 . S HLA("HLA",2)="ERR"
 . S $P(HLA("HLA",2),FS,3)=SID_CS_SEG_CS_FLD
 . S $P(HLA("HLA",2),FS,5)="E"
 . ;
 . ; Commit Error
 . I '+$G(ACKTYP) D
 .. S $P(HLA("HLA",2),FS,4)=CD_CS_TXT_CS_"0357"
 . ;
 . ; Application Error
 . I +$G(ACKTYP)=1 D
 .. S ERRI=0
 .. S $P(HLA("HLA",2),FS,6)=CS_CS_CS_CD_CS_TXT
 .. ;Process Error
 .. S ERRI=ERRI+1
 .. S ERRARY(ERRI,2)=$P($G(HLA("HLA",2)),"|",3)
 .. I $P($G(HLA("HLA",2)),"|",6)'="" D  ;
 ... S ERRARY(ERRI,3)=$P($P($G(HLA("HLA",2)),"|",6),"^",4)_"^"_$P($P($G(HLA("HLA",2)),"|",6),"^",5)
 .. I $P($G(HLA("HLA",2)),"|",6)="" S ERRARY(ERRI,3)=$P($G(HLA("HLA",2)),"|",4)
 . ;I $D(ERRARY) D MESSAGE(MID,.ERRARY)
 . ; build message for MailMan
 D GENACK^HLMA1(EID,$G(HLMTIENS),EIDS,"LM",1,.RES)
 Q
 ;
APPMSG(MSGID,ABORT) ; Send a MailMan Message with the errors
 N MSGTEXT,DUZ,XMDUZ,XMSUB,XMTEXT,XMY,XMMG,XMSTRIP,XMROU,DIFROM,XMYBLOB,XMZ,XMMG,DATE,J
 S DATE=$$FMTE^XLFDT($$FMDATE^HLFNC($P(HL("DTM"),"-",1)))
 S XMSUB="Consult: "_$G(CONSULTID)_" - GMRC CCRA Scheduling Issue from HSRM"
 S MSGTEXT(1)=" "
 S MSGTEXT(2)="An error in making a community care appointment for consult ID: "_$G(CONSULTID)
 S MSGTEXT(3)="The consult title is: "_$G(CONTITLE)
 S MSGTEXT(4)="A non-count clinic named "_$G(SRVNAMEX)_" could not be found."
 S MSGTEXT(5)="The appointment was for "_$G(PROVIDER)_" on "_$$FMTE^XLFDT(SDECSTART,3)
 S XMTEXT="MSGTEXT("
 S XMDUZ="GMRC-CCRA <-HSRM Transaction Error"
 S XMDUZ=.5
 S XMY("G.GMRC HSRM SIU HL7 MESSAGES")=""  ;  ** CHECK THIS OUT **
 D ^XMD
 Q
MESSAGE(MSGID,ABORT) ; Send a MailMan Message with the errors
 N MSGTEXT,DUZ,XMDUZ,XMSUB,XMTEXT,XMY,XMMG,XMSTRIP,XMROU,DIFROM,XMYBLOB,XMZ,XMMG,DATE,J,FLG1
 Q:$P(ABORT,"^",2)=""
 S DATE=$$FMTE^XLFDT($$FMDATE^HLFNC($P(HL("DTM"),"-",1)))
 S XMSUB="Consult: "_$G(CONID)_" GMRC CCRA Scheduling Issue from HSRM"
 S:$E($P($G(ABORT),"^",2),1,9)="SCHEDULER" FLG1=1
 S MSGTEXT(1)=" "
 S MSGTEXT(2)="Error in receiving HL7 message from HSRM"
 S MSGTEXT(3)="Date:       "_DATE
 S MSGTEXT(4)="Message ID: "_MSGID
 S MSGTEXT(5)="Error(s): "_$P(ABORT,"^",2)_"  "_$G(USERMAIL)
 ;Jan 21,2020 - PB - patch 735 add email from message and the email searched for
 S:$G(FLG1)=1 MSGTEXT(6)="Scheduler email from HSRM "_$G(USERMAIL)_" looking for "_$$LOW^XLFSTR(USERMAIL)
 S XMTEXT="MSGTEXT("
 S XMDUZ="GMRC-CCRA <-HSRM Transaction Error"
 S XMDUZ=.5
 S XMY("G.GMRC HSRM SIU HL7 MESSAGES")=""
 D ^XMD
 Q
ANAK(NAKMSG,USERMAIL,ICN,DFN,APTTM,CONID) ; Application Error
 N PATNAME,EID,EIDS,MSGN,SITE,CONPAT,CS,FS,RS,ES,SS  ;Jan 21,2020 - PB - patch 735 new and then set FS,CS,RS,ES,SS
 S FS=$G(HL("FS"),"|")
 S CS=$E($G(HL("ECH")),1) S:CS="" CS="^"
 S RS=$E($G(HL("ECH")),2) S:RS="" RS="~"
 S ES=$E($G(HL("ECH")),3) S:ES="" ES="\"
 S SS=$E($G(HL("ECH")),4) S:SS="" SS="&"
 Q:$G(NAKMSG)=""
 Q:$G(APTTM)=""
 Q:$G(CONID)=""
 S CONPAT=$$GET1^DIQ(123,CONID_",",.02,"I")
 S:$G(CONPAT)>0 PATNAME=$$GET1^DIQ(123,CONID_",",.02,"E")
 S:$G(CONPAT)'>0 PATNAME=$$GET1^DIQ(123,$G(DFN)_","_.02,"E")
 S SITE=$$KSP^XUPARAM("INST")
 I $G(ICN)="" S:$G(CONPAT)>0 ICN=$P(^DPT(CONPAT,"MPI"),"^",10)
 I $G(ICN)="" S ICN="NOT IN MSG"
 S EID=$G(HL("EID"))
 S EIDS=$G(HL("EIDS"))
 S MSGN=$G(HL("MID"))
 S HLA("HLA",1)="MSA|AE|"_$G(MSGN)_"|"_$G(USERMAIL)_" "_$G(NAKMSG)_"|||"_$G(ICN)_"^"_$G(PATNAME)_"^"_SITE_"^"_CONID_"^"_APTTM
 D GENACK^HLMA1(EID,$G(HLMTIENS),EIDS,"LM",1,.RES)
 Q
INT ;
 S RESULTS=0
 S DUZ=""
 S FS=$G(HL("FS"),"|")
 S CS=$E($G(HL("ECH")),1) S:CS="" CS="^"
 S RS=$E($G(HL("ECH")),2) S:RS="" RS="~"
 S ES=$E($G(HL("ECH")),3) S:ES="" ES="\"
 S SS=$E($G(HL("ECH")),4) S:SS="" SS="&"
 S MID=$G(HL("MID"))
 S (HLQUIT,HLNODE)=0
 Q
TIMES(APPTTIME,SITECODE) ; convert/calculate appt times
 N APPT
 S APPT=0,EXP=0
 K HSRMOFFSET,FMDTTM,UTCAPTTM,XOUT,Y,OFFSET,HSRMOFFSET1
 Q:$G(APPTTIME)=""  ;APPTTIME is HSRM time
 Q:$G(SITECODE)=""
 S YR=$E(APPTTIME,1,4),XOUT=$$HL7TFM^XLFDT(APPTTIME)
 S SITECODE=$O(^DIC(4,"D",SITECODE,"")),EXP=$$GET1^DIQ(4,SITECODE_",",802,"I"),EXP1=$S($G(EXP)=0:1,$G(EXP)=1:0,$G(EXP)="":0) ;EXP1=0 practice dst, EXP1=1 don't practice DST
 S HSRMOFFSET1="-"_$P(APPTTIME,"-",2),FMDTTM=$$HL7TFM^XLFDT(APPTTIME,"L") ;HSRMOFFSET1 is HSRM offset, FMDTTM is HSRM time converted to FM date/time w/o offset
 S DSTFL=$$DSTTEST(YR,FMDTTM) W !,$G(DSTFL),! ;S HSRMOFFSET=HSRMOFFSET1-(DSTFL*-1)
 I $G(EXP1)=1 D  ; don't practice DST
 .S OFFSET1=$P($$UTC^DIUTC(XOUT,,$G(SITECODE),,1),"^",3),OFFSET=(HSRMOFFSET1-OFFSET1),APPT=$$FMADD^XLFDT(FMDTTM,,-OFFSET) ;calculate offset based on sitecode and UTC appt time (UTCAPPTTM)
 I $G(EXP1)'=1 D  ;practice DST
 .S OFFSET1=$P($$UTC^DIUTC(XOUT,,$G(SITECODE),,1),"^",3)  ;,OFFSET1=OFFSET1*
 .I HSRMOFFSET1'=OFFSET1 S OFFSET=OFFSET1-DSTFL,OFFSET=OFFSET1-HSRMOFFSET1,APPT=$$FMADD^XLFDT(FMDTTM,,OFFSET)
 .I HSRMOFFSET1=OFFSET1 S APPT=FMDTTM
 I $G(P694)=1 S Y=APPT X ^DD("DD") S APPT=Y
 K OFFSET1,EXP,EXP1,DSTFL
 Q APPT
DSTTEST(YR,CHKDT) ;
 N RTN,DATES,I
 S RTN=1
 Q:$G(YR)=""
 Q:$G(CHKDT)=""
 ;$P($P($T(LIST+I),";;",2),"^",1)
 F I=1:1:20 I $P($P($T(DSTTABLE+I),";;",2),"^",1)=YR S DATES=$P($T(DSTTABLE+I),"^",2,3) D
 .I $G(CHKDT)>$P(DATES,"^",1)&($G(CHKDT)<$P(DATES,"^",2)) S RTN=0 ;APPT date is during DST timeframe.
 Q RTN
GETRSN(SCH) ; Collects appointment reason and translates into internal format.
 ;Tries using the Title to lookup the reason. If that fails uses the ID to lookup
 ;the reason against the title. If that fails tries using the ID against the ID.
 Q $$DATALKUP^SDCCRCOR(.SCH,"409.2","^SD(409.2,",6,302,"APPOINTMENT REASON MAPPING ERROR")
GETTYPE(OBX) ;translates appointment type into internal format
 ;OBX (I/REQ) - OBX message segment data
 N APPTTYPE
 S APPTTYPE=$$DATALKUP^SDCCRCOR(.OBX,"409.1","^SD(409.1,",5,303,"APPOINTMENT TYPE MAPPING ERROR")
 I $G(APPTTYPE)="" S APPTTYPE=9
 Q APPTTYPE
 ;
GETUSER(SCH) ;collects appointment entered by user and confirms they are a user in the 200 file
 ;SCH (I/REQ) - SCH message segment data
 Q:$G(SCH)=""
 S USER=$$FIND1^DIC(200,,"X",$G(SCH),"ASECID",,"SCERR")
 S USER=.5
 Q USER
DSTTABLE ;
 ;;2020^3200308^3201101
 ;;2021^3210314^3211107
 ;;2022^3220313^3221106
 ;;2023^3230312^3231105
 ;;2024^3240310^3241103
 ;;2025^3250309^3250302
 ;;2026^3260308^3261101
 ;;2027^3270314^3271107
 ;;2028^3280312^3281105
 ;;2029^3290311^3291104
 ;;2030^3300310^3301103
 ;;2031^3310309^3311102
 ;;2032^3320314^3321107
 ;;2033^3330313^3331106
 ;;2034^3340312^3341105
 ;;2035^3350311^3351104
 ;;2036^3360309^3361102
 ;;2037^3370308^3371101
 ;;2038^3380314^3381107
 ;;2039^3390313^3391106
 ;;2040^3400311^3401104
