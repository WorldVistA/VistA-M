IBODISP ;ALB/AAS - INTEGRATED BILLING - OUTPUTS ; 8-MAR-91
 ;;2.0; INTEGRATED BILLING ;**17,199**; 21-MAR-94
 ;
EN ;
 ;***
 ;I $D(XRT0) S:'$D(XRTN) XRTN="EN^IBODISP" D T1^%ZOSV ;stop rt clock
 ;S XRTL=$ZU(0),XRTN="EN^IBODISP-1" D T0^%ZOSV ;start rt clock
 ;  -display ib action by reference number
 S DIC="^IB(",DIC(0)="AEQM" D ^DIC K DIC G ENQ:+Y<1 S DA=+Y D DISP G EN
 ;***
 ;I $D(XRT0) S:'$D(XRTN) XRTN="EN^IBODISP" D T1^%ZOSV ;stop rt clock
 Q
 ;
DISP S DIC="^IB(",DR="0:1" D EN^DIQ
 Q
ENQ K DIC,DA,DR,Y,X,IBQT
 Q
EN1 ;
 ;***
 ;I $D(XRT0) S:'$D(XRTN) XRTN="EN1^IBODISP" D T1^%ZOSV ;stop rt clock
 ;S XRTL=$ZU(0),XRTN="EN1^IBODISP-1" D T0^%ZOSV ;start rt clock
 ;
 ;  -display ib action by patient [by date]
 N DPTNOFZY S DPTNOFZY=1  ;Suppress PATIENT file fuzzy lookups
 S DIC="^DPT(",DIC(0)="AEQM" D ^DIC K DIC G EN1Q:+Y<1 S DFN=+Y
 D DATE^IBOUTL G:'IBEDT EN1
 ;  -loop through inverse dates by patient and display
 S S=2,IBDT=IBBDT-.0000001,(IBQUIT,IBOCNT)=0
 F IBI=0:0 S IBDT=$O(^IB("APTDT",DFN,IBDT)) Q:'IBDT!(IBDT>(IBEDT+.24))  F IBJJ=0:0 S IBJJ=$O(^IB("APTDT",DFN,IBDT,IBJJ)) Q:'IBJJ!('S)!($D(DTOUT))  S DA=IBJJ,IBOCNT=IBOCNT+1 I DA D DISP,PAUSE^IBOUTL G:IBQUIT EN1
 I IBOCNT<1 W !!,"No IB Actions Found for this Date Range",!!
 G EN1
EN1Q K DIC,DA,DR,IBEDT,IBBDT,IBDT,IBI,IBJ,IBJJ,IBOCNT,S,X,Y,DFN,D0,IBQUIT
 ;***
 ;I $D(XRT0) S:'$D(XRTN) XRTN="EN1^IBODISP" D T1^%ZOSV ;stop rt clock
 Q
 ;
EN2 ;
 ;  -print list of ib actions
 ;***
 ;S XRTL=$ZU(0),XRTN="EN2^IBODISP-1" D T0^%ZOSV ;start rt clock
 W !!,"Print IB Action Entries by Date Added",!!," ** Please note that this output requires 132 columns **",!
 S DIC="^IB(",L=0,FLDS="[IB LIST]",BY="@12,@"
 D ASK G:$G(IBQT) ENQ
 S DHD="INTEGRATED BILLING ACTIONS FROM: "_FR(1)_" TO: "_TO(1)
 D EN1^DIP
 K DIC,L,FLDS,FR,BY,TO
 D ^%ZISC
 ;***
 ;I $D(XRT0) S:'$D(XRTN) XRTN="EN2^IBODISP" D T1^%ZOSV ;stop rt clock
 Q
ASK ;
 N IBBDT,IBEDT
 D DATE^IBOUTL
 I (IBBDT<1)!(IBEDT<1) S IBQT=1 Q
 S FR=IBBDT_",?",TO=IBEDT_",?"
 S FR(1)=$$DAT1^IBOUTL(FR),TO(1)=$$DAT1^IBOUTL(TO)
 Q
