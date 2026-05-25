PSOPRKA ;BIR/EJW - PARK/UNPARK functionality (cont.) ; Apr 24, 2023@08:17:57
 ;;7.0;OUTPATIENT PHARMACY;**441,712,763**;DEC 1997;Build 3
 ;
 ; Reference to $$L^PSSLOCK,PSOL^PSSLOCK,PSOUL^PSSLOCK,UL^PSSLOCK in ICR #2789
 ;(modified from hold rtn PSOHLDA)
 ;NOTE for PaPI - check on ECME calls like in the PSOHLD* routines (e.g. reverse
 ; below may need another code besides "HLD" for parking)
 ;
PARK(PSODA) ;park function ; Called from PSOPRK and edit for Outpatient and from PSORPC01 for Park from CPRS
 S (DA,PSDA)=PSODA
 N RXF,NEXTPOSS,BPMW,PRKMW,PSOOLDFILLDT
 I $P($G(^PSRX(DA,"STA")),"^")'=0,$P($G(^PSRX(DA,"STA")),"^")'=5 Q  ; can't park unless active
 S RSDT=$S($P(^PSRX(DA,2),"^",13):$P(^PSRX(DA,3),"^"),1:"@"),(PSUS,ACT,RXF,RFN,I)=0 F  S I=$O(^PSRX(DA,1,I)) Q:'I  D
 .S RXF=I,RFN=RFN+1 S:RFN=1 RSDT=$S('$P(^PSRX(DA,1,I,0),"^",18):$P(^PSRX(DA,2),"^",2),1:$P(^PSRX(DA,1,I,0),"^"))
 .I RFN>1,'$P(^PSRX(DA,1,I,0),"^",18) S RSDT=$P(^PSRX(DA,1,RXF-1,0),"^") Q
 .S:RFN>1 RSDT=$P(^PSRX(DA,1,RXF,0),"^")
 ; FILL DATE (FLD 22),2;13=RELEASED STATUS (FLD 100),LAST DISPENSED DT (FLD 101)
 S PSOOLDFILLDT=$S(RXF:$P(^PSRX(DA,1,RXF,0),U,1),1:$P(^PSRX(DA,2),U,2))
 S NEXTPOSS=$P(^PSRX(DA,3),"^",2)
 S BPMW=$S('RXF&$G(PSOTOPK)&($P($G(PSORXED("RX0")),U,11)'=""):$P(PSORXED("RX0"),U,11),'RXF:$P(^PSRX(DA,0),U,11),RXF:$P(^PSRX(DA,1,RXF,0),U,2),1:"")
 I 'RXF,'$P(^PSRX(DA,2),"^",13) S NEXTPOSS=$P(^PSRX(DA,2),"^",2) ; SET NEXT POSSIBLE TO FILL DATE THAT IS BEING BLANKED OUT WHEN PARKED
 S DIE="^PSRX(",DR=$S('RXF&($$CHKPRKORIG(DA)):"22///@;",1:"")_"100///0;101///"_RSDT_";102///"_NEXTPOSS D ^DIE Q:$D(Y)
 S ^PSRX(DA,"PARK")=1,^PSRX("APARK",1,DA)="",$P(^PSRX(DA,"STA"),"^")=0
 D:$D(PSORX("PSOL")) RMP(DA)
 K BINGRTE ; DON'T GO TO BINGO BOARD IF PARKED
 S PRKMW="P"
 I 'RXF N DA,DIE,DR S DA=PSDA,DIE="^PSRX(",DR="11///"_PRKMW D ^DIE
 I RXF N DA,DIE,DR S DA(1)=PSDA,DA=RXF,DIE="^PSRX("_DA(1)_",1,",DR="2///"_PRKMW D ^DIE S DA=PSDA
 S VALMSG="RX# "_$P(^PSRX(DA,0),"^")_" placed in Active/Parked status."
 K RXRS(DA)
 ; REMOVE FROM SUSPENSE WHEN PARKED
 I +$G(PSDA) S DA=$O(^PS(52.5,"B",PSDA,0)) I DA S:$P($G(^PS(52.5,DA,"P")),"^")=0 PSUS=1 S DIK="^PS(52.5," D ^DIK K DA,DIK
 S:+$G(PSDA) DA=PSDA D RXACT^PSOPRK(DA,"PK",,,PSUS)
 N PSONOOR,COMM
 S COMM="Medication placed in Active/Parked status "_$E(DT,4,5)_"-"_$E(DT,6,7)_"-"_$E(DT,2,3)
 S PSONOOR="I" ; DEFAULT TO "POLICY" FOR PARK/UNPARK
HL7 D EN^PSOHLSN1(DA,"SC","",COMM,PSONOOR)
 ;
 ; - Closes any OPEN/UNRESOLVED REJECTs and Reverses ECME Claim
 D REVERSE^PSOBPSU1(DA,+$G(RXF),"HLD",2)
 ;
 K PSUS,RXF,I,FDA,DIC,DIE,DR,Y,X,%,%I,%H,RSDT
 Q
 ;
RMP(PSODA) ;remove Rx if found in array PSORX("PSOL")
 Q:'$G(PSODA)
 N I,J,K,PSOX2,PSOX3,PSOX9 S I=0
 F  S I=$O(PSORX("PSOL",I)) Q:'I  S PSOX2=PSORX("PSOL",I) D:PSOX2[(PSODA_",")
 .S PSOX9="",K=0 F J=1:1 S PSOX3=$P(PSOX2,",",J) Q:'PSOX3  D
 ..I PSOX3=PSODA,$P($G(^PSRX(PSODA,"STA")),"^")=0 S K=1 Q
 ..S PSOX9=PSOX9_$S('PSOX9:"",1:",")_PSOX3
 .I K S:PSOX9]"" PSORX("PSOL",I)=PSOX9_"," K:PSOX9="" PSORX("PSOL",I) D:$D(BBRX(I)) RMB(PSODA)
 Q
RMB(PSODA) ;remove Rx if found in array BBRX()
 S PSOX2=BBRX(I) D:PSOX2[(PSODA_",")
 .S PSOX9="" F J=1:1 S PSOX3=$P(PSOX2,",",J) Q:'PSOX3  S:PSOX3'=PSODA PSOX9=PSOX9_$S('PSOX9:"",1:",")_PSOX3
 .S:PSOX9]"" BBRX(I)=PSOX9_"," K:PSOX9="" BBRX(I)
 Q
 ;
UNPARK(PSODA,PSODFN,ERRMSG,PSOARR) ; UNPARK FROM CPRS and refill option (including AudioCARE
 ; Process telephone refills option)
 ; Called from CPRS (PSORPC01 RPC) (Marks as unparked and queues fill to
 ; suspense if last fill is unreleased and label has not printed. If last fill
 ; is released, do auto refill.)
 N RXIEN,PSOX,STA,PSOY,PSORXFL,PSOFILNM,PSOOLDFILLDT
 S (DA,PSORXFL,PSOFILNM)=PSODA
 S PSOPLCK=$$L^PSSLOCK(PSODFN,0) I '$G(PSOPLCK) D LOCK^PSOORCPY S ERRMSG(1)=$S($P($G(PSOPLCK),"^",2)'="":$P($G(PSOPLCK),"^",2)_" is working on this patient.",1:"Another person is entering orders for this patient.") K PSOPLCK S VALMBCK="" Q
 K PSOPLCK D PSOL^PSSLOCK(DA) I '$G(PSOMSG) S ERRMSG(1)=$S($P($G(PSOMSG),"^",2)'="":$P($G(PSOMSG),"^",2),1:"Another person is editing this order."),VALMBCK="" K PSOMSG D ULP Q
 S STA=+$G(^PSRX(DA,"STA")) I STA'=0!('$G(^PSRX(DA,"PARK"))) S ERRMSG(1)="Cannot unpark. Order is not parked." D ULP Q
 K DIR,DTOUT,DUOUT,DIRUT
