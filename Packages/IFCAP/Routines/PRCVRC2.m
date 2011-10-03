PRCVRC2 ;WOIFO/BMM/VAC - silently build RIL for DynaMed ; 12/3/07 10:32am
V ;;5.1;IFCAP;**81,119**;Oct 20, 2000;Build 8
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;12/07 Code modified to fix error in GETTXN due to logic error.
 ;  Added KILL statements to eliminate finding random ^TMP global data
 ;  from other routines and to clean up ^DIC calls.
 ;
 ;validation, error code for PRCVRC1
 ;
 Q
 ;
GETFY(PRCVDT) ;return the fiscal year, PRCVDT is date/time the DM
 ;message was created (thus the date/time for RIL)
 ;
 Q $E(100+$E(PRCVDT,2,3)+$E(PRCVDT,4),2,3)
 ;
GETQTR(PRCVDT) ;return the fiscal quarter, PRCVDT is date/time the DM
 ;message was created (thus the date/time for RIL)
 ;
 N QTR S QTR=+$E(PRCVDT,4,5)
 Q $P("2^2^2^3^3^3^4^4^4^1^1^1","^",+QTR)
 ;
GETTXN(PRCVSTR) ;obtain current transaction number (if exists) from
 ;Transaction Number file (#410.1)
 ;increment transaction for current use, update 410.1 entry
 ;return new transaction number for this RIL
 ;PRCVSTR is Entry Number, comes in as "station-fy-qtr-fcp-cc"
 ;TXN is transaction #, PRCVRN is IEN for 410.1 entry
 ;NOTE: CHECK 410 too, look in EN1^PRCSUT3, lines 8-10 etc.
 ;
 Q:$G(PRCVSTR)="" 0
 N TXN,PRCVE,PRCVRN S TXN="",(PRCVRN,PRCVE)=0
 ;check if Entry Number def in 410.1
 K ATXN,^TMP("DIERR",$J),^TMP("DILIST",$J)
 D FIND^DIC(410.1,,"1","BX",PRCVSTR,,,,,"ATXN")
 ;
 S TXN=+$G(ATXN("DILIST","ID",1,1))
 S PRCVRN=$G(ATXN("DILIST",2,1))
 I TXN<1 D  Q:PRCVE=1 0
 . ;TXN=0 so Entry Number not def, create new
 . K PRCVAT S PRCVAT(410.1,"+1,",.01)=PRCVSTR
 . S PRCVAT(410.1,"+1,",2)=DT
 . S PRCVAT(410.1,"+1,",1)=1
 . K ^TMP("DIERR",$J),^TMP("DILIST",$J)
 . D UPDATE^DIE("","PRCVAT","PRCVRN")
 . ;don't send msg here
 . ;I $D(^TMP("DIERR",$J)) D SENDMSG(7,PRCVGL,0,1) S PRCVE=1 Q
 . I $D(^TMP("DIERR",$J))>0 K ^TMP("DIERR",$J),^TMP("DILIST",$J) S PRCVE=1 Q
 . S PRCVRN=PRCVRN(1)
 S TXN=TXN+1
 K PRCVSA S PRCVSA(410.1,PRCVRN_",",1)=TXN
 K ^TMP("DIERR",$J),^TMP("DILIST",$J)
 D FILE^DIE("","PRCVSA")
 ;don't send msg here
 ;I $D(^TMP("DILIST",$J)) D SENDMSG(7,PRCVGL,0,1) Q 0
 I $D(^TMP("DIERR",$J))>0 K ^TMP("DIERR",$J),^TMP("DILIST",$J) Q 0
 K ^TMP("DIERR",$J),^TMP("DILIST",$J)
 S TXN="000"_TXN,TXN=$E(TXN,$L(TXN)-3,$L(TXN))
 Q TXN
 ;
CHKDT(INDT) ;check the incoming date (date/time message created) against
 ;the present date.  date/time message created must be today or in
 ;the past.  if INDT is today or before today then return 1, else 
 ;return 0
 ;both dates are in Fileman format ex. 3050503.12446
 ;
 Q:$G(INDT)="" 0
 N %,PRESENT,PRCVDIFF
 D NOW^%DTC S PRESENT=%
 S PRCVDIFF=$$FMDIFF^XLFDT(PRESENT,INDT,1)
 I PRCVDIFF'<0 Q 1
 Q 0
 ;
CHKDTN(INDT) ;check the incoming date (Date Needed By from DynaMed)
 ;against the present date.  Date Needed By must be today or in the
 ;future.  if INDT is today or after today then return 1, else return 0
 ;both dates are in FileMan format ex. 3050503.12446
 ;
 Q:$G(INDT)="" 0
 N %,PRESENT,PRCVDIFF
 D NOW^%DTC S PRESENT=%
 S PRCVDIFF=$$FMDIFF^XLFDT(PRESENT,INDT,1)
 I PRCVDIFF'>0 Q 1
 Q 0
 ;
CHKBOC(ITEM,BOC) ;test BOC from passed-in detail record
 ;
 Q:$G(ITEM)="" 0
 N PRCVIBOC
 S PRCVIBOC=$$GET1^DIQ(441,ITEM_",",12,"I")
 I PRCVIBOC'=BOC Q 0
 Q 1
 ;
CHKFCP(PRCVFCP,PRCVST) ;validate that FCP is in 420
 ;
 Q:$G(PRCVFCP)=""!($G(PRCVST)="") 0
 N PRCVE,PRCVN,PRCVVAL
 S PRCVVAL=1,PRCVN=0
 S PRCVN=$$FIND1^DIC(420.01,","_PRCVST_",","",PRCVFCP_" ","B","","PRCVE")
 I +PRCVN'>0 S PRCVVAL=0
 Q PRCVVAL
 ;
CHKITM(PRCVITM) ;check extracted item number:
 ;1. must be greater than 100000
 ;2. must be defined in Item Master (#441) file
 ;3. must not be inactive (441 field 16 '=1)
 ;
 Q:$G(PRCVITM)="" 0
 N CITM S CITM=0
 ;N NITM
 ;S NITM=$$FIND1^DIC(441,"","X",PRCVITM,"","","ATXN")
 ;I '$D(ATXN) Q 1
 I PRCVITM'<100000,$D(^PRC(441,"B",PRCVITM)) D
 . I +$$GET1^DIQ(441,PRCVITM_",",16,"I")=0 S CITM=1
 Q CITM
 ;
CHKVEND(VENDN) ;check that vendor in Vendor file is active.
 ;VENDN is Vendor number
 ;
 Q:+VENDN=0 0
 N NVNDP,CHKFLG
 S CHKFLG=0
 I $D(^PRC(440,VENDN,0)),$$GET1^DIQ(440,VENDN_",",32,"I")="" S CHKFLG=1
 Q CHKFLG
 ;
CHKVI(VENDN,ITMN) ;check that vendor VENDN sells item ITMN
 ;can't use $$FIND1^DIC since could be >1 cross-ref and >1 node
 ;
 N ITMNN,VENDP,CHKFLG
 S (VENDP,ITMNN,CHKFLG)=0
 Q:+VENDN=0!(+ITMN=0) CHKFLG
 ;get item ien, quit if undef
 S ITMNN=$O(^PRC(441,"B",ITMN,0))
 Q:ITMNN="" CHKFLG
 ;get pointer to vendor ien
 S VENDP=$O(^PRC(441,ITMNN,2,"B",VENDN,0))
 ;check that vendor is defined
 I VENDP>0,$D(^PRC(440,VENDP,0)) S CHKFLG=1
 ;if item file defined and vendor for item defined, good
 Q CHKFLG
 ;
CHKDUZ(INDUZ) ;validate that DUZ against New Person (#200)
 ;
 N DUZFLG S DUZFLG=0
 Q:$G(INDUZ)="" DUZFLG
 I $D(^VA(200,INDUZ,0)) S DUZFLG=1
 Q DUZFLG
 ;
CHKNIF(ITEM,NIF) ;use the passed-in item to check that the passed-in
 ;NIF# is correct.  return 1 if valid, 0 if not valid
 ;
 N PRCVINIF
 S PRCVINIF=$$GET1^DIQ(441,ITEM_",",51)
 I PRCVINIF=NIF Q 1
 Q 0
 ;
MAKECAP(INSTR) ;take INSTR and return an all-caps version of it
 ;
 Q:$G(INSTR)="" ""
 N X,Y
 S X=INSTR X ^%ZOSF("UPPERCASE")
 Q Y
 ;
SENDMSG(EC,PRCVGL,CTR,ERPC) ;send an alert or error message back to
 ;DynaMed via VIE by posting "ERR" node to appropriate ^XTMP node
 ;
 ;the error text is currently stored in the routine PRCVRC3
 ;
 ;EC is the error code
 ;use EC to get the description and severity
 ;the message is built in ECSTR and the "ERR" node in ^XTMP is 
 ;  created using passed-in message id in MID.  the error message 
 ;  is appended to "ERR" and is separated by other error messages 
 ;  already there with a carat ("^")
 ;PRCVGL is the ^XTMP subscript and CTR is the detail counter #
 ;ERPC is the data piece in the line item node or header node to 
 ;  which the error pertains
 ;
 N X S X="PRCVRC3"
 X ^%ZOSF("TEST") I '$T Q
 N ECSTR,OVERSTR,ERRCTR
 S ERPC=$G(ERPC)
 S ECSTR=ERPC_"^"_$P($T(ET+EC^PRCVRC3),";;",2),CTR=+CTR
 I CTR'=0 D
 . S ERRCTR=+$O(^XTMP(PRCVGL,2,CTR,"ERR",""),-1)
 . S ERRCTR=ERRCTR+1,^XTMP(PRCVGL,2,CTR,"ERR",ERRCTR)=ECSTR
 I CTR=0 D
 . S ERRCTR=+$O(^XTMP(PRCVGL,1,"ERR",""),-1)
 . S ERRCTR=ERRCTR+1,^XTMP(PRCVGL,1,"ERR",ERRCTR)=ECSTR
 Q
 ;
ADDAUD(ADDSTR) ;add "^"-pieces from ADDSTR as fields to a new record in
 ;the Audit file #410.02
 ;
 ;ADDSTR pieces: DynaMed Doc ID ^ Item # ^ Vendor ^ User DUZ ^
 ;  Last name,First name ^ RIL# ^ date/time RIL created ^
 ;  date/time message created (DynaMed requisition) ^ date needed
 ;
 Q:$G(ADDSTR)=""
 ;
 ;set up entry
 N PRCVA,PRCVI,PRCVP,PRCVRIL,PRCVTMP S PRCVA="",PRCVP=0
 F PRCVI=.01,1,2,3,13,4,5,6,12 S PRCVP=PRCVP+1 D
 . S PRCVA(414.02,"+1,",PRCVI)=$P(ADDSTR,U,PRCVP)
 ;add record to Audit File
 D UPDATE^DIE("","PRCVA")
 ;if error, send bulletin
 I $D(^TMP("DIERR",$J)) D  Q
 . S PRCVTMP="PRCVRC2",PRCVRIL=$P(ADDSTR,U,5)
 . S XMB(1)="creating an entry in the DynaMed Audit File (#414.02)"
 . S XMB(2)=$P(ADDSTR,U)
 . S XMB(3)="unable to create Audit File entry"
 . S ^TMP($J,"PRCVRC2",1,0)="",PRCVP=1
 . S ^TMP($J,"PRCVRC2",2,0)="DynaMed Doc ID: "_$P(ADDSTR,U)
 . S ^TMP($J,"PRCVRC2",3,0)="Item #: "_$P(ADDSTR,U,2)
 . S ^TMP($J,"PRCVRC2",4,0)="Vendor #: "_$P(ADDSTR,U,3)
 . S ^TMP($J,"PRCVRC2",5,0)="User DUZ: "_$P(ADDSTR,U,4)
 . S ^TMP($J,"PRCVRC2",6,0)="RIL #: "_$P(ADDSTR,U,5)
 . S ^TMP($J,"PRCVRC2",7,0)="Message date/time: "_$P(ADDSTR,U,6)
 . S ^TMP($J,"PRCVRC2",8,0)="RIL create date: "_PRCVRIL
 . S ^TMP($J,"PRCVRC2",9,0)="Date Needed: "_$P(ADDSTR,U,8)
 . S ^TMP($J,"PRCVRC2",10,0)="Error: "_$G(^TMP("DIERR",$J,1,"TEXT",1))
 . S PRCVST=$P(PRCVRIL,"-"),PRCVFCP=$P(PRCVRIL,"-",4)
 . D DMERXMB^PRCVLIC(PRCVTMP,PRCVST,PRCVFCP)
 Q
 ;
