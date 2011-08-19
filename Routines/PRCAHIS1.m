PRCAHIS1 ;WASH-ISC@ALTOONA,PA/LDB-Transaction History Report (cont) ;9/27/93  10:33 AM
V ;;4.5;Accounts Receivable;**100**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
TRANS ;Build array of transactions
 ;Called from PRCAHIS
 N PRCAHIST S PRCAHIST="THIST"
 S PG=0,$P(LINE,"-",79)="-" K ^TMP("PRCAGT",$J) D DT^DICRW
 S BDATE=(BDATE-1)_".999999999"
 S EDATE=EDATE+.99999999
 S:'TYP TYP="" D EN^PRCAGT(DEB,BDATE,EDATE,TYP)
TBAL D TBAL^PRCAGT(DEB,.TBAL)
 I 'TYP!(TYP=45) S TYP(1)=TYP D
 .F TYP=1:1:$S(TYP(1)=45:1,1:3) S DAT1=0 F  S DAT1=$O(^RC(341,"AD",+DEB,TYP,DAT1)) Q:'DAT1  D
 ..S EVNT=0 F  S EVNT=$O(^RC(341,"AD",+DEB,TYP,DAT1,EVNT)) Q:'EVNT  I $D(^RC(341,+EVNT,0)) D
 ...S DAT2=$P(^RC(341,+EVNT,0),"^",7)
 ...I DAT2'<BDATE&(DAT2'>EDATE) D
 ....S ^TMP("PRCAGT",$J,+DEB,DAT2,0)="0^"_$P($G(^RC(341,+EVNT,0)),"^",2)_"^"_EVNT
 Q
