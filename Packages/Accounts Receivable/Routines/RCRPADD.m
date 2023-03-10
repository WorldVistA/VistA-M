RCRPADD ;EDE/YMG - REPAYMENT PLAN FORBEARBANCE;03/31/2021  8:40 AM
 ;;4.5;Accounts Receivable;**381,388,378**;Mar 20, 1995;Build 54
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
MAIN ; Entry point for Forbearance Option
 ;
 N RCDONE,QUIT,RCRVW,RCRPIEN,RCDONE1,LN
 N IOBOFF,IOBON,IORVON,IORVOFF,X
 ;
 S (RCDONE,LN)=0,QUIT=""
 F  Q:RCDONE  D PROCPLAN  Q:RCDONE
 ;Clean up working TMP array when exiting
 K ^TMP("RCRPP",$J)
 Q
 ;
PROCPLAN ;
 S RCDONE1=0,LN=0
 I $E(IOST,1,2)["C-" W @IOF
 S RCRPIEN=$$SELRPP^RCRPU1() S QUIT=0 I RCRPIEN=-1 S RCDONE=1 Q
 ;I RCRPIEN="" S RCDONE=1 Q
 I "^6^7^8^"[(U_$P($G(^RCRP(340.5,RCRPIEN,0)),U,7)_U) D  Q
 . S X="IOBON;IORVON;IOBOFF;IORVOFF" D ENDR^%ZISS
 . W !!,IOBON,IORVON,$$CJ^XLFSTR("*** WARNING: YOU HAVE SELECTED A CLOSED REPAYMENT PLAN ***",80),IORVOFF,IOBOFF,!!
 . S RCRVW=$$GET1^DIQ(340.5,RCRPIEN_",",1.01,"I")
 . I RCRVW D  Q
 . . W !,"The selected plan currently has more than 60 payments outstanding."
 . . W !,"Unable to add new bills to this plan until the plan's terms"
 . . W !,"are adjusted."
 . . D PAUSE^RCRPU
 S LN=$$PRTHDR^RCRPINQ(RCRPIEN,LN)
 Q:'LN
 D PAUSE^RCRPU
 Q:$G(QUIT)
 I $E(IOST,1,2)["C-" W @IOF
 ;
 S LN=0
 S LN=$$PRTBILLS^RCRPINQ(RCRPIEN,LN)
 ; User requested an exit, reset flag and quit
 Q:'LN
 S LN=0
 D PAUSE^RCRPU
 Q:$G(QUIT)
 ;
 ; reset screen output to the top
 I $E(IOST,1,2)["C-" W @IOF
 S RCDONE1=$$ADDNEW(RCRPIEN)
 ; If user selected No at supervisor approval print message nothing updated and quit out to prompt for Payment Plan.
 Q:RCDONE1>0
 I RCDONE1=-1 D  Q:$G(QUIT)
 . W !!,"The Repayment Plan was not updated."
 . D PAUSE^RCRPU
 . S QUIT=1
 Q:RCDONE
 ;
 ; Reprint the Header and Bills
 S LN=0
 S LN=$$PRTHDR^RCRPINQ(RCRPIEN,LN)
 Q:'LN
 ;
 W !
 ;
 S LN=0
 D PAUSE^RCRPU
 Q:$G(QUIT)
 I $E(IOST,1,2)["C-" W @IOF
 S LN=$$PRTBILLS^RCRPINQ(RCRPIEN,LN)
 D PAUSE^RCRPU
 I 'LN S RCDONE=1
 ;
 Q
 ;
PRTHDR(RPIEN) ; display repayment plan data
 ;
 ; RPIEN is defined in tag EN
 ;
 N ADDRSTR,BAMNT,BILL,BSTAT,CBAL,CNT,DEBDOB,DEBPHN,DEBSSN,DEBTOR,LN,N0,RAMNT,TMP,TMPDT,TMPIEN
 I $G(RPIEN)'>0 Q
 S N0=$G(^RCRP(340.5,RPIEN,0)) ; 0-node in file 340.5
 S DEBTOR=$P(N0,U,2)
 S ADDRSTR=$$DADD^RCAMADD(DEBTOR,1)  ; ADDRSTR = Str1^Str2^Str3^City^State^ZIP^Telephone^Forein Country Code
 U IO
 I $E(IOST,1,2)["C-" W @IOF
 S DEBSSN=+$$SSN^RCFN01(DEBTOR),DEBDOB=$$GETDOB^RCRPINQ(DEBTOR),DEBPHN=+$P(ADDRSTR,U,7)
 W !!,"Debtor: ",$$NAM^RCFN01(DEBTOR)
 W ?40,"SSN/TIN: ",$S(DEBSSN>0:$E(DEBSSN,1,3)_"-"_$E(DEBSSN,4,5)_"-"_$E(DEBSSN,6,9),1:"N/A")
 W ?64,"DOB: ",$S(DEBDOB="":"N/A",1:DEBDOB)
 W !,"Address: ",$P(ADDRSTR,U)," ",$P(ADDRSTR,U,2)," ",$P(ADDRSTR,U,3),", ",$P(ADDRSTR,U,4),", ",$P(ADDRSTR,U,5)," ",$P(ADDRSTR,U,6)
 W !,"Phone: ",$S(DEBPHN>0:$$FMTPHONE^RCRPINQ(DEBPHN),1:"N/A"),!
 W !,"Plan #: ",$P(N0,U),?28,"Status: ",$$EXTERNAL^DILFD(340.5,.07,"",$P(N0,U,7)),?49,"Last status date: ",$$FMTE^XLFDT($P(N0,U,8),"5DZ"),!
 S CBAL=$P(N0,U,11)-$$PMNTS^RCRPINQ(RPIEN),RAMNT=$P(N0,U,6)
 W !,?2,"Current balance: $",$FN(CBAL,"",2),?37,"Number of payments remaining: ",CBAL\RAMNT+$S(CBAL#RAMNT:1,1:0)
 W !,?1,"Orig amount owed: $",$FN($P(N0,U,13),"",2),?38,"Original number of payments: ",$P(N0,U,14)
 W !,"Total amount owed: $",$FN($P(N0,U,11),"",2),?41,"Total number of payments: ",$P(N0,U,5)
 W !,?1,"Repayment amount: $",$FN(RAMNT,"",2),?47,"Auto-add New Bills: ",$$GET1^DIQ(340.5,RPIEN_",",.12,"E"),!!
 Q
 ;
ADDNEW(RPIEN) ; Ask the user for the bills to add.
 ;
 N RCDONE,RCCTS,Y,DIRUT,RCALLFLG,RCBLCH,RCTOT,RCORBAL,RCNOMN,RCNWMN,RCDBTR,RCSPFLG
 N RCMNPAY,RCNEWTOT,RCNEWLN,RCBILLDA,RCACTDT,RCRMBAL,RCRMLN,RCPLNBL,RCNWMOD,QUIT
 S RCSPFLG=0
 ;
 ;Clear ^TMP array
 K ^TMP("RCRPP",$J)
 S RCDBTR=$$GET1^DIQ(340.5,RPIEN_",",.02,"I")
 S RCDONE=0,RCACTDT=$$DT^XLFDT
 ; Retrieve new bills for Debtor
 S RCCTS=$$GETACTS^RCRPU(RCDBTR)   ;Look for only new bills to add to the account.
 ; If no new bills, alert user and exit.
 I +RCCTS<1 D  Q 1
 . W !!,"No new bills available to add to this Debtor's plan.",!
 . D PAUSE^RCRPU
 ;
 ;Print New Bills to be added
 D PRTNB(+RCCTS)
 ;
 ;Ask user which Active bills to add to new plan (single, range, or all)
 S RCBLCH=$$GETBILLS^RCRPU(+RCCTS)
 S RCALLFLG=+RCBLCH
 S RCBLCH=$P(RCBLCH,U,2)
 ;
 ;Escape of no bills were selected.
 I RCBLCH="" D  Q 1
 . W !,"No Bills selected",!
 . D PAUSE^RCRPU
 . W @IOF
 ;
 I 'RCALLFLG D  Q:'RCDONE 1
 .  S RCDONE=$$ECHOBL(RCBLCH)
 ;
 ;Display total sum of bills chosen and confirm with user, exit if no.
 S RCTOT=$$TOT^RCRPU(RCBLCH)
 I '+RCTOT D  Q 1
 . D PAUSE^RCRPU    ;Any key to continue prompt
 ;
 ;Strip confirm flag to get total.
 S RCTOT=$P(RCTOT,U,2)
 ;
 ;Get existing Plan info
 S RCORBAL=$$GET1^DIQ(340.5,RPIEN_",",.11,"I")
 S RCMNPAY=$$GET1^DIQ(340.5,RPIEN_",",.06,"I")
 ;
 ;Calculate the new Potential remaining balance
 S RCRMBAL=RCORBAL-$$PMNTS^RCRPINQ(RPIEN)
 S RCNEWTOT=RCTOT+RCRMBAL,RCNEWLN=RCNEWTOT/RCMNPAY
 ;
 ;If the new term length will become >60 months by adding these bills,
 ; display a warning message to the user, update the Review Flag on the Plan,
 ; and exit.
 I RCNEWLN>60 D  Q 0
 . W !,"Adding these bills will make the number of remaining payments on the"
 . W !,"plan > 60 months.  Unable to add new bills to this plan until the"
 . W !,"plan's terms are adjusted."
 . D UPDRVW^RCRPU2(RPIEN,1)
 . D PAUSE^RCRPU
 ;
 I RCNEWLN>36,(RCNEWLN'>60) D
 . W !,"Adding these bills will make the number of remaining payments on the"
 . W !,"plan > 36 months. This requires supervisor approval."
 . S RCSPFLG=$$SUPAPPR^RCRPU(RPIEN,2)
 I RCNEWLN>36,(RCSPFLG<1) Q -1 ; No Supervisor approval when required
 ;
 ; Add the Bill to the plan.
 S RCBILLDA=0
 F  S RCBILLDA=$O(^TMP("RCRPP",$J,"BILLS",RCBILLDA)) Q:'RCBILLDA  D
 . D UPDBILL^RCRPU(RPIEN,RCBILLDA)
 . ; Add Plan to the Bill
 . D ADDPLAN^RCRPU(RPIEN,RCBILLDA,RCACTDT)
 . D UPDMET^RCSTATU(1.01,1)
 ;
 ; Update the Total balance Owed.
 S RCPLNBL=RCTOT+RCORBAL
 D UPDPAO^RCRPU1(RPIEN,RCPLNBL)
 ;
 ; Recalculate the total # payments.
 S RCNOMN=$$GET1^DIQ(340.5,RPIEN_",",.05,"I")
 S RCNWMN=RCPLNBL\RCMNPAY,RCNWMOD=RCPLNBL#RCMNPAY
 I RCNWMOD>0 S RCNWMN=RCNWMN+1
 ;
 ; If there is a change in term length, update the plan and the schedule.
 I RCNOMN'=RCNWMN D
 .  D UPDTERMS^RCRPU1(RPIEN,RCMNPAY_"^"_RCNWMN)
 .  D ADJSCHED^RCRPENTR(RPIEN,RCNOMN,RCNWMN)
 ;
 ;Update Audit Log
 I RCSPFLG<1 D UPDAUDIT^RCRPU2(RPIEN,$$DT^XLFDT,"A","")
 I RCSPFLG=1 D UPDAUDIT^RCRPU2(RPIEN,$$DT^XLFDT,"A","SM")
 ;
 W !,"Bills successfully added to the Plan.",!
 ;
 ;Pause for the user to read the output, then escape the option if they wish to.
 D PAUSE^RCRPU W ! S $Y=0 I $G(QUIT) Q 1
 Q 0
 ;
PRTNB(RCCTS) ;Print the new Bills to be added, with header
 ;
 W !!,?26,"Bills Available for Selection"
 W ! D DASH^RCRPRPU(80)
 ;
 D PRTACTS^RCRPU(RCCTS)
 Q
 ;
ECHOBL(RCBLCH) ; Echo the Lits of Bills selected
 ; Input:  RCBLCH - List of bills to added.
 ;
 N RCBILL,RCBILLDA
 ;
 S RCBILLDA=0
 ;Display the bills selected
 W !,"You chose to add the following bill(s) to this plan:",!!
 F  S RCBILLDA=$O(^TMP("RCRPP",$J,"BILLS",RCBILLDA)) Q:'RCBILLDA  D
 .  S RCBILL=$P($G(^PRCA(430,RCBILLDA,0)),U)
 .  W RCBILL,!
 ;
 ;Ask if correct and exit with the answer
 Q $$CORRECT^RCRPU
