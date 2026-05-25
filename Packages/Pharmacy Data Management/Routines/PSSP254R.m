PSSP254R ;BIRM/SA - PSS*1*254 Reports ; Aug 03, 2022@16:00
 ;;1.0;PHARMACY DATA MANAGEMENT;**254**;9/30/97;Build 109
 ;
 ; Reference to FINDQO^ORQOUTL supported by IA #7349
 ;
EN ; entry point
 K ^TMP("PSSP254R",$J)
 N ARRAY,CNT,DLG,DOSEFORM,ENTRY,FLD,FLE,FREQOLD,FREQNEW,IEN,INPUT,II,MEDSCH,MSG,NUM,NODE,NODE0
 N OD,ODLIST,ORDIEN,OR0,ORSNODE,ORSTEXT,PSSI,SUB
 ;
 S MSG="",CNT=1
 S ^TMP("PSSP254R",$J,CNT)="The Dosing Check Frequency field conversion may have impacted Orderable Items.",CNT=CNT+1
 S ^TMP("PSSP254R",$J,CNT)="Schedule^Old Freq^New Freq^Record Num (IEN)^Name^Dosage Form",CNT=CNT+1
 ;
 S FLE=0 F  S FLE=$O(^XTMP("PSSP254B","DCF",FLE)) Q:'FLE  D
 .S NUM=0 F  S NUM=$O(^XTMP("PSSP254B","DCF",FLE,NUM)) Q:'NUM  S FLD=$O(^XTMP("PSSP254B","DCF",FLE,NUM,0)) D
 ..S NODE=$G(^XTMP("PSSP254B","DCF",FLE,NUM,FLD)),ENTRY=$$GET1^DIQ(FLE,NUM,.01)
 ..S FREQOLD=$E($P(NODE,U,1),1,5),FREQNEW=$E($P(NODE,U,2),1,5)
 ..D CHK
 ;
 ;No impacted items
 I CNT=3 S ^TMP("PSSP254R",$J,CNT)="",^TMP("PSSP254R",$J,CNT+1)="There were no impacted Orderable Items"
 ;
 D MAIL("Orderable Items Report")
 D QO
 ;
 K ^TMP("PSSP254R",$J),^TMP($J)
 Q
 ;
CHK ; check if the modified schedule entry was used in file #50.7 entries
 S PSSI=0 F  S PSSI=$O(^PS(50.7,PSSI)) Q:'PSSI  S NODE0=$G(^PS(50.7,PSSI,0)),MEDSCH=$P(NODE0,U,8) I MEDSCH'="" D
 .I ENTRY=MEDSCH D
 ..S DOSEFORM=$$GET1^DIQ(50.606,$P(NODE0,U,2),.01)
 ..S ^TMP("PSSP254R",$J,CNT)=ENTRY_U_FREQOLD_U_FREQNEW_U_PSSI_U_$P(NODE0,U)_U_DOSEFORM
 ..;
 ..;If the entry is more than 78 characters, truncate the schedule to 15, orderable item name to 30, and dosage form to 10
 ..;The two frequency fields are already limited to 5 characters
 ..I $L(^TMP("PSSP254R",$J,CNT))>78 D
 ...S ^TMP("PSSP254R",$J,CNT)=$E(ENTRY,1,15)_U_FREQOLD_U_FREQNEW_U_$E(PSSI,1,7)_U_$E($P(NODE0,U),1,30)_U_$E(DOSEFORM,1,10)
 ..S CNT=CNT+1
 Q
 ;
