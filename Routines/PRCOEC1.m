PRCOEC1 ;WISC/DJM/BGJ-IFCAP SEGMENTS BI,VE,ST,AC ;9/11/96  11:51
V ;;5.1;IFCAP;**7**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
BI(A,VAR1,VAR2) ;BILL TO INFORMATION SEGMENT
 N A12,IA,INV,SITE,ST
 S SITE=$G(^PRC(442,VAR1,23)) S:SITE]"" SITE=$P(SITE,U,7) S SITE=$S($G(SITE)]"":SITE,1:+$P(A,U))
 S A23=$G(^PRC(442,VAR1,23))
 Q:$P(A23,U,11)="P"
 S A12=$G(^PRC(442,VAR1,12)) S:A12="" VAR2="ERROR" W:A12="" !,"NP12-INVOICE ADDRESS pointer is missing." Q:A12=""
 S IA=$P(A12,U,6) S:$P(A,U,19)=2 IA=0,IA=$O(^PRC(411,SITE,4,IA))
 S:IA="" VAR2="ERROR" W:IA="" !,"NPIA-Invoice address missing."
 Q:IA=""  S INV=$G(^PRC(411,SITE,4,IA,0)) S:INV="" VAR2="ERROR" W:INV="" !,"NMIL-MAIL INVOICE LOCATION information in file 411 missing." Q:INV=""
 S:$P(INV,U,5)="" VAR2="ERROR" W:$P(INV,U,5)="" !,"NMIC-No mail invoice city in file 411." S:$P(INV,U,6)="" VAR2="ERROR" W:$P(INV,U,6)="" !,"NMIS-No state file pointer in file 411."
 S:$P(INV,U,7)="" VAR2="ERROR" W:$P(INV,U,7)="" !,"NMIZ-No mail invoice ZIP CODE entry in file 411."
 I $P(INV,U,6)>0 S ST=$G(^DIC(5,$P(INV,U,6),0)) S:ST="" VAR2="ERROR" W:ST="" !,"NST0-'STATE' record is missing in STATE file." Q:VAR2]""  S:$P(ST,U,2)="" VAR2="ERROR" W:$P(ST,U,2)="" "NSTA-Abbreviation missing in state file entry."
 Q
VE(A1,VAR2) ;VENDOR INFORMATION SEGMENT
 N EDI,ST,V,V2,V3,VEN,VID
 S VEN=$P(A1,U),V3=$G(^PRC(440,VEN,3)),V2=$G(^PRC(440,VEN,2)),V=$G(^PRC(440,VEN,0))
 S:V="" VAR2="ERROR" W:V="" "NV0-No vendor record found in vendor file." Q:V=""  I $P(V,U,7)'>0 S VAR2="ERROR" W !,"NSTP-No Vendor Address pointer to the State file."
 S EDI=$P(V3,U,2),VID=$P(V3,U,3) I EDI="Y",VID="" W !,"NVID-Missing a vendor ID number for an EDI vendor." S VAR2="ERROR"
 I $P(V,U,7)>0 S ST=$G(^DIC(5,$P(V,U,7),0)) S:ST="" VAR2="ERROR" W:ST="" !,"NST0-No state file record." Q:ST=""  S:$P(ST,U,2)="" VAR2="ERROR" W:$P(ST,U,2)="" !,"NSTA-No abbreviation in state file."
 I $P(V2,U,3)="" S VAR2="ERROR" W !,"NBT-No Vendor Business Type."
 Q
 ;
ST(A,A1,VAR1,VAR2) ;SHIP TO INFORMATION SEGMENT
 N DDP,DDP0,EDI,FT,FT0,MP,NM,RL,SITE,SP0,ST,STS,VEN
 S MP=$P(A,U,2),DDP=$P(A1,U,12) G:MP=4&(DDP]"") STD
 S VEN=$P(A1,U),V3=$G(^PRC(440,VEN,3)) S EDI=$P(V3,U,2)
 S SITE1=$G(^PRC(442,VAR1,23)) S:SITE1]"" SITE=$P(SITE1,U,7) S SITE=$S($G(SITE)]"":SITE,1:+$P(A,U))
 S:SITE="" VAR2="ERROR" W:SITE="" !,"NSIT-No site entry in file 442." Q:SITE=""
 I $P(SITE1,U,11)="P" Q
 S ST=$P(A1,U,3) S:ST="" VAR2="ERROR"
 W:ST="" !,"NSTL-No ship to pointer to entry in file 411." Q:ST=""  S RL=$G(^PRC(411,SITE,1,ST,0)) S:RL="" VAR2="ERROR" W:RL="" !,"NRL-No receiving location record in file 411." Q:RL=""
 I $P(RL,U,6)'>0 S VAR2="ERROR" W !,"NSTT-No State file pointer in Receiving Location in file 411."
 S STS=$P(RL,U,9) I EDI="Y",STS="",SITE'=101 S VAR2="ERROR" W !,"NSTS-There is no ship to suffix for receiving location for",!,"this EDI P.O." Q
 S SP0=$G(^PRC(411,SITE,0)) S:SP0="" VAR2="ERROR" W:SP0="" !,"NSP0^"_SITE_"-No SITE information in file 411." Q:SP0=""
 S FT=$P(SP0,U,7) S:FT="" VAR2="ERROR" W:FT="" !,"NFT^"_SITE_"-No facility type pointer for SITE in file 411." Q:FT=""
 S FT0=$G(^PRC(411.2,FT,0)) S:FT0="" VAR2="ERROR" W:FT0="" !,"NFT0^"_SITE_"-No entry in file 411.2 for facility type pointer from file 411." Q:FT0=""
 I $P(RL,U,6)>0 S ST=$G(^DIC(5,$P(RL,U,6),0)) S:ST="" VAR2="ERROR" W:ST="" !,"NST0-No record in state file." Q:ST=""  S:$P(ST,U,2)="" VAR2="ERROR" W:$P(ST,U,2)="" !,"NSTA-Abbreviation missing in state file entry."
 Q
STD S NM=$G(^DPT(DDP,0)) S:NM="" VAR2="ERROR" W:NM="" !,"NOPT-No patient file entry for direct delivery patient pointer." Q:NM=""  S NM=$E($P(NM,U),1,30),NM=$P(NM,",",2)_" "_$P(NM,",")
 S DDP0=$G(^PRC(440.2,DDP,0)) S:DDP0="" VAR2="ERROR" W:DDP0="" !,"NDP0-No record for direct delivery patient pointer." Q:DDP0=""
 I $P(DDP0,U,6)'>0 S VAR2="ERROR" W !,"NSTDP-No State file pointer in Direct Delivery Address."
 I $P(DDP0,U,6)>0 S ST=$G(^DIC(5,$P(DDP0,U,6),0)) S:ST="" VAR2="ERROR" W:ST="" !,"NST0-No record in the state file." Q:ST=""
 S:$P(ST,U,2)="" VAR2="ERROR" W:$P(ST,U,2)="" !,"NSTA-Abbreviation missing in state file entry." Q
AC(A1,VAR1,VAR2) ;ACCOUNTING INFORMATION SEGMENT
 N Q
 S A23=$G(^PRC(442,VAR1,23))
 I '$G(PRCHPHAM),$P(A23,U,11)'="P",+A1>0 I $D(^PRC(440,+A1,3)),$P(^(3),U,2)="Y" S Q=$P($G(^PRC(442,VAR1,5,0)),U,4) S:Q'>0 VAR2="ERROR" W:Q'>0 !,"NPPT-No prompt payment terms entered in P.O." Q:VAR2]""
 Q
