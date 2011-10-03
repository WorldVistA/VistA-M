PSOORNE3 ;ISC-BHAM/SAB - display pending orders from backdoor ;2/3/05 1:59pm
 ;;7.0;OUTPATIENT PHARMACY;**11,9,39,59,46,103,124,139,152,194**;DEC 1997
 ;Ext ref to ^SC (File #44) (DBIA 10040),^PSXOPUTL (DBIA 2200)
 ;^PS(50.606 (DBIA 2174),^PS(50.7 DBIA 2223),^PS(55,DBIA 2228)
 ;^PSDRUG (DBIA 221)
 K ^TMP("PSOPO",$J) S ORD=$P(PSOLST(ORN),"^",2) D ORD^PSOORFIN Q
 S PSODRUG("OI")=$P(OR0,"^",8),PSODRUG("OIN")=$P(^PS(50.7,$P(OR0,"^",8),0),"^")
 I $P($G(OR0),"^",9) S DREN=$P(OR0,"^",9) S POERR=1 D DRG^PSOORDRG K POERR ;D POST^PSODRG
 I '$P(OR0,"^",9) D DREN^PSOORNW2
 S PSONEW("# OF REFILLS")=$P(OR0,"^",11)
 S (Y,PSONEW("ISSUE DATE"))=$S($G(PSONEW("ISSUE DATE")):PSONEW("ISSUE DATE"),1:$E($P(OR0,"^",6),1,7)) X ^DD("DD")
 S PSONEW("CLERK CODE")=$P(OR0,"^",4),PSORX("CLERK CODE")=$P(^VA(200,$P(OR0,"^",4),0),"^")
 S (PSONEW("DFLG"),PSONEW("QFLG"))=0,PSODFN=$P(OR0,"^",2),PSONEW("QTY")=$P(OR0,"^",10),PSONEW("MAIL/WINDOW")=$S($P(OR0,"^",17)]"":$P(OR0,"^",17),1:"W")
 S:$G(PSONEW("CLINIC"))']"" PSONEW("CLINIC")=$P(OR0,"^",13)
 S:$G(PSORX("CLINIC"))']"" PSORX("CLINIC")=$S($D(^SC(+$P(OR0,"^",13),0)):$P(^SC($P(OR0,"^",13),0),"^"),1:"")
 S PSONEW("CLERK CODE")=$P(OR0,"^",4),PSONEW("PROVIDER")=$P(OR0,"^",5),PSONEW("PROVIDER NAME")=$P(^VA(200,$P(OR0,"^",5),0),"^")
 S PSONEW("PATIENT STATUS")=$S(+$G(^PS(55,PSODFN,"PS")):+$G(^PS(55,PSODFN,"PS")),1:"")
 S PSONEW("DAYS SUPPLY")=$S(+$G(^PS(55,PSODFN,"PS"))&($P(^PS(53,+$G(^PS(55,PSODFN,"PS")),0),"^",3)):$P(^PS(53,+$G(^PS(55,PSODFN,"PS")),0),"^",3),1:30)
 S IEN=0 D OBX^PSOORFI1,DIN^PSONFI(PSODRUG("OI"),$S($G(PSODRUG("IEN")):PSODRUG("IEN"),1:"")) ;Setup for N/F & DIN indicator
 S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)="* (1) Orderable Item: "_$P(^PS(50.7,PSODRUG("OI"),0),"^")_" "_$P(^PS(50.606,$P(^(0),"^",2),0),"^")_NFIO
 S:NFIO["DIN" NFIO=IEN_","_($L(^TMP("PSOPO",$J,IEN,0))-4)
 K LST S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)="  (2)           Drug: "_$S($G(PSODRUG("NAME"))]"":PSODRUG("NAME")_NFID,1:"No Dispense Drug Selected")
 S:NFID["DIN" NFID=IEN_","_($L(^TMP("PSOPO",$J,IEN,0))-4)
 S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)="  (3) Patient Status: "_$P($G(^PS(53,PSONEW("PATIENT STATUS"),0)),"^")
 S IEN=IEN+1,(PSOID,Y)=$E($P(OR0,"^",6),1,7) X ^DD("DD") S ^TMP("PSOPO",$J,IEN,0)="   (4)     Issue Date: "_Y
 S (Y,PSONEW("FILL DATE"))=$E($P(OR0,"^",6),1,7) X ^DD("DD") S PSONEW("FILL DATE")=Y,^TMP("PSOPO",$J,IEN,0)=^TMP("PSOPO",$J,IEN,0)_"                       (5) Fill Date: "_Y
 S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)="       Instructions:" S TY=3 D INST^PSOORFI1
 S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)="  (6)   Possible SIG: " D:$G(PSONEW("SIG"))']"" SIG^PSOORFI1 S:$G(PSONEW("SIG"))]"" IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)=$G(PSONEW("SIG")),IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)=PSOERR("SIG")
 S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)="  (7)    Days Supply: "_$S($G(PSONEW("DAYS SUPPLY")):PSONEW("DAYS SUPPLY"),+$G(^PS(55,PSODFN,"PS"))&($P(^PS(53,+$G(^PS(55,PSODFN,"PS")),0),"^",3)):$P(^PS(53,+$G(^PS(55,PSODFN,"PS")),0),"^",3),1:"")
 S ^TMP("PSOPO",$J,IEN,0)=^TMP("PSOPO",$J,IEN,0)_"                                 (8)     QTY: "_$P(OR0,"^",10)
 S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)="  (9)   # of Refills: "_$P(OR0,"^",11)_$E("  ",$L($P(OR0,"^",11))+1,2)_"                                (10) Routing: "_$S($G(PSONEW("MAIL/WINDOW"))="M":"MAIL",1:"WINDOW")
 S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)=" (11)         Clinic: "_PSORX("CLINIC")
 S $P(RN," ",32)=" ",IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)=" (12)       Provider: "_PSONEW("PROVIDER NAME")_$E(RN,$L(PSONEW("PROVIDER NAME"))+1,32)_"  (13)  Copies: "_$S($G(PSONEW("COPIES")):PSONEW("COPIES"),1:1) K RN
 I $P(^VA(200,$S($G(PSONEW("PROVIDER")):PSONEW("PROVIDER"),1:$P(OR0,"^",5)),"PS"),"^",7)&($P(^("PS"),"^",8)) S IEN=IEN+1,PSONEW("COSIGNING PROVIDER")=$P(^("PS"),"^",8) D
 .S ^TMP("PSOPO",$J,IEN,0)="        Cos-Provider: "_$P(^VA(200,+$G(PSONEW("COSIGNING PROVIDER")),0),"^")
 S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)="  Provider Comments:" S TY=2 D INST^PSOORFI1
 S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)=" (14)        Remarks: "
 I $G(PSONEW("REMARKS"))]"" D
 .F SG=1:1:$L(PSONEW("REMARKS")) S:$L(^TMP("PSOPO",$J,IEN,0)_" "_$P(PSONEW("REMARKS")," ",SG))>80 IEN=IEN+1,$P(^TMP("PSOPO",$J,IEN,0)," ",20)=" " D
 ..S:$P(PSONEW("REMARKS")," ",SG)'="" ^TMP("PSOPO",$J,IEN,0)=$G(^TMP("PSOPO",$J,IEN,0))_" "_$P(PSONEW("REMARKS")," ",SG)
 S $P(RN," ",35)=" ",IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)="   Entry By: "_$P(^VA(200,$P(OR0,"^",4),0),"^")_$E(RN,$L($P(^VA(200,$P(OR0,"^",4),0),"^"))+1,35)
 S Y=$P(OR0,"^",12) X ^DD("DD") S ^TMP("PSOPO",$J,IEN,0)=^TMP("PSOPO",$J,IEN,0)_"Entry Date: "_$E($P(OR0,"^",12),4,5)_"/"_$E($P(OR0,"^",12),6,7)_"/"_$E($P(OR0,"^",12),2,3)_" "_$P(Y,"@",2) K RN
 G ^PSOLMPO
 Q
