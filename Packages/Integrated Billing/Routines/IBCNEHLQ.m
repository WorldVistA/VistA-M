IBCNEHLQ ;DAOU/ALA - HL7 RQI Message ;17-JUN-2002
 ;;2.0;INTEGRATED BILLING;**184,271,300,361,416,438,467,497,533,516,601,621,631,737**;21-MAR-94;Build 19
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;**Program Description**
 ;  This routine builds an eIV Verification (RQI^I01) or
 ;  Identification (RQI^I03) request
 ;
 ;**Modified by  Date        Reason
 ;  DAOU/BHS     10/04/2002  Implementing Transmit SSN logic
 ;  DAOU/DB      03/19/2004  Stripped dashes from SSN (PID, GT1)
 ;
EN ;  Entry Point
 ;  Variables
 ;    HLFS = Field Separator
 ;    DFN = Patient IEN
 ;    PAYR = Payer IEN
 ;    BUFF = Buffer IEN
 ;    FRDT = Freshness Date
 ;
PID ; Patient Identification Segment
 N VAFSTR,ICN,NM,I,PID11,EDQ,IBWHO,IBDOB,PID19
 ; IB*601 & IB*621 & IB*737: All changed the line(s) below - setting 'VAFSTR'
 ; IB*601 Added MBI check
 ; IB*621/HAN added check for EICD (EXT=4)
 ; IB*737/DJW  Added QUERY check as EICD-I needs SSN, but not allowed for EICD-V.
 S VAFSTR=",1,7,8,11,",DFN=+$G(DFN)
 I $$MBICHK^IBCNEUT7(BUFF)!((EXT=4)&($G(QUERY)="I")) S VAFSTR=VAFSTR_"19,"
 ;
 S PID=$$EN^VAFHLPID(DFN,VAFSTR,1)
 ;
 S PID11=$P(PID,HLFS,12)
 I PID11'="" D
 . I $P(PID11,HLECH,1)="""""" S $P(PID11,HLECH,1)=""
 . I $P(PID11,HLECH,2)="""""" S $P(PID11,HLECH,2)=""
 . I $P(PID11,HLECH,3)="""""" S $P(PID11,HLECH,3)="UNKNOWN"
 . S $P(PID,HLFS,12)=PID11
 S PID19=$P(PID,HLFS,20)
 ; Encode special characters into Name and address pieces
 ; **NOTE: If $$EN^VAFHLPID should, in the future, return more than 11 pieces than the lines below may
 ;         need to be modified as they currently expect 11 pieces to be returned.
 I DFN D
 .; try to get name of insured from NAME OF INSURED
 .I ";1;5;6;7;"'[(";"_EXT_";"),$G(IRIEN)'="" D
 .. S IBWHO=$P($G(^DPT(DFN,.312,IRIEN,0)),U,6)
 .. I IBWHO'="",IBWHO'="v" Q
 ..;IB*2.0*601/DM for "self" appt extract, use patient's insurance insured DOB
 .. S IBDOB=$$GET1^DIQ(2.312,IRIEN_","_DFN_",","INSURED'S DOB","I")
 .. I IBDOB S $P(PID,HLFS,8)=$$HLDATE^HLFNC(IBDOB)
 .. S NM=$P($G(^DPT(DFN,.312,IRIEN,7)),U,1)
 .I ";1;5;6;7;"[(";"_EXT_";"),BUFF,$G(NM)="" D
 .. S IBWHO=$P($G(^IBA(355.33,BUFF,60)),U,5)
 .. I IBWHO'="",IBWHO'="v" Q
 ..;IB*2.0*601/DM for "self" buffer extract, use buff's insured DOB
 ..;otherwise, use patient's insurance insured DOB, otherwise use patient's DOB 
 .. S IBDOB=$$GET1^DIQ(355.33,BUFF_",","INSURED'S DOB","I")
 .. I 'IBDOB,$G(IRIEN)'="" S IBDOB=$$GET1^DIQ(2.312,IRIEN_","_DFN_",","INSURED'S DOB","I")
 .. I IBDOB S $P(PID,HLFS,8)=$$HLDATE^HLFNC(IBDOB)
 .. S NM=$P($G(^IBA(355.33,BUFF,91)),U)
 .I $G(NM)'="" S NM=$$HLNAME^HLFNC(NM,HLECH)
 .; if unsuccessful, get patient name from 2/.01
 .I $G(NM)="" D
 ..S NM("FILE")=2,NM("IENS")=DFN,NM("FIELD")=.01
 ..S NM=$$HLNAME^XLFNAME(.NM,"",$E(HLECH)),NM=$S(NM]"":NM,1:HLQ)
 ..Q
 .S I=$L(NM,HLFS),NM=$$ENCHL7(NM),$P(PID,HLFS,6,5+I)=NM
 .; IB*2.0*601
 .S $P(PID,HLFS,20,99)=$$ENCHL7($P(PID,HLFS,20,99))
 .S ICN=$P($G(^DPT(DFN,"MPI")),U,1)
 .S $P(PID,HLFS,4)=ICN_HLECH_HLECH_HLECH_"USVHA"_HLECH_"NI"_HLECH_"~"_DFN_HLECH_HLECH_HLECH_"USVHA"_HLECH_"PI"_HLECH_$P($$SITE^VASITE,U,3)_HLECH
 .Q
 S FRDT=$$HLDATE^HLFNC($G(FRDT))
 I PID19'="" S $P(PID,HLFS,13)="",$P(PID,HLFS,20)=PID19
 I EXT'=4 S $P(PID,HLFS,34)=FRDT ; IB*2.0*621 Not for A1 transaction
 Q
 ;
