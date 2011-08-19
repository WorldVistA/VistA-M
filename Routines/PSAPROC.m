PSAPROC ;BIR/JMB-Process Uploaded Prime Vendor Invoice Data ;10/9/97
 ;;3.0; DRUG ACCOUNTABILITY/INVENTORY INTERFACE;**3,12,21,70**; 10/24/97;Build 12
 ;This routine assigns a pharmacy location or master vault to all invoices.
 ;
 N PSALCK S (PSALCK,PSAOUT)=1 D EXIT K PSAOUT,PSALCK ;Kill all option variables
 I '$D(^XUSEC("PSA ORDERS",DUZ)) W !,"You do not hold the key to enter the option." Q
ESIG D SIG^XUSESIG I X1="" S PSAOUT=1 G EXIT
 S PSASLN="",$P(PSASLN,"-",80)="",PSADLN="",$P(PSADLN,"=",80)="",(PSACNT,PSACTRL,PSAOUT)=0
 ;DAVE B (PSA*3*12) 12MAY99 Multi-divisional select
 D DAVE
 ;
CNT ;Count invoices that need a pharm location or master vault assigned.
 F  S PSACTRL=$O(^XTMP("PSAPV",PSACTRL)) Q:PSACTRL=""  D
 .Q:'$D(^XTMP("PSAPV",PSACTRL,"IN"))
 .I $G(PSASORT)'=0,$G(PSASORT)'="",$D(^XTMP("PSAPV",PSACTRL,"ST")),$P(^XTMP("PSAPV",PSACTRL,"ST"),"^",1)'=PSASORT Q
 .S PSAIN=^XTMP("PSAPV",PSACTRL,"IN")
 .;DAVE B (PSA*3*21)
 .K PSAINVDL D ^PSAPTCH Q:$D(PSAINVDL)
 .I $P(PSAIN,"^",10)="ALL CS",$P(PSAIN,"^",12)="" S PSACNT=PSACNT+1,PSACS(PSACTRL)="" Q
 .I $P(PSAIN,"^",10)'="ALL CS" D
 ..I $P(PSAIN,"^",9)="CS" S:$P(PSAIN,"^",7)="" PSANCS(PSACTRL)="" S:$P(PSAIN,"^",12)="" PSACS(PSACTRL)="" S:$P(PSAIN,"^",7)=""!($P(PSAIN,"^",12)="") PSACNT=PSACNT+1 Q
 ..I $P(PSAIN,"^",9)="",$P(PSAIN,"^",7)="" S PSACNT=PSACNT+1,PSANCS(PSACTRL)=""
 I 'PSACNT D ^PSAPROC1 G EXIT
 ;
