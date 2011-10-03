RORHL02 ;HOIFO/CRT,SG - HL7 REGISTRY DATA: CSP,CSR,CSS ;12/6/05 2:36pm
 ;;1.5;CLINICAL CASE REGISTRIES;**14**;Feb 17, 2006;Build 24
 ;
 Q
 ;******************************************************************************
 ;******************************************************************************
 ;                 --- ROUTINE MODIFICATION LOG ---
 ;        
 ;PKG/PATCH    DATE        DEVELOPER    MODIFICATION
 ;-----------  ----------  -----------  ----------------------------------------
 ;ROR*1.5*14   APR  2011   A SAUNDERS   CSR: Added HIV DX - FIRST DIAGNOSED
 ;                                      (#12.08) to CSR-12.  Date of Clnincal
 ;                                      AIDS logic modified for 'unknown'.
 ;******************************************************************************
 ;******************************************************************************
 ;
 ;***** CSP SEGMENTS BUILDER
 ;
 ; RORIENS       IENS of Patient Record in Registry File
 ;
 ; DXDTS         Main time frame for data extraction in
 ;               StartDate^EndDate format
 ;
 ; Return Values:
 ;       <0  Error Code
 ;        0  Ok
 ;       >0  Non-fatal error(s)
 ;
CSP(RORIENS,DXDTS) ;
 N CS,ERRCNT,FLDS,RC,RORMSG,ROROUT,STATUS,TMP
 S (ERRCNT,RC)=0
 ;--- Check the parameters
 S:$E(RORIENS,$L(RORIENS))'="," RORIENS=RORIENS_","
 ;
 S FLDS="1;2;3;3.2;6"
 D GETS^DIQ(798,RORIENS,FLDS,"IE","ROROUT","RORMSG")
 Q:$G(DIERR) $$DBS^RORERR("RORMSG",-9,,,798,RORIENS)
 I $$ICRDEF^RORHIVUT(+RORIENS)  D  Q:RC<0 RC
 . D GETS^DIQ(799.4,RORIENS,"9.01","IE","ROROUT","RORMSG")
 . S:$G(DIERR) RC=$$DBS^RORERR("RORMSG",-9,,,799.4,RORIENS)
 ;
 S STATUS=+$G(ROROUT(798,RORIENS,3,"I"))
 ;--- UPDATE
 I $G(DXDTS)>0  D  Q:RC<0 RC
 . S RC=$$CSPSEG(0,$P(DXDTS,U),$P(DXDTS,U,2))
 ;--- SELECT
 S RC=$$CSPSEG(1,$G(ROROUT(798,RORIENS,3.2,"I")))  Q:RC<0 RC
 ;--- ADD
 S RC=$$CSPSEG(2,$G(ROROUT(798,RORIENS,1,"I")))  Q:RC<0 RC
 ;--- CONFIRM
 I $G(ROROUT(798,RORIENS,2,"I"))>0  D  Q:RC<0 RC
 . S RC=$$CSPSEG(3,ROROUT(798,RORIENS,2,"I"))
 ;--- DELETE
 I STATUS=5  D  Q:RC<0 RC
 . S RC=$$CSPSEG(4,$G(ROROUT(798,RORIENS,6,"I")))
 ;--- CDC
 I $G(ROROUT(799.4,RORIENS,9.01,"I"))>0  D  Q:RC<0 RC
 . S RC=$$CSPSEG(5,ROROUT(799.4,RORIENS,9.01,"I"))
 ;---
 Q ERRCNT
 ;
 ;***** LOW-LEVEL CSP BUILDER
 ;
 ; RGEVC         Registry event code
 ; DATE          Event date (FileMan)
 ; [ENDT]        End date (FileMan)
 ;
 ; Return Values:
 ;       <0  Error Code
 ;        0  Ok
 ;
CSPSEG(RGEVC,DATE,ENDT,CSP4) ;
 ;;UPDATE^SELECT^ADD^CONFIRM^DELETE^CDC^MERGE
 N CS,RORSEG,TMP
 D ECH^RORHL7(.CS)
 ;
 ;--- Initialize the segment
 S RORSEG(0)="CSP"
 ;
 ;--- CSP-1
 S TMP=$S(RGEVC'<0:$P($P($T(CSPSEG+1),";;",2),U,RGEVC+1),1:"")
 Q:TMP="" $$ERROR^RORERR(-88,,,,"RGEVC",RGEVC)
 S RORSEG(1)=RGEVC_CS_TMP
 ;
 ;--- CSP-2
 S RORSEG(2)=$$FM2HL^RORHL7(DATE)
 ;
 ;--- CSP-3
 S:$G(ENDT)>0 RORSEG(3)=$$FM2HL^RORHL7(ENDT)
 ;
 ;--- CSP-4
 S:$G(CSP4)'?." " RORSEG(4)=CSP4
 ;
 ;--- Store the segment
 D ADDSEG^RORHL7(.RORSEG)
 Q 0
 ;
 ;***** CSR SEGMENT BUILDER
 ;
 ; [RORIENS]     IENS of Patient Record in Registry File. Either this
 ;               parameter or the PTIEN must have a valid value.
 ;
 ; [PTIEN]       Patient IEN (DFN). If no value is provided for this
 ;               parameter, then the function uses the value of the
 ;               .01 field of the patient's registry record.
 ;
 ; [RORFLDS]     Segment Fields to populate
 ;               (1,3,4,6,9,10,12 available)
 ;
 ; Return Values:
 ;       <0  Error Code
 ;        0  Ok
 ;       >0  Non-fatal error(s)
 ;
CSR(RORIENS,PTIEN,RORFLDS) ;
 N BUF,CS,ERRCNT,HIVIENS,RC,RORMSG,ROROUT,RORSEG,RORTXT,RPS,SCS,TMP,VER
 S (ERRCNT,RC)=0,HIVIENS=""
 D ECH^RORHL7(.CS,.SCS,.RPS)
 S PTIEN=+$G(PTIEN)
 ;
 I $G(RORIENS)>0  D  Q:RC<0 RC
 . S:$E(RORIENS,$L(RORIENS))'="," RORIENS=RORIENS_","
 . D GETS^DIQ(798,RORIENS,".01;.02;1","IE","ROROUT","RORMSG")
 . I $G(DIERR)  S RC=$$DBS^RORERR("RORMSG",-9,,,798,RORIENS)  Q
 . S:PTIEN'>0 PTIEN=+$G(ROROUT(798,RORIENS,.01,"I"))
 . S:$D(^RORDATA(799.4,+RORIENS,0)) HIVIENS=RORIENS
 E  S RORIENS=""
 ;
 I $G(RORFLDS)'=""  D
 . S:$E(RORFLDS)'="," RORFLDS=","_RORFLDS
 . S:$E(RORFLDS,$L(RORFLDS))'="," RORFLDS=RORFLDS_","
 E  S RORFLDS=",1,3,4,6,9,10,12," ; Default HL7 fields
 ;
 ;--- Initialize the segment
 S RORSEG(0)="CSR"
 ;
 ;--- CSR-1 - Name of the registry and version of the CCR
 I RORFLDS[",1,"  D
 . S VER=+$P(ROREXT("VERSION"),U)              ; Version
 . S:$P(VER,".",2)="" $P(VER,".",2)="0"
 . S $P(VER,".",3)=+$P(ROREXT("VERSION"),U,2)  ; Patch Number
 . S $P(VER,".",4)=+$$BUILD^ROR                ; Build Number
 . S TMP=$S(RORIENS'="":$G(ROROUT(798,RORIENS,.02,"E")),1:"")
 . S RORSEG(1)=$S(TMP'="":TMP,1:"CCR")_CS_VER
 ;
 ;--- CSR-3 - Institution
 I RORFLDS[",3,"  D
 . S RORSEG(3)=$$SITE^RORUTL03(CS)
 ;
 ;--- CSR-4 - Patient ID
 I RORFLDS[",4,"  D
 . S RORSEG(4)=PTIEN_CS_CS_CS_"USVHA"_CS_"PI"
 ;
 ;--- CSR-6 - Date when added to the registry
 I RORFLDS[",6,",RORIENS'=""  D  Q:RC<0 RC
 . S TMP=$$FMTHL7^XLFDT($G(ROROUT(798,RORIENS,1,"I"))\1)
 . I TMP'>0  S RC=$$ERROR^RORERR(-95,,,,798,RORIENS,1)  Q
 . S RORSEG(6)=TMP
 ;
 ;--- CSR-9 - Date of Clinical AIDS (HIV)
 I RORFLDS[",9,",HIVIENS'=""  D  Q:RC<0 RC
 . D GETS^DIQ(799.4,HIVIENS,".02;.03","I","ROROUT","RORMSG")
 . I $G(DIERR)  D  S ERRCNT=ERRCNT+1  Q
 . . D DBS^RORERR("RORMSG",-9,,,799.4,HIVIENS)
 . ;if not 'yes', set date to null
 . I $G(ROROUT(799.4,HIVIENS,.02,"I"))'=1  S TMP=""
 . E  S TMP=$G(ROROUT(799.4,HIVIENS,.03,"I"))
 . S RORSEG(9)=$$FM2HL^RORHL7(TMP)
 ;
 ;--- CSR-10 - Reason for addition of the patient to the registry
 I RORFLDS[",10,",RORIENS'=""  D  Q:RC<0 RC
 . S RORSEG(10)=$$ADREASON^RORHLUT1(RORIENS,CS)
 ;
 ;--- CSR-12 - Risk factors
 I RORFLDS[",12,",HIVIENS'=""  D  Q:RC<0 RC
 . N CNT,EV,FLD,RFLST,RORBUF,RORQUIT,RORRISK
 . ;S RFLST="14.01;14.02;14.03;14.04;14.07;14.08;14.09;14.1;14.11;14.12;14.13;14.16;14.17"
 . S RFLST="14.01;14.02;14.03;14.04;14.07;14.08;14.09;14.1;14.11;14.12;14.13;14.16;14.17;12.08"
 . D GETS^DIQ(799.4,HIVIENS,RFLST,"I","RORBUF","RORMSG")
 . I $G(DIERR)  D  S ERRCNT=ERRCNT+1
 . . D DBS^RORERR("RORMSG",-9,,,799.4,HIVIENS)
 . ;---
 . S RORRISK="",RORQUIT=0
 . F CNT=1:1  S FLD=$P(RFLST,";",CNT)  Q:FLD=""  D:FLD>0  Q:RORQUIT
 . . S TMP=$G(RORBUF(799.4,HIVIENS,FLD,"I"))
 . . S EV=$S(TMP=0:"NO",TMP=1:"YES",TMP=9:"UNKNOWN",1:"")
 . . ;I EV=""  S RORRISK="",RORQUIT=1  Q  ;risk factors can be null
 . . I $G(EV)="" S TMP=""
 . . S $P(RORRISK,RPS,CNT)=$G(TMP)_CS_$G(EV)
 . S RORSEG(12)=RORRISK
 ;
 ;--- Store the segment
 D ADDSEG^RORHL7(.RORSEG)
 Q $S(RC<0:RC,1:ERRCNT)
