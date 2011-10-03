RORHL15 ;HOIFO/BH - HL7 IV DATA: OBR, OBX ; 5/30/06 9:40am
 ;;1.5;CLINICAL CASE REGISTRIES;**1**;Feb 17, 2006;Build 24
 ;
 ; This routine uses the following IAs:
 ;
 ; #2400         OCL^PSOORRL and OEL^PSOORRL (controlled)
 ; #4549         ZERO^PSS52P6 (supported)
 ; #4550         ZERO^PSS52P7 (supported)
 ; #4826         PSS436^PSS55 (supported)
 ;
 Q
 ;
 ;***** SEARCHES FOR IV DATA
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
 ; The ^TMP("PS",$J) global node is used by this function.
 ;
EN1(RORDFN,DXDTS) ;
 N ERRCNT,IDX,IEN55,II,NODE,RC,ROR55,ROR55SUB,RORENDT,RORII,RORORD,RORSTDT,RORTMP
 S (ERRCNT,RC)=0
 ;
 S RORTMP=$$ALLOC^RORTMP()
 S ROR55=$$ALLOC^RORTMP(.ROR55SUB)
 ;
 S IDX=0
 F  S IDX=$O(DXDTS(14,IDX))  Q:IDX'>0  D  Q:RC<0
 . S RORSTDT=$P(DXDTS(14,IDX),U),RORENDT=$P(DXDTS(14,IDX),U,2)
 . ;--- Load the list of prescriptions
 . K ^TMP("PS",$J),@RORTMP
 . D OCL^PSOORRL(RORDFN,RORSTDT,RORENDT)
 . Q:$D(^TMP("PS",$J))<10
 . ;
 . ;--- Select the prescriptions
 . S RORII=0
 . F  S RORII=$O(^TMP("PS",$J,RORII))  Q:'RORII  D
 . . S RORORD=$P(^TMP("PS",$J,RORII,0),U)
 . . Q:RORORD'>0
 . . S II=$P(RORORD,";"),II=$E(II,$L(II))
 . . Q:II'="V"
 . . ;---
 . . M @RORTMP@(RORII)=^TMP("PS",$J,RORII)
 . ;
 . ;--- Browse through the list and generate the HL7 segments
 . S RORII=0
 . F  S RORII=$O(@RORTMP@(RORII))  Q:'RORII  D
 . . S RORORD=$P(@RORTMP@(RORII,0),U),IEN55=+$P(RORORD,";")
 . . D PSS436^PSS55(RORDFN,IEN55,ROR55SUB)
 . . S NODE=$NA(@ROR55@(IEN55))
 . . ;---
 . . S TMP=$$OBR(NODE,RORDFN)
 . . I TMP  Q:TMP<0  S ERRCNT=ERRCNT+TMP
 . . ;---
 . . S TMP=$$OBX(NODE,RORDFN)
 . . I TMP  Q:TMP<0  S ERRCNT=ERRCNT+TMP
 ;
 D FREE^RORTMP(ROR55),FREE^RORTMP(RORTMP)
 K ^TMP("PS",$J)
 Q $S(RC<0:RC,1:ERRCNT)
 ;
 ;***** IV OBR SEGMENT BUILDER
 ;
 ; NODE          Closed root of a subtree that stores the output of
 ;               the PSS436^PSS55 Pharmacy API
 ;
 ; RORDFN        IEN of the patient in the PATIENT file (#2)
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;       >0  Non-fatal error(s)
 ;
OBR(NODE,RORDFN) ;
 N CS,ERRCNT,IEN,RC,RORMSG,RORSEG,TMP
 S (ERRCNT,RC)=0
 D ECH^RORHL7(.CS)
 ;
 ;--- Initialize the segment
 S RORSEG(0)="OBR"
 ;
 ;--- OBR-3 - Order Number
 S RORSEG(3)=$P($G(@NODE@(.01)),U)
 ;
 ;--- OBR-4 - IV CPT Code
 S RORSEG(4)="90780"_CS_"IV"_CS_"C4"
 ;
 ;--- OBR-7 - Start Date
 S TMP=$$FMTHL7^XLFDT($P($G(@NODE@(.02)),U))
 Q:TMP'>0 $$ERROR^RORERR(-100,,,RORDFN,"No start date","PSS436^PSS55")
 S RORSEG(7)=TMP
 ;
 ;--- OBR-8 - Stop Date
 S RORSEG(8)=$$FM2HL^RORHL7($P($G(@NODE@(.03)),U))
 ;
 ;--- OBR-13 - Schedule
 S RORSEG(13)=$$ESCAPE^RORHL7($P($G(@NODE@(.09)),U))
 ;
 ;--- OBR-20 - Infusion Rate
 S RORSEG(20)=$$ESCAPE^RORHL7($P($G(@NODE@(.08)),U))
 ;
 ;--- OBR-24 - Diagnostic Service ID
 S RORSEG(24)="IMM"
 ;
 ;--- OBR-40 - Type
 S TMP=$P($G(@NODE@(.04)),U)
 I TMP'=""  D  S RORSEG(40)=TMP
 . S $P(TMP,CS,2)=$P($G(@NODE@(.04)),U,2)
 . S $P(TMP,CS,3)="VA"
 ;
 ;--- OBR-44 - Division
 S IEN=+$P($G(@NODE@(9)),U)
 I IEN>0  D
 . S IEN=+$$GET1^DIQ(42,IEN_",",44,"I",,"RORMSG")
 . D:$G(DIERR) DBS^RORERR("RORMSG",-99,,,42,IEN_",")
 S RORSEG(44)=$$DIV44^RORHLUT1(IEN,CS)
 ;
 ;--- Store the segment
 D ADDSEG^RORHL7(.RORSEG)
 Q ERRCNT
 ;
 ;***** IV OBX SEGMENT(S) BUILDER
 ;
 ; NODE          Closed root of a subtree that stores the output of
 ;               the PSS436^PSS55 Pharmacy API
 ;
 ; RORDFN        IEN of the patient in the PATIENT file (#2)
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;       >0  Non-fatal error(s)
 ;
OBX(NODE,RORDFN) ;
 N ADD,CS,ERRCNT,I,ID,RC,SOL,TMP
 S (ERRCNT,RC)=0
 D ECH^RORHL7(.CS)
 ;
 ;=== Other print info
 S TMP=$P($G(@NODE@(31)),U)
 D:TMP'="" SETOBX(TMP,"OTPR"_CS_"Other Print info."_CS_"VA080")
 ;
 ;=== Additive data
 I $G(@NODE@("ADD",0))>0  D
 . S ID="ADD"_CS_"Additive"_CS_"VA080"
 . S I=0
 . F  S I=$O(@NODE@("ADD",I))  Q:I'>0  D
 . . S ADD=$P($G(@NODE@("ADD",I,.01)),U,2)
 . . D:ADD'="" SETOBX(ADD,ID,$P($G(@NODE@("ADD",I,.02)),U))
 ;
 ;=== Solution Data
 I $G(@NODE@("SOL",0))>0  D
 . S ID="SOL"_CS_"Solution"_CS_"VA080"
 . S I=0
 . F  S I=$O(@NODE@("SOL",I))  Q:I'>0  D
 . . S SOL=$P($G(@NODE@("SOL",I,.01)),U,2)
 . . D:SOL'="" SETOBX(SOL,ID,$P($G(@NODE@("SOL",I,1)),U))
 ;
 Q ERRCNT
 ;
 ;***** CREATES AND STORES THE OBX SEGMENT
SETOBX(OBX5,OBX3,OBX7) ;
 N RORSEG
 ;--- Initialize the segment
 S RORSEG(0)="OBX"
 ;--- OBX-2 - Value Type
 S RORSEG(2)="FT"
 ;--- OBX-3 - Obervation Identifier
 S RORSEG(3)=OBX3
 ;--- OBX-5 - Observation Value
 S RORSEG(5)=$$ESCAPE^RORHL7(OBX5)
 ;--- OBX-7 - Strength (additives) or volume (solutions)
 S:$G(OBX7)'="" RORSEG(7)=OBX7
 ;--- OBX-11 - Observation Result Status
 S RORSEG(11)="F"
 ;--- Store the segment
 D ADDSEG^RORHL7(.RORSEG)
 Q
