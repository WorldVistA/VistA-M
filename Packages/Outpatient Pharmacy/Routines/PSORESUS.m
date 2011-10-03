PSORESUS ;BIR/EJW Queue/Requeue an Rx to CMOP ;07/25/07
 ;;7.0;OUTPATIENT PHARMACY;**264**;DEC 1997;Build 19
 ;
 ;This routine will allow the last unreleased fill of an Rx to be suspended or resuspended to CMOP.
 ;Examples of when this may be used are if the patient was previously marked as "DO NOT MAIL",
 ;a drug was recently marked as a CMOP drug, the patient's address was updated to a good address, etc.
 ;
TOP ;
 S SAVEPPL=$G(PPL)
 S DIR(0)="FO^1:15",DIR("A")="Enter the Rx # to queue to CMOP"
 S DIR("?")="Enter the prescription number you want to suspend for CMOP dispense."
 D ^DIR K DIR I $D(DIRUT) G END
 S RX=Y K Y
 S PSOIEN=$O(^PSRX("B",RX,"")) I $G(PSOIEN)']"" W !,"Rx # "_RX_" not found" D END G TOP
 D SENDRX
 I $G(PPL)]"" W !!,$P(^PSRX(PSOIEN,0),"^")," cannot be suspended for CMOP.  Make sure the last fill has a Mail routing, the drug is marked for CMOP, the last fill has not been released, etc...",!!
 D END G TOP
END K CHECK,CT,DIR,DIROUT,DIRUT,PSOIEN,LAST,NODE,PSX,PSXPPL,PPL,RF,RX,X,Y,ZD,%
 K PSXSITEA
 I $G(SAVEPPL) S PPL=SAVEPPL K SAVEPPL
 Q
CM ; ENTRY POINT FOR SPEED QUEUE/REQUEUE TO CMOP
 S SAVEPPL=$G(PPL)
 N PSOSTA,II
 N PSOOELSE,PSOIEN,VALMCNT
 I '$G(PSOCNT) S VALMSG="This patient has no Prescriptions!" S VALMBCK="" Q
OS K DIR,DUOUT,DIRUT S DIR("A")="Select Orders by number",DIR(0)="LO^1:"_PSOCNT D ^DIR S LST=Y I $D(DTOUT)!($D(DUOUT)) K DIR,DIRUT,DTOUT,DUOUT S VALMBCK="" Q
 K DIR,DIRUT,DTOUT,PSOOELSE,PSOREPX I '+LST D KILL S VALMBCK="" Q
 S PSOOELSE=1 D FULL^VALM1
 S PPL="" F ORD=1:1:$L(LST,",") Q:$P(LST,",",ORD)']""  D
 .S ORN=$P(LST,",",ORD),PSOIEN=$P(PSOLST(ORN),"^",2) I $P(PSOLST(ORN),"^",3)'="PENDING" D
 ..S PSOSTA=$P($G(^PSRX(PSOIEN,"STA")),"^") I PSOSTA'=0,PSOSTA'=5 W !!,$P(^PSRX(PSOIEN,0),"^")," is not active or suspended" H 2 Q
 ..I $P($G(^PSRX(PSOIEN,0)),"^",2) S PPL=$S(PPL:PPL_",",1:"")_PSOIEN
 ..S VALMBCK="R"
 I +PPL S SAVEPPL=PPL F II=1:1 S PSOIEN=$P(SAVEPPL,",",II) Q:PSOIEN=""  D
 .D SENDRX
 .I $G(PPL)]"" W !!,$P(^PSRX(PSOIEN,0),"^")_" cannot be suspended for CMOP.  Make sure the last fill has a Mail routing, the drug is marked for CMOP, the last fill has not been released, etc...",! H 2
 I '$G(PSOOELSE) S VALMBCK=""
 D ^PSOBUILD
 D KILL D KVA^VADPT
 Q
 ;
KILL ; CLEAN UP VARIABLES
 K DIC,LST,ORD,ORN,PSOIEN,PNM,PPL,PSZIP,RX,SSNP,VA,VADDR1,VADM,VAEL,VAPA,VASTREET
 I $G(SAVEPPL) S PPL=SAVEPPL K SAVEPPL
 Q
 ;
SENDRX ; SET RX INTO SUSPENSE FILE FOR CMOP
 N LAST,I,TRX,PSOMC,PSOMDT
 S LAST=0 I $D(^PSRX(PSOIEN,1)) S I=0 F  S I=$O(^PSRX(PSOIEN,1,I)) Q:'I  S LAST=I
 I $D(PSOSITE) S PSXSITEA=PSOSITE
 S PSOSITE=$S(LAST=0:$P(^PSRX(PSOIEN,2),"^",9),1:$P(^PSRX(PSOIEN,1,LAST,0),"^",9))
 D NOW^%DTC
 N ZD
 S PPL=PSOIEN
 S TRX=$P($G(PPL),",",1)
 S DFN=$P(^PSRX(TRX,0),"^",2),PSOMDT=$P($G(^PS(55,DFN,0)),"^",5),PSOMC=$P($G(^PS(55,DFN,0)),"^",3) K DFN,TRX
 I (PSOMC>1&(PSOMDT>DT))!(PSOMC>1&(PSOMDT<1)) W !,"Cannot suspend for CMOP. Patient's mail status not a CMOP mail status" H 2 K PPL Q
 S ZD(PSOIEN)=% D TEST^PSOCMOP H 2
 I $G(PSXSITEA)]"" S PSOSITE=PSXSITEA
 Q
 ;
