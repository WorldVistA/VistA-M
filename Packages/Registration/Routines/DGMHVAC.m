DGMHVAC ;HIRMFO/WAA-REACTIONS SELECT ROUTINE ;6/9/05  11:12
 ;;5.3;Registration;**903**;Aug 13, 1993;Build 82
 ;
 ; Submitted to OSEHRA 04/02/2015 by HP
 ; All entry points authored by James Harris 2014-2015
 ;
 ;
EN(DFN,DGABB) ; Entry point for MHV Enrollment/Registration 'screen'
 ; Allow editing only if "1" is selected, always begin with Registered? field, since subsequent field logic is dependent
 N DIR,DGMHVOUT,DGMHVQ,DGMHVI,DGRSPNS S DGMHVQ=0
 F DGMHVI=1:1 Q:$G(DGMHVOUT)  D
 .I DGMHVI=1&'$G(DGABB) S DGRSPNS=$$DSPENR^DGMHVUTL(DFN,.DGMHVOUT)
 .Q:$G(DGMHVOUT)
 .D MAIN(DFN,.DGRSPNS)
 .S DGRSPNS=$$DSPENR^DGMHVUTL(DFN,.DGMHVOUT)
 Q
 ;
MAIN(DFN,DGABB) ; Main Driver for Enrollment/Registration 'screen'. 
 ; Prompt for three MHV Enrollment/Registration fields - include previously entered values as defaults
 ; Copy NO value and reason entered at any field to all subsequent fields.
 ; Do not prompt for subsequent field unless 'YES' is entered at current field.
 ; (A)ction (in progress) is treated as UNANSWERED.
 N DGRPFLD,DGMHV,DGMHAC,DGMHSEL,DGMHVNOW,DGRSNPT,DGRSNTXT,X,Y,DGRNSPT,DGRTFLD
 S DGMHAC="",DGMHSEL="",DGMHVNOW=$$NOW^XLFDT
 I '$G(DGABB) D CLEAR^DGMHV W !!!
 K DIRUT W !
 S DGMHVQ=0
 ;
 ; Don't ask enrollment/registration question if 'abbreviated' mode and already populated with YES
 ; Patient MHV Enrolled/Registered?
 D  ; Enrollment/Registration prompt
 .I $G(DGABB)&($G(DGABB)>1) S DGMHV("ENROLLED")=$$GETEN^DGMHVUTL(DFN) Q  ; Skip- either abbreviated+already answered, or user selected another
 .D ENROLL
 Q:$G(DGMHVOUT)!$G(DGMHVQ)
 K DIRUT W !
 ;
 ; Patient MHV Authenticated?
 D  ; Authentication prompt
 .I $G(DGABB)&($G(DGABB)>2) S DGMHV("AUTH")=$$GETAUTH^DGMHVUTL(DFN) Q
 .D AUTHENT
 Q:$G(DGMHVOUT)!$G(DGMHVQ)
 ;
 ; Secure Messaging
 D  ; Secure Messaging prompt
 .D SECMSG
 ;
 Q
 ;
ENROLLQ(MHV,DGMHVNOW) ; Prompt for "MHV Enrolled/Registered"
 N ENDFLT,DIR,DA,X,Y S Y=""
 D CLEAR^DGMHV
 W !,"Step 1 of 3: My HealtheVet Registration",!,"----------------------------------------",!
 S ENDFLT=$P($G(^DPT(DFN,2)),"^")
 S ENDFLT=$S(ENDFLT=1:"YES",ENDFLT=0:"NO",1:"")
 S DIR(0)="Y",DIR("B")=ENDFLT
 S DIR("A")="Is the patient registered on My HealtheVet (Yes/No)"
 K DIRUT D ^DIR  Q:$D(DIRUT)
 S MHV("ENROLLED")=$S($G(Y):1,1:0)
 Q
 ;
