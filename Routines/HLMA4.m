HLMA4 ;OIFO-O/RJH-DON'T PING VIE ;03/29/2007  16:21
 ;;1.6;HEALTH LEVEL SEVEN;**122**;Oct 13, 1995;Build 14
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
DONTPING(PAR) ;
 ; check the data stored in file #869.3 related multiples to
 ; to see if ping is allowed for the Ping option, PING^HLMA
 ; return 1: don't ping this link.
 ; return 0: ok to ping the link.
 ;
 N ONE,LINE,PINGOK
 S HLQUIET=$G(HLQUIET)
 ;
 ; the only one entry in file #869.3
 S ONE=$O(^HLCS(869.3,0))
 ;
 D PINGIP
 Q:PINGOK 0
 ;
 D DONTPORT
 Q:'PINGOK 1
 ;
 D DONTDOMN
 Q:'PINGOK 1
 ;
 D DONTNAME
 Q:'PINGOK 1
 ;
 D DONTIP
 Q:'PINGOK 1
 ;
 D PINGDOMN
 Q:PINGOK 0
 ;
 I 'HLQUIET S HLCS="This link is not allowed to ping"
 Q 1
 ;
PINGIP ;
 ; retrieve the "Ping IP" multiple, which are ok to ping
 S PINGOK=0
 S LINE=0
 F  S LINE=$O(^HLCS(869.3,ONE,7,LINE)) Q:'LINE  D  Q:PINGOK
 . N DATAS,COUNT,DATA
 . S DATAS=$G(^HLCS(869.3,ONE,7,LINE,0))
 . S COUNT=$L(DATAS,",")
 . F I=1:1:COUNT D  Q:PINGOK
 .. S DATA=$P(DATAS,",",I),DATA=$TR(DATA," ","")
 .. I DATA=HLTCPADD S PINGOK=1
 Q
 ;
DONTPORT ;
 ; retrieve the "Don't Ping Port" multiple, which are not
 ; allowed to ping
 S PINGOK=1
 S LINE=0
 F  S LINE=$O(^HLCS(869.3,ONE,9,LINE)) Q:'LINE  D  Q:'PINGOK
 . N DATAS,COUNT,DATA
 . S DATAS=$G(^HLCS(869.3,ONE,9,LINE,0))
 . S COUNT=$L(DATAS,",")
 . F I=1:1:COUNT D  Q:'PINGOK
 .. S DATA=$P(DATAS,",",I),DATA=$TR(DATA," ","")
 .. I DATA=HLTCPORT D
 ... S PINGOK=0
 ... I 'HLQUIET D
 .... S HLCS="This link with 'PORT' as '"_HLTCPORT
 .... S HLCS=HLCS_"' is not allowed to ping"
 Q
 ;
DONTDOMN ;
 ; retrieve the "Don't Ping Domain (Full)" multiple,
 ; which are not allowed to ping
 ;
 N HLDOM
 S PINGOK=1
 S HLDOM=$P(^HLCS(870,HLDP,0),U,7)
 S HLDOM("DNS")=$P($G(^HLCS(870,+$G(HLDP),0)),"^",8)
 I 'HLDOM,($L(HLDOM("DNS"),".")<3) Q
 ;
 I HLDOM S HLDOM=$P(^DIC(4.2,HLDOM,0),U)
 ;
 S LINE=0
 F  S LINE=$O(^HLCS(869.3,ONE,12,LINE)) Q:'LINE  D  Q:'PINGOK
 . N DATAS,COUNT,DATA,DNSDOMN,MAILDOMN
 . S DATAS=$G(^HLCS(869.3,ONE,12,LINE,0))
 . S COUNT=$L(DATAS,",")
 . F I=1:1:COUNT D  Q:'PINGOK
 .. S DATA=$P(DATAS,",",I),DATA=$TR(DATA," ","")
 .. ; set PINGOK to 0 if domain is not allowed to ping
 .. I ($L(HLDOM("DNS"),".")>2),HLDOM("DNS")=DATA D  Q
 ... D SETHLCS(HLDOM("DNS"),"DNS DOMAIN")
 .. I $L(HLDOM)>5,HLDOM=DATA D
 ... D SETHLCS(HLDOM,"MAILMAN DOMAIN")
 Q
 ;
