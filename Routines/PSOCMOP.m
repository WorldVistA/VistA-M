PSOCMOP ;BIR/HTW-Rx Order Entry Screen for CMOP ;6/28/07 7:35am
 ;;7.0;OUTPATIENT PHARMACY;**2,16,21,27,43,61,126,148,274,347,251**;DEC 1997;Build 202
 ;External reference to ^PS(55 supported by DBIA 2228
 ;External reference to ^PSDRUG supported by DBIA 221
 ;External reference to ^PSDRUG supported by DBIA 3165
 ;External reference to ^PSSHUIDG supported by DBIA 3621
 ;External reference to $$DS^PSSDSAPI supported by DBIA 5424
TOP ;
 I $G(PSOFROM)="EDIT" S PPL=$G(PSORX("PSOL",1)) Q:$G(PPL)']""  G TEST
 I $G(PPL) G START
 I '$G(RXLTOP) S PPL=$G(DA) G TEST
 S:'$G(PPL) PPL=$G(PSORX("PSOL",1)) G:$G(PPL)']"" D1
START ;          Establish CMOP PPL
TEST N ACT,B,C,CK,COMM,CNT,DFLG,I,FLAG,MW,NEWDT,PI,P1,P2,REL,RFD,RX,RX0,RXN
 N RXP,RXS,SD,VALMSG,X,X7,Y,ZD,DFN,TRX
 S (P1,P2)=1,FLAG=0
LOOP F CNT=1:1 S RX=$P($G(PPL),",",CNT) Q:RX']""  D  S:'FLAG $P(RX("PSO"),",",P1)=RX,P1=P1+1 S FLAG=0
 .;   PSOMC=Mail Code, PSOMDT=Mail Code Expiration Date
 .N DFN  ;*347
 .S DFN=$P(^PSRX(RX,0),"^",2),PSOMDT=$P($G(^PS(55,DFN,0)),"^",5),PSOMC=$P($G(^PS(55,DFN,0)),"^",3) K DFN  ;*347
 .I (PSOMC>1&(PSOMDT>DT))!(PSOMC>1&(PSOMDT<1)) K PSOMC,PSOMDT Q  ;*347
 .;          Get drug IEN and check if CMOP
 .S CK=$P($G(^PSRX(RX,0)),"^",6) Q:'$D(^PSDRUG("AQ",CK))
 .;          If not marked for O.P., unmark for CMOP...
 .I $P($G(^PSDRUG(CK,2)),"^",3)'["O" D UNMARK^PSOCMOP Q
 .;          Check Drug Warning >11
 .N WARNS,COMM S WARNS=$P(^PSDRUG(CK,0),U,8) I $L(WARNS)>11 D  Q
 .. S COMM(1)="Rx# "_$P(^PSRX(RX,0),"^")_" CMOP cannot dispense - Drug warnings >11 characters."
 .. S COMM(2)="Drug Name: "_$P(^PSDRUG(CK,0),U)_"  (IEN: # "_CK_")"
 .. D COMM(RX,.COMM)
 .;           Q:If partial or pull early
 .Q:$G(RXPR(RX))!($G(RXRS(RX)))
 .;           Q:If standard reprint but allow edit reprint
 .I $G(RXRP(RX))&($P($G(RXRP(RX)),"^",4)'=1) Q
 .;           Q:If tradename
 .Q:$G(^PSRX(RX,"TN"))]""
 .;           Q: If Cancelled, Expired, Deleted, Hold
 .Q:$P(^PSRX(RX,"STA"),"^")>9!($P(^("STA"),"^")=4)!($P(^("STA"),"^")=3)
 .;        Find last fill
 .S RFD=0 F X7=0:0 S X7=$O(^PSRX(RX,1,X7)) Q:'$G(X7)  S (RFD)=X7
 .;if original fill and a tech stop
 .I 'RFD,$P(^PSRX(RX,"STA"),"^")=4!($D(^PSRX(RX,"DRI"))&('$D(^XUSEC("PSORPH",DUZ)))) Q
 .I 'RFD,$$DS^PSSDSAPI,($G(^PS(52.4,RX,1))>0)&('$D(^XUSEC("PSORPH",DUZ))) Q
 .Q:$G(RXFL(RX))&(RFD)&($G(RXFL(RX))'=RFD)
 .I '$O(^PSRX(RX,1,0)),'$P($G(^PSRX(RX,2)),"^",13),$P($G(^(0)),"^",11)="W",$S($P($G(^PSRX(RX,2)),"^",2):$P($G(^(2)),"^",2),1:+$G(PSOX("FILL DATE")))>DT D
 ..S PSOCPDA=$G(DA) K DIE S DA=RX,DIE="^PSRX(",DR="11////M" D ^DIE K DIE S:$G(PSOCPDA) DA=$G(PSOCPDA) K PSOCPDA
 .;           Q:If not "Mail"
 .S MW=$S($G(RFD)>0:$P(^PSRX(RX,1,RFD,0),"^",2),1:$P(^PSRX(RX,0),"^",11)) K X7 I $G(MW)="W"  K RFD Q
 .;
 .;           Q:If fill was CMOPed and other than a '3' 'not dispensed' 
 .Q:'$$FILTRAN(RX,RFD)
 .;
 .;            Check if released, for use in Sus
 .S REL=$S(RFD=0:$P($G(^PSRX(RX,2)),"^",13),1:$P($G(^PSRX(RX,1,RFD,0)),"^",18)) K RFD
 .I $G(REL) Q
 .;           Save CMOP's in PSXPPL1
 .S $P(RX("CMOP"),",",P2)=RX,P2=P2+1,FLAG=1 Q
 K PPL S PPL=$G(RX("PSO")),RX1("CMOP")=$G(RX("CMOP")) K RX("PSO")
 G:$G(XFROM)="EDIT" D1 ; passed from PSXEDIT
RESET ;
 G:'$G(RX("CMOP")) D1
 I $G(XFROM)="REINSTATE"!($G(XFROM)="UNHOLD") Q
 I $G(PSOFROM)="EDIT",($G(REL)]"") S PPL=RX("CMOP") G D1
