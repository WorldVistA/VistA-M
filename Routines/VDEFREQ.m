VDEFREQ ;INTEGIC/AM & BPOIFO/JG - VDEF Request Processor ; 15 Nov 2005  3:00 PM
 ;;1.0;VDEF;**3**;Dec 28, 2004
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; IA: 10063 - $$S^%ZTLOAD
 ;     10063 - $$ASKSTOP^%ZTLOAD
 ;
 Q  ; No bozos
 ;
EN ; Main entry point for the Request Queue processor from TaskMan
 ;
 ; Input parameter:
 ;   QIEN - Request Queue IEN passed in by TaskMan
 ;
 ; Output parameters:
 ;   ZTSTOP - flag indicating whether to stop processing: 0 by default
 ;    1 if an outside request to stop the Processor or internal error
 ;    2 if VistA HL7 API errored out
 ;   ZTREQ  - Tells the Submanager to delete this task's record if "@"
 ;
 N DSTDATA,DSTIEN,ERR,FDA,NVPIEN,QUEUE,SCHED,IEN,VDEFWAIT,VDEFTSK
 S VDEFTSK=ZTSK
 ;
 ; Lock this Request Queue from other processors. If it's already locked,
 ; another process has it.
 L +^VDEFHL7(579.3,"QUEUE",QIEN):1 G EXIT:'$T
 ;
EN1 ; Re-entry point after the wait period has expired
 ;
 ; Quit if there has been a request to stop processing
 S ZTSTOP=$$S^%ZTLOAD() G EXIT:ZTSTOP
 ;
 ; Get the queue data
 S QUEUE=$G(^VDEFHL7(579.3,QIEN,0))
 ;
 ; Quit if this Request Queue is suspended
 G EXIT:$P(QUEUE,U,9)="S"
 ;
 ; Set the wait period to the REQUEST QUEUE WAKEUP
 S VDEFWAIT=+$P(QUEUE,U,2)
 ;
 ; See if current time is in a scheduling rule
 S SCHED=$$SCHEDULE^VDEFQM(QIEN,$H) G EN2:'SCHED
 ;
 ; If current time is in a suspend rule, set wait period to
 ; the next start time or the basic wakeup period whichever is longer.
 I $P(SCHED,U)="S",$P(SCHED,U,2)>VDEFWAIT S VDEFWAIT=$P(SCHED,U,2) G WAITLOOP
 ;
