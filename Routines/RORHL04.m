RORHL04 ;HOIFO/CRT,SG - HL7 RADIOLOGY: OBR,OBX ; 4/26/07 12:53pm
 ;;1.5;CLINICAL CASE REGISTRIES;**3**;Feb 17, 2006;Build 7
 ;
 ; This routine uses the following IAs:
 ;
 ; #65           Read access to file #70 (controlled)
 ; #118-B        Read access to file #71 (controlled)
 ; #118-D        Read access to file #72 (controlled)
 ; #1995         $$CPT^ICPTCOD (supported)
 ; #2043         EN1^RAO7PC1 (supported)
 ; #2265         EN3^RAO7PC1 (supported)
 ; #10060        Read access to the file #200 (supported)
 ; #10090        Read access to the file #4 (supported)
 ;
 ; #15-C         Read access to file #74 (Private)
 ;
 Q
 ;
 ;***** SEARCHES RADIOLOGY FOR DATA
 ;
 ; RORDFN        IEN of the patient in the PATIENT file (#2)
 ;
 ; .DXDTS        Reference to a local variable where the
 ;               data extraction time frames are stored.
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;       >0  Non-fatal error(s)
 ;
 ; The ^TMP($J,"RAE1") and ^TMP($J,"RAE2") global nodes are used by
 ; this function.
 ;
EN1(RORDFN,DXDTS) ;
 N CNI,DTI,ERRCNT,EXAMID,IDX,IENS,IENS74,RACN0,RC,RORENDT,RORSTDT,STR1,TMP
 S (ERRCNT,RC)=0
 ;
 S IDX=0
 F  S IDX=$O(DXDTS(4,IDX))  Q:IDX'>0  D  Q:RC<0
 . S RORSTDT=$P(DXDTS(4,IDX),U),RORENDT=$P(DXDTS(4,IDX),U,2)
 . ;--- Get radiology data
 . K ^TMP($J,"RAE1")
 . D EN1^RAO7PC1(RORDFN,RORSTDT,RORENDT,999999999)
 . ;--- Process the data
 . S EXAMID=""
 . F  S EXAMID=$O(^TMP($J,"RAE1",RORDFN,EXAMID))  Q:EXAMID=""  D
 . . S DTI=$P(EXAMID,"-"),CNI=$P(EXAMID,"-",2)
 . . S IENS=CNI_","_DTI_","_RORDFN_","
 . . S STR=^TMP($J,"RAE1",RORDFN,EXAMID)
 . . S RACN0=$P(STR,"^",2),IENS74=$P(STR,"^",5)
 . . S TMP=$$OBR(IENS,RACN0)
 . . I TMP  Q:TMP<0  S ERRCNT=ERRCNT+TMP
 . . Q:TMP="S"
 . . S TMP=$$OBX(IENS,IENS74)
 . . I TMP  Q:TMP<0  S ERRCNT=ERRCNT+TMP
 ;
 K ^TMP($J,"RAE1")
 Q $S(RC<0:RC,1:ERRCNT)
 ;
 ;*****
LOOP(ROR8NODE,OID,PREFIX) ;
 N BR,CNT,I,I1,TMP
 S BR=$E(HLECH,3)_".br"_$E(HLECH,3)
 S RORSEG(3)=OID
 K RORSEG(5)
 ;---
 S I=$O(@ROR8NODE@("")),CNT=0
 D:$G(PREFIX)'=""
 . S CNT=CNT+1
 . S RORSEG(5,CNT)=$$ESCAPE^RORHL7(PREFIX)_$S(I'="":BR,1:"")
 ;---
 F  Q:I=""  S I1=$O(@ROR8NODE@(I))  D  S I=I1
 . S TMP=$$ESCAPE^RORHL7(@ROR8NODE@(I))
 . S CNT=CNT+1,RORSEG(5,CNT)=$S(I1'="":TMP_BR,1:TMP)
 ;---
 D:$D(RORSEG(5)) ADDSEG^RORHL7(.RORSEG)
 Q
 ;
 ;***** GENERATES THE RADIOLOGY OBR SEGMENT
 ;
 ; RORIENS       IENS of the radiology record in the file #70.03
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;       >0  Non-fatal error(s)
 ;      "S"  Skip the record
 ;
OBR(RORIENS,RACN0) ;
 N BUF,CPTIEN,CS,ERRCNT,IENS,IENS7002,RADTE,RC,RORMSG,ROROUT,RORSEG,TMP
 S (ERRCNT,RC)=0
 D ECH^RORHL7(.CS)
 ;--- Check the parameters
 S:$E(RORIENS,$L(RORIENS))'="," RORIENS=RORIENS_","
 ;
 D GETS^DIQ(70.03,RORIENS,"2;14","IE","ROROUT","RORMSG")
 Q:$G(DIERR) $$DBS^RORERR("RORMSG",-9,,,70.03,RORIENS)
 S IENS7002=$P(RORIENS,",",2,3)_","
 D GETS^DIQ(70.02,IENS7002,".01;3","EI","ROROUT","RORMSG")
 Q:$G(DIERR) $$DBS^RORERR("RORMSG",-9,,,70.02,IENS7002)
 ;
 ;--- Initialize the segment
 S RORSEG(0)="OBR"
 ;
 ;--- OBR-3 - Unique Accession #
 S BUF=$P(RORIENS,",",2)_"-"_$P(RORIENS,",")
 S RADTE=$G(ROROUT(70.02,IENS7002,.01,"I"))\1
 S $P(BUF,CS,2)=$E(RADTE,4,7)_$E(RADTE,2,3)_"-"_+RACN0
 S RORSEG(3)=BUF
 ;
 ;--- OBR-4 - Procedure & CPT Code
 S IENS=+$G(ROROUT(70.03,RORIENS,2,"I"))_","
 Q:IENS'>0 $$ERROR^RORERR(-95,,,,70.03,RORIENS,2)
 S CPTIEN=+$$GET1^DIQ(71,IENS,9,"I",,"RORMSG")
 Q:$G(DIERR) $$DBS^RORERR("RORMSG",-9,,,71,IENS)
 ;--- Some procedures never have a CPT code. Record a warning
 ;--- (only in debug mode) and skip the record.
 I CPTIEN'>0  D:$G(RORPARM("DEBUG"))  Q "S"
 . D ERROR^RORERR(-95,,,,71,IENS,9)
 ;---
 S TMP=$$CPT^ICPTCOD(CPTIEN)
 Q:TMP<0 $$ERROR^RORERR(-56,,$P(TMP,U,2),,+TMP,"$$CPT^ICPTCOD")
 S BUF=$P(TMP,U,2)_CS_$$ESCAPE^RORHL7($P(TMP,U,3))_CS_"C4"
 ;---
 S $P(BUF,CS,4)=$G(ROROUT(70.03,RORIENS,2,"I"))
 S $P(BUF,CS,5)=$$ESCAPE^RORHL7($G(ROROUT(70.03,RORIENS,2,"E")))
 S $P(BUF,CS,6)="99RAP"
 S RORSEG(4)=BUF
 ;
 ;--- OBR-7 - Exam Date/Time
 S TMP=$$FMTHL7^XLFDT($G(ROROUT(70.02,IENS7002,.01,"I")))
 Q:TMP'>0 $$ERROR^RORERR(-95,,,,70.02,IENS7002,.01)
 S RORSEG(7)=TMP
 ;
 ;--- OBR-16 - Requesting Physician
 S BUF=+$G(ROROUT(70.03,RORIENS,14,"I"))
 I BUF>0  D
 . S $P(BUF,CS,13)=$$GET1^DIQ(200,+BUF_",",53.5,"E",,"RORMSG")
 . I $G(DIERR)  D DBS^RORERR("RORMSG",-99,,,200,+BUF_",")  Q
 . S RORSEG(16)=BUF
 ;
 ;--- OBR-24 - Service Section ID
 S RORSEG(24)="RAD"
 ;
 ;--- OBR-44 - Division
 S RORSEG(44)=$$SITE^RORUTL03(CS)
 S IENS=+$G(ROROUT(70.02,IENS7002,3,"I"))_","
 I IENS>0  D
 . S BUF=$$GET1^DIQ(4,IENS,99,"I",,"RORMSG")
 . I $G(DIERR)  D DBS^RORERR("RORMSG",-99,,,4,IENS)  Q
 . Q:BUF=""
 . S $P(BUF,CS,2)=$$ESCAPE^RORHL7($G(ROROUT(70.02,IENS7002,3,"E")))
 . S $P(BUF,CS,3)="99VA4"
 . S RORSEG(44)=BUF
 ;
 ;--- Store the segment
 D ADDSEG^RORHL7(.RORSEG)
 Q ERRCNT
 ;
 ;***** GENERATES THE RADIOLOGY OBX SEGMENT
 ;
 ; RORIENS       IENS of the radiology record in the file #70.03
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;       >0  Non-fatal error(s)
 ;
OBX(RORIENS,IENS74) ;
 N CASEIEN,RAENODE,ERRCNT,PTIEN,RC,RFS,RORBUF,RORSEG,RORTXT,TMP
 S (ERRCNT,RC)=0
 D ECH^RORHL7(.CS)
 ;--- Check the parameters
 S:$E(RORIENS,$L(RORIENS))'="," RORIENS=RORIENS_","
 ;
 ;--- Load the data into the ^TMP($J,"RAE2")
 S CASEIEN=$P(IENS,","),PTIEN=$P(IENS,",",3)
 D EN3^RAO7PC1(PTIEN_U_$P(IENS,",",2)_U_CASEIEN)
 S TMP=$O(^TMP($J,"RAE2",PTIEN,CASEIEN,""))
 Q:TMP="" $$ERROR^RORERR(-100,,,PTIEN,"Nothing","EN3^RAO7PC1")
 S RAENODE=$NA(^TMP($J,"RAE2",PTIEN,CASEIEN,TMP))
 ;
 ;--- Initialize the segment
 S RORSEG(0)="OBX"
 ;
 ;--- OBX-2
 S RORSEG(2)="FT"
 ;
 ;--- OBX-11
 S RORSEG(11)="F"
 ;
 ;-- Get the Report Text
 S TMP=$NA(@RAENODE@("R"))
 D:$D(@TMP)>1 LOOP(TMP,"RT"_CS_"Report Text"_CS_"VA080")
 ;
 ;--- Get the Impression Report
 S TMP=$NA(@RAENODE@("I"))
 D:$D(@TMP)>1 LOOP(TMP,"IT"_CS_"Impression Text"_CS_"VA080")
 ;
 ;--- Get the Reason for Study and Clinical History
 S TMP=$NA(@RAENODE@("H")),RFS=$G(@RAENODE@("RFS"))
 D:($D(@TMP)>1)!(RFS'="")
 . S:RFS'="" RFS="Reason for Study: "_RFS
 . D LOOP(TMP,"CH"_CS_"Clinical History"_CS_"VA080",RFS)
 ;
 ;--- Get the Reason for Study (alternative approach)
 ;S RORBUF(1)=$G(@RAENODE@("RFS"))
 ;D:RORBUF(1)'="" LOOP("RORBUF","RS"_CS_"Reason for Study"_CS_"VA080")
 ;
 Q ERRCNT
