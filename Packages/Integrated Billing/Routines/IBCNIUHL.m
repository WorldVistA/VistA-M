IBCNIUHL ;AITC/TAZ - IIU PROCESS SEND INSURANCE TRANSMISSIONS ; 04/06/21 12:46p.m.
 ;;2.0;INTEGRATED BILLING;**687,713**;21-MAR-94;Build 12
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
 ;**Program Description**
 ;  This routine is the driver routine for sending an Interfacility Insurance Update message.  
 ;  It consists of both real time (RT) and delayed (NIGHT) transmissions.
 ;
NIGHT ;Main Entry Point for Nightly Process
 ;
 N DISYS,IIUIEN,XREF
 ;
 ; 1. If IIU Master Switch is "NO" or Null goto NIGHTQ
 ;
 I $$GET1^DIQ(350.9,1_",",53.01,"I")'="Y" G NIGHTQ
 ; 
 ; 2. Process Entries in INTERFACILITY INSURANCE UPDATE File (#365.19)
 ;  a. Use the "C" Cross References for status of Partial and Waiting
 ;  b. If Payer is deactivated quit
 ;  c. Call RT(IIUIEN)
 ;
 F XREF="P","W"  D
 . S IIUIEN=0
 . F  S IIUIEN=$O(^IBCN(365.19,"C",XREF,IIUIEN)) Q:'IIUIEN  D
 .. N PIEN
 .. S PIEN=$$GET1^DIQ(365.19,IIUIEN_",",1.02,"I")
 .. I $$PYRDEACT^IBCNINSU(PIEN) Q
 .. D RT(IIUIEN)
 ;
NIGHTQ ; Exit Night Processing
 ;
 Q
 ;
RT(IIUIEN) ; Real Time IIU Processing
 ;INPUT:
 ; IIUIEN        -  Internal Entry Number of the IIU data
 ;
 N ZTDESC,ZTDTH,ZTIO,ZTQUEUED,ZTRTN,ZTSAVE,ZTSK
 ;
 ;If not AUTOUPDATE, Queue the entry for 5 minutes to insure all buffer updates are complete.
 I $$GET1^DIQ(365.19,IIUIEN_",",1.04,"I")'=1 D  G RTQ
 . S ZTDTH=$$FMADD^XLFDT($$NOW^XLFDT(),,,5)
 . S ZTDESC="IIU BUFFER SUBMISSION ("_IIUIEN_")"
 . S ZTIO=""
 . S ZTQUEUED=1
 . S ZTRTN="BUFFER^IBCNIUHL("_IIUIEN_")"
 . D ^%ZTLOAD
 ;
RT1 ; entry tag for BUFFER^IBCNIUHL that we had to job off, this will correctly
 ; update the values in the DATA array
 ;
 ;IB*713/CKB add BADMSG variable to stop HL7 processing due to foreign characters
 N DA,DATA,DISYS,DFN,EFFDT,EFLAG,EXPDT,FAC,BADMSG,HCT,IBADDR,IBCNHLP,IBSDATA,ICN,IENS,INSIEN,INSIENS
 N NM,PDATE,PIEN,PIENS,PREL,PTR,ROUTINE,VACNTRY,ZMID
 N HL,HL771RF,HL771SF,HLA,HLCDOM,HLCINS,HLCS,HLCSTCP,HLDOM,HLDOMP,HLECH,HLFS,HLHDR,HLINST,HLINSTN,HLIP,HLL,HLN
 N HLPARAM,HLPID,HLPROD,HLREC,HLRESLT,HLRFREQ,HLSFREQ,HLTYPE,HLX
 ;
 D GETS^DIQ(365.19,IIUIEN_",","**","EI","DATA","ERROR")
 ; Check Payer Data
 ; 1. Get Payer IEN based on Insurance Company
 ;    a. If IIU Nationally Enabled is "NOT ENABLED" or Null Quit
 ;    b. If IIU Locally Enabled is "NOT ENABLED" or Null Quit
 S PIEN=$G(DATA(365.19,IIUIEN_",",1.02,"I")) I 'PIEN G RTQ
 D PAYER^IBCNINSU(PIEN,"IIU",,"IE",.DATA)
 S PIENS=$O(DATA(365.121,""))
 I '$G(DATA(365.121,PIENS,.02,"I")) G RTQ   ;If IIU Nationally Enabled is "NOT ENABLED" or Null Quit
 I '$G(DATA(365.121,PIENS,.03,"I")) G RTQ   ;If IIU Locally Enabled is "NOT ENABLED" or Null Quit
 ;
 ;Set Up IIU variables to be sent
 S DFN=$G(DATA(365.19,IIUIEN_",",.01,"I"))
 S INSIEN=$G(DATA(365.19,IIUIEN_",",1.03,"I")),INSIENS=INSIEN_","_DFN_","
 D GETS^DIQ(2.312,INSIENS,"*","IE","DATA")
 ;
 S IBCNHLP="IBCNIU PIN/I07 EVENT"  ;Event driver
 ;
 ; Initialize HL7
 D INIT
 ;
 ;Get facilities into HLL Array
 ;HLL("LINKS",n)=SUBSCRIBER PROTOCOL^LOGICAL LINK TO SEND TO
 K HLL("LINKS")
 N CNT S CNT=0
 S FAC="" F  S FAC=$O(DATA(365.191,FAC)) Q:'FAC  D
 . N LINK,LINKIEN
 . I $G(DATA(365.191,FAC,.02,"I"))'="R" K DATA(365.191,FAC) Q  ;Remove if not Ready to Send
 . D LINK^HLUTIL3($G(DATA(365.191,FAC,.01,"I")),.LINK)
 . S LINKIEN=$O(LINK("")) I 'LINKIEN K DATA(365.191,FAC) Q  ;Remove if can't resolve link
 . S CNT=CNT+1,HLL("LINKS",CNT)="IBCNIU PIN/I07 SUB"_U_LINK(LINKIEN)
 I 'CNT G RTQ   ; No facilities to send
 ;
 S BADMSG=0  ;IB*713 - initialize to 0 - "NO"
 ;
 ; Build PIN-I07 record
 D BLD(.DATA)
 ;
 I $G(EFLAG) G RTQ  ;Error creating HL7 record.  Try later.
 ;NOTE:  BADMSG Returns 1-"YES" if processing is to stop.
 I BADMSG G RTQ   ;IB*713/CKB DO NOT send HL7 msg
 ;
 ; Generate HL7 record
 D GENERATE^HLMA(IBCNHLP,"GM",1,.HLRESLT,"","")
 ;
 ;Update SENT STATUS (#.02)
 I '+$P(HLRESLT,U,2) D
 . S FAC=""
 . F  S FAC=$O(DATA(365.191,FAC)) Q:'FAC  D
 .. S IBDFDA=+FAC
 .. S IBDFDA(1)=IIUIEN
 .. S DATA(.02)="S"
 .. I $$UPD^IBDFDBS(365.191,.IBDFDA,.DATA)
 ;
 ; Set SENDER STATUS (#1.01)
 K IBDFDA,DATA
 S IBDFDA=IIUIEN
 I '$D(^IBCN(365.19,IBDFDA,1.1,"C","R")) S DATA(1.01)="C"
 I '$D(DATA(1.01)),'$D(^IBCN(365.19,IBDFDA,1.1,"C","S")) S DATA(1.01)="W"
 I '$D(DATA(1.01)) S DATA(1.01)="P"
 I $$UPD^IBDFDBS(365.19,.IBDFDA,.DATA)
 ;
 K ^TMP("HLS",$J),HLP
 ;
RTQ ;Exit Real-Time IIU transmission
 Q
 ;
INIT ;  Initialization for HL7
 D INIT^HLFNC2(IBCNHLP,.HL)
 S HLFS=HL("FS"),HLECH=$E(HL("ECH"),1)
 S HCT=0
 Q
 ;
BLD(DATA) ; Build the PIN_I07 record.
 ; Input:
 ;    DATA         - Data Array of all variables for the record from IIU (#365.19), PAYER (#365.12), 
 ;                   and INSURANCE TYPE (#2.312) files
 ;
 N BIN,DOB,FLD,GRP,GT1,IN1,INSDOB,NTE,PCN,PID,PRD,SUBID,VAFSTR,WHO
 ; The following variables are used in multiple segments
 S DOB=$G(DATA(2.312,INSIENS,3.01,"I"))        ;DATE OF BIRTH
 S SUBID=$G(DATA(365.19,IIUIEN_",",1.06,"E"))  ;SUBSCRIBER ID
 S PREL=$G(DATA(2.312,INSIENS,4.03,"I"))       ;PATIENT RELATIONSHIP - HIPAA
 S GRP=$G(DATA(2.312,INSIENS,.18,"I"))         ;Pointer to Group in #355.3
 S WHO=$G(DATA(2.312,INSIENS,6,"I"))           ;WHOSE INSURANCE
 ;
 ;Set up PRD node
 S HCT=HCT+1,^TMP("HLS",$J,HCT)="PRD"_HLFS_"NA"
 ;
 ;Set up PID Node
 S VAFSTR=",1,"
 S PID=$$EN^VAFHLPID(DFN,VAFSTR,1)
 S ICN=$$GETICN^MPIF001(DFN)
 I 'ICN S EFLAG=1 G BLDQ  ; ICN is required
 I $E(ICN,1,3)=$P($$SITE^VASITE,U,3) S EFLAG=1 G BLDQ  ;local ICN, skip patient
 S $P(PID,HLFS,4)=ICN_HLECH_HLECH_HLECH_"USVHA"_HLECH_"NI"_HLECH_"USVHA"
 ;
 I PID=""!(PID?."*") S EFLAG=1 G BLDQ
 ;
 S HCT=HCT+1,^TMP("HLS",$J,HCT)=$TR(PID,"*","")
 ;
 ;Set up GT1 Node if dependent policy
 S GT1=""
 ;
 I WHO'="v",(WHO'="") D
 . ; segment 2 - Subscriber ID
 . S $P(GT1,HLFS,2)=$$SCRUB($G(SUBID))_HLECH_HLECH_HLECH_HLECH_"HC"
 . ; segment 3 - Guarantor Name (Name of Insured)
 . S NM=$G(DATA(2.312,INSIENS,7.01,"I"))   ; Set name to NAME OF INSURED
 . S NM=$$HLNAME^HLFNC(NM,HLECH)
 ;
 ;IB*713/CKB - add checks for foreign characters
 ;If foreign chars encountered DO NOT send HL7
 I GT1]"",$$FOREIGN^IBCNINSU($P(GT1,HLFS,2)) S BADMSG=1 Q  ;GT1-2 SUBSCRIBER ID
 ;
 ;If foreign chars encountered clear field and continue with msg
 ; GT1-3 SUBSCRIBER NAME/NAME OF INSURED 
 I GT1]"" S FLD=$P(GT1,HLFS,3) I $$FOREIGN^IBCNINSU(.FLD,1,1) S $P(GT1,HLFS,3)=FLD ;GT1-3
 ;
 I GT1]"" D
 . S $P(GT1,HLFS,1)=1,GT1="GT1"_HLFS_GT1 ;
 . I GT1'?."*" S HCT=HCT+1,^TMP("HLS",$J,HCT)=$TR(GT1,"*","")
 ;
 ;Set up IN1 Node
 S IN1=""
 ;
 ; Segment 2 - Insurance Plan ID
 S $P(IN1,HLFS,2)=$S(PREL=18:$$SCRUB($G(SUBID)),PREL="":$$SCRUB($G(SUBID)),1:$$SCRUB($G(DATA(2.312,INSIENS,5.01,"I"))))
 ; Segment 3 - Insurance Company ID (Payer)
 S $P(IN1,HLFS,3)=$$ENCHL7($G(DATA(365.12,PIEN_",",.02,"E")))_HLECH_HLECH_HLECH_"USVHA"_HLECH_"VP"
 ; Segment 4 - Insurance Company Name
 S $P(IN1,HLFS,4)=$$ENCHL7($G(DATA(2.312,INSIENS,.01,"E")))
 ; Segment 8 - Group Number
 S $P(IN1,HLFS,8)=$$ENCHL7($G(DATA(2.312,INSIENS,21,"E")))
 ; Segment 9 - Group Name
 S $P(IN1,HLFS,9)=$$ENCHL7($G(DATA(2.312,INSIENS,20,"E")))
 ;
 ;IB*713/CKB - add check for foreign characters
 ;If foreign chars encountered DO NOT send HL7
 I $$FOREIGN^IBCNINSU($P(IN1,HLFS,2)) S BADMSG=1 Q    ;IN1-2 PATIENT/SUBSCRIBER ID
 ;
 ;If foreign chars encountered clear field and continue with msg
 S FLD=$P(IN1,HLFS,8) I $$FOREIGN^IBCNINSU(.FLD,1,1) S $P(IN1,HLFS,8)=FLD ;IN1-8 GROUP NUMBER
 S FLD=$P(IN1,HLFS,9) I $$FOREIGN^IBCNINSU(.FLD,1,1) S $P(IN1,HLFS,9)=FLD ;IN1-9 GROUP NAME
 ;
 ; Segment 12 - Effective Date of Policy
 S EFFDT=$G(DATA(2.312,INSIENS,8,"I")),$P(IN1,HLFS,12)=$$HLDATE^HLFNC(EFFDT)
 ; Segment 15 - Plan Type
 S $P(IN1,HLFS,15)=$$GET1^DIQ(355.3,GRP_",",.09,"I")
 ; Segment 17 - Patient Relationship - HIPAA
 S $P(IN1,HLFS,17)=$G(DATA(2.312,INSIENS,4.03,"I"))
 ; Segment 18 - Insured's DOB
 S INSDOB=$G(DATA(2.312,INSIENS,3.01,"I"))
 I WHO="v",INSDOB="" S INSDOB=$$GET1^DIQ(2,DFN_",",.03,"I")
 S $P(IN1,HLFS,18)=$$HLDATE^HLFNC(INSDOB)
 ; Segment 22 - Coordination of Benefits
 S $P(IN1,HLFS,22)=$G(DATA(365.19,IIUIEN_",",1.07,"I"))
 ;
 I IN1]"" D
 . S $P(IN1,HLFS,1)=1,IN1="IN1"_HLFS_IN1
 . I IN1'?."*" S HCT=HCT+1 S ^TMP("HLS",$J,HCT)=$TR(IN1,"*","")
 ;
 ;Set up NTE Node
 S NTE=""
 ;
 ; Segment 3  - Whose Insurance~BIN~PCN
 S BIN=$$ENCHL7($$GET1^DIQ(355.3,GRP_",",6.02,"E"))   ;Banking Identification Number (BIN)
 S PCN=$$ENCHL7($$GET1^DIQ(355.3,GRP_",",6.03,"E"))   ;Processor Control Number (PCN)
 S $P(NTE,HLFS,3)=WHO_HLECH_BIN_HLECH_PCN
 ;
 I NTE]"" D
 . S $P(NTE,HLFS,1)=1,NTE="NTE"_HLFS_NTE
 . I NTE'?."*" S HCT=HCT+1 S ^TMP("HLS",$J,HCT)=$TR(NTE,"*","")
 ;