DSPL ;backdoor
 K ^TMP("PSOPO",$J) D DIN^PSONFI(PSODRUG("OI"),$S($G(PSODRUG("IEN")):PSODRUG("IEN"),1:"")) ;NFI
 I $D(RX0),$D(PSODRUG("IEN")) D
 .I PSODRUG("IEN")=$P(RX0,"^",6)!($P(PSLST,",",2)) D RST
 S IEN=0,IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)="      Orderable Item: "_$P(^PS(50.7,PSODRUG("OI"),0),"^")_" "_$P(^PS(50.606,$P(^(0),"^",2),0),"^")_NFIO
 S:NFIO["DIN" NFIO=IEN_","_($L(^TMP("PSOPO",$J,IEN,0))-4)
 I $G(PSODRUG("NAME"))]"" D  G PST
 .S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)="  (1)"_$S($D(^PSDRUG("AQ",PSODRUG("IEN"))):"      CMOP ",1:"           ")_"Drug: "_PSODRUG("NAME")_NFID
 .S:NFID["DIN" NFID=IEN_","_($L(^TMP("PSOPO",$J,IEN,0))-4)
 S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)="  (1)           Drug: No Dispense Drug Selected"
PST S:$G(PSODRUG("TRADE NAME"))]"" IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)="          Trade Name: "_$S($G(PSODRUG("TRADE NAME"))]"":PSODRUG("TRADE NAME"),1:"")
 S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)="  (2) Patient Status: "_$P($G(^PS(53,PSONEW("PATIENT STATUS"),0)),"^")
 I $G(PSOID) S Y=PSOID X ^DD("DD") S PSONEW("ISSUE DATE")=Y
 S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)="  (3)     Issue Date: "_PSONEW("ISSUE DATE")
 S X2=PSONEW("DAYS SUPPLY")*(PSONEW("# OF REFILLS")+1)\1
 S X1=$S($G(PSOID):PSOID,1:DT)
 S X2=$S(PSONEW("DAYS SUPPLY")=X2:X2,+$G(PSOX("CS")):184,1:366)
 I X2<30 D
 . N % S %=$P($G(PSORX("PATIENT STATUS")),"^"),X2=30
 . S:%?.N %=$P($G(^PS(53,+%,0)),"^") I %["AUTH ABS" S X2=5
 D C^%DTC I PSONEW("FILL DATE")>X S PSONEW("FILL DATE")=PSONEW("ISSUE DATE")
 S Y=PSONEW("FILL DATE") X ^DD("DD") S ^TMP("PSOPO",$J,IEN,0)=^TMP("PSOPO",$J,IEN,0)_"             (4) Fill Date: "_Y
 D DOSE^PSOBKDED
 I $G(PSORXED("IRXN")),'$G(PSOSIGFL) S RXN=PSORXED("IRXN") D:'$G(COPY) INST1^PSOORNE5 K RXN
 S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)="                 SIG:"
 I $G(SIGOK),$O(SIG(0)) D SIG G DSP
 I $D(PSOCOPY),$G(PSONEW("SIG"))']"" D SIG G DSP
 I $G(PSOSIGFL),$G(PSONEW("SIG"))']"" D SIG G DSP
 D:$G(PSONEW("SIG"))]""
 .S X=PSONEW("SIG") D SIGONE^PSOHELP S SIG=$E($G(INS1),2,250)
 .F SG=1:1:$L(SIG) S:$L(^TMP("PSOPO",$J,IEN,0)_" "_$P(SIG," ",SG))>80 IEN=IEN+1,$P(^TMP("PSOPO",$J,IEN,0)," ",21)=" " S:$P(SIG," ",SG)'="" ^TMP("PSOPO",$J,IEN,0)=$G(^TMP("PSOPO",$J,IEN,0))_" "_$P(SIG," ",SG)
