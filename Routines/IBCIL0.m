IBCIL0 ;DSI/ESG - CLAIMSMANAGER SKIP LIST ;11-JAN-2001
 ;;2.0;INTEGRATED BILLING;**161**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;The skip list is a routine that will allow system managers the
 ;capabilities to select transactions that errored due to system 
 ;failures.  This routine utilizes ListMan functions.
EN ; -- main entry point for IBCI CLAIMSMANAGER SKIP LIST
 ;
 ; Try to get an option-level lock
 L +^IBCIL0:0
 E  W @IOF,!!!?10,"Another user is currently using this option.",!!?10,"Please try again later.",!! S DIR(0)="E" D ^DIR K DIR Q
 ;
 I '$$CK2^IBCIUT1 D  Q     ; check to see that ClaimsManager working OK
 . W @IOF,!!!?10,"ClaimsManager is not working right now."
 . W !!?10,"Please try again later.",!!
 . S DIR(0)="E" D ^DIR K DIR
 . L -^IBCIL0
 . Q
 ;
 D EN^VALM("IBCI CLAIMSMANAGER SKIP LIST")
 KILL ^TMP("IBCIL0",$J),^TMP("IBCIL1",$J),^TMP("IBCIL2",$J)
 KILL IBCISTAT,IBCISNT,IBCIREDT,IBCIERR,CT
 L -^IBCIL0
 Q
 ;
HDR ; -- header code
 S VALMHDR(1)="                      Welcome to ClaimsManager Bill Processing"
 S VALMHDR(2)="          This ListMan will display all skipped bills for processing"
 Q
 ;
INIT ; -- init variables and list array
 D CLEAN^VALM10
 K ^TMP("IBCIL0",$J),^TMP("IBCIL1",$J),^TMP("IBCIL2",$J),CT
 NEW IBCIVAUS,IBCIFDAT,IBCIIEN,IBCIBNUM
 NEW IBCINAME,IBCIDATE,IBCIUSER,IBCIST0,IBCIST1,IBCIARR
 NEW IBCISKST,NODE0,IBCIDFN,IBCIXX
 S IBCIARR=""
 F IBCISKST=2,6,7,10,11 D
 .S IBCIIEN=0 F  S IBCIIEN=$O(^IBA(351.9,"AST",IBCISKST,IBCIIEN)) Q:'IBCIIEN  D
 ..S NODE0=^IBA(351.9,IBCIIEN,0)
 ..S IBCIBNUM=$P(^DGCR(399,IBCIIEN,0),U,1)
 ..S IBCIFDAT=$P($P(^DGCR(399,IBCIIEN,0),U,3),".",1)
 ..S IBCIDATE=$$FDATE^VALM1(IBCIFDAT)
 ..S IBCIUSER=$P(NODE0,U,12)                          ; assigned to peep
 ..I 'IBCIUSER S IBCIUSER=+$$BILLER^IBCIUT5(IBCIIEN)  ; biller
 ..I 'IBCIUSER S IBCIUSER=$P(NODE0,U,9)               ; last edited by
 ..I 'IBCIUSER S IBCIUSER=$P(NODE0,U,7)               ; entered by
 ..S IBCIVAUS=$P($G(^VA(200,IBCIUSER,0)),U,1)
 ..I IBCIVAUS="" S IBCIVAUS="UNKNOWN"
 ..S IBCIDFN=$P(^DGCR(399,IBCIIEN,0),U,2)
 ..S IBCINAME=$P($G(^DPT(IBCIDFN,0)),U,1)
 ..S IBCIST0=$P(^DGCR(399,IBCIIEN,0),U,13)
 ..I IBCIST0=1 S IBCIST1="E/NR"
 ..I IBCIST0=2 S IBCIST1="R/MRA"
 ..I IBCIST0=3 S IBCIST1="AUTH"
 ..I IBCIST0=4 S IBCIST1="PR/TX"
 ..I IBCIST0=7 S IBCIST1="CANX"
 ..I IBCIST0=0 S IBCIST1="CLSD",IBCIST0=9
 ..S ^TMP("IBCIL0",$J,IBCIST0,IBCIVAUS,IBCIBNUM)=IBCIIEN_U_IBCIST1_U_IBCIVAUS_U_IBCIBNUM_U_IBCINAME_U_IBCIDATE
