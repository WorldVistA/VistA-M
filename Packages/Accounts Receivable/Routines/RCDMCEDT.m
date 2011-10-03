RCDMCEDT ;HEC/SBW - Enter/Edit DMC Debt Valid Field ;26-Oct-2007
 ;;4.5;Accounts Receivable;**253**;Mar 20, 1995;Build 9
 ;;Per VHA Directive 2004-038, this routine should not be modified.
UPDTDMC ;This is the main entry to enter/edit DMC Debt Valid field in 
 ;Accounts Receivable (#430) file
 N RCQUIT,DIROUT,DUOUT,DTOUT,DIRUT
 F  D  Q:$G(RCQUIT)>0!($D(DIROUT))
 . W !
 . N DIR,X,%,%X,Y,RCY,C,DFN,VAERR,VA,VADM,REFDT,BSTAT,RETVAL,FIRSTPAR
 . N ARDATA,DVAL,DVALDT,DVALUSER,IENS,PATIENT,SERDT
 . S DIR(0)="PAO^430:AEMQZ"
 . S DIR("A")="Select ACCOUNTS RECEIVABLE BILL NO. or PATIENT: "
 . D ^DIR
 . S:$D(DTOUT)!$D(DUOUT)!$D(DIRUT) RCQUIT=1
 . Q:+Y'>0
 . S RCY=Y
 . S RCY(0)=Y(0)
 . ;Get and Display info on Bill
 . ;Get Patient from 430 file
 . S PATIENT=+$P(RCY(0),U,7)
 . S FIRSTPAR=$$FIRSTPAR^RCDMCUT1(+RCY)
 . ;If Patient not in 430 file and this is a First Party bill get 
 . ;Debtor from 350 File
 . S:PATIENT'>0&(+FIRSTPAR>0) PATIENT=+$P(FIRSTPAR,U,2)
 . I +$$GETDEM^RCDMCUT1(PATIENT)'>0 W !!,"  Bill doesn't have an associated Patient.",! Q
 . W !!,"Veteran's Name:",?17,$G(VADM(1)),!
 . W "Veteran's SSN:",?17,$G(VA("PID")),!
 . D KVAR^VADPT
 . I +FIRSTPAR'>0 W !,"  Only First Party bills can be edited.",! Q
 . ;Get AR Bill Data
 . S IENS=+$P(RCY,U,1)_","
 . D GETS^DIQ(430,IENS,"2;8;121;125:127","EIN","ARDATA","ERR")
 . ;
 . W "Category Type:",?17,$G(ARDATA(430,IENS,2,"E")),!
 . S BSTAT=$G(ARDATA(430,IENS,8,"E"))
 . W "Bill Status: ",?17,BSTAT,!
 . I "^ACTIVE^OPEN^SUSPENDED^"'[(U_BSTAT_U) D  Q
 . . W !?5,"  Only Open, Active & Suspended bills may be edited.",!
 . S REFDT=$G(ARDATA(430,IENS,121,"E"))
 . I REFDT]"" W !,"Bill already referred to DMC on ",REFDT,!
 . ;Date of Service from file 340
 . S SERDT=$$GETSERDT^RCDMCUT1($P(RCY(0),U,1))
 . I SERDT>0 D
 . . W !
 . . I $P(SERDT,U,2) W "Outpatient Date: ",$$FMTE^XLFDT($P(SERDT,U,2),"1P"),!
 . . I $P(SERDT,U,3) W "Discharge Date:  ",$$FMTE^XLFDT($P(SERDT,U,3),"1P"),1
 . . I $P(SERDT,U,4) W "RX/Refill Date:  ",$$FMTE^XLFDT($P(SERDT,U,4),"1P"),!
 . ;Displays User Edits
 . S DVAL=$G(ARDATA(430,IENS,125,"E"))
 . S DVALUSER=$G(ARDATA(430,IENS,126,"E"))
 . S DVALDT=$G(ARDATA(430,IENS,127,"E"))
 . I DVAL]"" D
 . . W !,"DMC Debt Valid: ",?17,DVAL
 . . I DVAL="PENDING" W "  DMC Debt referral stopped on ",DVALDT,!
 . . I DVAL="YES"!(DVAL="NO") W "   Updated by ",DVALUSER," on ",DVALDT,!
 . ;
 . D EDIT(+RCY,.RETVAL)
 . I $G(RETVAL)="Y" W !!,"  Debt may be referred to DMC if it meets existing DMC referral criteria.",!
 . I $G(RETVAL)="N" W !!,"  Please cancel this bill and/or refund payment if appropriate.",!
 . S:$D(DTOUT)!$D(DUOUT)!$D(DIRUT) RCQUIT=1
 Q
 ;
EDIT(DA,RETVAL) ;Allows user to enter/edit DMC Debt Valid Field
 ;INPUT
 ;  DA - Internal Entry Number for Accounts Receivable (#430) file, 
 ;        Required variable.
 ;OUTPUT
 ;  RETVAL - The value entered by the users
 N DIE,DR,DTOUT,DUOUT,DIRUT,DIR,X,Y
 S RETVAL=0
 Q:+$G(DA)'>0
 ;
 L +^PRCA(430,DA,12.1):10
 I '$T D  Q
 .W !!?5,"Another user is editing this entry. Try later."
 ;
 ;Use DIR to get users response for the update
 S DIR(0)="430,125^^"
 S DIR("A")="Please confirm this is a valid debt based on eligibility"
 S DIR("B")=$P($G(^PRCA(430,DA,12.1)),U,1)
 D ^DIR
 ;Deletions and changes to Pending are not allowed
 I $G(X)="@",Y="" D  G EDITQ
 . W !!,"   *** Deletions not allowed. ***",!
 I $E(Y,1)="P" D  G EDITQ
 . W !!,"   *** PENDING is reserved for nightly DMC job. ***",!
 I DIR("B")=$E(Y,1) D  G EDITQ
 . W !!,"   *** No change entered. Field not updated. ***",!
 ;Quit if the user times or up arrows out
 G:$D(DIRUT) EDITQ
 S RETVAL=$E(Y,1)
 ;
 ;Update the entry with the Users response of Yes or No
 S DIE=430
 S DR="125////"_$E($G(Y),1)
 D ^DIE
EDITQ ;Used to allow a common exit and to unlock the record
 L -^PRCA(430,DA,12.1)
 Q
