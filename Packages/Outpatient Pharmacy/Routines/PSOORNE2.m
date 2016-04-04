PSOORNE2 ;BIR/SAB - Display finished orders from backdoor ;9/11/06 10:24am
 ;;7.0;OUTPATIENT PHARMACY;**11,21,23,27,32,37,46,84,103,117,131,146,156,210,148,222,238,264,281,289,251,379,391,313,282,427**;DEC 1997;Build 21
 ;^PSDRUG( -  221
 ;^YSCL(603.01 - 2697
 ;^PS(50.606 - 2174
 ;^PS(50.7 - 2223
 ;PSO*210 add call to WORDWRAP api
 ;$$DAWEXT^PSSDAWUT - 4708
 ;
SEL N ORN,ORD I '$G(PSOCNT) S VALMSG="This patient has no Prescriptions!" S VALMBCK="" Q
 D K1^PSOORNE6 S DIR("A")="Select Orders by number",DIR(0)="LO^1:"_PSOCNT D ^DIR I $D(DIRUT) D KV^PSOVER1 S VALMBCK="" Q
NEWSEL N ORN,ORD D K2^PSOORNE6
 ;*282 Correct Patient Instructions Copy
 I +Y S PSOOELSE=1,PSLST=Y K PSOREEDT F ORD=1:1:$L(PSLST,",") Q:$P(PSLST,",",ORD)']""  D  D UL1 K ^TMP("PSORXPO",$J),PSORXED,PSONEW,PSOPINS I $G(PSOQUIT) K PSOQUIT Q
 .S ORN=+$P(PSLST,",",ORD) D @$S(+PSOLST(ORN)=52:"ACT",1:"PEN^PSOORNE5")
 .K PSOREEDT,PSOSIGFL,PSONACT,SIGOK,PSOFDR,DRET,SIG,INS1
 K PRC,PHI,RTE I '$G(PSOOELSE) S VALMBCK=""
 K PSONACT,PSOOELSE,CLOZPAT D ^PSOBUILD,BLD^PSOORUT1,K3^PSOORNE6
 Q
 ;
ACT N REF,RPHKEY,PKIND K ^TMP("PSOAO",$J),PCOMX,PDA,PHI,PRC,ACOM,ANS,PSOFDR,CLOZPAT,ANQREM,DUR,DRET
 S RXN=$P(PSOLST(ORN),"^",2),RX0=^PSRX(RXN,0),RX2=$G(^(2)),RX3=$G(^(3)),ST=+$G(^("STA")),RXOR=$G(^("OR1")),POE=$G(^("POE")),EXDT=$S($P($G(^(2)),"^",6)>DT:1,1:0)
 I 'RX3 S RX3=$P(RX2,"^",2),$P(^PSRX(RXN,3),"^")=$P(RX2,"^",2)
 S PSODRG=+$P(RX0,"^",6),PSODRUG0=^PSDRUG(PSODRG,0),INDT=$G(^("I"))
 ;PSO*7*238;SET PSODRUG ARRAY ; PSOY KILLED AT END OF SET^PSODRG
 K PSODRUG
 S PSOY=PSODRG,PSOY(0)=PSODRUG0 D SET^PSODRG
 I 'RXOR,$P(^PSDRUG(PSODRG,2),"^") S $P(^PSRX(RXN,"OR1"),"^")=$P(^PSDRUG(PSODRG,2),"^"),RXOR=$P(^PSDRUG(PSODRG,2),"^")
 I $P($G(^PSDRUG(PSODRG,"CLOZ1")),"^")="PSOCLO1" D
 .S CLOZPAT=$O(^YSCL(603.01,"C",PSODFN,0)) Q:'CLOZPAT
 .;S CLOZPAT=$S($P(^YSCL(603.01,CLOZPAT,0),"^",3)="B":1,1:0)
 .S CLOZPAT=$P(^YSCL(603.01,CLOZPAT,0),"^",3)
 .S CLOZPAT=$S(CLOZPAT="M":2,CLOZPAT="B":1,1:0)
 S PKIND=$D(^PSRX(RXN,"PKI")),RPHKEY=$S('PKIND&($D(^XUSEC("PSORPH",DUZ))):1,PKIND&($D(^XUSEC("PSDRPH",DUZ))):1,1:0)
 I RPHKEY S RPH=1 D
 .S PSOACT=$S('ST&($G(INDT)]"")&(DT>$G(INDT)):"DHPLATC",ST=1!(ST=4):"DVE",ST=3:"DU",ST=5:"ELTD",ST=11:"ETDPCL",ST=12&EXDT:"EDCL",ST=12&'EXDT:"ECL",(ST=14!(ST=15))&'EXDT:"ECL",ST=13:"L",ST=16:"DL",1:"DHPEATCL")
 .D GET^PSOORNE5 S PSOACT=PSOACT_$S(ACTREN:"N",1:""),PSOACT=PSOACT_$S(ACTREF:"R",1:"")
 .I ST=5 S SURX=$O(^PS(52.5,"B",RXN,0)) I SURX,$P($G(^PS(52.5,SURX,0)),"^",7)="L" S PSOACT="TL" K SURX Q
 .S:ST'=12&('$D(^PS(50.7,+$P(RXOR,"^"),0))) PSOACT="DL",VALMSG="No Pharmacy Orderable Item !",PSONACT=1
 .S:ST=12&('$D(^PS(50.7,+$P(RXOR,"^"),0))) PSOACT="L",VALMSG="No Pharmacy Orderable Item !",PSONACT=1
 .S:ST=16 VALMSG="Rx Placed on HOLD by Provider."
 E  D
 .I ST=5 S SURX=$O(^PS(52.5,"B",RXN,0)) I SURX,$P($G(^PS(52.5,SURX,0)),"^",7)="L" S PSOACT="TL" Q
 .S PSOACT=$S(ST'<1&(ST'>4)!(ST>12):"",ST=12&EXDT&($P($G(PSOPAR),"^",2)):"CDPLT",1:"CPLT")
 .D GET^PSOORNE5 S PSOACT=PSOACT_$S(ACTREN:"N",1:""),PSOACT=PSOACT_$S(ACTREF:"R",1:"")
 .S:'$D(^PS(50.7,+$P(RXOR,"^"),0)) PSOACT="L",PSONACT=1,VALMSG="No Pharmacy Orderable Item !"
 ;K PSOLKFL D PSOL^PSSLOCK(RXN) I '$G(PSOMSG) K PSOMSG S PSOLKFL=1 S PSOACT="",VALMSG="This Order is being edited by another user."
 K PSOMSG S IEN=0,$P(RN," ",12)=" "
 D DIN^PSONFI(+RXOR,$P(RX0,"^",6))
 S IEN=IEN+1,^TMP("PSOAO",$J,IEN,0)=$S($P($G(^PSRX(RXN,"TPB")),"^"):"            TPB Rx #: ",1:"                Rx #: ")
 S ^TMP("PSOAO",$J,IEN,0)=^TMP("PSOAO",$J,IEN,0)_$P(RX0,"^")_$S($G(^PSRX(RXN,"IB")):"$",1:"")_$$ECME^PSOBPSUT(RXN)_$$TITRX^PSOUTL(RXN)_$E(RN,$L($P(RX0,"^")_$S($G(^PSRX(RXN,"IB")):"$",1:"")_$$ECME^PSOBPSUT(RXN)_$$TITRX^PSOUTL(RXN))+1,12)
 S IEN=IEN+1,^TMP("PSOAO",$J,IEN,0)=" ("_$S($P(PSOPAR,"^",3):1,1:"#")_")"_" *Orderable Item: "_$S($D(^PS(50.7,$P(+RXOR,"^"),0)):$P(^PS(50.7,$P(+RXOR,"^"),0),"^")_" "_$P(^PS(50.606,$P(^(0),"^",2),0),"^"),1:"")_NFIO
 S:NFIO["<DIN>" NFIO=IEN_","_($L(^TMP("PSOAO",$J,IEN,0))-4)
 S IEN=IEN+1,^TMP("PSOAO",$J,IEN,0)=" ("_$S($P(PSOPAR,"^",3):2,1:"#")_")"_$S($D(^PSDRUG("AQ",$P(RX0,"^",6))):"       CMOP ",1:"            ")_"Drug: "_$P(^PSDRUG($P(RX0,"^",6),0),"^")_NFID
 S:NFID["<DIN>" NFID=IEN_","_($L(^TMP("PSOAO",$J,IEN,0))-4)
 S IEN=IEN+1,^TMP("PSOAO",$J,IEN,0)=" "_$S('$P(PSOPAR,"^",3):"(2)",1:"   ")_"             NDC: "_$$GETNDC^PSONDCUT(RXN,0)
 S:$G(^PSRX(RXN,"TN"))]"" IEN=IEN+1,^TMP("PSOAO",$J,IEN,0)="          Trade Name: "_$G(^PSRX(RXN,"TN"))
 D DOSE^PSOORNE5
 S IEN=IEN+1,^TMP("PSOAO",$J,IEN,0)=" (4)Pat Instructions:" D INS^PSOORNE5
 D PC^PSOORNE5
 S IEN=IEN+1,^TMP("PSOAO",$J,IEN,0)="                 SIG:"
 I '$P($G(^PSRX(RXN,"SIG")),"^",2) S SIGOK=0 D  G PTST
 .S X=$P($G(^PSRX(RXN,"SIG")),"^") D SIGONE^PSOHELP S SIG=$E($G(INS1),2,250)
 .F SG=1:1:$L(SIG) S:$L(^TMP("PSOAO",$J,IEN,0)_" "_$P(SIG," ",SG))>80 IEN=IEN+1,$P(^TMP("PSOAO",$J,IEN,0)," ",21)=" " S:$P(SIG," ",SG)'="" ^TMP("PSOAO",$J,IEN,0)=$G(^TMP("PSOAO",$J,IEN,0))_" "_$P(SIG," ",SG)
 S SIGOK=1
 F I=0:0 S I=$O(^PSRX(RXN,"SIG1",I)) Q:'I  D                  ;PSO*210
 . S MIG=$P(^PSRX(RXN,"SIG1",I,0),"^")
 . D WORDWRAP^PSOUTLA2(MIG,.IEN,$NA(^TMP("PSOAO",$J)),21)
 S SIGOK=1 K MIG,SG
PTST S $P(RN," ",25)=" ",PTST=$S($G(^PS(53,+$P(RX0,"^",3),0))]"":$P($G(^PS(53,+$P(RX0,"^",3),0)),"^"),1:""),IEN=IEN+1
 S ^TMP("PSOAO",$J,IEN,0)=" (5)  Patient Status: "_PTST_$E(RN,$L(PTST)+1,25)
 S IEN=IEN+1,^TMP("PSOAO",$J,IEN,0)=" (6)      Issue Date: "_$E($P(RX0,"^",13),4,5)_"/"_$E($P(RX0,"^",13),6,7)_"/"_$E($P(RX0,"^",13),2,3)
 S ^TMP("PSOAO",$J,IEN,0)=^TMP("PSOAO",$J,IEN,0)_"               (7)  Fill Date: "_$E($P(RX2,"^",2),4,5)_"/"_$E($P(RX2,"^",2),6,7)_"/"_$E($P(RX2,"^",2),2,3)
 S ROU=$S($P(RX0,"^",11)="W":"Window",1:"Mail")
 S REFL=$P(RX0,"^",9),I=0 F  S I=$O(^PSRX(RXN,1,I)) Q:'I  S REFL=REFL-1,ROU=$S($P(^PSRX(RXN,1,I,0),"^",2)="W":"Window",1:"Mail")
 S IEN=IEN+1,^TMP("PSOAO",$J,IEN,0)="      Last Fill Date: "_$E($P(RX3,"^"),4,5)_"/"_$E($P(RX3,"^"),6,7)_"/"_$E($P(RX3,"^"),2,3)
 D CMOP^PSOORNE3
 S ^TMP("PSOAO",$J,IEN,0)=^TMP("PSOAO",$J,IEN,0)_" ("_ROU_$S($G(PSOCMOP)]"":", "_PSOCMOP,1:"")_")" K ROU,PSOCMOP
 ;*282 Correct return to stock/release display
 S IEN=IEN+1 D
 .S RLD=$S($P(RX2,"^",13):$E($P(RX2,"^",13),4,5)_"/"_$E($P(RX2,"^",13),6,7)_"/"_$E($P(RX2,"^",13),2,3),1:"")
 .I $O(^PSRX(RXN,1,0)) F I=0:0 S I=$O(^PSRX(RXN,1,I)) Q:'I  D
 ..I $P(^PSRX(RXN,1,I,0),"^",18) S RLD=$E($P(^(0),"^",18),4,5)_"/"_$E($P(^(0),"^",18),6,7)_"/"_$E($P(^(0),"^",18),2,3)
 .I $P(RX2,"^",15)&'$G(RLD) S ^TMP("PSOAO",$J,IEN,0)="   Returned to Stock: "_$E($P(RX2,"^",15),4,5)_"/"_$E($P(RX2,"^",15),6,7)_"/"_$E($P(RX2,"^",15),2,3)_$S($P(RX2,"^",14):" (Reprinted)",1:"")
 .E  S ^TMP("PSOAO",$J,IEN,0)="   Last Release Date: "_$S($G(RLD)]"":RLD,1:"        ")
 S ^TMP("PSOAO",$J,IEN,0)=^TMP("PSOAO",$J,IEN,0)_"               (8)      Lot #: "_$P($G(RX2),"^",4)
 S IEN=IEN+1,^TMP("PSOAO",$J,IEN,0)="             Expires: "_$E($P(RX2,"^",6),4,5)_"/"_$E($P(RX2,"^",6),6,7)_"/"_$E($P(RX2,"^",6),2,3)
 S ^TMP("PSOAO",$J,IEN,0)=^TMP("PSOAO",$J,IEN,0)_"                          MFG: "_$P($G(RX2),"^",8)
 S IEN=IEN+1,^TMP("PSOAO",$J,IEN,0)="(9)      Days Supply: "_$P(RX0,"^",8)_$S($L($P(RX0,"^",8))=1:" ",1:"")
 S ^TMP("PSOAO",$J,IEN,0)=^TMP("PSOAO",$J,IEN,0)_"                    (10)  QTY"_$S($P($G(^PSDRUG($P(RX0,"^",6),660)),"^",8)]"":" ("_$P($G(^PSDRUG($P(RX0,"^",6),660)),"^",8)_")",1:" (  )")_": "_$P(RX0,"^",7)
 I $P($G(^PSDRUG($P(RX0,"^",6),5)),"^")]"" D
 .S $P(RN," ",79)=" ",IEN=IEN+1
 .S ^TMP("PSOAO",$J,IEN,0)=$E(RN,$L("QTY DSP MSG: "_$P(^PSDRUG($P(RX0,"^",6),5),"^"))+1,79)_"QTY DSP MSG: "_$P(^PSDRUG($P(RX0,"^",6),5),"^") K RN
 S IEN=IEN+1,^TMP("PSOAO",$J,IEN,0)="(11)    # of Refills: "_$P(RX0,"^",9)_$S($L($P(RX0,"^",9))=1:" ",1:"")_"                          Remaining: "_REFL
 S IEN=IEN+1,^TMP("PSOAO",$J,IEN,0)="(12)        Provider: "_$S($D(^VA(200,$P(RX0,"^",4),0)):$P(^VA(200,$P(RX0,"^",4),0),"^"),1:"UNKNOWN")
 I +$P($G(^PSDRUG($P(RX0,"^",6),0)),"^",3)>1,+$P($G(^PSDRUG($P(RX0,"^",6),0)),"^",3)<6 D PRV^PSOORNE5
 I $P(RX3,"^",3) S IEN=IEN+1,^TMP("PSOAO",$J,IEN,0)="        Cos-Provider: "_$P(^VA(200,$S($G(PSORX("COSIGNING PROVIDER")):PSORX("COSIGNING PROVIDER"),1:$P(RX3,"^",3)),0),"^")
 S IEN=IEN+1,^TMP("PSOAO",$J,IEN,0)="(13)         Routing: "_$S($P(RX0,"^",11)="M":"MAIL",1:"WINDOW")_"                  (14)     Copies: "_$S($P(RX0,"^",18):$P(RX0,"^",18),1:1)
 S:$P(RX0,"^",11)="W"&($P(PSOPAR,"^",12)) IEN=IEN+1,^TMP("PSOAO",$J,IEN,0)="    Method of Pickup: "_$G(^PSRX(RXN,"MP"))
 S IEN=IEN+1,^TMP("PSOAO",$J,IEN,0)="(15)          Clinic: "_$S($D(^SC(+$P(RX0,"^",5),0)):$P(^SC($P(RX0,"^",5),0),"^"),1:"Not on File")
 S IEN=IEN+1,^TMP("PSOAO",$J,IEN,0)="(16)        Division: "_$S($G(^PS(59,+$P(RX2,"^",9),0))]"":$P(^PS(59,$P(RX2,"^",9),0),"^")_" ("_$P(^(0),"^",6)_")",1:"UNKNOWN")
 S IEN=IEN+1,^TMP("PSOAO",$J,IEN,0)="(17)      Pharmacist: "_$S($P(RX2,"^",3):$P(^VA(200,$P(RX2,"^",3),0),"^"),1:"")
 S IEN=IEN+1,^TMP("PSOAO",$J,IEN,0)="(18)         Remarks:" D RMK^PSOORNE3
 S IEN=IEN+1,^TMP("PSOAO",$J,IEN,0)="(19)      Counseling: "_$S($P($G(^PSRX(RXN,"PC")),"^"):"YES",1:"NO")_"                      "_$S($P($G(^PSRX(RXN,"PC")),"^"):"Was Counseling Understood: "_$S($P($G(^PSRX(RXN,"PC")),"^",2):"YES",1:"NO"),1:"")
 S:$O(^PSRX(RXN,1,0)) REF=1,IEN=IEN+1,^TMP("PSOAO",$J,IEN,0)="(20)     Refill Data"
 I $$STATUS^PSOBPSUT(RXN,0)'="" D
 . N DAW S IEN=IEN+1,DAW=$$GETDAW^PSODAWUT(RXN,0)
 . S ^TMP("PSOAO",$J,IEN,0)="(21)        DAW Code: "_DAW_" - "_$$DAWEXT^PSSDAWUT(DAW)
 D DISP^PSOORNE6
 I $G(PSOBEDT),PSOACT["E" S PSOACT="E"
 I $G(PSOBEDT),PSOACT'["E" S PSOACT=""
 Q:$G(PSORXED)!($G(COPY))!($G(UPMI))
 S:$G(PSOBEDT) (PSOEDIT,PSORXED)=1
RENERR S PSORERR=0 D ^PSOLMLST
 I PSORERR=1 S:$G(PSOBEDT) (PSOEDIT,PSORXED)=1 G RENERR
 K DRET,SIG
 Q
UL1 ;
 Q
