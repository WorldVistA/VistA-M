ORY94A ;SLC/MKB -- post-install for OR*3*94 cont;07:47 AM  7 Jun 2001
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**94**;Dec 17, 1997
 ;
EN ; -- Shell to check delayed med orders for inactive OI's
 ;
 N ORODG,ORGRP,ORNOW,ORPOI,ORPDD,ORPIN,ORPFT,ORPST,ORPID,ORPAD,ORQDLG,OR0,ORDIALOG,ORIT,ORDRUG,ORPSOI,ORP,ORI,ORXX
 S ORODG=+$O(^ORD(100.98,"B","PHARMACY",0)) D DG^ORCHANG1(ORODG,"BILD",.ORGRP)
 S ORODG=+$O(^ORD(100.98,"B","O RX",0)),ORNOW=$$NOW^XLFDT
 S ORPOI=+$$PTR("ORDERABLE ITEM"),ORPDD=+$$PTR("DISPENSE DRUG")
 S ORPIN=+$$PTR("INSTRUCTIONS"),ORPFT=+$$PTR("FREE TEXT")
 S ORPST=+$$PTR("STRENGTH"),ORPID=+$$PTR("DOSE"),ORPAD=+$$PTR("ADDITIVE")
 ; -- delayed orders conversion only
 D QO3,BULLETIN
 Q
 ;
QO3 ; -- Update inactive OI's in delayed orders, if possible
 N ORVP,OREVT,ORIFN,OR0,OR3,ORTS,ORITM,ORPSITM,ORNEWOI
 S ORVP=$G(^XTMP("OR94","PAT")) ;find where left off, if restarted
 F  S ORVP=$O(^OR(100,"AEVNT",ORVP)) Q:ORVP=""  D
 . S OREVT="" F  S OREVT=$O(^OR(100,"AEVNT",ORVP,OREVT)) Q:OREVT=""  D
 .. S ORIFN=0 F  S ORIFN=$O(^OR(100,"AEVNT",ORVP,OREVT,ORIFN)) Q:ORIFN'>0  D
 ... S OR0=$G(^OR(100,ORIFN,0)),OR3=$G(^(3)),ORTS=+$P(OR0,U,13)
 ... Q:'$D(ORGRP(+$P(OR0,U,11)))  Q:$P(OR3,U,3)'=10  ;PS, still delayed
 ... S ORDRUG=$$VALUE^ORMPS2("DRUG"),ORI=0
 ... F  S ORI=$O(^OR(100,ORIFN,4.5,"ID","ORDERABLE",ORI)) Q:ORI'>0  D
 .... S ORITM=+$G(^OR(100,ORIFN,4.5,ORI,1)) Q:ORITM'>0
 .... S ORPSITM=+$P($G(^ORD(101.43,ORITM,0)),U,2)
 .... S ORNEWOI=$$EN^PSSQORD(ORPSITM,ORDRUG)
 .... I ORNEWOI>0,$P(ORNEWOI,U,2)!($P(ORNEWOI,U,3)>ORNOW) S ORNEWOI=+$O(^ORD(101.43,"ID",+ORNEWOI_";99PSP",0)) I ORNEWOI D 100 Q
 .... S ^XTMP("ORDER",ORVP,OREVT_";"_ORTS,ORIFN)="" ;unconverted
 . S ^XTMP("OR94","PAT")=ORVP
 Q
 ;
100 ; -- update orderable item ptr in order
 N I S ^OR(100,ORIFN,4.5,ORI,1)=ORNEWOI,ORXX=1
 S I=$O(^OR(100,ORIFN,.1,"B",ORITM,0)) Q:I'>0
 K ^OR(100,ORIFN,.1,"B",ORITM,I)
 S ^OR(100,ORIFN,.1,I,0)=ORNEWOI,^OR(100,ORIFN,.1,"B",ORNEWOI,I)=""
 Q
 ;
PTR(X) ; -- Return ptr to prompt OR GTX X
 Q +$O(^ORD(101.41,"AB","OR GTX "_X,0))
 ;