SETHLCS(DATA,TYPE) ;
 ; to be called from sub-routine DONTDOMN
 S PINGOK=0
 I 'HLQUIET D
 . S HLCS="This link with '"_TYPE_"' as '"_DATA
 . S HLCS=HLCS_"' is not allowed to ping"
 Q
 ;
DONTNAME ;
 ; retrieve the "Don't Ping Link Name (Partial)" multiple,
 ; which are not allowed to ping
 ;
 N LINKNAME
 S PINGOK=1
 ;
 S LINKNAME=$P(^HLCS(870,HLDP,0),U,1)
 ;
 S LINE=0
 F  S LINE=$O(^HLCS(869.3,ONE,10,LINE)) Q:'LINE  D  Q:'PINGOK
 . N DATAS,COUNT,DATA
 . S DATAS=$G(^HLCS(869.3,ONE,10,LINE,0))
 . S COUNT=$L(DATAS,",")
 . F I=1:1:COUNT D  Q:'PINGOK
 .. S DATA=$P(DATAS,",",I),DATA=$TR(DATA," ","")
 .. I LINKNAME[DATA D
 ... S PINGOK=0
 ... I 'HLQUIET D
 .... S HLCS="This link 'NAME' containing name-stub"
 .... S HLCS=HLCS_" '"_DATA_"' is not allowed to ping"
 Q
 ;
DONTIP ;
 ; retrieve the "Don't Ping IP" multiple, which are not 
 ; allowed to ping
 ;
 S PINGOK=1
 ;
 S LINE=0
 F  S LINE=$O(^HLCS(869.3,ONE,11,LINE)) Q:'LINE  D  Q:'PINGOK
 . N DATAS,COUNT,DATA
 . S DATAS=$G(^HLCS(869.3,ONE,11,LINE,0))
 . S COUNT=$L(DATAS,",")
 . F I=1:1:COUNT D  Q:'PINGOK
 .. S DATA=$P(DATAS,",",I),DATA=$TR(DATA," ","")
 .. I DATA=HLTCPADD D
 ... S PINGOK=0
 ... I 'HLQUIET D
 .... S HLCS="This link with 'IP' as '"_HLTCPADD
 .... S HLCS=HLCS_"' is not allowed to ping"
 Q
 ;
PINGDOMN ;
 ; retrieve the "Ping Domain (Partial)" multiple,
 ; which is ok to ping, data could be partial domain.
 ;
 N HLDOM
 S PINGOK=0
 ;
 S HLDOM=$P(^HLCS(870,HLDP,0),U,7)
 S HLDOM("DNS")=$P($G(^HLCS(870,+$G(HLDP),0)),"^",8)
 I 'HLDOM,($L(HLDOM("DNS"),".")<3) Q
 ;
 I HLDOM S HLDOM=$P(^DIC(4.2,HLDOM,0),U)
 ;
 S LINE=0
 F  S LINE=$O(^HLCS(869.3,ONE,8,LINE)) Q:'LINE  D  Q:PINGOK
 . N DATAS,COUNT,DATA,DNSDOMN,MAILDOMN
 . S DATAS=$G(^HLCS(869.3,ONE,8,LINE,0))
 . S COUNT=$L(DATAS,",")
 . F I=1:1:COUNT D  Q:PINGOK
 .. S DATA=$P(DATAS,",",I),DATA=$TR(DATA," ","")
 .. ; set PINGOK to 1 if domain is allowed to ping
 .. I ($L(HLDOM("DNS"),".")>2),HLDOM("DNS")[DATA S PINGOK=1 Q
 .. I $L(HLDOM)>5,HLDOM[DATA S PINGOK=1
 Q
 ;