QO ; quick orders report
 N FREQNEW,FREQOLD,RDISP
 ;
 K ^TMP("PSSP254R",$J),^TMP($J)
 ;
 ; ODLIST(QO entry)=Display Group^Package
 S ODLIST("PSO OERR")="OUTPATIENT MEDICATIONS^OUTPATIENT PHARMACY"
 S ODLIST("PSJ OR PAT OE")="UNIT DOSE MEDICATIONS^INPATIENT MEDICATIONS"
 S ODLIST("PSJ OR CLINIC OE")="CLINIC MEDICATIONS^INPATIENT MEDICATIONS"
 S ODLIST("PSJI OR PAT FLUID OE")="IV MEDICATIONS^INPATIENT MEDICATIONS"
 S ODLIST("CLINIC OR PAT FLUID OE")="CLINIC INFUSIONS^INPATIENT MEDICATIONS"
 S ODLIST("PSH OERR")="NON-VA MEDICATIONS^HERBAL/OTC/NON-VA MEDS"
 S ODLIST("PS MEDS")="PHARMACY^PHARMACY DATA MANAGEMENT"
 ;
 ;For display in the email - RDISP(QO entry)=Display Text (for Display Group)
 ;  Values are locked to 8 characters max
 S RDISP("PSO OERR")="OP"
 S RDISP("PSJ OR PAT OE")="UD"
 S RDISP("PSJ OR CLINIC OE")="CLIN MED"
 S RDISP("PSJI OR PAT FLUID OE")="IV"
 S RDISP("CLINIC OR PAT FLUID OE")="CLIN INF"
 S RDISP("PSH OERR")="NON-VA"
 S RDISP("PS MEDS")="PHARM"
 ;
 S CNT=1,FLE=0
 S ^TMP("PSSP254R",$J,CNT)="The Dosing Check Frequency field conversion may have impacted Quick Orders.",CNT=CNT+1
 S ^TMP("PSSP254R",$J,CNT)="Schedule^Old Freq^New Freq^Record Num (IEN)^Name^Display Group",CNT=CNT+1
 ;S ^TMP("PSSP254R",$J,CNT)="",CNT=CNT+1
 ;
 ;Quick Orders are file 51 only
 ;F  S FLE=$O(^XTMP("PSSP254B","DCF",FLE)) Q:'FLE  D
 S FLE=51 D
 .S NUM=0 F  S NUM=$O(^XTMP("PSSP254B","DCF",FLE,NUM)) Q:'NUM  S FLD=$O(^XTMP("PSSP254B","DCF",FLE,NUM,0)) D
 ..S NODE=$G(^XTMP("PSSP254B","DCF",FLE,NUM,FLD)),ENTRY=$$GET1^DIQ(FLE,NUM,.01)
 ..S FREQOLD=$E($P(NODE,U,1),1,5),FREQNEW=$E($P(NODE,U,2),1,5)
 ..D CHKQO
 ;
 ;No impacted items
 I CNT=3 S ^TMP("PSSP254R",$J,CNT)="",^TMP("PSSP254R",$J,CNT+1)="There were no impacted Quick Orders"
 ;
 D MAIL("Quick Orders Report")
 Q
 ;
CHKQO ; check if the modified schedule entry was used in file #101.41 entries
 S SUB="ARR"
 ;
 S OD="" F  S OD=$O(ODLIST(OD)) Q:OD=""  D
 . K DLG,^TMP($J,SUB)
 . S DLG(OD)=""
 . I $$PATCH^XPDUTL("OR*3.0*405") D FINDQO^ORQOUTL(.ARRAY,.DLG,SUB,0,1,0,0) ; CPRS v32B
 . E  D FINDQO^ORQOUTL(.ARRAY,.DLG,SUB,0,1) ; CPRS v31B
 . D SET
 Q
 ;
SET ; 
 S IEN=0 F  S IEN=$O(^TMP($J,SUB,IEN)) Q:IEN'>0  S ORDIEN=+$G(^TMP($J,SUB,IEN,"ORDIALOG")) D:ORDIEN
 . S OR0=$G(^TMP($J,SUB,IEN))
 . S ORSNODE=$P($G(^TMP($J,SUB,IEN,"ORDIALOG","B","SCHEDULE")),U,2) I ORSNODE D
 .. S ORSTEXT=$G(^TMP($J,SUB,IEN,"ORDIALOG",ORSNODE,1)) I ORSTEXT'="",(ENTRY=ORSTEXT) D
 ... S ^TMP("PSSP254R",$J,CNT)=$E(ENTRY,1,10)_U_FREQOLD_U_FREQNEW_U_$E(IEN,1,7)_U_$E($P(OR0,U),1,36)_U_RDISP(OD) S CNT=CNT+1
 Q
 ;
MAIL(TEXT) ; Sends Mailman message
 N II,XMX,XMSUB,XMDUZ,XMTEXT,XMY,DIFROM
 D BMES^XPDUTL("Sending Mailman Message for "_TEXT_"...")
 S II=0 F  S II=$O(^XUSEC("PSNMGR",II)) Q:'II  S XMY(II)=""
 S XMY(DUZ)="",XMSUB="PSS*1*254 - "_TEXT
 S XMDUZ="PSS*1*254 Install",XMTEXT="^TMP(""PSSP254R"",$J,"
 D ^XMD K ^TMP("PSSP254R",$J)
 Q
