VAFHLZCE ;ALB/KUM - Create generic HL7 Community Care Program (ZCE) segments ;06/16/20 3:34PM
 ;;5.3;Registration;**1014**;Aug 13, 1993;Build 42
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;
 ;Supported ICRs
 ; #2056  - $$GET1^DIQ(}
 ;
 ; This generic extrinsic function is designed to return the
 ; HL7 Community Care Program (ZCE) segment. This segment contains VA-specific
 ; Community Care Eligibility data for a patient.
 ;
EN(DFN,VAFSTR,VAFNUM,VAFHLQ,VAFHLFS,VAFZCE) ; build HL7 ZCE segments.
 ; ZCE segments will be returned in the array VAFZCE.
 ;
 ; Input: DFN - Pointer to PATIENT file (#2)
 ;        VAFSTR - String of fields requested separated by commas
 ;        VAFNUM - (optional) sequential number for SET ID (default=1)
 ;        VAFHLQ - (optional) HL7 null variable.
 ;        VAFHLFS - (optional) HL7 field separator.
 ;       .VAFZCE - Array to return segments in
 ;
 ;
 ; Output: VAFZCE(X) = ZCE segment (first 245 characters)
 ;         VAFZCE(X,Y) = Remaining portion of ZCE segment in 245 character chunks
 ;
 ; Notes: VAFZCE is initialized (KILLed) on input.
 ;
 N VAFHLZCE,VAFNUM,VAFMAXL,VAFIE1,DGFIDX,DGUPDT,DGREC
 K VAFZCE
 ;
 ; if VAFHLQ or VAFHLFS not passed, use default HL7 variables
 S VAFHLQ=$S($D(VAFHLQ):VAFHLQ,1:$G(HLQ)),VAFHLFS=$S($D(VAFHLFS):VAFHLFS,1:$G(HLFS))
 ;
 ; if set id not passed, use default
 S VAFNUM=$S($G(VAFNUM):VAFNUM,1:1)
 ;
 S VAFMAXL=245
 S VAFSTR=","_VAFSTR_","
 ; Do not create ZCE segment if Archive flag is 1
 K DGTMP
 M DGTMP(DFN,5)=^DPT(DFN,5)
 S DGFIDX=0
 F  S DGFIDX=$O(DGTMP(DFN,5,DGFIDX)) Q:'DGFIDX  S DGREC=$G(DGTMP(DFN,5,DGFIDX,0)) D  ;
 .I $P(DGREC,U,5)'=1 D
 ..S DGUPDT=$P(DGREC,U)
 ..S DGTMP("UPDT",DGUPDT,DGFIDX)=DGREC
 ; ZCE for approved requests
 S DGUPDT=""
 F  S DGUPDT=$O(DGTMP("UPDT",DGUPDT)) Q:DGUPDT=""  D
 .S DGFIDX="" F  S DGFIDX=$O(DGTMP("UPDT",DGUPDT,DGFIDX)) Q:DGFIDX=""  D
 ..D GETDATA(DGFIDX),MAKESEG S VAFNUM=VAFNUM+1
 ..Q
 .Q
 Q
 ;
GETDATA(DGFIDX) ; Get information needed to build ZCE segment
 ; Input:
 ;   DGFIDX = IEN of Subfile #2.191 Community Care Program
 ;
 ; Existence of the following variables is assumed
 ;   DFN - Pointer to Patient (#2) file
 ;   VAFSTR - Fields to extract (padded with commas)
 ;   VAFNUM - Value to use for Set ID (optional)
 ;   HL7 encoding characters (HLFS, HLENC, HLQ)
 ;
 ; Output: VAFHLZCE(SeqNum) = Value
 ;
 ; Notes: VAFHLZCE is initialized (KILLed) on entry
 ;
 N VAFIEN,VAFPGM,VAFEFD,VAFEND,VAFCCD
 K VAFHLZCE
 S VAFIEN=DGFIDX_","_DFN_","
 S VAFPGM=$$GET1^DIQ(2.191,VAFIEN,1,"I")
 S VAFEFD=$$GET1^DIQ(2.191,VAFIEN,2,"I")
 S VAFEND=$$GET1^DIQ(2.191,VAFIEN,3,"I")
 S VAFCCD=$$GET1^DIQ(2.191,VAFIEN,.01,"I")
 ;
 ; set-up segment data fields
 I VAFSTR[",1," S VAFHLZCE(1)=+$G(VAFNUM)  ; Sequential ID
 I VAFSTR[",2," S VAFHLZCE(2)=$S($G(VAFPGM)]"":$G(VAFPGM),1:VAFHLQ)  ; Community Care Progarm Code
 I VAFSTR[",3," S VAFHLZCE(3)=$S($G(VAFEFD)]"":$$HLDATE^HLFNC($G(VAFEFD),"DT"),1:VAFHLQ)  ; Effective Date
 I VAFSTR[",4," S VAFHLZCE(4)=$S($G(VAFEND)]"":$$HLDATE^HLFNC($G(VAFEND),"DT"),1:VAFHLQ)  ; End Date
 I VAFSTR[",5," S VAFHLZCE(5)=$S($G(VAFCCD)]"":$$HLDATE^HLFNC($G(VAFCCD),"TS"),1:VAFHLQ)  ; Last Updated Date
 ;
 Q
 ;
MAKESEG ; Create segment using obtained data
 ; Input: Existence of the following variables is assumed
 ;   VAFNUM = Number denoting Xth repetition of the ZCE segment
 ;   VAFMAXL = Maximum length of each node (defaults to 245)
 ;   VAFHLZCE(SeqNum) = Value
 ;   HL7 encoding characters (HLFS, HLECH)
 ;
 ; Output: VAFZCE(VAFNUM)   = ZCE segment (first VAFMAXL characters)
 ;         VAFZCE(VAFNUM,x) = Remaining portion of ZCE segment in VAFMAXL character chunks (if needed), beginning with a field separator
 ;
 ; Notes: VAFZCE(VAFNUM) is initialized (KILLed) on input. Fields will not be split across nodes in VAFZCE()
 ;
 N VAFSEQ,VAFSPIL,VAFSPON,VAFSPOT,VAFLSEQ,VAFY
 K VAFZCE(VAFNUM)
 S VAFZCE(VAFNUM)="ZCE"
 S:'+$G(VAFMAXL) VAFMAXL=245
 S VAFY=$NA(VAFZCE(VAFNUM))
 S (VAFSPIL,VAFSPON)=0
 S VAFLSEQ=+$O(VAFHLZCE(""),-1)
 F VAFSEQ=1:1:VAFLSEQ D
 .; Make sure maximum length won't be exceeded
 .I ($L(@VAFY)+$L($G(VAFHLZCE(VAFSEQ)))+1)>VAFMAXL D
 ..; Max length exceeded - start putting data on next node
 ..S VAFSPIL=VAFSPIL+1
 ..S VAFSPON=VAFSEQ-1
 ..S VAFY=$NA(VAFZCE(VAFNUM,VAFSPIL))
 .; Add to string
 .S VAFSPOT=(VAFSEQ+1)-VAFSPON
 .S $P(@VAFY,VAFHLFS,VAFSPOT)=$G(VAFHLZCE(VAFSEQ))
 Q
