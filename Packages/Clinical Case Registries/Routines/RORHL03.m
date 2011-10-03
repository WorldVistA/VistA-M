RORHL03 ;HOIFO/CRT - HL7 PHARMACY: ORC,RXE ; 5/30/06 8:35am
 ;;1.5;CLINICAL CASE REGISTRIES;**1**;Feb 17, 2006;Build 24
 ;
 ; Routines RORHL03* use the following IAs:
 ;
 ; #93-A         Get stop code from the file #44 (controlled)
 ; #1876         Read access to file #59
 ; #2400         OCL^PSOORRL and OEL^PSOORRL (controlled)
 ; #4820         RX^PSO52API (supported)
 ; #4826         PSS432^PSS55 and PSS436^PSS55 (supported)
 ; #10060        Read access to file #200 (supported)
 ; #10090        Read access to file #4 (supported)
 ;
 Q
 ;
 ;***** PHARMACY DATA SEGMENT BUILDER
 ;
 ; RORDFN        DFN of Patient Record in File #2
 ;
 ; .DXDTS        Reference to a local variable where the
 ;               data extraction time frames are stored.
 ;
 ; Return Values:
 ;       <0  Error Code
 ;        0  Ok
 ;       >0  Non-fatal error(s)
 ;
 ; The ^TMP("PS",$J) global node is used by this function.
 ;
EN1(RORDFN,DXDTS) ;
 N ENDT,ERRCNT,IDX,RC,STDT
 S (ERRCNT,RC)=0
 ;---
 S IDX=0
 F  S IDX=$O(DXDTS(6,IDX))  Q:IDX'>0  D  Q:RC<0
 . S STDT=$P(DXDTS(6,IDX),U),ENDT=$P(DXDTS(6,IDX),U,2)
 . S TMP=$$EN2(RORDFN,STDT,ENDT)
 . I TMP  Q:TMP<0  S ERRCNT=ERRCNT+TMP
 ;---
 Q $S(RC<0:RC,1:ERRCNT)
 ;
 ;***** PHARMACY DATA SEGMENT BUILDER
 ;
 ; RORDFN        DFN of Patient Record in File #2
 ;
 ; RORSTDT       Start Date/Time (Fileman)
 ; RORENDT       End Date/Time (Fileman)
 ;
 ; Return Values:
 ;       <0  Error Code
 ;        0  Ok
 ;       >0  Non-fatal error(s)
 ;
