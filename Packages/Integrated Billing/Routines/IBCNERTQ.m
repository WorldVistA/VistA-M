IBCNERTQ ;BI/BI-Real-time Insurance Verification ;27-AUG-2010
 ;;2.0;INTEGRATED BILLING;**438**;27-AUG-2010;Build 52
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
TRIG(N2) ; Called by triggers in the INSURANCE BUFFER FILE Dictionary (355.33)
 ; Fields:  20.01 - INSURANCE COMPANY NAME
 ;          40.02 - GROUP NAME
 ;          40.03 - GROUP NUMBER
 ;          60.01 - PATIENT NAME
 ;          60.04 - SUBSCRIBER ID
 ;          60.08 - INSURED'S DOB
 ;
 ; To make a request for Real Time Verification
 ; The following fields must contain data.
 ;          20.01 - INSURANCE COMPANY NAME
 ;          60.01 - PATIENT NAME
 ;          60.04 - SUBSCRIBER ID
 ;          60.08 - INSURED'S DOB (if patient is not the subscriber)
 ;
 N TQIEN,TQN0,NODE20,NODE40,NODE60,QF,N4,PTID,SUBID,MGRP,DFN
 N RESPONSE S RESPONSE=0
 ; Protect the FileMan variables.
 N DA,DC,DH,DI,DK,DL,DM,DP,DQ,DR,INI,MR,NX,UP
 ;
 I N2="" Q RESPONSE
 S MGRP=$$MGRP^IBCNEUT5()
 S NODE20=$G(^IBA(355.33,N2,20))
 S NODE40=$G(^IBA(355.33,N2,40))
 S NODE60=$G(^IBA(355.33,N2,60))
 I $P(NODE20,U,1)="" Q RESPONSE                      ;INSURANCE COMPANY NAME
 I $P(NODE60,U,1)="" Q RESPONSE                      ;PATIENT NAME
 I $P(NODE60,U,4)="" Q RESPONSE                      ;SUBSCRIBER ID
 I $P(NODE60,U,14)'=18,$P(NODE60,U,8)="" Q RESPONSE  ;DATE OF BIRTH
 ;
 ; exclude ePharmacy buffer entries
 I $G(IBNCPDPELIG) Q  ; variable set in ^IBNCPDP3
 I $P($G(^IBA(355.33,N2,0)),U,17)'="" Q RESPONSE
 ;
 ; prevent HMS entries from creating inquiries
 N PTR S PTR=+$P($G(^IBA(355.33,N2,0)),U,3)
 I PTR,$P($G(^IBE(355.12,PTR,0)),U,2)="HMS",$P($G(^IBA(355.33,N2,60)),U,14)="" Q RESPONSE
 ;
 ; Quit if a waiting transaction exists in file #365.1
 S PTID=$P(NODE60,U,1)
 S SUBID=$P(NODE60,U,4)
 S QF=0,N4=""
 F  S N4=$O(^IBCN(365.1,"E",PTID,N4)) Q:N4=""  Q:QF=1  D
 .S TQN0=$G(^IBCN(365.1,N4,0))
 .; don't send again if there's an entry in the queue with the same subsciber id, same buffer entry, and
 .; transmission status other than "response received" or "cancelled" 
 .I $P(TQN0,U,5)=N2,".3.7."'[("."_$P(TQN0,U,4)_"."),$P(TQN0,U,16)=SUBID S QF=1 Q
 .Q
 I QF=1 Q RESPONSE                                    ; DON'T SEND AGAIN.
 ;
 ; Quit if there is a lock on patient and policy in file #355.33
 L +^IBA(355.33,N2):1 I '$T Q RESPONSE                ; RECORD LOCKED By Another Process
 ;
 ;Store Service Type Codes in BUFFER file #355.33 just before sending to EIV TRANSMISSION QUEUE
 D SETSTC(N2)
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
ENDTRIG  ; Final Clean Up.
 ;
 ; Restore the dictionary 355.33 temporary error global, ^TMP("DIERR",$J)
 K ^TMP("DIERR",$J)
 M ^TMP("DIERR",$J)=^TMP("IBCNERTQ","DIERR",$J)
 K ^TMP("IBCNERTQ","DIERR",$J)
 ;
 ; Remove Dictionary Entry Lock.
 L -^IBA(355.33,N2)
 ;
 Q RESPONSE
 ;
