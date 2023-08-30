PXRMORCH ;SLC/AGP - Reminder Order Checks API ;Jan 13, 2023@19:26
 ;;2.0;CLINICAL REMINDERS;**16,22,26,47,45,71,65,84**;Feb 04, 2005;Build 2
 ;
 ;SAC EXEMPTION 20030908-01 : Use proper variable scoping instead of
 ;                            namespace variable scoping
 ;
 ;Reference to $$OITM^ORX8 in ICR #3071
 ;Reference to DATA^PSS50 in ICR #4533
 ;Reference to DRGIEN^PSS50P7 in ICR #4662
 ;Reference to FILE #79.2 in ICR #3505
 ;Reference to ^ORD(101.43 in ICR #2843
 ;Reference to FIELD #71.3 IN FILE #101.43 in ICR #7130
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
 F  S IEN=$O(^PXD(801,"AITEM",TYPE,ITEM,IEN)) Q:IEN'>0  S LIST(IEN)=""
 Q
 ;
GETDRUG(DRGIEN,OI,LIST) ;
 ;add rules assigned to the drug
 D ADDRULES("DR",DRGIEN,.LIST)
 D DATA^PSS50(DRGIEN,,DT,,,"PXRM DRUG")
 I $G(^TMP($J,"PXRM DRUG",0))'>0 Q
 ;add rules assigned to VA Generic
 D ADDRULES("DG",$P($G(^TMP($J,"PXRM DRUG",DRGIEN,20)),U),.LIST)
 ;add rules assigned to VA Drug Class
 D ADDRULES("DC",$P($G(^TMP($J,"PXRM DRUG",DRGIEN,25)),U),.LIST)
 ;add rules assigned to VA Product
 D ADDRULES("DP",$P($G(^TMP($J,"PXRM DRUG",DRGIEN,22)),U),.LIST)
 I OI>0 Q
 ;get OI from DRUG
 N IEN,PSOI
 S PSOI=+$G(^TMP($J,"PXRM DRUG",DRGIEN,2.1)) I PSOI'>0 Q
 S OI=$$OITM^ORX8(PSOI,"99PSP") I OI'>0 Q
 S IEN=0 F  S IEN=$O(^PXD(801,"AITEM","OI",OI,IEN)) Q:IEN'>0  S LIST(IEN)=""
 Q
 ;
GETRAD(OI,LIST) ;
 N ITEMS,TYPE,TYPEIEN,RIEN,ERR,X
 K ^TMP("DILIST",$J)
 S TYPE=$$GET1^DIQ(101.43,OI,71.3) I TYPE="" Q
 I TYPE="RADIOLOGY" S TYPE="GENERAL RADIOLOGY"
 D FIND^DIC(79.2,"","@","BXU",TYPE,"","","","","ITEMS","ERR")
 S X=0 F  S X=$O(ITEMS("DILIST",2,X)) Q:X'>0  D
 .S TYPEIEN=+$G(ITEMS("DILIST",2,X))
 .S RIEN=0 F  S RIEN=$O(^PXD(801,"AITEM","RA",TYPEIEN,RIEN)) Q:RIEN=""  S LIST(RIEN)=""
 K ^TMP("DILIST",$J)
 Q
 ;
GETRULES(OI,DRUG,LIST) ;
 ;get rules for OI
 N DRGIEN,IEN,OIID
 S OIID=""
 I OI>0 S IEN=0 F  S IEN=$O(^PXD(801,"AITEM","OI",OI,IEN)) Q:IEN'>0  S LIST(IEN)=""
 ;detemine if pharmacy OI
 I OI>0 S OIID=$P($G(^ORD(101.43,OI,0)),U,2) I OIID'["PSP",OIID'["RAP" Q
 K ^TMP($J,"PXRM DRUG LIST"),^TMP($J,"PXRM DRUG")
 I DRUG>0 D GETDRUG(DRUG,OI,.LIST) G GETRULEX
 I OIID["PSP" D
 .;get drug(s) assocaited with the OI DBIA 4662
 .D DRGIEN^PSS50P7(+OIID,DT,"PXRM DRUG LIST")
 .I $G(^TMP($J,"PXRM DRUG LIST",0))'>0 Q
 .S DRGIEN=0
 .F  S DRGIEN=$O(^TMP($J,"PXRM DRUG LIST",DRGIEN)) Q:DRGIEN'>0  D GETDRUG(DRGIEN,OI,.LIST)
 I OIID["RAP" D GETRAD(OI,.LIST)
GETRULEX ;
 K ^TMP($J,"PXRM DRUG LIST"),^TMP($J,"PXRM DRUG")
 Q
 ;
ORDERCHK(DFN,OI,TEST,DRUG,TESTER) ;
 ;main order check API check for order checks for all Order Check Groups
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
 N RULES,SUB
 ;
 ;
 S SUB=$S(DRUG>0:DRUG,1:OI)
 I +SUB=0 Q
 K ^TMP($J,SUB)
 D GETRULES(OI,DRUG,.RULES)
 D PROCESS(SUB,OI,TEST,TESTER,.RULES)
 Q
 ;
 ; entry point used to look for groups for a specific orderable item
GETGRPS(OI,GROUPS) ;
 N OIID,DRGIEN,TYPE,TYPEIEN,ERR
 I $G(OI)'?1.N Q
 K GROUPS
 ;add groups containing orderable item
 D OLOOP(OI_";ORD(101.43,",.GROUPS)
 ;determine type of item, quit if not pharmacy or radiology
 S OIID=$P($G(^ORD(101.43,OI,0)),U,2) I OIID'["PSP",OIID'["RAP" Q
 I OIID["PSP" D
 .;get drug(s) associated with the OI DBIA 4662
 .D DRGIEN^PSS50P7(+OIID,DT,"PXRM DRUG LIST")
 .I $G(^TMP($J,"PXRM DRUG LIST",0))'>0 Q
 .S DRGIEN=0
 .F  S DRGIEN=$O(^TMP($J,"PXRM DRUG LIST",DRGIEN)) Q:DRGIEN'>0  D
 ..;get drug information DBIA 4533
 ..D DATA^PSS50(DRGIEN,,DT,,,"PXRM DRUG")
 ..I $G(^TMP($J,"PXRM DRUG",0))'>0 Q
 ..;add groups containing VA Generic
 ..D OLOOP($P($G(^TMP($J,"PXRM DRUG",DRGIEN,20)),U)_";PSNDF(50.6,",.GROUPS)
 ..;add groups containing VA Drug Class
 ..D OLOOP($P($G(^TMP($J,"PXRM DRUG",DRGIEN,25)),U)_";PS(50.605,",.GROUPS)
 ..;add groups containing VA Product
 ..D OLOOP($P($G(^TMP($J,"PXRM DRUG",DRGIEN,22)),U)_";PSNDF(50.68,",.GROUPS)
 .K ^TMP($J,"PXRM DRUG LIST"),^TMP($J,"PXRM DRUG")
 I OIID["RAP" D
 .S TYPE=$$GET1^DIQ(101.43,OI,71.3) I TYPE="" Q
 .I TYPE="RADIOLOGY" S TYPE="GENERAL RADIOLOGY"
 .S TYPEIEN=$$FIND1^DIC(79.2,"","X",TYPE,"","","ERR")
 .;add groups containing radiology procedure
 .D OLOOP(TYPEIEN_";RA(79.2,",.GROUPS)
 Q
 ;
 ; entry point used to loop through O index
OLOOP(VPOINTER,GROUPS) ;
 N IEN,GNAME
 S IEN=0 F  S IEN=$O(^PXD(801,"O",VPOINTER,IEN)) Q:'+IEN  D
 .S GNAME=$P($G(^PXD(801,IEN,0)),U) Q:GNAME=""
 .S GROUPS(GNAME)=""
 Q
 ;
 ; entry point used to look for order checks for a specific list of groups.
 ;INPUT and OUTPUT defined ORDERCHK
ORDERGRP(DFN,OI,TEST,DRUG,GROUPS) ;
 N GIEN,GROUP,GRULES,RULE,RULES,SUB
 S SUB=$S(DRUG>0:DRUG,1:OI)
 K ^TMP($J,SUB)
 S GROUP="" F  S GROUP=$O(GROUPS(GROUP)) Q:GROUP=""  D
 .I GROUP=+GROUP,($D(^PXD(801,GROUP,0))) S GIEN=GROUP
 .E  S GIEN=+$O(^PXD(801,"B",GROUP,""))
 .Q:GIEN=0
 .S RULE=0 F  S RULE=$O(^PXD(801,GIEN,3,"B",RULE)) Q:RULE'>0  S GRULES(RULE,GROUP)=""
 D GETRULES(OI,DRUG,.RULES)
 S RULE=0 F  S RULE=$O(RULES(RULE)) Q:RULE'>0  I '$D(GRULES(RULE)) K RULES(RULE)
 D PROCESS(SUB,OI,TEST,0,.RULES)
 Q
 ;
PROCESS(SUB,OI,TEST,TESTER,RULES) ;
 N CNT,FIEVAL,FLAG,IEN,IENOI,IENR,NODE,NUM,OIREM,PNAME,RIEN,RNAME
 N REMEVLST,RSTAT,SEV,TEXTTYPE,TIEN,TNAME,TSTAT,PXRMSRCFF
 S PXRMSRCFF=1
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
 ..S TSTAT=$$TERM^PXRMDLLB(TIEN,DFN,IEN,"O",.FIEVAL)
 ..S CNT=0
 ..I TSTAT=-1 D  Q
 ...S CNT=CNT+1,^TMP($J,SUB,3,PNAME,CNT)="Clinical Reminder evaluation error; this order check cannot be processed."
 ...S CNT=CNT+1,^TMP($J,SUB,3,PNAME,CNT)="Please contact the reminder manager for assistance."
 ...I TESTER=0 D SENDMSG(DFN,"order check rule",PNAME,"term",TIEN)
 ..I $D(^XTMP("PXRM_DISEV",0)) D  Q
 ...S CNT=CNT+1,^TMP($J,SUB,SEV,PNAME,CNT)="Clinical Reminder evaluation is currently disabled; this order check cannot"
 ...S CNT=CNT+1,^TMP($J,SUB,SEV,PNAME,CNT)="be processed." Q
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
 ..K ^TMP("PXRM BL DATA",$J)
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
REMEVAL(DFN,OI,RIEN,PNAME,IEN,RNAME,TEXTTYPE,RSTAT,SEV,SUB,TESTER) ;
 ;used by ORDECHK this does the reminder evaluation and put the
 ;reminder text in the temp global
 K ^TMP("PXRHM",$J),^TMP("PXRMORTMP",$J)
 N CNT,NUM,STATUS,PXRMDEFS
 S CNT=0
 ;
 ;standard reminder evaluation results, final output like the
 ;HS COMPONENT REMINDER FINDINGS
 ;
 D MAIN^PXRM(DFN,RIEN,55,1)
 S STATUS=$P($G(^TMP("PXRHM",$J,RIEN,RNAME)),U)
 I STATUS="ERROR" D  G REMEVALX
 .S CNT=CNT+1,^TMP($J,SUB,3,PNAME,CNT)="Clinical Reminder evaluation error; this order check cannot be processed."
 .S CNT=CNT+1,^TMP($J,SUB,3,PNAME,CNT)="Please contact the reminder manager for assistance."
 .I TESTER=0 D SENDMSG(DFN,"order check rule",PNAME,"definition",RIEN)
 I (STATUS="CNBD") D  G REMEVALX
 .S CNT=CNT+1,^TMP($J,SUB,SEV,PNAME,CNT)="Clinical Reminder evaluation is currently disabled; this order check cannot"
 .S CNT=CNT+1,^TMP($J,SUB,SEV,PNAME,CNT)="be processed."
 I TESTER=1 D
 .S CNT=CNT+1,^TMP($J,SUB,SEV,PNAME,CNT)="INTERNAL: Reminder Definition: "_RNAME_" Status: "_STATUS
 ;if not valid status return error message
 ;if Reminder Status does not match status field quit.
 I $$STATMTCH(STATUS,RSTAT)=0 D  G REMEVALX
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
 I TEXTTYPE="O" G REMEVALX
 ;
 I TEXTTYPE="B" S CNT=CNT+1,^TMP($J,SUB,SEV,PNAME,CNT)=""
 ;build reminder text if requested
 F  S NUM=$O(^TMP("PXRMORTMP",$J,RIEN,RNAME,"TXT",NUM)) Q:NUM'>0  D
 .S CNT=CNT+1
 .S ^TMP($J,SUB,SEV,PNAME,CNT)=$G(^TMP("PXRMORTMP",$J,RIEN,RNAME,"TXT",NUM))
REMEVALX ;EXIT AND CLEAN UP ^TMP
 K ^TMP("PXRHM",$J),^TMP("PXRMORTMP",$J)
 Q
 ;
STATMTCH(REMSTAT,RULESTAT) ;
 I RULESTAT="D",REMSTAT["DUE" Q 1
 I RULESTAT="A",REMSTAT'="N/A",REMSTAT'="NEVER",REMSTAT'="CONTRA",REMSTAT'="REFUSED" Q 1
 I RULESTAT="N",$E(REMSTAT,1)="N"!(REMSTAT="CONTRA")!(REMSTAT="REFUSED") Q 1
 I RULESTAT="R",REMSTAT["RESOLVE" Q 1
 Q 0
 ;
SENDMSG(PAT,TYPE,NAME,ITYPE,IIEN) ;
 K ^TMP("PXRMXMZ",$J)
 N CNT,ERRORTXT,GBL,HEADER,ITEM,PNAME
 S PNAME=$$GET1^DIQ(2,PAT,.01)
 S HEADER="Evaluation error in a Reminder "_TYPE
 S GBL=$S(ITYPE["def":"^PXD(811.9)",ITYPE["dial":"^PXRMD(801.41)",ITYPE["order":"^PXD(801.1)",ITYPE["term":"^PXRMD(811.5)",1:"")
 S ITEM=$S(GBL'="":$P($G(@GBL@(IIEN,0)),U),1:"")
 S CNT=1,^TMP("PXRMXMZ",$J,CNT,0)="Error evaluating a reminder "_ITYPE_" "_ITEM
 S CNT=CNT+1,^TMP("PXRMXMZ",$J,CNT,0)="on patient "_PNAME_" (DFN: "_PAT_")."
 S CNT=CNT+1,^TMP("PXRMXMZ",$J,CNT,0)="This error was found when processing a Reminder "_TYPE_" "_NAME_"."
 D SEND^PXRMMSG("PXRMXMZ",HEADER,"",DUZ)
 K ^TMP("PXRMXMZ",$J)
 Q
 ;
