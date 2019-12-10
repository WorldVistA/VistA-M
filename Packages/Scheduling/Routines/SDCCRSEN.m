SDCCRSEN ;CCRA/LB,PB - Appointment retrieval API;APR 4, 2019
 ;;5.3;Scheduling;**707,730**;APR 4, 2019;Build 8
 ;;Per VA directive 6402, this routine should not be modified.
 Q
 ; Documented API's and Integration Agreements
 ; ----------------------------------------------
 ; 2165   GENACK^HLMA1
 ; 2701   $$GETDFN^MPIF001
 ; 2701   $$GETICN^MPIF001
 ; 3535   MAKEADD^TIUSRVP2
 ; 10103  $$HL7TFM^XLFDT
EN() ;Primary entry routine for HL7 based CCRA scheduling processing.
 ;Will take all scheduling messages through this one point.
 N FS,CS,RS,ES,SS,MID,HLQUIT,HLNODE,USER,USERMAIL,NAKMSG,ICN
 N MSG,HDR,SEG,SEGTYPE,MSGARY,LASTSEG,HDRTIME,ABORT,BASEDT,CLINARY,COUNT,PROVDTL,RESULTS
 S RESULTS=0
 S DUZ=""
 S FS=$G(HL("FS"),"|")
 S CS=$E($G(HL("ECH")),1) S:CS="" CS="^"
 S RS=$E($G(HL("ECH")),2) S:RS="" RS="~"
 S ES=$E($G(HL("ECH")),3) S:ES="" ES="\"
 S SS=$E($G(HL("ECH")),4) S:SS="" SS="&"
 S MID=$G(HL("MID"))
 S (HLQUIT,HLNODE)=0
 ;initialize message from queue
 D COPYMSG^SDCCRCOR(.MSG)
 Q:$$CHKMSG^SDCCRCOR(.MSG)
 Q:$$PROCMSG(.MSG)
 D ACK^SDCCRCOR("CA",MID)
 Q