SRT ;sort
 S (IBCIST0,CT)=0 F  S IBCIST0=$O(^TMP("IBCIL0",$J,IBCIST0)) Q:'IBCIST0  D
 .S IBCIUSER="" F  S IBCIUSER=$O(^TMP("IBCIL0",$J,IBCIST0,IBCIUSER)) Q:IBCIUSER=""  D
 ..S IBCIBNUM="" F  S IBCIBNUM=$O(^TMP("IBCIL0",$J,IBCIST0,IBCIUSER,IBCIBNUM)) Q:IBCIBNUM=""  D
 ...S IBCIXX=^TMP("IBCIL0",$J,IBCIST0,IBCIUSER,IBCIBNUM)
 ...S IBCIARR=$$SETFLD^VALM1($P(IBCIXX,U,2),IBCIARR,"STATUS")
 ...S IBCIARR=$$SETFLD^VALM1($P(IBCIXX,U,3),IBCIARR,"USER")
 ...S IBCIARR=$$SETFLD^VALM1($P(IBCIXX,U,4),IBCIARR,"BNUM")
 ...S IBCIARR=$$SETFLD^VALM1($P(IBCIXX,U,5),IBCIARR,"PT_NAME")
 ...S IBCIARR=$$SETFLD^VALM1($P(IBCIXX,U,6),IBCIARR,"EVENT_DATE")
 ...S CT=CT+1
 ...S ^TMP("IBCIL1",$J,CT)=$P(IBCIXX,U)_U_$P(^IBA(351.9,$P(IBCIXX,U),0),U,2)_U_IBCIST0
 ...S IBCIARR=$$SETFLD^VALM1(CT,IBCIARR,"ITEM") D SET^VALM10(CT,IBCIARR)
 S VALMCNT=CT
 I VALMCNT=0 S VALMSG="No Skipped Claims to Send to ClaimsManager."
 D EXIT
 Q
 ;
SELB ; select single bill, bill by status, or multiple range of bills
 ;
 NEW IBCIENAR,IBCINUMS,IBCIPIEC,IBCIYSUB,IBCIX
 S VALMBCK="R"
 I CT=0 D NOBILS,INIT G SELBX
 D FULL^VALM1
 S DIR(0)="LO^1:"_CT
 S DIR("A",1)="You may select one or more claims, or a range."
 S DIR("A")="Selection"
 S DIR("?",1)="  You may choose a single bill, a list of bills (i.e. 2,5,9,12), a range"
 S DIR("?",2)="  of bills (i.e. 3-8), or any combination of these (i.e. 1,3,5,8-12).  Only"
 S DIR("?")="  the bills you select here will be sent to ClaimsManager."
 D ^DIR K DIR
 I $D(DIRUT) G SELBX
 D YESBLS
 M IBCIENAR=Y KILL X,Y
 S IBCIYSUB=""
 F  S IBCIYSUB=$O(IBCIENAR(IBCIYSUB)) Q:IBCIYSUB=""  D
 . S IBCINUMS=IBCIENAR(IBCIYSUB)
 . S IBCINUMS=$E(IBCINUMS,1,$L(IBCINUMS)-1)
 . F IBCIPIEC=1:1:$L(IBCINUMS,",") S IBCIX=$P(IBCINUMS,",",IBCIPIEC) D N1
 . Q
 D SENDMAIL,INIT
SELBX ;
 Q
 ;