S ;           Auto-Suspend CMOPS
 N DA,Y
 F PI=1:1 S DA=$P($G(RX("CMOP")),",",PI) Q:'DA  D SUS
 S SUSPT="SUSPENSE"
 G D1
SUS ;
 I $G(XFROM)="REINSTATE" W !,RX_" REINSTATED -- "
 S ACT=1,RXN=DA,RX0=^PSRX(DA,0),SD=$S($G(ZD(DA)):$E(ZD(DA),1,7),1:$P(^(3),"^")),RXS=$O(^PS(52.5,"B",DA,0)) I RXS D  Q:$G(DFLG)
 .S DA=RXS,DIK="^PS(52.5," D ^DIK S DA=RXN
 K X7 S RFD1=0 F X7=0:0 S X7=$O(^PSRX(DA,1,X7)) Q:'$G(X7)  S (RFD1)=X7
LOCK S RXP=+$G(RXPR(DA)),DIC="^PS(52.5,",DIC(0)="",X=RXN
 S DIC("DR")=".02////"_SD_";.03////"_$P(^PSRX(DA,0),"^",2)_";.04////M;.05////"_RXP_";.06////"_PSOSITE_";2////0;3////Q;9////"_RFD1
 K DD,DO D FILE^DICN K DD,DO S DA=RXN I +Y S PSONAME=$P(^PSRX(DA,0),"^",2) K ^PS(52.5,"AC",PSONAME,SD,+Y),PSONAME
 S $P(^PSRX(RXN,"STA"),"^")=5,LFD=$E(SD,4,5)_"-"_$E(SD,6,7)_"-"_$E(SD,2,3) D ACT
 W !!,"RX# ",$P(^PSRX(RXN,0),"^")_" HAS BEEN SUSPENDED for CMOP Until "_LFD_"."
 S VALMSG="Rx# "_$P(^PSRX(RXN,0),"^")_" Has Been Suspended for CMOP Until "_LFD_"."
 S COMM="Rx# "_$P(^PSRX(RXN,0),"^")_" Has Been Suspended for CMOP Until "_LFD_"."
 D EN^PSOHLSN1(RXN,"SC","ZS",COMM) K COMM
 ;- Calling ECME to reverse any PAYABLE claim for the prescription/fill
 D REVERSE^PSOBPSU1(RXN,,"DC",3)
 Q
ACT S RXF=0 F I=0:0 S I=$O(^PSRX(DA,1,I)) Q:'I  S RXF=I S:I>5 RXF=I+1
 S IR=0 F FDA=0:0 S FDA=$O(^PSRX(DA,"A",FDA)) Q:'FDA  S IR=FDA
 S IR=IR+1,^PSRX(DA,"A",0)="^52.3DA^"_IR_"^"_IR
 D NOW^%DTC S ^PSRX(DA,"A",IR,0)=%_"^S^"_DUZ_"^"_RXF_"^"_"RX Placed on Suspense for CMOP until "_LFD
 K RXF,I,FDA,DIC,DIE,DR,Y,X,%,%H,%I
 Q
D1 K CNT,COUNT,DFLG,DIRUT,DIROUT,DTOUT,DUOUT,EXDT,FLAG,FLD,L,PDUZ,PI,X7
 K PSOCMOP,REF,REPRINT,RFDATE,RFL1,RFLL,RXPD,SD,SUSPT,WARN,XFROM,ZY,RX1
 Q
