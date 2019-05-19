PSSMIGRC ;AJF - Receives and Process Synch XML message from PEPS;  6/22/2012 0747
 ;;1.0;PHARMACY ENTERPRISE PRODUCT SYSTEM;;;Build 36
 ;;
 ; Start of Sync request
 ; Calls PSSMIGRP AND EN^PSSMIGRD
 ;;
SYNC(XOBY,PSSMSG) ;Entry point into routine
 N X,Y,DIR,PATH,FILE,DOCHAND,PSSFDA,XMLFILE,VAL,LEN,INPUT,XFILE,OUTCNT,PSS,PSTATUS,ERROR
 N ERROR,PSNDC,PSUPN,PSMAN,PSTNAME,PSPNAME,PSSIZE,PSTYPE,PSOTC,NIEN,MIEN,TIEN,SIEN
 N PSCNT,PSNUM,D,DA,DATE,DIC,DIE,DLAYGO,DOCHAND,DOCHAND1,DR,DT,FILE,FRMTENT,GT,IMPUT,LEN,MIEN,NIEN
 N NWARRY,OUT,PS0,PSNDC1,XML2,PSIADT,NIEN2,PNIEN,DIK,PNT,BNAME,PSSTITLE,PST,XMESS,XIEN,JOB
 ;
 D DT^DICRW S U="^",INPUT="",(ERROR,OUTCNT)=0,DATE=DT,PST="",DUZ(0)="@"
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
 S PSS("duz")=DUZ,PSS("FILE")=""
 S (PSUPN,MIEN,PSTNAME,PNIEN,SIEN,TIEN,PSOTC,PSIADT,PSSTITLE)=""
 ;
 ;**retrieve parent node attributes
 S PSS("body")=$$PARENT^MXMLDOM(DOCHAND,2)
 S PSS("bodyName")=$$NAME^MXMLDOM(DOCHAND,PSS("body"))
 S PSS("status")=$$VALUE^MXMLDOM(DOCHAND,PSS("body"),"status")
 S PSS("pepsIdNumber")=$$VALUE^MXMLDOM(DOCHAND,PSS("body"),"pepsIdNumber")
 S JOB=$J
 ;
 ;
 S BNAME=$G(PSS("bodyName"))
 I BNAME]"" D
 . I BNAME="ndcSyncRequest" D NDC Q
 . I BNAME="manufacturerSyncRequest" D MAN Q
 . I BNAME="packageTypeSyncRequest" D PACK Q
 . I BNAME="drugUnitSyncRequest" D DRU Q
 . I BNAME="vaDispenseUnitSyncRequest" D DIS Q
 . I BNAME="drugIngredientSyncRequest" D DRUI Q
 . I BNAME="vaGenericNameSyncRequest" D VAG Q
 . I BNAME="drugClassSyncRequest" D DRUC^PSSMIGRP Q
 . I BNAME="dosageFormSyncRequest" D DOF^PSSMIGRP Q
 . I BNAME="vaProductSyncRequest" D VAP^PSSMIGRP Q
 ;
 ; Quit if REQUIRED DATA is Missing
 I PSS("FILE")="" D OUT(" Error...Missing Required START TAG") Q
 I PSS("RTYPE")'="ADD",PSS("RTYPE")'="MODIFY"  D OUT("Error...Invalid Request Type") Q
 I PSS("RTYPE")="MODIFY",'+$G(PSS("IEN")) D OUT(" Error... Missing Required IEN") Q
 ;
 D MIGR
 Q
 ;
NDC ;
 ;
 I PSS("bodyName")="ndcSyncRequest" D
 . S PSS("child")=1,PSS("FILE")=50.67,(PSSTITLE,PST)="syncResponse"
 . F  S PSS("child")=$$CHILD^MXMLDOM(DOCHAND,1,PSS("child")) Q:PSS("child")=0  D
 .. S PSS("ELE")=$$NAME^MXMLDOM(DOCHAND,PSS("child"))
 .. I PSS("ELE")="RequestType" S PSS("RTYPE")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 .. I PSS("ELE")="ndcName" S PSS("NAME")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 .. I PSS("ELE")="ndcIen" S PSS("IEN")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 .. I PSS("ELE")="upn" S PSS("UPN")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 .. I PSS("ELE")="tradeName" S PSS("TNAME")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 .. I PSS("ELE")="manufacturer" D
 ... S DOCHAND1=PSS("child"),PSS("child1")=1
 ... F  S PSS("child1")=$$CHILD^MXMLDOM(DOCHAND,DOCHAND1,PSS("child1")) Q:PSS("child1")=0  D
 .... S PSS("ELE1")=$$NAME^MXMLDOM(DOCHAND,PSS("child1"))
 .... I PSS("ELE1")="manufacturerName" S PSS("MNAME")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child1"),"T",1)
 .... I PSS("ELE1")="manufacturerIen" S PSS("MIEN")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child1"),"T",1)
 .. I PSS("ELE")="product" D
 ... S DOCHAND1=PSS("child"),PSS("child1")=1
 ... F  S PSS("child1")=$$CHILD^MXMLDOM(DOCHAND,DOCHAND1,PSS("child1")) Q:PSS("child1")=0  D
 .... S PSS("ELE1")=$$NAME^MXMLDOM(DOCHAND,PSS("child1"))
 .... I PSS("ELE1")="productName" S PSS("PNAME")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child1"),"T",1)
 .... I PSS("ELE1")="productIen" S PSS("PIEN")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child1"),"T",1)
 .. I PSS("ELE")="packageSize" S PSS("PSIZE")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 .. I PSS("ELE")="inactivationDate" S PSS("IDATE")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 .. I PSS("ELE")="packageType" D
 ... S DOCHAND1=PSS("child"),PSS("child1")=1
 ... F  S PSS("child1")=$$CHILD^MXMLDOM(DOCHAND,DOCHAND1,PSS("child1")) Q:PSS("child1")=0  D
 .... S PSS("ELE1")=$$NAME^MXMLDOM(DOCHAND,PSS("child1"))
 .... I PSS("ELE1")="packageTypeName" S PSS("PTYPE")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child1"),"T",1)
 .... I PSS("ELE1")="packageTypeIen" S PSS("PTIEN")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child1"),"T",1)
 .. I PSS("ELE")="otcRxIndicator" S PSS("PSOTC")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 Q
 ;
