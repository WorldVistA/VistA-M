RORHL031 ;HOIFO/BH,SG - HL7 PHARMACY: UTILITIES ; 3/13/06 9:23am
 ;;1.5;CLINICAL CASE REGISTRIES;**1**;Feb 17, 2006;Build 24
 ;
 ; This routine uses the following IAs:
 ;
 ; #1878         EN^PSOORDER
 ; #4533         ARWS^PSS50 (supported)
 ; #4545         DATA^PSN50P68 (supported)
 ; #4820         RX^PSO52API (supported)
 ;
 Q
 ;
 ;***** OUTPATIENT PHARMACY RXE SEGMENT BUILDER
 ;
 ; RORIEN        IEN in the PRESCRIPTION file (#52)
 ;
 ; .RORRXE       Array with info (from OEL^PSOORRL)
 ;
 ; PTIEN         Patient IEN (DFN)
 ;
 ; The ^TMP("PSOR",$J) global node is used by this function.
 ;
 ; Return Values:
 ;       <0  Error Code
 ;        0  Ok
 ;       >0  Non-fatal error(s)
 ;
RXE(RORIEN,RORRXE,PTIEN) ;
 N BUF,CS,ERRCNT,IDGN,II,INDF,J,L,RC,RORCLIN,RORCMOP,RORISIG,RORLST,RORMREF,RORMSG,RORPRICE,RORSEG,RORSTAT,RORSTOP,RORTEST,RORTMP,RORTS,TMP
 S (ERRCNT,RC)=0
 D ECH^RORHL7(.CS)
 ;
 Q:$P($G(RORRXE(0)),U)="" 0
 ;
 K ^TMP("PSOR",$J)
 D EN^PSOORDER(,RORIEN)
 ;
 S BUF=$G(^TMP("PSOR",$J,RORIEN,0))
 S RORMREF=$P(BUF,U,8)            ; # of refills
 S RORPRICE=$P(BUF,U,10)          ; unit price of drugs
 ;
 S BUF=$G(^TMP("PSOR",$J,RORIEN,1))
 S RORSTAT=$P($P(BUF,U,5),";",1)  ; patient status (internal)
 S RORSTDE=$P($P(BUF,U,5),";",2)  ; patient status
 S RORCLIN=+$P(BUF,U,4)           ; clinic
 ;
 S (J,RORISIG)="",L=245
 F  S J=$O(^TMP("PSOR",$J,RORIEN,"SIG1",J))  Q:J=""  D  Q:L'>0
 . S BUF=$G(^TMP("PSOR",$J,RORIEN,"SIG1",J,0))
 . S RORISIG=RORISIG_" "_$E(BUF,1,L)
 . S L=L-$L(BUF)-1  S:L<-1 RORISIG=RORISIG_"..."
 S RORISIG=$$TRIM^XLFSTR(RORISIG)
 ;
 ;--- Get Stop Code
 S RORSTOP=$$STOPCODE^RORUTL18(+RORCLIN)
 S:RORSTOP'>0 RORSTOP=""
 ;
 S RORTMP=$$ALLOC^RORTMP(.RORTS)
 D RX^PSO52API(PTIEN,RORTS,RORIEN,,"C,R")
 ;--- Get last dispensed dates
 S II=0  K RORLST
 F  S II=$O(@RORTMP@(PTIEN,RORIEN,"RF",II))  Q:II'>0  D
 . S RORLST(II,10.1)=+$G(@RORTMP@(PTIEN,RORIEN,"RF",II,10.1))
 ;--- Load the CMOP list
 S II=0  K RORCMOP
 F  S II=$O(@RORTMP@(PTIEN,RORIEN,"C",II))  Q:II'>0  D
 . Q:+$G(@RORTMP@(PTIEN,RORIEN,"C",II,3))=3
 . S TMP=$G(@RORTMP@(PTIEN,RORIEN,"C",II,2))
 . S:TMP'="" RORCMOP("A2",TMP,II)=""
 ;--- Free the buffer
 D FREE^RORTMP(RORTMP)
 ;
 F RORINDEX="REF","PAR" D
 . S II=""
 . F  S II=$O(RORRXE(RORINDEX,II))  Q:II=""  D  Q:RC<0
 . . S RORTEST=$G(RORRXE(RORINDEX,II,0))  Q:RORTEST=""
 . . ;
 . . ;--- Initialize the segment
 . . K RORSEG  S RORSEG(0)="RXE"
 . . ;
 . . ;--- RXE-1 - Quantity/Timing
 . . S RORSEG(1)=""""""
 . . ;
 . . ;--- RXE-2 - Give Code
 . . S IDGN=+$P($G(RORRXE("DD",1,0)),U,3)  ; File #50 IEN
 . . I IDGN'>0  S IDGN=+$P($G(RORRXE("DD",1,0)),U)  Q:IDGN'>0
 . . S TMP=$$RXE2(IDGN,CS,.BUF,.INDF)
 . . I TMP  S ERRCNT=ERRCNT+1  Q:TMP<0
 . . Q:BUF=""
 . . S RORSEG(2)=BUF
 . . ;
 . . ;--- RXE-3 - Give Amount (Min)
 . . S RORSEG(3)=""""""
 . . ;
 . . ;--- RXE-4 - Max # of re-fills
 . . S RORSEG(4)=RORMREF
 . . ;
 . . ;--- RXE-5 - Give Units
 . . S TMP=$$RXE5(+$G(INDF),CS,.BUF)
 . . S:TMP ERRCNT=ERRCNT+1
 . . S:BUF'="" RORSEG(5)=BUF
 . . ;
 . . ;--- RXE-6 - Release Date/Time
 . . S TMP=$P($G(RORRXE(RORINDEX,II,0)),U,4)
 . . S RORSEG(6)=$$FM2HL^RORHL7(TMP)
 . . ;
 . . ;--- RXE-7 - SIG1
 . . S RORSEG(7)=CS_$$ESCAPE^RORHL7(RORISIG)
 . . ;
 . . ;--- RXE-10 - Dispense amount
 . . S RORSEG(10)=$P($G(RORRXE(RORINDEX,II,0)),U,3)
 . . ;
 . . ;--- RXE-15 - Refill Indicator
 . . S RORSEG(15)=$S(RORINDEX="REF":1,RORINDEX="PAR":2)
 . . ;
 . . ;--- RXE-17 - Refill #
 . . S RORSEG(17)=II
 . . ;
 . . ;--- RXE-18 - Fill Date/Time
 . . S TMP=$P($G(RORRXE(RORINDEX,II,0)),U)
 . . S RORSEG(18)=$$FM2HL^RORHL7(TMP)
 . . ;
 . . ;--- RXE-19 - Total Daily Dose
 . . S RORSEG(19)=$P($G(RORRXE(RORINDEX,II,0)),U,2)
 . . ;
 . . ;--- RXE-20 - CMOP
 . . S RORSEG(20)=$S($D(RORCMOP("A2",II)):"Y",1:"N")
 . . ;
 . . ;--- RXE-21 - Clinic Stop
 . . S RORSEG(21)=RORSTOP
 . . ;
 . . ;--- RXE-22 - Dispense Date
 . . I 'II  D
 . . . S TMP=$P($G(RORRXE(0)),U,5)
 . . . S RORSEG(22)=$$FM2HL^RORHL7(TMP)
 . . E  D:$D(RORLST(II))
 . . . S TMP=+$G(RORLST(II,10.1))
 . . . S RORSEG(22)=$$FM2HL^RORHL7(TMP)
 . . ;
 . . ;--- RXE-23 - Unit Cost
 . . S RORSEG(23)=RORPRICE
 . . ;
 . . ;--- RXE-27 - Patient Status
 . . S RORSEG(27)=RORSTAT_CS_RORSTDE
 . . ;
 . . ;--- RXE-30 Mail/Window
 . . S TMP=$P($G(RORRXE(RORINDEX,II,0)),U,5)
 . . S RORSEG(30)=$S(TMP="M":"AD",TMP="W":"TR",1:"")
 . . ;
 . . ;--- Store the segment
 . . D ADDSEG^RORHL7(.RORSEG)
 ;
 K ^TMP("PSOR",$J)
 Q ERRCNT
 ;
 ;***** CONSTRUCTS THE RXE-2 FIELD (GIVE CODE)
 ;
 ; IEN50         IEN in the DRUG file (#50)
 ;
 ; [CS]          Component Separator (defaults to "^")
 ;
 ; .RXE2         Reference to a local variable where the value
 ;               of the  RXE-2 field is returned
 ;
 ; [.PSNDF]      VA PRODUCT
 ;                 ^01: IEN
 ;                 ^02: NAME (.01)
 ;
 ; Return Values:
 ;       <0  Error Code
 ;        0  Ok
 ;       >0  Non-fatal error(s)
 ;
RXE2(IEN50,CS,RXE2,PSNDF) ;
 N ERRCNT,IDGN,NODE,RC,RORMSG,TMP,TMP1
 S (ERRCNT,RC)=0,RXE2=""
 ;
 S:$G(CS)="" CS="^"
 S IDGN=+$G(IEN50)
 ;
 S NODE=$$ALLOC^RORTMP(.TMP)
 D ARWS^PSS50(IDGN,,TMP)
 ;
 S $P(RXE2,CS,1)=$G(@NODE@(IDGN,31))        ; NDC
 ;--- VA Product Name
 S PSNDF=$G(@NODE@(IDGN,22)),TMP1=$P(PSNDF,U,2)
 S $P(RXE2,CS,2)=$$ESCAPE^RORHL7($E(TMP1,1,64))
 S $P(RXE2,CS,3)="PSNDF"
 ;
 S TMP=""
 S $P(TMP,"-",1)=$P($G(@NODE@(IDGN,20)),U)  ; VA Drug Code
 S $P(TMP,"-",2)=$G(@NODE@(IDGN,2))         ; VA Drug Class
 S:TMP'="-" $P(RXE2,CS,4)=TMP
 ;--- Drug Name
 S $P(RXE2,CS,5)=$$ESCAPE^RORHL7($G(@NODE@(IDGN,.01)))
 S $P(RXE2,CS,6)="99PSD"
 ;
 D FREE^RORTMP(NODE)
 S:($P(RXE2,CS,1,2)="^")&($P(RXE2,CS,4,5)="^") RXE2=""
 Q ERRCNT
 ;
 ;***** CONSTRUCTS THE RXE-5 FIELD (GIVE UNITS)
 ;
 ; IEN50P68      IEN in the VA PRODUCT file (#50.68)
 ;
 ; [CS]          Component Separator (defaults to "^")
 ;
 ; .RXE5         Reference to a local variable where the value
 ;               of the  RXE-5 field is returned
 ;
 ; Return Values:
 ;       <0  Error Code
 ;        0  Ok
 ;
RXE5(IEN50P68,CS,RXE5) ;
 N INDF,NODE,TMP
 S:$G(CS)="" CS="^"
 S RXE5="",INDF=+$G(IEN50P68)
 Q:INDF'>0 0
 ;--- Get the units
 S NODE=$$ALLOC^RORTMP(.TMP)
 D DATA^PSN50P68(INDF,,TMP)
 S TMP=$G(@NODE@(INDF,3))
 D FREE^RORTMP(NODE)
 Q:TMP'>0 0
 ;--- Format the field
 S $P(RXE5,CS,4)=$P(TMP,U)
 S $P(RXE5,CS,5)=$$ESCAPE^RORHL7($P(TMP,U,2))
 S $P(RXE5,CS,6)="99PSU"
 ;--- Success
 Q 0
