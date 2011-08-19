PSAPTCH ;BHM/DAV - FIND INVOICES PROCESSED BY CONTROLLED SUBS;
 ;;3.0; DRUG ACCOUNTABILITY/INVENTORY INTERFACE;**21**; 10/24/97
 ;CS() = array contains item numbers of processed CS invoice
 ;PSACSERR =error flag set
 ;
 D Q
 ;
1 ;Check for uploaded CS invoice
 ;PSAIN=^XTMP("PSAPV",PSACTRL,"IN")
 S PSAUPORD=$P(PSAIN,"^",4) ;Incoming Order Number
 S PSAUPINV=$P(PSAIN,"^",2) ;Incoming Invoice Number
 I $G(PSAUPORD)="" K ^XTMP("PSAPV",PSACTRL) S PSAINVDL=1 Q
 I $G(PSAUPINV)="" K ^XTMP("PSAPV",PSACTRL) S PSAINVDL=1 Q
 I $L(PSAIN)'>10 K ^XTMP("PSAPV",PSACTRL) S PSAINVDL=1 Q
 S Y=$P(PSAIN,"^",1) X ^DD("DD") S PSAUPDT1=Y ;Invoice Date
 S Y=$P(PSAIN,"^",3) X ^DD("DD") S PSAUPDT2=Y ;Order Date
 S INVITM=0 F  S INVITM=$O(^XTMP("PSAPV",PSACTRL,"IT",INVITM)) Q:INVITM'>0  S INV(INVITM)=^XTMP("PSAPV",PSACTRL,"IT",INVITM),INVCNT=$G(INVCNT)+1
 I '$D(^PSD(58.811,"AORD",PSAUPORD,PSAUPINV)) G Q
 W @IOF,!,"** WARNING **",!!,"P.O. Number    : ",PSAUPORD,!,"Invoice Number : ",PSAUPINV,!
 K PSAORD,ORDIEN,INVIEN,CSINV
 S ORDIEN=$O(^PSD(58.811,"AORD",PSAUPORD,PSAUPINV,0)) ;Order # IEN
 S INVIEN=$O(^PSD(58.811,"AORD",PSAUPORD,PSAUPINV,ORDIEN,0)) ;Invoice # IEN
 S PSDCNT=0,X=0 F  S X=$O(^PSD(58.811,ORDIEN,1,INVIEN,1,X)) Q:X'>0  S PSDCNT=$G(PSDCNT)+1
 ;
 S PSASTAS=$P($G(^PSD(58.811,ORDIEN,1,INVIEN,0)),"^",3),PSASTAS=$S(PSASTAS="P":"PROCESSED",PSASTAS="V":"VERIFIED",PSASTAS="C":"COMPLETED",1:"UNKNOWN")
 W !,"Incoming",?40,"Already Marked as "_" * "_PSASTAS_" *",!,"Invoice file",?40,"in Drug Accountability Order file",! F X=1:1:(IOM-1) W "="
 S Y=$P($G(^PSD(58.811,ORDIEN,1,INVIEN,0)),"^",4) X ^DD("DD") W !,PSAUPDT2,?16," <-- Order Date --> ",?40,Y
 S Y=$P($G(^PSD(58.811,ORDIEN,1,INVIEN,0)),"^",2) X ^DD("DD") W !,PSAUPDT1,?15," <-- Invoice Date --> ",?40,Y
CHECK W !,?3,$J($G(INVCNT),8),?16," <-- Line Items -->",?40,$G(PSDCNT),!!
 ;
CMPRE R !,"Do you want to compare item? NO// ",AN:DTIME I AN["^"!(AN="") G ASK
 S AN=$E(AN) I "yYnN"'[AN W !,"Answer 'Y'es to display the items from the invoice file, as well as the items",!,"already uploaded.",! G CMPRE
 I "nN"[AN G ASK
 S X=0 F  S X=$O(^XTMP("PSAPV",PSACTRL,"IT",X)) Q:X=""  S DATA=$G(^XTMP("PSAPV",PSACTRL,"IT",X)),PSAITM(+DATA)=DATA
 S X=0 F  S X=$O(^PSD(58.811,ORDIEN,1,INVIEN,1,X)) Q:X=""  S DATA=$G(^PSD(58.811,ORDIEN,1,INVIEN,1,X,0)),PSAUPITM(+DATA)=DATA
 ;
ASK R !!,"Do you want to delete the incoming invoice ? NO// ",AN:DTIME G Q:AN["^" I "Nn"[AN G Q
 I "?"[AN W !!,"Answer 'Y'es, and the incoming invoice will be deleted.",! G ASK
 I AN="" G Q
 I "Yy"[AN K ^XTMP("PSAPV",PSACTRL) S PSAINVDL=1 Q
 ;
 ;Kill incoming invoice.
Q K AN,CS,CSCNT,CSIEN,CSINV,DATA,FOUND,INV,INVCNT,INVDEL,INVIEN,INVITM,LINEITM,ORDIEN,PSAORD,PSAUPDT1,PSAUPDT2,PSAUPINV,PSAUPORD,PSDCNT,X,XX,Y Q
PSAOLD ;Entry point for deleting old invoices
 I '$D(^XTMP("PSAPV")) W !,"Sorry, there aren't any invoices on file." G Q
ASKDT S %DT="A",%DT("A")="Delete invoices older than what date: " D ^%DT
 I Y'<DT W !,"Sorry, the date has to be in the past." K Y G ASKDT
 S PSAKLDT=Y
 ;
 S PSACTRL=0 F  S PSACTRL=$O(^XTMP("PSAPV",PSACTRL)) Q:PSACTRL'>0  S DATA=$G(^XTMP("PSAPV",PSACTRL,"IN")) D
 .I $G(DATA)="" Q
 .S PSAINVDT=$P(^XTMP("PSAPV",PSACTRL,"IN"),"^",1)
 .I PSAINVDT<PSAKLDT K ^XTMP("PSAPV",PSACTRL) W "."
 W !,"Finished" K PSACTRL,PSAINVDT,PSAKLDT Q
