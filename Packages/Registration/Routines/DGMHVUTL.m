DGMHVUTL ;ALB/JCH - Patient MHV Enrollment/Registration - Utilities ;09/12/14 11:30am
 ;;5.3;Registration;**903**;August 13, 1993;Build 82
 ;
 ; Submitted to OSEHRA 04/02/2015 by HP
 ; All entry points authored by James Harris 2014-2015
 ;
 Q
QUESUC(DFN,DGMHVOUT) ; If last action entered by clerk was one of the Socialization actions
 ; from MHV SOCIALIZATION ACTIONS (#390.02) file entries for which "SELECTABLE LOCATIONS" 
 ; includes SOCIALIZATION, display/prompt the "were you successful" message/question
 ;
 N DGSUPTXT
 S DGSUPTXT=$$ENQACHK(DFN)
 I DGSUPTXT]"" D  Q
 .Q:$P($G(^DPT(DFN,2)),"^")
 .N NXT,MARX,DIR,DGTXTCNT S DIR(0)="YA",DIR("A",1)=" Please read the following to the patient:"
 .S DIR("?")=" Enter the patient's response to the question"
 .D TXT^DGMHV(DGSUPTXT,55) S DGTXTCNT=0,NXT=3 F  S DGTXTCNT=$O(MARX(DGTXTCNT)) Q:'DGTXTCNT  D
 ..I '$O(MARX(DGTXTCNT)) S DIR("A")="       "_MARX(DGTXTCNT)_""""_" (Y/N): " Q
 ..S DIR("A",NXT)="      """_MARX(DGTXTCNT),NXT=$G(NXT)+1
 .W ! D ^DIR S DGMHVOUT=$S(Y=1:"R",Y=0:"A",1:"")
 .I $G(DGMHVOUT)="R" N DIE,DA S DIE="^DPT(",DA=DFN,DR="537027////1;537030////"_$$NOW^XLFDT D ^DIE
 .H .5
 K DIR
 Q
 ;
