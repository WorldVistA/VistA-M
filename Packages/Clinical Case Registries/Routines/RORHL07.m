RORHL07 ;HOIFO/BH - HL7 INPATIENT PHARMACY: ORC,RXE ; 5/22/06 1:29pm
 ;;1.5;CLINICAL CASE REGISTRIES;**1**;Feb 17, 2006;Build 24
 ;
 ; This routine uses the following IAs:
 ;
 ; #93           Get stop code from the file #44 (controlled)
 ; #1876         Read access to file #59 (controlled)
 ; #10040        Read the INSTITUTION field of file #44 (supported)
 ; #10060        Read access to file #200 (supported)
 ; #10090        Read access to file #4 (supported)
 ;
 Q
 ;
 ;***** INPATIENT PHARMACY ORC SEGMENT BUILDER
 ;
 ; NODE          Closed root of a subtree that stores the output of
 ;               the PSS432^PSS55 Pharmacy API
 ;
 ; .RORORC       Array with info (from OEL^PSOORRL)
 ;
 ; Return Values:
 ;       <0  Error Code
 ;        0  Ok
 ;       >0  Non-fatal error(s)
 ;
ORC(NODE,RORORC) ;
 N BUF,CS,ERRCNT,IEN42,IEN44,RC,RORMSG,RORSEG,TMP
 S (ERRCNT,RC)=0
 D ECH^RORHL7(.CS)
 ;
 ;--- Initialize the segment
 S RORSEG(0)="ORC"
 ;
 ;--- ORC-1 - Order Control 
 S RORSEG(1)="NW"
 ;
 ;--- ORC-2 - Placer Order Number
 S RORSEG(2)=RORDFN_"V"_$P($G(@NODE@(.01)),U)_CS_"IP"
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
 S IEN42=+$P($G(@NODE@(9)),U)
 I IEN42>0  D
 . S IEN44=+$$GET1^DIQ(42,IEN42_",",44,"I",,"RORMSG")
 . I $G(DIERR)  D  S ERRCNT=ERRCNT+1
 . . D DBS^RORERR("RORMSG",-99,,,42,IEN42_",")
 E  S IEN44=0
 S RORSEG(17)=$$DIV44^RORHLUT1(IEN44,CS)
 ;
 ;--- Store the segment
 D ADDSEG^RORHL7(.RORSEG)
 Q ERRCNT
 ;
 ;***** INPATIENT PHARMACY RXE SEGMENT BUILDER
 ;
 ; NODE          Closed root of a subtree that stores the output of
 ;               the PSS432^PSS55 Pharmacy API
 ;
 ; .RORRXE       Array containing info (from OEL^PSJORRL)
 ;
 ; Return Values:
 ;       <0  Error Code
 ;        0  Ok
 ;       >0  Non-fatal error(s)
 ;
RXE(NODE,RORRXE) ;
 N BUF,CS,ERRCNT,IDGN,II,INDF,RC,RORMSG,RORMR,ROROUT,RORUOUT,RORQT,RORSEG,TMP
 Q:$P($G(RORRXE(0)),U)="" 0
 D ECH^RORHL7(.CS)
 S (ERRCNT,RC)=0
 ;
 ;--- Load the data
 S RORMR=$$ESCAPE^RORHL7($P($G(@NODE@(3)),U,2))
 S TMP=$P($G(@NODE@(26)),U),RORQT=""
 S:TMP'="" $P(RORQT,CS,8)=$$ESCAPE^RORHL7(TMP)
 ;
 S II=0
 F  S II=$O(RORRXE("DD",II)) Q:II=""  D  Q:RC<0
 . K ROROUT,RORSEG
 . ;--- Initialize the segment
 . S RORSEG(0)="RXE"
 . ;
 . ;--- RXE-1 - Quantity/Timing
 . S RORSEG(1)=RORQT
 . ;
 . ;--- RXE-2 - Give Code
 . S IDGN=+$P($G(RORRXE("DD",II,0)),U)
 . S:IDGN'>0 IDGN=+$P($G(RORRXE("DD",II,0)),U,3)  Q:IDGN'>0
 . S BUF="",TMP=$$RXE2^RORHL031(IDGN,CS,.BUF,.INDF)
 . I TMP  S ERRCNT=ERRCNT+1  Q:TMP<0
 . Q:BUF=""
 . S RORSEG(2)=BUF
 . ;
 . ;--- RXE-3 - Give Amount (Min)
 . S RORSEG(3)=""""""
 . ;
 . ;--- RXE-5 - Give Units
 . S TMP=$$RXE5^RORHL031(+$G(INDF),CS,.BUF)
 . S:TMP ERRCNT=ERRCNT+1
 . S:BUF'="" RORSEG(5)=BUF
 . ;
 . ;--- RXE-18 - Stop Date/Time
 . S TMP=$P($G(RORRXE(0)),U,3)
 . S RORSEG(18)=$$FM2HL^RORHL7(TMP)
 . ;
 . ;--- RXE-21 - Medication Route
 . S:RORMR'="" RORSEG(21)=RORMR
 . ;
 . ;--- RXE-24 - Units per dose
 . S TMP=$P($G(RORRXE("DD",II,0)),U,2)
 . S:TMP'="" RORSEG(24)=+TMP
 . ;
 . ;--- Store the segment
 . D ADDSEG^RORHL7(.RORSEG)
 ;
 Q ERRCNT
