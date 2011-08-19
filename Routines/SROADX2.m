SROADX2 ;BIR/RJS - ASSOCIATED DIAGNOSIS FOR CODER AND VERIFY SCREENS ;09/12/05 12:01pm
 ;;3.0; Surgery ;**119,150,142**;24 Jun 93
PDXCHK(SRCODE) N SRYBAK,SRXBAK,DIR,SRQUIT,SRTEMP,DA
 Q:'$D(D0)
 I '$D(SRTN) N SRTN S SRTN=D0
 Q:D0=SRTN
 S ^TMP($J,"SRASOC",SRTN)=""
 M SRYBAK=Y
 I SRYBAK=1 S SRYBAK=""
 S DIR(0)="Y",SRXBAK=X,SRQUIT=0,SRKALL=0,Y=0
 S DIR("A",1)="The Procedure Associations may no longer be correct,"
 I SRCODE D
 .Q:$$PRLOOP(1)=0
 .I $P(XQY0,U)'="SROVER"&($P(XQY0,U)'="SRCODING EDIT") S DIR("A",2)="Please update the Associations in the PHYSICIAN'S VERIFY menu"
 .S DIR("A")="Delete PRINCIPAL Procedure Associations for this DX",DIR("B")="NO"
 .S:$$GET1^DIQ(130.18,D0_","_SRTN_",",3) DIR("B")="YES"
 .D ^DIR
 I 'SRCODE D
 .I $$PRLOOP(1)=0,$$OTLOOP(1)=0 Q
 .S DIR("A")="All Procedure Associations for this DX will be deleted. Continue",DIR("B")="NO"
 .D ^DIR S:'Y SRXBAK=SRYBAK,SRQUIT=1
 .S:Y SRKALL=1
 S:Y SRTEMP=$$PRLOOP(0)
 M Y=SRYBAK S X=SRXBAK
 I SRQUIT W !! Q
 K DIR
 D OTHCHK(SRCODE)
 K SRKALL,SRMATCH,DIR
 Q
OTHCHK(SRCODE) N OTH,DA,SRY,SRQUIT,SRYBAK,SRXBAK,DIR
 M SRYBAK=Y
 S SRQUIT=0,SRXBAK=X
 I 'SRKALL W ! D
 .Q:$$OTLOOP(1)=0
 .S DIR(0)="Y",DIR("A",1)="The OTHER Prodecure Associations may no longer be correct."
 .I SRCODE D
 ..I $P(XQY0,U)'="SROVER"&($P(XQY0,U)'="SRCODING EDIT") S DIR("A",2)="Please update the Associations in the PHYSICIAN'S VERIFY menu"
 ..S DIR("A")="Delete OTHER Procedure Associations for this DX",DIR("B")="NO"
 ..S:$$GET1^DIQ(130.18,D0_","_SRTN_",",3) DIR("B")="YES"
 ..D ^DIR W !!
 I Y!SRKALL D
 .N DA S OTH=0
 .F  S OTH=$O(^SRF(SRTN,13,OTH)) Q:'OTH  D
 ..S DA=0
 ..F  S DA=$O(^SRF(SRTN,13,OTH,"OADX",DA)) Q:'+DA  D
 ...I D0=^SRF(SRTN,13,OTH,"OADX",DA,0) D  Q
 ....D KOADX(SRTN,OTH)
 M Y=SRYBAK S X=SRXBAK
 Q
MSG Q:$D(SRFLG)
 Q:'$D(EMILY)
 D SRCMSG^SROADX1
 D SRCWRT^SROADX1
 Q
PRLOOP(SRCHK) N SRDX,SRMATCH S (SRDX,SRMATCH)=0
 F SRI=1:1 S SRDX=$O(^SRF(SRTN,"PADX",SRDX)) Q:'SRDX  D
 .I (D0=^SRF(SRTN,"PADX",SRDX,0))!($G(DA)=^SRF(SRTN,"PADX",SRDX,0)) S SRMATCH=1 Q
 I SRMATCH,'SRCHK D KPADX(SRTN)
 Q SRMATCH
OTLOOP(SRCHK) N SRDA,OTH,SRMATCH S (OTH,SRMATCH)=0
 F  S OTH=$O(^SRF(SRTN,13,OTH)) Q:'OTH  D
 .S SRDA=0
 .F  S SRDA=$O(^SRF(SRTN,13,OTH,"OADX",SRDA)) Q:'+SRDA  D
 ..I (D0=^SRF(SRTN,13,OTH,"OADX",SRDA,0))!($G(DA)=^SRF(SRTN,13,OTH,"OADX",SRDA,0)) D  Q
 ...I 'SRCHK D KOADX(SRTN,SRDA)
 ...S SRMATCH=1
 Q SRMATCH
DELASOC N DIR,Y,SRPR,SROT,SRXBAK
 S:'$D(SRTN)&$D(DA(1)) SRTN=DA(1)
 S:'$D(SRTN)&'$D(DA(1)) SRTN=DA
 I $D(^TMP($J,"SRASOC",SRTN)) K ^TMP($J,"SRASOC",SRTN) Q
 Q:$G(D0)=""
 S SRPR=$$PRLOOP(1),SROT=$$OTLOOP(1),SRXBAK=X
 I 'SRPR,'SROT Q
 S DIR(0)="FO",DIR("A")="Procedure Associations for this Diagnosis will be deleted. Continue"
 D ^DIR
 S SRPR=$$PRLOOP(0),SROT=$$OTLOOP(0)
 S X=SRXBAK
 Q
