SR95UTL ;BIR/ADM-Utility routine for patch SR*3*95; [09/01/00  10:33 AM ]
 ;;3.0; Surgery ;**95**;24 Jun 93
 ;
 ; Reference to ^DGPM("APTT1" supported by DBIA #565
 ;
 Q
PRE ; pre-install action for SR*3*95
 ; add new entried to file 136.5
 S ^SRO(136.5,33,0)="TRACHEOSTOMY^^^Y",^SRO(136.5,33,1,0)="^^4^4^3000711^"
 S ^SRO(136.5,33,1,1,0)="This category should be selected if a procedure to cut into the trachea"
 S ^SRO(136.5,33,1,2,0)="and insert a tube to overcome tracheal obstruction, or to facilitate"
 S ^SRO(136.5,33,1,3,0)="extended mechanical ventilation, was performed during the postoperative"
 S ^SRO(136.5,33,1,4,0)="hospitalization."
 S ^SRO(136.5,34,0)="NEW MECHANICAL CIRCULATORY SUPPORT^^^Y"
 S ^SRO(136.5,34,1,0)="^^5^5^3000711^"
 S ^SRO(136.5,34,1,1,0)="This category should be selected if the patient left the operating suite"
 S ^SRO(136.5,34,1,2,0)="while dependent upon IABP or VAD for circulatory support postoperatively,"
 S ^SRO(136.5,34,1,3,0)="even if the pump is only used for a short time postoperatively.  However,"
 S ^SRO(136.5,34,1,4,0)="this category is only appropriate if the patient did not enter the OR"
 S ^SRO(136.5,34,1,5,0)="with mechanical circulatory support."
 S ^SRO(136.5,"B","TRACHEOSTOMY",33)=""
 S ^SRO(136.5,"B","NEW MECHANICAL CIRCULATORY SUP",34)=""
 S ^SRO(136.5,0)="PERIOPERATIVE OCCURRENCE CATEGORY^136.5I^34^34"
 ; add new entries to file 139.2
 I $G(^SRO(139.2,21,0))'="HDL" D
 .F DA=21,22,23,24 S DIK="^SRO(139.2," D ^DIK
 .S ^SRO(139.2,21,0)="HDL",^SRO(139.2,21,2)=72
 .S ^SRO(139.2,22,0)="TRIGLYCERIDE",^SRO(139.2,22,2)=72
 .S ^SRO(139.2,23,0)="LDL",^SRO(139.2,23,2)=72
 .S ^SRO(139.2,24,0)="CHOLESTEROL",^SRO(139.2,24,2)=72
 .S DIK="^SRO(139.2,",DIK(1)=".01" D ENALL^DIK K DA,DIK
LETR ; add text of 30-day letter to file 133
 N I,SRDIV,SRLINE,X S SRDIV=0 F  S SRDIV=$O(^SRO(133,SRDIV)) Q:'SRDIV  D
 .S ^SRO(133,SRDIV,5,0)="^133.031^40^40^3000818^^^^"
 .F I=1:1:40 S X=$T(DAY30+I),SRLINE=$P(X,";;",2) S ^SRO(133,SRDIV,5,I,0)=SRLINE
CLEAN ; delete file 132.8 if test site
 I $D(^SRO(132.8)) S DIU="^SRO(132.8,",DIU(0)="DT" D EN^DIU2
 Q
EN1 ; ASA Class conversion from set of codes to file
 S SRTN=0 F  S SRTN=$O(^SRF(SRTN)) Q:'SRTN  S (SRASA,SRNEW)=$P($G(^SRF(SRTN,1.1)),"^",3) I SRASA'="" D
 .I SRASA=1!(SRASA=2)!(SRASA=3)!(SRASA=4)!(SRASA=5) Q
 .I SRASA="1E" S SRNEW=7
 .I SRASA="2E" S SRNEW=8
 .I SRASA="3E" S SRNEW=9
 .I SRASA="4E" S SRNEW=10
 .I SRASA="5E" S SRNEW=11
 .I SRNEW'=SRASA S $P(^SRF(SRTN,1.1),"^",3)=SRNEW
 K SRASA,SRNEW,SRTN
MSG ; send mail message notification that conversion is completed
 S XMY(DUZ)="",XMSUB="SR*3*95 - ASA Class Conversion Completed"
 S SRTXT(1)="Surgery ASA Class conversion is completed."
 S XMDUZ=.5,XMTEXT="SRTXT("
 N I D ^XMD S ZTREQ="@"
 Q
QR ; transmit quarterly reports for FY2000
 S (SRFLG,SRT)=1 D NOW^%DTC S SRNOW=$E(%,1,12)
 S SRSTART=2991001,SREND=2991231 D TSK
 S SRSTART=3000101,SREND=3000331 D TSK
 S SRSTART=3000401,SREND=3000630 D TSK
 I DT>3001113 S SRSTART=3000701,SREND=3000930 D TSK
 S ZTREQ="@"
 Q
TSK S ZTDTH=SRNOW,ZTIO="",ZTDESC="Surgery Quarterly Report",(ZTSAVE("SRSTART"),ZTSAVE("SREND"),ZTSAVE("SRFLG"),ZTSAVE("SRT"))="",ZTRTN="EN^SROQT" D ^%ZTLOAD
 Q
POST ; post-install action for SR*3*95
 D NOW^%DTC S (SRNOW,ZTDTH)=$E(%,1,12),ZTRTN="EN1^SR95UTL",ZTDESC="Surgery ASA Class Conversion",ZTIO="" D ^%ZTLOAD
 D MES^XPDUTL("  ASA Class conversion process queued...")
 ;
 N SRD S SRD=^XMB("NETNAME") I SRD["TST."!(SRD["TEST")!(SRD["UTL.")!(SRD["TRAIN")!(SRD[".IHS.GOV")!(SRD["CPRS") Q
 S ZTDTH=SRNOW,ZTRTN="TN1^SR95UTL",ZTDESC="Surgery Risk Assessment Retransmission",ZTIO="" D ^%ZTLOAD
 S ZTDTH=SRNOW,ZTRTN="QR^SR95UTL",ZTDESC="Surgery Quarterly Report",ZTIO="" D ^%ZTLOAD
 K SRNOW
 Q
TN1 ; transmit historical data
 K ^TMP("SRA",$J) S SRASITE=+$P($$SITE^SROVAR,"^",3),SRACNT=1
 S SRADFN=0 F  S SRADFN=$O(^SRF("ARS","C","T",SRADFN)) Q:'SRADFN  S SRTN=0 F  S SRTN=$O(^SRF("ARS","C","T",SRADFN,SRTN)) Q:'SRTN  S ^TMP("SRA",$J,SRTN)=""
 S SRTN=0 F  S SRTN=$O(^TMP("SRA",$J,SRTN)) Q:'SRTN  D STUFF
 I SRACNT=1 G END
 D TMSG
END K ^TMP("SRA",$J),DA,DFN,I,ISC,NAME,SR,SRA,SRACNT,SRADFN,SRACE,SRASITE,SRD,SRSDATE,SRTN,X,XMSUB,XMTEXT,VA S ZTREQ="@"
 Q
STUFF ; stuff entries into ^TMP("SRA"
 S SR=^SRF(SRTN,0),SRA(208)=$G(^SRF(SRTN,208)),DFN=$P(SR,"^"),SRSDATE=$P(SR,"^",9) D DEM^VADPT
 N VAINDT,X,SRDISTYP,SRPTF,SRRES,SRICD9,SRPICD9,SRX,SRY
 S SRACE=$P(SRA(208),"^",10) I 'SRACE S SRX=$P(VADM(8),"^") I SRX K DA,DIC,DIQ,DR S DIC=10,DR=2,DA=SRX,DIQ="SRY",DIQ(0)="I" D EN^DIQ1 S SRACE=SRY(10,SRX,2,"I")
 S X=$P(SRA(208),"^",15) D:X="" DSCHG S VAINDT=X-.0001
 D INP^VADPT S SRPTF=VAIN(10)
 S SRRES="" D RPC^DGPTFAPI(.SRRES,SRPTF)
 S SRPICD9=$P($G(SRRES(1)),U,3)
 I '$D(SRRES(2)) S SRICD9="^^^^^^^^"
 E  S SRICD9="" F I=1:1:$L(SRRES(2),"^") S X=$P(SRRES(2),"^",I) D
 .I I=1 S SRICD9=X Q
 .S SRICD9=SRICD9_"^"_X
 S X=$$SITE^SROUTL0(SRTN),SRDIV=$S(X:$P(^SRO(133,X,0),"^"),1:""),SRP(3)=$S(SRDIV:$$GET1^DIQ(4,SRDIV,99),1:SRASITE)
 S X=$P($G(SRRES(1)),U)
 S SRDISTYP=$S(X="REGULAR":1,X="NBC OR WHILE ASIH":2,X="EXPIRATION 6 MONTH LIMIT":3,X="IRREGULAR":4,X="TRANSFER":5,X="DEATH WITH AUTOPSY":6,X="DEATH WITHOUT AUTOPSY":7,1:"")
 S ^TMP("SRA",$J,SRACNT)=SRASITE_"^"_SRTN_"^1^"_$E(SRSDATE,1,7)_"^"_VA("PID")_"^"_SRP(3)_"^^"_SRACE_"^"_SRPICD9_"^",SRACNT=SRACNT+1
 S ^TMP("SRA",$J,SRACNT)=SRASITE_"^"_SRTN_"^2^"_SRDISTYP_"^"_SRICD9_"^",SRACNT=SRACNT+1
 Q
DSCHG ; find discharge date
 S VAIP("D")=SRSDATE D IN5^VADPT
 I 'VAIP(13) S X1=$P($G(^SRF(SRTN,.2)),"^",12),X2=1 D C^%DTC S SR24=X,SRDT=$O(^DGPM("APTT1",DFN,SRSDATE)) G:'SRDT!(SRDT>SR24) NODS S VAIP("D")=SRDT D IN5^VADPT
 I VAIP(17) S X=$E($P(VAIP(17,1),"^"),1,12) Q
NODS S X=""
 Q
TMSG ; create mail message to Denver
 S ISC=0,NAME=$G(^XMB("NETNAME")) I NAME["FORUM"!(NAME["ISC-")!($E(NAME,1,3)="ISC")!(NAME["ISC.") S ISC=1
 I ISC S XMY("G.RISK ASSESSMENT@"_^XMB("NETNAME"))=""
 I 'ISC S (XMY("G.CARDIAC RISK ASSESSMENTS@DENVER.VA.GOV"),XMY("G.SRCARDIAC@ISC-CHICAGO.VA.GOV"))=""
 S SRD=^XMB("NETNAME") S XMSUB="** SR*3*95 FROM VAMC-"_SRASITE_" **",XMDUZ=$S($D(DUZ):DUZ,1:.5)
 S XMTEXT="^TMP(""SRA"",$J," N I D ^XMD
 Q
DAY30 ;;
 ;;One month ago, you had an operation at the VA Medical Center.  We are
 ;;interested in how you feel.  Have you had any health problems since your
 ;;operation ?  We would like to hear from you.  Please take a few minutes
 ;;to answer these questions and return this letter in the self-addressed
 ;;stamped envelope.
 ;; 
 ;;Have you been to a hospital or seen a doctor for any reason since your
 ;;operation ?   ___ Yes  ___ No
 ;; 
 ;;If you answered NO, you do not need to answer any more questions.  Please
 ;;return this sheet in the self-addressed stamped envelope.
 ;; 
 ;;If you have answered YES, please answer the following questions.
 ;; 
 ;;   1) Have you been seen in an outpatient clinic or doctor's office ? 
 ;;      ___ Yes  ___ No
 ;; 
 ;;      Why did you go to the clinic or doctor's office ? ________________
 ;; 
 ;;      Where ? (name and location) _____________________  Date ? ________
 ;; 
 ;;      Who was your doctor ? ____________________________________________
 ;; 
 ;; 
 ;;   2) Were you admitted to a hospital ?  ___ Yes  ___ No
 ;; 
 ;;      Why did you go to the hospital ? _________________________________
 ;; 
 ;;      Where ? (name and location) _____________________  Date ? ________
 ;; 
 ;;      Who was your doctor ? ____________________________________________
 ;; 
 ;; 
 ;;Please return this letter whether or not you have had any medical
 ;;problems.  Your health and opinion are important to us.  Thank You.
 ;; 
 ;;Sincerely,
 ;; 
 ;; 
 ;;Surgical Clinical Nurse Reviewer
