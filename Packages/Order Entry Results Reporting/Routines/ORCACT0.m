ORCACT0 ;SLC/MKB-Validate order action ;5/19/08
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**7,27,48,72,86,92,94,141,165,177,173,190,215,243,289**;Dec 17, 1997;Build 3
 ;
 ;Reference to REFILL^PSOREF supported by IA #2399
 ;
VALID(IFN,ACTION,ERROR,NATR) ; -- Determines if action is valid for order IFN
 N OR0,OR3,ORA0,AIFN,PKG,DG,ORDSTS,ACTSTS,VER,X,Y,MEDPARM K ERROR
 S OR0=$G(^OR(100,+IFN,0)),OR3=$G(^(3)),PKG=$$NMSP^ORCD($P(OR0,U,14))
 S DG=$P($G(^ORD(100.98,+$P(OR0,U,11),0)),U,3)
 S MEDPARM=$S($G(NATR)="A":2,PKG'="PS":2,'$D(^XUSEC("OREMAS",DUZ)):2,DG="NV RX":$$GET^XPAR("ALL","OR OREMAS NON-VA MED ORDERS"),1:$$GET^XPAR("ALL","OR OREMAS MED ORDERS"))
 S AIFN=$P(IFN,";",2) S:'AIFN AIFN=+$P(OR3,U,7)
 S ORA0=$G(^OR(100,+IFN,8,AIFN,0)),ACTSTS=$P(ORA0,U,15)
 S ORDSTS=$P(OR3,U,3),VER=$S($P(OR0,U,5)["101.41":3,1:2)
CM I ACTION="CM" S ERROR="This action is no longer available!" G VQ ; ward comments - no restrictions
FL I ACTION="FL" D  G VQ ; flag
 . I +$G(^OR(100,+IFN,8,AIFN,3)) S ERROR="This order is already flagged!" Q
UF I ACTION="UF" D  G VQ ; unflag
 . I '+$G(^OR(100,+IFN,8,AIFN,3)) S ERROR="This order is not flagged!" Q
DC1 I ACTION="DC",ACTSTS D  G VQ ; discontinue/cancel unrel or canc order
 . I (ACTSTS=11)!(ACTSTS=10) D  Q  ; unreleased
 .. I 'MEDPARM S ERROR="You are not authorized to cancel med orders!" Q
 .. I $G(NATR)="A" S X=$O(^ORE(100.2,"AO",+IFN,0)) I X,'$G(^ORE(100.2,X,1)) S ERROR="Future event orders may not be auto-discontinued!" Q
 . I ACTSTS=12 S ERROR="This order has been dc'd due to edit!" Q
 . I ACTSTS=13 S ERROR="This order has been cancelled!" Q
ES I (ACTION="ES")!(ACTION="OC")!(ACTION="RS")!(ACTION="DS") D ES^ORCACT01 G VQ ; sign
VR I ACTION="VR" D  G VQ ; verify
 . I $G(ORVER)="N",$P(ORA0,U,9) S ERROR="This order has been verified!" Q
 . I $G(ORVER)="C",$P(ORA0,U,11) S ERROR="This order has been verified!" Q
 . I $G(ORVER)="R",$P(ORA0,U,19) S ERROR="This order has been reviewed!" Q
 . I (ACTSTS=11)!(ACTSTS=10) S ERROR="This order has not been released to the service." Q
 . I AIFN=1,ORDSTS=5,PKG="PS" S X=$$DISABLED I X S ERROR=$P(X,U,2) Q
DIS S X=$$DISABLED I X S ERROR=$P(X,U,2) G VQ
MN I ACTION="MN" D  G VQ ; manually release (delayed)
 . I ACTSTS'=10,ACTSTS'=11 S ERROR="This order has already been released!" Q
 . I $P(OR0,U,12)="I",'$G(^DPT(+ORVP,.105)) S ERROR="This patient is not currently admitted!"
GMRA I PKG="GMRA" S ERROR="This action is not allowed on an allergy/adverse reaction!" G VQ ; no actions allowed on Allergies
MEDS I PKG="PS",'MEDPARM S ERROR="You are not authorized to enter med orders!" G VQ
RW I ACTION="RW" D RW^ORCACT01 G VQ ; rewrite/copy
XFR I ACTION="XFR" D  G VQ
 . N A
 . S A=""
 . F  S A=$O(^OR(100,+IFN,4.5,"ID","CONJ",A)) Q:'A  I ^OR(100,+IFN,4.5,A,1)="X" S ERROR="Orders with a conjunction of 'EXCEPT' may not be transferred." Q
 . I $G(ERROR)]"" Q
 . D XFR^ORCACT01 ; transfer to in/outpt
