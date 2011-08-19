FBUCUTL5 ;ALBISC/TET - UTILITY CONTINUATION (SET DISPLAY) ;6/28/01
 ;;3.5;FEE BASIS;**32**;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
DISP7(IX,IEN,FBO,FB1725R) ;set array for display from file 162.7
 ;INPUT:  order no. of status (FBO), xref (IX) and either veteran or vendor ien (IEN) and optionally mill bill screening criteria (FB1725R)
 ;        FBO is either 0 for all status' for a patient/vendor or
 ;             in string format, delimited by "^" EG: ("10^50^")
 ;        FB1725 = (optional) mill bill screening criteria with value
 ;            "M" for just mill bill claims
 ;            "N" for just non-mill bill claims
 ;            "A" (or null) for all claims
 ;VARIABLE PL is set to the piece length of order string,
 ;             if fbo = 0 set to 2; if pl>1 status is displayed
 ;        SON = status order number
 ;        FBORDER = specific order from fbo string
 ;        FBMC = master claim ien with Primary or Secondary designation
 ;OUTPUT: FBAR( array => ien;name(vet or ven)^name(ven or vet)^fee program^date of claim^status (if status not passed - pl'>1)
 ;        FBAR = display count in array;piece positions for display (only if count)
 D:$D(XRTL) T0^%ZOSV ;start monitor
 K ^TMP("FBAR",$J) N FBAR,FBDA,FBDCT,FBMC,FBOMC,FBORDER,FBSP,FBSET,P,PL,SON,Z S FBDCT=0,FBO=$S('+$G(FBO):$$FBO^FBUCUTL4(),1:FBO),PL=($L(FBO,"^")-1)
 S FB1725R=$G(FB1725R) ; optional parameter
 S FBOMC=0,FBMC="" F  S FBMC=$O(^FB583(IX,IEN,FBMC)) Q:FBMC']""  D
 . S FBSET=$S(FBOMC'=+FBMC:1,1:0)
 . F P=1:1:PL S SON=$P(FBO,U,P) Q:SON']""  D
 . . S FBDA=0 F  S FBDA=$O(^FB583(IX,IEN,FBMC,SON,FBDA)) Q:'FBDA  I $$MBSCR(FB1725R,FBDA) D DA(FBDA,IX,.FBDCT,FBMC):FBSET,DA1:'FBSET S FBOMC=+FBMC
 D FBAR(FBDCT)
 S:$D(XRT0) XRTN=$T(+0) D:$D(XRT0) T1^%ZOSV ;stop monitor
 Q
DA(FBDA,IX,FBDCT,FBMC,Z) ;get ien in 162.7 and set array; also called from enter tag in fbuclink
 ;INPUT:  FBDA = internal entry number of unauthorized claim
 ;        IX = cross-reference, APMS is from fbuclink
 ;        FBDCT = counter
 ;        FBMC = master claim ien
 ;        Z = (optional) zero node of unauthorized claim
 S:$G(Z)']"" Z=$G(^FB583(FBDA,0)) I Z]"" D
 .S FBAR=FBDA_";"_$S(IX'="AVMS":($E($$VET^FBUCUTL($P(Z,U,4)),1,12)_U_$E($$VEN^FBUCUTL($P(Z,U,3)),1,12)),1:($E($$VEN^FBUCUTL($P(Z,U,3)),1,12)_U_$E($$VET^FBUCUTL($P(Z,U,4)),1,12)))
 .S FBAR=FBAR_U_$E($$PROG^FBUCUTL($P(Z,U,2)),1,12)_U_$$DATX^FBAAUTL($P(Z,U))_U_$E($P($$PTR^FBUCUTL("^FB(162.92,",$P(Z,U,24)),U),1,16)_U_"!"_U_"TREATMENT FROM: "_$$DATX^FBAAUTL(+$P(Z,U,5))_U_"TREATMENT TO: "_$$DATX^FBAAUTL(+$P(Z,U,6))
 .I $P(Z,U,20)'=FBDA,+$G(FBMC) S FBAR=FBAR_U_"PRIMARY CLAIM: "_$$DATX^FBAAUTL(+$P($G(^FB583(+FBMC,0)),U))
 .S FBDCT=FBDCT+1,^TMP("FBAR",$J,FBDCT)=FBAR
 Q
DA1 ;if same set, set node differently
 S Z=$G(^FB583(FBDA,0)) I Z]"" D
 .S:IX'="AVMS" FBAR=FBDA_";"_$S(FBMC["P":"",1:"  ")_$$PAD^FBUCUTL4(12,$E($$VEN^FBUCUTL($P(Z,U,3)),1,12)," ",2)
 .S:IX="AVMS" FBAR=FBDA_";"_$S(FBMC["P":"",1:"  ")_$$PAD^FBUCUTL4(12,$E($$VET^FBUCUTL($P(Z,U,4)),1,12)," ",2)
 .;S FBAR=FBDA_"; "_FBAR
 .S FBAR=FBAR_U_"  "_$$PAD^FBUCUTL4(12,$E($$PROG^FBUCUTL($P(Z,U,2)),1,12)," ",2)_"   "_$$DATX^FBAAUTL($P(Z,U))_"   "_$$PAD^FBUCUTL4(16,$E($P($G(^FB(162.92,$$STATUS^FBUCUTL(SON),0)),U),1,16)," ",2)
 .S FBAR=FBAR_"   <"_$$DATX^FBAAUTL(+$P($G(^FB583(+FBMC,0)),U))_">"
 .S FBDCT=FBDCT+1,^TMP("FBAR",$J,FBDCT)=FBAR
 Q
FBAR(FBDCT) ;set fbar node, also called from fbuclink
 ;INPUT:  FBDCT = number of entries in global array
 ;OUTPUT: FBAR = fbar node
 ;        sets tmp("fbar",$j,"fbar")=# entries;piece positions
 N E S:$G(FBDCT)']"" FBDCT=0 S FBAR=FBDCT I FBDCT S E="5^20^35^52^63^6^33^57^",FBAR=FBAR_";"_E
 S ^TMP("FBAR",$J,"FBAR")=FBAR
 Q
DISP8(FBDA) ;set array for display from file 162.8
 ;INPUT:  FBDA = ien of unauthorized claim (file 162.7)
 ;OUTPUT: FBAR( array => ien of file 162.8;.01 from file 162.93^
 K ^TMP("FBAR",$J) N FBAR,FBDCT,FBDT,FBI,Z
 S (FBDT,FBDCT)=0 F  S FBDT=$O(^FBAA(162.8,"ACD",FBDA,FBDT)) Q:'FBDT  D
 .S FBI=0 F  S FBI=$O(^FBAA(162.8,"ACD",FBDA,FBDT,FBI)) Q:'FBI  S Z=$G(^FBAA(162.8,+FBI,0)) I Z]"",'$P(Z,U,5) S FBDCT=FBDCT+1,FBAR=FBI_";"_$P($G(^FB(162.93,+$P(Z,U,3),0)),U) D
 ..I $P(Z,U,4)]"" S FBAR=FBAR_U_"!"_U_$P(Z,U,4)
 ..S ^TMP("FBAR",$J,FBDCT)=FBAR
 S FBAR=FBDCT I FBDCT S FBAR=FBAR_";5^6^"
 S ^TMP("FBAR",$J,"FBAR")=FBAR
 Q
DISP9(FN,IG) ;set array for display from files 162.9*
 ;INPUT:  FN = file number
 ;        IG = ignore screen (optional)
 ;OUTPUT: FBAR( array => ien;.01 from file^
 ;        FBAR = display count in array;piece positions for display (only if count)
 K ^TMP("FBAR",$J) N FBAR,FBDA,FBDCT,Z S IG=+$G(IG)
 S (FBDA,FBDCT)=0 F  S FBDA=$O(^FB(FN,FBDA)) Q:'FBDA  S Z=$G(^(FBDA,0)) I Z]"",IG!('IG&($P(Z,U,2))) S FBDCT=FBDCT+1,FBAR=FBDA_";"_$P(Z,U),^TMP("FBAR",$J,FBDCT)=FBAR
 S FBAR=FBDCT I FBDCT S FBAR=FBAR_";"_5_U
 S ^TMP("FBAR",$J,"FBAR")=FBAR
 Q
DISP92 ;display status, in order sequence
 ;OUTPUT: data in tmp("fbar",$j)
 K ^TMP("FBAR",$J) N FBAR,FBDCT,FBI,FBO,Z S (FBDCT,FBO)=0
 F  S FBO=$O(^FB(162.92,"AO",FBO)) Q:'FBO  S FBI=0,FBI=+$O(^FB(162.92,"AO",FBO,0)) I FBI S Z=$G(^FB(162.92,FBI,0)) I Z]"" S FBDCT=FBDCT+1,FBAR=FBI_";"_$P(Z,U),^TMP("FBAR",$J,FBDCT)=FBAR
 S FBAR=FBDCT I FBDCT S FBAR=FBAR_";5^"
 S ^TMP("FBAR",$J,"FBAR")=FBAR
 Q
MBSCR(FB1725R,FBDA) ; Mill Bill Screen
 ;INPUT: FB1725R - criteria code (M:just mill bill, N:just non-mill bill,
 ;                 A:all, null:all)
 ;       FBDA    - internal entry number of unauthorized claim
 ;RETURN: true if claim meets criteria or false if it does not
 N FBRET
 S FBRET=1 ; initial value
 I FB1725R="M",$P($G(^FB583(FBDA,0)),U,28)'=1 S FBRET=0
 I FB1725R="N",$P($G(^FB583(FBDA,0)),U,28)=1 S FBRET=0
 Q FBRET
