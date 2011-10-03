IVMPMTE ;ALB/KCL/CJM/JAN - MEANS TEST EVENT DRIVER INTERFACE ; 07-MAR-01
 ;;2.0;INCOME VERIFICATION MATCH;**1,9,17,39,49,89**;21-OCT-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;  Input - DFN the patient's internal entry number.
 ;          DGMTI the Means Test internal entry number.
 ;          DGMTINF the Means Test Interactive/Non-interactive flag.
 ;          DGMTACT the Means Test event type
 ;          DGMTP annual Means Test 0th node prior to Add, Edit
 ;                or Delete.
 ;          DGMTA annual Means Test 0th node after Add, Edit or Delete.
 ;
 ; Output - None.
 ;
 ;
EN ; Entry point
 N EVENTS,IVMDA
 S EVENTS("IVM")=1
 ;
 ; Quit if supported Means Test variables are not defined
 Q:'$D(DFN)!('$D(DGMTA))!('$D(DGMTP))!('$D(DGMTINF))!('$D(DGMTACT))
 ;
 ; - no processing required when uploading or deleting
 ; - an IVM-verified Means Test
 Q:DGMTACT="UPL"!(DGMTACT="DUP")
 I DGMTP]"",DGMTA]"",DGMTACT="DEL" Q
 ;
 ; Prevent DCD/other income tests uploaded from HEC to trigger a
 ; transmission back to HEC (quit if source of test isn't VAMC)
 N DGST S DGST=$S(+DGMTA:+$P(DGMTA,U,23),1:+$P(DGMTP,U,23))
 Q:$P($G(^DG(408.34,DGST,0)),"^")'="VAMC"&(DGMTACT'="CAT")
 ;
 W:'DGMTINF !,"Checking Income Verification Match (IVM) for changes..."
 S IVMMTDT=$S(DGMTA:+DGMTA,1:+DGMTP) Q:'IVMMTDT  S IVMDT=$$LYR^DGMTSCU1(IVMMTDT)
 S IVMNEW=0 S IVMDA=$O(^IVM(301.5,"APT",DFN,IVMDT,0)) I 'IVMDA S IVMNEW=1 ; Check for entry/previous year in IVM PATIENT file
 I 'IVMNEW D CHK ; If entry in IVM PATIENT file check for Means Test changes
 I IVMNEW,$$IVM^IVMUFNC(DFN,IVMMTDT),($E(IVMDT,1,3)=($E(DT,1,3)-1)) I $$LOG^IVMPLOG(DFN,IVMDT,.EVENTS) ; new & meets crtieria & current year
 ;
 ;log patient for transmission if patient meets DCD criteria
 D LOGDCD^IVMCUC(DFN,IVMMTDT)
 ;
 ; Quit when uploading Future Means Tests
 Q:$G(IVM1)>DT
 ;
 ; Update cross references when editing Future Dated Tests
 I $D(DGMTI),+$G(DGMT0)>DT,$D(IVMDA) D
 .I DGMTYPT=1,$P(^IVM(301.5,IVMDA,0),U,6)'="",+DGMTA'>DT S DATA(.06)="" I $$UPD^DGENDBS(301.5,IVMDA,.DATA) K DATA,^IVM(301.5,"AC",+DGMT0,IVMDA,DGMTI)
 .I DGMTYPT=2,$P(^IVM(301.5,IVMDA,0),U,7)'="",+DGMTA'>DT S DATA(.07)="" I $$UPD^DGENDBS(301.5,IVMDA,.DATA) K DATA,^IVM(301.5,"AD",+DGMT0,IVMDA,DGMTI)
 ;
ENQ ; Cleanup
 W:'DGMTINF "completed."
 K DA,DIC,DIE,DLAYGO,DR,IVMDA,IVMDT,IVMFLG,IVMMTDT,IVMNEW,X,Y
 Q
CHK ; Check if Means Test has been ADDED, DELETED, or EDITED
 S IVMFLG=0
 F X=1,2,3,4,5,7,10,12,15,18 Q:IVMFLG=1  D
 .I $P(DGMTA,"^",X)'=$P(DGMTP,"^",X) S IVMFLG=1 I $$SETSTAT^IVMPLOG(IVMDA,.EVENTS) ; If MT changes then edit IVM PATIENT file
 Q
