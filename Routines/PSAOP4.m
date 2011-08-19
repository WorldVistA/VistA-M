PSAOP4 ;BIR/LTL-Outpatient Dispensing (Single Drug) & (All Drugs) - CONT'D ;7/23/97
 ;;3.0; DRUG ACCOUNTABILITY/INVENTORY INTERFACE;**3**; 10/24/97
 ;This routine gathers outpatient dispensing and is called by PSAOP2.
 ;
 N PSADRUGN S PSADRUGN=0
 F  S PSADRUGN=$O(^TMP("PSA",$J,PSADRUGN)),PSADRUG=$O(^PSDRUG("B",PSADRUGN,0)) Q:'PSADRUGN  D
 .S PSA(2)=0 F  S PSA(2)=$O(^TMP("PSA",$J,PSADRUGN,PSA(2))) Q:'PSA(2)  D
 ..S PSA(3)=+^TMP("PSA",$J,PSADRUGN,PSA(2)) D TMP^PSAOP1
 ..K:$D(^XTMP("PSA",PSAS,PSADRUGN)) ^XTMP("PSA",PSAS,PSADRUGN)
QUIT K ^TMP("PSA",$J) S:$D(ZTQUEUED) ZTREQ="@"
 Q
 ;
AM ;Collects partial fills released & returned to stock.
 F  S PSAP=$O(^PSRX("AM",PSAP)) Q:'PSAP  F  S PSAP(1)=$O(^PSRX("AM",+PSAP,PSAP(1))) Q:'PSAP(1)  D:$P($G(^PSRX(+PSAP(1),0)),U,6)=PSADRUG&($P($G(^PSRX(+PSAP(1),2)),U,9)=PSAS)
 .S PSAP(2)="" F  S PSAP(2)=$O(^PSRX("AM",+PSAP,+PSAP(1),PSAP(2))) Q:'PSAP(2)  S $P(^TMP("PSA",$J,+PSADRUG,$E(PSAP,1,7)),U)=$P($G(^TMP("PSA",$J,+PSADRUG,$E(PSAP,1,7))),U)+$P($G(^PSRX(+PSAP(1),"P",+PSAP(2),0)),U,4) D
 ..S $P(^TMP("PSA",$J,+PSADRUG,$E(PSAP,1,7)),U,6)=PSAP,$P(^($E(PSAP,1,7)),U,7)=PSAP(1)
 F  S PSAN=$O(^PSRX("AN",PSAN)) Q:'PSAN  F  S PSAN(1)=$O(^PSRX("AN",+PSAN,PSAN(1))) Q:'PSAN(1)  D:$P($G(^PSRX(+PSAN(1),0)),U,6)=PSADRUG&($P($G(^PSRX(+PSAN(1),2)),U,0)=PSAS)
 .S PSAN(2)="" F  S PSAN(2)=$O(^PSRX("AN",+PSAN,+PSAN(1),PSAN(2))) Q:'PSAN(2)  S $P(^TMP("PSA",$J,+PSADRUG,$E(PSAN,1,7)),U)=$P($G(^($E(PSAN,1,7))),U)-$P($G(^PSRX(+PSAN(1),"P",+PSAN(2),0)),U,4) D
 ..S $P(^TMP("PSA",$J,+PSADRUG,$E(PSAN,1,7)),U,8)=PSAN,$P(^($E(PSAN,1,7)),U,9)=PSAN(1)
 Q
