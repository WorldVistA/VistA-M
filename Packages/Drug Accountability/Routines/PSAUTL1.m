PSAUTL1 ;BIR/JMB-Prime Vendor Invoice Data Utility ;9/19/97
 ;;3.0; DRUG ACCOUNTABILITY/INVENTORY INTERFACE;**3,12,15,21,48,49,54,67**; 10/24/97;Build 15
 ;This routine contains utilities to get the location name, display an
 ;error-free item, display an item with errors, and display a line ready
 ;for verification.
 ;References to global ^PS(59.4, are covered under IA #2505
 ;References to global ^DIC(51.5, are covered under IA #1931
 ;References to global ^PS(59, are covered under IA #212
 ;References to ^PSDRUG( are covered by IA #2095
 ;
SITES ;Gets the combined IP/OP's IP & OP site names
 ;PSA*3*22 (DAVE B) no location defined
 I $G(PSALOC)'>0 S (PSAISITN,PSAOSITN)="Unknown",PSACOMB=" No location identified" Q
 ;End PSA*3*22
 S PSAISIT=+$P($G(^PSD(58.8,PSALOC,0)),"^",3) D OPSITE
 I $G(PSAOSIT)="" S PSAOSIT=0
 S PSAISITN=$S($P($G(^PS(59.4,PSAISIT,0)),"^")'="":$P($G(^PS(59.4,PSAISIT,0)),"^"),1:"UNKNOWN")
 I PSAISIT,PSAOSIT S PSACOMB=": "_PSAISITN_" (IP) "_PSAOSITN_" (OP)" Q
 I PSAISIT S PSACOMB=": "_PSAISITN_" (IP)" Q
 I PSAOSIT S PSACOMB=": "_PSAOSITN_" (OP)" Q
 ;DAVE B (PSA*3*12) no DA sites defined
 S PSACOMB="No Inpatient or Outpatient Sites defined"
 Q
OPSITE ;PSA*3*25 - check for multiple OP sites
 ;VMP OIFO BAY PINES;ELR;PSA*3*49  ADDED THE FOLLOWING LINE
 S (PSAOSIT,PSAOSITN)=""
 K PSAOSITC
 Q:'$D(PSALOC)
 I '$D(^PSD(58.8,+PSALOC,7)),$P(^PSD(58.8,+PSALOC,0),"^",10)'="" S PSAOSIT=$P(^PSD(58.8,+PSALOC,0),"^",10),PSAOSITN=$P($G(^PS(59,PSAOSIT,0)),"^"),PSAOSITN=$S($G(PSAOSITN)="":"Unknown",1:PSAOSITN)
 S XX=0 F  S XX=$O(^PSD(58.8,+PSALOC,7,XX)) Q:XX'>0  S PSAOSIT=XX,PSAOSITC=$G(PSAOSITC)+1,SN=$P($G(^PS(59,XX,0)),"^") D
 .I PSAOSITC=1 S PSAOSITN=SN Q
 .S PSAOSITN=PSAOSITN_" & "_SN
 I $G(PSAOSITN)="",$P(^PSD(58.8,+PSALOC,0),"^",10)'="" S PSAOSIT=$P(^PSD(58.8,+PSALOC,0),"^",10),PSAOSITN=$P($G(^PS(59,+PSAOSIT,0)),"^")
 S PSAOSITN=$S($G(PSAOSITN)="":"unknown",1:PSAOSITN)
 Q
 ;
DISPLAY ;Displays an error-free line item
 S PSADISP=1
 S PSAIEN=$P(PSADATA,"^",6),PSASUB=$P($P(PSADATA,"^",7),"~"),PSANDC=$P($P(PSADATA,"^",4),"~"),PSAVSN=$P($P(PSADATA,"^",5),"~")
 W !,PSALINE_"  "_$S($P($G(^PSDRUG(PSAIEN,0)),"^")'="":$P(^PSDRUG(PSAIEN,0),"^"),1:"UNKNOWN")
 I PSAIEN D
 .I $P($G(^PSDRUG(PSAIEN,2)),"^",3)["N" W " (Controlled Substance)" I $P($G(^PSD(58.8,+$P(PSAIN,"^",12),1,PSAIEN,0)),"^",14),$P($G(^(0)),"^",14)'>DT W !,$C(7),$C(7),"** INACTIVE IN MASTER VAULT **" Q
 .I $P($G(^PSD(58.8,+$P(PSAIN,"^",7),1,PSAIEN,0)),"^",14),$P($G(^(0)),"^",14)'>DT W !,$C(7),$C(7),"** INACTIVE IN PHARMACY LOCATION **"
 .I $D(^PSDRUG(PSAIEN,"I")) W !?5,"** INACTIVE IN DRUG FILE **"
 W !,"Qty Invoiced: "_+$P(PSADATA,"^")
 W:$P($P(PSADATA,"^",26),"~")'="" ?38,"UPC: "_$P($P(PSADATA,"^",26),"~")
 W !,"Order Unit  : "
 S PSAOU=$S(+$P(PSADATA,"^",12):+$P(PSADATA,"^",12),+$P($P(PSADATA,"^",2),"~",2):+$P($P(PSADATA,"^",2),"~",2),PSAIEN&(PSASUB)&(+$P($G(^PSDRUG(PSAIEN,1,PSASUB,0)),"^",5)):+$P(^PSDRUG(PSAIEN,1,PSASUB,0),"^",5),1:0)
 W $S(PSAOU:$P($G(^DIC(51.5,+PSAOU,0)),"^"),1:"UNKNOWN")
 W:$E(PSANDC)'="S" ?38,"NDC: " D PSANDC1^PSAHELP W PSANDCX K PSANDCX
 W !,"Unit Price  : $"_$P(PSADATA,"^",3),?38,"VSN: "_$S(PSAVSN'="":PSAVSN,1:"Blank"),!
 I $P(PSADATA,U,13)=.5 D  ;*48 AUTO OU UPDATE FOR MCKESSON
 .W !,"*****>",!,"Note: The order unit was changed from EACH to ",$P($G(^DIC(51.5,+PSAOU,0)),"^")," by Drug Accountability"
 .W !,"      during the upload of the invoiced data. Adjustments may be necessary.",!,"*****<"
 ;bgn *67
 W !,"PV-Drug-Description  : ",$S($P(PSADATA,"^",28)'="":$P(PSADATA,"^",28),1:"Unknown")
 W ?55,"PV-DUOU  : ",$S($P(PSADATA,"^",31)'="":$P(PSADATA,"^",31),1:"Unknown")
 W !,"PV-Drug-Generic Name : ",$S($P(PSADATA,"^",29)'="":$P(PSADATA,"^",29),1:"Unknown")
 W ?55,"PV-UNITS : ",$S($P(PSADATA,"^",30)'="":$P(PSADATA,"^",30),1:"Unknown"),!
 ;end *67
 W !,"Dispense Units: "_$S(+PSAIEN&($P($G(^PSDRUG(+PSAIEN,660)),"^",8)'=""):$P($G(^PSDRUG(+PSAIEN,660)),"^",8),1:"Blank")
 W !,"Dispense Units Per Order Unit: "_$S($P(PSADATA,"^",20):+$P(PSADATA,"^",20),+PSASUB&(+$P($G(^PSDRUG(+PSAIEN,1,PSASUB,0)),"^",7)):+$P($G(^PSDRUG(+PSAIEN,1,PSASUB,0)),"^",7),1:"Blank")
 S PSALOC=$S($P(PSADATA,"^",19)="":+$P(PSAIN,"^",7),1:+$P(PSAIN,"^",12))
 Q:'+$P($G(^PSD(58.8,+PSALOC,0)),"^",14)!('$G(PSAIEN))
 S PSASTOCK=$S(+$P(PSADATA,"^",27):+$P(PSADATA,"^",27),+$P($G(^PSD(58.8,+PSALOC,1,+PSAIEN,0)),"^",3):+$P($G(^PSD(58.8,+PSALOC,1,+PSAIEN,0)),"^",3),1:"Blank")
 W !,"Stock Level   : "_PSASTOCK
 S PSAREORD=$S(+$P(PSADATA,"^",21):+$P(PSADATA,"^",21),+$P($G(^PSD(58.8,+PSALOC,1,+PSAIEN,0)),"^",5):+$P($G(^PSD(58.8,+PSALOC,1,+PSAIEN,0)),"^",5),1:"Blank") ;*48
 W !,"Reorder Level : "_PSAREORD,!
 Q
 ;
EDITDISP ;Displays a line item with errors.
 W @IOF,!?23,"<<< PROCESS LINE ITEM SCREEN >>>",!,"Order#: "_$P(PSAIN,"^",4)_"  Invoice#: "_$P(PSAIN,"^",2)_"  Invoice Date: "_$$FMTE^XLFDT(+PSAIN),!,PSASLN
EDIT1 S PSADATA=$G(^XTMP("PSAPV",PSACTRL,"IT",PSALINE))
 S PSASUB=+$P(PSADATA,"^",7) ;*54
 S PSAIEN=+$P(PSADATA,"^",15) I PSAIEN ;*54
 E  S PSAIEN=+$P(PSADATA,"^",6) ;*54
 S PSALOC=$S($P(PSADATA,"^",19)="":+$P(PSAIN,"^",7),1:+$P(PSAIN,"^",12))
 W !,PSALINE_"  "_$S($D(^XTMP("PSAPV",PSACTRL,"IT",PSALINE,"SUP")):$P(^XTMP("PSAPV",PSACTRL,"IT",PSALINE,"SUP"),"^",3),PSAIEN&($P($G(^PSDRUG(PSAIEN,0)),"^")'=""):$P(^PSDRUG(PSAIEN,0),"^"),1:"UNKNOWN ITEM")
 I PSAIEN D
 .I $P($G(^PSDRUG(PSAIEN,2)),"^",3)["N" W " (Controlled Substance)" I $P($G(^PSD(58.8,+$P(PSAIN,"^",12),1,PSAIEN,0)),"^",14),$P($G(^(0)),"^",14)'>DT W !,$C(7),$C(7),"** INACTIVE IN MASTER VAULT **" Q
 .I $P($G(^PSD(58.8,+$P(PSAIN,"^",7),1,PSAIEN,0)),"^",14),$P($G(^(0)),"^",14)'>DT W !,$C(7),$C(7),"** INACTIVE IN PHARMACY LOCATION **"
 ;
 W !,"Qty Invoiced: "
 I $P(PSADATA,"^",8)'="" W $P(PSADATA,"^",8)_" ("_$S(+PSADATA:+PSADATA,$P(PSADATA,"^")=0:0,1:"Blank")_")"
 I $P(PSADATA,"^",8)="" W $S(+PSADATA:+PSADATA,$P(PSADATA,"^")=0:0,1:"Blank")
 W:$P($P(PSADATA,"^",26),"~")'="" ?38,"UPC: "_$P($P(PSADATA,"^",26),"~")
 ;
 W !,"Order Unit  : "
 I +$P(PSADATA,"^",12) D
 .W $P($G(^DIC(51.5,+$P(PSADATA,"^",12),0)),"^")
 .W " ("_$S($P($P(PSADATA,"^",2),"~")'="":$P($P(PSADATA,"^",2),"~"),$P($G(^DIC(51.5,+$P($P(PSADATA,"^",2),"~",3),0)),"^")'="":$P($G(^DIC(51.5,+$P($P(PSADATA,"^",2),"~",3),0)),"^"),1:"Blank")_")"
 I '+$P(PSADATA,"^",12) D
 .W $S(+$P($P(PSADATA,"^",2),"~",2):$P($P(PSADATA,"^",2),"~"),PSAIEN&(PSASUB)&(+$P($G(^PSDRUG(PSAIEN,1,PSASUB,0)),"^",5)):$P($G(^DIC(51.5,+$P(^PSDRUG(PSAIEN,1,PSASUB,0),"^",5),0)),"^"),1:"Blank")
 ;
 W:$E(PSANDC)'="S" ?38,"NDC: " D PSANDC1^PSAHELP W PSANDCX K PSANDCX
 S PSAPRICE=$P(PSADATA,"^",3)
 I +PSAPRICE,$L($P(PSAPRICE,".",2))<2 S PSAPRICE=$P(PSAPRICE,".")_"."_$P(PSAPRICE,".",2)_$E("00",1,(2-$L($P(PSAPRICE,".",2))))
 W !,"Unit Price  : $"_$S($G(PSAPRICE):PSAPRICE,PSAPRICE=0:0,1:"Blank"),?38,"VSN: "_$S(PSAVSN'="":PSAVSN,1:"Blank"),!
 I $P(PSADATA,U,13)=.5 D  ;*48 AUTO OU UPDATE FOR MCKESSON
 .N PSAOU S PSAOU=$P(PSADATA,U,12)
 .W !,"*****>",!,"Note: The order unit was changed from EACH to ",$P($G(^DIC(51.5,+PSAOU,0)),"^")," by Drug Accountability"
 .W !,"      during the upload of the invoiced data. Adjustments may be necessary.",!,"*****<"
 ;bgn *67
 W !,"PV-Drug-Description  : ",$S($P(PSADATA,"^",28)'="":$P(PSADATA,"^",28),1:"Unknown")
 W ?55,"PV-DUOU  : ",$S($P(PSADATA,"^",31)'="":$P(PSADATA,"^",31),1:"Unknown")
 W !,"PV-Drug-Generic Name : ",$S($P(PSADATA,"^",29)'="":$P(PSADATA,"^",29),1:"Unknown")
 W ?55,"PV-UNITS : ",$S($P(PSADATA,"^",30)'="":$P(PSADATA,"^",30),1:"Unknown"),!
 ;end *67
 S PSAIN=^XTMP("PSAPV",PSACTRL,"IN"),PSALOC=$S($P(PSADATA,"^",19)="CS":+$P(PSAIN,"^",12),1:+$P(PSAIN,"^",7))
DU W !,"Dispense Units: "_$S(+PSAIEN&($P($G(^PSDRUG(+PSAIEN,660)),"^",8)'=""):$P($G(^PSDRUG(+PSAIEN,660)),"^",8),1:"Blank")
DUOU W !,"Dispense Units Per Order Unit: "_$S($P(PSADATA,"^",20):+$P(PSADATA,"^",20),+PSASUB&(+$P($G(^PSDRUG(+PSAIEN,1,PSASUB,0)),"^",7)):+$P($G(^PSDRUG(+PSAIEN,1,PSASUB,0)),"^",7),1:"Blank"),!
 ;
 Q:'+$P($G(^PSD(58.8,+PSALOC,0)),"^",14)
 ;
 S PSASTOCK=$S(+$P(PSADATA,"^",27):+$P(PSADATA,"^",27),+$P($G(^PSD(58.8,+PSALOC,1,+PSAIEN,0)),"^",3):+$P($G(^PSD(58.8,+PSALOC,1,+PSAIEN,0)),"^",3),1:"Blank")
 W "Stock Level   : "_PSASTOCK
 S PSAREORD=$S(+$P(PSADATA,"^",21):+$P(PSADATA,"^",21),+$P($G(^PSD(58.8,+PSALOC,1,+PSAIEN,0)),"^",5):+$P($G(^PSD(58.8,+PSALOC,1,+PSAIEN,0)),"^",5),1:"Blank")
 W !,"Reorder Level : "_PSAREORD,!
 Q
