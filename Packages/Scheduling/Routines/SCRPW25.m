SCRPW25 ;RENO/KEITH - ACRP Ad Hoc Report (cont.) ; 12/5/00 4:15pm
 ;;5.3;Scheduling;**144,177,232**;AUG 13, 1993
PEAO(SDX) ;Get agent orange indicator
 K SDX S DFN=$P(SDOE0,U,2) I DFN D SVC^VADPT I $L(VASV(2)) S SDX(1)=VASV(2)_U_$S(VASV(2):"YES",1:"NO")
 D NX Q
 ;
PEEC(SDX) ;Get environmental contaminants indicator
 K SDX S SDX=$P($G(^DPT($P(SDOE0,U,2),.322)),U,13) I $L(SDX) D FST(.SDX,2,.322013) I $L($P(SDX,U,2)) S SDX(1)=SDX
 D NX Q
 ;
PEIR(SDX) ;Get ionizing radiation indicator
 K SDX S DFN=$P(SDOE0,U,2) I DFN D SVC^VADPT I $L(VASV(3)) S SDX(1)=VASV(3)_U_$S(VASV(3):"YES",1:"NO")
 D NX Q
 ;
PEMT(SDX,SDZ) ;Get patient means test
 K SDX N SDY S SDX=$$LST^DGMTU(+$P(SDOE0,U,2),$S(SDZ="H":+$P(SDOE0,U),1:DT)) I $L($P(SDX,U,4)) S SDY=$O(^DG(408.32,"C",$P(SDX,U,4),0)) I SDY S SDX(1)=SDY_U_$P(SDX,U,3)
 D NX Q
 ;
PEMTQ(SDZ) ;Set up means test help text
 I SDZ="H" S SDIRQ("?")="Means Test status as of the encounter date/time is used for 'historical' values."
 I SDZ="C" S SDIRQ("?")="Means Test status as of the report run date is used for 'current' values."
 Q
 ;
PEPE(SDX) ;Get patient primary eligibility
 K SDX S DFN=$P(SDOE0,U,2) I DFN D ELIG^VADPT I $L($P(VAEL(1),U,2)) S SDX(1)=VAEL(1)
 D NX Q
 ;
PEAE(SDX) ;Get all patient eligibilities
 K SDX S DFN=$P(SDOE0,U,2) I DFN D ELIG^VADPT M SDX=VAEL(1) I VAEL(1) S SDX(+VAEL(1))=VAEL(1)
 D NX Q
 ;
PEPS(SDX) ;Get patient period of service
 K SDX S DFN=$P(SDOE0,U,2) I DFN D ELIG^VADPT I $L($P(VAEL(2),U,2)) S SDX(1)=VAEL(2)
 D NX Q
 ;
PEPW(SDX) ;Get patient POW indicated
 K SDX S DFN=$P(SDOE0,U,2) I DFN D SVC^VADPT I $L(VASV(4)) S SDX(1)=VASV(4)_U_$S(VASV(4)=1:"YES",1:"NO")
 D NX Q
 ;
PESP(SDX) ;Get service connected percentage
 K SDX S DFN=$P(SDOE0,U,2) I DFN D ELIG^VADPT I VAEL(3) S SDX(1)=+$P(VAEL(3),U,2)_U_+$P(VAEL(3),U,2)
 D NX Q
 ;
PEVT(SDX) ;Get veteran (y/n)?
 K SDX S DFN=$P(SDOE0,U,2) I DFN D ELIG^VADPT I $L(VAEL(4)) S SDX(1)=$S(VAEL(4)=1:"Y^YES",1:"N^NO")
 D NX Q
 ;
PRAP(SDX) ;Get all providers
 K SDX N SDY,SDI D GETPRV^SDOE(SDOE,"SDY") S SDI=0 F  S SDI=$O(SDY(SDI)) Q:'SDI  S SDX=$P(SDY(SDI),U),SDX=SDX_U_$P($G(^VA(200,SDX,0)),U) S:$L($P(SDX,U,2)) SDX(SDI)=SDX
 D NX Q
 ;
