PSODDPR3 ;BIR/SAB - display NVA enhanced order checks ;10/04/06 3:38pm
 ;;7.0;OUTPATIENT PHARMACY;**251,375**;DEC 1997;Build 17
 ;Reference ^PSDRUG supported by DBIA 221
 ;Reference ^PS(55 supported by DBIA 2228
 ;Reference ^PS(50.7 is supported by DBIA 2223
 ;Reference ^PS(50.606 supported by DBIA 2174
NVA S DUPRX0=^PS(55,PSODFN,"NVA",$P(ON,";",2),0) N NVAQ
 S:$G(PSODUPF) PSODUPC(ZCT)=PSODUPC(ZCT)+1 W:'$G(PSODUPF) ! I '$P(DUPRX0,"^",2) W:'$G(PSODUPF) $J("Non-VA Med: ",20)_$P(^PS(50.7,$P(DUPRX0,"^"),0),"^")_" "_$P(^PS(50.606,$P(^(0),"^",2),0),"^")
 E  S:$G(PSODUPF) PSODUPC(ZCT)=PSODUPC(ZCT)+1 W:'$G(PSODUPF) $J("Non-VA Med: ",20)_$P(^PSDRUG($P(DUPRX0,"^",2),0),"^")
 ;W " (Active)"
 S:$G(PSODUPF) PSODUPC(ZCT)=PSODUPC(ZCT)+1 W:'$G(PSODUPF) !,$J("Dosage: ",20)_$S($P(DUPRX0,"^",3)]"":$P(DUPRX0,"^",3),1:"<NOT ENTERED>"),$J("Schedule: ",20)_$S($P(DUPRX0,"^",5)]"":$P(DUPRX0,"^",5),1:"<NOT ENTERED>")
 K DSC,DSPL,CAN,DA,DIR,DNM,DUPRX0,ISSD,J,LSTFL,MSG,PHYS,PSOCLC,REA,RFLS,RX0,RX2,RXN,RXREC,ST,Y,ZZ,ACT,PSOCLOZ,PSOLR,PSOLDT,PSOCD,SIG
 K LST,THER,THERO,^UTILITY($J),DGI,SER,SEV,SERS,BSIG,I,NODDERR,NODTERR,PDRG,DRGI,IZ
 K ^UTILITY($J,"W"),X,ZX,DIWL,DIWR,DIWF
 Q
MON ;print monograph
 Q:$G(PSODLQT)
 N MONQ,DRGINFO,PVAGDRG,PVAGDRG,VAGDRG,MDRGCNT,MONSEV,PSOMON1,MONTITLE,FDBSEV,SMONTI,MONQ K DIR S DIR(0)="Y",DIR("A")="Display Interaction Monograph",DIR("B")="No" D ^DIR
 S:($D(DTOUT))!($D(DUOUT))!($G(DIRUT)) PSODLQT=1,PSORX("DFLG")=1 W:$G(PSODLQT) !,PSONULN,! K DIR,DTOUT,DUOUT,DIRUT Q:'Y!($G(PSODLQT))
 ;ADD OUTPUT DEVICE
 K IOP,%ZIS,POP S %ZIS="QM" D ^%ZIS
 I POP W !,"NOTHING PRINTED" Q
 E  W !
 I $D(IO("Q")) D  Q
 .S ZTRTN="QUE^PSODDPR3",ZTDESC="Monograph Report of Drug Interactions",ZTSAVE("PSONULN")="",ZTSAVE("SEV")="",ZTSAVE("LIST")=""
 .S ZTSAVE("^TMP($J,LIST,""OUT"",""DRUGDRUG"",SV,DRG,ON,")="",ZTSAVE("ON")="",ZTSAVE("DRG")="",ZTSAVE("CT")="",ZTSAVE("PDRG")=""
 .S ZTSAVE("^TMP($J,""OUT"",""REMOTE"",")="",ZTSAVE("SV")=""
 .D ^%ZTLOAD,^%ZISC W !,"Monograph Queued to Print!",!
 .S:$D(ZTQUEUED) ZTREQ="Q"
QUE   S (CT,PMON,MDRGCNT)=0 K ^TMP($J,LIST,"PMON")
 ;sort to attain an array of FDBSEV by drug and monograph title.  Note that the PMON array is already sorted by Vista Severity
 F  S CT=$O(^TMP($J,LIST,"OUT","DRUGDRUG",SV,DRG,ON,CT)) Q:'CT  D
 . I $D(^TMP($J,LIST,"OUT","DRUGDRUG",SV,DRG,ON,CT,"PMON",5,0)) S MONSEV="",MONSEV=^TMP($J,LIST,"OUT","DRUGDRUG",SV,DRG,ON,CT,"PMON",5,0) D
 ..S FDBSEV=$P($P(MONSEV,"SEVERITY LEVEL:  ",2),"-",1),FDBSEV=$TR(FDBSEV," ","") S:'$G(FDBSEV) FDBSEV=999999999
 ..S MONTITLE="",MONTITLE=$G(^TMP($J,LIST,"OUT","DRUGDRUG",SV,DRG,ON,CT,"PMON",3,0)),MONTITLE=$P(MONTITLE,"MONOGRAPH TITLE:  ",2)
 ..S:MONTITLE="" MONTITLE="Zz No title given"
 ..S PSOMON1(DRG,MONTITLE,FDBSEV)=""
 Q:$G(PSODLQT)
 ;sort "PMON" nodes by drug and FDB severity then print monograph; MDRGCNT = monograph drug count - sequential number counting monographs per drug.  If multiple monographs fro same drug allows display of each.
 ;; PMON  = counter of # of lines in the monograph to be displayed; FDBSEV = FDB severity for each monograph within the Vista severity
 F  S CT=$O(^TMP($J,LIST,"OUT","DRUGDRUG",SV,DRG,ON,CT)) Q:'CT!$G(PSODLQT)  D  S PMON=PMON+1,^TMP($J,LIST,"PMON",PMON,0)=""
 .S DRGINFO=^TMP($J,LIST,"OUT","DRUGDRUG",SV,DRG,ON,CT),PDRGIEN=$P(DRGINFO,"^",2),DRGIEN=$P(DRGINFO,"^",3)
 .S PVAGDRG=$$GET1^DIQ(50,PDRGIEN,20,"E"),VAGDRG=$$GET1^DIQ(50,DRGIEN,20,"E"),MDRGCNT=MDRGCNT+1
 .I PVAGDRG="" S PVAGDRG=$P(^TMP($J,LIST,"OUT","DRUGDRUG",SV,DRG,ON,CT),"^",4)
 .I VAGDRG="" S VAGDRG=DRG
 .S SMONTI=$G(^TMP($J,LIST,"OUT","DRUGDRUG",SV,DRG,ON,CT,"PMON",3,0)),SMONTI=$P(SMONTI,"MONOGRAPH TITLE:  ",2)
 .I $D(PSOMON1(DRG,SMONTI)) S FDBSEV="",FDBSEV=$O(PSOMON1(DRG,SMONTI,FDBSEV))
 .S PMON=PMON+1,^TMP($J,LIST,"PMON",FDBSEV,MDRGCNT,PMON,0)=PSONULN
 .S PMON=PMON+1,^TMP($J,LIST,"PMON",FDBSEV,MDRGCNT,PMON,0)="Professional Monograph",PMON=PMON+1
 .S ^TMP($J,LIST,"PMON",FDBSEV,MDRGCNT,PMON,0)="Drug Interaction with "_PVAGDRG_" and "_VAGDRG,PMON=PMON+1,^TMP($J,LIST,"PMON",FDBSEV,MDRGCNT,PMON,0)=""
 .F QX=0:0 S QX=$O(^TMP($J,LIST,"OUT","DRUGDRUG",SV,DRG,ON,CT,"PMON",QX)) Q:'QX  D FPMON
 Q:'$O(^TMP($J,LIST,"PMON",0))!$G(PSODLQT)
 K DIR,DTOUT,DUOUT,MONQ U IO W @IOF
 I $P(ON,";")="R" S RMRX=$P(^TMP($J,LIST,"OUT","REMOTE",$P(ON,";",2)),"^",5)
 ;display monograph detailed information
 F FDBSEV=0:0 S FDBSEV=$O(^TMP($J,LIST,"PMON",FDBSEV)) Q:FDBSEV=""!($G(MONQ))  F QXX=0:0 S QXX=$O(^TMP($J,LIST,"PMON",FDBSEV,QXX)) Q:QXX=""!($G(MONQ))  S PSOMONQ=0 D
 .F QX=0:0 S QX=$O(^TMP($J,LIST,"PMON",FDBSEV,QXX,QX)) Q:'QX!($G(PSOMONQ)=1)!($G(MONQ))  W !,^TMP($J,LIST,"PMON",FDBSEV,QXX,QX,0) I $Y+3>IOSL D
 ..I $E(IOST)="C",($Y+3)>IOSL S PSOMONQ=$$PAUSE1()
 ..I PSOMONQ=1 W @IOF Q
 ..I PSOMONQ=2 S MONQ=1
 ..W @IOF,!
 I '$G(PSOMONQ) K DIR S DIR(0)="E",DIR("?")="Press Return to continue",DIR("A")="Press Return to continue" D ^DIR W @IOF S:($D(DTOUT))!($D(DUOUT))!($G(DIRUT)) PSODLQT=1,PSORX("DFLG")=1 K DIR,DTOUT,DUOUT,DIRUT
 K DIR,DTOUT,DUOUT,^UTILITY($J),DIWL,DIWR,DIWF,X,QX,PMON,RDI,^TMP($J,LIST,"PMON"),RMRX,PSOMON1,PSOMONQ,MONQ,FDBSEV,MONTITLE,SMONTI
 Q
PAUSE1() ;Allow "^"
 ;Return 0 if X="" ;Return 1 if X="^" ;Return 2 if Not null or "^"
 NEW DIR,DIRUT,DUOUT,X
 W ! K DIR S DIR("A")="Press RETURN to continue, ""^"" to display the next Monograph or ""^^"" to Exit"
 S DIR("?")="Enter ""^"" to go to next Monograph, ""^^"" to exit the Monograph display."
 S DIR(0)="FOU^^K:(X'="""")!(X'[""^"") X"
 D ^DIR
 I X="" Q 0
 I X="^" Q 1
 Q 2
RDI ;RDI orders
 Q:'$D(^TMP($J,LIST,"OUT","REMOTE",$P(ON,";",2)))
 S RXREC=^TMP($J,LIST,"OUT","REMOTE",$P(ON,";",2))
 S:$G(PSODUPF) PSODUPC(ZCT)=PSODUPC(ZCT)+1 W:'$G(PSODUPF) !,$J("LOCATION: ",20)_$P(RXREC,"^")_"  Remote Rx: "_$P(RXREC,"^",5)
 S:$G(PSODUPF) PSODUPC(ZCT)=PSODUPC(ZCT)+1 W:'$G(PSODUPF) !,$J("Drug: ",20)_$P(RXREC,"^",3)_" ("_$P(RXREC,"^",4)_")"
 D FSIG(.FSIG)
 S:$G(PSODUPF) PSODUPC(ZCT)=PSODUPC(ZCT)+1 W:'$G(PSODUPF) !,$J("SIG: ",20) F I=1:1 Q:'$D(FSIG(I))  W:'$G(PSODUPF) ?20,FSIG(I) I $O(FSIG(I)) W:'$G(PSODUPF) !
 I $G(QTHER) S:$G(PSODUPF) PSODUPC(ZCT)=PSODUPC(ZCT)+1 W:'$G(PSODUPF) !,$J("QTY: ",20)_$P(RXREC,"^",8),?40,$J("Days Supply: ",24)_$P(RXREC,"^",7)
 S:$G(PSODUPF) PSODUPC(ZCT)=PSODUPC(ZCT)+1 W:'$G(PSODUPF) !,$J("Last Filled On: ",20)_$P(RXREC,"^",6)
 S ^TMP($J,"PSONRVADD",RXREC,0)=1
 K RXREC,I,FSIG
 Q
FSIG(FSIG) ;Format sig from remote site ;returned in the FSIG array
 K FSIG N FFF,NNN,CNT,FVAR,FVAR1,FLIM,HSIG,II,I
 F I=0:1 Q:'$D(^TMP($J,LIST,"OUT","REMOTE",$P(ON,";",2),"SIG",I))  S HSIG(I+1)=^(I)
FSTART S (FVAR,FVAR1)="",II=1
 F FFF=0:0 S FFF=$O(HSIG(FFF)) Q:'FFF  S CNT=0 F NNN=1:1:$L(HSIG(FFF)) I $E(HSIG(FFF),NNN)=" "!($L(HSIG(FFF))=NNN) S CNT=CNT+1 D  I $L(FVAR)>50 S FSIG(II)=FLIM_" ",II=II+1,FVAR=FVAR1
 .S FVAR1=$P(HSIG(FFF)," ",(CNT))
 .S FLIM=FVAR
 .S FVAR=$S(FVAR="":FVAR1,1:FVAR_" "_FVAR1)
 I $G(FVAR)'="" S FSIG(II)=FVAR
 I $G(FSIG(1))=""!($G(FSIG(1))=" ") S FSIG(1)=$G(FSIG(2)) K FSIG(2)
FQUIT ;
 Q
DCOR ;dc duplicate therapy
 D HD^PSODDPR2()  Q:$G(PSODLQT)
 Q:'$D(^XUSEC("PSORPH",DUZ))!$G(PSODLQT)
 S MSG="Discontinued During "_$S('$G(PSONV):"New Prescription Entry",1:"Verification")_" - Duplicate Therapy"
 S ACT="Duplicate Therapy Discontinued while "_$S('$G(PSONV):"entering",1:"verifying")_" new RX"
 N DCN,DCRD,LST S THERO=0 F I=0:0 S I=$O(^TMP($J,"PSODCOR",I)) Q:'I  S THERO=THERO+1
 I THERO=1 D  Q
 .K DIR S DIR(0)="Y",THER(1)=^TMP($J,"PSODCOR",1)
 .S DIR("A")="Discontinue "_$S($P(THER(1),"^")="P":"Pending Order "_$P(THER(1),"^",4),1:"Rx #"_$P(^PSRX($P(THER(1),"^",2),0),"^")_" "_$P(THER(1),"^",4))_" Y/N "
 .D ^DIR S:($D(DTOUT))!($D(DUOUT))!($G(DIRUT)) PSODLQT=1,PSORX("DFLG")=1 Q:$G(PSODLQT)  K DIR,DIRUT I 'Y K DIR,THER,THERO,X,Y Q
 .S ^TMP("PSORXDC",$J,$P(THER(1),"^",2),0)=$P(THER(1),"^")_"^"_$P(THER(1),"^",2)_"^"_MSG
 .I $P(THER(1),"^")=52 S ^TMP("PSORXDC",$J,$P(THER(1),"^",2),0)=^TMP("PSORXDC",$J,$P(THER(1),"^",2),0)_"^C^"_ACT_"^"_$P(THER(1),"^",3)_"^"_$P(THER(1),"^",4),PSONOOR="D"
 .S $P(^TMP("PSORXDC",$J,$P(THER(1),"^",2),0),"^",10)=1
 .W !! K ^UTILITY($J,"W") S DIWL=1,DIWR=75,DIWF=""
 .S X="Duplicate Therapy "_$S($P(THER(1),"^")="P":"Pending Order ",1:"Rx #"_$P(^PSRX($P(THER(1),"^",2),0),"^"))_" "_$P(THER(1),"^",4)_" will be discontinued after the acceptance of the new order." D ^DIWP
 .F ZX=0:0 S ZX=$O(^UTILITY($J,"W",1,ZX)) Q:'ZX  W !,^UTILITY($J,"W",1,ZX,0)
 .K ^UTILITY($J,"W"),X,DIWL,DIWR,DIWF W ! H 2
 K DIR S DIR(0)="Y",DIR("A")="Discontinue Orders Y/N ",DIR("B")="No" D ^DIR
 S:($D(DTOUT))!($D(DUOUT))!($G(DIRUT)) PSODLQT=1,PSORX("DFLG")=1 Q:$G(PSODLQT)
 I 'Y K DIR,X,Y Q
 K DIR S DIR(0)="LO^1:"_THERO
 D HD^PSODDPR2()  Q:$G(PSODLQT)
 F I=1:1:THERO S DIR("A",I)=I_". "_$S($P(^TMP($J,"PSODCOR",I),"^")="P":"Pending Order "_$P(^TMP($J,"PSODCOR",I),"^",4),1:"Rx #"_$P(^PSRX($P(^TMP($J,"PSODCOR",I),"^",2),0),"^")_" "_$P(^TMP($J,"PSODCOR",I),"^",4))
 S DIR("A")="Select Order(s)" D ^DIR S:($D(DTOUT))!($D(DUOUT))!($G(DIRUT)) PSODLQT=1,PSORX("DFLG")=1 Q:$G(PSODLQT)  K DIR,DIRUT I 'Y K THER,THERO Q
 S LST=Y(0) F DCRD=1:1:$L(LST,",") Q:$P(LST,",",DCRD)']""!$G(PSODLQT)  D
 .S DCN=$P(LST,",",DCRD),THER(DCN)=^TMP($J,"PSODCOR",DCN)
 .S ^TMP("PSORXDC",$J,$P(THER(DCN),"^",2),0)=$P(THER(DCN),"^")_"^"_$P(THER(DCN),"^",2)_"^"_MSG
 .I $P(THER(DCN),"^")=52 S ^TMP("PSORXDC",$J,$P(THER(DCN),"^",2),0)=^TMP("PSORXDC",$J,$P(THER(DCN),"^",2),0)_"^C^"_ACT_"^"_$P(THER(DCN),"^",3)_"^"_$P(THER(DCN),"^",4),PSONOOR="D"
 .S $P(^TMP("PSORXDC",$J,$P(THER(DCN),"^",2),0),"^",10)=1
 .W ! K ^UTILITY($J,"W") S DIWL=1,DIWR=75,DIWF=""
 .S X="Duplicate Therapy "_$S($P(THER(DCN),"^")="P":"Pending Order "_$P(THER(DCN),"^",4),1:"Rx #"_$P(^PSRX($P(THER(DCN),"^",2),0),"^")_" "_$P(THER(DCN),"^",4))_" will be discontinued after the acceptance of the new order." D ^DIWP
 .F ZX=0:0 S ZX=$O(^UTILITY($J,"W",1,ZX)) Q:'ZX  W !,^UTILITY($J,"W",1,ZX,0)
 .K ^UTILITY($J,"W"),X,DIWL,DIWR,DIWF H 2
 W ! K X,Y,THER,THERO,MSG,ACT,I,DIR
 Q
FPMON ;displays instruction and/or comments
 S PMON=PMON+1,MG=^TMP($J,LIST,"OUT","DRUGDRUG",SV,DRG,ON,CT,"PMON",QX,0)
 I MG="" S ^TMP($J,LIST,"PMON",FDBSEV,MDRGCNT,PMON,0)="",PMON=PMON+1 Q
 I $L(MG)>70 F SG=1:1:$L(MG," ") S:$L(($G(^TMP($J,LIST,"PMON",FDBSEV,MDRGCNT,PMON,0)))_" "_$P(MG," ",SG))>80 PMON=PMON+1 S ^TMP($J,LIST,"PMON",FDBSEV,MDRGCNT,PMON,0)=$G(^TMP($J,LIST,"PMON",FDBSEV,MDRGCNT,PMON,0))_$P(MG," ",SG)_" "
 E  S PMON=PMON+1,^TMP($J,LIST,"PMON",FDBSEV,MDRGCNT,PMON,0)=$G(^TMP($J,LIST,"PMON",FDBSEV,MDRGCNT,PMON,0))_MG
 K MG,SG
 Q
VAGEN(PSODD) ;Return the VA GENERIC name
 ;PSODD - IEN (file #50)
 N PSOIEN I '+$G(PSODD) Q ""
 S PSOIEN=+$G(^PSDRUG(PSODD,"ND")) D ZERO^PSN50P6(PSOIEN,,,,"PSOVAG")
 S PSOVAG=$G(^TMP($J,"PSOVAG",PSOIEN,.01)) K ^TMP($J,"PSOVAG")
 S:PSOVAG="" PSOVAG="*"
 Q PSOVAG
INST ;displays instruction and/or comments
 S INST=0 F  S INST=$O(^PS(52.41,RXREC,TY,INST)) Q:'INST  S MIG=^PS(52.41,RXREC,TY,INST,0) D
 .W !,$S(TY=2:"      Instructions: ",TY=3:" Provider Comments: ",1:"")
 .F SG=1:1:$L(MIG," ") D HD^PSODDPR2() Q:$G(PSODLQT)  W:$X+$L($P(MIG," ",SG)_" ")>IOM @$S(TY=3:"!?14",1:"!?19") W $P(MIG," ",SG)_" "
 K INST,TY,MIG,SG
 Q
CLASSES ;display therapeutic duplications classes (called from PSODDPR5 too)
 I '$G(PSODUPF) D
 .I '$G(PSODUPCT)&('$G(PSODUPC("CLASS"))) D HD^PSODDPR2() Q
 .I ($G(PSODUPCT)+PSODUPC("CLASS"))>22 D HD^PSODDPR2(15) S PSODUPCT=0
 Q:$G(PSODLQT)
 K ^UTILITY($J,"W") S DIWL=1,DIWR=75,DIWF="",ZCT=0 S:$G(PSODUPF) PSODUPC("CLASS")=PSODUPC("CLASS")+1 W:'$G(PSODUPF) !
 S X="Class(es) Involved in Therapeutic Duplication(s): " D ^DIWP
 S (ZCT,ZZCT,ZZZCT)=0 F  S ZZCT=$O(^TMP($J,LIST,"OUT","THERAPY",ZZCT)) Q:'ZZCT  S ZCT=0 F  S ZCT=$O(^TMP($J,LIST,"OUT","THERAPY",ZZCT,ZCT)) Q:'ZCT  D
 . S X=^TMP($J,LIST,"OUT","THERAPY",ZZCT,ZCT,"CLASS")
 . S X=^TMP($J,LIST,"OUT","THERAPY",ZZCT,ZCT,"CLASS")_$S($O(^TMP($J,LIST,"OUT","THERAPY",ZZCT))!($O(^TMP($J,LIST,"OUT","THERAPY",ZZCT,ZCT))):", ",1:" ")
 . D ^DIWP
 F ZX=0:0 S ZX=$O(^UTILITY($J,"W",1,ZX)) Q:'ZX  S:$G(PSODUPF) PSODUPC("CLASS")=PSODUPC("CLASS")+1 W:'$G(PSODUPF) !,^UTILITY($J,"W",1,ZX,0)
 K ^UTILITY($J,"W"),X,CLASS,DIWL,DIWR,DIWF,ZX,DRG,ZCT,ZZCT,ZZZCT
 S:$G(PSODUPF) PSODUPC("CLASS")=PSODUPC("CLASS")+1 W:'$G(PSODUPF) !,PSONULN1,!
 Q
