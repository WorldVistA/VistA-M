FBUCLET0 ;ALBISC/TET - UNAUTHORIZED CLAIM LETTER DQ (CONT.) ;12/3/2001
 ;;3.5;FEE BASIS;**32,38**;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
BATCHDQ ;tasked entry point from batch^fbuclet or option
 U IO S FBFF=0 S:'$D(FBUC) FBUC=$$FBUC^FBUCUTL2(1) S:'$D(FBCOPIES) FBCOPIES=$S($P(FBUC,U,4):$P(FBUC,U,4),1:1) D STANUM^FBUCUTL2 D:'$P($G(FBUC),U,8) STATADD^FBUCUTL2
 D DISPNP^FBUCUTL3 ;set array of letters which are waiting to be printed
 S FBAR=$G(^TMP("FBAR",$J,"FBAR")) I +FBAR D
 .N FBDA,FBEXP,FBI,FBORDER,FBP,FBPL,FBW S FBI=0 D PARSE^FBUCUTL4(FBAR)
 .F  S FBI=$O(^TMP("FBAR",$J,FBI)) Q:'FBI  D
 ..S FBDA=+$P($G(^TMP("FBAR",$J,FBI)),";")
 ..S FBUCA=$G(^FB583(FBDA,0))
 ..S FBORDER=$$ORDER^FBUCUTL(+$P(FBUCA,U,24))
 ..; if only one type of letter was requested for a batch print then
 ..; skip the claim if it's letter is not of that type
 ..I $G(FBLTRTYP),FBLTRTYP'=$$LETTER^FBUCUTL2(FBORDER,+$P(FBUCA,U,28)) Q
 ..; if disposition letter, approved or approved to stabilization then
 ..; skip if no payments on file or not all payments have been released
 ..I FBORDER>20,"^1^4^"[(U_$P(FBUCA,U,11)_U),'$$PAYST^FBUCUTL(FBDA) Q
 ..D PRINT^FBUCLET1
 K ^TMP("FBAR",$J) G END
REPRNTDQ ;tasked entry point from reprint^fbuclet
 ;fbnoup=1 if no update of expiration date, = 0 to update
 U IO S FBFF=0 D STANUM^FBUCUTL2 D:'$P($G(FBUC),U,8) STATADD^FBUCUTL2 I 'FBNOUP K FBNOUP
 D ARRAY:FBRANGE,STRING:'FBRANGE
 N FBI S FBI=0 F  S FBI=$O(^TMP("FBARY",$J,FBI)) Q:'FBI  D
 .S FBDA=+$P($G(^TMP("FBARY",$J,FBI)),";")
 .S FBUCA=$G(^FB583(FBDA,0))
 .S FBORDER=$$ORDER^FBUCUTL(+$P(FBUCA,U,24))
 .; if only one type of letter was requested for a batch reprint then
 .; skip the claim if it's letter is not of that type
 .I $G(FBLTRTYP),FBLTRTYP'=$$LETTER^FBUCUTL2(FBORDER,+$P(FBUCA,U,28)) Q
 .D PRINT^FBUCLET1
 K ^TMP("FBARY",$J) G END
AUTODQ ;tasked entry point from auto^fbuclet
 U IO S FBFF=0 S:'$D(FBUC) FBUC=$$FBUC^FBUCUTL2(1) D STANUM^FBUCUTL2 D:'$P(FBUC,U,8) STATADD^FBUCUTL2 D PRINT^FBUCLET1
 ;G END
END S ZTREQ="@" D ^%ZISC K ZTRTN,ZTSTOP,ZTIO,ZTDESC,FBADD,FBAR,FBARY,FBCOPIES,FBDA,FBFF,FBFR,FBNOUP,FBORDER,FBSADD,FBSTANUM,FBTO,FBUCA,FBUC,XRT0,XRTN,FBLTRTYP
 Q
STRING ;process string of ien's if not date range/called by reprntdq
 ;INPUT:  FBARY( array of ien of selected unauthorized claims
 ;OUTPUT: TMP(FBARY,$J array
 N FBDCT,FBA S (FBDCT,FBA)=0 F  S FBA=$O(FBARY(FBA)) Q:'FBA  D
 .N FBCT,FBI,FBDA S FBCT=($L(FBARY(FBA),",")) F FBI=1:1:FBCT S FBDCT=FBDCT+1,FBDA=$P(FBARY(FBA),",",FBI),^TMP("FBARY",$J,FBDCT)=+FBDA
 Q
ARRAY ;set array in tmp for date range
 ;called by reprntdq if date range selected
 ;INPUT VARIABLES:  FBFR = from date;  FBTO = to date
 N FBARY,FBDCT,FBDT,FBI,FBO,FBORDER,FBZ
 S (FBDCT,FBORDER)=0,FBO="" F  S FBORDER=$O(^FB(162.92,"AO",FBORDER)) Q:'FBORDER  I $$LETTER^FBUCUTL2(FBORDER) S FBO=FBO_U_FBORDER
 I FBO]"" S FBO=FBO_U
 S FBDT=FBFR F  S FBDT=$O(^FB583("ALP",FBDT)) Q:'FBDT!(FBDT>FBTO)  S FBI=0 F  S FBI=$O(^FB583("ALP",FBDT,FBI)) Q:'FBI  S FBZ=$G(^FB583(FBI,0)) I FBZ]"",FBO["^"_$$ORDER^FBUCUTL($P(FBZ,U,24))_"^" D
 .N FBARY S FBDCT=FBDCT+1
 .S FBARY=FBI_";"_$E($$VET^FBUCUTL($P(FBZ,U,4)),1,12)_U_$E($$VEN^FBUCUTL($P(FBZ,U,3)),1,12)_U_$E($$PROG^FBUCUTL($P(FBZ,U,2)),1,14)_U_$$DATX^FBAAUTL($P(FBZ,U))_U_$E($$PTR^FBUCUTL("^FB(162.92,",+$P(FBZ,U,24)),1,16)
 .S ^TMP("FBARY",$J,FBDCT)=FBARY
 S FBARY=FBDCT I FBDCT S FBARY=FBARY_";"_"5^20^35^52^63^",^TMP("FBARY",$J,"FBARY")=FBARY
 Q