EN ;
 N I,UNRFIL
 S (RXF,UNRFIL)=0 F I=0:0 S I=$O(^PSRX(DA,1,I)) Q:'I  S RXF=I
 S RSDT="",LBLP=0
 D GETRELDT(DA)
 I 'RSDT D CHKLBL(DA,RXF) ; if not released, but label has printed or sent to CMOP, order new refill if available.
 ; If label has not printed and latest fill is not released and not sent to CMOP, process it instead of ordering new
 I 'RSDT,'LBLP D ^PSOCMOPA
 ; Unpark whether reusing fill or not
 D KILLPARK^PSOPRK(DA)
 I 'RSDT,'LBLP,'$D(PSOCMOP) D  ; If last fill not released and label not printed, put it on suspense with routing of mail when unparked; reset dates
 .I RXF S PSORX("FILL DATE")=$P(^PSRX(DA,1,RXF,0),"^")
 .I 'RXF S PSORX("FILL DATE")=$P(^PSRX(DA,3),"^",2)
 .I PSORX("FILL DATE")<DT S PSORX("FILL DATE")=DT
 .S PSOOLDFILLDT=$S(RXF:$P(^PSRX(DA,1,RXF,0),"^",1),1:$P(^PSRX(DA,2),"^",2))
 .D UPKSUSP
 .S UNRFIL=1
 D RXACT^PSOPRK(DA,"UPK") S PSOKPK=$G(PSOKPK)+1
 I '$G(UNRFIL),$S('RXF:$P(^PSRX(DA,0),"^",11),RXF:$P(^PSRX(DA,1,RXF,0),"^",2),1:"")="P" D
 .N I,J,BPMW  S I=0,BPMW=""
 .F  S I=$O(^PSRX(DA,"A",I)) Q:'I  S J=^(I,0) I $P(J,"^",4)=RXF,J["Rx placed in Parked status" S BPMW=$S(J["(M)":"M",J["(W)":"W",1:"M")
 .I BPMW]"" S:'RXF $P(^PSRX(DA,0),"^",11)=BPMW S:RXF $P(^PSRX(DA,1,RXF,0),"^",2)=BPMW
 S:$G(ORRFILL)&('$G(UNRFIL)) UNPARK=0
 S:$G(ORRFILL)&($G(UNRFIL)) UNPARK=1
 I $G(ORRFILL)!$G(UNRFIL) G EN0
 I RSDT!(LBLP)!($D(PSOCMOP)) D  ; If latest fill released or label printed, generate new refill using autorefill logic
 .K ERRMSG
 .D REFRX(.PSOERR)
 .I $G(PSOERR(1))'="" S ERRMSG(1)="Unparked. "_PSOERR(1) ; Message back to CPRS if couldn't refill
 ;
EN0 ;
 D ULP
EX D PSOUL^PSSLOCK(RXIEN)
 K PSOHRL,PSOMSG,PSOPLCK,ST,PSL,PSNP,IR,NOW,DR,NEW1,NEW11,RTN,DA,PPL,RXN,RX0,RXS,DIK,RXP,FLD,ACT,DIE,DIC,DIR,DIE,X,Y,DIRUT,DUOUT,SUSPT,C,D0,LFD,I,PSDA,RFDATE,DI,DQ,%,RFN,XFLAG
 K HRX,PSPRK,PSOLIST,STA,QTY,RFDT,PSORX0,PSRXN,RXF,JJ,PSOERR
 K PSOUTIL,PSOX,PSOY,RSDT,RXIEN,SITE
 ;
 Q
 ;
ULP ;
 D UL^PSSLOCK(+$G(PSODFN))
 Q
 ;
REFRX(REFCOM) ;
 I $O(^PS(52.41,"ARF",PSORXFL,0)) S REFCOM(1)="Refill request already exists." Q
 I '$D(^PSRX(PSORXFL,0)) S REFCOM(1)="Order was not located by Pharmacy." Q
 I $G(PDFN),$G(PDFN)'=$P($G(^PSRX(PSORXFL,0)),"^",2) S REFCOM(1)="Patient does not match." Q
 ;
 ;  Unpark released fill -> Auto Refill, file to Prescription file #52 and put on suspense
 D REF^PSOATRFC(PSOFILNM,.PSOERR)
 I $G(PSOERR(1))'="" S REFCOM(1)=PSOERR(1)
 Q
 ;
UPKSUSP ; Update routing and date fields for latest fill and put on suspense
 N PSOX,NEXTPOSS,FILLDATE,SD
 S PSOX("RX0")=^PSRX(PSODA,0)
 S PSOX("RX2")=$G(^PSRX(PSODA,2))
 S PSOX("QTY")=$P(PSOX("RX0"),"^",7),PSOX("DAYS SUPPLY")=$P(PSOX("RX0"),"^",8)
 S X1=PSORX("FILL DATE"),X2=PSOX("DAYS SUPPLY")-10\1 D C^%DTC S PSOX1=X
 S FILLDATE=PSORX("FILL DATE")
 S NEXTPOSS=PSOX1
 K X,PSOX1
 S PSOX("MAIL/WINDOW")="M"
 S DIE="^PSRX(",DR=$S('RXF:"22////"_FILLDATE_";",1:"")_"100///5;102///"_NEXTPOSS D ^DIE
 I RXF N DA,DIE,DR S DA(1)=PSODA,DA=RXF,DIE="^PSRX("_DA(1)_",1,",DR=".01////"_FILLDATE D ^DIE
 S PRKMW="M"
 I 'RXF N DA,DIE,DR S DA=PSODA,DIE="^PSRX(",DR="11///"_PRKMW D ^DIE
 I RXF N DA,DIE,DR S DA(1)=PSODA,DA=RXF,DIE="^PSRX("_DA(1)_",1,",DR="2///"_PRKMW D ^DIE S DA=PSODA
 S $P(^PSRX(PSODA,3),"^")=FILLDATE
 ; PUT ON SUSPENSE
 S (RXN,DA)=PSODA
 S SD=FILLDATE
 I '$G(PSOSITE) N PSOSITE S PSOSITE=$$RXSITE^PSOBPSUT(RXN,$G(RXF))
 N DRADD S DRADD="" I 'RXF,$G(^PSDRUG($P(PSOX("RX0"),"^",6),3)) S DRADD=";3////Q" ;p763
 S RXP=+$G(RXPR(DA)),DIC="^PS(52.5,",DIC(0)="L",X=RXN
 S DIC("DR")=".02///"_SD_";.03////"_$P(^PSRX(DA,0),"^",2)_";.04///M;.05///"_RXP_";.06////"_PSOSITE_";2///0"_$G(DRADD) K DD,DO D FILE^DICN D  I +Y,'$G(RXP),$G(RXRP(RXN)) S $P(^PS(52.5,+Y,0),"^",12)=1
 .K DD,DO I +Y,$G(PSOEXREP) S $P(^PS(52.5,+Y,0),"^",12)=1
 .I +Y S $P(^PS(52.5,+Y,0),"^",13)=$G(RXF)
 S $P(^PSRX(RXN,"STA"),"^")=5,LFD=$E(SD,4,5)_"-"_$E(SD,6,7)_"-"_$E(SD,2,3)
 S PSOARR("UPKSUSPCOMM")=$G(RXF)_" Susp. until "_$TR(LFD,"-","/")
 ;D ACT^PSORXL1 p763
 S RXF=0 F I=0:0 S I=$O(^PSRX(DA,1,I)) Q:'I  S RXF=I S:I>5 RXF=I+1 ;p763
 S IR=0 F FDA=0:0 S FDA=$O(^PSRX(DA,"A",FDA)) Q:'FDA  S IR=FDA
 S IR=IR+1,^PSRX(DA,"A",0)="^52.3DA^"_IR_"^"_IR
 N SUSPCOM S SUSPCOM="Placed on Suspense until " I PRKMW="M",$L($G(DRADD)) S SUSPCOM="Placed on Suspense for CMOP until "
 D NOW^%DTC S ^PSRX(DA,"A",IR,0)=%_"^S^"_DUZ_"^"_RXF_"^"_$S(RXP:"Partial ",1:"")_"RX "_$S($G(RXRP(DA))&('$G(RXP)):"Reprint ",1:"")_SUSPCOM_LFD K RXF,I,FDA,DIC,DIE,DR,Y,X,%,%H,%I
 ;eoc p763
 S COMM=$S(RXP:"Partial ",1:"")_"Rx# "_$P(^PSRX(RXN,0),"^")_" Has Been Suspended Until "_LFD_"."_$S($G(RXRP(RXN))&('$G(RXP)):" (Reprint)",1:"")
 D EN^PSOHLSN1(RXN,"SC","ZS",COMM)
 Q
 ;
GETRELDT(DA) ; get release date of last fill
 N I,RXF
 S RXF=0 F I=0:0 S I=$O(^PSRX(DA,1,I)) Q:'I  S RXF=I,RSDT=$P(^(I,0),"^",18)
 S RXIEN=DA
 I 'RXF S RSDT=$P(^PSRX(DA,2),"^",13)
 Q
 ;
CHKLBL(PSODA,RXF) ; see if label has printed for this fill
 N LBL
 S LBLP=0
 F LBL=0:0 S LBL=$O(^PSRX(PSODA,"L",LBL)) Q:'LBL  I $P(^PSRX(PSODA,"L",LBL,0),"^",2)=RXF S LBLP=1
 Q
 ;
CHKPARK(DA,RESULT) ; Entry point for AudioCARE API to determine if parked original/refill
 ; with no refills can be requested now (will queue original/refill when refill request is received)
 N PSOPRKRF,PSORXF
 S (LBLP,RESULT)=0
 I '$D(^PSRX(DA)) Q
 I '$G(^PSRX(DA,"PARK")) Q  ; Not Parked
 I +$G(^PSRX(DA,"STA"))'=0 Q  ; Not Active
 S PSOPRKRF=$O(^PSRX(DA,1,""))
 I PSOPRKRF="",+$P(^PSRX(DA,0),"^",9)=0 D  ;Check Original Fill
 .D GETRELDT(DA) I 'RSDT D CHKLBL(DA,0) I 'LBLP D
 ..S NEXTPOSS=$P(^PSRX(DA,3),"^",2) I NEXTPOSS<DT S NEXTPOSS=DT
 ..D ^PSOCMOPA I '$D(PSOCMOP) S RESULT="1^"_NEXTPOSS
 I PSOPRKRF'="",+$P(^PSRX(DA,0),"^",9)>0 D  ;Check Last Refill
 .S PSORXF=$O(^PSRX(DA,1,99999),-1)
 .D GETRELDT(DA) I 'RSDT D CHKLBL(DA,PSORXF) I 'LBLP D
 ..S NEXTPOSS=$P(^PSRX(DA,3),"^",2) I NEXTPOSS<DT S NEXTPOSS=DT
 ..D ^PSOCMOPA I '$D(PSOCMOP) S RESULT="1^"_NEXTPOSS
 K PSOCMOP,LBLP,RSDT,NEXTPOSS
 Q
 ;
 ;
CHKPRKORIG(DA) ;
 N PSOCMOP,LBLP,RSDT
 I $O(^PSRX(DA,1,0)) Q 0
 D GETRELDT(DA) I $G(RSDT) Q 0
 D CHKLBL(DA,0) I $G(LBLP) Q 0
 D ^PSOCMOPA I $D(PSOCMOP) Q 0
 Q 1
