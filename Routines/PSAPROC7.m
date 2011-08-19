PSAPROC7 ;BIR/JMB-Process Uploaded Prime Vendor Invoice Data - CONT'D ;9/6/97
 ;;3.0; DRUG ACCOUNTABILITY/INVENTORY INTERFACE;**3,12,27,21,42,61,64,67,68,71**; 10/24/97;Build 10
 ;This routine takes the data in XTMP and moves it to DA ORDERS file.
 ;It deletes the data in XTMP after it is copies.
 ;
 ;References to ^PSDRUG( are covered by IA #2095
INVOICE ;PSA*3*21 (3JAN01) - FILE INVOICE IMMEDIATELY
 ;
 S PSAIN=$G(^XTMP("PSAPV",PSACTRL,"IN")) Q:PSAIN=""
 Q:$P(PSAIN,"^",8)'="P"
 S PSAORD=$P(PSAIN,"^",4),PSAIEN=+$O(^PSD(58.811,"B",PSAORD,0)),PSACRED=0
 I 'PSAIEN D
 .F  L +^PSD(58.811,0):$S($G(DILOCKTM)>0:DILOCKTM,1:3) I  Q
 .;(PSA*3*24 - Dave B. Jun 2 00 - Improper DIC call)
 .;(PSA*3*61 - add N DO. DICN will use DO if defined, we do not want to use it since DIC is defined.
 .N DO S DIC="^PSD(58.811,",DIC(0)="L",X=PSAORD D FILE^DICN K DIC L -^PSD(58.811,0) S PSAIEN=+Y
 F  L +^PSD(58.811,PSAIEN,0):10 I  Q
 S:'$D(^PSD(58.811,PSAIEN,1,0)) DIC("P")=$P(^DD(58.811,2,0),"^",2)
 S DA(1)=PSAIEN,DIC="^PSD(58.811,"_DA(1)_",1,",DIC(0)="L",X=$P(PSAIN,"^",2),DLAYGO=58.811 D ^DIC K DA,DLAYGO S PSAIEN1=+Y
 S DA(1)=PSAIEN,DA=PSAIEN1,DIE=DIC K DIC
 S PSALOCDR=$P($G(PSAIN),"^",7)
 S PSADELDR=$P($G(PSAIN),"^",6)
 S PSACSDR=$S($P(PSAIN,"^",10)="ALL CS":"A",$P(PSAIN,"^",9)="CS":"S",1:"N")
 S PSARECD=$P($G(PSAIN),"^",11)
 S PSAMV=$S(+$P(PSAIN,"^",12):$P(PSAIN,"^",12),1:"")
 S PSASUP=$S($P(PSAIN,"^",13)="SUP":1,1:"")
 ;DAVE B ( PSA*3*12) Invalid Concatenation of zero node
 S ^PSD(58.811,DA(1),1,DA,0)=$P(^(0),"^")_"^"_$P(PSAIN,"^",1)_"^P^"_$P(PSAIN,"^",3)_"^"_$G(PSALOCDR)_"^"_$G(PSADELDR)_"^"_$G(PSARECD)_"^"_$G(PSACSDR)_"^^"_DUZ_"^^"_$G(PSAMV)_"^"_$G(PSASUP)
 S DIK=DIE D IX^DIK
 K ^TMP($J,"PSADIF"),PSADIFLC ;*42 pre verify storage for  OU, DUOU, Cost, NDC changes
 S PSALINE=0 F  S PSALINE=$O(^XTMP("PSAPV",PSACTRL,"IT",PSALINE)) Q:PSALINE=""  D LINE
 D SCANDIF,MM ;*42 look for differences to drug file SEND EMAIL
 I PSACRED K DA S DA(1)=PSAIEN,DA=PSAIEN1,DIE="^PSD(58.811,"_DA(1)_",1,",DR="10///^S X=1" D ^DIE K DIE
 S $P(^PSD(58.811,PSAIEN,0),"^",2)=$P($G(^XTMP("PSAPV",PSACTRL,"DS")),"^")
 L -^PSD(58.811,PSAIEN,0)
 K ^XTMP("PSAPV",PSACTRL)
 Q
 ;
LINE ;Files line items.
 S PSADATA=^XTMP("PSAPV",PSACTRL,"IT",PSALINE) S:'$D(^PSD(58.811,PSAIEN,1,PSAIEN1,1,0)) DIC("P")=$P(^DD(58.8112,5,0),"^",2)
 ;PSA*3*31 Dave B - Check for invoice already in file
 S DA(2)=PSAIEN,DA(1)=PSAIEN1,(DA,X)=PSALINE,DIC="^PSD(58.811,"_DA(2)_",1,"_DA(1)_",1,",DIC(0)="L",DLAYGO=58.811 D ^DIC S PSAIEN2=+Y K DA,DIC,DLAYGO
 ;
 ;DAVEB PSA*3*3 (5may98)
 S PSADRG=$P($G(PSADATA),"^",6)
 S PSASYN=$P($G(PSADATA),"^",7)
 K PSAUNIT
 I $G(PSASYN)'="",$G(PSADRG)'="" S PSAUNIT=+$P($G(^PSDRUG(PSADRG,1,PSASYN,0)),"^",5)
 ;
 ;DAVE B (PSA*3*12) Assignment of order unit didn't take into 
 ;account the adjusted order unit.
 S PSAUNIT=$S($G(PSAUNIT):PSAUNIT,$P(PSADATA,"^",12)'="":$P(PSADATA,"^",12),+$P($P(PSADATA,"^",2),"~",2):+$P($P(PSADATA,"^",2),"~",2),1:0)  ;;*71
 S PSACS=$S($P(PSADATA,"^",19)="CS":1,1:0),PSANDC=$P($P(PSADATA,"^",4),"~"),PSAVSN=$P($P(PSADATA,"^",5),"~"),PSAUPC=$P($P(PSADATA,"^",26),"~")
 I PSANDC="",$P($P(PSADATA,"^",26),"~")'="" S PSANDC="S"_$P($P(PSADATA,"^",26),"~")
 S DA(2)=PSAIEN,DA(1)=PSAIEN1,DA=$S($D(PSAIEN2):PSAIEN2,1:PSALINE),DIE="^PSD(58.811,"_DA(2)_",1,"_DA(1)_",1,"
 ;DaveB (4may98) hard code filing data
 S $P(^PSD(58.811,DA(2),1,DA(1),1,DA,0),"^",3)=+PSADATA
 S $P(^PSD(58.811,DA(2),1,DA(1),1,DA,0),"^",11)=PSANDC
 S $P(^PSD(58.811,DA(2),1,DA(1),1,DA,0),"^",12)=PSAVSN
 S $P(^PSD(58.811,DA(2),1,DA(1),1,DA,0),"^",13)=PSAUPC
 S $P(^PSD(58.811,DA(2),1,DA(1),1,DA,0),"^",10)=PSACS
 S $P(^PSD(58.811,DA(2),1,DA(1),1,DA,0),"^",2)=PSADRG
 S $P(^PSD(58.811,DA(2),1,DA(1),1,DA,0),"^",4)=PSAUNIT
 S $P(^PSD(58.811,DA(2),1,DA(1),1,DA,0),"^",5)=$P(PSADATA,"^",3)
 S $P(^PSD(58.811,DA(2),1,DA(1),1,DA,0),"^",6)=DT
 S $P(^PSD(58.811,DA(2),1,DA(1),1,DA,0),"^",7)=DUZ
 ;BGN 67
 S $P(^PSD(58.811,DA(2),1,DA(1),3,DA,0),"^",1)=$P(PSADATA,"^",28)
 S $P(^PSD(58.811,DA(2),1,DA(1),3,DA,0),"^",2)=$P(PSADATA,"^",29)
 S $P(^PSD(58.811,DA(2),1,DA(1),3,DA,0),"^",3)=$P(PSADATA,"^",30)
 S $P(^PSD(58.811,DA(2),1,DA(1),3,DA,0),"^",4)=$P(PSADATA,"^",31)
 ;END 67
 S DIK=DIE D IX^DIK
 ;End PSA*3*7
 ;
 I +$P(PSADATA,"^",15)!($D(^XTMP("PSAPV",PSACTRL,"IT",PSALINE,"SUP"))) D ADJDRUG
 I $P(PSADATA,"^",8)'="" D QTY
 I +$P(PSADATA,"^",12) D OU
 I +$P(PSADATA,"^",23) D PRICE
 ;Adds the reorder level and/or dispense units per order unit
 I +$P(PSADATA,"^",7)!(+$P(PSADATA,"^",20))!(+$P(PSADATA,"^",21))!(+$P(PSADATA,"^",27)) D
 .S ^PSD(58.811,PSAIEN,1,PSAIEN1,1,PSAIEN2,2)=$P(PSADATA,"^",20)_"^"_$P(PSADATA,"^",21)_"^"_$S(+$P(PSADATA,"^",7):+$P(PSADATA,"^",7),1:0)_"^"_+$P(PSADATA,"^",27)
 ;Bgn 67
 I $P(PSADATA,"^",5)'="" S ^XTMP("PSAVSN",$P(PSADATA,"^",5))=$P(PSADATA,"^",28)_"^"_$P(PSADATA,"^",29)_"^"_$P(PSADATA,"^",30)_"^"_$P(PSADATA,"^",31)
 ;End 67
 K ^XTMP("PSAPV",PSACTRL,"IT",PSALINE)
 Q
ADJDRUG ;Records adjusted drug received
 S PSAFLD="D"
 I +$P(PSADATA,"^",15) S PSADJ=+$P(PSADATA,"^",15),PSADUZ=+$P(PSADATA,"^",16),PSADT=+$P(PSADATA,"^",17),PSAREA="" D RECORD Q
 I $D(^XTMP("PSAPV",PSACTRL,"IT",PSALINE,"SUP")) S PSASNODE=^XTMP("PSAPV",PSACTRL,"IT",PSALINE,"SUP"),PSADJ=$P(PSASNODE,"^",3),PSADUZ=+$P(PSASNODE,"^"),PSADT=+$P(PSASNODE,"^",2),PSAREA="" D RECORD
 Q
OU ;Records adjusted order unit
 S PSAFLD="O",PSADJ=+$P(PSADATA,"^",12),PSADUZ=+$P(PSADATA,"^",13),PSADT=+$P(PSADATA,"^",14),PSAREA=""
 D RECORD
 Q
PRICE ;Records adjusted price per order unit
 S PSAFLD="P",PSADJ=+$P(PSADATA,"^",23),PSADUZ=+$P(PSADATA,"^",24),PSADT=+$P(PSADATA,"^",25),PSAREA=""
 S:PSADJ'=+$P(PSADATA,"^",3) PSACRED=1
 D RECORD
 Q
QTY ;Records adjusted quantity received.
 S PSAFLD="Q",PSADJ=+$P(PSADATA,"^",8),PSADUZ=+$P(PSADATA,"^",9),PSADT=+$P(PSADATA,"^",10),PSAREA=$P(PSADATA,"^",11)
 S:PSADJ'=+$P(PSADATA,"^") PSACRED=1
 D RECORD
 Q
RECORD ;Adds adjusted data to DA ORDERS file
 K DA S DA(3)=PSAIEN,DA(2)=PSAIEN1,DA(1)=PSAIEN2,X=PSAFLD
 S:'$D(^PSD(58.811,PSAIEN,1,PSAIEN1,1,PSAIEN2,1,0)) DIC("P")=$P(^DD(58.81125,9,0),"^",2)
 ;PSA*3*27 (DAVE B) removed killing of DA variable on next line
 S DIC="^PSD(58.811,"_DA(3)_",1,"_DA(2)_",1,"_DA(1)_",1,",DIC(0)="L",DLAYGO=58.811 D ^DIC S PSAIEN3=+Y K DLAYGO
 ;
 ;PSA*3*3
 ;DAVEB Hard code filing
 S DIE=DIC,DA=PSAIEN3
 S $P(^PSD(58.811,DA(3),1,DA(2),1,DA(1),1,DA,0),"^",2)=PSADJ
 S $P(^PSD(58.811,DA(3),1,DA(2),1,DA(1),1,DA,0),"^",3)=$G(PSAREA)
 S $P(^PSD(58.811,DA(3),1,DA(2),1,DA(1),1,DA,0),"^",4)=DT
 S $P(^PSD(58.811,DA(3),1,DA(2),1,DA(1),1,DA,0),"^",5)=DUZ
 ;
 S DIK=DIE,DA=PSAIEN3 D IX1^DIK K DA,DIE,DIK,PSAFLD
 Q
 ;*42 CHANGES
SCANDIF ; inspect invoice for noted differences in OU,DUOU,PPDU,NDC
 ;NEEDS PSAIEN, PSAIEN1
 K ^TMP($J,"PSADIF"),PSADIFLC
 S PSALINE=0 F  S PSALINE=$O(^PSD(58.811,PSAIEN,1,PSAIEN1,1,PSALINE)) Q:PSALINE'>0  D CHECK
 Q
MM ;
 I $D(^TMP($J,"PSADIF")) D MESSAGE
 Q
CHECK ;Check line item for differences to drug file *42
 N ITM,ITMI,DRG,DRIEN,DIF,ZZ,XX,XXX,PCNT,PDIF,T,IENS
 ; use new API call to retrieve item fields see PSAUTL6
 D ITEM^PSAUTL6(PSAIEN,PSAIEN1,PSALINE,.ITM)
 D ITEM^PSAUTL6(PSAIEN,PSAIEN1,PSALINE,.ITMI,"I")
 I ITM(2)'>0 Q  ;zero quantity will not be filed
 S ITM("OU")=ITM(3),ITM("DUOU")=ITM(10),ITM("NDC")=ITM(13),ITM("PPOU")=ITM(4),ITM("PPDU")=$J(ITM("PPOU")/ITM("DUOU"),1,4)
 I ITMI(1)'?1.N S DRIEN=ITMI(1)
 I ITMI(1)?1.N S DRIEN=+ITMI(1)
 Q:'$D(^PSDRUG(DRIEN))
 S DRG("OU")=$$GET1^DIQ(50,DRIEN,12),DRG("DUOU")=$$GET1^DIQ(50,DRIEN,15),DRG("NDC")=$$GET1^DIQ(50,DRIEN,31),DRG("PPDU")=$$GET1^DIQ(50,DRIEN,16)
 K DIF
 F XX="OU","DUOU","NDC" I $D(DRG(XX)),ITM(XX)'=DRG(XX) S DIF(XX)=""
 I $G(DRG("PPDU")),ITM("PPDU")'=DRG("PPDU") S PCNT=.05*DRG("PPDU"),PDIF=DRG("PPDU")-ITM("PPDU") S:PDIF<0 PDIF=-1*PDIF S:PDIF>PCNT DIF("PPDU")=""
 S:ITM("OU")=""!(ITM("OU")=0) ITM("OU")="Blank",DIF("OU")=""  ;;*71
 S:DRG("OU")=""!(DRG("OU")=0) DRG("OU")="Blank",DIF("OU")=""  ;;*71
 I $D(DIF) D
 . F ZZ=" ",$J(ITM(.01),3)_"   "_ITM(1) D SET
 . S XXX="" F  S XXX=$O(DIF(XXX)) Q:XXX=""  D
 .. S ZZ="  ",T=XXX,ZZ=$$SETSTR^VALM1(T,ZZ,4,$L(T))
 .. S T="Old: "_DRG(XXX),ZZ=$$SETSTR^VALM1(T,ZZ,13,$L(T))
 .. S T="New: "_ITM(XXX),ZZ=$$SETSTR^VALM1(T,ZZ,36,$L(T))
 .. D SET
 Q
SET ;set differences into ^TMP
 S:'$G(PSADIFLC) PSADIFLC=3
 S ^TMP($J,"PSADIF",PSADIFLC,0)=ZZ,PSADIFLC=PSADIFLC+1
 Q
MESSAGE ;differences found, notify user and send message to g.PSA NDC UPDATES.
 K DIR N IENS
 S PSAORD=$$GET1^DIQ(58.811,PSAIEN,.01),IENS=PSAIEN1_","_PSAIEN
 S PSAINV=$$GET1^DIQ(58.8112,IENS,.01)
 S XMSUB="PRE Verify "_PSAORD_" : "_PSAINV_" Variance Report"
 S ^TMP($J,"PSADIF",1,0)=XMSUB,^TMP($J,"PSADIF",2,0)=" "
 W !,XMSUB,!
 W !,"Noted differences between the invoice line items and the drug file have",!,"been found. A mail message is being sent to G.PSA NDC UPDATES."
 W !!,"    Please check the message for accuracy.",!
 K DIR S DIR(0)="E",DIR("A")="<cr> - continue" D ^DIR
 K DIR
 S XMTEXT="^TMP($J,""PSADIF"",",XMY("G.PSA NDC UPDATES")=""
 D ^XMD
 K PSADIFLC,^TMP($J,"PSADIF")
 Q
