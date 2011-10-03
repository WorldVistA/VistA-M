PSJA0103 ;BIR/JLC - Check for Non-Standard Schedules ;01-MAR-04
 ;;5.0; INPATIENT MEDICATIONS ;**103**;16 DEC 97
 ;
SENDMSG ;
 D NOW^%DTC S (Y,YA)=% X ^DD("DD") S YT=Y
 K PSG,XMY S XMDUZ="MEDICATIONS,INPATIENT",XMSUB="ADMIN SCHEDULES",XMTEXT="PSG(",XMY(DUZ)=""
 S PSG(1,0)="  The check of Inpatient Medications 5.0 orders is complete."
 S PSG(2,0)=" ",PSG(3,0)="  Here is the list of all medication administration schedules in use: ",PSG(4,0)=" "
 S PSJSCHD="",OCNT=4,X=""
 F  S PSJSCHD=$O(^XTMP("PSJSC","ALL",PSJSCHD)) Q:PSJSCHD=""  S X=X_PSJSCHD_", " I $L(X)>60 S OCNT=OCNT+1,PSG(OCNT,0)=X,X=""
 I X]"" S OCNT=OCNT+1,PSG(OCNT,0)=X
 D ^XMD
 K PSG S XMDUZ="MEDICATIONS,INPATIENT",XMSUB="ADMIN SCHEDULES NOT IN 51.1",XMTEXT="PSG(",XMY(DUZ)=""
 S PSG(1,0)="  The check of Inpatient Medications 5.0 orders is complete."
 S PSG(2,0)=" ",PSG(3,0)="Here is the list of administration schedules not in the",PSG(4,0)="ADMINISTRATION SCHEDULE file (#51.1): "
 S PSG(5,0)=" ",PSJSCHD="",OCNT=5,X=""
 F  S PSJSCHD=$O(^XTMP("PSJSC","NSS",PSJSCHD)) Q:PSJSCHD=""  S X=X_PSJSCHD_", " I $L(X)>60 S OCNT=OCNT+1,PSG(OCNT,0)=X,X=""
 I X]"" S OCNT=OCNT+1,PSG(OCNT,0)=X
 D ^XMD
 K PSG S XMDUZ="MEDICATIONS,INPATIENT",XMSUB="DANGEROUS SCHEDULES IN 51.1",XMTEXT="PSG(",XMY(DUZ)=""
 S PSG(1,0)="  The check of Inpatient Medications 5.0 orders is complete."
 S PSG(3,0)=" ",PSG(4,0)="Here is the list of administration schedules in 51.1",PSG(5,0)="considered 'dangerous': "
 S PSG(6,0)=" ",PSJSCHD="",OCNT=6,X=""
 F  S PSJSCHD=$O(^XTMP("PSJSC","DAN51.1",PSJSCHD)) Q:PSJSCHD=""  S X=X_PSJSCHD_", " I $L(X)>60 S OCNT=OCNT+1,PSG(OCNT,0)=X,X=""
 I X]"" S OCNT=OCNT+1,PSG(OCNT,0)=X
 D ^XMD
 K PSG S XMDUZ="MEDICATIONS,INPATIENT",XMSUB="DANGEROUS SCHEDULE ABBREVIATIONS",XMTEXT="PSG(",XMY(DUZ)=""
 S PSG(1,0)="  The check of Inpatient Medications 5.0 orders is complete."
 S PSG(2,0)=" ",PSG(3,0)="Here is the list of administration schedules JCAHO labels",PSG(4,0)="as dangerous: "
 S PSG(5,0)=" ",PSJSCHD="",OCNT=5,X=""
 F  S PSJSCHD=$O(^XTMP("PSJSC","DAN",PSJSCHD)) Q:PSJSCHD=""  S X=X_PSJSCHD_", " I $L(X)>60 S OCNT=OCNT+1,PSG(OCNT,0)=X,X=""
 I X]"" S OCNT=OCNT+1,PSG(OCNT,0)=X
 D ^XMD
 K PSG S XMDUZ="MEDICATIONS,INPATIENT",XMSUB="NON-STANDARD SCHEDULES IN QUICK CODES",XMTEXT="PSG(",XMY(DUZ)=""
 S PSG(1,0)="  The check of Inpatient Medications 5.0 is complete."
 S PSG(2,0)=" ",PSG(3,0)="Here is the list of IV Additives / IV Quick Codes with non-standard schedules:"
 S PSG(4,0)=" ",A="",OCNT=4,X=""
 F  S A=$O(^XTMP("PSJSC","QC","NSS",A)) Q:A=""  S X=X_A_", " I $L(X)>60 S OCNT=OCNT+1,PSG(OCNT,0)=X,X=""
 I X]"" S OCNT=OCNT+1,PSG(OCNT,0)=X
 D ^XMD
 K PSG S XMDUZ="MEDICATIONS,INPATIENT",XMSUB="DANGEROUS SCHEDULES IN QUICK CODES",XMTEXT="PSG(",XMY(DUZ)=""
 S PSG(1,0)="  The check of Inpatient Medications 5.0 is complete."
 S PSG(2,0)=" ",PSG(3,0)="Here is the list of IV Additives / IV Quick Codes with dangerous abbreviations:"
 S PSG(4,0)=" ",A="",OCNT=4,X=""
 F  S A=$O(^XTMP("PSJSC","QC","DAN",A)) Q:A=""  S X=X_A_", " I $L(X)>60 S OCNT=OCNT+1,PSG(OCNT,0)=X,X=""
 I X]"" S OCNT=OCNT+1,PSG(OCNT,0)=X
 D ^XMD
 K PSG S XMDUZ="MEDICATIONS,INPATIENT",XMSUB="NON-STANDARD SCHEDULES IN ORDER SETS",XMTEXT="PSG(",XMY(DUZ)=""
 S PSG(1,0)="  The check of Inpatient Medications 5.0 is complete."
 S PSG(2,0)=" ",PSG(3,0)="Here is the list of Unit Dose Order Sets with non-standard schedules:"
 S PSG(4,0)=" ",A="",OCNT=4,X=""
 F  S A=$O(^XTMP("PSJSC","OS","NSS",A)) Q:A=""  S X=X_A_", " I $L(X)>60 S OCNT=OCNT+1,PSG(OCNT,0)=X,X=""
 I X]"" S OCNT=OCNT+1,PSG(OCNT,0)=X
 D ^XMD
 K PSG S XMDUZ="MEDICATIONS,INPATIENT",XMSUB="DANGEROUS SCHEDULES IN ORDER SETS",XMTEXT="PSG(",XMY(DUZ)=""
 S PSG(1,0)="  The check of Inpatient Medications 5.0 is complete."
 S PSG(2,0)=" ",PSG(3,0)="Here is the list of Unit Dose Order Sets with dangerous abbreviations:"
 S PSG(4,0)=" ",A="",OCNT=4,X=""
 F  S A=$O(^XTMP("PSJSC","OS","DAN",A)) Q:A=""  S X=X_A_", " I $L(X)>60 S OCNT=OCNT+1,PSG(OCNT,0)=X,X=""
 I X]"" S OCNT=OCNT+1,PSG(OCNT,0)=X
 D ^XMD
 K PSG S XMDUZ="MEDICATIONS,INPATIENT",XMSUB="NON-STANDARD SCHEDULES IN ORDERABLE ITEMS",XMTEXT="PSG(",XMY(DUZ)=""
 S PSG(1,0)="  The check of Inpatient Medications 5.0 is complete."
 S PSG(2,0)=" ",PSG(3,0)="Here is the list of Orderable Items-Dosage Forms with dangerous abbreviations:"
 S PSG(4,0)=" ",A="",OCNT=4,X=""
 F  S A=$O(^XTMP("PSJSC","OI","NSS",A)) Q:A=""  S X=X_A_"-"_^(A)_", " I $L(X)>60 S OCNT=OCNT+1,PSG(OCNT,0)=X,X=""
 I X]"" S OCNT=OCNT+1,PSG(OCNT,0)=X
 D ^XMD
 K PSG S XMDUZ="MEDICATIONS,INPATIENT",XMSUB="DANGEROUS SCHEDULES IN ORDERABLE ITEMS",XMTEXT="PSG(",XMY(DUZ)=""
 S PSG(1,0)="  The check of Inpatient Medications 5.0 is complete."
 S PSG(2,0)=" ",PSG(3,0)="Here is the list of Orderable Items-Dosage Forms with dangerous abbreviations:"
 S PSG(4,0)=" ",A="",OCNT=4,X=""
 F  S A=$O(^XTMP("PSJSC","OI","DAN",A)) Q:A=""  S X=X_A_"-"_^(A)_", " I $L(X)>60 S OCNT=OCNT+1,PSG(OCNT,0)=X,X=""
 I X]"" S OCNT=OCNT+1,PSG(OCNT,0)=X
 D ^XMD
 Q