BLDQ ;
 Q
 ;
ENCHL7(STR) ; Encode HL7 escape seqs in data fields
 ;INPUT:
 ;  STR    - String to be encoded
 ;  HL     - Array containing HL components returned from INIT^HLFNC2
 ;
 ; Returns an encoded string
 ;   The encoded characters are:
 ;    /F/ - Field Separator
 ;    /C/ - Component Separator
 ;    /R/ - Repetition Separator
 ;    /E/ - Escape Character
 ;    /S/ - Sub-component Separator
 ;
 N CHR,ENCCHR,IDX
 I STR']"" G ENCHL7Q  ;Nothing to encode
 I '$D(HL) G ENCHL7Q  ;No encoding characters defined
 S ENCCHR="CRES"
 ;
 ; Check for field Separator
 F  Q:STR'[HL("FS")  S STR=$P(STR,HL("FS"),1)_"/F/"_$P(STR,HL("FS"),2,99)
 F IDX=1:1:$L(HL("ECH")) S CHR=$E(HL("ECH"),IDX) F  Q:STR'[CHR  S STR=$P(STR,CHR,1)_"/"_$E(ENCCHR,IDX)_"/"_$P(STR,CHR,2,99)
 ;
ENCHL7Q ;
 Q STR
 ;
SCRUB(Z) ; remove all punctuation from the string and convert lowercase to uppercase
 S Z=$$NOPUNCT^IBCEF(Z,1)
 S Z=$$UP^XLFSTR(Z)