PROCMSG(MSG1) ; Process message
 N QUIT,I,SEGTYPE,ERR1
 N GMRCDFN,GMRCTIU,GMRCTIUS,ADDTXT,GMRCATIU,STID,RAWSEG,APTTM,DFN,CONID,CONTITLE,PROVIDER,SRVNAME1,SRVNAMEX
 K SDECSTART,SDECEND,SDDFN,SDECRES,SDECLEN,SDECNOTE,SDECATID,SDECCR,SDMRTC,SDDDT,SDREQBY,SDLAB,PROVIEN,SDID,SDAPTYP,SDSVCP,SDSVCPR,SDCL,SDEKG,SDXRAY,APPTYPE,EESTAT,OVB,SDPARENT,SDEL
 S (SDECSTART,SDECEND,SDDFN,SDECRES,SDECLEN,SDECNOTE,SDECATID,SDECCR,SDMRTC,SDDDT,SDREQBY,SDLAB,PROVIEN,SDID,SDAPTYP,SDSVCP,SDSVCPR,SDCL,SDEKG,SDXRAY,APPTYPE,EESTAT,OVB,SDPARENT,SDEL)=""
 S ABORT=0,BASEDT=""
 S (QUIT,XX)=0
 F  S XX=$O(MSG1(XX)) Q:XX'>0  D
 . Q:+$G(ABORT)>0
 . S SEGTYPE=$E(MSG1(XX),1,3),RAWSEG=$G(MSG1(XX))
 . I SEGTYPE'="NTE" S LASTSEG=SEGTYPE
 . S SEG=$G(MSG1(XX))
 . I SEGTYPE="SCH" D SCH(SEG,.MSGARY,.ABORT,.BASEDT) ;SCH MUST BE PROCESSED FIRST SOME VALIDATION DEPENDS ON APPOINTMENT STATUS IN SCH-25
 . I SEGTYPE="NTE" D NTE(SEG,.MSGARY,LASTSEG,.CLINARY,.ABORT,.PROVDTL)
 . I SEGTYPE="PID" D PID(SEG,.MSGARY,.ABORT)
 . I SEGTYPE="PV1" D PV1(SEG,.MSGARY,HDRTIME,.ABORT)
 . I SEGTYPE="RGS" D RGS(SEG,.MSGARY)
 . I SEGTYPE="AIS" D AIS(SEG,.MSGARY)
 . I SEGTYPE="AIG" D AIG(SEG,.MSGARY,.PROVDTL,BASEDT)
 . I SEGTYPE="AIL" D AIL(SEG,.MSGARY)
 . I SEGTYPE="AIP" D AIP(SEG,.MSGARY,.PROVDTL,BASEDT)
 K XX
 I $G(NAKMSG)'="" S DUZ=.5,QUIT=1 D ANAK^SDCCRCOR($G(NAKMSG),$G(USERMAIL),$G(ICN),$G(DFN),$G(APTTM),$G(CONID))
 I +$G(ABORT)=1 D MESSAGE^SDCCRCOR(MID,.ABORT) Q 1
 I +$G(ABORT)=2 D APPMSG^SDCCRCOR(MID,.ABORT) Q 1
 ;Process Message by Event Type
 ;ADD NEW APPOINTMENT: "S12"="SCHEDULE"
 I MSGARY("EVENT")="SCHEDULE" D
 . S SDECLEN=$P(^SC(SDCL,"SL"),"^",1),SDECAPTID=0
 . S:$G(DFN)>0 SDDFN=DFN
 . S:$G(SDECLEN)'>0 SDECLEN=15
 . S:$G(SDDFN)>0 SDECAPTID=$$APPTGET^SDECUTL(SDDFN,BASEDT,SDCL,SDECRES)
 . I SDECAPTID>0 D ACK^SDCCRCOR("CE",MID,"","","","","Patient already has an appointment at that datetime.",1)
 . S ABORT="1^Patient already has an appointment at that datetime."
 . ;I $G(SDECAPTID)'>0 D INP^SDCCRSCU,ARSET^SDECAR2(.RET,.INP)
 . ;Q:$G(SDECAPTID)>0
 . S SDECSTART=$P(SDECSTART,".",1)_"."_$E($P(SDECSTART,".",2),1,4)
 . S SDECSTART=$$FMTE^XLFDT(SDECSTART,2)
 . D:QUIT=0 APPADD^SDEC07(.SDECY,SDECSTART,SDECEND,SDDFN,SDECRES,SDECLEN,,,,,,,,,,SDAPTYP,,,SDCL,,,,,1,,"") ;ADD NEW APPOINTMENT
 ;CANCEL APPOINTMENT: "S15"="CANCEL" 
 I MSGARY("EVENT")="CANCEL" D
 . S SDECLEN=$P(^SC(SDCL,"SL"),"^",1),SDECAPTID=0
 . S:$G(DFN)>0 SDDFN=DFN
 . S:$G(SDECLEN)'>0 SDECLEN=15
 . ;check if appointment exists
 . ;Retrieve SDECAPTID pointer to SDEC APPOINTMENT file
 . S:$G(SDDFN)>0 SDECAPTID=$$APPTGET^SDECUTL(SDDFN,BASEDT,SDCL,SDECRES)
 . S SDECSTART=$P(SDECSTART,".",1)_"."_$E($P(SDECSTART,".",2),1,4)
 . S SDECSTART=$$FMTE^XLFDT(SDECSTART,2)
 . I $G(SDECAPTID)=0 D
 . . D ACK^SDCCRCOR("CE",MID,"","","","","NO APPOINTMENT Found to CANCEL for requested PATIENT,DATE/TIME,and CLINIC",1)
 . . S ABORT="1^NO APPOINTMENT was found to mark as CANCELED for the PATIENT on "_$G(SDECSTART)_" for consult, "_CONSULTID
 . . S QUIT=1
 . I +$G(ABORT)=1 D MESSAGE^SDCCRCOR(MID,ABORT) Q
 . D:QUIT=0 APPDEL^SDEC08(.SDECY,SDECAPTID,$G(MSGARY("CANCEL CODE")),$G(MSGARY("CANCEL REASON")),$G(MSGARY("COMMENT")),$G(SDECDATE),$G(MSGARY("USER"))) ;CANCEL APPOINTMENT
 ;NOSHOW APPOINTMENT: "S26"="NOSHOW" 
 I MSGARY("EVENT")="NOSHOW" D
 . S SDECLEN=$P(^SC(SDCL,"SL"),"^",1),SDECAPTID=0
 . S:$G(DFN)>0 SDDFN=DFN
 . S:$G(SDECLEN)'>0 SDECLEN=15
 . ;check if appointment exists
 . ;Retrieve SDECAPTID pointer to SDEC APPOINTMENT file
 . S SDECSTART=$P(SDECSTART,".",1)_"."_$E($P(SDECSTART,".",2),1,4)
 . S SDECSTART=$$FMTE^XLFDT(SDECSTART,2)
 . S SDECAPTID=$$APPTGET^SDECUTL(SDDFN,BASEDT,SDCL,SDECRES)
 . I $G(SDECAPTID)'>0 D
 . . D ACK^SDCCRCOR("CE",MID,"","","","","NO APPOINTMENT Found to NOSHOW for requested PATIENT,DATE/TIME,and CLINIC",1)
 . . S ABORT="1^NO APPOINTMENT was found to mark as NO SHOW for the PATIENT on "_$G(SDECSTART)_" for consult, "_CONSULTID
 . . S QUIT=1
 . I +$G(ABORT)=1 D MESSAGE^SDCCRCOR(MID,ABORT) Q
 . D:QUIT=0 NOSHOW^SDEC31(.SDECY,SDECAPTID,1,$G(MSGARY("USER")),$G(SDECDATE))
 D DONEINC^SDCCRCOR
 K MSG1,SDRES,SDECY,SDECDATE,SDECAPTID,RSNAME,SDAPTYP,SDCL,SDDFN,SDECNOT,SDECNOTE,INP,RET
 Q QUIT
