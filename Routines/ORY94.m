ORY94 ;SLC/MKB -- post-install for OR*3*94;02:56 PM  8 May 2001
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**94**;Dec 17, 1997
 ;
PRE ; -- preinit for patch 94
 I $O(^ORD(101.41,"AB","PS MEDS",0)) Q  ;not first install
 N ORNOW S ORNOW=$$NOW^XLFDT
 S ^XTMP("OR94",0)=$$FMADD^XLFDT(ORNOW,90)_U_ORNOW_"^OR*3*94 Conversion"
 S ^XTMP("OR94","DUZ")=DUZ,^("DLG")=0,^("PAT")=""
 K ^XTMP("ORPSO"),^XTMP("ORIT"),^XTMP("ORDER")
 Q
 ;
EN ; -- postinit for patch 94
 N NAME,DLG,ITM,PTR
 F NAME="PS MEDS","PSJ OR PAT OE","PSO OERR","PSO SUPPLY" D
 . S DLG=+$O(^ORD(101.41,"AB",NAME,0)) Q:DLG'>0
 . S PTR=+$$PTR("DRUG NAME") F ITM="ORDERABLE ITEM","STRENGTH" D
 .. S ITM=+$$PTR(ITM),ITM=+$O(^ORD(101.41,DLG,10,"D",ITM,0))
 .. I ITM,PTR S $P(^ORD(101.41,DLG,10,ITM,2),U,2)="@"_PTR
 D ID,DLGS
 Q
 ;
ID ; -- Look for OI's with duplicate ID's, inactivate extras
 N ORID,ORNOW,DA,DR,DIE S ORNOW=+$E($$NOW^XLFDT,1,12)
 S ORID="" F  S ORID=$O(^ORD(101.43,"ID",ORID)) Q:ORID=""  D
 . S DA=$O(^ORD(101.43,"ID",ORID,0)) Q:'$O(^(DA))  ;no dup's
 . F  S DA=$O(^ORD(101.43,"ID",ORID,DA)) Q:DA'>0  D
 .. I $G(^ORD(101.43,DA,.1)),^(.1)<ORNOW Q  ;already inactive
 .. S DIE="^ORD(101.43,",DR=".1////"_ORNOW D ^DIE
 Q
 ;
DLGS ; -- Look for local PS dialogs that will need to be updated
 N PSJ,PSO,ORPKG,ORDLG,OR0,ORZ,CNT
 S PSJ=+$O(^DIC(9.4,"C","PSJ",0)),PSO=+$O(^DIC(9.4,"C","PSO",0))
 S ORZ(1)="The order dialogs for medications, PSJ OR PAT OE and PSO OERR, have been"
 S ORZ(2)="modified in this patch; please review and compare the following local"
 S ORZ(3)="copies of these dialogs for changes:",CNT=3
 F ORPKG=PSJ,PSO S ORDLG=0 D
 . F  S ORDLG=+$O(^ORD(101.41,"APKG",ORPKG,ORDLG)) Q:ORDLG'>0  D
 .. S OR0=$G(^ORD(101.41,ORDLG,0)) Q:$P(OR0,U,4)'="D"  ;ck dialogs only
 .. I ORPKG=PSJ Q:$P(OR0,U)="PSJ OR PAT OE"
 .. I ORPKG=PSO Q:$P(OR0,U)="PSO OERR"  Q:$P(OR0,U)="PSO SUPPLY"
 .. S CNT=CNT+1,ORZ(CNT)=$J(ORDLG,7)_"  "_$P(OR0,U)
DLG1 I $O(ORZ(3)) D  ;send bulletin
 . N XMDUZ,XMY,I,XMSUB,XMTEXT,DIFROM
 . S XMDUZ="PATCH OR*3*94 POSTINIT",XMY(.5)="" S:$G(DUZ) XMY(DUZ)=""
 . I '$G(DUZ) S I=$G(^XTMP("OR94","DUZ")) S:I XMY(I)=""
 . S XMSUB="PATCH OR*3*94 POSTINIT COMPLETED"
 . S XMTEXT="ORZ(" D ^XMD
 . D BMES^XPDUTL("The order dialogs for medications have been modified in this patch;")
 . D MES^XPDUTL("a bulletin has been sent to the installer listing local copies that")
 . D MES^XPDUTL("may need to be reviewed and updated.")
 Q
 ;
POST ; -- postinit for MOAB
 D IVM,QO
 Q
 ;