SCRUBX ;
 Q Z
 ;
BUFFER(IIUIEN) ;
 ;Job was queued with a 5 minute delay because ICB has to take back control
 ; then save the patient data to the patient's record in subfile #2.312.
 N DATA,DFN,FIELD,INSIEN,INSIENS,OK,STAT
 S OK=1
 S DFN=$$GET1^DIQ(365.19,IIUIEN_",",.01,"I")
 S INSIEN=$$GET1^DIQ(365.19,IIUIEN_",",1.03,"I"),INSIENS=INSIEN_","_DFN_","
 ;
 ;Picking up the fields after the 5 minute delay to ensure we are getting the correct values
 S DATA(1.06)=$$GET1^DIQ(2.312,INSIENS,7.02,"I") ;Subscriber ID to be sent to remote facility
 S DATA(1.07)=$$GET1^DIQ(2.312,INSIENS,.2,"I")   ;Coordination of Benefits to be sent to remote facility
 I $$UPD^IBDFDBS(365.19,IIUIEN,.DATA)
 K DATA
 ;
 D GETS^DIQ(2.312,INSIENS,".01;3.01;4.03;5.01;7.01;7.02","IE","DATA")
 ;
 ;Check for IIU Required fields in the Patient record, file #2 and subfile #2.312
 ; Patient name + Patient DOB + Insurance Company Name + Name of Insured + Subscriber ID
 ;Checking Patient Name, Patient Date of Birth
 F FIELD=.01,.03 D  I 'OK G BUFFERQ
 . I $$GET1^DIQ(2,DFN_",",FIELD,"E")="" S OK=0
 ;
 ;Checking Insurance Company Name, Name of Insured, Subscriber ID
 F FIELD=.01,7.01,7.02 D  I 'OK G BUFFERQ
 . I $G(DATA(2.312,INSIENS,FIELD,"E"))="" S OK=0
 ;
 ;IF Pt. Relationship-HIPAA is not SELF, then Insured Date of Birth + Patient ID are required
 I DATA(2.312,INSIENS,4.03,"E")'="SELF" D
 . I $G(DATA(2.312,INSIENS,3.01,"E"))="" S OK=0  Q  ;Insured Date of Birth
 . I $G(DATA(2.312,INSIENS,5.01,"E"))="" S OK=0     ;Patient ID
 ;
BUFFERQ ;Exit
 ;
 ;Everything checks out.  Process entry real time.
 I OK G RT1
 ;
 ;If any of the required fields are missing data, set the SENDER STATUS (#1.01)
 ; in the INTERFACILITY UPDATE file #365.19 to 'F'-FAILED MISSING DATA
 S STAT(1.01)="F"
 I $$UPD^IBDFDBS(365.19,IIUIEN,.STAT)
 Q
 ;