RN I ACTION="RN" D RN^ORCACT01 G VQ ; renew
TRM I $$DONE G VQ ; ORDSTS=1,2,7,12,13
EV I ACTION="EV" D  G VQ ; change delay event
 . I ORDSTS'=10,ORDSTS'=11 S ERROR="This order has been released!" Q
 . I DG="NV RX" S ERROR="Non-VA Med orders do not support this action!" Q
 . I $$EVTORDER^OREVNTX(IFN) S ERROR="The release event for this order may not be changed!" Q
 . S X=$P(ORA0,U,4) I X'=2,X'=3 S ERROR="Signed orders may not be delayed to another event!" Q
DC2 I ACTION="DC",ACTSTS="" D  G VQ ; DC released order
 . I $G(NATR)="A" D  Q:$D(ERROR)
 .. S X=$O(^ORE(100.2,"AO",+IFN,0)) I X S:'$G(^ORE(100.2,X,1)) ERROR="Future event orders may not be auto-discontinued!" Q
 .. I $$GET1^DIQ(9.4,+$P(OR0,U,14)_",",1)="PSO",$G(DGPMT)=1 Q  ;177 If admission auto-dc and order is outpt med then no further checking needed
 .. I $G(DGPMT)=1,$P($G(^SC(+$P(OR0,U,10),0)),U,3)'="C" S ERROR="Only outpatient orders may be auto-discontinued!" Q
 .. I $G(DGPMT)'=1,$P($G(^SC(+$P(OR0,U,10),0)),U,3)="C",PKG'="PS" S ERROR="Only inpatient orders may be auto-discontinued!" Q
 . I PKG="RA",ORDSTS=6 S ERROR="Active Radiology orders cannot be discontinued!" Q
 . I PKG="VBEC",ORDSTS=6 S ERROR="Active Blood Product orders cannot be discontinued!" Q
 . I PKG="LR" D  Q
 .. I $$COLLECTD S ERROR="Lab orders that have been collected may not be discontinued!" Q
 .. I $G(NATR)="A","^12^38^"'[(U_$P($G(DGPMA),U,18)_U),$$VALUE^ORX8(+IFN,"COLLECT")="SP",$P(OR0,U,8)'<DT S ERROR="Future Send Patient orders may not be auto-discontinued!" Q
 . I PKG="GMRC",ORDSTS=9 S ERROR="Consults orders with partial results cannot be discontinued!" Q
 . I DG="DO",$G(DGPMT)'=3,ORDSTS=6,'$$NPO(+IFN) S ERROR="Active Diets cannot be discontinued; please order a new diet!" Q
