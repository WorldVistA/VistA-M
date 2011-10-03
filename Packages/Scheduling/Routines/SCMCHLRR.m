SCMCHLRR ;BP/DJB - PCMM HL7 Rejects - Resubmit ; 3/6/00 12:14pm
 ;;5.3;Scheduling;**210,224,272**;AUG 13, 1993
 ;
EN(SCLIM) ;Entry point for retransmitting "M"arked messages
 ;
 ;Input:  
 ;    SCLIM  - maximum messages allowed per batch passed by reference
 ;
 ;Output: none
 ;
 Q:'$D(SCLIM)
 ;
 NEW DFN,SCDELETE,VARPTR
 NEW MSGCNT,SCFAC,SCSEQ
 ;
 ;Send notification msg if new HL7 reject transmissions received
 D NOTIFY^SCMCHLM
 ;
 ;Initialize variables needed by GENERATE^SCMCHLG
 S SCFAC=+$P($$SITE^VASITE(),"^",3) ;..Facility number
 S MSGCNT=0 ;..........................Message count
 ;
 ;Loop thru PCMM HL7 TRANSMISSION LOG and resubmit items
 D LOOP
 ;
EXIT ;
 Q
 ;
 ;
LOOP ;Loop thru PCMM HL7 TRANSMISSION LOG file and find every entry
 ;with STATUS="M", and re-transmit.
 ;
 NEW TRANI
 S TRANI=0
 F  S TRANI=$O(^SCPT(404.471,"ASTAT","M",TRANI)) Q:'TRANI!(SCLIM<1)  D 
 . N WORK S (WORK,VARPTR)=$P($G(^SCPT(404.471,+TRANI,0)),U,7)
 . I '$G(WORK) D GETDATA(TRANI)  ;..Get DFN,VARPTR,SCDELETE
 . ;alb/rpm - Missing ZPC segment messages will not retransmit.
 . ;          Clear the entry by setting status to "RT".
 . I VARPTR="" D STATUS(TRANI,"RT") Q
 . D RETRAN ;.......................Re-transmit message
 Q