N1 ; check for valid number and send the claim
 NEW IBCIST1,IBIFN,IBCIMCSB,IBCIMCSL
 NEW ATP,BILLNO,CHARGES,DFN,DPTDATA,EVENTDT,IBDATA,PATNAME,RESP,RESPNM
 NEW SSN,TMPDATA
 NEW IBCIENAR,IBCINUMS,IBCIPIEC,IBCIYSUB
 ;
 I 'IBCIX Q
 I '$D(^TMP("IBCIL1",$J,IBCIX)) Q
 S IBIFN=$P(^TMP("IBCIL1",$J,IBCIX),U,1)
 S IBCIST1=$P(^TMP("IBCIL1",$J,IBCIX),U,3) D STATUS
 ;
 S IBCIMCSB=+$$BILLER^IBCIUT5(IBIFN)          ; current biller
 S IBCIMCSL=+$P($G(^IBA(351.9,IBIFN,0)),U,5)  ; last sent to CM by
 ;
 D ST2^IBCIST          ; send a single bill to CM
 W "."
 ;
 ; esg - 10/4/01 - If the bill is still editable and it came back
 ;       clean from CM, then build a scratch global so we can send
 ;       a MailMan message to some people about this.
 ;
 I IBCISNT=2,IBCISTAT=3 D
 . S (RESP,ATP)=+$P($G(^IBA(351.9,IBIFN,0)),U,12)
 . I 'RESP S RESP=IBCIMCSB
 . I 'RESP S RESP=DUZ
 . S RESPNM=$P($G(^VA(200,RESP,0)),U,1)
 . I RESPNM="" S RESPNM="UNKNOWN"
 . S CHARGES=+$P($G(^DGCR(399,IBIFN,"U1")),U,1)
 . S IBDATA=$G(^DGCR(399,IBIFN,0))
 . S BILLNO=$P(IBDATA,U,1)
 . S DFN=+$P(IBDATA,U,2)
 . S DPTDATA=$G(^DPT(DFN,0))
 . S SSN=$E($P(DPTDATA,U,9),6,9)
 . S PATNAME=$P(DPTDATA,U,1)
 . S EVENTDT=$P($P(IBDATA,U,3),".",1)
 . S TMPDATA=BILLNO_U_PATNAME_U_SSN_U_EVENTDT
 . S ^TMP("IBCIL2",$J,RESPNM,-CHARGES,IBIFN)=TMPDATA
 . ;
 . ; these people should get the MailMan message
 . I ATP S ^TMP("IBCIL2",$J,RESPNM,-CHARGES,IBIFN,ATP)=""
 . I IBCIMCSB S ^TMP("IBCIL2",$J,RESPNM,-CHARGES,IBIFN,IBCIMCSB)=""
 . I IBCIMCSL S ^TMP("IBCIL2",$J,RESPNM,-CHARGES,IBIFN,IBCIMCSL)=""
 . S ^TMP("IBCIL2",$J)=$G(^TMP("IBCIL2",$J))+1
 . Q
 Q
 ;