RXL N FROM S FROM=$G(PSOFROM)
 I ((FROM="NEW")!(FROM="REFILL")!(FROM="CANCEL")!(FROM="BATCH")!($G(XFROM)="HOLD")!($G(XFROM)="BATCH")) G TOP
 Q
SUS1 ;
 N PPL
 S PPL=DA D TEST
 I $G(PPL)']"" S XFLAG=1
 S RX("CMOP")=$G(RX1("CMOP"))
 Q
A S:'$G(PPL) PPL=$G(PSORX("PSOL",PPL1)) G:$G(PPL)']"" D1
 G TEST
UNMARK ;Entry point to unmark drug for CMOP dispense
 N X,Z,%
 S $P(^PSDRUG(CK,3),"^",1)=0 K ^PSDRUG("AQ",CK)
 S:'$D(^PSDRUG(CK,4,0)) ^PSDRUG(CK,4,0)="^50.0214DA^^"
 S (X,Z)=0 F  S Z=$O(^PSDRUG(CK,4,Z)) Q:'Z  S X=Z
 S X=X+1 D NOW^%DTC S ^PSDRUG(CK,4,X,0)=%_"^E^"_DUZ_"^CMOP Dispense^"_$S($G(^PSDRUG(CK,3))=1:"YES",$G(^PSDRUG(CK,3))=0:"NO",1:"")
 S $P(^PSDRUG(CK,4,0),"^",3)=X,$P(^(0),"^",4)=$P(^(0),"^",4)+1
 I $$PATCH^XPDUTL("PSS*1.0*70") D DRG^PSSHUIDG(CK)
 K X,Z,%
 Q
FILTRAN(RX,RFD) ; Test fill's CMOP tran status, return 1 if OK to send
 N DA,CMOP
 S DA=RX
 D ^PSOCMOPA
 I '$D(CMOP(RFD)) Q 1
 I CMOP(RFD)=3 Q 1
 Q 0
COMM(RXN,COMM) ;EP process problem message to g.cmop managers
 N XMSUB,XMTEXT
 S XMTEXT="COMM(",XMY("I:G.CMOP MANAGERS")=""
 S XMSUB="CMOP RX PROBLEM ENCOUNTERED"
 D ^XMD
 Q
CMPRXTYP(SUSDA) ; given suspense record SUSDA returns RX CMOP TYPE C - CS, N -Non-CS
 ;used in compound index ^PS(52.5,"CMP",STAT,TYP,DIV,DATE,DFN,DA)
 N RXDA,DRGDA,DEA,TYP
 S RXDA=$P(^PS(52.5,SUSDA,0),U),DRGDA=$P(^PSRX(RXDA,0),U,6)
 S TYP="N",DEA=$P(^PSDRUG(DRGDA,0),U,3) F I=3,4,5 I DEA[I S TYP="C"
 Q TYP
NOW() D NOW^%DTC Q %
 ;
PIECE(REC,DLM,VP) ; VP="Variable^Piece"
 ; Set Variable V = piece P of REC using delimiter DLM
 N V,P S V=$P(VP,U),P=$P(VP,U,2),@V=$P(REC,DLM,P)
 Q
PUT(REC,DLM,VP) ; VP="Variable^Piece"
 ; pass by reference D PUT^PSOCMOP(.REC,DLM,VP)
 ; Set Variable V into piece P of REC using delimiter DLM
 N V,P S V=$P(VP,U),P=$P(VP,U,2)
 S $P(REC,DLM,P)=$G(@V)
 Q
KCMPX(SUS,VAL) ; Kill ^PS(52.5,"CMP",VAL index given SUS
 N SDT,TYP,DFN,DIV,RX,F,XX
 S F=$G(^PS(52.5,SUS,0)) Q:'+F  S TYP=$$CMPRXTYP(SUS)
 F XX="RX^1","SDT^2","DFN^3","DIV^6" D PIECE(F,U,XX)
 K ^PS(52.5,"CMP",VAL,TYP,DIV,SDT,DFN,SUS)
 Q
SCMPX(SUS,VAL) ; Set  ^PS(52.5,"CMP",VAL index given SUS
 N SDT,TYP,DFN,DIV,RX,F,XX
 S F=$G(^PS(52.5,SUS,0)) Q:'+F  S TYP=$$CMPRXTYP(SUS)
 F XX="RX^1","SDT^2","DFN^3","DIV^6" D PIECE(F,U,XX)
 S ^PS(52.5,"CMP",VAL,TYP,DIV,SDT,DFN,SUS)=""
 Q
