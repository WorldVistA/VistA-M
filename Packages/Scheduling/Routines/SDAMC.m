SDAMC ;ALB/MJK - Cancel Appt Action ; 8/31/05 3:02pm  ; 12/26/08 12:26pm  ; 5/25/12 12:40pm
 ;;5.3;Scheduling;**20,28,32,46,263,414,444,478,538,554,597**;Aug 13, 1993;Build 3
 ;
EN ; -- protocol SDAM APPT CANCEL entry pt
 ; input:  VALMY := array entries
 ;
 N SDI,SDAT,VALMY,SDAMCIDT,CNT,L,SDWH,SDCP,SDREM,SDSCR,SDMSG,SCLHOLD
 K ^UTILITY($J)
 ;
 ;
 I '$D(DFN),$G(SDFN),($G(SDAMTYP)="P") S DFN=SDFN
 ;
 S VALMBCK=""
 D SEL^VALM2,CHK G ENQ:'$O(VALMY(0))
 D FULL^VALM1 S VALMBCK="R"
 S SDWH=$$WHO,SDCP=$S(SDWH="C":0,1:1) G ENQ:SDWH=-1
 S SDSCR=$$RSN(SDWH) G ENQ:SDSCR=-1
 S (TMPD,SDREM)=$$REM G ENQ:SDREM=-1 ;SD/478
 S (SDI,CNT,L)=0
 F  S SDI=$O(VALMY(SDI)) Q:'SDI  I $D(^TMP("SDAMIDX",$J,SDI)) K SDAT S SDAT=^(SDI) W !,^TMP("SDAM",$J,+SDAT,0) D CAN($P(SDAT,U,2),$P(SDAT,U,3),.CNT,.L,SDWH,SDCP,SDSCR,SDREM)
 I SDAMTYP="P" D BLD^SDAM1
 I SDAMTYP="C" D BLD^SDAM3
ENQ Q
 ;
CAN(DFN,SDT,CNT,L,SDWH,SDCP,SDSCR,SDREM) ;
 N A1,NDT S NDT=SDT
 I $P($G(^DPT(DFN,"S",NDT,0)),U,2)["C" W !!,"Appointment already cancelled" H 2 Q
 I $D(^DPT(DFN,"S",NDT,0)) S SD0=^(0) I $P(SD0,"^",2)'["C" S SC=+SD0,L=L\1+1,APL="" D FLEN^SDCNP1A S ^UTILITY($J,"SDCNP",L)=NDT_"^"_SC_"^"_COV_"^"_APL_"^^"_APL_"^^^^^^"_SDSP D CHKSO^SDCNP0 ;SD/478
 ;SD*5.3*414 next line added to set hold variable SCLHOLD for clinic ptr
 S APP=1,A1=L\1 S SCLHOLD=$P(^UTILITY($J,"SDCNP",A1),U,2) D BEGD^SDCNP0
 D MES,NOPE W ! S (CNT,L)=0 K ^UTILITY($J,"SDCNP")
 Q
CANQ(SDFN,SDCLN) ; SD*5.3*554 - Passes in SDFN, SDCLN
 ;Wait List Message
 ;
 I SDFN=""!(SDCLN="") Q  ;Checks to make sure that SDFN and SDCLN are set to a non null value - PATCH SD*5.3*597
 N SDOMES S SDOMES="" I $D(^SDWL(409.3,"SC",SDCLN)) D
 .N SDWL S SDWL="" F  S SDWL=$O(^SDWL(409.3,"SC",SDCLN,SDWL)) Q:SDWL=""  D  Q:SDOMES
 ..I $P(^SDWL(409.3,SDWL,0),U,17)="O" I $P(^SDWL(409.3,SDWL,0),U)=$G(SDFN) D  S SDOMES=1
 ...W !,?1,"There are Wait List entries waiting for an Appointment for this patient in ",!?1,$P(^SC(SDCLN,0),U,1)," Clinic.",!
 W ! S DIR(0)="E" D ^DIR W !
 K SCLHOLD,SC,COV,APP,SDCLN
 Q
MES ; -- set error message
 S SDMSG="W !,""Enter appt. numbers separated by commas and/or a range separated"",!,""by dashes (ie 2,4,6-9)"" H 2"
 Q
 ;
WHO() ;
 W ! S DIR(0)="SOA^PC:PATIENT;C:CLINIC",DIR("A")="Appointments cancelled by (P)atient or (C)linic: ",DIR("B")="Patient"
 D ^DIR K DIR
 Q $S(Y=""!(Y="^"):-1,1:Y)
 ;
RSN(SDWH) ;
RSN1 W ! S DIC="^SD(409.2,",DIC(0)="AEMQ",DIC("S")="I '$P(^(0),U,4),"""_$E(SDWH)_"B""[$P(^(0),U,2)" D ^DIC K DIC
 I X["^" G RSNQ
 I Y<0 W *7 G RSN1
RSNQ Q +Y
 ;
REM() ;
 W ! S DIR(0)="2.98,17" D ^DIR K DIR
 I $E(X)="^" S Y=-1
 Q Y
 ;
NOPE ;
 N SDEND,SDPAUSE
 S:'CNT SDPAUSE=1
 D NOPE^SDCNP1
 D:$G(SDPAUSE) PAUSE^VALM1
 Q
 ;
CHK ; -- check if status of appt permits cancelling
 N SDI S SDI=0
 F  S SDI=$O(VALMY(SDI)) Q:'SDI  I $D(^TMP("SDAMIDX",$J,SDI)) K SDAT S SDAT=^(SDI) I '$D(^SD(409.63,"ACAN",1,+$$STATUS^SDAM1($P(SDAT,U,2),$P(SDAT,U,3),+$G(^DPT(+$P(SDAT,U,2),"S",+$P(SDAT,U,3),0)),$G(^(0))))) D
 .W !,^TMP("SDAM",$J,+SDAT,0),!!,*7,"You cannot cancel this appointment."
 .K VALMY(SDI) D PAUSE^VALM1
 Q
