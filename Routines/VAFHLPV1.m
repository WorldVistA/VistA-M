VAFHLPV1 ;ALB/CM/ESD HL7 PV1 SEGMENT BUILDING ;06/08/00
 ;;5.3;Registration;**94,106,151,298,617**;Aug 13, 1993
 ;
 ;This routine will build an HL7 PV1 segment for an inpatient or
 ;outpatient event depending on the entry point used.
 ;Use IN for inpatient
 ;Use OUT for outpatient
 ;
IN(DFN,VAFHDT,VAFSTR,IEN,PIVOT,SETID,VAFDIAG) ;
 N RESULT
 S RESULT=$$EN^VAFHAPV1(DFN,VAFHDT,VAFSTR,IEN,PIVOT,SETID,.VAFDIAG)
 Q $G(RESULT)
 ;
OUT(DFN,EVT,EVDTS,VPTR,STRP,NUMP) ;
 ;DFN - Patient File
 ;EVT - event number from pivot file
 ;EVDTS - event date/time in FileMan format
 ;VPTR - variable pointer
 ;STRP - string of fields (if null - required fields, if "A" - supported
 ;fields, or string of fields seperated by commas")
 ;NUMP - ID # (optional)
 ;
 N ERR
 I '$D(NUMP) S NUMP=1
 S ERR=$$OPV1^VAFHCPV($G(DFN),$G(EVT),$G(EVDTS),$G(VPTR),$G(STRP),NUMP)
 Q ERR
KVAR ;
 K VAFHLPV1
 Q
 ;
EN(VAFENC,VAFDENC,VAFSTR,VAFNUM,VAFHLQ,VAFHLFS) ;
 ; Entry point for Ambulatory Care Database Project
 ;
 ; Entry point to return the HL7 PV1 (Patient Visit) segment
 ;
 ;  Input:    VAFENC - Outpatient Encounter IEN (pointer to Outpatient
 ;                     Encounter file #409.68)
 ;                    
 ;           VAFDENC - Deleted Outpatient Encounter IEN (pointer to
 ;                     Deleted Outpatient Encounter file #409.74)
 ;
 ;            VAFSTR - String of fields requested separated by commas
 ;
 ;            VAFNUM - Set ID (sequential number - default=1)
 ;
 ;            VAFHLQ - Optional HL7 null variable.  If not there, use 
 ;                     default HL7 variable.
 ;
 ;           VAFHLFS - Optional HL7 field separator.  If not there, use 
 ;                     default HL7 variable.
 ;
 ; Output:   String containing desired components of the PV1 segment
 ;
 ; NOTE:   Data for the PV1 segment will be retrieved from either the 
 ;         Outpatient Encounter file (#409.68) or Deleted Outpatient 
 ;         Encounter (#409.74) based on the pointer parameter passed in.
 ;
 ;06/08/2000 ACS - AMBCARE PV1 CHANGES:
 ; 1. SET UP HL7 DEFAULT VARIABLES AT BEGINNING OF SUBROUTINE.
 ; 2. VALIDATE EXISTENCE OF AMBCARE ENCOUNTER.
 ; 3. ALWAYS RETURN PATIENT CLASS IN SEGMENT.
 ;
 ;
 N VAFAPTYP,VAFCLIN,VAFDAT,VAFDFN,VAFFLG,VAFNODE,VAFNODE1,VAFORIG,VAFPTCL,VAFY,X,VAINVENC,VAFPSTAT,VAFPIN
 ;
 ; - If VAFHLQ or VAFHLFS aren't passed in, use default HL7 variables.
 S VAFHLQ=$S($D(VAFHLQ):VAFHLQ,1:$G(HLQ)),VAFHLFS=$S($D(VAFHLFS):VAFHLFS,1:$G(HLFS))
 ;
 ;- Sequential Number
 S $P(VAFY,VAFHLFS,1)=$S($G(VAFNUM):VAFNUM,1:1)
 ;
 S VAFPTCL="O" ; Patient Class = Outpatient
 ;
 ;- Set patient class in segment
 S $P(VAFY,VAFHLFS,2)=VAFPTCL
 ;
 ;- If encounter or variable string missing, pass back incomplete segment
 I ($G(VAFENC)=""&($G(VAFDENC)=""))!($G(VAFSTR)="") G ENQ
 ;
 ; - If regular encounter doesn't exist, pass back incomplete segment
 I $G(VAFENC) D  G:$G(VAINVENC) ENQ
 . I '$D(^SCE($G(VAFENC))) S VAINVENC=1
 ;
 ; - If deleted encounter doesn't exist, pass back incomplete segment
 I $G(VAFDENC) D  G:$G(VAINVENC) ENQ
 . I '$D(^SD(409.74,$G(VAFDENC))) S VAINVENC=1
 ;
 S VAFENC=+$G(VAFENC),VAFDENC=+$G(VAFDENC)
 S $P(VAFY,VAFHLFS,50)="",VAFSTR=","_VAFSTR_","
 ;
 ; - Set flag to indicate whether Outpatient Encounter ("E") or Deleted 
 ;   Outpatient Encounter ("D").
 S VAFFLG=$S(VAFENC:"E",1:"D")
 ;
 I VAFFLG="E" S VAFNODE=$$SCE^DGSDU(VAFENC)
 ;
 ; - VAFNODE1 = old encounter zero node for deleted encounter
 I VAFFLG="D" D
 . S VAFNODE=$G(^SD(409.74,VAFDENC,0))
 . S VAFNODE1=$G(^SD(409.74,VAFDENC,1))
 ;
 ;- Reset patient class/status if Inpatient
 S VAFPSTAT=$$INPATENC^SCDXUTL($S(VAFFLG="E":VAFENC,1:VAFDENC),$S(VAFFLG="E":1,1:2))
 I VAFPSTAT S VAFPTCL="I" S $P(VAFY,VAFHLFS,2)=VAFPTCL
 ;
 ;- Purpose of Visit
 I VAFSTR[",4," D
 . S VAFDAT=$P(VAFNODE,"^"),VAFDFN=$P(VAFNODE,"^",2)
 . S VAFCLIN=$S(VAFFLG="E":$P(VAFNODE,"^",4),1:$P(VAFNODE1,"^",4))
 . S VAFAPTYP=$S(VAFFLG="E":$P(VAFNODE,"^",10),1:$P(VAFNODE1,"^",10))
 . S X=$$POV^SCDXUTL0(VAFDFN,VAFDAT,VAFCLIN,VAFAPTYP)
 . I X="" D
 .. S VAFORIG=$S(VAFFLG="E":$P(VAFNODE,"^",8),1:$P(VAFNODE1,"^",8))
 .. S X=$S(VAFORIG=2:"04"_$S($L(VAFAPTYP)=1:"0"_VAFAPTYP,1:VAFAPTYP),VAFORIG=3:"02"_$S($L(VAFAPTYP)=1:"0"_VAFAPTYP,1:VAFAPTYP),1:"")
 . S $P(VAFY,VAFHLFS,4)=$S(X]"":X,1:VAFHLQ)
 ;
 ;- Location of Visit
 I VAFSTR[",14," D
 . S VAFCLIN=$S(VAFFLG="E":$P(VAFNODE,"^",4),1:$P(VAFNODE1,"^",4))
 . S X=$P($G(^SC(+VAFCLIN,0)),"^",19),X=$S(X="Y":1,X="N":6,1:"")
 . I X="" S VAFORIG=$S(VAFFLG="E":$P(VAFNODE,"^",8),1:$P(VAFNODE1,"^",8)),X=$S(VAFORIG=2!(VAFORIG=3):1,1:"")
 . S $P(VAFY,VAFHLFS,14)=$S(X]"":X,1:VAFHLQ)
 ;
 ;- Outpatient Encounter IEN (not passed for deleted outpat encounter)
 I VAFSTR[",19," S $P(VAFY,VAFHLFS,19)=$S(VAFFLG="E":VAFENC,1:VAFHLQ)
 ;
 ;- Facility Number and Suffix
 I VAFSTR[",39," D
 . ; add division parameter to $$SITE^VASITE call ; abr
 . S X=$S(VAFFLG="E":$$SITE^VASITE($P(VAFNODE,"^"),$P(VAFNODE,"^",11)),1:$$SITE^VASITE($P(VAFNODE1,"^"),$P(VAFNODE1,"^",11)))
 . S X=$P(X,"^",3)
 . S $P(VAFY,VAFHLFS,39)=$S(X]"":X,1:VAFHLQ)
 ;
 ;- Encounter Date/Time for Outpatients & Admission Date for Inpatients
 I VAFSTR[",44," D
 . N DFN,VAIN
 . S VAFPIN=0
 . I VAFPSTAT S VAFPIN=$S(VAFFLG="E":$P(VAFNODE,"^",2),1:$P(VAFNODE1,"^",2)) I VAFPIN S DFN=VAFPIN D INP^VADPT S X=$P(VAIN(7),"^") I 'X S VAFPIN=0
 . I 'VAFPIN S X=$S(VAFFLG="E":$P(VAFNODE,"^"),1:$P(VAFNODE1,"^"))
 . S X=$$HLDATE^HLFNC(X)
 . S $P(VAFY,VAFHLFS,44)=$S(X]"":X,1:VAFHLQ)
 ;
 ;- Unique Identifier (PCE)
 I VAFSTR[",50," D
 . S X=$S(VAFFLG="E":$P(VAFNODE,"^",20),1:$P(VAFNODE1,"^",20))
 . S $P(VAFY,VAFHLFS,50)=$S(X]"":X,1:VAFHLQ)
 ;
ENQ Q "PV1"_VAFHLFS_$G(VAFY)
