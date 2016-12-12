ORDV06B ; slc/dcm - OE/RR Report Extracts ;7/14/14  16:34
 ;;3.0;ORDER ENTRY RESULTS REPORTING;**312,350**;Dec 17, 1997;Build 77
 ;Pharmacy Extracts for VistaWeb and ALL Medication Report
RXALL(ROOT,ORALPHA,OROMEGA,ORMAX,ORDBEG,ORDEND,OREXT) ;All Patient Meds
 ;Call to PSOORRL
 I $L($T(GCPR^OMGCOAS1)) D  ; Call if FHIE station 200
 . D GCPR^OMGCOAS1(DFN,"RXOP",ORDBEG,ORDEND,9999)
 ;
 N ORRXSTAT,GO
 Q:'$L(OREXT)
 S GO=$P(OREXT,";")_"^"_$P(OREXT,";",2)
 Q:'$L($T(@GO))
 S ORRXSTAT=""
 D GETMED
 Q
IN ;Setup and call to Pharmacy API
 ;LST(i)=
 ;LST(i) flags: "~" Start of new record, "/" Continuation line (concatination with Line feed CRLF)
 ;
 ;{          1     2      3     4       5     6       7       8        9      10     11           16
 ;{ Pieces: Typ^PharmID^Drug^InfRate^StopDt^RefRem^TotDose^UnitDose^OrderID^Status^LastFill^...^StartDt^  }
 ;If $P($P(X,"^",2),";",2)= "I" or "C" then Inpatient=TRUE
 ;If $P(X,"^",1)="~NV" then NonVAMed=TRUE and Instruct="Non-VA "_Instruct
 ;If $E($P(X,"^",1),1,2)="t\" then this is a comment, strip off the 1st character (t) and concatenate to other text
 ;Location  := $P($P(X,U,1),":",2);
 K ^TMP("PS",$J),^TMP("ORACT",$J),^TMP("ORPS",$J)
 N ORBEG,OREND,ERROR,ORCTX,ORVIEW
 S (ORBEG,OREND,ORCTX)=""
 S ORVIEW=1
 S ORBEG=$S($G(ORDBEG):ORDBEG,1:$$DT^ORWPS("T-50000")),OREND=$S(ORDEND<DT:ORDEND,1:$$DT^ORWPS("T+3000"))
 D OCL^PSOORRL(DFN,$$DT^ORWPS("T-50000"),$$DT^ORWPS("T+3000"),ORVIEW)
 N ITMP,FIELDS,INSTRUCT,COMMENTS,REASON,NVSDT,TYPE,ILST,J,SORTDT,STOPDT
 S ILST=0,ITMP=""
 F  S ITMP=$O(^TMP("PS",$J,ITMP)) Q:'ITMP  D
 . K INSTRUCT,COMMENTS,REASON,ORIFN
 . K ^TMP("ORACT",$J,"COMMENTS")
 . S COMMENTS="^TMP(""ORACT"",$J,""COMMENTS"")"
 . S (INSTRUCT,@COMMENTS,STOPDT)="",FIELDS=^TMP("PS",$J,ITMP,0)
 . S $P(FIELDS,"^",17)=$P($G(^TMP("PS",$J,ITMP,"P",0)),"^",2) ;Provider
 . S SORTDT=$S($L($P(FIELDS,"^",10)):$P(FIELDS,"^",10),1:$P(FIELDS,"^",15)) ;Date Priority: 1)Last Fill Date, 2)Issue/Start Date, 3)Order Date
 . I 'SORTDT D  ;If pharmacy API doesn't screen out data within selected date range, check CPRS OrderDate and screen out as appropriate
 .. K ^TMP("ORXPS",$J) M ^TMP("ORXPS",$J)=^TMP("PS",$J)
 .. D OEL^PSOORRL(DFN,$P(FIELDS,"^")) ;This API uses same ^TMP("PS" global
 .. S ORIFN=+$P(^TMP("PS",$J,0),"^",11),SORTDT=$P(^OR(100,ORIFN,0),"^",7),STOPDT=$P(^(0),"^",9)
 .. M ^TMP("PS",$J)=^TMP("ORXPS",$J) K ^TMP("ORXPS",$J)
 . S TYPE=$S($P($P(FIELDS,U),";",2)="O":"OP",1:"UD")
 . I $D(^TMP("PS",$J,ITMP,"CLINIC",0)) S TYPE="CP"
 . N LOC,LOCEX S (LOC,LOCEX)=""
 . I TYPE="CP" S LOC=$G(^TMP("PS",$J,ITMP,"CLINIC",0))
 . S:LOC LOCEX=$P($G(^SC(+LOC,0)),U)_":"_+LOC ;IMO
 . I TYPE="OP",$P(FIELDS,";")["N" S TYPE="NV" ;non-VA med
 . ;Next line excludes any data where (ExpirationDate, LastFill Date, StartDate or OrderDate) is outside of selected date range for everything except non-VAmeds.
 . I TYPE'="NV",SORTDT<ORBEG!(SORTDT>OREND),($P(FIELDS,"^",4)<ORBEG!($P(FIELDS,"^",4)>OREND)),($P(FIELDS,"^",10)<ORBEG!($P(FIELDS,"^",10)>OREND)),($P(FIELDS,"^",15)<ORBEG!($P(FIELDS,"^",15)>OREND)) Q
 . I $P(FIELDS,"^",9)["DISCONTINUED",(TYPE="OP"!(TYPE="NV")) D
 .. K ^TMP("ORXPS",$J) M ^TMP("ORXPS",$J)=^TMP("PS",$J)
 .. D OEL^PSOORRL(DFN,$P(FIELDS,"^")) ;This API uses same ^TMP("PS" global
 .. S ORIFN=+$P(^TMP("PS",$J,0),"^",11),STOPDT=$P(^OR(100,ORIFN,0),"^",9)
 .. M ^TMP("PS",$J)=^TMP("ORXPS",$J) K ^TMP("ORXPS",$J)
 .. I TYPE="NV",'$L($P(FIELDS,"^",4)) S $P(FIELDS,"^",4)=STOPDT
 .. I TYPE="OP" S $P(FIELDS,"^",4)=STOPDT
 . I $O(^TMP("PS",$J,ITMP,"A",0))>0 S TYPE="IV"
 . I $O(^TMP("PS",$J,ITMP,"B",0))>0 S TYPE="IV"
 . I (TYPE="UD")!(TYPE="CP") D UDINST^ORWPS(.INSTRUCT,ITMP)
 . I TYPE="OP" D OPINST^ORWPS(.INSTRUCT,ITMP)
 . I TYPE="IV" D IVINST^ORWPS(.INSTRUCT,ITMP)
 . I TYPE="NV" D NVINST^ORWPS(.INSTRUCT,ITMP),NVREASON^ORWPS(.REASON,.NVSDT,ITMP)
 . I (TYPE="UD")!(TYPE="IV")!(TYPE="NV")!(TYPE="CP") D SETMULT^ORWPS(COMMENTS,ITMP,"SIO")
 . M COMMENTS=@COMMENTS
 . I $D(COMMENTS(1)) S COMMENTS(1)="\"_COMMENTS(1)
 . I '$L($P(FIELDS,U,15)) S:TYPE="NV" $P(FIELDS,U,15)=$P($G(NVSDT),".") ;Set Start Date for non-VA Med (from file 100, which currently doesn't get set)
 . I LOC S ^TMP("ORPS",$J,$$NXT)="~CP:"_LOCEX_U_FIELDS
 . E  S ^TMP("ORPS",$J,$$NXT)="~"_TYPE_U_FIELDS
 . S J=0 F  S J=$O(INSTRUCT(J)) Q:'J  S ^TMP("ORPS",$J,$$NXT)=INSTRUCT(J)
 . S J=0 F  S J=$O(COMMENTS(J)) Q:'J  S ^TMP("ORPS",$J,$$NXT)="t"_COMMENTS(J)
 . S J=0 F  S J=$O(REASON(J)) Q:'J  S ^TMP("ORPS",$J,$$NXT)="t"_REASON(J)
 K ^TMP("PS",$J),^TMP("ORACT",$J)
 Q
NXT() ; increment ILST
 S ILST=ILST+1
 Q ILST
 ;
GETMED ;
 N J,ORIPS,ORIPSS,ORDRGIEN,ORDRG,ORRXNO,ORSTAT,ORQTY,OREXP,ORISSUE,ORLAST,ORREF,ORPRVD,ORCOST,ORSIG,ORT,ORX0
 N ECD,GMR,GMW,IX,PSOBEGIN,GMTSNDM,GMTS1,GMTS2,ORSITE,SITE,X,NONVA,INST,OLDORI,RT,X,X2,X3,ORII,ORKK
 S ORSITE=$$SITE^VASITE,ORSITE=$P(ORSITE,"^",2)_";"_$P(ORSITE,"^",3)
 ;Sorted by STATUS then by DRUG NAME
 K ^TMP("ORDATA",$J),^TMP("ORXPND",$J),^TMP("ORT",$J)
 I '$L($T(GCPR^OMGCOAS1)) D
 . K ^TMP("ORPS",$J)
 . D @GO
 S (OLDORI,ORIPS,ORT)=0
 F  S ORIPS=$O(^TMP("ORPS",$J,ORIPS)) Q:(ORIPS'>0)  S X=$G(^(ORIPS)) I X'="" D
 . I $E(X)="~" D  Q
 .. S OLDORI=ORIPS,ORT=0,X3=$S($L($P(X,"^",10)):$P(X,"^",10),1:"ZUNKNOWN"),X2=$S($L($P(X,"^",3)):$P(X,"^",3),1:"ZUNKNOWN")
 .. S ^TMP("ORT",$J,X3,X2,ORIPS)=X
 . I $L(X2),$L(X3),$E(X)="\" S ORT=ORT+1,^TMP("ORT",$J,X3,X2,OLDORI,ORT)=$E(X,2,9999)
 S ORII=""
 F  S ORII=$O(^TMP("ORT",$J,ORII)) Q:ORII=""  S ORKK="" F  S ORKK=$O(^TMP("ORT",$J,ORII,ORKK)) Q:ORKK=""  D
 . S ORIPS=0 F  S ORIPS=$O(^TMP("ORT",$J,ORII,ORKK,ORIPS)) Q:(ORIPS'>0)  S ORX0=^(ORIPS) D
 .. I $E(ORX0)="~" D  Q
 ... S ORIPSS=$S($L($P(ORX0,U,10)):$E($P(ORX0,U,10),1,10),1:"UNK")_"_"_$S($L($P(ORX0,U,3)):$P(ORX0,U,3),1:"UNK")_"_"_ORIPS
 ... S ^TMP("ORDATA",$J,ORIPSS,"WP",1)="1^"_ORSITE ;Station ID
 ... S ^TMP("ORDATA",$J,ORIPSS,"WP",2)="2^"_$P(ORX0,U,3) ;Medication Name
 ... S ^TMP("ORDATA",$J,ORIPSS,"WP",3)="3^"_$P(ORX0,U,10) ;Status
 ... S X=$P($P(ORX0,"^",2),";",2),^TMP("ORDATA",$J,ORIPSS,"WP",4)="4^"_$S(X="I":"IN",X="C":"IN",1:"OUT") ;In/OutPatient
 ... S X=$P(ORX0,"^"),^TMP("ORDATA",$J,ORIPSS,"WP",5)="5^"_$S(X="~NV":"NonVAMed",1:"RX") ;Type: RX or NonVA Med
 ... S ^TMP("ORDATA",$J,ORIPSS,"WP",6)="6^"_$$DATE^ORDVU($P(ORX0,U,16)) ;Start Date
 ... S ^TMP("ORDATA",$J,ORIPSS,"WP",7)="7^"_$$DATE^ORDVU($P(ORX0,U,5)) ;Stop Date
 ... S ^TMP("ORDATA",$J,ORIPSS,"WP",8)="8^"_$$DATE^ORDVU($P(ORX0,U,11)) ;Last Fill Date
 ... S ^TMP("ORDATA",$J,ORIPSS,"WP",9)="9^"_$P(ORX0,U,18) ;Provider
 ... S ^TMP("ORDATA",$J,ORIPSS,"WP",12)="12^[+]" ;flag for detail
 ... S X=$P(ORX0,"^",2) D DETAIL^ORWPS(.RT,DFN,X)
 ... S J=0 F  S J=$O(^TMP("ORXPND",$J,J)) Q:'J  S X=^(J,0),^TMP("ORDATA",$J,ORIPSS,"WP",11,J)="11^"_X ;Details from Order
 ... K ^TMP("ORXPND",$J)
 ... S ORT=0 F  S ORT=$O(^TMP("ORT",$J,ORII,ORKK,ORIPS,ORT)) Q:'ORT  S X=^(ORT),^TMP("ORDATA",$J,ORIPSS,"WP",10,ORT)="10^"_X ;Instructions
 K ^TMP("ORPS",$J),^TMP("ORXPND",$J),^TMP("ORT",$J)
 S ROOT=$NA(^TMP("ORDATA",$J))
 Q