EN2 ; Update the Request Queue definition with the current task #
 K FDA S FDA(1,579.3,QIEN_",",.11)=VDEFTSK D FILE^DIE("","FDA(1)","ERR(1)")
 ;
 ; Store VDEF Destination data in a local array
 S DSTIEN=0 F  S DSTIEN=$O(^VDEFHL7(579.2,DSTIEN)) Q:'DSTIEN  D
 . S DSTDATA(DSTIEN)=$G(^VDEFHL7(579.2,DSTIEN,0))
 ;
 ; Loop through the Queued Up requests for this queue
 S (ZTSTOP,IEN)=0
 F  S IEN=$O(^VDEFHL7(579.3,"C","Q",QIEN,IEN)) Q:IEN=""  D  Q:ZTSTOP
 . ;
 . ; Quit if there has been a request to stop processing
 . S ZTSTOP=$$S^%ZTLOAD() Q:ZTSTOP
 . I $P($G(^VDEFHL7(579.3,QIEN,0)),U,9)="S" S ZTSTOP=1 Q
 . N DSTPROT,DSTTYP,DYNAMIC,ERR,SITEPARM
 . N FDA,VDEFHL,HLA,HLCS,IEN577,IENS,II,HL
 . N NAMEVAL,PAIR,REQUEST,SUBT,VAL,VDEFERR
 . S IENS=IEN_","_QIEN_"," ; Request Queue IEN string
 . L +^VDEFHL7(579.3,QIEN,IEN):5 Q:'$T
 . M VAL=^VDEFHL7(579.3,QIEN,1,IEN) S REQUEST=$G(VAL(0))
 . M NAMEVAL=VAL(.05) ; Name Value pairs
 . M DYNAMIC=VAL(.19) ; Dynamic Addressing information
 . K VAL
 . ;
 . ; Check for an incomplete record
 . I '$D(NAMEVAL(1)) L -^VDEFHL7(579.3,QIEN,IEN) Q
 . ;
 . ; Change request status from "Q"ueued Up to "C"hecked Out
 . S FDA(1,579.31,IENS,.02)="C" D FILE^DIE("","FDA(1)") K FDA
 . ;
 . ; Get the Event Subtype
 . S SUBT="",PAIR=$P($G(NAMEVAL(1,0)),U,2)
 . I $P(PAIR,"=",1)="SUBTYPE" S SUBT=$P(PAIR,"=",2)
 . E  D ERR("Subtype missing from Name/Value Pair") L -^VDEFHL7(579.3,QIEN,IEN) Q
 . ;
 . ; Get the VistA data file IEN
 . S NVPIEN="",PAIR=$P($G(NAMEVAL(2,0)),U,2)
 . I $P(PAIR,"=",1)="IEN" S NVPIEN=$P(PAIR,"=",2)
 . E  D ERR("IEN missing from Name/Value Pair") L -^VDEFHL7(579.3,QIEN,IEN) Q
 . ;
 . ; Retrieve the Destination information for this request
 . S DSTIEN=$P(REQUEST,U,7),DSTTYP=$P($G(DSTDATA(+DSTIEN)),U,2)
 . ;
 . ; Get the VDEF Event IEN
 . S IEN577=$P(REQUEST,U,18)
 . ;
 . ; Get the VISTA HL7 Protocol
 . S DSTPROT=$P($G(^VDEFHL7(577,IEN577,0)),U,7)
 . I DSTPROT="" D ERR("Protocol not defined in VDEF event file") S ZTSTOP=1 L -^VDEFHL7(579.3,QIEN,IEN) Q
 . ;
 . ; Create delimiter structure to use when building segments
 . D INIT^HLFNC2(DSTPROT,.VDEFHL)
 . I '$D(VDEFHL) D ERR("No HL7 parameters for this Protocol") S ZTSTOP=1 L -^VDEFHL7(579.3,QIEN,IEN) Q
 . S HLCS=$E(VDEFHL("ECH")) M HL=VDEFHL ; Some called routines use 'HL' array
 . ;
 . ; Get the site parameters
 . S SITEPARM=$$PARAM^HLCS2
 . ;
 . ; If no IEN don't generate an HL7 message
 . I $G(NVPIEN)="" D STATUS^VDEFREQ1(IENS,"P"),ERR("Invalid IEN") S ZTSTOP=1 L -^VDEFHL7(579.3,QIEN,IEN) Q
 . D NOW^%DTC S FDA(1,579.31,IENS,.09)=%
 . ;
 . ; Update this Request record with the current date & time
 . D FILE^DIE("","FDA(1)","ERR(1)") K FDA
 . ;
 . ; Generate HL7 message for this request
 . D GENERATE^VDEFREQ1(NVPIEN,.HLA,HLCS,IEN577,SUBT,DSTPROT,DSTTYP,.ZTSTOP,.VDEFHL,.DYNAMIC)
 . ;
 . ; Update request status from Checked Out to Processed or Errored Out
 . ; Leave Request Checked Out if VistA HL7 errored out (ZTSTOP=2)
 . I ZTSTOP'=2 D STATUS^VDEFREQ1(IENS,$S(ZTSTOP=1:"E",1:"P")) S ZTSTOP=0
 . I ZTSTOP=2 S ZTSTOP=0 ; If VistA HL7 errored out, continue processing
 . ;
 . ; Unlock the record
 . L -^VDEFHL7(579.3,QIEN,IEN)
 ;
 ; Quit if necessary.
 G EXIT:ZTSTOP
 ; Wait for the next time to run.
 ; The wait process is in a loop so it can check if there
 ; has been a request to stop processing before the wait expires.
WAITLOOP N I S ZTSTOP=0 F I=1:1:VDEFWAIT D  Q:ZTSTOP
 . S ZTSTOP=$$S^%ZTLOAD() Q:ZTSTOP
 . I $P(^VDEFHL7(579.3,QIEN,0),U,9)="S" S ZTSTOP=1 Q
 . H 1
 ;
 ; Quit or resume processing
 I 'ZTSTOP K I G EN1
 ;
 ; Quit
 ; Unlock the record in case it left the loop with an error
EXIT L -^VDEFHL7(579.3,"QUEUE",QIEN),-^VDEFHL7(579.3,QIEN,IEN)
 D ALERT^VDEFUTIL("VDEF REQUEST QUEUE PROCESSOR FOR "_$P(QUEUE,U)_" HAS EXITED.")
 ;
 ; Stop the task and delete this task's record
 N X,I S ZTSK=VDEFTSK,X=$$ASKSTOP^%ZTLOAD(ZTSK),ZTREQ="@"
 F I=1:1:5 D STAT^%ZTLOAD Q:ZTSK(1)=0!(ZTSK(1)>2)  H 1
 K X,I
 Q
 ;
ERR(TEXT) ; Error processing
 N FDA,ERR
 S VDEFERR=$TR(TEXT,"^"),FDA(1,579.31,IENS,.17)=VDEFERR
 D FILE^DIE("","FDA(1)","ERR")
 Q
