PRCHNPO9 ;WISC/SC/JDM-SPLITTED PRCHNPO ROUTINE, ENTER NEW P.O./REQ. ; [12/10/98 12:22pm]
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
EDITMSG ;messages-when editing P.O.
 S PRCHEST=$P($G(^PRC(442,PRCHPO,0)),U,13),PRCHESTL=$P($G(^(0)),U,18)
CKSHBOC I PRCHEST>0 S ESTBOC=+$P($G(^PRC(442,PRCHPO,23)),U) I ESTBOC=""!(ESTBOC'>0) W ?5,!!,"The Estimated Shipping Charges is missing BOC!",$C(7) S PRCHER="",ERROR1=1
 S SHPGBOC=$G(^PRC(442,PRCHPO,23))
 I PRCHEST<0 S SHBOC="",PRCHEST="",$P(^PRC(442,PRCHPO,0),U,13)=PRCHEST,$P(^PRC(442,PRCHPO,23),U)=SHBOC
CKSRCCD I PRCHSC="",'$D(PRCHPC) W !!?5,"Source Code for "_$S($D(PRCHNRQ):"Requisition",1:"Purchase Order")_" is undefined !",$C(7) S ERROR1=1
CKPRCHD S PRCHDT=$S($P($G(^PRC(442,PRCHPO,1)),U,15)<2881001:0,$P($G(^(1)),U,15)>2880930:1,1:"")
 I PRCHDT="" W !,$S($D(PRCHNRQ):"Requisition",1:"Purchase Order")_" has no date. ",$C(7) S ERROR1=1
CKSINFO I $P($G(^PRC(442,PRCHPO,1)),U,12),$P($G(^(0)),U,2)'=4,$P($G(^(0)),U,2)'=25,$P($G(^(1)),U,3)'="" W $C(7),!!,"P.O. contains both a 'Ship to Address' and a 'Direct Delivery Patient'.",!,"Shipping information is unclear!" S ERROR1=1
 S PRCHNDX=+$P($G(^PRC(442,PRCHPO,0)),U,2),PRCHN("MP")="" G:PRCHNDX'>0 CKPMETH
 S PRCHN("MP")=$P($G(^PRCD(442.5,PRCHNDX,0)),U,3)
CKPMETH I 'PRCHN("MP") W !,$C(7),"Method of Processing is not entered!" S ERROR1=1
CKFOBOR I $P($G(^PRC(442,PRCHPO,1)),U,6)="O"&(($P($G(^(0)),U,13)<0)!($P($G(^(0)),U,13)="")) W !,"F.O.B. Point with ORIGIN must have a Est. Shipping and/or Handling Charges" S ERROR1=1
 Q
CKLI ;Messages if req'd Packaging Multiple, UCF or Drug Type Code are null
 S ERMS1=" ",IMF=$P(^PRC(442,PRCHPO,2,LI,0),U,5),IMFD=$P(^PRC(441,IMF,0),U,2),VND=$P(^PRC(442,PRCHPO,1),U,1)
 S ERMS2="Line item "_$P(^PRC(442,PRCHPO,2,LI,0),U)_" is missing "
 I PRCHMUL=""&(PRTY=1!(PRTY=25)!(PRTY=26)) K E S E(1)=ERMS2,E(1,"F")="!",E(2)="Packaging Multiple!",E(2,"F")="",E(3)=ERMS1,E(3,"F")="!" D EN^DDIOL(.E) S ERRFL=1
 I PRCHUCF=""&(PRTY=1!(PRTY=25)!(PRTY=26)) K E S E(1)=ERMS2,E(1,"F")="!",E(2)="Unit Conversion Factor!",E(2,"F")="",E(3)=ERMS1,E(3,"F")="!" D EN^DDIOL(.E) S ERRFL=2
 I PRCHDRTY=""&(PRCHFSCD="6505") K E S E(1)=ERMS2,E(1,"F")="!",E(2)="Drug Type Code!",E(2,"F")="" D EN^DDIOL(.E) S ERRFL=3
 Q
TSTREQ1 ;EP;Called from PO Input Templates to warn blank Packaging Multiple field will be required to complete transaction.
 Q:$P($G(^PRC(442,PRCHPO,2,DA,0)),U,5)=""
 S:'$D(^VA(200,DUZ,400)) SUPUSR=0
 S:'$D(SUPUSR) SUPUSR=$P(^VA(200,DUZ,400),U,1)
 S PRTY=$P($G(^PRC(442,PRCHPO,0)),U,2),LI=$P($G(^PRC(442,PRCHPO,2,0)),U,4),CUROPT=$P(XQY0,U,1),ERRFL=0
 Q:(PRTY=25!(PRTY=26))&(SUPUSR'>2)
 Q:PRTY'=1&(PRTY'=25)&(PRTY'=26)
 I $P($G(^PRC(442,PRCHPO,2,DA,0)),U,12)']"" K W S W(1)="Pkg. Multiple is blank. It must be supplied to later complete this document!",W(1,"F")="!" D EN^DDIOL(.W)
 Q
TSTREQ2 ;EP;Called from PO Input Templates to warn blank Drug Type Code will be required to complete transaction.
 Q:$P($G(^PRC(442,PRCHPO,2,DA,2)),U,3)'="6505"
 I $P($G(^PRC(442,PRCHPO,2,DA,4)),U,11)']"" K W S W(1)="For FSC 6505, DRUG TYPE CODE must be supplied to later complete document",W(1,"F")="!" D EN^DDIOL(.W)
 Q
ERRCHKS ;EP;Called from routine PRCHNPO before allowing completion of transaction.  Checks all line items for blank required fields (as appropriate) Pkg. Mult., UCF & Drug Type Code.
 S ERRFL=0
 S PRTY=$P(^PRC(442,PRCHPO,0),U,2),LI=0
 K SUPUSR S:'$D(^VA(200,DUZ,400)) SUPUSR=0
 S:'$D(SUPUSR) SUPUSR=$P(^VA(200,DUZ,400),U,1)
 S CUROPT=$P(XQY0,U,1)
 G:(PRTY=25!(PRTY=26))&(SUPUSR'>2) NOIMF
 G:PRTY'=1&(PRTY'=25)&(PRTY'=26) NOIMF
 F  Q:$O(^PRC(442,PRCHPO,2,LI))'>0  S LI=$O(^PRC(442,PRCHPO,2,LI)) D
 .Q:$P($G(^PRC(442,PRCHPO,2,LI,0)),U,5)=""
 .S PRCHMUL=$P($G(^PRC(442,PRCHPO,2,LI,0)),U,12),PRCHUCF=$P(^PRC(442,PRCHPO,2,LI,0),U,17)
 .S PRCHDRTY=$P($G(^PRC(442,PRCHPO,2,LI,4)),U,11),PRCHFSCD=$P(^PRC(442,PRCHPO,2,LI,2),U,3) D CKLI
NOIMF Q
