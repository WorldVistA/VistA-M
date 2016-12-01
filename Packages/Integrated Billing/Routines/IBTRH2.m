IBTRH2 ;ALB/YMG - HCSR worklist expand entry ;18-JUN-2014
 ;;2.0;INTEGRATED BILLING;**517**;21-MAR-94;Build 240
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
EN ; main entry point for IBT HCSR ENTRY
 N DFN,DLINE,EVENTDT,IEN312,IEN36,INSNODE0,NODE0,IBTRNM,IBTRENT
 S VALMBCK="R"
 S IBTRNM="IBTRH2",IBTRENT=0
 S IBTRIEN=+$$SELEVENT^IBTRH1(0,"Select entry",.DLINE) ; select entry to expand
 I IBTRIEN'>0 Q
 ; try to lock the entry
 I '$$LOCKEV^IBTRH1(IBTRIEN) D LOCKERR^IBTRH2A S VALMSG="?Await #In-Prog -RespErr !Unable +Pend *NextRev" D MSG^VALM10(VALMSG) Q
 D EN^VALM("IBT HCSR ENTRY")
 ; unlock entry
 D UNLOCKEV^IBTRH1(IBTRIEN)
 Q
 ;
EN2(IBTRNM,IBTRIEN) ; Secondary entry point.
 ; IBTRNM is the calling routine name.
 ; IBTRIEN is the internal id for ^IBT(356.22)
 I $G(IBTRNM)="" S VALMQUIT="" Q
 I '$G(IBTRIEN) S VALMQUIT="" Q
 N DFN,EVENTDT,IEN312,INSNODE0,NODE0
 D INIT
 Q
 ;
HDR ; header code
 N VADM,VA,VAERR,Z
 S Z=""
 I +$G(DFN) D DEM^VADPT S Z=$E(VADM(1),1,28),Z=Z_$J("",35-$L(Z))_$P(VADM(2),U,2)_"    DOB: "_$P(VADM(3),U,2)_"    AGE: "_VADM(4)
 S VALMHDR(1)=Z
 Q
 ;
INIT ; init variables and list array
 K ^TMP(IBTRNM,$J)
 I '$G(IBTRIEN) S VALMQUIT="" Q
 S NODE0=$G(^IBT(356.22,IBTRIEN,0))
 S DFN=+$P(NODE0,U,2)
 S IEN312=+$P(NODE0,U,3)
 S INSNODE0="" S:IEN312>0 INSNODE0=$G(^DPT(DFN,.312,IEN312,0)) ; 0-node in file 2.312
 S IEN36=+$P(INSNODE0,U)
 S EVENTDT=$P(NODE0,U,7)
 D BLD
 Q
 ;
HELP ; help code
 D FULL^VALM1
 W !!,"This screen displays an expanded view of a Healthcare Services Review Worklist entry."
 W !!,"The actions allow editing of data and transmission of HCSR inquiry."
 D PAUSE^VALM1 S VALMBCK="R"
 Q
 ;
EXIT ; exit code
 K ^TMP(IBTRNM,$J)
 D CLEAR^VALM1,CLEAN^VALM10
 Q
 ;
