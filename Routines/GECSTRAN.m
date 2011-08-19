GECSTRAN ;WISC/RFJ/KLD-transmit a batch                                 ;01 Nov 93
 ;;2.0;GCS;**13,15,20**;MAR 14, 1995
 N %,%X,CODE,D,DOMAIN,DA,GECS,GECSBADA,GECSBATC,GECSCODE,GECSDICS,GECSLINE,GECSMAX,GECSMSG,GECSXMY,GECSSYDA,GECSTOTL,GECSXMZ,PRIORITY,X,Y
 D ^GECSSITE Q:'$G(GECS("SITE"))
 D BATNOFMS^GECSUSEL Q:'$G(GECS("BATDA"))
 S GECS("SITECOM")=GECS("SITE")_GECS("SITE1")
 S GECSDICS="S %=^(0) I $S($P(%,""-"",1)=GECS(""SITECOM"")&($P(^(0),U,6)=GECS(""BATDA"")):1,1:0)"
 W ! S GECSBADA=$$BATCHSEL^GECSUSEL(GECSDICS) Q:'GECSBADA
 S GECSBATC=$P($G(^GECS(2101.3,GECSBADA,0)),"^") I GECSBATC="" W !,"CANNOT FIND BATCH NUMBER IN FILE 2101.3." Q
 ;
 ;  build receiving users for mail messages
 K GECSXMY
 S %=0 F  S %=$O(^GECS(2101.1,GECS("BATDA"),2,%)) Q:'%  S D=$G(^(%,0)) I $P(D,"^",3)=1 D
 .   S DOMAIN=$P($G(^DIC(4.2,+$P(D,"^",2),0)),"^") I DOMAIN'="" S DOMAIN="@"_DOMAIN
 .   S GECSXMY($P(D,"^")_DOMAIN)=""
 I '$D(GECSXMY) W !,"RECEIVING USERS FOR THIS BATCH TYPE HAVE NOT BEEN ENTERED." Q
 W !!,"Transmission will be to the following:"
 S %="" F  S %=$O(GECSXMY(%)) Q:%=""  W !?5,%
 ;
 ;
