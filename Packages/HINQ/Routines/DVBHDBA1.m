DVBHDBA1 ;pke/isc-albany - Check, add to file 31; 25 AUG 88@12:00
 ;;V4.0;HINQ;;03/25/92 
EN K DO,DD S U="^" D DT^DICRW
 ;
 W !!?5,"*** Updating 'Disability Condition' file #31 ***",!!
 ;
ENT S DIF="^TMP($J,",XCNP=0 K ^TMP($J)
 F ROU="DVBHDBA2","DVBHDBA3","DVBHDBA4","DVBHDBA5","DVBHDBA6","DVBHDBA7","DVBHDBA8","DVBHDBA9","DVBHDBAA","DVBHDBAB" S X=ROU X ^%ZOSF("LOAD") W ".."
 K DIF,XCNP,ROU
 ;
 S XMSUB="Disability Condition file #31 Changes",XMDUN="HINQ update"
 I $D(DUZ)#2,DUZ S XMDUZ=DUZ
 E  S XMDUZ=.5
 S XMY(XMDUZ)=""
 D GET^XMA2
 ;
ADD S (LCNT,ACNT,CCNT)=0,$P(BL," ",40)="" W !!
 S (DIE,DIC)="^DIC(31,",DIC(0)="L"
 F DVBZ=0:0 S DVBZ=$O(^TMP($J,DVBZ)) Q:'DVBZ  I $D(^(DVBZ,0)) S DCODE=$P(^(0),";;",2) I +DCODE S DTEXT=$P(DCODE,"^",2),DCODE=+DCODE D CHKADD
 ;
 W !!?5,"*** "
 I 'ACNT W "No entry"
 E  W ACNT," ",$S(ACNT>1:"entries",1:"entry")
 W " added to file #31 ***",!
 W !!?5,"*** "
 ;
 I 'CCNT W "No entry"
 E  W CCNT," ",$S(CCNT>1:"entries",1:"entry")
 W " changed in file #31 ***",!
 ;
 S ^XMB(3.9,XMZ,2,0)="^^"_LCNT_"^"_LCNT_"^"_DT_"^"
 D ENT1^XMD
 ;
KIL K XMDUZ,XMSUB,XMDUN,XMZ,LINE,%I,%N,BL
 K INT,LCNT,ACNT,CCNT,DCODE,DTEXT,Z,DIE,DIC,DR,DA,DD,D0,DQ,X,Y,DVBZ
 K ^TMP($J) Q
 ;
CHKADD I '$D(^DIC(31,"C",DCODE)) S DIC("DR")="2///"_DCODE,X=DTEXT K DD,DO D FILE^DICN K DO,DD S ACNT=ACNT+1 D M1 Q
 ;
 S INT=0,INT=$O(^DIC(31,"C",DCODE,INT)) I INT,$P(^DIC(31,INT,0),"^")'=DTEXT S DR=".01///"_DTEXT,DA=INT D M2,^DIE S CCNT=CCNT+1 Q
 ;
 Q
M1 S LINE="'"_DCODE_"'  "_DTEXT_" ...added to file..." D MSET Q
 ;
M2 S LINE=$E(DCODE_" "_$P(^DIC(31,INT,0),"^")_BL,1,37)_"==> "_DTEXT
 ;
MSET S LCNT=LCNT+1,^XMB(3.9,XMZ,2,LCNT,0)=LINE
 I DCODE#50=0 W "."
 Q
