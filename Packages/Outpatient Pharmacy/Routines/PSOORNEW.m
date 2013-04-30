PSOORNEW ;BIR/SAB - display orders from oerr ;6/19/06 3:53pm
 ;;7.0;OUTPATIENT PHARMACY;**11,23,27,32,55,46,71,90,94,106,131,133,143,237,222,258,206,225,251,386,390**;DEC 1997;Build 86
 ;^PS(50.7 -2223
 ;^PSDRUG -221
 ;^PS(50.606 -2174
 ;^PS(55 -2228
 ;EN1^ORCFLAG -3620
 ;External reference to $$DS^PSSDSAPI supported by DBIA 5424
 ;
 ;PSO*237 quit Finish if Today > Issue date + 365
 ;
DSPL I $G(PSODSPL) S VALMBCK="Q" K PSODSPL,PSOANSQD Q
 Q:'$D(PSOLMC)  K ^TMP("PSOPO",$J) S PSOLMC=PSOLMC+1
 I $D(CLOZPAT) S PSONEW("DAYS SUPPLY")=$S($G(PSONEW("DAYS SUPPLY")):PSONEW("DAYS SUPPLY"),1:7) G OI
 S PSONEW("DAYS SUPPLY")=$S($G(PSONEW("DAYS SUPPLY")):PSONEW("DAYS SUPPLY"),+$G(^PS(55,PSODFN,"PS"))&($P(^PS(53,+$G(^PS(55,PSODFN,"PS")),0),"^",3))&('$G(PSONEW("DAYS SUPPLY"))):$P(^PS(53,+$G(^PS(55,PSODFN,"PS")),0),"^",3),1:30)
OI I '$G(PSODRUG("OI")) D
 .S (OI,PSODRUG("OI"))=$P(OR0,"^",8),PSODRUG("OIN")=$P(^PS(50.7,$P(OR0,"^",8),0),"^"),OID=$P(OR0,"^",9)
 .I $P($G(OR0),"^",9) S POERR=1,DREN=$P(OR0,"^",9) D DRG^PSOORDRG K POERR
 I '$D(CLOZPAT) I $G(PSODRUG("DEA"))["A",$G(PSODRUG("DEA"))'["B"!($G(PSODRUG("DEA"))["F") S PSONEW("# OF REFILLS")=0
 I $D(CLOZPAT) S PSONEW("# OF REFILLS")=$S($D(PSONEW("# OF REFILLS")):PSONEW("# OF REFILLS"),$G(CLOZPAT)=2&($P(OR0,"^",11)>2):3,$G(CLOZPAT)&($P(OR0,"^",11)>1):1,1:0)
 S IEN=0 D OBX^PSOORFI1,DIN^PSONFI(PSODRUG("OI"),$S($G(PSODRUG("IEN")):PSODRUG("IEN"),1:""))
 D LMDISP^PSOORFI5(+$G(ORD)) ; Display Flag/Unflag Information
 S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)="*(1) Orderable Item: "_$P(^PS(50.7,PSODRUG("OI"),0),"^")_" "_$P(^PS(50.606,$P(^(0),"^",2),0),"^")_NFIO
 S:NFIO["<DIN>" NFIO=IEN_","_($L(^TMP("PSOPO",$J,IEN,0))-4)
 K LST I $G(PSODRUG("NAME"))]"" D  G PT
 .S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)=" (2)"_$S($D(^PSDRUG("AQ",PSODRUG("IEN"))):"      CMOP ",1:"           ")_"Drug: "_PSODRUG("NAME")_NFID
 .S:NFID["<DIN>" NFID=IEN_","_($L(^TMP("PSOPO",$J,IEN,0))-4)
 .I $P($G(^PSDRUG(PSODRUG("IEN"),0)),"^",10)]"" S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)="       Drug Message:" D DRGMSG
 S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)=" (2)           Drug: No Dispense Drug Selected"
PT D DOSE2^PSOORFI4
 S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)=" (4)   Pat Instruct:" D:$O(PSONEW("SIG",0)) INST^PSOORFI4
 S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)="  Provider Comments:" S TY=3 D INST^PSOORFI1
 S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)="       Instructions:" S TY=2 D INST^PSOORFI1
 K PSOELSE S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)="                SIG:"
 F I=0:0 S I=$O(SIG(I)) Q:'I  S SIG=SIG(I) D
 .F SG=1:1:$L(SIG) S:$L(^TMP("PSOPO",$J,IEN,0)_" "_$P(SIG," ",SG))>80 IEN=IEN+1,$P(^TMP("PSOPO",$J,IEN,0)," ",20)=" " S:$P(SIG," ",SG)'="" ^TMP("PSOPO",$J,IEN,0)=$G(^TMP("PSOPO",$J,IEN,0))_" "_$P(SIG," ",SG)
 S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)=" (5) Patient Status: "_$P($G(^PS(53,+PSONEW("PATIENT STATUS"),0)),"^")
 K PSOELSE I $G(PSONEW("ISSUE DATE"))']"" S PSOELSE=1 S IEN=IEN+1,(PSOID,Y)=$E($P(OR0,"^",6),1,7) X ^DD("DD") S PSONEW("ISSUE DATE")=Y,^TMP("PSOPO",$J,IEN,0)=" (4)     Issue Date: "_Y
 I '$G(PSOELSE) S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)=" (6)     Issue Date: "_PSONEW("ISSUE DATE")
 K PSOELSE I $G(PSORX("FILL DATE"))']"" S PSOELSE=1 D
 .S (Y,PSORX("FILL DATE"))=$S($E($P(OR0,"^",6),1,7)<DT:DT,1:$E($P(OR0,"^",6),1,7)) X ^DD("DD") S PSONEW("FILL DATE")=Y,^TMP("PSOPO",$J,IEN,0)=^TMP("PSOPO",$J,IEN,0)_"                  (5) Fill Date: "_Y
 I '$G(PSOELSE) S Y=PSORX("FILL DATE") X ^DD("DD") S PSORX("FILL DATE")=Y,^TMP("PSOPO",$J,IEN,0)=^TMP("PSOPO",$J,IEN,0)_"       (7) Fill Date: "_PSORX("FILL DATE")
 I $P(OR0,"^",18) S IEN=IEN+1,Y=$P(OR0,"^",18) X ^DD("DD") S $P(^TMP("PSOPO",$J,IEN,0)," ",39)="Effective Date: "_Y
 I $D(CLOZPAT) D ELIG^PSOORFI2 S:'$D(PSONEW("QTY")) PSONEW("QTY")=0
 S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)=" (8)    Days Supply: "_PSONEW("DAYS SUPPLY")
 S ^TMP("PSOPO",$J,IEN,0)=^TMP("PSOPO",$J,IEN,0)_"               (9)   QTY"_$S($P($G(^PSDRUG(+$G(PSODRUG("IEN")),660)),"^",8)]"":" ("_$P($G(^PSDRUG(+PSODRUG("IEN"),660)),"^",8)_")",1:" (  )")
 S ^TMP("PSOPO",$J,IEN,0)=^TMP("PSOPO",$J,IEN,0)_": "_$S($G(PSONEW("QTY"))]"":PSONEW("QTY"),1:$P(OR0,"^",10))
 I $P($G(^PSDRUG(+$G(PSODRUG("IEN")),5)),"^")]"" D
 .S $P(RN," ",79)=" ",IEN=IEN+1
 .S ^TMP("PSOPO",$J,IEN,0)=$E(RN,$L("QTY DSP MSG: "_$P(^PSDRUG(PSODRUG("IEN"),5),"^"))+1,79)_"QTY DSP MSG: "_$P(^PSDRUG(PSODRUG("IEN"),5),"^") K RN
 S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)="       Provider ordered "_+$P(OR0,"^",11)_" refills"
 D:$D(CLOZPAT) PQTY^PSOORFI4
 S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)="(10)   # of Refills: "_$S($G(PSONEW("# OF REFILLS"))]"":PSONEW("# OF REFILLS"),1:$P(OR0,"^",11))_"               (11)   Routing: "_$S($G(PSONEW("MAIL/WINDOW"))="M":"MAIL",1:"WINDOW")
 S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)="(12)         Clinic: "_PSORX("CLINIC")
 S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)="(13)       Provider: "_PSONEW("PROVIDER NAME")
 I $P($G(^VA(200,$S($G(PSONEW("PROVIDER")):PSONEW("PROVIDER"),1:$P(OR0,"^",5)),"PS")),"^",7)&($P($G(^("PS")),"^",8)) D
 .S IEN=IEN+1,PSONEW("COSIGNING PROVIDER")=$S($G(PSONEW("COSIGNING PROVIDER")):PSONEW("COSIGNING PROVIDER"),1:$P(^("PS"),"^",8))
 .S ^TMP("PSOPO",$J,IEN,0)="       Cos-Provider: "_$P(^VA(200,PSONEW("COSIGNING PROVIDER"),0),"^")
 S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)="(14)         Copies: "_$S($G(PSONEW("COPIES")):PSONEW("COPIES"),1:1)
 S PSONEW("REMARKS")=$S($G(PSONEW("REMARKS"))]"":PSONEW("REMARKS"),$P(OR0,"^",17)="C":"Administered in Clinic.",1:"")
 S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)="(15)        Remarks:"
 I $G(PSONEW("REMARKS"))]"" D
 .F SG=1:1:$L(PSONEW("REMARKS")) S:$L(^TMP("PSOPO",$J,IEN,0)_" "_$P(PSONEW("REMARKS")," ",SG))>80 IEN=IEN+1,$P(^TMP("PSOPO",$J,IEN,0)," ",20)=" " D
 ..S:$P(PSONEW("REMARKS")," ",SG)'="" ^TMP("PSOPO",$J,IEN,0)=$G(^TMP("PSOPO",$J,IEN,0))_" "_$P(PSONEW("REMARKS")," ",SG)
 I $G(PSOSIGFL)!(PSODRUG("OI")'=$P(OR0,"^",8)) S PSONEW("CLERK CODE")=DUZ,PSORX("CLERK CODE")=$P(^VA(200,DUZ,0),"^"),VALMSG="This change will create a new prescription!"
 S $P(RN," ",35)=" ",IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)="   Entry By: "_$P(^VA(200,PSONEW("CLERK CODE"),0),"^")_$E(RN,$L($P(^VA(200,PSONEW("CLERK CODE"),0),"^"))+1,35)
 S Y=$P(OR0,"^",12) X ^DD("DD") S ^TMP("PSOPO",$J,IEN,0)=^TMP("PSOPO",$J,IEN,0)_"Entry Date: "_$E($P(OR0,"^",12),4,5)_"/"_$E($P(OR0,"^",12),6,7)_"/"_$E($P(OR0,"^",12),2,3)_" "_$P(Y,"@",2) K RN
 I PSOLMC<2 D ^PSOLMPO1 S VALMBCK="Q",PSOLMC=0
 S:PSOLMC>1 VALMBCK="R"
 Q
