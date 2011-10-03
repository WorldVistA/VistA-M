PSOUTIL ;IHS/DSD/JCM - outpatient pharmacy utility routine ; 03/28/93 20:46
 ;;7.0;OUTPATIENT PHARMACY;**64**;DEC 1997
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
 I '$D(^VA(200,PSORENW("PROVIDER"),0)) D   G:PSORENW("DFLG") CHKPRVX
 .W !,$C(7),"Provider not in New Person File .. You must select a new provider"
 .S PSODIR("FIELD")=0 K PSORENW("PROVIDER") D PROV^PSODIR(.PSORENW)
 .S:$G(PSORENW("PROVIDER"))']"" PSORENW("DFLG")=1
 ;
 I '$G(^VA(200,PSORENW("PROVIDER"),"PS")) D   G:PSORENW("DFLG") CHKPRVX
 .W !,$C(7),$P(^VA(200,PSORENW("PROVIDER"),0),"^")_" is not a Valid provider .. You must select a new provider"
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
