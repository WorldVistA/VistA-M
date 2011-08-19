PSOORUTL ;ISC BHAM/SAB  - updates order status from oerr ;2/25/09 9:47am
 ;;7.0;OUTPATIENT PHARMACY;**14,46,146,132,118,199,223,148,249,274,225,324**;DEC 1997;Build 6
 ;External reference to EN^ORERR - 2187
 ;External reference to ^PS(55 - 2228
 ;Input variables, poerr("psofilnm")=pharmacy pointer # from OE/RR, poerr("stat")=Order Control status
 ;poerr("pharmst")=will contain 'ZE'if rx has expired, poerr("comm")=Comments, poerr("user")=Person placing request
EN(POERR) ;
 N PSZORS,III
 F OO=0:0 S OO=$O(MSG(OO)) Q:'OO  I $P(MSG(OO),"|")="ZRN" S NVA=1
 I $G(NVA) G NVA
 G:POERR("PSOFILNM")'["S" RXO S III=+POERR("PSOFILNM")
 S ORS=0 I $D(^PS(52.41,III,0)) D  G PEXIT
 .Q:$P($G(^PS(52.41,III,0)),"^",3)="RF"
 .I $G(PDFN),$P($G(^PS(52.41,III,0)),"^",2),PDFN'=$P(^PS(52.41,III,0),"^",2) S ORS=1
RXO S III=POERR("PSOFILNM") I $D(^PSRX(III,0)) D  G PEXIT
 .I $G(PDFN),$P($G(^PSRX(III,0)),"^",2),PDFN'=$P(^PSRX(III,0),"^",2) S ORS=1
 S (ORS,PSZORS)=1
PEXIT I $G(ORS) S POERR("STAT")=$S(POERR("STAT")="CA":"UC",POERR("STAT")="DC":"UD",POERR("STAT")="HD":"UH",1:"UR"),POERR("FILLER")="",POERR("COMM")=$S($G(PSZORS):"Invalid Pharmacy order number",1:"Patient does not match.") K ORS,PSZORS,III Q
 S POERR("PHARMST")="" G:POERR("STAT")="HD"!(POERR("STAT")="RL") HD
 S ORS=0 I POERR("PSOFILNM")["S" S DA=+POERR("PSOFILNM") I $D(^PS(52.41,DA,0)) D  G EXIT
 .Q:$P($G(^PS(52.41,DA,0)),"^",3)="RF"
 .S $P(^PS(52.41,DA,0),"^",3)="DC",POERR("PLACE")=$P(^(0),"^"),POERR("STAT")="CR",POERR("FILLER")=DA_"^P"
 .K ^PS(52.41,"AOR",+$P($G(^PS(52.41,DA,0)),"^",2),+$P($G(^PS(52.41,DA,"INI")),"^"),DA)
 .S:$G(POERR("COMM"))']"" POERR("COMM")="Order Canceled by OE/RR before finishing." S ORS=1,$P(^PS(52.41,DA,4),"^")=$G(POERR("COMM"))
 S DA=POERR("PSOFILNM") D:$D(^PSRX(DA,0)) REVERSE^PSOBPSU1(DA,,"DC",7)
 I $D(^PSRX(DA,0)) D  S $P(^PSRX(DA,"STA"),"^")=14,$P(^PSRX(DA,3),"^",5)=DT,$P(^PSRX(DA,3),"^",10)=$P(^PSRX(DA,3),"^") D CHKCMOP^PSOUTL(DA),CAN^PSOTPCAN(DA) G EXIT
 .;cancel/discontinue action
 .S POERR("PLACE")=+$P($G(^PSRX(DA,"OR1")),"^",2),POERR("STAT")=$S(POERR("STAT")="CA":"CR",1:"DR"),POERR("FILLER")=DA_"^R"
 .S:'$D(POERR("COMM")) POERR("COMM")="Prescription DISCONTINUED by OERR"
 .S ORS=1 D CAN
EXIT I '$G(ORS) D
 .S POERR("STAT")=$S(POERR("STAT")="CA":"UC",POERR("STAT")="DC":"UD",POERR("STAT")="HD":"UH",1:"UR"),POERR("FILLER")="",POERR("COMM")="Order was not located by Pharmacy"
 K EXP,ORS,DA,ACOM,RXDA,SUSD,PSUS,RXF,I,FDA,DIC,DIE,DR,Y,X,%,%I,%H,RSDT,ACNT,ACT,DIK,FDT,IR,LFD,NOW,ORD,PSDA,PSCDA,PSODFN,PSUS,RF,RFCNT,RXN,RXP,RXREF,SD,SUB
 Q
CAN S ACOM="Discontinued by OE/RR." I $P(^PSRX(DA,"STA"),"^")=3!($P(^("STA"),"^")=16) D
 .S ACOM="Discontinued by OE/RR while on hold. " K:$P(^PSRX(DA,"H"),"^") ^PSRX("AH",$P(^PSRX(DA,"H"),"^"),DA) S ^PSRX(DA,"H")=""
 .I $P(^PSRX(DA,0),"^",13),'$O(^PSRX(DA,1,0)) S DIE=52,DR="22///"_$E($P(^PSRX(DA,0),"^",13),1,7) D ^DIE K DIE,DR Q
 .S (IFN,SUSD)=0 F  S IFN=$O(^PSRX(DA,1,IFN)) Q:'IFN  S SUSD=IFN,RFDT=$P(^PSRX(DA,1,IFN,0),"^")
 .Q:'$G(SUSD)  I '$P(^PSRX(DA,1,SUSD,0),"^",18) S PSDTEST=0 D  I 'PSDTEST K ^PSRX(DA,1,SUSD),^PSRX("AD",RFDT,DA,SUSD),^PSRX(DA,1,"B",RFDT,SUSD),IFN,SUSD,RFDT
 ..F PDA=0:0 S PDA=$O(^PSRX(DA,"L",PDA)) Q:'PDA  I $P($G(^PSRX(DA,"L",PDA,0)),"^",2)=SUSD S PSDTEST=1
 ..K CMOP D ^PSOCMOPA I $G(CMOP(CMOP("L")))="",$G(CMOP("S"))'="L" Q
 ..S PSDTEST=1
 S RXDA=DA,(DA,SUSDA)=$O(^PS(52.5,"B",DA,0)) D:DA
 .S SUSD=$P($G(^PS(52.5,DA,0)),"^",2)
 .S:+$G(^PS(52.5,DA,"P"))'=1 ACOM="Discontinued by OE/RR while suspended."
 .I $O(^PSRX(RXDA,1,0)) S DA=RXDA D:'$G(^PS(52.5,+SUSDA,"P")) REF^PSOCAN2
 .S DA=SUSDA,DIK="^PS(52.5," D ^DIK K DIK
 K SUSD,SUSDA S DA=RXDA,RXREF=0,PSODFN=+$P(^PSRX(DA,0),"^",2) D
 .S ACNT=0 F SUB=0:0 S SUB=$O(^PSRX(DA,"A",SUB)) Q:'SUB  S ACNT=SUB
 .S RFCNT=0 F RF=0:0 S RF=$O(^PSRX(DA,1,RF)) Q:'RF  S RFCNT=RF S:RF>5 RFCNT=RF+1
 .D NOW^%DTC S ^PSRX(DA,"A",0)="^52.3DA^"_(ACNT+1)_"^"_(ACNT+1),^PSRX(DA,"A",ACNT+1,0)=%_"^C^"_POERR("USER")_"^"_RFCNT_"^"_$G(ACOM)
 .S REA="C" D EXP^PSOHELP1
 I $G(^PS(52.4,DA,0))]"" S PSCDA=DA,DIK="^PS(52.4," D ^DIK S DA=PSCDA K DIK,PSCDA
 Q
HD ;place order on hold
 G:POERR("STAT")="RL" REL^PSOORUT1 S (ACT,ORS)=0 I POERR("PSOFILNM")["S" D  G EXIT
 .S DA=+POERR("PSOFILNM")
 .Q:'$D(^PS(52.41,DA,0))  Q:$P(^PS(52.41,DA,0),"^",3)="RF"
 .S $P(^PS(52.41,DA,0),"^",3)="HD",POERR("STAT")="HR",POERR("FILLER")=DA_"^P"
 .S:$G(POERR("COMM"))']"" POERR("COMM")="Order PLACED on HOLD by OERR before finished." S $P(^PS(52.41,DA,4),"^")=POERR("COMM"),ORS=1
 S DA=POERR("PSOFILNM") I $D(^PSRX(DA,0)) S ORS=1,PSDA=DA D  G EXIT
 .S POERR("FILLER")=DA_"^R"
 .S:'$D(POERR("COMM")) POERR("COMM")="Prescription Placed on HOLD by OERR"
 .I DT>$P(^PSRX(DA,2),"^",6) S EXP=$P(^(2),"^",6) S:$P(^PSRX(DA,"STA"),"^")<12 $P(^PSRX(DA,"STA"),"^")=11,PSOEXFLG=1 S POERR("STAT")="UH",POERR("COMM")="Prescription EXPIRED on "_$E(EXP,4,5)_"/"_$E(EXP,6,7)_"/"_$E(EXP,2,3)_"." D  Q
 ..D ECAN^PSOUTL(DA)
 .I $P(^PSRX(DA,"STA"),"^")=3!($P(^("STA"),"^")>11) S POERR("STAT")="UH",POERR("COMM")="Unable to place on HOLD" Q
 .S $P(^PSRX(DA,"STA"),"^")=16,POERR("STAT")="HR",^PSRX(DA,"H")=99_"^"_POERR("COMM")_"^"_DT
 .S (PSUS,RXF)=0 F I=0:0 S I=$O(^PSRX(DA,1,I)) Q:'I  S RXF=I S:RXF>1 RSDT=$P(^(RXF-1,0),"^")
 .S DA=PSDA D ACT D REVERSE^PSOBPSU1(DA,,"HLD",2)
 .S DA=$O(^PS(52.5,"B",PSDA,0)) I DA S DIK="^PS(52.5,",PSUS=1 D ^DIK K DA,DIK
 I 'ORS S POERR("COMM")="Unable to place order on HOLD" G EXIT
 Q
NVA ;non-va med action
 N DIE,DR,DA K NVA
 I POERR("PSOFILNM")'["N"!('$D(^PS(55,PDFN,"NVA",+POERR("PSOFILNM"),0))) D EN^ORERR("Order was not located by Pharmacy",.MSG) Q
 I $G(OR("STAT"))'="CA",$G(OR("STAT"))'="DC" D EN^ORERR("Invalid Order Control Code",.MSG) Q
XO S ORD=+POERR("PSOFILNM")
 N TMP
 D NOW^%DTC
 K TMP S TMP(55.05,ORD_","_PDFN_",",5)=$S($G(PSODEATH):2,1:1)
 S TMP(55.05,ORD_","_PDFN_",",6)=%
 D FILE^DIE("","TMP")
 S PLACER=$P(^PS(55,PDFN,"NVA",ORD,0),"^",8)
 K MSG S NULLFLDS="F JJ=0:1:LIMIT S FIELD(JJ)="""""
 K ^UTILITY("DIQ1",$J),DIQ S DA=$P($$SITE^VASITE(),"^")
 I $G(DA) S DIC=4,DIQ(0)="I",DR="99" D EN^DIQ1 S PSOHINST=$G(^UTILITY("DIQ1",$J,4,DA,99,"I")) K ^UTILITY("DIQ1",$J),DA,DR,DIQ,DIC
 S MSG(1)="MSH|^~\&|PHARMACY|"_$G(PSOHINST)_"|||||ORR"
 ;
 S DFN=PDFN,COUNT=1,LIMIT=5 X NULLFLDS D DEM^VADPT S NAME=$G(VADM(1)) K VADM
 S FIELD(0)="PID",FIELD(3)=DFN,FIELD(5)=NAME
 D SEG^PSOHLSN1
 ;
 S LIMIT=15 X NULLFLDS
 S FIELD(0)="ORC",FIELD(2)=PLACER_"^OR",FIELD(3)=+POERR("PSOFILNM")_"N^PS"
 S FIELD(1)="SC",FIELD(5)="DC"
 D SEG^PSOHLSN1
 I $G(PSODEATH) S MSG(COUNT)=MSG(COUNT)_"|^^^^DATE OF DEATH ENTERED BY MAS.^"
 ;
 D SEND^PSOHLSN1 K FIELDS,LIMIT,PSODSC,PSONVA,OI
 Q
 ;
ACT ;activity log
 D NOW^%DTC S NOW=%
 S IR=0 F FDA=0:0 S FDA=$O(^PSRX(DA,"A",FDA)) Q:'FDA  S IR=FDA
 S IR=IR+1,^PSRX(DA,"A",0)="^52.3DA^"_IR_"^"_IR
 S RXF=$S(RXF>5:RXF+1,1:RXF)
 S ^PSRX(DA,"A",IR,0)=NOW_"^"_$S(ACT:"U",1:"H")_"^"_POERR("USER")_"^"_RXF_"^"_"RX "_$S('ACT:"placed in a",1:"removed from")_" HOLD status "_$S(+$G(PSUS):"and removed from SUSPENSE ",1:"")_"("_$E(DT,4,5)_"-"_$E(DT,6,7)_"-"_$E(DT,2,3)_") by OERR."
 Q
