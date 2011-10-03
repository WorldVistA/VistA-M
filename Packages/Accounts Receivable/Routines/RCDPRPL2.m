RCDPRPL2 ;WISC/RFJ-receipt profile listmanager options ;1 Jun 99
 ;;4.5;Accounts Receivable;**114,148,173,217**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;  this routine contains entry points for customize and printing
 ;
 ;
ACCTPROF ;  option: account profile
 D FULL^VALM1
 S VALMBCK="R"
 ;
 N ACCT,RCDEBTDA,RCTRANDA
 ;  select the payment transaction
 S RCTRANDA=$$SELPAY^RCDPRPL1(RCRECTDA)
 I RCTRANDA>0 D
 .   ;  find debtor (file 340) entry
 .   S RCDEBTDA=0
 .   S ACCT=$P(^RCY(344,RCRECTDA,1,RCTRANDA,0),"^",3)
 .   I ACCT[";DPT(" S RCDEBTDA=$O(^RCD(340,"B",ACCT,0))
 .   I ACCT["PRCA(430," S RCDEBTDA=$P($G(^PRCA(430,+ACCT,0)),"^",9)
 .   I 'RCDEBTDA S VALMSG="Account NOT found for payment transaction."
 ;
 ;  payment not selected ask to select an account
 I '$D(RCDEBTDA) S RCDEBTDA=$$SELACCT^RCDPAPLM
 ;
 I $G(RCDEBTDA)'>0 Q
 D EN^VALM("RCDP ACCOUNT PROFILE")
 S VALMBCK="R"
 ;  fast exit
 I $G(RCDPFXIT) S VALMBCK="Q"
 Q
 ;
 ;
PRINRECT ;  option: print a receipt
 D FULL^VALM1
 S VALMBCK="R"
 ;
 N RCTRANDA
 ;  select the payment transaction
 S RCTRANDA=$$SELPAY^RCDPRPL1(RCRECTDA) I RCTRANDA<1 Q
 ;
 ;  check if transaction has a payment amount
 I '$P($G(^RCY(344,RCRECTDA,1,RCTRANDA,0)),"^",4) S VALMSG="NO Payment Amount on Transaction." Q
 ;
 S VALMSG=$$DEVICE^RCDPRECT
 I VALMSG=0 S VALMSG="Receipt NOT printed"
 Q
 ;
 ;
PRINT215 ;  print 215 report
 N %ZIS,POP
 D FULL^VALM1
 S VALMBCK="R"
 ;
 N RECEIPDA,RCTYPE
 S RECEIPDA=RCRECTDA
 ;
 S RCTYPE=$$GETTYPE^RCDPR215
 I RCTYPE="" Q
 ;
 ;  select device
 W ! S %ZIS="Q" D ^%ZIS Q:POP
 I $D(IO("Q")) D  D ^%ZTLOAD K IO("Q"),ZTSK D ^%ZISC Q
 .   S ZTDESC="Print 215 Report",ZTRTN="DQ^RCDPR215"
 .   S ZTSAVE("RECEIPDA")="",ZTSAVE("RCTYPE")="",ZTSAVE("ZTREQ")="@"
 W !!,"<*> please wait <*>"
 D DQ^RCDPR215
 Q
 ;
 ;
CUSTOMIZ ;  option: customize display
 D FULL^VALM1
 S VALMBCK="R"
 ;
 W !!,"This option will allow the user to customize the screen and options"
 W !,"used for receipt processing."
 ;
 ;  ask to show check/credit card data
 I $$ASKCHECK=-1 Q
 ;
 ;  ask to show acct lookup, batch and sequence number
 I $$ASKACCT=-1 D INIT^RCDPRPLM Q
 ;
 ;  ask to show comments
 I $$ASKCOMM=-1 D INIT^RCDPRPLM Q
 ;
 ;  ask to show fms cr documents
 I $$ASKFMS=-1 D INIT^RCDPRPLM Q
 ;
 ;  ask to show EOB detail information
 I $$ASKEOB=-1 D INIT^RCDPRPLM Q
 ;
 ;  make sure form is rebuilt based on the above answers
 D INIT^RCDPRPLM
 ;
 ;
 W !!,"The next prompts will allow the user to individually set up the way receipts"
 W !,"should be printed when entering payment transactions.  The user can set"
 W !,"the software up to automatically print a receipt to a device, never print"
 W !,"the receipt, or ask to print the receipt.  The user can also specify the"
 W !,"printer used for printing receipts, preventing from having to re-enter it."
 N DEVICE,TYPE
 ;
 ;  for printing receipts
 D  Q:TYPE<0
 .   W !
 .   S TYPE=$$ASKRECT
 .   I TYPE<0 Q
 .   ;
 .   ;  never print receipt
 .   I TYPE=0 D RCSET("RECEIPT",0) Q
 .   ;
 .   ;  ask default printer device
 .   S DEVICE=$$ASKDEVIC(1)
 .   ;
 .   ;  no default printer, always print receipt
 .   I DEVICE="",TYPE=1 D  Q
 .   .   W !,"Since you did not enter a default printer for printing receipts,"
 .   .   W !,"I will change it so the software will ask you to print the receipt"
 .   .   W !,"when entering a payment transaction."
 .   .   D RCSET("RECEIPT",2)
 .   ;
 .   ;  set default printer for receipts
 .   D RCSET("RECEIPT",TYPE_"^"_DEVICE)
 ;
 ;  for printing 215 report
 W !!!,"You now have the option of setting up the default printer for automatically"
 W !,"printing the 215 report when a receipt is processed.",!
 ;  ask default printer device
 S DEVICE=$$ASKDEVIC(2)
 D RCSET("215REPORT",U_DEVICE)
 Q
RCSET(RCSNPT,RCSLDV) ;file the selected parameter & device
 N DA,DIC,DIE,DR,X,Y
 I '$D(^RC(342.3,"B",RCSNPT)) D
 .K DD,DO,DIC("DR") S DIC="^RC(342.3,",DIC(0)="",X=RCSNPT D FILE^DICN
 S DA(1)=$O(^RC(342.3,"B",RCSNPT,0))
 I '$D(^RC(342.3,DA(1),1,"B",DUZ)) D  Q
 .S DIC(0)="",DIC("P")=$P(^DD(342.3,1,0),U,2),DIC="^RC(342.3,"_DA(1)_",1,",X=DUZ
 .S DIC("DR")="1////"_$P(RCSLDV,U)_";2////"_$P(RCSLDV,U,2)
 .K DD,DO D FILE^DICN
 S DA=$O(^RC(342.3,DA(1),1,"B",DUZ,0)),DR=".01////"_DUZ_";1////"_$P(RCSLDV,U)_";2////"_$P(RCSLDV,U,2)
 S DIE="^RC(342.3,"_DA(1)_",1," D ^DIE
 Q
 ;
OPTCK(RCSNPT,RCSLDV) ;return the selection in piece 2 and device in piece 3
 N RCDA
 S RCDA=$O(^RC(342.3,+$O(^RC(342.3,"B",RCSNPT,0)),1,"B",DUZ,0))
 I RCDA S RCDA=$P($G(^RC(342.3,+$O(^RC(342.3,"B",RCSNPT,0)),1,RCDA,0)),U,RCSLDV)
 Q RCDA
 ;
 ;
ASKCHECK() ;  ask if its okay to show check/credit card data
 ;  1 is yes, otherwise no
 N DIR,DIQ2,DTOUT,DUOUT,X,Y
 S DIR(0)="YO"
 S DIR("B")="NO"
 I $$OPTCK("SHOWCHECK",2) S DIR("B")="YES"
 S DIR("A")="  Do you want to show check and credit card information"
 W ! D ^DIR
 I $G(DTOUT)!($G(DUOUT)) S Y=-1
 I Y'=-1 D RCSET("SHOWCHECK",Y)
 Q Y
 ;
ASKEOB() ;  ask if its okay to show EOB detail data
 ;  1 is yes, otherwise no
 N DIR,DIQ2,DTOUT,DUOUT,X,Y
 S DIR(0)="YO"
 S DIR("B")="NO"
 I $$OPTCK("SHOWEOB",2) S DIR("B")="YES"
 S DIR("A")="  Do you want to show electronic EEOB detail data"
 W ! D ^DIR
 I $G(DTOUT)!($G(DUOUT)) S Y=-1
 I Y'=-1 D RCSET("SHOWEOB",Y)
 Q Y
 ;
ASKACCT() ;  ask if its okay to show acct lookup, batch, and sequence
 ;  1 is yes, otherwise no
 N DIR,DIQ2,DTOUT,DUOUT,X,Y
 S DIR(0)="YO"
 S DIR("B")="NO"
 I $$OPTCK("SHOWACCT",2) S DIR("B")="YES"
 S DIR("A")="  Do you want to show acct lookup, batch and sequence information"
 W ! D ^DIR
 I $G(DTOUT)!($G(DUOUT)) S Y=-1
 I Y'=-1 D RCSET("SHOWACCT",Y)
 Q Y
 ;
 ;
ASKCOMM() ;  ask if its okay to show comments and posting errors
 ;  1 is yes, otherwise no
 N DIR,DIQ2,DTOUT,DUOUT,X,Y
 S DIR(0)="YO"
 S DIR("B")="NO"
 I $$OPTCK("SHOWCOMMENTS",2) S DIR("B")="YES"
 S DIR("A")="  Do you want to show comments"
 W ! D ^DIR
 I $G(DTOUT)!($G(DUOUT)) S Y=-1
 I Y'=-1 D RCSET("SHOWCOMMENTS",Y)
 Q Y
 ;
 ;
ASKFMS() ;  ask if its okay to show fms documents
 ;  1 is yes, otherwise no
 N DIR,DIQ2,DTOUT,DUOUT,X,Y
 S DIR(0)="YO"
 S DIR("B")="NO"
 I $$OPTCK("SHOWFMS",2) S DIR("B")="YES"
 S DIR("A")="  Do you want to show the FMS cash receipt documents"
 W ! D ^DIR
 I $G(DTOUT)!($G(DUOUT)) S Y=-1
 I Y'=-1 D RCSET("SHOWFMS",Y)
 Q Y
 ;
 ;
ASKRECT() ;  ask to print the receipt
 ;  returns 0 (never), 1 (always), or 2 (ask)
 N DEFAULT,DIR,DIQ2,DTOUT,DUOUT,X,Y
 S DEFAULT="ALWAYS"
 I $$OPTCK("RECEIPT",2)'=""!($$OPTCK("RECEIPT",3)'="") S DEFAULT=$$OPTCK("RECEIPT",2),DEFAULT=$S(DEFAULT=0:"NEVER",DEFAULT=1:"ALWAYS",1:"MAYBE")
 S DIR(0)="SO^0:Never Print the Receipt;1:Always Print the Receipt;2:Maybe, Ask to Print the Receipt"
 S DIR("A")="Print Receipt"
 S DIR("B")=DEFAULT
 D ^DIR
 I $G(DTOUT)!($G(DUOUT)) S Y=-1
 Q Y
 ;
 ;
ASKDEVIC(RCTYPE) ;  ask the default printer for receipts and for 215 report
 ;  rctype=1 for receipts, rctype=2 for 215 report
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
 ;  reset current device
 D ^%ZISC
 Q RCION
 ;
SHEOB ;  show EEOB detail if switch on - moved from RCDPRPLM
 I $$OPTCK("SHOWEOB",2) D
 .   N Z
 .   S Z=$O(^RCY(344.4,"ARCT",RCRECTDA,0))
 .   Q:'Z
 .   S RCLINE=RCLINE+1 D SET^RCDPRPLM(" ",RCLINE,1,80)
 .   S RCLINE=RCLINE+1 D SET^RCDPRPLM("EEOB Detail:",RCLINE,1,80,0,IOUON,IOUOFF)
 .   K ^TMP($J,"RCDISP") D DISP^RCDPEDS(Z)
 .   S Z=0 F  S Z=$O(^TMP($J,"RCDISP",Z)) Q:'Z  S RCLINE=RCLINE+1 D SET^RCDPRPLM(^TMP($J,"RCDISP",Z),RCLINE,1,80)
 .   K ^TMP($J,"RCDISP")
 Q
 ;
