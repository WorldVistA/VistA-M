FBPAID2 ;AISC - SERVER ALERT MESSAGES ;6/1/1999
 ;;3.5;FEE BASIS;**4**;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 S FBN=0,XQSTXT(FBN)=""
 ;process those payments that have the amount paid changed in FMS
 I $D(^TMP("FBERR",$J,4)) D
 .S FBN=FBN+1,XQSTXT(FBN)="  The 'AMOUNT PAID' has been altered on the Fee Payment Voucher Document",FBN=FBN+1,XQSTXT(FBN)="  in FMS for the following payments:",FBN=FBN+1,XQSTXT(FBN)=""
 .S I=0 F  S I=$O(^TMP("FBERR",$J,4,I)) Q:'I  S FBI=$P(^(I),U,2,99) D @$P(FBI,U)
 I FBN'>3 K XQSTXT S FBN=0,XQSTXT(FBN)=""
 I FBN>3 S FBN=FBN+1,XQSTXT(FBN)=" >>> For detailed payment information use the appropriate payment output. <<<",FBN=FBN+1,XQSTXT(FBN)=""
 ;process those payments that have been cancelled and require human int.
 S FBNH=FBN
 I $D(^TMP("FBERR",$J,5)) D
 .S FBN=FBN+1,XQSTXT(FBN)="  Payment has been cancelled for the following line items:",FBN=FBN+1,XQSTXT(FBN)=""
 .S I=0 F  S I=$O(^TMP("FBERR",$J,5,I)) Q:'I  S FBI=$P(^(I),U,2,99) D @$P(FBI,U)
 I FBN'=FBNH&(FBN-FBNH'>3) F I=FBNH:1:FBN K XQSTXT(I)
 I FBN-FBNH>3 S FBN=FBN+1,XQSTXT(FBN)=" >>> For detailed check information use the Check Display output. <<<",FBN=FBN+1,XQSTXT(FBN)=""
 D EXIT^FBMRASV2 K FBN,I,D,FBI,FBNH
 Q
3 ;write outpatient medical payment (162)
 S D(3)=+$P(FBI,U,2),D(2)=+$P(FBI,U,3),D(1)=+$P(FBI,U,4),D=+$P(FBI,U,5)
 D OUTP(+FBI,.D)
 K D,FBI
 Q
 ;
5 ;write pharmacy payments
 S D(1)=+$P(FBI,U,2),D=+$P(FBI,U,3)
 D OUTP(+FBI,.D)
 K D,FBI
 Q
 ;
9 ;write inpatient payments
 S D=+$P(FBI,U,2)
 D OUTP(+FBI,.D)
 K D,FBI
 Q
T ;write travel payments
 S D(1)=+$P(FBI,U,2),D=+$P(FBI,U,3)
 D OUTP($P(FBI,U),.D)
 K D,FBI
 Q
 Q
OUTP(X,Y) ;X=fee program
 ;y=ien array of payment record
 I X=3,$D(^FBAAC(D(3),1,D(2),1,D(1),1,D,0)) S D(0)=^(0),D(4)=$G(^(2)) I $P(D(4),U,3)]"" S FBN=FBN+1 D
 . S XQSTXT(FBN)="Check Number: "_$P(D(4),U,3)_$S($P(D(0),U,20)'="R":" to "_$E($$VEN^FBUCUTL(D(2)),1,30),1:"")_" for "_$E($$VET^FBUCUTL(D(3)),1,30)_" - "_$$SSN^FBAAUTL(D(3),1)
 . S FBN=FBN+1,XQSTXT(FBN)="         CPT: "_$$CPT^FBAAUTL4($P(D(0),U))_"  Date of Service: "_$$DATX^FBAAUTL($P($G(^FBAAC(D(3),1,D(2),1,D(1),0)),U))
 . S XQSTXT(FBN)=XQSTXT(FBN)_"  Invoice Number: "_$P($G(D(0)),U,16)
 ;
 I X=5,$D(^FBAA(162.1,D(1),"RX",D,0)) S D(0)=^(0),D(2)=^(2) I $P(D(2),U,10)]"" S FBN=FBN+1 D
 . S XQSTXT(FBN)="Check Number: "_$P(D(2),U,10)_$S($P(D(0),U,20)'="R":" to "_$E($$VEN^FBUCUTL(+$P(^FBAA(162.1,D(1),0),U,4)),1,30),1:"")_" for "_$E($$VET^FBUCUTL(+$P(D(0),U,5)),1,30)_" - "_$$SSN^FBAAUTL(+$P(D(0),U,5),1)
 . S FBN=FBN+1,XQSTXT(FBN)="         RX#: "_$P(D(0),U)_"  Date of Service: "_$$DATX^FBAAUTL($P(D(0),U,3))_"  Invoice Number: "_$P(^FBAA(162.1,+D(1),0),U)
 ;
 I X=9,$D(^FBAAI(D,0)) S D(0)=^(0),D(2)=$G(^(2)) I $P(D(2),U,4)]"" S FBN=FBN+1 D
 . S XQSTXT(FBN)="Check Number: "_$P(D(2),U,4)_$S($P(D(0),U,13)'="R":" to "_$E($$VEN^FBUCUTL(+$P(D(0),U,3)),1,30),1:"")_" for "_$E($$VET^FBUCUTL(+$P(D(0),U,4)),1,30)_" - "_$$SSN^FBAAUTL(+$P(D(0),U,4),1)
 . S FBN=FBN+1,XQSTXT(FBN)="   From Date: "_$$DATX^FBAAUTL($P(D(0),U,6))_"   To Date: "_$$DATX^FBAAUTL($P(D(0),U,7))_"  Invoice Number: "_$P(D(0),U)
 ;
 I X="T",$D(^FBAAC(D(1),3,D,0)) S D(0)=^(0) I $P(D(0),U,7)]"" S FBN=FBN+1 D
 . S XQSTXT(FBN)="Check Number: "_$P(D(0),U,7)_" to "_$E($$VET^FBUCUTL(+D(1)),1,30)_" - "_$$SSN^FBAAUTL(+D(1),1)_" for travel on"
 . S FBN=FBN+1,XQSTXT(FBN)="        Date: "_$$DATX^FBAAUTL($P(D(0),U))
 Q