BLD ; build screen array
 N AAADATA,ADDR,CMTDATA,DATA36,DATA3553,IBL,IBLINE,IBY,IEN3553,IENS,PNDDATA,RESPONSE,STATUS,TMPARY,Z,Z0,Z1,Z2
 S IEN3553=+$P(INSNODE0,U,18),STATUS=$$STATUS(IBTRIEN),RESPONSE=+$P($G(^IBT(356.22,IBTRIEN,0)),U,14)
 I $P($G(^IBT(356.22,IBTRIEN,0)),U,20)=2 S RESPONSE=IBTRIEN
 S VALMCNT=0
 ;
 S IENS=IEN36_","
 D GETS^DIQ(36,IENS,".01;1;.131:.133","EI","DATA36")
 D SET(" ") S IBY=$J("",26)_"Insurance Company Information" D SET(IBY,"B") S IBLINE=""
 S IBL="Name: ",IBY=$G(DATA36(36,IENS,.01,"E")),IBLINE=$$SETL("",IBY,IBL,10,30)
 S IBL="Reimburse?: ",IBY=$G(DATA36(36,IENS,1,"E")),IBLINE=$$SETL(IBLINE,IBY,IBL,57,20)
 D SET(IBLINE) S IBLINE=""
 S IBL="Phone: ",IBY=$G(DATA36(36,IENS,.131,"E")),IBLINE=$$SETL(IBLINE,IBY,IBL,10,20)
 S IBL="Billing Phone: ",IBY=$G(DATA36(36,IENS,.132,"E")),IBLINE=$$SETL(IBLINE,IBY,IBL,57,20)
 D SET(IBLINE) S IBLINE=""
 S IBL="Precert Phone: ",IBY=$G(DATA36(36,IENS,.133,"E")),IBLINE=$$SETL(IBLINE,IBY,IBL,57,20)
 D SET(IBLINE) S IBLINE=""
 D ADDR^IBTRH2A(36,IEN36,.111,.112,.113,.114,.115,.116,.ADDR)
 S IBL="Address: ",IBY=ADDR(1),IBLINE=$$SETL(IBLINE,IBY,IBL,10,69)
 D SET(IBLINE) S IBLINE=""
 F Z=2:1:9 S IBL="",IBY=$G(ADDR(Z)) Q:IBY=""  S IBLINE=$$SETL(IBLINE,IBY,IBL,10,69) D SET(IBLINE) S IBLINE=""
 ;
 S IENS=IEN3553_","
 D GETS^DIQ(355.3,IENS,".02:.09;.12;6.02;6.03;11",,"DATA3553")
 D SET(" ") S IBY=$J("",29)_"Group/Plan Information" D SET(IBY,"B") S IBLINE=""
 S IBL="Type Of Plan: ",IBY=$G(DATA3553(355.3,IENS,.09)),IBLINE=$$SETL("",IBY,IBL,16,40)
 S IBL="Require UR: ",IBY=$G(DATA3553(355.3,IENS,.05)),IBLINE=$$SETL(IBLINE,IBY,IBL,63,3)
 D SET(IBLINE) S IBLINE=""
 S IBL="Group?: ",IBY=$G(DATA3553(355.3,IENS,.02)),IBLINE=$$SETL("",IBY,IBL,16,3)
 S IBL="Require Amb Cert: ",IBY=$G(DATA3553(355.3,IENS,.12)),IBLINE=$$SETL(IBLINE,IBY,IBL,63,3)
 D SET(IBLINE) S IBLINE=""
 S IBL="Group Name: ",IBY=$G(DATA3553(355.3,IENS,.03)),IBLINE=$$SETL("",IBY,IBL,16,20)
 S IBL="Require Pre-Cert: ",IBY=$G(DATA3553(355.3,IENS,.06)),IBLINE=$$SETL(IBLINE,IBY,IBL,63,3)
 D SET(IBLINE) S IBLINE=""
 S IBL="Group Number: ",IBY=$G(DATA3553(355.3,IENS,.04)),IBLINE=$$SETL("",IBY,IBL,16,17)
 S IBL="Exclude Pre-Cond: ",IBY=$G(DATA3553(355.3,IENS,.07)),IBLINE=$$SETL(IBLINE,IBY,IBL,63,3)
 D SET(IBLINE) S IBLINE=""
 S IBL="BIN: ",IBY=$G(DATA3553(355.3,IENS,6.02)),IBLINE=$$SETL("",IBY,IBL,16,10)
 S IBL="Benefits Assignable: ",IBY=$G(DATA3553(355.3,IENS,.08)),IBLINE=$$SETL(IBLINE,IBY,IBL,63,3)
 D SET(IBLINE) S IBLINE=""
 S IBL="PCN: ",IBY=$G(DATA3553(355.3,IENS,6.03)),IBLINE=$$SETL("",IBY,IBL,16,20)
 D SET(IBLINE) S IBLINE=""
 D SET(" ")
 S IBL="Plan Comments: ",IBY="",IBLINE=$$SETL("",IBY,IBL,10,69)
 D SET(IBLINE) S IBLINE=""
 S IBL="",Z0=0 F  S Z0=$O(DATA3553(355.3,IENS,11,Z0)) Q:'Z0  D
 .S IBY=$G(DATA3553(355.3,IENS,11,Z0)),IBLINE=$$SETL("",IBY,IBL,10,69) D SET(IBLINE) S IBLINE=""
 .Q
 D SET(" ") S IBY=$J("",26)_"Policy/Subscriber Information" D SET(IBY,"B") S IBLINE=""
 S IBL="Insured's Name: ",IBY=$P(INSNODE0,U,17),IBLINE=$$SETL("",IBY,IBL,18,30)
 S IBL="Effective: ",IBY=$$FMTE^XLFDT($P(INSNODE0,U,8),5),IBLINE=$$SETL(IBLINE,IBY,IBL,62,10)
 D SET(IBLINE) S IBLINE=""
 S IBL="Subscriber Id: ",IBY=$P(INSNODE0,U,2),IBLINE=$$SETL("",IBY,IBL,18,20)
 S IBL="Expiration: ",IBY=$$FMTE^XLFDT($P(INSNODE0,U,4),5),IBLINE=$$SETL(IBLINE,IBY,IBL,62,13)
 D SET(IBLINE) S IBLINE=""
 S IBL="Relationship: ",IBY=$$EXPAND^IBTRE(2.312,4.03,$P($G(^DPT(DFN,.312,IEN312,4)),U,3)),IBLINE=$$SETL("",IBY,IBL,18,16)
 S IBL="Coord of Benefits: ",IBY=$$EXPAND^IBTRE(2.312,.2,$P(INSNODE0,U,20)),IBLINE=$$SETL(IBLINE,IBY,IBL,62,16)
 D SET(IBLINE) S IBLINE=""
 S IBL="Insured's DOB: ",IBY=$$FMTE^XLFDT($P($G(^DPT(DFN,.312,IEN312,3)),U),5),IBLINE=$$SETL("",IBY,IBL,18,10)
 D SET(IBLINE) S IBLINE=""
 S IBL="Employer Sponsored Group Health Plan?: ",IBY=$$EXPAND^IBTRE(2.312,2.1,$P($G(^DPT(DFN,.312,IEN312,2)),U))
 S IBLINE=$$SETL("",IBY,IBL,40,3)
 D SET(IBLINE) S IBLINE=""
 D SET(" ") S IBY=$J("",23)_"User Added Comments for This Entry" D SET(IBY,"B") S IBLINE=""
 S IENS=IBTRIEN_"," D GETS^DIQ(356.22,IENS,"1*","IE","CMTDATA")
 S Z0="" F  S Z0=$O(CMTDATA(356.221,Z0)) Q:Z0=""  D
 .I $G(CMTDATA(356.221,Z0,.01,"I"))="" Q
 .S IBL="User's Name: ",IBY=$G(CMTDATA(356.221,Z0,.02,"E")),IBLINE=$$SETL("",IBY,IBL,10,30)
 .S IBL="Date Comment Entered: ",IBY=$$FMTE^XLFDT(CMTDATA(356.221,Z0,.01,"I"),5),IBLINE=$$SETL(IBLINE,IBY,IBL,60,19)
 .D SET(IBLINE) S IBLINE=""
 .S IBL="Comment: ",IBY="",IBLINE=$$SETL("",IBY,IBL,10,69) D SET(IBLINE) S IBLINE=""
 .K TMPARY D FSTRNG^IBJU1($$WP2STR^IBTRHLO2(356.221,.03,Z0),75,.TMPARY)
 .S IBL="  " F Z1=1:1:TMPARY S IBY=TMPARY(Z1),IBLINE=$$SETL("",IBY,IBL,1,75) D SET(IBLINE) S IBLINE=""
 .D SET(" ")
 .Q
 ; STATUS = "03" - unable to send, STATUS = "04" - negative response received
 I STATUS="03"!(STATUS="04") D
 .I STATUS="04",RESPONSE'>0 Q  ; no response pointer
 .S IENS=$S(STATUS="04":RESPONSE,1:IBTRIEN)_","
 .D SET(" ")
 .S IBY=$S(STATUS="03":$J("",16)_"Unable to send request for the following reasons",1:$J("",26)_"278 response error condition")
 .D SET(IBY,"B") S IBLINE=""
 .D GETS^DIQ(356.22,IENS,"101*","IE","AAADATA")
 .S Z0="" F  S Z0=$O(AAADATA(356.22101,Z0)) Q:Z0=""  D
 ..I STATUS="04" D
 ...S Z1=+$G(AAADATA(356.22101,Z0,.02,"I")) I Z1>0 D
 ....S IBL="Error Source: ",IBY=$P($G(^IBE(365.027,Z1,0)),U,2)_" (Loop "_$G(AAADATA(356.22101,Z0,.02,"E"))_")"
 ....S IBLINE=$$SETL("",IBY,IBL,10,69) D SET(IBLINE) S IBLINE=""
 ...S IBL="Reject Reason Code: ",IBY=$G(AAADATA(356.22101,Z0,.04,"E"))
 ...I IBY'="" S IBLINE=$$SETL("",IBY,IBL,20,59) D SET(IBLINE) S IBLINE=""
 ...S Z1=+$G(AAADATA(356.22101,Z0,.04,"I"))
 ...I Z1>0 S IBL="Reject Reason Text: ",IBY=$P($G(^IBE(365.017,Z1,0)),U,2),IBLINE=$$SETL("",IBY,IBL,20,59) D SET(IBLINE) S IBLINE=""
 ...S IBL="Action Code: ",IBY=$G(AAADATA(356.22101,Z0,.05,"E"))
 ...I IBY'="" S IBLINE=$$SETL("",IBY,IBL,20,59) D SET(IBLINE) S IBLINE=""
 ...S Z1=+$G(AAADATA(356.22101,Z0,.05,"I"))
 ...I Z1>0 S IBL="Action Text: ",IBY=$P($G(^IBE(365.018,Z1,0)),U,2),IBLINE=$$SETL("",IBY,IBL,20,59) D SET(IBLINE) S IBLINE=""
 ...Q
 ..S Z1=$G(AAADATA(356.22101,Z0,1,"E")) I Z1'="" D
 ...;D SET(" ")
 ...S IBL=$S(STATUS="04":"Error message:",1:""),IBY="",IBLINE=$$SETL("",IBY,IBL,10,69) D SET(IBLINE) S IBLINE=""
 ...K TMPARY D FSTRNG^IBJU1(Z1,75,.TMPARY)
 ...S IBL="" F Z2=1:1:TMPARY S IBY=TMPARY(Z2),IBLINE=$$SETL("",IBY,IBL,1,79) D SET(IBLINE)
 ...Q
 ..D SET(" ")
 ..Q
 .Q
 ; "Pending" response received
 I RESPONSE>0 D
 .S IENS=RESPONSE_","
 .D GETS^DIQ(356.22,IENS,"11*;12;17.02;103.01;103.03","IE","PNDDATA")
 .I $G(PNDDATA(356.22,IENS,103.01,"E"))'="A4" Q  ; only display this section if Certification Action Code = A4
 .D SET(" ")  S IBY=$J("",23)_"278 Response with 'Pending' status" D SET(IBY,"B") S IBLINE=""
 .D SET(" ")
 .S IBL="Admin Reference #: ",IBY=$G(PNDDATA(356.22,IENS,17.02,"E")),IBLINE=$$SETL("",IBY,IBL,10,69)
 .D SET(IBLINE) S IBLINE=""
 .S IBL="Review Decision Reason Code: ",IBY=$G(PNDDATA(356.22,IENS,103.03,"E")),IBLINE=$$SETL("",IBY,IBL,10,69)
 .D SET(IBLINE) S IBLINE=""
 .S IBL="Review Decision Reason Text: ",IBY=$P($G(^IBT(356.021,+$G(PNDDATA(356.22,IENS,103.03,"I")),0)),U,2)
 .S IBLINE=$$SETL("",IBY,IBL,10,69)
 .D SET(IBLINE) S IBLINE=""
 .I $D(PNDDATA(356.22,IENS,12)) D
 ..S IBL="Message: ",IBY="",IBLINE=$$SETL("",IBY,IBL,1,79)
 ..D SET(IBLINE) S IBLINE="",IBL=""
 ..S Z0=0 F  S Z0=$O(PNDDATA(356.22,IENS,12,Z0)) Q:Z0'=+Z0  D
 ...S Z1=$G(PNDDATA(356.22,IENS,12,Z0))
 ...K TMPARY D FSTRNG^IBJU1(Z1,75,.TMPARY)
 ...S IBL="" F Z2=1:1:TMPARY S IBY=TMPARY(Z2),IBLINE=$$SETL("",IBY,IBL,1,79) D SET(IBLINE)
 ...S IBLINE=""
 ...Q
 ..Q
 .I $D(PNDDATA(356.2211)) D
 ..D SET(" ")
 ..S IBL="Reports: ",IBY="",IBLINE=$$SETL("",IBY,IBL,40,9)
 ..D SET(IBLINE) S IBLINE=""
 ..D SET(" ")
 ..S Z="" F  S Z=$O(PNDDATA(356.2211,Z)) Q:Z=""  D
 ...S IBL="Attachment Report Type Code: ",IBY=$P($G(^IBT(356.018,+$G(PNDDATA(356.2211,Z,.01,"I")),0)),U)
 ...S IBLINE=$$SETL("",IBY,IBL,1,79) D SET(IBLINE) S IBLINE=""
 ...S IBL="Attachment Report Type Text: ",IBY=$G(PNDDATA(356.2211,Z,.01,"E"))
 ...S IBLINE=$$SETL("",IBY,IBL,1,79) D SET(IBLINE) S IBLINE=""
 ...S IBL="Report Transmission Code: ",IBY=$G(PNDDATA(356.2211,Z,.02,"I"))
 ...S IBLINE=$$SETL("",IBY,IBL,1,79) D SET(IBLINE) S IBLINE=""
 ...S IBL="Report Transmission Text: ",IBY=$G(PNDDATA(356.2211,Z,.02,"E"))
 ...S IBLINE=$$SETL("",IBY,IBL,1,79) D SET(IBLINE) S IBLINE=""
 ...S IBL="Report Control #: ",IBY=$G(PNDDATA(356.2211,Z,.03,"E"))
 ...S IBLINE=$$SETL("",IBY,IBL,1,79) D SET(IBLINE) S IBLINE=""
 ...S IBL="Attachment Description: ",IBY="",IBLINE=$$SETL("",IBY,IBL,1,79)
 ...D SET(IBLINE) S IBLINE=""
 ...S IBL="",IBY=$G(PNDDATA(356.2211,Z,.04,"E")),IBLINE=$$SETL("",IBY,IBL,1,79)
 ...D SET(IBLINE) S IBLINE=""
 ...D SET(" ")
 ...Q
 ..Q
 .Q
 S Z=+$O(^TMP(IBTRNM,$J,""),-1) I Z,$G(^TMP(IBTRNM,$J,Z,0))=" " K ^TMP(IBTRNM,$J,Z) S VALMCNT=VALMCNT-1
 Q
 ;