PRPC(SDX,SDP) ;Get person class
 K SDX N SDY,SDI D GETPRV^SDOE(SDOE,"SDY") S SDI=0
 F  S SDI=$O(SDY(SDI)) Q:'SDI  S SDX=$P(SDY(SDI),U,4) I $S(SDP="P"&(SDX="P"):1,SDP="S"&(SDX'="P"):1,SDP="A":1,1:0) S SDX=$P(SDY(SDI),U,6) I SDX S SDX=SDX_U_$P($$CODE2TXT^XUA4A72(SDX),U) I $L($P(SDX,U,2)) D PCOTR S SDX(SDI)=SDX Q:SDP="P"
 D NX Q
 ;
PCOTR ;Person class output transform
 N SDI,SDII,SDY S SDY=$G(^USC(8932.1,+SDX,0)) F SDI=2,3 S SDII=$P(SDY,U,SDI) S:$L(SDII) SDX=SDX_"/"_SDII
 S SDX=$E(SDX,1,42) Q
 ;
PRPP(SDX) ;Get primary provider
 K SDX N SDY,SDI D GETPRV^SDOE(SDOE,"SDY") S SDI=0 F  S SDI=$O(SDY(SDI)) Q:'SDI  I $P(SDY(SDI),U,4)="P" S SDX=$P(SDY(SDI),U),SDX=SDX_U_$P($G(^VA(200,SDX,0)),U) S:$L($P(SDX,U,2)) SDX(SDI)=SDX Q
 D NX Q
 ;
PRSP(SDX) ;Get secondary providers
 K SDX N SDY,SDI D GETPRV^SDOE(SDOE,"SDY") S SDI=0 F  S SDI=$O(SDY(SDI)) Q:'SDI  I $P(SDY(SDI),U,4)'="P" S SDX=$P(SDY(SDI),U),SDX=SDX_U_$P($G(^VA(200,SDX,0)),U) S:$L($P(SDX,U,2)) SDX(SDI)=SDX
 D NX Q
 ;
SCBC(SDX) ;Get both stop codes
 K SDX S SDX=$P(SDOE0,U,3) I SDX S SDX=SDX_U_$P($G(^DIC(40.7,SDX,0)),U) I $L($P(SDX,U,2)) D SCOTR S SDX(1)=SDX
 N SDI S SDI=0 F  S SDI=$O(^SCE("APAR",SDOE,SDI)) Q:'SDI  S SDOECH=$$GETOE^SDOE(SDI) I $P(SDOECH,U,8)=4 S SDX=$P(SDOECH,U,3) I SDX S SDX=SDX_U_$P($G(^DIC(40.7,SDX,0)),U) I $L($P(SDX,U,2)) D SCOTR S SDX(2)=SDX
 D NX Q
 ;
SCPC(SDX) ;Get primary stop code
 K SDX S SDX=$P(SDOE0,U,3) I SDX S SDX=SDX_U_$P($G(^DIC(40.7,SDX,0)),U) I $L($P(SDX,U,2)) D SCOTR S SDX(1)=SDX
 D NX Q
 ;
SCSC(SDX) ;Get secondary stop code
 K SDX N SDI S SDI=0 F  S SDI=$O(^SCE("APAR",SDOE,SDI)) Q:'SDI  S SDOECH=$$GETOE^SDOE(SDI) I $P(SDOECH,U,8)=4 S SDX=$P(SDOECH,U,3) I SDX S SDX=SDX_U_$P($G(^DIC(40.7,SDX,0)),U) I $L($P(SDX,U,2)) D SCOTR S SDX(2)=SDX
 D NX Q
 ;
SCOTR ;Transform stop code external value
 S $P(SDX,U,2)=$P(^DIC(40.7,+SDX,0),U,2)_" "_$P(SDX,U,2) Q
 ;
SCCP(SDX) ;Get stop code credit pair
 K SDX N SDY D SCBC(.SDY) S SDX=$E($P(SDY(1),U,2),1,3) K:SDX'?3N SDX I $D(SDX) S SDX=SDX_$E($P($G(SDY(2)),U,2),1,3) S:SDX'?6N SDX=$E(SDX,1,3)_"000" D CPOTR S SDX(1)=SDX
 D NX Q
 ;
