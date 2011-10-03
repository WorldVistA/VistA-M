PSAPOST ;BIR/JMB-Post Init ;7/23/97
 ;;3.0; DRUG ACCOUNTABILITY/INVENTORY INTERFACE;**64**; 10/24/97;Build 4
 ;If there is a NDC in field #31, the NDC is added to the SYNONYM
 ;multiple.
 ;
SYNONYM D BMES^XPDUTL("Copying the NDCs to the SYNONYM multiple in the DRUG file.")
 S PSAIEN=0 F  S PSAIEN=$O(^PSDRUG(PSAIEN)) Q:'PSAIEN  D
 .Q:$P($G(^PSDRUG(PSAIEN,2)),"^",4)=""
 .S PSANDC4=$P($G(^PSDRUG(PSAIEN,2)),"^",4)
 .S PSANDC=$E("000000",1,(6-$L($P(PSANDC4,"-"))))_$P(PSANDC4,"-")_$E("0000",1,(4-$L($P(PSANDC4,"-",2))))_$P(PSANDC4,"-",2)_$E("00",1,(2-$L($P(PSANDC4,"-",3))))_$P(PSANDC4,"-",3)
 .S PSADASH=$E("000000",1,(6-$L($P(PSANDC4,"-"))))_$P(PSANDC4,"-")_"-"_$E("0000",1,(4-$L($P(PSANDC4,"-",2))))_$P(PSANDC4,"-",2)_"-"_$E("00",1,(2-$L($P(PSANDC4,"-",3))))_$P(PSANDC4,"-",3)
 .I '$D(^PSDRUG(PSAIEN,1,0)) S ^PSDRUG(PSAIEN,1,0)="^50.1A^^"
 .K DD,DO,DA S DA(1)=PSAIEN,DIC="^PSDRUG("_DA(1)_",1,",DIC(0)="LM",X=PSANDC,DLAYGO=50 D ^DIC K DIC,DLAYGO
 .Q:$G(DA)=""
 .S DR="2///"_PSADASH_";1///D",DA=+Y,DIE="^PSDRUG("_DA(1)_",1,"
 .F  L +^PSDRUG(PSAIEN,0):$S($G(DILOCKTM)>0:DILOCKTM,1:3) I  Q
 .D ^DIE K DIE L -^PSDRUG(PSAIEN,0)
 K DA,DIC,DIE,DR,PSADASH,PSAIEN,PSANDC,PSANDC4,X,Y
 D BMES^XPDUTL("Copying NDCs is complete!")
 Q
