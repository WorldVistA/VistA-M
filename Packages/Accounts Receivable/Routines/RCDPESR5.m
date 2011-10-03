RCDPESR5 ;ALB/TMK - Server interface 835XFR processing ;10/01/02
 ;;4.5;Accounts Receivable;**173,208**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
XFR(RCTDA,RCFROM,RCMSG,RCD) ; Send bulletin, update 344.5 for transfer EOB into site
 ; RCTDA = ien in file 344.5 being updated
 ; RCFROM = the sender's mail address from the mail message
 ; RCMSG = message # the data was received in
 ; RCD = array containing formatted header data
 ;
 N RCCT,RCDXM,DA,DR,DIE,X,Y,Z,RCFROMNM
 S Z=$P($P(RCD("SUBJ"),"REF #",2),"#"),RCFROMNM=$TR($P(RCFROM,"@",2),">")
 I RCFROMNM="" S RCFROMNM=RCFROM
 S DA=RCTDA,DR=".05///@;.08////1;.1///3"_$S($P(RCFROM,"@",2)'="":";.12////"_RCFROMNM,1:"")_";.13////^S X=("_+Z_"_$C(59)_"_$P(Z,";",2)_")"_$S($G(RCD("PAYFROM"))'="":";3.01////"_RCD("PAYFROM"),1:"")
 S DIE="^RCY(344.5," D ^DIE
 ;
 D SENDACK(RCTDA,"") ; acknowledge receipt of transferred EOB
 ;
 S RCDXM(1)="An EEOB transmission has been received by the EDI Lockbox",RCDXM(2)="  system that was sent to you from another VistA site.  Please review"
 S RCDXM(3)="  it in EEOB exception processing and file the EEOB if it belongs to your",RCDXM(4)="  site or delete the message to return the EEOB to the site it was sent from."
 S RCDXM(5)=" ",RCDXM(6)="The message was sent by "_RCFROM
 S RCDXM(7)="The mail message number is "_RCMSG
 S RCDXM(8)=" ",RCDXM(9)="EEOB DATA INCLUDED:"
 S RCCT=9
 K ^TMP($J)
 D DISP^RCDPESR0("^RCY(344.5,"_RCTDA_",2)","^TMP($J,""PRCA_EXT"")",1,"^TMP($J,""PRCA_LINES"")",70)
 S Z=0 F  S Z=$O(^TMP($J,"PRCA_LINES",Z)) Q:'Z  S RCCT=RCCT+1,RCDXM(RCCT)=$J("",3)_$G(^TMP($J,"PRCA_LINES",Z))
 D BULLERA^RCDPESR0("",RCTDA,RCMSG,"EDI LBOX EEOB FROM "_$E(RCFROMNM,1,18)_" FOR "_$E($G(RCD("PAYFROM")),1,20),.RCDXM,1)
 K ^TMP($J)
 Q
 ;
