SCRPW24 ;RENO/KEITH - ACRP Ad Hoc Report (cont.) ;06/19/99
 ;;5.3;Scheduling;**144,163,180,254,243,295,329,351,510,530,562,576**;AUG 13, 1993;Build 5
 ;06/19/99 ACS - Added CPT modifier API calls
 ;11/26/03 RLC - 329 fixes primary/secondary dx problem with report
 ;
APAC(SDX) ;Get all procedure codes
 D APAC^SCRPW241(.SDX)
 D NX Q
 ;
APOTR ;Transform procedure external value
 D APOTR^SCRPW241(.SDX)
 Q
 ;
APAP(SDX) ;Get ambulatory procedures (no E&M codes)
 D APAP^SCRPW241(.SDX)
 D NX Q
 ;
APEM(SDX) ;Get evaluation and management codes
 D APEM^SCRPW241(.SDX)
 D NX Q
 ;
CLCG(SDX) ;Get clinic group
 K SDX S SDX=$P(SDOE0,U,4) I SDX S SDX=$P($G(^SC(SDX,0)),U,31) I SDX,$D(^SD(409.67,SDX)) S SDX=SDX_U_$P(^SD(409.67,SDX,0),U) S:$L($P(SDX,U,2)) SDX(1)=SDX
 D NX Q
 ;
CLCN(SDX) ;Get clinic name
 K SDX S SDX=$P(SDOE0,U,4) I SDX S SDX=SDX_U_$P($G(^SC(SDX,0)),U) I $L($P(SDX,U,2)) S SDX(1)=SDX
 D NX Q
 ;
CLCS(SDX) ;Get clinic service
 K SDX S SDX=$P(SDOE0,U,4) I SDX S SDX=$P($G(^SC(SDX,0)),U,8) D FST(.SDX,44,9) S:$L($P(SDX,U,2)) SDX(1)=SDX
 D NX Q
 ;
DXAD(SDX) ;Get all diagnoses
 K SDX N SDY,SDI D GETDX^SDOE(SDOE,"SDY") S SDI=0 F  S SDI=$O(SDY(SDI)) Q:'SDI  S SDX=$P(SDY(SDI),U) I SDX S SDX=SDX_U_$P($$ICDDX^ICDCODE(+SDX,+SDOE0),U,2) I $L($P(SDX,U,2)) D DXOTR S SDX(SDI)=SDX
 D NX Q
 ;
DXOTR ;Transform diagnosis external value
 N ENCDT
 S ENCDT=+$G(SDOE0)
 I 'ENCDT D
 .I '$G(SDOE) S ENCDT=$$NOW^XLFDT() Q
 .N SDY
 .D GETGEN^SDOE(SDOE,"SDY")
 .S ENCDT=+$G(SDY(0))
 .K SDY
 S SDX=SDX_" "_$P($$ICDDX^ICDCODE(+SDX,ENCDT),U,4) Q
 ;
DXGS(SDX,SDZ) ;Get GAF score
 K SDX N SDI,SDY S SDY=$S(SDZ="H":$P($P(SDOE0,U),"."),1:DT)_.9999,SDY=9999999-SDY,SDY=$O(^YSD(627.8,"AX5",$P(SDOE0,U,2),SDY))
 I SDY S SDI=$O(^YSD(627.8,"AX5",$P(SDOE0,U,2),SDY,""),-1) I SDI S SDX=+$P($G(^YSD(627.8,SDI,60)),U,3) I SDX S SDX(1)=SDX_U_SDX
 D NX Q
 ;
DXGSQ(SDI) ;Set up GAF help text
 S SDIRQ("?",1)="Specify a value representing the Global Assessment of Functioning (GAF) score."
 I SDI="H" S SDIRQ("?")="Status as of the encounter date/time is used to determine 'historical' values."
 I SDI="C" S SDIRQ("?")="Status as of the report run date is used to determine 'current' values."
 Q
 ;
