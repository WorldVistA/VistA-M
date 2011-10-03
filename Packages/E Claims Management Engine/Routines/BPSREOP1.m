BPSREOP1 ;BHAM ISC/SS - REOPEN CLOSED CLAIMS ;03/07/08  14:54
 ;;1.0;E CLAIMS MGMT ENGINE;**3,7**;JUN 2004;Build 46
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;Reopen closed claims
 ;
 ;create an ^TMP for the list manager
 ;
COLLECT(BPDFN,BPSTRT,BPEND) ;
 D CLEAN^VALM10
 N LINE
 N BPIEN02,BPIEN59
 S LINE=1
 S BPIEN59=0
 F  S BPIEN59=$O(^BPST("AC",BPDFN,BPIEN59)) Q:+BPIEN59=0  D
 . I $P($G(^BPST(BPIEN59,12)),U,2)<BPSTRT Q
 . I $P($G(^BPST(BPIEN59,12)),U,2)>BPEND Q
 . ; Don't display deleted prescriptions
 . I $$RXAPI1^BPSUTIL1($P(^BPST(BPIEN59,1),U,11),100,"I")=13 Q
 . S BPIEN02=+$P($G(^BPST(BPIEN59,0)),U,4)
 . ;if the is no BPS CLAIMS - error
 . Q:BPIEN02=0
 . ;if NOT closed
 . I +$P($G(^BPSC(BPIEN02,900)),U)=0 Q
 . D SET^VALM10(LINE,$$LJ^BPSSCR02(LINE,6)_$$CLAIMINF(BPIEN59),BPIEN59)
 . S LINE=LINE+1
 S VALMCNT=LINE-1 ;"of PAGE" fix - VALMCNT should be EXACT number of lines on the screen
 Q
 ;claim info for list manager screen
CLAIMINF(BP59) ;*/
 N BPX,BPX1
 S BPX1=$$RXREF^BPSSCRU2(BP59)
 S BPX=$$LJ^BPSSCR02($$DRGNAME^BPSSCRU2(BP59),17)_"  "_$$LJ^BPSSCR02($$NDC^BPSSCRU2(+BPX1,+$P(BPX1,U,2)),13)_" "
 S BPX=BPX_$$LJ^BPSSCR02($$FILLDATE^BPSSCRRS(+BPX1,+$P(BPX1,U,2)),5)_" "
 S BPX=BPX_$$LJ^BPSSCR02($$RXNUM^BPSSCRU2(+BPX1),11)_" "_+$P(BPX1,U,2)_"/"
 S BPX=BPX_$$LJ^BPSSCR02($$ECMENUM^BPSSCRU2(BP59),7)_" "_$$MWCNAME^BPSSCRU2($$GETMWC^BPSSCRU2(BP59))_"   "
 S BPX=BPX_$$RTBB^BPSSCRU2(BP59)_" "_$$RXST^BPSSCRU2(BP59)_"/"_$$RL^BPSSCRU2(BP59)
 Q BPX
 ;
 ;patient info for header
PATINF(BPDFN) ;*/
 N X
 S X=$E($$PATNAME(BPDFN),1,22)_" "_$$SSN4^BPSSCRU2(BPDFN)
 Q $$LJ^BPSSCR02(X,29) ;name
 ;
 ;------------ patient's name
PATNAME(BPDFN) ;
 Q $E($P($G(^DPT(BPDFN,0)),U),1,30)
 ;
 ;/**
 ;ECME User Screen Reopen Closed Claim Hidden Action (ROC)
 ;**/