SETEVENT(EVENT,MSGARY) ;Takes the scheduling event and sets a message event to process.
 ;EVENT (I/REQ) - Message event from the MSH header. EX. S12, S14, S15, S26
 ;MSGARY (I/O,REQ) message array structure with reformatted and translated data ready for filing. See PARSEMSG for details.
 I $G(EVENT)="" Q 0
 I EVENT="S12" S MSGARY("EVENT")="SCHEDULE" Q 1
 I EVENT="S14" S MSGARY("EVENT")="UPDATE" Q 1
 I EVENT="S15" S MSGARY("EVENT")="CANCEL" Q 1
 I EVENT="S26" S MSGARY("EVENT")="NOSHOW" Q 1
 Q 0
SCH(SCH,MSGARY,ABORT,BASEDT) ;SCH segment processing.:
 ;SEG (I/REQ) - SCH message segment data
 ;MSGARY (I/O,REQ) message array structure with deformated and translated data ready for filing. See PARSEMSG for details.
 ;ABORT (O,OPT) - Error parameter if we did not receive an appointment date and time. Fatal case to this message.
 ;BASEDT (O,REQ) - appointment base date/time to use. May be incremented later if processing multiple joint clinic scheduling
 N ORDIDTYP,SRVNAME,CONSULTID
 D PARSESEG^SDCCRSCU(SCH,.SCH)
 S MSGARY("PLACER ID")=$G(SCH(1)) ;SCH-1.1
 ;Cancel Reason
 S CONID=$G(SCH(2)),PROVIDER=$G(SCH(12,1,2))_" "_$G(SCH(12,1,3))
 I MSGARY("EVENT")="CANCEL" S MSGARY("CANCEL REASON")=$$GETRSN($G(SCH(6,1,2))),MSGARY("CANCEL CODE")=$G(SCH(6,1,5)) ;SCH-6
 ;Duration
 S (SDECLEN,MSGARY("DURATION"))=$G(SCH(9)) ;SCH-9,10
 ;Appointment Date
 N Y
 S (SDECSTART,BASEDT)=$$HL7TFM^XLFDT($G(SCH(11,1,4)),"L") ;SCH-11.3
 S APTTM=$G(SCH(11,1,4))
 N Y S SDECEND=$$HL7TFM^XLFDT($G(SCH(11,1,5)),"L") ;SCH-11.3
 I $G(BASEDT)="" S ERR1="NO APPOINTMENT DATE AND TIME" D ACK^SDCCRCOR("CE",MID,"SCH","",11,305,ERR1,1) S ABORT="1^"_ERR1 Q
 ;User
 S (MSGARY("USER"))=$$GETUSER($G(SCH(20,1,1))) ;SCH-20
 S USERMAIL=$G(SCH(13,1,4)) S:$G(USERMAIL)'="" DUZ=$O(^VA(200,"ADUPN",$$LOW^XLFSTR(USERMAIL),""))
 I DUZ'>0 S DUZ=.5,(NAKMSG,ERR1)="SCHEDULER DOESN'T HAVE AN ACCOUNT ON THIS SYSTEM",ABORT="1^"_ERR1 Q
 S MSGARY("STATUS")=$$GETSTAT($G(SCH(25))) ;SCH-25
 ; Linked Consults/Orders
 S ORDIDTYP=$$GET^SDCCRSCU(.SCH,27,2) ;Placer ID Type
 Q