AUTHENQ(MHV,DGMHVNOW) ; Prompt for "MHV Authenticated"
 I '$G(MHV("ENROLLED")) S DGMHVQ=1 Q
 D CLEAR^DGMHV
 W !,"Step 2 of 3: My HealtheVet Authentication Upgrade",!,"-------------------------------------------------------------",!
 N AUDFLT,DIR,DA,X,Y,DGTXT,DGTXTCNT
 D CANTXT^DGMHVUTL("AUTH",,,71)
 W !
 S AUDFLT=$P($G(^DPT(DFN,2)),"^",2),AUDFLT=$S(AUDFLT=1:"YES",AUDFLT=0:"NO",AUDFLT=2:"ACTION",1:"")
 S DIR(0)="SAO^Y:YES;N:NO;A:ACTION"
 S DIR("B")=AUDFLT
 S DIR("A",1)="Select (Y) YES if patient already has a Premium My HealtheVet account."
 S DIR("A",2)="Select (A) ACTION if patient wants to upgrade to Premium My HealtheVet account."
 S DIR("A",3)="Select (N) NO if patient refuses to upgrade to a Premium My HealtheVet account."
 S DIR("A",4)=""
 S DIR("A")="(Yes/No/(A)ction): "
 K DIRUT D ^DIR I $D(DIRUT) W ! Q
 S MHV("AUTH")=$S(Y="Y":1,Y="A":2,1:0)
 S DGTXT=""
 I MHV("AUTH")'=2 S MHV("AUTH","DATE")=DGMHVNOW
 I MHV("AUTH")=1 S DGTXT="- Patient already has a Premium My HealtheVet account."
 I MHV("AUTH")=0 S DGTXT="- Patient refuses to upgrade to a Premium My HealtheVet account."
 I MHV("AUTH")=2 S DGTXT="- Patient would like to upgrade to a Premium My HealtheVet account."
 I DGTXT]"" D TXT^DGMHV(DGTXT,50) I $G(MARX) F DGTXTCNT=1:1:+$G(MARX) D
 .I DGTXTCNT=1 W MARX(DGTXTCNT) Q
 .W !,MARX(DGTXTCNT)
 W !
 Q
 ;
OPTINQ(MHV,DGMHVNOW) ; Prompt for "Use MHV Secure Messaging" - Note previous wording was Opt In
 I '$G(MHV("AUTH")) S DGMHVQ=1 Q
 D CLEAR^DGMHV
 W !,"Step 3 of 3: My HealtheVet Secure Messaging",!,"--------------------------------------------",!
 N MSGDFLT,DIR,DA,X,Y
 D CANTXT^DGMHVUTL("SMSG",,,71)
 W !
 S MSGDFLT=$P($G(^DPT(DFN,2)),"^",3),MSGDFLT=$S(MSGDFLT=1:"YES",MSGDFLT=0:"NO",MSGDFLT=2:"ACTION",1:"")
 S DIR(0)="SAO^Y:YES;N:NO;A:ACTION",DIR("B")=MSGDFLT
 S DIR("A",1)="Select (Y) YES if patient already uses Secure Messaging."
 S DIR("A",2)="Select (A) ACTION if patient would like to use Secure Messaging."
 S DIR("A",3)="Select (N) NO if patient declines to use Secure Messaging."
 S DIR("A",4)=""
 S DIR("A")="Secure Messaging? (Yes/No/(A)ction): "
 K DIRUT D ^DIR I $D(DIRUT) W ! Q
 S MHV("OPTINQ")=$S(Y="Y":1,Y="A":2,1:0)
 S DGTXT=""
 I MHV("OPTINQ")'=2 S MHV("AUTH","DATE")=DGMHVNOW
 W !
 Q
 ;
