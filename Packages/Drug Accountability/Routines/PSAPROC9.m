PSAPROC9 ;BIR/JMB-Process Uploaded Prime Vendor Invoice Data - CONT'D ;8/19/97
 ;;3.0; DRUG ACCOUNTABILITY/INVENTORY INTERFACE;**39**; 10/24/97
 ;This routine processes the line item when the user selects automatic
 ;processing.
 ;
 S (PSACONT,PSADU,PSANEXT)=0
 I '+$P(PSADATA,"^",6),PSANDC="" D  Q:PSAOUT  G:PSANEXT NEXT
 .I +$P($P(PSADATA,"^",5),"~",2) D MANYVSNS^PSAPROC4 D:PSAOUT CONT Q
 .I PSAVSN="" D  Q:PSAOUT  G:PSANEXT NEXT
 ..I +$P($P(PSADATA,"^",26),"~",2) D ^PSAPROC5 D:PSAOUT CONT Q
 ..I +$P($P(PSADATA,"^",26),"~",3) D SUPDIFF^PSAPROC5 D:PSAOUT CONT
 I '+$P(PSADATA,"^",6),'+$P(PSADATA,"^",15),PSANDC'="" D ^PSANDF D:PSAOUT CONT Q:PSAOUT
 I PSANDC'="" D  Q:PSAOUT  G:PSANEXT NEXT
 .I +$P($P(PSADATA,"^",4),"~",2) D MANYNDCS^PSAPROC4 D:PSAOUT CONT Q
 .I $P($P(PSADATA,"^",4),"~",3)'="" D VSNDIFF^PSAPROC5 D:PSAOUT CONT
 I +$P($P(PSADATA,"^",5),"~",2) D MANYVSNS^PSAPROC4 D:PSAOUT CONT Q:PSAOUT  G:PSANEXT NEXT
 ;VMP OIFO BAY PINES;VGF;PSA*3.0*39
 I $P($P(PSADATA,"^",5),"~",3)]"" D NDCDIFF^PSAPROC5 D:PSAOUT CONT Q:PSAOUT