NTE(NTE,MSGARY,LASTSEG,CLINARY,ABORT,PROVDTL) ;NTE segment processing.
 ;NTE (I/REQ) - NTE message segment data
 ;MSGARY (I/O,REQ) - message array structure with deformated and translated data ready for filing. See PARSEMSG for details.
 ;LASTSEG (I,REQ) - segment previous to the NTE to determine context of note.
 ;CLINARY (I/O,REQ) - List of Clinics to be scheduled. Could contain more than one for joint appointments
 ;ABORT (O,REQ) - quit parameter to the whole tag. Having one clinic unmapped must stop filing.
 ;PROVDTL (I/OPT) - passed when NTE concerns a preceding AIP or AIG segment
 N NOTE,NOTETYPE,CLINIC
 S LASTSEG=$G(LASTSEG)
 ;;;lb ===> change to HL7
 S NOTE=$$GET^SDCCRSCU(.NTE,3,1)  ;NTE-3.1
 S NOTETYPE=$$GET^SDCCRSCU(.NTE,4,1)  ;NTE-4.1
 ;Process NTE following SCH for scheduling comments.
 S NOTE=$TR(NOTE,"^","?")  ;FileMan can't handle "^"
 I LASTSEG="SCH" D
 . I ($G(MSGARY("COMMENT"))'=""),(NOTE'="") S MSGARY("COMMENT")=$G(MSGARY("COMMENT"))_" "
 . S MSGARY("COMMENT")=NOTE
 ;Process NTE following AIG/AIP for getting clinics
 I (LASTSEG="AIP")!(LASTSEG="AIG") D
 . I NOTETYPE="CLINIC" D
 . . S CLINIC=$$GETCLIN(NOTE)
 . . I CLINIC="" S ERR1="CLINIC MAPPING ERROR VALUE" D ACK^SDCCRCOR("CE",MID,"NTE","",1,300,ERR1,1) S ABORT="1^"_ERR1 Q
 . . S CLINARY(0)=$G(CLINARY(0))+1
 . . S CLINARY(CLINARY(0))=CLINIC
 . . S CLINARY(CLINARY(0),"DT")=$G(PROVDTL("DT"))
 . . S CLINARY(CLINARY(0),"LN")=$G(PROVDTL("LN"))
 Q
PID(PID,MSGARY,ABORT) ;PID segment processing.
 ;PID (I/REQ) - PID message segment data
 ;MSGARY (I/O,REQ) message array structure with deformated and translated data ready for filing. See PARSEMSG for details.
 ;ABORT (O,OPT) - Error parameter if we failed to find a valid patient. Fatal case to this message.
 N IDENTIFIERS,IENCHECK,OK
 D PARSESEG^SDCCRSCU(PID,.PID)
 S ICN=$G(PID(3,1,1)),(SDDFN,DFN)=$$GETDFN^MPIF001($P(ICN,"V"))
 Q