ENROLL  ; MHV Enrollment/Registration
 D ENROLLQ(.DGMHV,.DGMHVNOW) I $D(DIRUT) S DGMHVOUT=1,DGMHVQ=1 Q
 Q:$G(DGMHVOUT)!$G(DGMHVQ)
 ; MHV Enrolled/Registered
 I '$G(DGMHV("ENROLLED")) S DGRNSPT="",DGRSNTXT="" D  Q:$G(DGMHVOUT)!$G(DGMHVQ)
 .N DGADFLT,UTILITY,DIC,DA,DR S DIC=2,DA=DFN,DR="537036" D GETS^DIQ(DIC,DFN,DR,"I","UTILITY")
 .S DGADFLT=$G(UTILITY(2,DFN_",",537036,"I"))
 .D GETRSN("patient is not registered",.DGRSNPT,.DGRSNTXT,DGADFLT,2.1) Q:$G(DGMHVOUT)!$G(DGMHVQ)
 .I $D(DIRUT)!$G(DGMHVOUT) S DGMHVQ=1,DGMHVOUT=1 Q
 .F DGRPFLD=537033:1:537035 D FILRNA(DFN,DGRPFLD,"@")
 .F DGRPFLD=537036:1:537038 D FILRNA(DFN,DGRPFLD,DGRSNPT)
 .I $P($G(^DGMHV(390.03,DGRSNPT,0)),"^")="Other" F DGRTFLD=537033:1:537035 D FILRNA(DFN,DGRTFLD,DGRSNTXT)
 .N DIE,DR,DA S DIE="^DPT(",DR="537027////"_+DGMHV("ENROLLED")_";537030////"_DGMHVNOW,DA=DFN D ^DIE
 .N DIE,DR,DA S DA=DFN,DIE="^DPT(",DR="537028////0;537029////0;537031////"_DGMHVNOW_";537032////"_DGMHVNOW D ^DIE
 .D FILACT(DFN,3),FILACT(DFN,4)
 I $G(DGMHV("ENROLLED")) D
 .Q:$G(DGABB)&($P($G(^DPT(DFN,2)),U,1)=1)  ; Quit if 'abbreviated' mode and this was answered previously
 .N DGOLDEN S DGOLDEN=$P($G(^DPT(DFN,2)),"^")
 .N DIE,DA S DIE="^DPT(",DA=DFN,DR="537027////1;537030////"_DGMHVNOW D ^DIE
 .Q:DGOLDEN=DGMHV("ENROLLED")
 .N DGFLD F DGFLD=537033,537036 D FILRNA(DFN,DGFLD,"@")
 .; If "Registered:" changed from NO or Action to YES, remove NO values in AUTHENTICATED and SECURE MESSAGING
 .N MHVND S MHVND=$G(^DPT(+DFN,2))
 .I $P(MHVND,"^",2)=0 F DGFLD=537028,537031,537034,537037 D FILRNA(DFN,DGFLD,"@")
 .I $P(MHVND,"^",3)=0 F DGFLD=537029,537032,537035,537038 D FILRNA(DFN,DGFLD,"@")
 Q
 ;
AUTHENT  ; Authenticated MHV account status
 D AUTHENQ(.DGMHV,.DGMHVNOW) I $D(DIRUT) S DGMHVOUT=1,DGMHVQ=1 Q
 Q:$G(DGMHVOUT)!$G(DGMHVQ)
 I '$G(DGMHV("AUTH")) S DGRNSPT="",DGRSNTXT="" D CANTXT^DGMHVUTL("UP",1,1) D  Q:$G(DGMHVOUT)!$G(DGMHVQ)
 .W !!,"Patient Not Authenticated Reasons"
 .N DGADFLT,UTILITY,DIC,DA,DR S DIC=2,DA=DFN,DR="537037" D GETS^DIQ(DIC,DFN,DR,"I","UTILITY")
 .S DGADFLT=$G(UTILITY(2,DFN_",",537037,"I"))
 .D GETRSN("patient has not upgraded/authenticated",.DGRSNPT,.DGRSNTXT,DGADFLT,2.2) Q:$G(DGMHVOUT)!$G(DGMHVQ)
 .I $D(DIRUT)!$G(DGMHVOUT) S DGMHVQ=1,DGMHVOUT=1 Q
 .F DGRPFLD=537034,537035 D FILRNA(DFN,DGRPFLD,"@")
 .F DGRPFLD=537037,537038 D FILRNA(DFN,DGRPFLD,DGRSNPT)
 .I $P($G(^DGMHV(390.03,DGRSNPT,0)),"^")="Other" F DGRTFLD=537034:1:537035 D FILRNA(DFN,DGRTFLD,DGRSNTXT)
 .N DIE,DR,DA S DA=DFN
 .S DIE="^DPT(",DR="537028////"_DGMHV("AUTH")_";537031////"_DGMHVNOW_";537029////0;537032////"_DGMHVNOW
 .D ^DIE
 .D FILACT(DFN,3),FILACT(DFN,4)
 I $G(DGMHV("AUTH"))=1 D
 .N DGOLDAU S DGOLDAU=$P($G(^DPT(DFN,2)),"^",2)
 .N DIE,DA S DIE="^DPT(",DA=DFN,DR="537028////1;537031////"_DGMHVNOW D ^DIE
 .Q:DGOLDAU=DGMHV("AUTH")  ; User accepted default, nothing changed
 .;iF AUTHENTICATED is changed to YES then delete all Decline Text / Reason and Action
 .F DGFLD=537034,537037 D FILRNA(DFN,DGFLD,"@")
 .D FILACT(DFN,4)
 .;iF AUTHENTICATED is changed to YES then delete all SECURE MESSAGE elements
 .F DGFLD=537029,537032,537035,537038 D FILRNA(DFN,DGFLD,"@")
 .D FILACT(DFN,3)
 I $G(DGMHV("AUTH"))=2 D CANTXT^DGMHVUTL("UP",,1) D  S DGMHVQ=1 Q  ; Action entered instead of yes or no
 .N DGOLDAU S DGOLDAU=$P($G(^DPT(DFN,2)),"^",2)
 .W !! N DGDPTSOC,DGMHSEL S DGDPTSOC=+$O(^DPT(DFN,1,"A"),-1)+1 D ACTIONS^DGMHV(.DGMHAC,.DGMHSEL,DGDPTSOC,"A")
 .N DGCURSEL S DGCURSEL=$O(DGMHSEL(0)) I 'DGCURSEL Q
 .N DIE,DA S DIE="^DPT(",DA=DFN,DR="537028////2;537031////"_DGMHVNOW D ^DIE
 .D FILRNA(DFN,537034,"@"),FILRNA(DFN,537037,"@")
 .D FILACT(DFN,4,.DGMHSEL)
 .Q:DGOLDAU=DGMHV("AUTH")
 .;iF AUTHENTICATED is changed to ACTION then delete all SECURE MESSAGE elements
 .F DGFLD=537029,537032,537035,537038 D FILRNA(DFN,DGFLD,"@")
 .D FILACT(DFN,3)
 W !
 Q
 ;