ORCHK D PROVCOM^PSOORFI4,ORCHK^PSOORFI4
 Q
EDT D KV S DIR("A",1)="* Indicates which fields will create an new Order",DIR("A")="Select Field to Edit by number",DIR(0)="LO^1:15" D ^DIR Q:$D(DTOUT)!($D(DUOUT))
EDTSEL N LST,FLD,OUT D KV S OUT=0
 I +Y S LST=Y D FULL^VALM1 N PSODOSE M PSODOSE=PSONEW D  G DSPL
 .F FLD=1:1:$L(LST,",") Q:$P(LST,",",FLD)']""!(OUT)  D @(+$P(LST,",",FLD)) D:$P(LST,",",FLD)=8 REF D KV
 E  S VALMBCK="" Q
 Q
ACP ;
 N DIR,Y S Y=0
 I $G(ORD),+$P($G(^PS(52.41,+ORD,0)),"^",23)=1 D  Q:$D(DIRUT)!'Y  D EN1^ORCFLAG(+$P($G(^PS(52.41,ORD,0)),"^")) H 1
 . D FULL^VALM1
 . I '$D(^XUSEC("PSORPH",DUZ)) D  S Y=0 Q
 . . S DIR("A",1)="Order must be unflagged by a pharmacist before it can be finished."
 . . S DIR("A",2)=""
 . . S DIR(0)="E",DIR("A")="Enter RETURN to continue" W !,$C(7) D ^DIR
 . . S VALMBCK="R"
 . D KV
 . S DIR("A",1)="This Order is flagged. In order to finish it"
 . S DIR("A",2)="you must unflag it first."
 . S DIR("A",3)=""
 . S DIR(0)="Y",DIR("A")="Unflag Order",DIR("B")="NO"
 . W ! D ^DIR I $D(DIRUT)!'Y S VALMBCK="Q"
 I $G(ORD),+$P($G(^PS(52.41,+ORD,0)),"^",23)=1 Q
 ;
 I $D(CLOZPAT),+$G(PSONEW("QTY"))=0 S VALMSG="Unable to calculate the quantity, enter a quantity" G DSPL
 S (PSODIR("DFLG"),PSORX("DFLG"),PSODIR("QFLD"))=0,ACP=1 D ORCHK
 G:$G(PSONEW("QFLG")) DSPL
 I $G(PSODIR("DFLG"))!$G(PSORX("DFLG")) Q
 I $G(PSONEW("FLD"))!($G(PSODRUG("NAME"))']"")!('$O(SIG(0))) G DSPL
 I $G(PSODRUG("NAME"))]"",'$G(ORCHK)!($G(ORDRG)'=PSODRUG("NAME")) D  I $G(PSORX("DFLG")) D CLEAN^PSOVER1 G DSPL
 . D POST^PSODRG S:'$G(PSORX("DFLG")) ORCHK=1,ORDRG=PSODRUG("NAME")
 D:$$DS^PSSDSAPI&('$G(PSORX("DFLG"))) DOSCK^PSODOSUT("N") I $G(PSORX("DFLG")) D CLEAN^PSOVER1 G DSPL
 I '$D(PSONEW("RX #")) S PSOFROM="NEW",RTN=$S($P($G(PSOPAR),"^",7):"AUTO^PSONRXN",1:"MANUAL^PSONRXN") D @RTN Q:PSONEW("QFLG")  I '$P($G(PSOPAR),"^",7) S PSOX=PSONEW("RX #") D CHECK^PSONRXN
 D RXNCHK^PSOORNE1 I $G(PSONEW("QFLG")) S PSONEW("DFLG")=1 Q
 I DT>$$FMADD^XLFDT($P(OR0,"^",6),365) D EXPR^PSONEW2 G DSPL
 D STOP^PSONEW2,DISPLAY^PSONEW2,^PSONEWF
 I $G(PSOCPZ("DFLG")) W !!,"No action taken!",! K DIR S DIR(0)="E",DIR("?")="Press Return to continue",DIR("A")="Press Return to continue" D ^DIR,KV K PSOCPZ("DFLG"),DRET,PSOANSQD S VALMBCK="Q" Q
 ;
 K PSOCPZ("DFLG") D KV S DIR(0)="Y",DIR("A")="Are you sure you want to Accept this Order",DIR("B")="NO" D ^DIR I $D(DIRUT) D KV K DRET,PSOANSQ,PSOANSQD S VALMBCK="Q" Q
 D KV I 'Y K PSOANSQ G DSPL
 I $G(PSONEW("MAIL/WINDOW"))["W" D:$P($G(PSOPAR),"^",12)  S BINGCRT="Y",BINGRTE="W",PSORX("MAIL/WINDOW")="WINDOW" K RTN
 .W ! K DIR,DIRUT S DIR(0)="52,35O"
 .S:$G(PSORX("METHOD OF PICK-UP"))]"" DIR("B")=PSORX("METHOD OF PICK-UP") D ^DIR I $D(DIRUT) K DIR,DIRUT Q
 .S (PSONEW("METHOD OF PICK-UP"),PSORX("METHOD OF PICK-UP"))=Y K X,Y
 S PSONEW("POE")=1 D EN^PSON52(.PSONEW) G:$G(PSONEW("DFLG")) ABORT D DCORD^PSONEW2
 ;saves drug allergy order chks pso*7*390
 I +$G(^TMP("PSODAOC",$J,1,0)) D
 .I $G(PSORX("DFLG")) K ^TMP("PSODAOC",$J) Q
 .S RXN=PSONEW("IRXN"),PSODAOC="Finished CPRS Rx "_$S($P(^PSRX(RXN,"STA"),"^")=4:"NON-VERIFIED ",1:"")_"Order Acceptance_OP"
 .D DAOC^PSONEW
 D NPSOSD^PSOUTIL(.PSONEW),FULL^VALM1 K PSORX("MAIL/WINDOW")
 D EOJ^PSONEW
ABORT S VALMBCK="Q",DIR(0)="E",DIR("?")="Press Return to continue",DIR("A")="Press Return to Continue" D ^DIR,CLEAN^PSOVER1,KV
 Q
KV K DIRUT,DUOUT,DTOUT,DIR
 Q
REF D REF^PSOORFI4
 Q
1 N PSOBDR,PSOBDRG S PSOBDRG=1 D 1^PSOORNW2 Q  ;oi
 ;
4 D INS^PSOORNW2 Q
 ;
3 D DOSE^PSOORED4(.PSONEW) Q
 ;
6 D 4^PSOORNW2 Q  ;idt
 ;
7 D 5^PSOORNW2 Q  ;fdt
 ;
5 D 3^PSOORNW2 Q  ;pstat
 ;
13 D 12^PSOORNW2 Q  ;doc
 ;
12 D 11^PSOORNW2 Q  ;cli
 ;
2 N PSOCSIG I '$G(PSOBDRG) N PSOBDR,PSOBDRG S PSOBDRG=1
 D 2^PSOORNW1 Q:$G(PSOQFLG)  D EN^PSODIAG  ;drg/ICD
 I $G(PSOCSIG) K PSOCSIG G 3
 Q
 ;
9 D 8^PSOORNW2 Q  ;qty
 ;
8 D 7^PSOORNW2 Q  ;ds
 ;
10 D 9^PSOORNW2 Q  ;#rfs
 ;
14 D 13^PSOORNW2 Q  ;cop
 ;
11 D 10^PSOORNW2 Q  ;m/w
 ;
15 D 14^PSOORNW2 Q  ;rem
 ;
DRGMSG ;
 F SG=1:1:$L($P(^PSDRUG(PSODRUG("IEN"),0),"^",10)) S:$L(^TMP("PSOPO",$J,IEN,0)_" "_$P($P(^PSDRUG(PSODRUG("IEN"),0),"^",10)," ",SG))>80 IEN=IEN+1,$P(^TMP("PSOPO",$J,IEN,0)," ",20)=" " D
 .S:$P($P(^PSDRUG(PSODRUG("IEN"),0),"^",10)," ",SG)'="" ^TMP("PSOPO",$J,IEN,0)=$G(^TMP("PSOPO",$J,IEN,0))_" "_$P($P(^PSDRUG(PSODRUG("IEN"),0),"^",10)," ",SG)
 K SG
 Q
 ;
