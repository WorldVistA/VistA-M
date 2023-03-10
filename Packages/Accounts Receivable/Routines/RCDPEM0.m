RCDPEM0 ;ALB/TMK - ERA MATCHING TO EFT (cont) ;Jun 11, 2014@13:04:03
 ;;4.5;Accounts Receivable;**173,208,220,298,304,345,375,349**;Mar 20, 1995;Build 44
 ;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
MATCH(RCZ,RCPROC) ;EP from RCDPEM
 ; Match EFT to ERA
 ; Input:   RCZ     - IEN of file 344.31
 ;          RCPROC  - 1 if called from EFT-EOB automatch, 0 if from manual match
 ;
 ; PRCA*4.5*345 - Alphabetized and added MS1,TIN1,TR1,TTL0,TTL1,XX below
 N DA,DIE,DR,MS1,NAM0,RCER,RCERATYP,RCMATCH,RCRZ,RCXCLDE,RC0,RC3444,RC34431
 N TIN0,TIN1,TR1,TTL0,TTL1,X,XX,Y,Z,Z0
 ;
 ; Find ERA to match to EFT by trace, date, amt
 ; PRCA*4.5*345 Begin - Added lines
 S TIN1=$$GET1^DIQ(344.31,RCZ_",",.03,"I")      ; EFT Payer TIN
 S TR1=$$GET1^DIQ(344.31,RCZ_",",.04,"I")       ; EFT Trace Number
 S TTL1=$$GET1^DIQ(344.31,RCZ_",",.07,"I")      ; EFT Amount of Payment
 S MS1=$$GET1^DIQ(344.31,RCZ_",",.06,"I")       ; EFT Match Status
 ; PRCA*4.5*345 End
 S RC34431=$G(^RCY(344.31,RCZ,0))               ; EFT record 
 Q:MS1!$O(^RCY(344,"AEFT",RCZ,0))               ; Already matched
 I TIN1'="",TR1'="" D                           ; Must have Payor TIN and Trace #
 . ;
 . ; Loop through all of the ERAs that match the EFT on Trace Number and TIN
 . S RCRZ=0
 . F  S RCRZ=$O(^RCY(344.4,"ATRIDUP",$$UP^XLFSTR(TR1),$$UP^XLFSTR(TIN1),RCRZ)) Q:'RCRZ  S RC3444=$G(^RCY(344.4,RCRZ,0)) I '$O(^RCY(344.31,"AERA",RCRZ,0)),'$P(RC3444,U,9) D  Q:$D(Z(1))
 . . S Z($S(+TTL1=+$P(RC3444,U,5):1,1:-1),RCRZ)="" ; Total Amount Paid match?
 ;
 S RCMATCH=+$O(Z(""),-1),RCRZ=+$O(Z(RCMATCH,0))
 S $P(^TMP($J,"RCDPETOT",344.31,RCZ),U)=RCMATCH
 ;
 I 'RCMATCH D  Q                                ; Match failure
 . S ^TMP($J,"RCTOT","NO_MATCH")=$G(^TMP($J,"RCTOT","NO_MATCH"))+1
 ;
 I RCMATCH<0 D
 . ;
 . ; Bulletin for totals don't match warning
 . S ^TMP($J,"RCTOT","TOTMIS")=$G(^TMP($J,"RCTOT","TOTMIS"))+1
 . N RCER,RCLESS,RCM,RCT,XMB,XMBODY,XMERR,XMFULL,XMINSTR,XMSUBJ,XMTO,XMTYPE,XMZ
 . S RCT=0
 . D BLD^RCDPEM1("RCER",.RCT,344.31,RC34431)
 . S RCT=RCT+1,RCER(RCT)=""
 . K RCM
 . S RCM=RCT
 . S TTL0=+$$GET1^DIQ(344.4,RCRZ_",",.05,"I")       ; ERA Total Amount Paid - PRCA*4.5*345
 . S RCLESS=(TTL1<TTL0)
 . S RCT=RCT+1,RCER(RCT)="  TOTALS ON ERA AND EFT DON'T MATCH."
 . S RCT=RCT+1,RCER(RCT)="  EFT TOTAL IS "_$S(RCLESS:"LESS",1:"GREATER")_" THAN ERA AMOUNT TOTAL"
 . I RCLESS D
 . . S RCT=RCT+1
 . . S RCER(RCT)="  DECREASE ADJUSTMENT IS NEEDED BEFORE THE ERA RECEIPT CAN BE PROCESSED."
 . I 'RCLESS D
 . . S RCT=RCT+1
 . . S RCER(RCT)="  A SUSPENSE LINE IS NEEDED ON THE RECEIPT TO ACCOUNT FOR THE DIFFERENCE."
 . S RCT=RCT+1
 . S RCER(RCT)="  IF YOU USE THE ERA WORKLIST SCRATCH PAD, THIS WILL BE GENERATED FOR YOU."
 . ;
 . S RCT=RCT+1,RCER(RCT)="  EFT WAS MATCHED TO ERA ENTRY #: "_RCRZ_" ($"_$J(TTL0,"",2)_")."
 . S XMTO("I:G.RCDPE PAYMENTS")=""
 . S XMBODY="RCER"
 . S XMSUBJ="EDI LBOX TOTALS MISMATCH ON EFT-ERA MATCH"
 . D
 . . N DUZ S DUZ=.5,DUZ(0)="@"
 . . D SENDMSG^XMXAPI(.5,XMSUBJ,XMBODY,.XMTO,,.XMZ)
 . ;
 . ; Update log
 . F  S RCM=$O(RCER(RCM)) Q:'RCM  S RCT=RCT+1,RCM(RCT)=RCER(RCM)
 . D STORERR(344.31,RCZ,.RCM)
 ;
 ; Many checks done by this are also done AUTOCHK2^RCDPEAP1 so if these are changed, 
 ; AUTOCHK2 may also need to be changed
 I RCMATCH D
 . S DIE="^RCY(344.31,",DA=RCZ,DR=".08////"_RCMATCH_";.1////"_RCRZ
 . D ^DIE
 . S DIE="^RCY(344.4,",DA=RCRZ,DR=".09////"_RCMATCH
 . D ^DIE
 . S ^TMP($J,"RCTOT","MATCH")=$G(^TMP($J,"RCTOT","MATCH"))+1
 . ;
 . ; Lines below are added for Auto-posting - PRCA*4.5*298
 . ; Quit if this is not nightly job
 . Q:'RCPROC
 . Q:+$P($G(^RCY(344.4,RCRZ,0)),U,5)=0       ; Quit if this is a zero value ERA
 . S NAM0=$$GET1^DIQ(344.4,RCRZ_",",.06,"E") ; PRCA*4.5*345 - Added line - Payer Name
 . S TIN0=$$GET1^DIQ(344.4,RCRZ_",",.03,"E") ; PRCA*4.5*345 - Added line - Payer TIN
 . S XX=$$GETPAY^RCDPEU1(NAM0,TIN0)          ; PRCA*4.5*345 - Get the IEN from 344.6
 . ;
 . ; Determine if ERA should be excluded using the site parameters
 . I $$CHKTYPE^RCDPEU1(XX,"T") S RCERATYP=2  ; PRCA*4.5*349 - Check if this is TRICARE ERA
 . E  S RCERATYP=$$PHARM^RCDPEAP1(RCRZ)      ; Else it must be a Medical or Rx ERA
 . S RCXCLDE=0
 . S:RCERATYP=0 RCXCLDE=$$EXCLUDE^RCDPEAP1(RCRZ)    ; PRCA*4.5*345 - Changed to =0 from 'RCERATYP
 . S:RCERATYP=1 RCXCLDE=$$EXCLDRX^RCDPEAP1(RCRZ)    ; PRCA*4.5*345 - Changed to =1 from RCERATYP
 . S:RCERATYP=2 RCXCLDE=$$EXCLDTR^RCDPEAP1(RCRZ)    ; PRCA*4.5*349 - Added Line
 . Q:RCXCLDE                                 ; Quit if the Payer is excluded from Auto-Post
 . ;
 . ; Ignore ERA with exceptions, zero balance, or ERA-level adjustments
 . Q:'$$AUTOCHK^RCDPEAP1(RCRZ)
 . ;
 . ; Set AUTO-POST STATUS = UNPOSTED this is trigger for auto-post (EN^RCDPEAP)
 . D SETSTA^RCDPEAP(RCRZ,0,"Auto Matching: Marked as Auto-Post Candidate")
 Q
 ;
