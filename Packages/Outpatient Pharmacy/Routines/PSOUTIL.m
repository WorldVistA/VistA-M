PSOUTIL ;IHS/DSD/JCM - outpatient pharmacy utility routine ;12/28/15 4:01pm
 ;;7.0;OUTPATIENT PHARMACY;**64,456,444**;DEC 1997;Build 34
 ;External reference $$MXDAYSUP^PSSUTIL1 supported by DBIA 6229
 ;
 W !!,$C(7),"This routine not callable from PSOUTIL.."
 Q
 ;
NPSOSD(PSORX) ; Entry point to add newly added rx to patients PSOSD array
 S STA="ACTIVE^NON-VERIFIED^R^HOLD^NON-VERIFIED^ACTIVE^^^^^^ACTIVE^DISCONTINUE^^DISCONTINUE^DISCONTINUE^HOLD"
 S STAT=$P(STA,"^",$P(^PSRX(PSORX("IRXN"),"STA"),"^")+1)
 I $D(PSOSD(STAT,PSODRUG("NAME"))),$P(PSOSD(STAT,PSODRUG("NAME")),"^",2)<10 D
 . S PSOSD(STAT,PSODRUG("NAME")_"^"_PSORX("IRXN"))=PSORX("IRXN")_"^"_$P($G(^PSRX(PSORX("IRXN"),"STA")),"^")_"^^^"_PSODRUG("VA CLASS")_"^"_$P(^PSRX(PSORX("IRXN"),0),"^",9)_"^"_PSODRUG("NDF")_"^"_$P(^PSRX(PSORX("IRXN"),0),"^",8)_"^1"
 E  S PSOSD(STAT,PSODRUG("NAME"))=PSORX("IRXN")_"^"_$P($G(^PSRX(PSORX("IRXN"),"STA")),"^")_"^^^"_PSODRUG("VA CLASS")_"^"_$P(^PSRX(PSORX("IRXN"),0),"^",9)_"^"_PSODRUG("NDF")_"^"_$P(^PSRX(PSORX("IRXN"),0),"^",8)_"^1"
 S PSOSD=$S($G(PSOSD)]"":PSOSD+1,1:1),^TMP("PS",$J,STAT,PSODRUG("NAME"))=1
 Q
 ;
RNPSOSD ;update PSOSD array for renewals
 S STA="ACTIVE^NON-VERIFIED^R^HOLD^NON-VERIFIED^ACTIVE^^^^^^ACTIVE^DISCONTINUE^^DISCONTINUE^DISCONTINUE^HOLD"
 S STAT=$P(STA,"^",$P(^PSRX(PSORENW("OIRXN"),"STA"),"^")+1)
 I $D(PSOSD(STAT,PSODRUG("NAME")_"^"_PSORENW("OIRXN"))) D
 . S PSOSD(STAT,PSODRUG("NAME")_"^"_PSORENW("IRXN"))=PSOSD(STAT,PSODRUG("NAME")_"^"_PSORENW("OIRXN")),$P(PSOSD(STAT,PSODRUG("NAME")_"^"_PSORENW("IRXN")),"^",2)=$P($G(^PSRX(PSORENW("IRXN"),"STA")),"^")
 . S $P(PSOSD(STAT,PSODRUG("NAME")_"^"_PSORENW("IRXN")),"^",6)=$P(^PSRX(PSORENW("IRXN"),0),"^",9)
 . K PSOSD(STAT,PSODRUG("NAME")_"^"_PSORENW("OIRXN")) Q
 E  D
 .S $P(PSOSD(STAT,PSODRUG("NAME")),"^")=PSORENW("IRXN"),$P(PSOSD(STAT,PSODRUG("NAME")),"^",2)=$P($G(^PSRX(PSORENW("IRXN"),"STA")),"^")
 .S $P(PSOSD(STAT,PSODRUG("NAME")),"^",6)=$P(^PSRX(PSORENW("IRXN"),0),"^",9)
 .S ^TMP("PS",$J,STAT,PSODRUG("NAME"))=1
 Q
 ;
