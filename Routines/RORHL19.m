RORHL19 ;BPOIFO/ACS - HL7 SKIN TEST DATA: OBR,OBX ;11/1/09
 ;;1.5;CLINICAL CASE REGISTRIES;**10**;Feb 17, 2006;Build 32
 ;
 ; DBIA #5520 :  ^AUPNVSK (private)
 ; DBIA #2028 :  ^AUPNVSIT (controlled)
 ; DBIA #2056 :  $$GET1^DIQ,GETS^DIQ (supported)
 Q
 ;
 ;***** SEARCH FOR SKIN TEST DATA
 ;
 ; DFN           DFN of the patient in the PATIENT file (#2)
 ;
 ; .DXDTS        Reference to a local variable where the
 ;               data extraction time frames are stored.
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;       >0  Non-fatal error(s)
 ;
EN1(DFN,DXDTS) ;
 N IDX,RORENDT,RORSTDT,ROR1,ROREVDT
 S IDX=0
 F  S ROR1=0 S IDX=$O(DXDTS(18,IDX))  Q:IDX'>0  D
 . S RORSTDT=$P(DXDTS(18,IDX),U),RORENDT=$P(DXDTS(18,IDX),U,2)
 . ;--- Find Skin Test data
 . F  S ROR1=$O(^AUPNVSK("C",DFN,ROR1)) Q:'ROR1  D
 .. N RORIDATA,RORIERR,ROREVDT K RORIDATA,RORIERR
 .. ;get skin test data for the HL7 message
 .. D GETS^DIQ(9000010.12,ROR1_",",".01;.03;.04;.05;.06;1201;1202;81101","IE","RORIDATA","RORIERR")
 .. Q:$D(RORIERR("DIERR"))
 .. S ROREVDT=$G(RORIDATA(9000010.12,ROR1_",",1201,"I")) ;get event date/time
 .. ;Q:$G(ROREVDT)>(RORENDT_.999999)  ;event date/time can't be in the future
 .. N RORVSIT ;get VISIT IEN from immunization file
 .. S RORVSIT=$G(RORIDATA(9000010.12,ROR1_",",".03","I")) ;visit IEN
 .. ;get FM internal DATE LAST MODIFIED from visit file
 .. N RORIDLM,RORIERR,RORDLM K RORIDLM,RORIERR D GETS^DIQ(9000010,RORVSIT_",",".13","I","RORIDLM","RORIERR")
 .. S RORDLM=$G(RORIDLM(9000010,RORVSIT_",",".13","I")) ;date last modified
 .. S RORDLM=RORDLM\1 ;exclude 'time'
 .. Q:RORDLM<RORSTDT  ;quit if date last modified is before extraction start date
 .. Q:RORDLM>RORENDT  ;quit if date last modified is after extraction end date
 .. S RORVSIT=+$G(^AUPNVSIT(RORVSIT,0)) ;get visit date/time in FM format
 .. ;--- Process the data
 .. D OBR(.RORIDATA,DFN,RORVSIT,ROR1)
 .. D OBX(.RORIDATA,DFN,RORVSIT,ROR1)
 ;
 Q 0
 ;
 ;***** SKIN TEST OBR SEGMENT BUILDER
 ;
 ; Return Values:
 ;        0  Ok
 ;
OBR(RORIDATA,DFN,RORVSIT,ROR1) ;
 N CS,RORSEG
 D ECH^RORHL7(.CS)
 ;
 ;--- Initialize the segment
 S RORSEG(0)="OBR"
 ;
 ;--- OBR-3 - Skin Test IEN in the V SKIN TEST file
 S RORSEG(3)=$G(ROR1)
 ;
 ;--- OBR-4 - Universal Service ID
 S RORSEG(4)="86486"_CS_"SKIN TEST"_CS_"C4"
 ;
 ;--- OBR-7 - DATE READ
 N RORDR S RORDR=$G(RORIDATA(9000010.12,ROR1_",",".06","I"))
 I $G(RORDR)>0 S RORSEG(7)=$$FM2HL^RORHL7(RORDR)
 ;
 ;--- OBR-13 - 'COMMENTS'
 S RORSEG(13)=$G(RORIDATA(9000010.12,ROR1_",",81101,"E"))
 ;
 ;--- OBR-16 - 'ORDERING PROVIDER': IEN and PROVIDER CLASS
 N ROROPIEN,RORDATA,RORMSG
 S ROROPIEN=$G(RORIDATA(9000010.12,ROR1_",",1202,"I"))
 I ROROPIEN>0  D
 . ;get provider class
 . S $P(RORDATA,CS,13)=$$GET1^DIQ(200,+ROROPIEN_",",53.5,"E",,"RORMSG")
 . Q:$G(RORMSG(("DIERR")))
 . S $P(RORDATA,CS,1)=ROROPIEN ;provider IEN 
 . S RORSEG(16)=$G(RORDATA)
 ;
 ;--- OBR-24 - Diagnostic Service ID
 S RORSEG(24)="OTH"
 ;
 ;--- Store the segment
 D ADDSEG^RORHL7(.RORSEG)
 Q 0
 ;
 ;***** SKIN TEST OBX SEGMENT BUILDER
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;       >0  Non-fatal error(s)
 ;
OBX(RORIDATA,DFN,RORVSIT,ROR1) ;
 N CS,RORSEG
 D ECH^RORHL7(.CS)
 ;
 ;--- Initialize the segment
 S RORSEG(0)="OBX"
 ;
 ;--- OBX-2 - Value Type of OBX-5
 S RORSEG(2)="FT"
 ;
 ;--- OBX-3 - 'SKIN TEST' name
 S RORSEG(3)=CS_$G(RORIDATA(9000010.12,ROR1_",",.01,"E"))
 ;
 ;--- OBX-5 - 'RESULTS'_CS_'READING'
 N TMP1,TMP2
 S TMP1=$G(RORIDATA(9000010.12,ROR1_",",.04,"I"))
 S TMP2=$G(RORIDATA(9000010.12,ROR1_",",.05,"I"))
 S RORSEG(5)=$G(TMP1)_CS_$G(TMP2)
 ;
 ;--- OBX-14 - 'EVENT DATE AND TIME'
 N TMP1 S TMP1=$G(RORIDATA(9000010.12,ROR1_",",1201,"I"))
 I $G(TMP1)>0 S RORSEG(14)=$$FM2HL^RORHL7(TMP1)
 ;
 ;--- OBX-19 - 'VISIT' DATE AND TIME
 I $G(RORVSIT)>0 S RORSEG(19)=$$FM2HL^RORHL7(RORVSIT) ;convert to HL7 format
 ;
 D ADDSEG^RORHL7(.RORSEG)
 Q 0