MAN  ;MANUFACTURER
 I PSS("bodyName")="manufacturerSyncRequest" D
 . S PSS("child")=1,PSS("FILE")=55.95,(PSSTITLE,PST)="syncResponse"
 . F  S PSS("child")=$$CHILD^MXMLDOM(DOCHAND,1,PSS("child")) Q:PSS("child")=0  D
 .. S PSS("ELE")=$$NAME^MXMLDOM(DOCHAND,PSS("child"))
 .. I PSS("ELE")="RequestType" S PSS("RTYPE")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 .. I PSS("ELE")="manufacturerIen" S PSS("IEN")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 .. I PSS("ELE")="manufacturerName" S PSS("NAME")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 .. I PSS("ELE")="NDCNumber" S PSS("NDCNUM")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 .. I PSS("ELE")="inactivationDate" S PSS("IDATE")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 Q
 ;
PACK ; PACKAGETYPE
 I PSS("bodyName")="packageTypeSyncRequest" D
 . S PSS("child")=1,PSS("FILE")=50.608,(PSSTITLE,PST)="syncResponse"
 . F  S PSS("child")=$$CHILD^MXMLDOM(DOCHAND,1,PSS("child")) Q:PSS("child")=0  D
 .. S PSS("ELE")=$$NAME^MXMLDOM(DOCHAND,PSS("child"))
 .. I PSS("ELE")="RequestType" S PSS("RTYPE")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 .. I PSS("ELE")="packageTypeIen" S PSS("IEN")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 .. I PSS("ELE")="packageTypeName" S PSS("NAME")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 .. I PSS("ELE")="inactivationDate" S PSS("IDATE")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 Q
 ;
DRU ;DRUGUNIT
 ;
 I PSS("bodyName")="drugUnitSyncRequest" D
 . S PSS("child")=1,PSS("FILE")=50.607,(PSSTITLE,PST)="syncResponse"
 . F  S PSS("child")=$$CHILD^MXMLDOM(DOCHAND,1,PSS("child")) Q:PSS("child")=0  D
 .. S PSS("ELE")=$$NAME^MXMLDOM(DOCHAND,PSS("child"))
 .. I PSS("ELE")="RequestType" S PSS("RTYPE")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 .. I PSS("ELE")="drugUnitIen" S PSS("IEN")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 .. I PSS("ELE")="drugUnitName" S PSS("NAME")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 .. I PSS("ELE")="inactivationDate" S PSS("IDATE")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 Q
 ;
DIS ;DISPENSEUNIT
 I PSS("bodyName")="vaDispenseUnitSyncRequest" D
 . S PSS("child")=1,PSS("FILE")=50.64,(PSSTITLE,PST)="syncResponse"
 . F  S PSS("child")=$$CHILD^MXMLDOM(DOCHAND,1,PSS("child")) Q:PSS("child")=0  D
 .. S PSS("ELE")=$$NAME^MXMLDOM(DOCHAND,PSS("child"))
 .. I PSS("ELE")="RequestType" S PSS("RTYPE")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 .. I PSS("ELE")="vaDispenseUnitIen" S PSS("IEN")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 .. I PSS("ELE")="vaDispenseUnitName" S PSS("NAME")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 .. I PSS("ELE")="inactivationDate" S PSS("IDATE")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 Q
 ;
