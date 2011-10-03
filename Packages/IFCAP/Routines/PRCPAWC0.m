PRCPAWC0 ;WISC/RFJ-adjustment code sheets create and trans ;9.9.97
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
CODESHTS(INVPT,TRANID)       ;  create and transmit code sheets
 ;  for invpt and transaction register id
 N %,%H,%X,%Y,ACCT,DA,DATA,INVVALUE,ISMSCNT,ISMSFLAG,ITEMDA,NSN,PRCPXMZ,QSIGN,QTY,SELVALUE,STRING,VOUCHER,VSIGN
 S ISMSFLAG=$$ISMSFLAG^PRCPUX2(PRC("SITE"))
 K ^TMP($J,"PRCPAWN1")
 S ISMSCNT=0
 S DA=0 F  S DA=$O(^PRCP(445.2,"T",INVPT,TRANID,DA)) Q:'DA  S DATA=$G(^PRCP(445.2,DA,0)) I DATA'="" D
 .   I '$D(VOUCHER),$L($P(DATA,"^",15)) S VOUCHER=$P(DATA,"^",15)
 .   S ITEMDA=+$P(DATA,"^",5) I 'ITEMDA Q
 .   S NSN=$$NSN^PRCPUX1(ITEMDA),ACCT=$$ACCT1^PRCPUX1($E(NSN,1,4))
 .   S QTY=+$P(DATA,"^",7),INVVALUE=+$P(DATA,"^",22),SELVALUE=+$P(DATA,"^",23)
 .   I ISMSFLAG=2 D ISMS Q
 .   D LOG
 ;
 ;  transmit isms code sheets
 I ISMSFLAG=2,ISMSCNT D
 .   K ^TMP($J,"STRING")
 .   S %X="^TMP("_$J_",""PRCPAWN1"",",%Y="^TMP("_$J_",""STRING""," D %XY^%RCR
 .   D CODESHT^PRCPSMGO(PRC("SITE"),"ADJ",VOUCHER)
 ;
 ;  transmit log code sheets to isms
 I ISMSFLAG'=2,ISMSCNT D
 .   K ^TMP($J,"STRING")
 .   S %X="^TMP("_$J_",""PRCPAWN1"",",%Y="^TMP("_$J_",""STRING""," D %XY^%RCR
 .   D TRANSMIT^PRCPSMCL(PRC("SITE"),605,"LOG")
 .   W !!?4,"LOG 605 Transmitted in MailMan Messages:" I $D(PRCPXMZ) S %=0 F  S %=$O(PRCPXMZ(%)) Q:'%  W " ",PRCPXMZ(%),"  "
 K ^TMP($J,"PRCPAWN1"),^TMP($J,"STRING")
 Q
 ;
 ;
ISMS ;  format isms code sheet
 I QTY D ADJUST^PRCPSMA0(INVPT,ITEMDA,QTY,"","","") I STRING("AT")'="" S ISMSCNT=ISMSCNT+1,^TMP($J,"PRCPAWN1",ISMSCNT)=STRING("AT")
 I INVVALUE D ADJUST^PRCPSMA0(INVPT,ITEMDA,"",INVVALUE,+$P($G(^PRCP(445,INVPT,1,ITEMDA,0)),"^",22),"") I STRING("AT")'="" S ISMSCNT=ISMSCNT+1,^TMP($J,"PRCPAWN1",ISMSCNT)=STRING("AT")
 Q
 ;
 ;
LOG ;  format log code sheets for isms
 S NSN=$E($TR($P(NSN,"-",2,4),"-")_"          ",1,10)
 ;  format quantity
 S QSIGN="+"
 I QTY<0 S QSIGN="-",QTY=QTY*-1
 S QTY=$S(QTY=0:"     ",1:$E("00000",$L(QTY)+1,5)_QTY)
 ;  format inventory value
 S VSIGN=QSIGN
 I INVVALUE S INVVALUE=$TR($J(INVVALUE,0,2),"."),VSIGN="+" I INVVALUE<0 S VSIGN="-",INVVALUE=INVVALUE*-1
 S INVVALUE=$S('INVVALUE:"     ",1:$E("0000000",$L(INVVALUE)+1,7)_INVVALUE)
 ;  build code sheets
 S %="",$P(%," ",80)=""
 I '$D(VOUCHER) S VOUCHER="     "
 I QSIGN=VSIGN S ISMSCNT=ISMSCNT+1,^TMP($J,"PRCPAWN1",ISMSCNT)="   "_NSN_PRC("SITE")_"605A"_ACCT_QTY_INVVALUE_QSIGN_VOUCHER_$E(DT,4,7)_$E(DT,2,3)_$E(%,1,35) Q
 I +QTY S ISMSCNT=ISMSCNT+1,^TMP($J,"PRCPAWN1",ISMSCNT)="   "_NSN_PRC("SITE")_"605A"_ACCT_QTY_"0000000"_QSIGN_VOUCHER_$E(DT,4,7)_$E(DT,2,3)_$E(%,1,35)
 I +INVVALUE S ISMSCNT=ISMSCNT+1,^TMP($J,"PRCPAWN1",ISMSCNT)="   "_NSN_PRC("SITE")_"605A"_ACCT_"00000"_INVVALUE_VSIGN_VOUCHER_$E(DT,4,5)_$E(DT,6,7)_$E(DT,2,3)_$E(%,1,35)
 Q
