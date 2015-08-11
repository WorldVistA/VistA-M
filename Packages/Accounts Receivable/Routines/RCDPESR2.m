RCDPESR2 ;ALB/TMK/DWA - Server auto-upd - EDI Lockbox ;Jun 06, 2014@19:11:19
 ;;4.5;Accounts Receivable;**173,216,208,230,252,264,269,271,298**;Mar 20, 1995;Build 121
 ;Per VA Directive 6402, this routine should not be modified.
 ; IA 4042 (IBCEOB)
 ;Reference to $$VALECME^BPSUTIL2 supported by IA# 6139
 ;
TASKERA(RCTDA) ; Task to upd ERA
 ; RCTDA = ien 344.5
 N ZTDTH,ZTUCI,ZTSAVE,ZTIO,ZTDESC,ZTRTN,ZTSK,DIE,DR,DA
 S (ZTSAVE("DT"),ZTSAVE("U"),ZTSAVE("DUZ"))="",ZTSAVE("ZTREQ")="@",ZTRTN="NEWERA^RCDPESR2("_RCTDA_",0)",ZTDTH=$H,ZTIO=""
 D ^%ZTLOAD
 Q
 ;
NEWERA(RCTDA,RCREFILE) ;Tasked
 ; Add new EOB's to IB & ERA tot rec to AR
 ; RCTDA = ien 344.5
 ; RCREFILE = 1: re-filing rec via exc proc
 N RCDUPERR,RCPAYER,RCRTOT,RCE,RCEC,RCERR,RCR1,RCADJ,DIE,DR,DA,Z,Q
 S ZTREQ="@"
 K ^TMP($J,"RCDPERA")
 L +^RCY(344.5,RCTDA):5
 I $D(ZTQUEUED) S DIE="^RCY(344.5,",DA=RCTDA,DR=".05////"_ZTSK_";.04////1" D ^DIE
 I $P($G(^RCY(344.5,RCTDA,0)),U,5),'$G(RCREFILE) S DIE="^RCY(344.5,",DA=RCTDA,DR=".1////4;.08///1" D ^DIE
 S RCR1=$P($G(^RCY(344.5,RCTDA,0)),U,7),RCPAYER=$P($G(^RCY(344.5,RCTDA,3)),U)
 S RCRTOT=$S(RCR1:RCR1,1:$$ERATOT^RCDPESR6(RCTDA,.RCERR)) ; ERA rec
 S RCDUPERR=$S($G(RCERR)="DUP"!($G(RCERR(1))=-2):$G(RCERR(1)),1:0) K RCERR(1)
 I RCRTOT,'RCR1 S DIE="^RCY(344.5,",DR=".07////"_RCRTOT,DA=RCTDA D ^DIE
 D:RCDUPERR'=-2 UPDEOB(RCTDA,5,$S('$G(RCREFILE):RCDUPERR,1:-1)) ; Add EOB det to IB
 I RCRTOT D UPDCON^RCDPESR6(RCRTOT),UPDADJ^RCDPESR6(RCRTOT),UPD3444^RCDPESR6(.RCRTOT) ; Bills added 344.41
 I RCRTOT,RCTDA S DIE="^RCY(344.5,",DR=".08////0;.1///@",DA=RCTDA D ^DIE
 I 'RCRTOT D  G QNEW
 .I RCDUPERR Q:'RCTDA  D  S RCTDA="" Q
 ..I RCDUPERR=-2 D BULLERA^RCDPESR0("D",RCTDA,$P($G(^RCY(344.5,RCTDA,0)),U,11),"EDI LBOX - DUPLICATE ERA NOT FILED "_$E(RCPAYER,1,20),.RCERR,0)
 ..D TEMPDEL^RCDPESR1(RCTDA)
 .S RCE(1)=$$FMTE^XLFDT($$NOW^XLFDT(),2)_" An error occurred while storing ERA data.",RCE(2)="No totals data was stored for this ERA record"_$S('$G(RCREFILE):" and an",1:" on this re-file attempt.")
 .S RCE(3)=$S('$G(RCREFILE):"ERA transmission exception was created.",1:"")
 .D WP^DIE(344.5,RCTDA_",",5,"A","RCE")
 .S DIE="^RCY(344.5,",DA=RCTDA,DR=".07///@;.08////1;.1////1" D ^DIE
 .K RCERR
 .S RCERR(1)=$$FMTE^XLFDT($$NOW^XLFDT(),2)_" The ERA data could not be stored. The AR receipt",RCERR(2)=" for this data must be created/processed manually for the bills included"
 .S RCERR(3)=" in this ERA."_$S('$G(RCREFILE):"",1:"  This error occurred during a refile attempt."),RCERR(4)=" "
 .D BULLERA^RCDPESR0("DF",RCTDA,$P($G(^RCY(344.5,RCTDA,0)),U,11),"EDI LBOX - TOTALS FILE EXCEPTION "_$E(RCPAYER,1,20),.RCERR,0)
 .K RCERR
 ;-----
 ; PRCA*4.5*298 - MailMan message disabled, logic retained - 14 Feb 2014
 ;I $$ADJ^RCDPEU(RCRTOT,.RCADJ) D  ;Bulletin adjs
 ;.S RCEC=$$ADJERR^RCDPESR3(.RCERR)
 ;.I RCADJ'=2 S RCEC=RCEC+1,RCERR(RCEC)=" THERE ARE ERA LEVEL ADJUSTMENT(S)",RCEC=RCEC+1,RCERR(RCEC)=" "
 ;.I RCADJ'=1 S RCEC=RCEC+1,RCERR(RCEC)=" THE FOLLOWING BILL(S) HAVE RETRACTIONS:" D
 ;..S (Q,Z)=0 S Z=0 F  S Z=$O(RCADJ(RCRTOT,Z)) Q:'Z  S:'Q RCEC=RCEC+1,RCERR(RCEC)="  " S Q=Q+1,RCERR(RCEC)=RCERR(RCEC)_"  "_RCADJ(RCRTOT,Z) S:Q=4 Q=0
 ;..S RCEC=RCEC+1,RCERR(RCEC)=" "
 ;.D BULLERA^RCDPESR0("D",RCTDA,$P($G(^RCY(344.5,RCTDA,0)),U,11),"EDI LBOX - ERA HAS ADJ/TAKEBACKS "_$E(RCPAYER,1,20),.RCERR,0)
 ;-----
 ;
QNEW I RCTDA,'$P($G(^RCY(344.5,RCTDA,0)),U,8) D TEMPDEL^RCDPESR1(RCTDA) S RCTDA=""
 I RCTDA,$P($G(^RCY(344.5,RCTDA,0)),U)'="" S DIE="^RCY(344.5,",DR=".04////0;.05///@"_$S('$G(RCR1)&$G(RCRTOT):";.07////"_RCRTOT,1:""),DA=RCTDA D ^DIE
 K ^TMP($J,"RCDPERA")
 I RCTDA L -^RCY(344.5,RCTDA)
 Q
 ;
UPDEOB(RCTDA,RCFILE,DUP) ;Upd 361.1 from ERA msg in 344.5 or .4
 ;RCTDA = ien ERA msg in 344.5 or ;subfile in 344.4
 ;RCFILE = 4 file 344.4, 5 if 344.5
 ;DUP = msg # if dup msg, but not same # or -1 if same msg #
 ;Returned for each bill in ERA:
 ;^TMP($J,"RCDPEOB",n)=Bill ien^AR bill#^SrvDt^ECME#
 ;^TMP($J,"RCDPEOB",n,"EOB")=EOB ien^amt pd^ins co ptr^rev flg^EEOB pn^amtbld^^^^BPNPI^RNPI^ETQual^LN^FN
 ;^TMP($J,"RCDPEOB","ADJ",x)=adj rec ('02')
 ;Also:
 ;^TMP($J,"RCDPEOB","HDR")=hdr rec from txmn
 ;^TMP($J,"RCDPEOB","CONTACT")=ERA contact rec ('01')
 ;
 N RCGBL,RC,RC0,RCCT,RCCT1,RCEOB,RCBILL,RCDPBNPI,RCMNUM,RCIFN,RCIB,RCERR,RCSTAR,RCET,RCX,RCXMG,Z,Q,DA,DR,DIE
 N RCPAYER,RCFILED,RCEOBD,RCNOUPD,REFORM,RCSD,RCERR1,C5,ECMENUM
 K ^TMP($J,"RCDP-EOB"),^TMP("RCDPERR-EOB",$J)
 ;
 S RCPAYER="",RCFILED=1,RCNOUPD=0
 I RCFILE=5 D
 .S RCGBL=$NA(^RCY(344.5,RCTDA,2))
 .S RCMNUM=+$G(^RCY(344.5,RCTDA,0)),RCXMG=$P($G(^(0)),U,11)
 .I $G(DUP) S RCNOUPD=$S(DUP>0:+DUP,1:RCXMG)
 .S ^TMP($J,"RCDPEOB","HDR")=$G(^RCY(344.5,RCTDA,2,1,0))
 .I $P(^TMP($J,"RCDPEOB","HDR"),U)["XFR",'$P($G(^RCY(344.5,RCTDA,0)),U,14) D
 ..D SENDACK^RCDPESR5(RCTDA,1)
 ..S DR=".14////1",DIE="^RCY(344.5,",DA=RCTDA D ^DIE
 ;
 I RCFILE=4 D
 .S RCGBL=$NA(^RCY(344.4,+RCTDA,1,+$P(RCTDA,";",2),1))
 .S RCMNUM=$P($G(^RCY(344.4,+RCTDA,0)),U,12),RCXMG=$P($G(^(0)),U,12)
 .S ^TMP($J,"RCDPEOB","HDR")=$G(^RCY(344.4,+RCTDA,1,+$P(RCTDA,";",2),1,1,0))
 ;
 S RCPAYER=$P($G(^TMP($J,"RCDPEOB","HDR")),U,6)
 S RCDPBNPI=$P($G(^TMP($J,"RCDPEOB","HDR")),U,18)
 ;
 ;srv dates
 S RCSD=$NA(^TMP($J,"RCSRVDT")) K @RCSD
 N CP5 S CP5="",RC=1,C5=0 ;retrofit 264 into 269
 F  S RC=$O(@RCGBL@(RC)) Q:'RC  S RC0=$G(^(RC,0)) D
 .I RC0<5 Q
 .I +RC0=5 S C5=RC,CP5=$P(RC0,U,2) Q  ;retrofit 264 into 269
 . ; service date for possible ECME# matching
 .I +RC0=40,$$VALECME^BPSUTIL2(CP5),C5,'$D(@RCSD@(C5)) S @RCSD@(C5)=$P(RC0,U,19)
 ;
 S RC=1,(RCCT,RCCT1,RCX,REFORM)=0,RCBILL=""
 S RCERR1=$NA(^TMP("RCERR1",$J)) K @RCERR1
 F  S RC=$O(@RCGBL@(RC)) Q:'RC  S RC0=$G(^(RC,0)) D
 .I RCFILE=5,+RC0=1 D  Q
 ..S ^TMP($J,"RCDPEOB","CONTACT")=RC0
 .;
 .I RCFILE=5,+RC0=2 D  Q
 ..S RCX=RCX+1,^TMP($J,"RCDPEOB","ADJ",RCX)=RC0
 .I RCFILE=5,+RC0=3 D  Q  ; Adding logic for line type 03,Patch 269,DWA
 ..S $P(^TMP($J,"RCDPEOB","ADJ",RCX),U,5)=$P(RC0,U,2)
 .;
 .I +RC0=5 S RCCT=RCCT+1,RCCT1=0 D
 ..S REFORM=0,ECMENUM="" I $$VALECME^BPSUTIL2($P(RC0,U,2)) S ECMENUM=$P(RC0,U,2)
 ..S Z=$$BILL^RCDPESR1($P(RC0,U,2),$G(@RCSD@(RC)),.RCIB)   ; look up claim ien by claim# or by ECME#
 ..I Z S RCBILL=$P($G(^PRCA(430,Z,0)),U) I RCBILL'="",RCBILL'=$P(RC0,U,2) S REFORM=1,$P(RC0,U,2)=RCBILL
 ..S RCBILL=$P(RC0,U,2)
 ..S Z=$S(Z>0:$S($G(RCIB):Z,1:-1),1:-1)
 ..S ^TMP($J,"RCDP-EOB",RCCT,0)=Z_U_RCBILL_U_$G(@RCSD@(RC))_U_ECMENUM
 ..S $P(^TMP($J,"RCDPEOB",RCCT,"EOB"),U,5)=$P(RC0,U,3)_","_$P(RC0,U,4)_" "_$P(RC0,U,5) ;Save pt nm
 ..I Z>0 S Q=+$P($G(^PRCA(430,Z,0)),U,9) I $P($G(^RCD(340,Q,0)),U)["DIC(36," S $P(^TMP($J,"RCDPEOB",RCCT,"EOB"),U,3)=+^RCD(340,Q,0) ;Save ins co
 .;
 .I +RC0>5,REFORM S $P(RC0,U,2)=RCBILL ;
 .I +RC0=10 D  ;Save amt pd/billed, rev flg
 ..S $P(^TMP($J,"RCDPEOB",RCCT,"EOB"),U,2)=$S(+$P(RC0,U,11):$J($P(RC0,U,11)/100,"",2),1:0),$P(^TMP($J,"RCDPEOB",RCCT,"EOB"),U,6)=$J($P(RC0,U,11),"",2)
 ..I $P(RC0,U,6)="Y"!($P(RC0,U,7)=22) S $P(^TMP($J,"RCDPEOB",RCCT,"EOB"),U,4)=1
 ..S $P(^TMP($J,"RCDPEOB",RCCT,"EOB"),U,10,14)=RCDPBNPI_U_$P(RC0,U,16,19)
 .I +RC0=11 D  ; Save Rendering Provider information from new style message
 ..S $P(^TMP($J,"RCDPEOB",RCCT,"EOB"),U,10,14)=RCDPBNPI_U_$P(RC0,U,3,6)
 ..; End save of Rendering Provider
 .I RCBILL=$P(RC0,U,2) S RCCT1=RCCT1+1,^TMP($J,"RCDP-EOB",RCCT,RCCT1,0)=RC0
 ;
 S RCSTAR=$TR($J("",15)," ","*"),RCET=RCSTAR_"ERROR/WARNING EEOB DETAIL SEQ #"
 S RCCT=0 F  S RCCT=$O(^TMP($J,"RCDP-EOB",RCCT)) Q:'RCCT  S RCIFN=+$G(^(RCCT,0)),RCBILL=$P($G(^(0)),U,2),^TMP($J,"RCDPEOB",RCCT)=$G(^TMP($J,"RCDP-EOB",RCCT,0)) D
 .S RCEOB=-1,RCEOBD=""
 .I $S(RCIFN>0:$P(^PRCA(430.3,+$P($G(^PRCA(430,+RCIFN,0)),U,8),0),U,3)'=102,RCIFN'>0&($G(DUP)'>0):1,1:0) D
 ..S @RCERR1@(RCCT)=" ",@RCERR1@(RCCT,1)=RCET_RCCT_RCSTAR
 ..S @RCERR1@(RCCT,2)="Bill "_RCBILL_" is"_$S(RCIFN>0:" not in an ACTIVE status in your A/R",1:"n't valid/wasn't found so its detail wasn't stored in IB")
 ..S:RCFILE=5 @RCERR1@(RCCT,"*")=@RCERR1@(RCCT,2)
 ..S @RCERR1@(RCCT,3)="  The reported amount paid on this bill was: "_$P(^TMP($J,"RCDPEOB",RCCT,"EOB"),U,2)
 ..I RCIFN'>0 D
 ...S @RCERR1@(RCCT,4)="  If the bill is not for your site, it must be transferred to the"
 ...S @RCERR1@(RCCT,5)="   correct site and manually adjusted in your AR."
 ...S @RCERR1@(RCCT,6)="  You can perform this transfer using EDI Lockbox ERA/EEOB exception process."
 ...S @RCERR1@(RCCT,7)=" "
 ..D DISP1^RCDPESR5(RCCT,1)
 ..S Q=0 F  S Q=$O(^TMP($J,"RCDP-EOB",RCCT,Q)) Q:'Q  S ^TMP($J,"RCDPEOB",RCCT,Q)=$G(^TMP($J,"RCDP-EOB",RCCT,Q,0))
 ..S ^TMP($J,"RCDPEOB",RCCT)=^TMP($J,"RCDP-EOB",RCCT,0) M ^TMP($J,"RCDPEOB",RCCT,"ERR")=@RCERR1@(RCCT)
 ..I RCFILE=5 D  ;Store err if trans-in failed
 ...N RCE,RC,DIE,X,Y,DA,DR
 ...S RCE(1)=$$FMTE^XLFDT($$NOW^XLFDT(),2)_" "_$G(@RCERR1@(RCCT,"*"))
 ...S RCE(2)=" ",RCFILED=0
 ...D WP^DIE(344.5,RCTDA_",",5,"A","RCE")
 .I RCIFN>0 D
 ..N RCDUPEOB,RCALLDUP
 ..;Chk rec exists
 ..S RCDUPEOB=0
 ..S RCEOB=$$DUP^RCDPESR3(RCMNUM,RCIFN,$P($G(^TMP($J,"RCDPEOB",RCCT,"EOB")),U,2),$P($G(^TMP($J,"RCDPEOB",RCCT,"EOB")),U,6)) ;Same msg for update?
 ..I RCEOB,$P(RCEOB,U,2) S RCEOB=0  ;If chksum exists, let below check it
 ..S ^TMP($J,"RCDP-EOB",RCCT,.5,0)="835ERA" ;Needed - checksum
 ..S RCALLDUP=$$DUP^IBCEOB("^TMP("_$J_",""RCDP-EOB"","_RCCT_")",RCIFN)
 ..I $S(RCALLDUP:1,RCEOB:$G(DUP)'>0,1:0) D
 ...S RCDUPEOB=1
 ...D DUPREC^RCDPESR6(RCET,RCCT,RCSTAR,RCFILE,RCALLDUP,RCEOB,RCBILL,.RCDUPEOB)
 ...S:RCALLDUP RCEOBD=RCALLDUP
 ..;Add stub to 361.1
 ..I 'RCDUPEOB S RCEOB=+$$ADD3611^IBCEOB(RCMNUM,"","",RCIFN,1,"^TMP("_$J_",""RCDP-EOB"","_RCCT_")") ;IA 4042
 ..K ^TMP($J,"RCDP-EOB",RCCT,.5,0)
 ..I RCEOB<0 D:$G(DUP)'>0  Q
 ...S @RCERR1@(RCCT)=" ",^(RCCT,1)=RCET_RCCT_RCSTAR,RCFILED=0
 ...S @RCERR1@(RCCT,2)="Error - EEOB detail not added to IB for bill "_RCBILL,$P(^TMP($J,"RCDPEOB",RCCT,"EOB"),U)=""
 ...S:RCFILE=5 @RCERR1@(RCCT,"*")=@RCERR1@(RCCT,2)
 ...D DISP1^RCDPESR5(RCCT,1)
 ...S Q=0 F  S Q=$O(^TMP($J,"RCDP-EOB",RCCT,Q)) Q:'Q  S ^TMP($J,"RCDPEOB",RCCT,Q)=$G(^TMP($J,"RCDP-EOB",RCCT,Q,0))
 ...S ^TMP($J,"RCDPEOB",RCCT)=^TMP($J,"RCDP-EOB",RCCT,0) M ^TMP($J,"RCDPEOB",RCCT,"ERR")=@RCERR1@(RCCT)
 ..;Upd 361.1, needs ^TMP($J,"RCDPEOB","HDR" and $J,"RCDP-EOB"
 ..I RCDUPEOB'<0 S RCNOUPD=0 D UPD3611^IBCEOB(RCEOB,RCCT,1)
 ..;errors in ^TMP("RCDPERR-EOB",$J
 ..I $O(^TMP("RCDPERR-EOB",$J,0)) D ERRUPD^IBCEOB(RCEOB,"RCDPERR-EOB")
 ..S $P(^TMP($J,"RCDPEOB",RCCT,"EOB"),U)=$S('$G(RCEOBD):RCEOB,1:RCEOBD)
 .K ^TMP("RCDPERR-EOB",$J)
 ;
 I RCNOUPD D DUPERA^RCDPESR3($G(DUP),RCNOUPD)
 I $O(@RCERR1@("")) D BULLS^RCDPESR3(RCFILE,RCTDA,$S(RCNOUPD:RCNOUPD,1:$G(DUP)),$G(RCXMG))
 K ^TMP("RCDPERR-EOB",$J),^TMP($J,"RCDP-EOB"),@RCERR1,@RCSD
 D CLEAN^DILF
 Q
