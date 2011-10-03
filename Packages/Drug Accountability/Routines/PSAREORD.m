PSAREORD ;BIR/JMB-Nightly Background Job - CONT'D ;7/23/97
 ;;3.0; DRUG ACCOUNTABILITY/INVENTORY INTERFACE;**3,21**; 10/24/97
 ;References to ^PSDRUG( are covered by IA #2095
 ;References to ^DIC(51.5 are covered by IA #1931
 ;This routine checks each pharmacy location for current balances less
 ;than or equal to the reorder level. A list is sent to the holders of
 ;the PSA ORDERS key. If the location is a master vault, the message
 ;will include those CS drugs only if the user has the PSJ RPHARM key.
 ;
PHARM ;Looks for drugs that are >= reorder level in pharmacy locations.
 K ^TMP("PSAMSGO",$J),^TMP("PSAREORD",$J) S (PSACNT,PSALOC)=0
 F  S PSALOC=$O(^PSD(58.8,"ADISP","P",PSALOC)) Q:'PSALOC  D
 .Q:'$P($G(^PSD(58.8,PSALOC,0)),"^",14)!('$D(^PSD(58.8,PSALOC,0)))
 .I +$G(^PSD(58.8,PSALOC,"I")),+^PSD(58.8,PSALOC,"I")'>DT Q
 .S PSAFIRST=1,PSADRG=0
 .F  S PSADRG=+$O(^PSD(58.8,PSALOC,1,PSADRG)) Q:'PSADRG  D
 ..S PSANODE=$G(^PSD(58.8,PSALOC,1,PSADRG,0)) Q:PSANODE=""
 ..Q:+$P(PSANODE,"^",4)>+$P(PSANODE,"^",5)
 ..Q:'+$P(PSANODE,"^",4)&('+$P(PSANODE,"^",5))
 ..S PSANDC=$P($G(^PSDRUG(PSADRG,2)),"^",4) K PSALVSN D:PSANDC'="" NDC
 ..S ^TMP("PSAORD",$J,PSALOC,$S($P($G(^PSDRUG(PSADRG,0)),"^")'="":$P(^PSDRUG(PSADRG,0),"^"),1:"UNKNOWN ("_PSADRG_")"))=+$P(PSANODE,"^",3)_"^"_+$P(PSANODE,"^",4)_"^"_$G(PSALVSN)
 K PSALVSN
 ;
VAULT ;Looks for drugs that are >= reorder level in master vaults.
 S PSALOC=0 F  S PSALOC=$O(^PSD(58.8,"ADISP","M",PSALOC)) Q:'PSALOC  D
 .Q:'$P($G(^PSD(58.8,PSALOC,0)),"^",14)!('$D(^PSD(58.8,PSALOC,0)))
 .I +$G(^PSD(58.8,PSALOC,"I")),+^PSD(58.8,PSALOC,"I")'>DT Q
 .S PSAFIRST=1,PSADRG=0
 .F  S PSADRG=$O(^PSD(58.8,PSALOC,1,PSADRG)) Q:'PSADRG  D
 ..S PSANODE=$G(^PSD(58.8,PSALOC,1,PSADRG,0))
 ..Q:PSANODE=""!(+$P(PSANODE,"^",4)>+$P(PSANODE,"^",5))
 ..Q:'+$P(PSANODE,"^",4)&('+$P(PSANODE,"^",5))
 ..S PSANDC=$P($G(^PSDRUG(PSADRG,2)),"^",4) K PSALVSN D:PSANDC'="" NDC
 ..S ^TMP("PSAORDCS",$J,PSALOC,$S($P($G(^PSDRUG(PSADRG,0)),"^")'="":$P(^PSDRUG(PSADRG,0),"^"),1:"UNKNOWN ("_PSADRG_")"))=+$P(PSANODE,"^",3)_"^"_+$P(PSANODE,"^",4)_"^"_$G(PSALVSN)
 K PSALVSN I '$O(^TMP("PSAORD",$J,0)),'$O(^TMP("PSAORDCS",$J,0)) G EXIT
 ;
NONCS ;Loops through the non-controlled subs to create mail message text.
 G:'$O(^TMP("PSAORD",$J,0)) CS K PSA S (PSACNT,PSALOC)=0
 F  S PSALOC=$O(^TMP("PSAORD",$J,PSALOC)) Q:'PSALOC  D
 .S PSAFIRST=1,PSADRG=""
 .F  S PSADRG=$O(^TMP("PSAORD",$J,PSALOC,PSADRG)) Q:PSADRG=""  D
 ..S PSASTOCK=$P(^TMP("PSAORD",$J,PSALOC,PSADRG),"^"),PSABAL=$P(^(PSADRG),"^",2),PSAVSN=$P(^(PSADRG),"^",3) D SETMSG
 G:'$D(^XUSEC("PSJ RPHARM",DUZ))!('$O(^TMP("PSAORDCS",$J,0))) SEND
 ;
CS ;Loops through the controlled subs to create mail message text.
 S PSALOC=0 F  S PSALOC=$O(^TMP("PSAORDCS",$J,PSALOC)) Q:'PSALOC  D
 .S PSAFIRST=1,PSADRG=""
 .F  S PSADRG=$O(^TMP("PSAORDCS",$J,PSALOC,PSADRG)) Q:PSADRG=""  D
 ..S PSASTOCK=$P(^TMP("PSAORDCS",$J,PSALOC,PSADRG),"^"),PSABAL=$P(^(PSADRG),"^",2),PSAVSN=$P(^(PSADRG),"^",3) D SETMSG
 ;
SEND ;Send the mail message to the holders of the PSA ORDERS key.
 S XMTEXT="^TMP(""PSAMSGO"",$J,",XMDUZ="Drug Accountability System",XMSUB="Drug Balances Below Reorder Level"
 ;PSA*3*21 ( change recipients to PSA REORDER LEVEL mail group
 S XMY("G.PSA REORDER LEVEL")=""
 G:'$D(XMY) QUIT D ^XMD
QUIT K XMY,^TMP("PSAMSGO",$J)
 Q
 ;
NDC ;Gets VSN dispense units,dispense units/order unit, order unit for
 ;^TMP global
 K PSASYN,PSAVSN,PSAOU,PSADUOU,PSADU,PSALVSN
 S PSANDC=$E("000000",1,(6-$L($P(PSANDC,"-"))))_$P(PSANDC,"-")_$E("0000",1,(4-$L($P(PSANDC,"-",2))))_$P(PSANDC,"-",2)_$E("00",1,(2-$L($P(PSANDC,"-",3))))_$P(PSANDC,"-",3)
 S PSASYN=+$O(^PSDRUG("C",PSANDC,PSADRG,0)) Q:'PSASYN!('$D(^PSDRUG(PSADRG,1,PSASYN,0)))
 S PSAVSN=$P(^PSDRUG(PSADRG,1,PSASYN,0),"^",4),PSAOU=$S(+$P(^(0),"^",5):$P($G(^DIC(51.5,+$P(^(0),"^",5),0)),"^"),1:"")
 S PSADUOU=$S(+$P(^PSDRUG(PSADRG,1,PSASYN,0),"^",7):+$P(^(0),"^",7),1:""),PSADU=$P($G(^PSDRUG(PSADRG,660)),"^",8)
 Q:PSAVSN=""
 S PSALVSN="VSN: "_PSAVSN I PSAOU'="",+PSADUOU,PSADU'="" S PSALVSN=PSALVSN_" "_PSADUOU_" "_PSADU_"/"_PSAOU
 K PSASYN,PSAVSN,PSAOU,PSADUOU,PSADU
 Q
SETMSG ;Creates the body of the mail message.
 I PSAFIRST D
 .I PSACNT'=0 S PSACNT=PSACNT+1,^TMP("PSAMSGO",$J,PSACNT)="=============================================================================",PSACNT=PSACNT+1,^TMP("PSAMSGO",$J,PSACNT)=" "
 .K PSALOCA D SITES^PSAUTL1 S PSALOCA($P(^PSD(58.8,PSALOC,0),"^")_PSACOMB,PSALOC)=PSAISIT_"^"_PSAOSIT,PSALOCN=$O(PSALOCA("")),PSAFIRST=0
 .S PSACNT=PSACNT+1,PSACNT(PSACNT)=$S($P(^PSD(58.8,PSALOC,0),"^",2)="P":"PHARMACY LOCATION",1:"MASTER VAULT")
 .I $L(PSALOCN)>76 S PSACNT=PSACNT+1,^TMP("PSAMSGO",$J,PSACNT)=$P(PSALOCN,"(IP)",1)_"(IP)" S PSACNT=PSACNT+1,^TMP("PSAMSGO",$J,PSACNT)="                 "_$P(PSALOCN,"(IP)",2)
 .I $L(PSALOCN)<77 S PSACNT=PSACNT+1,^TMP("PSAMSGO",$J,PSACNT)=PSALOCN
 .S PSACNT=PSACNT+1,^TMP("PSAMSGO",$J,PSACNT)="                                           Stock    Current    Amount to"
 .S PSACNT=PSACNT+1,^TMP("PSAMSGO",$J,PSACNT)="Drug Name:                                 Level    Balance        Order"
 .S PSACNT=PSACNT+1,^TMP("PSAMSGO",$J,PSACNT)="-----------------------------------------------------------------------------"
 S PSALEN=$L(PSADRG),PSASPACE=$E("                                        ",1,(42-PSALEN))
 S PSACNT=PSACNT+1,^TMP("PSAMSGO",$J,PSACNT)=PSADRG_PSASPACE_$J(PSASTOCK,6,0)_"     "_$J(PSABAL,6,0)_"       "_$S((PSASTOCK-PSABAL)>.001:$J((PSASTOCK-PSABAL),6,0),1:"   N/A")
 S PSACNT=PSACNT+1 S:$G(PSAVSN)'="" ^TMP("PSAMSGO",$J,PSACNT)="  "_PSAVSN
 Q
 ;
EXIT ;Kills the variables & TMP globals.
 K ^TMP("PSAMSGO",$J),^TMP("PSAORD",$J),^TMP("PSAORDCS",$J)
 K PSA,PSABAL,PSACNT,PSACOMB,PSADRG,PSAFIRST,PSAISIT,PSALEN,PSALOC,PSALOCA,PSALOCN,PSANODE,PSAOSIT,PSAISITN,PSAOSITN,PSASPACE,PSASTOCK,XMDUZ,XMSUB,XMTEXT,XMY
 Q
