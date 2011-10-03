RCDPESRV ;ALB/TMK - Server interface to AR from Austin ;06/03/02
 ;;4.5;Accounts Receivable;**173**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
SERVER ; Entry point for server option to process EDI Lockbox msgs received
 ; from Austin and redirected EOB transactions received from another
 ; VistA site
 ;
 N RCEFLG,RCERR,XMER,RCXMZ,RCTYPE
 K ^TMP("RCERR",$J),^TMP("RCMSG",$J),^TMP("RCMSGH",$J),^TMP($J)
 S RCXMZ=$G(XMZ)
 S RCEFLG=$$MSG(RCXMZ,.RCERR)
 D:$G(RCEFLG) PERROR^RCDPESR1(.RCERR,"G.RCDPE PAYMENTS EXCEPTIONS",RCXMZ)
 D DKILL^RCDPESR1(RCXMZ) S ZTREQ="@"
 K ^TMP("RCERR",$J),^TMP("RCMSG",$J),^TMP("RCMSGH",$J),^TMP($J)
 Q
 ;
MSG(RCXMZ,RCERR) ; Read/Store message lines
 ; RCERR = array of errors
 ; RCXMZ = the # of the Mailman message contianing this message
 ; 
 ; OUTPUT:
 ;  Function returns flag ... 0 = no errors    1 = errors
 ;     and the standard Mailman error variable contents of XMER
 ;
 N RCTYP1,RCDATE,RCHD,RCTXN,XMDUZ,RCGBL,RCD,RCEFLG,RCCT,RCDXM,X,Y
 K ^TMP("RCERR",$J),^TMP("RCMSG",$J),^TMP("RCMSGH",$J)
 ;
 S (RCEFLG,RCERR,RCTXN)="",RCGBL="RCTXN"
 ; Set up formatted mailman header data in RCD
 S RCD("MSG#")=RCXMZ\1
 S RCHD=$$NET^XMRENT(RCXMZ)
 S RCD("FROM")=$P(RCHD,U,3)
 S RCD("SUBJ")=$P(RCHD,U,6)
 S (X,RCDATE)=$P(RCHD,U)
 I X'="" D  ;Reformat date, if needed
 . N %DT
 . I X'["@" S X=$P(X," ",1,3)_"@"_$P(X," ",4)
 . S %DT="XTS" D ^%DT S:Y>0 RCDATE=Y\.0001*.0001
 ;
 S RCD("DATE")=RCDATE
 ; Read up to the header line of message
 S RCCT=1
 F  X XMREC Q:$S(XMER<0:1,1:$E(XMRG,1,3)="835"&($E(XMRG,4,6)="ERA"!($E(XMRG,4,6)="EFT")!($E(XMRG,4,6)="XFR")!($E(XMRG,4,6)="XAK")))  S RCCT=RCCT+1,^TMP("RCERR",$J,"MSG",RCCT)=XMRG
 I XMER<0 D  G MSGQ
 . S (RCEFLG,RCERR)=1
 . S ^TMP("RCERR",$J,"MSG",.5)=RCHD
 . S ^TMP("RCERR",$J,"DATE")=RCDATE
 ;
 K ^TMP("RCERR",$J,"MSG")
 S RCTXN=XMRG,RCD("PAYFROM")=$P(RCTXN,U,6)
 S RCTYP1=$P(RCTXN,U)
 ;
 I RCTYP1["835XAK" D  G MSGQ ; Accept/reject of transferred EOB
 . N DA,DR,DIE,RCACC,RC0,RC00,XMZ,XMTO,XMBODY,RCXM,X,Y
 . S RCACC=$P(RCTXN,U,2)
 . S DR=$S(RCACC'="":".1////"_RCACC_";.13////"_RCACC,1:".16////1")
 . S DA(1)=+$P(RCTXN,U,3),DA=$P($P(RCTXN,U,3),";",2)
 . S RC0=$G(^RCY(344.4,DA(1),0))
 . S RC00=$G(^RCY(344.4,DA(1),1,DA,0))
 . I $P(RC00,U,10)'="" Q  ; Already updated
 . S DIE="^RCY(344.4,"_DA(1)_",1,"
 . I DA(1),DA,RC00'="" D ^DIE
 . S RCXM(1)="An EEOB record for bill "_$P(RC00,U,5)_" was transferred to",RCXM(2)=$P($G(^DIC(4,+$P(RC00,U,11),0)),U)_" on "_$$FMTE^XLFDT($P(RC00,U,12),2)
 . S RCXM(3)=" ",RCXM(4)=" ERA TRACE #: "_$P(RC0,U,2)_"  SEQ #:"_+RC00
 . S RCXM(5)=" ",RCXM(6)=" ",RCXM(7)="    This message is to inform you this transfer was **** "_$S(RCACC="":"RECEIVED",1:$P("REJECTED^ACCEPTED",U,RCACC+1))_" ****"
 . S RCXM(8)=" ",RCXM(9)=" "
 . I RCACC S RCXM(10)=" You must make the appropriate funds transfers manually"
 . I 'RCACC S RCXM(10)=$S(RCACC="":" Contact this site if the EEOB is not ACCEPTED or REJECTED in a timely manner",1:" Try another site or contact your IMPLEMENTATION MANAGER to reconcile this")
 . S XMBODY="RCXM"
 . S XMTO("I:G.RCDPE PAYMENTS"_$S(RCACC:" MGMNT",1:""))=""
 . D
 .. N DUZ S DUZ=.5,DUZ(0)="@"
 .. D SENDMSG^XMXAPI(.5,"EDI LBOX TRANSFERRED EEOB "_$S(RCACC="":"RECEIVED",RCACC:"ACCEPTED",1:"REJECTED"),XMBODY,.XMTO,,.XMZ)
 . ;
 ;
 I RCTYP1["835",$E(RCTYP1,1,4)'="835X",RCD("FROM")'["POSTMASTER@FOC-AUSTIN.VA.GOV" D  G MSGQ
 . ;Send bulletin warning for non-Austin ERA/EFT message received
 . S RCDXM(1)="An electronic transmission ("_$E($P(RCTXN,U),4,6)_") has been received by the EDI Lockbox",RCDXM(2)="  system that did not originate from the Austin system.  This message"
 . S RCDXM(3)="  WILL NOT be stored on your system and may be a breach of security.",RCDXM(4)=" "
 . S RCDXM(5)="  Please contact your IRM with the following information:",RCDXM(6)=" ",RCDXM(7)="The message was sent from "_RCD("FROM")
 . S RCDXM(8)="The mail message number is "_RCXMZ
 . S RCDXM(9)="The text received in the message is:",RCDXM(10)=" "
 . S RCDXM(11)=RCTXN
 . D RESTMSG^RCDPESR1(+$O(RCDXM(""),-1),"RCDXM",RCXMZ)
 . D BULLERA^RCDPESR0("","",RCXMZ,"EDI LBOX - ERA/EFT NOT FROM AUSTIN "_$G(RCD("PAYFROM")),.RCDXM,0)
 ;
 S RCGBL="^TMP(""RCMSG"","_$J_")"
 S @RCGBL=RCTYP1,^TMP("RCMSGH",$J,0)=RCTXN
 ;
 I RCTYP1["835ERA"!(RCTYP1["835XFR") D ERAEOBIN^RCDPESR4(RCTXN,.RCD,RCGBL,.RCEFLG)
 ;
 I RCTYP1["835EFT" D EFTIN^RCDPESR3(RCTXN,.RCD,XMZ,RCGBL,.RCEFLG)
 ;
MSGQ Q RCEFLG
 ;
