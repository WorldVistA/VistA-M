XUOAAHL7 ;OAKCIOFO/JLG - Clinical Trainee HL7 Msg Routine;8:06 AM  22 Mar 2005
 ;;8.0;KERNEL;**251,324,344**;Jul 10, 1995
 ;
OAA ; entry point for the scheduled option [XUOAA SEND HL7 MESSAGE]
 ; This routine generates an HL7 PMU message, Update Personnel Record,
 ; based on data pointed by the ^VA(200,"ATR",ien) cross-reference.
 ; The type of message is PMU~B02 with the following structure:
 ;      MSH,EVN,STF,PRA,ORG,EDU
 ; The data generated for the STF,PRA,ORG, and EDU are not repeating.
 ;
 ; Input:
 ;   MSGID       (required) Pass by reference
 ;   ERROR       (required) Pass by reference
 ;
 ; Output:
 ;   MSGID       The message id assigned to the message when the call
 ;               succeeds; null when call does not succeed.
 ;   ERROR       0 if call succeeds.
 ;               "1^description of error" if call fails
 ;
 ; Pre-conditions:
 ;    - ^VA(200,"ATR") exists
 ;    - XUOAA PMU event protocol and XUOAA ACK subscriber protocols are
 ;      active.
 ; Postcondition:
 ;    - An HL7 PMU-B02 message is queued for transmission.
 ;    - the ^VA(200,"ATR") x-reference is killed when queueing is
 ;      successful; otherwise, it is left intact for next attempt.
 ;
 N CNT,CS,ERROR,FS,INDX,RESULT,SS,TOTAL,XUCNT,XUHLDT,XUHLDT1,XUHLMID
 N XUMTIEN,XUOAA,XUOAAHL
 S TOTAL=0
LOOP1 ; Generate batch messages of 100 messages long
 I '$D(^VA(200,"ATR")) D MAIL Q  ;No "ATR" xref
 K ^TMP("HLS",$J),XUOAA
 S (INDX,XUOAA,CNT,ERROR)=0
 D INIT Q:ERROR
 D STUB Q:ERROR  ; create msg stub (batch)
 ; iterate over list of entries (100 max) and build batch message
 F  S INDX=$O(^VA(200,"ATR",INDX)) Q:'INDX!(XUOAA>99)  D
 . L +^VA(200,INDX):30 Q:'$T
 . S XUOAA=XUOAA+1 ; message count in batch
 . ; temporary array to keep track of entries
 . S XUOAA(INDX)=$G(^VA(200,"ATR",INDX)) ; date/time recorded
 . D BLDMSG(INDX) ; build message for this entry
 . K ^VA(200,"ATR",INDX)
 . S TOTAL=TOTAL+1
 . L -^VA(200,INDX)
 D SEND
 I ERROR D RESTORE,STORENV Q
 I XUOAA>99 G LOOP1 ; more than 100 entries, create another batch
 K ^TMP("HLS",$J),XUOAA
 D MAIL
 Q
 ;
INIT ; initialize HL variables
 ; "XUOAA PMU"=event protocol, XUOAAHL=hl variables
 ; checks for valid event protocol
 D INIT^HLFNC2("XUOAA PMU",.XUOAAHL)
 I $G(XUOAAHL) S ERROR="1^"_$P(XUOAAHL,U,2) Q
 S FS=$G(XUOAAHL("FS")) ;field separator
 S CS=$E(XUOAAHL("ECH"),1) ;component separator
 S SS=$E(XUOAAHL("ECH"),4) ;sub-component separator
 Q
 ;
STUB ; create msg stub for batch msg
 ; XUHLMID=batch msg id, XUMTIEN=file 772 ien
 ; XUHLDT=FM date/time, XUHLDT1=HL7 date/time
 D CREATE^HLTF(.XUHLMID,.XUMTIEN,.XUHLDT,.XUHLDT1)
 I 'XUHLMID S ERROR="1^could not create msg stub" Q
 Q
 ;
