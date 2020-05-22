IBCNERTQ ;ALB/BI - Real-time Insurance Verification ;15-OCT-2015
 ;;2.0;INTEGRATED BILLING;**438,467,497,549,582,593,601,631,659**;21-MAR-94;Build 16
 ;;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
TRIG(N2) ; Called by triggers in the INSURANCE BUFFER FILE Dictionary (355.33)
 ; Fields:  20.01 - INSURANCE COMPANY NAME
 ;          90.01 - GROUP NAME
 ;          90.02 - GROUP NUMBER
 ;          60.01 - PATIENT NAME
 ;          90.03 - SUBSCRIBER ID
 ;          60.08 - INSURED'S DOB
 ;          62.01 - PATIENT ID
 ;
 ; To make a request for Real Time Verification
 ; The following fields must contain data.
 ;          20.01 - INSURANCE COMPANY NAME
 ;          60.01 - PATIENT NAME
 ;          90.03 - SUBSCRIBER ID (if patient is the subscriber)
 ;          60.08 - INSURED'S DOB (if patient is not the subscriber)
 ;          62.01 - PATIENT ID (if patient is not the subscriber)
 ;
 ;
 N TQIEN,TQN0,NODE20,NODE60,NODE90,QF,N4,PTID,SUBID,MGRP,DFN,PREL
 N RESPONSE S RESPONSE=0
 ; Protect the FileMan variables.
 N DA,DB,DC,DH,DI,DK,DL,DM,DP,DQ,DR,INI,MR,NX,UP
 ;
 I N2="" Q RESPONSE
 ;IB*582/HAN - Do not allow entries to process if the user is INTERFACE,IB EIV
 N EIVDUZ S EIVDUZ=$$FIND1^DIC(200,"","X","INTERFACE,IB EIV")
 ;IB*2.0*593/HN - Added to allow nightly extract entries to go out immediately.
 I $G(IDUZ)'="",IDUZ=EIVDUZ,$G(CALLEDBY)'="",CALLEDBY="IBCNEHL1" Q RESPONSE
 ;IB*582 - End
 S MGRP=$$MGRP^IBCNEUT5()
 S NODE20=$G(^IBA(355.33,N2,20))
 S NODE60=$G(^IBA(355.33,N2,60))
 S NODE90=$G(^IBA(355.33,N2,90))
 S PREL=$P(NODE60,U,14)
 I $P(NODE20,U,1)="" Q RESPONSE                       ;INSURANCE COMPANY NAME
 I $P(NODE60,U,1)="" Q RESPONSE                       ;PATIENT NAME
 I $P(NODE90,U,3)="" Q RESPONSE                       ;SUBSCRIBER ID
 ; exclude dependent inquiries w/o patient id or DOB
 I PREL'=18,PREL'="",($P($G(^IBA(355.33,N2,62)),U)=""!($P(NODE60,U,8)="")) Q RESPONSE
 ; exclude ePharmacy buffer entries
 I $G(IBNCPDPELIG) Q RESPONSE  ; variable set in ^IBNCPDP3
 I $P($G(^IBA(355.33,N2,0)),U,17)'="" Q RESPONSE
 ;
 ; prevent HMS entries from creating inquiries
 N PTR S PTR=+$P($G(^IBA(355.33,N2,0)),U,3)
 I PTR,$P($G(^IBE(355.12,PTR,0)),U,2)="HMS",PREL="" Q RESPONSE
 ;
 ; Quit if a waiting transaction exists in file #365.1
 S PTID=$P(NODE60,U,1)
 S SUBID=$P(NODE90,U,3)
 S QF=0,N4=""
 F  S N4=$O(^IBCN(365.1,"E",PTID,N4)) Q:N4=""  Q:QF=1  D
 .S TQN0=$G(^IBCN(365.1,N4,0))
 .; don't send again if there's an entry in the queue with the same subscriber id, same buffer entry, and
 .; transmission status other than "response received" or "cancelled" 
 .I $P(TQN0,U,5)=N2,".3.7."'[("."_$P(TQN0,U,4)_"."),$P(TQN0,U,16)=SUBID S QF=1 Q
 .Q
 I QF=1 Q RESPONSE                                    ; DON'T SEND AGAIN.
 ;
 ; Quit if there is a lock on patient and policy in file #355.33
 L +^IBA(355.33,N2):1 I '$T Q RESPONSE                ; RECORD LOCKED By Another Process
 ;
 ;Store Service Type Code in BUFFER file #355.33 just before sending to EIV TRANSMISSION QUEUE
 I +$G(^IBA(355.33,N2,80))'>0 D SETSTC(N2)
 ;
 ; Save and clear the dictionary 355.33 temporary error global, ^TMP("DIERR",$J)
 K ^TMP("IBCNERTQ","DIERR",$J)
 M ^TMP("IBCNERTQ","DIERR",$J)=^TMP("DIERR",$J)
 K ^TMP("DIERR",$J)
 ;
 ; if buffer entry is currently being edited, set the flag and quit
 I $G(^TMP("IBCNERTQ",$J,N2,"LOCK"))=1 S ^TMP("IBCNERTQ",$J,N2,"TRIGGER")=1 G ENDTRIG
 ;
 ; Sending to the EIV TRANSMISION QUEUE.
 S TQIEN=$$IBE(N2) I 'TQIEN G ENDTRIG
 ; Load and Send HL7 Message
 S RESPONSE=$$PROCSEND(TQIEN)
 ;
