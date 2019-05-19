PSSMIGRS ;AJF - Receives and Process Migration Synch XML message from PEPS; 05/15/2012 0645
 ;;1.0;PHARMACY ENTERPRISE PRODUCT SYSTEM;;;Build 35
 ;;
 ; Start of Migration Sync code
 ; Calls ^PSSMIGRT
 ;;
SYNC(XOBY,PSSMSG) ;Entry point into routine
 N X,Y,DIR,PATH,FILE,DOCHAND,PSSFDA,XMLFILE,VAL,LEN,INPUT,XFILE,OUTCNT,PSS,PSTATUS
 N RERR,PSNDC,PSUPN,PSMAN,PSTNAME,PSPNAME,PSSIZE,PSTYPE,PSOTC,NIEN,MIEN,TIEN,SIEN
 N PSCNT,PSNUM,D,DA,DATE,DIC,DIE,DLAYGO,DOCHAND,DR,DT,FILE,FRMTENT,GT,IMPUT,LEN,MIEN,NIEN
 N NWARRY,OUT,PS0,PSNDC1,XML2,PSIADT,NIEN2,PNIEN,DIK,PNT
 ;
 D DT^DICRW S U="^",INPUT="",OUTCNT=0,DATE=DT,PST=""
 ;
 S OUT=$NA(^UTILITY($J,"OUT"))
 K ^UTILITY($J),^TMP($J,"XML OUT")
 S ^TMP($J,"NDC1","START")=DATE
 S ^TMP($J,"NDC1","XML")=$G(PSSMSG)
 ;
 D PRSTRING(.PSSMSG,.XMLFILE)
 ;
 S VAL="" F  S VAL=$O(XMLFILE(VAL)) Q:VAL=""  D
 .S ^TMP($J,"XML OUT",VAL)=XMLFILE(VAL)
 ;
 ;**strip out any invisible ASCII characters before passing the TMP global to MXMLDOM
 ;F  S PSS("charCount")=$O(^TMP($J,"XML OUT",PSS("charCount"))) Q:PSS("charCount")=""  D
 ;F PSS("char")=0:1:32 S ^TMP($J,"XML OUT",PSS("charCount"))=$TRANSLATE(^TMP($J,"XML OUT",PSS("charCount")),$C(PSS("char")),"")
 ;
 ;**get handle to XML document in memory, the date/time message was received, and the DUZ of the associated user
 S DOCHAND=$$EN^MXMLDOM($NA(^TMP($J,"XML OUT")),"VO")
 S PSS("date/time")=$$NOW^XLFDT
 S PSS("duz")=DUZ
 S (PSUPN,MIEN,PSTNAME,PNIEN,SIEN,TIEN,PSOTC,PSIADT)=""
 ;
 ;**retrieve parent node attributes
 S PSS("body")=$$PARENT^MXMLDOM(DOCHAND,2)
 S PSS("bodyName")=$$NAME^MXMLDOM(DOCHAND,PSS("body"))
 S PSS("status")=$$VALUE^MXMLDOM(DOCHAND,PSS("body"),"status")
 S PSS("pepsIdNumber")=$$VALUE^MXMLDOM(DOCHAND,PSS("body"),"pepsIdNumber")
 ;
 I PSS("bodyName")="ndcMigrationSynchRequest" D
 . S PSS("child")=1,PSS("FILE")=50.67,PSSTITLE="ndcMigrationSynchResponse",PST="ndc"
 . F  S PSS("child")=$O(^TMP("MXMLDOM",$J,DOCHAND,PSS("child"))) Q:PSS("child")=""  D
 .. S PSS("ELE")=$$NAME^MXMLDOM(DOCHAND,PSS("child"))
 .. I PSS("ELE")="ndc" S PSNDC=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 .. I PSS("ELE")="ndcIen" S NIEN=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 .. I PSS("ELE")="upn" S PSUPN=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 .. I PSS("ELE")="manufacturer" S PSMAN=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 .. I PSS("ELE")="manufacturerIen" S MIEN=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 .. I PSS("ELE")="tradeName" S PSTNAME=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 .. I PSS("ELE")="productName" S PSPNAME=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 .. I PSS("ELE")="productIen" S PIEN=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 .. I PSS("ELE")="packageSize" S PSSIZE=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 .. I PSS("ELE")="inactivationDate" S PSIADT=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 .. I PSS("ELE")="packageType" S PSTYPE=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 .. I PSS("ELE")="packageTypeIen" S PKIEN=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 .. I PSS("ELE")="otcRxIndicator" S PSOTC=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 .. I PSS("ELE")="status" S PSTATUS=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 ;
 ;
 I PSS("bodyName")="manufacturerMigrationSyncRequest" D
 . S PSS("child")=1,PSS("FILE")=55.95,PSSTITLE="manufacturerMigrationSynchResponse",PST="manufacturer"
 . F  S PSS("child")=$$CHILD^MXMLDOM(DOCHAND,1,PSS("child")) Q:PSS("child")=0  D
 .. S PSS("ELE")=$$NAME^MXMLDOM(DOCHAND,PSS("child"))
 .. I PSS("ELE")="RequestType" S PSS("RTYPE")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 .. I PSS("ELE")="ien" S PSS("IEN")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 .. I PSS("ELE")="manufacturer" S PSS("NAME")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 .. I PSS("ELE")="NDCNumber" S PSS("NDCNUM")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 .. I PSS("ELE")="inactivationDate" S PSS("IDATE")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 ;
 ;
 I PSS("bodyName")="packageTypeMigrationSyncRequest" D
 . S PSS("child")=1,PSS("FILE")=50.608,PSSTITLE="packageTypeMigrationSynchResponse",PST="packageType"
 . F  S PSS("child")=$$CHILD^MXMLDOM(DOCHAND,1,PSS("child")) Q:PSS("child")=0  D
 .. S PSS("ELE")=$$NAME^MXMLDOM(DOCHAND,PSS("child"))
 .. I PSS("ELE")="RequestType" S PSS("RTYPE")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 .. I PSS("ELE")="ien" S PSS("IEN")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 .. I PSS("ELE")="packageType" S PSS("NAME")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 .. I PSS("ELE")="inactivationDate" S PSS("IDATE")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 ;
 ;
 I PSS("bodyName")="drugUnitSyncRequest" D
 . S PSS("child")=1,PSS("FILE")=50.607,PSSTITLE="drugUnitMigrationSynchResponse",PST="drugUnit"
 . F  S PSS("child")=$$CHILD^MXMLDOM(DOCHAND,1,PSS("child")) Q:PSS("child")=0  D
 .. S PSS("ELE")=$$NAME^MXMLDOM(DOCHAND,PSS("child"))
 .. I PSS("ELE")="RequestType" S PSS("RTYPE")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 .. I PSS("ELE")="ien" S PSS("IEN")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 .. I PSS("ELE")="drugUnitName" S PSS("NAME")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 .. I PSS("ELE")="inactivationDate" S PSS("IDATE")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 ;
 I PSS("bodyName")="drugIngredientsSyncRequest" D
 . S PSS("child")=2,PSS("FILE")=50.416
 . F  S PSS("child")=$$CHILD^MXMLDOM(DOCHAND,2,PSS("child")) Q:PSS("child")=0  D
 .. S PSS("ELE")=$$NAME^MXMLDOM(DOCHAND,PSS("child"))
 .. I PSS("ELE")="RequestType" S PSS("RTYPE")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 .. I PSS("ELE")="ien" S PSS("IEN")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 ;
 I PSS("bodyName")="genericNameSyncRequest" D
 . S PSS("child")=2,PSS("FILE")=50.6
 . F  S PSS("child")=$$CHILD^MXMLDOM(DOCHAND,2,PSS("child")) Q:PSS("child")=0  D
 .. S PSS("ELE")=$$NAME^MXMLDOM(DOCHAND,PSS("child"))
 .. I PSS("ELE")="RequestType" S PSS("RTYPE")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 .. I PSS("ELE")="ien" S PSS("IEN")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 ;
 I PSS("bodyName")="dispenseUnitSyncRequest" D
 . S PSS("child")=2,PSS("FILE")=50.64
 . F  S PSS("child")=$$CHILD^MXMLDOM(DOCHAND,2,PSS("child")) Q:PSS("child")=0  D
 .. S PSS("ELE")=$$NAME^MXMLDOM(DOCHAND,PSS("child"))
 .. I PSS("ELE")="RequestType" S PSS("RTYPE")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 .. I PSS("ELE")="ien" S PSS("IEN")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 ;
 I PSS("bodyName")="drugClassSyncRequest" D
 . S PSS("child")=2,PSS("FILE")=50.605
 . F  S PSS("child")=$$CHILD^MXMLDOM(DOCHAND,2,PSS("child")) Q:PSS("child")=0  D
 .. S PSS("ELE")=$$NAME^MXMLDOM(DOCHAND,PSS("child"))
 .. I PSS("ELE")="RequestType" S PSS("RTYPE")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 .. I PSS("ELE")="ien" S PSS("IEN")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 ;
 I PSS("bodyName")="dosageFormSyncRequest" D
 . S PSS("child")=2,PSS("FILE")=50.606
 . F  S PSS("child")=$$CHILD^MXMLDOM(DOCHAND,2,PSS("child")) Q:PSS("child")=0  D
 .. S PSS("ELE")=$$NAME^MXMLDOM(DOCHAND,PSS("child"))
 .. I PSS("ELE")="RequestType" S PSS("RTYPE")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 .. I PSS("ELE")="ien" S PSS("IEN")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 ;
 I PSS("bodyName")="productSyncRequest" D
 . S PSS("child")=2,PSS("FILE")=50.68
 . F  S PSS("child")=$$CHILD^MXMLDOM(DOCHAND,2,PSS("child")) Q:PSS("child")=0  D
 .. S PSS("ELE")=$$NAME^MXMLDOM(DOCHAND,PSS("child"))
 .. I PSS("ELE")="RequestType" S PSS("RTYPE")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 .. I PSS("ELE")="ien" S PSS("IEN")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 ;
 ; Date conversion
 ;S PSIADT=$TR($P(PSIADT,"T",1),"-","")
 ;S PSIADT=$$HL7TFM^XLFDT(PSIADT)
 ;
 ;Check for Migration Status
 I $G(PSTATUS)="Start" D  Q
 . S X=0 F  S X=$O(^PSNDF(50.67,X)) Q:X="NDC"  D
 .. S:$P(^PSNDF(50.67,X,0),"^",7)="" ^TMP($J,"NDC",X)=""
 . S XMESS=" Started ",XIEN="" D XMLR
 ;
 I $G(PSTATUS)="Stop" D  Q
 . S X=0 F  S X=$O(^TMP($J,"NDC",X)) Q:X=""  D
 ..Q:'$D(^PSNDF(50.67,X,0))  S $P(^PSNDF(50.67,X,0),"^",7)=DATE
 . S XMESS=" Stop ",XIEN="" D XMLR
 ;
 ;