BLDMSG(IEN) ;
 N ADDR,CITY,DEGLEV,DOB,EMAIL,ENTERDT,FACILITY,GEOLOC,IFN
 N LASTYR,MSGHDR,NAME,PROGSTD,RECORDT,SERVICE,SSN,STATE,STREET,TERMDT
 N TITLE,ZIP,XUNAME,VHATF,X,Y
 Q:'IEN
 ; extract data from Fileman and transform to HL7 datatype
 S XUNAME("FILE")=200,XUNAME("FIELD")=.01,XUNAME("IENS")=IEN
 S NAME=$$HLNAME^XLFNAME(.XUNAME,"S",CS)
 S STREET=$$GET1^DIQ(200,IEN,"STREET ADDRESS 1")
 S STREET=STREET_U_$$GET1^DIQ(200,IEN,"STREET ADDRESS 2")
 S STREET=STREET_U_$$GET1^DIQ(200,IEN,"STREET ADDRESS 3")
 S CITY=$$GET1^DIQ(200,IEN,"CITY")
 S STATE=$$GET1^DIQ(200,IEN,"STATE","I")
 S ZIP=$$GET1^DIQ(200,IEN,"ZIP CODE")
 S GEOLOC=CITY_U_STATE_U_ZIP_U_"USA"
 S ADDR=$$HLADDR^HLFNC(STREET,GEOLOC)
 S SSN=$$GET1^DIQ(200,IEN,"SSN")
 S SSN=SSN_CS_CS_CS_"USSSA"_CS_"SS"
 S EMAIL=$$GET1^DIQ(200,IEN,"EMAIL ADDRESS")
 S DEGLEV=$$GET1^DIQ(200,IEN,"CURRENT DEGREE LEVEL:ABBREVIATION")
 S PROGSTD=$$GET1^DIQ(200,IEN,"PROGRAM OF STUDY")
 S LASTYR=$$GET1^DIQ(200,IEN,"LAST TRAINING MONTH & YEAR")
 D
 . N %DT
 . S X=LASTYR,%DT="M"
 . D ^%DT
 . Q
 S LASTYR=$$FMTHL7^XLFDT(Y)
 S SERVICE=$$GET1^DIQ(200,IEN,"SERVICE/SECTION")
 S SERVICE=SERVICE_CS_CS_"SERVICE/SECTION"
 S TERMDT=$$GET1^DIQ(200,IEN,"DATE NO LONGER TRAINEE","I")
 S TERMDT=$$FMTHL7^XLFDT(TERMDT)
 S:'TERMDT TERMDT=""
 S TITLE=$$GET1^DIQ(200,IEN,"TITLE")
 S ENTERDT=$$GET1^DIQ(200,IEN,"START OF TRAINING","I")
 S ENTERDT=$$FMTHL7^XLFDT(ENTERDT)
 S:'ENTERDT ENTERDT=""
 ; date recorded
 S RECORDT=$$FMTHL7^XLFDT($G(XUOAA(IEN)))
 S FACILITY=$$NS^XUAF4($$KSP^XUPARAM("INST"))
 S FACILITY=$P(FACILITY,U,2)_CS_$P(FACILITY,U)
 D
 . S VHATF=+$$GET1^DIQ(200,IEN,"VHA TRAINING FACILITY","I")
 . I VHATF<1 S VHATF="^" Q  ;Both pieces Null
 . I VHATF>0 S VHATF=$$NS^XUAF4(VHATF)
 . Q
 S VHATF=$P(VHATF,U,2)_CS_$P(VHATF,U)
 ; IFN= internal file number
 S IFN=IEN_CS_"IEN"_CS_"NEW PERSON"
 S DOB=$$GET1^DIQ(200,IEN,"DOB","I")
 S DOB=$$FMTHL7^XLFDT(DOB)
 ; create msg header per entry
 ; XUOAAHL=hl array from INIT, XUHLMID=batch msg id from STUB
 ; XUOAA=message count, MSGHDR=message header
 D MSH^HLFNC2(.XUOAAHL,XUHLMID_"-"_XUOAA,.MSGHDR)
 ; build temporary MSG TEXT array
 S CNT=CNT+1
 S ^TMP("HLS",$J,CNT)=MSGHDR
 S CNT=CNT+1
 S ^TMP("HLS",$J,CNT)="EVN"_FS_XUOAAHL("ETN")_FS_RECORDT_FS_FS_FS_FS_FS_FACILITY
 S CNT=CNT+1
 S ^TMP("HLS",$J,CNT)="STF"_FS_IFN_FS_SSN_FS_NAME_FS_FS_FS_DOB_FS_FS_FS_SERVICE_FS_FS_ADDR_FS_FS_FS_FS_EMAIL_FS_FS_FS_TITLE
 S CNT=CNT+1
 S ^TMP("HLS",$J,CNT)="PRA"_FS_FS_FS_"OAA"_FS_FS_PROGSTD_CS_CS_CS_CS_LASTYR
 S CNT=CNT+1
 S ^TMP("HLS",$J,CNT)="ORG"_FS_1_FS_VHATF_FS_SERVICE_FS_FS_FS_FS_FS_CS_PROGSTD_CS_"PROGRAM OF STUDY"_FS_ENTERDT_CS_TERMDT
 S CNT=CNT+1
 S ^TMP("HLS",$J,CNT)="EDU"_FS_"1"_FS_DEGLEV
 D
 . ; Update Trainee's Date Transmitted to OAA
 . N DIERR,ZERR,FDA
 . S FDA(200,$S(IEN[",":IEN,1:IEN_","),12.5)=DT
 . D FILE^DIE("I","FDA","ZERR")
 Q
 ;
SEND ; send complete batch message
 ; "XUOAA PMU"=event protocol, LB=batch array type
 ; RESULT="msgid^error code^error msg" , XUMTIEN=file 772 ien from STUB
 D GENERATE^HLMA("XUOAA PMU","GB",1,.RESULT,XUMTIEN)
 I +$P(RESULT,U,2) D  Q
 . S ERROR="1^"_$P(RESULT,U,3)
 S MSGID=+RESULT
 Q
 ;
RESTORE ; message could not be sent, restore x-ref
 S INDX=0 F  S INDX=$O(XUOAA(INDX)) Q:'INDX  D
 . S ^VA(200,"ATR",INDX)=$G(XUOAA(INDX))
 Q
 ;
RECACK ; receive application acknoledgement from HL7
 I $G(HL("ACKCD"))'="AA" D
 . D STORENV("RECACK")
 Q
 ;
STORENV ; store environmental variables for logging purposes
 N APP,XTMP,X
 S APP="Clinical Trainee Core Dataset",XTMP="XUOAA"_DT
 S ^XTMP(XTMP,0)=$$FMADD^XLFDT(DT,14)_U_$$NOW^XLFDT_U_APP
 S X="^XTMP("""_XTMP_""","
 D DOLRO^%ZOSV
 Q
 ;
MAIL ;Send mail message to G.XUOAA CLIN TRAINEE TRANS
 N LN,MSGTXT,MSGSBJ
 S LN=1
 S MSGSBJ="Clinical Trainee Transmission Count"
 S MSGTXT=""
 S MSGTXT(LN)=" ",LN=LN+1
 S MSGTXT(LN)="Number of trainees transmitted to OAA: "_TOTAL
 ;Check to see if Mail Group has members
 I '$$GOTLOCAL^XMXAPIG("XUOAA CLIN TRAINEE TRANS") D SENDMSG^XMXAPI(DUZ,MSGSBJ,"MTEXT",DUZ) Q
 ; Mail Group Has Memebers so send the message
 D SENDMSG^XMXAPI(DUZ,MSGSBJ,"MSGTXT","G.XUOAA CLIN TRAINEE TRANS")
 Q