SECMSG  ; Secure Messaging
 K DIRUT D OPTINQ(.DGMHV,.DGMHVNOW) I $D(DIRUT) S DGMHVOUT=1,DGMHVQ=1
 Q:$G(DGMHVOUT)!$G(DGMHVQ)
 I '$G(DGMHV("OPTINQ")) S DGRNSPT="",DGRSNTXT="" D  Q:$G(DGMHVOUT)
 .N DGMDFLT,UTILITY,DIC,DA,DR S DIC=2,DA=DFN,DR="537038" D GETS^DIQ(DIC,DFN,DR,"I","UTILITY")
 .S DGMDFLT=$G(UTILITY(2,DFN_",",537038,"I"))
 .D GETRSN("not using secure messaging",.DGRSNPT,.DGRSNTXT,DGMDFLT,2.3) Q:$G(DGMHVOUT)!$G(DGMHVQ)
 .I $D(DIRUT)!$G(DGMHVOUT) S DGMHVQ=1,DGMHVOUT=1 Q
 .D FILRNA(DFN,537035,"@")
 .N DIE,DR,DA S DA=DFN,DIE="^DPT(",DR="537029////"_DGMHV("OPTINQ")_";537032////"_DGMHVNOW D ^DIE
 .D FILRNA(DFN,537038,DGRSNPT)
 .I $P($G(^DGMHV(390.03,DGRSNPT,0)),"^")="Other" D FILRNA(DFN,537035,DGRSNTXT)
 .D FILACT(DFN,3)
 I $G(DGMHV("OPTINQ"))=1 D  Q
 .N DIE,DA S DIE="^DPT(",DA=DFN,DR="537029////1;537032////"_DGMHVNOW D ^DIE
 .D FILRNA(DFN,537035,"@"),FILRNA(DFN,537038,"@")
 .D FILACT(DFN,3)
 I $G(DGMHV("OPTINQ"))=2 D  Q
 .N DGOLDMSG S DGOLDMSG=$$GETMSG^DGMHVUTL(DFN)
 .W !! N DGDPTSOC,DGMHSEL S DGDPTSOC=+$O(^DPT(DFN,1,"A"),-1)+1 D ACTIONS^DGMHV(.DGMHAC,.DGMHSEL,DGDPTSOC,"M")
 .N DGCURSEL S DGCURSEL=$O(DGMHSEL(0)) I 'DGCURSEL D  Q
 .N DIE,DA S DIE="^DPT(",DA=DFN,DR="537029////2;537032////"_DGMHVNOW D ^DIE
 .D FILRNA(DFN,537035,"@"),FILRNA(DFN,537038,"@")
 .D FILACT(DFN,3,.DGMHSEL)
 Q
 ;
