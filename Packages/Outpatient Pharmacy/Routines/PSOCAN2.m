PSOCAN2 ;BHAM ISC/JMB - rx cancel with speed ability drug check ;10/23/06 11:30am
 ;;7.0;OUTPATIENT PHARMACY;**8,18,62,46,88,164,235,148,259,281,287,251,375**;DEC 1997;Build 17
 ;External reference to ^PSDRUG supported by dbia 221
 ;External reference to $$DS^PSSDSAPI supported by DBIA 5424
REINS N DODR,ORN
 I $P(^PSRX(DA,2),"^",6)<DT D  Q
 .S Y=$P(^PSRX(DA,2),"^",6) X ^DD("DD")
 .W !!,"Rx: "_$P(^PSRX(DA,0),"^")_" Drug: "_$S($D(^PSDRUG($P(^PSRX(DA,0),"^",6),0)):$P(^(0),"^"),1:""),!,"Expired "_Y_" and cannot be Reinstated!",!
 .D PAUSE^VALM1
 I $D(^PSRX("APSOD",$P(^PSRX(DA,0),"^",2),DA)) S PSCAN($P(^PSRX(DA,0),"^"))=DA_"^R",DODR=1 D AUTOD G ACT
 I $P(PSOPAR,"^",2),'$D(^XUSEC("PSORPH",DUZ)) N PSOVODA S PSOVODA=DA D DRGDRG S DA=PSOVODA Q:PSORX("DFLG")  D VERIFY D  D AREC^PSOCAN1 Q
 .S RX1=$P(^PSRX(DA,0),"^") S:'$D(PSCAN(RX1)) PSCAN(RX1)=DA_"^R" K RX1
