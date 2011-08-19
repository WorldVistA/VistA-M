RCRJRCOC ;WISC/RFJ/BGJ-count current receivables ; 11/2/10 10:53am
 ;;4.5;Accounts Receivable;**156,170,182,203,220,138,239,272,273**;Mar 20, 1995;Build 3
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ; IA 4385 for call to $$MRATYPE^IBCEMU2
 Q
 ;
 ;
CURRENT(RCBILLDA,RCVALUE) ;  count current bills balance
 ;  rcvalue = prin ^ int ^ admin ^ mf ^ cc
 ;
 N %,RCFUND,RCRSC,RCTOHSIF,RCTOMCCF,SGL,TYPE,MRATYPE,ARACTDT,CATEGORY
 ;
 ;  calculate the rsc for the bill.  the rsc is only used for
 ;  mccf bills
 S RCRSC=""
 I $$ACCK^PRCAACC(RCBILLDA) S RCRSC=$$CALCRSC^RCXFMSUR(RCBILLDA)
 ;
 ;  calculate the amount that goes to mccf and hsif
 D MCCFHSIF(RCBILLDA,RCVALUE,RCRSC,DATEEND+1)
 ;
 ;  store the data for the ndb, if a 0 is returned by the function,
 ;  then the bill has already been counted as a current receivable,quit
 I '$$NDBSTORE(RCBILLDA,RCVALUE,1) Q
 ;
 ;  store results for FMS SV document for accrued bills only
 ;  do not include prepayments (26)
 I $$ACCK^PRCAACC(RCBILLDA),$P($G(^PRCA(430,RCBILLDA,0)),"^",2)'=26 D
 .   ;  get the bills fund and category
 .   S RCFUND=$$GETFUNDB^RCXFMSUF(RCBILLDA)
 .   S RCFUND=$$ADJFUND^RCRJRCO(RCFUND) ; may remove the line after 10/1/03
 .   S CATEGORY=+$P($G(^PRCA(430,RCBILLDA,0)),"^",2)
 .   ;
 .   ;  ----- this code is used to set up the SV code sheet -----
 .   S TYPE=21
 .   ;  special type for tort feasor
 .   I $E(RCRSC,1,2)=86!($E(RCRSC,1,2)="8S") S TYPE="2A"
 .   ;
 .   ;  Get ARACTDT=AR Date Active for bill
 .   S ARACTDT=+$P($P($G(^PRCA(430,RCBILLDA,6)),"^",21),".")
 .   ;  determine Receivable Type: 1=pre-MRA, 2=post-MRA Medicre, 3=post-MRA non-Medicare
 .   ;  DBIA #4385 activated on 31-Mar-2004
 .   S MRATYPE=$$MRATYPE^IBCEMU2(RCBILLDA,ARACTDT)
 .   ;  set TYPE to 2F for post-MRA Medicare bills or to 2L for
 .   ;  post-MRA non-Medicare bills (for RHI receivables only)
 .   I $E(RCRSC,1,2)=85!($E(RCRSC,1,2)="8R"),MRATYPE>1 S TYPE=$S(MRATYPE=2:"2F",1:"2L")
 .   ;
 .   ;  store dollars to mccf and hsif
 .   I RCTOMCCF S ^TMP($J,"RCRJRCOLSV",TYPE,RCFUND,RCRSC)=$G(^TMP($J,"RCRJRCOLSV",TYPE,RCFUND,RCRSC))+RCTOMCCF
 .   I RCTOHSIF S ^TMP($J,"RCRJRCOLSV",21,5358.1,$S(RCRSC="8BZZ":"8B1Z",1:"8C1Z"))=$G(^TMP($J,"RCRJRCOLSV",21,5358.1,$S(RCRSC="8BZZ":"8B1Z",1:"8C1Z")))+RCTOHSIF
 .   ;
 .   ;  ----- this code is used to build the user report
 .   S %=+$P($P($G(^PRCA(430,RCBILLDA,6)),"^",21),".")
 .   S ^TMP($J,"RCRJRCOLREPORT",%,RCBILLDA)=$P(RCVALUE,"^")_"^"_($P(RCVALUE,"^",2)+$P(RCVALUE,"^",3)+$P(RCVALUE,"^",4)+$P(RCVALUE,"^",5))_"^SV"_TYPE
 .   ;
 .   ;  ----- this code is used to build the OIG extract, piece 3 = GL acct
 .   S ^TMP($J,"RCRJROIG",RCBILLDA)=$P(RCVALUE,"^")_"^"_($P(RCVALUE,"^",2)+$P(RCVALUE,"^",3)+$P(RCVALUE,"^",4)+$P(RCVALUE,"^",5))_"^"_$S(TYPE="2A":1333,TYPE="2F":"13H1",TYPE="2L":"13N1",1:1311)
 .   ;
 .   ;  ----- this code is used to set up medicare supplemental SVs
 .   S %=$G(^PRCA(430,RCBILLDA,13))
 .   ;  medicare contract adjustment field 131 for bills activated in AR during the month the ARDC is running
 .   I $P(%,"^",1),ARACTDT'<DATEBEG D  ;
 .   .   S ^TMP($J,"RCRJRCOLSV",17)=$G(^TMP($J,"RCRJRCOLSV",17))+$P(%,"^",1)
 .   .   S ^TMP($J,"RCRJRCOLSV",17,RCFUND,RCRSC)=$G(^TMP($J,"RCRJRCOLSV",17,RCFUND,RCRSC))+$P(%,"^",1)
 .   ;  medicare unreimbursable medicare expense field 132 for bills activated in AR during the month the ARDC is running
 .   I $P(%,"^",2),ARACTDT'<DATEBEG D  ;
 .   .   S ^TMP($J,"RCRJRCOLSV",18)=$G(^TMP($J,"RCRJRCOLSV",18))+$P(%,"^",2)
 .   .   S ^TMP($J,"RCRJRCOLSV",18,RCFUND,RCRSC)=$G(^TMP($J,"RCRJRCOLSV",18,RCFUND,RCRSC))+$P(%,"^",2)
 .   ;
 .   ;  ----- this code is used to set up the bad debt report -----
 .   S SGL=$$BDRSGL^RCRJRBD(CATEGORY,RCFUND,MRATYPE)
 .   ;  store dollars to mccf and hsif.  both are sgl 1319 so 1319.1 is
 .   ;  used to put hsif in a subset of 1319
 .   I RCTOMCCF S ^TMP($J,"RCRJRBD",SGL)=$G(^TMP($J,"RCRJRBD",SGL))+RCTOMCCF
 .   I RCTOHSIF S ^TMP($J,"RCRJRBD",1319.1)=$G(^TMP($J,"RCRJRBD",1319.1))+RCTOHSIF
 ;
 ;  store the interest, admin, mf, cc on the SV code sheet
 ;  interest (type P2; fund 1435; rsc 8047)
 I $P(RCVALUE,"^",2) S ^TMP($J,"RCRJRCOLSV","P2",1435,8047)=$G(^TMP($J,"RCRJRCOLSV","P2",1435,8047))+$P(RCVALUE,"^",2)
 ;  admin (type P2; fund 3220; rsc 8046)
 I $P(RCVALUE,"^",3) S ^TMP($J,"RCRJRCOLSV","P2",3220,8046)=$G(^TMP($J,"RCRJRCOLSV","P2",3220,8046))+$P(RCVALUE,"^",3)
 ;  mf + cc (type P2; fund 0869; rsc 8048)
 S %=$P(RCVALUE,"^",4)+$P(RCVALUE,"^",5)
 I % S ^TMP($J,"RCRJRCOLSV","P2","0869",8048)=$G(^TMP($J,"RCRJRCOLSV","P2","0869",8048))+%
 Q
 ;
 ;
