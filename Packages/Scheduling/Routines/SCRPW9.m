SCRPW9 ;RENO/KEITH - Outpatient Encounter Workload Statistics (cont.) ; 15 Jul 98  02:38PM
 ;;5.3;Scheduling;**139,144,339,466,510**;AUG 13, 1993;Build 3
UNARL(SDS1,SDS2) ;Print list of 'action required'/not accepted uniques
 ;Required input: SDS1,SDS2=subscript values
 S SDPAGE=1 D UHDR Q:SDOUT  I '$D(^TMP(SDS1,$J,SDS2,"VISIT","UNARL")) W !!,"No 'action required'/not accepted unique patients identified." Q
 S SDARCT=0,SDPNAM="" F  S SDPNAM=$O(^TMP(SDS1,$J,SDS2,"VISIT","UNARL",SDPNAM)) Q:SDPNAM=""!SDOUT  S DFN=0 F  S DFN=$O(^TMP(SDS1,$J,SDS2,"VISIT","UNARL",SDPNAM,DFN)) Q:'DFN!SDOUT  D UNP
 Q:SDOUT  D:$Y>(IOSL-3) UHDR Q:SDOUT  W !!,SDARCT," 'action required'/not accepted unique patient",$S(SDARCT=1:"",1:"s")," identified." Q
 ;
UNP S SDSSN=$O(^TMP(SDS1,$J,SDS2,"VISIT","UNARL",SDPNAM,DFN,"")) D:$Y>(IOSL-4) UHDR Q:SDOUT  W !,$E(SDPNAM,1,18),?20,SDSSN
 S SDARCT=SDARCT+1,(SDDT,SDI)=0 F  S SDDT=$O(^TMP(SDS1,$J,SDS2,"VISIT","UNARL",SDPNAM,DFN,SDSSN,SDDT)) Q:'SDDT!SDOUT  D:$Y>(IOSL-4) UHDR Q:SDOUT  S Y=SDDT X ^DD("DD") W:SDI ! W ?31,Y S SDI=1 D UNP1
 Q
 ;
UNP1 N SDII,SDDT1 S SDII=0,SDDT1=SDDT F  S SDDT1=$O(^SCE("ADFN",DFN,SDDT1)) Q:'SDDT1!(SDDT1>(SDDT+.9999))!SDOUT  D
 .S SDOE=0 F  S SDOE=$O(^SCE("ADFN",DFN,SDDT1,SDOE)) Q:'SDOE!SDOUT  S SDOE0=$$GETOE^SDOE(SDOE) I $L(SDOE0),'$P(SDOE0,U,6) D UNP2
 .Q
 Q
 ;
