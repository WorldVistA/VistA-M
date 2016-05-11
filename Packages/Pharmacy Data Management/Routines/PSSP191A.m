PSSP191A ;BIRMINGHAM/GN/DRP-Diagnostic Report only, does not update ; 9/25/15 2:36pm
 ;;1.0;PHARMACY DATA MANAGEMENT;**191**;9/30/97;Build 40
 Q
 ;
QUE ; Que the job in the background
 N NAMSP,PATCH,JOBN,ZTSK,ZTRTN,ZTIO,ZTDTH,ZTDESC,Y,ZTQUEUED,ZTREQ,ZTSAVE,CNT,SBJM
 S NAMSP="PSSP191A"
 S JOBN="PSS*1*191 Post Install Diagnostic Report"
 S PATCH="PSS*1*191"
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
 Q
 ;
EN(P1) ;Check for MRR meds missing the 2.1 node which is new and would be
 ;there if an order was created and finished after patch PSJ*3*315
 ; Input param: P1 = default is null and checks for 2.1 node (used for testing)
 ;                  = if pass in a value, then it will not check 2.1
 ;
 N PSSDFN,PSSMRRAR,PSSORD,PSSDDOI,PSSOI,PSSDUZ,PSSLN,PSSMRRFL,PSSSPCE
 N CLNODE,DDTXT,MRR,PAGNO,QQ,YY,STS,ID,LOC,STP,ORDTOT,ORDSDT
 N XMDUZ,XMSUB,XMTEXT,XMY,X,DIFROM
 S PSSDUZ=DUZ,ORDSDT=$$NOW^XLFDT
 K ^TMP($J,"PSSP191A"),^XTMP("PSSP191A")
 ;build array of OI's that are mrr and their flag value
 F QQ=0:0 S QQ=$O(^PSDRUG("ASP",QQ)) Q:QQ=""  D
 . F YY=0:0 S YY=$O(^PSDRUG("ASP",QQ,YY)) Q:'YY  D
 .. S PSSOI=$P(^PSDRUG(YY,2),U)
 .. S PSSMRRFL=$P($G(^PS(50.7,PSSOI,4)),U,1)
 .. S:PSSMRRFL PSSMRRAR(PSSOI)=PSSMRRFL
 ;
 S P1=$G(P1)   ;define P1 to null if not passed
 S PAGNO=0,ORDTOT=0
 ; Use Ord Stop Date XREF to look for current orders
 F  S ORDSDT=$O(^PS(55,"AUD",ORDSDT)) Q:ORDSDT=""  D
 . S PSSDFN=0
 . F  S PSSDFN=$O(^PS(55,"AUD",ORDSDT,PSSDFN)) Q:PSSDFN=""  D
 .. S PSSORD=0
 .. F  S PSSORD=$O(^PS(55,"AUD",ORDSDT,PSSDFN,PSSORD)) Q:PSSORD=""  D
 ... S STS=$P($G(^PS(55,PSSDFN,5,PSSORD,0)),U,9)
 ... S CLNODE=$G(^PS(55,PSSDFN,5,PSSORD,8))
 ... ;non Active type order, quit dont include
 ... I (STS="D")!(STS="E")!(STS="DE")!(STS="DR") Q
 ... S ID=$S('$D(^DPT(PSSDFN,0)):"NONE",1:$E($P($G(^DPT(PSSDFN,0)),U,1),1)_$E($P($G(^DPT(PSSDFN,0)),U,9),6,9))
 ... D CHKORD        ;check and then print line on report
 ...Q
 ..Q
 .Q
 D MAKERPT,SENDRPT
 Q
 ;
CHKORD ;check if Order qualifies and then print on report
 ; return mrrfl which is positive or true  (1,2,3)
 F QQ=0:0 S QQ=$O(^PS(55,PSSDFN,5,PSSORD,1,QQ)) Q:'QQ  D
 . S PSSDDOI=+$P($G(^PS(55,PSSDFN,5,PSSORD,.2)),U)
 . S MRR=$G(PSSMRRAR(PSSDDOI))
 . Q:'MRR      ;don't report not a MRR med
 . ;   don't report if has a 2.1 node, unless P1 overrides
 . I $G(P1)="",$D(^PS(55,PSSDFN,5,PSSORD,2.1)) Q
 . S LOC=$S($$CLINIC(CLNODE):$P(^SC(+^PS(55,PSSDFN,5,PSSORD,8),0),U,1),$G(^DPT(PSSDFN,.1))]"":^DPT(PSSDFN,.1),1:"UNKNOWN")
 . S DDTXT=$$GET1^DIQ(55.07,QQ_","_PSSORD_","_PSSDFN,"DISPENSE DRUG")
 . S ^XTMP("PSSP191A",$J,LOC,ID)=DDTXT_U_STS_U_MRR
 .Q
 Q