GETRSN(TXTAD,REASPT,REASTXT,REASDFLT,DGTXTND) ; Prompt for "NO" Reason
 N DGDFTXT,DGMSACT,DIR,X,Y K DIRUT,DGTXTFIN,DGSCR
 S DGSCR=$S($G(DGTXTND)=2.1:1,$G(DGTXTND)=2.2:2,$G(DGTXTND)=2.3:3,1:"")
 S DGDFTXT=$$LKUPRTXT^DGMHVAC(DFN,$G(DGTXTND)),DGTXTFIN=0
 D GETRSNS(.DGMSACT,DGSCR)
 I $G(REASDFLT) N RSNSEL S RSNSEL="" F  S RSNSEL=$O(DGMSACT(RSNSEL)) Q:'RSNSEL  I $G(DGMSACT(RSNSEL,"IEN"))=REASDFLT S REASDFLT=RSNSEL
 D SETDIR(.DGMSACT,TXTAD,$G(REASDFLT))
 S REASPT="" F  Q:$G(REASPT)!$G(DGMHVOUT)  D ^DIR S:(Y>0) REASPT=+$G(DGMSACT(Y,"IEN")) I 'REASPT D
 .N DIR S DIR(0)="Y",DIR("A")="Are you sure you want to quit " D ^DIR I $G(Y)>0 S DGMHVOUT=1
 .N UTILITY,DIC,DA,DR S DIC=2,DA=DFN,DR="537038" D GETS^DIQ(DIC,DFN,DR,"I","UTILITY")
 .S DGMDFLT=$G(UTILITY(2,DFN_",",537038,"I"))
 Q:'$G(REASPT)
 I $P($G(^DGMHV(390.03,REASPT,0)),"^")="Other" F  Q:$G(DGTXTFIN)!$G(DGMHVQ)  D
 .N DIR,X,Y S DIR("B")=$G(DGDFTXT),DIR(0)="FAR^2:250",DIR("A")="Other Reason Text (250 Chars Max): " D ^DIR
 .I $L(Y)>1 S REASTXT=$TR(Y,";^"," ") S DGTXTFIN=1 Q
 .I $G(X)="@" S DGDFTXT="" W "   Deleted",!
 .I $G(X)="^" S DGMHVQ=1 Q
 Q
 ;
FILRNA(DFN,DGFIELD,DGRSPT) ; File selected NO Reason to Patient file
 N DIE,DA,DR
 S DIE="^DPT(",DA=DFN,DR=DGFIELD_"////"_DGRSPT D ^DIE
 Q
 ;
FILACT(DFN,DGNODE,DGACTSEL) ; File selected MHV Action(s) to Patient file
 N NEXT,DGCNT
 S NEXT="A" F  S NEXT=$O(^DPT(DFN,DGNODE,NEXT),-1) Q:'NEXT  D
 .N DIE,DA,DIR S DIE="^DPT("_DFN_","_DGNODE_",",DA(1)=DFN,DA=NEXT,DR=.01_"////@" D ^DIE
 S NEXT=0 F DGCNT=1:1 S NEXT=$O(DGACTSEL(NEXT)) Q:'NEXT  D
 .Q:'$G(DGACTSEL(NEXT,"IEN"))
 .N DA,DINUM,X,DIC S DIC(0)="LEZ",DIC="^DPT(DFN,DGNODE,",DA(1)=DFN,DA=DGCNT,DINUM=DA,X=DGACTSEL(NEXT,"IEN") D FILE^DICN
 Q
 ;
GETRSNS(DGMSACT,DGSCRQ) ; Build and return array of selectable reasons from file 390.03
 N ACTIEN,ACTCNT,ACTTXT,SELCNT,DGSCR S ACTCNT=0,SELCNT=0
 S ACTIEN=0 F  S ACTIEN=$O(^DGMHV(390.03,ACTIEN)) Q:'ACTIEN  S ACTTXT=$P($G(^DGMHV(390.03,ACTIEN,0)),"^"),DGSCR=$P(^(0),"^",2) I ACTTXT]"" D
 .I $G(DGSCRQ),$G(DGSCR) Q:DGSCR'[DGSCRQ
 .S ACTCNT=ACTCNT+1,SELCNT=SELCNT+1,DGMSACT(ACTCNT)=ACTTXT,DGMSACT(ACTCNT,"IEN")=ACTIEN
 Q
 ;