NEXT Q:PSACONT
 S PSADATA=^XTMP("PSAPV",PSACTRL,"IT",PSALINE)
 I '+$P(PSADATA,"^",6),'+$P(PSADATA,"^",15),'$D(^XTMP("PSAPV",PSACTRL,"IT",PSALINE,"SUP")) D:'$G(PSAPASS) ASKDRUG^PSANDF D:PSAOUT CONT Q:PSAOUT  S PSADATA=^XTMP("PSAPV",PSACTRL,"IT",PSALINE)
 Q:$G(PSAPASS)
 I $G(PSASUPP) S PSALINES=PSALINES+1 Q
 S PSAIEN=$S(+$P(PSADATA,"^",15):+$P(PSADATA,"^",15),1:+$P(PSADATA,"^",6))
 I PSAIEN S $P(^XTMP("PSAPV",PSACTRL,"IT",PSALINE),"^",19)=$S($P($G(^PSDRUG(PSAIEN,2)),"^",3)["N":"CS",1:"")
 I PSAIEN,PSANDC'="" S PSASUB=0 F  S PSASUB=$O(^PSDRUG("C",PSANDC,PSAIEN,PSASUB)) Q:'PSASUB  I $P($G(^PSDRUG(PSAIEN,1,PSASUB,0)),"^")=PSANDC Q
 S $P(^XTMP("PSAPV",PSACTRL,"IT",PSALINE),"^",7)=$S(+$G(PSASUB):PSASUB,1:"0~1")
QTY I '+PSADATA,$P(PSADATA,"^",8)="" D QTY^PSAPROC3 D:PSAOUT CONT Q:PSAOUT
OU I '+$P($P(PSADATA,"^",2),"~",2),'+$P(PSADATA,"^",12) D  D:PSAOUT CONT Q:PSAOUT
 .I PSAIEN,PSASUB,'$P($G(^PSDRUG(PSAIEN,1,PSASUB,0)),"^",5) D GETOU^PSAPROC3 Q
 .I PSAIEN,'PSASUB D GETOU^PSAPROC3
DU I PSAIEN,$P($G(^PSDRUG(PSAIEN,660)),"^",8)="" D DU^PSAPROC8 D:PSAOUT CONT Q:PSAOUT
DUOU ;If drug has synonym & no conv factor set conv factor in 50.
 I PSAIEN,PSASUB,$D(^PSDRUG(PSAIEN,1,PSASUB,0)),'+$P(^PSDRUG(PSAIEN,1,PSASUB,0),"^",7),'+$P(PSADATA,"^",20) D DUOU^PSAPROC8 D:PSAOUT CONT Q:PSAOUT
 ;If drug doesn't have synonym & disp units/order unit, store disp units/order unit in XTMP.
 I PSAIEN,'PSASUB,'+$P(PSADATA,"^",20) D DUOU^PSAPROC3 D:PSAOUT CONT Q:PSAOUT
PRICE I '+$P(PSADATA,"^",3) D PRICE^PSAPROC3 D:PSAOUT CONT Q:PSAOUT
NOTCS ;If drug is not a CS & no stock level/reorder level, store in XTMP.
 S PSADATA=^XTMP("PSAPV",PSACTRL,"IT",PSALINE)
 I $P(PSADATA,"^",19)'="CS" D  Q:PSAOUT
 .I '+$P(PSAIN,"^",7) D GETLOC D EDITDISP^PSAUTL1,END^PSAPROC D:PSAOUT CONT Q:PSAOUT
 .I $P(PSADATA,"^",19)'="CS",+$P(PSAIN,"^",7),+$P($G(^PSD(58.8,+$P(PSAIN,"^",7),0)),"^",14) D  Q:PSAOUT
 ..I '+$P($G(^PSD(58.8,+$P(PSAIN,"^",7),1,PSAIEN,0)),"^",3),'+$P(PSADATA,"^",27) S PSALOC=$P(PSAIN,"^",7) D STOCK^PSAPROC8 D:PSAOUT CONT Q:PSAOUT
 ..I '+$P($G(^PSD(58.8,+$P(PSAIN,"^",7),1,PSAIEN,0)),"^",5),'+$P(PSADATA,"^",21) S PSALOC=$P(PSAIN,"^",7) D REORDER^PSAPROC8 D:PSAOUT CONT
CS ;If drug is a CS & no stock level/reorder level, store in XTMP.
 I $P(PSADATA,"^",19)="CS" D  Q:PSAOUT
 .S PSACS=PSACS+1
 .I '+$P(PSAIN,"^",12) D MASTER D EDITDISP^PSAUTL1,END^PSAPROC D:PSAOUT CONT Q:PSAOUT
 .I +$P(PSAIN,"^",12),+$P($G(^PSD(58.8,+$P(PSAIN,"^",12),0)),"^",14) D  Q:PSAOUT
 ..I '+$P($G(^PSD(58.8,+$P(PSAIN,"^",12),1,PSAIEN,0)),"^",3),'+$P(PSADATA,"^",27) S PSALOC=$P(PSAIN,"^",12) D STOCK^PSAPROC8 S PSALOC=+$P(PSAIN,"^",7),PSAMV=+$P(PSAIN,"^",12) D:PSAOUT CONT Q:PSAOUT
 ..I '+$P($G(^PSD(58.8,+$P(PSAIN,"^",12),1,PSAIEN,0)),"^",5),'+$P(PSADATA,"^",21) S PSALOC=$P(PSAIN,"^",12) D REORDER^PSAPROC8 S PSALOC=+$P(PSAIN,"^",7),PSAMV=+$P(PSAIN,"^",12) D:PSAOUT CONT
 D CHECK^PSANDF D:PSAOUT CONT Q:PSAOUT  D SETLINE^PSAPROC3 W !
 Q
 ;
CONT ;Asks if user wants to continue processing invoice.
 S PSAINV=$P(^XTMP("PSAPV",PSACTRL,"IN"),"^",2)
 W ! S DIR(0)="Y",DIR("B")="Y",DIR("A")="Do you want to continue processing invoice# "_PSAINV,DIR("?")="Enter YES to process the next line item.",DIR("?")="Enter NO to stop processing the invoice.",DIR("??")="^D CONTYN^PSAPROC9"
 D ^DIR K DIR S PSACONT=Y Q:$G(DIRUT)!('Y)
 S PSAOUT=0
 Q
MASTER ;Assigns invoice to Master Vault
 S PSAINV=$P($G(^XTMP("PSAPV",PSACTRL,"IN")),"^",2)
 S (PSAMVN,PSAMV)=0 F  S PSAMV=+$O(^PSD(58.8,"ADISP","M",PSAMV)) Q:'PSAMV  D
 .Q:'$D(^PSD(58.8,PSAMV,0))!($P($G(^PSD(58.8,PSAMV,0)),"^")="")
 .I +$G(^PSD(58.8,PSAMV,"I")),+^PSD(58.8,PSAMV,"I")'>DT Q
 .S PSAMVN=PSAMVN+1,PSAONEMV=PSAMV,PSAMV($P(^PSD(58.8,PSAMV,0),"^"),PSAMV)=""
 I 'PSAMVN W !!,"No master vaults are set up. You must set up a master vault then",!,"select the Process Uploaded Prime Vendor Invoices Data option." S PSAOUT=1 Q
 I PSAMVN=1 D  Q
 .S PSAMV=PSAONEMV
 .W @IOF,!?22,"<<< ASSIGN A MASTER VAULT SCREEN >>>"
 .W !!,"Controlled substances on the invoice has been",!,"automatically assigned to the Master Vault."
 .W !!,$P(^PSD(58.8,PSAMV,0),"^"),!,PSASLN
 .W !,"Order#: "_PSAORD_"  Invoice#: "_PSAINV_"  Invoice Date: "_$$FMTE^XLFDT(+PSAIN)
 .S $P(^XTMP("PSAPV",PSACTRL,"IN"),"^",12)=PSAMV,PSAIN=^("IN")
 .D END^PSAPROC
 I PSAMVN>1 D DISPMV W !,"Order#: "_PSAORD_"  Invoice#: "_PSAINV_"  Invoice Date: "_$$FMTE^XLFDT(+PSAIN) D SELMV
 Q
 ;
DISPMV ;Displays active master vaults
 W @IOF,!?22,"<<< ASSIGN A MASTER VAULT SCREEN >>>",!,PSASLN
 S PSA=0,PSAMVA="" F  S PSAMVA=$O(PSAMV(PSAMVA)) Q:PSAMVA=""  D
 .S PSAMVIEN=0 F  S PSAMVIEN=$O(PSAMV(PSAMVA,PSAMVIEN)) Q:'PSAMVIEN  D
 ..S PSA=PSA+1,PSAVAULT(PSA,PSAMVA,PSAMVIEN)=""
 ..W !,$J(PSA,2)_".",?4,PSAMVA
 W !
 Q
 ;
SELMV ;Select displayed master vaults
 W ! S DIR(0)="NO^1:"_PSA,DIR("A")="Select Master Vault",DIR("?")="Select the Master Vault that received the invoice's drugs"
 S DIR("??")="^D MV^PSAPROC" D ^DIR K DIR Q:Y=""  I $G(DIRUT) S PSAOUT=1 Q
 S PSASEL1=Y
 S PSAMVA=$O(PSAVAULT(PSASEL1,"")) Q:PSAMVA=""  S PSAMVIEN=+$O(PSAVAULT(PSASEL1,PSAMVA,0)) Q:'PSAMVIEN  S PSAMV=PSAMVIEN,$P(^XTMP("PSAPV",PSACTRL,"IN"),"^",12)=PSAMV,PSAIN=^("IN")
 Q
 ;
GETLOC ;Gets pharmacy locations
 S PSAINV=$P($G(^XTMP("PSAPV",PSACTRL,"IN")),"^",2)
 S (PSALOC,PSANUM)=0 F  S PSALOC=+$O(^PSD(58.8,"ADISP","P",PSALOC)) Q:'PSALOC  D
 .Q:'$D(^PSD(58.8,PSALOC,0))!($P($G(^PSD(58.8,PSALOC,0)),"^")="")
 .I +$G(^PSD(58.8,PSALOC,"I")),+^PSD(58.8,PSALOC,"I")'>DT Q
 .S PSANUM=PSANUM+1,PSAONE=PSALOC,PSAISIT=+$P(^PSD(58.8,PSALOC,0),"^",3),PSAOSIT=+$P(^(0),"^",10)
 .D SITES^PSAUTL1 S PSALOCA($P(^PSD(58.8,PSALOC,0),"^")_PSACOMB,PSALOC)=PSAISIT_"^"_PSAOSIT
 G:'PSANUM NONE G:PSANUM=1 ONE G:PSANUM>1 MANY
 ;
NONE ;No DA pharmacy locations
 W !!,"There are no Drug Accountability pharmacy locations.",!!,"Use the Set Up/Edit a Pharmacy Location option on Pharmacy Location menu"
 W !,"to setup one or more pharmacy locations. Then select the Process Uploaded",!,"Prime Vendor Invoice Data option to process the invoices."
 Q
 ;
ONE ;Only one location
 S PSACNT=0,PSALOC=PSAONE,PSALOCN=$O(PSALOCA(""))
 W @IOF,!?19,"<<< ASSIGN A PHARMACY LOCATION SCREEN >>>"
 W !!,"The non-controlled substance items on the invoice have",!,"been automatically assigned to the Pharmacy Location.",!
 W:$L(PSALOCN)>76 !,$P(PSALOCN,"(IP)",1)_"(IP)",!?17,$P(PSALOCN,"(IP)",2) W:$L(PSALOCN)<77 PSALOCN W !,PSASLN
 W !!,"Order#: "_PSAORD_"  Invoice#: "_PSAINV_"  Invoice Date: "_$$FMTE^XLFDT(+PSAIN)
 S $P(^XTMP("PSAPV",PSACTRL,"IN"),"^",7)=PSALOC,PSAIN=^("IN")
 Q
 ;
MANY ;If more than one pharmacy location, display invoices.
 D DISPLOC W !,"Order#: "_PSAORD_"  Invoice#: "_PSAINV_"  Invoice Date: "_$$FMTE^XLFDT(+PSAIN) D SELLOC
 Q
 ;
DISPLOC ;Displays the active pharmacy locations.
 W @IOF,!?19,"<<< ASSIGN A PHARMACY LOCATION SCREEN >>>",!,PSASLN,!
 S PSACNT=0,PSALOCN="" F  S PSALOCN=$O(PSALOCA(PSALOCN)) Q:PSALOCN=""  D
 .S PSALOC=0 F  S PSALOC=$O(PSALOCA(PSALOCN,PSALOC)) Q:'PSALOC  D
 ..S PSACNT=PSACNT+1,PSAMENU(PSACNT,PSALOCN,PSALOC)=PSALOC
 ..W !,$J(PSACNT,2)_"." W:$L(PSALOCN)>72 ?4,$P(PSALOCN,"(IP)",1)_"(IP)",!?21,$P(PSALOCN,"(IP)",2) W:$L(PSALOCN)<73 ?4,PSALOCN
 W !
 Q
 ;
SELLOC ;Select the Pharmacy Location to be assigned to the order.
 W ! K DIR S DIR(0)="NO^1:"_PSACNT,DIR("A")="Pharmacy Location",DIR("?")="Select the pharmacy location that received the invoice's drugs"
 S DIR("??")="^D LOCHELP^PSAVER5" D ^DIR K DIR Q:Y=""  I $G(DIRUT) S PSAOUT=1 Q
 S PSASEL1=Y
 S PSALOCN=$O(PSAMENU(PSASEL1,"")) Q:PSALOCN=""  S PSALOC=$O(PSAMENU(PSASEL1,PSALOCN,0)) Q:'PSALOC  S $P(^XTMP("PSAPV",PSACTRL,"IN"),"^",7)=PSALOC,PSAIN=^("IN")
 Q
 ;
CONTYN ;Extended help for 'Do you want to continue processing invoice# 99'
 W !?5,"Enter YES to continue processing the current invoice and line item.",!?5,"Enter NO to discontinue processing the current invoice and exit the option."
 Q
