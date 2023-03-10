RCRPFB ;EDE/SAB - REPAYMENT PLAN FORBEARBANCE;03/31/2021  8:40 AM
 ;;4.5;Accounts Receivable;**378**;Mar 20, 1995;Build 54
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
MAIN ; Entry point for Forbearance Option
 ;
 N RCDONE
 N IOBOFF,IOBON,IORVON,IORVOFF,X,LN
 S RCDONE=0
 F  D  Q:RCDONE
 . S RCDONE1=0
 . S RCRPIEN=$$SELRPP^RCRPU1() I RCRPIEN=-1 S RCDONE=1 Q
 . I "^6^7^8^"[(U_$P($G(^RCRP(340.5,RCRPIEN,0)),U,7)_U) D  Q
 . . S X="IOBON;IORVON;IOBOFF;IORVOFF" D ENDR^%ZISS
 . . W !!,IOBON,IORVON,$$CJ^XLFSTR("*** WARNING: YOU HAVE SELECTED A CLOSED REPAYMENT PLAN ***",80),IORVOFF,IOBOFF,!!
 . ;
 . S LN=0
 . S LN=$$PRTHDR^RCRPINQ(RCRPIEN,LN)
 . Q:'LN
 . ;
 . S LN=$$PRTSCHED^RCRPINQ(RCRPIEN,LN)
 . Q:'LN
 . ;
 . S RCDONE1=$$PRTFORB^RCRPINQ(RCRPIEN,LN)
 . Q:'LN
 . ;
 . S RCDONE1=$$FORBEAR(RCRPIEN,LN)
 . Q:'LN
 . ;
 ;
 Q
 ;
FORBEAR(RPIEN,LN) ; Ask the user for the month and year to move.
 ;
 N RCDONE,Y,DIR,DIRUT,RCSCHIEN,RCNEWDT,RCCONT,RCFBDT,LN
 S RCDONE=0
 S LN=1
 S DIR(0)="DA"
 S DIR("A")="Enter scheduled payment to Forbear (MM/DD/YY) or ""^"" to Quit: "
 S DIR("?")="The payment the Debtor needs to be skip and reschedule."
 F  D  Q:RCDONE>0
 . S LN=$$WRTLN^RCRPINQ("",LN) Q:'LN
 . D ^DIR
 . I $D(DIRUT) S RCDONE=1 Q
 . S RCFBDT=+Y
 . S RCSCHIEN=$O(^RCRP(340.5,RPIEN,2,"B",Y,0))
 . I 'RCSCHIEN D  Q
 . . W !,"The payment date entered is not in the repayment plan.",!
 . . W "Please try again.",!
 . . D PAUSE^RCRPU
 . W !
 . S RCNEWDT=$$CALCNWDT(RPIEN)
 . S RCCONT=$$CORRECT($$FMTE^XLFDT(RCFBDT,2),$$FMTE^XLFDT(RCNEWDT,2))   ;Confirm that this is correct
 . Q:'RCCONT
 . ;Add new month to the plan
 . D UPDSCHED(RPIEN,RCNEWDT)
 . ;
 . ;Update the forborne month Forbearance Field to Yes
 . D UPDFRBFG(RPIEN,RCFBDT)
 . ;
 . ;File Audit Node entry
 . D UPDAUDIT^RCRPU2(RPIEN,$$DT^XLFDT,"E","F")
 . ;
 . ;File Forbearance Node Entry
 . D UPDFORB(RPIEN,$$DT^XLFDT,RCFBDT,RCNEWDT,"H")
 . ;
 . S LN=13,LN=$$WRTLN^RCRPINQ($$CJ^XLFSTR("Forbearance granted successfully.",80),LN) Q:'LN
 . ;
 . ;Update AR Metrics File
 . D UPDMET^RCSTATU(1.09,1)
 . ;
 . ; Pause here so user see's the confirmation.
 . D PAUSE^RCRPU
 . ;
 . ;Re-display updated schedule
 . S LN=$$PRTSCHED^RCRPINQ(RCRPIEN,LN)
 . Q:'LN
 . ;
 . ;re-display forbearances granted
 . S LN=$$PRTFORB^RCRPINQ(RCRPIEN,LN)
 . I 'LN S RCDONE=1
 ;
 Q RCDONE
 ;
CORRECT(RCDT,RCNEWDT) ;Are you sure this is correct?
 ; Input: (Optional) Prompt to display
 ; Return: 1 for Yes
 ;         0 for No
 ;
 N DIR,X,Y,RCPROMPT
 S DIR(0)="Y",DIR("B")="YES",DIR("A")="Are you sure you wish to move the "_RCDT_" payment to "_RCNEWDT_"? (Y/N) "
 D ^DIR
 W !
 Q Y
 ;
CALCNWDT(RCPIEN) ;Calculate the next date in the repayment plan.
 N RCNEWDT,RCLSTDT,RCMN,RCYR
 ;Retrieve the last payment date on the plan
 S RCLSTDT=+$G(^RCRP(340.5,RCPIEN,2,$O(^RCRP(340.5,RCPIEN,2,"A"),-1),0))
 ;
 ;Get the month and year
 S RCMN=+$E(RCLSTDT,4,5),RCYR=+$E(RCLSTDT,1,3)
 ;
 ;Add a Month
 S RCMN=RCMN+1
 ;
 ;If the new month is month 13, reset the month to 1 and Add 1 to the year.
 I RCMN>12 S RCMN=1,RCYR=RCYR+1
 ;
 ;Update the month to have 2 digits
 I $L(RCMN)=1 S RCMN="0"_RCMN
 ;
 ;Rebuild the date in FileMan format.
 S RCNEWDT=RCYR_RCMN_28
 Q RCNEWDT
 ;
UPDFORB(RCRPIEN,RCCHGDT,RCLSTDT,RCNEWDT,RCCMMNT) ; Update the Audit Log for the Plan
 ;
 ;INPUT - RCRPIEN - IEN of the repayment plan to update
 ;        RCCHGDT - date of the change
 ;        RCCTYPE - RCTYPE (N)ew, (E)dit, or (C)lose
 ;        RCCMMNT - Code for the reason
 ;                   N - New Plan
 ;                   T - Terms Adjustment
 ;                   F - Forbearance Granted
 ;                   S - System Termination
 ;                   D - Defaulted for Non Payment (manual Default)
 ;                   A - Administratively Closed (manual non default closing)
 ;
 N DLAYGO,DD,DO,DIC,DA,X,Y
 N RCLSTMY,RCNEWMY
 S RCLSTMY=$E(RCLSTDT,4,5)_"/"_($E(RCLSTDT,1,3)+1700)
 S RCNEWMY=$E(RCNEWDT,4,5)_"/"_($E(RCNEWDT,1,3)+1700)
 S DLAYGO=340.5,DA(1)=RCRPIEN,DIC(0)="",DIC="^RCRP(340.5,"_DA(1)_",5,",X=RCCHGDT
 S DIC("DR")="1///"_RCLSTMY_";2///"_RCNEWMY_";3///"_DUZ_";4///"_RCCMMNT
 D FILE^DICN
 Q
 ;
UPDFRBFG(RCPIEN,RCLSTDT) ; Update the Forbearance flag in the plan schedule.
 ;INPUT: RCPIEN  - IEN of plan to update
 ;       RCLSTDT - Scheduled Payment to mark as forborne
 ;
 N DR,DIE,DA,X,Y
 N RCI
 ;
 S RCI=$O(^RCRP(340.5,RCPIEN,2,"B",RCLSTDT,""))
 S DR="2////1"
 S DA(1)=RCPIEN,DA=RCI
 S DIE="^RCRP(340.5,"_DA(1)_",2,"
 D ^DIE
 Q
 ;
UPDSCHED(RCRPIEN,RCNEWDT) ; Add another month to the schedule - For Forbearances only.
 ;
 ;Allowing for other activities that may need to occur in the future when moving the payment to a new month.
 ;Add the new month to the schedule
 D UPDSCHED^RCRPU(RCRPIEN,RCNEWDT)
 ;
 Q
