PSORXL ;BHAM ISC/SAB - action to be taken on prescriptions ;10/15/08 2:12pm
 ;;7.0;OUTPATIENT PHARMACY;**8,21,24,32,47,135,148,287,334,251,354,367**;DEC 1997;Build 62
 ;External reference to File #50 supported by DBIA 221
 ;External references CHPUS^IBACUS and TRI^IBACUS supported by DBIA 2030
 I $G(PSOTRVV),$G(PPL) S PSORX("PSOL",1)=PPL K PPL
 N SLBL,PSOSONE,PSOKLRXS,PSOSKIP S PSOSKIP=1
 S:'$G(PPL) PPL=$G(PSORX("PSOL",1)) G:$P(PSOPAR,"^",26) P
LBL ;
 I $G(PPL) N PSOCKDC S PSOCKDC=1 D ECME^PSORXL1 I '$G(PPL) S PPL="" G RXSQUIT  ;*334 ;don't prompt to print labels for DC'ed Rx's
 W !! S DIR("A",1)="Label Printer: "_$S($G(SUSPT):PSLION,1:$G(PSOLAP))
 I $$GET1^DIQ(59,PSOSITE,134)'="" D
 . I $G(PSOFDAPT)="" S PSOFDAPT=$$DEFPRT^PSOFDAUT(PSOSITE)
 . S DIR("A",2)="FDA Med Guide Printer: "_$S($G(PSOFDAPT)="":"HOME",1:$P(PSOFDAPT,"^"))
 S DIR("A")="LABEL: QUEUE/CHANGE PRINTER"_$S($P(PSOPAR,"^",23):"/HOLD",1:"")_$S($P(PSOPAR,"^",24):"/SUSPEND",1:"")_$S($P(PSOPAR,"^",26):"/LABEL",1:"")_" or '^' to bypass "
 S DIR("?",1)="Enter 'Q' to queue labels to print",DIR("?")="Enter '^' to bypass label functions",DIR("?",4)="Enter 'S' to suspend labels to print later"
 S DIR("?",2)="Enter 'H' to hold label until Rx can be filled",DIR("?",3)="Enter 'P' for Rx profile"
 S DIR("?",5)="Enter 'C' to select another label printer"
 S:$P(PSOPAR,"^",26) DIR("?",5)="Enter 'L' to print labels without queuing"
TRI ;Tricare
 S X="IBACUS" X ^%ZOSF("TEST") K X I '$T G PASS
 I '$$TRI^IBACUS() G PASS
 I '$D(PSORX("PSOL",1))!($G(PSOSUREP))!($G(PSOEXREP)) G PASS
 N GGG,PBILL,PSTRD,PSTRDZ,PSTRF,PSTRP,TRXI,TRIRX,PSTRIVAR,VV,VVV,VVCT
 D DEV^PSOCPTRI
 K ^TMP($J,"PSONOB"),^TMP($J,"PSOBILL")
 S VVCT=0 F VV=0:0 S VV=$O(PSORX("PSOL",VV)) Q:'VV  F VVV=1:1 S TRXI=$P(PSORX("PSOL",VV),",",VVV) Q:'TRXI  D
 .I '$G(DT) S DT=$$DT^XLFDT
 .I $P($G(^PSRX(+TRXI,"STA")),"^")=3 Q
 .S PSTRP=$P($G(^PSRX(+TRXI,0)),"^",2),PSTRD=+$G(PSOSITE),PSTRDZ=+$G(DUZ)
 .S PSTRF=0 F GGG=0:0 S GGG=$O(^PSRX(+TRXI,1,GGG)) Q:'GGG  S PSTRF=GGG
 .S VVCT=VVCT+1
 .I $G(RXRP(TRXI))!($G(RXPR(TRXI)))!($G(RXRH(TRXI))) S ^TMP($J,"PSONOB",VVCT)=TRXI Q
 .S PBILL=$$CHPUS^IBACUS(PSTRP,DT,TRXI,PSTRF,PSOLAP,PSTRD,PSTRDZ) S ^TMP($J,$S($G(PBILL):"PSOBILL",1:"PSONOB"),VVCT)=TRXI
 I '$D(^TMP($J,"PSOBILL")) K ^TMP($J,"PSONOB") G PASS
 I '$D(^TMP($J,"PSONOB")),$D(^TMP($J,"PSOBILL")) S (Y,LBL)="H" G H1
 ;If some Rx's are billable, and some are not
