IBCNEHLQ ;DAOU/ALA - HL7 RQI Message ;17-JUN-2002
 ;;2.0;INTEGRATED BILLING;**184,271,300,361,416**;21-MAR-94;Build 58
 ;;Per VHA Directive 2004-038, this routine should not be modified.
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
 N VAFSTR,ICN,NM,I
 S VAFSTR=",1,7,8,11,",DFN=+$G(DFN)
 S PID=$$EN^VAFHLPID(DFN,VAFSTR,1)
 ; Encode special characters into Name and address pieces
 ; **NOTE: If $$EN^VAFHLPID should, in the future, return more than 11 pieces than the lines below may
 ;         need to be modified as they currently expect 11 pieces to be returned.
 I DFN D
 . S NM("FILE")=2,NM("IENS")=DFN,NM("FIELD")=.01
 . S NM=$$HLNAME^XLFNAME(.NM,"",$E(HLECH)),NM=$S(NM]"":NM,1:HLQ)
 . S I=$L(NM,HLFS),NM=$$ENCHL7(NM),$P(PID,HLFS,6,5+I)=NM
 . S $P(PID,HLFS,12,99)=$$ENCHL7($P(PID,HLFS,12,99))
 . S ICN=$P($G(^DPT(DFN,"MPI")),U,1)
 . S $P(PID,HLFS,4)=ICN_HLECH_HLECH_HLECH_"USVHA"_HLECH_"NI"_HLECH_"~"_DFN_HLECH_HLECH_HLECH_"USVHA"_HLECH_"PI"_HLECH_$P($$SITE^VASITE,U,3)_HLECH
 . Q
 S FRDT=$$HLDATE^HLFNC($G(FRDT))
 S $P(PID,HLFS,34)=FRDT
 Q
 ;
GT1 ;  Guarantor Segment
 N WHO,NM,IDOB,ISEX,SEX,RLIEN,PER,PLIEN,RDATA,IBSDATA,IBADDR
 ;
 S GT1=""
 I $G(QUERY)="I" Q
 ;
 ;  If the data was extracted from Buffer get specifics from Buffer file
 I EXT=1 D
 . S WHO=$P($G(^IBA(355.33,BUFF,60)),U,5)
 . I WHO="v"!(WHO="") Q
 . S NM=$P($G(^IBA(355.33,BUFF,60)),U,7),NM=$$NAME^IBCNEHLU(NM)
 . S NM=$$HLNAME^HLFNC(NM,HLECH)
 . S NM=$$ENCHL7(NM)
 . S $P(GT1,HLFS,3)=NM_HLECH_HLECH_HLECH
 . S IDOB=$P($G(^IBA(355.33,BUFF,60)),U,8),IDOB=$$HLDATE^HLFNC(IDOB)
 . S $P(GT1,HLFS,8)=IDOB
 . S $P(GT1,HLFS,2)=$$SCRUB($G(SUBID))_HLECH_HLECH_HLECH_HLECH_"HC"
 . Q
 ;
 ;  If the data was extracted from non-Buffer, check Patient file
 I EXT'=1 D
 . I IRIEN="" Q
 . S WHO=$P($G(^DPT(DFN,.312,IRIEN,0)),U,6)
 . I WHO="v"!(WHO="") Q
 . S NM=$P($G(^DPT(DFN,.312,IRIEN,0)),U,17)
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
 I GT1="" Q
 S $P(GT1,HLFS,1)=1
 S GT1="GT1"_HLFS_GT1
 Q
 ;
