RCXFMST1 ;ALB/TMK-EDI Lockbox fms transfer (tr) cd sht gen ;31 Mar 03
 ;;4.5;Accounts Receivable;**173,220,184,238**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
GETTR(RCRECTDA,RCGECSDA) ;  extract transfer data for TR code sheet for
 ;  a receipt in rcrectda
 ;  rcgecsda is the ien for the gcs stack file 2100.1 for rebuilds
 ;
 N TRANDA,AMOUNT,DETAIL,UNAPPLY,TOTAL,RCTOTAL,FUND,REVSRCE,VENDORID,RCSEQ,RESULT,GECSDATA,RCTRANS,UNAPPNUM,TRANNUMB
 ;
 ;  extract all payments on receipt
 S RESULT=""
 K ^TMP($J,"RCFMSCR")  ;  used for 215 report, not used here
 D FMSLINES^RCXFMSC1(RCRECTDA,1)
 K ^TMP($J,"RCFMSCR")
 ;
 ;  unapplied payments to accounts
 S TRANDA=0 F  S TRANDA=$O(^RCY(344,RCRECTDA,1,TRANDA)) Q:'TRANDA  D
 .   ;  dollars applied in AR
 .   I $P(^RCY(344,RCRECTDA,1,TRANDA,0),U,5) Q
 .   ;  no dollars on transaction
 .   S AMOUNT=$P(^RCY(344,RCRECTDA,1,TRANDA,0),U,4) I 'AMOUNT Q
 .   ;
 .   S UNAPPLY($$GETUNAPP^RCXFMSCR(RCRECTDA,TRANDA,1))=AMOUNT
 ;
 ;  no code sheets to send
 I '$D(DETAIL),'$D(TOTAL),'$D(UNAPPLY) S RESULT="-1^No code sheets to send for this receipt" G QUIT
 ;
 ;  get the next common number in the series = station "-" nextnumber
 ;  use (field 200 in file 344) if document previously sent
 S TRANNUMB=$P($P($G(^RCY(344,RCRECTDA,2)),U),"-",2)
 I TRANNUMB="" S TRANNUMB=$$ENUM^RCMSNUM
 I TRANNUMB<0 S RESULT="0^Unable to lookup next transaction number" G QUIT
 ;  remove the dash (i,e, 460-K1A05HY)
 S TRANNUMB=$TR(TRANNUMB,"-")
 ;
 ;  extract transfer from/to array for applied payments
 S (RCTOTAL,RCSEQ)=0
 S FUND="" F  S FUND=$O(TOTAL(FUND)) Q:FUND=""  D
 .   S REVSRCE="" F  S REVSRCE=$O(TOTAL(FUND,REVSRCE)) Q:REVSRCE=""  D
 .   .   S VENDORID="" F  S VENDORID=$O(TOTAL(FUND,REVSRCE,VENDORID)) Q:VENDORID=""  D
 .   .   .   S RCSEQ=RCSEQ+1,RCTRANS($$TRFUND(),"8NZZ",RCSEQ)=FUND_U_REVSRCE_U_TOTAL(FUND,REVSRCE,VENDORID)_U_U_VENDORID
 ;
 ;  extract unapplied payments
 S UNAPPNUM="" F  S UNAPPNUM=$O(UNAPPLY(UNAPPNUM)) Q:UNAPPNUM=""  D
 .   S RCSEQ=RCSEQ+1,RCTRANS($$TRFUND(),"8NZZ",RCSEQ)=3875_U_U_UNAPPLY(UNAPPNUM)_U_UNAPPNUM
 ;
 ;  build the TR document
 S RESULT=$$BUILDTR(.RCTRANS,.DETAIL,+$G(GECSDATA),TRANNUMB,RCRECTDA)
 ;
QUIT Q RESULT
 ;
