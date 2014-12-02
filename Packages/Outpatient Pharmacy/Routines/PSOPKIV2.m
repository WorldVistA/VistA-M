PSOPKIV2 ;BIR/MHA - Dig Signed Pending order Auto-DC message ;08/17/11
 ;;7.0;OUTPATIENT PHARMACY;**391**;DEC 1997;Build 13
 ;
ADCMAIL ;
 N XX,QQ,ZZ S ZZ="PSOPODC"
 K ^TMP(ZZ,$J)
 S XMSUB=$P(^PS(59,PSOSITE,0),"^",6)_" - DIGITALLY SIGNED "_$S($P(OR0,"^",3)="RNW":"RE",1:"")_"NEW ORDER AUTO DISCONTINUED",XMDUZ=.5
 S LC=1,^TMP(ZZ,$J,LC)="",LC=LC+1
 S ^TMP(ZZ,$J,LC)="Following order was auto discontinued when finishing a pending order due to "_$P(PKIE,": ",2),LC=LC+1
 S ^TMP(ZZ,$J,LC)="",LC=LC+1
 S ^TMP(ZZ,$J,LC)="Division      : "_$P(^PS(59,PSOSITE,0),"^"),LC=LC+1
 S ^TMP(ZZ,$J,LC)="CPRS Order #  : "_$P(OR0,"^"),LC=LC+1
 S ^TMP(ZZ,$J,LC)="Issue Date    : "_PSONEW("ISSUE DATE"),LC=LC+1
 S ^TMP(ZZ,$J,LC)="Patient       : "_$P(^DPT(DFN,0),U)_" ("_$G(VA("BID"))_")",LC=LC+1
 ;S ^TMP(ZZ,$J,LC)="Address       : ",LC=LC+1
 D PATAD
 S ^TMP(ZZ,$J,LC)="Drug          : "_$G(PSODRUG("NAME")),LC=LC+1
 S QQ=PSONEW("DOSE",1) S:PSONEW("UNITS",1) QQ=QQ_"("_$P(^PS(50.607,PSONEW("UNITS",1),0),"^")_")"
 I $O(PSONEW("DOSE",1)) S XX=1 F  S XX=$O(PSONEW("DOSE",XX)) Q:'XX  D
 .S QQ=QQ_","_PSONEW("DOSE",XX)
 .S:PSONEW("UNITS",XX) QQ=QQ_"("_$P(^PS(50.607,PSONEW("UNITS",XX),0),"^")_")"
 S ^TMP(ZZ,$J,LC)="Dosage Ordered: "_QQ
 S LC=LC+1
 S ^TMP(ZZ,$J,LC)="Dosage Form   : "_PSONEW("NOUN",1),LC=LC+1
 S ^TMP(ZZ,$J,LC)="Quantity      : "_PSONEW("QTY")
 N TLC K TMP("ZZ") S XX=0,TLC=1,TMP("ZZ",1,0)="SIG           : "
 F  S XX=$O(^PS(52.41,ORD,"SIG",XX)) Q:'XX  D
 .S QQ=^PS(52.41,ORD,"SIG",XX,0)
 .D WORDWRAP^PSOUTLA2(QQ,.TLC,$NA(TMP("ZZ")),15)
 S XX=0 F  S XX=$O(TMP("ZZ",XX)) Q:'XX  S ^TMP(ZZ,$J,LC+1)=TMP("ZZ",XX,0)
 S LC=LC+1
 S ^TMP(ZZ,$J,LC)="Provider      : "_PSONEW("PROVIDER NAME"),LC=LC+1
 D PRV
 S LC=LC+1,^TMP(ZZ,$J,LC)=""
 I $G(PKIOR)=16 D MISMCH
 D MGRP
 S XMY(DUZ)="",XMTEXT="^TMP(ZZ,$J," N DIFROM D ^XMD K XMDUZ,XMTEXT,XMSUB
 K ^TMP(ZZ,$J)
 Q
 ;