DSP S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)="  (7)    Days Supply: "_PSONEW("DAYS SUPPLY")_$S($L(PSONEW("DAYS SUPPLY"))=1:" ",1:"")
 I '$D(PSONEW("FLD")),$D(RX0) S PSONEW("QTY")=$P(RX0,"^",7)
 ;if sched PSONEW("FLD") not def. qty reset
 ;if qty PSONEW("FLD")=7, qty NOT reset
 S ^TMP("PSOPO",$J,IEN,0)=^TMP("PSOPO",$J,IEN,0)_"                     (8)   QTY"_$S($G(PSODRUG("UNIT"))]"":" ("_PSODRUG("UNIT")_")",1:" ( )")_": "_PSONEW("QTY")
 I $P($G(^PSDRUG(+$G(PSODRUG("IEN")),5)),"^")]"" D
 .S $P(RN," ",79)=" ",IEN=IEN+1
 .S ^TMP("PSOPO",$J,IEN,0)=$E(RN,$L("QTY DSP MSG: "_$P(^PSDRUG(PSODRUG("IEN"),5),"^"))+1,79)_"QTY DSP MSG: "_$P(^PSDRUG(PSODRUG("IEN"),5),"^") K RN
 S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)="  (9)   # of Refills: "_PSONEW("# OF REFILLS")_$S($L(PSONEW("# OF REFILLS"))=1:" ",1:"")_"                     (10)  Routing: "_$S($G(PSONEW("MAIL/WINDOW"))="M":"MAIL",1:"WINDOW")
 S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)=" (11)         Clinic: "_$S($G(PSONEW("CLINIC")):$P(^SC(PSONEW("CLINIC"),0),"^"),1:"")
 S $P(RN," ",31)=" ",IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)=" (12)       Provider: "_PSONEW("PROVIDER NAME")_$E(RN,$L(PSONEW("PROVIDER NAME"))+1,31)_"(13)   Copies: "_$S($G(PSONEW("COPIES")):PSONEW("COPIES"),1:1) K RN
 I $G(PSONEW("COSIGNING PROVIDER"))]"" S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)="        Cos-Provider: "_$P(^VA(200,PSONEW("COSIGNING PROVIDER"),0),"^")
 S IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)=" (14)        Remarks:"
 I $G(PSONEW("REMARKS"))]"" D
 .F SG=1:1:$L(PSONEW("REMARKS")) S:$L(^TMP("PSOPO",$J,IEN,0)_" "_$P(PSONEW("REMARKS")," ",SG))>80 IEN=IEN+1,$P(^TMP("PSOPO",$J,IEN,0)," ",21)=" " D
 ..S:$P(PSONEW("REMARKS")," ",SG)'="" ^TMP("PSOPO",$J,IEN,0)=$G(^TMP("PSOPO",$J,IEN,0))_" "_$P(PSONEW("REMARKS")," ",SG)
 I $G(PSORXED("IRXN")),'$G(PSOSIGFL) S RXN=PSORXED("IRXN") D:'$G(COPY) PC1^PSOORNE5 K RXN
 S $P(RN," ",35)=" ",IEN=IEN+1,^TMP("PSOPO",$J,IEN,0)="   Entry By: "_$P(^VA(200,DUZ,0),"^")_$E(RN,$L($P(^VA(200,DUZ,0),"^"))+1,35)
 D NOW^%DTC S PSONEW("LOGIN DATE")=% K %,X S Y=PSONEW("LOGIN DATE") X ^DD("DD")
 S ^TMP("PSOPO",$J,IEN,0)=^TMP("PSOPO",$J,IEN,0)_"Entry Date: "_$P(Y,"@")_" "_$P(Y,"@",2) K RN,PSOFDR
 S (VALMCNT,PSOPF)=IEN Q
