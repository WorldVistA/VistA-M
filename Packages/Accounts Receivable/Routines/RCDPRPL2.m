RCDPRPL2 ;WISC/RFJ-receipt profile List Manager options ;1 Nov 2018 13:02:23
 ;;4.5;Accounts Receivable;**114,148,173,217,332**;Mar 20, 1995;Build 40
 ;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
 ; This routine contains entry points for customization and printing
 ;
ACCTPROF ;EP from protocol RCDP RECEIPT PROFILE ACCOUNT PROFILE
 ; Account Profile action
 D FULL^VALM1
 S VALMBCK="R"
 ;
 N ACCT,RCDEBTDA,RCTRANDA
 S RCTRANDA=$$SELPAY^RCDPRPL1(RCRECTDA)  ; Select payment transaction
 I RCTRANDA>0 D  ; Find debtor (file 340) entry
 . S RCDEBTDA=0
 . S ACCT=$P(^RCY(344,RCRECTDA,1,RCTRANDA,0),U,3)  ; (#.03) ACCOUNT [3V]
 . I ACCT["DPT(" S RCDEBTDA=$O(^RCD(340,"B",ACCT,0))
 . I ACCT["PRCA(430," S RCDEBTDA=$P($G(^PRCA(430,+ACCT,0)),U,9)
 . I 'RCDEBTDA S VALMSG="Account NOT found for payment transaction."
 ;
 ; Payment not selected ask to select an account
 I '$D(RCDEBTDA) S RCDEBTDA=$$SELACCT^RCDPAPLM
 ;
 Q:$G(RCDEBTDA)'>0
 D EN^VALM("RCDP ACCOUNT PROFILE")
 S VALMBCK="R"
 I $G(RCDPFXIT) S VALMBCK="Q"  ; Fast exit
 Q
 ;
PRINRECT ;EP from protocol action RCDP RECEIPT PROFILE PRINT RECEIPT
 ; Print a receipt
 D FULL^VALM1
 S VALMBCK="R"
 N RCTRANDA
 ;
 ; Select the payment transaction
 S RCTRANDA=$$SELPAY^RCDPRPL1(RCRECTDA)
 Q:RCTRANDA<1
 ;
 ; Check if transaction has a payment amount
 I '$P($G(^RCY(344,RCRECTDA,1,RCTRANDA,0)),U,4) D  Q
 . S VALMSG="NO Payment Amount on Transaction."
 ;
 S VALMSG=$$DEVICE^RCDPRECT
 I VALMSG=0 S VALMSG="Receipt NOT printed"
 Q
 ;
PRINT215 ;EP from protocol action RCDP RECEIPT PROFILE 215 REPORT
 ; Print 215 report
 ; Input:   RCRECTDA    - IEN of the selected receipt (#344)
 N %ZIS,POP,RECEIPDA,RCTYPE
 D FULL^VALM1
 S VALMBCK="R",RECEIPDA=RCRECTDA
 S RCTYPE=$$GETTYPE^RCDPR215
 I RCTYPE="" Q
 ;
 ; Select device
 W !
 S %ZIS="Q"
 D ^%ZIS
 Q:POP
 I $D(IO("Q")) D  D ^%ZTLOAD K IO("Q"),ZTSK D ^%ZISC Q
 . S ZTDESC="Print 215 Report",ZTRTN="DQ^RCDPR215"
 . S ZTSAVE("RECEIPDA")="",ZTSAVE("RCTYPE")="",ZTSAVE("ZTREQ")="@"
 W !!,"<*> please wait <*>"
 D DQ^RCDPR215
 Q
 ;
CUSTOMIZ ;EP from protocol RCDP RECEIPT PROFILE CUSTOMIZE
 ; Option to customize display and printing of the receipt
 ; Input:   None
 ; Output:  Receipt Profile display and printing options customized
 N OPT,QUES
 D FULL^VALM1
 S VALMBCK="R"
 ;
 W !!,"This option will allow the user to customize the screen and options"
 W !,"used for receipt processing."
 ;
 ; Ask to show check/credit card data
 S OPT="SHOWCHECK"
 S QUES="  Do you want to show trace #, check and credit card information"
 Q:$$ASKCUST(OPT,QUES)=-1
 ;
 ; Ask to show acct lookup, batch and sequence number
 S OPT="SHOWACCT"
 S QUES="  Do you want to show acct. lookup, batch and sequence information"
 I $$ASKCUST(OPT,QUES)=-1 D INIT^RCDPRPLM Q
 ;
 ; Ask to show comments
 S OPT="SHOWCOMMENTS",QUES="  Do you want to show comments"
 I $$ASKCUST(OPT,QUES)=-1 D INIT^RCDPRPLM Q
 ;
 ; Ask to show FMS cr documents
 S OPT="SHOWFMS"
 S QUES="  Do you want to show the FMS cash receipt documents"
 I $$ASKCUST(OPT,QUES)=-1 D INIT^RCDPRPLM Q
 ;
 ; Ask to show EOB detail information
 S OPT="SHOWEOB"
 S QUES="  Do you want to show electronic EEOB detail data"
 I $$ASKCUST(OPT,QUES)=-1 D INIT^RCDPRPLM Q
 ;
 ; Make sure form is rebuilt based on the answers above
 D INIT^RCDPRPLM
 ;
 W !!,"The next prompts will allow the user to individually set up the way receipts"
 W !,"should be printed when entering payment transactions.  The user can set"
 W !,"the software up to automatically print a receipt to a device, never print"
 W !,"the receipt, or ask to print the receipt.  The user can also specify the"
 W !,"printer used for printing receipts, preventing from having to re-enter it."
 N DEVICE,TYPE
 ;
 ; For printing receipts
 D  Q:TYPE<0
 . W !
 . S TYPE=$$ASKRECT Q:TYPE<0
 . ; Never print receipt
 . I TYPE=0 D RCSET("RECEIPT",0) Q
 . ; Ask default printer device
 . S DEVICE=$$ASKDEVIC(1)
 . ; No default printer, always print receipt
 . I DEVICE="",TYPE=1 D  Q
 ..  W !,"Since you did not enter a default printer for printing receipts,"
 ..  W !,"I will change it so the software will ask you to print the receipt"
 ..  W !,"when entering a payment transaction."
 ..  D RCSET("RECEIPT",2)
 . ; Set default printer for receipts
 . D RCSET("RECEIPT",TYPE_U_DEVICE)
 ;
 ; For printing 215 report
 W !!!,"You now have the option of setting up the default printer for automatically"
 W !,"printing the 215 report when a receipt is processed.",!
 ; Ask default printer device
 S DEVICE=$$ASKDEVIC(2)
 D RCSET("215REPORT",U_DEVICE)
 Q
 ;
RCSET(RCSNPT,RCSLDV) ; File the selected parameter & device as the user's preference
 ; RCSNPT  - Name of the user's preference parameter to file
 ; RCSLDV  - User's preference^Name of the device selected by the user
 N DA,DIC,DIE,DR,X,Y
 ;
 ; If this is a new parameter, file it
 I '$D(^RC(342.3,"B",RCSNPT)) D
 . K DD,DO,DIC("DR")
 . S DIC="^RC(342.3,",DIC(0)="",X=RCSNPT
 . D FILE^DICN
 ;
 ; File user's preference for the parameter if they don't have one currently defined
 S DA(1)=$O(^RC(342.3,"B",RCSNPT,0))
 I '$D(^RC(342.3,DA(1),1,"B",DUZ)) D  Q
 . S DIC(0)="",DIC("P")=$P(^DD(342.3,1,0),U,2),DIC="^RC(342.3,"_DA(1)_",1,",X=DUZ
 . S DIC("DR")="1////"_$P(RCSLDV,U,1)_";2////"_$P(RCSLDV,U,2)
 . K DD,DO
 . D FILE^DICN
 ;
 ; Edit the user's preference for the parameter
 S DA=$O(^RC(342.3,DA(1),1,"B",DUZ,0))
 S DR=".01////"_DUZ_";1////"_$P(RCSLDV,U)_";2////"_$P(RCSLDV,U,2)
 S DIE="^RC(342.3,"_DA(1)_",1,"
 D ^DIE
 Q
 ;
OPTCK(RCSNPT,RCSLDV) ; function, return user's preference for AR USER CUSTOMIZE parameter (if defined)
 ; Input:   RCSNPT  - Name of the AR USER CUSTOMIZE (#342.3) parameter to check
 ;          RCLSDV  - Piece to be retrieved off of the 342.3 record
 ; Returns: user's preference for RCSNPT or null if no preference in file
 N RCDA
 ;
 ; find user preference IEN for the specified entry (if any)
 S RCDA=$O(^RC(342.3,+$O(^RC(342.3,"B",RCSNPT,0)),1,"B",DUZ,0))
 ;
 ; If the user has a preference retrieve it
 I RCDA S RCDA=$P($G(^RC(342.3,+$O(^RC(342.3,"B",RCSNPT,0)),1,RCDA,0)),U,RCSLDV)
 Q RCDA
 ;
ASKCUST(OPT,QUES) ; Ask one of the customize questions from the CUSTOMIZ action
 ; Input:   OPT - Name of customize option to set
 ;          QUES - Question for the user
 ; Returns: 1 if answer 'YES', 0 if answer 'NO', -1 if timed out or '^'
 N DIR,DTOUT,DUOUT,X,Y
 S DIR(0)="YO"
 S DIR("B")="NO"
 S:$$OPTCK(OPT,2) DIR("B")="YES"
 S DIR("A")=QUES
 W !
 D ^DIR
 I $G(DTOUT)!($G(DUOUT)) S Y=-1
 I Y'=-1 D RCSET(OPT,Y)  ; PRCA*4.5*332, fixed OPT parameter
 Q Y
 ;
ASKRECT() ; function, ask user when they want to print the receipt
 ; Returns: 0 (never), 1 (always), 2 (ask), -1 (timed out or '^')
 N DEFAULT,DIR,DTOUT,DUOUT,X,Y
 S DEFAULT="ALWAYS"
 I $$OPTCK("RECEIPT",2)'=""!($$OPTCK("RECEIPT",3)'="") D
 . S DEFAULT=$$OPTCK("RECEIPT",2),DEFAULT=$S(DEFAULT=0:"NEVER",DEFAULT=1:"ALWAYS",1:"MAYBE")
 S DIR(0)="SO^0:Never Print the Receipt;1:Always Print the Receipt;2:Maybe, Ask to Print the Receipt"
 S DIR("A")="Print Receipt"
 S DIR("B")=DEFAULT
 D ^DIR
 I $G(DTOUT)!($G(DUOUT)) S Y=-1
 Q Y
 ;
ASKDEVIC(RCTYPE) ; Ask for the default printer for receipts and for 215 report
 ; Input:   RCTYPE - 1 for receipts, 2 for 215 report
 ; Returns: Name of selected device or ""
 N RCION
 S %ZIS="NP0"
 S %ZIS("A")="Enter the Default Printer for Printing Receipts: "
 I RCTYPE=2 S %ZIS("A")="Enter the Default Printer for Printing the 215 Report: "
 S %ZIS("B")=""
 I RCTYPE=1,$$OPTCK("RECEIPT",3)'="" S %ZIS("B")=$$OPTCK("RECEIPT",3)
 I RCTYPE=2,$$OPTCK("215REPORT",3)'="" S %ZIS("B")=$$OPTCK("215REPORT",3)
 D ^%ZIS
 I IO=IO(0) W !,"You cannot select your current device as a default printer." Q ""
 S RCION=ION
 ;
 ; close device
 D ^%ZISC
 Q RCION
 ;
SHEOB ; Show EEOB detail if switch on - moved from RCDPRPLM
 ; Input:  RCLINE - Current line count
 ; Output: RCLINE - Updated line countt
 I $$OPTCK("SHOWEOB",2) D
 . N Z S Z=$O(^RCY(344.4,"ARCT",RCRECTDA,0)) Q:'Z
 . S RCLINE=RCLINE+1
 . D SET^RCDPRPLM(" ",RCLINE,1,80)
 . S RCLINE=RCLINE+1
 . D SET^RCDPRPLM("EEOB Detail:",RCLINE,1,80,0,IOUON,IOUOFF)
 . K ^TMP($J,"RCDISP")
 . D DISP^RCDPEDS(Z)  ; build ^TMP($J,"RCDISP")
 . S Z=0 F  S Z=$O(^TMP($J,"RCDISP",Z)) Q:'Z  D
 ..  S RCLINE=RCLINE+1
 ..  D SET^RCDPRPLM(^TMP($J,"RCDISP",Z),RCLINE,1,80)
 . K ^TMP($J,"RCDISP")
 Q
 ;