RL I ACTION="RL" D  G VQ  ; release hold
 . I ORDSTS'=3 D  Q
 ..I $P(ORA0,U,4)=2 S ERROR="Providers has not yet signed the hold order and therefor it cannot yet be released" Q
 ..S ERROR="Orders not on hold cannot be released!" Q
 . I ACTSTS S ERROR=$$ACTION($P(ORA0,U,2))_" orders cannot be released from hold!" Q
 . N NATR,ACT S ACT=$S($P(ORA0,U,2)="HD":AIFN,1:+$P(OR3,U,7))
 . S NATR=+$P($G(^OR(100,+IFN,8,ACT,0)),U,12),ACT=$P($G(^(0)),U,2)
 . I PKG="RA"!(ACT'="HD")!($P($G(^ORD(100.02,NATR,0)),U,2)="S") S ERROR="Orders held by a service must be released from hold through the service!" Q
AIFN S X=$P(ORA0,U,2) I AIFN>1,ACTSTS S ERROR="This action is not allowed on a "_$$ACTION(X)_" order!" G VQ
RF I ACTION="RF" D  G VQ
 . I DG'="O RX" S ERROR="Only Outpatient Med orders may be refilled!" Q
 . I ORDSTS=5 S ERROR="Pending orders may not be refilled!" Q
 . I ORDSTS=7 S ERROR="Expired orders may not be refilled!" Q
 . N X,PSIFN S PSIFN=$G(^OR(100,+IFN,4))
 . S X=$$REFILL^PSOREF(PSIFN) I X'>0 S ERROR=$P(X,U,2) Q
CP I ACTION="CP" D  G VQ ; complete
 . I PKG'="OR" S ERROR="Only generic text orders may be completed through this option!" Q
 . I ORDSTS=11!(ORDSTS=10) S ERROR="This order has not been released!" Q
AL I ACTION="AL" D  G VQ
 . I PKG'="LR",PKG'="RA",PKG'="GMRC" S ERROR="This order does not generate results!" Q
 . I $P(OR3,U,10) S ERROR="This order is already flagged to alert the provider when resulted!" Q
XX I ACTION="XX" D  G VQ ; edit/change
 . I ORDSTS=7 S ERROR="Expired orders may not be changed!" Q
 . D XX^ORCACT01
HD I ACTION="HD" D  G VQ ; hold
 . I PKG="FH" S ERROR="Diet orders cannot be held!" Q
 . I PKG="LR" S ERROR="Lab orders cannot be held!" Q
 . I PKG="RA" S ERROR="Radiology orders cannot be held!" Q
 . I PKG="GMRC" S ERROR="Consult orders cannot be held!" Q
 . I DG="NV RX" S ERROR="Non-VA Med orders cannot be held!" Q
 . I ORDSTS=3 S ERROR="This order is already on hold!" Q
 . I ORDSTS'=6,PKG="PS" S ERROR="Only active Pharmacy orders may be held!" Q
 . I (ORDSTS=11)!(ORDSTS=10) S ERROR="This order has not been released to the service." Q
VQ S Y=$S($D(ERROR):0,1:1)
 Q Y
 ;
ACTION(X) ; -- Return text of action X
 N Y S Y=$S(X="NW":"New",X="DC":"Discontinue",X="HD":"Hold",X="RL":"Release Hold",X="RN":"Renew",1:X)
 Q Y
 ;
NPO(ORIFN) ; -- Returns 1 or 0, if order ORIFN is for NPO
 N X,Y S X=$$VALUE^ORX8(+ORIFN,"ORDERABLE",1,"E")
 S Y=$S($E(X,1,3)="NPO":1,1:0)
 Q Y
 ;
COLLECTD() ; -- Lab order collected/active (incl all children)?
 I (ORDSTS=11)!(ORDSTS=10) Q 0 ; unreleased
 I '$O(^OR(100,+IFN,2,0)) Q (ORDSTS'=5)
 ;I ORDSTS'=6 Q 1 ; Parent -> active instead of pending
 N Y,Z S Y=1,Z=0
 F  S Z=$O(^OR(100,+IFN,2,Z)) Q:Z'>0  I $P($G(^OR(100,Z,3)),U,3)=5 S Y=0 Q
 Q Y
 ;
DONE() ; -- sets ERROR if terminal status
 I ORDSTS=1 S ERROR="This order has been discontinued!" Q 1
 I ORDSTS=2 S ERROR="This order has been completed!" Q 1
 I ORDSTS=7,DG'="O RX" S ERROR="This order has expired!" Q 1
 I ORDSTS=12 S ERROR="This order has been changed!" Q 1
 I ORDSTS=13 S ERROR="This order has been cancelled!" Q 1
 I ORDSTS=14 S ERROR="This order has lapsed!" Q 1
 I ORDSTS=15 S ERROR="This order has been renewed!" Q 1
 Q 0
 ;
DISABLED() ; -- Order dialog [or protocol] disabled?
 N X,DLG S DLG=$P(OR0,U,5),X=0 I +DLG'>0 Q X
 I VER'<3,DLG?1.N1";ORD(101.41," S X=$$MSG^ORXD(+DLG) Q X
 S DLG=$S(PKG="RA":"RA OERR EXAM",PKG="GMRC":"GMRCOR CONSULT",1:"")
 I $L(DLG) S DLG=+$O(^ORD(101.41,"AB",DLG,0)),X=$$MSG^ORXD(DLG)
 Q X
