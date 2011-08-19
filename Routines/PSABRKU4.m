PSABRKU4 ;BIR/JMB-Upload and Process Prime Vendor Invoice Data - CONT'D ;7/23/97
 ;;3.0; DRUG ACCOUNTABILITY/INVENTORY INTERFACE;**26,64**; 10/24/97;Build 4
XTMP ;This modules copies the prime vendor data in ^TMP($J,"PSAPV SET") to
 ;^XTMP("PSAPV"). The data has passed all X12 checks.
 ;
 S X1=DT,X2=21 D C^%DTC L +^XTMP("PSAPV",0):$S($G(DILOCKTM)>0:DILOCKTM,1:3) I '$T Q
 S ^XTMP("PSAPV",0)=X_"^"_DT_"^Drug Accountability Prime Vendor Uploaded Invoice Data"
 ;
 ;Sets array of orders & invoices in XTMP (uploaded or processed).
 S PSACTRL=0 F  S PSACTRL=$O(^XTMP("PSAPV",PSACTRL)) Q:'PSACTRL  D
 .Q:'$D(^XTMP("PSAPV",PSACTRL,"IN"))
 .S PSAIN=^XTMP("PSAPV",PSACTRL,"IN")
 .;DAVE B PSA*3*3 - Incomplete invoice deletion
 .I $P(PSAIN,"^",2)=""!($P(PSAIN,"^",4)="") K ^XTMP("PSAPV",PSACTRL) Q
 .S PSADUP($P(PSAIN,"^",4),$P(PSAIN,"^",2))=$S($P(PSAIN,"^",8)="P":"P",1:"U")
DUPLICAT ;
 ;Sets XTMP if incoming order & invoice is not a duplicate.
 S (PSACTRL,PSADUP)=0
 F  S PSACTRL=$O(^TMP($J,"PSAPV SET",PSACTRL)) S PSASET=PSACTRL Q:PSACTRL=""  D  S PSACTRL=PSASET
DAV .;
 .I $D(^XTMP("PSAPV",PSASET,"IN")) S DATA=^("IN") I $P(^TMP($J,"PSAPV SET",PSACTRL,"IN"),"^",4)'=$P(DATA,"^",4),$P(^TMP($J,"PSAPV SET",PSACTRL,"IN"),"^",2)'=$P(DATA,"^",2) S PSACHKR=1
 .I $D(PSACHKR) F  S PSASET=$G(PSASET)+.01 I '$D(^XTMP("PSAPV",PSASET)) K PSACHKR Q
 .;
 .S PSASEG="" F  S PSASEG=$O(^TMP($J,"PSAPV SET",PSACTRL,PSASEG)) Q:PSASEG=""  S PSADUP=0 D
 ..I PSASEG'="IT" D  Q
 ...I PSASEG="IN" S PSAIN=^TMP($J,"PSAPV SET",PSACTRL,PSASEG) D  Q
 ....I $P(PSAIN,"^",2)=""!($P(PSAIN,"^",4)="") K ^TMP($J,"PSAPV SET",PSACTRL) Q
 ....D CHKDUP Q:PSADUP
 ....S ^XTMP("PSAPV",PSASET,"IN")=^TMP($J,"PSAPV SET",PSACTRL,PSASEG)
 ....D DATES
 ....S PSAORD=$P($G(^TMP($J,"PSAPV SET",PSACTRL,"IN")),"^",4),PSAINV=$P($G(^("IN")),"^",2),PSAORDDT=$P($G(^("IN")),"^",3),PSAINVDT=$P($G(^("IN")),"^")
 ....S PSAGUI2(PSAORD)="",PSAGUI3(PSAINV)=""
 ....S ^TMP($J,"PSA GUI",PSAORD,PSAINV)=""
 ...I PSASEG'="IN" S ^XTMP("PSAPV",PSASET,PSASEG)=^TMP($J,"PSAPV SET",PSACTRL,PSASEG)
 ..I PSASEG="IT" S PSALINE=0 F  S PSALINE=$O(^TMP($J,"PSAPV SET",PSACTRL,PSASEG,PSALINE)) Q:'PSALINE  S ^XTMP("PSAPV",PSASET,PSASEG,PSALINE)=^TMP($J,"PSAPV SET",PSACTRL,PSASEG,PSALINE),PSAGUI4=$G(PSAGUI4)+1
 .K ^TMP($J,"PSAPV SET",PSACTRL)
 .I '$D(^XTMP("PSAPV",PSASET,"IT")) K ^XTMP("PSAPV",PSASET)
 L -^XTMP("PSAPV",0)
 Q
 ;