BULLETIN        ; -- Send bulletin containing qo's we couldn't convert
 N ORNOW,ORNOW90,XMSUB,XMTEXT,XMDUZ,XMY,XMZ,XMMG,I,J,K,L,X,TS,ORD0,DIFROM
 S ORNOW=$$NOW^XLFDT,ORNOW90=$$FMADD^XLFDT(ORNOW,90)
 S XMDUZ="PATCH OR*3*94 CONVERSION",XMY(.5)="" S:$G(DUZ) XMY(DUZ)=""
 I '$G(DUZ) S I=$G(^XTMP("OR94","DUZ")) S:I XMY(I)=""
 S ^TMP("ORTXT",$J,1)="The quick order conversion of patch OR*3*94 has completed."
B1 S J=1 I $O(^XTMP("ORIT",0)) D
 . S ^XTMP("ORIT",0)=ORNOW90_U_ORNOW_"^CPRS/POE Inactive Orderables conversion"
 . S J=J+1,^TMP("ORTXT",$J,J)="   "
 . S J=J+1,^TMP("ORTXT",$J,J)="The following quick orders have inactive orderable items that were"
 . S J=J+1,^TMP("ORTXT",$J,J)="unable to be automatically replaced with active ones:"
 . S I=0 F  S I=$O(^XTMP("ORIT",I)) Q:I'>0  D
 .. S ORD0=$G(^ORD(101.41,+I,0))
 .. S J=J+1,^TMP("ORTXT",$J,J)="   "_$P(ORD0,U)_"  ("_$P(ORD0,U,2)_")"
B2 I $O(^XTMP("ORPSO",0)) D
 . S ^XTMP("ORPSO",0)=ORNOW90_U_ORNOW_"^CPRS/POE Outpt Dose conversion"
 . S J=J+1,^TMP("ORTXT",$J,J)="   "
 . S J=J+1,^TMP("ORTXT",$J,J)="The following Outpatient Pharmacy quick orders have instructions that"
 . S J=J+1,^TMP("ORTXT",$J,J)="were unable to be re-formatted:"
 . S I=0 F  S I=$O(^XTMP("ORPSO",I)) Q:I'>0  D
 .. S ORD0=$G(^ORD(101.41,+I,0))
 .. S J=J+1,^TMP("ORTXT",$J,J)="   "_$P(ORD0,U)_"  ("_$P(ORD0,U,2)_")"
B3 I $O(^XTMP("ORDER",0)) D
 . S ^XTMP("ORDER",0)=ORNOW90_U_ORNOW_"^CPRS/POE Delayed Orders conversion"
 . S J=J+1,^TMP("ORTXT",$J,J)="   "
 . S J=J+1,^TMP("ORTXT",$J,J)="The following patients have delayed orders with inactive orderable items"
 . S J=J+1,^TMP("ORTXT",$J,J)="that were unable to be automatically replaced with active ones:"
 . S I="" F  S I=$O(^XTMP("ORDER",I)) Q:I=""  D  ;pt
 .. S K="" F  S K=$O(^XTMP("ORDER",I,K)) Q:K=""  D  ;event;TS
 ... S X=$P(K,";"),TS=+$P(K,";",2) I X="D" S X="Discharge"
 ... E  S X=$S(X="A":"Admission",X="T":"Transfer",1:"")_$S(TS:" to "_$P($G(^DIC(45.7,TS,0)),U),1:"")
 ... S J=J+1,^TMP("ORTXT",$J,J)="   "_$P($G(^DPT(+I,0)),U)_" - "_X_":"
 ... S L=0 F  S L=+$O(^XTMP("ORDER",I,K,L)) Q:L'>0  S J=J+1,^TMP("ORTXT",$J,J)="     "_$E($G(^OR(100,L,8,1,.1,1,0)),1,64)_"..."
 S XMSUB="PATCH OR*3*94 CONVERSION COMPLETED"
 S XMTEXT="^TMP(""ORTXT"","_$J_"," D ^XMD
 Q
