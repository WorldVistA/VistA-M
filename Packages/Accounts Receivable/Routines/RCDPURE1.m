RCDPURE1 ;WISC/RFJ - Process a Receipt ;Jun 06, 2014@19:11:19
 ;;4.5;Accounts Receivable;**114,148,153,169,204,173,214,217,296,298,304,321,367**;Mar 20, 1995;Build 11
 ;;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
 ;
PROCESS(RCRECTDA,RCSCREEN) ;  process a receipt, update ar, generate cr/tr documents to fms
 ;  the receipt and deposit must be locked before calling this label
 ;  if $g(rcscreen) = 1 show messages during processing
 ;  if $g(rcscreen) = 2 store messages during processing
 ; 
 N RCPAYDA,RCDPFPAY,RCERROR,RCMSG,RCEFT,RCERA,RCPAYDT0,RCPAYDT1,RCSUSPAR,RCI,RCJ,RCCMTFLG
 K ^TMP($J,"RCDPEMSG"),^TMP("RCDPE-RECEIPT-ERROR",$J)
 S RCCMTFLG=""
 ;
 ; === No comments ===  PRCA*4.5*304
 ; If there are entries in suspense with no comments, AND, posting manually, not through auto-posting, display the list of entries
 I RCSCREEN=1 D  Q:RCCMTFLG
 . S RCSUSPAR="",RCPAYDA=0
 . F  S RCPAYDA=$O(^RCY(344,RCRECTDA,1,RCPAYDA)) Q:'RCPAYDA  D
 . . S RCPAYDT0=$G(^RCY(344,RCRECTDA,1,RCPAYDA,0))
 . . S RCPAYDT1=$G(^RCY(344,RCRECTDA,1,RCPAYDA,1))
 . . ; If there is no Bill linked, and the pay amount is not 0 and there is no comment, add to the list
 . . I $P(RCPAYDT0,U,9)="",($P(RCPAYDT0,U,4)'=0),($P(RCPAYDT1,U,2)="") S RCSUSPAR(RCPAYDA)=""
 . ;
 . S RCI="" I $O(RCSUSPAR(RCI)) D  Q
 . . I '$G(RCSCREEN) Q
 . . S RCMSG="The following line items are in suspense: "
 . . S RCJ="" F  S RCJ=$O(RCSUSPAR(RCJ)) Q:'RCJ  D
 . . . S RCMSG=RCMSG_RCJ_","
 . . S RCMSG=$E(RCMSG,1,$L(RCMSG)-1)
 . . D MSG(RCMSG,RCSCREEN,"!!")
 . . S RCMSG="Please add the appropriate comment(s) to these line items before re-processing this receipt."
 . . D MSG(RCMSG,RCSCREEN,"!!")
 . . S RCCMTFLG=1
 ;
 ;  first mark the receipt as processed/closed to prevent changing the
 ;  data if the receipt does not fully process.  this will lock the
 ;  cancel payment, edit payment, etc. options.  once a receipt is
 ;  processed, even partially, it should not be changed.
 D MARKPROC^RCDPUREC(RCRECTDA,"")
 ;
 ; Special processing needed for EFT-related receipts
 ; RCEFT = 1 if EFT deposit, = 2 if receipt detail transfer, 0 if no EFT
 S RCEFT=+$$EDILB^RCDPEU(RCRECTDA)
 S RCERA=$P($G(^RCY(344,RCRECTDA,0)),U,18)
 ;
 ;  === no payments ===
 ;  if there are no payments for the receipt, quit
 I '$O(^RCY(344,RCRECTDA,1,0)) D  Q
 . I $G(RCSCREEN) S RCMSG="Receipt does not have any payments and has been marked as processed/closed." D MSG(RCMSG,RCSCREEN,"!!")
 . S ^TMP("RCDPE-RECEIPT-ERROR",$J)=RCMSG  ;prca*4.5*298  used by auto-post process
 . I RCERA D UPDERA(RCERA)
 ;
 ;  check to see if the payments have dollar amounts
 S RCPAYDA=0 F  S RCPAYDA=$O(^RCY(344,RCRECTDA,1,RCPAYDA)) Q:'RCPAYDA  I $P($G(^(RCPAYDA,0)),"^",4) S RCDPFPAY=1 Q
 I '$G(RCDPFPAY) D  Q
 . I $G(RCSCREEN)  S RCMSG="Receipt does not have any payments and has been marked as processed/closed." D MSG(RCMSG,RCSCREEN,"!!")
 . S ^TMP("RCDPE-RECEIPT-ERROR",$J)=RCMSG  ;prca*4.5*298  used by auto-post process
 . I RCERA D UPDERA(RCERA)
 ;
 ;  === update AR accounts ===
 I $G(RCSCREEN) S RCMSG="Updating AR accounts..." D MSG(RCMSG,RCSCREEN,"!!")
 ;
 ;  loop payments and apply to account in AR
 S RCPAYDA=0 F  S RCPAYDA=$O(^RCY(344,RCRECTDA,1,RCPAYDA)) Q:'RCPAYDA  D  I RCERROR Q
 . S RCERROR=$$PROCESS^RCBEPAY(RCRECTDA,RCPAYDA)
 . S:RCERROR ^TMP("RCDPE-RECEIPT-ERROR",$J)=RCERROR  ;prca*4.5*298  used by auto-post process
 ;
 ;  an error occurred during processing a payment
 I $G(RCERROR) D  Q
 .   I '$G(RCSCREEN) Q
 .   S RCMSG="+-----------------------------------------------------------------------------+" D MSG(RCMSG,RCSCREEN,"!!")
 .   S RCMSG="|  An ERROR has occurred when processing payment "_RCPAYDA_" on receipt "_$P(^RCY(344,RCRECTDA,0),"^")_".",RCMSG=$E(RCMSG_$J("",77),1,77)_"|" D MSG(RCMSG,RCSCREEN,"!")
 .   S RCMSG="|  The error message returned during processing is:",RCMSG=$E(RCMSG_$J("",77),1,77)_"|" D MSG(RCMSG,RCSCREEN,"!")
 .   S RCMSG="|"_$J("",77)_"|" D MSG(RCMSG,RCSCREEN,"!")
 .   S RCMSG=$E("|  "_$P(RCERROR,"^",2)_$J("",77),1,77)_"|" D MSG(RCMSG,RCSCREEN,"!")
 .   S RCMSG="|"_$J("",77)_"|" D MSG(RCMSG,RCSCREEN,"!")
 .   S RCMSG=$E("|  You will need to correct the error before you can completely process the"_$J("",77),1,77)_"|" D MSG(RCMSG,RCSCREEN,"!")
 .   S RCMSG=$E("|  receipt.  Once the receipt is completely processed, the FMS "_$S(RCEFT'=2:"Cash Receipt",1:"'TR'")_$J("",77),1,77)_"|" D MSG(RCMSG,RCSCREEN,"!")
 .   S RCMSG=$E("|  document will be generated."_$J("",77),1,77)_"|" D MSG(RCMSG,RCSCREEN,"!")
 .   S RCMSG="+-----------------------------------------------------------------------------+" D MSG(RCMSG,RCSCREEN,"!")
 ;
 ;  all payments processed correctly
 I RCERA D UPDERA(RCERA)
 I $G(RCSCREEN) D MSG(" Done.",RCSCREEN)
 ;
 ;  *296 - no cr document for event type 'a' or 'p' or 't'
 N RCDPETY S RCDPETY=$P($G(^RCY(344,RCRECTDA,0)),"^",4)
 I (RCDPETY=15)!(RCDPETY=16)!(RCDPETY=13) D 215 Q
 ;
 ;  if no deposit ticket and not related to EFT or is a HAC payment, do not send to fms
 I '$P(^RCY(344,RCRECTDA,0),"^",6),$S('RCEFT:1,1:$$HACEFT^RCDPEU(+$P(^RCY(344,RCRECTDA,0),U,17))) D  Q
 . D 215
 . I $G(RCSCREEN) S RCMSG="Receipt does not have a deposit ticket and will NOT be sent to FMS." D MSG(RCMSG,RCSCREEN,"!!")
 . S ^TMP("RCDPE-RECEIPT-ERROR",$J)=""  ;prca*4.5*298  used by auto-post process
 ;
 ;  === send fms cash receipt document ===
 N GECSDATA,FMSDOCNO,RESULT,REFMS
 ;  lookup fms document number to see if the receipt has been
 ;  sent to fms (field 200 in file 344)
 S FMSDOCNO=$P($G(^RCY(344,RCRECTDA,2)),"^")
 ;  if there is an entry, find the code sheet in gcs to rebuild
 ;  gecsdata will be the ien for file 2100.1
 I FMSDOCNO'="" S REFMS=1 N DIQ2 D DATA^GECSSGET(FMSDOCNO,0)
 ;
 I $G(RCSCREEN)&$G(GECSDATA) S RCMSG="Re-Transmitting CR document to FMS... " D MSG(RCMSG,RCSCREEN,"!!")
 I $G(RCSCREEN)&'$G(GECSDATA) S RCMSG="Transmitting CR document to FMS... " D MSG(RCMSG,RCSCREEN,"!!")
 ;
 ;  build and send the tr/cr document to fms
 I RCEFT'=2 D  ; Send CR doc
 . S RESULT=$$BUILDCR^RCXFMSCR(RCRECTDA,+$G(GECSDATA),RCEFT)
 E  D  ; Send TR doc
 . S RESULT=$$GETTR^RCXFMST1(RCRECTDA,+$G(GECSDATA))
 ;  error in building code sheet
 I 'RESULT D:$G(RCSCREEN) MSG("ERROR - "_$P(RESULT,"^",2),RCSCREEN,"!!") Q
 ;
 ;  no document to send
 I $P(RESULT,"^")=-1,$G(RCSCREEN) S RCMSG="NOTE - "_$P(RESULT,"^",2) S $P(RESULT,"^",2)="" D MSG(RCMSG,RCSCREEN,"!!") S ^TMP("RCDPE-RECEIPT-ERROR",$J)=""
 ;  document built and sent
 I $P(RESULT,"^")=1,$G(RCSCREEN) D
 . N Z,DIE,DR,DA
 . D MSG("Done. FMS document number "_$P(RESULT,"^",2),RCSCREEN,"!!")
 . I +$O(^RCY(344.4,"ARCT",RCRECTDA,0)) S DIE="^RCY(344.4,",DR=".14////1",DA=+$O(^RCY(344.4,"ARCT",RCRECTDA,0)) D ^DIE
 . I $P($G(^RCY(344,RCRECTDA,0)),U,17) S Z=$P($G(^RCY(344.31,+$P(^RCY(344,RCRECTDA,0),U,17),0)),U,15) I Z'="" S DA=RCRECTDA,DIE="^RCY(344,",DR=".16////"_Z D ^DIE
 I $G(RCSCREEN) D
 . N Y
 . I '$G(REFMS)&(DT>$$LDATE^RCRJR(DT)) S Y=$E($$FPS^RCAMFN01(DT,1),1,5)_"01" D DD^%DT W !! S RCMSG="   * * * * Transmission will be held until "_Y_" * * * *" D MSG(RCMSG,RCSCREEN,"!!")
 ;
 ;
 ;  store the fms document number (receipt already marked processed/
 ;  closed at the top of the routine just before posting the dollars.
 D MARKPROC^RCDPUREC(RCRECTDA,$P(RESULT,"^",2))
 I RCEFT=2 D MSG("No 215 report generated for this receipt",RCSCREEN,"!!") G Q215
 ;
 ;
215 ;  === print 215 report ===
 I $G(RCSCREEN) D MSG("Queuing 215 report...",RCSCREEN,"!!")
 N DEVICE
 S DEVICE=$$OPTCK^RCDPRPL2("215REPORT",3)
 I DEVICE="" D:$G(RCSCREEN) MSG(" Use Customize Option to set up the default printer.",RCSCREEN) Q
 ;
 S ZTIO=DEVICE,ZTDTH=$H,ZTRTN="DQ^RCDPR215",ZTSAVE("RECEIPDA")=RCRECTDA,ZTSAVE("RCTYPE")="A"
 D ^%ZTLOAD,^%ZISC
Q215 I $G(RCSCREEN) D MSG(" Done.",RCSCREEN)
 Q
 ;
UPDERA(RCERA) ; Update detail posted status for ERA entry RCERA
 ;
 N DA,DIE,DR
 S DA=+$G(RCERA),DR=".14////1",DIE="^RCY(344.4," D:DA ^DIE
 Q
 ;
MSG(RCMSG,RCSCREEN,PRELINE,POSTLINE) ; Write message or set into msg array
 ; RCMSG = text to write  RCSCREEN = screen flag
 ; PRELINE = the line feeds to print before the text
 ; POSTLINE = the line feeds to print after the text
 Q:'RCSCREEN
 N RCPRE,RCPOST,Z
 S RCPRE=$L($G(PRELINE),"!")-1,RCPOST=$L($G(POSTLINE),"!")-1
 I RCSCREEN=1 D  G MSGQ
 . F Z=1:1:RCPRE W !
 . W RCMSG
 . F Z=1:1:RCPOST W !
 F Z=1:1:RCPRE S ^TMP($J,"RCDPEMSG",+$O(^TMP("RCDPEMSG",""),-1)+1)=""
 S ^TMP($J,"RCDPEMSG",+$O(^TMP("RCDPEMSG",""),-1)+1)=RCMSG
 F Z=1:1:RCPOST S ^TMP($J,"RCDPEMSG",+$O(^TMP("RCDPEMSG",""),-1)+1)=""
MSGQ Q
 ;
 ; PRCA*4.5*298 updated EDIT4 removing DIPA
EDIT4(DA,DR,RCDR1,RCDR2,RCDR3) ; Modify DR string for type of payment edit
 ;   for EDI Lockbox
 ; Input: DA,DR   Output: RCDR1,RCDR2,RCDR3
 ; If type unchanged, or neither old/new are EDI Lockbox, no chk needed
 ; If old type is EDI Lockbox and scratch pad exists, no change allowed
 ; If changed to EDI Lockbox and detail already exists, no chg allowed without UNMATCH EFT key
 ; If changed to EDI Lockbox, ask for related EFT
 N RCDR,RCLST,RCM,RCM1,RCM2,RCM3,RCN4,RCNE,RCNO,RCO4,RCOE,RCP,RCSTRT,Z,Z0
 S (RCDR1,RCDR2,RCDR3)=""
 ;
 S RCP=10 F Z=2:1 Q:DR'[("@"_RCP)&(DR'[("@"_(RCP+1)))&(DR'[("@"_(RCP+2)))&(DR'[("@"_(RCP+3)))&(DR'[("@"_(RCP+4)))  S RCP=RCP*Z
 ;
 S Z=$L(DR,".04;"),RCSTRT=1,RCLST=Z
 I Z>2 D  ; Find .04, not n.04
 . F  S Z0=$P(DR,".04;",RCSTRT) Q:Z0=""!'$E(Z0,$L(Z0))  S RCSTRT=RCSTRT+1
 ;
 ; If unchanged/changed from/to other than EDI Lockbox, jump over edits
 S RCDR1="S RCP="_RCP_" D SETV^RCDPURE1;"_$P(DR,".04;",1,RCSTRT)
 S RCDR2="@"_RCP_";.04;S RCNO=0,RCN4=X D TYP^RCDPUREC(.Y);.17////^S X=RCNE;S Y=""@"_(RCP+2)_""""
 ; Reset field .04 and .17 if not a valid type change
 S RCDR2=RCDR2_";@"_(RCP+1)_";.04////^S X=RCO4;I RCOE="""" S Y=""@"_(RCP+3)_""";"
 S RCDR2=RCDR2_".17////^S X=RCOE;@"_(RCP+3)_";"
 ; PRCA*4.5*321 Modified error message logic in $S ; PRCA*4.5*367 - Added RECEIPT TOTAL if type is CHAMPVA
 S RCDR2=RCDR2_"W !,*7,$S(RCN4=14&RCNO:RCM2,RCO4=14:RCM1,1:RCM),! S Y=""@"_RCP_""";@"_(RCP+4)_";.06///@;.22;S Y=""@99"";@"_(RCP+2)
 S RCDR3=$P(DR,".04;",RCSTRT+1,RCLST)
 Q
 ;
 ; PRCA*4.5*298 updated SETV removing DIPA, added comments
SETV ; Set up variables needed to edit change of receipt type, used in DR strings to edit AR BATCH PAYMENT (#344)
 ; RCO4 = existing (#.04) TYPE OF PAYMENT value, RCOE = existing (#.17) EFT RECORD value
 N X S X=$G(^RCY(344,DA,0)),RCO4=$P(X,U,4),RCOE=$P(X,U,17)
 S RCM="RCDPEPP key required for this action"                           ; PCRA*4.5*321
 S RCM1="RCDPEPP key required once detail has been loaded from the ERA" ; PCRA*4.5*321
 S RCM2="Must have an EFT for an EDI Lockbox payment type"
 S RCM3=">>If receipt is for an ERA and a paper check, select the ERA now"
 Q
 ;
WL(DA) ; Function returns 0 if the worklist did not create the receipt
 ;  or the ien of the worklist entry if it did (344.4 and 344.49 are DINUMED)
 N Z
 S Z=+$O(^RCY(344.4,"AREC",DA,0))
 Q Z
 ;
HAC(RC) ; Returns 1 if the receipt in RC is related to a HAC EFT
 N Z,HAC
 S HAC=0
 ; ERA related to an EFT detail record
 S Z=+$G(^RCY(344.31,+$P($G(^RCY(344,RC,0)),U,17),0))
 ; Deposit # in EFT transmission starts with HAC
 I Z S Z=$P($G(^RCY(344.3,+Z,0)),U,6) I $E(Z,1,3)="HAC" S HAC=1
 Q HAC
 ;
