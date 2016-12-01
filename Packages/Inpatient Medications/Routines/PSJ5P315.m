PSJ5P315 ;BIRMINGHAM/GN/DRP-Diagnostic Report only, does not update ;9/25/15 10:03am
 ;;5.0;INPATIENT MEDICATIONS ;**315**;16 DEC 97;Build 73
 ;
 ; Reference to ^PS(50.7 is supported by DBIA# 2180
 ; Reference to ^PS(55 is supported by DBIA 2191.
 ; Reference to ^PSDRUG is supported by DBIA 2192.
 ; Routine should be deleted after install
 ;
 Q
QUE ; Que the job in the background
 N NAMSP,PATCH,JOBN,ZTSK,ZTRTN,ZTIO,ZTDTH,ZTDESC,Y,ZTQUEUED,ZTREQ,ZTSAVE,CNT,SBJM
 S NAMSP="PSJ5P315"
 S JOBN="PSJ*5*315 Pre Install Diagnostic Report"
 S PATCH="PSJ*5*315"
 S Y=$$NOW^XLFDT S ZTDTH=$$FMTH^XLFDT(Y)
 ;
 D BMES^XPDUTL("=============================================================")
 D MES^XPDUTL("Queuing background job for "_JOBN_"...")
 D MES^XPDUTL("Start time: "_$$HTE^XLFDT(ZTDTH))
 D MES^XPDUTL("A MailMan message will be sent to the installer upon Post")
 D MES^XPDUTL("Install Completion.  This may take an hour.")
 D MES^XPDUTL("==============================================================")
 ;
 S ZTRTN="EN^"_NAMSP,ZTIO=""
 S (SBJM,ZTDESC)="Background job for "_JOBN
 S ZTSAVE("JOBN")="",ZTSAVE("ZTDTH")="",ZTSAVE("DUZ")="",ZTSAVE("SBJM")=""
 D ^%ZTLOAD
 D:$D(ZTSK)
 . D MES^XPDUTL("*** Task #"_ZTSK_" Queued! ***")
 . D BMES^XPDUTL("")
 . S ZTSAVE("ZTSK")=""
 D BMES^XPDUTL("")
 K XPDQUES
 D FIXITEM
 Q
 ;
FIXITEM ; SET PROTOCOL SEQUENCES TO MATCH REQUIREMENTS
 N PSJMNUI,PSJITEM,PSJPIEN,PSJPNM,PSJITXT,QT S QT=""""
 S PSJPIEN=$O(^ORD(101,"B","PSJ LM ORDER VIEW HIDDEN ACTIONS",0)) Q:'PSJPIEN
 S PSJITEM=$O(^ORD(101,"B","PSJ LM PHARMACY INTERVENTION MENU",0))
 S:PSJITEM PSJMNUI=$O(^ORD(101,PSJPIEN,10,"B",PSJITEM,0))
 S:$G(PSJMNUI) $P(^ORD(101,PSJPIEN,10,PSJMNUI,0),U,3)=42
 ; Change display name of Other Pharmacy Options
 S PSJPIEN=$O(^ORD(101,"B","PSJ LM OTHER PHARMACY OPTIONS",0))
 S:$G(PSJPIEN) $P(^ORD(101,PSJPIEN,0),U,2)="Other Pharm Options"
 ; Recompile menus that contain new item
 N I,STR S STR="PSJU LM HIDDEN UD ACTIONS,PSJ LM BPI HIDDEN ACTIONS,PSJ LM PROFILE HIDDEN ACTIONS,PSJ LM ORDER VIEW HIDDEN ACTIONS"
 F I=1:1:$L(STR,",") S PSJITXT=$P(STR,",",I) D
 . S PSJPIEN=$O(^ORD(101,"B",PSJITXT,0))
 . S XQORM=PSJPIEN_";ORD(101," D XREF^XQORM K XQORM
 .Q
 ;
 S PSJITEM=$O(^ORD(101,"B","PSJ LM ADM HIST",0)) Q:'PSJITEM
 S PSJMNUI=$O(^ORD(101,PSJPIEN,10,"B",PSJITEM,0)) Q:'PSJMNUI
 S:$G(PSJMNUI) $P(^ORD(101,PSJPIEN,10,PSJMNUI,0),U,3)=43
 Q
 ;
EN(P1) ;Check for MRR meds missing the 2.1 node which is new and would be
 ;there if an order was created and finished after patch PSJ*3*315
 ; Input param: P1 = default is null and checks for 2.1 node (used for testing)
 ;                  = if pass in a value, then it will not check 2.1
 ;
 N PSJDFN,PSJMRR,PSJMRRAR,PSJORD,ORDTOT,PSJDDOI,PSJOI,PSJMRRFL,PSJSPCE,PSJDUZ,PSJLN
 N QQ,YY,STS,ID,LOC,CLNODE,STP,DDTXT,PAGNO,ORDSDT
 N XMDUZ,XMSUB,XMTEXT,XMY,X,DIFROM
 S PSJDUZ=DUZ,ORDSDT=$$NOW^XLFDT
 K ^TMP($J,"PSJ5P315"),^XTMP("PSJ5P315")
 ;build array of OI's that are mrr and their flag value
 F QQ=0:0 S QQ=$O(^PSDRUG("ASP",QQ)) Q:QQ=""  D
 . F YY=0:0 S YY=$O(^PSDRUG("ASP",QQ,YY)) Q:'YY  D
 .. S PSJOI=$P(^PSDRUG(YY,2),U)
 .. S PSJMRRFL=$P($G(^PS(50.7,PSJOI,4)),U,1)
 .. S:PSJMRRFL PSJMRRAR(PSJOI)=PSJMRRFL
 ;
 S P1=$G(P1)   ;define P1 to null if not passed
 S PAGNO=0,ORDTOT=0
 ; Use Ord Stop Date XREF to look for current orders
 F  S ORDSDT=$O(^PS(55,"AUD",ORDSDT)) Q:ORDSDT=""  D
 . S PSJDFN=0
 . F  S PSJDFN=$O(^PS(55,"AUD",ORDSDT,PSJDFN)) Q:PSJDFN=""  D
 .. S PSJORD=0
 .. F  S PSJORD=$O(^PS(55,"AUD",ORDSDT,PSJDFN,PSJORD)) Q:PSJORD=""  D
 ... S STS=$P($G(^PS(55,PSJDFN,5,PSJORD,0)),U,9)
 ... S CLNODE=$G(^PS(55,PSJDFN,5,PSJORD,8))
 ... ;non Active type order, quit dont include
 ... I (STS="D")!(STS="E")!(STS="DE")!(STS="DR") Q
 ... S ID=$S('$D(^DPT(PSJDFN,0)):"NONE",1:$E($P($G(^DPT(PSJDFN,0)),U,1),1)_$E($P($G(^DPT(PSJDFN,0)),U,9),6,9))
 ... D CHKORD        ;check and then print line on report
 ..Q
 .Q
 D MAKERPT,SENDRPT
 Q
 ;
CHKORD ;check if Order qualifies and then print on report
 ; return mrrfl which is positive or true  (1,2,3)
 F QQ=0:0 S QQ=$O(^PS(55,PSJDFN,5,PSJORD,1,QQ)) Q:'QQ  D
 . S PSJDDOI=+$P($G(^PS(55,PSJDFN,5,PSJORD,.2)),U)
 . S PSJMRR=$G(PSJMRRAR(PSJDDOI))
 . Q:'PSJMRR      ;don't report not a MRR med
 . ;   don't report if has a 2.1 node, unless P1 overrides
 . I $G(P1)="",$D(^PS(55,PSJDFN,5,PSJORD,2.1)) Q
 . S LOC=$S($$CLINIC(CLNODE):$P(^SC(+^PS(55,PSJDFN,5,PSJORD,8),0),U,1),$G(^DPT(PSJDFN,.1))]"":^DPT(PSJDFN,.1),1:"UNKNOWN")
 . S DDTXT=$$GET1^DIQ(55.07,QQ_","_PSJORD_","_PSJDFN,"DISPENSE DRUG")
 . S ^XTMP("PSJ5P315",$J,LOC,ID)=DDTXT_U_STS_U_PSJMRR
 .Q
 Q
MAKERPT ;
 S ^TMP($J,"PSJ5P315")=""
 S ^TMP($J,"PSJ5P315",0)=" "
 S ^TMP($J,"PSJ5P315",1)=" "
 S ^TMP($J,"PSJ5P315",2)="Orders for Medications Requiring Removal (MRR) ACTIVE PRIOR to"
 S ^TMP($J,"PSJ5P315",3)="Installation of PSJ*5*315. These orders will need to be Discontinued"
 S ^TMP($J,"PSJ5P315",6)=" and re-entered after coordinating with your Pharmacy ADPAC."
 S ^TMP($J,"PSJ5P315",7)=" This report can be recalled from the PSS MGR Menu."
 S ^TMP($J,"PSJ5P315",8)=" "
 S ^TMP($J,"PSJ5P315",9)="             Sorted by Patient within Ward"
 S ^TMP($J,"PSJ5P315",10)="Pat    Patient               Orderable             Ordr  MRR"
 S ^TMP($J,"PSJ5P315",11)="ID     Loc                   Item Name             Sts   Val"
 S ^TMP($J,"PSJ5P315",12)="-----  --------------------  --------------------  ----  ---"
 S ^TMP($J,"PSJ5P315",13)=" "
 S PSJLN=14,$P(PSJSPCE," ",20)=""
 N STR S LOC=""
  F  S LOC=$O(^XTMP("PSJ5P315",$J,LOC)) Q:LOC=""  D
 . S ID=""
 . F  S ID=$O(^XTMP("PSJ5P315",$J,LOC,ID)) Q:ID=""  D
 .. S STR=^XTMP("PSJ5P315",$J,LOC,ID),DDTXT=$P(STR,U),STS=$P(STR,U,2),PSJMRR=$P(STR,U,3)
 .. S ^TMP($J,"PSJ5P315",PSJLN)=$E(ID_PSJSPCE,1,5)_"  "_$E($$FMTE^XLFDT(LOC,5)_PSJSPCE,1,20)_"  "_$E(DDTXT_PSJSPCE,1,20)_"  "_$E(STS_PSJSPCE,1,4)_"  "_$E(PSJMRR_PSJSPCE,1,3)
 .. S ORDTOT=ORDTOT+1,PSJLN=PSJLN+1
 ..Q
 .Q
 S PSJLN=PSJLN+1,^TMP($J,"PSJ5P315",PSJLN)="Total Orders found: "_ORDTOT
 Q
 ;
CLINIC(CL) ;Is this a Clinic order that would show on the VDL in CO mode also?
 Q:'($P(CL,"^",2)?7N!($P(CL,"^",2)?7N1".".N)) 0  ;no appt date, IM ord
 Q:'$D(^PS(53.46,"B",+CL)) 0                     ;no PTR to 44, IM ord
 N A S A=$O(^PS(53.46,"B",+CL,"")) Q:'A 0        ;no 53.46 ien, IM ord
 Q $P(^PS(53.46,A,0),"^",4)                      ;Send to BCMA? flag
 ;
SENDRPT ;Send report to user
 S XMY(PSJDUZ)=""
 S X="" F  S X=$O(^XUSEC("PSJI MGR",X)) Q:'X  S XMY(X)=""
 S X="" F  S X=$O(^XUSEC("PSJU MGR",X)) Q:'X  S XMY(X)=""
 S X="" F  S X=$O(^XUSEC("PSJU RPH",X)) Q:'X  S XMY(X)=""
 S X="" F  S X=$O(^XUSEC("PSJ RPHARM",X)) Q:'X  S XMY(X)=""
 S XMSUB="Pharmacy Data Management",XMTEXT="^TMP("_$J_","_"""PSJ5P315"""_",",XMDUZ=.5,XMY(PSJDUZ)=""
 D ^XMD
 K ^TMP($J,"PSJ5P315"),^XTMP("PSJ5P315")
 Q
 ;
TST ;
 N P1 S P1=1
 D EN(P1)
 Q
 ;