SETP K PSORX("PSOL"),PPL S VVCT=1 F VV=0:0 S VV=$O(^TMP($J,$S($G(PSTRIVAR):"PSONOB",1:"PSOBILL"),VV)) Q:'VV  S TRIRX=^TMP($J,$S($G(PSTRIVAR):"PSONOB",1:"PSOBILL"),VV) I +TRIRX D
 .I $G(PSORX("PSOL",1))="" S PSORX("PSOL",1)=TRIRX_"," Q
 .I $L(PSORX("PSOL",VVCT))+$L(TRIRX)<220 S PSORX("PSOL",VVCT)=PSORX("PSOL",VVCT)_TRIRX_"," Q
 .S VVCT=VVCT+1 S PSORX("PSOL",VVCT)=TRIRX_","
 I '$G(PSTRIVAR) S (Y,LBL)="H" S PSOKLRXS=1 K PSORSAVE,PSOPSAVE,PSOHSAVE D RSAVE D H1 D RREST K PSORSAVE,PSOPSAVE,PSOHSAVE K PSOKLRXS S PSTRIVAR=1 G SETP
 K ^TMP($J,"PSONOB") S PPL=$G(PSORX("PSOL",1))
PASS ;
 I $E($G(DIR("A")),1,6)'="LABEL:" D RESDIR^PSOCPTRI
 S DIR(0)="SA^P:PROFILE;Q:QUEUE;C:CHANGE PRINTER"_$S($P(PSOPAR,"^",23):";H:HOLD",1:"")_$S($P(PSOPAR,"^",24):";S:SUSPENSE",1:"")_$S($P(PSOPAR,"^",26):";L:PRINT",1:""),DIR("B")="Q" D ^DIR D  G:$D(DIRUT)!($D(DUOUT)) EX
 .I $D(DIRUT)!($D(DUOUT)) D AL^PSOLBL("UT") I $G(PSOEXREP) S PSOEXREX=1
 .I $G(PSOPULL) I $D(DIRUT)!($D(DUOUT)) S PSOQFLAG=1
 S:$G(PSOBEDT) NOPP=Y
 I $G(Y)="C" K PSOCLBL,%ZIS("B") S PSOCLBL=1 D @$S('$D(PSOPAR):"^PSOLSET",1:"PLBL^PSOLSET") K PSOCLBL G LBL
 I $G(Y)="Q",$D(RXRS),'$G(PSOPULL) D PPLADD^PSOSUPOE
 I $G(PSXSYS),($G(Y)'="H"),($G(Y)'="P"),('$G(PSOEXREP)) S LBL=Y,(RXLTOP,PPL1)=1 S:'$G(PSOPULL) SLBL=Y D A^PSOCMOP G:'$G(PPL) D1
 K DIR S LBL=Y S:'$G(PSOPULL) SLBL=Y G Q:Y="Q",S:Y="S",H1:Y="H",P:Y="L" I Y="P" W ! S PSDFN=DFN,PSFROM="" D ^PSODSPL K PSDFN,PSFROM G LBL
EX I $D(DUOUT)!$D(DIRUT) K BINGCRT,BINGRTE,BBRX,BBFLG S:$D(RXRS) SLBL="^" G:$D(RXRS) RXS K DIR,X,DIRUT,DUOUT,ACT,Y,DTOUT,PPL,REPRINT S NOBG=1 G RXSQUIT  ;*334
Q S PPL1=1 G:$G(PPL)']"" D1 S PSNP=0,PSL=1 D  I $G(PSOFROM)="NEW",$P(PSOPAR,"^",8) S PSNP=1
 .Q:'$P(PSOPAR,"^",8)!($G(PSONOPRT))
 .F SLPPL=0:0 S SLPPL=$O(RXRS(SLPPL)) Q:'SLPPL!($G(PSNP))  I '$O(^PSRX(SLPPL,1,0)),'$D(RXPR(SLPPL)) S PSNP=1
 I $G(PSOLAP)]"",$G(PSOLAP)'=ION G Q2
Q1 W ! K POP S %ZIS("B")="",%ZIS="MNQ",%ZIS("A")="Select LABEL DEVICE: " D ^%ZIS S PSLION=ION K %ZIS("A")
 G:$G(POP)&($G(PSPARTXX)) RXSQUIT G:$G(POP)&($G(PSOSONE)) RXSQ D:$G(POP)&($G(PSONOPRT))
 .S PSOQFLAG=1
 G:$G(PSOQFLAG) RXSQUIT G:POP!(IO=IO(0)) LBL S PSOLAP=ION  ;*334
 N PSOIOS S PSOIOS=IOS D DEVBAR^PSOBMST
 S PSOBARS=PSOBAR1]""&(PSOBAR0]"")&$P(PSOPAR,"^",10)
 D ^%ZISC S PSL=0