UNP2 N SDCL,SDST Q:'$P(SDOE0,U,4)  S SDCL=$P($G(^SC($P(SDOE0,U,4),0)),U),SDST=$P(SDOE0,U,12) Q:$P($G(^SC($P(SDOE0,U,4),0)),U,17)="Y"  Q:'SDST!(SDST=12)  S SDST=$S("28"'[SDST:$P(^SD(409.63,SDST,0),U),1:$P($$STX^SCRPW8(SDOE,SDOE0),U,3))
 D:$Y>(IOSL-4) UHDR Q:SDOUT  W:SDII ! W ?44,$E(SDCL,1,17),?63,$E(SDST,1,17) S SDII=SDII+1 Q
 ;
UHDR I $E(IOST)="C" N DIR S DIR(0)="E" D ^DIR S SDOUT=Y'=1 Q:SDOUT
 D STOP^SCRPW8 Q:SDOUT
 W $$XY^SCRPW50(IOF,1,0),SDLINE,!?8,"<*>  LIST OF 'ACTION REQUIRED'/NOT ACCEPTED UNIQUE PATIENTS  <*>",!?(66-$L(SDDNAM)\2),"For station: ",SDDNAM
 W !,SDLINE,!,"For encounter dates ",SDDTPF," to ",SDDTPL,!,"Date printed: ",SDPNOW,?(74-$L(SDPAGE)),"Page: ",SDPAGE,!,SDLINE,! S SDPAGE=SDPAGE+1
 W:$D(^TMP(SDS1,$J,SDS2,"VISIT","UNARL")) !,"Name:",?20,"SSN:",?31,"Date:",?44,"Location:",?63,"Reason:",! Q
 ;
DETAIL ;Ask questions for detail of encounters or uniques for a division
 K SDZ S SDZ(0)=0 K DIR S DIR(0)="Y",DIR("A")="Would you like to print a detailed list of activity for a division",DIR("B")="NO" W ! D ^DIR I $D(DTOUT)!$D(DUOUT) S SDZ(0)=-1 Q
 S SDZ(0)=Y Q:'Y  W !!!,$C(7),"   WARNING: Selection high activity areas will result in lengthy output!",!
 K DIR S DIR(0)="S^U:UNIQUES;V:VISITS;E:ENCOUNTERS",DIR("A")="Select type of list" D ^DIR I $D(DTOUT)!$D(DUOUT) S SDZ(0)=-1 Q
 S SDZ(1)=Y G:Y'="E" ZDIV
DET1 K DIC S DIC="^SD(409.63,",DIC(0)="AEMQ",DIC("S")="I Y<4!(Y=8!(Y=12!(Y=14)))",DIC("A")="Select encounter status: " W ! D ^DIC I $D(DTOUT)!$D(DUOUT)!($G(Y)<1) S SDZ(0)=-1 Q
 S SDZ(2)=$P(Y,U) G:(SDZ(2)'=2)&(SDZ(2)'=8) ZDIV K DIR S DIR("A")="Select transmission status for "_$S(SDZ(2)=2:"CHECKED OUT",1:"INPATIENT APPOINTMENT")_" encounters"
 S DIR(0)="S^A:All transmission statuses;1:No transmission record;2:Not required, not transmitted;3:Rejected for transmission;4:Awaiting transmission;"
 S DIR(0)=DIR(0)_"5:Transmitted, no acknowledgment;6:Transmitted, rejected;7:Transmitted, error;8:Transmitted, accepted"
 I SDZ(2)=8 S DIR(0)=DIR(0)_";9:Non-Count (not transmitted)"
 W ! D ^DIR I $D(DTOUT)!$D(DUOUT) S SDZ(0)=-1 Q  ;SD*5.3*339 add sub-zero
 S SDZ(3)=+Y
ZDIV ;Get division for detail
 I '$P($G(^DG(43,1,"GL")),U,2) S SDZ(4)=$P(^DG(40.8,$$PRIM^VASITE(),0),U) Q
 K DIC S DIC="^DG(40.8,",DIC("A")="Select Medical Center division for detail: ",DIC(0)="AEMQ" W ! D ^DIC I $D(DTOUT)!$D(DUOUT) S SDZ(0)=-1 Q
 I Y<1 W $C(7),"    Required for patient detail!" G ZDIV
 S SDZ(4)=$P(Y,U,2) Q
 ;
DPRT(SDS1,SDS2) ;Detail print
 ;Required input: SDS1,SDS2=subscript values
 K SDH S SDPAGE=1,SDH(1)="<*>  DETAILED LIST OF DIVISION "_$S(SDZ(1)="U":"UNIQUES",SDZ(1)="V":"VISITS",1:"ENCOUNTERS")_"  <*>",SDH(2)="For division: "_SDZ(4)
 I $G(SDZ(2)) S SDH(3)="Encounters with "_$P(^SD(409.63,SDZ(2),0),U)_" status"
 I $G(SDZ(2))'="","28"[SDZ(2) S SDH(4)="Transmission status: "_$P($T(TXS+SDZ(3)),";",2)
 D DHDR Q:SDOUT  I '$D(^TMP(SDS1,$J,SDS2,"DETAIL")) W !,"No records found in this category." Q
 S SDCT=0 D @SDZ(1) Q
 ;
U ;Print uniques
 S SDPNAM="" F  S SDPNAM=$O(^TMP(SDS1,$J,SDS2,"DETAIL",SDPNAM)) Q:SDPNAM=""!SDOUT  S DFN=0 F  S DFN=$O(^TMP(SDS1,$J,SDS2,"DETAIL",SDPNAM,DFN)) Q:'DFN!SDOUT  D U1
 Q:SDOUT  W !!,SDCT," uniques identified." Q
 ;
U1 S SDCT=SDCT+1,SDSSN=$O(^TMP(SDS1,$J,SDS2,"DETAIL",SDPNAM,DFN,"")) D:$Y>(IOSL-4) DHDR Q:SDOUT  W !,$E(SDPNAM,1,18),?21,SDSSN Q
 ;
V ;Print visits
 S SDPNAM="" F  S SDPNAM=$O(^TMP(SDS1,$J,SDS2,"DETAIL",SDPNAM)) Q:SDPNAM=""!SDOUT  S DFN=0 F  S DFN=$O(^TMP(SDS1,$J,SDS2,"DETAIL",SDPNAM,DFN)) Q:'DFN!SDOUT  S SDSSN=$O(^TMP(SDS1,$J,SDS2,"DETAIL",SDPNAM,DFN,"")) D V1
 Q:SDOUT  W !!,SDCT," visits identified." Q
 ;
V1 D:$Y>(IOSL-4) DHDR Q:SDOUT  W !,$E(SDPNAM,1,18),?21,SDSSN S (SDDT,SDI)=0 F  S SDDT=$O(^TMP(SDS1,$J,SDS2,"DETAIL",SDPNAM,DFN,SDSSN,SDDT)) Q:'SDDT!SDOUT  D
 .D:$Y>(IOSL-3) DHDR Q:SDOUT  S Y=SDDT X ^DD("DD") W:SDI ! W ?32,Y S SDCT=SDCT+1,SDI=SDI+1
 .Q
 Q
 ;
E ;Print encounters
 S SDPNAM="" F  S SDPNAM=$O(^TMP(SDS1,$J,SDS2,"DETAIL",SDPNAM)) Q:SDPNAM=""!SDOUT  S DFN=0 F  S DFN=$O(^TMP(SDS1,$J,SDS2,"DETAIL",SDPNAM,DFN)) Q:'DFN!SDOUT  S SDSSN=$O(^TMP(SDS1,$J,SDS2,"DETAIL",SDPNAM,DFN,"")) D E1
 Q:SDOUT  W !!,SDCT," encounters identified." Q
 ;
E1 D:$Y>(IOSL-4) DHDR Q:SDOUT  W !,$E(SDPNAM,1,18),?21,SDSSN
 S (SDDT,SDI)=0 F  S SDDT=$O(^TMP(SDS1,$J,SDS2,"DETAIL",SDPNAM,DFN,SDSSN,SDDT)) Q:'SDDT!SDOUT  S SDOE=0 F  S SDOE=$O(^TMP(SDS1,$J,SDS2,"DETAIL",SDPNAM,DFN,SDSSN,SDDT,SDOE)) Q:'SDOE!SDOUT  D E2
 Q
 ;
E2 D:$Y>(IOSL-3) DHDR Q:SDOUT  S SDHL=^TMP(SDS1,$J,SDS2,"DETAIL",SDPNAM,DFN,SDSSN,SDDT,SDOE),SDHL=$P($G(^SC(+SDHL,0)),U),Y=SDDT X ^DD("DD") W:SDI ! W ?32,$P(Y,":",1,2),?50,SDHL S SDCT=SDCT+1,SDI=SDI+1 Q
 ;
DHDR I $E(IOST)="C" N DIR S DIR(0)="E" D ^DIR S SDOUT=Y'=1 Q:SDOUT
 D STOP^SCRPW8 Q:SDOUT
 W $$XY^SCRPW50(IOF,1,0),SDLINE S I=0 F  S I=$O(SDH(I)) Q:'I  W !?(80-$L(SDH(I))\2),SDH(I)
 W !,SDLINE,!,"For date range: ",SDDTPF," to ",SDDTPL,!,"Date printed: ",SDPNOW,?(74-$L(SDPAGE)),"Page: ",SDPAGE,!,SDLINE,! S SDPAGE=SDPAGE+1 Q
 ;
TXS ;All transmission statuses
 ;No transmission record
 ;Not required, not transmitted
 ;Rejected for transmission
 ;Awaiting transmission
 ;Transmitted, no acknowledgment
 ;Transmitted, rejected
 ;Transmitted, error
 ;Transmitted, accepted
 ;Non-Count (not transmitted)
 ;
PARM ;Prompt for report parameters
 D TITL^SCRPW50("Outpatient Encounter Workload Statistics")
 N %DT,DIR,DIC D SUBT^SCRPW50("*** Date Range Selection ***")
FDT W ! S %DT="AEPX",%DT("A")="Beginning date:  FIRST// ",%DT(0)=2961001 D ^%DT G:X=U!$D(DTOUT) EXIT^SCRPW8 I X="" S (Y,SDDTF)=2961001 X ^DD("DD") W "  ",Y,! S SDDTPF=Y G LDT
 G:Y<1 FDT S SDDTF=Y X ^DD("DD") S SDDTPF=Y W !
LDT S %DT("A")="Ending date:  LAST// " D ^%DT G:X=U!$D(DTOUT) EXIT^SCRPW8 I X="" S X1=DT,X2=-1 D C^%DTC S (Y,SDDTL)=X X ^DD("DD") W "  ",Y,! S SDDTPL=Y G ASK
 I Y<SDDTF W !!,$C(7),"Ending date must be after beginning date!",! G LDT
 G:Y<1 LDT S SDDTL=Y X ^DD("DD") S SDDTPL=Y,SDDTL=SDDTL_".999999"
ASK D SUBT^SCRPW50("*** Additional Detail Selection ***")
 W ! K DIR S DIR(0)="Y",DIR("A")="Break out workload by clinic group",DIR("B")="NO",DIR("?")="Specify if subtotals by encounter location CLINIC GROUP should be provided." D ^DIR G:$D(DTOUT)!$D(DUOUT) EXIT^SCRPW8 S SDCLGR=Y
 D DETAIL^SCRPW9 W ! G:SDZ(0)=-1 EXIT^SCRPW8
 K DIR S DIR(0)="Y",DIR("A")="List facility 'action required'/not accepted unique patients",DIR("B")="NO" D ^DIR G:$D(DTOUT)!$D(DUOUT) EXIT^SCRPW8 S SDUL=Y W !
QUE S ZTRTN="PST^SCRPW8",ZTDESC="Outpatient Encounter Workload" F SDI="SDCLGR","SDDTF","SDDTPF","SDDTL","SDDTPL","SDUL","SDDUL","SDZ(" S ZTSAVE(SDI)=""
 D EN^XUTMDEVQ(ZTRTN,ZTDESC,.ZTSAVE) G EXIT^SCRPW8
