RCJIBFN2 ;WASH-ISC@ALTOONA,PA/NYB-FUNC. CALLS FOR JOINT IB/AR ;10/12/95  8:34 AM ; 7/19/96  1:38 PM
V ;;4.5;Accounts Receivable;**15,50,59,69,63**;Mar 20, 1995
TRAN(RCTYNO) ;Pass IFN from 430.3 - returns the transaction type from file 430.3
 N TRAN
 I '$G(RCTYNO) S TRAN="" G TRANQ
 S TRAN=$P($G(^PRCA(430.3,RCTYNO,0)),"^")
TRANQ Q TRAN
 ;
STNO(RCTYNO) ;Pass IFN for 430.3 - returns pieces of the 0 node 430.3 where
 ;$P1=Name,$P2=Abbreviation,$P3=Status Number
 N SNDE,STNO,STRG
 I '$G(RCTYNO) S STRG="" G STNOQ
 S SNDE=$G(^PRCA(430.3,+RCTYNO,0)) I SNDE="" S STRG="" G STNOQ
 S STRG=$P($G(SNDE),"^")_"^"_$P($G(SNDE),"^",2)_"^"_$P($G(SNDE),"^",3)
STNOQ Q STRG
 ;
STAT(BN) ;Pass in IFN for 430 - returns the IFN for status file 430.3
 N STAT
 I '$G(BN) S STAT="" G STATQ
 S STAT=+$P($G(^PRCA(430,BN,0)),"^",8)
STATQ Q STAT
 ;
TRN(BN) ;Pass in IFN for 430 - returns ^TMP array with all transaction
 ;for a bill where I is the transaction number in 433 and
 ;$P1=Transaction Number,$P2=Transaction Date,$P3=Transaction Type
 ;$P4=Transaction Amount,$P5=Amount Due after transaction applied
 ;(Current Balance),$P6=Transaction Comment
 ;Caller must kill ^TMP array
 N BAL,CAT,I,N1,N8,TAMT,TTY
 I '$G(BN) G TRNQ
 K ^TMP("RCJIB",$J)
 S CAT=$$CAT^PRCAFN(BN)
 S BAL=+$P($$BILL(BN),"^")
 S I=0 F  S I=$O(^PRCA(433,"C",BN,I)) Q:'I  D
    .S N1=$G(^PRCA(433,I,1)),TTY=$P($G(N1),"^",2)
    .S TAMT=$P($G(N1),"^",5)
    .I ",2,8,9,10,11,14,19,47,34,35,29,"[(","_TTY_",") I TAMT'<0 S TAMT=-TAMT
    .I ",2,8,9,10,11,14,19,47,34,35,29,"'[(","_TTY_",") I TAMT<0 S TAMT=-TAMT
    .S N8=$G(^PRCA(433,I,8))
    .I +CAT=33,TTY=1 I TAMT<0 S TAMT=-TAMT
    .I +CAT=33,TTY=35 I TAMT>0 S TAMT=-TAMT
    .I TTY>2,(TTY<7)!(TTY=25) S TAMT=0
    .S BAL=BAL+TAMT
    .S ^TMP("RCJIB",$J,I)=$P($G(^PRCA(433,I,0)),"^")_"^"_$P($G(N1),"^")_"^"_$P($G(N1),"^",2)_"^"_$P($G(N1),"^",5)_"^"_BAL_"^"_$P($G(N8),"^",6)
    .Q
TRNQ Q
 ;
BILL(BN) ;Pass in IFN for 430 - Returns pieces of the 0 node of 430
 ;and pieces of calculated from file 433 where
 ;$P1=Orginal Amount,$P2=Current Status,$P3=Current Balance
 ;$P4=Total Collected,$P5=% Collected
 N BAL,BN0,CST,I,PAY,PER,STRG,TP
 I '$G(BN) S STRG="" G BILLQ
 S BN0=$G(^PRCA(430,BN,0)) I '$G(BN0) S STRG="" G BILLQ
 S CST=$P($G(BN0),"^",8)
 S BAL=$G(^PRCA(430,BN,7)),BAL=$P(BAL,"^")+$P(BAL,"^",2)+$P(BAL,"^",3)+$P(BAL,"^",4)+$P(BAL,"^",5)
 I CST=26 S BAL=0
 I '$G(BN) S STRG="" G TRNQ
 S (I,TP)=0 F  S I=$O(^PRCA(433,"C",BN,I)) Q:'I  D
    .S PAY=$P($G(^PRCA(433,I,1)),"^",2)
    .I $G(PAY)=2!($G(PAY)=34) S TP=TP+$P($G(^PRCA(433,I,1)),"^",5)
    .Q
 S PER="" I '$P($G(BN0),"^",3)=0 S PER=TP/($P($G(BN0),"^",3))*100
 S STRG=$P($G(BN0),"^",3)_"^"_CST_"^"_BAL_"^"_TP_"^"_PER
BILLQ Q STRG
 ;
BCOM(BN) ;Pass in IFN for 430 - Returns COM where $P1=Person who audited and
 ;$P2=Date audited and COM array where COM(I) is the audit comments
 ;Caller must kill COM ARRAY
 N FL,I
 I '$G(BN) S COM="" G BCOMQ
 S COM="",(FL,I)=0 F  S I=$O(^PRCA(430,BN,10,I)) Q:I=""  D
    .S FL=1,COM(I)=$P($G(^PRCA(430,BN,10,I,0)),"^")
    .Q
 I FL S COM=$P($G(^PRCA(430,BN,9)),"^")_"^"_$P($G(^PRCA(430,BN,9)),"^",3)
BCOMQ Q
 ;
DIQ(DA,DR,RCDIQ) ;Return File 430 data from Fileman
 ;DA - IEN, DR - File 430 fields, RCDIQ - Array name
 N D0,DIC,DIQ,DIQ2
 I ($G(^PRCA(430,DA,0))="")!(DR="")!(RCDIQ="") G DIQQ
 S DIQ(0)="IE",DIC="^PRCA(430,",DIQ=RCDIQ
 D EN^DIQ1
DIQQ Q
 ;
 ;RCJIBFN2
