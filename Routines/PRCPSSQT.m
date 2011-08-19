PRCPSSQT ;WISC/CC-Request GIP QOH be overwitten by supply station values ;04/01
V ;;5.1;IFCAP;**24**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ; option requires multiple keys and other access privileges.
 N %,%DT,DA,DIE,DIR,DR,DTOUT,DUOUT,PRCPACT,PRCPDATA,PRCPNEXT
 N PRCPREQ,PRCPSTOP,PRCPTIME,X,Y,%
 ;
 I '$D(PRCP("DPTYPE")) S PRCP("DPTYPE")="S"
 D ^PRCPUSEL Q:'$G(PRCP("I"))
 I PRCP("DPTYPE")'="S" Q
 I $P($G(^PRCP(445,PRCP("I"),5)),"^",1)']"" D EN^DDIOL("This secondary is not linked to a supply station") Q
 I '$$KEY^PRCPUREP("PRCP2 MGRKEY",DUZ) D EN^DDIOL("You must be a secondary inventory point manager to user this option.") Q
 I '$$KEY^PRCPUREP("PRCPSSQOH",DUZ) D EN^DDIOL("You must be authorized to request an adjustment to supply station values") Q
 I '$D(^PRCP(445,PRCP("I"),8,DUZ,0)) D  Q
 . D EN^DDIOL("You may not request an update for this inventory point.")
 . D EN^DDIOL("Please contact your application coordinator.")
 ;
 L +^PRCP(445,PRCP("I"),7):3 I $T=0 D EN^DDIOL("The request file is busy.  Please try again later.") Q
 D ADD^PRCPULOC(445,PRCP("I")_"-7",0,"Request GIP Quantity Replacement")
 S PRCPSTOP=0
 ;
 ; check to see if request is pending - allow deletion if exists
 S PRCPREQ=$G(^PRCP(445,PRCP("I"),7))
 I $P(PRCPREQ,"^")]"" D  I PRCPSTOP G EXIT
 . S Y=$P(PRCPREQ,"^",2) X ^DD("DD")
 . S PRCPTIME=Y
 . D EN^DDIOL(" ")
 . N DA,DIE,DIR,DR
 . S DIR(0)="Y"
 . S DIR("A",1)=$P(^VA(200,+PRCPREQ,0),"^")_" made a request on "_PRCPTIME
 . S DIR("A",2)=" "
 . S DIR("A")="Do you wish to remove this"
 . S DIR("?")="Enter 'Y' or 'YES' to delete the current request"
 . S DIR("?",1)="Enter 'N' or 'NO' to retain the current request and quit"
 . D ^DIR
 . I $D(DUOUT)!$D(DTOUT) S PRCPSTOP=1 Q
 . I Y=0 S PRCPSTOP=1 Q
 . S DIE="^PRCP(445,",DA=PRCP("I"),DR="24////@;25////@"
 . D ^DIE
 . D EN^DDIOL("The current request has been deleted.")
 . Q
 ;
 K X S X(1)="WARNING: USE THIS OPTION ONLY IF THE INTERFACE IS FUNCTIONING WELL AND IS "
 S X(2)="            UP-TO-DATE ON PROCESSING TRANSACTIONS."
 D DISPLAY^PRCPUX2(1,79,.X)
 D EN^DDIOL(" ")
 D EN^DDIOL("Your name will be on the Transaction Register for all adjusted items.")
 D EN^DDIOL("Please keep any records needed to justify these adjustments.")
 ;
 ; ask if they wish to proceed.
 D EN^DDIOL(" ")
 S DIR(0)="Y"
 S DIR("A")="Do you wish to create a new request"
 D ^DIR K DIR
 I $D(DUOUT)!$D(DTOUT) G EXIT
 I Y=0 D EN^DDIOL("No request created.") G EXIT
 ;
 I $$ORDCHK^PRCPUITM(0,+PRCP("I"),"R","R") D  G EXIT
 . D EN^DDIOL(" ")
 . D EN^DDIOL("This inventory has released orders that are not yet posted.")
 . D EN^DDIOL("YOU MUST FIRST POST OR DELETE ALL RELEASED ORDERS ON THIS INVENTORY POINT.")
 ;
 D EN^DDIOL(" ")
 S DIR("A")="Is recent supply station activity on the transaction register"
 S DIR(0)="Y"
 D ^DIR K DIR
 I Y=0 D  I PRCPSTOP G EXIT
 . S X(1)="Do not run this option until you know the interface is working correctly.   "
 . S X(2)="Call your IRM to verify:"
 . S X(3)="1) TaskMan is running"
 . S X(4)="2) PRCP2 SUPPLY STATION TXN RUN is scheduled for every 3-5 minutes."
 . S X(5)="3) The interface links are set up properly and are open."
 . D DISPLAY^PRCPUX2(1,79,.X)
 . S PRCPSTOP=1
 ;
 ; check for unprocessed transactions, stop if first transaction is older than 20 minutes
 S PRCPNEXT=$O(^PRCP(447.1,"C",+PRCP("PAR"),PRCP("I"),""))
 I PRCPNEXT]"" D  I PRCPSTOP=1 G EXIT
 . ; get info about txn, if older than 20 minutes, stop
 . N DIR,PRCPACT,PRCPTIME
 . D EN^DDIOL(" ")
 . D EN^DDIOL("There are supply station transactions waiting to be processed.")
 . S PRCPDATA=^PRCP(447.1,PRCPNEXT,0)
 . S %DT="S",Y=$P(PRCPDATA,"^",4) D DD^%DT S PRCPACT=Y
 . D EN^DDIOL("The oldest transaction was created at "_PRCPACT)
 . S %DT="S",Y=$P(PRCPDATA,"^",8) D DD^%DT S PRCPTIME=Y
 . D EN^DDIOL("and was received by VistA at "_PRCPTIME)
 . S Y=$P(PRCPDATA,"^",8) D NOW^%DTC
 . I %-Y>.002 D  S PRCPSTOP=1 QUIT
 . . S X(1)="This is more than 20 minutes ago.  You may not proceed until these"
 . . S X(2)="transactions are processed.  Call IRM and verify the PRCP2 Supply Station"
 . . S X(3)="TXN Run option is scheduled to run every 3 to 5 minutes in TaskMan."
 . . D DISPLAY^PRCPUX2(1,79,.X)
 . S Y=$P(PRCPDATA,"^",4),PRCPTIME=$P(PRCPDATA,"^",8)
 . I PRCPTIME-PRCPDATA>0 D
 . . D EN^DDIOL(" ")
 . . D EN^DDIOL("This transaction implies the clock setting on the supply station is wrong.")
 . . D EN^DDIOL("Please adjust the time on the supply station system to match the VistA")
 . . D EN^DDIOL("system before filing your request")
 . S DIR("A")="Do you wish to proceed?"
 . S DIR(0)="Y"
 . D ^DIR
 . I $D(DUOUT)!$D(DTOUT) S PRCPSTOP=1 QUIT
 . I Y=0 S PRCPSTOP=1 QUIT
 . Q
 ;
 ; ask for signature, if verified save DUZ and date/time in node 7 of file 445
 D ESIG^PRCUESIG(DUZ,.PRCPSTOP)
 I PRCPSTOP'=1 D EN^DDIOL("No request to replace the GIP quantities was filed.")
 I PRCPSTOP=1 D
 . W !
 . D NOW^%DTC
 . S ^PRCP(445,PRCP("I"),7)=DUZ_"^"_%
 . D EN^DDIOL("Your request to replace GIP values is now on file.")
 . D BLDSEG^PRCPHLQU(PRCP("I"))
 . D EN^DDIOL(" ")
 . D EN^DDIOL("Sending request for quantity information to supply station...")
 . D EN^DDIOL(" ")
 . D EN^DDIOL("The first QOH transaction time stamped by the supply station after")
 . S Y=% X ^DD("DD")
 . D EN^DDIOL(Y_" will cause the GIP values to be replaced.")
 . S PRCPSTOP=0
 ;
EXIT L -^PRCP(445,PRCP("I"),7)
 D CLEAR^PRCPULOC(445,PRCP("I")_"-7",0)
 Q
