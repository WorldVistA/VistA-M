RCRCRT ;ALB/CMS - RC TRANSACTION PROC OVER INTERFACE ;8/27/97  11:01 AM
V ;;4.5;Accounts Receivable;**63,147,168,169,189,159**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
EN ;Enter at top with the Transaction Type from RC Server via Taskman
 ;Create the AR Transaction or send Transaction/Comment LOG to RC.
 ;Input: RCSITE,RCBDT,RCEDT,RCJOB,RCXTYP,RCVAR,RCXMY
 ;Input: XTMP(RCXTYP,RCJOB,  
 ;RCXTYP:
 ;    CL   - Comment Log send all Comments to RC
 ;    TR   - Send all Transactions to RC
 ;    DA-1 - DA-3 Decrease Adj.,Bill Status Collected/Close,Contractual Adjustment Yes, Tran. Comment 
 ;    DA-4 - Decrease Adj.,Bill Status Cancellation,Contractual Adjustment Yes, Tran. Comment 
 ;    DA-5 - DA-10 Decrease Adj.,Bill Status Cancellation,Notify IB of Cancelation, Tran. Comment 
 ;    TJ-1 - TJ-5 Termination by RC,Bill Status Write-off, Tran. Comment 
 ;    RT   - Returned by RC/DOJ,Delete Referral Date in 430
 ; 
 N PRCABN,PRCABN0,RCAMT,RCCAT,RCBNAM,RCD,RCERR,RCFL,RCL,RCCMSG,RCTR,RCTYP,XMZ
 K ^TMP("RCRCAT",$J,"XM") S RCCMSG=""
 S RCXMZ=$P($G(^XTMP($G(RCXTYP,"UNK"),+$G(RCXMZ),0)),U,4) I 'RCXMZ G ENQ
 S RCL=0 F  S RCL=$O(^XTMP(RCXTYP,RCXMZ,RCL)) Q:'RCL  S RCD=^(RCL) D
 .I RCD["$$RC$" S RCTYP=$P(RCD,"$",4) Q
 .I RCD["$END$" Q
 .S RCBNAM=$P(RCD,U,1),RCAMT=+$P(RCD,U,2)
 .S PRCABN=$O(^PRCA(430,"B",RCBNAM,0))
 .I 'PRCABN S RCCMSG="E;Bill "_RCBNAM_" does not exist at this medical center" Q
 .S RCD=$$REFST^RCRCUTL(PRCABN)
 .I ('RCD)!("RCDCDOJ"'[$P(RCD,U,2)) S RCCMSG="E;Bill "_RCBNAM_" is not currently referred to RC." Q
 .I (RCTYP="CL")!(RCTYP="TR") Q
 .S PRCABN0=$G(^PRCA(430,PRCABN,0))
 .I $P(PRCABN0,U,8)'=16 S RCCMSG="E;Bill "_RCBNAM_" is no longer Active at medical center." Q
 .D RCCAT^RCRCUTL(.RCCAT)
 .I +$G(RCCAT(+$P(PRCABN0,U,2)))'=1 S RCCMSG="E;Bill "_RCBNAM_" Category is not electronically referred." Q
 .I "TJDA"[$E(RCTYP,1,2) D
 ..I RCAMT'=+$P(RCD,U,3) S RCCMSG="E;Bill "_RCBNAM_" for $"_RCAMT_" does not equal AR Referred Amount of $"_+$P(RCD,U,3)_". AR Site Problem!" Q
 ..S RCD=+$P($$BILL^RCJIBFN2(PRCABN),U,3)
 ..I RCAMT'=RCD S RCCMSG="E;Bill "_RCBNAM_" for $"_RCD_" does not equal the AR Current Balance. RC may need to Return Bill!" Q
 ;
 I RCCMSG]"" S XMZ=+RCXMZ D SEND^RCRCSRV G ENQ
 ;
 I (RCTYP="CL")!(RCTYP="TR") D TR G ENQ
 ;
 S RCTR=$S(RCTYP="RT":6,$E(RCTYP,1,2)="DA":35,$E(RCTYP,1,2)="TJ":29,1:0)
 I RCTR D TRAN
 ;
ENQ K ^XTMP(RCXTYP,RCXMZ)
 K RCSITE,RCBDT,RCEDT,RCJOB,RCXTYP,RCVAR,RCXMY,RCXMZ
 Q
 ;
REF ;Entry point from Review/Refer Protocol
 ;Refer to RC (3) or  Re-Establish to RC/DOJ (5) send to RC
 ;Input: PRCABN, RCCOM (Optional)
 N DA,DIE,DR,PRCAEN,RCBAL,RCI,RCTYP,RC7,X,Y,RCCOM1
 S DA=PRCABN,DIC="^PRCA(430," D LCK^PRCAUPD
 S RCCODE="RC"
 S RCTYP=$S($P($G(^PRCA(430,PRCABN,6)),U,4):5,1:3)
 S RCCOM1=$P($G(^PRCA(430,PRCABN,6)),U,22,23)
 S:RCCOM1 RCCOM1=$$EXTERNAL^DILFD(430,68.94,"",$P(RCCOM1,"^"))_$S($L($P(RCCOM1,"^",2)):" - "_$P(RCCOM1,"^",2),1:"")
 S RCBAL=0,RC7=$G(^PRCA(430,PRCABN,7))
 F RCI=1:1:5 S RCBAL=RCBAL+$P(RC7,U,RCI)
 D SETTR^PRCAUTL,PATTR^PRCAUTL I '$D(PRCAEN) G REFQ
 S DA=PRCAEN,DIE="^PRCA(433,",DR="[PRCAC RC REFER]" D ^DIE
 I $G(RCCOM)]"" D COM(PRCAEN,RCCOM)
 S DR=$S(RCTYP=5:"68.2////"_DT_";",1:"")_"64////"_DT_";65////^S X=""RC"";66////"_RCBAL
 S DA=PRCABN,DIE="^PRCA(430," D ^DIE
REFQ L -^PRCA(430,PRCABN)
 Q
 ;
COM(PRCAEN,RCCOM,ERR) ;Update AR Transaction Comments
 N X,Y
 I '$D(^PRCA(433,+$G(PRCAEN),0)) G COMQ
 S COM(1,1)=RCCOM
 S:$L($G(RCCOM1)) COM(1,2)=RCCOM1
 D WP^DIE(433,PRCAEN_",",41,"A","COM(1)","ERR(0)")
COMQ Q
 ;
INC ;Increase Referred TP Bill called by Protocol
 N DA,DIE,DIR,DR,DTOUT,DUOUT,PRCA,PRCABN,PRCAEN,RCBAL,RCBN,RCEN,RCOUT,RCSP,RCY,X,Y
 D FULL^VALM1
 I '$O(^TMP("RCRCAL",$J,"SEL",0)) W !!,"NO SELECTED ITEMS FROM LIST!" G INCQ
 W !! S DIR("A",1)="Increasing bill(s) on highlighted Selection List "
 S DIR("A")="Okay to continue ",DIR("?")="Enter Yes to Continue"
 D ASK^RCRCACP K DIR I $G(Y)'=1 G INCQ
 S RCY=0 F  S RCY=$O(^TMP("RCRCAL",$J,"SEL",RCY)) Q:('RCY)!($G(RCOUT))  D
 .   S PRCABN=+$P($G(^TMP("RCRCALX",$J,RCY)),U,2)
 .   I '$D(^PRCA(430,PRCABN,0)) Q
 .   W !!,?5,"Patient",?22,"Bill #",?33,"Cat.",?62,"Orig Amt",?72,"Cur Bal"
 .   W !,$G(^TMP("RCRCAL",$J,RCY,0))
 .   ;  get the balance before the adjustment
 .   S RCBAL=+$P($$BILL^RCJIBFN2(PRCABN),U,3)
 .   ;  create increase adjustment
 .   D ADJBILL^RCBEADJ("INCREASE",PRCABN)
 .   ;  get the balance after the adjustment
 .   S X=+$P($$BILL^RCJIBFN2(PRCABN),U,3)
 .   I RCBAL=X W !!,"** Bill not Increased **",! G INCX
 .   S RCBAL=X,DA=PRCABN,DIE="^PRCA(430,",DR="66///^S X="_RCBAL D ^DIE
 .   S RCSP="",RCBAL=$J(RCBAL,".",2),$E(RCSP,10-$L($E(RCBAL,1,10)))=" ",RCBAL=RCSP_RCBAL
 .   D FLDTEXT^VALM10(RCY,"CURAMT",RCBAL)
 .   I '$G(PRCAEN) S PRCAEN=$O(^PRCA(433,"C",PRCABN,9999999),-1)
 .   D PF^RCRCAT("I")
INCX .   K DIR,PRCA,PRCAEN
 .   I '$O(^TMP("RCRCAL",$J,"SEL",RCY)) Q
 .   W !! S DIR("A")="Continue Increasing Selected Bills ",DIR("?")="Enter Yes to Continue to next bill"
 .   D ASK^RCRCACP K DIR I $G(Y)'=1 S RCOUT=1
 ;
INCQ K DIR D PAUSE^VALM1 S VALMBCK="R"
 Q
 ;
TR ;Send Transactions or Comment Log to RC for bill
 N PRCA,PRCAEN,RCI,RCXCNT,X,Y,RCSITE,RCDOM,RCBDIV,RCDIV S RCXCNT=0
 D BNVAR^RCRCUTL(PRCABN)
 D DEBT^RCRCUTL(PRCABN)
 S RCSITE=$$SITE^RCMSITE
 D RCDIV^RCRCDIV(.RCDIV)
 S PRCAEN=0 F  S PRCAEN=$O(^PRCA(433,"C",PRCABN,PRCAEN)) Q:'PRCAEN  D
 .I RCTYP="CL",$P($G(^PRCA(433,PRCAEN,1)),U,2)'=45 Q
 .D SET^RCRCAT1
 ;
 I '$O(^TMP("RCRCAT",$J,"XM",PRCABN,0)) D
 .S ^TMP("RCRCAT",$J,"XM",PRCABN,1,1)="BN1^"_PRCA("BNAME")_U_PRCA("DEBTNM")
 .S ^TMP("RCRCAT",$J,"XM",PRCABN,1,2)="TR1^0^0"
 .S ^TMP("RCRCAT",$J,"XM",PRCABN,1,3)="COMMENT: No "_$S(RCTYP="CL":"Comment ",1:"")_"Transactions at site for Bill "_PRCA("BNAME")_"."
 I $G(RCDIV(0)) S RCBDIV=$$DIV^IBJDF2(PRCABN) S X=0 F  S X=$O(RCDIV(X)) Q:'X  D
 .I X=+RCBDIV S RCDOM=$P(RCDIV(X),"^",6)
 I $G(RCDOM)="" S RCDOM=$$RCDOM^RCRCUTL
 D SEND^RCRCAT
 K ^TMP("RCRCAT",$J,"XM")
TRQ Q
 ;
TRAN ;Process Termination, Returned and Decrease Transactions from RC
 ;Input: PRCABN,PRCABN0,RCTYP,RCBNAM,RCAMT,RCTR=6,29 or 35
 ;  
 N DA,DIC,DIE,DR,LN,PRCA,PRCAA2,PRCAEN,PRCAQNM,X,XMCHAN,XMZ,XMY,XMDUZ,XMSUB,XMTEXT,Y
 N RCAMT,RCAD,RCCA,RCCC,RCCOM,RCDT,RCERR,RCI,RCIB,RCMF,RCO,RCPB
 S DA=PRCABN,DIC="^PRCA(430,",XMCHAN=1 D LCK^PRCAUPD
 D SETTR^PRCAUTL,PATTR^PRCAUTL I '$D(PRCAEN) Q
 S RCI=$O(^RCT(349.4,"B",RCTYP,0)),RCI=$G(^RCT(349.4,+RCI,0))
 S PRCA("STATUS")=$P(RCI,U,3),RCCA=$P(RCI,U,4),RCDT=DT
 S RCAMT=0,RCI=$G(^PRCA(430,PRCABN,7))
 F X=1:1:5 S RCAMT=RCAMT+$P(RCI,U,X)
 S RCPB=$P(RCI,U,1),RCIB=$P(RCI,U,2),RCAD=$P(RCI,U,3),RCMF=$P(RCI,U,4),RCCC=$P(RCI,U,5)
 I RCTR=35 S RCAMT=-RCAMT
 S DA=PRCAEN,DIE="^PRCA(433,",DR="[PRCAC RC TRAN]" D ^DIE
 S RCCOM=RCTYP_" Transaction created electronically by local Regional Counsel Office"
 D COM(PRCAEN,RCCOM)
 S DA=PRCAEN,DR="7///^S X=""RC""",DIE="^PRCA(433," D ^DIE
 ;
 ;If action is not a Returned by RC/DOJ
 I RCTR'=6 D
 .S RCI=$P($G(^PRCA(430,PRCABN,6)),U,5)
 .I RCI="DC" S $P(^PRCA(430,PRCABN,6),U,5)="RC"
 .D UPSTATS^PRCAUT2
 .S PRCAA2=$G(^PRCA(433,PRCAEN,4,0))
 .I $P(PRCAA2,U,4) D
 ..S PRCAA2=$P(PRCAA2,U,3)
 ..S $P(^PRCA(433,PRCAEN,4,PRCAA2,0),U,2,5)=RCAMT_"^^1^"_RCAMT
 ;
 ;If action is a Decrease
 I RCTR=35 D  G TRANQ
 .S DA=PRCABN,DIE="^PRCA(430,"
 .S DR="71///^S X=0;72///^S X=0;73///^S X=0;74///^S X=0;75///^S X=0" D ^DIE
 .S PRCAQNM=1 D EN1^PRCADJ
 .S DA=PRCAEN,DIE="^PRCA(433,",DR="14////^S X="_+PRCAQNM
 .I RCCA S DR=DR_";88////1"
 .D ^DIE
 .I RCCA=1 D
 ..S RCO=$P(^PRCA(430,PRCABN,0),U,3),RCAMT=RCO+RCAMT
 ..D BULL^IBCNSBL2(PRCABN,RCO,$$PAID^PRCAFN1(+PRCABN))
 .I '$$ACCK^PRCAACC(PRCABN),'($P($G(^PRCA(433,+PRCAEN,8)),U,8)) D
 ..D EN^PRCAFBDM(PRCABN,RCAMT,RCTR,RCDT,PRCAEN,.RCERR)
 .L -^PRCA(430,PRCABN)
 ;
 ;If action is a Returned by RC/DOJ
RT I RCTR=6 D  G TRANQ
 .S DA=PRCABN,DIE="^PRCA(430,"
 .S DR="64///@;65///@;66///@;68.3///^S X="_RCDT D ^DIE
 .S DA=PRCAEN,DIE="^PRCA(433,",DR="81///^S X="_RCAMT D ^DIE
 .L -^PRCA(430,PRCABN)
 .S XMDUZ="ACCOUNTS RECEIVABLE RC SERVER",XMSUB="AR/RC - REFERRED AR BILL RETURNED BY RC"
 .S XMY("G.RC RC REFERRALS")=""
 .S LN(1)="  Referred TP Bill "_$P(^PRCA(430,PRCABN,0),U,1)_" was returned"
 .S LN(2)="  by Regional Counsel.  Return MAY be because"
 .S LN(3)="  of a reconciliation issue."
 .S XMTEXT="LN(" D ^XMD
 ;
 ;If action is Termination by RC/DOJ
 I RCTR=29 D  G TRANQ
 .S DA=PRCAEN,DIE="^PRCA(433,",DR="17///9;81///^S X="_RCAMT D ^DIE
 .I '$$ACCK^PRCAACC(PRCABN) D FMSDOC^RCWROFF(PRCAEN)
 .L -^PRCA(430,PRCABN)
 ;
TRANQ Q
 ;RCRCRT
