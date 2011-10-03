VAFHLPR1 ;ALB/ESD - Create generic HL7 PR1 Segment ;4/4/00
 ;;5.3;Registration;**94,123,160,215,243,606**;Aug 13, 1993
 ;06/22/99 ACS - Added CPT modifier API calls and added CPT modifier to the
 ;PR1 segment (sequence 16)
 ;
 ;  This function will create VA-specific PR1 segment(s) for a 
 ;  given outpatient encounter. The PR1 segment is designed to transfer
 ;  information relative to various types of procedures performed during
 ;  a patient visit.
 ;
EN(VAFENC,VAFSTR,VAFHLQ,VAFHLFS,VAFHLECH,VAFARRY) ; Entry point for Ambulatory Care Database Project
 ; - Entry point to return the HL7 PR1 segment
 ;
 ;  Input:   VAFENC - IEN of the Outpatient Encounter (#409.68) file
 ;           VAFSTR - String of fields requested separated by commas
 ;           VAFHLQ - Optional HL7 null variable. If not there, use 
 ;                    default HL7 variable
 ;          VAFHLFS - Optional HL7 field separator. If not there, use 
 ;                    default HL7 variable
 ;         VAFHLECH - HL7 variable containing encoding characters
 ;          VAFARRY - Optional user-supplied array name which will hold PR1 segments
 ;
 ; Output: Array of HL7 PR1 segments
 ;
 ;
 N I,J,VAFCPT,VAFIDX,VAFPR,VAFPROC,VAFPRTYP,VAFY,X,PTRVCPT,PROCCNT,PROCLOOP,ICPTVDT
 S (J,VAFIDX)=0
 S VAFARRY=$G(VAFARRY),ICPTVDT=$$SCE^DGSDU(VAFENC,1,0)
 ;
 ; - Variable ICPTVDT gets correct CPT/Modifier descriptor for event date
 ;
 ; - If VAFARRY not defined, use ^TMP("VAFHL",$J,"PROCEDURE")
 S:(VAFARRY="") VAFARRY="^TMP(""VAFHL"",$J,""PROCEDURE"")"
 ;
 ; - If VAFHLQ or VAFHLFS aren't passed in, use default HL7 variables
 S VAFHLQ=$S($D(VAFHLQ):VAFHLQ,1:$G(HLQ)),VAFHLFS=$S($D(VAFHLFS):VAFHLFS,1:$G(HLFS))
 I '$G(VAFENC)!($G(VAFSTR)']"") S @VAFARRY@(1,J)="PR1"_VAFHLFS_1 G ENQ
 S VAFSTR=","_VAFSTR_","
 ;
 ; - Get procedures for encounter
 D GETCPT^SDOE(VAFENC,"VAFPROC")
 ;
 ; - Set procedure array to 0 if no procedures to loop thru once
 I '$G(VAFPROC) S VAFPROC(1)=0
 ;