SETL(LINE,DATA,LABEL,COL,LNG) ;
 S LINE=LINE_$J("",(COL-$L(LABEL)-$L(LINE)))_LABEL_$E(DATA,1,LNG)
 Q LINE
 ;
SET(LINE,SPEC) ;
 S VALMCNT=VALMCNT+1
 S ^TMP(IBTRNM,$J,VALMCNT,0)=LINE
 I $G(SPEC)="B" D CNTRL^VALM10(VALMCNT,1,80,IOINHI,IOINORM)
 Q
 ;
ADDCMT(FROMWL) ; add entry comment
 ; called from action protocol IBT HCSR ADD COMMENT
 ; Input:   FROMWL  - Optional, only sent when adding a comment to entry
 ;                    directly from the main worklist.
 ;                    Defaults to 0
 N CMTIEN,DA,DD,DIC,DIE,DIK,DINUM,DLAYGO,DO,DR,DTOUT,DUOUT,DIRUT,X,Y
 S:'$D(FROMWL) FROMWL=0
 S VALMBCK="R"
 ; create new entry in the comments multiple (356.221)
 S DA(1)=IBTRIEN,DLAYGO=356.221,DIC(0)="L",DIC="^IBT(356.22,"_DA(1)_",1,",X=$$NOW^XLFDT()
 D FILE^DICN K DD,DO S (CMTIEN,DA)=+Y I DA<1 Q
 ; prompt for the comment
 S DIE="^IBT(356.22,"_DA(1)_",1,",DR=".02////"_DUZ_";.03" D ^DIE
 ; if no comment was added, delete the entry in 356.221 we just created
 I $G(^IBT(356.22,IBTRIEN,1,CMTIEN,1,1,0))="" S DIK=DIE,DA(1)=IBTRIEN,DA=CMTIEN D ^DIK Q
 ;
 ; If called from the main worklist, skip the next line
 Q:FROMWL
 ;
 ; rebuild the listman screen in order to show the newly added comment
 D INIT^IBTRH2,HDR^IBTRH2
 Q
 ;