SENDACK(RCTDA,RCSTAT) ; Send accept/reject msg to transf 'from' site
 ; RCTDA = ien of entry file 344.5
 ; RCSTAT = flag to indicate what happened
 ;   values:  "" = receipt   1 = accepted   0 = rejected
 ;
 N RC,RC0,RCDOM,RCREF,XMTO,XMBODY,XMZ
 ; Send a mail message to sending site for accept/reject of EOB
 S RC0=$G(^RCY(344.5,RCTDA,0)),RCREF=$P(RC0,U,13)
 S RCDOM="@"_$S($P(RC0,U,12)'="":$P(RC0,U,12),1:$$KSP^XUPARAM("WHERE")) S:RCDOM="@" RCDOM=""
 I RCREF,$P(RCREF,";",2) D
 . ; 835ACK^accept/reject flag (""/0/1)^ien file 344_;_ien file 344.41
 . S RC(1)="835XAK^"_RCSTAT_U_+$P(RCREF,";")_";"_+$P(RCREF,";",2)
 . S XMBODY="RC",XMTO("S.RCDPE EDI LOCKBOX SERVER"_RCDOM)=""
 . D
 .. N DUZ S DUZ=.5,DUZ(0)="@"
 .. D SENDMSG^XMXAPI(.5,"TRANSFER EEOB ACKNOWLEDGEMENT",XMBODY,.XMTO,,.XMZ)
 Q
 ;
FILEEOB(RCTDA) ; Files trans-in EOB in IB
 N DIE,DA,DR,X,Y,RCE
 D UPDEOB^RCDPESR2(RCTDA,5)
 I $D(^RCY(344.5,RCTDA,0)) D
 . S DIE="^RCY(344.5,",DR=".04////0;.05///@;.1////5",DA=RCTDA D ^DIE
 Q
 ;
BULL1(RCTDA,RCERR,DUP) ; Send bulletin for EDI Lockbox EOB exceptions
 ; RCTDA = ien of entry in file 344.5
 ; RCERR = the name of the error global
 ; DUP = ien of existing entry in file 344.4 if ERA is duplicate
 ;
 N RCSUBJ
 S RCSUBJ="EDI LBOX "_$S(DUP:"ERA - DUPLICATE TRANSMISSION MSG #"_DUP,1:" EEOB - EXCEPTIONS")_" "_$E($P($G(^RCY(344.5,RCTDA,3)),U),1,20)
 S RCSUBJ=$E(RCSUBJ,1,65)
 S DUP=+$G(DUP)
 D BULLERA^RCDPESR0("D",RCTDA,$P($G(^RCY(344.5,RCTDA,0)),U,11),RCSUBJ,RCERR,0)
 Q
 ;
BULL2(RCTDA,RCERR,RCXMG) ; Send bulletin for EOB transfer received at site
 ; RCTDA = ien of entry in file 344.5
 ; RCXMG = incoming message #
 ; RCERR = the name of the error global
 ;
 N RCDIQ,RCXM,RCXM1,XMBODY,XMZ,XMTO,RC,Z,Q,RCSUBJ
 S RCSUBJ="EDI LBOX EEOB DETAIL RE-FILE ATTEMPTED TO IB"
 S XMTO("I:G.RCDPE PAYMENTS")="",RC=0
 K ^TMP("RCERR_BULL2",$J)
 S RC=RC+1,^TMP("RCERR_BULL2",$J,RC)="The following EEOB was received at your site.",RC=RC+1,^TMP("RCERR_BULL2",$J,RC)="It was received on: "_$$FMTE^XLFDT($$NOW^XLFDT(),2)_" in mail msg # "_RCXMG_"."
 S RC=RC+1,^TMP("RCERR_BULL2",$J,RC)="The initial attempt to file this data in IB failed and this message",RC=RC+1,^TMP("RCERR_BULL2",$J,RC)="is the result of a subsequent attempt to file this EEOB detail data in IB"
 S RC=RC+1,^TMP("RCERR_BULL2",$J,RC)=" "
 D GETS^DIQ(344.4,+RCTDA_",","*","IEN","RCDIQ")
 D TXT0^RCDPEX31(+RCTDA,.RCDIQ,.RCXM,0)
 S Z=0 F  S Z=$O(RCXM(Z)) Q:'Z  S RC=RC+1,^TMP("RCERR_BULL2",$J,RC)=RCXM(Z)
 I $G(RCERR)'="",$E(RCERR,1,5)'="^TMP(" S RC=RC+1,^TMP("RCERR_BULL2",$J,RC)=RCERR,RC=RC+1,^TMP("RCERR_BULL2",$J,RC)=" "
 S RCERR=$S($E(RCERR,1,5)="^TMP(":RCERR,1:"RCERR")
 I $O(@RCERR@(""))'="" D
 . S Z="" F  S Z=$O(@RCERR@(Z)) Q:Z=""  D
 .. I $G(@RCERR@(Z))'="" S RC=RC+1,^TMP("RCERR_BULL2",$J,RC)=@RCERR@(Z)
 .. I $O(@RCERR@(Z,0)) S Q="" F  S Q=$O(@RCERR@(Z,Q)) Q:Q=""  S RC=RC+1,^TMP("RCERR_BULL2",$J,RC)=@RCERR@(Z,Q)
 S XMBODY="^TMP(""RCERR_BULL2"","_$J_")"
 D
 . N DUZ S DUZ=.5,DUZ(0)="@"
 . D SENDMSG^XMXAPI(.5,$E(RCSUBJ,1,65),XMBODY,.XMTO,,.XMZ)
 K ^TMP("RCERR_BULL2",$J)
 Q
 ;
DISP1(RCCT,RCNOH) ; Extract formatted EOB detail for bill
 ; RCCT = bill seq# within ERA transmission
 ; RCNOH = 1 if no header text needed on 05 rec
 ;
 ; Error array returned in ^TMP("RCERR1",$J)
 ;
 N RC1,RC2,RCCT1,Z
 D DISP^RCDPESR0("^TMP($J,""RCDP-EOB"","_RCCT_")","RC1",1)
 D FMTDSP^RCDPESR0("RC1","RC2",75,RCNOH)
 S Z=0,RCCT1=$O(^TMP("RCERR1",$J,RCCT," "),-1)
 F  S Z=$O(RC2(Z)) Q:'Z  S RCCT1=RCCT1+1,^TMP("RCERR1",$J,RCCT,RCCT1)=RC2(Z)
 Q
 ;
