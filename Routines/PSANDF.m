PSANDF ;BIR/JMB-Process Uploaded Prime Vendor Invoice Data - CONT'D ;7/23/97
 ;;3.0; DRUG ACCOUNTABILITY/INVENTORY INTERFACE;**8,11,58**; 10/24/97
 ;This routine searches NDF for the NDC. If it is not found, the user
 ;is asked to select the drug from the DRUG file.
 ;
 I PSANDC="",$P(PSADATA,"^",26)'="" D  Q
 .I +$P($P(PSADATA,"^",26),"~",2) D
 ..K PSASUP S PSASUP="S"_$P(PSADATA,"^",26),(PSACNT,PSAIEN50)=0
 ..F  S PSAIEN50=$O(^PSDRUG("C",PSASUP,PSAIEN50)) Q:PSAIEN50=""  D
 ...S PSASSUB=0 F  S PSASSUB=$O(^PSDRUG("C",PSASUP,PSAIEN50,PSASSUB)) Q:'PSASSUB  S PSACNT=PSACNT+1,PSASUP(PSACNT)=PSAIEN50_"^"_PSASSUB
 ..I 'PSACNT D  Q
 ...W !,"The vendor sent no NDC or UPC for the item."
 ...D ASKDRUG S PSADATA=^XTMP("PSAPV",PSACTRL,"IT",PSALINE)
 ..I PSACNT=1 D  Q
 ...S PSAIEN=$P(PSASUP(1),"^"),$P(^XTMP("PSAPV",PSACTRL,"IT",PSALINE),"^",6)=PSAIEN,PSASUB=$P(PSASUP(1),"^",2),$P(^(PSALINE),"^",7)=PSASUB
 ...S PSANDC=PSASUP,$P(^XTMP("PSAPV",PSACTRL,"IT",PSALINE),"^",4)=PSANDC,PSAVSN=$P($G(^PSDRUG(PSAIEN,1,PSASUB,0)),"^",4),$P(^XTMP("PSAPV",PSACTRL,"IT",PSALINE),"^",5)=PSAVSN
 ...S PSADATA=^XTMP("PSAPV",PSACTRL,"IT",PSALINE)
 ..I PSACNT>1 S PSACNT=$O(PSASUP(0)) D:PSACNT MANYUPCS^PSAPROC5
 ;
LOOKNDF S PSACNT=0,X=$$PSA^PSNAPIS(PSANDC,.PSALIST),PSACNT=X
 K ^TMP("PSANDF",$J) S X=0 F  S X=$O(PSALIST(X)) Q:X'>0  S ^TMP("PSANDF",$J,X)=PSALIST(X)
 ;
 ;DAVEB (PSA*3*11)
 I $D(^TMP("PSANDF",$J)) S XX=$O(^TMP("PSANDF",$J,0)),PSAVAPN=$P($G(^PSDRUG(XX,"ND")),"^",2) K XX
 I $G(PSACNT)>0 S X=0 F  S X=$O(PSALIST(X)) Q:X'>0  I '$D(^PSDRUG(X,"I")) S ^TMP("PSANDF",$J,X)=$P(PSALIST(X),"^")
 I '$D(PSAVAPN),$D(PSALIST) S PSAVAPN=$O(PSALIST(0)),PSAVAPN=$S('$D(^PSDRUG(PSAVAPN,"ND")):"Unknown",1:$P($G(^PSDRUG(PSAVAPN,"ND")),"^",2))
 K PSALIST,X
