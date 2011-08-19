GECSSTTR ;WISC/RFJ-stacker file transmission utilities ;08 Dec 93
 ;;2.0;GCS;**4,5,11,13,27**;MAR 14, 1995
 Q
 ;
 ;
ERROR(DA,ERRORMSG)          ;  record error for stack da
 ;  errormsg = error message to record
 I '$D(^GECS(2100.1,DA,0)) Q
 L +^GECS(2100.1,DA,1)
 I ERRORMSG="" S ERRORMSG="Unspecified"
 S $P(^GECS(2100.1,DA,1),"^",2)=ERRORMSG
 L -^GECS(2100.1,DA,1)
 Q
 ;
 ;
RECUSER(SEGMENT,GROUP)     ;  build receiving user array for segment (2101.2)
 ;  group = 1 to include G.batch mail group
 ;  receiving user array returned in GECSXMY
 K GECSXMY
 N %,D,DA,DOMAIN,SYSID
 S DA=+$P($G(^GECS(2101.2,+$O(^GECS(2101.2,"B",SEGMENT,0)),0)),"^",4) I 'DA Q
 S %=0 F  S %=$O(^GECS(2101.1,DA,2,%)) Q:'%  S D=$G(^(%,0)) I $P(D,"^",3)=1 D
 .   S DOMAIN=$P($G(^DIC(4.2,+$P(D,"^",2),0)),"^") I DOMAIN'="" S DOMAIN="@"_DOMAIN
 .   S GECSXMY($P(D,"^")_DOMAIN)=""
 ;
 ; get user in mail group
 I GROUP S SYSID=$P($G(^GECS(2101.1,DA,0)),"^",4) I $L(SYSID) S GECSXMY("G."_SYSID)=""
 Q
 ;
 ;
MAILMSG(SEGMENT,SEQUENCE,TOTAL) ;  create mail message with code sheets
 ;  segment = entry in file 2101.2
 ;  sequence = sequence number
 ;  total = total sequences
 ;  returns xmz message number
 N %,%X,%Y,GECSXMY,XCNP,XMDISPI,XMDUZ,XMMG,XMSUB,XMTEXT,XMY,XMZ,ZTSK
 ;
 ;  build receiving queue and user array
 D RECUSER(SEGMENT,1)
 I '$D(GECSXMY) Q "0^No receiving users for code sheets"
 S %X="GECSXMY(",%Y="XMY(" D %XY^%RCR
 ;
 S XMDUZ=$S($D(ZTQUEUED):.5,'$G(DUZ):.5,$G(GECSFQUE):.5,1:DUZ),XMTEXT="^TMP($J,""GECSSTTR"","_SEQUENCE_",",XMSUB="GCS TRANSACTION "_SEGMENT_" (MSG "_SEQUENCE_" OF "_TOTAL_")"
 D ^XMD
 I '$G(XMZ) S XMZ="0^Mailman Error: "_$S($G(XMMG)'="":XMMG,1:"<not recorded>")
 Q XMZ
 ;
 ;
MESSAGE(DA,NODE,XMZ) ;  add message (XMZ) to node in stack file for DA
 N %
 L +^GECS(2100.1,DA,NODE)
 I $D(^GECS(2100.1,DA,NODE,XMZ,0)) Q
 I '$D(^GECS(2100.1,DA,NODE,0)) S ^(0)=$S(NODE=20:"^2100.12^^",1:"^2100.121^^")
 S ^GECS(2100.1,DA,NODE,XMZ,0)=XMZ
 S ^GECS(2100.1,"AM",XMZ,DA)=""
 S %=^GECS(2100.1,DA,NODE,0),$P(%,"^",3)=XMZ,$P(%,"^",4)=$P(%,"^",4)+1,^(0)=%
 L -^GECS(2100.1,DA,NODE)
 Q
 ;
 ;
HOLDDATE(DATA) ;  return the hold date from the tt2 segment
 ;  if hold date is not greater than today, return null
 N HOLDDATE
 S HOLDDATE=$P(DATA,"^",2)_$P(DATA,"^",3)_$P(DATA,"^",4)
 ;  some segments have yr and mo on different pieces
 I $P(DATA,"^")="AT1" S HOLDDATE=$P(DATA,"^",6)_$P(DATA,"^",4)_$P(DATA,"^",5)
 I "BD2PV2SA2ST2DD2"[$P(DATA,"^") S HOLDDATE=$P(DATA,"^",4)_$P(DATA,"^",2)_$P(DATA,"^",3)
 I $L(HOLDDATE)'=6 Q ""
 S HOLDDATE=$S($E(HOLDDATE,1,2)<70:3,1:2)_HOLDDATE
 I HOLDDATE'>DT Q ""
 Q HOLDDATE
 ;
 ;
CTLDATE(CTLSEG) ;  put transmission date and time on ctl segment
 N %,%H,%I,X,Y
 D NOW^%DTC
 S $P(CTLSEG,"^",10)=(17+$E(X))_$E(X,2,7)
 S Y=% D DD^%DT
 S $P(CTLSEG,"^",11)=$$FORMTIME^GECSUFM1($P(Y,"@",2))
 Q CTLSEG