PV1(PV1,MSGARY,HDRTIME,ABORT) ;PV1 segment processing.
 ;PV1 (I/REQ) - PV1 message segment data
 ;MSGARY (I/O,REQ) message array structure with deformated and translated data ready for filing. See PARSEMSG for details.
 ;HDRTIME (I,OPT) - TIME FROM MSH-7, USED AS A DEFAULTING OPTION
 ;ABORT (O,OPT) - Error parameter if we failed to find a valid patient. Fatal case to this message.
 N ERROR
 D PARSESEG^SDCCRSCU(PV1,.PV1)
 S CONSULTID=0,(CONID,CONSULTID)=$G(PV1(19))
 S MSGARY("FILLER ID")=CONSULTID
 S SDAPTYP="C|"_$G(CONSULTID)
 N Y,RESNAME
 S SDECRES=$$GET1^DIQ(123,$G(CONSULTID)_",",1,"I"),(CONTITLE,SRVNAME)=$$GET1^DIQ(123,$G(CONSULTID)_",",1,"E")
 Q:$G(SRVNAME)'["COMMUNITY CARE"
 S:$G(SRVNAME)[" - " SRVNAME=$P(SRVNAME," - ",1)_"-"_$P(SRVNAME," - ",2)
 S:$G(SRVNAME)[" -" SRVNAME=$P(SRVNAME," -",1)_"-"_$P(SRVNAME," -",2)
 S:$G(SRVNAME)["- " SRVNAME=$P(SRVNAME,"- ",1)_"-"_$P(SRVNAME,"- ",2)
 S SDCL=$$CHECKLST($G(SRVNAME))
 I $G(SDCL)="" S ERROR="NO MATCH FOR "_SRVNAMEX_" PV1-19 CONSULT ID:"_CONSULTID,ERR1=ERROR D ACK^SDCCRCOR("CE",MID,"PV1","",19,305,ERR1,1) S ABORT="2^"_ERR1 Q  ;WE NEED AN ERR HERE FOR PV1(19)
 N SDRES S SDRES=$O(^SDEC(409.831,"B",$G(SRVNAMEX),"")) S:$G(SDRES)>0 SDECRES=$G(SDRES)
 I $G(SDECRES)="" S ERROR="NO CLINIC RESOURCE MATCH FOR "_SRVNAMEX,ERR1=ERROR D ACK^SDCCRCOR("CE",MID,"PV1","",19,305,ERR1) S ABORT="1^"_ERR1 Q
 ;ONLY LOG DEFAULTING ERRORS
 ;CHECK IN DATE/TIME
 S MSGARY("CHECKINDT")=$$DETTIME($$GET^SDCCRSCU(.PV1,44,1),$G(HDRTIME),.ERROR)   ;PV1-44.1
 I ($G(ERROR)'=""),($G(MSGARY("STATUS"))="CHECKED IN") D ACK^SDCCRCOR("CE",MID,"PV1","",44,306,"NO CHECK IN TIME IN PV1-44 "_ERROR,1) S ABORT="1^NO CHECK IN TIME IN PV1-44 "_ERROR Q
 ;CHECK OUT DATE/TIME
 S MSGARY("CHECKOUTDT")=$$DETTIME($$GET^SDCCRSCU(.PV1,45,1),$G(HDRTIME),.ERROR)   ;PV1-45.1
 I ($G(ERROR)'=""),($G(MSGARY("STATUS"))="CHECKED OUT") D ACK^SDCCRCOR("CE",MID,"PV1","",45,307,"NO CHECK IN TIME IN PV1-45 "_ERROR,1) S ABORT="1^NO CHECK IN TIME IN PV1-44 "_ERROR Q
 Q
RGS(RGS,MSGARY) ; RGS segment processing.
 ;Per HL7 this segment repeats and has multiple AIS/AIG/AIP segments underneath.
 ;RGS (I/REQ) - RGS message segment data
 ; MSGARY (I/O,REQ) message array structure with deformated and translated data ready for filing. See PARSEMSG for details.
 Q
AIS(AIS,MSGARY) ;AIS segment processing.
 ;Per HL7 this field can repeat within each RGS group.
 ;AIS (I/REQ) - AIS message segment data
 ;MSGARY (I/O,REQ) message array structure with deformated and translated data ready for filing. See PARSEMSG for details.
 Q
AIP(AIP,MSGARY,PROVDTL,BASEDTE) ;AIP segment processing.
 ;Per HL7 this field can repeat within each RGS group.
 ;AIP (I/REQ) - AIP message segment data
 ;MSGARY (I/O,REQ) message array structure with deformated and translated data ready for filing. See PARSEMSG for details.
 ;PROVDTL (O,REQ) - AIP date/time and length
 ;BASEDTE (I,REQ) - Appt D/T from SCH
 D PARSESEG^SDCCRSCU(AIP,.AIP)
 I $$HL7TFM^XLFDT($$GET^SDCCRSCU(.AIP,6,1),"L")'="" S PROVDTL("DT")=$$HL7TFM^XLFDT($$GET^SDCCRSCU(.AIP,6,1),"L")  ;AIP-6
 E  S PROVDTL("DT")=BASEDTE
 S PROVDTL("LN")=MSGARY("DURATION")
 Q
 ;
AIL(AIL,RETVAL) ; Process AIL Segment
 Q
AIG(AIG,MSGARY,PROVDTL,BASEDTE) ;AIG segment processing.
 ;Per HL7 this field can repeat within each RGS group.
 ;AIG (I/REQ) - AIG message segment data
 ;MSGARY (I/O,REQ) message array structure with deformated and translated data ready for filing. See PARSEMSG for details.
 ;PROVDTL (O,REQ) - AIG date/time and length
 ;BASEDTE (I,REQ) - Appt D/T from SCH
 D PARSESEG^SDCCRSCU(AIG,.AIG)
 I $$HL7TFM^XLFDT($$GET^SDCCRSCU(.AIG,8,1),"L")'="" S PROVDTL("DT")=$$HL7TFM^XLFDT($$GET^SDCCRSCU(.AIG,8,1),"L")  ;AIG-8
 E  S PROVDTL("DT")=BASEDTE
 S PROVDTL("LN")=MSGARY("DURATION")
 Q
 ;
GETRSN(SCH) ; Collects appointment reason and translates into internal format.
 ;Tries using the Title to lookup the reason. If that fails uses the ID to lookup
 ;the reason against the title. If that fails tries using the ID against the ID.
 ;SCH (I/REQ) - SCH message segment data
 Q $$DATALKUP(.SCH,"409.2","^SD(409.2,",6,302,"APPOINTMENT REASON MAPPING ERROR")
GETTYPE(OBX) ;translates appointment type into internal format
 ;OBX (I/REQ) - OBX message segment data
 N APPTTYPE
 S APPTTYPE=$$DATALKUP(.OBX,"409.1","^SD(409.1,",5,303,"APPOINTMENT TYPE MAPPING ERROR")
 I $G(APPTTYPE)="" S APPTTYPE=9
 Q APPTTYPE
 ;
GETUSER(SCH) ;collects appointment entered by user and confirms they are a user in the 200 file
 ;SCH (I/REQ) - SCH message segment data
 Q:$G(SCH)=""
 S USER=$$FIND1^DIC(200,,"X",$G(SCH),"ASECID",,"SCERR")
 S USER=.5
 Q USER
GETSTAT(SCH) ; Translates status into appropriate scheduling statuses
 ;Options: (SCHEDULED,CHECKED IN,CHECKED OUT,CANCELLED,NO SHOW)
 ;SCH (I/REQ) - SCH message segment data
 N STATUS,ID,TITLE
 S ID=$$GET^SDCCRSCU(.SCH,25,1)
 S TITLE=$$GET^SDCCRSCU(.SCH,25,2)
 I $$INSTRING^SDCCRCOR(TITLE,"SCHEDULED,CHECKED IN,CHECKED OUT,CANCELLED,NO SHOW") Q TITLE
 I $$INSTRING^SDCCRCOR(ID,"SCHEDULED,CHECKED IN,CHECKED OUT,CANCELLED,NO SHOW") Q ID
 I (ID'="")!(TITLE'="") D ACK^SDCCRCOR("CE",MID,"SCH",25,"",309,"SCHEDULING STATUS MAPPING ERROR",1) S ABORT="1^SCHEDULING STATUS MAPPING ERROR" Q
 Q "NA"
GETIDS(PID,IDENTIFIERS) ;Loops over PID-3 and extracts all IDs out into an array. Currently will identify ICN and IEN identifiers only
 ;PID (I,REQ) - PID message segment data
 ;IDENTIFIERS (O,REQ) - Identifier array to return
 K IDS    ;force output parameter
 N REP,ID,ASSIGN,IDTYPE
 S ID=PID(3,1,5)
 S IDENTIFIERS("PATIENT IEN")=$G(PID(3,2,1))   ;DFN
 S IDENTIFIERS("PATIENT ICN")=$G(PID(3,1,1))   ;ICN
 Q
ISPATIEN(ASSIGN,IDTYPE) ;Determines if given id descriptors are the IEN for this instance
 ;ASSIGN (I,OPT) - Assigning Authority of this identifier
 ;IDTYPE (I,OPT) - ID Type of this identifier
 I $G(IDTYPE)="IEN" Q 1
 Q 0
ISPATICN(ASSIGN,IDTYPE) ;Determines if given id descriptors are the ICN for this instance
 ;ASSIGN (I,OPT) - Assigning Authority of this identifier
 ;IDTYPE (I,OPT) - ID Type of this identifier
 I $G(IDTYPE)="ICN" Q 1
 Q 0
GTIENICN(PATICN) ;Lookup the IEN for a given ICN
 ;PATICN (I,REQ) - Patient ICN
 ;IDTYPE (I,OPT) - ID Type of this identifier
 N PATIEN
 S PATIEN=""
 Q PATIEN
GETCLIN(ID) ;Collects clinic from the PV1-3.1 segment. There is no title component to this data type.
 ;ID (I/REQ) - Clinic string to lookup clinic with
 ;Check Requirements
 I $G(ID)="" Q ""
 N CLINIC
 ; Try robust multi tier lookup
 S CLINIC=$O(^SC("B",ID,""))
 I CLINIC'="" Q CLINIC
 I $G(^SC(ID,0))'="" Q ID
 Q ""
GETELIG(OBX) ;Collects appointment eligibility and translates into internal format
 ;Tries using the Title to lookup the eligibility. If that fails uses the
 ;ID to lookup the reason against the title. If that fails tries using the ID against the ID.
 ;OBX (I/REQ) - OBX message segment data
 Q $$DATALKUP(.OBX,"8","^DIC(8,",5)
DETTIME(PV1TIME,HDRTIME,ERROR) ;RETURNS THE BEST CHECK IN/OUT TIME AVAILABLE IN THE MESSAGE OR DEFAULTS TO NOW
 ;PV1TIME (I,OPT)   - HIGHEST PRIORITY TIME TO RETURN FROM EITHER PV1-44 OR PV1-45
 ;HDRTIME (I,OPT)   - TIME FROM MSH-7
 ;ERROR   (O,OPT)   - ERROR OUTPUT PARAMETER
 K ERROR
 I $G(PV1TIME)'="" Q $$HL7TFM^XLFDT(PV1TIME,"L")
 I $G(HDRTIME)'="" S ERROR="FALLING BACK TO MSH-7" Q $$HL7TFM^XLFDT(HDRTIME,"L")
 S ERROR="FALLING BACK TO FILING TIME"
 Q $$NOW^XLFDT()
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
CHECKLST(SRVNAME) ;
 ; lookup matching clinic for imaging comm care consults
 I $G(SRVNAME)="" Q 0
 N CLINID,CLINIC,CONTITLE
 S CONTITLE=SRVNAME
 S (RSNAME,SRVNAME)="COM CARE-"_$P($P(SRVNAME,"COMMUNITY CARE",2),"-",2),SRVNAME=$E(SRVNAME,1,30) S:$E(SRVNAME,30)=" " SRVNAME=$E(SRVNAME,1,29)
 S:$E($P(RSNAME,"-",2),1,3)="DOD" (RSNAME,SRVNAME)="CC-"_$P(RSNAME,"-",2)
 S CLINID=$O(^SC("B",$E($G(SRVNAME),1,30),""))
 I $G(CLINID)'>0 D
 .F I=1:1:7 D
 ..Q:$G(CLINID)>0
 ..I $P($P($T(LIST+I),";;",2),"^",1)=CONTITLE S CLINIC=$P($P($T(LIST+I),";;",2),"^",2),CLINID=$O(^SC("B",$G(CLINIC),"")),SRVNAME=CLINIC
 I CLINID'>0 D
 . N LENG,SRVNAME1
 . S LENG=0
 . S LENG=$L(SRVNAME)
 . S (SRVNAME,SRVNAME1)=$S(LENG>28:$E(SRVNAME,1,28)_"-X",1:$G(SRVNAME)_"-X"),CLINID=$O(^SC("B",$G(SRVNAME1),""))
 S SRVNAMEX=SRVNAME
 Q CLINID
LIST ; List of Imaging Community Care consult titles and clinics
 ;;COMMUNITY CARE-IMAGING CT-AUTO^COM CARE-IMAG CT-AUTO
 ;;COMMUNITY CARE-IMAGING GENERAL RADIOLOGY-AUTO^COM CARE-IMAG GEN RAD-AUTO
 ;;COMMUNITY CARE-IMAGING MAGNETIC RESONANCE IMAGING-AUTO^COM CARE-IMAG MRI-AUTO
 ;;COMMUNITY CARE-IMAGING MAMMOGRAPHY DIAGNOSTIC-AUTO^COM CARE-IMAG MAM DIAG-AUTO
 ;;COMMUNITY CARE-IMAGING MAMMOGRAPHY SCREEN-AUTO^COM CARE-IMAG MAM SCR-AUTO
 ;;COMMUNITY CARE-IMAGING NUCLEAR MEDICINE-AUTO^COM CARE-IMAG NUC MEC-AUTO
 ;;COMMUNITY CARE-IMAGING ULTRASOUND-AUTO^COM CARE-IMAG U/S-AUTO
