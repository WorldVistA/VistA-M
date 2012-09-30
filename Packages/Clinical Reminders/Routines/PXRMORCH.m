PXRMORCH ; SLC/AGP - Reminder Order Checks API;06/3/2012
 ;;2.0;CLINICAL REMINDERS;**16,22**;Feb 04, 2005;Build 160
 ;
 Q
 ;
GETOCTXT(DFN,IEN,OI,SEV,PNAME,SUB,CNT) ;Get the Order Check text from
 ;rule IEN.
 N LC,NFL,NIN,NOUT,PXRMRM,TEXTIN,TEXTOUT
 ;If formatted text is stored just copy it.
 S NFL=$P(^PXD(801.1,IEN,5),U,2)
 I NFL>0 D  Q
 . F LC=1:1:NFL S CNT=CNT+1,^TMP($J,SUB,SEV,PNAME,CNT)=^PXD(801.1,IEN,6,LC,0)
 ;
 ;If there is no formatted text then the Order Check Text contains a
 ;TIU Object so call the Found/Not Found Text expansion.
 S NIN=$P(^PXD(801.1,IEN,5),U,1)
 F LC=1:1:NIN S TEXTIN(LC)=^PXD(801.1,IEN,4,LC,0)
 S PXRMRM=80,NOUT=0
 D FNFTXTO^PXRMFNFT(1,NIN,.TEXTIN,DFN,"",.NOUT,.TEXTOUT)
 F LC=1:1:NOUT S CNT=CNT+1,^TMP($J,SUB,SEV,PNAME,CNT)=TEXTOUT(LC)
 Q
 ;
ADDRULES(TYPE,ITEM,LIST) ;
 I ITEM'>0 Q
 N IEN S IEN=0
 F  S IEN=$O(^PXD(801,"ADRUGR",TYPE,ITEM,IEN)) Q:IEN'>0  S LIST(IEN)=""
 Q
 ;
GETDRUG(DRGIEN,OI,LIST) ;
 ;add rules assigned to the drug
 D ADDRULES("DR",DRGIEN,.LIST)
 ;get drug information DBIA 4533
 D DATA^PSS50(DRGIEN,,DT,,,"PXRM DRUG")
 I $G(^TMP($J,"PXRM DRUG",0))'>0 Q
 ;add rules assigned to VA Generic
 D ADDRULES("DG",$P($G(^TMP($J,"PXRM DRUG",DRGIEN,20)),U),.LIST)
 ;add rules assigned to VA Drug Class
 D ADDRULES("DC",$P($G(^TMP($J,"PXRM DRUG",DRGIEN,25)),U),.LIST)
 I OI>0 Q
 ;get OI from DRUG
 N IEN,PSOI
 S PSOI=+$G(^TMP($J,"PXRM DRUG",DRGIEN,2.1)) I PSOI'>0 Q
 S OI=$$OITM^ORX8(PSOI,"99PSP") I OI'>0 Q
 S IEN=0 F  S IEN=$O(^PXD(801,"AOIR",OI,IEN)) Q:IEN'>0  S LIST(IEN)=""
 Q
 ;
GETRULES(OI,DRUG,LIST) ;
 ;get rules for OI
 N DRGIEN,IEN,OIID
 I OI>0 S IEN=0 F  S IEN=$O(^PXD(801,"AOIR",OI,IEN)) Q:IEN'>0  S LIST(IEN)=""
 ;detemine if pharmacy OI
 I OI>0 S OIID=$P($G(^ORD(101.43,OI,0)),U,2) I OIID'["PSP" Q
 K ^TMP($J,"PXRM DRUG LIST"),^TMP($J,"PXRM DRUG")
 I DRUG>0 D GETDRUG(DRUG,OI,.LIST) G GETRULEX
 ;get drug(s) assocaited with the OI DBIA 4662
 D DRGIEN^PSS50P7(+OIID,DT,"PXRM DRUG LIST")
 I $G(^TMP($J,"PXRM DRUG LIST",0))'>0 Q
 S DRGIEN=0
 F  S DRGIEN=$O(^TMP($J,"PXRM DRUG LIST",DRGIEN)) Q:DRGIEN'>0  D GETDRUG(DRGIEN,OI,.LIST)
GETRULEX ;
 K ^TMP($J,"PXRM DRUG LIST"),^TMP($J,"PXRM DRUG")
 Q
 ;
