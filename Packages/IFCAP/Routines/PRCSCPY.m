PRCSCPY ;WISC/KMB/DXH/DAP - COPY OLD TEMP. REQUEST TO NEW ; 7.23.99
V ;;5.1;IFCAP;**81**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 N X3,T,T1,PRCSDR,OLDA,NEWDA,PRCDAA,PRCSAPP,PRCSK,NEWTEMP,OLD0NODE,OLD3NODE,I,J,PRCK,PRCHFLG
 ;
START ;
 W !!
 ; S PRCSK=1 ; flag to allow any user to select any site
 ; next line commented out in PRC*5*140 - user responses not used
 ; D EN1F^PRCSUT(1) G W2:'$D(PRC("SITE")) G EXIT:Y<0
 S X3="H",DIC="^PRCS(410,",DIC(0)="AEQ",DIC("A")="Select transaction to be copied: "
 S DIC("S")="I $P(^(0),U,3)'="""",^PRCS(410,""H"",$P(^(0),U,3),+Y)=DUZ!(^(+Y)="""")" ; request must be authored by user or be unauthored
 D ^PRCSDIC K DIC("A"),DIC("S")
 G EXIT:Y<0 ; user entered '^'
 S (OLDA,DA)=+Y ; subscript/internal# to file 410
 L +^PRCS(410,DA):1 I $T=0 D EN^DDIOL("File being accessed...please try later") Q
 D REVIEW
 S PRCVFT=$P(^PRCS(410,DA,0),"^",4)
 ;*81 Check site parameter to see if Issue Books are allowed
 I $$GET^XPAR("SYS","PRCV COTS INVENTORY",1,"Q")=1 S PRCVZ=1
 I $$GET^XPAR("SYS","PRCV COTS INVENTORY",1,"Q")'=1 S PRCVZ=0
 I PRCVZ=1,PRCVFT=5 W !,"All Supply Warehouse requests must be processed in the new Inventory System.",!!,"Please cancel this IFCAP Issue Book order." D CLEAN G START
 K DA,DIC,PRCVFT,PRCVZ
 I $D(%) G EXIT:%=-1
ENTRY ;
 D EN^DDIOL("Please enter information for the transaction being created.")
 W !
 S PRCSK=1 ; allow user to select any station on system
 D EN1F^PRCSUT(1) ;ask site, FY, QRTR, CP & store in PRC array, set up PRCSIP
 G W2:'$D(PRC("SITE")) ; only happens if there are no stations on system?
 G EXIT:Y<0
EN1 D EN^DDIOL("Please enter a new transaction in the format 'A1234'")
 W !
 S DIC("A")="Enter new temporary transaction number: "
 S DLAYGO=410,DIC="^PRCS(410,",DIC(0)="L",D="H"
 S DIC("S")="I '^(0),$P(^(0),U,3)'="""",^PRCS(410,""H"",$P(^(0),U,3),+Y)=DUZ!(^(+Y)="""")" ; only requests authored by user or unauthored will display on partial match, display doesn't filter for station,CP,FY,or QRTR
 D ^PRCSDIC S NEWTEMP=X K DLAYGO,DIC("A"),DIC("S") G:Y<0 EXIT
 I $D(^PRCS(410,"H",$P(Y,U,2)))
 I  D EN^DDIOL("Must be a new and different temporary number.","","!!") G EN1
 S (NEWDA,T1,DA)=+Y ; subscript/internal# to file 410 for new txn
 ;
