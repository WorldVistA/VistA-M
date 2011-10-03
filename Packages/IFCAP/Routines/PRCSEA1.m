PRCSEA1 ;WISC/KMB/DXH - REQUESTOR ENTER 1358 ;7.26.99
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
EN ;
 N PRCAED,DIR,DIRUT,PRCS,PRCSCP,PRCSN,PRCSTT,PRC,X,X1,DIC,DIE,DR,PRCSL,PRCSIP,X3
 S PRCSK=1,X3="H"
 D EN1F^PRCSUT(1) Q:Y<0
 D EN^DDIOL("Enter a 2-16 digit number with a leading alpha, as in 'ABC123'","","!!")
 D EN^DDIOL(" ") ; blank line
EN1 ;
 S DLAYGO=410,DIC="^PRCS(410,",DIC(0)="AELQ",D="H"
 S DIC("A")="Select TRANSACTION: "
 S DIC("S")="I '^(0),$P(^(0),U,3)'="""",$D(^PRCS(410,""H"",$P(^(0),U,3),+Y)),^(+Y)=DUZ!(^(+Y)="""")" ; request must be authored by user or unauthored
 D ^PRCSDIC
 K DLAYGO,DIC("A"),DIC("S")
 Q:Y<0
 I $P(Y,U,3)'=1 D EN^DDIOL("Must be a new entry. ") G EN1
 L +^PRCS(410,+Y):1 ;CHANGED DA TO +Y IN P182
 I $T=0 D EN^DDIOL("File being accessed, please try another entry") G EN1
 S T(2)=$P(Y,U,2)
 D EN2A^PRCSUT3 ; saves CP,sta,substa,txn name,user,BBFY,RB stat,acct data, etc. in new ien (nodes 0,3,6,11 of file 410)
 S $P(^PRCS(410,DA,14),"^")=DUZ ; originator (entered by)
 S $P(^PRCS(410,DA,7),"^",1)=DUZ,$P(^PRCS(410,DA,7),"^",2)=$P($G(^VA(200,DUZ,20)),"^",3)
 ; commented out by PRC*5*140 - automated flag not implemeted in option, if commented lines are removed, remember to stop newing the PRCS variable
 ; S PRCS="" I $D(^PRC(420,PRC("SITE"),1,+PRC("CP"),0)) S:$P(^(0),"^",11)="Y" PRCS=1
 S X=T(2)
 D EN^DDIOL("This transaction is assigned temporary transaction number: "_X,"","!!")
 K PRCSERR
 S DIC(0)="AEMQ",DIE=DIC,DIE("NO^")=1
 S DR="3///1"_$S($D(PRCSIP):";4////"_PRCSIP,1:""),X4=1
 D ^DIE
 S PRCAED=1 ; cannot find where or how PRCAED is used
 S DR="[PRCE NEW 1358S]"
 D ^DIE
 D W1^PRCSEB ; ask 'review?'
 L -^PRCS(410,DA)
 S DIR("B")="NO",DIR(0)="Y"
 S DIR("A")="Do you want to enter another new request"
 D ^DIR Q:'Y!($D(DIRUT))
 W !!
 ; removed by PRC*5*140 - PRCS2 never set up
 ; K PRCS2
 G EN1
ED ;edit 1358 for requestor
 N PRCAED,DIR,DIRUT,PRCS,PRCSCP,PRCSN,PRCSTT,PRC,X,X1,DIC,DIE,DR,PRCSL,PRCSIP,X3
ED1 ;
 S PRCAED=1,X3=1 ; PRC*5*140 comment - PRCAED used?, X3="H" for all other temp txn options.  X3 determines xrefs to search in finding txn name.
 D EN^DDIOL("Enter a 2-16 digit number with a leading alpha, as in 'ABC123'","","!!")
 D EN^DDIOL(" ")
 S DIC="^PRCS(410,",DIC(0)="AEQ",D="H"
 S DIC("A")="Select TRANSACTION: "
 S DIC("S")="I '^(0),$P(^(0),U,3)'="""",$P(^(0),U,4)=1,^PRCS(410,""H"",$P(^(0),U,3),+Y)=DUZ!(^(+Y)="""")" ; request must be authored by user or unauthored & must be a 1358
 D ^PRCSDIC ; lookup & prelimiary validity checking
 K DIC("A"),DIC("S")
 Q:Y<0
 S DA=+Y
 L +^PRCS(410,DA):1 I $T=0 D EN^DDIOL("File being accessed...try later") Q
 S DIC=(0)="AEMQ",DIE="^PRCS(410,"
 S PRC("SITE")=+$P(^PRCS(410,DA,0),"^",5)
 S PRC("CP")=$P(^PRCS(410,DA,3),"^")
 S (PRCSDR,DR)="[PRCE NEW 1358S]"
 K DTOUT,DUOUT,Y
 S PDA=DA
 D ^DIE
 S DA=PDA
 I $D(Y)!($D(DTOUT)) S PRCAED=-1
 D W1^PRCSEB
 L -^PRCS(410,DA)
 S DIR("B")="NO",DIR(0)="Y"
 S DIR("A")="Would you like to edit another request"
 D ^DIR
 Q:'Y!($D(DIRUT))
 G ED1
W6 D EN^DDIOL("For the transaction number,use an uppercase alpha as the first character,")
 D EN^DDIOL(" and then 2-15 alphanumerics, as in 'ADP1'.")
 D EN^DDIOL(" ")
 Q
