PSORXVW ;BIR/SAB - ListMan View of a Prescription ;Dec 13, 2021@09:48
 ;;7.0;OUTPATIENT PHARMACY;**14,35,46,96,103,88,117,131,146,156,185,210,148,233,260,264,281,359,385,400,391,313,427,504,622,441,651**;DEC 1997;Build 30
 ; Reference to ^PS(55 in ICR #2228
 ; Reference to ^PS(50.7 in ICR #2223
 ; Reference to ^PSDRUG( in ICR #221
 ; Reference to ^VA(200 in ICR #10060
 ; Reference to ^SC in ICR #10040
 ; Reference to ^DPT in ICR #10035
 ; Reference to ^PS(50.606 in ICR #2174
 ; Reference to GMRADPT in ICR #10099
 ; Reference to $$BADADR^DGUTL3 in ICR #4080
 ; Reference to $$POSTSHRT^WVRPCOR in ICR #6174
 ;
 S PS="VIEW"
A1 ; - Prescription prompt
 S DIR(0)="FAO^1:30",DIR("A")=PS_" PRESCRIPTION: ",(DIR("?"),DIR("??"))="^D HLP^PSORXVW1"
 W ! D ^DIR I X=""!$D(DIRUT) K:$G(PS)="VIEW" DA K PS G KILL
 S X=$$UP^XLFSTR(X),QUIT=0
 I $E(X,1,2)'="E." S (DA,PSOVDA)=+$$LKP^PSORXVW1(X) I DA<0 G A1
 I $E(X,1,2)="E." D  I QUIT G A1   ; esg 12/7/10 - ECME# lookup - PSO*7*359
 .S (DA,PSOVDA)=+$$RXNUM^PSOBPSU2($E(X,3,$L(X))) I DA<0 W " ??",$C(7) S QUIT=1
 ;
 ; pso*7*385 - esg - Routine BPSRVX is calling this routine here at entry point DP in order to capture the
 ; scratch global data for the View ECME Rx option.  Special variable BPSVRX=1 in this case.
DP ; DBIA #4711 entry point from ECME
 ;
 S (PSODFN,DFN)=+$P(^PSRX(DA,0),"^",2) S PSOLOUD=1 D:$P($G(^PS(55,PSODFN,0)),"^",6)'=2 EN^PSOHLUP(PSODFN) K PSOLOUD
 D ICN^PSODPT(PSODFN)
 K ^TMP("PSOHDR",$J) D ^VADPT,ADD^VADPT
 S ^TMP("PSOHDR",$J,1,0)=VADM(1)
 N PSOBADR,PSOTEMP
 S PSOBADR=$$BADADR^DGUTL3(DFN) I PSOBADR S PSOTEMP=$$CHKTEMP^PSOBAI(DFN) D
 .S ^TMP("PSOHDR",$J,1,0)=^TMP("PSOHDR",$J,1,0)_" ** BAD ADDRESS INDICATED-("_$S(PSOBADR=1:"UNDELIVERABLE",PSOBADR=2:"HOMELESS",1:"OTHER")_")"_$S(PSOTEMP:" Active Temporary Address",1:"")
 S ^TMP("PSOHDR",$J,2,0)=$P(VADM(2),"^",2)
 S ^TMP("PSOHDR",$J,3,0)=$P(VADM(3),"^",2),^TMP("PSOHDR",$J,4,0)=VADM(4),^TMP("PSOHDR",$J,5,0)=$P(VADM(5),"^",2)
 S POERR=1 D RE^PSODEM K PSOERR
 S ^TMP("PSOHDR",$J,6,0)=$S(+$P(WT,"^",8):$P(WT,"^",9)_" ("_$P(WT,"^")_")",1:"_______ (______)")
 S ^TMP("PSOHDR",$J,7,0)=$S($P(HT,"^",8):$P(HT,"^",9)_" ("_$P(HT,"^")_")",1:"_______ (______)") K VM,WT,HT S PSOHD=7
 S GMRA="0^0^111" D EN1^GMRADPT S ^TMP("PSOHDR",$J,8,0)=+$G(GMRAL)
 S ^TMP("PSOHDR",$J,14,0)=$$POSTSHRT^WVRPCOR(PSODFN)
 D DEM^VADPT I +VADM(6) D
 .S SSN=$P(^DPT(PSODFN,0),"^",9) W !,$C(7),?10,$P(^DPT(PSODFN,0),"^")_" ("_$E(SSN,1,3)_"-"_$E(SSN,4,5)_"-"_$E(SSN,6,9)_") DIED "_$P(VADM(6),"^",2),!
 .W "All Active Medications will be Autocanceled!",! H 2 S PSODEATH=1
 .S ACOM="Date of Death "_$P(VADM(6),"^",2)_".",ZTRTN="CAN^PSOCAN3",ZTDESC="Outpatient Pharmacy Autocancel Due to Death of Patient",ZTSAVE("ACOM")="",ZTSAVE("PSODFN")="",ZTSAVE("PSODEATH")=""
 .S ZTIO="",PSOCLC=DUZ,ZTSAVE("PSOCLC")="",ZTDTH=$H D ^%ZTLOAD K ACOM,ZTSK,PSODEATH
 K ^TMP("PSOAL",$J),PCOMX,PDA,PHI,PRC,ACOM,ANS
 S (DA,RXN)=PSOVDA K PSOVDA S RX0=^PSRX(RXN,0),RX2=$G(^(2)),RX3=$G(^(3)),ST=+$G(^("STA")),RXOR=$G(^("OR1"))
 I 'RXOR,$P(^PSDRUG($P(RX0,"^",6),2),"^") S $P(^PSRX(RXN,"OR1"),"^")=$P(^PSDRUG($P(RX0,"^",6),2),"^"),RXOR=$P(^PSDRUG($P(RX0,"^",6),2),"^")
 S IEN=0,$P(RN," ",12)=" "
 N APPND,ECME,TITR
 S APPND=$S($G(^PSRX(RXN,"IB")):"$",1:"")
 S ECME=$$ECME^PSOBPSUT(RXN)  ; Returns "" (non-ECME), or "e" (ECME)
 S TITR=$$TITRX^PSOUTL(RXN)  ; Returns "" (non-Titration), "m" (Maintenance) or "t" (titration)
 S APPND=APPND_ECME_TITR
 I ECME'="" S APPND=APPND_"  (ECME#: "_$$ECMENUM^PSOBPSU2(RXN)_")"
 I TITR'="" S APPND=APPND_"  ("_$S(TITR="t":"Titration",1:"Maintenance")_")"
 S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)=$S($P($G(^PSRX(RXN,"TPB")),"^"):"            TPB Rx #: ",1:"                Rx #: ")_$P(RX0,"^")_APPND_$E(RN,$L($P(RX0,"^")_APPND)+1,12)
 S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="      Orderable Item: "_$S($D(^PS(50.7,$P(+RXOR,"^"),0)):$P(^PS(50.7,$P(+RXOR,"^"),0),"^")_" "_$P(^PS(50.606,$P(^(0),"^",2),0),"^"),1:"No Pharmacy Orderable Item")
 S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)=$S($D(^PSDRUG("AQ",$P(RX0,"^",6))):"           CMOP ",1:"                ")_"Drug: "_$P(^PSDRUG($P(RX0,"^",6),0),"^")
 S:$G(^PSRX(RXN,"TN"))]"" IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="          Trade Name: "_$G(^PSRX(RXN,"TN"))
 ; Always display the NDC# - PSO*7*427
 S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="                 NDC: "_$$GETNDC^PSONDCUT(RXN,0)
 D DOSE^PSORXVW1
 S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="Patient Instructions:" I $O(^PSRX(RXN,"INS1",0)) D
 . F I=0:0 S I=$O(^PSRX(RXN,"INS1",I)) Q:'I  D
 .. S MIG=^PSRX(RXN,"INS1",I,0)
 .. D WORDWRAP^PSOUTLA2(MIG,.IEN,$NA(^TMP("PSOAL",$J)),21)
 K MIG,SG
 S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="         Indications: "_$P($G(^PSRX(RXN,"IND")),"^")  ;*441-IND
 I $P($G(^PS(55,PSODFN,"LAN")),"^") S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="  Other Pat. Instruc: "_$S($G(^PSRX(RXN,"INSS"))]"":^PSRX(RXN,"INSS"),1:"") D
 . S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="   Other Indications: "_$P($G(^PSRX(RXN,"IND")),"^",3)  ;*441-IND
 S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="                 SIG:"
 I '$P($G(^PSRX(RXN,"SIG")),"^",2) D  G PTST
 . S X=$P($G(^PSRX(RXN,"SIG")),"^") D SIGONE^PSOHELP S SIG=$E($G(INS1),2,250)
 . D WORDWRAP^PSOUTLA2(SIG,.IEN,$NA(^TMP("PSOAL",$J)),21)
 S SIGOK=1
 F I=0:0 S I=$O(^PSRX(RXN,"SIG1",I)) Q:'I  D
 . S MIG=^PSRX(RXN,"SIG1",I,0)
 . D WORDWRAP^PSOUTLA2(MIG,.IEN,$NA(^TMP("PSOAL",$J)),21)
 S SIGOK=1 K MIG,SG
PTST S $P(RN," ",25)=" ",PTST=$S($G(^PS(53,+$P(RX0,"^",3),0))]"":$P($G(^PS(53,+$P(RX0,"^",3),0)),"^"),1:""),IEN=IEN+1
 S ^TMP("PSOAL",$J,IEN,0)="      Patient Status: "_PTST_$E(RN,$L(PTST)+1,25)
 S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="          Issue Date: "_$E($P(RX0,"^",13),4,5)_"/"_$E($P(RX0,"^",13),6,7)_"/"_$E($P(RX0,"^",13),2,3)
 S ^TMP("PSOAL",$J,IEN,0)=^TMP("PSOAL",$J,IEN,0)_"                 Fill Date: "_$E($P(RX2,"^",2),4,5)_"/"_$E($P(RX2,"^",2),6,7)_"/"_$E($P(RX2,"^",2),2,3)
 S ROU=$S($P(RX0,"^",11)="W":"Window",$P(RX0,"^",11)="P":"Parked",1:"Mail")  ;441 PAPI
 S REFL=$P(RX0,"^",9),I=0 F  S I=$O(^PSRX(RXN,1,I)) Q:'I  S REFL=REFL-1,ROU=$S($P(^PSRX(RXN,1,I,0),"^",2)="W":"Window",$P(^PSRX(RXN,1,I,0),"^",2)="P":"Parked",1:"Mail")  ;441 PAPI
 S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="      Last Fill Date: "_$E($P(RX3,"^"),4,5)_"/"_$E($P(RX3,"^"),6,7)_"/"_$E($P(RX3,"^"),2,3)
 D CMOP^PSOORNE3 S DA=RXN
 S ^TMP("PSOAL",$J,IEN,0)=^TMP("PSOAL",$J,IEN,0)_" ("_ROU_$S($G(PSOCMOP)]"":", "_PSOCMOP,1:"")_")" K ROU,PSOCMOP
 S IEN=IEN+1 I $P(RX2,"^",15) S ^TMP("PSOAL",$J,IEN,0)="   Returned to Stock: "_$E($P(RX2,"^",15),4,5)_"/"_$E($P(RX2,"^",15),6,7)_"/"_$E($P(RX2,"^",15),2,3)
 E  S ^TMP("PSOAL",$J,IEN,0)="   Last Release Date: " D
 .S RLD=$S($P(RX2,"^",13):$E($P(RX2,"^",13),4,5)_"/"_$E($P(RX2,"^",13),6,7)_"/"_$E($P(RX2,"^",13),2,3),1:"")
 .I $O(^PSRX(RXN,1,0)) F I=0:0 S I=$O(^PSRX(RXN,1,I)) Q:'I  D
 ..I $P(^PSRX(RXN,1,I,0),"^",18) S RLD=$E($P(^(0),"^",18),4,5)_"/"_$E($P(^(0),"^",18),6,7)_"/"_$E($P(^(0),"^",18),2,3)
 .S ^TMP("PSOAL",$J,IEN,0)=^TMP("PSOAL",$J,IEN,0)_$S($G(RLD)]"":RLD,1:"        ")
 S ^TMP("PSOAL",$J,IEN,0)=^TMP("PSOAL",$J,IEN,0)_"                     Lot #: "_$P(RX2,"^",4)
 S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="             Expires: "_$E($P(RX2,"^",6),4,5)_"/"_$E($P(RX2,"^",6),6,7)_"/"_$E($P(RX2,"^",6),2,3)
 S ^TMP("PSOAL",$J,IEN,0)=^TMP("PSOAL",$J,IEN,0)_"                       MFG: "_$P($G(RX2),"^",8)
 S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="         Days Supply: "_$P(RX0,"^",8)_$S($L($P(RX0,"^",8))=1:" ",1:"")
 S ^TMP("PSOAL",$J,IEN,0)=^TMP("PSOAL",$J,IEN,0)_"                        QTY"_$S($P($G(^PSDRUG($P(RX0,"^",6),660)),"^",8)]"":" ("_$P($G(^PSDRUG($P(RX0,"^",6),660)),"^",8)_")",1:" (  )")_": "_$P(RX0,"^",7)
 I $P($G(^PSDRUG($P(RX0,"^",6),5)),"^")]"" D
 .S $P(RN," ",79)=" ",IEN=IEN+1
 .S ^TMP("PSOAL",$J,IEN,0)=$E(RN,$L("QTY DSP MSG: "_$P(^PSDRUG($P(RX0,"^",6),5),"^"))+1,79)_"QTY DSP MSG: "_$P(^PSDRUG($P(RX0,"^",6),5),"^") K RN
 S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="        # of Refills: "_$P(RX0,"^",9)_$S($L($P(RX0,"^",9))=1:" ",1:"")_"                       Remaining: "_REFL
 S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="            Provider: "_$S($D(^VA(200,$P(RX0,"^",4),0)):$P(^VA(200,$P(RX0,"^",4),0),"^"),1:"UNKNOWN")
 N DEAV S DEAV=+$P($G(^PSDRUG(+$P(RX0,"^",6),0)),"^",3) I DEAV>1,DEAV<6 D PRV K DEAV
 I $P(RX3,"^",3) S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="        Cos-Provider: "_$P(^VA(200,$P(RX3,"^",3),0),"^")
 S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="             Routing: "_$S($P(RX0,"^",11)="W":"Window",$P(RX0,"^",11)="P":"Parked",1:"Mail")  ;441 PAPI
 S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="              Copies: "_$S($P(RX0,"^",18):$P(RX0,"^",18),1:1)
 S:$P(RX0,"^",11)="W" IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="    Method of Pickup: "_$G(^PSRX(RXN,"MP"))
 S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="              Clinic: "_$S($D(^SC(+$P(RX0,"^",5),0)):$P(^SC($P(RX0,"^",5),0),"^"),1:"Not on File")
 S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="            Division: "_$P(^PS(59,$P(RX2,"^",9),0),"^")_" ("_$P(^(0),"^",6)_")"
 S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="          Pharmacist: "_$S($P(RX2,"^",3):$P(^VA(200,$P(RX2,"^",3),0),"^"),1:"")
 S:$P(RX2,"^",10)&('$G(PSOCOPY)) IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="         Verified By: "_$P(^VA(200,$P(RX2,"^",10),0),"^")
 S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="  Patient Counseling: "_$S($P($G(^PSRX(RXN,"PC")),"^"):"YES",1:"NO")_"                      "_$S($P($G(^PSRX(RXN,"PC")),"^"):"Was Counseling Understood: "_$S($P($G(^PSRX(RXN,"PC")),"^",2):"YES",1:"NO"),1:"")
 S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="             Remarks: "_$P(RX3,"^",7)
 D PC^PSORXVW1
 I $P($G(^PSRX(DA,"OR1")),"^",5) S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="         Finished By: "_$P(^VA(200,$P(^PSRX(DA,"OR1"),"^",5),0),"^")
 D ^PSORXVW1 S PSOAL=IEN K IEN,ACT,LBL,LOG
 I ST<12,$P(RX2,"^",6)<DT S ST=11
 S VALM("TITLE")="Rx View "_"("_$P("Error^Active^Non-Verified^Refill^Hold^Non-Verified^Suspended^^^^^Done^Expired^Discontinued^Deleted^Discontinued^Discontinued (Edit)^Provider Hold^","^",ST+2)_")"
 S:$P($G(^PSRX(DA,"PKI")),"^") VALMSG="Digitally Signed Order"
 S:$P($G(^PSRX(DA,"PKI")),"^",3) VALMSG="Digitally Signed eRx Order"
 ;
 ; pso*7*385 - esg - if being called by the BPSVRX routine, call HDR^PSOLMUTL to build the VALMHDR array and then Quit
 I $G(BPSVRX) D HDR^PSOLMUTL Q
 ;
 D EN^PSOORAL,KILL I $G(PS)="VIEW" G PSORXVW
 K:$G(PS)="VIEW" DA K PS
 Q
 ;
KILL K ^TMP("PSOAL",$J),PSOAL,IEN,^TMP("PSOHDR",$J) I $G(PS)="VIEW" K DA
 K ST,RFL,RFLL,RFL1,ST,II,J,N,PHYS,L1,DIRUT,PSDIV,PSEXDT,MED,M1,FFX,DTT,DAT,RX0,RX2,R3,RTN,SIG,STA,P1,PL,P0,Z0,Z1,EXDT,IFN,DIR,DUOUT,DTOUT,PSOELSE
 K LBL,I,RFDATE,%H,%I,RN,RFT,%,%I,DFN,GMRA,GMRAL,HDR,POERR,PTST,REFL,RF,RLD,RX3
 K RXN,RXOR,SG,VA,VADM,VAERR,VALMBCK,VAPA,X,DIC,REA,ZD,PSOHD,PSOBCK,PSODFN,QUIT
 Q
 ;
PRV       ;
 N DETN,DEA,LBL,VADD,SPC,ORN S ORN=$P(^PSRX(RXN,"OR1"),"^",2)
 S DEA=$$RXDEA^PSOUTIL(RXN)
 S LBL=$S(DEA["-":"  VA#: ",1:" DEA#: ")
 S $P(SPC," ",(28-$L(DEA)))=" "
 I $$DETOX^PSSOPKI($P(RX0,"^",6)) S DETN=$$RXDETOX^PSOUTIL(RXN)
 I (DEA'="")!($G(DETN)'="") S IEN=IEN+1,$E(^TMP("PSOAL",$J,IEN,0),16)=LBL_DEA_$S($G(DETN)]"":SPC_"DETOX#: "_$G(DETN),1:"")
 D PRVAD^PSOPKIV2
 I $G(VADD(1))]"" D
 .S IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="        Site Address: "_VADD(1)
 .S:VADD(2)]"" IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="                      "_VADD(2) S:VADD(3)]"" IEN=IEN+1,^TMP("PSOAL",$J,IEN,0)="                      "_VADD(3)
 Q
 ;