PROCESS ;ERC-10/96 Revised copy of fields into new transaction
 L +^PRCS(410,NEWDA):1 ; lock file being created
 I $T=0 D EN^DDIOL("File being accessed...please try a different number or try later") G EN1
 D EN^DDIOL("Transaction data is being copied.","","!?10") W !
 S T(2)=NEWTEMP
 D EN2A^PRCSUT3 ; sets up sta,substa,BBFY,author,CP,ACC,rb code,etc
 S OLD0NODE=^PRCS(410,OLDA,0),OLD3NODE=^PRCS(410,OLDA,3)
 F I=2,4 S $P(^PRCS(410,NEWDA,0),U,I)=$P(OLD0NODE,U,I) ; txn type,format
 ; note that for any FCP that is not automated,the form type is not forced to be non repetitive.  This may be because full implementation of IFCAP is mandatory.
 I $D(PRCSIP) S $P(^PRCS(410,NEWDA,0),U,6)=PRCSIP ; inventory distrib point, 'AO' xref will be set by XREF subroutine
 S %DT="X",X="T" D ^%DT ; get today in internal date format
 S $P(^PRCS(410,NEWDA,1),U)=Y ; & store as date of request
 I $D(^PRCS(410,OLDA,2)) S ^PRCS(410,NEWDA,2)=^PRCS(410,OLDA,2) ; vendor info may not be on 1358's
 F I=4:1:10 S $P(^PRCS(410,NEWDA,3),U,I)=$P(OLD3NODE,U,I)
 I $P(OLD3NODE,U)'=PRC("CP") S PRCHFLG=1 ; different CP
 E  S $P(^PRCS(410,NEWDA,3),U,3)=$P(OLD3NODE,U,3)
 F I=4,10 I $D(^PRCS(410,OLDA,I)) S $P(^PRCS(410,NEWDA,I),U)=$P(^PRCS(410,OLDA,I),U)
 I $P(^PRCS(410,NEWDA,0),U,4)=1 ;1358 needs Date Committed
 I  S $P(^PRCS(410,NEWDA,4),U,2)=$E($P(^PRCS(410,NEWDA,1),U),1,5)_"01"
 S $P(^PRCS(410,DA,7),U)=DUZ ; PRC140 - this line moved from FINAL
 S $P(^PRCS(410,DA,14),U)=DUZ
 I $D(^PRCS(410,OLDA,"RM",0)) S ^PRCS(410,NEWDA,"RM",0)=$P(^PRCS(410,OLDA,"RM",0),U,1,4)_"^"_DT,PRCK=0 D
 . F J=0:0 S PRCK=$O(^PRCS(410,OLDA,"RM",PRCK)) Q:'PRCK  S:$D(^PRCS(410,OLDA,"RM",PRCK,0)) ^PRCS(410,NEWDA,"RM",PRCK,0)=$P(^PRCS(410,OLDA,"RM",PRCK,0),U)
 S T1=OLDA,DA=NEWDA
 D S7^PRCSECP1 ; copy 'IT' subnode from the old transaction
 ;new transaction has different FCP from old txn
 I +$G(PRCHFLG) S PRCHFLG=$$CHGCCBOC^PRCSCK($P($G(^PRCS(410,T1,0)),U),$P($G(^PRCS(410,NEWDA,0)),U),$P($G(^PRCS(410,OLDA,3)),U,3),0)
 ;I '$G(PRCHFLG) G P2 ; new transaction has same CP as original
 ;D SRCH I X'="" S:X'=1 $P(^PRCS(410,NEWDA,3),U,3)=X G P1
 ;S DA=NEWDA,DR=15.5,DIE="^PRCS(410," D ^DIE ; ask cost center
 ;I $D(Y)'=0 D XREF G EXIT ; user entered '^'
 I ($G(PRCHFLG)<-1) D XREF G EXIT ; user entered '^'
P1 K PRCHFLG
P2 S DIC(0)="AEMQ",DIE=DIC,DR=7 D ^DIE ; ask Date required
 I $D(Y)'=0 D XREF G EXIT ; user entered '^'
 D XREF G EDIT
XREF S DA=NEWDA,DIK="^PRCS(410," D IX^DIK ; set up X-refs for new transaction
 Q 
EDIT ;
 S %=2 D EN^DDIOL("Would you like to edit this entry")
 D YN^DICN G EDIT:%=0 G EXIT:%=-1 G:%=2 FINAL