STATUS ;set ibcisnt based on criteria
 K IBCISNT
 I $$STAT^IBCIUT1(IBIFN)=10 S IBCISNT=4 Q
 I $$STAT^IBCIUT1(IBIFN)=11 S IBCISNT=5 Q
 S IBCISNT=$S("^1^"[IBCIST1:2,1:6)
 Q
 ;
ALL ;send all claims
 NEW IBCIX
 S VALMBCK="R"
 I CT=0 D NOBILS,INIT Q
 I CT>0 D YESBLS
 S IBCIX=0 F  S IBCIX=$O(^TMP("IBCIL1",$J,IBCIX)) Q:'IBCIX  D N1
 D SENDMAIL,INIT
 Q
SNA ;send all non authorized claims
 NEW IBCIX
 S VALMBCK="R"
 I CT=0 D NOBILS,INIT Q
 I CT>0 D YESBLS
 S IBCIX=0 F  S IBCIX=$O(^TMP("IBCIL1",$J,IBCIX)) Q:'IBCIX  D
 . I $P(^TMP("IBCIL1",$J,IBCIX),U,3)<3 D N1
 . Q
 D SENDMAIL,INIT
 Q
 ;
SENDMAIL ;
 ; This procedure is responsible for sending a MailMan message to
 ; users about the claims that had no ClaimsManager errors.  The 
 ; message will list all clean claims and will be sent to the billers,
 ; assigned to people, current user, and the user who most recently
 ; sent the bill to CM.
 ;
 NEW CHG,IBIFN,L1,TEXT,TMPDATA,USER,XMDUZ,XMSUB,XMTEXT,XMY,XMDUN,XMZ
 NEW X,Y,X1,X2,X3,X4
 I '$D(^TMP("IBCIL2",$J)) G SENDX
 S L1=1
 S TEXT(L1)="The following bills were sent to ClaimsManager from the Multiple Claim Send",L1=L1+1
 S TEXT(L1)="option.  ClaimsManager did not find any errors with them.  These bills have",L1=L1+1
 S TEXT(L1)="passed both the IB edit checks and the ClaimsManager edit checks.  They are",L1=L1+1
 S TEXT(L1)="ready to be authorized.  Please review the bills for which you are responsible",L1=L1+1
 S TEXT(L1)="(if any) and take the appropriate action.",L1=L1+1
 S TEXT(L1)=" ",L1=L1+1
 S TEXT(L1)=$J("EVENT",43),L1=L1+1
 S TEXT(L1)="  BILL#     PATIENT NAME      PID     DATE         CHARGES    USER NAME",L1=L1+1
 S TEXT(L1)=" -------  ------------------  ----  ----------  ----------  ------------------",L1=L1+1
 ;
 S USER=""
 F  S USER=$O(^TMP("IBCIL2",$J,USER)) Q:USER=""  S CHG="" F  S CHG=$O(^TMP("IBCIL2",$J,USER,CHG)) Q:CHG=""  S IBIFN=0 F  S IBIFN=$O(^TMP("IBCIL2",$J,USER,CHG,IBIFN)) Q:'IBIFN  D
 . M XMY=^TMP("IBCIL2",$J,USER,CHG,IBIFN)
 . S TMPDATA=XMY,XMY=""
 . S TEXT(L1)=" "
 . S X=$P(TMPDATA,U,1),X1=7,X2="L" S TEXT(L1)=TEXT(L1)_$$FILL^IBCIUT2
 . S TEXT(L1)=TEXT(L1)_"  "
 . S X=$P(TMPDATA,U,2),X1=18,X2="L" S TEXT(L1)=TEXT(L1)_$$FILL^IBCIUT2
 . S X=$P(TMPDATA,U,3),X1=6,X2="R" S TEXT(L1)=TEXT(L1)_$$FILL^IBCIUT2
 . S X=$$FMTE^XLFDT($P(TMPDATA,U,4),"5Z"),X1=12,X2="R"
 . S TEXT(L1)=TEXT(L1)_$$FILL^IBCIUT2
 . S X="$"_$FN(-CHG,",",2),X1=12,X2="R"
 . S TEXT(L1)=TEXT(L1)_$$FILL^IBCIUT2
 . S TEXT(L1)=TEXT(L1)_"  "
 . S X=USER,X1=18,X2="L" S TEXT(L1)=TEXT(L1)_$$FILL^IBCIUT2
 . S L1=L1+1
 . Q
 S TEXT(L1)=" ",L1=L1+1
 S TEXT(L1)=" ",L1=L1+1
 ;
 S XMTEXT="TEXT("
 S XMDUZ=DUZ
 S XMSUB="ClaimsManager Clean Claims"
 S XMY(DUZ)=""
 D ^XMD
SENDX ;
 Q
 ;
NOBILS ;msg for no bills
 D FULL^VALM1
 W !!,"There are no claims to send ...",!
 S DIR(0)="E" D ^DIR K DIR
 Q
YESBLS ;msg for sending bills
 W !!,"Sending claims ... please wait.",!
 Q
HELP ; -- help code
 S X="?"
 D FULL^VALM1
 D EN^DDIOL("   'Send All Bills to ClaimsManager' will send all claims listed","","!!")
 D EN^DDIOL("     to ClaimsManager for processing.")
 D EN^DDIOL("   'Send All Non Auth Bills to ClaimsManager' will send only","","!!")
 D EN^DDIOL("     Non-Authorized claims to ClaimsManager for processing.")
 D EN^DDIOL("   'Select Bills to send to ClaimsManager' allows individual and","","!!")
 D EN^DDIOL("     multiple selection of claims before sending")
 D EN^DDIOL("     claims to ClaimsManager for processing.")
 D PAUSE^VALM1
 S VALMBCK="R"
 Q
 ;
EXIT ; -- exit code
 D CLEAR^VALM1
 Q