PROV(PSORENW) ;called from psoornew
CHKPRV ;check inactive providers and cosinging providers called from PSORENW (renew rx)
 N OK
 I '$D(^VA(200,PSORENW("PROVIDER"),0)) D  I 'OK G:PSORENW("DFLG") CHKPRVX
 .W !,$C(7),"Provider not in New Person File .. You must select a new provider"
 .S PSODIR("FIELD")=0 K PSORENW("PROVIDER") D PROV^PSODIR(.PSORENW)
 .S:$G(PSORENW("PROVIDER"))']"" PSORENW("DFLG")=1
 ;
 I '$G(^VA(200,PSORENW("PROVIDER"),"PS")) D   G:PSORENW("DFLG") CHKPRVX
 .I $$ISSPLY(),$D(^XUSEC("ORSUPPLY",PSORENW("PROVIDER"))) S OK=1 Q
 .S OK=0 W !,$C(7),$P(^VA(200,PSORENW("PROVIDER"),0),"^")_" is not a Valid provider .. You must select a new provider"
 .S PSODIR("FIELD")=0 K PSORENW("PROVIDER") D PROV^PSODIR(.PSORENW)
 .S:$G(PSORENW("PROVIDER"))']"" PSORENW("DFLG")=1
 ;
 K PSOX S PSOX=$P($G(^VA(200,PSORENW("PROVIDER"),"PS")),"^",4)
 I PSOX,PSOX<DT D   G:PSORENW("DFLG") CHKPRVX
 .W !,$C(7),$P(^VA(200,PSORENW("PROVIDER"),0),"^")_" is inactive as a provider .. You must select a new provider"
 .S PSODIR("FIELD")=0 K PSORENW("PROVIDER") D PROV^PSODIR(.PSORENW)
 .I $G(PSORENW("PROVIDER"))']"" S PSORENW("DFLG")=1
 ;
 I '$D(PSORENW("COSIGNING PROVIDER")),$D(PSORENW("COSIGNER")) K PSOX S PSOX=$P(^VA(200,PSORENW("COSIGNER"),"PS"),"^",4) I PSOX,PSOX<DT D
 .W !,$C(7),"Inactive Cosigning Provider .. You must select a new cosigner"
 .S PSODIR("FIELD")=0,PSODIR("PROVIDER")=$S($D(PSORENW("PROVIDER")):PSORENW("PROVIDER"),1:PSORENW("PROVIDER"))
 .D COSIGN^PSODIR I '$D(PSODIR("COSIGNING PROVIDER")) S PSORENW("DFLG")=1
 .S PSORENW("COSIGNING PROVIDER")=PSODIR("COSIGNING PROVIDER")
 ;
CHKPRVX K PSODIR,PSOX
 Q
 ;
NEXT(PSOX) ;
 S PSOX("RX0")=^PSRX(PSOX("IRXN"),0)
 S PSOX("RX2")=^PSRX(PSOX("IRXN"),2)
 S PSOX("RX3")=^PSRX(PSOX("IRXN"),3)
 S PSOX1=$P(PSOX("RX2"),"^",2)
 I '$O(^PSRX(PSOX("IRXN"),1,0)) D  G NEXTX
 . S $P(PSOX("RX3"),"^")=PSOX1,X1=PSOX1
 . S X2=$P(PSOX("RX0"),"^",8)-10\1
 . D C^%DTC
 . S:'$P(PSOX("RX3"),"^",8) $P(PSOX("RX3"),"^",2)=X
 . K X Q
 ;
 S PSOY2=0
 F PSOY=0:0 S PSOY=$O(^PSRX(PSOX("IRXN"),1,PSOY)) Q:'PSOY  S PSOY1=PSOY,PSOY2=PSOY2+1
 S PSOY=^PSRX(PSOX("IRXN"),1,PSOY1,0)
 S PSOX2=$P(PSOY,"^")
 S $P(PSOX("RX3"),"^")=PSOX2,X1=PSOX2
 S X2=$P(PSOX("RX0"),"^",8)-10\1
 D C^%DTC S PSOY3=X
 S X1=PSOX1,X2=(PSOY2+1)*$P(PSOX("RX0"),"^",8)-10\1
 D C^%DTC S PSOY4=X
 S $P(PSOX("RX3"),"^",2)=$S(PSOY3<PSOY4:PSOY4,1:PSOY3)
NEXTX ;
 K X,PSOX1,PSOX2,PSOY,PSOY1,PSOY2,PSOY3,PSOY4
 Q
 ;