ACT W ! F I=1:1:80 W "="
 D ^PSOBUILD S DRG=+$P(^PSRX(DA,0),"^",6),DRG=$S($D(^PSDRUG(DRG,0)):$P(^(0),"^"),1:""),HOLDRX=RX
 W !!,RX_"  "_DRG I $G(POERR) S HPOERR=POERR
 D DRGDRG
 S:$G(HPOERR) POERR=HPOERR S:$G(PSORX("DFLG"))'=1 PSORX("DFLG")=0
 S RX=HOLDRX K HOLDRX,HPOERR Q:$P(^PSRX(+PSCAN(RX),"STA"),"^")'=12!($G(PSORX("DFLG")))
 S DA=+PSCAN(RX),REA=$P(PSCAN(RX),"^",2) D CAN^PSOCAN W !
 N RXIEN S RXIEN=DA
 ;Takes action on reinstated Rx's
 S RFCNT=0 F RF=0:0 S RF=$O(^PSRX(DA,1,RF)) Q:'RF  S RFCNT=RF
 S (LPRT,LREF)="" F LL=0:0 S LL=$O(^PSRX(DA,"L",LL)) Q:'LL  S LPRT=$P($G(^PSRX(DA,"L",LL,0)),"."),LREF=$P($G(^(0)),"^",2)
 I 'RFCNT S FDT=$S($P($G(^PSRX(DA,2)),"^",2)'="":$P($G(^PSRX(DA,2)),"^",2),1:$P($G(^PSRX(DA,2)),"^")) S RELDT=$P(^(2),"^",13),RELDT=$P(RELDT,".")
 I RFCNT S FDT=$P($G(^PSRX(DA,1,RFCNT,0)),"^"),RELDT=$P(^(0),"^",18),RELDT=$P(RELDT,".")
 S Y=FDT D DD^%DT S XFDT=Y I RELDT'="" S Y=RELDT D DD^%DT S XRELDT=Y
 I LPRT'="" S Y=LPRT D DD^%DT S XLPDT=Y
 ;If Rx was released, do nothing
 I RELDT'="" W !,RX_" Reinstated -- ",!?3,$S('RFCNT:"Filled",1:"Refilled # "_LREF)_": "_XFDT,?32,"Printed: "_$S(LREF=RFCNT:XLPDT,1:""),?56,"Released: "_$G(XRELDT) H 3 Q
 ;If Rx not released, check fill/refill date for action
 I $G(PSXSYS) D REINS^PSOCMOPA I $G(XFLAG) K XFLAG Q
 W !,"Prescription #"_RX_" REINSTATED!"
 ;
 N PSOTRIC S PSOTRIC="",PSOTRIC=$$TRIC^PSOREJP1(RXIEN,RFCNT,PSOTRIC)
 D SUBMIT^PSOREJU3(RXIEN,RFCNT,PSOTRIC)
 ;
 W !?3,"Prescription #",RX_": "
 W !?6,$S('RFCNT:"  Filled",1:"  Refilled # "_LREF)_": "_XFDT,"  Printed: "_$S(LREF=RFCNT:XLPDT,1:""),"  Released: "_$G(XRELDT),!
 I FDT<DT D
 .Q:$$FIND^PSOREJUT(RXIEN)  ;No label for Rx's with claims rejects
 .Q:PSOTRIC&($$STATUS^PSOBPSUT(RXIEN,RFCNT)'["PAYABLE")  ;No labels for Tricare non-payable/in progress Rx
 .S DIR("A")="     ** Do you want to print the label now",DIR("B")="N",DIR(0)="Y",DIR("?")="Enter 'Y' to print the label now.  If 'N' is entered, the label may be reprinted through reprint at a later date."
 .D ^DIR K DIR Q:$G(DIRUT)!('Y)  S PPL=RXIEN D Q^PSORXL Q
 I FDT=DT D
 . Q:$$FIND^PSOREJUT(RXIEN)
 . Q:PSOTRIC&($$STATUS^PSOBPSUT(RXIEN,RFCNT)'["PAYABLE")
 . W !?5,"Either print the label using the reprint option "
 . W !?7,"or check later to see if the label has been printed." Q
 I FDT>DT&('$G(DODR)) W !?5,"Placing Rx on suspense.  Please wait..." D SUS
 K DODR
 Q
SUS ;Adds rec to suspense
 S ACT=1,RXN=DA,RX0=^PSRX(DA,0),RXS=$O(^PS(52.5,"B",DA,0)) I RXS S DA=RXS,DIK="^PS(52.5," D ^DIK S DA=RXN
 S RXP=$S($D(RXP):RXP,1:0),DIC="^PS(52.5,",DIC(0)="L",X=RXN,DIC("DR")=".02///"_FDT_";.03///"_$P(RX0,"^",2)_";.04///M;.05///"_RXP_";.06////"_$G(PSOSITE)_";2///0" K DD,DO D FILE^DICN
 I +$G(Y),$G(RFCNT)'="" S $P(^PS(52.5,+Y,0),"^",13)=$G(RFCNT)
 S DA=RXN,$P(^PSRX(DA,"STA"),"^")=5,LFD=$E($P(^PSRX(DA,3),"^"),4,5)_"-"_$E($P(^(3),"^"),6,7)_"-"_$E($P(^(3),"^"),2,3)
 S ACOM="RX Placed on Suspense until "_LFD D AREC^PSOCAN1 S ST="SC",PHST="ZS" D EN^PSOHLSN1(DA,ST,PHST,ACOM) K ST,PHST
 Q
DRGDRG ;Checks for drug/drug interaction, duplicate drug and class
 Q:$P(^PSRX(DA,2),"^",6)<DT
 S (PSORX("DFLG"),PSORXED("DFLG"))=0
 S STA="ACTIVE^NON-VERIFIED^R^HOLD^NON-VERIFIED^ACTIVE^^^^^^ACTIVE^DISCONTINUED^^DISCONTINUED^DISCONTINUED^HOLD"
 S STAT=$P(STA,"^",$P(^PSRX(DA,"STA"),"^")+1)
 S X=$P(^PSRX(DA,0),"^",6),DIC="^PSDRUG(",DIC(0)="MZO" D ^DIC K DIC Q:$D(DTOUT)!(Y<0)
 K HOLD S NAME=$P(Y(0),"^") I +$G(PSOSD(STAT,NAME))=+PSCAN(RX) S HOLD(STAT,NAME)=$G(PSOSD(STAT,NAME)) K PSOSD(STAT,NAME)
 S:$G(PSONEW("OLD VAL"))=+Y PSODRG("QFLG")=1
 K PSOY,PSOTECCK S PSOY=Y,PSOY(0)=Y(0)
 I '$D(^XUSEC("PSORPH",DUZ)) S PSOTECCK=1
 S PSORENW("OIRXN")=DA D SET^PSODRG,POST^PSODRG
 D:$$DS^PSSDSAPI&('$G(PSORX("DFLG"))) DOSCK^PSODOSUT("C")
 S REA=$P(PSCAN($P(^PSRX(PSORENW("OIRXN"),0),"^")),"^",2)
 W ! S:$G(HOLD(STAT,NAME))]"" PSOSD(STAT,NAME)=$G(HOLD(STAT,NAME)) K HOLD,STA,STAT,PSORENW("OIRXN")
 Q
VERIFY ;Put in non-verify file
 S PSRXDA=DA,DIC="^PS(52.4,",DLAYGO=52.4,(X,DINUM)=PSRXDA,DIC(0)="ML",DIC("DR")="1////"_PSODFN_";2////"_DUZ_";4////"_DT
 K DD,DO D FILE^DICN K DIC,DLAYGO,DINUM
 S DA=PSRXDA S $P(^PSRX(DA,"STA"),"^")=1
 S ST="SC",PHST="IP",VCOM="Put in non-verified status" D EN^PSOHLSN1(DA,ST,PHST,VCOM) K ST,PHST,VCOM
 Q
HLD N PSDTEST,PDA,CMOP,SUSD I $P(^PSRX(DA,"STA"),"^")=3 D
 .S ACOM=$S(REA="C":"Discontinued",1:"Reinstated")_" while on hold during Rx cancel. " K:$P(^PSRX(DA,"H"),"^") ^PSRX("AH",$P(^PSRX(DA,"H"),"^"),DA) S ^PSRX(DA,"H")=""
 .I $P(^PSRX(DA,0),"^",13),'$O(^PSRX(DA,1,0)) S DIE=52,DR="22///"_$E($P(^PSRX(DA,0),"^",13),1,7) D ^DIE K DIE,DR Q
 .S (IFN,SUSD)=0 F  S IFN=$O(^PSRX(DA,1,IFN)) Q:'IFN  S SUSD=IFN,RFDT=$P(^PSRX(DA,1,IFN,0),"^")
 .Q:'$G(SUSD)  I '$P(^PSRX(DA,1,SUSD,0),"^",18) S PSDTEST=0 D  I 'PSDTEST K ^PSRX(DA,1,SUSD),^PSRX("AD",RFDT,DA,SUSD),^PSRX(DA,1,"B",RFDT,SUSD),IFN,SUSD,RFDT
 ..F PDA=0:0 S PDA=$O(^PSRX(DA,"L",PDA)) Q:'PDA  I $P($G(^PSRX(DA,"L",PDA,0)),"^",2)=SUSD S PSDTEST=1
 ..K CMOP D ^PSOCMOPA I $G(CMOP(CMOP("L")))="",$G(CMOP("S"))'="L" Q
 ..S PSDTEST=1
 Q
REF S IFN=0 F  S IFN=$O(^PSRX(DA,1,IFN)) Q:'IFN  I $P($G(^PSRX(DA,1,IFN,0)),"^")=SUSD,'$P(^(0),"^",18) D
 .D DELREF I $G(PSORFDEL) K PSORFDEL Q
 .;PSO*7*259;CHECK IF REFILL RELEASED OR LABEL PRINTED
 .I $P($G(^PSRX(DA,1,IFN,0)),"^",18)]"" Q  ;REFILL RELEASED
 .N PSONODEL,PSOLBL S PSONODEL=0
 .I $P(^PSRX(DA,"STA"),"^")=5 D REF^PSOCAN4 Q:PSONODEL
 .S PSOLBL="" F  S PSOLBL=$O(^PSRX(DA,"L",PSOLBL),-1) Q:'PSOLBL  Q:PSONODEL  Q:$P(^PSRX(DA,"L",PSOLBL,0),"^",2)<IFN  I $P(^PSRX(DA,"L",PSOLBL,0),"^",2)=IFN S PSONODEL=1
 .Q:PSONODEL
 .K PSORFDEL K ^PSRX(DA,1,IFN),^PSRX("AD",SUSD,DA,IFN),^PSRX(DA,1,"B",SUSD,IFN)
 .S $P(^PSRX(DA,1,0),"^",4)=$P(^PSRX(DA,1,0),"^",4)-1,DA(1)=DA
 .S NODE=0 D SPR^PSOUTL K DA(1),RF,NODE
 S IFN=0 F  S IFN=$O(^PSRX(DA,1,IFN)) Q:'IFN  I '$O(^PSRX(DA,1,IFN)) S $P(^PSRX(DA,3),"^")=+$P(^PSRX(DA,1,IFN,0),"^"),$P(^(3),"^",2)=SUSD
 I '$O(^PSRX(DA,1,0)) S $P(^PSRX(DA,3),"^")=$P(^PSRX(DA,2),"^",2),$P(^PSRX(DA,3),"^",2)=SUSD
 K IFN,SUSD
 Q
KILL K %,ACNT,ACOM,ACT,ALL,BCNUM,CMOP,CNT,DA,DAYS360,DEAD,DRG,DIRUT,DR,DRUG,DTOUT,DUOUT,FDT,HOLD,I,II,IN,IT,JJ,LC,LFD,LINE,LL,LPRT,LREF,LSI,NAME,NDF,NOEXP,NSF,OUT,RXSP,EN,WARN K:'$G(POERR) INCOM
 K PSODRUG,PCNT,POP,PPL,PS,PSFROM,PSINV,PLINE,PSI,PSINV,PSOCAN,PSOCMOP,PSODFN,PSODRG,PSOOPT,PSOSD,PSPOP,PSRXDA,PSS,PSVC,PSONOOR
 K REA,RELDT,RF,RFDATE,RFCNT,RFL,RFL1,RFLL,RP,RX,RX0,RXCNT,RXDA,RXN,RXNUM,RXP,RXREC,RXREF,RXS,SDATE,SPCANC,SS,STAT,SUB,X,XFDT,XLPDT,XRELDT,Y D KVA^VADPT Q
DELREF ;
 N RDL,PSCNODE
 S PSORFDEL=0
 F RDL=0:0 S RDL=$O(^PSRX(DA,4,RDL)) Q:'RDL  I $G(IFN)=$P($G(^PSRX(DA,4,RDL,0)),"^",3) S PSCNODE=$G(^(0))
 I $G(PSCNODE)="" Q
 I +$P(PSCNODE,"^",4)<3 S PSORFDEL=1
 Q
AUTOD ;reinstates Rxs dc'd by date of death
 I $G(^PSRX(DA,"DDSTA"))']"" K ^PSRX("APSOD",+$P(^PSRX(DA,0),"^",2),DA),DODR Q
 S DODS=$P(^PSRX(DA,"DDSTA"),"^"),DODD=$P(^("DDSTA"),"^",2,245)
 S FILE=$P(DODS,";"),STA=$P(DODS,";",2)
 I FILE=52.4 D  Q
 .S RXN=DA,^PS(52.4,DA,0)=DODD,DIK="^PS(52.4," D IX^DIK K DIK,DA S DA=RXN,$P(^PSRX(DA,"STA"),"^")=STA
 .S ST="SC",PHST="IP",ACOM="Date of Death Deleted. Returned to Non-Verified status."
 .K ^PSRX("APSOD",$P(^PSRX(DA,0),"^",2),DA),^PSRX(DA,"DDSTA")
 .S DA=RXN D LOG D EN^PSOHLSN1(DA,ST,PHST,ACOM) K ST,PHST,ACOM,RXN
 I FILE=52.5 D  Q
 .;Adds rec to suspense
 .S RXN=DA,RXS=$O(^PS(52.5,"B",DA,0)) I RXS S DA=RXS,DIK="^PS(52.5," D ^DIK
 .S DIC="^PS(52.5,",DIC(0)="L",X=RXN K DD,DO D FILE^DICN S DA=+Y
 .S ^PS(52.5,DA,0)=DODD,^PS(52.5,DA,"P")=0,LFD=$E($P(^PS(52.5,DA,0),"^",2),4,5)_"-"_$E($P(^(0),"^",2),6,7)_"-"_$E($P(^(0),"^",2),2,3)
 .S DIK="^PS(52.5," D IX^DIK K DIK,DA S DA=RXN,$P(^PSRX(DA,"STA"),"^")=STA
 .S ACOM="Date of Death Deleted. RX Placed on Suspense until "_LFD
 .K ^PSRX("APSOD",PSODFN,DA),^PSRX(DA,"DDSTA")
 .I STA=5 S ST="SC",PHST="ZS" D LOG D EN^PSOHLSN1(DA,ST,PHST,ACOM) K ST,PHST,ACOM,LFD
 I FILE=52 S ^PSRX(DA,"STA")=STA I STA=3!(STA=16) D  Q
 .S ^PSRX(DA,"H")=DODD,^PSRX("AH",$P(^PSRX(DA,"H"),"^"),DA)=""
 .S ACOM="Date of Death Deleted. Medication Returned to"_$S(STA=16:" Provider",1:"")_" Hold Status "_$E(DT,4,5)_"/"_$E(DT,6,7)_"/"_$E(DT,2,3)_"."
 .D LOG,EN^PSOHLSN1(DA,"OH","",ACOM) K ACOM
 .K ^PSRX("APSOD",PSODFN,DA),^PSRX(DA,"DDSTA")
 S ACOM="Date of Death Deleted. Prescription Reinstated." D EN^PSOHLSN1(DA,"SC","CM",ACOM),LOG K ACOM
 K ^PSRX("APSOD",PSODFN,DA),^PSRX(DA,"DDSTA")
 Q
LOG K ACNT F SUB=0:0 S SUB=$O(^PSRX(DA,"A",SUB)) Q:'SUB  S ACNT=$G(ACNT)+1
 S RFCNT=0 F RF=0:0 S RF=$O(^PSRX(DA,1,RF)) Q:'RF  S RFCNT=$G(RFCNT)+1 S:RF>5 RFCNT=$G(RFCNT)+1
 S ACNT=$G(ACNT)+1
 D NOW^%DTC S ^PSRX(DA,"A",0)="^52.3DA^"_ACNT_"^"_ACNT S ^PSRX(DA,"A",ACNT,0)=%_"^R^"_DUZ_"^"_RFCNT_"^"_ACOM
 K ^PSRX("APSOD",PSODFN,DA),ACNT,RFCNT,RF,%
 S $P(^PSRX(DA,3),"^")=$P(^PSRX(DA,3),"^",5),$P(^(3),"^",2)=$P(^(3),"^",8)
 S $P(^PSRX(DA,3),"^",5)="",$P(^(3),"^",8)=""
 Q
NVER ;Called from PSOCAN3, needs DA defined
 N PSONVC,PSONVCP,PSONVCC
 S PSONVC="SC",PSONVCP="IP",PSONVCC="Put in non-verified status" D EN^PSOHLSN1(DA,PSONVC,PSONVCP,PSONVCC)
 Q
RMB(IDX) ;remove Rx if found in array BBRX() (Bingo Board)
 N ST4,ST5,ST6,K
 S ST4=BBRX(IDX) Q:ST4'[(DA_",")
 S ST6=""
 F K=1:1 S ST5=$P(ST4,",",K) Q:'ST5  D
 . S:ST5'=DA ST6=ST6_$S('ST6:"",1:",")_ST5
 . S:ST6]"" BBRX(IDX)=ST6_"," K:ST6="" BBRX(IDX)
 I '$D(BBRX) K BINGCRT
 Q
 ;