IVM ; -- build S.IVM RX xref
 N ORNM,ORIT
 S ORNM="" F  S ORNM=$O(^ORD(101.43,"S.UD RX",ORNM)) Q:ORNM=""  D
 . S ORIT=0 F  S ORIT=+$O(^ORD(101.43,"S.UD RX",ORNM,ORIT)) Q:ORIT'>0  I '$G(^(ORIT)),$P($G(^ORD(101.43,ORIT,"PS")),U)=2 D SET^ORDD43("IVM RX",ORIT)
 Q
 ;
FIRST() ; -- first install of this patch?
 N Y S Y=$G(^XTMP("OR94","DUZ")) ;set in pre-init if first install
 Q Y
 ;
QO ; -- check med QO's for inactive orderables, old OP doses
 ;
 Q:'$$FIRST  ;conversion already run
 ;
 N ORODG,ORGRP,ORNOW,ORPOI,ORPDD,ORPIN,ORPFT,ORPST,ORPID,ORPAD,ORQDLG,OR0,ORDIALOG,ORIT,ORDRUG,ORPSOI,ORP,ORI,ORXX
 S ORODG=+$O(^ORD(100.98,"B","PHARMACY",0)) D DG^ORCHANG1(ORODG,"BILD",.ORGRP)
 S ORODG=+$O(^ORD(100.98,"B","O RX",0)),ORNOW=$$NOW^XLFDT
 S ORPOI=+$$PTR("ORDERABLE ITEM"),ORPDD=+$$PTR("DISPENSE DRUG")
 S ORPIN=+$$PTR("INSTRUCTIONS"),ORPFT=+$$PTR("FREE TEXT")
 S ORPST=+$$PTR("STRENGTH"),ORPID=+$$PTR("DOSE"),ORPAD=+$$PTR("ADDITIVE")
QO1 S ORQDLG=+$G(^XTMP("OR94","DLG")) ;find where left off, if restarted
 F  S ORQDLG=+$O(^ORD(101.41,ORQDLG)) Q:ORQDLG'>0  S OR0=$G(^(ORQDLG,0)) D
 . Q:$P(OR0,U,4)'="Q"  Q:'$D(ORGRP(+$P(OR0,U,5)))  ;pharmacy qo's only
 . K ORDIALOG,ORXX,^TMP("ORWORD",$J) D GETQDLG Q:'$D(ORDIALOG)
 . S ORDRUG=+$G(ORDIALOG(ORPDD,1))
 . ;
 . ; -- Update inactive OI's, if possible
 . F ORP=ORPOI,ORPAD S ORI=0 F  S ORI=$O(ORDIALOG(ORP,ORI)) Q:ORI'>0  D
 .. N ORITM,ORPSITM,ORNEWOI
 .. S ORITM=+$G(ORDIALOG(ORP,ORI)) Q:ORITM'>0
 .. Q:'$G(^ORD(101.43,ORITM,.1))!($G(^(.1))>ORNOW)  ;still active
 .. S ORPSITM=+$P($G(^ORD(101.43,ORITM,0)),U,2)
 .. S ORNEWOI=$$EN^PSSQORD(ORPSITM,ORDRUG)
 .. I ORNEWOI>0,$P(ORNEWOI,U,2)!($P(ORNEWOI,U,3)>ORNOW) S ORNEWOI=+$O(^ORD(101.43,"ID",+ORNEWOI_";99PSP",0)) S:ORNEWOI ORDIALOG(ORP,ORI)=ORNEWOI,ORXX=1 Q
 .. S ^XTMP("ORIT",ORQDLG)="" ;list unconverted qo's for bulletin
 . ;
QO2 . ; -- Update Outpt instructions, if possible
 . S ORIT=+$G(ORDIALOG(ORPOI,1)),ORPSOI=+$P($G(^ORD(101.43,ORIT,0)),U,2)
 . I $P(OR0,U,5)=ORODG D
 .. N ORDOSE,ORI,DRUG,STR D DOSE^PSSORUTL(.ORDOSE,ORPSOI,"O","")
 .. S DRUG=$G(ORDOSE("DD",ORDRUG)),STR=$P(DRUG,U,5,6) ;"" if no ORDRUG
 .. S ORI=0 F  S ORI=$O(ORDIALOG(ORPIN,ORI)) Q:ORI'>0  D DOSE
 .. S STR=$TR(STR,"^") I STR,$P($G(^ORD(101.43,ORIT,0)),U)'[STR S ORDIALOG(ORPST,1)=STR
 .. ;set Drug Name if needed too?
 . ;
 . ; -- Save changes to quick order
 . I $G(ORXX) D SAVE^ORCMEDT0 ;save responses if changed
 . S ^XTMP("OR94","DLG")=ORQDLG
 ;