CPOTR ;Credit pair output transform
 N SDSC1,SDSC2,SDZ
 S SDSC1=$O(^DIC(40.7,"C",$E(SDX,1,3),"")) Q:'SDSC1  S SDSC1=$P(^DIC(40.7,SDSC1,0),U),SDSC1=$TR(SDSC1,"/","-")
 I $E(SDX,4,6)="000" S SDSC2="(NONE)" G CPO1
 S SDSC2=$O(^DIC(40.7,"C",$E(SDX,4,6),"")) Q:'SDSC2  S SDSC2=$P(^DIC(40.7,SDSC2,0),U),SDSC2=$TR(SDSC2,"/","-")
CPO1 I $L(SDSC1)<17 S SDZ=SDSC1_"/"_$E(SDSC2,1,(17+(17-$L(SDSC1)))) G CPOTQ
 I $L(SDSC2)<17 S SDZ=$E(SDSC1,1,(17+(17-$L(SDSC2))))_"/"_SDSC2 G CPOTQ
 S SDZ=$E(SDSC1,1,17)_"/"_$E(SDSC2,1,17)
CPOTQ S $P(SDX,U,2)=$P(SDX,U)_" "_SDZ Q
 ;
VFEX(SDX) ;Get examinations
 K SDX N SDY,SDI S SDY=+$P(SDOE0,U,5),SDI=0 F  S SDI=$O(^AUPNVXAM("AD",SDY,SDI)) Q:'SDI  S SDX=$P($G(^AUPNVXAM(SDI,0)),U),SDX=SDX_U_$P($G(^AUTTEXAM(+SDX,0)),U) S:$L($P(SDX,U,2)) SDX(SDI)=SDX
 D NX Q
 ;
VFHF(SDX) ;Get health factors
 K SDX N SDY,SDI S SDY=+$P(SDOE0,U,5),SDI=0 F  S SDI=$O(^AUPNVHF("AD",SDY,SDI)) Q:'SDI  S SDX=$P($G(^AUPNVHF(SDI,0)),U),SDX=SDX_U_$P($G(^AUTTHF(+SDX,0)),U) S:$L($P(SDX,U,2)) SDX(SDI)=SDX
 D NX Q
 ;
VFIM(SDX) ;Get immunizations
 K SDX N SDY,SDI S SDY=+$P(SDOE0,U,5),SDI=0 F  S SDI=$O(^AUPNVIMM("AD",SDY,SDI)) Q:'SDI  S SDX=$P($G(^AUPNVIMM(SDI,0)),U),SDX=SDX_U_$P($G(^AUTTIMM(+SDX,0)),U) S:$L($P(SDX,U,2)) SDX(SDI)=SDX
 D NX Q
 ;
VFPE(SDX) ;Get patient education
 K SDX N SDY,SDI S SDY=+$P(SDOE0,U,5),SDI=0 F  S SDI=$O(^AUPNVPED("AD",SDY,SDI)) Q:'SDI  S SDX=$P($G(^AUPNVPED(SDI,0)),U),SDX=SDX_U_$P($G(^AUTTEDT(+SDX,0)),U) S:$L($P(SDX,U,2)) SDX(SDI)=SDX
 D NX Q
 ;
VFST(SDX) ;Get skin tests
 K SDX N SDY,SDI S SDY=+$P(SDOE0,U,5),SDI=0 F  S SDI=$O(^AUPNVSK("AD",SDY,SDI)) Q:'SDI  S SDX=$P($G(^AUPNVSK(SDI,0)),U),SDX=SDX_U_$P($G(^AUTTSK(+SDX,0)),U) S:$L($P(SDX,U,2)) SDX(SDI)=SDX
 D NX Q
 ;
VFTR(SDX) ;Get treatments
 K SDX N SDY,SDI S SDY=+$P(SDOE0,U,5),SDI=0 F  S SDI=$O(^AUPNVTRT("AD",SDY,SDI)) Q:'SDI  S SDX=$P($G(^AUPNVTRT(SDI,0)),U),SDX=SDX_U_$P($G(^AUTTTRT(+SDX,0)),U) S:$L($P(SDX,U,2)) SDX(SDI)=SDX
 D NX Q
 ;
NX S:$D(SDX)<10 SDX(1)="~~~NONE~~~^~~~NONE~~~" Q
 ;
