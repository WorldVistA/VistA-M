PSSMIGR ;AJF - Receives and Process XML message from PEPS; 10/12/2011 1905
 ;;1.0;PHARMACY ENTERPRISE PRODUCT SYSTEM;;;Build 35
 ;;
 ; Start of Migration code
 ;
 ; Modified Copy of routine PSSXML
 ;;
MIGR2(XOBY,PSSMSG) ;Entry point into routine
 N X,Y,DIR,FILE,DOCHAND,XMLFILE,VAL,LEN,INPUT,OUTCNT,PSS
 N RERR,PSSEOF,EOF,FNUM,FNAME,FNAME1
 S PSSEOF=0,PSS("xmlResponse")=$$XMLBODY(.PSS)
 S XML=PSS("xmlHeader")_"<drugMigrationResponse"_PSS("xmlns:xsi")
 S XML=XML_PSS("xsi:schemaLocation")_PSS("xmlns")_">"_PSS("respHead")
 S XML=XML_"<drugUnits><drugUnitsIen>12</drugUnitsIen><name>5ML</name>"
 S XML=XML_"<inactivationDate>20080219</inactivationDate></drugUnits></drugMigrationResponse>"
 S XOBY=XML
 Q
 ;
MIGR(XOBY,PSSMSG) ;Entry point into routine
 N IEN,MIEN,CNT,OUT,RCNT,XML2,VAL
 ;
 D DT^DICRW S U="^",OUTCNT=0
 ;
 S OUT=$NA(^UTILITY($J,"OUT")) K ^UTILITY($J),^TMP($J,"XML OUT")
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
 ;
 ;**retrieve parent node attributes
 S PSS("body")=$$PARENT^MXMLDOM(DOCHAND,2)
 S PSS("bodyName")=$$NAME^MXMLDOM(DOCHAND,PSS("body"))
 S PSS("status")=$$VALUE^MXMLDOM(DOCHAND,PSS("body"),"status")
 S PSS("pepsIdNumber")=$$VALUE^MXMLDOM(DOCHAND,PSS("body"),"pepsIdNumber")
 ;
 I PSS("bodyName")="drugMigrationRequest" D
 . S PSS("child")=2
 . F  S PSS("child")=$$CHILD^MXMLDOM(DOCHAND,2,PSS("child")) Q:PSS("child")=0  D
 .. S PSS("ELE")=$$NAME^MXMLDOM(DOCHAND,PSS("child"))
 .. I PSS("ELE")="ndfmsFile" S PSS("FILE")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 .. I PSS("ELE")="startingIen" S PSS("IEN")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 .. I PSS("ELE")="numElements" S PSS("SNUM")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 .. I PSS("ELE")="type" S PSS("TYPE")=^TMP("MXMLDOM",$J,DOCHAND,PSS("child"),"T",1)
 ;
 ;
 D EN^PSSMIGR1(PSS("FILE"),PSS("IEN"),PSS("SNUM"),PSS("TYPE"))
 Q:$D(RERR)=1
 ;
 S RCNT=PSS("SNUM"),PSSEOF=+$G(^TMP($J,PSS("FILE"),"EOF"))
 ;**generate XML response message
 ;
 S PSS("xmlResponse")=$$XMLBODY(.PSS)
 ;
 ;**store value in VistALink return parameter
 ;
 ;
 ;
 ;Write the XML response message to a new file
 S FILE=FNAME
 S XML2=PSS("xmlHeader")_"<drugMigrationResponse"_PSS("xmlns:xsi")
 S XML2=XML2_PSS("xsi:schemaLocation")_PSS("xmlns")_">"_PSS("respHead")
 S IEN="",CNT=0
 F  S IEN=$O(^TMP($J,FNUM,PSS("TYPE"),IEN)) Q:IEN=""  D
 . I IEN="" S EOF=1,RCNT=CNT Q
 .S XML2=XML2_"<"_FNAME1_">"
 . S XML2=XML2_^TMP($J,FNUM,PSS("TYPE"),IEN)
 .S MIEN=0
 .F  S MIEN=$O(^TMP($J,FNUM,PSS("TYPE"),IEN,MIEN)) Q:MIEN=""  D
 .. S XML2=XML2_^TMP($J,FNUM,PSS("TYPE"),IEN,MIEN)
 .S XML2=XML2_"</"_FNAME1_">"
 S XOBY=XML2_"</drugMigrationResponse>"
 ;
 ; exit and clean-up
 K ^TMP($J,FNUM),^TMP("MXMLDOM",$J)
 Q
 ;
GFILE ;Get file path and name 
 S DIR(0)="F" ;Free text Input
 S DIR("A")="Enter Directory (path) and File Name"
 S DIR("?")=""
 S DIR("?",1)="**********************************************************"
 S DIR("?",2)="Enter the Path and File Name to where the File is Located."
 S DIR("?",3)="  example:  c:\tmp\test.xml"
 S DIR("?",4)="Enter ""^"" to Exit"
 S DIR("?")="**********************************************************"
 D ^DIR W ! K DIR Q:X[U!(X']"")
 Q
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
 ;S PSS("xsi:schemaLocation")="xsi:schemaLocation=""gov/va/med/pharmacy/peps/external/common/vo/inbound/migration/data/response ../../../schema/migration/drugMigrationResponse.xsd"""
 S PSS("xsi:schemaLocation")=" "
 S PSS("xmlns")="xmlns=""gov/va/med/pharmacy/peps/external/common/vo/inbound/migration/data/response"""
 S PSS("elementFormDefault")="elementFormDefault=""qualified"""
 S PSS("attributeFormDefault")="attributeFormDefault=""unqualified"""
 S PSS("respHead")="<responseHeader><endOfFile>"_PSSEOF_"</endOfFile></responseHeader>"
 ;
 S PSSOUT=PSS("xmlHeader")
 S PSSOUT=PSSOUT_"<drugMigrationResponse"
 S PSSOUT=PSSOUT_" "_PSS("xmlns:xsi")
 S PSSOUT=PSSOUT_" "_PSS("xsi:schemaLocation")
 S PSSOUT=PSSOUT_" "_PSS("xmlns")
 S PSSOUT=PSSOUT_" "_PSS("elementFormDefault")
 S PSSOUT=PSSOUT_" "_PSS("attributeFormDefault")_">"
 S PSSOUT=PSSOUT_" "_PSS("respHead")
 Q PSSOUT
 ;
TRASH ;**delete XML handle
 D DELETE^MXMLDOM(DOCHAND)
 Q
 ;
OUT(X) S OUTCNT=OUTCNT+1,@OUT@(OUTCNT)=X,PSSEOF=+$G(^TMP($J,PSS("FILE"),"EOF"))
 S FILE=FNAME,RERR=1,PSS("xmlResponse")=$$XMLBODY(.PSS)
 S XML2=PSS("xmlHeader")_"<drugMigrationResponse"_PSS("xmlns:xsi")
 S XML2=XML2_PSS("xsi:schemaLocation")_PSS("xmlns")_">"_PSS("respHead")
 S XML2=XML2_"<invalidRequest>"_X_"</invalidRequest>"_"</drugMigrationResponse>"
 S XOBY=XML2
 Q
 ;
PRSTRING(XML,NWARRY) ;**parses the incoming xml string coming back from PEPS
 ;;
 ;XML is the xml string that is passed by PEPS. 
 ;It must be parsed into an array that is usable by MXML Kernel routines. 
 ;;
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
DATE(Y)  ;RETURN A DATE
 I Y X ^DD("DD")
 Q Y