MISMCH ;Reason for mis-match
 N XX,XY,XZ,X1,X2,XM,PSOARY,HASH
 S HASH=$$HSHCHK^PSOPKIV1(.PSOARY,ORD) I HASH'=-1 Q
 I $O(PSOARY(""))="" Q
 ;I $G(PSOARY)'=-1 Q
 S $P(XZ," ",80)="",LC=LC+1
 S ^TMP(ZZ,$J,LC)="Differences in CPRS and Pharmacy Pending File",LC=LC+1,^TMP(ZZ,$J,LC)=""
 S LC=LC+1,^TMP(ZZ,$J,LC)="Data Name          CPRS File                    Pharmacy Pending File"
 S LC=LC+1,^TMP(ZZ,$J,LC)="---------          ---------                    ---------------------"
 S LC=LC+1,XX=""
 F  S XX=$O(PSOARY(XX)) Q:XX=""  D
 .S XY=PSOARY(XX),LC=LC+1
 .S X1=$P(XY,"^"),X2=$P(XY,"^",2)
 .S XM=$S($L(X1)>$L(X2):X1,1:X2),STR=""
 .F I=0:1:$L(XM) Q:$E(XM,28*I,$L(XM))=""  S ^TMP(ZZ,$J,LC)=$S(I=0:$E(XX,1,18),1:"")_$$BLNK(19,$S(I=0:$E(XX,1,18),1:""))_$E(X1,(28*I),(28*I+28))_$$BLNK(29,$S($E(X1,(28*I),(28*I+28))]"":$E(X1,(28*I),(28*I+28)),1:""))_$E(X2,(28*I),(28*I+28)),LC=LC+1
 Q
 ;
BLNK(X,STR) ;blank spaces
 N XZ,SP
 Q:X="" ""
 S $P(XZ," ",80)="",SP=X-$L(STR)
 Q $E(XZ,1,SP)
MGRP ;
 N MDUZ S MDUZ=0 F  S MDUZ=$O(^XUSEC("PSDMGR",MDUZ)) Q:MDUZ'>0  S XMY(MDUZ)=""
 Q
 ;
PRV ;
 N DEA,VADD,PRV,DRG,ORN
 S PRV=$G(PSONEW("PROVIDER")),DRG=$G(PSODRUG("IEN")),ORN=$P(OR0,"^")
 I PRV="" Q
 S DEA=$$DEA^XUSER(0,PRV)
 S DEA=$S(DEA["-":"VA#           : ",1:"DEA#          : ")_DEA
 S ^TMP(ZZ,$J,LC)=DEA
 I $$DETOX^PSSOPKI(DRG),$$DETOX^XUSER(PRV)'="" S ^TMP(ZZ,$J,LC)=^TMP(ZZ,$J,LC)_"  DETOX#: "_$$DETOX^XUSER(PRV)
 D PRVAD
 I $G(VADD(1))]"" D
 .S LC=LC+1,^TMP(ZZ,$J,LC)="Site Address  : "_VADD(1)
 .S:VADD(2)'="" LC=LC+1,^TMP(ZZ,$J,LC)="                "_VADD(2)
 .S:VADD(3)'="" LC=LC+1,^TMP(ZZ,$J,LC)="                "_VADD(3)
 Q
 ;
PRVAD ;
 K ^TMP($J,"ORDEA")
 D ARCHIVE^ORDEA(ORN)
 I $D(^TMP($J,"ORDEA",ORN,3)) S VADD=^(3) D
 .S VADD(1)=$P(VADD,"^",2),VADD(2)=$P(VADD,"^",3),VADD(3)=$P(VADD,"^",4)_", "_$P(VADD,"^",5)_" "_$P($P(VADD,"^",6),"-")
 K ^TMP($J,"ORDEA")
 Q
 ;
PATAD ;
 D ^VADPT,ADD^VADPT
 N PSOBADR,PSOTEMP,PSOFORGN,I,T
 S PSOBADR=0,PSOTEMP=0,XX=0
 S PSOFORGN=$P($G(VAPA(25)),"^",2) I PSOFORGN'="",PSOFORGN'["UNITED STATES" S PSOFORGN=1
 I 'PSOFORGN S PSOBADR=$$BADADR^DGUTL3(DFN)
 I 'PSOFORGN,PSOBADR S PSOTEMP=$$CHKTEMP^PSOBAI(DFN)
 F I=1:1:3 I $G(VAPA(I))]"" D
 . S T="" I I=1,'PSOFORGN,PSOBADR,'$G(PSOTEMP) S T="** BAD ADDRESS INDICATED **"
 . I I=1,T="",PSOFORGN S T="*** FOREIGN ADDRESS ***"
 . I T="" I 'PSOFORGN I 'PSOBADR!$G(PSOTEMP) S T=$G(VAPA(I))
 . I I=1,T]"" S ^TMP(ZZ,$J,LC)="Address       : "_T,LC=LC+1
 . I I>1,T]"" S ^TMP(ZZ,$J,LC)="                "_T,LC=LC+1
 S I=+$G(VAPA(5)) I I S I=$S($D(^DIC(5,I,0)):$P(^(0),"^",2),1:"UNKNOWN")
 S T="" I 'PSOFORGN I 'PSOBADR!$G(PSOTEMP) S T=$G(VAPA(4))_", "_I_"  "_$S($G(VAPA(11)):$P(VAPA(11),"^",2),1:$G(VAPA(6)))
 S:T]"" ^TMP(ZZ,$J,LC)="                "_T,LC=LC+1
 Q
 ;
