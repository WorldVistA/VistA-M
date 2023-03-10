IBCNIUH1 ;AITC/TAZ - IIU RECEIVE AND PROCESS INSURANCE TRANSMISSIONS ; 04/06/21 12:46p.m.
 ;;2.0;INTEGRATED BILLING;**687,702**;21-MAR-94;Build 53
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; ICR #2171 for the usage of $$IEN^XUAF4
 Q
 ;
 ;**Program Description**
 ;  This routine is the driver routine for receiving an Interfacility Insurance Update message.  
 ;
REC ;Receive data from remote system
 N BIN,CNT,COB,DFN,DOB,ECODE,EFFDT,ERFLG,ERROR,EVENT,FDATA,FLD
 N GNAME,GNUM,GT1,HLECH,HLFS,IBACK,IBDFA,IBPRTCL,ICN,IDLIST,IDUZ
 N IIUERR,IIUIEN,INAME,INSNAME,MSG,PATDFN,PATICN,PATID,PATNAME,PCN,PTYPE,REL
 N SEGCNT,SEGMT,SITE,STATUS,SUBC,SUBCID,SUBCNT,SUBCDATA,SUBCID,SUBID
 N VAID,WHOSE,XDFN
 ;
 ;Store the incoming message into a TMP global
 K ^TMP("IBCNIUH1",$J)
 S ^TMP("IBCNIUH1",$J)=$$NOW^XLFDT
 F SEGCNT=1:1 X HLNEXT Q:HLQUIT'>0  D
 . S CNT=0
 . S ^TMP("IBCNIUH1",$J,SEGCNT,CNT)=HLNODE
 . F  S CNT=$O(HLNODE(CNT)) Q:'CNT  D
 . . S ^TMP("IBCNIUH1",$J,SEGCNT,CNT)=HLNODE(CNT)
 ;
 ;Initialize the HL7 variables
 N HLCMP,HLECH,HLFS
 S HLCMP=$E(HL("ECH"))  ;HL7 component separator 
 S HLECH=HL("ECH")      ;HL7 encoding characters
 S HLFS=HL("FS")        ;HL7 field separator
 ;
 ;Received HL7 message & save to file INTERFACILITY INSURANCE UPDATE (#365.19)
 D RECEIVE
 I $G(IIUERR)!ERFLG G RECX
 ;
 D GETSTAT
 I IIUERR G RECX
 ;
 ; Attempt to file to the "Buffer", INSURANCE VERIFICATION PROCESSOR (#355.33)
 D FILEBUF
 I IIUERR G RECX
 ;
 ;Update the receiving STATUS of the IIU entry to "S" SAVED TO BUFFER
 S STATUS="S"
 D FILESTAT
 ;
RECX ;
 K ^TMP("IBCNIUH1",$J)
 K HLNEXT,HLNODE,HLQUIT
 Q
 ;
RECEIVE ;Entry Point
 N DATA,DFN,ERROR,HCT,IBDFDA,IBSEG,ICN,IENSTR,ISCT
 N SEG,STATUS,SUBC,SUBCDATA,SUBCID,SUBCNT,UPD,XDFN
 ;
 S (ERFLG,GT1,IIUERR)=0
 ;
 S HCT=0 F  S HCT=$O(^TMP("IBCNIUH1",$J,HCT)) Q:HCT=""  D  Q:ERFLG
 . D SPAR
 . S SEG=$G(IBSEG(1))
 . ;
 . Q:SEG="PRD"  ; PRD segment carries no data to store
 . ;
 . ;Message Segment
 . I SEG="MSH" D  Q
 . . ;SITE will get stored during the processing of the PID segment
 . . ;IB*702/CKB - get the IEN not the Site number of Sending/Originating VAMC
 . . S SITE=$$IEN^XUAF4($P($G(IBSEG(4)),HLCMP))
 . ;
 . ;Patient Segment
 . I SEG="PID" D  Q
 . . K DATA
 . . S (ICN,DFN)=""
 . . S IDLIST=$G(IBSEG(4))
 . . F SUBCNT=1:1:$L(IDLIST,$E(HLECH,2,2)) D
 . . . S SUBC=$P(IDLIST,$E(HLECH,2,2),SUBCNT)
 . . . S SUBCID=$P(SUBC,$E(HLECH),5)   ; Identifier Type Code
 . . . S SUBCDATA=$P(SUBC,$E(HLECH),1) ; Data Value
 . . . I SUBCID="NI" S ICN=SUBCDATA
 . . ; Use ICN to find the patients DFN at this site
 . . I ICN'="" S XDFN=$$GETDFN^MPIF001(ICN)
 . . I +$G(XDFN)'>0,+$G(ICN)>0 S ERFLG=1 Q
 . . ;
 . . I +ICN>0 S (PATDFN,DFN)=XDFN
 . . S PATICN=SUBCDATA
 . . ; Get PATIENT NAME (if GT1, NAME OF INSURED). This is needed for the Duplicate Check, STATD.
 . . S INAME=$G(IBSEG(6))
 . . S INAME=$$DECHL7($$FMNAME^HLFNC(INAME,HLECH))
 . . ; 
 . . S DATA(.01)=PATDFN
 . . S DATA(.02)=$$NOW^XLFDT
 . . S DATA(.03)="R"       ;DIRECTION, R for RECEIVER
 . . ; Create new entry in IIU File #365.19, get IEN
 . . S IIUIEN=$$ADD^IBDFDBS(365.19,,.DATA)
 . . I 'IIUIEN S ERFLG=1 Q  ; couldn't create record
 . . S IBDFDA(1)=IIUIEN
 . . K DATA
 . . ;
 . . ; We got the variable SITE from the MSH segment
 . . S DATA(.01)=SITE      ;ORIGINATING VAMC
 . . S DATA(.02)=PATICN    ;PATIENT'S ICN
 . . ; Create new entry in IIU, ORIGINATING VAMC sub-file #365.192, get IBDFDA which = IEN
 . . S IBDFDA=$$ADD^IBDFDBS(365.192,.IBDFDA,.DATA)
 . . I 'IBDFDA D STATE ;Error Saving to the IIU file
 . ;
 . I '$G(IIUIEN) S ERFLG=1 Q  ;missing PID, abort process
 . ;
 . ;Guarantor Segment
 . I SEG="GT1" D  Q
 . . K DATA,ERROR,UPD
 . . S GT1=1
 . . S SUBID=$P($G(IBSEG(3)),HLCMP)
 . . S INAME=$G(IBSEG(4))
 . . S INAME=$$DECHL7($$FMNAME^HLFNC(INAME,HLECH))
 . . ;
 . . S DATA(1.02)=INAME    ;NAME OF INSURED
 . . S DATA(1.03)=SUBID    ;SUBSCRIBER ID
 . . ;Update IIU file with data from GT1
 . . S UPD=$$UPD^IBDFDBS(365.192,.IBDFDA,.DATA,.ERROR)
 . . I ERROR=0 D STATE  ;Error Saving to the IIU file
 . ;
 . ;Insurance Segment
 . I SEG="IN1" D  Q
 . . K DATA,ERROR,UPD
 . . I 'GT1 S SUBID=$G(IBSEG(3))
 . . I GT1 S PATID=$G(IBSEG(3))
 . . S VAID=$P($G(IBSEG(4)),HLCMP)
 . . S INSNAME=$G(IBSEG(5))
 . . S INSNAME=$$DECHL7(INSNAME)
 . . S GNUM=$$DECHL7($G(IBSEG(9)))
 . . S GNAME=$$DECHL7($G(IBSEG(10)))
 . . S EFFDT=$G(IBSEG(13))
 . . S EFFDT=$$FMDATE^HLFNC(EFFDT)
 . . S PTYPE=$G(IBSEG(16))
 . . S REL=$G(IBSEG(18))
 . . S DOB=$G(IBSEG(19))
 . . S DOB=$$FMDATE^HLFNC(DOB)
 . . S COB=$G(IBSEG(23))
 . . ;
 . . S DATA(.03)=INSNAME ;INSURANCE COMPANY NAME
 . . S DATA(.04)=GNAME   ;GROUP NAME
 . . S DATA(.05)=GNUM    ;GROUP NUMBER
 . . S DATA(.08)=PTYPE   ;PLAN TYPE
 . . S DATA(.09)=EFFDT   ;EFFECTIVE DATE
 . . S DATA(.1)=REL      ;PT. RELATIONSHIP - HIPAA
 . . S DATA(1.04)=DOB    ;INSURED'S DOB
 . . S DATA(1.05)=COB    ;COORDINATION OF BENEFITS
 . . S DATA(1.07)=VAID   ;PAYER'S VA NATIONAL ID
 . . ;If not a Guarantor, the Patient ID is the same as the Subscriber ID
 . . I 'GT1 S DATA(1.01)=SUBID,DATA(1.03)=SUBID  ;PATIENT ID/SUBSCRIBER ID
 . . I GT1 S DATA(1.01)=PATID  ;PATIENT ID
 . . ;
 . . ;Update IIU file with data from IN1
 . . S UPD=$$UPD^IBDFDBS(365.192,.IBDFDA,.DATA,.ERROR)
 . . I ERROR=0 D STATE ;Error Saving to the IIU file
 . ;
 . ;NTE Segment
 . I SEG="NTE" D  Q
 . . K DATA,ERROR,UPD
 . . S WHOSE=$P($G(IBSEG(4)),HLCMP)
 . . S BIN=$$DECHL7($P($G(IBSEG(4)),HLCMP,2))
 . . S PCN=$$DECHL7($P($G(IBSEG(4)),HLCMP,3))
 . . ;
 . . S DATA(.06)=BIN     ;BANKING IDENTIFICATION NUMBER
 . . S DATA(.07)=PCN     ;PROCESSOR CONTROL NUMBER
 . . S DATA(1.06)=WHOSE  ;WHOSE INSURANCE
 . . ;Update IIU file with data from NTE
 . . S UPD=$$UPD^IBDFDBS(365.192,.IBDFDA,.DATA,.ERROR)
 . . I ERROR=0 D STATE ;error saving to the IIU file
 ;
 Q
 ;
GETSTAT ;Get the RECEIVER STATUS (365.19,2.01) by performing various checks
 S IIUERR=0
 D STATI I IIUERR=1 G GETSTATQ  ;I=IIU ENABLED IS OFF
 D STATR I IIUERR=1 G GETSTATQ  ;R=RECEIVE IIU DATA IS OFF
 D STATV I IIUERR=1 G GETSTATQ  ;V=VISITED TOO LONG AGO
 D STATD I IIUERR=1 G GETSTATQ  ;D=DUPLICATE
 S STATUS="S"                   ;S=SAVED TO THE BUFFER
 ;
GETSTATQ ;
 D FILESTAT  ; files STATUS into #365.19
 Q
 ;
FILEBUF ;File IIU data file #365.19 into the Buffer file #355.33
 N IBBUFDA,IBDATA,SOURCE
 ;
 S SOURCE=$$FIND1^DIC(355.12,"","X","INTERFACILITY INS UPDATE","C")
 ;Get the non-human user
 S IDUZ=$$FIND1^DIC(200,"","X","INTERFACE,IB IIU")
 ;Add a new buffer file entry (#355.33), sets only status (0) node data 
 S IBBUFDA=+$$ADD^IBCNBEE(SOURCE)
 ;There was an error saving the Buffer, set IIU RECEIVER STATUS to 'B' ERROR SAVING TO BUFFER
 I (IDUZ="")!('IBBUFDA) D STATB Q
 ; 
 S IBDATA(.02)=IDUZ       ; Entered By
 ; Source of Information was set above in $$ADD^IBCNBEE
 S IBDATA(.14)=SITE       ; Remote Location (the site that sent the IIU record)
 S IBDATA(20.01)=INSNAME  ; Insurance Company/Payer Name
 S IBDATA(40.09)=PTYPE    ; Plan Type
 S IBDATA(40.1)=BIN       ; Banking Identification Number
 S IBDATA(40.11)=PCN      ; Processor Control Number
 S IBDATA(60.01)=PATDFN   ; Patient IEN 
 S IBDATA(60.02)=EFFDT    ; Effective Date
 S IBDATA(60.05)=WHOSE    ; Whose Insurance
 S IBDATA(60.08)=DOB      ; Insured's DOB
 S IBDATA(60.12)=COB      ; Coordination of Benefits
 S IBDATA(60.14)=REL      ; Patient Relationship
 S IBDATA(90.01)=GNAME    ; Group Name
 S IBDATA(90.02)=GNUM     ; Group Number
 S IBDATA(90.03)=SUBID    ; Subscriber ID
 ;
 I GT1 D
 . S IBDATA(62.01)=$G(PATID) ; Patient/Member ID
 . S IBDATA(91.01)=INAME     ; Name of Insured
 I 'GT1 D
 . ;If not a Guarantor, the Patient/Member ID is the same as the Subscriber ID
 . S IBDATA(62.01)=SUBID  ; Patient/Member ID
 . S IBDATA(91.01)=PATDFN ; Patient IEN
 ;
 ;Add IBDATA to the buffer entry. EDITSTF ensures that Subscriber ID is saved to the buffer last.
 D EDITSTF^IBCNBES(IBBUFDA,.IBDATA)
 ;Set buffer symbol to the buffer
 D BUFF^IBCNEUT2(IBBUFDA,+$$INSERROR^IBCNEUT3("B",IBBUFDA))
 ;
 ;Add BUFFER IEN to the IIU file
 N DATA,ERROR,UPD
 S DATA(2.03)=IBBUFDA
 S UPD=$$UPD^IBDFDBS(365.19,IIUIEN,.DATA,.ERROR)
 I ERROR=0 D STATB ;Error Saving to the Buffer
 Q
 ;
STATI ;If the IIU ENABLED field is off, set RECEIVER STATUS to "I" IIU ENABLED IS OFF
 N IIUEN
 S IIUEN=$$GET1^DIQ(350.9,"1,",53.02,"I")
 I 'IIUEN S IIUERR=1,STATUS="I"
 Q
 ;
STATR ;If the RECEIVE IIU DATA is off, set RECEIVER STATUS to "R" RECEIVE IIU DATA IS OFF
 N PIEN,IIUARR,IIUIENS
 ; Get the Payer IEN
 S PIEN=$O(^IBE(365.12,"C",VAID,""))
 ; Get the IIU Payer data
 D PAYER^IBCNINSU(PIEN,"IIU","*","E",.IIUARR)
 S IIUIENS=$O(IIUARR(365.121,""))
 ; Check field 5.01 RECEIVE IIU DATA for the Payer
 I $G(IIUARR(365.121,IIUIENS,5.01,"E"))'="YES" S IIUERR=1,STATUS="R"
 Q
 ;
STATV ;If the last event date is greater then the site parameter IIU RECENT VISIT DAYS,
 ; set RECEIVER STATUS to "V" VISITED TOO LONG AGO
 N IBS,IIUDAYS,LV,SITE
 ; Get current site
 ;IB*702 CKB - get the IEN not the Site number of Receiving VAMC
 S IBS=$$IEN^XUAF4($P($$SITE^VASITE,U,3))
 ; Get last visit
 I $$TFL^IBCNIUF(PATDFN,.SITE,"R") S LV=$P(SITE(IBS),U,3)
 ; If no last visit, set error and quit
 I '$G(LV) S IIUERR=1,STATUS="V" G STATVQ
 ; Get IIU RECENT VISIT DAYS
 S IIUDAYS=$$GET1^DIQ(350.9,"1,",53.03,"I")
 ; Compare last visit to IIU RECENT VISIT DAYS
 I +$G(LV),$$FMDIFF^XLFDT(DT,LV)>IIUDAYS S IIUERR=1,STATUS="V"
STATVQ ;
 Q
 ;
STATD ;Check for Duplicate IIU entry, if found set RECEIVER STATUS to "D" DUPLICATE
 K ^TMP("IBCNRDV",$J)
 ;
 ; Build index of Buffer entries and Insurance Type subfile entries.
 D INDEX^IBCNRDV(PATDFN)
 ;
 ; Build array for checking
 N IBARY
 S IBARY(20.01)=$G(INSNAME)
 S IBARY(40.03)=$G(GNUM)
 S IBARY(60.04)=$G(SUBID)
 S IBARY(60.07)=$P($G(INAME)," ",1)
 S IBARY(60.08)=$G(DOB)
 ;
 ;If Duplicate, set IIUERR and STATUS=D and quit
 I $$DUP^IBCNRDV(.IBARY) S IIUERR=1,STATUS="D"
 ;
 K ^TMP("IBCNRDV",$J)
 Q
 ;
STATE ;If a error occurs during the creation of the entry into the IIU file (365.19),
 ;set RECEIVER STATUS to "E" ERROR SAVING TO IIU
 S IIUERR=1,STATUS="E"
 D FILESTAT
 Q
 ;
STATB ;If a error occurs during the creation of the entry into the Buffer file (355.33),
 ;set RECEIVER STATUS in the IIU file to "B" ERROR SAVING TO THE BUFFER
 S IIUERR=1,STATUS="B"
 D FILESTAT
 Q
 ;
FILESTAT ;File STATUS in File #365.19
 N DATA
 S DATA(2.01)=STATUS
 I $$UPD^IBDFDBS(365.19,IIUIEN,.DATA)
 Q
 ;
DECHL7(STR,HL) ;Decode HL7 characters
 ;INPUT:
 ;  STR    - String to be encoded
 ;  HL     - Array containing HL components returned from INIT^HLFNC2
 ;
 ; Returns an decoded string
 ;   The encoded characters are:
 ;    /F/ - Field Separator
 ;    /C/ - Component Separator
 ;    /R/ - Repetition Separator
 ;    /E/ - Escape Character
 ;    /S/ - Sub-component Separator
 ;
 ;NOTE:  This tag uses RECURSION.  Be careful how you edit it.
 ;
 I STR']"" G DECHL7Q  ;Nothing to decode
 I '$D(HL) G DECHL7Q  ;No decoding characters defined
 ;
LP ;Continue to loop through the string until all instances of encoding is decoded then exit.
 I STR'?.E1"/".A1"/".E G DECHL7Q
 I STR["/F/" S STR=$P(STR,"/",1)_HL("FS")_$P(STR,"/",3,9999)
 I STR["/C/" S STR=$P(STR,"/",1)_$E(HL("ECH"),1)_$P(STR,"/",3,9999)
 I STR["/R/" S STR=$P(STR,"/",1)_$E(HL("ECH"),2)_$P(STR,"/",3,9999)
 I STR["/E/" S STR=$P(STR,"/",1)_$E(HL("ECH"),3)_$P(STR,"/",3,9999)
 I STR["/S/" S STR=$P(STR,"/",1)_$E(HL("ECH"),4)_$P(STR,"/",3,9999)
 G LP
 ;
DECHL7Q ; Exit
 Q STR
 ;
SPAR ;Segment Parsing  (logic from SPAR^IBCNEHLU)
 ;This tag will parse the current segment referenced by the HCT index
 ;and place the results in the IBSEG array.
 ;
 ;Input Variables
 ; HCT
 ;Output Variables
 ; IBSEG (ARRAY of fields in segment)
 N II,IJ,IK,IM,IS,ISCT,ISDATA,ISEND,ISPEC,LSDATA,NPC
 ;
 ;Reset IBSEG
 K IBSEG
 ;
 S ISCT="",II=0,IS=0
  F  S ISCT=$O(^TMP("IBCNIUH1",$J,HCT,ISCT)) Q:ISCT=""  D
 . S IS=IS+1
 . S ISDATA(IS)=$G(^TMP("IBCNIUH1",$J,HCT,ISCT))
 . I $O(^TMP("IBCNIUH1",$J,HCT,ISCT))="" S ISDATA(IS)=ISDATA(IS)_HLFS
 . S ISPEC(IS)=$L(ISDATA(IS),HLFS)
 ;
 S IM=0,LSDATA=""
LP1 S IM=IM+1 Q:IM>IS
 S LSDATA=LSDATA_ISDATA(IM),NPC=ISPEC(IM)
 F IJ=1:1:NPC-1 D
 . S II=II+1,IBSEG(II)=$$CLNSTR^IBCNEHLU($P(LSDATA,HLFS,IJ),$E(HL("ECH"),1,2)_$E(HL("ECH"),4),$E(HL("ECH")))
 ;
 S LSDATA=$P(LSDATA,HLFS,NPC)
 G LP1
 Q