BUILDTR(RCTRANS,RCDETAIL,RCGECSDA,TRANNUMB,RCRECTDA) ;  generate a tr code
 ;  sheet for transferring dollars out of 528704/8NZZ
 ;
 ;  rctrans(fund,rsc,seq) = data array passed
 ;    fund=fund to transfer from (always 528704)
 ;    rsc = rsc to transfer from (always 8NZZ)
 ;    seq = sequence to make record unique for each 'transferred to' rsc
 ;    data = fund to transfer to (piece 1)
 ;           rsc  to transfer to (piece 2)
 ;           dollars to transfer (piece 3)
 ;           unapplied deposit # for suspense (fund to transfer to=3875)
 ;           vendor id (piece 5)
 ;
 ;  rcgecsda is the ien for the gcs stack file 2100.1 for rebuilds
 ;
 ;  trannumb is the document identifier
 ;
 ;  rcrectda is the ien of the receipt (file 344)
 ;
 ;  rcdetail array contains accrual data for BD transactions
 ;
 N COUNT,DATA,DESCRIP,FISCALYR,FUND,GECSFMS,LINE,REVSRCE,TR2,X,Y,RCSUSP,BILLDA,FMSTYPE,AMOUNT,RCSEQ
 ;
 S FISCALYR=$$FY^RCFN01(DT)
 ;
 ;  build detail lines
 S COUNT=0
 ;
 S FMSTYPE="" F  S FMSTYPE=$O(RCDETAIL(FMSTYPE)) Q:FMSTYPE=""  D
 .   S BILLDA=0 F  S BILLDA=$O(RCDETAIL(FMSTYPE,BILLDA)) Q:'BILLDA  D
 .    .   S AMOUNT=RCDETAIL(FMSTYPE,BILLDA)
 .    . ; Decrease from 528704/8NZZ
 .    .   S COUNT=COUNT+1
 .    .   S LINE(COUNT)=$$DEC(COUNT,FISCALYR,TRANNUMB,AMOUNT)
 .    . ; Send BD
 .    .   S COUNT=COUNT+1
 .    .   S LINE(COUNT)="LIN^~CRA^"_$S($L(COUNT)=1:"00",$L(COUNT)=2:"0",1:"")_COUNT
 .    .   S $P(LINE(COUNT),U,20)=$J(AMOUNT,0,2)
 .    .   S $P(LINE(COUNT),U,21)="I"
 .    .   S $P(LINE(COUNT),U,23)=$S(FMSTYPE'=75:FMSTYPE,$$GETFUNDB^RCXFMSUF(BILLDA,1)["5287":33,1:75)
 .    .   S $P(LINE(COUNT),U,24)="BD"
 .    .   S $P(LINE(COUNT),U,25)=$TR($P(^PRCA(430,BILLDA,0),U),"-")
 .    .   S $P(LINE(COUNT),U,26)=$$LINE^RCXFMSC1(BILLDA)
 .    .   S $P(LINE(COUNT),U,27)="~"
 .    ;
 ;
 S FUND=$$TRFUND(),REVSRCE="8NZZ"
 S RCSEQ=0 F  S RCSEQ=$O(RCTRANS(FUND,REVSRCE,RCSEQ)) Q:'RCSEQ  D
 .   S DATA=RCTRANS(FUND,REVSRCE,RCSEQ)
 .   ;  if no value, quit
 .   I '$P(DATA,U,3) Q
 .   ;
 .   ;  create line to transfer from (decrease)
 .   S COUNT=COUNT+1
 .   S LINE(COUNT)=$$DEC(COUNT,FISCALYR,TRANNUMB,$P(DATA,U,3))
 .   ;
 .   ;  create line to transfer to (increase)
 .   S COUNT=COUNT+1
 .   S RCSUSP=($P(DATA,U)=3875)
 .   S LINE(COUNT)="LIN^~CRA^"_$S($L(COUNT)=1:"00",$L(COUNT)=2:"0",1:"")_COUNT
 .   S $P(LINE(COUNT),U,4)=FISCALYR
 .   S $P(LINE(COUNT),U,4)=$S($E(FUND,1,4)=5287:"05",1:FISCALYR)
 .   S $P(LINE(COUNT),U,6)=$P(DATA,U)
 .   S $P(LINE(COUNT),U,7)=$E(TRANNUMB,1,3) ; station #
 .   I 'RCSUSP S $P(LINE(COUNT),U,10)=$P(DATA,U,2)
 .   ;
 .   ;  vendor id
 .   I 'RCSUSP S $P(LINE(COUNT),U,18)=$P(DATA,U,5)
 .   ;
 .   S $P(LINE(COUNT),U,20)=$J($P(DATA,U,3),0,2)
 .   S $P(LINE(COUNT),U,21)="I"
 .   S $P(LINE(COUNT),U,23)=$S('RCSUSP:33,1:24)
 .   S $P(LINE(COUNT),U,24)=$S('RCSUSP:"~",1:"~CRB")
 .   I RCSUSP D
 .   .   S $P(LINE(COUNT),U,32)=$P(DATA,U,4)
 .   .   S $P(LINE(COUNT),U,33)="~"
 ;
 ;  build tr2
 N FMSDT S FMSDT=$$FMSDATE^RCBEUTRA(DT)
 S TR2="CR2^"_$E(FMSDT,2,3)_U_$E(FMSDT,4,5)_U_$E(FMSDT,6,7)_"^^^^^^E^^^"
 ;  deposit number which is equal to the gcs id
 ;  $j(0,0,2) is the document total which is zero
 S TR2=TR2_$P(TRANNUMB,U)_"^^"_$J(0,0,2)_"^^"
 ;  deposit/transfer date
 S TR2=TR2_$E(DT,2,3)_U_$E(DT,4,5)_U_$E(DT,6,7)_"^~"
 ;
 ;  put together document in gcs
 N D0,DA,DI,DIC,DIE,DIQ2,DQ,DR
 S DESCRIP="EDI Lockbox Detail Receipt: "_$P(^RCY(344,RCRECTDA,0),U)
 I 'RCGECSDA D CONTROL^GECSUFMS("A",$E(TRANNUMB,1,3),TRANNUMB,"TR",10,0,"",DESCRIP)
 I RCGECSDA D REBUILD^GECSUFM1(RCGECSDA,"A",10,"N","Rebuild "_DESCRIP) S GECSFMS("DA")=RCGECSDA
 ;
 ;  store document in gcs
 D SETCS^GECSSTAA(GECSFMS("DA"),TR2)
 F COUNT=1:1 Q:'$D(LINE(COUNT))  D SETCS^GECSSTAA(GECSFMS("DA"),LINE(COUNT))
 D SETCODE^GECSSDCT(GECSFMS("DA"),"D RETN^RCFMFN02")
 D SETSTAT^GECSSTAA(GECSFMS("DA"),"Q")
 ;
 ;  add/update entry in file 347 for unprocessed document report
 N %DT,%X,D,DA347,D0,DI,DQ,DIC,ERROR,FMSDOCNO,X
 S FMSDOCNO="TR-"_$P(GECSFMS("CTL"),U,9)
 S DA347=$O(^RC(347,"C",FMSDOCNO,0))
 ;  if not in the file, addit   fmsdocid   tr   id
 I 'DA347 D OPEN^RCFMDRV1(FMSDOCNO,9,"TR-"_$P($G(^RCY(344,RCRECTDA,0)),U),.DA347,.ERROR)
 I DA347 D SSTAT^RCFMFN02(FMSDOCNO,1)
 ;
 ;  return 1 for success ^ fms document id
 Q 1_"^TR-"_$P(GECSFMS("CTL"),U,9)
 ;
 ;
DEC(COUNT,FISCALYR,TRANNUMB,AMOUNT) ; Add decrease from 528704/8NZZ
 ; Returns LINE with decrease TR info
 ; FISCALYR/TRANNUMB from above
 ; COUNT = line counter
 ; AMOUNT = amount to be transferred
 ;
 S LINE="LIN^~CRA^"_$S($L(COUNT)=1:"00",$L(COUNT)=2:"0",1:"")_COUNT
 S $P(LINE,U,4)=FISCALYR
 S $P(LINE,U,6)=$$TRFUND()
 S $P(LINE,U,4)=$S($E($P(LINE,U,6),1,4)=5287:"05",1:FISCALYR)
 S $P(LINE,U,7)=$E(TRANNUMB,1,3) ; station #
 S $P(LINE,U,10)="8NZZ"
 ;
 ;  vendor id
 S $P(LINE,U,18)="MCCFVALUE"
 S $P(LINE,U,20)=$J(AMOUNT,0,2)
 S $P(LINE,U,21)="D"
 S $P(LINE,U,23)=33
 S $P(LINE,U,24)="~"
 Q LINE
 ;
TRFUND() ; Determine if fund should be 5287 or 528704, based on date
 I DT<3030926 Q 5287
 I DT<$$ADDPTEDT^PRCAACC() Q 5287.4
 Q 528704
 ;