DRUI ;DRUGINGREDIENT
 ;
 I PSS("bodyName")="drugIngredientSyncRequest" D
 . S PSS("child")=1,PSS("FILE")=50.416,(PSSTITLE,PST)="syncResponse"
 . F  S PSS("child")=$$CHILD^MXMLDOM(DOCHAND,1,PSS("child")) Q:PSS("child")=0  D
 .. S PSS("ELE")=$$NAME^MXMLDOM(DOCHAND,PSS("child"))
 .. I PSS("ELE")="RequestType" S PSS("RTYPE")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 .. I PSS("ELE")="drugIngredientName" S PSS("NAME")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 .. I PSS("ELE")="ingredientIen" S PSS("IEN")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 .. I PSS("ELE")="primaryIngredient" S PSS("PRIMARY")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 .. I PSS("ELE")="inactivationDate" S PSS("INACTDATE")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 .. I PSS("ELE")="masterEntryForVuid" S PSS("MASTERVUID")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 .. I PSS("ELE")="vuid" S PSS("VUID")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 .. I PSS("ELE")="effectiveDateTimeRecord" D
 ... S DOCHAND1=PSS("child"),PSS("child1")=1
 ... F  S PSS("child1")=$$CHILD^MXMLDOM(DOCHAND,DOCHAND1,PSS("child1")) Q:PSS("child1")=0  D
 .... S PSS("ELE1")=$$NAME^MXMLDOM(DOCHAND,PSS("child1"))
 .... I PSS("ELE1")="effectiveDateTime" S PSS("EFFDATE")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child1"),"T",1)
 .... I PSS("ELE1")="status" S PSS("STATUS")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child1"),"T",1)
 Q
 ;
VAG ;VAGENERIC
 ;
 I PSS("bodyName")="vaGenericNameSyncRequest" D
 . S PSS("child")=1,PSS("FILE")=50.6,(PSSTITLE,PST)="syncResponse"
 . F  S PSS("child")=$$CHILD^MXMLDOM(DOCHAND,1,PSS("child")) Q:PSS("child")=0  D
 .. S PSS("ELE")=$$NAME^MXMLDOM(DOCHAND,PSS("child"))
 .. I PSS("ELE")="RequestType" S PSS("RTYPE")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 .. I PSS("ELE")="vaGenericNameIen" S PSS("IEN")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 .. I PSS("ELE")="vaGenericNameName" S PSS("NAME")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 .. I PSS("ELE")="masterEntryForVuid" S PSS("MASTERVUID")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 .. I PSS("ELE")="inactivationDate" S PSS("INACTDATE")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 .. I PSS("ELE")="vuid" S PSS("VUID")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 .. I PSS("ELE")="effectiveDateTimeRecord" D
 ... S DOCHAND1=PSS("child"),PSS("child1")=1
 ... F  S PSS("child1")=$$CHILD^MXMLDOM(DOCHAND,DOCHAND1,PSS("child1")) Q:PSS("child1")=0  D
 .... S PSS("ELE1")=$$NAME^MXMLDOM(DOCHAND,PSS("child1"))
 .... I PSS("ELE1")="effectiveDateTime" S PSS("EFFDATE")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child1"),"T",1)
 .... I PSS("ELE1")="status" S PSS("STATUS")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child1"),"T",1)
 ;
 Q
 ;
MIGR ;Process sync request
 D EN^PSSMIGRD(.PSS)
 ;
 Q:ERROR=1
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
 S XML2=PSS("xmlHeader")_"<"_PSSTITLE_PSS("xmlns")
 S XML2=XML2_PSS("xmlns:xsi")_">"_"<syncResponseType>"_"<status>Success</status>"
 S XML2=XML2_XMESS_"</syncResponseType>"_XIEN
 S XOBY=XML2_"</"_PSSTITLE_">"
 S ^TMP($J,"NDC1","XOBY")=XOBY
 ;
 ;
Q1 ; exit and clean-up
 ;K ^TMP("MXMLDOM",$J),^TMP($J)
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
 S PSS("xmlns")=" xmlns=""gov/va/med/pharmacy/peps/external/common/vo/inbound/sync/syncResponse"""
 ;S PSS("xmlns")=" xmlns=""gov/va/med/pharmacy/peps/external/common/vo/inbound/migration/"_PST_"/response"""
 S PSSOUT=PSS("xmlHeader")
 S PSSOUT=PSSOUT_"<"_PSSTITLE
 S PSSOUT=PSSOUT_" "_PSS("xmlns")
 S PSSOUT=PSSOUT_" "_PSS("xmlns:xsi")
 Q PSSOUT
 ;
TRASH ;**delete XML handle
 D DELETE^MXMLDOM(DOCHAND)
 Q
 ;
OUT(X) ;Error message 
 S FILE=PSSTITLE_".XML",ERROR=1,PSS("xmlResponse")=$$XMLBODY(.PSS)
 S XML2=PSS("xmlHeader")_"<syncResponse "_PSS("xmlns")
 S XML2=XML2_PSS("xmlns:xsi")_"><syncResponseType><status>Failure</status>"
 S XML2=XML2_"<message>"_X_"</message></syncResponseType></syncResponse>"
 S XOBY=XML2
 S ^TMP($J,"NDC1","OUT")=XOBY,ERROR=1
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
