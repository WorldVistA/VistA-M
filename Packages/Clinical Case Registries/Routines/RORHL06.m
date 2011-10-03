RORHL06 ;HOIFO/BH,CRT - HL7 LIVER BIOPSY: OBR,OBX ; 3/13/06 9:23am
 ;;1.5;CLINICAL CASE REGISTRIES;**1**;Feb 17, 2006;Build 24
 ;
 ; This routine uses the following IAs:
 ;
 ; #1995         $$CPT^ICPTCOD (supported)
 ; #10035        Read access to the PATIENT file (supported)
 ;
 Q
 ;
 ;***** SEARCHES FOR LIVER BIOPSY DATA
 ;
 ; RORDFN        IEN of the patient in the PATIENT file (#2)
 ;
 ; RORSTDT       Start Date (FileMan)
 ; RORENDT       End Date   (FileMan)
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;       >0  Non-fatal error(s)
 ;
 ; The function uses the ^UTILITY($J,"W") global node.
 ;
EN1(RORDFN,RORSTDT,RORENDT) ;
 N ERRCNT,FLDS,IDT,IENS,K5,LRDFN,QUIT,RC,SPECIMEN
 S (ERRCNT,RC)=0
 ;
 ;--- Check if the patient exists
 S RORDFN=+$G(RORDFN)
 I '$D(^DPT(RORDFN))  D  Q RC
 . S RC=$$ERROR^RORERR(-36,,,RORDFN,2)
 ;
 S LRDFN=+$$LABREF^RORUTL18(RORDFN)  Q:LRDFN'>0 0
 ;
 S FLDS="1.1;1.4"
 S RORENDT=$$INVDATE^RORUTL01(RORENDT)
 S RORSTDT=$$INVDATE^RORUTL01(RORSTDT)
 ;
 S IDT=$O(^LR(LRDFN,"SP",RORSTDT))
 F  S IDT=$O(^LR(LRDFN,"SP",IDT),-1)  Q:'IDT!(IDT'>RORENDT)  D  Q:RC<0
 . S K5=0,QUIT=0
 . F  S K5=$O(^LR(LRDFN,"SP",IDT,.1,K5))  Q:'K5  D  Q:QUIT!(RC<0)
 . . S IENS=K5_","_IDT_","_LRDFN_","
 . . S SPECIMEN=$$GET1^DIQ(63.812,IENS,.01,"E",,"RORMSG")
 . . I $G(DIERR)  D  S ERRCNT=ERRCNT+1  Q
 . . . D DBS^RORERR("RORMSG",-9,,,63.812,IENS)
 . . I $$UP^XLFSTR(SPECIMEN)["LIVER"  D
 . . . S IENS=IDT_","_LRDFN_","
 . . . S TMP=$$OBR(IENS)
 . . . I TMP  S ERRCNT=ERRCNT+1  Q:TMP<0
 . . . S TMP=$$OBX(IENS,FLDS)
 . . . I TMP  S ERRCNT=ERRCNT+1  Q:TMP<0
 . . . S QUIT=1
 ;
 Q $S(RC<0:RC,1:ERRCNT)
 ;
 ;***** LIVER BIOPSY OBR SEGMENT BUILDER
 ;
 ; RORIENS       IENS of Liver Biopsy Record in File #63.08
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;       >0  Non-fatal error(s)
 ;
OBR(RORIENS) ;
 N BUF,CS,ERRCNT,FLDS,IEN,RC,RORMSG,ROROUT,RORSEG,TMP
 S (ERRCNT,RC)=0
 D ECH^RORHL7(.CS)
 ;--- Check the parameters
 S:$E(RORIENS,$L(RORIENS))'="," RORIENS=RORIENS_","
 ;
 ;--- Load the data (with a temporary fix for invalid
 ;--- output transform of the .01 field - ROR*1*8)
 D GETS^DIQ(63.08,RORIENS,".01","I","ROROUT","RORMSG")
 I $G(DIERR)  D  S ERRCNT=ERRCNT+1
 . D DBS^RORERR("RORMSG",-9,,,63.08,RORIENS)
 D GETS^DIQ(63.08,RORIENS,".06;.07;.08","IE","ROROUT","RORMSG")
 I $G(DIERR)  D  S ERRCNT=ERRCNT+1
 . D DBS^RORERR("RORMSG",-9,,,63.08,RORIENS)
 ;
 ;--- Initialize the segment
 S RORSEG(0)="OBR"
 ;
 ;--- OBR-3 - Surgical Path Acc #
 S RORSEG(3)=$G(ROROUT(63.08,RORIENS,.06,"E"))
 ;
 ;--- OBR-4 - Liver Biopsy CPT Code
 S BUF=47000,TMP=$$CPT^ICPTCOD(BUF)
 I TMP<0  D  S ERRCNT=ERRCNT+1,TMP=""
 . D ERROR^RORERR(-57,,$P(TMP,U,2),,+TMP,"$$CPT^ICPTCOD")
 S $P(BUF,CS,2)=$$ESCAPE^RORHL7($P(TMP,U,3))
 S $P(BUF,CS,3)="C4"
 S RORSEG(4)=BUF
 ;
 ;--- OBR-7 - Date/Time Specimen Taken
 S TMP=$G(ROROUT(63.08,RORIENS,.01,"I"))
 Q:TMP'>0 $$ERROR^RORERR(-95,,,,63.08,RORIENS,.01)
 S RORSEG(7)=$$FMTHL7^XLFDT(TMP)
 ;
 ;--- OBR-16 - Surgeon/Physician
 S RORSEG(16)=$G(ROROUT(63.08,RORIENS,.07,"I"))
 ;
 ;--- OBR-24 - Service Section ID
 S RORSEG(24)="SP"
 ;
 ;--- OBR-44 - Division
 S TMP=$G(ROROUT(63.08,RORIENS,.08,"E"))
 S IEN=$S(TMP'="":+$O(^SC("B",TMP,0)),1:0)
 S RORSEG(44)=$$DIV44^RORHLUT1(IEN,CS)
 ;
 ;--- Store the segment
 D ADDSEG^RORHL7(.RORSEG)
 Q $S(RC<0:RC,1:ERRCNT)
 ;
 ;***** LIVER BIOPSY OBX SEGMENT(S) BUILDER
 ;
 ; RORIENS       IENS of Liver Biopsy Record in File #63.08
 ; RORFLDS       List of WP fields to return as OBX'es
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;       >0  Non-fatal error(s)
 ;
OBX(RORIENS,RORFLDS) ;
 N BUF,CS,DIWF,DIWL,DIWR,ERRCNT,FLD,I,RORII,PZ,RC,RORMSG,ROROUT,RORRES,RORSEG,SCS,TMP,X
 S (ERRCNT,RC)=0
 D ECH^RORHL7(.CS,.SCS)
 ;--- Check the parameters
 S:$E(RORIENS,$L(RORIENS))'="," RORIENS=RORIENS_","
 ;
 ;--- Load the data
 D GETS^DIQ(63.08,RORIENS,RORFLDS,"EI","ROROUT","RORMSG")
 I $G(DIERR)  D  S ERRCNT=ERRCNT+1
 . D DBS^RORERR("RORMSG",-99,,,63.08,RORIENS)
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
 F PZ=1:1  S FLD=$P(RORFLDS,";",PZ)  Q:FLD=""  D  Q:RC<0
 . S BUF=47000,TMP=$$CPT^ICPTCOD(BUF)
 . I TMP<0  D  S ERRCNT=ERRCNT+1,TMP=""
 . . D ERROR^RORERR(-57,,$P(TMP,U,2),,+TMP,"$$CPT^ICPTCOD")
 . S $P(BUF,SCS,2)=$$GET1^DID(63.08,FLD,,"LABEL",,"RORMSG")
 . S $P(BUF,CS,2)=$$ESCAPE^RORHL7($P(TMP,U,3))
 . S $P(BUF,CS,3)="C4"
 . S RORSEG(3)=BUF
 . ;---
 . K ^UTILITY($J,"W")
 . S DIWL=1,DIWR=72
 . S RORII=0
 . F  S RORII=$O(ROROUT(63.08,RORIENS,FLD,RORII))  Q:'RORII  D
 . . S X=ROROUT(63.08,RORIENS,FLD,RORII)  D ^DIWP
 . ;---
 . S I=0
 . F  S I=$O(^UTILITY($J,"W",DIWL,I))  Q:'I  D
 . . S RORSEG(5)=$G(^UTILITY($J,"W",DIWL,I,0))
 . . ;--- Store the segment
 . . D ADDSEG^RORHL7(.RORSEG)
 ;
 Q $S(RC<0:RC,1:ERRCNT)