QO3 ; -- Update inactive OI's in delayed orders, if possible
 D QO3^ORY94A
 D BULLETIN^ORY94A
 K ^TMP("ORWORD",$J),^TMP("ORTXT",$J),^XTMP("OR94")
 Q
 ;
PTR(X) ; -- Return ptr to prompt OR GTX X
 Q +$O(^ORD(101.41,"AB","OR GTX "_X,0))
 ;
GETQDLG ; -- Get quick order definition, build ORDIALOG()
 S ORDIALOG=+$$DEFDLG^ORCD(ORQDLG) Q:'ORDIALOG
 D GETDLG^ORCD(ORDIALOG),GETORDER^ORCD("^ORD(101.41,"_ORQDLG_",6)")
 ; -- set additional nodes for old Noun prompt
 N I,J,X
 S I=0 F  S I=$O(^ORD(101.41,ORQDLG,6,"D",ORPFT,I)) Q:I'>0  D
 . S J=+$P($G(^ORD(101.41,ORQDLG,6,I,0)),U,3),X=$G(^(1))
 . S:$D(ORDIALOG(ORPIN,J)) ORDIALOG(ORPFT,J)=X
 Q
 ;
DOSE ; -- Reformat outpt dose instance ORI, if possible/necessary
 Q:$D(ORDIALOG(ORPID,ORI))  ;already successfully converted
 N UD,UNT,CONJ,IDX,DOSE,MATCH,X,Y
 S UD=$G(ORDIALOG(ORPIN,ORI)),UNT=$G(ORDIALOG(ORPFT,ORI)),MATCH=0
 S:UD="1/2" UD=.5 S:UD="1/3" UD=.33 S:UD="1/4" UD=.25 S:UD="3/4" UD=.75
 I UNT?1.U1"(S)" S UNT=$P(UNT,"(")_$S(UD>1:"S",1:"") ;strip trailing (s)
 S CONJ=$P($G(ORDOSE("MISC")),U,3) S:$L(CONJ) CONJ=" "_CONJ
 S IDX="ORDOSE(0)" F  S IDX=$Q(@IDX) Q:IDX'?1"ORDOSE("1.N.",".N1")"  D
 . S DOSE=@IDX,X=UD_$S('$L(UNT):"",$P(DOSE,U,3):"^"_UNT,1:" "_UNT)
 . S X=$$UP^XLFSTR(X) I ($P(DOSE,U,3,4)=X)!($P(DOSE,U,5)=X) D
 .. I ORDRUG,$P(DOSE,U,6)'=ORDRUG Q  ;not a match
 .. S MATCH=MATCH+1,MATCH(MATCH)=$P(DOSE,U,1,6)
D1 K ORDIALOG(ORPFT,ORI) S ORXX=1
 I MATCH=1 D  Q  ;Update responses
 . S Y=MATCH(1),X=$P(Y,U,5)
 . S:'Y X=X_CONJ_" "_$S($G(STR):$TR(STR,"^"),1:$P(DRUG,U))
 . S ORDIALOG(ORPIN,ORI)=X
 . S ORDIALOG(ORPDD,ORI)=$P(Y,U,6)
 . S ORDIALOG(ORPID,ORI)=$TR(Y,"^","&")_"&"_$TR($G(STR),"^","&")
 ; -- Else save free text instructions, add qo to bulletin for review
 S ORDIALOG(ORPIN,ORI)=UD_$S($L(UNT):" "_UNT,1:"")
 ;K ORDIALOG(ORPDD,ORI) ;clear old dispense drug?
 S ^XTMP("ORPSO",ORQDLG)=""
 Q
 ;
BULLETIN ; -- Send bulletin containing qo's we couldn't convert
 D BULLETIN^ORY94A ;just in case
 Q
 ;
DLGSEND(ANAME)  ; -- Return true if the order dialog should be sent
 I ANAME="OR GTX AND/THEN" Q 1
 I ANAME="OR GTX DAYS SUPPLY" Q 1
 I ANAME="OR GTX DOSE" Q 1
 I ANAME="OR GTX DRUG NAME" Q 1
 I ANAME="OR GTX INSTRUCTIONS" Q 1
 I ANAME="OR GTX NOW" Q 1
 I ANAME="OR GTX ORDERABLE ITEM" Q 1
 I ANAME="OR GTX PATIENT INSTRUCTIONS" Q 1
 I ANAME="OR GTX SIG" Q 1
 I ANAME="OR GTX STRENGTH" Q 1
 I ANAME="PS MEDS" Q 1
 I ANAME="PSJ OR PAT OE" Q 1
 I ANAME="PSO OERR" Q 1
 I ANAME="PSO SUPPLY" Q 1
 Q 0