LOC ;Gets pharmacy locations
 S (PSALOC,PSANUM)=0 F  S PSALOC=+$O(^PSD(58.8,"ADISP","P",PSALOC)) Q:'PSALOC  D
 .Q:'$D(^PSD(58.8,PSALOC,0))!($P($G(^PSD(58.8,PSALOC,0)),"^")="")
 .I +$G(^PSD(58.8,PSALOC,"I")),+^PSD(58.8,PSALOC,"I")'>DT Q
 .S PSANUM=PSANUM+1,PSAONE=PSALOC,PSAISIT=+$P(^PSD(58.8,PSALOC,0),"^",3),PSAOSIT=+$P(^(0),"^",10)
 .D SITES^PSAUTL1 S PSACOMB=$S('$D(PSACOMB):"NO COMBINED IP/OP",1:PSACOMB),PSALOCA($P(^PSD(58.8,PSALOC,0),"^")_PSACOMB,PSALOC)=PSAISIT_"^"_PSAOSIT
 ;
 ;Gets master vaults
 S (PSAMVN,PSAMV)=0 F  S PSAMV=+$O(^PSD(58.8,"ADISP","M",PSAMV)) Q:'PSAMV  D
 .Q:'$D(^PSD(58.8,PSAMV,0))!($P($G(^PSD(58.8,PSAMV,0)),"^")="")
 .I +$G(^PSD(58.8,PSAMV,"I")),+^PSD(58.8,PSAMV,"I")'>DT Q
 .S PSAMVN=PSAMVN+1,PSAONEMV=PSAMV,PSAMV($P(^PSD(58.8,PSAMV,0),"^"),PSAMV)=""
 ;PSA*3*22 (Set PSDOUT on next line to avoid automatic stuffing
 I 'PSANUM D NONE S PSAOUT=1 G EXIT
 I PSANUM=1 D ONE Q:PSAOUT
 I PSANUM>1 D MANY Q:PSAOUT
 D ^PSAPROC1 G EXIT
 ;
NONE ;No DA pharmacy locations
 W !!,"There are no Drug Accountability pharmacy locations.",!!,"Use the Set Up/Edit a Pharmacy Location option on Pharmacy Location Maintenance"
 W !,"Menu to setup one or more pharmacy locations. Then select the Process Uploaded",!,"Prime Vendor Invoice Data option to process the invoices."
 D END S PSA=$O(PSACS("")) D:PSA'="" MASTER,END
 Q
 ;
ONE ;Only one location
 S PSACNT=0,PSALOC=PSAONE,PSALOCN=$O(PSALOCA(""))
 W !!,"The invoices are being assigned to the pharmacy location. Please wait."
 S PSACTRL="" F  S PSACTRL=$O(PSANCS(PSACTRL)) Q:PSACTRL=""  D
 .Q:'$D(^XTMP("PSAPV",PSACTRL,"IN"))
 .S $P(^XTMP("PSAPV",PSACTRL,"IN"),"^",7)=PSALOC,PSACNT=1 W "."
 H 1 S PSA=$O(PSACS("")) D:PSA'="" MASTER
 Q
 ;
MANY ;If more than one pharmacy location, display invoices.
 S PSACTRL="" F  S PSACTRL=$O(PSANCS(PSACTRL)) Q:PSACTRL=""  D  Q:PSAOUT
 .Q:'$D(^XTMP("PSAPV",PSACTRL,"IN"))
 .S PSAIN=$G(^XTMP("PSAPV",PSACTRL,"IN")),PSAORD=$P(PSAIN,"^",4),PSAINV=$P(PSAIN,"^",2)
 .D DISPLOC
 .W !,"Order#: "_PSAORD_"  Invoice#: "_PSAINV_"  Invoice Date: "_$$FMTE^XLFDT(+PSAIN)
 .W:$D(PSACS(PSACTRL)) !,"Some controlled substances" D SELECT
 S PSA=$O(PSACS("")) D:PSA'="" MASTER,END K PSAMENU,PSALOCA
 Q
 ;
DISPLOC ;Displays the active pharmacy locations.
 W @IOF,!?19,"<<< ASSIGN A PHARMACY LOCATION SCREEN >>>",!,PSASLN
 S (PSACNT,PSASTOP)=0,PSALOCN=""
 F  S PSALOCN=$O(PSALOCA(PSALOCN)) Q:PSALOCN=""!(PSASTOP)  D
 .S PSALOC=0 F  S PSALOC=$O(PSALOCA(PSALOCN,PSALOC)) Q:'PSALOC!(PSASTOP)  D
 ..S PSACNT=PSACNT+1,PSAMENU(PSACNT,PSALOCN,PSALOC)=PSALOC
 ..I $Y+3>IOSL D HDR I PSAOUT S PSAOUT=0,PSASTOP=1 Q
 ..W !,$J(PSACNT,2)_"." W:$L(PSALOCN)>72 ?4,$P(PSALOCN,"(IP)",1)_"(IP)",!?21,$P(PSALOCN,"(IP)",2) W:$L(PSALOCN)<73 ?4,PSALOCN
 W ! K PSASTOP
 Q
 ;
HDR D END
 W @IOF,!?19,"<<< ASSIGN A PHARMACY LOCATION SCREEN >>>",!,PSASLN
 Q
 ;
SELECT ;Select the Pharmacy Location to be assigned to the order.
 W ! K DIR S DIR(0)="NO^1:"_PSACNT,DIR("A")="Pharmacy Location",DIR("?")="Select the pharmacy location that received the invoice's drugs"
 ;
 ;DAVE B (PSA*3*12) 2/16/99 Force entering a pharacy location
 S DIR("??")="^D PHARM^PSAPROC" D ^DIR K DIR Q:Y=""  ;I Y="" W !!?5,"Enter an Up-arrow '^' to abort the process.",! G SELECT
 I $G(DIRUT) S PSAOUT=1 Q
 S PSASEL=Y,PSALOCN=""
 F  S PSALOCN=$O(PSAMENU(PSASEL,PSALOCN)) Q:PSALOCN=""  D
 .S PSALOC=0 F  S PSALOC=+$O(PSAMENU(PSASEL,PSALOCN,PSALOC)) Q:'PSALOC  D
 ..S $P(^XTMP("PSAPV",PSACTRL,"IN"),"^",7)=PSALOC
 Q
 ;
MASTER ;Assigns invoice to Master Vault
 I 'PSAMVN W !!,"No master vaults are set up. You must set up a master vault then",!,"select the Process Uploaded Prime Vendor Invoices Data option." S PSAOUT=1 Q
 ;
 I PSAMVN=1 D  H 1 Q
 .S PSACTRL=$O(PSACS(""))
 .W !!,"The invoices are being assigned to the master vault. Please wait."
 .S PSACTRL="" F  S PSACTRL=$O(PSACS(PSACTRL)) Q:PSACTRL=""  D
 ..Q:'$D(^XTMP("PSAPV",PSACTRL,"IN"))
 ..S $P(^XTMP("PSAPV",PSACTRL,"IN"),"^",12)=PSAONEMV W "."
 ;
 I PSAMVN>1 D
 .S PSACTRL="" F  S PSACTRL=$O(PSACS(PSACTRL)) Q:PSACTRL=""  D  Q:PSAOUT
 ..Q:'$D(^XTMP("PSAPV",PSACTRL,"IN"))
 ..S PSAIN=^XTMP("PSAPV",PSACTRL,"IN"),PSAORD=$P(PSAIN,"^",4),PSAINV=$P(PSAIN,"^",2)
 ..D DISPMV W !,"Order#: "_PSAORD_"  Invoice#: "_PSAINV_"  Invoice Date: "_$$FMTE^XLFDT(+PSAIN)
 ..W:$P(PSAIN,"^",10)="ALL CS" !,"** All controlled substances"
 ..W:$P(PSAIN,"^",10)'="ALL CS" !,"** Some controlled substances"
 ..D SELMV
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
 ;
 ;DAVE B (PSA*3*12) 2/16/99 Force entry of MV
 S DIR("??")="^D MV^PSAPROC" D ^DIR K DIR Q:Y=""  ;I Y="" W !!?5,"A Master Vault must be selected. Otherwise enter an up-arrow '^' to abort.",! G SELMV
 I $G(DIRUT) S PSAOUT=1 Q
 ;
 ;
 S PSASEL=Y
 S PSAMVA=$O(PSAVAULT(PSASEL,"")) Q:PSAMVA=""  S PSAMVIEN=+$O(PSAVAULT(PSASEL,PSAMVA,0)) Q:'PSAMVIEN  S $P(^XTMP("PSAPV",PSACTRL,"IN"),"^",12)=PSAMVIEN
 Q
 ;
END ;Holds screen
 S PSASS=21-$Y F PSAKK=1:1:PSASS W !
 S DIR(0)="E" D ^DIR K DIR S:$G(DIRUT) PSAOUT=1 W @IOF
 Q
 ;
EXIT ;Kills processing variables
 I $G(PSAENTRY) D PRINT2^PSAUP
 D:($G(PSALCK)!($G(PSAOUT))) PSAUNLCK^PSAPROC8  ;; < PSA*3*70 RJS
 ;
 ;DAVE B (PSA*3*12) replaced '$D with '$G on next line
 K DA,DIC,DIE,DIK,DIR,DIRUT,DR,DTOUT,DUOUT,PSA,PSABEFOR,PSACHG,PSACHO,PSACNT,PSACNT1,PSACNTER,PSACNTOK,PSACOMB,PSACONT,PSACS,PSACTRL,PSAREA,PSAFLD
 K PSADRG1,PSASORT
 K PSAD0,PSAD1,PSAD2,PSAD3,PSAD4,PSAD5,PSAD6,PSADATA,PSADIFF,PSADISP,PSADJQTY,PSADLN,PSADONE,PSADU,PSAENTRY,PSAERR,PSAFLDS,PSAFND,PSAFPR,PSAGET,PSAHDR
 K PSAIEN,PSAIEN3,PSAIEN50,PSAIN,PSAINV,PSAIPR,PSAISIT,PSAISITN,PSAJUST,PSAKK,PSALINE,PSALINES,PSALLSUP,PSALN,PSALNCNT,PSALNSU,PSALOC,PSALOCA,PSALOCN,PSALOCN
 K PSAMENU,PSAMV,PSAMVA,PSAMVIEN,PSAMVN,PSANCS,PSANDC,PSANEXT,PSANODE,PSANUM,PSAOK,PSAONE,PSAONEMV,PSAORD,PSAOSIT,PSAOSITN,PSAOUT,PSAPASS,PSAPC,PSAPCF,PSAPCL,PSAPHARM,PSAPICK,PSAPRICE,PSAPTR
 K PSARECD,PSAREORD,PSASAME,PSASEL,PSASEL1,PSASKIP,PSASLN,PSASNODE,PSASS,PSASSUB,PSASTOCK,PSASUB,PSASUP,PSASUPP,PSASYN,PSAVAPN,PSAVAULT,PSAVSN,X1,Y,ZTDTH,ZTIO
 Q
 ;
MV ;Extended help for the select "Master Vault" prompt
 W !?5,"Enter the number of the master vault for which you want to assign",!?5,"the order. The invoiced drugs in the assigned master vault will be"
 W !?5,"incremented with the quantity received after the order is verified."
 Q
PHARM ;Extended help for the select "Pharmacy Location" prompt
 W !?5,"Enter the number of the pharmacy location for which you want to assign",!?5,"the order. The invoiced drugs in the assigned pharmacy location will be"
 W !?5,"incremented with the quantity received after the order is verified."
 Q
DAVE ;Select division
 S (CNT,CNTR,DIV,PSASORT)=0
 S X=0 F  S X=$O(^XTMP("PSAPV",X)) Q:X=""  I $D(^XTMP("PSAPV",X,"ST")) S DATA=^XTMP("PSAPV",X,"ST"),DIV($P(DATA,"^"))=""
 Q:$O(DIV(0))=""  S (CNT,CNTR)=0,DIR(0)="S^" F  S CNT=$G(CNT)+1,CNTR=$O(DIV(CNTR)) Q:CNTR=""  S DIR(0)=DIR(0)_CNT_":"_CNTR_";"
 Q:$L(DIR(0))'>2  S XX=$L(DIR(0)),XX=XX-1,XXX=$E(DIR(0),1,XX),DIR(0)=XXX
 K X,XX,XXX,CNT,CNTR,DIV
 W !!,"You have invoices on your system for more than one division.",!,"Please select the location for which you want to process invoices.",!,"or Press the up-arrow to process all invoices."
 D ^DIR S:+Y>0 PSASORT=Y(0)
 Q