ADDDEP(RCD,RCDDT,RCZ) ; Add deposit
 ; RCD = deposit #
 ; RCDDT = deposit date FM format
 ; RCZ = ien of entry in file 344.3
 ; Function returns IEN of new deposit entry
 ;
 N RCDEP,RC0,DIE,DR,DA,X,Y
 S RCDEP=+$$ADDDEPT^RCDPUDEP(RCD,RCDDT)
 I RCDEP D
 . D LOCKDEP^RCDPEM(RCDEP,1)
 . S RC0=$G(^RCY(344.3,RCZ,0))
 . S DIE="^RCY(344.1,",DA=RCDEP,DR=".04////"_+$P(RC0,U,8)_$S($P(RC0,U,4)'="":";.05////"_$P(RC0,U,4),1:"")  D ^DIE
 . S DIE="^RCY(344.3,",DR=".03////"_RCDEP,DA=RCZ D ^DIE
 . S $P(^TMP($J,"RCDPETOT",344.3,RCZ),U,5)=RCDEP
 Q RCDEP
 ;
ADDREC(RCDEP,RCZ) ; Add receipt, send CR to FUND 528704, Rev src cd 8NZZ
 ;   for total EFT amt
 ; RCDEP = IEN in AR DEPOSIT file (#344.1)
 ;   RCZ = IEN in EDI LOCKBOX DEPOSIT file (#344.3)
 ;    Function returns IEN of new receipt entry
 ;
 ; RCLOCK - flag indicating lock success
 ; RCTRANDA - transaction number
 ; RECTDA - IEN in file #344
 N RCER,RCLOCK,RCTRANDA,RECTDA,RCQUIT,RCDPDATA,RCTOTCT,RC0,DIE,DA,DR,X,Y
 S RC0=$G(^RCY(344.3,RCZ,0))
 S $P(^TMP($J,"RCDPETOT",344.3,RCZ),U,3)=0
 ; Single receipt - multiple transactions for EFT payments
 S RECTDA=+$$ADDRECT^RCDPUREC($P(RC0,U,7),RCDEP,+$O(^RC(341.1,"AC",14,0)))
 ; Create detail lines for deposit amount, process whole receipt to send
 ;   CR document for deposit amount
 I RECTDA D
 . L +^RCY(344,RECTDA):DILOCKTM S RCLOCK=$T Q:'RCLOCK  ; exit if unable to lock
 . N STATUS,RC00,RCT
 . S $P(^TMP($J,"RCDPETOT",344.3,RCZ),U)=RECTDA,^TMP($J,"RCTOT","EFT_RECPT")=$G(^TMP($J,"RCTOT","EFT_RECPT"))+1
 . ;  check to see if receipt has been processed (fms document)
 . D DIQ344^RCDPRPLM(RECTDA,"200;")
 . ;  code sheet already sent once, this is a retransmission, check it
 . I RCDPDATA(344,RECTDA,200,"E")'="" S RCQUIT=0 D  Q:RCQUIT
 .. S STATUS=$$STATUS^GECSSGET(RCDPDATA(344,RECTDA,200,"E"))
 .. ;  okay to continue if status is Error, Rejected, or not defined (-1)
 .. I $E(STATUS)="E"!($E(STATUS)="R")!(STATUS=-1) Q
 .. S RCER(1)=$$SETERR(2),RCER(2)="  Receipt already sent to FMS - No change"
 .. D BULL^RCDPEM1(344.3,RC0,.RCER)
 .. S $P(^TMP($J,"RCDPETOT",344.3,RCZ),U,4)=+$G(^TMP($J,"RCXM",0))
 .. D STORERR(344.3,RCZ,.RCER)
 .. L -^RCY(344,RECTDA)
 .. L -^RCY(344.1,RCDEP)
 .. S RCQUIT=1 K RCER
 . ;  mark receipt as processed (closed) to prevent editing
 . D MARKPROC^RCDPUREC(RECTDA,"")
 . S DIE="^RCY(344,",DR=".04////"_+$O(^RC(341.1,"AC",14,0)),DA=RECTDA D ^DIE ; Add EDI Lockbox payment type
 . ;
 . ; Add receipt line for each payer's EFT
 . S RCT=0 F  S RCT=$O(^RCY(344.31,"B",RCZ,RCT)) Q:'RCT  D  Q:$O(RCER(0))
 .. S RC00=$G(^RCY(344.31,RCT,0)),DR=""
 .. S RCTRANDA=$S('$P(RC00,U,14):$$ADDTRAN^RCDPURET(RECTDA),1:$P(RC00,U,14)) ; detail line
 .. I 'RCTRANDA D  Q
 ... S RCER(1)=$$SETERR(2),RCER(2)="  The receipt for the EFT deposit was not created correctly",RCER(3)="  You may have to add the detail manually to send the FMS CR doc to revenue"
 ... S RCER(4)="  source code 8NZZ in fund "_$S(DT<$$ADDPTEDT^PRCAACC():"5287.4",1:"528704")_".  Receipt # is "_$P($G(^RCY(344,RECTDA,0)),U),RCER(5)="  Trace # being processed at time of error was: "_$P(RC00,U,4)_"."
 ... D BULL^RCDPEM1(344.3,RC0,.RCER)
 ... S $P(^TMP($J,"RCDPETOT",344.3,RCZ),U,4)=+$G(^TMP($J,"RCXM",0))
 ... D STORERR(344.3,RCZ,.RCER)
 .. ;
 .. S DR=DR_";1.02////Auto added EDI Lockbox deposit;.06////"_$P(RC00,U,12)_";.04////"_$J(+$P(RC00,U,7),"",2)_";.14////"_RCTRANDA
 .. N N S N=+$O(^VA(200,"B","EDILOCKBOX,AUTOMATIC",0)) S:N=0 N=.5
 .. S DR=DR_";.12////"_N_";.29////"_$P(RC00,U,16) ;PRCA*4.5*375 - Add Debit/Credit Flag to Receipt Transactions
 .. S DA(1)=RECTDA,DA=RCTRANDA,DIE="^RCY(344,"_DA(1)_",1,"
 .. S:$E(DR)=";" DR=$P(DR,";",2,999) D ^DIE
 .. S DR=".14///"_RCTRANDA_";.09///"_RECTDA,DIE="^RCY(344.31,",DA=RCT D ^DIE
 .. ;
 . ;Post to FUND 528704/RSC 8NZZ
 . D PROCESS^RCDPURE1(RECTDA,2)
 . ;Save details for status report
 . N Z,TOT
 . S (TOT,Z)=0 F  S Z=$O(^RCY(344,RECTDA,1,Z)) Q:'Z  S TOT=TOT+$P($G(^RCY(344,RECTDA,1,Z,0)),U,4)
 . S $P(^TMP($J,"RCDPETOT",344.3,RCZ),U,2)=TOT
 . ;
 . I $P($G(^RCY(344,RECTDA,2)),U)="" D  ; Receipt not processed fully
 .. N CT,Z
 .. S RCER(1)=$$SETERR(2),RCER(2)="  The receipt "_$P($G(^RCY(344,RECTDA,0)),U)_" for the EFT deposit was not processed fully" S:TOT RCER(3)="  You must manually process it to create the FMS CR doc to rev src code 8NZZ"
 .. S Z=0,CT=+$O(RCER(" "),-1) F  S Z=$O(^TMP($J,"RCDPEMSG",Z)) Q:'Z  S CT=CT+1,RCER(CT)=$G(^TMP($J,"RCDPEMSG",Z))
 .. D BULL^RCDPEM1(344.3,RC0,.RCER)
 .. S $P(^TMP($J,"RCDPETOT",344.3,RCZ),U,4)=+$G(^TMP($J,"RCXM",0))
 .. D STORERR(344.3,RCZ,.RCER)
 . ;
 . S DIE="^RCY(344.3,",DR=".11////^S X=DT;.12////"_$J(+TOT,"",2),DA=RCZ D ^DIE
 . S ^TMP($J,"RCTOT","SUSPAMT")=$G(^TMP($J,"RCTOT","SUSPAMT"))+TOT
 . S $P(^TMP($J,"RCDPETOT",344.3,RCZ),U,3)="1"
 ;
 I 'RCLOCK,$G(RECTDA) D  ; couldn't get LOCK send MailMan message and store error
 .N RCBODY,XMINSTR,XMSUBJ,XMTO,XMZ
 .S RCBODY(1)=" > "_$$FMTE^XLFDT($$NOW^XLFDT,10)
 .S RCBODY(2)="An exception occurred during Lockbox processing."
 .S RCBODY(3)="Receipt "_$P($G(^RCY(344,RECTDA,0)),U)_" was not processed."
 .S RCBODY(4)="The ePayments software could not get exclusive access to the entry."
 .S XMSUBJ="EDI LBOX "_$$FMTE^XLFDT(DT,10)_" Receipt Not Processed"
 .S XMTO("I:G.RCDPE PAYMENTS")="",XMTO(DUZ)=""
 .S XMINSTR("FROM")="POSTMASTER"
 .D SENDMSG^XMXAPI(DUZ,XMSUBJ,"RCBODY",.XMTO,.XMINSTR,.XMZ)
 .I $G(RCZ) D STORERR(344.3,RCZ,.RCBODY)
 ;
 I RCLOCK L -^RCY(344,RECTDA)
 Q $S(RCLOCK:RECTDA,1:0)  ; return new IEN or zero if not processed
 ;
SETERR(RCPROC) ; Set up first line of error message to be stored
 ; RCPROC = 1 if called from EFT-EOB automatch, 0 if from manual match
 ;        = 2 if called from EFT deposit creation
 N LINE1
 I RCPROC S LINE1=$$FMTE^XLFDT($$NOW^XLFDT(),2)_" - PROCESS TO "_$S(RCPROC=1:"CREATE RECEIPT FROM ERA",1:"SEND EFT DEPOSIT TO FMS")
 Q LINE1
 ;
STORERR(RCFILE,RCZ,RCER) ; Store error text in word processing field
 ; RCFILE = 344.3 or 344.31
 ; RCZ = ien of the entry in file RCFILE
 ; RCER = array containing the error text (passed by ref)
 D WP^DIE(RCFILE,RCZ_",",2,"A","RCER")
 Q
 ;