Q2 ; Checking FDA Med Guide printer
 I ($$GET1^DIQ(59,PSOSITE,134)="")!($G(PSOEXREP)&'$G(PSOMGREP))!'$$FDARX(PPL)!($G(PSOSKIP)&($G(PSOFDAPT)'="")) G QLBL
 I $G(PSOEXREP),'$G(PSOMGREP) G QLBL
 N FDAPRT S FDAPRT=""
 F  D  Q:FDAPRT'=""!(FDAPRT="^")
 . S FDAPRT=$$SELPRT^PSOFDAUT($P($G(PSOFDAPT),"^"))
 . I FDAPRT="" W $C(7),!,"You must select a valid FDA Medication Guide printer."
 I FDAPRT="^"!(FDAPRT="") G LBL
 S PSOFDAPT=FDAPRT
 ;
QLBL I $G(PSXSYS),('$G(RXLTOP)),('$G(PSOEXREP)) D RXL^PSOCMOP G:'$G(PPL) D1
 ;
 ;- Submitting list of Rx to ECME for DUR/79 REJECT check and possible submission to 3rd Pary Payer
 D ECME^PSORXL1 I '$G(PPL) W !!,"No Label(s) printed.",!! S PSOQFLAG=1 G RXSQUIT  ;*334
 ;
 S ZTRTN="DQ^PSOLBL",ZTIO=$S($G(SUSPT):PSLION,1:PSOLAP),ZTDTH=$S($G(PSOTIME):PSOTIME,1:$H),PDUZ=DUZ,OPAIO=ZTIO
 S ZTDESC="Outpatient Pharmacy "_$S($G(SUSPT):"SUSPENSE ",$G(DG):"DRUG INTERACTION ",1:"")_"LABELS OUTPUT ROUTINE"
 F G="PPL1","PSOSYS","DFN","PSOPAR","PDUZ","PCOMX",$S($G(SUSPT):"PFION",1:"PSOLAP"),"PPL" S:$D(@G) ZTSAVE(G)=""
 F G="RXY","PSOSITE","COPIES","SIDE","PSOSUSPR","PSOBARS","PSOBAR1","PSOBAR0","PSODELE" S:$D(@G) ZTSAVE(G)=""
 F G="PSOPULL","PSTAT","PSODBQ","PSOEXREP","PSOTREP","PSOFDAPT","PSOMGREP" S:$D(@G) ZTSAVE(G)=""
 S ZTSAVE("PSORX(")="",ZTSAVE("RXRP(")="",ZTSAVE("RXPR(")="",ZTSAVE("RXRS(")="",ZTSAVE("RXFL(")="",ZTSAVE("PCOMH(")=""
 D ^%ZISC,^%ZTLOAD K:$G(PSOSONE) RXRS
 I $D(ZTSK)&('$G(SUSPT))&('$G(PSOEXREP)) D
 . W !!,"LABEL(S) QUEUED TO PRINT",!!
 . D OPAI
 K OPAIO
 G:$G(PSPARTXX) RXSQUIT K G,PDUZ K:'$G(SUSPT) ZTSK G:$G(DG) RXSQUIT  ;*334
 G:'$G(PSNP) QUEUP G:$G(PSOPRFLG) QUEUP S HOLDRPAS=$G(PSOPRPAS),PSOPRPAS=$P(PSOPAR,"^",13)
PLBL S PSOION=ION
 I '$D(PSOPROP)!($G(PSOPROP)=ION) W $C(7),!,"PROFILES MUST BE SENT TO PRINTER !!",! K IOP,%ZIS,IO("Q"),POP S %ZIS="MNQ",%ZIS("A")="Select PROFILE DEVICE: " D ^%ZIS K %ZIS("A") G:POP QUEUP G:$E(IOST)["C"!(PSOION=ION) PLBL S PSOPROP=ION
QPRF S ZTRTN="DQ^PSOPRF",ZTIO=PSOPROP,ZTDESC="Outpatient Pharmacy "_$S($G(SUSPT):"SUSPENSE ",1:"")_"PATIENT PROFILES",ZTDTH=$S($G(PSOTIME):PSOTIME,1:$H)
 F G="PSOPAR","PSODTCUT","PSOPRPAS","DFN","PSOSITE","NEW1","NEW11","PSOBMST","PFIO","PPL" S:$D(@G) ZTSAVE(G)=""
 D ^%ZTLOAD W:$D(ZTSK)&('$G(SUSPT))&('$G(PSOEXREP)) !,"PROFILE IS QUEUED TO PRINT",!! K G K:'$G(SUSPT) ZTSK D ^%ZISC
QUEUP D:$G(POP)&($G(PSONOPRT))  G:$G(PSOQFLAG) RXSQUIT S PSNP=0,PSOPRPAS=$G(HOLDRPAS) K:PSOPRPAS']"" PSOPRPAS K HOLDRPAS G D1  ;*334
 .S PSOQFLAG=1
 Q
 ;
S G S^PSORXL1
SUS S X="IBACUS" X ^%ZOSF("TEST") K X I '$T G SUSL1
 N TRIDA S TRIDA=DA I '$$TRI^IBACUS() S DA=TRIDA G SUSL1
 I $G(RXRP(TRIDA))!($G(RXPR(TRIDA)))!($G(RXRH(TRIDA))) S DA=TRIDA G SUSL1
 N PBILL,PSTRD,PSTRDZ,PSTRF,PSTRP,GGG
 D DEV^PSOCPTRI
 I '$G(DT) S DT=$$DT^XLFDT
 S PSTRP=$P($G(^PSRX(+TRIDA,0)),"^",2),PSTRD=+$G(PSOSITE),PSTRDZ=+$G(DUZ)
 S PSTRF=0 F GGG=0:0 S GGG=$O(^PSRX(+TRIDA,1,GGG)) Q:'GGG  S PSTRF=GGG
 S PBILL=$$CHPUS^IBACUS(PSTRP,DT,TRIDA,PSTRF,PSOLAP,PSTRD,PSTRDZ)
 I '$G(PBILL) S DA=TRIDA G SUSL1
 S FLD(99)="99",FLD(99.1)="Awaiting CHAMPUS billing approval"
 N RSDT,ACT,PSUS,RXF,RFN,I,PSDA,NOW,IR,FDA
 S DA=TRIDA D H^PSOCPTRH
 Q
SUSL1 G SUS^PSORXL1
H1 S PPL1=1 S:'$G(PPL) PPL=$G(PSORX("PSOL",PPL1))
 D:'$D(^TMP($J,"PSOBILL")) NOOR^PSOHLD I $D(DIRUT) K DIRUT G PSORXL
 I $D(^TMP($J,"PSOBILL")) S FLD(99)="99",FLD(99.1)="Awaiting CHAMPUS billing approval" G H
 G:$G(PPL)']"" D1 D FLD^PSOHLD I $D(DUOUT)!($D(DIRUT)) K DIRUT,DUOUT,FLD,DIR G LBL
H K SPPL G:$D(DTOUT) D1 S SPPL="" F PI=1:1 Q:$P(PPL,",",PI)=""  D
 .S DA=$P(PPL,",",PI) I $P(^PSRX(DA,"STA"),"^")<10,$P(^("STA"),"^")'=4 D @$S($D(^TMP($J,"PSOBILL")):"H^PSOCPTRH",1:"H^PSOHLD") Q
 .I $P(^PSRX(DA,"STA"),"^")=4 S SPPL=SPPL_DA_"," Q
 I $G(SPPL)]"" D
 .W !!,$C(7),"Drug Interaction Rx(s) " F I=1:1 Q:$P(SPPL,",",I)=""  W $P(^PSRX($P(SPPL,",",I),0),"^")_", "
 .S PPL=SPPL,DG=1 D Q K DG,SPPL
D1 K RXLTOP I $G(PPL1),$O(PSORX("PSOL",$G(PPL1))) S PPL1=$O(PSORX("PSOL",PPL1)),PPL=PSORX("PSOL",PPL1) G @$S(LBL="H":"H",LBL="L":"P1",1:"QLBL")
RXS I $D(RXRS),'$G(PSOKLRXS) I $G(SLBL)="H"!($G(SLBL)="S")!($G(SLBL)="^")!($G(SLBL)="") D  G:$G(PPL)'="" Q
 .K PPL,PSORX("PSOL") S PSOSONE=1 D PPLADD^PSOSUPOE
 .Q:$G(PPL)=""  W !!,"You have selected the following Rx(s) to be pulled from suspense:",!
 .F RXSS=0:0 S RXSS=$O(RXRS(RXSS)) Q:'RXSS  W !," Rx # ",$P($G(^PSRX(+$G(RXSS),0)),"^"),?23,$P($G(^PSDRUG(+$P($G(^PSRX(+$G(RXSS),0)),"^",6),0)),"^")
 .K DIR W ! S DIR(0)="Y",DIR("B")="YES",DIR("A")="Do you still want to pull these Rx(s) from suspense" D ^DIR K DIR I Y'=1 W !!,"Rx(s) will remain in Suspense!",! D RESET^PSOSUPOE K RXRS,PPL
RXSQUIT K:'$G(PSOKLRXS) RXRS K ^TMP($J,"PSOBILL"),RXPR,RXRP,RXRH,RXSS,LBL,PPL1,PPL,DIR,%DT,%,SD,COUNT,EXDT,L,PDUZ,REF,REPRINT,RFDATE,RFL1,RFLL,RXN,WARN,ZY,FLD,PI,ZD,ACT,X,Y,DIRUT,DUOUT,DTOUT,DIROUT Q  ;*334 ADDED TAG NAME
P S PPL1=1 S:'$G(PPL) PPL=$G(PSORX("PSOL",1)) G:$G(PPL)']"" D1
 I $G(PSOLAP)']"" W ! K POP,ZTSK S %ZIS="M",%ZIS("A")="Select LABEL DEVICE: " D ^%ZIS K %ZIS("A") G:POP LBL S PSOLAP=ION
 S IOP=PSOLAP D ^%ZIS
 N PSOIOS S PSOIOS=IOS D DEVBAR^PSOBMST
P1 S PSOBARS=PSOBAR1]""&(PSOBAR0]"")&$P(PSOPAR,"^",10),PDUZ=DUZ D DQ1^PSOLBL,^%ZISC
 G:'$P(PSOPAR,"^",8)!(+$G(REPRINT))!($G(PSOFROM)'="NEW") D1 I $G(PSOPROP)']"" S PSOION=ION,%ZIS="M",%ZIS("A")="Select PROFILE DEVICE: " D ^%ZIS K %ZIS("A") G:POP D1 S PSOPROP=ION
 S IOP=PSOPROP D ^%ZIS D DQ^PSOPRF,^%ZISC G D1
 Q
