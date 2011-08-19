VAFHLZM2 ;ALB/KCL - Create HL7 Military History segment (ZMH) Cont ; 1/26/06
 ;;5.3;Registration;**673**;Aug 13, 1993
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
