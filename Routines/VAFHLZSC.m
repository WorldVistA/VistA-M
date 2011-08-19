VAFHLZSC ;ALB/ESD - Create generic HL7 ZSC Segment ; 06-MAY-1996
 ;;5.3;Registration;**94**;Aug 13, 1993
 ;
 ;  This function will create VA-specific ZSC segment(s) for a 
 ;  given outpatient encounter.  The ZSC segment is designed to transfer
 ;  service indicator (stop code) information pertaining to a patient 
 ;  visit.
 ;
EN(VAFENC,VAFSTR,VAFHLQ,VAFHLFS,VAFARRY) ; Entry point to return the HL7 ZSC segment
 ;
 ;  Input:   VAFENC - IEN of the Outpatient Encounter (#409.68) file.
 ;           VAFSTR - String of fields requested separated by commas.
 ;           VAFHLQ - Optional HL7 null variable. If not there, use 
 ;                    default HL7 variable.
 ;          VAFHLFS - Optional HL7 field separator. If not there, use 
 ;                    default HL7 variable.
 ;          VAFARRY - Optional user-supplied array name which will hold HL7 ZSC segments
 ;
 ; Output: Array of HL7 ZSC segments
 ;
 ;
 N I,VAFIDX,VAFNODE,VAFSCODE,VAFY
 S VAFARRY=$G(VAFARRY)
 ;
 ; - If VAFARRY not defined, use ^TMP("VAFHL",$J,"STOPCODE")
 S:(VAFARRY="") VAFARRY="^TMP(""VAFHL"",$J,""STOPCODE"")"
 ;
 ; - If VAFHLQ or VAFHLFS aren't passed in, use default HL7 variables
 S VAFHLQ=$S($D(VAFHLQ):VAFHLQ,1:$G(HLQ)),VAFHLFS=$S($D(VAFHLFS):VAFHLFS,1:$G(HLFS))
 I '$G(VAFENC)!($G(VAFSTR)']"") S @VAFARRY@(1,0)="ZSC"_VAFHLFS_1 G ENQ
 S VAFIDX=0,VAFSTR=","_VAFSTR_","
 ;
 ; - Get stop codes for encounter
 D SCODE^SCDXUTL0(VAFENC,"VAFSCODE")
 ;
 ; - Set stop code array to 0 if no stop codes to loop thru once
 I '$G(VAFSCODE(0)) S VAFSCODE(1)=0
 ;
ALL ; - All stop codes for encounter
 F I=0:0 S I=$O(VAFSCODE(I)) Q:I=""  D
 .;
 .S VAFNODE=$G(^DIC(40.7,+VAFSCODE(I),0))
 .S:($P(VAFNODE,"^",1)="") $P(VAFNODE,"^",1)=VAFHLQ
 .S:($P(VAFNODE,"^",2)="") $P(VAFNODE,"^",2)=VAFHLQ
 .;
 .; - build array of HL7 (ZSC) segments
 .D BUILD
 ;
ENQ Q
 ;
 ;
BUILD ; - Build array of HL7 (ZSC) segments
 S $P(VAFY,VAFHLFS,3)="",VAFIDX=VAFIDX+1
 ;
 ; - Sequential number (required field)
 S $P(VAFY,VAFHLFS,1)=VAFIDX
 ;
 ; - Build HL7 (ZSC) segment fields
 I VAFSTR[",2," S $P(VAFY,VAFHLFS,2)=$P(VAFNODE,"^",2) ; Stop Code
 I VAFSTR[",3," S $P(VAFY,VAFHLFS,3)=$P(VAFNODE,"^",1) ; Name
 ;
 ; - Set all stop codes into array
 S @VAFARRY@(VAFIDX,0)="ZSC"_VAFHLFS_$G(VAFY)
 Q