RXSQ K RXRS G RXS
 Q
FDARX(PPL) ; Check if any Rx to be printed has an FDA Med Guide
 N FDARX,FDARXIEN,I S FDARX=0
 F I=1:1:$L($G(PPL),",") D  Q:FDARX
 . S FDARXIEN=+$P(PPL,",",I) I 'FDARXIEN Q
 . I $D(RXRP(FDARXIEN)),'$D(RXRP(FDARXIEN,"MG")) Q
 . I FDARXIEN,$$MGONFILE^PSOFDAUT(FDARXIEN) S FDARX=1
 Q FDARX
 ;
RSAVE N PMX
 S PMX="" F  S PMX=$O(RXRP(PMX)) Q:PMX=""  S PSORSAVE(PMX)=RXRP(PMX)
 S PMX="" F  S PMX=$O(RXPR(PMX)) Q:PMX=""  S PSOPSAVE(PMX)=RXPR(PMX)
 S PMX="" F  S PMX=$O(RXRH(PMX)) Q:PMX=""  S PSOHSAVE(PMX)=RXRH(PMX)
 Q
RREST N PMXZ
 S PMXZ="" F  S PMXZ=$O(PSORSAVE(PMXZ)) Q:PMXZ=""  S RXRP(PMXZ)=PSORSAVE(PMXZ)
 S PMXZ="" F  S PMXZ=$O(PSOPSAVE(PMXZ)) Q:PMXZ=""  S RXPR(PMXZ)=PSOPSAVE(PMXZ)
 S PMXZ="" F  S PMXZ=$O(PSOHSAVE(PMXZ)) Q:PMXZ=""  S RXRH(PMXZ)=PSOHSAVE(PMXZ)
 Q
 ;
