RCXFMSCR ;WISC/RFJ-fms cash receipt (cr) code sheet generator ;1 Oct 97
 ;;4.5;Accounts Receivable;**90,114,148,172,204,203,173,220,184**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
BUILDCR(RCRECTDA,RCGECSDA,RCEFT) ;  generate a cr/tr code sheet for a receipt
 ;  rcgecsda is the ien for the gcs stack file 2100.1 for rebuilds
 ;  rceft = 1 if processing CR for an EFT deposit (CR to rev src cd 8NZZ)
 ;        = 2 if processing TR for the receipt detail relating to an EFT
 ;              (TR from 528704/8NZZ to original fund/rsc)
 ;
 N AMOUNT,BILLDA,COUNT,CR2,DETAIL,DEPOSIT,DESCRIP,DOCTOTAL,FISCALYR,FMSTYPE,FUND,GECSFMS,LINE,RCDEPTDA,REVSRCE,TOTAL,TRANDA,TRANNUMB,UNAPPLY,UNAPPNUM,VENDORID,EFTDEP
 ;
 ;  build the lines for all payments on receipt
 S RCEFT=+$G(RCEFT)
 K ^TMP($J,"RCFMSCR")  ;  used for 215 report, not used here
 D FMSLINES^RCXFMSC1(RCRECTDA)
 K ^TMP($J,"RCFMSCR")
 ;
 ;  unapplied payments to accounts
 S TRANDA=0 F  S TRANDA=$O(^RCY(344,RCRECTDA,1,TRANDA)) Q:'TRANDA  D
 .   ;  dollars applied in AR
 .   I $P(^RCY(344,RCRECTDA,1,TRANDA,0),"^",5) Q
 .   ;  no dollars on transaction
 .   S AMOUNT=$P(^RCY(344,RCRECTDA,1,TRANDA,0),"^",4) I 'AMOUNT Q
 .   ;
 .   I RCEFT=1 S TOTAL("5287"_$S(DT<3030926:"",DT'<3030926&(DT<$$ADDPTEDT^PRCAACC()):".4",1:"04"),"8NZZ","MCCFVALUE")=$G(TOTAL("5287"_$S(DT<3030926:"",1:"04"),"8NZZ","MCCFVALUE"))+AMOUNT Q
 .   S UNAPPLY($$GETUNAPP(RCRECTDA,TRANDA,1))=AMOUNT
 ;
 ;  no code sheets to send
 I '$D(DETAIL),'$D(TOTAL),'$D(UNAPPLY) Q "-1^No code sheets to send for this receipt"
 ;
 ;  get the next common number in the series = station "-" nextnumber
 ;  use (field 200 in file 344) if document previously sent
 S TRANNUMB=$P($P($G(^RCY(344,RCRECTDA,2)),"^"),"-",2)
 I TRANNUMB="" S TRANNUMB=$$ENUM^RCMSNUM
 I TRANNUMB<0 Q "0^Unable to lookup next transaction number"
 ;  remove the dash (i,e, 460-K1A05HY)
 S TRANNUMB=$TR(TRANNUMB,"-")
 ;
 S FISCALYR=$$FY^RCFN01(DT)
 ;
 S COUNT=0,DOCTOTAL=0
 ;  build detail line
 S FMSTYPE="" F  S FMSTYPE=$O(DETAIL(FMSTYPE)) Q:FMSTYPE=""  D
 .   S BILLDA=0 F  S BILLDA=$O(DETAIL(FMSTYPE,BILLDA)) Q:'BILLDA  D
 .   .   S AMOUNT=DETAIL(FMSTYPE,BILLDA),DOCTOTAL=DOCTOTAL+AMOUNT
 .   .   S COUNT=COUNT+1
 .   .   S LINE(COUNT)="LIN^~CRA^"_$S($L(COUNT)=1:"00",$L(COUNT)=2:"0",1:"")_COUNT
 .   .   S $P(LINE(COUNT),"^",20)=$J(AMOUNT,0,2)
 .   .   S $P(LINE(COUNT),"^",21)="I"
 .   .   S $P(LINE(COUNT),"^",23)=FMSTYPE
 .   .   S $P(LINE(COUNT),"^",24)="BD"
 .   .   S $P(LINE(COUNT),"^",25)=$TR($P(^PRCA(430,BILLDA,0),"^"),"-")
 .   .   S $P(LINE(COUNT),"^",26)=$$LINE^RCXFMSC1(BILLDA)
 .   .   S $P(LINE(COUNT),"^",27)="~"
 ;
 ;  build summary line
 S FUND="" F  S FUND=$O(TOTAL(FUND)) Q:FUND=""  D
 .   S REVSRCE="" F  S REVSRCE=$O(TOTAL(FUND,REVSRCE)) Q:REVSRCE=""  D
 .   .   S VENDORID="" F  S VENDORID=$O(TOTAL(FUND,REVSRCE,VENDORID)) Q:VENDORID=""  D
 .   .   .   S AMOUNT=TOTAL(FUND,REVSRCE,VENDORID),DOCTOTAL=DOCTOTAL+AMOUNT
 .   .   .   S COUNT=COUNT+1
 .   .   .   S LINE(COUNT)="LIN^~CRA^"_$S($L(COUNT)=1:"00",$L(COUNT)=2:"0",1:"")_COUNT
 .   .   .   S $P(LINE(COUNT),"^",4)=$S(FUND=4032:"03",1:FISCALYR)
 .   .   .   S $P(LINE(COUNT),"^",4)=$S($E(FUND,1,4)=5287:"05",1:FISCALYR)
 .   .   .   S $P(LINE(COUNT),"^",6)=FUND
 .   .   .   S $P(LINE(COUNT),"^",7)=$E(TRANNUMB,1,3) ; station #
 .   .   .   S $P(LINE(COUNT),"^",10)=REVSRCE
 .   .   .   ;I FUND=4032 S $P(LINE(COUNT),"^",13)="24GX40100"
 .   .   .   S $P(LINE(COUNT),"^",18)=VENDORID
 .   .   .   S $P(LINE(COUNT),"^",20)=$J(AMOUNT,0,2)
 .   .   .   S $P(LINE(COUNT),"^",21)="I"
 .   .   .   S $P(LINE(COUNT),"^",23)=23
 .   .   .   S $P(LINE(COUNT),"^",24)="~"
 ;
 ;  build unapplied payment lines
 S UNAPPNUM="" F  S UNAPPNUM=$O(UNAPPLY(UNAPPNUM)) Q:UNAPPNUM=""  D
 .   S AMOUNT=UNAPPLY(UNAPPNUM),DOCTOTAL=DOCTOTAL+AMOUNT
 .   S COUNT=COUNT+1
 .   S LINE(COUNT)="LIN^~CRA^"_$S($L(COUNT)=1:"00",$L(COUNT)=2:"0",1:"")_COUNT
 .   S $P(LINE(COUNT),"^",4)=FISCALYR
 .   S $P(LINE(COUNT),"^",6)=3875
 .   S $P(LINE(COUNT),"^",7)=$E(TRANNUMB,1,3) ; station #
 .   S $P(LINE(COUNT),"^",20)=$J(AMOUNT,0,2)
 .   S $P(LINE(COUNT),"^",21)="I"
 .   S $P(LINE(COUNT),"^",23)=17
 .   S $P(LINE(COUNT),"^",24)="~CRB"
 .   S $P(LINE(COUNT),"^",32)=UNAPPNUM
 .   S $P(LINE(COUNT),"^",33)="~"
 ;
 ;  get data from file 344.1, the ar deposit file
 S RCDEPTDA=$P(^RCY(344,RCRECTDA,0),"^",6),DEPOSIT=$G(^RCY(344.1,RCDEPTDA,0))
 ;
 ;  build cr2, $p(deposit,^,3)=deposit date
 N FMSDT S FMSDT=$$FMSDATE^RCBEUTRA(DT)
 S CR2="CR2^"_$E(FMSDT,2,3)_"^"_$E(FMSDT,4,5)_"^"_$E(FMSDT,6,7)_"^^^^^^E^^^"
 S CR2=CR2_$P(DEPOSIT,"^")_"^^"_$J(DOCTOTAL,0,2)_"^^"
 S CR2=CR2_$E($P(DEPOSIT,"^",3),2,3)_"^"_$E($P(DEPOSIT,"^",3),4,5)_"^"_$E($P(DEPOSIT,"^",3),6,7)_"^~"
 ;
 ;  put together document in gcs
 N %DT,D,D0,DA,DI,DIC,DIE,DIQ2,DQ,DR
 S DESCRIP="Receipt: "_$P(^RCY(344,RCRECTDA,0),"^")
 I 'RCGECSDA D CONTROL^GECSUFMS("A",$E(TRANNUMB,1,3),TRANNUMB,"CR",10,0,"",DESCRIP)
 I RCGECSDA D REBUILD^GECSUFM1(RCGECSDA,"A",10,"N","Rebuild "_DESCRIP) S GECSFMS("DA")=RCGECSDA
 ;
 ;  store document in gcs
 D SETCS^GECSSTAA(GECSFMS("DA"),CR2)
 F COUNT=1:1 Q:'$D(LINE(COUNT))  D SETCS^GECSSTAA(GECSFMS("DA"),LINE(COUNT))
 D SETCODE^GECSSDCT(GECSFMS("DA"),"D RETN^RCFMFN02")
 D SETSTAT^GECSSTAA(GECSFMS("DA"),"Q")
 ;
 ;  add/update entry in file 347 for unprocessed document report
 N %DT,%X,D,DA347,D0,DI,DQ,DIC,ERROR,FMSDOCNO,X
 S FMSDOCNO="CR-"_$P(GECSFMS("CTL"),"^",9)
 S DA347=$O(^RC(347,"C",FMSDOCNO,0))
 ;  if not in the file, addit   fmsdocid   cr   id
 I 'DA347 D OPEN^RCFMDRV1(FMSDOCNO,3,"RC"_$P($G(^RCY(344,RCRECTDA,0)),"^"),.DA347,.ERROR)
 I DA347 D SSTAT^RCFMFN02(FMSDOCNO,1)
 ;
 ;  return 1 for success ^ fms document transaction number
 Q "1^"_FMSDOCNO
 ;
 ;
GETUNAPP(RCRECTDA,RCTRANDA,RCSTORE) ;  get unapplied deposit number for receipt
 ;  if $g(rcstore) store it with transaction
 N UNAPPNUM
 ;  if number is already assigned, use it
 I $P($G(^RCY(344,RCRECTDA,1,RCTRANDA,2)),"^",5)'="" Q $P(^(2),"^",5)
 ;
 S UNAPPNUM=$P(^RCY(344,RCRECTDA,0),"^")
 ;  if the receipt number is more than 9 characters, take the last 9
 I $L(UNAPPNUM)>9 S UNAPPNUM=$E(UNAPPNUM,$L(UNAPPNUM)-8,$L(UNAPPNUM))
 S UNAPPNUM=UNAPPNUM_$TR($J(RCTRANDA,4)," ",0)
 ;
 ;  store unapplied number
 I $G(RCSTORE) D SETUNAPP^RCDPURET(RCRECTDA,RCTRANDA,UNAPPNUM)
 ;
 Q UNAPPNUM