IBE(IEN) ; Insurance Buffer Extract
 N SETSTR,FRESHDAY,ISYMBOL,STATIEN,OVRFRESH
 N PDOD,SRVICEDT,FRESHDT,PAYERSTR,PAYERID,SYMBOL
 N PIEN,INSNAME,MCAREFLG,TQDT,TQIENS,TQOK,QUEUED
 N TQIEN,CNT,SIDCNT,MAXCNT
 ;
 S CNT=0
 ;
 S QUEUED=0
 S SETSTR=$$SETTINGS^IBCNEDE7(1)     ;Returns buffer extract settings
 I 'SETSTR Q QUEUED                  ;Quit if extract is not active
 S MAXCNT=$P(SETSTR,U,4)             ;Max # TQ entries that may be created
 S:MAXCNT="" MAXCNT=9999999999
 ;
 S FRESHDAY=$P($G(^IBE(350.9,1,51)),U,1)          ;System freshness days
 ;
 ; Get symbol, if symbol'=" " OR "!" OR "#" then quit
 S ISYMBOL=$$SYMBOL^IBCNBLL(IEN)                  ;Insurance buffer symbol
 I (ISYMBOL'=" ")&(ISYMBOL'="!")&(ISYMBOL'="#") Q QUEUED
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
 S SRVICEDT=DT I PDOD S SRVICEDT=PDOD             ;Service Date
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
 S INSNAME=$P($G(^IBA(355.33,IEN,20)),U)
 I INSNAME["MEDICARE",$G(MCAREFLG(DFN)) Q QUEUED
 ;
 ; If freshness overide flag is set, file to TQ and quit
 I OVRFRESH=1 D  Q $G(TQIEN)
 . NEW DIE,X,Y,DISYS
 . S FDA(355.33,IEN_",",.13)="" D FILE^DIE("","FDA") K FDA
 . S:INSNAME["MEDICARE" MCAREFLG(DFN)=1 D TQ^IBCNEDE1
 ; Check the existing TQ entries to confirm that this buffer IEN is
 ; not included
 S (TQDT,TQIENS)="",TQOK=1
 I ISYMBOL'="#" F  S TQDT=$O(^IBCN(365.1,"AD",DFN,PIEN,TQDT)) Q:'TQDT!'TQOK  D
 . F  S TQIENS=$O(^IBCN(365.1,"AD",DFN,PIEN,TQDT,TQIENS)) Q:'TQIENS!'TQOK  D
 .. I $P($G(^IBCN(365.1,TQIENS,0)),U,5)=IEN S TQOK=0 Q
 I TQOK S:INSNAME["MEDICARE" MCAREFLG(DFN)=1 D TQ^IBCNEDE1
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
SETSTC(BUFF) ; set service type codes
 N DIE,DA,DR,K,X,Y
 I '+$G(BUFF) Q
 S DR=""
 ; Define Service Type Codes (STC) to be sent with Insurance Inquiry
 S DIE="^IBA(355.33,",DA=BUFF
 ; Store 11 DEFAULT STCs
 F K=80.01:.01:80.11 S DR=DR_K_"////"_$P($G(^IBE(350.9,1,60)),U,K-80*100)_";"
 ; Store up to 9 SITE SELECTED STCs, otherwise NULLs
 F K=80.12:.01:80.2 S DR=DR_K_"////"_$P($G(^IBE(350.9,1,61)),U,K-80*100-11)_";"
 S DR=$E(DR,1,$L(DR)-1)
 D ^DIE
 Q
