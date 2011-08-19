RCNRIG ;Washington IRMFO@Altoona, Pa/TJK-IG REPORTS ;6/17/96  11:37 AM
 ;;4.5;Accounts Receivable;**41,77,117,103,203,220,270**;Mar. 20, 1995;Build 25
 Q
 ;
 ;
QUEUE ;  queue extract
 W !,"QUEUE STATS PROGRAM"
 S ZTIO="",ZTRTN="EN2^RCNRIG",ZTDESC="AR OIG Transaction Extract",ZTDTH=$H
 D ^%ZTLOAD,^%ZISC
 Q
 ;
 ;
EN2 ;  called by routine rcrjr as part of the nightly process
 ;  this will generate the OIG extract of transactions on the 15th
 ;  day of each quarter
 L +^XTMP("RCNRIG")
 K ^XTMP("RCNRIG")
 S ^XTMP("RCNRIG",0)=DT_"^"_DT_"^OIG Transaction Extract"
 ;
 N B0,CNT,TRANS,BILL,TD,STDT,EDT,T0,T1,TT,FYQ,AMT,FUND,RSC
 D FYQ
 S STDT=$S(FYQ=1:1001,FYQ=2:"0101",FYQ=3:"0401",FYQ=4:"0701")
 S STDT=$S(FYQ=1:($E(DT,1,3)-1)_STDT,1:$E(DT,1,3)_STDT)
 S EDT=$E(STDT,1,3)_$S(FYQ=1:1231.9999,FYQ=2:"0331.9999",FYQ=3:"0630.9999",1:"0930.9999")
 S (CNT,TRANS)=0
 F  S TRANS=$O(^PRCA(433,TRANS)) Q:TRANS'?1N.N  D
    .S T1=$G(^PRCA(433,TRANS,1)),T0=$G(^(0))
    .S TD=$P(T1,U,9) Q:$S(TD<STDT:1,TD>EDT:1,1:0)
    .S BILL=$P(T0,U,2) S:'BILL B0="           ",FUND="      ",RSC="    "
    .S:BILL B0=$P($G(^PRCA(430,BILL,0)),U),B0=$E($$LJ^XLFSTR(B0,11),1,11)  ;WCJ;PRCA*4.5*270
    .S AMT=$P(T1,"^",5) S AMT=$$AMT(AMT)
    .S TT=+$P(T1,"^",2) S:'TT TT="                      "
    .S:TT TT=$G(^PRCA(430.3,TT,0)),TT=$E($P(TT,"^"),1,22),TT=$$LJ^XLFSTR(TT,22)
    .D:BILL
       ..S FUND=$$GETFUNDB^RCXFMSUF(BILL,1)
       ..S FUND=$$ADJFUND^RCRJRCO(FUND)
       ..S RSC=$$GETRSC
       ..S FUND=$J(FUND,6),RSC=$J(RSC,4)
    .S CNT=CNT+1
    .S ^XTMP("RCNRIG",CNT)=$J(TRANS,8)_AMT_B0_TT_FUND_RSC_"$"
    .Q
 D BUILD("T",FYQ,CNT)
 L -^XTMP("RCNRIG")
 Q
 ;
 ;
FYQ ;CALCULATE PREVIOUS FY QUARTER
 S FYQ=$E(DT,4,5),FYQ=$S(FYQ<4:1,FYQ<7:2,FYQ<10:3,1:4)
 Q
 ;
 ;
NOW() N X,Y,%,%H
 S %H=$H D YX^%DTC
 Q Y
 ;
 ;
BUILD(CODE,FYQ,CNT) ;BUILDS MESSAGE ARRAY
 N %Z,XCNP,XMDUZ,XMSCR,XMZ
 N MAX,CNTR,SEQ,REC,SITE
 S SITE=$$SITE^RCMSITE()
 S MAX=$S(CODE="B":350,1:500),(SEQ,CNTR)=0
 F CNTR=1:1:CNT D
    .D:CNTR#MAX=1
       ..K ^XTMP("RCNRIG","BUILD") S SEQ=SEQ+1
       ..S REC=0
       ..Q
    .S REC=REC+1,^XTMP("RCNRIG","BUILD",REC)=^XTMP("RCNRIG",CNTR)
    .S:CNTR=CNT ^XTMP("RCNRIG","BUILD",REC+1)="END OF TRANSMISSION FOR SITE# "_SITE_":  TOTAL RECORDS: "_CNT
    .I $S(CNTR=CNT:1,CNTR#MAX=0:1,1:0) D
       ..N XMY,XMSUB
       ..S XMY("XXX@Q-OIG.VA.GOV")="",XMDUZ="AR PACKAGE"
       ..S XMSUB=SITE_"/"_$S(CODE="B":"BILL",1:"TRANSACTION")_"/"_FYQ_"/SEQ#: "_SEQ_"/"_$$NOW()
       ..S XMTEXT="^XTMP(""RCNRIG"",""BUILD"","
       ..D ^XMD
       ..Q
    .Q
 Q
 ;
 ;
AMT(X) ;CONVERTS AMOUNT TO RIGHT JUSTIFIED, 0 FILLED
 S X=$J(X,0,2),X=$P(X,".")_$P(X,".",2)
 S X=$E("000000000",1,9-$L(X))_X
 Q X
 ;
 ;
GETRSC() ;  return the rsc for a bill
 I $E(FUND,1,4)'=5287,FUND'=4032 Q $P($G(^PRCA(430,BILL,11)),U,6)
 I FUND[5287,'$$PTACCT^PRCAACC(FUND) Q $P($G(^PRCA(430,BILL,11)),U,6)
 ;  check missing patient for reimbursable health insurance
 I $P(^PRCA(430,BILL,0),"^",2)=9,'$P(^PRCA(430,BILL,0),"^",7) Q "    "
 Q $$CALCRSC^RCXFMSUR(BILL)