WRITEOFF(RCBILLDA,RCVALUE,RCRITER2) ;  count write offs
 ;  rcvalue = prin ^ int ^ admin ^ mf ^ cc
 ;  rcriter2 = write off criteria tracked in ndb
 ;
 N %,RCFUND,RCRSC,RCTOHSIF,RCTOMCCF,TYPE,MRATYPE,ARACTDT
 ;
 ;  calculate the rsc for the bill.  the rsc is only used for
 ;  mccf bills
 S RCRSC=""
 I $$ACCK^PRCAACC(RCBILLDA) S RCRSC=$$CALCRSC^RCXFMSUR(RCBILLDA)
 ;
 ;  calculate the amount that goes to mccf and hsif
 D MCCFHSIF(RCBILLDA,RCVALUE,RCRSC,DATEEND+1)
 ;
 ;  store the data for the ndb, if a 0 is returned by the function,
 ;  then the bill has already been counted as a current receivable,quit
 I '$$NDBSTORE(RCBILLDA,RCVALUE,RCRITER2) Q
 ;
 ;  store results for FMS WR document
 ;  do not include prepayments (26)
 I $$ACCK^PRCAACC(RCBILLDA),$P($G(^PRCA(430,RCBILLDA,0)),"^",2)'=26 D
 .   ;  get the bills fund
 .   S RCFUND=$$GETFUNDB^RCXFMSUF(RCBILLDA)
 .   S RCFUND=$$ADJFUND^RCRJRCO(RCFUND) ; may remove the line after 10/1/03
 .   ;
 .   S TYPE=37
 .   ;  special type for tort feasor
 .   I $E(RCRSC,1,2)=86!($E(RCRSC,1,2)="8S") S TYPE=39
 .   S ARACTDT=+$P($P($G(^PRCA(430,RCBILLDA,6)),"^",21),".")
 .   ;  DBIA #4385 activated on 31-Mar-2004
 .   S MRATYPE=$$MRATYPE^IBCEMU2(RCBILLDA,ARACTDT)
 .   ;  for contract adjustments (criter2=20), the type is 38 for pre-
 .   ;  MRA, 4N for post-MRA non-Medicare and 08 for post-MRA Medicare
 .   I RCRITER2=20 S TYPE=$S(MRATYPE=1:38,MRATYPE=2:"08",1:"4N")
 .   ;  store dollars to mccf and hsif
 .   I RCTOMCCF S ^TMP($J,"RCRJRCOLWR",TYPE,RCFUND,RCRSC)=$G(^TMP($J,"RCRJRCOLWR",TYPE,RCFUND,RCRSC))+RCTOMCCF
 .   I RCTOHSIF S ^TMP($J,"RCRJRCOLWR",TYPE,5358.1,$S(RCRSC="8BZZ":"8B1Z",1:"8C1Z"))=$G(^TMP($J,"RCRJRCOLWR",TYPE,5358.1,$S(RCRSC="8BZZ":"8B1Z",1:"8C1Z")))+RCTOHSIF
 ;
 ;  store the interest, admin, mf, cc on the WR code sheet
 ;  interest (type P4; fund 1435; rsc 8047)
 I $P(RCVALUE,"^",2) S ^TMP($J,"RCRJRCOLWR","P4",1435,8047)=$G(^TMP($J,"RCRJRCOLWR","P4",1435,8047))+$P(RCVALUE,"^",2)
 ;  admin (type P4; fund 3220; rsc 8046)
 I $P(RCVALUE,"^",3) S ^TMP($J,"RCRJRCOLWR","P4",3220,8046)=$G(^TMP($J,"RCRJRCOLWR","P4",3220,8046))+$P(RCVALUE,"^",3)
 ;  mf + cc (type P4; fund 0869; rsc 8048)
 S %=$P(RCVALUE,"^",4)+$P(RCVALUE,"^",5)
 I % S ^TMP($J,"RCRJRCOLWR","P4","0869",8048)=$G(^TMP($J,"RCRJRCOLWR","P4","0869",8048))+%
 Q
 ;
 ;