FST(SDX,SDFI,SDFE) ;Field set transform
 Q:'$L(SDX)  N SDY,SDI D FIELD^DID(SDFI,SDFE,"","POINTER","SDY") S SDY=SDY("POINTER") F SDI=1:1:$L(SDY,";") I SDX=$P($P(SDY,";",SDI),":") S SDX=SDX_U_$P($P(SDY,";",SDI),":",2) Q
 Q
 ;
VETQ(DIR) ;Set up DIR array for 'veteran?' prompt
 S DIR(0)="SO^Y:YES;N:NO",DIR("?")="Indicates if the patient served in the U.S. armed forces." Q
 ;
AOQ(DIR) ;Set up DIR array for agent orange prompt
 S DIR(0)="SO^1:YES;0:NO",DIR("?")="Indicates if the patient was exposed to agent orange." Q
 ;
IRQ(DIR) ;Set up DIR array for ionizing radiation prompt
 S DIR(0)="SO^1:YES;0:NO",DIR("?")="Indicates if the patient was exposed to ionizing radiation." Q
 ;
ECQ(DIR) ;Set up DIR array for environmental contaminants prompt
 S DIR(0)="SO^Y:YES;N:NO;U:UNKNOWN",DIR("?")="Indicates if the patient was exposed to environmental contaminants." Q
 ;
POWQ(DIR) ;Set up DIR array for POW prompt
 S DIR(0)="SO^1:YES;0:NO",DIR("?")="Indicates if the patient was a prisoner of war." Q
 ;
CPQ ;Credit pair help text
 S SDIRQ("?",1)="Enter a six digit numeric value that represents two valid stop codes, or a",SDIRQ("?",2)="valid stop code followed by three zeros for clinics that do not have a (second)",SDIRQ("?")="credit stop code."
 Q  ; SD*5.3*232 TEJ - Q TO PREVENT CPQ OVERRUN INTO PCAP 11/28/00
 ;
PCAP(SDX,SDZ) ;Get primary care associate provider
 ;Required input: SDZ="C" for current, "H" for historical
 N SDI,SDATE,SDLIST,DFN
 D VARZ(SDZ) S SDI=$$GETALL^SCAPMCA(DFN,.SDATE,SDLIST)
 S SDX=$P($G(^TMP("SDPLIST",$J,DFN,"PCAP",1)),U,1,2)
 I $L($P(SDX,U,2)) S SDX(1)=SDX
 K ^TMP("SDPLIST",$J,DFN)
 D NX Q
 ;
NPCP(SDX,SDZ) ;Get non-primary care provider information
 ;Required input: SDZ="C" for current, "H" for historical
 N SDI,SDATE,SDLIST,DFN
 D VARZ(SDZ) S SDI=$$GETALL^SCAPMCA(DFN,.SDATE,SDLIST),SDI=0
 F  S SDI=$O(^TMP("SDPLIST",$J,DFN,"NPCPR",SDI)) Q:'SDI  D
 .S SDX=$P($G(^TMP("SDPLIST",$J,DFN,"NPCPR",SDI)),U,1,2)
 .I $L($P(SDX,U,2)) S SDX(SDI)=SDX
 .Q
 K ^TMP("SDPLIST",$J,DFN)
 D NX Q
 ;
NPCT(SDX,SDZ) ;Get non-primary care team information
 ;Required input: SDZ="C" for current, "H" for historical
 N SDI,SDATE,SDLIST,DFN
 D VARZ(SDZ) S SDI=$$GETALL^SCAPMCA(DFN,.SDATE,SDLIST),SDI=0
 F  S SDI=$O(^TMP("SDPLIST",$J,DFN,"NPCTM",SDI)) Q:'SDI  D
 .S SDX=$P($G(^TMP("SDPLIST",$J,DFN,"NPCTM",SDI)),U,1,2)
 .I $L($P(SDX,U,2)) S SDX(SDI)=SDX
 .Q
 K ^TMP("SDPLIST",$J,DFN)
 D NX Q
 ;
VARZ(SDZ) ;Produce variables
 ;Input: SDZ="C" for current, "H" for historical
 S SDLIST="^TMP(""SDPLIST"",$J)",DFN=+$P(SDOE0,U,2) K SDX,@SDLIST
 S SDATE=$S(SDZ="C":DT,1:+$P(SDOE0,U))
 S (SDATE("BEGIN"),SDATE("END"))=SDATE,SDATE="SDATE"
 Q
