PSXRPPL ;BIR/WPB,BAB-Gathers data for the CMOP Transmission ;13 Mar 2002  10:31 AM
 ;;2.0;CMOP;**3,23,33,28,40,42,41,48,62,58,66,65,69,70**;11 Apr 97;Build 9
 ;Reference to ^PS(52.5,  supported by DBIA #1978
 ;Reference to ^PSRX(     supported by DBIA #1977
 ;Reference to ^PSOHLSN1  supported by DBIA #2385
 ;Reference to ^PSORXL    supported by DBIA #1969
 ;Reference to ^PSOLSET   supported by DBIA #1973
 ;Reference to %ZIS(1     supported by DBIA #290
 ;Reference to %ZIS(2     supported by DBIA #2247
 ;Reference to ^PSSLOCK   supported by DBIA #2789
 ;Reference to ^XTMP("ORLK-" supported by DBIA #4001
 ;Reference to ^BPSUTIL   supported by DBIA #4410
 ;Reference to ^PS(59     supported by DBIA #1976
 ;Reference to $$SELPRT^PSOFDAUT supported by DBIA #5740
 ;Called from PSXRSUS -Builds ^PSX(550.2,,15,"C" , and returns to PSXRSUS or PSXRTRAN
 ;
SDT K ^TMP($J,"PSX"),^TMP($J,"PSXDFN"),^TMP("PSXEPHNB",$J),ZCNT,PSXBAT D:$D(XRTL) T0^%ZOSV
 S PSXTDIV=PSOSITE,PSXTYP=$S(+$G(PSXCS):"C",1:"N")
 ;
 ; - Submitting prescriptions to ECME (Electronic Claims Mgmt Engine) - 3rd pary
 I $$ECMEON^BPSUTIL(PSXTDIV),$$CMOPON^BPSUTIL(PSXTDIV) D
 . N BPSCNT S BPSCNT=$$SBTECME^PSXRPPL1(PSXTYP,PSXTDIV,PRTDT,PSXDTRG)
 . ; - Wait 15 seconds per prescription sent to ECME (max of 2 hours)
 . I BPSCNT>0 H 60+$S((BPSCNT*15)>7200:7200,1:(BPSCNT*15))
 ;
 ; - Transmitting prescription to CMOP (up to THROUGH DATE)
 K ^TMP("PSXEPHIN",$J)
 S SDT=0 F  S SDT=$O(^PS(52.5,"CMP","Q",PSXTYP,PSXTDIV,SDT)) S XDFN=0 Q:(SDT>PRTDT)!(SDT'>0)  D
 . F  S XDFN=$O(^PS(52.5,"CMP","Q",PSXTYP,PSXTDIV,SDT,XDFN)) S REC=0 Q:(XDFN'>0)!(XDFN="")  D
 . . F  S REC=$O(^PS(52.5,"CMP","Q",PSXTYP,PSXTDIV,SDT,XDFN,REC)) Q:(REC'>0)!(REC="")  D
 . . . D GETDATA D:$G(RXN) PSOUL^PSSLOCK(RXN),OERRLOCK(RXN)
 ;
 ; - Pulling prescriptions ahead (parameter in OUTPATIENT SITE file #59)
 I $G(PSXBAT),'$G(PSXRTRAN) D CHKDFN^PSXRPPL2(PRTDT)
 I $G(PSXBAT),'$G(PSXRTRAN) D CHKDFN
 ;
 ; - Sends a Mailman message if there were transmission problems with the 3rd Party Payer
 I $D(^TMP("PSXEPHIN",$J)) D ^PSXBPSMS K ^TMP("PSXEPHIN",$J),^TMP("PSXEPHNB",$J)
 ;
EXIT ;   
 K SDT,DFN,REC,RXNUM,PSXOK,FILNUM,REF,PNAME,CNAME,DIE,DR,NDFN,%,CNT,COM,DTTM,FILL,JJ,PRTDT,PSXDIV,XDFN,NFLAG,CIND,XDFN
 K CHKDT,DAYS,DRUG,DRUGCHK,NM,OPDT,PHARCLK,PHY,PSTAT,PTRA,PTRB,QTY,REL,RXERR,RXF,SFN,PSXDGST,PSXMC,PSXMDT
 S:$D(XRT0) XRTN=$T(+0) D:$D(XRT0) T1^%ZOSV
 K ^TMP("PSXEPHIN",$J),^TMP("PSXEPHNB",$J)
 Q
GETDATA ;Screens rxs and builds data
 ;PSXOK=1:NOT CMOP DRUG OR DO NOT MAIL,2:TRADENAME,3:WINDOW,4:PRINTED,5:NOT SUSPENDED
 ;PSXOK=6:ALREADY RELEASED,7:DIFFERENT DIVISION,8:BAD DATA IN 52.5
 ;9:CS Mismatch,10:DEA 1 or 2
 I '$D(^PS(52.5,REC,0)) K ^PS(52.5,"AQ",SDT,XDFN,REC),^PS(52.5,"CMP","Q",PSXTYP,PSXTDIV,SDT,XDFN,REC) Q
 I $P(^PS(52.5,REC,0),"^",7)="" K ^PS(52.5,"AQ",SDT,XDFN,REC),^PS(52.5,"CMP","Q",PSXTYP,PSXTDIV,SDT,XDFN,REC) Q
 I ($P(^PS(52.5,REC,0),"^",3)'=XDFN) K ^PS(52.5,"AQ",SDT,XDFN,REC),^PS(52.5,"CMP","Q",PSXTYP,PSXTDIV,SDT,XDFN,REC) Q
 N DFN S DFN=XDFN D DEM^VADPT
 I $G(VADM(6))'="" D DELETE K VADM Q
 S PSXOK=0,NFLAG=0
 S RXN=$P($G(^PS(52.5,REC,0)),"^",1) I RXN="" S PSXOK=8 Q
 S RFL=+$$GET1^DIQ(52.5,REC,9,"I")
 I '$D(^TMP($J,"PSXBAI",DFN)) D
 .S PSXGOOD=$$ADDROK^PSXMISC1(RXN)
 .I 'PSXGOOD S PSXFIRST=1 D  I 'PSXFIRST S PSXOK=8
 ..D CHKACT^PSXMISC1(RXN)
 I PSXOK=8 K RXN Q
 ;
 N EPHQT S EPHQT=0
 I $$PATCH^XPDUTL("PSO*7.0*148") D EPHARM^PSXRPPL2 I EPHQT Q
 D CHKDATA^PSXMISC1
SET Q:(PSXOK=7)!(PSXOK=8)!(PSXOK=9)
 S PNAME=$G(VADM(1))
 I ($G(PSXCSRX)=1)&($G(PSXCS)=1) S ^XTMP("PSXCS",PSOSITE,DT,RXN)=""
 I (PSXOK=0)&(PSXFLAG=1) S ^TMP($J,"PSXDFN",XDFN)="",NFLAG=4 D DQUE,RX550215 Q
 I (PSXOK=0)&(PSXFLAG=2) D RX550215 Q
 I (PSXOK>0)&(PSXOK<7)!(PSXOK=10) D DELETE Q
 Q
 ;
DELETE ; deletes the CMOP STATUS field in PS(52.5, reindex 'AC' x-ref
 L +^PS(52.5,REC):600 Q:'$T
 N DR,DIE,DA S DIE="^PS(52.5,",DA=REC,DR="3///@" D ^DIE
 S ^PS(52.5,"AC",$P(^PS(52.5,REC,0),"^",3),$P(^PS(52.5,REC,0),"^",2),REC)=""
 L -^PS(52.5,REC)
 Q
 ;the rest of the sub-routines go through the ^PSX(550.2,,15,"C"
 ;global and checks for RXs within the days ahead range and
 ;builds the ^PSX(550.2,PSXBAT,
CHKDFN ; use the patient 'C' index under RX multiple in file 550.2 to GET dfn to gather Patients' future RXs
 I '$D(^PSX(550.2,PSXBAT,15,"C")) Q
 S PSXPTNM="" F  S PSXPTNM=$O(^PSX(550.2,PSXBAT,15,"C",PSXPTNM)) Q:PSXPTNM=""  D
 . S XDFN=0 F  S XDFN=$O(^PSX(550.2,PSXBAT,"15","C",PSXPTNM,XDFN)) Q:(XDFN'>0)  D
 . . S SDT=PRTDT F  S SDT=$O(^PS(52.5,"CMP","Q",PSXTYP,PSXTDIV,SDT)),NDFN=0 Q:(SDT>PSXDTRG)!(SDT="")  D
 . . . F  S NDFN=$O(^PS(52.5,"CMP","Q",PSXTYP,PSXTDIV,SDT,NDFN)),REC=0 Q:NDFN'>0  I NDFN=XDFN D
 . . . . F  S REC=$O(^PS(52.5,"CMP","Q",PSXTYP,PSXTDIV,SDT,NDFN,REC)) Q:REC'>0  D
 . . . . . D GETDATA D:$G(RXN) PSOUL^PSSLOCK(RXN),OERRLOCK(RXN)
 Q
 ;
BEGIN ; Select print device
 I '$D(PSOPAR) D ^PSOLSET
 I $D(PSOLAP),($G(PSOLAP)'=ION) S PSLION=PSOLAP G PROFILE
 W ! S %ZIS("A")="PRINTER 'LABEL' DEVICE:  ",%ZIS("B")="",%ZIS="MQN" D ^%ZIS S PSLION=ION G:POP EXIT
 I $G(IOST)["C-" W !,"You must select a printer!",! G BEGIN
 F J=0,1 S @("PSOBAR"_J)="" I $D(^%ZIS(2,^%ZIS(1,IOS,"SUBTYPE"),"BAR"_J)) S @("PSOBAR"_J)=^("BAR"_J)
 S PSOBARS=PSOBAR1]""&(PSOBAR0]"")&$P(PSOPAR,"^",19)
 K PSOION,J D ^%ZISC I $D(IO("Q")) K IO("Q")
 ;
PROFILE I $D(PSOPROP),($G(PSOPROP)'=ION) G FDAMG
 I $P(PSOPAR,"^",8) S %ZIS="MNQ",%ZIS("A")="Select PROFILE PRINTER: " D ^%ZIS K %ZIS,IO("Q"),IOP G:POP EXIT S PSOPROP=ION D ^%ZISC
 I $G(PSOPROP)=ION W !,"You must select a printer!",! G PROFILE
 ;
FDAMG ; Selects FDA Medication Guide Printer
 I $$GET1^DIQ(59,PSOSITE,134)'="" N FDAPRT S FDAPRT="" D  I FDAPRT="^"!($G(PSOFDAPT)="") S POP=1 G EXIT
 . F  D  Q:FDAPRT'=""
 . . S FDAPRT=$$SELPRT^PSOFDAUT($P($G(PSOFDAPT),"^"))
 . . I FDAPRT="" W $C(7),!,"You must select a valid FDA Medication Guide printer."
 . I FDAPRT'="",(FDAPRT'="^") S PSOFDAPT=FDAPRT
 Q
 ;
PRT ; w auto error trapping
 D NOW^%DTC S DTTM=% K %
 S NM="" F  S NM=$O(^PSX(550.2,PSXBAT,15,"C",NM)) Q:NM=""  D DFN,PPL ;gather patient RXs, print patient RXs
 S DIK="^PSX(550.2,",DA=PSXBAT D ^DIK K PSXBAT
 K CHKDT,CIND,DAYS,DRUG,DRUGCHK,NFLAG,NM,ORD,PDT,PHARCLK,PHY,PSTAT,PTRA,PTRB,QTY,REL,RXERR,RXF,SFN,SIG,SITE,SUS,SUSPT
 Q
DFN S DFN=0,NFLAG=2
 F  S DFN=$O(^PSX(550.2,PSXBAT,15,"C",NM,DFN)),RXN=0 Q:(DFN="")!(DFN'>0)  D
 .F  S RXN=$O(^PSX(550.2,PSXBAT,15,"C",NM,DFN,RXN)),RXF="" Q:(RXN="")!(RXN'>0)  D
 ..F  S RXF=$O(^PSX(550.2,PSXBAT,15,"C",NM,DFN,RXN,RXF)) Q:RXF=""  D BLD
 Q
BLD ;
 S BATRXDA=$O(^PSX(550.2,PSXBAT,15,"B",RXN,0)) D NOW^%DTC S DTTM=%
 S REC=$P(^PSX(550.2,PSXBAT,15,BATRXDA,0),U,5),SUS=$O(^PS(52.5,"B",RXN,0))
 I SUS=REC,+SUS'=0 I 1 ;rx still valid in suspense
 E  D  Q  ;rx gone
 . N DA,DIK S DIK=550.2,DA(1)=PSXBAT,DA=BATRXDA
 . D ^DIK
 S PSOSU(DFN,SUS)=RXN,RXCNTR=$G(RXCNTR)+1,NFLAG=2
 S $P(^PSRX(RXN,0),U,15)=0,$P(^PSRX(RXN,"STA"),U,1)=0
 K % S COM="CMOP Suspense Label "_$S($G(^PS(52.5,SUS,"P"))=0:"Printed",$G(^PS(52.5,SUS,"P"))="":"Printed",1:"Reprinted")_$S($G(^PSRX(RXN,"TYPE"))>0:" (PARTIAL)",1:"")
 D EN^PSOHLSN1(RXN,"SC","ZU",COM)
 S DA=SUS D DQUE K DA
ACTLOG F JJ=0:0 S JJ=$O(^PSRX(RXN,"A",JJ)) Q:'JJ  S CNT=JJ
 S RFCNT=0 F RF=0:0 S RF=$O(^PSRX(RXN,1,RF)) Q:'RF  S RFCNT=$S(RF<6:RF,1:RF+1)
 S CNT=CNT+1,^PSRX(RXN,"A",0)="^52.3DA^"_CNT_"^"_CNT
LOCK L +^PSRX(RXN):600 G:'$T LOCK
 S ^PSRX(RXN,"A",CNT,0)=DTTM_"^S^"_DUZ_"^"_RFCNT_"^"_COM L -^PSRX(RXN)
 K CNT,COM,RFCNT,%,JJ,RF,Y,RXCNTR
 Q
PPL K PPL,PPL1 S ORD="" F  S ORD=$O(PSOSU(ORD)) Q:(ORD="")!(ORD'>0)  D PPL1
 Q
PPL1 ; print patient labels
 F SFN=0:0 S SFN=$O(PSOSU(ORD,SFN)) Q:'SFN  D
 . S:$L($G(PPL))<240 PPL=$P(PSOSU(ORD,SFN),"^")_","_$G(PPL)
 . S:$L($G(PPL))>239 PPL1=$P(PSOSU(ORD,SFN),"^")_","_$G(PPL1)
 . S DFN=$P(^PS(52.5,SFN,0),"^",3)
 S SUSPT=1,PSNP=$S($P(PSOPAR,"^",8):1,1:0) S:$D(PSOPROP) PFIO=PSOPROP
 D QLBL^PSORXL
 I $D(PPL1) S PSNP=0,PPL=PPL1 D QLBL^PSORXL
 K PPL,PPL1,PSOSU(ORD)
 Q
DQUE ; sets the CMOP indicator field, and printed field in 52.5
 L +^PS(52.5,REC):600 G:'$T DQUE
 I NFLAG=4 D
 . S DA=REC,DIE="^PS(52.5,",DR="3////L;4////"_DT D ^DIE K DIE,DA,DR L -^PS(52.5,REC)  ; the rest moved into PSXRTR
 S CIND=$S(NFLAG=1:"X",NFLAG=2:"P",NFLAG=3:"@",1:0)
 I $G(NFLAG)'=2 D
 .S DA=REC,DIE="^PS(52.5,",DR="3////"_CIND_";4////"_DT
 .D ^DIE K DIE,DA,DR
 .S ^PS(52.5,REC,"P")=1,^PS(52.5,"ADL",DT,REC)=""
 I $G(NFLAG)=2 D  ;print label cycle
 . S DA=REC,DIE="^PS(52.5,",DR="3////"_CIND_";4////"_DTTM_";5////"_DUZ_";7////"_RXCNTR
 . D ^DIE K DIE,DA,DR
 . S ^PS(52.5,REC,"P")=1,^PS(52.5,"ADL",$E($P(^PS(52.5,REC,0),"^",8),1,7),REC)=""
 L -^PS(52.5,REC)
 I $G(NFLAG)=2 D EN^PSOHLSN1(RXN,"SC","ZU","CMOP Suspense Label Printed")
 Q
RX550215 ; put RX into RX multiple TRANS 550.215 for PSXBAT
 I '$G(PSXBAT) D BATCH^PSXRSYU ; first time through create batch, & return PSXBAT
 K DD,DO,DIC,DA,DR,D0
 S:'$D(^PSX(550.2,PSXBAT,15,0)) ^PSX(550.2,PSXBAT,15,0)="^550.215P^^"
 S X=RXN,DA(1)=PSXBAT
 S DIC="^PSX(550.2,"_PSXBAT_",15,",DIC("DR")=".02////^S X=RXF;.03////^S X=DFN;.05////^S X=REC",DIC(0)="ZF"
 D FILE^DICN
 S PSXRXTDA=+Y ;RX DA within PSXBAT 'T'ransmission
 K DD,DO,DIC,DA,DR,D0
 Q
OERRLOCK(RXN) ; set XTMP for OERR/CPRS order locking
 I $G(PSXBAT),$G(RXN),$G(PSXRXTDA) I 1
 E  Q
 I $P(^PSX(550.2,PSXBAT,15,PSXRXTDA,0),U,1)'=RXN Q
RXNSET ; set ^XTMP("ORLK-"_ORDER per IA 4001 needs RXN
 Q:'$G(RXN)
 N ORD,NOW,NOW1 S ORD=+$P($G(^PSRX(+$G(RXN),"OR1")),"^",2)
 Q:'ORD
 S NOW=$$NOW^XLFDT,NOW1=$$FMADD^XLFDT(NOW,1)
 S ^XTMP("ORLK-"_+ORD,0)=NOW1_U_NOW_"^CPRS/CMOP RX/Order Lock",^(1)=DUZ_U_$J
 Q
RXNCLEAR ; needs RXN
 Q:'$G(RXN)
 N ORD S ORD=+$P($G(^PSRX(+$G(RXN),"OR1")),"^",2) Q:'ORD
 I $D(^XTMP("ORLK-"_ORD,0)),^(0)["CPRS/CMOP" K ^XTMP("ORLK-"_ORD)
 Q
