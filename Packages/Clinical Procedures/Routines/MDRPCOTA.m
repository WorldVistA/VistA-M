MDRPCOTA ; HOIFO/NCA - Object RPCs (TMDTransaction) Continued 2;10/29/04  12:20 ;3/12/08  09:18
 ;;1.0;CLINICAL PROCEDURES;**20**;Apr 01, 2004;Build 9
 ; Integration Agreements:
 ; IA# 3468 [Subscription] GMRCCP API.
 ;
GETCS(MDNP1) ; [Function] Return the next procedure request.
 N MDNLL,MDNFG,MDNNOD,MDNR,MDNX K ^TMP("MDNREQ",$J) S (MDNFG,MDNR)=0
 S MDNNOD=$G(^MDD(702,+MDNP1,0)) Q:MDNNOD="" 0
 D CPLIST^GMRCCP(+MDNNOD,+$P(MDNNOD,"^",4),$NA(^TMP("MDNREQ",$J)))
 S MDNLL="" F  S MDNLL=$O(^TMP("MDNREQ",$J,MDNLL),-1) Q:MDNLL<1!(+MDNFG)  S MDNX=$G(^(MDNLL)) D
 .I "saprc"[$P(MDNX,U,4) S MDNFG=1,MDNR=$P(MDNX,U,5) Q
 .Q
 Q MDNR