CHKDUP ;Checks for duplicate orders & invoices and duplicates in XTMP.
 I $D(PSADUP($P(PSAIN,"^",4),$P(PSAIN,"^",2))) S PSASTA=PSADUP($P(PSAIN,"^",4),$P(PSAIN,"^",2)),PSADUP=1 D  Q
 .S X12="** Order# "_$P(PSAIN,"^",4)_", invoice# "_$P(PSAIN,"^",2)_" has been "
 .I PSASTA="U" S X12=X12_"uploaded and" D SETMSG^PSABRKU8 S X12="is awaiting processing. It cannot be uploaded more than once." D SETMSG^PSABRKU8
 .I PSASTA'="U" S X12=X12_" processed and" D SETMSG^PSABRKU8 S X12="is being prepared for verification. It cannot be uploaded more than once." D SETMSG^PSABRKU8
 .K ^TMP($J,"PSAPV SET",PSACTRL) Q
 ;
 Q:'$D(^PSD(58.811,"AORD",$P(PSAIN,"^",4),$P(PSAIN,"^",2)))
 ;
 ;Checks for duplicates in 58.811
 S PSAORD=$P(PSAIN,"^",4),PSAINV=$P(PSAIN,"^",2),PSAORDN=$O(^PSD(58.811,"B",PSAORD,0)) Q:'PSAORDN
 S PSAINVN=$O(^PSD(58.811,PSAORDN,1,"B",PSAINV,0)) Q:'PSAINVN
 Q:'$D(^PSD(58.811,PSAORDN,1,PSAINVN,0))
 S PSAIN=^PSD(58.811,PSAORDN,1,PSAINVN,0),PSASTA=$P(PSAIN,"^",3),PSAPC=$S(PSASTA="P":6,PSASTA="V"!(PSASTA="C"):8,1:0)
 S (PSADT,PSALINE)=0 F  S PSALINE=$O(^PSD(58.811,PSAORDN,1,PSAINVN,1,PSALINE)) Q:'PSALINE!($G(PSADT))  S PSADT=+$P($G(^PSD(58.811,PSAORDN,1,PSAINVN,1,PSALINE,0)),"^",PSAPC)
 S X12="** Order# "_PSAORD_" Invoice# "_PSAINV
 S:+PSADT PSADT=$E(PSADT,4,5)_"/"_$E(PSADT,6,7)_"/"_$E(PSADT,2,3)
 I PSASTA="P" S X12=X12_" has been processed"_$S(+PSADT:" on "_PSADT,1:"")_" and" D SETMSG^PSABRKU8 S X12="    is awaiting verification. It cannot be uploaded more than once." D SETMSG^PSABRKU8
 I PSASTA="V" S X12=X12_"   has been verified"_$S(+PSADT:" on "_PSADT,1:"")_"and" D SETMSG^PSABRKU8 S X12="   is updating the pharmacy location. It cannot be uploaded more than once." D SETMSG^PSABRKU8
 I PSASTA="C" S X12=X12_" has been completed." D SETMSG^PSABRKU8 S X12="   It cannot be uploaded more than once." D SETMSG^PSABRKU8
 ;
KILLDUP S PSADUP=1
 K ^TMP($J,"PSAPV SET",PSACTRL),^XTMP("PSAPV",PSASET)
 Q
PRT2 ;Extended help to second "Print invoices?"
 W !?5,"Enter YES to print all invoices that are not processed and",!?5,"the invoices that were processed while you were in this option.",!!?5,"Enter NO to exit the option."
 Q
YNPRINT ;Extended help to "Print invoices?"
 W !?5,"Enter YES to print the uploaded invoices. You",!?5,"can check the invoices prior to processing them.",!!?5,"Enter NO to not print the invoices."
 Q
 ;
YNPROCES ;Extended help to "Do you want to process the invoices now?"
 W !?5,"Enter YES to begin processing the uploaded invoices.",!!?5,"Enter NO if you do not want to process the invoices now. You can process"
 W !?5,"them later by selecting the ""Process Uploaded Prime Vendor Invoice Data"" option."
 Q
 ;
YNUPLOAD ;Extended help to "Are you ready to upload the prime vendor invoice data?"
 W !?5,"Enter YES to start uploading the invoices.",!?5,"Enter NO or ""^"" to exit the option."
 Q
 ;
DATES ;PSA*3*12 Check for Y2K compliance of dates
 S DATECHK=0
 F X=1,3,5,6 S XX=$P(^XTMP("PSAPV",PSASET,"IN"),"^",X) I $L(XX)=8 S XXX=($E(XX,1,4)-1700)_$E(XX,5,8),$P(^XTMP("PSAPV",PSASET,"IN"),"^",X)=XXX,DATECHK=1
 I DATECHK Q
 S LWRDT=$E(DT,1,3)-70,UPPRDT=$E(DT,1,3)+30
 F Y=1,3,5,6 S DT1=$E(DT,1)_$E($P(^XTMP("PSAPV",PSASET,"IN"),"^",Y),1,2),$P(^XTMP("PSAPV",PSASET,"IN"),"^",Y)=$S((DT1>LWRDT&(DT1<UPPRDT)):$E(DT1)_$P(^XTMP("PSAPV",PSASET,"IN"),"^",Y),1:($E(DT1,1)+1)_$P(^XTMP("PSAPV",PSASET,"IN"),"^",Y))
 F X=1,3,5,6 S XX=$P(^XTMP("PSAPV",PSASET,"IN"),"^",X) I XX>(DT+300000) S XXX=$E(XX,1)-2,$P(^XTMP("PSAPV",PSASET,"IN"),"^",X)=XXX_$E(XX,2,99)
 F X=1,3,5,6 S XX=$P(^XTMP("PSAPV",PSASET,"IN"),"^",X) I XX'?7N S $P(^XTMP("PSAPV",PSASET,"IN"),"^",X)=DT
 K LWRDT,UPPRDT,DT1,X,Y,XXX,XX
