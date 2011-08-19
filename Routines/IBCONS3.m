IBCONS3 ;ALB/AAS - NSC W/INSURANCE OUTPUT, TRACKING INTEFACE ; 21-OCT-93
 ;;2.0;INTEGRATED BILLING;**19,36,91,120**;21-MAR-94
 ;
TRACK ; -- Claims tracking interface for patients with insurance reports.
 ;
 I $D(ZTQUEUED),$$S^%ZTLOAD S (ZTSTOP,IBQUIT)=1
 ;
 N IBNO,IBTRN,IBXX
 S IBRMARK=""
 ; -- if there get reason not billable
 I IBINPT D  ;look for inpatient tracking records
 .Q:'$G(IBADMVT)
 .S IBTRN=$O(^IBT(356,"AD",+IBADMVT,0))
 .Q:'$G(IBTRN)
 .S IBRMARK=$$RMARK(IBTRN)
 .Q
 ;
 I 'IBINPT D  ;look for outpatient tracking records
 .I $G(IBOE) S IBTRN=$O(^IBT(356,"ASCE",+IBOE,0))
 .;Patch 36 if assoc stop code link to primary encounter IBOE
 .I '$G(IBTRN) S IBXX=$$SCE^IBSDU(+IBOE,6) S:IBXX IBTRN=$O(^IBT(356,"ASCE",+IBXX,0))
 .I $P($G(IBOE(1)),U,2),'($G(IBTRN)) N X,IBTMP F IBNO=1:1 Q:$G(IBOE(IBNO))=""  F X=1:1 Q:($P(IBOE(IBNO),U,X)="")!($G(IBTRN))  D
 ..S IBTMP=$P(IBOE(IBNO),U,X)
 ..I $O(^IBT(356,"ASCE",+IBTMP,0)) S IBTRN=$O(^IBT(356,"ASCE",+IBTMP,0)) Q
 .I '$G(IBTRN) D
 ..N IBETYP S IBETYP=+$O(^IBE(356.6,"B","OUTPATIENT VISIT",0))
 ..S X=$O(^IBT(356,"APTY",DFN,IBETYP,($P(I,".")-.0000001))) S:$P(X,".")=$P(I,".") IBTRN=$O(^(X,0))
 .Q:'$G(IBTRN)
 .S IBRMARK=$$RMARK(IBTRN)
 .Q
 ;
 ; -- if not in ct and parameter set to add, add to ct. (INPT ONLY P120)
 I IBINPT,'$G(IBTRN),$P(IBTRKR,"^",23) D ADD
 ;
TRACKQ Q
 ;
ADD ; -- if not there see if should add
 ;    if inpatient, not before ct start date, inpt tracking on
 I IBINPT,I'<+IBTRKR,$P(IBTRKR,"^",2) D
 .;
 .Q:'$G(IBADMVT)
 .N I,J,X,Y,DA,DR,DIE,DIC,IBETYP,IBADMDT,IBTRN
 .S IBADMDT=$P(^DGPM(IBADMVT,0),"^")
 .S IBETYP=+$O(^IBE(356.6,"B","INPATIENT ADMISSION",0))
 .S IBTRN=$O(^IBT(356,"ASCH",+$$SCH^IBTRKR2(IBADMVT),0))
 .D:'IBTRN ADDT^IBTUTL
 .I IBTRN<1 Q
 .S DA=IBTRN,DIE="^IBT(356,"
 .L +^IBT(356,+IBTRN):10 I '$T Q
 .S DR=$$ADMDR^IBTUTL(IBADMDT,IBETYP,IBADMVT,0)
 .D ^DIE
 .L -^IBT(356,+IBTRN)
 .Q
 ;
 ; patch 120, removed add opt to CT from here to call tracker routine to add opt CT entries so will get all the non-billable checks
ADDQ Q
 ;
RMARK(IBTRN) ; -- returns external reason not billable
 Q $P($G(^IBE(356.8,+$P($G(^IBT(356,+$G(IBTRN),0)),"^",19),0)),"^")
