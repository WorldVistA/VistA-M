PSBALL ;BIRMINGHAM/VRN-BCMA RPC BROKER CALLS ;04/22/16  14:14
 ;;3.0;BAR CODE MED ADMIN;**93**;Mar 2004;Build 111
 ;
 ; Reference/IA
 ; EN1^GMRADPT/10099
 ; EN2^GMRADPT/10099  ;93
 ; HAVEHDR^ORRDI1/4659  ;93
 ;
ALLR(RESULTS,DFN) ; Return array of patient allergies/adverse reactions
 ;
 ;RPC: PSB ALLERGY
 ;
 D SORT
 Q
 ;
SORT ;*** Set up the allergies and adv. reactions arrays.
 N REMOTE,GMRA,GMRAL,PSBLCL,REMALL,REMADR,PSBALL,PSBADR,PSBCNT,PSBNM,PSBTYP,X,FIRST
 S PSBCNT=0
 S GMRA="0^0^111" D EN2^GMRADPT ; local results only
 S PSBLCL=GMRAL ; needed to know nka/no assesment (if there are remote results but not local results) 
 S GMRA="0^0^111^1" D EN2^GMRADPT  ; include remote
 S REMOTE=$$HAVEHDR^ORRDI1  ;check if server is up
 I +GMRAL D  ; found local and/or remote results
 .S X="" F  S X=$O(GMRAL(X))  Q:X=""  D  ; seperate into 4 arrays local allergies, local adrs, remote allergies, remote adrs
 ..S PSBTYP=$P(GMRAL(X),U,5),PSBNM=$P(GMRAL(X),U,2)
 ..I X["R" D  Q
 ...S:PSBTYP=0 REMALL(PSBNM)=""
 ...S:PSBTYP>0 REMADR(PSBNM)=""
 ..S:PSBTYP=0 PSBALL(PSBNM)=""
 ..S:PSBTYP>0 PSBADR(PSBNM)=""
 .; add allergies first
 .I '$D(PSBALL) S PSBCNT=PSBCNT+1,RESULTS(PSBCNT)="ALL"_U_$S(PSBLCL="":"No Assessment",1:"No Known Allergies")
 .I $D(PSBALL) S X="" F  S X=$O(PSBALL(X)) Q:X=""  S PSBCNT=PSBCNT+1,RESULTS(PSBCNT)="ALL"_U_X ; add local allergies
 .S RESULTS(PSBCNT)=RESULTS(PSBCNT)_"     Remote Allergies: " ; add remote tag to last local allergy
 .I '$D(REMALL) D  ; no remote allergies
 ..I '$D(REMADR),'REMOTE S RESULTS(PSBCNT)=RESULTS(PSBCNT)_"Remote Data Not Available" Q
 ..S RESULTS(PSBCNT)=RESULTS(PSBCNT)_"None"
 .I $D(REMALL) S X="",FIRST=1 F  S X=$O(REMALL(X)) Q:X=""  D 
 ..I 'FIRST S PSBCNT=PSBCNT+1,RESULTS(PSBCNT)="ALL"_U_X ; add remote allergies to list (will quit if none found)
 ..I FIRST S RESULTS(PSBCNT)=RESULTS(PSBCNT)_X,FIRST=0 ; first one needs to be appended to avoid leading comma added in gui
 .; add adrs next
 .I '$D(PSBADR) S PSBCNT=PSBCNT+1,RESULTS(PSBCNT)="ADR"_U_$S(PSBLCL="":"No Assessment",1:"No Known Reactions")
 .I $D(PSBADR) S X="" F  S X=$O(PSBADR(X)) Q:X=""  S PSBCNT=PSBCNT+1,RESULTS(PSBCNT)="ADR"_U_X ; add local adrs
 .S RESULTS(PSBCNT)=RESULTS(PSBCNT)_"     Remote ADRs: " ; add remote tag to last local adr
 .I '$D(REMADR) D  ; no remote adrs
 ..I '$D(REMALL),REMOTE'>0 S RESULTS(PSBCNT)=RESULTS(PSBCNT)_"Remote Data Not Available" Q
 ..S RESULTS(PSBCNT)=RESULTS(PSBCNT)_"None"
 .I $D(REMADR) S X="",FIRST=1 F  S X=$O(REMADR(X)) Q:X=""  D
 ..I 'FIRST S PSBCNT=PSBCNT+1,RESULTS(PSBCNT)="ADR"_U_X ; add remote adrs to list (will quit if none found)
 ..I FIRST S RESULTS(PSBCNT)=RESULTS(PSBCNT)_X,FIRST=0 ; first one needs to be appended to avoid leading comma added in gui
 E  D  ; did not find local or remote results
 .S PSBCNT=PSBCNT+1,RESULTS(PSBCNT)="ALL"_U_$S(PSBLCL="":"No Assessment",1:"No Known Allergies")
 .S RESULTS(PSBCNT)=RESULTS(PSBCNT)_$S('REMOTE:"   Remote: Remote Data Not Available",1:"     Remote Allergies: None")
 .S PSBCNT=PSBCNT+1,RESULTS(PSBCNT)="ADR"_U_$S(PSBLCL="":"No Assessment",1:"No Known Reactions")
 .S RESULTS(PSBCNT)=RESULTS(PSBCNT)_$S('REMOTE:"   Remote: Remote Data Not Available",1:"     Remote ADRs: None")
 S RESULTS(0)=PSBCNT
 Q