EUSCREOP ;
 N BPREOP,BP59,BPDFN,BPDISP,BPCNT,BPI,BPJ,BPCOMM,BPRETV,BPIEN02,BPSRXNUM
 ; Check for BPS MANAGER security key
 I '$D(^XUSEC("BPS MANAGER",DUZ)) D  Q
 . W !,"You must hold the BPS MANAGER Security Key to access the",!,"Reopen Closed Claims option."
 . S VALMBCK="R"
 . D PAUSE^VALM1
 S (BP59,BPCNT,BPI,BPJ)=0
 I '$D(@(VALMAR)) G REOP
 D FULL^VALM1
 ; Select the claim(s) to reopen
 W !,"Enter the line number for the claim you want to reopen."
 I $$ASKLINES^BPSSCRU4("","C",.BPREOP,VALMAR) D
 . ; Build array to display to user
 . F  S BP59=$O(BPREOP(BP59)) Q:BP59=""  D
 . . S BPDFN=+$P($G(^BPST(BP59,0)),U,6)
 . . S BPCNT=BPCNT+1
 . . I '$D(BPDISP(BPDFN)) S BPDISP(BPDFN,BPCNT)=$$LJ^BPSSCR02($$PATNAME(BPDFN)_" :",50),BPCNT=BPCNT+1
 . . S BPDISP(BPDFN,BPCNT)=@VALMAR@($P(BPREOP(BP59),U,1),0)
 . . ; Make sure this claim is closed
 . . I '$$CLOSED02^BPSSCR03($P($G(^BPST(BP59,0)),U,4)) D
 . . . S BPCNT=BPCNT+1
 . . . S BPDISP(BPDFN,BPCNT)="Claim NOT closed and cannot be reopened."
 . . . K BPREOP(BP59)
 . . ; Make sure the Prescription isn't deleted
 . . I $$RXAPI1^BPSUTIL1($P(^BPST(BP59,1),U,11),100,"I")=13 D
 . . . S BPCNT=BPCNT+1
 . . . S BPDISP(BPDFN,BPCNT)="The prescription has been marked DELETED and cannot be reopened."
 . . . K BPREOP(BP59)
 . ; Display the selected claims from the display array
 . W !!,"You've chosen to reopen the following prescriptions(s) for"
 . F  S BPI=$O(BPDISP(BPI)) Q:BPI=""  D
 . . F  S BPJ=$O(BPDISP(BPI,BPJ)) Q:BPJ=""  D
 . . . W !,BPDISP(BPI,BPJ)
 . . Q
 . Q
 ; If there are any closed claims selected, verify if the users still wants to reopen
 I $D(BPREOP) D
 . W !!,"All Selected Rxs will be reopened using the same information gathered in the",!,"following prompts.",!!
 . I $$YESNO^BPSSCRRS("Are you sure?(Y/N)") D
 . . ; Get the Reopen Comments to be stored in the BPS CLAIMS file
 . . S BPCOMM=$$PROMPT("REOPEN COMMENTS","","F",1,40)
 . . Q:BPCOMM["^"
 . . ; Do we REALLY want to reopen the claims?
 . . I $$YESNO^BPSSCRRS("ARE YOU SURE YOU WANT TO RE-OPEN THIS CLAIM? (Y/N)","No") D
 . . . S (BPCNT,BP59)=0
 . . . ; Loop through all selected claims and reopen them one at a time
 . . . ; using the same comments
 . . . F  S BP59=$O(BPREOP(BP59)) Q:BP59=""  D
 . . . . S BPIEN02=+$P($G(^BPST(BP59,0)),U,4)
 . . . . S BPRETV=$$REOPEN^BPSBUTL(BP59,BPIEN02,$$NOW^XLFDT,+DUZ,BPCOMM)
 . . . . W !,$P(BPRETV,U,2)
 . . . . I +BPRETV S BPCNT=BPCNT+1
 . . . . Q
 . . . I BPCNT>1 W !!,BPCNT_" claims have been reopened.",! Q
 . . . I BPCNT=1 W !!,"1 claim has been reopened.",! Q
 . . . I BPCNT=0 W !!,"Unable to reopen claim" Q
 I '$D(BPREOP) S VALMBCK="R" D PAUSE^VALM1 Q
 D PAUSE^VALM1
 D REDRAW^BPSSCRUD("Updating screen for reopened claims...")
 Q
 ;
SELECT ;
 I VALMCNT<1 D  Q
 . W !,"No claims to select." D PAUSE^VALM1 S VALMBCK="R"
 N BP59,BPQ
 D FULL^VALM1
 S BP59=0
 S BPQ=0
 F  S BPLINE=$$PROMPT("Select item","","A") D  Q:BPQ
 . I BPLINE="^" S BPQ=1 Q
 . I '(BPLINE?1N.N) W !,"Please select a SINGLE Rx Line Item." Q
 . S BP59=+$$GET59(+BPLINE) I BP59>0 S BPQ=1 Q
 . W !,"Please select a VALID Rx Line Item."
 I BPLINE="^" S VALMBCK="R" Q
 I BP59=0 S VALMBCK="R" W !,"Invalid selection." D PAUSE^VALM1 Q
 I $$SELCLAIM(BP59)<1 S VALMBCK="R" Q
 ;D RE^VALM4
 D REDRAW
 S VALMBCK="R"
 Q
 ;
GET59(BPLINE) ;
 Q +$O(^TMP("BPSREOP",$J,"VALM","IDX",BPLINE,0))
 ;
 ;display selected claim information
SELCLAIM(BP59) ;
 D FULL^VALM1
 W @IOF
 N BPX,BPX1,BPDFN,BPIEN02,BPCLDATA,BPCOMM,BPRETV,BPQ
 S BPDFN=+$P($G(^BPST(BP59,0)),U,6)
 S BPX1=$$RXREF^BPSSCRU2(BP59)
 W !,?1,$$LJ^BPSSCR02("PATIENT NAME: "_$$PATNAME(BPDFN),30)
 W ?33,$$LJ^BPSSCR02("RX#: "_$$RXNUM^BPSSCRU2(+BPX1)_" "_$P(BPX1,U,2),22)
 W ?57,$$LJ^BPSSCR02("DRUG: "_$$DRGNAME^BPSSCRU2(BP59),22)
 ;ien in BPS CLAIMS
 S BPIEN02=+$P($G(^BPST(BP59,0)),U,4)
 I BPIEN02=0 W !,"BPS CLAIMS file error!" D PAUSE^VALM1 Q -1
 ;Close info
 S BPCLDATA=$G(^BPSC(BPIEN02,900))
 ;if the is no BPS CLAIMS - error
 W !,?3,"CLOSED  ",$$FORMDATE^BPSSCRU6(+$P($G(^BPSC(BPIEN02,900)),U,2),2)
 W !,?4,"ECME#: "_+BPX1_", FILL DATE: "_$$FORMDATE^BPSSCRU6($$DOSDATE^BPSSCRRS(+BPX1,+$P(BPX1,U,2)),2)
 W ", RELEASE DATE: "_$$FORMDATE^BPSSCRU6($$RELDATE^BPSSCRU6(+BPX1,+$P(BPX1,U,2)),2)
 W !,?4,"PLAN: ",$$PLANNAME^BPSSCRU6(BP59)," INSURANCE: ",$$INSNAME^BPSSCRU6(BP59)
 W !,?4,"CLOSE REASON: ",$$CLREASON^BPSSCRU6(+$P(BPCLDATA,U,4))
 W !,?4,"DROP TO PAPER: ",$S(+$P(BPCLDATA,U,5)=1:"YES",1:"NO")
 W !,?4,"CLOSE USER: ",$P($G(^VA(200,+$P(BPCLDATA,U,3),0)),U)
 W !!,"You have selected the CLOSED electronic claim listed above.",!
 S BPCOMM=$$PROMPT("REOPEN COMMENTS","","F",1,40)
 Q:BPCOMM["^" 0
 S BPQ=$$YESNO^BPSSCRRS("ARE YOU SURE YOU WANT TO RE-OPEN THIS CLAIM? (Y/N)","No")
 Q:BPQ<1 0
 S BPRETV=$$REOPEN^BPSBUTL(BP59,BPIEN02,$$NOW^XLFDT,+DUZ,BPCOMM)
 W !,$P(BPRETV,U,2),!
 W !,"1 claim has been reopened.",!
 D PAUSE^VALM1
 Q 1
 ;
REDRAW ;
 N BPARR
 D CLEAN^VALM10
 D COLLECT^BPSREOP1(BPDFN,BPSTRT,BPEND)
 S VALMBCK="R"
 Q
 ;input:
 ;BPSPROM - prompt text
 ;BPSDFVL - default value (optional)
 ;BPMODE - N- to enter numbers, F - free text, A - free text w/o limitations
 ;returns:
 ; "response"
 ; or "^" for quit
PROMPT(BPSPROM,BPSDFVL,BPMODE,MINLEN,MAXLEN) ;
 N IR,X,Y,DIRUT,DIR
 I BPMODE="N" S DIR(0)="N^::2"
 I BPMODE="A" S DIR(0)="F^::2"
 I BPMODE="F" S DIR(0)="F^"_MINLEN_":"_MAXLEN_":2^K:(X?1"" ""."" "") X"
 S DIR("A")=BPSPROM
 I $L($G(BPSDFVL))>0 S DIR("B")=$G(BPSDFVL)
 D ^DIR I $D(DIRUT) Q "^"
 I Y["^" Q "^"
 Q Y
 ;
 ;Update reopen record in BPS CLAIM
 ;Input:
 ; BP02 - ien in BPS CLAIMS file
 ; BPCLOSED - value for CLOSED field
 ; BPREOPDT - reopen date/time
 ; BPDUZ - user DUZ (#200 ien)
 ; BPCOMM - reopen comment text
 ;Output:
 ; 0^message_error - error
 ; 1 - success
UPDREOP(BP02,BPCLOSED,BPREOPDT,BPDUZ,BPCOMM) ;
 ;Now update ECME database
 N RECIENS,BPDA,BPLCK,ERRARR
 S RECIENS=BP02_","
 S BPDA(9002313.02,RECIENS,901)=BPCLOSED ;CLOSED = "NO"
 S BPDA(9002313.02,RECIENS,906)=BPREOPDT ;reopen date/time
 S BPDA(9002313.02,RECIENS,907)=+BPDUZ ;user
 S BPDA(9002313.02,RECIENS,908)=BPCOMM ;comment
 L +^BPST(9002313.02,+BP02):10
 S BPLCK=$T
 I 'BPLCK Q "0^Locked record"  ;quit
 D FILE^DIE("","BPDA","ERRARR")
 I BPLCK L -^BPST(9002313.02,+BP02)
 I $D(ERRARR) Q "0^"_ERRARR("DIERR",1,"TEXT",1)
 Q 1
 ;
 ; Reopen Closed Claim displayed in ECME User Screen
REOP ;
 Q