GETDATA(TRANI) ;Get DFN & VARPTR from PCMM HL7 TRANSMISSION LOG file
 ; Input:
 ;    TRANI    - IEN to file PCMM HL7 TRANSMISSION LOG file (#404.471)
 ;Output:
 ;    DFN      - Patient IEN
 ;    VARPTR   - Variable pointer to 404.43 (ex: "2404;SCPT(404.43,")
 ;    SCDELETE - Flag to process a delete
 ;
 NEW IDI,IDLONG,ND,PTPI
 ;
 ;Initialize return variables
 S (DFN,VARPTR)=""
 S SCDELETE=0
 ;
 S IDI=$O(^SCPT(404.471,TRANI,"ZPC","C",0)) Q:'IDI
 S ND=$G(^SCPT(404.49,IDI,0)) ;............PCMM HL7 ID zero node
 S IDLONG=$P(ND,U,1) ;.....................Get long form of ID
 ;alb/rpm;Patch 224;Fix DFN retrieval to prevent missing PID/EVN segments
 S DFN=$P($G(^SCPT(404.471,TRANI,0)),U,2) Q:'DFN
 S PTPI=$P(IDLONG,"-",1) ;.................File 404.43 IEN
 Q:'PTPI
 I '$D(^SCPT(404.43,PTPI)) S SCDELETE=1 ;..Flag to process a delete
 S VARPTR=PTPI_";SCPT(404.43," ;...........Create event pointer
 Q
 ;
RETRAN ;Re-transmit messages.
 ;
 NEW PT,PTPI,RESULT,XMITARRY
 NEW HL,HLECH,HLEID,HLFS,HLQ
 ;
 ;Initialize array
 S XMITARRY="^TMP(""PCMM"",""HL7"","_$J_")" ;..Segments
 KILL @XMITARRY
 ;
 ;Get pointer to sending event
 S HLEID=$$HLEID^SCMCHL()
 I 'HLEID D  Q
 . Q:$D(ZTQUEUED)
 . W "Unable to initialize HL7 variables - protocol not found"
 ;
 ;Initialize HL7 variables
 D INIT^HLFNC2(HLEID,.HL)
 I $G(WORK) S RESULT=$$BUILD^SCMCHLP(VARPTR,.HL,.XMITARRY,$G(TRANI)) D GEN Q
 I $O(HL(""))="" W:'$D(ZTQUEUED) $P(HL,"^",2) Q
 ;
 ;Build segment array
 I $G(SCDELETE) D  I 1 ;....................Process a deletion
 . S PTPI=$P(VARPTR,";",1)
 . D PTPD^SCMCHLB2(PTPI)
 E  D  I +RESULT<0 W $P(RESULT,"^",2) Q  ;..Process a normal entry
 . S RESULT=$$BUILD^SCMCHLB(VARPTR,.HL,.XMITARRY)
 . I +RESULT<0,'$D(ZTQUEUED) W $P(RESULT,"^",2)
 ;
 ;Generate message
GEN S RESULT=$$GENERATE^SCMCHLG()
 ;
 KILL @XMITARRY
 Q:'$G(RESULT)  ;No messages generated
 D STATUS(TRANI,"RT") ;..Change STATUS to RT
 W:'$D(ZTQUEUED) !,"Message re-transmitted..."
 Q
 ;
STATUS(TRANI,STATUS) ;Update STATUS field in PCMM HL7 TRANSMISSION LOG file.
 ; Input: TRANI - IEN of PCM HL7 TRANSMISSION LOG file
 ;       STATUS - A=Accepted, M=Marked for re-transmit, RJ=Rejected
 ;
 NEW SCERR,SCFDA,SCIENS
 Q:'$G(TRANI)
 Q:($G(STATUS)']"")
 S SCIENS=TRANI_","
 S SCFDA(404.471,SCIENS,.04)=STATUS ;..Status
 D FILE^DIE("I","SCFDA","SCERR")
 Q
 ;
AUTO(SCLIM) ;Auto retransmit messages that have not received an ACK.
 ;Check all messages with a STATUS of "Transmitted" and see if
 ;they've received an ACK. Then compare their transmit date to the
 ;date in PCMM PARAMETER file HL7 TRANSMIT PERIOD field.
 ;
 ;Input:
 ;    SCLIM - maximum messages allowed to transmit passed by reference
 ;
 ;Output: none
 ;
 Q:'$D(SCLIM)
 ;
 NEW DAYSMAX,DAYSDIFF,ND,TODAY,TRANDT,TRANI
 NEW DFN,SCDELETE,VARPTR
 NEW MSGCNT,SCFAC,SCSEQ
 ;
 ;Initialize variables needed by GENERATE^SCMCHLG
 S SCFAC=+$P($$SITE^VASITE(),"^",3) ;..Facility number
 S MSGCNT=0 ;..........................Message count
 ;
 S TODAY=$$DT^XLFDT()
 ;Get max days from HL7 PARAMETER file
 S DAYSMAX=$P($G(^SCTM(404.44,1,1)),U,6)
 I DAYSMAX="" S DAYSMAX=7 ;Default of 7 days
 ;
 S TRANI=0
 F  S TRANI=$O(^SCPT(404.471,"ASTAT","T",TRANI)) Q:'TRANI!(SCLIM<1)  D 
 . S ND=$G(^SCPT(404.471,TRANI,0))
 . Q:$P(ND,U,5)  ;........ACK already received
 . S TRANDT=$P(ND,U,3) ;..Date Transmitted
 . ;
 . ;Get number of days between Today and Transmit Date.
 . S DAYSDIFF=$$FMDIFF^XLFDT(TODAY,TRANDT,1)
 . ;
 . ;Quit if required number of days hasn't passed
 . Q:(DAYSDIFF<DAYSMAX)
 . ;
 . D GETDATA(TRANI) Q:VARPTR=""  ;..Get DFN,VARPTR,SCDELETE
 . N WORK S WORK=$P($G(^SCPT(404.471,+TRANI,0)),U,7)
 . D RETRAN ;.......................Re-transmit message
 Q