SEND278 ; send 278 request
 N ADMIEN,DDT,DIR,DIROUT,DIRUT,DTOUT,DUOUT,EDT,DISIEN,IBEXIT,IENS,STATUS,X,Y
 ; IBTRENT - where this action is called from:
 ;  0 = from HCSR Worklist (full view)
 ;  1 = from HCSR Worklist (short view)
 ;  2 = from HCSR Response Worklist
 ;  3 = from Insurance Review Editor or Claims Tracking Editor
 S IBTRENT=+$G(IBTRENT)
 S:'$D(IBRESP) IBRESP=0
 S VALMBCK="R"
 D FULL^VALM1
 I $G(IBTRIEN)="" S IBTRENT=3 D  ; coming from either Insurance Review Editor or Claims Tracking Editor
 .I $G(IBTRN)'="" D
 ..S IENS=IBTRN_",",DDT=""
 ..S EDT=$$GET1^DIQ(356,IENS,.06,"I") ; get event date from file 356
 ..S ADMIEN=+$$GET1^DIQ(356,IENS,.05,"I") ; get admission (ptr to file 405) from file 356
 ..I ADMIEN>0 D
 ...S DISIEN=+$$GET1^DIQ(405,ADMIEN_",",.17,"I") ; get discharge (ptr to file 405) from file 405
 ...I DISIEN>0 S DDT=$$GET1^DIQ(405,DISIEN_",",.01,"I") ; get discharge date from file 405
 ...Q
 ..S IBTRIEN=$O(^IBT(356.22,"D",DFN,EDT_$S(DDT'="":"-"_DDT,1:""),""))
 .Q
 ; if no valid 356.22 ien, complain and bail out
 I +$G(IBTRIEN)'>0 D STATMSG^IBTRH2A(1) Q
 ;
 S STATUS=$$STATUS(IBTRIEN)
 ; don't send a new request if we're waiting for response
 I STATUS="02" D STATMSG^IBTRH2A(3) Q
 ; if status is pending, still waiting on payer
 I STATUS="07" D STATMSG^IBTRH2A(4) Q
 ; Create the 278 request to be sent
 I IBTRENT'=1 S IBEXIT=$$CRT278^IBTRH5I(IBTRIEN)
 I IBTRENT=1 S IBEXIT=1
 ;
 ; Quit if the user '^' exited the template or if there is missing required fields
 I $$REQMISS^IBTRH5I(IBTRIEN,IBEXIT) D  Q
 . D PAUSE^VALM1
 . ; Refresh display
 . I IBTRENT=0 D INIT^IBTRH2
 ;
 S DIR("A")="Send Request? (Y/N): ",DIR("B")="N",DIR(0)="YAO" D ^DIR K DIR
 I $G(DTOUT)!$G(DUOUT)!$G(DIROUT)!($G(Y)'=1) Q
 D EN^IBTRHLO(IBTRIEN,0)
 ; check if message id got populated and display appropriate message
 D STATMSG^IBTRH2A($S($P($G(^IBT(356.22,IBTRIEN,0)),U,12)="":2,1:0))
 ; refresh display
 I IBTRENT=0 D INIT^IBTRH2
 Q
 ;
STATUS(IBTRIEN) ; returns 356.22 entry status
 ; IBTRIEN - file 356.22 ien
 ;
 N RES
 S RES=""
 I +$G(IBTRIEN)>0 S RES=$P($G(^IBT(356.22,IBTRIEN,0)),U,8)
 Q RES
 ;
PRMARK(WHICH)   ;EP
 ; Listman Protocol Action to Mark/Remove 'In-Progress' from a selected entry
 ; from the expand entry worklist
 ; Input:   WHICH   - 0 - Remove 'In-Progress' mark
 ;                    1 - Set 'In-Progress' mark
 ;          IBTRIEN - IEN of the Expanded Entry being marked/removed
 D PRMARK^IBTRH1(WHICH,IBTRIEN)
 I WHICH=1 D  Q
 . I +$$STATUS^IBTRH2(IBTRIEN)=1 S VALMSG="Entry has been Marked" Q
 . S VALMSG="Nothing Done"
 ;
 I +$$STATUS^IBTRH2(IBTRIEN)=0 S VALMSG="Entry has been Unmarked" Q
 S VALMSG="Nothing Done"
 Q
