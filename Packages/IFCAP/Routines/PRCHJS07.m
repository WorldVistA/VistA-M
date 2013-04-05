PRCHJS07 ;OI&T/KCL - IFCAP/ECMS INTERFACE RETRANSMIT 2237;6/6/12
 ;;5.1;IFCAP;**167**;Oct 20, 2000;Build 17
 ;Per VHA Directive 2004-38, this routine should not be modified.
 ;
ENTACT(PRCDUZ) ;Option [PRCHJ RETRANS 2237] entry action 
 ;This function is called from the entry action of the
 ;[PRCHJ RETRANS 2237] option. If the user is not assigned
 ;as the PPM ACCOUNTABLE OFFICER, access will be denied.
 ;
 ;  Input:
 ;   PRCDUZ - (required) IEN of user in the NEW PERSON (#200) file
 ;
 ; Output:
 ;   Function value - 1 on success, 0 on failure (access denied)
 ;
 N PRCIENS ;iens string for GETS^DIQ
 N PRCFLDS ;results array for GETS^DIQ
 N PRCERR  ;error array for GETS^DIQ
 N PRCRSLT ;function result
 ;
 S PRCRSLT=0
 ;
 I +$G(DUZ)>0 D
 . ;is user assigned as PPM ACCOUNTABLE OFFICER?
 . S PRCIENS=+$G(DUZ)_","
 . D GETS^DIQ(200,PRCIENS,"400","I","PRCFLDS","PRCERR")
 . Q:$D(PRCERR)
 . I $G(PRCFLDS(200,PRCIENS,400,"I"))=2 S PRCRSLT=1
 ;
 I 'PRCRSLT W !!,">>> You are not authorized to use this option!",!
 ;
 Q PRCRSLT
 ;
 ;
RETRANS ;Option [PRCHJ RETRANS 2237] run routine 
 ;This procedure is the run routine for the [PRCHJ RETRANS 2237]
 ;option. The option allows an IFCAP user having the Accountable
 ;Officer role to retransmit a 2237 to the Electronic Contracting
 ;Management System (eCMS) via HL7 messaging.
 ;
 ;  Input: None
 ; Output: None
 ;
 N PRCESIG  ;output from call to ESIG^PRCUESIG
 N PRCABORT ;flag to abort user prompting
 ;
 ;prompt - electronic signature to validate user
 W !
 S PRCESIG=""
 D ESIG^PRCUESIG($G(DUZ),.PRCESIG)
 Q:$G(PRCESIG)'=1
 ;
 ;prompt user to retransmit 2237 transactions until PRCABORT=1
 S PRCABORT=0
 F  D  Q:PRCABORT
 . N PRCER    ;transmission error text
 . N PRCLOGER ;error returned from LOG^PRCHJTA
 . ;prompt - select 2237 transaction in REQUEST WORKSHEET (#443) file
 . N DIC,DTOUT,DUOUT,X,Y ;^DIC variables
 . N PRCSELCT ;selected entry: ien^transaction #
 . W !
 . S DIC="^PRC(443,"
 . S DIC(0)="AEMQZ"
 . S DIC("A")="Select 2237 TRANSACTION NUMBER: "
 . ;(screen) only allow selection of 2237s with status of 'Sent to eCMS (P&C)' and
 . ;have not been processed by eCMS (no ECMS ACTIONUID)
 . S DIC("S")="I $P(^PRC(443,+$G(Y),0),U,7)=69,'$$ECMS2237^PRCHJUTL(Y)"
 . D ^DIC K DIC
 . S:$G(Y)>0 PRCSELCT=+$G(Y)_U_$G(Y(0,0))
 . ;abort if no 2237 transaction selected, or user enters up-arrow, or timed out
 . I (Y=-1)!($D(DTOUT))!($D(DUOUT)) S PRCABORT=1 Q
 . ;
 . ;prompt - review 2237 prior to retransmission?
 . N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y ;^DIR variables
 . W !
 . S DIR(0)="YA"
 . S DIR("B")="NO"
 . S DIR("A")="Would you like to review this 2237 transaction? "
 . S DIR("?")="'Yes' to review the 2237 prior to retransmitting, 'No' to not review."
 . D ^DIR K DIR
 . ;abort if user enters up-arrow, pressed Enter key, or timed out
 . I $D(DIRUT) S PRCABORT=1 Q
 . ;if Yes, display 2237 for review
 . I Y=1 D DISP2237(+$G(PRCSELCT))
 . ;
 . ;prompt - 2237 retransmit?
 . N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y ;^DIR variables
 . W !
 . S DIR(0)="YA"
 . S DIR("B")="NO"
 . S DIR("A")="Do you want to retransmit this 2237 transaction to eCMS? "
 . S DIR("?")="'Yes' to retransmit the 2237 to eCMS, 'No' to not retransmit."
 . D ^DIR K DIR
 . ;abort if user enters up-arrow, pressed Enter key, or timed out
 . I $D(DIRUT) S PRCABORT=1 Q
 . ;if No selected, quit and ask user for another 2237 transaction
 . I (Y=0) Q
 . ;
 . ;if Yes selected, retransmit 2237 to eCMS
 . W !!,"Retransmitting 2237 transaction to eCMS..."
 . N PRCMSGID ;ien of msg in HLO MESSAGES (#778) file
 . S PRCMSGID=$$SEND2237^PRCHJS01(+$G(PRCSELCT),.PRCER)
 . ;
 . I $G(PRCMSGID)>0 D
 . . W !?3,">>> 2237 transaction has been successfully retransmitted to eCMS."
 . . W !?3,"    Transaction Number: "_$P($G(PRCSELCT),U,2)
 . . W !?3,"        HLO Message ID: "_$G(PRCMSGID)
 . . ;
 . . ;log transmission in IFCAP/ECMS TRANSACTION (#414.06) file
 . . W !!?3,">>> Updating retransmission in IFCAP/ECMS Transaction file..."
 . . N PRCEVNT ;event array for LOG^PRCHJTA
 . . S PRCEVNT("MSGID")=$G(PRCMSGID)
 . . S PRCEVNT("IEN410")=+$G(PRCSELCT)
 . . S PRCEVNT("IFCAPU")=$G(DUZ)
 . . D LOG^PRCHJTA($P($G(PRCSELCT),U,2),,4,.PRCEVNT,.PRCLOGER)
 . . I +$G(PRCLOGER) W !?3,"    Error: "_$P($G(PRCLOGER),U,2)
 . E  D
 . . W !?3,">>> ERROR: 2237 was not retransmitted to eCMS!"
 . . W !?3,"    Transaction Number: "_$P($G(PRCSELCT),U,2)
 . . W !?3,"    Error: "_$G(PRCER)
 . . ;log transmission in IFCAP/ECMS TRANSACTION (#414.06) file
 . . W !!?3,">>> Updating transmission error in IFCAP/ECMS Transaction file..."
 . . N PRCEVNT ;event array for LOG^PRCHJTA
 . . S PRCEVNT("MSGID")=""
 . . S PRCEVNT("IEN410")=+$G(PRCSELCT)
 . . S PRCEVNT("IFCAPU")=$G(DUZ)
 . . S PRCEVNT("ERROR",1)="An error occurred when retransmitting the 2237 transaction to eCMS."
 . . S PRCEVNT("ERROR",2)="Error: "_$E($G(PRCER),1,60)
 . . I $D(XQY0) S PRCEVNT("ERROR",3)="Option: "_$P($G(XQY0),"^",2)
 . . D LOG^PRCHJTA($P($G(PRCSELCT),U,2),,4,.PRCEVNT,.PRCLOGER)
 . . I +$G(PRCLOGER) W !?3,"    Error: "_$P($G(PRCLOGER),U,2)
 . . ;
 . . ;send notification message with error to AO
 . . W !!?3,">>> Sending error notification mail message to Accountable Officer..."
 . . N PRCMSG1,PRCMSG2 ;input arrays for PHMSG^PRCHJMSG, pass by ref
 . . S PRCMSG1(1)=$P($G(PRCSELCT),U,2)
 . . S PRCMSG1(2)=5
 . . S PRCMSG1(3)=$$NOW^XLFDT
 . . I $G(PRCER)["REQUESTING SERVICE" D
 . . . S PRCMSG1(7)="Return 2237 to Control Point for edit and re-approval!"
 . . E  D
 . . . S PRCMSG1(7)="Please forward this message to appropriate OIT staff!"
 . . M PRCMSG2=PRCEVNT("ERROR") ;merge error array into PRCMSG2 array
 . . D PHMSG^PRCHJMSG(.PRCMSG1,.PRCMSG2) ;send msg
 . ;
 . ;prompt - retransmit another 2237 transaction?
 . N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y ;^DIR variables
 . S DIR(0)="YA"
 . S DIR("B")="NO"
 . S DIR("A")="Do you want to retransmit another 2237 transaction to eCMS? "
 . S DIR("?")="'Yes' to retransmit another 2237 to eCMS, 'No' to exit."
 . W !
 . D ^DIR K DIR
 . ;abort if user enters No, up-arrow, pressed Enter key, or timed out
 . I $D(DIRUT)!(Y=0) S PRCABORT=1 Q
 ;
 Q
 ;
 ;
DISP2237(DA) ;Display 2237 Utility
 ;This procedure calls ^PRCSD12 to disply a 2237 to the screen.
 ;
 ;  Input:
 ;   DA - (required var for ^PRCSD12) IEN of record in CONTROL POINT ACTIVITY (#410) file
 ;
 ; Output: None 
 ; 
 N PRCS,PRCPRIB,TRNODE
 S (PRCS,PRCPRIB)=$G(DA)
 S TRNODE(0)=0
 D ^PRCSD12
 Q
 ;
 ;
CONTINUE() ;Pause display utility
 ;This function is used to pause the display and prompt the 
 ;user to --> Enter RETURN to continue or '^' to exit
 ;
 ;  Input: None
 ;
 ; Output: 1 - continue
 ;         0 - quit/exit
 ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y ;^DIR variables
 S DIR(0)="E"
 D ^DIR K DIR
 Q $S(Y'=1:0,1:1)