NDBSTORE(RCBILLDA,RCVALUE,RCRITER2) ;  store the data for the NDB
 ;  returns a 1 if the bill has not been counted
 ;  returns a 0 if the bill has been counted
 N %,CRITERIA
 ;
 ;  this line of code will prevent duplicate counts if a sites cross
 ;  references in file 430 (actdt and asdt) are duplicated (incorrect)
 I RCRITER2<13,$D(^TMP($J,"RCRJRCOL","COUNT",RCBILLDA,RCRITER2)) Q 0
 ;
 ;  get a bills criteria 1,3,4,5
 S CRITERIA=$G(^TMP($J,"RCRJRCOL","CRITERIA",RCBILLDA))
 I CRITERIA="" S CRITERIA=$$CRITERIA^RCRJRCOL(RCBILLDA),^TMP($J,"RCRJRCOL","CRITERIA",RCBILLDA)=CRITERIA
 S $P(CRITERIA,"-",2)=RCRITER2
 ;
 ;  store results for ndb
 S %=$G(@DATASTOR)
 S $P(%,"^")=$P(%,"^")+1
 S $P(%,"^",2)=$P(%,"^",2)+$P(RCVALUE,"^")
 S $P(%,"^",3)=$P(%,"^",3)+$P(RCVALUE,"^",2)+$P(RCVALUE,"^",3)+$P(RCVALUE,"^",4)+$P(RCVALUE,"^",5)
 S @DATASTOR=%
 ;
 ;  keep a count of current receivables counted
 S ^TMP($J,"RCRJRCOL","COUNT",RCBILLDA,RCRITER2)=""
 S ^TMP($J,"RCRJRCOL","CRIT2",RCRITER2,RCBILLDA)=""
 Q 1
 ;
 ;
MCCFHSIF(RCBILLDA,RCVALUE,RCRSC,ASOFDATE) ;  calculate the amount that goes
 ;
 ;  to mccf and hsif
 ;
 ;  returns RCTOMCCF and RCTOHSIF as the outstanding balance to mccf
 ;  and the outstanding balance to hsif
 N MCCFHSIF
 ;
 S RCTOMCCF=$P(RCVALUE,"^"),RCTOHSIF=0
 ;
 I $$NOHSIF^RCRJRCO() Q  ; disabled HSIF
 ;
 ; if revenue source code is not 8BZZ or 8CZZ then it all goes to mccf
 I RCRSC="8BZZ"!(RCRSC="8CZZ") D
 .   ;  get the amount for each fund mccf and hsif
 .   ;  this call returns the total amount owed to mccf (piece 1),
 .   ;  total amount owed to hsif (piece 2), total amount paid
 .   ;  to mccf (piece 3), total amount paid to hsif (piece 4).
 .   ;  for outstanding balance you must subtract the payment in
 .   ;  pieces 3 and 4 which are returned as negative amounts.
 .   S MCCFHSIF=$$BILLFUND^RCBMILLC(RCBILLDA,ASOFDATE)
 .   S RCTOMCCF=$P(MCCFHSIF,"^",1)+$P(MCCFHSIF,"^",3)
 .   S RCTOHSIF=$P(MCCFHSIF,"^",2)+$P(MCCFHSIF,"^",4)
 Q