SIG ;
 D SIG^PSOORNE6 Q
CMOP ;
 K PSXZ S X="PSXOPUTL" X ^%ZOSF("TEST") K X I  D
 .S DA=RXN D ^PSXOPUTL K DA,PSOCMOP
 .S PSOCMOP=$S($G(PSXZ(PSXZ("L")))=0!($G(PSXZ(PSXZ("L")))=2):"Transmitted",$G(PSXZ(PSXZ("L")))=1:"Released",$G(PSXZ(PSXZ("L")))=3:"Not Dispensed",1:"")
 .I $G(PSXZ(PSXZ("L")))=3 F LBL=0:0 S LBL=$O(^PSRX(RXN,"L",LBL)) Q:'LBL  I $P(^PSRX(RXN,"L",LBL,0),"^",2)=PSXZ("L"),'$P(^(0),"^",5),$P(^(0),"^",3)'["INTERACTION" S PSOCMOP="Local"
 .K PSXZ
 Q
RST ;
 S PSODRUG("IEN")=$P(RX0,"^",6),PSODRUG("OI")=$P(^PSDRUG(($P(RX0,"^",6)),2),"^")
 S PSODRUG("NAME")=$P(^PSDRUG(($P(RX0,"^",6)),0),"^")
 Q
RMK ;
 I $P(RX3,"^",7)]"" D
 .F SG=1:1:$L($P(RX3,"^",7)) S:$L(^TMP("PSOAO",$J,IEN,0)_" "_$P($P(RX3,"^",7)," ",SG))>80 IEN=IEN+1,$P(^TMP("PSOAO",$J,IEN,0)," ",21)=" " D
 ..S:$P($P(RX3,"^",7)," ",SG)'="" ^TMP("PSOAO",$J,IEN,0)=$G(^TMP("PSOAO",$J,IEN,0))_" "_$P($P(RX3,"^",7)," ",SG)
 Q
