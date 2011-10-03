ORCHTAB2 ;SLC/MKB/REV-Add item to tab listing cont ;03/11/03 14:01
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**27,58,181**;Dec 17, 1997
GMRA ; -- allergies
 N ORY,ORI,ALLG,SEV,ID,SIGNS,J,ORIFN,DATA,X,ORTX
 D SUBHDR^ORCHTAB("Allergies/Adverse Reactions")
 D EN1^GMRAOR1(+ORVP,"ORY")
 I '$G(ORY) S X=$S($G(ORY)="":"No assessment available",1:"No known allergies") D LINE^ORCHTAB Q
 S ORI=0 F  S ORI=$O(ORY(ORI)) Q:ORI'>0  D
 . S ALLG=$P(ORY(ORI),U),SEV=$P(ORY(ORI),U,2),ID=$P(ORY(ORI),U,3)
 . S X=$S($L(SEV):$$LOWER^VALM1(SEV)_" reaction to ",1:"")_ALLG
 . S SIGNS="",J=0 F  S J=$O(ORY(ORI,"S",J)) Q:J'>0  S SIGNS=SIGNS_$S($L(SIGNS):", ",1:"")_$$LOW^XLFSTR(ORY(ORI,"S",J))
 . S:$L(SIGNS) X=X_" ("_SIGNS_")"
 . S:$L(X)'>ORMAX ORTX=1,ORTX(1)=X I $L(X)>ORMAX D TXT^ORCHTAB
 . S DATA(1)=$$DATE^ORCHTAB($P(^GMR(120.8,ID,0),U,4)),DATA=1,ORIFN="GMRA"
 . D ADD^ORCHTAB
 Q
 ;
GMRV ; -- Vitals
 N ORY,ORI,X,Y,DATA
 D SUBHDR^ORCHTAB("Recent Vitals"),FASTVIT^ORQQVI(.ORY,+ORVP)
 I '$O(ORY(0)) S X="No data available" D LINE^ORCHTAB Q
 S ORI=0 F  S ORI=$O(ORY(ORI)) Q:ORI'>0  D
 . S Y=$P(ORY(ORI),U,5)_" "_$P(ORY(ORI),U,6) S:$L(Y)'>1 Y=$P(ORY(ORI),U,3)
 . S X=$P(ORY(ORI),U,2),X=$S(X="BP":"B/P:   ",X="HT":"Ht:    ",X="P":"Pulse: ",X="R":"Resp:  ",X="T":"Temp:  ",X="WT":"Wt:    ",X="PN":"Pain:  ",1:$$LJ^XLFSTR(X_":",7))_Y
 . S DATA=$$DATETIME^ORCHTAB($P(ORY(ORI),U,4))
 . D LINE^ORCHTAB
 Q
 ;
