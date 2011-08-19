VAFHLZCL ;ALB/ESD - Create generic HL7 ZCL Segment ; 02-MAY-1996
 ;;5.3;Registration;**94,103,102,397,423**;Aug 13, 1993
 ;
 ;  This function will create VA-specific ZCL segment(s) for a 
 ;  given outpatient encounter.  The ZCL segment is designed to transfer
 ;  generic information about outpatient classifications.
 ;
 ;
EN(DFN,VAFENC,VAFSTR,VAFHLQ,VAFHLFS,VAFARRY) ; Entry point to return the HL7 ZCL segment
 ;
 ;  Input:      DFN - IEN of the Patient (#2) file
 ;           VAFENC - IEN of the Outpatient Encounter (#409.68) file
 ;           VAFSTR - String of fields requested separated by commas
 ;           VAFHLQ - Optional HL7 null variable. If not there, use 
 ;                    default HL7 variable
 ;          VAFHLFS - Optional HL7 field separator. If not there, use 
 ;                    default HL7 variable
 ;          VAFARRY - Optional user-supplied array name which will hold ZCL segments
 ;
 ; Output:  Array of HL7 ZCL segments
 ;
 ;
 N I,VAFCLASS,VAFIDX,VAFY
 S VAFARRY=$G(VAFARRY)
 ;
 ; - If VAFARRY not defined, use ^TMP("VAFHL",$J,"CLASS")
 S:(VAFARRY="") VAFARRY="^TMP(""VAFHL"",$J,""CLASS"")"
 ;
 ; - If VAFHLQ or VAFHLFS aren't passed in, use default HL7 variables
 S VAFHLQ=$S($D(VAFHLQ):VAFHLQ,1:$G(HLQ)),VAFHLFS=$S($D(VAFHLFS):VAFHLFS,1:$G(HLFS))
 I '$G(DFN)!('$G(VAFENC))!($G(VAFSTR)']"") S @VAFARRY@(1,0)="ZCL"_VAFHLFS_1 G ENQ
 S VAFIDX=0,VAFSTR=","_VAFSTR_","
 ;
ALL ; - All active outpatient classifications for encounter
 S VAFCLASS=$$CHKCLASS^SCDXUTL0(DFN,VAFENC)
 S VAFCLASS=$G(VAFCLASS)
 I '$D(VAFCLASS) S @VAFARRY@(1,0)="ZCL"_VAFHLFS_1 G ENQ
 ;
 ; - Build array of HL7 (ZCL) segments
 F I=1:1:$L(VAFCLASS,"^") D BUILD
 ;
ENQ ;
 Q
 ;
 ;
BUILD ; - Build for each classification question
 S $P(VAFY,VAFHLFS,3)="",VAFIDX=VAFIDX+1
 ;
 ; - Sequential number (required field)
 S $P(VAFY,VAFHLFS,1)=VAFIDX
 ;
 ; - Classification type (1=AO,2=IR,3=SC,4=EC,5=MST,6=HNC)
 I VAFSTR[",2," S $P(VAFY,VAFHLFS,2)=$S($G(I)]"":I,1:VAFHLQ) ; Outpatient Classification Type
 ;
 ; - Value (1=Yes, 0=No, ""=N/A)
 I VAFSTR[",3," S $P(VAFY,VAFHLFS,3)=$S($P(VAFCLASS,"^",I)]"":$P(VAFCLASS,"^",I),1:VAFHLQ) ; Value
 ;
 ; - If occasion of service, stuff 0 (N) if class value = Y
 I (VAFSTR[",3,"),($$CHKOCC^SCMSVDG1(VAFENC)=1),($P(VAFY,VAFHLFS,3)=1) S $P(VAFY,VAFHLFS,3)=0
 ;
 ; - Set all outpatient classifications into array
 S @VAFARRY@(VAFIDX,0)="ZCL"_VAFHLFS_$G(VAFY)
 Q