DXPD(SDX) ;Get primary diagnosis
 ;SD*5.3*329 fixes problem of report not working for primary dx
 K SDX N SDY,SDI D GETDX^SDOE(SDOE,"SDY") S SDI=0 F  S SDI=$O(SDY(SDI)) Q:'SDI  S SDX=$P(SDY(SDI),U) I SDX,$P(SDY(SDI),U,12)="P" S SDX=SDX_U_$P($$ICDDX^ICDCODE(+SDX,+SDOE0),U,2) I $L($P(SDX,U,2)) D DXOTR S SDX(SDI)=SDX
 D NX Q
 ;
DXSD(SDX) ;Get secondary diagnoses
 ;SD*5.3*329 fixes problem of report not working for secondary dx
 K SDX N SDY,SDI D GETDX^SDOE(SDOE,"SDY") S SDI=0 F  S SDI=$O(SDY(SDI)) Q:'SDI  S SDX=$P(SDY(SDI),U) I SDX,$P(SDY(SDI),U,12)'="P" S SDX=SDX_U_$P($$ICDDX^ICDCODE(+SDX,+SDOE0),U,2) I $L($P(SDX,U,2)) D DXOTR S SDX(SDI)=SDX
 D NX Q
 ;
ENED(SDX,SDZ) ;Get enrollment date
 K SDX N SDY S SDY=$$ENROL($S(SDZ="H":+SDOE0,1:DT)) I SDY S (SDX,Y)=$P(SDY,U) X ^DD("DD") S SDX(1)=SDX_U_Y
 D NX Q
 ;
ENEF(SDX,SDZ) ;Get enrollment effective date
 K SDX N SDY S SDY=$$ENROL($S(SDZ="H":+SDOE0,1:DT)) I SDY S (SDX,Y)=$P(SDY,U,8) X ^DD("DD") S SDX(1)=SDX_U_Y
 D NX Q
 ;
ENEP(SDX,SDZ) ;Get enrollment priority
 K SDX N SDY S SDY=$$ENROL($S(SDZ="H":+SDOE0,1:DT)) I SDY S SDX=$P(SDY,U,7) D FST(.SDX,27.11,.07) S:$L($P(SDX,U,2)) SDX(1)=SDX
 D NX Q
 ;
ENES(SDX,SDZ) ;Get enrollment status
 K SDX N SDY S SDY=$$ENROL($S(SDZ="H":+SDOE0,1:DT)) I SDY S SDX=$P(SDY,U,4),SDX=SDX_U_$$EXTERNAL^DILFD(27.11,.04,"F",SDX) S:$L($P(SDX,U,2)) SDX(1)=SDX
 D NX Q
 ;
ENFR(SDX,SDZ) ;Get enrollment facility received
 K SDX N SDY S SDY=$$ENROL($S(SDZ="H":+SDOE0,1:DT)) I SDY S SDX=$P(SDY,U,6) I SDX S SDX=SDX_U_$P($G(^DIC(4,SDX,0)),U) S:$L($P(SDX,U,2)) SDX(1)=SDX
 D NX Q
 ;
ENSE(SDX,SDZ) ;Get enrollment source of enrollment
 K SDX N SDY S SDY=$$ENROL($S(SDZ="H":+SDOE0,1:DT)) I SDY S SDX=$P(SDY,U,3) D FST(.SDX,27.11,.03) S:$L($P(SDX,U,2)) SDX(1)=SDX
 D NX Q
 ;
ENQ(SDZ) ;Set up help text for enrollment
 I SDZ="H" S SDIRQ("?")="Enrollment status as of the encounter date/time is used for 'historical' values."
 I SDZ="C" S SDIRQ("?")="Enrollment status as of the report run date is used for 'current' values."
 Q
 ;
OEAT(SDX) ;Get encounter appointment type
 K SDX S SDX=$P(SDOE0,U,10) I SDX S SDX=SDX_U_$P($G(^SD(409.1,SDX,0)),U) S:$L($P(SDX,U,2)) SDX(1)=SDX
 D NX Q
 ;