GT1 ;  Guarantor Segment
 N WHO,NM,IDOB,ISEX,SEX,RLIEN,PER,PLIEN,RDATA,IBSDATA,IBADDR
 N EICDIIEN,IBFMIEN,IBTRKDTA ; IB*2.0*621/DM variables 
 ;
 S GT1=""
 I $G(QUERY)="I" Q
 ;
 ;  If the data was extracted from Buffer get specifics from Buffer file
 I ";1;5;6;7;"[(";"_EXT_";") D
 . S WHO=$P($G(^IBA(355.33,BUFF,60)),U,5)
 . I WHO="v"!(WHO="") Q
 . ;S NM=$P($G(^IBA(355.33,BUFF,60)),U,7),NM=$$NAME^IBCNEHLU(NM)
 . S NM=$$GET1^DIQ(355.33,BUFF,91.01),NM=$$NAME^IBCNEHLU(NM) ;Get HIPAA data from new fields - IB*2*516
 . S NM=$$HLNAME^HLFNC(NM,HLECH)
 . S NM=$$ENCHL7(NM)
 . S $P(GT1,HLFS,3)=NM_HLECH_HLECH_HLECH
 . S IDOB=$P($G(^IBA(355.33,BUFF,60)),U,8),IDOB=$$HLDATE^HLFNC(IDOB)
 . S $P(GT1,HLFS,8)=IDOB
 . S $P(GT1,HLFS,2)=$$SCRUB($G(SUBID))_HLECH_HLECH_HLECH_HLECH_"HC"
 . Q
 ;
 ;  If the data was from the appointment extract, check Patient file, IB*2.0*621/DM
 I EXT=2 D
 . I IRIEN="" Q
 . S WHO=$P($G(^DPT(DFN,.312,IRIEN,0)),U,6)
 . I WHO="v"!(WHO="") Q
 . ;S NM=$P($G(^DPT(DFN,.312,IRIEN,0)),U,17)  ; WCJ;IB*2.0*497
 . S NM=$P($G(^DPT(DFN,.312,IRIEN,7)),U,1)  ; WCJ;IB*2.0*497
 . S NM=$$HLNAME^HLFNC(NM,HLECH)
 . S NM=$$ENCHL7(NM)
 . S $P(GT1,HLFS,3)=NM_HLECH_HLECH_HLECH
 . S IDOB=$P($G(^DPT(DFN,.312,IRIEN,3)),U,1),IDOB=$$HLDATE^HLFNC(IDOB)
 . S $P(GT1,HLFS,8)=IDOB
 . S $P(GT1,HLFS,2)=$$SCRUB($G(SUBID))_HLECH_HLECH_HLECH_HLECH_"HC"
 . ;
 . S IBSDATA=$G(^DPT(DFN,.312,IRIEN,3))
 . S IBADDR=$$HLADDR^HLFNC($P(IBSDATA,U,6,7),$P(IBSDATA,U,8,10))
 . S $P(GT1,HLFS,5)=$$ENCHL7(IBADDR)
 . ;
 . D CHK
 . I $P(GT1,HLFS,8)=""&(IDOB'="") S $P(GT1,HLFS,8)=$$HLDATE^HLFNC(IDOB)
 . I $P(GT1,HLFS,9)=""&(ISEX'="") S $P(GT1,HLFS,9)=ISEX
 . I $P(GT1,HLFS,9)="",WHO="s" D
 .. S SEX=$P($G(^DPT(DFN,.312,IRIEN,3)),U,12) ; get policy holder sex
 .. I SEX="" S SEX=$P(^DPT(DFN,0),U,2),SEX=$S(SEX="M":"F",1:"M") ; if null, use alternative method
 .. S $P(GT1,HLFS,9)=SEX
 ;
 ; IB*2.0*621/DM add EICD Verification, use data from EIV EICD TRACKING (#365.18) 
 I EXT=4,$G(QUERY)="V" D
 . S EICDIIEN=+$O(^IBCN(365.18,"C",IEN,0)) ; IEN is the TQ from IBCNEDEP
 . I ('EICDIIEN)!(EICDVIEN="") Q 
 . S IBFMIEN=EICDVIEN_","_EICDIIEN_","
 . K IBTRKDTA D GETS^DIQ(365.185,IBFMIEN,".04;.07;.08;.09","I","IBTRKDTA") ; grab selected fields (internal)
 . ;
 . S NM=IBTRKDTA(365.185,IBFMIEN,.09,"I")
 . Q:NM=""  ; no name means subscriber -- GT1 is not needed
 . S NM=$$HLNAME^HLFNC(NM,HLECH)
 . S NM=$$ENCHL7(NM)
 . S $P(GT1,HLFS,3)=NM_HLECH_HLECH_HLECH
 . S IDOB=IBTRKDTA(365.185,IBFMIEN,.07,"I"),IDOB=$$HLDATE^HLFNC(IDOB)
 . S $P(GT1,HLFS,8)=IDOB
 . ; Subscriber ID -- Guarantor Number 
 . S $P(GT1,HLFS,2)=$$SCRUB(IBTRKDTA(365.185,IBFMIEN,.04,"I"))_HLECH_HLECH_HLECH_HLECH_"HC"
 . ; skip address data
 . S ISEX=IBTRKDTA(365.185,IBFMIEN,.08,"I")
 . I $P(GT1,HLFS,8)=""&(IDOB'="") S $P(GT1,HLFS,8)=$$HLDATE^HLFNC(IDOB)
 . I $P(GT1,HLFS,9)=""&(ISEX'="") S $P(GT1,HLFS,9)=ISEX
 ;
 I GT1="" Q
 S $P(GT1,HLFS,1)=1
 S GT1="GT1"_HLFS_GT1
 Q
 ;
IN1 ;  Insurance Segment
 N EFFDT,ELIGDT,EXPDT,PREL,ADMN,ADMDT,IENS
 N EICDIIEN,IBFMIEN,IBPYIEN,IBTRKDTA ; IB*2.0*621/DM variables
 S IN1=""
 ;
 ;  If the data was extracted from Buffer get specifics from Buffer file
 I ";1;5;6;7;"[(";"_EXT_";") D
 .S PREL=$P($G(^IBA(355.33,BUFF,60)),U,14)
 .S ELIGDT=$P($G(TRANSR),U,12) I ELIGDT=DT S ELIGDT=""
 .S $P(IN1,HLFS,2)=$S(PREL=18:$$SCRUB($G(SUBID)),PREL="":$$SCRUB($G(SUBID)),1:$$SCRUB($G(PATID)))
 .S $P(IN1,HLFS,3)=$$ENCHL7($P(^IBE(365.12,PAYR,0),U,2))_HLECH_HLECH_HLECH_"USVHA"_HLECH_"VP"_HLECH
 .S $P(IN1,HLFS,4)=$$ENCHL7($P(^IBE(365.12,PAYR,0),U,1))
 . ;IB*2.0*516/TAZ - Use HIPAA compliant fields
 .;S $P(IN1,HLFS,8)=$$ENCHL7($P($G(^IBA(355.33,BUFF,40)),U,3))
 .;S $P(IN1,HLFS,9)=$$ENCHL7($P($G(^IBA(355.33,BUFF,40)),U,2))
 .S $P(IN1,HLFS,8)=$$ENCHL7($$GET1^DIQ(355.33,BUFF_",",90.02))
 .S $P(IN1,HLFS,9)=$$ENCHL7($$GET1^DIQ(355.33,BUFF_",",90.01))
 .S EFFDT=$P($G(^IBA(355.33,BUFF,60)),U,2),EFFDT=$$HLDATE^HLFNC(EFFDT)
 .S EXPDT=$P($G(^IBA(355.33,BUFF,60)),U,3),EXPDT=$$HLDATE^HLFNC(EXPDT)
 .S $P(IN1,HLFS,12)=EFFDT
 .S $P(IN1,HLFS,13)=EXPDT
 .S $P(IN1,HLFS,17)=$$PATREL(PREL)
 .S $P(IN1,HLFS,26)=$$HLDATE^HLFNC(ELIGDT)
 .I $P(IN1,HLFS,17)="" S $P(IN1,HLFS,17)=18
 ;
 ; If the data was from the appointment extract, check Patient file, IB*2.0*621/DM
 I EXT=2 D
 . I IRIEN="" Q
 . I $$SCRUB($G(SUBID))'=$$SCRUB($P($G(^DPT(DFN,.312,IRIEN,0)),U,2)) Q
 . S EFFDT=$P($G(^DPT(DFN,.312,IRIEN,0)),U,8),EFFDT=$$HLDATE^HLFNC(EFFDT)
 . S EXPDT=$P($G(^DPT(DFN,.312,IRIEN,0)),U,4),EXPDT=$$HLDATE^HLFNC(EXPDT)
 . S $P(IN1,HLFS,12)=EFFDT
 . S $P(IN1,HLFS,13)=EXPDT
 . S PREL=$P($G(^DPT(DFN,.312,IRIEN,4)),U,3)
 . S $P(IN1,HLFS,2)=$S(PREL=18:$$SCRUB($G(SUBID)),PREL="":$$SCRUB($G(SUBID)),1:$$SCRUB($G(PATID)))
 . S $P(IN1,HLFS,3)=$$ENCHL7($P(^IBE(365.12,PAYR,0),U,2))_HLECH_HLECH_HLECH_"USVHA"_HLECH_"VP"_HLECH
 . S $P(IN1,HLFS,4)=$$ENCHL7($P(^IBE(365.12,PAYR,0),U,1))
 . S $P(IN1,HLFS,17)=$$PATREL(PREL)
 . S IENS=IRIEN_","_DFN_","
 . S $P(IN1,HLFS,8)=$$ENCHL7($$GET1^DIQ(2.312,IENS,21,"E"))
 . S $P(IN1,HLFS,9)=$$ENCHL7($$GET1^DIQ(2.312,IENS,20,"E"))
 . I $P(IN1,HLFS,17)="" S $P(IN1,HLFS,17)=18
 ;
 ; IB*2.0*621/DM add EICD Verification, use data from EIV EICD TRACKING (#365.18) 
 I EXT=4,$G(QUERY)="V" D
 . S EICDIIEN=+$O(^IBCN(365.18,"C",IEN,0)) ; IEN is the TQ from IBCNEDEP
 . I ('EICDIIEN)!(EICDVIEN="") Q
 . S IBFMIEN=EICDVIEN_","_EICDIIEN_","
 . K IBTRKDTA D GETS^DIQ(365.185,IBFMIEN,".01;.03;.05;.09","I","IBTRKDTA") ; grab selected fields (internal)
 . ;
 . S PREL="18"  ; means self/veteran
 . S:IBTRKDTA(365.185,IBFMIEN,.09,"I")'="" PREL="" ; not subscriber 
 . S $P(IN1,HLFS,2)=IBTRKDTA(365.185,IBFMIEN,.05,"I")
 . S $P(IN1,HLFS,3)=$$ENCHL7(IBTRKDTA(365.185,IBFMIEN,.01,"I"))_HLECH_HLECH_HLECH_"USVHA"_HLECH_"VP"_HLECH ; PAYER VA ID
 . S IBPYIEN=+$$FIND1^DIC(365.12,,"QX",IBTRKDTA(365.185,IBFMIEN,.01,"I"),"C") ; PAYER IEN
 . S $P(IN1,HLFS,4)=$$ENCHL7($$GET1^DIQ(365.12,IBPYIEN_",",.01)) ; PAYER NAME
 . S $P(IN1,HLFS,17)=$$PATREL(PREL)
 . S $P(IN1,HLFS,8)=IBTRKDTA(365.185,IBFMIEN,.03,"I") ; GROUP NUMBER
 I IN1="" Q
 ;
 S $P(IN1,HLFS,1)=1
 S IN1="IN1"_HLFS_IN1
 Q
 ;
NTE(CTR) ;  NTE Segment
 N EICDIIEN
 ; TRANSR is 0 node of TQ, set in PROC^IBCNEDEP
 I CTR=1 S NTE=$$EXTERNAL^DILFD(365.1,.2,,$P($G(TRANSR),U,20)) ; service code from 365.1/.2
 ; IB*2.0*601 - Added NTE2 and NTE3
 I CTR=2 D
 . S NTE=$$GET1^DIQ(365.1,IEN_",","SOURCE OF INFORMATION","I")  ; IEN = ien of TQ
 . S NTE=$$GET1^DIQ(355.12,NTE_",","IB BUFFER ACRONYM")
 ; IB*2.0*631/TAZ restructure NTE(3)
 I CTR=3 D
 . N TYPE,WHICH
 . S NTE=$S(((EXT=4)&(QUERY="I")):"OHI",$$MBICHK^IBCNEUT7(BUFF):"MBI",1:"ELI") ; IB*2.0*621
 . S WHICH=$$GET1^DIQ(365.1,IEN_",",.1,"I") ;WHICH EXTRACT
 . S TYPE="" D
 .. I $$GET1^DIQ(365.1,IEN_",",.04)="Retry" S TYPE="RETRY" Q
 .. I WHICH=1 S TYPE="BUFFER" Q
 .. I WHICH=2 S TYPE="APPT" Q
 .. I EXT=4 D  Q
 ... I QUERY="I" S TYPE="EICD-I" Q
 ... S TYPE="EICD-V"
 .. I WHICH=5 S TYPE="REQUEST ELECTRONIC" Q
 .. I WHICH=6 S TYPE="ICB/VISTA" Q
 .. I WHICH=7 S TYPE="MBI REQUEST"
 . S NTE=NTE_"~"_TYPE
 ; IB*2.0*621
 I CTR=4 S NTE="" ; Reporting of known insurance information will happen at a later release
 I CTR=5 S NTE=""
 I CTR=5,EXT=4,QUERY="V" D
 . ; on EICD Verifications, pass the TRACE # from the associated EICD Inquiry
 . S EICDIIEN=+$O(^IBCN(365.18,"C",IEN,0)) ; IEN is the TQ from IBCNEDEP
 . S NTE=$$GET1^DIQ(365.18,EICDIIEN_",",.04,"I") ; EICD TRACE NUMBER 
 S NTE="NTE"_HLFS_CTR_HLFS_HLFS_NTE
 K CTR
 Q
 ; 
CHK ;  Check for spouse or other information in the Patient Relation File
 ;  DGREL = Relationship (1=Self, 2=Spouse, 3-34,99=Other)
 NEW IEN,QFL
 S IEN="",RLIEN="",ISEX="",QFL=0
 F  S IEN=$O(^DGPR(408.12,"B",DFN,IEN)) Q:IEN=""  D  Q:QFL
 . S DGREL=$P($G(^DGPR(408.12,IEN,0)),U,2)
 . ;
 . ;  If person is veteran, quit
 . I DGREL=1 Q
 . ;
 . ;  If person is spouse, pick that record and quit
 . I WHO="s",DGREL=2 S RLIEN=IEN,QFL=1 Q
 . ;
 . ;  Otherwise it should be an 'other' dependent
 . S RLIEN=IEN
 ;
 I RLIEN="" Q
 ;
 ;  Check for Sex, SSN, DOB in INCOME PERSON File
 S PER=$P(^DGPR(408.12,RLIEN,0),U,3)
 I PER'["DGPR(408.13" Q
 S PLIEN=$P(PER,";",1)
 I PLIEN="" Q
 S RDATA=$G(^DGPR(408.13,PLIEN,0)),ISEX=$P(RDATA,U,2),IDOB=$P(RDATA,U,3)
 I $P(RDATA,U,4)'="" N DFN S DFN=$P(RDATA,U,4),ISEX=$P(^DPT(DFN,0),U,2),IDOB=$P(^DPT(DFN,0),U,3)
 Q
 ;
ENCHL7(STR) ; Encode HL7 escape seqs in data fields
 ;
 ; Input:
 ; STR = Field data possible containing HL7 encoding chars
 ;
 ; Output Values
 ; Fn returns string w/converted escape seqs
 ;
 N CHR,NEW,RPLC,CNT,LOOP
 ;
 ; Replace "\" "&" "~" "|" with \F\ \R\ \E\ \T\ respectively
 F CHR="\","&","~","|" S CNT=$L(STR,CHR) I CNT>1 D
 . S NEW=$P(STR,CHR)
 . S RPLC="\"_$TR(CHR,"|~\&","FRET")_"\"
 . F LOOP=2:1:CNT S NEW=NEW_RPLC_$P(STR,CHR,LOOP)
 . S STR=NEW
 ;
 Q STR
 ;
SCRUB(Z) ; remove all punctuation from the string and convert lowercase to uppercase
 ; IB*2*416 - used for subscriber and patient ID fields
 S Z=$$NOPUNCT^IBCEF(Z,1)
 S Z=$$UP^XLFSTR(Z)
SCRUBX ;
 Q Z
 ;
PATREL(REL) ; convert pat.relationship to insured from VistA to X12 and return X12 value
 ; REL - VistA value
 ; 
 ; VistA values of Self (18), Spouse (01), and Child (19) remain unchanged,
 ; anything else is converted to X12 value of Other Adult (34)
 ;
 Q $S($G(REL)="":"",".01.18.19."[("."_REL_"."):REL,1:34)