DSPENR(DFN,DGMHVFIN) ; Display patient's MHV Enrollment/Registration information
 ; This is the MHV Registration pseudo-screen display; allow entry of 1 to edit the fields as a group, in sequence.
 N ACTION,ACTIONE,REASON,REASONE,MHVOK,MHVOKND,MHVEN,MHVEN,MHVAU,MHVMSG,DGRSNTXT
 N X,Y,IORVON,IORVOFF,DIR,DIRUT,DGRSNCNT,DGRSPNS,DGSCHTR,DGDIR
 ;
 D HEADER(DFN)
 K MHVOK N DIC,DA,DR S DIQ(0)="I",DIC=2,DA=DFN,DR="537027:537040" D GETS^DIQ(DIC,DFN,DR,"I","MHVOK")
 S MHVEN=$G(MHVOK(2,DFN_",",537027,"I")),MHVAU=$G(MHVOK(2,DFN_",",537028,"I")),MHVMSG=$G(MHVOK(2,DFN_",",537029,"I"))
 S X="IORVON;IORVOFF" D ENDR^%ZISS
 W !!!,"[1]       Registered: ",$S(MHVEN=0:"NO",MHVEN=1:"YES",1:"UNANSWERED") I MHVEN=1!(MHVEN=0) D
 .N ENRDT S ENRDT=$$ENDATE(DFN) I ENRDT&(MHVEN=1) W ?44,"Confirmed: "_ENRDT
 I MHVEN=0 S REASON=$G(MHVOK(2,DFN_",",537036,"I")) I REASON W !?12,"Reason: " S REASONE=$$LKUPRSN^DGMHVAC(REASON) D
 .N DGRSNTXT S DGRSNTXT=$$LKUPRTXT^DGMHVAC(DFN,2.1) I (REASONE="Other")&($L(DGRSNTXT)>1) S REASONE=REASONE_" - "_DGRSNTXT
 .N MARX,I,LINE D TXT^DGMHV(REASONE,58) F I=1:1:$O(MARX(""),-1) S LINE=$G(MARX(I)) D
 ..I I=1 W LINE S DGRSNCNT=1 Q
 ..W !?20,LINE
 ;
 W !!
 I ",1,"[(","_$G(MHVEN)_",") S DGDIR(2)=";2:Authentication" W "[2]"
 W ?7,"Authenticated: ",$S(MHVAU=0:"NO",MHVAU=1:"YES",MHVAU=2:"ACTION/IN PROGRESS",1:"UNANSWERED") D
 .I MHVAU!(MHVAU=0) N AUTHDT S AUTHDT=$$AUTHDATE(DFN) I AUTHDT&(MHVAU=1) W ?44,"Confirmed: "_AUTHDT
 I MHVAU=0,'$G(DGRSNCNT) S REASON=$G(MHVOK(2,DFN_",",537037,"I")) I REASON W !?12,"Reason: " S REASONE=$$LKUPRSN^DGMHVAC(REASON) D
 .N DGRSNTXT S DGRSNTXT=$$LKUPRTXT^DGMHVAC(DFN,2.2) I (REASONE="Other")&($L(DGRSNTXT)>1) S REASONE=REASONE_" - "_DGRSNTXT
 .N MARX,I,LINE D TXT^DGMHV(REASONE,58) F I=1:1:$O(MARX(""),-1) S LINE=$G(MARX(I)) D
 ..I I=1 W LINE S DGRSNCNT=1 Q
 ..W !?21,LINE
 I MHVAU=2 N ACTIEN S ACTIEN="" F  S ACTIEN=$O(^DPT(DFN,4,"B",ACTIEN)) Q:ACTIEN=""  D
 .N ACTTXT,LI S ACTTXT=$P($G(^DGMHV(390.02,+ACTIEN,3,1,0)),"^") I ACTTXT]"" D
 ..N TXTND S TXTND=1 F  S TXTND=$O(^DGMHV(390.02,ACTIEN,3,TXTND)) Q:'TXTND  S ACTTXT=ACTTXT_" "_^DGMHV(390.02,ACTIEN,3,TXTND,0)
 ..Q:$L(ACTTXT)<2  N MARX,INOD,LINE D TXT^DGMHV(ACTTXT,48) F INOD=1:1:$O(MARX(""),-1) S LINE=$G(MARX(INOD)) D
 ...I INOD=1 W !?14,"Action: ",LINE S DGRSNCNT=1 Q
 ...W !?22,LINE
 ;
 W !!
 I ",1,"[(","_$G(MHVAU)_",") S DGDIR(3)=";3:Secure Messaging"  W "[3]"
 W ?4,"Secure Messaging: ",$S(MHVMSG=0:"NO",MHVMSG=1:"YES",MHVMSG=2:"ACTION/IN PROGRESS",1:"UNANSWERED") D
 .I MHVMSG!(MHVMSG=0) N MSGDT S MSGDT=$$MSGDATE(DFN) I MSGDT&(MHVMSG=1) W ?44,"Confirmed: "_MSGDT
 I MHVMSG=0,'$G(DGRSNCNT) S REASON=$G(MHVOK(2,DFN_",",537038,"I")) I REASON W !?12,"Reason: " S REASONE=$$LKUPRSN^DGMHVAC(REASON) D
 .N DGRSNTXT S DGRSNTXT=$$LKUPRTXT^DGMHVAC(DFN,2.3) I REASONE="Other"&($L(DGRSNTXT)>1) S REASONE=REASONE_" - "_DGRSNTXT
 .N MARX,I,LINE D TXT^DGMHV(REASONE,60) F I=1:1:$O(MARX(""),-1) S LINE=$G(MARX(I)) D
 ..I I=1 W LINE S DGRSNCNT=1 Q
 ..W !?20,LINE
 I MHVMSG=2 N ACTIEN S ACTIEN="" F  S ACTIEN=$O(^DPT(DFN,3,"B",ACTIEN)) Q:ACTIEN=""  D
 .N ACTTXT,LI S ACTTXT=$P($G(^DGMHV(390.02,+ACTIEN,3,1,0)),"^") I ACTTXT]"" D
 ..N TXTND S TXTND=1 F  S TXTND=$O(^DGMHV(390.02,ACTIEN,3,TXTND)) Q:'TXTND  S ACTTXT=ACTTXT_" "_^DGMHV(390.02,ACTIEN,3,TXTND,0)
 ..Q:$L(ACTTXT)<2  N MARX,INOD,LINE D TXT^DGMHV(ACTTXT,48) F INOD=1:1:$O(MARX(""),-1) S LINE=$G(MARX(INOD)) D
 ...I INOD=1 W !?14,"Action: ",LINE S DGRSNCNT=1 Q
 ...W !?22,LINE
 W !!!!!!!
 K DIRUT S DGMHVFIN=0
 K DGABB
 S DGSCHTR=$$SELFLDS(DFN)
 N DGDONE F  Q:$G(DGDONE)  D
 .N DIR S DIR("A")="Select a Registration step, or RETURN to continue: "
 .S DIR(0)="SAO^1:Registration"_$G(DGDIR(2))_$G(DGDIR(3))
 .D ^DIR S DGRSPNS=Y I DGSCHTR[(","_DGRSPNS_",") S DGDONE=1 Q
 .I DGRSPNS=""!(DGRSPNS="^") S DGRSPNS="" S DGDONE=1 Q
 .W !," Not a valid response",!
 S DGMHVFIN=$S(DGSCHTR[(","_DGRSPNS_",")=1:0,1:1)
 Q DGRSPNS
 ;
ENQACHK(DFN)  ; Return followup question in DGSUPTXT if last action taken for patient DFN was one of the socialization actions
 N DGSUP1,DGSUP2,DGSUP3,DGACT,DIR
 S DGMHVOUT=$G(DGMHVOUT)
 ; Get MHV SOCIALIZATION ACTIONS (#390.02) file entries for which "SELECTABLE LOCATIONS" 
 ; includes SOCIALIZATION
 ; NOTE: If there are adjustments to the values in files 390.02 this API may need to be updated 
 D GETACTS^DGMHV(.DGACT,"S")
 S DGSUP1="Were you successful in creating your My HealtheVet account?"
 S DGSUP2=$P(DGSUP1,"?")_" during your last visit?"
 S DGSUP3="Were you able to create a My HealtheVet account from the Registration instructions we gave you last time?"
 S DGSUPTXT=$S($$LASTACHK^DGMHVAC(DFN,$G(DGACT(1)))!$$LASTACHK^DGMHVAC(DFN,$G(DGACT(2))):DGSUP2,$$LASTACHK^DGMHVAC(DFN,$G(DGACT(3)))!$$LASTACHK^DGMHVAC(DFN,$G(DGACT(5))):DGSUP1,$$LASTACHK^DGMHVAC(DFN,$G(DGACT(4))):DGSUP3,1:"")
 Q DGSUPTXT
 ;
GETLACT(DFN,DGLACTS) ; Get most recent MHV actions entered by clerk for patient DFN
 ; Input: DFN - Patient IEN
 ; Output: DGLACTS - Array of MHV actions
 ;
 N DGOT,LASTCNT,ACTCNT,X,X1,Y,LASTDT,LASTACT,LASTIEN,ACTCNT,FNDACT,LIENOK S (LASTACT,LASTIEN,DGLACTS,LASTCNT)=""
 S LASTDT="" F LASTCNT=1:1 S LASTDT=$O(^DPT(DFN,1,"B",LASTDT),-1) Q:'LASTDT!($G(DGOT)>4)  D
 .F  S LASTIEN=$O(^DPT(DFN,1,"B",LASTDT,LASTIEN)) Q:'LASTIEN  D
 ..Q:'$O(^DPT(DFN,1,LASTIEN,1,0))  S ACTCNT("DT",LASTIEN)=LASTDT,FNDACT=1,LIENOK=LASTIEN,DGOT=$G(DGOT)+1
 Q:'$G(LIENOK)
 S LIENOK="" F  S LIENOK=$O(ACTCNT("DT",LIENOK)) Q:'LIENOK  N LASTDT S LASTDT=$G(ACTCNT("DT",LIENOK)) D
 .S ACTCNT=0 F  S ACTCNT=$O(^DPT(DFN,1,LIENOK,1,ACTCNT)) Q:'ACTCNT  S ACTCNT(LASTDT,ACTCNT)=^DPT(DFN,1,LIENOK,1,ACTCNT,0) D
 ..N ACTTXT,ACTIEN S ACTIEN=+$G(ACTCNT(LASTDT,ACTCNT)) S ACTTXT=$G(^DGMHV(390.02,ACTIEN,3,1,0)) I ACTTXT]"" D
 ...N TXTND S TXTND=1 F  S TXTND=$O(^DGMHV(390.02,ACTIEN,3,TXTND)) Q:'TXTND  S ACTTXT=ACTTXT_" "_^DGMHV(390.02,ACTIEN,3,TXTND,0)
 ...S ACTCNT(LASTDT,ACTCNT,"IEN")=ACTCNT(LASTDT,ACTCNT)
 ...N MARX D TXT^DGMHV(ACTTXT,60) M ACTCNT(LASTDT,ACTCNT,"TXT")=MARX
 S LASTDT=$O(ACTCNT(0)) I $O(ACTCNT(0)) M DGLACTS=ACTCNT
 Q
 ;
ACTSCRN(ACTIEN,LOCLIST) ; Check on code/functional locations at which MHV actions are selectable
 ; Accepts an ACTION (#390.02) file IEN, returns array LOCLIST(LOC) where LOC is a location at which the action is selectable
 ;
 Q:'$G(ACTIEN)  K LOCLIST S LOCLIST=""
 N ACTLOCN Q:'$D(^DGMHV(390.02,+ACTIEN,1))
 S ACTLOCN=0 F  S ACTLOCN=$O(^DGMHV(390.02,ACTIEN,1,ACTLOCN)) Q:'ACTLOCN  D
 .S LOCLIST=$G(^DGMHV(390.02,ACTIEN,1,ACTLOCN,0)) I LOCLIST S LOCLIST=$P($G(^DGMHV(390.04,LOCLIST,0)),"^") I LOCLIST]"" S LOCLIST(LOCLIST)=""
 Q
 ;
HEADER(DFN) ; Print simulated screen header
 N DGPTINFO,DGSCST,DGNMSSN K ^UTILITY("DIQ1",$J)
 N DIC,DA,DR S DIQ(0)="E",DIC=2,DA=DFN,DR=".01;391" D EN^DIQ1 M DGPTINFO(DFN)=^UTILITY("DIQ1",$J,2,DFN)
 D CLEAR^DGMHV
 W !!?20,"MY HEALTHEVET REGISTRATION STATUS"
 S DGNMSSN=$$SSNNM^DGRPU(DFN)
 W !!,DGNMSSN,?60,$G(DGPTINFO(DFN,391,"E"))
 W !,"================================================================================"
 K ^UTILITY("DIQ1",$J)
 Q
 ;
SELFLDS(DFN) ; Get selectable Enrollment/Registration fields based on values of other fields
 ;
 N MHVEN,MHVAU,MHVMSG,MHVFLDS,DGFLDSEL
 N DIC,DA,DR
 S DIQ(0)="I",DIC=2,DA=DFN,DR="537027:537040" D GETS^DIQ(DIC,DFN,DR,"I","MHVFLDS")
 S MHVEN=$G(MHVFLDS(2,DFN_",",537027,"I")),MHVAU=$G(MHVFLDS(2,DFN_",",537028,"I")),MHVMSG=$G(MHVFLDS(2,DFN_",",537029,"I"))
 N DGFLDSEL S DGFLDSEL=1
 I $S(",0,1,"[(","_$G(MHVEN)_","):1,1:0) S DGFLDSEL=DGFLDSEL_",2"
 I $S(",0,1,"[(","_$G(MHVAU)_","):1,1:0) S DGFLDSEL=DGFLDSEL_",3"
 S DGFLDSEL=","_DGFLDSEL_","
 Q DGFLDSEL
 ;
ENTRYFLD(DFN,DGUNONLY) ; Get first non-firmly answered field either unanswered or action in progress
 ;
 N MHVEN,MHVAU,MHVMSG,MHVFLDS,DGFLDSEL
 N DIC,DA,DR
 S DIQ(0)="I",DIC=2,DA=DFN,DR="537027:537040" D GETS^DIQ(DIC,DFN,DR,"I","MHVFLDS")
 S MHVEN=$G(MHVFLDS(2,DFN_",",537027,"I")),MHVAU=$G(MHVFLDS(2,DFN_",",537028,"I")),MHVMSG=$G(MHVFLDS(2,DFN_",",537029,"I"))
 N DGFLDSEL S DGFLDSEL=""
 I '$G(DGUNONLY) D
 .I MHVMSG=""!(MHVMSG=2) S DGFLDSEL=3
 .I MHVAU=""!(MHVAU=2) S DGFLDSEL=2
 .I MHVEN="" S DGFLDSEL=1
 I $G(DGUNONLY) D
 .I MHVAU=2!(MHVMSG=2) Q
 .I MHVMSG="" S DGFLDSEL=3
 .I MHVAU="" S DGFLDSEL=2
 .I MHVEN="" S DGFLDSEL=1
 Q DGFLDSEL
 ;
GETEN(DFN) ; Get value of MHV Registered
 ;
 N MHVEN,MHVAU,MHVMSG,MHVFLDS,DGFLDSEL
 N DIC,DA,DR
 S DIQ(0)="I",DIC=2,DA=DFN,DR="537027" D GETS^DIQ(DIC,DFN,DR,"I","MHVFLDS")
 S MHVEN=$G(MHVFLDS(2,DFN_",",537027,"I"))
 Q MHVEN
 ;
GETAUTH(DFN) ; Get value of MHV Authenticated
 ;
 N MHVEN,MHVAU,MHVMSG,MHVFLDS,DGFLDSEL
 N DIC,DA,DR
 S DIQ(0)="I",DIC=2,DA=DFN,DR="537028" D GETS^DIQ(DIC,DFN,DR,"I","MHVFLDS")
 S MHVAU=$G(MHVFLDS(2,DFN_",",537028,"I"))
 Q MHVAU
 ;
GETMSG(DFN) ; Get value of MHV Secure Messaging
 ;
 N MHVEN,MHVAU,MHVMSG,MHVFLDS,DGFLDSEL
 N DIC,DA,DR
 S DIQ(0)="I",DIC=2,DA=DFN,DR="537029" D GETS^DIQ(DIC,DFN,DR,"I","MHVFLDS")
 S MHVMSG=$G(MHVFLDS(2,DFN_",",537029,"I"))
 Q MHVMSG
 ;
CANTXT(DGMSG,CLEAR,CONT,DGTXTW) ; Display canned text to read to patient
 Q:$G(DGMSG)']""
 N DGINDEN,TMPCAN,NEXT,CANTXT,MARX,I S CANTXT=""
 F I=0:1 S TMPCAN=$T(@(DGMSG_"+"_I)) Q:TMPCAN'[";"  S CANTXT=CANTXT_$P(TMPCAN,";",2)
 Q:CANTXT=""
 I $G(CLEAR) D CLEAR^DGMHV
 W !,"Please read the following to the patient",!
 S DGTXTW=$S($G(DGTXTW):DGTXTW,1:60)
 D TXT^DGMHV(.CANTXT,DGTXTW)
 S DGINDEN=(80-DGTXTW)/2
 S NEXT=0 F  S NEXT=$O(MARX(NEXT)) Q:'NEXT  D
 .W !?DGINDEN,MARX(NEXT)
 I $G(CONT) W !! D CONT^DGMHV
 Q
 ;
UP ;"Upgrade to a Premium My HealtheVet account to view parts of your VA health record and
 ; use Secure Messaging. This requires one-time in-person identity verification (show
 ; government issued photo ID). Read and sign VA Release of Information form (10-5345a-MHV).
 ; Present a government issued photo ID required. (Instructions for optional online
 ; Authentication process are also available)"
 Q
SMSG ;"With Secure Messaging, Veterans can communicate online with VA health care teams about health, medication questions, request prescription renewals, and/or appointments."
 Q
AUTH ;"With a Premium My HealtheVet account, patients can view VA appointments, lab results, access portions of their VA medical record and use Secure Messaging"
 Q
MHVPCHK(DFN) ; Consistency checker MHV update
 ; Don't trigger update if MHV REGISTERED has not been answered, and Registration socialization action is pending
 N DGMHVOUT,DGMHVQ,DGMHVACT,DP,DG,DK,DH,DM,DQ,DR,DL,X,Y,DC,DE,DIC,DIE,DIIENS,DIFLD,DIETMP,DW,D,D0,DG,DI,DIEL,DU,DV,DIR
 S DGMHVOUT=0,DGMHVQ=0
 S DGMHVACT=$$ENQACHK^DGMHVUTL(DFN) Q:(DGMHVACT]"")&'$G(^DPT(DFN,2))
 S DGMHVACT=$$ENTRYFLD^DGMHVUTL(DFN)
 D MAIN^DGMHVAC(DFN,DGMHVACT)
 S:'$$MHVOK^DGMHVAC(DFN) FILERR(315)=""
 Q
 ;
GETFLDS(DFN,FLDARRAY) ; Get MHV Registration status field and date values, place in array formatted for merging with historical action display
 N DGEN,DGAUTH,DGMSG,DGENDT,DGAUDT,DGMSGDT
 S DGEN=$$GETEN(DFN),DGAUTH=$$GETAUTH(DFN),DGMSG=$$GETMSG(DFN)
 S DGENDT=$$ENDATE(DFN,1),DGAUDT=$$AUTHDATE(DFN,1),DGMSGDT=$$MSGDATE(DFN,1)
 I DGENDT&($G(DGEN)=1) S FLDARRAY(DGENDT,1)="",FLDARRAY(DGENDT,1,"TXT")=1 D
 .S FLDARRAY(DGENDT,1,"TXT",1)="My HealtheVet Registration "_$S(DGEN=1:"confirmed.",1:"")
 I DGAUDT&($G(DGAUTH)=1) S FLDARRAY(DGAUDT,1)="",FLDARRAY(DGAUDT,1,"TXT")=1 D
 .S FLDARRAY(DGAUDT,1,"TXT",1)="My HealtheVet Authenticated/Premium Upgrade "_$S(DGAUTH=1:"confirmed.",1:"")
 I DGMSGDT&($G(DGMSG)=1) S FLDARRAY(DGMSGDT,1)="",FLDARRAY(DGMSGDT,1,"TXT")=1 D
 .S FLDARRAY(DGMSGDT,1,"TXT",1)="My HealtheVet Secure Messaging  "_$S(DGMSG=1:"confirmed.",1:"")
 Q
CONSTAT(DFN,DGFLDNO) ; Write condensed patient MHV status
 N DGEN,DGAUTH,DGMSG,DGMHVFLD
 N DGENDT,DGAUTHDT,DGMSGDT
 N DIQ,DIC,DA,DR,DGDTPC,DGTIMPC
 S DGEN=$$GETEN(DFN)
 S DGAUTH=$$GETAUTH(DFN)
 S DGMSG=$$GETMSG(DFN)
 N DGDASH S $P(DGDASH,"-",78)="-"
 I $G(DGFLDNO(1))!$G(DGFLDNO(2))!$G(DGFLDNO(3)) W !?10,"MHV Registration Progress" ;,?40,"Status" D
 W !,DGDASH
 I $G(DGFLDNO(1)) W !,$$ENDATE(DFN),?10,"[Step 1 of 3]  My HealtheVet Registration: ",?56,$S(DGEN=1:"COMPLETED",DGEN=2:"ACTION PENDING",DGEN=0:"REFUSED",1:"UNANSWERED")
 I $G(DGFLDNO(2)) W !,$$AUTHDATE(DFN),?10,"[Step 2 of 3]  Authentication Upgrade:",?56,$S(DGAUTH=1:"COMPLETED: ",DGAUTH=2:"ACTION PENDING",DGAUTH=0:"REFUSED",1:"UNANSWERED")
 I $G(DGFLDNO(3)) W !,$$MSGDATE(DFN),?10,"[Step 3 of 3]  Secure Messaging Verification:",?56,$S(DGMSG=1:" COMPLETED: "_$$MSGDATE(DFN),DGMSG=2:"ACTION PENDING",DGMSG=0:"REFUSED:",1:"UNANSWERED")
 Q
ENDATE(DFN,INTERNAL) ; Most recent date mhv Registration was updated
 N DGENDT,DGDTPC,DGTIMPC,DIQ,DIC,DA,DR,DGDTPC,DGTIMPC,MHVFLD
 S DIQ(0)="I",DIC=2,DA=DFN,DR="537030" D GETS^DIQ(DIC,DFN,DR,"I","MHVFLD")
 S DGENDT=$G(MHVFLD(2,DFN_",",537030,"I")) I $G(INTERNAL) Q DGENDT
 I DGENDT S DGENDT=$$FMTE^XLFDT(DGENDT,2)
 S $P(DGENDT,"@",2)=$P($P(DGENDT,"@",2),":",1,2)
 S DGENDT=$P(DGENDT,"@")
 Q DGENDT
AUTHDATE(DFN,INTERNAL) ; Most recent date mhv authentication was updated
 N DGAUTHDT,DGDTPC,DGTIMPC,DIQ,DIC,DA,DR,DGDTPC,DGTIMPC,MHVFLD
 S DIQ(0)="I",DIC=2,DA=DFN,DR="537031" D GETS^DIQ(DIC,DFN,DR,"I","MHVFLD")
 S DGAUTHDT=$G(MHVFLD(2,DFN_",",537031,"I")) I $G(INTERNAL) Q DGAUTHDT
 I DGAUTHDT S DGAUTHDT=$$FMTE^XLFDT(DGAUTHDT,2)
 S $P(DGAUTHDT,"@",2)=$P($P(DGAUTHDT,"@",2),":",1,2)
 S DGAUTHDT=$P(DGAUTHDT,"@")
 Q DGAUTHDT
MSGDATE(DFN,INTERNAL) ; Most recent date mhv secure messaging was updated
 N DGMSGDT,DGDTPC,DGTIMPC,DIQ,DIC,DA,DR,DGDTPC,DGTIMPC,MHVFLD
 S DIQ(0)="I",DIC=2,DA=DFN,DR="537032" D GETS^DIQ(DIC,DFN,DR,"I","MHVFLD")
 S DGMSGDT=$G(MHVFLD(2,DFN_",",537032,"I")) I $G(INTERNAL) Q DGMSGDT
 I DGMSGDT S DGMSGDT=$$FMTE^XLFDT(DGMSGDT,2)
 S $P(DGMSGDT,"@",2)=$P($P(DGMSGDT,"@",2),":",1,2)
 S DGMSGDT=$P(DGMSGDT,"@")
 Q DGMSGDT
MHVENABL() ; Get value of "Enable MyHealtheVet Prompts?" from MAS Parameter (#43) file
 ; This API is checked to determine if the MyHealtheVet functionality is enable or not.
 N DIQ,DIC,DA,DR,MHVFLDS
 S DIQ(0)="I",DIC=43,DA=1,DR="1100.07" D GETS^DIQ(DIC,DA,DR,"I","MHVFLDS")
 Q +$G(MHVFLDS(43,DA_",",1100.07,"I"))