MIGR D EN^PSSMIGRT(.PSS)
 ;Process sync request
 ;
 ;
 Q:$D(RERR)=1
 ;
 ;
 ;
 ;
XMLR  ;**generate XML response message
 ;
 ;
 S PSS("xmlResponse")=$$XMLBODY(.PSS)
 ;
 ;
 ;**store value in VistALink return parameter
 ;
 ;
 ;
 ;Write the XML response message to a new file
 S FILE=PSSTITLE_".XML"
 S XML2=PSS("xmlHeader")_"<"_PSSTITLE_PSS("xmlns:xsi")
 S XML2=XML2_PSS("xmlns")_">"_"<responseType>"_"<status>Success</status>"
 S XML2=XML2_XMESS_"</responseType>"_XIEN
 S XOBY=XML2_"</"_PSSTITLE_">"
 S ^TMP($J,"NDC1","XOBY")=XOBY
 ;
 ;
Q1 ; exit and clean-up
 ;K ^TMP("MXMLDOM",$J)
 ;
 ;
 Q
 ;
 ;
RESPONSE(PSS) ;**check to see if current XML message was successfully written to the PEPS QUEUE file (#54.5)
 N PSSOUT
 ;
 I $D(PSS("ERR")) S PSS("response")="Failure",PSS("attribValue")="<response status="""_PSS("response")_""">Unable to queue message.  Reason: "_$P(PSS("ERR"),"^",2)_"</response>"
 E  I $D(^PSSPEPS("B",PSS("pepsIdNumber"))) S PSS("response")="Queued",PSS("attribValue")="<response status="""_PSS("response")_""">Message "_PSS("pepsIdNumber")_" is queued.</response>"
 E  S PSS("response")="Failure",PSS("attribValue")="<response status="""_PSS("response")_""">Unable to queue message "_PSS("pepsIdNumber")_". Reason: "_$P($G(PSS("ERR")),"^",2)_"</response>"
 S PSSOUT=$$XMLBODY(.PSS)
 Q PSSOUT
 ;
XMLBODY(PSS) ;**generates response XML message
 S PSS("xmlHeader")=$$XMLHDR^MXMLUTL
 S PSS("xmlns:xsi")=" xmlns:xsi=""http://www.w3.org/2001/XMLSchema"""
 S PSS("xmlns")=" xmlns=""gov/va/med/pharmacy/peps/external/common/vo/inbound/migration/"_PST_"/response"""
 S PSSOUT=PSS("xmlHeader")
 S PSSOUT=PSSOUT_"<"_PSSTITLE
 S PSSOUT=PSSOUT_" "_PSS("xmlns:xsi")
 S PSSOUT=PSSOUT_" "_PSS("xmlns")
 Q PSSOUT
 ;
TRASH ;**delete XML handle
 D DELETE^MXMLDOM(DOCHAND)
 Q
 ;
OUT(X) ;Error message 
 S FILE=PSSTITLE_".XML",RERR=1,PSS("xmlResponse")=$$XMLBODY(.PSS)
 S XML2=PSS("xmlHeader")_"<"_PSSTITLE_PSS("xmlns:xsi")
 S XML2=XML2_PSS("xmlns")_"><responseType><status>Failure</status>"
 S XML2=XML2_"<message>"_X_"</message></responseType></"_PSSTITLE_">"
 S XOBY=XML2
 S ^TMP($J,"NDC1","OUT")=XOBY
 D Q1
 Q
 ;
PRSTRING(XML,NWARRY) ;**parses the incoming xml string coming back from PEPS
 ;;
 ;XML is the xml string that is passed by PEPS. 
 ;It must be parsed into an array that is usable by MXML Kernel routines. 
 ;;
 I '$D(XML) D OUT(" Error... Invalid xml string") Q
 N POS,GT,FRNTEND,CNT
 ;**FRNTEND holds the front portion of the extracted data
 S GT=">",POS=0
 F CNT=0:1 Q:XML=""!(XML'[">")  D
 .S POS=$F(XML,GT)
 .S FRNTEND=$E(XML,1,POS-1)
 .S XML=$E(XML,POS,$L(XML))
 .S NWARRY(CNT)=FRNTEND
 Q
 ;
 ;
DATE(Y)  ;RETURN A DATE
 I Y X ^DD("DD")
 Q Y
 ;