NONE I 'PSACNT D  Q
 .I +$P($P(^XTMP("PSAPV",PSACTRL,"IT",PSALINE),"^",4),"~",2)!($P($P(^(PSALINE),"^",4),"~",3)'="") D ^PSAPROC4
 .E  D ASKDRUG
 I PSACNT=1 S PSAVAPN=$P($G(^PSDRUG($O(^TMP("PSANDF",$J,0)),"ND")),"^",2) D ONE Q
 ;
MANY ;Display for selection if more than 1 drug is found for the Product Name
 W !!,"The NDC has the VA Product Name of "_PSAVAPN_".",!,"The following drugs have the same VA Product Name.",!
 S (PSACNT,PSAGET,PSAIEN50)=0 F  S PSAIEN50=+$O(^TMP("PSANDF",$J,PSAIEN50)) Q:'PSAIEN50  D  Q:PSAGET!(+$G(PSAIEN))
 .S PSACNT=PSACNT+1,^TMP("PSACNT",$J,PSACNT)=PSAIEN50
 .W !?2,PSACNT_". "_^TMP("PSANDF",$J,PSAIEN50)
 .I PSACNT#5=0 D  Q:PSAGET!($G(PSAIEN))
 ..W ! S DIR(0)="N^1:"_PSACNT,DIR("A",1)="Select the received drug or",DIR("A")="enter ""^"" to select the drug from the DRUG file.",DIR("?",1)="Choose the drug you received and assign it to the line item."
 ..S DIR("?")="To exit the list and select the drug from the DRUG file, enter ""^"".",DIR("??")="^D SELNDF^PSANDF1" D ^DIR K DIR I $G(DUOUT) S PSAGET=1 Q
 ..I $G(DTOUT) S PSAOUT=1 Q
 ..I +Y S PSAIEN=^TMP("PSACNT",$J,+Y),$P(^XTMP("PSAPV",PSACTRL,"IT",PSALINE),"^",15)=PSAIEN,$P(^(PSALINE),"^",16)=DUZ,$P(^(PSALINE),"^",17)=DT
 I '$G(PSAIEN),'PSAOUT,PSACNT#5'=0 D  G:Y="^" ASKDRUG Q:PSAOUT!($G(PSAIEN))
 .W ! S DIR(0)="N^1:"_PSACNT,DIR("A",1)="Select the received drug or",DIR("A")="enter ""^"" to select the drug from the DRUG file."
 .S DIR("?")="Select the drug you received or enter ""^""  to select the drug from the DRUG file.",DIR("??")="^D SELNDF^PSANDF1" D ^DIR K DIR Q:Y="^"
 .I $G(DTOUT) S PSAOUT=1 Q
 .S PSAIEN=^TMP("PSACNT",$J,+Y),$P(^XTMP("PSAPV",PSACTRL,"IT",PSALINE),"^",15)=PSAIEN,$P(^(PSALINE),"^",16)=DUZ,$P(^(PSALINE),"^",17)=DT,PSADATA=^(PSALINE) D EDITDISP^PSAUTL1
 K ^TMP("PSACNT",$J,PSACNT),^TMP("PSANDF",$J)
 Q:+$G(PSAIEN)!(PSAOUT)
 I +$P($P(^XTMP("PSAPV",PSACTRL,"IT",PSALINE),"^",4),"~",2),$P($P(^(PSALINE),"^",4),"~",3)'="" G ^PSAPROC4
 ;
ASKDRUG ;If the NDC found by searching NDF is not correct OR if the NDC can't
 ;be found, the user is asked to select the drug.
 N PSADRG
 W !!,"If the item will never be in the DRUG, press the Return key then",!,"answer YES to the ""Is this a supply item?"" prompt. To bypass this",!,"line item, enter ""^"" then press the Return key.",!
 S (PSASKIP,PSAPASS)=0,DIC("A")="Select Drug: ",DIC(0)="AEMZQ",DIC="^PSDRUG("
 D ^DIC K DIC I $G(DTOUT)!($G(DUOUT)) S PSAOUT=1 Q
 S PSAREA="",PSADRG=Y K Y ;; <<*58
 I +PSADRG>0 D
 .W !!," The selection is:  ",$P(PSADRG,U,2)
 .K DIR S DIR(0)="Y",DIR("B")="Y",DIR("A")="Is this correct ?" D ^DIR K DIR
 .K:'Y PSADRG
 I $D(Y),Y<1 G ASKDRUG ;<<*58
 I +PSADRG=-1 D  Q:PSASUPP  Q:PSASKIP
 .D SUPPLY Q:PSAOUT
 .I 'PSASUPP S PSASKIP=1 Q
 .S PSAIEN=0,^XTMP("PSAPV",PSACTRL,"IT",PSALINE,"SUP")=DUZ_"^"_DT_"^"_PSAREA,$P(^XTMP("PSAPV",PSACTRL,"IT",PSALINE),"^",18)="P",PSADATA=^(PSALINE)
 S PSAIEN=+PSADRG K ^XTMP("PSAPV",PSACTRL,"IT",PSALINE,"SUP") ;*58
 S $P(^XTMP("PSAPV",PSACTRL,"IT",PSALINE),"^",15)=+PSADRG,$P(^(PSALINE),"^",16)=DUZ,$P(^(PSALINE),"^",17)=DT,PSADATA=^(PSALINE) ;*58
 D EDITDISP^PSAUTL1
 ;
CHECK I $G(PSANDC)'="" D  Q
 .S $P(^XTMP("PSAPV",PSACTRL,"IT",PSALINE),"^",4)=PSANDC,PSAFND=0
 .S PSASUB=0 F  S PSASUB=+$O(^PSDRUG(PSAIEN,1,PSASUB)) Q:'PSASUB  I $P($G(^PSDRUG(PSAIEN,1,PSASUB,0)),"^")=PSANDC S PSAFND=1 Q
 .I PSAFND S $P(^XTMP("PSAPV",PSACTRL,"IT",PSALINE),"^",7)=PSASUB
 ;
 S $P(^XTMP("PSAPV",PSACTRL,"IT",PSALINE),"^",7)="0~1"
 I $P($P(^XTMP("PSAPV",PSACTRL,"IT",PSALINE),"^",4),"~")="",$P($P(^(PSALINE),"^",26),"~")="" D
 .W !,"The vendor did not send a NDC or UPC for the drug. Enter the",!,"NDC if it is available. Enter the UPC if you do not know the NDC.",!
 .S DIR(0)="SA^N:NDC;U:UPC",DIR("A")="Will you enter the NDC or UPC? ",DIR("B")="N",DIR("??")="^D NDCUPC^PSANDF1" D ^DIR K DIR I $G(DIRUT) S PSAOUT=1 Q
 .I Y="N" D GETNDC Q:PSAOUT  S PSANDC=Y,$P(^XTMP("PSAPV",PSACTRL,"IT",PSALINE),"^",4)=PSANDC
 .I Y="U" D GETUPC Q:PSAOUT  S PSANDC="S"_Y,PSAUPC=Y,$P(^XTMP("PSAPV",PSACTRL,"IT",PSALINE),"^",4)=PSANDC,$P(^(PSALINE),"^",26)=PSAUPC
 Q
 ;
ONE ;Display for selection if 1 drug is found for that Product Name.
 S PSAIEN50=$O(^TMP("PSANDF",$J,0))
 W !!,"The NDC has the VA Product Name of "_PSAVAPN_"."
 S DIR("A")="Is "_^TMP("PSANDF",$J,PSAIEN50)_" the drug you received",DIR(0)="Y",DIR("B")="N"
 S DIR("?",1)="Enter Yes if the drug is the one you received for this line item.",DIR("?")="Enter No if it is not the drug you received.",DIR("??")="^D NDFDRG^PSANDF1"
 D ^DIR K DIR I $G(DIRUT) S PSAOUT=1 Q
 I +Y S PSAIEN=+PSAIEN50,$P(^XTMP("PSAPV",PSACTRL,"IT",PSALINE),"^",15)=PSAIEN,$P(^(PSALINE),"^",16)=DUZ,$P(^(PSALINE),"^",17)=DT K ^TMP("PSANDF",$J) D EDITDISP^PSAUTL1 Q
 D ASKDRUG
 Q
 ;
GETNDC ;Gets NDC for selected drug.
 S DIR(0)="F^11,11",DIR("A")="NDC",DIR("?")="Enter the 11-digit National Drug Code. Do not enter dashes",DIR("??")="^D NDC^PSANDF1" ;*58
 D ^DIR K DIR I $G(DIRUT) S PSAOUT=1 Q
 I Y'?11N W !,"You must enter exactly eleven numbers." G GETNDC ;*58
 Q
GETUPC ;Gets UPC for selected drug.
 S DIR(0)="F^1:30",DIR("A")="UPC",DIR("?")="Enter the Universal Product Code",DIR("??")="^D UPC^PSANDF1"
 D ^DIR K DIR I $G(DIRUT) S PSAOUT=1 Q
 Q
SUPPLY ;Asks if item is a supply. If so, asks for supply info.
 S DIR(0)="Y",DIR("A")="Is this a supply item",DIR("?")="Enter YES if the item is not and will never be in the DRUG file",DIR("??")="^D SUP^PSANDF1" D ^DIR K DIR S PSASUPP=Y Q:$G(DIRUT)
 I 'PSASUPP S PSAPASS=1 Q
 W ! S DIR(0)="F^3:30",DIR("A",1)="Enter either a description of the item or",DIR("A")="the reason why the item is not in the DRUG file"
 S DIR("?",1)="If the item is a supply, enter the name of the supply",DIR("?")="or a reason why this item is not in the DRUG file.",DIR("??")="^D REA^PSANDF1" D ^DIR K DIR S PSAREA=Y I $G(DTOUT)!($G(DUOUT)) S PSAOUT=1
 S:PSAREA="" PSAREA="SUPPLY ITEM"
 Q:$G(PSAVER)
 S $P(^XTMP("PSAPV",PSACTRL,"IT",PSALINE),"^",15)="",$P(^(PSALINE),"^",16)="",$P(^(PSALINE),"^",17)=""
 Q