ORDERCHK(DFN,OI,TEST,DRUG,TESTER) ;
 ;main order check API
 ;Input
 ;  OI=IEN of Orderable Item from file 101.43
 ;  DFN=Patient DFN
 ;  TEST=Value that matches the Testing Flag either 1 or 0
 ;
 ;Output
 ;  ^TMP($J,OI,SEV,DISPLAY NAME,n)=TEXT
 ;  SEV=is the value assigned to the severity field
 ;  DISPLAY NAME=is the value assigned to the Display Field Name
 ;
 ;K ^TMP($J,OI)
 N CNT,FLAG,IEN,IENOI,IENR,NODE,NUM,OIREM,PNAME,RIEN,RNAME
 N RULES,REMEVLST,RSTAT,SEV,SUB,TEXTTYPE,TIEN,TNAME,TSTAT
 ;
 ;loop through AOIR xref to find the group IEN and the corresponding
 ;Rules assigned to the orderable item
 ;
 S SUB=$S(DRUG>0:DRUG,1:OI)
 K ^TMP($J,SUB)
 D GETRULES(OI,DRUG,.RULES)
 S IEN=0 F  S IEN=$O(RULES(IEN)) Q:IEN'>0  D
 .S NODE=$G(^PXD(801.1,IEN,0))
 .S FLAG=$P(NODE,U,3)
 .I FLAG="I" Q
 .I TEST=1,FLAG="P" Q
 .I TEST=0,FLAG="T" Q
 .S PNAME=$P(NODE,U,2)
 .S SEV=$P(NODE,U,5)
 .S TIEN=$P($G(^PXD(801.1,IEN,2)),U)
 .;
 .;Reminder Term defined used branching logic code
 .I TIEN>0 D  Q
 ..S TSTAT=$$TERM^PXRMDLLB(TIEN,DFN,IEN,"O")
 ..S CNT=0
 ..I TESTER=1 D
 ...S TNAME=$P(^PXRMD(811.5,TIEN,0),U)
 ...S CNT=CNT+1,^TMP($J,SUB,SEV,PNAME,CNT)="INTERNAL: Reminder Term: "_TNAME_" Status: "_$S(TSTAT=1:"True",1:"False")
 ...;S CNT=CNT+1,^TMP($J,SUB,SEV,PNAME,CNT)=" "
 ..I TSTAT'=$P(^PXD(801.1,IEN,2),U,2) D  Q
 ...I TESTER=1 D
 ....S CNT=CNT+1,^TMP($J,SUB,SEV,PNAME,CNT)="RULE FAILED"
 ....S CNT=CNT+1,^TMP($J,SUB,SEV,PNAME,CNT)=" "
 ..;load order check text needs to be converted
 ..D GETOCTXT(DFN,IEN,OI,SEV,PNAME,SUB,.CNT)
 .;if not TERM do reminder evaluation
 .S NODE=$G(^PXD(801.1,IEN,3))
 .S RIEN=$P(NODE,U),RSTAT=$P(NODE,U,2),TEXTTYPE=$P(NODE,U,3)
 .S NODE=$G(^PXD(811.9,RIEN,0))
 .;
 .S RNAME=$S($P(NODE,U,3)'="":$P(NODE,U,3),1:$P(NODE,U))
 .D REMEVAL(DFN,OI,RIEN,PNAME,IEN,RNAME,TEXTTYPE,RSTAT,SEV,SUB,TESTER)
 Q
 ;
 ;
REMEVAL(DFN,OI,RIEN,PNAME,IEN,RNAME,TEXTTYE,RSTAT,SEV,SUB,TESTER) ;
 ;used by ORDECHK this does the reminder evaluation and put the
 ;reminder text in the temp global
 K ^TMP("PXRHM",$J),^TMP("PXRMORTMP",$J)
 N CNT,NUM,STATUS
 S CNT=0
 ;
 ;standard reminder evaluation results, final output like the
 ;HS COMPONENT REMINDER FINDINGS
 ;
 D MAIN^PXRM(DFN,RIEN,55,1)
 S STATUS=$P($G(^TMP("PXRHM",$J,RIEN,RNAME)),U)
 I TESTER=1 D
 .S CNT=CNT+1,^TMP($J,SUB,SEV,PNAME,CNT)="INTERNAL: Reminder Definition: "_RNAME_" Status: "_STATUS
 .;S CNT=CNT+1,^TMP($J,SUB,SEV,PNAME,CNT)=" "
 ;if not valid status quit
 I (STATUS="CNBD")!(STATUS="ERROR") Q
 ;if Reminder Status does not match status field quit.
 I $$STATMTCH(STATUS,RSTAT)=0 D  Q
 .I TESTER=1 D
 ..S CNT=CNT+1,^TMP($J,SUB,SEV,PNAME,CNT)="RULE FAILED"
 ..S CNT=CNT+1,^TMP($J,SUB,SEV,PNAME,CNT)=" "
 ;save off the evaluation temp global into another global. This
 ;prevent a problem with TIU Objects for reminder evaluation
 M ^TMP("PXRMORTMP",$J)=^TMP("PXRHM",$J)
 ;
 S NUM=0
 ;load order check text if requested
 I TEXTTYPE="O"!(TEXTTYPE="B") D GETOCTXT(DFN,IEN,OI,SEV,PNAME,SUB,.CNT)
 I TEXTTYPE="O" Q
 ;
 I TEXTTYPE="B" S CNT=CNT+1,^TMP($J,SUB,SEV,PNAME,CNT)=""
 ;build reminder text if requested
 F  S NUM=$O(^TMP("PXRMORTMP",$J,RIEN,RNAME,"TXT",NUM)) Q:NUM'>0  D
 .S CNT=CNT+1
 .S ^TMP($J,SUB,SEV,PNAME,CNT)=$G(^TMP("PXRMORTMP",$J,RIEN,RNAME,"TXT",NUM))
 K ^TMP("PXRHM",$J),^TMP("PXRMORTMP",$J)
 Q
 ;
STATMTCH(REMSTAT,RULESTAT) ;
 I RULESTAT="D",REMSTAT["DUE" Q 1
 I RULESTAT="A",REMSTAT'="N/A",REMSTAT'="NEVER" Q 1
 I RULESTAT="N",$E(REMSTAT,1)="N" Q 1
 Q 0
 ;