SETDIR(DGMSACT,TXTAD,DGMDEF) ; Put incoming array of reasons into DIC("A")
 S DIR(0)="SA^",DIR("A",1)="",DIR("B")=$G(DGMDEF)
 S ACTCNT=0 F  S ACTCNT=$O(DGMSACT(ACTCNT)) Q:'ACTCNT  S DIR(0)=DIR(0)_ACTCNT_":"_DGMSACT(ACTCNT)_";",DIR("A",ACTCNT+1)="     "_ACTCNT_" - "_DGMSACT(ACTCNT)
 S DIR("A",$O(DIR("A","A"),-1)+1)=""
 N LINE,II,MARX,TXL D TXT^DGMHV(TXTAD,30)
 I $O(MARX(""),-1)=1 S DIR("A")="Select reason "_TXTAD_": " Q
 S TXL=0 F II=1:1 S TXL=$O(MARX(TXL)) Q:'TXL  D
 .S LINE=$S(II=1:"Select reason ",1:"")_MARX(TXL)
 .I $O(MARX(TXL))="" S DIR("A")=LINE Q
 .S DIR("A",$O(DIR("A","A"),-1)+1)=""
 S DIR("A")="Select reason "_TXTAD_": "
 Q
 ;
MHVOK(DFN) ; Check patient's MHV enrollment/registration info. 
 ; Logic to activate/deactivate alert
 ; -----------------------------------
 ; 1. If any field contains null (UNANSWERED), return 0
 ; 2. If any field contains "A" (ACTION), return 0
 ; 3. If neither 1 nor 2 is true, and any field contains "N" (NO):
 ;    a. The alert is ON if the date the NO was entered is at least 6 months prior to the current date
 ;    b. The alert is OFF if the date the NO was entered is less than 6 months prior to the current date
 ; 4. If all fields contain "Y" (YES), return 1
 ;
 N DIR,DGIQ,MHVOK,MHVOKND,MHVEN,MHVBAD,UTILITY
 N DIC,DA,DR S DIC=2,DA=DFN,DR="537027:537032" D GETS^DIQ(DIC,DFN,DR,"I","UTILITY")
 M MHVOK(DFN)=UTILITY(2,DFN_",")
 S MHVBAD=0
 F DGIQ=0:1:2 I $G(MHVOK(DFN,537027+DGIQ,"I"))="" S MHVBAD=1
 I $G(MHVBAD) Q 0
 F DGIQ=0:1:2 Q:$G(MHVBAD)  D
 .I $G(MHVOK(DFN,537027+DGIQ,"I"))=0 D  Q
 ..I '$G(MHVOK(DFN,537030+DGIQ,"I")) S MHVBAD=1 Q
 ..I $$FMDIFF^XLFDT($$NOW^XLFDT,MHVOK(DFN,537030+DGIQ,"I"))>179 S MHVBAD=1 D
 ...N DGQ F DGQ=537027+DGIQ:1:537029 Q:DGQ>537029  D FILRNA(DFN,DGQ,"@")
 .I (MHVOK(DFN,537027+DGIQ,"I")="")!(MHVOK(DFN,537027+DGIQ,"I")=2) S MHVBAD=1
 Q $S($G(MHVBAD):0,1:1)
 ;
LKUPRSN(REASON) ; Lookup "NO" Reason in file 390.03
 N DIC,X S DIC="390.03",DIC(0)="ZU",X=+REASON D ^DIC
 Q $P($G(Y(0)),"^")
 ;
LKUPRTXT(DFN,DGRFIELD) ; Lookup "OTHER" Reason free text from PATIENT (#2) file
 S DGRSNTXT=$P($G(^DPT(+DFN,+DGRFIELD)),"^")
 Q $S($L(DGRSNTXT)>1:DGRSNTXT,1:"")
 ;
LKUPACT(ACTION) ; Lookup MHV Action in file 390.02
 N DIC,X S DIC="390.02",DIC(0)="ZU",X=+ACTION D ^DIC
 Q $G(Y(0))
 Q
 ;
LASTACHK(DFN,ACTXT) ; Check if ACTXT contains the text matching the most recent ACTION entered for patient DFN
 N DGMATCH,DGLST5,DGLST1,DGL1TXT S DGMATCH=0,DGLST5=""
 D GETLACT^DGMHVUTL(DFN,.DGLST5) S DGLST1=$O(DGLST5($$NOW^XLFDT),-1)
 I $G(DGLST1) D
 . S DGL1TXT=$G(DGLST5(DGLST1,1,"TXT",1))
 . I $E($G(ACTXT),1,$L($G(DGL1TXT)))=$E($G(DGL1TXT),1,$L($G(DGL1TXT))) S DGMATCH=1
 Q $S($G(DGMATCH):1,1:0)