EN2(RORDFN,RORSTDT,RORENDT) ;
 N ERRCNT,IEN55,II,RC,ROR55,ROR55SUB,RORII,RORINC,RORINDEX,RORMSG,RORORD,RORRXE,RORTMP,RORXII,TMP
 S (ERRCNT,RC)=0
 ;
 ;--- Load the list of prescriptions
 K ^TMP("PS",$J)
 D OCL^PSOORRL(RORDFN,RORSTDT,RORENDT)
 Q:$D(^TMP("PS",$J))<10 0
 ;
 ;--- Select the prescriptions
 S RORTMP=$$ALLOC^RORTMP()
 S RORII=0
 F  S RORII=$O(^TMP("PS",$J,RORII))  Q:'RORII  D
 . S RORORD=$P(^TMP("PS",$J,RORII,0),U)
 . Q:RORORD'>0
 . S II=$P(RORORD,";"),II=$E(II,$L(II))
 . Q:'("RUV"[II)
 . ;---
 . I "UV"[II   D  Q:(TMP<RORSTDT)!(TMP'<RORENDT)
 . . S TMP=$P($G(^TMP("PS",$J,RORII,0)),U,15)
 . I II="R"  D  Q:TMP<RORSTDT
 . . S TMP=$P($G(^TMP("PS",$J,RORII,0)),U,10)
 . ;---
 . S @RORTMP@(RORII,0)=^TMP("PS",$J,RORII,0)
 K ^TMP("PS",$J)
 ;
 ;--- Browse through the list and generate the HL7 segments
 S ROR55=$$ALLOC^RORTMP(.ROR55SUB)
 S RORII=0
 F  S RORII=$O(@RORTMP@(RORII))  Q:'RORII  D  Q:RC<0
 . S RORORD=$P(@RORTMP@(RORII,0),U)
 . S RORXII=$P(RORORD,";"),RORXII=$E(RORXII,$L(RORXII))
 . S IEN55=+$P(RORORD,";")
 . ;
 . K ^TMP("PS",$J),RORRXE
 . D OEL^PSOORRL(RORDFN,RORORD)
 . Q:$D(^TMP("PS",$J))<10
 . M RORRXE=^TMP("PS",$J)
 . K ^TMP("PS",$J)
 . ;
 . I RORXII="R"  D               ;--- Outpatient Pharmacy
 . . D REFILL
 . . ;--- Check if the original prescription or one of
 . . ;--- the refills is within date range
 . . S RORINC=0
 . . F RORINDEX="REF","PAR" D
 . . . S II=""
 . . . F  S II=$O(RORRXE(RORINDEX,II))  Q:II=""  D
 . . . . S TMP=$P($G(RORRXE(RORINDEX,II,0)),U)
 . . . . I TMP'<RORSTDT,TMP<RORENDT  S RORINC=1  Q
 . . . . K RORRXE(RORINDEX,II,0)
 . . Q:'RORINC
 . . ;---
 . . S TMP=$$ORC(IEN55,.RORRXE,RORDFN)
 . . I TMP  Q:TMP<0  S ERRCNT=ERRCNT+TMP
 . . S TMP=$$RXE^RORHL031(IEN55,.RORRXE,RORDFN)
 . . I TMP  Q:TMP<0  S ERRCNT=ERRCNT+TMP
 . . ;
 . I RORXII="U"  D               ;--- Unit Dose Inpatient Pharmacy
 . . N NODE  K @ROR55
 . . D PSS432^PSS55(RORDFN,IEN55,ROR55SUB)
 . . S NODE=$NA(@ROR55@(IEN55))
 . . ;---
 . . S TMP=$$ORC^RORHL07(NODE,.RORRXE)
 . . I TMP  Q:TMP<0  S ERRCNT=ERRCNT+TMP
 . . S TMP=$$RXE^RORHL07(NODE,.RORRXE)
 . . I TMP  Q:TMP<0  S ERRCNT=ERRCNT+TMP
 . . ;
 . I RORXII="V"  D               ;--- IV Inpatient Pharmacy
 . . N NODE  K @ROR55
 . . D PSS436^PSS55(RORDFN,IEN55,ROR55SUB)
 . . S NODE=$NA(@ROR55@(IEN55))
 . . ;---
 . . S TMP=$$ORC^RORHL071(NODE,.RORRXE)
 . . I TMP  Q:TMP<0  S ERRCNT=ERRCNT+TMP
 . . S TMP=$$RXE^RORHL071(NODE,.RORRXE)
 . . I TMP  Q:TMP<0  S ERRCNT=ERRCNT+TMP
 ;
 D FREE^RORTMP(ROR55),FREE^RORTMP(RORTMP)
 Q $S(RC<0:RC,1:ERRCNT)
 ;
 ;***** OUTPATIENT PHARMACY ORC SEGMENT BUILDER
 ;
 ; RORIEN        IEN of the record of the PRESCRIPTION file (#52)
 ;
 ; .RORORC       Array with info (from OEL^PSOORRL)
 ;
 ; PTIEN         Patient IEN (DFN)
 ;
 ; Return Values:
 ;       <0  Error Code
 ;        0  Ok
 ;       >0  Non-fatal error(s)
 ;
ORC(RORIEN,RORORC,PTIEN) ;
 N BUF,CS,ERRCNT,IEN,IENS59,RC,RORMSG,ROROUT,RORSEG,RORTMP,RORTS,TMP
 S (ERRCNT,RC)=0
 D ECH^RORHL7(.CS)
 ;
 ;--- Initialize the segment
 S RORSEG(0)="ORC"
 ;
 ;--- ORC-1 - Order Control 
 S RORSEG(1)="NW"
 ;
 ;--- ORC-2 - Placer Order #
 S RORSEG(2)=+RORIEN_CS_"OP"
 ;
 ;--- ORC-9 - Release Date/Time
 S TMP=$P($G(RORORC("RXN",0)),U,7)
 S RORSEG(9)=$$FM2HL^RORHL7(TMP)
 ;
 ;--- ORC-12 - Provider
 S BUF=+$P($G(RORORC("P",0)),U)
 I BUF>0  D
 . S $P(BUF,CS,13)=$$GET1^DIQ(200,+BUF_",",53.5,"E",,"RORMSG")
 . I $G(DIERR)  D  S ERRCNT=ERRCNT+1
 . . D DBS^RORERR("RORMSG",-99,,,200,+BUF_",")
 . S RORSEG(12)=BUF
 ;
 ;--- ORC-15 - Order Date/Time
 S TMP=$$FMTHL7^XLFDT($P($G(RORORC(0)),U,5))
 Q:TMP'>0 $$ERROR^RORERR(-100,,,,"No order date","OEL^PSOORRL")
 S RORSEG(15)=TMP
 ;
 ;--- ORC-16 - Control Code Reason
 S RORSEG(16)=CS_CS_CS_CS_"NEW"
 ;
 ;--- ORC-17 - Division
 S RORSEG(17)=$$SITE^RORUTL03(CS)
 S RORTMP=$$ALLOC^RORTMP(.RORTS)
 D RX^PSO52API(PTIEN,RORTS,+RORIEN,,"2")
 S IENS59=+$G(@RORTMP@(PTIEN,+RORIEN,20))_","
 D FREE^RORTMP(RORTMP)
 I IENS59>0  D
 . D GETS^DIQ(59,IENS59,"100","IE","ROROUT","RORMSG")
 . I $G(DIERR)  D  S ERRCNT=ERRCNT+1  Q
 . . D DBS^RORERR("RORMSG",-99,,,59,IENS59)
 . S IEN=+$G(ROROUT(59,IENS59,100,"I"))
 . Q:IEN'>0
 . ;---
 . S BUF=$$GET1^DIQ(4,IEN_",",99,"I",,"RORMSG")
 . I $G(DIERR)  D  S ERRCNT=ERRCNT+1  Q
 . . D DBS^RORERR("RORMSG",-99,,,4,IEN_",")
 . Q:BUF=""
 . S $P(BUF,CS,2)=$$ESCAPE^RORHL7($G(ROROUT(59,IENS59,100,"E")))
 . S $P(BUF,CS,3)="99VA4"
 . S RORSEG(17)=BUF
 ;
 ;--- Store the segment
 D ADDSEG^RORHL7(.RORSEG)
 Q ERRCNT
 ;
 ;***** MAKES ORIGINAL FILL LIKE REFILLS TO REUSE CODE
REFILL ;
 S RORRXE("REF",0,0)=""
 S $P(RORRXE("REF",0,0),U,1)=$P(RORRXE("RXN",0),U,6)
 S $P(RORRXE("REF",0,0),U,2)=$P(RORRXE(0),U,7)
 S $P(RORRXE("REF",0,0),U,3)=$P(RORRXE(0),U,8)
 S $P(RORRXE("REF",0,0),U,4)=$P(RORRXE("RXN",0),U,7)
 S $P(RORRXE("REF",0,0),U,5)=$P(RORRXE("RXN",0),U,3)
 Q