IMM ; -- Immunizations
 N ORIMM,ORIDT,ORI,X,Y,DATA K ^TMP("PXI",$J)
 D SUBHDR^ORCHTAB("Recent Immunizations"),IMMUN^PXRHS03(+ORVP)
 S ORIMM=0 F  S ORIMM=$O(^TMP("PXI",$J,ORIMM)) Q:ORIMM=""  D
 . S ORIDT=$O(^TMP("PXI",$J,ORIMM,0)),ORI=$O(^(ORIDT,0)),Y=$G(^(ORI,0))
 . S X=ORIMM_$S($L($P(Y,U,6)):" ("_$P(Y,U,6)_")",1:"")
 . S DATA=$S('ORI:"",1:$$DATETIME^ORCHTAB($P(Y,U,3)))
 . D LINE^ORCHTAB
 Q
 ;
SC ; -- Service Connected data
 N DFN,VAEL,VASV,VAERR,X,DATA
 S DFN=+ORVP D 7^VADPT,SUBHDR^ORCHTAB("Eligibility")
 I VAEL(3) S X="Service Connected "_$P(VAEL(3),U,2)_"%"
 E  S X="Not Service Connected"
 D LINE^ORCHTAB
 I VASV(2) S X="Agent Orange Exposure" D LINE^ORCHTAB
 I VASV(3) S X="Radiation Exposure" D LINE^ORCHTAB
 I $P($G(^DPT(+ORVP,.322)),U,10) S X="Environmental Contaminants exposure" D LINE^ORCHTAB
 Q
 ;
CWAD ; -- postings
 N ORI,ORX,MSG,CNT,X,ID,DATA,ORIFN,ORTX K ^TMP("TIUPPCV",$J)
 D SUBHDR^ORCHTAB("Patient Postings")
 D ENCOVER^TIUPP3(+ORVP)
 S CNT=0,ORIFN="TIU"
 S ORI=0 F  S ORI=$O(^TMP("TIUPPCV",$J,ORI)) Q:ORI'>0  S ORX=$G(^(ORI)) D
 . S ID=$P(ORX,U) Q:'$L(ID)
 . S X=$P(ORX,U,3),DATA(1)=$$DATETIME^ORCHTAB($P(ORX,U,5)),DATA=1
 . S:$L(X)'>ORMAX ORTX=1,ORTX(1)=X I $L(X)>ORMAX D TXT^ORCHTAB
 . D ADD^ORCHTAB S CNT=CNT+1
 I 'CNT S LCNT=LCNT+1,^TMP("OR",$J,ORTAB,LCNT,0)="     "_$$PAD^ORCHTAB("<None>",40)_"|"
 K ^TMP("TIUPPCV",$J)
 Q
 ;
PROB ; -- problem
 N ID,DATA,X,ORTX,FIRST,ORJ,ORIFN
 S ID=$P(ORX,U),ORIFN=$P(ORX,U,2) ;problem ptr, status
 ;I $E(ORX,1,3)="   " S X=ORX D TXT^ORCHTAB Q  ;comment line only ??
 S X=$P(ORX,U,3)_$S($L($P(ORX,U,4)):" ("_$P(ORX,U,4)_")",1:"")
 S:$L(X)'>ORMAX ORTX=1,ORTX(1)=X I $L(X)>ORMAX D TXT^ORCHTAB
 S DATA(1)=$$PAD^ORCHTAB($$DATE^ORCHTAB($P(ORX,U,5)),10)_$$PAD^ORCHTAB($$DATE^ORCHTAB($P(ORX,U,6)),10)_$S($P(ORX,U,2)="I":"inactive",1:"active "_$P(ORX,U,9)),DATA=1
 I COMM,$O(ORY(ORI,0)) S ORJ=0 F  S ORJ=$O(ORY(ORI,ORJ)) Q:ORJ'>0  S X=" "_ORY(ORI,ORJ) I $L(X)>1 S ORTX=ORTX+1,ORTX(ORTX)="" D TXT^ORCHTAB ;add comments
 S FIRST=LCNT+1 D ADD^ORCHTAB
 I $L($P(ORX,U,10)) S $E(^TMP("OR",$J,ORTAB,FIRST,0),5)=$P(ORX,U,10)  ; unverified flag    ($)
 ; CSV change - check for active code, for active problem list only
 ; Inactive code flag (#) takes precedence and replaces unverified flag ($)
 I $P(ORX,U,2)="A",'$$CODESTS^GMPLX(ID,DT) S $E(^TMP("OR",$J,ORTAB,FIRST,0),5)="#"
 Q
 ;
NOTE ; -- progress note
 N ID,DATA,X,ORTX
 S DATA(1)=$$PAD^ORCHTAB($$DATETIME^ORCHTAB($P(ORX,U,3)),16)_$$PAD^ORCHTAB($$LNAMEF^ORCHTAB(+$P(ORX,U,5)),12)_$E($P(ORX,U,7),1,5),DATA=1
 S ID=$P(ORX,U),X=$P(ORX,U,2)
 S:$L(X)'>ORMAX ORTX=1,ORTX(1)=X I $L(X)>ORMAX D TXT^ORCHTAB
 I SUBJ,$L($P(ORX,U,12)) S X=" "_$P(ORX,U,12),ORTX=ORTX+1,ORTX(ORTX)="" D TXT^ORCHTAB ;add note subject
 D ADD^ORCHTAB
 Q
 ;
SUMM ; -- discharge summary
 N ID,DATA,ORTX
 S DATA(1)=$$DATE^ORCHTAB($P(ORX,U,3))_"     "_$$PAD^ORCHTAB($$LNAMEF^ORCHTAB(+$P(ORX,U,5)),15)_$E($P(ORX,U,7),1,5)_$P($P(ORX,U,8)," ",2)_"  "_$P($P(ORX,U,9)," ",2)
 S ID=$P(ORX,U),ORTX=1,ORTX(1)=$P(ORX,U,2),DATA=1
 D ADD^ORCHTAB
 Q
 ;
INITIALS(USER) ; -- Return initials of USER
 N X,Y S X=$G(^VA(200,+$G(USER),0)),Y=$P(X,U,2)
 S:'$L(Y) Y=" x "
 Q Y
