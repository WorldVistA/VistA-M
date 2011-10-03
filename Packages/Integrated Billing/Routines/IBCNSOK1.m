IBCNSOK1 ;ALB/AAS - Insurance consisitency stuff ; 2/22/93
 ;;Version 2.0 ; INTEGRATED BILLING ;; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
DUPCO(DFN,IBCNS,IBCDFN,IBTALK) ; -- is this a duplicate company for this patient
 ; -- make this call after selecting a company
 ; -- input    DFN = patient file pointer (required)
 ;           IBCNS = new insurance company selected
 ;          IBCDFN = if added to patient ins type mult is required as enter number in multiple
 ;          IBTALK = (optional) if defined and true will write messages to current device if not queued
 ;  -- output      = $p1 - 0 if no other entry 1 if possible dup.
 ;                   $p2 - 1 if another active entry for same company
 ;                   $p3 - 1 if same co, same subscriber
 ;                   $p4 - 1 if same co, same dates
 ;                   $p5 - 1 if same co, same plan
 ;                   $p6 - 1 if spouse insurer but not listed
 ;                   $p7 - 1 if spouse insurer but no employer
 N IBI,IBJ,IBX,IBY,I,J,X,Y,Z,IBDUP,IBACT,IBCDFND
 S (I,IBDUP)=0
 I '$O(^DPT(DFN,.312,0)) G DUPCOQ ; no policies on file, don't bother
 ;
 ; -- use b x-ref
 F  S I=$O(^DPT(DFN,.312,"B",IBCNS,I)) Q:'I  S IBX=$G(^DPT(DFN,.312,I,0)) I $S('$G(IBCDFN):1,I=$G(IBCDFN):0,1:1) D
 .S IBDUP=1
 .S IBACT=$$CHK^IBCNS1(IBX,DT,2) I IBACT S $P(IBDUP,"^",2)=1 ; another active entry
 .I '$G(IBCDFN) Q  ;quit if not stored in dpt
 .I 'IBACT Q
 .;
 .S IBCDFND=$G(^DPT(DFN,.312,+IBCDFN,0)) I IBCDFND=""!(IBCDFND=+IBCDFND) Q
 .I $P(IBX,"^",6)=$P(IBCDFND,"^",6) S $P(IBDUP,"^",3)=1 ; same whose ins.
 .I $P(IBX,"^",4)="",$P(IBCDFND,"^",4)="" S $P(IBDUP,"^",4)=1 ; no expiration date
 .I $P(IBX,"^",8)="",$P(IBCDFND,"^",8)="" S $P(IBDUP,"^",4)=1 ; no effective date
 .; need to figure out overlapping date logic.  not simple
 .I $P(IBX,"^",18)=$P(IBCDFND,"^",18) S $P(IBDUP,"^",5)=1 ; same plan
 .I $P(IBCDFND,"^",6)="s" I $P(^DPT(DFN,0),"^",5)=6!($P(^DPT(DFN,0),"^",5)=7) S $P(IBDUP,"^",6)=1 ; marital status inconsistent
 .I $P(IBCDFND,"^",6)="s",$P($G(^DPT(DFN,.25)),"^")="" S $P(IBDUP,"^",7)=1
 I 'IBDUP G DUPCOQ
 I IBDUP,$G(IBTALK),'$D(ZTQUEUED) D
 .W !!,*7,"Warning:  Insurance Company selected already on file for this patient."
 .I $P(IBDUP,"^",2) W !,"          The previous entry is active."
 .I $P(IBDUP,"^",3) W !,"          The WHOSE INSURANCE are the same."
 .I $P(IBDUP,"^",4) W !,"          The Effective and Expiration dates may cover overlapping dates."
 .I $P(IBDUP,"^",5) W !,"          The Group Plans are the same."
 .I $P(IBDUP,"^",6) W !,"          WHOSE INSURANCE is Spouse, patient marital Status Inconsistent."
 .I $P(IBDUP,"^",7) W !,"          WHOSE INSURANCE is Spouse but no Employer listed."
 .Q
 ;
DUPCOQ Q IBDUP
 ;
DUPPOL(IBCPOL,IBTALK) ; -- is this a duplicate policy for this company
 N I,J,X,Y,Z,IBDUP,IBCNS
 S (I,IBDUP)=0,J=$G(^IBA(355.3,IBCPOL,0)),IBCNS=+J
 F  S I=$O(^IBA(355.3,"B",IBCNS,I)) Q:'I  I I'=IBCPOL S X=$G(^IBA(355.3,I,0)) D
 .Q:'$P(X,"^",2)  ;skip individual policies
 .I $P(J,"^",3)'="",$P(J,"^",3)=$P(X,"^",3) S $P(IBDUP,"^")=1
 .I $P(J,"^",4)'="",$P(J,"^",4)=$P(X,"^",4) S $P(IBDUP,"^",2)=1
 I IBDUP,$G(IBTALK),'$D(ZTQUEUED) D
 .I $P(IBDUP,"^",1) W !!,"Warning:  There is another policy with the same Group Name."
 .I $P(IBDUP,"^",2) W !!,"Warning:  There is another policy with the same Group Number."
 ;
DUPPOLQ Q IBDUP
