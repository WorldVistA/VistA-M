PSAUTL4 ;BIR ISC/JMB-Verify Invoices Utility ; 8/19/97
 ;;3.0; DRUG ACCOUNTABILITY/INVENTORY INTERFACE;**3,21,48,54,61,67,71**; 10/24/97;Build 10
 ;
 ;References to ^DIC(51.5 are covered by IA #1931
 ;References to ^PSDRUG( are covered by IA #2095
 I $G(PSADICW)=1 S PSALINE=Y
 ;This routine contains a utility to display a line item ready for
 ;verification. It is called by PSAVER1 and PSAVER2.
 ;
VERDISP ;Displays a line item on a processed or verified invoice
 W PSALINEN_"  "
DRUG S PSADJ=+$O(^PSD(58.811,PSAIEN,1,PSAIEN1,1,PSALINE,1,"B","D",0))
 I $G(PSADJ) D
 .S PSANODE=$G(^PSD(58.811,PSAIEN,1,PSAIEN1,1,PSALINE,1,PSADJ,0))
 .S PSADJD=$S($P(PSANODE,"^",6)'="":$P(PSANODE,"^",6),1:$P(PSANODE,"^",2))
 .I PSADJD'?1.N S PSASUP=1
 .S PSADRG=$S(PSADJ&('PSASUP):$G(PSADJD),PSADJ&(PSASUP):0,1:+$P(PSADATA,"^",2))
 .I $G(PSADJD),$L(PSADJD)=$L(+PSADJD),$P($G(^PSDRUG(+PSADJD,0)),"^")'="" W "*"_$P($G(^PSDRUG(+PSADJD,0)),"^") S (PSADRG,PSA50IEN)=+PSADJD Q
 .I $G(PSADJD),$L(PSADJD)=$L(+PSADJD),$P($G(^PSDRUG(+PSADJD,0)),"^")="" S (PSADJ,PSADRG)=0 Q
 .W ?7,"**"_PSADJD S PSADJSUP=1,(PSADRG,PSA50IEN)=PSADJD
 I '$G(PSADJ) D
 .S (PSA50IEN,PSADRG)=$S(+$P(PSADATA,"^",2)&($P($G(^PSDRUG(+$P(PSADATA,"^",2),0)),"^")'=""):+$P(PSADATA,"^",2),1:0)
 .W $S(+$P(PSADATA,"^",2)&($P($G(^PSDRUG(+$P(PSADATA,"^",2),0)),"^")'=""):$P(^PSDRUG(+$P(PSADATA,"^",2),0),"^"),1:"DRUG UNKNOWN")
 I PSADRG D
 .I $P($G(^PSDRUG(PSADRG,2)),"^",3)["N" W " (Controlled Substance)" I $P($G(^PSD(58.8,+$P(PSAIN,"^",12),1,PSADRG,0)),"^",14),$P($G(^(0)),"^",14)'>DT W !,$C(7),$C(7),"** INACTIVE IN MASTER VAULT **"
 .I $D(^PSDRUG(PSADRG,"I")) W !?5,"** INACTIVE IN DRUG FILE **" Q
 .I $P($G(^PSD(58.8,+$P(PSAIN,"^",5),1,PSADRG,0)),"^",14),$P($G(^(0)),"^",14)'>DT W !,$C(7),$C(7),"** INACTIVE IN PHARMACY LOCATION **"
QTY W !,"Qty Invoiced: "
 ;No Adj. Qty
 S PSADJQ="",PSADJ=+$O(^PSD(58.811,PSAIEN,1,PSAIEN1,1,PSALINE,1,"B","Q",0))
 I $G(PSADJ) S PSANODE=$G(^PSD(58.811,PSAIEN,1,PSAIEN1,1,PSALINE,1,PSADJ,0)),PSADJQ=$S($P(PSANODE,"^",6)'="":+$P(PSANODE,"^",6),1:$P(PSANODE,"^",2))
 ;Adj. Qty  <-RJS *71 START
 I $G(PSADJQ)'="" S PSAQTY=PSADJQ W PSAQTY_" ("_$S($P(PSADATA,"^",3):$P(PSADATA,"^",3),$P(PSADATA,"^",3)=0:0,1:"Blank")_")"
 I $G(PSADJQ)="" W $P(PSADATA,"^",3) S PSAQTY=$P(PSADATA,"^",3)  ;; <- RJS *71 END
UPC S PSAUPC=$P(PSADATA,U,13) W:PSAUPC'="" ?38,"UPC: "_PSAUPC
OU W !,"Order Unit  : "
 S PSAOU=$S(+$P(PSADATA,"^",4)&($P($G(^DIC(51.5,+$P(PSADATA,"^",4),0)),"^")'=""):+$P(PSADATA,"^",4),1:"")
 S PSATEMP=$G(^PSD(58.811,PSAIEN,1,PSAIEN1,1,PSALINE,2))
 I +$P(PSATEMP,"^",3),PSADRG,+$P($G(^PSDRUG(PSADRG,1,+$P(PSATEMP,"^",3),0)),"^",5) S PSAOU=+$P(^PSDRUG(PSADRG,1,+$P(PSATEMP,"^",3),0),"^",5)
 S PSADJO="",PSADJ=+$O(^PSD(58.811,PSAIEN,1,PSAIEN1,1,PSALINE,1,"B","O",0))
 I $G(PSADJ) S PSANODE=$G(^PSD(58.811,PSAIEN,1,PSAIEN1,1,PSALINE,1,PSADJ,0)),PSADJO=$S($P(PSANODE,"^",6)'="":$P(PSANODE,"^",6),1:$P(PSANODE,"^",2))
 ;Adj. Order Unit
 I PSADJO'="" W $S(+PSADJO&($P($G(^DIC(51.5,+PSADJO,0)),"^")'=""):$P($G(^DIC(51.5,+PSADJO,0)),"^"),1:"UNKNOWN")_" ("_$S(PSAOU:$P($G(^DIC(51.5,+PSAOU,0)),"^"),1:"Blank")_")" S PSAOU=+PSADJO
 I PSADJO="" W $S(+PSAOU:$P($G(^DIC(51.5,+PSAOU,0)),"^"),1:"Blank")
 ;
NDC S PSANDC=$P(PSADATA,"^",11)
 I $E(PSANDC)'="S" W ?38,"NDC: " D PSANDC1^PSAHELP W PSANDCX K PSANDCX
 ;
PRICE W !,"Unit Price  : $"
 S PSADJP=0,PSADJ=+$O(^PSD(58.811,PSAIEN,1,PSAIEN1,1,PSALINE,1,"B","P",0))
 I $G(PSADJ) S PSANODE=$G(^PSD(58.811,PSAIEN,1,PSAIEN1,1,PSALINE,1,PSADJ,0)),PSADJP=$S(+$P(PSANODE,"^",6):+$P(PSANODE,"^",6),1:+$P(PSANODE,"^",2))
 ;Adj. Unit Price
 I $G(PSADJP) D
 .I $L($P(PSADJP,".",2))<2 S PSADJP=$P(PSADJP,".")_"."_$P(PSADJP,".",2)_$E("00",1,(2-$L($P(PSADJP,".",2))))
 .W $FN(PSADJP,",")_" ($"_$S(+$P(PSADATA,"^",5):$FN($P(PSADATA,"^",5),","),$P(PSADATA,"^",5)=0:"0.00",1:"")_")"
 .S PSAPRICE=PSADJP
 I '$G(PSADJP) D
 .S PSAPRICE=+$P(PSADATA,"^",5)
 .I $G(PSAPRICE)!(PSAPRICE=0) W $S($G(PSAPRICE):PSAPRICE,1:"0.00") Q
 .W "Blank"
 ;
VSN S:$D(PSADATA) PSAVSN=$P(PSADATA,"^",12) ;*48
 W ?38,"VSN: "_$S(PSAVSN'="":PSAVSN,1:"Blank"),!
 ;bgn *67
 S PSAP67=$G(^PSD(58.811,PSAIEN,1,PSAIEN1,3,PSALINE,0))
 W !,"PV-Drug-Description  : ",$S($P(PSAP67,"^",1)'="":$P(PSAP67,"^",1),1:"Unknown")
 W ?55,"PV-DUOU  : ",$S($P(PSAP67,"^",4)'="":$P(PSAP67,"^",4),1:"Unknown")
 W !,"PV-Drug-Generic Name : ",$S($P(PSAP67,"^",2)'="":$P(PSAP67,"^",2),1:"Unknown")
 W ?55,"PV-UNITS : ",$S($P(PSAP67,"^",3)'="":$P(PSAP67,"^",3),1:"Unknown"),!
 ;end *67
VDU S PSADUOU=+$P(PSATEMP,"^"),PSAREORD=+$P(PSATEMP,"^",2),PSASUB=+$P(PSATEMP,"^",3),PSASTOCK=+$P(PSATEMP,"^",4)
 W !,"Dispense Units: "_$S($P($G(^PSDRUG(+PSADRG,660)),"^",8)'="":$P($G(^PSDRUG(+PSADRG,660)),"^",8),1:"Blank")
VDUOU W !,"Dispense Units Per Order Unit: "_$S(+PSADUOU:+PSADUOU,+PSASUB&(+$P($G(^PSDRUG(+PSADRG,1,PSASUB,0)),"^",7)):+$P($G(^PSDRUG(+PSADRG,1,PSASUB,0)),"^",7),1:"Blank"),!
 ;
 Q:'+$P($G(^PSD(58.8,+PSALOC,0)),"^",14)
 ;
STOCK S PSASTOCK=$S(+PSASTOCK:+PSASTOCK,+$P($G(^PSD(58.8,+PSALOC,1,+PSADRG,0)),"^",3):+$P($G(^PSD(58.8,+PSALOC,1,+PSADRG,0)),"^",3),1:"Blank")
 W "Stock Level   : "_PSASTOCK
REORDER S PSAREORD=$S(+PSAREORD:+PSAREORD,+$P($G(^PSD(58.8,+PSALOC,1,+PSADRG,0)),"^",5):+$P($G(^PSD(58.8,+PSALOC,1,+PSADRG,0)),"^",5),1:"Blank")
 W !,"Reorder Level : "_PSAREORD,!
 Q