ALL ; - All procedures for encounter
 S PTRVCPT=0
 F  S PTRVCPT=+$O(VAFPROC(PTRVCPT)) Q:('PTRVCPT)  D
 .;S VAFPR=$G(^ICPT(+$G(VAFPROC(PTRVCPT)),0))
 .N CPTINFO
 .S CPTINFO=$$CPT^ICPTCOD(+$G(VAFPROC(PTRVCPT)),,1)
 .Q:CPTINFO'>0
 .S VAFPR=$P(CPTINFO,"^",2,99)
 .S:($P(VAFPR,"^",1)="") $P(VAFPR,"^",1)=VAFHLQ
 .S:($P(VAFPR,"^",2)="") $P(VAFPR,"^",2)=VAFHLQ
 .;
 .; - Build array of HL7 (PR1) segments
 .;   Repeated procedures get individual segment
 .S PROCCNT=+$P($G(VAFPROC(PTRVCPT)),"^",16)
 .S:('PROCCNT) PROCCNT=1
 .F PROCLOOP=1:1:PROCCNT D BUILD
 ;
ENQ Q
 ;
 ;
BUILD ; - Build array of HL7 (PR1) segments
 S J=0,VAFIDX=VAFIDX+1,VAFY=""
 S VAFCPT="C4" ; Procedure Coding Method = C4 (CPT-4)
 ;
 ; - Build HL7 (PR1) segment fields
 ;
 ; - Sequential number (required field)
 S $P(VAFY,VAFHLFS,1)=VAFIDX
 ;
 I VAFSTR[",2," S $P(VAFY,VAFHLFS,2)=$S($G(VAFCPT)]"":VAFCPT,1:VAFHLQ) ; Procedure Coding Method = CPT-4
 I (VAFSTR[",3,") D
 .;Procedure Code
 .S X=$P(VAFPR,"^",1)
 .;Procedure Description
 .S $P(X,$E(VAFHLECH,1),2)=$P(VAFPR,"^",2)
 .;Procedure Coding Method
 .S $P(X,$E(VAFHLECH,1),3)=VAFCPT
 .;Add to segment
 .S $P(VAFY,VAFHLFS,3)=X
 I VAFSTR[",4," S $P(VAFY,VAFHLFS,4)=$P(VAFPR,"^",2) ; Procedure Description
 ;
 ;  *** Add CPT modifiers to sequence 16 ***
 ;  VAFY    = PR1 segment
 ;  MAXLEN  = maximum length of the segment
 ;  WRAPCNT = continuation segment count (currently 0)
 ;  FSFLAG  = field separator flag: 1="^", 0="|"
 ;  MODIND  = indicates if a modifier has been added to the segment
 ;
 N MAXLEN,WRAPCNT,FSFLAG,MODIND
 S MAXLEN=245,WRAPCNT=0,FSFLAG=1,MODIND=0
 ;
 ;- set up VAFY to have 15 sequences, then concatenate "PR1"
 ;  onto front of segment for a total of 16 sequences
 S $P(VAFY,VAFHLFS,15)=""
 S VAFY="PR1"_VAFHLFS_VAFY
 ;
 ;check if modifiers are requested
 I VAFSTR'[",16," G NOMODS
 ;
 ;- spin through CPT array VAFPROC and retrieve modifiers
 ;- set MODIND flag to 1 if modifiers found
 N PTR,MODPTR,MODINFO,MODCODE,MODTEXT,MODMETH,MODSEQ,SEGLEN
 S PTR=0
 F  S PTR=+$O(VAFPROC(PTRVCPT,1,PTR)) Q:'PTR  D
 . S MODPTR=$G(VAFPROC(PTRVCPT,1,PTR,0))
 . Q:'MODPTR
 . S MODIND=1
 . ;
 . ;- get modifier and coding method
 . S MODINFO=$$MOD^ICPTMOD(MODPTR,"I",,1)
 . Q:MODINFO'>0
 . S MODCODE=$P(MODINFO,"^",2)
 . S MODTEXT=""
 . S MODMETH=$P(MODINFO,"^",5)
 . ;
 . ;- get correct field separator and build sequence
 . S MODSEQ=$S(FSFLAG:VAFHLFS,1:$E(VAFHLECH,2))_MODCODE
 . S MODSEQ=MODSEQ_$E(VAFHLECH,1)_MODTEXT
 . S MODSEQ=MODSEQ_$E(VAFHLECH,1)_MODMETH
 . S FSFLAG=0
 . ;
 . ;- check length of VAFY segment
 . S SEGLEN=$L(VAFY)+$L(MODSEQ)
 . I SEGLEN>MAXLEN G DONE
 . S VAFY=VAFY_MODSEQ
 . Q
 ;
 ;- --Done spinning through the modifiers--
 ;- if modifiers were added to the segment, write out the
 ;  last modifier
DONE S:MODIND @VAFARRY@(VAFIDX,WRAPCNT)=VAFY
 ;
 ;- if no modifiers were added to the segment, write segment with
 ;  field separator as an empty place holder
NOMODS S:'MODIND @VAFARRY@(VAFIDX,WRAPCNT)=VAFY_VAFHLFS
 Q