OPAI ;This section of code will display where an RX is routed.
 ;To determine where an RX will be routed, check:
 ;1) if the drug for the RX is associated with an ADD device in
 ;   file #50 and if the printer is in the DISPENSING SYSTEM 
 ;   PRINTER multiple sub-file #59.02008. If it is then the RX 
 ;   will display as being routed to that device.  
 ;2) Otherwise, the category of the ADD associated with the
 ;   printer in sub-file #59.20081 will be used to determine 
 ;   where the RX will be routed and the ADD displayed.
 ;
 N DIC,X,Y,PN,II,RX,DEV,DDEV,ADD,DAT,DAT1,PDAT,DRG,DRG0,OPAI,CSB,RTE,FLG
 N ZTIO,MTH,NPPL
 I ($G(OPAIO)="")!($G(PPL)="") Q
 S DIC=3.5,DIC(0)="",X=OPAIO D ^DIC K DIC,X Q:Y=-1  S ZTIO=+Y
 S FLG=1,DEV=0,PN=$O(^PS(59,PSOSITE,"P","B",ZTIO,"")) I PN="" Q 
 I '$P($G(PSOPAR),"^",30) Q
 I $$GET1^DIQ(59,PSOSITE_",",105,"I")'=2.4 Q
 ;
 ;ADD array built base on category.
 ; if category is not "S" then 
 ;               ADD(category)=ADD name^dns^port^inactive date
 ; if category is "S" then (Category "S" can be multiple)
 ;               ADD(category,ADD name)=ADD name^dns^port^inactive date
 ;Array OPAI will be used to display the data on the screen.
 ;               OPAI(ADD name)=ADD name^dns^port^inactive date
 ;               OPAI(ADD name,RX)=drug
 ;
 F  S DEV=$O(^PS(59,PSOSITE,"P",PN,"OPAI",DEV)) Q:'DEV  D
 .S DAT=$G(^PS(59,PSOSITE,"P",PN,"OPAI",DEV,0)) I $P(DAT,"^",2)="" Q
 .S DAT1=$$ADDCHK^PSOHLDS($P(DAT,"^"))
 .I DAT1 D
 ..I $P(DAT,"^",2)'="S" S ADD($P(DAT,"^",2))=$P(DAT1,"^",2,99) Q
 ..S ADD($P(DAT,"^",2),$P(DAT1,"^",2))=$P(DAT1,"^",2,99)
 S NPPL=""
 F II=1:1:$L(PPL,",") S RX=$P(PPL,",",II) D:RX'=""
 .I $G(RXRP(RX,"RP")) Q 
 .S PDAT=$G(^PSRX(RX,0)),DRG=$P(PDAT,"^",6),RTE=$$RTE()
 .S DRG0=$G(^PSDRUG(+DRG,0)),DDEV=$G(^PSDRUG(+DRG,"OPAI",PSOSITE,0))
 .I $S($P(PSOPAR,"^",30)=3:1,$P(PSOPAR,"^",30)=4:1,1:0),'$$GET1^DIQ(50,DRG,28,"I") Q
 .S NPPL=NPPL_","_RX,DAT1=$$ADDCHK^PSOHLDS($S(RTE="W":$P(DDEV,"^",2),RTE="M":$P(DDEV,"^",3),1:"")) I DAT1 D  Q
 ..D SETOP($P(DAT1,"^",2,99),$P(PDAT,"^"),$P(DRG0,"^"))
 .I $D(ADD("A")) D SETOP(ADD("A"),$P(PDAT,"^"),$P(DRG0,"^")) Q
 .S CSB=+$P(DRG0,"^",3),CSB=$S((CSB>0)&(CSB<6):"CS",1:"NCS")
 .I $D(ADD(CSB)) D SETOP(ADD(CSB),$P(PDAT,"^"),$P(DRG0,"^")) Q
 .I $D(ADD(RTE_CSB)) D SETOP(ADD(RTE_CSB),$P(PDAT,"^"),$P(DRG0,"^")) Q
 .S MTH=$S(RTE="W":"WIND",RTE="M":"MAIL",1:"")
 .I MTH'="",$D(ADD(MTH)) D SETOP(ADD(MTH),$P(PDAT,"^"),$P(DRG0,"^"))
 .S FLG=0
 I FLG Q  ;nothing found to print
 I ($D(OPAI))!($D(ADD("S"))) W !,"PRESCRIPTIONS SENT TO:" D
 .S DEV="" F  S DEV=$O(OPAI(DEV)) Q:DEV=""  W !?3,DEV D  W !
 ..S RX=0 F  S RX=$O(OPAI(DEV,RX)) Q:'RX  W !?5,RX,?20,$P(OPAI(DEV,RX),"^")
 I $D(ADD("S")) W !,"STORAGE DEVICES" S II="" D
 .F  S II=$O(ADD("S",II)) Q:II=""  W !?3,II I $D(OPAI) ;W ?20,"The above Prescriptions"
 .F II=1:1:$L(NPPL,",") S RX=$P(NPPL,",",II) D:RX'=""
 ..Q:$G(RXRP(RX,"RP"))  S PDAT=$G(^PSRX(RX,0)),DRG=$P($G(^PSDRUG(+$P(PDAT,"^",6),0)),"^")
 ..W !?5,$P(PDAT,"^"),?20,DRG
 .W !
 Q
 ;
