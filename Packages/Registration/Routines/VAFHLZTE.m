VAFHLZTE ;SHRPE/YMG - Create HL7 ZTE segment ;06/17/19
 ;;5.3;Registration;**952**;Aug 13, 1993;Build 160
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
EN(DFN,VAFSTR,VAFCHK,VAFZTE) ; build HL7 ZTE segments.
 ; These segments contain VA-specific data for OTH (Other Than Honorable)
 ; patients. ZTE segments will be returned in the array VAFZTE.
 ;
 ; Input: DFN - Pointer to PATIENT file (#2)
 ;       VAFSTR - String of fields requested separated by commas
 ;       VAFCHK - 1 to only create ZTE segments if patient is OTH, 0 to create segments regardless of patient's OTH status (default)
 ;       .VAFZEL - Array to return segments in
 ;
 ;       Existence of HL7 encoding characters (HLFS,HLECH) is assumed
 ;
 ; Output: VAFZTE(X) = ZTE segment (first 245 characters)
 ;         VAFZTE(X,Y) = Remaining portion of ZTE segment in 245 character chunks
 ;
 ; Notes: VAFZTE is initialized (KILLed) on input.
 ;
 N DGOTHSTR,IEN33,IEN3301,IEN3303,IEN3311,VAFHLZTE,VAFSETID,VAFMAXL
 K VAFZTE
 S VAFMAXL=245
 S VAFCHK=+$G(VAFCHK,0)
 I VAFCHK,'$$ISOTHD^DGOTHD(DFN) Q
 I '$G(DFN)!($G(VAFSTR)="") Q
 S VAFSTR=","_VAFSTR_","
 S IEN33=+$O(^DGOTH(33,"B",DFN,"")) I 'IEN33 Q
 ; Build ZTE segments
 S VAFSETID=1
 ; ZTE for pending request
 S DGOTHSTR=$$GETPEND^DGOTHUT1(DFN)
 I $P(DGOTHSTR,U)>0 D GETDATA("P",DGOTHSTR),MAKESEG S VAFSETID=VAFSETID+1
 ; ZTE for denied requests
 S IEN3303=0 F  S IEN3303=$O(^DGOTH(33,IEN33,3,IEN3303)) Q:'IEN3303  D
 .S DGOTHSTR=$$GETDEN^DGOTHUT1(IEN33,IEN3303)
 .I $P(DGOTHSTR,U)>0 D GETDATA("D",DGOTHSTR),MAKESEG S VAFSETID=VAFSETID+1
 .Q
 ; ZTE for approved requests
 S IEN3301=0 F  S IEN3301=$O(^DGOTH(33,IEN33,1,IEN3301)) Q:'IEN3301  D
 .S IEN3311=0 F  S IEN3311=$O(^DGOTH(33,IEN33,1,IEN3301,1,IEN3311)) Q:'IEN3311  D
 ..S DGOTHSTR=$$GETAUTH^DGOTHUT1(IEN33,IEN3301,IEN3311)
 ..I $P(DGOTHSTR,U)>0 D GETDATA("A",DGOTHSTR),MAKESEG S VAFSETID=VAFSETID+1
 ..Q
 .Q
 Q
 ;
GETDATA(DGTYPE,DGOTHSTR) ; Get information needed to build ZTE segment
 ; Input:
 ;   DGTYPE = request type: "P" = Pending, "D" = Denied, "A" = Approved
 ;   DGOTHSTR = "^" - delimited string containing data from file 33 to use
 ;
 ; Existence of the following variables is assumed
 ;   DFN - Pointer to Patient (#2) file
 ;   VAFSTR - Fields to extract (padded with commas)
 ;   VAFSETID - Value to use for Set ID (optional)
 ;   HL7 encoding characters (HLFS, HLENC, HLQ)
 ;
 ; Output: VAFHLZTE(SeqNum) = Value
 ;
 ; Notes: VAFHLZTE is initialized (KILLed) on entry
 ;
 K VAFHLZTE
 ; Set ID
 I VAFSTR[",1," S VAFHLZTE(1)=+$G(VAFSETID)
 ; Date request submitted
 I VAFSTR[",2," S VAFHLZTE(2)=$$HLDATE^HLFNC($P(DGOTHSTR,U,$S(DGTYPE="A":4,1:2)))
 ; Request creation timestamp
 I VAFSTR[",3," S VAFHLZTE(3)=$$HLDATE^HLFNC($P(DGOTHSTR,U,$S(DGTYPE="A":10,DGTYPE="D":7,1:6)))
 ; Authorization status
 I VAFSTR[",4," S VAFHLZTE(4)=DGTYPE
 ; Request entered/edited timestamp
 I VAFSTR[",5," S VAFHLZTE(5)=$$HLDATE^HLFNC($P(DGOTHSTR,U,$S(DGTYPE="A":7,DGTYPE="D":5,1:4)))
 ; Request entered by
 I VAFSTR[",6," S VAFHLZTE(6)=$$ENCHL7^DGPFHLUT($P(DGOTHSTR,U,$S(DGTYPE="A":6,DGTYPE="D":4,1:3)))
 ; Facility
 I VAFSTR[",7," S VAFHLZTE(7)=$P(DGOTHSTR,U,$S(DGTYPE="A":9,DGTYPE="D":6,1:5))
 ; 365 day period number
 I VAFSTR[",8," S VAFHLZTE(8)=$S(DGTYPE="A":$P(DGOTHSTR,U),1:"")
 ; 90 day period number
 I VAFSTR[",9," S VAFHLZTE(9)=$S(DGTYPE="A":$P(DGOTHSTR,U,2),1:"")
 ; Authorization date
 I VAFSTR[10 S VAFHLZTE(10)=$S(DGTYPE="A":$$HLDATE^HLFNC($P(DGOTHSTR,U,5)),1:"")
 ; Request authorized by
 I VAFSTR[11 S VAFHLZTE(11)=$S(DGTYPE="A":$$ENCHL7^DGPFHLUT($P(DGOTHSTR,U,8)),1:"")
 ; 90 day period start date
 I VAFSTR[12 S VAFHLZTE(12)=$S(DGTYPE="A":$$HLDATE^HLFNC($P(DGOTHSTR,U,3)),1:"")
 ; Authorization comment
 I VAFSTR[13 S VAFHLZTE(13)=$S(DGTYPE="D":$$ENCHL7^DGPFHLUT($P(DGOTHSTR,U,3)),1:"")
 Q
 ;
MAKESEG ; Create segment using obtained data
 ; Input: Existence of the following variables is assumed
 ;   VAFSETID = Number denoting Xth repetition of the ZTE segment
 ;   VAFMAXL = Maximum length of each node (defaults to 245)
 ;   VAFHLZTE(SeqNum) = Value
 ;   HL7 encoding characters (HLFS, HLECH)
 ;
 ; Output: VAFZTE(VAFSETID)   = ZTE segment (first VAFMAXL characters)
 ;         VAFZTE(VAFSETID,x) = Remaining portion of ZTE segment in VAFMAXL character chunks (if needed), beginning with a field separator
 ;
 ; Notes: VAFZTE(VAFSETID) is initialized (KILLed) on input. Fields will not be split across nodes in VAFZTE()
 ;
 N SEQ,SPILL,SPILLON,SPOT,LASTSEQ,VAFY
 K VAFZTE(VAFSETID)
 S VAFZTE(VAFSETID)="ZTE"
 S:'+$G(VAFMAXL) VAFMAXL=245
 S VAFY=$NA(VAFZTE(VAFSETID))
 S (SPILL,SPILLON)=0
 S LASTSEQ=+$O(VAFHLZTE(""),-1)
 F SEQ=1:1:LASTSEQ D
 .; Make sure maximum length won't be exceeded
 .I ($L(@VAFY)+$L($G(VAFHLZTE(SEQ)))+1)>VAFMAXL D
 ..; Max length exceeded - start putting data on next node
 ..S SPILL=SPILL+1
 ..S SPILLON=SEQ-1
 ..S VAFY=$NA(VAFZTE(VAFSETID,SPILL))
 .; Add to string
 .S SPOT=(SEQ+1)-SPILLON
 .S $P(@VAFY,HLFS,SPOT)=$G(VAFHLZTE(SEQ))
 Q