MAKERPT ;
 S ^TMP($J,"PSSP191A")=""
 S ^TMP($J,"PSSP191A",0)=" "
 S ^TMP($J,"PSSP191A",1)=" "
 S ^TMP($J,"PSSP191A",2)="Active Orders for Medications Requiring Removal (MRR)."
 S ^TMP($J,"PSSP191A",3)="Prior to Installation of PSJ*5*315 these orders should be "
 S ^TMP($J,"PSSP191A",4)="reviewed for planning purposes, but no action taken."
 S ^TMP($J,"PSSP191A",5)=" Once PSJ*5*315 is installed they will need to be Discontinued"
 S ^TMP($J,"PSSP191A",6)=" and re-entered after coordinating with your Pharmacy ADPAC."
 S ^TMP($J,"PSSP191A",7)=" This report can be recalled from the PSS MGR Menu."
 S ^TMP($J,"PSSP191A",8)=" "
 S ^TMP($J,"PSSP191A",9)="             Sorted by Patient within Ward"
 S ^TMP($J,"PSSP191A",10)="Pat    Patient               Orderable             Ordr  MRR"
 S ^TMP($J,"PSSP191A",11)="ID     Loc                   Item Name             Sts   Val"
 S ^TMP($J,"PSSP191A",12)="-----  --------------------  --------------------  ----  ---"
 S ^TMP($J,"PSSP191A",13)=" "
 S PSSLN=14,$P(PSSSPCE," ",20)=""
 N STR S LOC=""
 F  S LOC=$O(^XTMP("PSSP191A",$J,LOC)) Q:LOC=""  D
 . S ID=""
 . F  S ID=$O(^XTMP("PSSP191A",$J,LOC,ID)) Q:ID=""  D
 .. S STR=^XTMP("PSSP191A",$J,LOC,ID),DDTXT=$P(STR,U),STS=$P(STR,U,2),MRR=$P(STR,U,3)
 .. S ^TMP($J,"PSSP191A",PSSLN)=$E(ID_PSSSPCE,1,5)_"  "_$E($$FMTE^XLFDT(LOC,5)_PSSSPCE,1,20)_"  "_$E(DDTXT_PSSSPCE,1,20)_"  "_$E(STS_PSSSPCE,1,4)_"  "_$E(MRR_PSSSPCE,1,3)
 .. S ORDTOT=ORDTOT+1,PSSLN=PSSLN+1
 ..Q
 .Q
 S PSSLN=PSSLN+1,^TMP($J,"PSSP191A",PSSLN)="Total Orders found: "_ORDTOT
 Q
 ;
CLINIC(CL) ;Is this a Clinic order that would show on the VDL in CO mode also?
 Q:'($P(CL,"^",2)?7N!($P(CL,"^",2)?7N1".".N)) 0  ;no appt date, IM ord
 Q:'$D(^PS(53.46,"B",+CL)) 0                     ;no PTR to 44, IM ord
 N A S A=$O(^PS(53.46,"B",+CL,"")) Q:'A 0        ;no 53.46 ien, IM ord
 Q $P(^PS(53.46,A,0),"^",4)                      ;Send to BCMA? flag
 ;
SENDRPT ;Send report to user
 S XMY(PSSDUZ)=""
 S X="" F  S X=$O(^XUSEC("PSJI MGR",X)) Q:'X  S XMY(X)=""
 S X="" F  S X=$O(^XUSEC("PSJU MGR",X)) Q:'X  S XMY(X)=""
 S X="" F  S X=$O(^XUSEC("PSJU RPH",X)) Q:'X  S XMY(X)=""
 S X="" F  S X=$O(^XUSEC("PSJ RPHARM",X)) Q:'X  S XMY(X)=""
 S XMSUB="PHARMACY ORDERABLE ITEM MANAGEMENT",XMTEXT="^TMP("_$J_","_"""PSSP191A"""_",",XMDUZ=.5,XMY(PSSDUZ)=""
 D ^XMD
 K ^TMP($J,"PSSP191A"),^XTMP("PSSP191A")
 Q
 ;
TST ;
 N P1 S P1=1
 D EN(P1)
 Q
 ;