IN1 ;  Insurance Segment
 NEW EFFDT,EXPDT,PREL,ADMN,ADMDT,IENS
 S IN1="",SRVDT=$$HLDATE^HLFNC(SRVDT)
 ;
 ;  If the data was extracted from Buffer get specifics from Buffer file
 I EXT=1 D
 . S PREL=$P($G(^IBA(355.33,BUFF,60)),U,14)
 . S $P(IN1,HLFS,2)=$S(PREL=18:$$SCRUB($G(SUBID)),1:$$SCRUB($G(PATID)))
 . I PAYR'=$$FIND1^DIC(365.12,"","X","~NO PAYER") D
 .. S $P(IN1,HLFS,3)=$$ENCHL7($P(^IBE(365.12,PAYR,0),U,2))_HLECH_HLECH_HLECH_"USVHA"_HLECH_"VP"_HLECH
 .. S $P(IN1,HLFS,4)=$$ENCHL7($P(^IBE(365.12,PAYR,0),U,1))
 . S $P(IN1,HLFS,8)=$$ENCHL7($P($G(^IBA(355.33,BUFF,40)),U,3))
 . S $P(IN1,HLFS,9)=$$ENCHL7($P($G(^IBA(355.33,BUFF,40)),U,2))
 . S EFFDT=$P($G(^IBA(355.33,BUFF,60)),U,2),EFFDT=$$HLDATE^HLFNC(EFFDT)
 . S EXPDT=$P($G(^IBA(355.33,BUFF,60)),U,3),EXPDT=$$HLDATE^HLFNC(EXPDT)
 . S $P(IN1,HLFS,12)=EFFDT
 . S $P(IN1,HLFS,13)=EXPDT
 . S $P(IN1,HLFS,17)=$$PATREL(PREL)
 ;
 ;  If the data was extracted from non-Buffer, check Patient file
 I EXT'=1 D
 . I IRIEN="" Q
 . I $$SCRUB($G(SUBID))'=$$SCRUB($P($G(^DPT(DFN,.312,IRIEN,0)),U,2)) Q
 . S EFFDT=$P($G(^DPT(DFN,.312,IRIEN,0)),U,8),EFFDT=$$HLDATE^HLFNC(EFFDT)
 . S EXPDT=$P($G(^DPT(DFN,.312,IRIEN,0)),U,4),EXPDT=$$HLDATE^HLFNC(EXPDT)
 . S $P(IN1,HLFS,12)=EFFDT
 . S $P(IN1,HLFS,13)=EXPDT
 . S PREL=$P($G(^DPT(DFN,.312,IRIEN,4)),U,3)
 . S $P(IN1,HLFS,2)=$S(PREL=18:$$SCRUB($G(SUBID)),1:$$SCRUB($G(PATID)))
 . I PAYR'=$$FIND1^DIC(365.12,"","X","~NO PAYER") D
 .. S $P(IN1,HLFS,3)=$$ENCHL7($P(^IBE(365.12,PAYR,0),U,2))_HLECH_HLECH_HLECH_"USVHA"_HLECH_"VP"_HLECH
 .. S $P(IN1,HLFS,4)=$$ENCHL7($P(^IBE(365.12,PAYR,0),U,1))
 . S $P(IN1,HLFS,17)=$$PATREL(PREL)
 . S IENS=IRIEN_","_DFN_","
 . S $P(IN1,HLFS,8)=$$ENCHL7($$GET1^DIQ(2.312,IENS,21,"E"))
 . S $P(IN1,HLFS,9)=$$ENCHL7($$GET1^DIQ(2.312,IENS,20,"E"))
 ;
 I IN1="" Q
 ;
 I $G(QUERY)="I",$P(IN1,HLFS,17)'=18 S $P(IN1,HLFS,17)=18
 I $P(IN1,HLFS,17)="" S $P(IN1,HLFS,17)=18
 ;
 ;  Set the admission date if patient currently admitted
 S ADMN=$P($G(^DPT(DFN,.105)),U,1) I ADMN'="" D
 . S ADMDT=$P(^DGPM(ADMN,0),U,1),ADMDT=$$HLDATE^HLFNC(ADMDT)
 . S $P(IN1,HLFS,24)=ADMDT
 ;
 ;  Set the service date
 S $P(IN1,HLFS,26)=SRVDT
 S $P(IN1,HLFS,1)=1
 S IN1="IN1"_HLFS_IN1
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
