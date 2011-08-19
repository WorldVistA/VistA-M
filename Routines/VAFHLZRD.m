VAFHLZRD ;ALB/KCL,PJH - CREATE HL7 RATED DISABILITIES (ZRD) SEGMENTS ; 5/31/07 2:59pm
 ;;5.3;Registration;**122,144,754**;Aug 13,1993;Build 46
 ;
 ;
 ; This generic function creates HL7 VA-Specific Rated Disabilities
 ; (ZRD) segments for a patient.
 ;
EN(DFN,VAFSTR,VAFHLQ,VAFHLFS,VAFARRY) ;--
 ; Entry point to return HL7 Rated Disabilities (ZRD) segments.
 ;
 ;  Input:
 ;        DFN - internal entry number of Patient (#2) file
 ;     VAFSTR - (optional) string of fields requested, separated
 ;              by commas. If not passed return all data fields.
 ;     VAFHLQ - (optional) HL7 null variable.
 ;     VAFHLS - (optional) HL7 field separator.
 ;    VAFARRY - (optional) user-supplied array name which will
 ;              hold HL7 ZRD segments.  Otherwise, ^TMP("VAFZRD",$J
 ;              will be used.
 ;
 ; Output:
 ;    Array containing the HL7 ZRD segments.
 ;
 N VAFINDX,VAFSUB,VAFNODE,VAFY,X
 S VAFARRY=$G(VAFARRY)
 ;
 ; if VAFHLQ or VAFHLFS not passed, use default HL7 variables
 S VAFHLQ=$S($D(VAFHLQ):VAFHLQ,1:$G(HLQ)),VAFHLFS=$S($D(VAFHLFS):VAFHLFS,1:$G(HLFS))
 ;
 ; if VAFARRY not defined, use ^TMP("VAFZRD",$J)
 S:(VAFARRY="") VAFARRY="^TMP(""VAFZRD"",$J)"
 ;
 ; if DFN not passed, exit
 I '$G(DFN) S @VAFARRY@(1,0)="ZRD"_VAFHLFS_1 G ENQ
 ;
 ; if VAFSTR not passed, return all data fields
 I $G(VAFSTR)']"" S VAFSTR="1,2,3,4,12,13,14"
 S (VAFINDX,VAFSUB)=0,VAFSTR=","_VAFSTR_","
 ;
 ; get all rated disabilities for patient
 F  S VAFSUB=$O(^DPT(DFN,.372,VAFSUB)) Q:'VAFSUB  D
 .;
 .; - get rated disabilities node
 .S VAFNODE=$G(^DPT(DFN,.372,+VAFSUB,0))
 .;
 .; - build array of ZRD segments
 .D BUILD
 ;
 ; if no rated disabilities, build ZRD
 I 'VAFINDX D
 .S @VAFARRY@(1,0)="ZRD"_VAFHLFS_1_VAFHLFS_VAFHLFS_VAFHLFS
 ;
ENQ Q
 ;
 ;
BUILD ; Build array of ZRD segments
 N DCNODE ;0 node of Disability Condition
 N DXCODE
 N NAME
 ;
 ;if the Rated Disability node doesn't point to a Disability Condition,
 ;then the data is meaningless and should not be sent
 Q:'$P(VAFNODE,"^")
 S DCNODE=$G(^DIC(31,$P(VAFNODE,"^"),0))
 S DXCODE=$P(DCNODE,"^",3)
 Q:DXCODE=""
 S NAME=$P(DCNODE,"^",1)
 ;
 S VAFINDX=VAFINDX+1,$P(VAFY,"^",4)=""
 S $P(VAFY,VAFHLFS,1)=VAFINDX ; Set ID
 I VAFSTR[",2," S $P(VAFY,VAFHLFS,2)=DXCODE_$E($G(HLECH))_NAME ;Disabilty Condition
 I VAFSTR[",3," S $P(VAFY,VAFHLFS,3)=$S($P(VAFNODE,"^",2)]"":$P(VAFNODE,"^",2),1:VAFHLQ) ; Disability %
 I VAFSTR[",4," S $P(VAFY,VAFHLFS,4)=$S($P(VAFNODE,"^",3)]"":$P(VAFNODE,"^",3),1:VAFHLQ) ; Service Connected?
 ;
 ; *** PJH - DG*5.3*754 data fields added ***
 I VAFSTR[",12," S $P(VAFY,VAFHLFS,12)=$S($P(VAFNODE,"^",4)]"":$P(VAFNODE,"^",4),1:VAFHLQ) ; Extremity
 I VAFSTR[",13," S $P(VAFY,VAFHLFS,13)=$S($P(VAFNODE,"^",5)]"":$$HLDATE^HLFNC($P(VAFNODE,"^",5)),1:VAFHLQ) ; Original Effective Date
 I VAFSTR[",14," S $P(VAFY,VAFHLFS,14)=$S($P(VAFNODE,"^",6)]"":$$HLDATE^HLFNC($P(VAFNODE,"^",6)),1:VAFHLQ) ; Current Effective Date
 ;
 ; set segment into array
 S @VAFARRY@(VAFINDX,0)="ZRD"_VAFHLFS_$G(VAFY)
 Q
