PRSAPPX ; HISC/REL-Approve Prior Pay Period Changes ;9/21/95  15:23
 ;;4.0;PAID;**124**;Sep 21, 1995;Build 9
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 K ^TMP($J)
 F DFN=0:0 S DFN=$O(^PRST(458,"AXS",DFN)) Q:DFN<1  F PPI=0:0 S PPI=$O(^PRST(458,"AXS",DFN,PPI)) Q:PPI<1  D CHK
 I '$D(^TMP($J)) S NF=0 G ES
 K AP S QT=0,NF=1,TLE=""
 F  S TLE=$O(^TMP($J,TLE)) Q:TLE=""  F DFN=0:0 S DFN=$O(^TMP($J,TLE,DFN)) Q:DFN<1  F PPI=0:0 S PPI=$O(^TMP($J,TLE,DFN,PPI)) Q:PPI<1  F AUN=0:0 S AUN=$O(^PRST(458,"AXS",DFN,PPI,AUN)) Q:AUN<1  D  G:QT ES
 .D HDR,DIS^PRSASC3 D OK Q:QT
 .I ACT'="" S AP(5,DFN_"~"_PPI_"~"_AUN)=DFN_"^"_ACT
 .Q
ES I '$D(^TMP($J)) W !!,$S('NF:"No Prior Pay Period actions to certify.",1:"No Prior Pay Period certification action taken.") G EX
 D ^PRSAES G:'ESOK EX D NOW^%DTC S NOW=%
 S NOD="AXS",NX="" F  S NX=$O(AP(5,NX)) Q:NX=""  D APP^PRSASC3
 G EX
CHK   ; Check for needed approvals
 N PRSSSSN,PRSESSN ;;Approving Supervisor SSN and Paid Employee SSN
 S PRSSSSN=$P($G(^VA(200,DUZ,1)),U,9),PRSESSN=$P($G(^PRSPC(DFN,0)),U,9)
 I PRSSSSN=PRSESSN,'$D(^XUSEC("PRSA SIGN",DUZ)) Q
 D TLC Q
TLC ; Check T&L
 S TLE=$E($G(^PRST(458,PPI,"E",DFN,5)),22,24) D:"   "[TLE T1 Q:TLE=""
 S TLI=$O(^PRST(455.5,"B",TLE,0)) D:TLI<1 T1 Q:TLI<1  I $D(^PRST(455.5,TLI,"A",DUZ)) S ^TMP($J,TLE,DFN,PPI)=""
 Q
T1 S TLE=$P($G(^PRSPC(DFN,0)),"^",8) Q:TLE=""
 S TLI=$O(^PRST(455.5,"B",TLE,0)) Q
OK R !!,"Disposition (A=Approve, D=Disapprove, X=Cancel, RETURN to bypass): ",ACT:DTIME S:'$T!(ACT["^") QT=1 Q:QT!(ACT="")  S ACT=$TR(ACT,"adx","ADX") I ACT'?1U!("ADX"'[ACT) W *7,!,"Enter A, D or X or Press RETURN to bypass" G OK
 Q
HDR ; Display Header
 W:$E(IOST,1,2)="C-" @IOF W !?26,"VA TIME & ATTENDANCE SYSTEM",!?26,"PRIOR PAY PERIOD CORRECTION"
 S PPE="" D HDR^PRSADP1 S HDR=1 Q
EX S TLE="" F  S TLE=$O(^TMP($J,TLE)) Q:TLE=""  S TLI=$O(^PRST(455.5,"B",TLE,0))  D:TLI APP^PRSASAL
 K ^TMP($J) G KILL^XUSCLEAN
