VAFHLZM2 ;ALB/KCL,PJH,LBD - Create HL7 Military History segment (ZMH) Cont ; 6/8/09 4:42pm
 ;;5.3;Registration;**673,797**;Aug 13, 1993;Build 24
 ;
 ;--------------------------------------------------------------------------------
 ;This routine creates HL7 VA-specific Military History ("ZMH") segments. It is a
 ;continuation of VAFHLZM1 and uses variables from both VAFHLZMH and VAFHLZM1.
 ;--------------------------------------------------------------------------------
 ;
 ;no direct entry
 Q
 ;
 ;
OEIF ;Build Operation Enduring/Iraqi Freedom segments
 ;
 N VAFDATA,VAFFROM,VAFIDX,VAFNODE,VAFSITE,VAFTO,VAFTYPE
 ;
 ;need to build segment even if no data in OEIF array 
 S $P(VAFY,VAFHLS,2)="OEIF"
 I VAFSTR[",3," S $P(VAFY,VAFHLS,3)=VAFHLQ_$E(VAFHLC)_VAFHLQ
 I VAFSTR[",4," S $P(VAFY,VAFHLS,4)=VAFHLQ_$E(VAFHLC)_VAFHLQ
 I VAFSTR[",5," S $P(VAFY,VAFHLS,5)=VAFHLQ
 Q:'$D(VAFOPS)
 ;
 ;if data in OEIF array, build segment for each episode
 S (VAFNODE,VAFIDX)=0
 F  S VAFNODE=$O(VAFOPS(VAFNODE)) Q:'$G(VAFNODE)  D
 .;
 .S VAFDATA=$G(VAFOPS(VAFNODE))
 .;
 .I VAFSTR[",3," D
 ..S VAFTYPE=$$EXTERNAL^DILFD(2.3215,.01,"F",$P(VAFDATA,U,1)) I VAFTYPE']"" S VAFTYPE=VAFHLQ
 ..S VAFSITE=$$STATION^VAFHLFNC($P(VAFDATA,U,6)) I VAFSITE="" S VAFSITE=VAFHLQ
 ..S $P(VAFY,VAFHLS,3)=VAFTYPE_$E(VAFHLC)_VAFSITE
 .;
 .I VAFSTR[",4," D
 ..S VAFFROM=$P(VAFDATA,U,2) S VAFFROM=$S(VAFFROM:$$HLDATE^HLFNC(VAFFROM),1:VAFHLQ)
 ..S VAFTO=$P(VAFDATA,U,3) S VAFTO=$S(VAFTO:$$HLDATE^HLFNC(VAFTO),1:VAFHLQ)
 ..S $P(VAFY,VAFHLS,4)=VAFFROM_$E(VAFHLC)_VAFTO
 .;
 .I VAFSTR[",5," D
 ..S $P(VAFY,VAFHLS,5)=VAFHLQ
 .;
 .;put segment into array
 .S VAFIDX=VAFIDX+1
 .S VAFY(VAFIDX)=$G(VAFY)
 ;
 Q
 ;
 ;
NOSEG ;
 Q
 ;
MSDS ;Returns all service episodes from ESR sourced data
 ;
 N BRANCH,COMP,DA,DATE,DONE,DTYP,EDATA,EDATE,NUM,SDATE,SERVNO,VAFIDX
 S DATE="",(NUM,VAFIDX)=0
 ;Scan back through entry dates for service episodes
 F  S DATE=$O(^DPT(DFN,.3216,"B",DATE),-1) Q:'DATE  D
 .S DA=$O(^DPT(DFN,.3216,"B",DATE,0)) Q:'DA
 .S NUM=NUM+1
 .S EDATA=$G(^DPT(DFN,.3216,DA,0)) Q:EDATA=""
 .S SDATE=$P(EDATA,U,2),EDATE=DATE
 .S BRANCH=$P(EDATA,U,3),COMP=$P(EDATA,U,4)
 .S SERVNO=$P(EDATA,U,5),DTYP=$P(EDATA,U,6)
 .S $P(VAFY,VAFHLS,2)=$S(NUM=1:"SL",NUM=2:"SNL",NUM=3:"SNNL",1:"MSD")
 .I VAFSTR[",3," D
 ..S BRANCH=$S(BRANCH:$P($G(^DIC(23,BRANCH,0)),U),1:VAFHLQ)
 ..I SERVNO="" S SERVNO=VAFHLQ
 ..S DTYP=$S(DTYP:$P($G(^DIC(25,DTYP,0)),U),1:VAFHLQ)
 ..; Service branch~Service number~Service discharge type
 ..S $P(VAFY,VAFHLS,3)=BRANCH_$E(VAFHLC)_SERVNO_$E(VAFHLC)_DTYP
 .I VAFSTR[",4," D
 ..S EDATE=$S(EDATE:$$HLDATE^HLFNC(EDATE),1:VAFHLQ)
 ..S SDATE=$S(SDATE:$$HLDATE^HLFNC(SDATE),1:VAFHLQ)
 ..; Service entry date~Service separation date
 ..S $P(VAFY,VAFHLS,4)=EDATE_$E(VAFHLC)_SDATE
 .I VAFSTR[",5," D
 ..; Service Component [L]
 ..I COMP="" S COMP=VAFHLQ
 ..S $P(VAFY,VAFHLS,5)=COMP
 .;
 .;put segment into array
 .S VAFIDX=VAFIDX+1
 .S VAFY(VAFIDX)=$G(VAFY)
 Q
