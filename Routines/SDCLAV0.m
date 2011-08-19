SDCLAV0 ;ALB/LDB - OUTPUT PATTERNS (cont.) ; 05 Mar 99 11:31 AM
 ;;5.3;Scheduling;**184,439,490,517,529,509**;Aug 13, 1993;Build 37
 ;SD/517 CHANGED FOR LOOPS
 I 'VAUTC S SDC=0 F  S SDC=$O(VAUTC(SDC)) Q:'SDC  S SDV=VAUTC(SDC) D:VAUTD!($D(VAUTD(+$P(^SC(SDC,0),"^",15))))!('$P(^(0),"^",15)&$D(VAUTD($P(^DG(43,1,"GL"),"^",3)))) S1
 I VAUTC S SDC=0 F  S SDC=$O(^SC(SDC)) Q:'SDC  I $P(^(SDC,0),"^",3)="C" D:VAUTD!($D(VAUTD(+$P(^(0),"^",15))))!('$P(^(0),"^",15)&$D(VAUTD($P(^DG(43,1,"GL"),"^",3)))) S1
 I $D(^UTILITY($J,"SDNMS")) D S2^SDCLAV1
 ;following line commented off per SD*529
 ;S DGTCH="CLINIC AVAILABILITY REPORT^CLINIC^PAGE#" D:$E(IOST,1,2)="P-" TP^DGUTL K SDBD,SDCI,SDED D END^SDCLAV Q
 D END^SDCLAV Q
S1 S SD=^SC(SDC,0),D=$S($P(SD,"^",15):$P(SD,"^",15),1:$P(^DG(43,1,"GL"),"^",3)),SD5=0,SDNM=$P(SD,"^")
 S $P(^UTILITY($J,"SDNMS",D,SDNM),"^",3)=SDC
 Q
NM ;called by SDCLAV1 - SD/517 CHANGED FOR LOOP
 S SDAP1=0 F  S SDAP1=$O(^SC(SDC,"S",SDAP,1,SDAP1)) Q:'SDAP1  D NM1
 K M1,SDN1,SDN2,SDN3,SDC3,SDAP1  ; SD*5.3*439 added Kill of local vars
 Q
NM1 I '$D(^SC(SDC,"S",SDAP,1,SDAP1,0)) N POP S POP=0,(SDN1,SDN2,SDN3)="" D CHECK,KILL Q  ;added SD/517
 I $P(^SC(SDC,"S",SDAP,1,SDAP1,0),U,1)="" D SETUTL Q   ;SD*509
 S SDN1=+^SC(SDC,"S",SDAP,1,SDAP1,0),M1=$P(^(0),"^",2),SDC3=$P(^(0),"^",9),SDN2=$P(^DPT(+SDN1,0),"^"),SDN3=$P(^(0),"^",9),SDN3=$S(SDN3="":"UNKNOWN",1:SDN3) I $D(SDCI) D NM2 Q
 ; SD*5.3*439 added quit if clinic in "S" node not = to selected clinic
 I '$D(SDCI),$D(^DPT(SDN1,"S",SDAP,0)),$P(^(0),"^",2)'["C",$P(^(0),"^",2)'="N",$P(^(0),"^",2)'="NA" Q:$P(^(0),U,1)'=SDC  D NM2 Q
 Q
 ;SD*5.3*490 do not display appts prior to clinic start date
NM2 Q:$P(SDAP,".",1)<$O(^SC(SDC,"T",0))  ;SD*5.3*490
 S:$D(^DPT(SDN1,"S",SDAP,0)) ^UTILITY($J,"SDNMS",D,SDV,SDAP,SDN2,SDN3)=M1_$S(($P(^DPT(SDN1,"S",SDAP,0),"^",2)["C"):"^*",SDC3="C":"^*",($P(^(0),"^",2)="N"):"^**",($P(^(0),"^",2)="NA"):"^**",1:"")
 S:$D(^DPT(SDN1,"S",SDAP,0)) $P(^UTILITY($J,"SDNMS",D,SDV,SDAP,SDN2,SDN3),"^",3)=$S($P(^DPT(SDN1,"S",SDAP,0),"^",7)=4:"***",1:"")
 Q
 ;
CHECK ;Added SD/517
 N SDIEN,NODE,NODE0,HDFN,HDNAM,HDSN,POP
 S SDIEN=0,NODE="",HDAP1=SDAP1
 F  S SDIEN=$O(^SCE("B",SDAP,SDIEN)) Q:'SDIEN  D
 .S NODE=^SCE(SDIEN,0)
 .Q:$P(NODE,U,4)'=SDC
 .S HDFN=$P(NODE,U,2),HDNAM=$P(^DPT(HDFN,0),U),HDSN=$P(^(0),U,9)
 .Q:$D(^UTILITY($J,"SDNMS",D,SDV,SDAP,HDNAM,HDSN))
 .S POP=0 D CHECK1 Q:POP
 .S SDN1=$P(NODE,U,2),SDN2=$P(^DPT(SDN1,0),U),SDN3=$P(^DPT(SDN1,0),U,9),M1="",SDC3=""
 .D NM2
 Q
 ;
CHECK1 ;Added SD/517
 S HDAP1=$O(^SC(SDC,"S",SDAP,1,HDAP1)) Q:'HDAP1
 Q:'$D(^SC(SDC,"S",SDAP,1,HDAP1,0))  S NODE0=^(0)
 I $P(NODE0,U,1)=HDFN S POP=1 Q
 Q
 ;
KILL K SDIEN,NODE,NODE0,POP,HDFN,HDNAM,HDSN,HDAP1  ;added SD/517
 Q
 ;
SETUTL ;SD*509 set Utility for null DFN, corrupt node will be deleted in SDCLAV1
 S (SDN1,SDN2,SDN3)="UNKNOWN",M1=0
 S ^UTILITY($J,"SDNMS",D,SDV,SDAP,SDN2,SDN3)=M1_"^"_SDC_"^"_SDAP1
 Q
 ;