PRINASO(SRCODE) Q:$G(SRTN)=""!($G(X)="")
 N D0 S D0=0  D PDXCHK(SRCODE) K SRCODE Q
PRINASOD Q:$G(SRTN)=""!($G(X)="")
 I $D(^TMP($J,"SRASOC",SRTN)) K ^TMP($J,"SRASOC",SRTN) Q
 N D0 S D0=0  D DELASOC Q
PCPTASO(SRCODE) Q:$G(SRTN)=""!($G(X)="")
 I $G(D0)=""!('+$G(X)&(SRCODE))!('$D(^SRF(SRTN,"PADX"))) Q
 D:$$EDITWARN(SRCODE) KPADX(SRTN)
 K SRCODE
 Q
OCPTASO(SRCODE) Q:$G(SRTN)=""!($G(DA)="")!($G(X)="")
 I $G(D0)=""!('+$G(X)&(SRCODE))!('$D(^SRF(SRTN,13,DA,"OADX",0))) Q
 D:$$EDITWARN(SRCODE) KOADX(SRTN,DA)
 K SRCODE
 Q
EDITWARN(SRCODE) N SRYBAK,SRXBAK,DIR,SRY
 M SRYBAK=Y,SRDABAK=DA
 S DIR(0)="Y",DIR("B")="NO",SRXBAK=X,SRQUIT=0
 S DIR("A",1)="The Diagnosis to Procedure Associations may no longer be correct."
 I SRCODE D
 .I $P(XQY0,U)'="SROVER"&($P(XQY0,U)'="SRCODING EDIT") S DIR("A",2)="Please update the Associations in the PHYSICIAN'S VERIFY menu."
 .S DIR("A")="Delete Diagnosis Associations for this Procedure"
 .D ^DIR
 I 'SRCODE D
 .S DIR("A")="All DX Associations for this Procedure will be deleted. Continue"
 .D ^DIR
 .S:'Y SRXBAK=SRYBAK
 S X=SRXBAK,SRY=Y
 M Y=SRYBAK,DA=SRDABAK
 W !!
 Q SRY
KPADX(SRCN) ; kill all the principal cpt associated diagnosis codes
 N DA,DIK,SRX1,Y,SRXBAK
 S SRX1=0,DA(1)=SRCN,SRXBAK=X
 F  S SRX1=$O(^SRF(DA(1),"PADX",SRX1)) Q:'SRX1  D
 .S DA=SRX1,DA(1)=SRCN,DIK="^SRF("_DA(1)_",""PADX""," D ^DIK
 S X=SRXBAK
 Q
KOADX(SRCN,SRREC) ; kill other cpt associated diagnosis codes
 N DA,DIK,SRX1,Y,SRXBAK
 S SRX1=0,DA(2)=SRCN,SRXBAK=X
 F  S SRX1=$O(^SRF(DA(2),13,SRREC,"OADX",SRX1)) Q:'SRX1  D
 .S DA=SRX1,DA(1)=SRREC,DA(2)=SRCN,DIK="^SRF("_DA(2)_",13,"_DA(1)_",""OADX""," D ^DIK
 S X=SRXBAK
 Q
ADXCHK ; check the validity of associations and remove if diagnosis missing
 N SRDX,SRX,SRY,SRZ
 S SRDX=0
 I $D(^SRF(SRTN,13)) S SRX=0 D
 .F  S SRX=$O(^SRF(SRTN,13,SRX)) Q:'SRX  D
 ..I $D(^SRF(SRTN,13,SRX,"OADX")) S SRY=0 D
 ...F  S SRY=$O(^SRF(SRTN,13,SRX,"OADX",SRY)) Q:'SRY  D
 ....S SRDX=^SRF(SRTN,13,SRX,"OADX",SRY,0)
 ....I (SRDX'=0),'$D(^SRF(SRTN,15,SRDX,0)) D KOADX(SRTN,SRX)
 ....I (SRDX=0),($P($G(^SRF(SRTN,34)),U)=""),('$P($G(^SRF(SRTN,34)),U,2)) D KOADX(SRTN,SRX)
 I $D(^SRF(SRTN,"PADX")) S SRX=0 D
 .F  S SRX=$O(^SRF(SRTN,"PADX",SRX)) Q:'SRX  D
 ..S SRDX=^SRF(SRTN,"PADX",SRX,0)
 ..I (SRDX'=0),'$D(^SRF(SRTN,15,SRDX,0)) D KPADX(SRTN)
 I $O(^SRF(SRTN,"PADX",0)),(($P($G(^SRF(SRTN,34)),U)="")&('$P($G(^SRF(SRTN,34)),U,2)))!(($P($G(^SRF(SRTN,"OP")),U)="")&('$P($G(^SRF(SRTN,"OP")),U,2))) D KPADX(SRTN)
 Q