OEDV(SDX) ;Get encounter division
 K SDX S SDX=$P(SDOE0,U,11) I SDX S SDX=SDX_U_$P($G(^DG(40.8,SDX,0)),U) S:$L($P(SDX,U,2)) SDX(1)=SDX
 D NX Q
 ;
OEEE(SDX) ;Get encounter eligibility
 K SDX S SDX=$P(SDOE0,U,13) I SDX S SDX=SDX_U_$P($G(^DIC(8,SDX,0)),U) S:$L($P(SDX,U,2)) SDX(1)=SDX
 D NX Q
 ;
OEOP(SDX) ;Get encounter originating process type
 K SDX S SDX=$P(SDOE0,U,8) D FST(.SDX,409.68,.08) S:$L($P(SDX,U,2)) SDX(1)=SDX
 D NX Q
 ;
OEPA(SDX) ;Get encounter patient
 K SDX S DFN=$P(SDOE0,U,2) I DFN D DEM^VADPT I $L(VADM(1)) S SDX(1)=DFN_U_VADM(1)
 D NX Q
 ;
OEES(SDX) ;Get encounter status
 K SDX S SDX=$P(SDOE0,U,12) I SDX S SDX=SDX_U_$P($G(^SD(409.63,SDX,0)),U) S:$L($P(SDX,U,2)) SDX(1)=SDX
 D NX Q
 ;
OETS(SDX) ;Get transmission status
 K SDX S SDX(1)=$$STX^SCRPW8(SDOE,SDOE0) Q
 ;
TSQ(DIR) ;Set up DIR array for transmission status question
 K DIR S DIR("A")="Select transmission status",DIR("?")="This value represents the transmission status of the encounter record."
 S DIR(0)="SO^0:Not checked-out;1:No transmission record;2:Not required, not transmitted;3:Rejected for transmission;4:Awaiting transmission;5:Transmitted, no acknowledgment;6:Transmitted, rejected;7:Transmitted, error;8:Transmitted, accepted"
 Q
 ;
CLQ(DIR,SDZ) ;Set up DIR array for classification questions
 K DIR S SDZ=$S(SDZ="A":"Agent Orange exposure",SDZ="I":"ionizing radiation exposure",SDZ="S":"service connected condition",1:"environmental contaminants exposure")
 S DIR(0)="SO^1:YES;0:NO",DIR("A")="Treatment related to "_SDZ,DIR("?")="Indicates if treatment was related to "_SDZ Q
 ;
OECL(SDX,SDZ) ;Get classification values
 K SDX N SDY S SDZ=$S(SDZ="A":1,SDZ="I":2,SDZ="S":3,SDZ="E":4,1:"") I SDZ D CLASK^SDCO2(SDOE,.SDY) S SDX=$P($G(SDY(SDZ)),U,2) I $L(SDX) S SDX(1)=$S(SDX=1:"1^YES",1:"0^NO")
 D NX Q
 ;
OEOU(SDX) ;Get option used to create
 K SDX S SDX=+$P(SDOE0,U,5),SDX=+$P($G(^AUPNVSIT(SDX,0)),U,24)
 N SDY D GETS^DIQ(19,SDX,.01,"","SDY")
 I 'SDX S SDX="0^UNKNOWN",SDX(1)=SDX    ;SD*576
 I +SDX S SDX=SDX_U_SDY(19,SDX_",",.01) S:$L($P(SDX,U,2)) SDX(1)=SDX
 D NX Q
 ;
SUQ(DIR) ;Set up DIR() array for Scheduled/unscheduled question
 K DIR S DIR("A")="Select outpatient activity type",DIR("?",1)="Only pre-scheduled appointments will be reflected as SCHEDULED.  All other",DIR("?",2)="types of activity (add/edits, registrations, walkins or unscheduled activity)"
 S DIR("?")="will be reflected as UNSCHEDULED.",DIR(0)="SO^S:SCHEDULED;U:UNSCHEDULED" Q
 ;
