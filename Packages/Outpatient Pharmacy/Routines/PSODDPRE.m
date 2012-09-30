PSODDPRE ;BIR/SAB - Enhanced OP order checks ;09/20/06 3:38pm
 ;;7.0;OUTPATIENT PHARMACY;**251,375,387,379**;DEC 1997;Build 28
 ;External references PSOL and PSOUL^PSSLOCK supported by DBIA 2789
 ;External references to ^PSSDSAPM supported by DBIA 5570
 ;External references to ^PSSHRQ2 supported by DBIA 5369
 ;External reference to ^PS(50.7 supported by DBIA 2223
 ;External reference to ^PS(55 supported by DBIA 2228
 ;External reference to ^PSDRUG( supported by DBIA 221
 ;External reference to ^PS(50.606 supported by DBIA 2174
 ;External reference to $$SUP^PSSDSAPI supported by DBIA 5425
 ;
 K IT,^TMP("PSORXDC",$J),^TMP("PSORXDD",$J),CLS,^TMP($J,"PSONVADD"),^TMP($J,"PSONRVADD"),^TMP($J,"PSORDI"),^TMP($J,"PSORMDD")
 N PSONULN,PSODLQT,ZZPSODRG S LIST="PSOPEPS",$P(PSONULN,"-",79)="-",(STA,DNM)=""
 D HD^PSODDPR2():(($Y+5)'>IOSL) Q:$G(PSODLQT)
 F  S STA=$O(PSOSD(STA)) Q:STA=""  F  S DNM=$O(PSOSD(STA,DNM)) Q:DNM=""!$G(PSORX("DFLG"))  I $P(PSOSD(STA,DNM),"^")'=$G(PSORENW("OIRXN")) D  Q:$G(PSORX("DFLG"))
 .I STA="PENDING" D ^PSODDPR1 Q
 .I STA="ZNONVA" D NVA^PSODDPR1 Q
 .D:PSODRUG("NAME")=$P(DNM,"^")&('$D(^XUSEC("PSORPH",DUZ)))  Q:$G(PSORX("DFLG"))
 ..I '$P(PSOPAR,"^",2),'$P(PSOPAR,"^",16) D DUP I $G(PSOTECCK) S PSORX("DFLG")=1 Q
 ..I '$P(PSOPAR,"^",2),$P(PSOPAR,"^",16),$G(PSOTECCK) D DUP Q
 ..I $P(PSOPAR,"^",2),$G(PSOTECCK) D  Q
 ...S DA=+PSOSD(STA,DNM),PSOCLC=DUZ
 ...S MSG="Discontinued During Reinstating Prescription Entry",ACT="Discontinued during Rx Reinstate."
 ...S ^TMP("PSORXDC",$J,DA,0)="52^"_DA_"^"_MSG_"^C^"_ACT_"^"_STA_"^"_DNM,PSONOOR="D",^TMP("PSORXDD",$J)=DNM
 ..I $P($G(PSOPAR),"^",16) D DUP Q
 ..I $P(PSOPAR,"^",2),'$P(PSOPAR,"^",16) D DUP S PSORX("DFLG")=1 Q
 .D:PSODRUG("NAME")=$P(DNM,"^")&($D(^XUSEC("PSORPH",DUZ))) DUP
 K ^TMP($J,"DD"),^TMP($J,"DC"),^TMP($J,"DI"),^TMP($J,"PSODRDI")
 Q:$G(PSORX("DFLG"))
 M ZZPSODRG=PSODRUG
 S LIST="PSOPEPS" D REMOTE^PSOCPPRE
 M PSODRUG=ZZPSODRG
 Q
OBX  ;process enhanced order checks
 K ZDGDG,ZTHER,IT
 S LIST="PSOPEPS" K PSODLQT,DTOUT,DUOUT,DIRUT,PSODOSD
 I $P(^TMP($J,LIST,"OUT",0),"^")=-1 G EXIT
 W !,"Now Processing Enhanced Order Checks!  Please wait...",! H 2
 D FDB S PDRG=PSODRUG("IEN"),DO=0 D IN^PSSHRQ2(LIST)    ;call 2 fdb
 ;
 K DIR
 I $P(^TMP($J,LIST,"OUT",0),"^")=-1 D DATACK G EXIT
 D ^PSODDPR2 ;if order checks returned
 I '$G(PSOCOPY)&('$G(PSORENW)),$G(PSOQUIT) D
 .I $G(PSOREINS) Q:$G(PSODLQT)  S PSORX("DFLG")=1
 ;
EXIT ;
 D ^PSOBUILD
 K CAN,DA,DIR,DNM,DUPRX0,ISSD,J,LSTFL,MSG,PHYS,PSOCLC,PSONULN,REA,RFLS,RX0,RX2,RXN,RXREC,ST,Y,ZZ,ACT,PSOCLOZ,PSOLR,PSOLDT,PSOCD,SIG
 K DO,PDRG,IT,PSODLQT
 K ^TMP($J,LIST,"IN","PING"),^TMP($J,LIST,"OUT","EXCEPTIONS"),^TMP($J,"PSOPEPS"),^TMP($J,"PSORDI")
 Q
DUP S:$P(PSOSD(STA,DNM),"^",2)<10!($P(PSOSD(STA,DNM),"^",2)=16) DUP=1 W !,PSONULN,!,$C(7),"Duplicate Drug in Local Rx:",!
 S RXREC=+PSOSD(STA,DNM),MSG="Discontinued During "_$S('$G(PSONV):"New Prescription Entry",1:"Verification")_" - Duplicate Drug"
DATA S DUPRX0=^PSRX(RXREC,0),RFLS=$P(DUPRX0,"^",9),ISSD=$P(^PSRX(RXREC,0),"^",13),RX0=DUPRX0,RX2=^PSRX(RXREC,2),$P(RX0,"^",15)=+$G(^PSRX(RXREC,"STA"))
 S RXRECLOC=$G(RXREC)
 S DA=RXREC
 D HD^PSODDPR2():(($Y+5)'>IOSL) Q:$G(PSODLQT)
 W !,$J("Rx: ",24)_$P(^PSRX(+PSOSD(STA,DNM),0),"^")
 W !,$J("Drug: ",24)_$P(DNM,"^")
 K FSIG,BSIG I $P($G(^PSRX(RXREC,"SIG")),"^",2) D FSIG^PSOUTLA("R",RXREC,54) F PSREV=1:1 Q:'$D(FSIG(PSREV))  S BSIG(PSREV)=FSIG(PSREV)
 K FSIG,PSREV I '$P($G(^PSRX(RXREC,"SIG")),"^",2) D EN2^PSOUTLA1(RXREC,54)
 W !,$J("SIG: ",24) W $G(BSIG(1))
 I $O(BSIG(1)) F PSREV=1:0 S PSREV=$O(BSIG(PSREV)) Q:'PSREV  W !?24,$G(BSIG(PSREV))
 K BSIG,PSREV
 D HD^PSODDPR2():(($Y+5)'>IOSL) Q:$G(PSODLQT)
 W !,$J("QTY: ",24)_$P(DUPRX0,"^",7),?42,$J("Refills remaining: ",24),RFLS-$S($D(^PSRX(RXREC,1,0)):$P(^(0),"^",4),1:0)
 S PHYS=$S($D(^VA(200,+$P(DUPRX0,"^",4),0)):$P(^(0),"^"),1:"UNKNOWN")
 W !,$J("Provider: ",24)_PHYS,?42,$J("Issued: ",24),$E(ISSD,4,5)_"/"_$E(ISSD,6,7)_"/"_$E(ISSD,2,3)
 W !,$J("Status: ",24) S J=RXREC D STAT^PSOFUNC W ST K RX0,RX2
 S LSTFL=+^PSRX(RXREC,3) W ?42,$J("Last filled: ",24)_$E(LSTFL,4,5)_"/"_$E(LSTFL,6,7)_"/"_$E(LSTFL,2,3)
 D PRSTAT(RXREC)
 W !?42,$J("Days Supply: ",24)_$P(DUPRX0,"^",8)
 W !,PSONULN,! I $P($G(^PS(53,+$P($G(PSORX("PATIENT STATUS")),"^"),0)),"^")["AUTH ABS"!($G(PSORX("PATIENT STATUS"))["AUTH ABS")&'$P(PSOPAR,"^",5) W !,"PATIENT ON AUTHORIZED ABSENCE!" K RXRECLOC Q
ASKCAN I $P(PSOSD(STA,DNM),"^",2)>10,$P(PSOSD(STA,DNM),"^",2)'=16 D  Q
 .K DIR S DIR(0)="E",DIR("?")="Press Return to continue",DIR("A")="Press Return to continue" D ^DIR S:($D(DTOUT))!($D(DUOUT)) PSODLQT=1,PSORX("DFLG")=1 K DIR,DTOUT,DUOUT,DIRUT,RXRECLOC
 .S ^TMP("PSORXDD",$J,RXREC,0)=1
 I '$P(PSOPAR,"^",16),'$D(^XUSEC("PSORPH",DUZ)) D  Q
 .S PSORX("DFLG")=1 K RXRECLOC,DIR S DIR(0)="E",DIR("?")="Press Return to continue",DIR("A")="Press Return to continue"
 .D ^DIR K DIR
 I $P(PSOSD(STA,DNM),"^",2)=16,$G(DUP) D  Q
 .W !!,"Prescription "_$P($G(^PSRX(+$G(RXRECLOC),0)),"^")_" is on Provider Hold, it cannot be discontinued.",!
 .K DUP,DIR,RXRECLOC S PSORX("DFLG")=1 S DIR(0)="E",DIR("?")="Press Return to continue",DIR("A")="Press Return to continue" D ^DIR K DIR
 D PSOL^PSSLOCK(RXRECLOC) I '$G(PSOMSG) D  K PSOMSG,DIR,DUP,RXRECLOC S DIR("A")="Press Return to continue",DIR(0)="E",DIR("?")="Press Return to continue" D ^DIR K DIR S PSORX("DFLG")=1 Q
 .I $P($G(PSOMSG),"^",2)'="" W !!,$P(PSOMSG,"^",2),! Q
 .W !!,"Another person is editing Rx "_$P($G(^PSRX(RXRECLOC,0)),"^"),!
 K PSOMSG S DIR("A")=$S($P(PSOSD(STA,DNM),"^",2)=12:"Reinstate",1:"Discontinue")_" RX # "_$P(^PSRX(+PSOSD(STA,DNM),0),"^")_" "_$P(DNM,"^")_" Y/N",DIR(0)="Y"
 S DIR("?")="Enter Y to "_$S($P(PSOSD(STA,DNM),"^",2)=12:"reinstate",1:"discontinue")_" this RX."
 D ^DIR K DIR S DA=RXREC S ACT=$S($D(SPCANC):"Reinstated during Rx cancel.",1:$S($P(PSOSD(STA,DNM),"^",2)=12:"Reinstated",1:"Discontinued")_" while "_$S('$G(PSONV):"entering",1:"verifying")_" new RX")
 D CMOP^PSOUTL I $G(CMOP("S"))="L" W !,"A CMOP Rx cannot be discontinued during transmission!",! S Y=0 K CMOP
 I 'Y W !,$C(7)," -Prescription was not "_$S($P(PSOSD(STA,DNM),"^",2)=12:"reinstated",1:"discontinued")_"..." D  Q
 .S:'$D(PSOCLC) PSOCLC=DUZ S MSG=ACT,REA=$S($P(PSOSD(STA,DNM),"^",2)=12:"R",1:"C") S:$G(DUP) PSORX("DFLG")=1 K DUP D ULRX K RXRECLOC
 .K ^TMP("PSORXDC",$J,RXREC,0)
 I $P(PSOSD(STA,DNM),"^",2)=16,$G(CLS) W !!,"Prescription "_$P($G(^PSRX(+$G(RXRECLOC),0)),"^")_" is on Provider Hold, it cannot be discontinued.",! D ULRX K CLS,DUP,RXRECLOC S PSORX("DFLG")=1 H 2 Q
 S PSOCLC=DUZ,MSG=$S($G(MSG)]"":MSG,1:ACT_" During New RX "_$S('$G(PSONV):"Entry",1:"Verification")_" - Duplicate Rx"),REA=$S($P(PSOSD(STA,DNM),"^",2)=12:"R",1:"C")
 W !! K ^UTILITY($J,"W") S DIWL=1,DIWR=75,DIWF=""
 S X="Rx #"_$P(^PSRX(+PSOSD(STA,DNM),0),"^")_" "_DNM_" will be discontinued after"_$S('$G(PSOTECCK):" the acceptance of the new order.",1:" reinstating the order.") D ^DIWP
 F ZX=0:0 S ZX=$O(^UTILITY($J,"W",1,ZX)) Q:'ZX  W !,^UTILITY($J,"W",1,ZX,0)
 K ^UTILITY($J,"W"),X,DIWL,DIWR,DIWF W !
 S ^TMP("PSORXDC",$J,RXREC,0)="52^"_DA_"^"_MSG_"^"_REA_"^"_ACT_"^"_STA_"^"_DNM,PSONOOR="D",^TMP("PSORXDD",$J)=DNM H 2
 K RXRECLOC,DUP,CLS,PSONOOR
 Q
FDB ;build drug check input
 N ID,ORTYP,PSOI,ORN S DFN=PSODFN,CT=0
 S ID=+$$GETVUID^XTID(50.68,,+$P(PSODRUG("NDF"),"A",2)_",")
 S P1=$P(PSODRUG("NDF"),"A"),P2=$P(PSODRUG("NDF"),"A",2),X=$$PROD0^PSNAPIS(P1,P2),SEQN=+$P(X,"^",7)
 I 'SEQN K ^TMP($J,LIST,"OUT","EXCEPTIONS"),^TMP($J,LIST,"IN")
 S ^TMP($J,LIST,"IN","PROSPECTIVE","Z;1;PROSPECTIVE;1")=SEQN_"^"_ID_"^"_PSODRUG("IEN")_"^"_$P(^PSDRUG(PSODRUG("IEN"),0),"^")
 S ^TMP($J,LIST,"IN","IEN")=PSODFN,^TMP($J,LIST,"IN","DRUGDRUG")="",^TMP($J,LIST,"IN","THERAPY")=""
 K ID,P1,P2 N ODRG,TU S (STA,DNM)="" I '$G(PSOCOPY),'$G(SEQN) K SEQN Q
 ;build profile drug order checks
 F  S STA=$O(PSOSD(STA)) Q:STA=""  F  S DNM=$O(PSOSD(STA,DNM)) Q:DNM=""   D  ;I $P(PSOSD(STA,DNM),"^")'=$G(PSORENW("OIRXN")) S CT=CT+1 D
 .Q:$P(PSOSD(STA,DNM),"^")=$G(PSORENW("OIRXN"))&('$G(PSOCOPY))
 .S CT=CT+1
 .I STA="PENDING" N DDRG D
 ..Q:$G(^TMP("PSORXDC",$J,$P(PSOSD(STA,DNM),"^",10),0))]""
 ..Q:$G(PSODRUG("IEN"))=$P(^PS(52.41,$P(PSOSD(STA,DNM),"^",10),0),"^",9)
 ..Q:$P(^PS(52.41,$P(PSOSD(STA,DNM),"^",10),0),"^",3)="RF"
 ..Q:$G(^TMP("PSORXPO",$J,$P(PSOSD(STA,DNM),"^",10),0))
 ..S RXREC=$P(PSOSD(STA,DNM),"^",10),ORN=$P(^PS(52.41,RXREC,0),"^"),ODRG=$P(^(0),"^",9),ORTYP="P"
 ..I ODRG D  K ODRG Q
 ...I $P($G(^PSDRUG(ODRG,0)),"^",3)["S"!($E($P($G(^PSDRUG(ODRG,0)),"^",2),1,2)="XA") Q 
 ...S PDNM=$P(^PSDRUG(ODRG,0),"^") D ID
 ..E  N PSOI,DDRG,ODRG,SEQN,DDRG S PSOI=$P(^PS(52.41,RXREC,0),"^",8) D
 ...S PDNM=$P(^PS(50.7,PSOI,0),"^")_" "_$P(^PS(50.606,$P(^(0),"^",2),0),"^")
 ...S DDRG=$$DRG^PSSDSAPM(PSOI,"O") I '$P(DDRG,";") D OIX Q
 ...I $P($G(^PSDRUG($P(DDRG,";"),0)),"^",3)["S"!($E($P($G(^PSDRUG($P(DDRG,";"),0)),"^",2),1,2)="XA") Q
 ...S ODRG=$P(DDRG,";"),SEQN=+$P(DDRG,";",3) K PSOI
 ...N ID S ID=+$$GETVUID^XTID(50.68,,+$P($G(^PSDRUG(ODRG,"ND")),"^",3)_",")
 ...D ID1
 .I STA="ZNONVA" D  Q
 ..Q:$G(^TMP($J,"PSONVADD",$P(PSOSD(STA,DNM),"^",10),0))]""
 ..S RXREC=$P(PSOSD(STA,DNM),"^",10),ODRG=$P(^PS(55,PSODFN,"NVA",RXREC,0),"^",2),ORN=$P(^(0),"^",8),ORTYP="N"
 ..I ODRG D  K ODRG Q
 ...I $P($G(^PSDRUG(ODRG,0)),"^",3)["S"!($E($P($G(^PSDRUG(ODRG,0)),"^",2),1,2)="XA") Q
 ...S PDNM=$P(^PSDRUG(ODRG,0),"^") D ID
 ..E  N PSOI,DDRG,ODRG,SEQN,DDRG S PSOI=$P(^PS(55,PSODFN,"NVA",RXREC,0),"^") D
 ...S PDNM=$P(^PS(50.7,PSOI,0),"^")_" "_$P(^PS(50.606,$P(^(0),"^",2),0),"^")
 ...S DDRG=$$DRG^PSSDSAPM(PSOI,"X") I '$P(DDRG,";") D:'$$NVATST(PSOI) OIX Q
 ...I $P($G(^PSDRUG($P(DDRG,";"),0)),"^",3)["S"!($E($P($G(^PSDRUG($P(DDRG,";"),0)),"^",2),1,2)="XA") Q
 ...S ODRG=$P(DDRG,";"),SEQN=+$P(DDRG,";",3) K PSOI
 ...N ID S ID=+$$GETVUID^XTID(50.68,,+$P($G(^PSDRUG(ODRG,"ND")),"^",3)_",")
 ...D ID1
 .I $P($G(^PSRX(+PSOSD(STA,DNM),0)),"^",6) D
 ..Q:$G(^TMP("PSORXDC",$J,$P(PSOSD(STA,DNM),"^"),0))]""
 ..Q:$G(^TMP("PSORXBO",$J,$P(PSOSD(STA,DNM),"^"),0))
 ..Q:$G(^TMP("PSORXDD",$J,$P(PSOSD(STA,DNM),"^"),0))
 ..;I $P(PSOSD(STA,DNM),"^",2)>5,$P(PSOSD(STA,DNM),"^",2)'=16 Q
 ..S RXREC=+PSOSD(STA,DNM),ODRG=$P(^PSRX(RXREC,0),"^",6),ORN=$P($G(^("OR1")),"^",2),ORTYP="O"
 ..I ODRG D
 ...I $P($G(^PSDRUG(ODRG,0)),"^",3)["S"!($E($P($G(^PSDRUG(ODRG,0)),"^",2),1,2)="XA") Q
 ...I STA="DISCONTINUED" Q:$$DUPTHER(RXREC)
 ...S PDNM=$P(^PSDRUG(ODRG,0),"^") D ID
 K RXREC,ID,STA,DNM,PSOI,ORN,ODRG,ORTYP,CT,PDNM,TU,DDRG
 Q
ID N ID,P1,P2 S ID=+$$GETVUID^XTID(50.68,,+$P($G(^PSDRUG(ODRG,"ND")),"^",3)_",")
 S P1=$P($G(^PSDRUG(ODRG,"ND")),"^"),P2=$P($G(^("ND")),"^",3),X=$$PROD0^PSNAPIS(P1,P2),SEQN=$P(X,"^",7)
ID1 S ^TMP($J,LIST,"IN","PROFILE",ORTYP_";"_RXREC_";PROFILE;"_CT)=SEQN_"^"_ID_"^"_ODRG_"^"_PDNM_"^"_ORN_"^O" K ID
 Q
DUPTHER(RXREC) ;screen out discontinued/duplicate therapy Rx's greater than business rule calculation (cancel date + days supply +7 days)
 ;Note: If the dup allowance is 1 you have to have at least 3 eligible drug orders (or 2 matches) to produce the dupl. therapy warning
 ;Business rule for expired orders is (expiration date+120 days) which is the length of time expired order currently stay on med profile.  No changes for this.
 N X,Y,X1,X2 S X1=$P($G(^PSRX(RXREC,3)),"^",5),X2=(+$P(^PSRX(RXREC,0),"^",8)+7) D C^%DTC I DT>X Q 1
 Q 0
OIX S ^TMP($J,LIST,"IN","EXCEPTIONS","OI",PDNM)=1_"^"_ORTYP_";"_RXREC_";PROFILE;"_CT
 Q
ULRX ;
 I '$G(RXRECLOC) Q
 D PSOUL^PSSLOCK(RXRECLOC)
 Q
 ;
PRSTAT(DA) ;Displays the prescription's status
 N PSOTRANS,PSOREL,PSOCMOP,RXPSTA,PSOX,RFLZRO,PSOLRD,PSORTS,CMOP
 D HD^PSODDPR2():(($Y+5)'>IOSL) Q:$G(PSODLQT)  S RXPSTA="Processing Status: ",PSOLRD=$P($G(^PSRX(RXREC,2)),"^",13)
 D ^PSOCMOPA I $G(PSOCMOP)]"" D  K CMOP,PSOTRANS,PSOREL
 .S PSOTRANS=$E($P(PSOCMOP,"^",2),4,5)_"/"_$E($P(PSOCMOP,"^",2),6,7)_"/"_$E($P(PSOCMOP,"^",2),2,3)
 .S PSOREL=$S(CMOP("L")=0:$P($G(^PSRX(DA,2)),"^",13),1:$P(^PSRX(DA,1,CMOP("L"),0),"^",18))
 .S PSOREL=$E(PSOREL,4,5)_"/"_$E(PSOREL,6,7)_"/"_$E(PSOREL,2,3)_"@"_$E($P(PSOREL,".",2),1,4)
 .I '$D(IOINORM)!('$D(IOINHI)) S X="IORVOFF;IORVON;IOINHI;IOINORM" D ENDR^%ZISS
 .I $P($G(^PSRX(RXREC,"STA")),"^")=0 W:$$TRANCMOP^PSOUTL(RXREC) ?5,IORVON_IOINHI
 .S:$G(PSODUPF) PSODUPC(ZCT)=PSODUPC(ZCT)+1 W:'$G(PSODUPF) !,$J(RXPSTA,24)_$S($P(PSOCMOP,"^")=0!($P(PSOCMOP,"^")=2):"Transmitted to CMOP on "_PSOTRANS,$P(PSOCMOP,"^")=1:"Released by CMOP on "_PSOREL,1:"Not Dispensed"),IOINORM_IORVOFF
 D HD^PSODDPR2():(($Y+5)'>IOSL) Q:$G(PSODLQT)
 I $G(PSOCMOP)']"" D
 .F PSOX=0:0 S PSOX=$O(^PSRX(RXREC,1,PSOX)) Q:'PSOX  D
 ..S RFLZRO=$G(^PSRX(RXREC,1,PSOX,0))
 ..S:$P(RFLZRO,"^",18)'="" PSOLRD=$P(RFLZRO,"^",18) I $P(RFLZRO,"^",16) S PSOLRD=PSOLRD_"^R",PSORTS=$P(RFLZRO,"^",16)
 .I '$O(^PSRX(RXREC,1,0)),$P(^PSRX(RXREC,2),"^",15) S PSOLRD=PSOLRD_"^R",PSORTS=$P(^PSRX(RXREC,2),"^",15)
 .S:$G(PSODUPF) PSODUPC(ZCT)=PSODUPC(ZCT)+1 W:'$G(PSODUPF) !,$J(RXPSTA,24)
 .I +$G(PSORTS) S:$G(PSODUPF) PSODUPC(ZCT)=PSODUPC(ZCT)+1 W:'$G(PSODUPF) "Returned to stock on "_$$FMTE^XLFDT(PSORTS,2) Q
 .S:$G(PSODUPF) PSODUPC(ZCT)=PSODUPC(ZCT)+1 W:'$G(PSODUPF) $S(PSOLRD="":"Not released locally",1:"Released locally on "_$$FMTE^XLFDT($P(PSOLRD,"^"),2)_" "_$P(PSOLRD,"^",2))_$S($P(^PSRX(RXREC,0),"^",11)="W":" (Window)",1:" (Mail)")
 Q
 ;
DATACK ;check FDB returned data to determine whether to continue processing.
 S DIR(0)="E",DIR("A",1)="No Enhanced Order Checks can be performed."
 S DIR("A",2)="   Reason: "_$P($G(^TMP($J,LIST,"OUT",0)),"^",2)
 S DIR("A")="Press Return to continue...",DIR("?")="Press Return to continue"
 W ! D ^DIR K DIRUT,DUOUT,DIR,X,Y  W @IOF ;I $P(^TMP($J,LIST,"OUT",0),"^")=1
 Q
 ;
NVATST(PSONVTOI) ; Look for any active Non-VA Dispense Drugs not marked as a supply item
 N PSONVT1,PSONVTFL,PSONVTIN
 S PSONVTFL=1
 F PSONVT1=0:0 S PSONVT1=$O(^PSDRUG("ASP",PSONVTOI,PSONVT1)) Q:'PSONVT1!('PSONVTFL)  D
 .I $P($G(^PSDRUG(PSONVT1,2)),"^",3)'["X" Q
 .S PSONVTIN=$P($G(^PSDRUG(PSONVT1,"I")),"^") I PSONVTIN,PSONVTIN<DT Q
 .S PSONVTFL=$$SUP^PSSDSAPI(PSONVT1)
 Q PSONVTFL
