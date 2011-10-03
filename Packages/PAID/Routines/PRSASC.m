PRSASC ; HISC/MGD - Supervisor Certification ;01/22/05
 ;;4.0;PAID;**15,43,93**;Sep 21, 1995;Build 7
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 W:$E(IOST,1,2)="C-" @IOF W !?26,"VA TIME & ATTENDANCE SYSTEM",!?28,"SUPERVISOR'S APPROVALS"
 S PRSTLV=3 D ^PRSAUTL G:TLI<1 EX S QT=0
 S LVT=";"_$P(^DD(458.1,6,0),"^",3),LVS=";"_$P(^DD(458.1,8,0),"^",3) K AP
 S OTS=";"_$P(^DD(458.2,10,0),"^",3)
 S EDS=";"_$P(^DD(458.3,8,0),"^",3)
 S NN="",CKS=1 F  S NN=$O(^PRSPC("ATL"_TLE,NN)) Q:NN=""  F DFN=0:0 S DFN=$O(^PRSPC("ATL"_TLE,NN,DFN)) Q:DFN<1  D CHK I QT G ES
 S CKS=0 F VA2=0:0 S VA2=$O(^PRST(455.5,"ASX",TLE,VA2)) Q:VA2<1  S SSN=$P($G(^VA(200,VA2,1)),"^",9) I SSN'="" S DFN=$O(^PRSPC("SSN",SSN,0)) I DFN,$P($G(^PRSPC(+DFN,0)),"^",8)'=TLE D CHK I QT G ES
ES I '$D(AP) W !!,"No actions to certify." G EX
 D ^PRSAES G:'ESOK EX
 ; Queue approvals
 K ZTUCI,ZTDTH,ZTIO,ZTSAVE S ZTRTN="^PRSASC1",ZTREQ="@",ZTIO="",ZTDTH=$H
 S ZTSAVE("ZTREQ")="",ZTSAVE("AP(")="",ZTSAVE("ESNAM")="",ZTDESC=$P(XQY0,"^",1)
 S ZTSAVE("TLI")="",ZTSAVE("TLE")=""
 D ^%ZTLOAD W !,"Approvals Queued",! G EX
CHK ; Check for needed approvals
 S HDR=0 I USR=DFN Q:'$D(^XUSEC("PRSA SIGN",DUZ))
 E  I CKS S SSN=$P($G(^PRSPC(DFN,0)),"^",9) I SSN S EDUZ=+$O(^VA(200,"SSN",SSN,0)) I $D(^PRST(455.5,"AS",EDUZ,TLI)) Q:$P($G(^PRST(455.5,TLI,"S",EDUZ,0)),"^",2)'=TLE
 F DA=0:0 S DA=$O(^PRST(458.1,"AR",DFN,DA)) Q:DA<1  D LV G:QT C1
 F DA=0:0 S DA=$O(^PRST(458.2,"AR",DFN,DA)) Q:DA<1  D OT G:QT C1
 F DA=0:0 S DA=$O(^PRST(458.3,"AR",DFN,DA)) Q:DA<1  D ED G:QT C1
 I $D(^PRST(458,"ATC",DFN)) F PPI=0:0 S PPI=$O(^PRST(458,"ATC",DFN,PPI)) Q:PPI<1  S DA=DFN_"~"_PPI D TC G:QT C1
 I $D(^PRST(458,"AXR",DFN)) F PPI=0:0 S PPI=$O(^PRST(458,"AXR",DFN,PPI)) Q:PPI<1  F AUN=0:0 S AUN=$O(^PRST(458,"AXR",DFN,PPI,AUN)) Q:AUN<1  S DA=DFN_"~"_PPI_"~"_AUN D PP G:QT C1
C1 Q
LV ; Leave Request
 N PRSX
 D:'HDR HDR S (NUM,CNT)=0,PRT=1 W ! D BAL^PRSALVS W ! D LST^PRSALVS
 S PRSX=$$OKALVR^PRSPLVU(DA)
 I PRSX'>0 D
 . W !!,"This leave request can not be approved because the employee is"
 . W !,"a part-time physician with a memorandum of service level"
 . W !,"expectations, and the leave request may impact a time card for"
 . W !,"pay period "_$P($G(^PRST(458,+$P(PRSX,U,2),0)),U)_" that has a status of Payroll."
 . W !,"The request can be approved once the time card status changes."
 . W !,"(i.e. returned to Timekeeper or transmitted to Austin)",!
 S COM="" D LVOK Q:QT
 I ACT="A",PRSX'>0 W !,"Approved action can't be accepted at this time" Q
 S:ACT'="" AP(1,DA)=DFN_"^"_ACT_"^"_COM
 Q
OT ; Overtime/CompTime Request
 D:'HDR HDR S (NUM,CNT)=0 W ! D LST^PRSAOTS S COM="" D OK Q:QT  I ACT'="" S:ACT="A" ACT="S" S AP(2,DA)=DFN_"^"_ACT_"^"_COM
 Q
ED ; Environmental Diff. Request
 D:'HDR HDR S (NUM,CNT)=0 W ! D LST^PRSAEDS S COM="" D OK Q:QT  S:ACT'="" AP(3,DA)=DFN_"^"_ACT_"^"_COM Q
TC ; Tour Change
 D:'HDR HDR D LST^PRSATE1 K COM D OK Q:QT  S:ACT'="" AP(4,DA)=DFN_"^"_ACT Q
PP ; Prior Pay Period Change
 D:'HDR HDR D DIS^PRSASC3 K COM D OK Q:QT  I ACT'="" S:ACT="A" ACT="S" S AP(5,DA)=DFN_"^"_ACT
 Q
OK R !!,"Disposition (A=Approve, D=Disapprove, X=Cancel, RETURN to bypass): ",ACT:DTIME S:'$T!(ACT["^") QT=1 Q:QT!(ACT="")  S ACT=$TR(ACT,"adx","ADX") I ACT'?1U!("ADX"'[ACT) W *7,!,"Enter A, D or X or Press RETURN to bypass" G OK
 Q:'$D(COM)  S COM=""
O1 I ACT'="A" R !!,"Comment: ",COM:DTIME S:'$T!(COM["^") QT=1 Q:QT  I COM'?.ANP W *7," ??" G O1
 I ACT'="A",$L(COM)<4!($L(COM)>60)!(COM?1"?".E) W *7,"   A 4-60 character comment is required." G O1
 Q
 ;
LVOK N PROMPT,REPROMPT
 S PROMPT="Disposition (A=Approve, D=Disapprove, RETURN to bypass): "
 S REPROMPT="Enter A or D or Press RETURN to bypass"
 W !!,PROMPT
 R ACT:DTIME
 S:'$T!(ACT["^") QT=1
 Q:QT!(ACT="")
 S ACT=$TR(ACT,"ad","AD")
 I ACT'?1U!("AD"'[ACT) W *7,!,REPROMPT G LVOK
 Q:'$D(COM)  S COM=""
 D O1
 Q
 ;
HDR ; Display Header
 W:$E(IOST,1,2)="C-" @IOF W !?26,"VA TIME & ATTENDANCE SYSTEM",!?28,"SUPERVISOR'S APPROVALS"
 S PPE="" D HDR^PRSADP1 S HDR=1 Q
EX G KILL^XUSCLEAN