SUSDATE(PSOX) ;
 S PSOX("OLD FILL DATE")=PSOX("FILL DATE")
 S PSORX("OLD FILL DATE")=PSORX("FILL DATE")
 S PSOX("FILL DATE")=$P(PSOX("RX3"),"^",2)
 I $O(^PS(52.5,"B",PSOX("IRXN"),0)),'$G(^PS(52.5,+$O(^PS(52.5,"B",PSOX("IRXN"),0)),"P")) S PSOX("FILL DATE")=$P(PSOX("RX3"),"^")
 S Y=PSOX("FILL DATE")
 X ^DD("DD") S PSORX("FILL DATE")=Y K Y
 Q
 ;
SUSDATEK(PSOX) ;
 S PSOX("FILL DATE")=PSOX("OLD FILL DATE")
 I $G(PSORX("OLD FILL DATE"))="",$G(PSORENW("OLD FILL DATE")) S Y=PSORENW("OLD FILL DATE") D DD^%DT S PSORX("OLD FILL DATE")=Y K Y
 S PSORX("FILL DATE")=PSORX("OLD FILL DATE")
 K PSOX("OLD FILL DATE"),PSORX("OLD FILL DATE")
 Q
 ;
STATUS(PSOREA,PSOSTAT) ;
 S DSMSG="Cannot "_$S($G(PSOOPT)=3:"renew",1:"refill")_" Rx. " S:$G(OR0) ACOM=DSMSG
 I PSOREA["A" W:$G(SPEED) ", Inactive Drug.",! D
 .S:$G(POERR)&('$G(SPEED)) VALMSG=DSMSG_"Inactive Drug.",VALMBCK="R" W:'$G(POERR) !," Inactive Drug"
 .S:$G(OR0) ACOM=ACOM_" Inactive Drug."
 I PSOREA["M" W:$G(SPEED) ", Drug no longer used by Outpatient.",! D
 .S:$G(POERR)&('$G(SPEED)) VALMSG=DSMSG_"Drug no longer used by Outpatient.",VALMBCK="R" W:'$G(POERR) !," Drug no longer used by Outpatient."
 .S:$G(OR0) ACOM=ACOM_" Drug no longer used by Outpatient."
 ;
 I PSOREA["B" W:$G(SPEED) ", Narcotic Drug." D
 .W:'$G(POERR) !,"Narcotic Drug" S:$G(POERR)&('$G(SPEED)) VALMSG=DSMSG_"Narcotic Drug.",VALMBCK="R"
 .S:$G(OR0) ACOM=ACOM_" Narcotic Drug."
 ;
 I PSOREA["C" W:$G(SPEED) ", Non-Renewable Drug." D
 .W:'$G(POERR) !,"Non-Renewable Drug" S:$G(POERR)&('$G(SPEED)) VALMSG=DSMSG_"Non-Renewable Drug.",VALMBCK="R"
 .S:$G(OR0) ACOM=ACOM_" Non-Renewable Drug."
 ;
 I PSOREA["D" W:$G(SPEED) ", Non-Renewable Patient Status." D
 .W:'$G(POERR) !,"Non-Renewable Patient Status" S:$G(POERR)&('$G(SPEED)) VALMSG=DSMSG_"Non-Renewable Patient Status.",VALMBCK="R"
 .S:$G(OR0) ACOM=ACOM_" Non-Renewable Patient Status."
 ;
 I PSOREA["E" W:$G(SPEED) ", Non-Verified Rx." D
 .W:'$G(POERR) !,"Non-Verified Rx" S:$G(POERR)&('$G(SPEED)) VALMSG=DSMSG_"Non-Verified Rx.",VALMBCK="R"
 .S:$G(OR0) ACOM=ACOM_" Non-Verified Rx."
 ;
 I PSOREA["F" W:$G(SPEED) ", Maximum of 26 Renewals." D
 .W:'$G(POERR) !,"Maximum of 26 Renewals" S:$G(POERR)&('$G(SPEED)) VALMSG=DSMSG_"Maximum of 26 Renewals.",VALMBCK="R"
 .S:$G(OR0) ACOM=ACOM_" Maximum of 26 Renewals."
 ;
 I PSOREA["G",PSOREA'["B" W:$G(SPEED) ", No more refills left." W:'$G(POERR) !,"No more refills left" S:$G(POERR)&('$G(SPEED)) VALMSG=DSMSG_"No more refills left.",VALMBCK="R"
 ;
 I PSOREA["Z" D
 . S:PSOSTAT=4 PSOSTAT=1
 . S PSOA=";"_PSOSTAT,PSOB=$P(^DD(52,100,0),"^",3),PSOA=$F(PSOB,PSOA),PSOA=$P($E(PSOB,PSOA,999),";",1)
 . W:$G(SPEED) ", Rx is in "_$P(PSOA,":",2)_" status."
 . W:'$G(POERR)&('$G(SPEED)) !,"Rx is in "_$P(PSOA,":",2)_" status"
 .S:$G(POERR)&($G(VALMSG)']"")&('$G(SPEED)) VALMSG=DSMSG_"Rx is in "_$P(PSOA,":",2)_" status.",VALMBCK="R"
 . K PSOA,PSOB
 . Q
 I $G(SPEED) K DIR S DIR(0)="E",DIR("A")="Press Return to Continue" D ^DIR K DIRUT,DUOUT,DTOUT,DIR
 Q
ACP I $P(^PSRX(PSOX("IRXN"),0),"^",11)="W",$G(^("IB")) S ^PSRX("ACP",$P(^PSRX(PSOX("IRXN"),0),"^",2),$P(^(2),"^",2),0,PSOX("IRXN"))=""
 Q
 ;
RENFDT(PSOX) ;gets the correct fill date
 S PSOX("OLD FILL DATE")=PSOX("FILL DATE")
 S PSORX("OLD FILL DATE")=PSORX("FILL DATE")
 S PSOX("FILL DATE")=$P(PSOX("RX3"),"^",2)
 N RXY,LBL,SUPN,LBP,RF,RFN,RFD
 S RXY=PSOX("IRXN"),RFN=0
 I '$O(^PSRX(RXY,1,0)) D GFDT G SDTX
 F RF=0:0 S RF=$O(^PSRX(RXY,1,RF)) Q:'RF  S RFN=RF
 S RF=^PSRX(RXY,1,RFN,0) D GFDT
 I PSOX("FILL DATE")<DT,PSOX("FILL DATE")<PSORNW("FILL DATE") S PSOX("FILL DATE")=DT
SDTX ;
 S Y=PSOX("FILL DATE")
 X ^DD("DD") S PSORX("FILL DATE")=Y K Y
 Q
GFDT ;
 I 'RFN,$P(^PSRX(RXY,2),"^",13) Q
 I RFN,$P(RF,"^",18) Q
 F LBL=0:0 S LBL=$O(^PSRX(RXY,"L",LBL)) Q:'LBL  I $P(^PSRX(RXY,"L",LBL,0),"^",2)=RFN S LBP=1 Q
 Q:$G(LBP)
 S SUPN=$O(^PS(52.5,"B",RXY,0))
 I SUPN,$P($G(^PS(52.5,SUPN,0)),"^",7)="L"!($P($G(^(0)),"^",7)="X") Q
 S:RFN RFD=$E($P(RF,"^"),1,7) S:'RFN RFD=$P(PSOX("RX3"),"^")
 I SUPN,RFD,$D(^PS(52.5,"C",RFD,SUPN)),$G(^PS(52.5,SUPN,"P"))=1 Q
 S PSOX("FILL DATE")=$P(PSOX("RX3"),"^")
 Q
 ;
ISSPLY() ;is the drug a supply item
 ;assumes the existence of the PSODRUG array
 I $G(PSODRUG("DEA"))="" Q 0
 I $G(PSODRUG("VA CLASS"))="" Q 0
 I PSODRUG("VA CLASS")?1"XA".E!(PSODRUG("VA CLASS")?1"XX".E)!(PSODRUG("VA CLASS")="DX900"&(PSODRUG("DEA")["S")) Q 1
 Q 0
 ;
DAYSUP(DRUG,RXARR,RCLQTY) ; Adjusts DAYS SUPPLY and QUANTITY based on the maximum allowed
 ; Input: DRUG   - DRUG file (#50) IEN
 ;        RXARR  - Array containing prescription information
 ;        RVWQTY - Re-calculate Quantity (1: YES / 0: NO) 
 ;Output: RXARR  - Array with "DAYS SUPPLY" and "QTY" values modified
 ;
 ; - Invalid Dispense Drug
 I '$D(^PSDRUG(+$G(DRUG),0))!'$D(RXARR) Q
 N MXDAYSUP,RXDAYSUP,RXQTY,NEWQTY
 S MXDAYSUP=$$MXDAYSUP^PSSUTIL1(DRUG)
 S RXDAYSUP=+$G(RXARR("DAYS SUPPLY"))
 I RXDAYSUP>MXDAYSUP D
 . W !!,"The current DAYS SUPPLY value (",RXDAYSUP,") exceeds the Maximum allowed"
 . W !,"for ",$$GET1^DIQ(50,DRUG,.01)," (",MXDAYSUP,") and will be reset.",$C(7)
 . S RXARR("DAYS SUPPLY")=MXDAYSUP
 . S RXQTY=+$G(RXARR("QTY"))
 . I $G(RCLQTY),RXQTY,RCLQTY'=RXQTY D
 . . S NEWQTY=((RXQTY*MXDAYSUP)/RXDAYSUP)+.5\1
 . . W !!,"The Quantity was changed from ",RXQTY," to ",NEWQTY,"."
 . . S RXARR("QTY")=NEWQTY
 . W !!,"Please, review the modified order before accepting it."
 . W ! N DIR S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR
 Q
 ;
MAXNUMRF(DRUG,DAYSUP,PTST,CLOZPAT) ; Returns the Maximum Number of Refills Allowed
 ; Input: DRUG     - DRUG file (#50) IEN
 ;        DAYSUP   - Number of DAYS SUPPLY per fill
 ;        PTST     - RX PATIENT STATUES (#53) IEN
 ;        CLOZPAT  - Clozapine Indicator Variable (used throughout PSO)
 ;Output: MAXNUMRF - Maximum Number of Refills
 ;
 N MAXNUMRF,DEAHDLG,CSDRUG,MAXPTST
 ; - Invalid Drug or DAYS SUPPLY value
 I '$D(^PSDRUG(+$G(DRUG),0))!'$G(DAYSUP) Q 0
 ;
 ; - Calculating Maximum for Clozapine Drug
 I $D(CLOZPAT) Q $S(CLOZPAT=2&(DAYSUP=14):1,CLOZPAT=2&(DAYSUP=7):3,CLOZPAT=1&(DAYSUP=7):1,1:0)
 ;
 ; - Non-Refillable Drugs based on DEA SPECIAL HDLG field
 S DEAHDLG=$$GET1^DIQ(50,DRUG,3)
 I DEAHDLG["A"&(DEAHDLG'["B")!(DEAHDLG["F")!(DEAHDLG[1)!(DEAHDLG[2) Q 0
 S CSDRUG=0 I (DEAHDLG[3)!(DEAHDLG[4)!(DEAHDLG[5) S CSDRUG=1
 ;
 ; - The Maximum Number of Refills Calculation is different for up to 90 Days Supply Vs. Above 90 Days Supply
 I $G(CSDRUG) D
 . I DAYSUP'>90 D
 . . S MAXNUMRF=$S(DAYSUP<60:5,DAYSUP'<60&(DAYSUP'>89):2,DAYSUP=90:1,1:0)
 . E  D
 . . S MAXNUMRF=182\DAYSUP-1
 E  D
 . I DAYSUP'>90 D
 . . S MAXNUMRF=$S(DAYSUP<60:11,DAYSUP'<60&(DAYSUP'>89):5,DAYSUP=90:3,1:0)
 . E  D
 . . S MAXNUMRF=365\DAYSUP-1
 ;
 ; - Adjusting Maximum based Rx Patient Status 
 I $G(PTST) S MAXPTST=$$GET1^DIQ(53,PTST,4) I MAXNUMRF>MAXPTST S MAXNUMRF=MAXPTST
 ;
 Q MAXNUMRF
 ;
BADADDFL(RXIEN) ; Indicate whether an Rx should be flagged with a Bad Address
 ; Input: RXIEN    - Rx IEN (#52) to be checked
 ;Output: BADADDFL - 1: Rx Flagged for Bad Address / 0: Rx NOT Flagged Bad Address 
 N BADADDFL,LSTLBLSQ,LSTLBLTX
 S BADADDFL=0
 I '$G(^PSRX(+$G(RXIEN),0)) Q BADADDFL
 S LSTLBLSQ=$O(^PSRX(+RXIEN,"L",9999),-1)
 I LSTLBLSQ D
 . S LSTLBLTX=$G(^PSRX(+RXIEN,"L",LSTLBLSQ,0)) I LSTLBLTX["(BAD ADDRESS)" S BADADDFL=1
 Q BADADDFL