RETRY ;  if locked, come here to retry transmission
 S XP="ARE YOU READY TO TRANSMIT THE CODE SHEETS",XH="Enter YES to transmit the code sheets, NO or ^ to exit." W ! I $$YN^GECSUTIL(2)'=1 Q
 ;
 ;  check lock and lock system
 S GECSSYDA=$$LOCKSYS^GECSULOC(GECS("SITE")_"-"_GECS("SYSID")_"-TRANSMIT")
 I 'GECSSYDA W !!,"ANOTHER USER IS TRANSMITTING THE CODE SHEETS, TRY AGAIN IN A MINUTE" G RETRY
 ;
 ;  check to see if batch has been transmitted, if so quit
 I $P($G(^GECS(2101.3,GECSBADA,0)),"^",3)'="B" D UNLOCK^GECSULOC(GECSSYDA) Q
 ;
 ;  get maximum number of code sheets per message
 S GECSMAX=$P($G(^GECS(2101.1,GECS("BATDA"),0)),"^",3) I 'GECSMAX S GECSMAX=999999999
 ;
 ;  build priority list
 K ^TMP($J,"GECSTRAN")
 S DA=0 F  S DA=$O(^GECS(2100,"AB",GECSBATC,DA)) Q:'DA  I $O(^GECS(2100,DA,"CODE",0)) S D=$G(^GECS(2100,DA,"TRANS")) I D'="" D
 .   S PRIORITY=$P(D,"^",10) S:'PRIORITY PRIORITY=3
 .   S ^TMP($J,"GECSTRAN",PRIORITY,DA)=""
 ;
 ;  build messages
 K ^TMP($J,"GECSTRAN MM")
 S (GECSMSG,GECSLINE)=1
 S PRIORITY=0 F  S PRIORITY=$O(^TMP($J,"GECSTRAN",PRIORITY)) Q:'PRIORITY  S (DA,GECSCODE)=0 F  S DA=$O(^TMP($J,"GECSTRAN",PRIORITY,DA)) Q:'DA  D
 .   ;
 .   ;  umark code sheet for transmission
 .   S $P(^GECS(2100,DA,"TRANS"),"^",2)="" K ^GECS(2100,"AE","Y",DA)
 .   ;
 .   S GECSCODE=GECSCODE+1
 .   I GECSCODE>GECSMAX S GECSMSG=GECSMSG+1,(GECSCODE,GECSLINE)=1
 .   ;
 .   ;  special code to create calm header for fee code sheets 994.xx
 .   I $P(GECSBATC,"-",2)="FEN",GECSLINE=1 D
 .   .   S %=$P(GECSBATC,"-",4)
        .   .   N Y,X
        .   .   S Y=DT D DD^%DT
 .   .   S ^TMP($J,"GECSTRAN MM",GECSMSG,GECSLINE,0)=$E($G(^GECS(2100,DA,"CODE",1,0)),1,3)_"."_$P(GECSBATC,"-")_".999.01."_$E(DT,4,7)_$E(DT,2,3)_".06"_$E("0000",$L(%)+1,4)_%_".$",GECSLINE=GECSLINE+1
 .   S %=0 F  S %=$O(^GECS(2100,DA,"CODE",%)) Q:'%  S CODE=$G(^(%,0)) I CODE'="" D
 .   .   S ^TMP($J,"GECSTRAN MM",GECSMSG,GECSLINE,0)=CODE,GECSLINE=GECSLINE+1
 ;
 S GECSTOTL=GECSMSG
 ;  transmit
 W !
 S GECSMSG=0 F  S GECSMSG=$O(^TMP($J,"GECSTRAN MM",GECSMSG)) Q:'GECSMSG  D
 .   ;create mailman message
 .   W !,"MESSAGE NUMBER: "
 .   S GECSXMZ=$$MAILMSG(GECS("BATCH"),GECSBATC,.GECSXMY,GECSMSG,GECSTOTL)
 .   W GECSXMZ
 .   I 'GECSXMZ Q
 .   ;
 .   ;  set message number in batch
 .   D SETMSG(GECSBADA,GECSXMZ)
 ;
 ;  update file 2101.3
 D UPDATE(GECSBADA)
 Q
 ;
 ;
MAILMSG(BATCHNME,BATCHNUM,RECUSERS,MSGNUMBR,TOTALMSG)    ;  create mailman msg
 ;  batchnme=name of batch
 ;  batchnum=batch number
 ;  recusers()=array of receiving users (same as xmy)
 ;  msgnumbr=this message number
 ;  totalmsg=total number of messages to transmit in all
 ;  returns xmz message number
 N %,DIC,XCNP,XMDISPI,XMDUZ,XMTEXT,XMY,XMZ
 ;
 ;  build receiving queue and user array
 S %="" F  S %=$O(RECUSERS(%)) Q:%=""  S XMY(%)=""
 S XMY(DUZ)="",XMDUZ=DUZ
 ;
 S XMTEXT="^TMP($J,""GECSTRAN MM"","_MSGNUMBR_",",XMSUB="GECS "_BATCHNME_" # "_BATCHNUM_" (MSG "_MSGNUMBR_" OF "_TOTALMSG_")"
 K XMZ D ^XMD
 Q $G(XMZ)
 ;
 ;
UPDATE(DA)         ;  update file 2101.3 batch as being transmitted
 N %DT,D,D0,DI,DIC,DIE,DQ,DR,X,Y
 S (DIC,DIE)="^GECS(2101.3,",DR=".5///T;4///T;5////"_DUZ D ^DIE
 Q
 ;
 ;
SETMSG(DA,XMZ)     ;  set message number in batch
 N %,D0,DD,DIC,DLAYGO,X,Y
 I '$D(^GECS(2101.3,DA,0)) Q
 S:'$D(^GECS(2101.3,DA,2,0)) ^(0)="^2101.32^^"
 S DIC="^GECS(2101.3,"_DA_",2,",DIC(0)="L",DLAYGO=2101.3,X=XMZ D FILE^DICN
 Q
