GECSSTTT ;WISC/RFJ-stacker file transmission routine ;08 Dec 93
 ;;2.0;GCS;**27**;MAR 14, 1995
 Q
 ;
 ;
TRANSMIT ;  transmit from ^tmp($j,"gecssttr","cs",sequence,line,0)
 N %X,%Y,BATCH,BATCHDA,DA,GECSXMY,SEGTYPES,SEQUENCE,XCNP,XMDISPI,XMDUZ,XMMG,XMSUB,XMTEXT,XMY,XMZ
 S SEQUENCE=0 F  S SEQUENCE=$O(^TMP($J,"GECSSTTR","CS",SEQUENCE)) Q:'SEQUENCE  D
 .   S BATCHDA=^TMP($J,"GECSSTTR","BATCH",SEQUENCE),BATCH=$G(^GECS(2101.1,BATCHDA,0)) S:$P(BATCH,"^")="" $P(BATCH,"^")="<<UNDEFINED BATCH TYPE>>" S:$P(BATCH,"^",4)="" $P(BATCH,"^",4)="???"
 .   D RECUSER(BATCHDA,1)
 .   I '$D(GECSXMY) D TRANSERR("No receiving users for batch type: "_$P(BATCH,"^")) Q
 .   S %X="GECSXMY(",%Y="XMY(" D %XY^%RCR
 .   ;
 .   S SEGTYPES=$G(^TMP($J,"GECSSTTR","SEGS",SEQUENCE))
 .   S XMDUZ=$S($D(ZTQUEUED):.5,'$G(DUZ):.5,$G(GECSFQUE):.5,1:DUZ),XMTEXT="^TMP($J,""GECSSTTR"",""CS"","_SEQUENCE_",",XMSUB="GCS TRANSACTION "_$P(BATCH,"^",4)_$S(SEGTYPES="":"",1:":"_SEGTYPES)
 .   I $L(XMSUB)>65 S XMSUB=$E(XMSUB,1,64)_"*"
 .   K XMMG,XMZ
 .   D ^XMD
 .   I '$G(XMZ) D TRANSERR("Mailman Error: "_$S($G(XMMG)'="":XMMG,1:"<not recorded>")) Q
 .   S DA=0 F  S DA=$O(^TMP($J,"GECSSTTR","LIST",SEQUENCE,DA)) Q:'DA  D
 .   .   D MESSAGE^GECSSTTR(DA,20,XMZ)
 .   .   D SETSTAT^GECSSTAA(DA,"T")
 Q
 ;
 ;
TRANSERR(ERROR)    ;  error during transmitting mail message
 S DA=0 F  S DA=$O(^TMP($J,"GECSSTTR","LIST",SEQUENCE,DA)) Q:'DA  D ERROR^GECSSTTR(DA,ERROR)
 Q
 ;
 ;
RECUSER(DA,GROUP)  ;  build receiving user array for batch (2101.1)
 ;  group = 1 to include G.batch mail group
 ;  receiving user array returned in GECSXMY
 K GECSXMY
 N %,D,DOMAIN,SYSID
 I '$D(^GECS(2101.1,+DA)) Q
 S %=0 F  S %=$O(^GECS(2101.1,DA,2,%)) Q:'%  S D=$G(^(%,0)) I $P(D,"^",3)=1 D
 .   S DOMAIN=$P($G(^DIC(4.2,+$P(D,"^",2),0)),"^") I DOMAIN'="" S DOMAIN="@"_DOMAIN
 .   S GECSXMY($P(D,"^")_DOMAIN)=""
 ;
 ; get user in mail group
 I GROUP S SYSID=$P($G(^GECS(2101.1,DA,0)),"^",4) I $L(SYSID) S GECSXMY("G."_SYSID)=""
 Q