EDIT1 ;
 S X=+$P($G(^PRCS(410,DA,0)),"^",4) ; X is form type
 ;*81 Check site parameter to see if issue books should be allowed
 I $$GET^XPAR("SYS","PRCV COTS INVENTORY",1,"Q")=1 S PRCVX="I Y>1&(Y<5)",PRCVY="The Issue Book and NO FORM types are not valid in this option."
 I $$GET^XPAR("SYS","PRCV COTS INVENTORY",1,"Q")'=1 S PRCVX="I Y>1",PRCVY="The NO FORM type is not valid in this option."
 I X<1 D
 . S DA=NEWDA
 . D EN^DDIOL(PRCVY)
 . D EN^DDIOL("Please enter another form type.","","!!")
 . W !
 . S DIC="^PRCS(410.5,"
 . S DIC("A")="FORM TYPE: "
 . S DIC(0)="AEQZ"
 . S DIC("S")=PRCVX
 . D ^DIC
 . S:Y=-1 Y=2
 . S $P(^PRCS(410,NEWDA,0),"^",4)=+Y,X=+Y
 . K DIC,PRCVX,PRCVY
 D EN^DDIOL("The form type of this request is "_$P($G(^PRCS(410.5,X,0)),"^"))
 ; PRC140 - 2237 form types now use temporary transaction templates
 S (PRCSDR,DR)="["_$S(X=1:"PRCE NEW 1358S",X=2:"PRCSEN2237S",X=3:"PRCSENPRS",X=4:"PRCSENR&NRS",X=5:"PRCSENIBS",1:"PRCSENCOD")_"]"
 K DTOUT,DUOUT,Y
 S (DIE,DIC)="^PRCS(410,"
 D ^DIE I $D(Y)!($D(DTOUT)) G EXIT
 I +$P($G(^PRCS(410,DA,0)),"^",4)=1 G FINAL ; skip line item processing if this is a 1358
 S DA=NEWDA D RL^PRCSUT1
 D ^PRCSCK I $D(PRCSERR),PRCSERR G EDIT1
 ;
FINAL ;
 W !! D CLEAN G START
 ;
REVIEW W !!,"Would you like to review this request" S %=2
 D YN^DICN G REVIEW:%=0 I %'=1 Q
 S PRC("SITE")=+$P(^PRCS(410,DA,0),"^",5)
 S PRC("CP")=$P(^PRCS(410,DA,3),"^")
 S (N,PRCSZ)=DA,PRCSF=1 D PRF1^PRCSP1 S DA=OLDA K X,PRCSF,PRCSZ Q
 ;
W2 D EN^DDIOL("You are not an authorized control point user.","","!!")
 D EN^DDIOL("Contact your control point official")
 R X:5 G EXIT
W3 Q  ;can this be deleted? - commented out in patch PRC*5*140
 D EN^DDIOL("Would you like to copy another request","","!!")
 S %=1 D YN^DICN G W3:%=0 G START:%=1 Q
 ;
SRCH ;FIND COST CENTER
 ; returns x="" if there are multiple cc's, x=1 if no cc, x=cc if only 1
 S X=0
SRCH1 S X=$O(^PRC(420,PRC("SITE"),1,+PRC("CP"),2,X))
 I X=""!(+X'=X) D EN^DDIOL("Transaction will be created but this control point has no active cost center","","!!") S X=1 Q
 I '$D(^PRCD(420.1,X,0)) G SRCH1
 I $P(^PRCD(420.1,X,0),U,2)=1 G SRCH1
 S Y=X ; found 1 cost center
SRCH2 S X=$O(^PRC(420,PRC("SITE"),1,+PRC("CP"),2,X))
 I X=""!(+X'=X) S X=$P(^PRCD(420.1,Y,0),U) Q  ; save cost center
 I '$D(^PRCD(420.1,X,0)) G SRCH2
 I $P(^PRCD(420.1,X,0),U,2)=1 G SRCH2
 S X="" ; system can't select cost center - there is more than 1
 Q
CLEAN I $D(OLDA) L -^PRCS(410,OLDA)
 I $D(NEWDA)=1 L -^PRCS(410,NEWDA)
 K %,DA,DIC,X,Y,PRCSERR
 Q
 ;
EXIT D CLEAN
 Q