ENDTRIG ; Final Clean Up.
 ;
 ; Restore the dictionary 355.33 temporary error global, ^TMP("DIERR",$J)
 K ^TMP("DIERR",$J)
 M ^TMP("DIERR",$J)=^TMP("IBCNERTQ","DIERR",$J)
 K ^TMP("IBCNERTQ","DIERR",$J)
 ;
 ; Remove Dictionary Entry Lock.
 L -^IBA(355.33,N2)
 Q RESPONSE
 ;
IBE(IEN) ; Insurance Buffer Extract
 N FRESHDAY,FRESHDT,INSNAME,ISMBI,ISYMBOL,MCAREFLG,OVRFRESH,PAYERID,PAYERSTR
 N PIEN,QUEUED,SRVICEDT,STATIEN,SYMBOL,TQDT,TQIENS,TQOK
 ;
 S QUEUED=0
 S FRESHDAY=$P($G(^IBE(350.9,1,51)),U,1)          ;System freshness days
 ;
 ; Get symbol, if symbol'=" " OR "!" OR "#" then quit
 S ISYMBOL=$$SYMBOL^IBCNBLL(IEN)                  ;Insurance buffer symbol
 I (ISYMBOL'=" ")&(ISYMBOL'="!")&(ISYMBOL'="#") Q QUEUED
 ;
 ;/vd-IB*2.0*659 - Quit if VAMC Site is MANILA (#358) & EIV is disabled for MANILA.
 I $P($$SITE^VASITE,U,3)=358,$$GET1^DIQ(350.9,"1,",51.33,"I")="N" Q 0
 ;
 ; IB*2.0*549 -  Quit if Realtime  Extract Master switch is off
 ; Note: Checking here instead of the top of TRIG to check for above error conditions first
 Q:$$GET1^DIQ(350.9,"1,",51.27,"I")="N" 0
 ;
 ; Get the eIV STATUS IEN and quit for response related errors
 S STATIEN=+$P($G(^IBA(355.33,IEN,0)),U,12)
 I ",11,12,15,"[(","_STATIEN_",") Q QUEUED        ;Prevent update for response errors
 ;
 S OVRFRESH=$P($G(^IBA(355.33,IEN,0)),U,13)       ;Freshness OvrRd flag
 S DFN=$P($G(^IBA(355.33,IEN,60)),U,1)            ;Patient DFN
 Q:DFN="" QUEUED
 I $P($G(^DPT(DFN,0)),U,21) Q QUEUED              ;Exclude if test patient
 ;
 S PDOD=$P($G(^DPT(DFN,.35)),U,1)\1               ;Patient's date of death
 S SRVICEDT=+$P($G(^IBA(355.33,IEN,0)),U,18) S:'SRVICEDT SRVICEDT=DT ; Service Date
 ;
 ; IB*2.0*549 Removed following line
 ;I PDOD,PDOD<SRVICEDT S SRVICEDT=PDOD
 S FRESHDT=$$FMADD^XLFDT(SRVICEDT,-FRESHDAY)
 S PAYERSTR=$$INSERROR^IBCNEUT3("B",IEN)          ;Payer String
 S PAYERID=$P(PAYERSTR,U,3),PIEN=$P(PAYERSTR,U,2) ;Payer ID
 S SYMBOL=+PAYERSTR                               ;Payer Symbol
 I '$$PYRACTV^IBCNEDE7(PIEN) Q QUEUED             ;Payer is not nationally active
 ;
 ; If payer symbol is returned set symbol in Ins. Buffer and quit
 I SYMBOL D BUFF^IBCNEUT2(IEN,SYMBOL) Q QUEUED
 ;
 D CLEAR^IBCNEUT4(IEN)                            ;Remove any existing symbol
 ;
 ; If no payer ID or no payer IEN is returned quit
 I (PAYERID="")!('PIEN) Q QUEUED
 ;
 ; Update service date and freshness date based on payer's allowed
 ;  date range
 D UPDDTS^IBCNEDE6(PIEN,.SRVICEDT,.FRESHDT)
 ;
 ; Update service dates for inquiries to be transmitted
 D TQUPDSV^IBCNEUT5(DFN,PIEN,SRVICEDT)
 ;
 ; Allow only one MEDICARE transmission per patient
 ; IB*2*601/DM 
 ;S INSNAME=$P($G(^IBA(355.33,IEN,20)),U)
 ;I INSNAME["MEDICARE",$G(MCAREFLG(DFN)) Q QUEUED
 S INSNAME=$$GET1^DIQ(355.33,IEN_",","INSURANCE COMPANY NAME")
 S ISMBI=$$MBICHK^IBCNEUT7(IEN) ;IB*2.0*631/TAZ - Set the MBI Check into a variable since it is used in multiple places.
 I 'ISMBI,INSNAME["MEDICARE",$G(MCAREFLG(DFN)) Q QUEUED
 ; make sure that entries have pat. relationship set to "self"
 D SETREL^IBCNEDE1(IEN)
 ;
 ; If freshness override flag is set, file to TQ and quit
 I OVRFRESH=1!ISMBI D  Q $G(TQIEN)
 . ;IB*2.0*631/TAZ - Changed logic to call new TQ
 . ;N DIE,DISYS,SUBID,WHICH,X,Y
 . ;S SUBID=$$GET1^DIQ(365.1,TQIEN_",",.16,"I"),WHICH=$S(SUBID="MBIRequest":7,1:5)
 . N DIE,DISYS,WHICH,X,Y
 . S WHICH=$S(ISMBI:7,1:5)
 . S FDA(355.33,IEN_",",.13)="" D FILE^DIE("","FDA") K FDA
 . S:INSNAME["MEDICARE" MCAREFLG(DFN)=1 D TQ^IBCNERTU(WHICH,IEN,FRESHDT,DFN,PIEN,OVRFRESH,SRVICEDT)
 ; Check the existing TQ entries to confirm that this buffer IEN is
 ; not included
 S (TQDT,TQIENS)="",TQOK=1
 I ISYMBOL'="#" F  S TQDT=$O(^IBCN(365.1,"AD",DFN,PIEN,TQDT)) Q:'TQDT!'TQOK  D
 . F  S TQIENS=$O(^IBCN(365.1,"AD",DFN,PIEN,TQDT,TQIENS)) Q:'TQIENS!'TQOK  D
 .. I $P($G(^IBCN(365.1,TQIENS,0)),U,5)=IEN S TQOK=0 Q
 I TQOK S:INSNAME["MEDICARE" MCAREFLG(DFN)=1 D TQ^IBCNERTU(6,IEN,FRESHDT,DFN,PIEN,OVRFRESH,SRVICEDT) ;IB*2.0*631/TAZ
 Q $G(TQIEN)
 ;
PROCSEND(TQIEN) ; Make call to PROC^IBCNEDEP to build the HL7 message.  Then send the Message.
 N BUFF,CNT,D,D0,DFN,DIC,DIE,DILOCKTM,DISYS,EXT
 N FRDT,GT1,HCT,HL,HLCDOM,HLCINS,HLCS,HLCSTCP,HLDOM,HLECH
 N HLFS,HLHDR,HLINST,HLIP,HLN,HLP,HLPARAM,HLPROD,HLQ,HLRESLT
 N HLSAN,HLTYPE,HLX,IBCNHLP,IEN,IHCNT,IN1,IRIEN,MSGID,TOT
 N NRETR,NTRAN,OVRIDE,PATID,PAYR,PID,QUERY,RSTYPE,SRVDT,STA
 N SUB4,SUBID,TRANSR,U,VACNTRY,VNUM,X,ZMID
 ;
 K ^TMP("HLS",$J)
 S IEN=TQIEN
 I $D(DT)=0 N DT S DT=$$DT^XLFDT
 S U="^",CNT=0,TOT=0,IHCNT=0
 S QUERY=$P($G(^IBCN(365.1,IEN,0)),U,11)
 I QUERY="V" S VNUM=3
 I $D(VNUM)=0 Q 0
 ;
 ; IB*2.0*549 - quit if test site and not a valid test case
 Q:'$$XMITOK^IBCNETST(IEN) 0
 ;
 ;  Initialize HL7 variables protocol for Verifications
 S IBCNHLP="IBCNE IIV RQV OUT"
 D INIT^IBCNEHLO
 D PROC^IBCNEDEP
 D GENERATE^HLMA(IBCNHLP,"GM",1,.HLRESLT,"",.HLP)
 ;  If not successful
 I $P(HLRESLT,U,2)]"" D HLER^IBCNEDEQ Q 0
 ;  If successful
 D SCC^IBCNEDEQ
 K ^TMP("HLS",$J)
 ;
 I $G(^TMP("IBCNEQUDTS",$J)) D
 . S DA=IEN,DIE="^IBCN(365.1,",DR="3.01////^S X=$$NOW^XLFDT" D ^DIE
 ;
 Q 1
 ;
SETSTC(BUFF) ; set service type code
 N DIE,DA,DR,X,Y
 I '+$G(BUFF) Q
 ; Define Service Type Code (STC) to be sent with Insurance Inquiry
 S DIE="^IBA(355.33,",DA=BUFF
 S DR="80.01////"_$P($G(^IBE(350.9,1,60)),U)
 D ^DIE
 Q