OESU(SDX) ;Get scheduled/unscheduled status
 N SDAP0 K SDX S SDX(1)=""
 I $P(SDOE0,U,8)=1 D  Q:$L(SDX(1))
 .S SDAP0=$G(^DPT(+$P(SDOE0,U,2),"S",+SDOE0,0))
 .Q:$P(SDAP0,U,20)'=SDOE  Q:$P(SDAP0,U,7)=4
 .S SDX(1)="S^SCHEDULED" Q
 S SDX(1)="U^UNSCHEDULED" Q
 ;
PCPR(SDX,SDZ) ;Get primary care provider
 ;Required input: SDZ="C" for current, "H" for historical
 K SDX S SDX=$S(SDZ="C":$$OUTPTPR^SDUTL3(+$P(SDOE0,U,2)),1:$$OUTPTPR^SDUTL3(+$P(SDOE0,U,2),+$P(SDOE0,U))) S:$L($P(SDX,U,2)) SDX(1)=SDX
 D NX Q
 ;
PCTM(SDX,SDZ) ;Get priamry care team
 ;Required input: SDZ="C" for current, "H" for historical
 K SDX S SDX=$S(SDZ="C":$$OUTPTTM^SDUTL3(+$P(SDOE0,U,2)),1:$$OUTPTTM^SDUTL3(+$P(SDOE0,U,2),+$P(SDOE0,U))) S:$L($P(SDX,U,2)) SDX(1)=SDX
 D NX Q
 ;
PDPA(SDX) ;Get patient age
 K SDX S DFN=$P(SDOE0,U,2) I DFN D DEM^VADPT I VADM(4)=+VADM(4) S SDX(1)=VADM(4)_U_VADM(4)
 D NX Q
 ;
PDPS(SDX) ;Get patient sex
 K SDX S DFN=$P(SDOE0,U,2) I DFN D DEM^VADPT I $L($P(VADM(5),U,2)) S SDX(1)=VADM(5)
 D NX Q
 ;
PDSC(SDX) ;Get patient state/county
 K SDX S DFN=$P(SDOE0,U,2) I DFN D ADD^VADPT I $L($P(VAPA(7),U,2)) S SDX(1)=$P(VAPA(5),U)_";"_$P(VAPA(7),U)_U_$P(VAPA(5),U,2)_" / "_$P(VAPA(7),U,2)
 D NX Q
 ;
PDZC(SDX) ;Get patient zip code
 K SDX S DFN=$P(SDOE0,U,2) I DFN D ADD^VADPT I $L(VAPA(6)) S SDX(1)=VAPA(6)_U_VAPA(6)
 D NX Q
 ;
ENROL(SDATE)  ;Get enrollment record (most recent to encounter date)
 ;SD/530 changed For loop and added check for zero node to eliminate undefined error
 N SDY,SDI,X1,X2,X,%Y
 S:SDATE#1=0 SDATE=SDATE+.9999 S SDI=0 F  S SDI=$O(^DGEN(27.11,"C",+$P(SDOE0,U,2),SDI)) Q:'SDI  D
 .Q:'$D(^DGEN(27.11,SDI,0))
 .I '$D(^DGEN(27.11,SDI,"U")) S SDY=$G(^DGEN(27.11,SDI,0)),SDY(+SDY)=SDY Q   ;SD*562
 .S SDY=$G(^DGEN(27.11,SDI,0)),SDY($P($P(^DGEN(27.11,SDI,"U"),U,1),".",1))=SDY  ;SD/510 changed logic to use date/time entered
 S SDI=$O(SDY(SDATE),-1) Q:'SDI ""  S X1=$P($P(SDOE0,U),"."),X2=SDI D ^%DTC Q SDY(SDI)
 ;
NX S:$D(SDX)<10 SDX(1)="~~~NONE~~~^~~~NONE~~~" Q
 ;
FST(SDX,SDFI,SDFE) ;Field set transform
 Q:'$L(SDX)  N SDY,SDI D FIELD^DID(SDFI,SDFE,"","POINTER","SDY") S SDY=SDY("POINTER") F SDI=1:1:$L(SDY,";") I SDX=$P($P(SDY,";",SDI),":") S SDX=SDX_U_$P($P(SDY,";",SDI),":",2) Q
 Q
