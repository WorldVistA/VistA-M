ORY117 ;SLC/MKB -- post-install for OR*3*117;02:56 PM  8 May 2001
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**117**;Dec 17, 1997
 ;
PRE ; -- preinit
 S ^XTMP("OR117","DUZ")=$G(DUZ) ;save user, if queued
 Q
 ;
QO ; -- check Inpt Med QO's for old doses
 ;
 I $G(^XTMP("ORPSJ",0)) K ^XTMP("OR117") Q  ;already done
 N ORPSJ,ORNOW,ORPOI,ORPDD,ORPIN,ORPST,ORPID,ORPDN,ORQDLG,OR0,ORDIALOG,ORIT,ORDRUG,ORPSOI,ORP,ORI,ORXX,ORDOSE,DRUG,STR
 S ORPSJ=+$O(^DIC(9.4,"C","PSJ",0)),ORNOW=$$NOW^XLFDT
 S ORPOI=+$$PTR("ORDERABLE ITEM"),ORPDD=+$$PTR("DISPENSE DRUG")
 S ORPIN=+$$PTR("INSTRUCTIONS"),ORPST=+$$PTR("STRENGTH")
 S ORPID=+$$PTR("DOSE"),ORPDN=+$$PTR("DRUG NAME")
 S ORQDLG=+$G(^XTMP("OR117","DLG")) ;find where left off, if restarted
 F  S ORQDLG=+$O(^ORD(101.41,ORQDLG)) Q:ORQDLG'>0  S OR0=$G(^(ORQDLG,0)) D
 . Q:$P(OR0,U,4)'="Q"  Q:$P(OR0,U,7)'=ORPSJ  ;Inpt Pharmacy qo's only
 . K ORDIALOG,ORXX,^TMP("ORWORD",$J),ORDOSE
 . D GETQDLG Q:'$D(ORDIALOG)  Q:'$L($G(ORDIALOG(ORPIN,1)))
 . S ORDRUG=+$G(ORDIALOG(ORPDD,1)),ORIT=+$G(ORDIALOG(ORPOI,1))
 . S ORPSOI=+$P($G(^ORD(101.43,ORIT,0)),U,2)
 . D DOSE^PSSORUTL(.ORDOSE,ORPSOI,"U","")
 . S DRUG=$G(ORDOSE("DD",ORDRUG)),STR=$P(DRUG,U,5,6)
 . D DOSE I $G(ORDRUG),'$G(ORDOSE) D
 .. S STR=$TR(STR,"^") I STR'>0 S ORDIALOG(ORPDN,1)=$P(DRUG,U) Q
 .. I $P($G(^ORD(101.43,ORIT,0)),U)'[STR S ORDIALOG(ORPST,1)=STR
 . I $G(ORXX) D SAVE^ORCMEDT0 ;save responses if changed
 . S ^XTMP("OR117","DLG")=ORQDLG
 ;
 D BULLETIN
 K ^TMP("ORWORD",$J),^TMP("ORTXT",$J),^XTMP("OR117")
 Q
 ;
PTR(X) ; -- Return ptr to prompt OR GTX X
 Q +$O(^ORD(101.41,"AB","OR GTX "_X,0))
 ;
GETQDLG ; -- Get quick order definition, build ORDIALOG()
 S ORDIALOG=+$$DEFDLG^ORCD(ORQDLG) Q:'ORDIALOG
 D GETDLG^ORCD(ORDIALOG),GETORDER^ORCD("^ORD(101.41,"_ORQDLG_",6)")
 Q
 ;
DOSE ; -- Reformat outpt dose instance ORI, if possible/necessary
 Q:$D(ORDIALOG(ORPID,1))  ;already successfully converted
 N UD,CONJ,IDX,DOSE,MATCH,X,Y
 S UD=$G(ORDIALOG(ORPIN,1)),X=$$UP^XLFSTR(UD),MATCH=0
 S Y=$G(ORDOSE(1)) I Y D  ;check format for Total Doses
 . I X?1.N1." "1.U S X=$TR(X," "),ORXX=1 ;strip spaces
 . I Y?1"0."1.N.E,X?1"."1.N.E S X="0"_X,ORXX=1 ;leading zero's
 . I Y?1"."1.N.E,X?1"0."1.N.E S X=$E(X,2,99),ORXX=1
 ;S:UD="1/2" UD=.5 S:UD="1/3" UD=.33 S:UD="1/4" UD=.25 S:UD="3/4" UD=.75
 S CONJ=$P($G(ORDOSE("MISC")),U,3) S:$L(CONJ) CONJ=" "_CONJ
 S IDX="ORDOSE(0)" F  S IDX=$Q(@IDX) Q:IDX'?1"ORDOSE("1.N.",".N1")"  D
 . S DOSE=@IDX I $P(DOSE,U,5)=X D  Q
 .. I ORDRUG,$P(DOSE,U,6)'=ORDRUG Q  ;not a match
 .. S MATCH=MATCH+1,MATCH(MATCH)=$P(DOSE,U,1,6)
 . ;str ok?
D1 I MATCH=1 D  Q  ;Update responses
 . S Y=MATCH(1),X=$P(Y,U,5),ORXX=1
 . S:'Y X=X_CONJ_" "_$S($G(STR):$TR(STR,"^"),1:$P(DRUG,U))
 . S ORDIALOG(ORPIN,1)=X
 . S ORDIALOG(ORPDD,1)=$P(Y,U,6)
 . S ORDIALOG(ORPID,1)=$TR(Y,"^","&")_"&"_$TR($G(STR),"^","&")
 ; -- Else add qo to bulletin for review
 ;K ORDIALOG(ORPDD,1) ;clear old dispense drug?
 S:$G(ORXX) ORDIALOG(ORPIN,1)=X
 S ^XTMP("ORPSJ",ORQDLG)=""
 Q
 ;
BULLETIN ; -- Send bulletin containing qo's we couldn't convert
 N ORNOW,ORNOW90,XMSUB,XMTEXT,XMDUZ,XMY,XMZ,XMMG,I,J,ORD0,DIFROM
 S ORNOW=$$NOW^XLFDT,ORNOW90=$$FMADD^XLFDT(ORNOW,90)
 S XMDUZ="PATCH OR*3*117 CONVERSION",XMY(.5)="" S:$G(DUZ) XMY(DUZ)=""
 I '$G(DUZ) S I=$G(^XTMP("OR117","DUZ")) S:I XMY(I)=""
 S ^TMP("ORTXT",$J,1)="The quick order conversion of patch OR*3*117 has completed."
B1 S J=1 I $O(^XTMP("ORPSJ",0)) D
 . S ^XTMP("ORPSJ",0)=ORNOW90_U_ORNOW_"^CPRS/POE Inpt Dose conversion"
 . S J=J+1,^TMP("ORTXT",$J,J)="   "
 . S J=J+1,^TMP("ORTXT",$J,J)="The following Inpatient Pharmacy quick orders have instructions that"
 . S J=J+1,^TMP("ORTXT",$J,J)="were unable to be re-formatted:"
 . S I=0 F  S I=$O(^XTMP("ORPSJ",I)) Q:I'>0  D
 .. S ORD0=$G(^ORD(101.41,+I,0))
 .. S J=J+1,^TMP("ORTXT",$J,J)="   "_$P(ORD0,U)_"  ("_$P(ORD0,U,2)_")"
 S XMSUB="PATCH OR*3*117 CONVERSION COMPLETED"
 S XMTEXT="^TMP(""ORTXT"","_$J_"," D ^XMD
 Q
