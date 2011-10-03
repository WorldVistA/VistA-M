PSXRCVRY ;BIR/WPB/PDW-CMOP Utility to reset transmissions at remote ;11 Jul 2002
 ;;2.0;CMOP;**1,3,28,41**;11 Apr 97
 ;Reference to ^PS(52.5 supported by DBIA #1978
 ;Reference to ^PSRX(   supported by DBIA #1977
 ;
EN D SET^PSXSYS
 N ZTSK S ZTSK=$P(^PSX(550,+PSXSYS,3),"^",2),PSX=+PSXSYS
 ;
 Q:$G(PSXSYS)'>0
 G:$G(ZTSK)'>0 EN1
 D STAT^%ZTLOAD
 I ($G(ZTSK(1))=1&($G(ZTSK(2))["Active"))!($G(ZTSK(1))=2&($G(ZTSK(2))["Active")) W !,"There is a transmission in progress, try again later." Q
EN1 ;I '$G(ARCVRY) W !,"Please wait, checking for data to send."
 D:'$D(PSXSYS) SET^PSXSYS
 ;N PSXSYS D SET^PSXSYS Q:$G(PSXSYS)'>0  S PSXSTAT="T" D PSXSTAT^PSXRSYU K PSXSTAT
 ;S LAST=$P(^PSX(550,PSX,3),"^",1) K ^PSX("CMOP TRAN")
 ;loop transmissions 550.2 "AQ" for batches started
 L ^PSX(550.1):30 I '$T W !,"A transmission build is in process, try again later" Q
 S PSXBAT=0 F  S PSXBAT=$O(^PSX(550.2,"AQ",PSXBAT)) Q:PSXBAT'>0  D
 . D RSTBATCH(PSXBAT),MMSG,CLNRXQUE(PSXBAT),CLOSEBAT,SUSRST
 Q
RSTBATCH(PSXBAT)    ; given PSXBAT reset RXs into CMOP SUSPENSE, (code also in re-transmit a batch)
 ; pull, reset RXs from 550.2 RX multiple
 S PSXBATNM=$$GET1^DIQ(550.2,PSXBAT,.01)
 I '$D(^PSX(550.2,PSXBAT,15)) D BLDRXM(PSXBAT) ;build RX multiple from 550.1,"C"
 S PSXTRXDA=0,RXCNT=0 F  S PSXTRXDA=$O(^PSX(550.2,PSXBAT,15,PSXTRXDA)) Q:PSXTRXDA'>0  S PSX0=^PSX(550.2,PSXBAT,15,PSXTRXDA,0) D
 . F YY="RXDA^1","RXFL^2","PSXHOST^4" D PIECE^PSXUTL(PSX0,U,YY)
 . D RESET^PSXNEW(RXDA,RXFL,PSXBATNM_" Transmission Recovery") ; resets RX 52.5, 52 into CMOP suspense
 Q
CLNRXQUE(PSXBAT) ; locate 550.1 entries associated with transmission PSXBAT and remove
 K DIK,DA N PSXRXQDA
 S DIK="^PSX(550.1,"
 S PSXRXQDA=0 F  S PSXRXQDA=$O(^PSX(550.1,"C",PSXBAT,PSXRXQDA)) Q:PSXRXQDA'>0  S DA=PSXRXQDA D ^DIK
 K DIK,DA
 Q 
EXIT K DFN,PTR,REC,SDT,LAST,PSXBAT,PSXTRNBT,PSXRXQDA,PSXTRXDA,RXDA,RXFL
 Q
MMSG ;
 S SITE=$P($G(PSXSYS),"^",3) K PSXTRNBT
 D GETS^DIQ(550.2,PSXBAT,".01;2;3;4;5;6;17","","PSXTRNBT"),TOP^PSXUTL("PSXTRNBT")
 S XMSUB="CMOP Recovery Message "_$G(SITE),XMDUN="CMOP Managers",XMDUZ=.5
 D XMZ^XMA2 G:$G(XMZ)'>0 EXIT
 S ^XMB(3.9,XMZ,2,1,0)="The last CMOP transmission did not complete properly. The data for this"
 S ^XMB(3.9,XMZ,2,2,0)="transmission will be sent to the CMOP during the next transmission for"
 S ^XMB(3.9,XMZ,2,3,0)="that division."
 S ^XMB(3.9,XMZ,2,4,0)=""
 S ^XMB(3.9,XMZ,2,5,0)="If you have scheduled auto transmissions for CMOP, please check to see"
 S ^XMB(3.9,XMZ,2,6,0)="that they are still scheduled for the correct time."
 S ^XMB(3.9,XMZ,2,7,0)=""
 S ^XMB(3.9,XMZ,2,8,0)="This message is just a notification that problems were detected with the last"
 S ^XMB(3.9,XMZ,2,9,0)="transmission and that the data will be sent to the CMOP facility for processing."
 S ^XMB(3.9,XMZ,2,10,0)="If you are getting this message frequently, please contact your IRM staff."
 S ^XMB(3.9,XMZ,2,11,0)="Otherwise there is not anything that you need to do."
 S ^XMB(3.9,XMZ,2,12,0)=" "
 S ^XMB(3.9,XMZ,2,13,0)="Transmission:       "_PSXTRNBT(.01)
 S ^XMB(3.9,XMZ,2,14,0)="Division:           "_PSXTRNBT(2)
 S ^XMB(3.9,XMZ,2,15,0)="CMOP Host:          "_PSXTRNBT(3)
 S ^XMB(3.9,XMZ,2,16,0)="Type:               "_PSXTRNBT(17)
 S ^XMB(3.9,XMZ,2,17,0)="Date/Time:          "_PSXTRNBT(5)
 S ^XMB(3.9,XMZ,2,18,0)=" "
 S ^XMB(3.9,XMZ,2,19,0)="The prescriptions have been reset into CMOP suspense"
 S ^XMB(3.9,XMZ,2,20,0)="and this transmission has been closed"
 S ^XMB(3.9,XMZ,2,0)="^3.92A^20^20^"_DT
 D GRP^PSXNOTE
 D ENT1^XMD
 K XMSUB,XMDUZ,XMDUN,XMZ,XMY,SITE,BADBAT
 Q
CLOSEBAT   ; close failed transmission PSXBAT in 550.2
 K DIE,DA,DR
 S DIE="^PSX(550.2,",DA=PSXBAT,DR="1////4" D ^DIE
 K DIE,DA,DR
 Q
SUSRST ; reset any RXs in suspense with 'L'oading status
 F RXTYP="N","C" F STAT="L" I $D(^PS(52.5,"CMP",STAT,RXTYP)) S DIV=0 F  S DIV=$O(^PS(52.5,"CMP",STAT,RXTYP,DIV)) Q:DIV'>0  D
 . S SUSDT=0 F  S SUSDT=$O(^PS(52.5,"CMP",STAT,RXTYP,DIV,SUSDT)) Q:SUSDT'>0  D DFN
 Q
DFN S DFN=0 F  S DFN=$O(^PS(52.5,"CMP",STAT,RXTYP,DIV,SUSDT,DFN)) Q:DFN'>0  D
 . S SUSDA=0 F  S SUSDA=$O(^PS(52.5,"CMP",STAT,RXTYP,DIV,SUSDT,DFN,SUSDA)) Q:SUSDA'>0  D SUSRX
 Q
SUSRX ; reset suspense RX
 S SUSRX=$P(^PS(52.5,SUSDA,0),U)
 D RESET^PSXNEW(SUSRX,0,"Recovery")
 Q
BLDRXM(PSXBAT) ; build 550.2 RX multiple from 550.1,"C" given PSXBAT batch ien
 ; can be used for postinit
 S ORD=0 F  S ORD=$O(^PSX(550.1,"C",PSXBAT,ORD)) Q:ORD'>0  D
 . S LN=0 F  S LN=$O(^PSX(550.1,ORD,"T",LN)) Q:LN'>0  S TXT=^(LN,0) I $P(TXT,"|")="RX1" D
 .. S RX=$P(TXT,"|",2),RXF=$P(RX,"-",3)-1,RX=$P(RX,"-",2),PSXPTR=$O(^PSRX("B",RX,0))
 .. S DFN=$P(^PSRX(PSXPTR,0),U,2),REC=$O(^PS(52.5,"B",PSXPTR,0))
 .. K DD,DO,DIC,DA,DR,D0
 .. S:'$D(^PSX(550.2,PSXBAT,15,0)) ^PSX(550.2,PSXBAT,15,0)="^550.215P^^"
 .. S X=RX,DA(1)=PSXBAT
 .. S DIC="^PSX(550.2,"_PSXBAT_",15,",DIC(0)="LX",DLAYGO=550.2
 .. S DIC("DR")=".02////^S X=RXF;.03////^S X=DFN;.04////^S X=REC"
 .. D ^DIC
 .. K DD,DO,DIC,DA,DR,D0
 Q