SETOP(DINF,DRX,DDRG) ; Set OPAI array
 N DNAM
 S DNAM=$P(DINF,"^"),OPAI(DNAM)=DINF,OPAI(DNAM,DRX)=DDRG,FLG=0
 Q
 ;
RTE() ; get route for RX
 N FP,FPN,LRF,MW,XX
 S FP=$S($G(RXPR(RX)):"P",1:"F")
 I '$G(RXPR(RX)) S LRF=0 F XX=0:0 S XX=$O(^PSRX(RX,1,XX)) Q:'XX  I +^(XX,0) S LRF=XX
 I '$G(RXPR(RX)),$G(RXFL(RX))'="" S LRF=$S($G(RXFL(RX))=0:0,$D(^PSRX(RX,1,+$G(RXFL(RX)),0)):+$G(RXFL(RX)),1:$G(LRF))
 S FPN=$S($G(RXPR(RX)):RXPR(RX),1:$G(LRF))
 I FP="F"&('FPN) S MW=$P($G(^PSRX(RX,0)),"^",11)       ;original
 I FP="F"&(FPN) S MW=$P($G(^PSRX(RX,1,FPN,0)),"^",2)   ;refill
 I FP="P"&(FPN) S MW=$P($G(^PSRX(RX,"P",FPN,0)),"^",2) ;partial
 Q $G(MW)
