PSSFDBDI ;BIR/LE - Sends XML Request to PEPS via HWSC for Dose Information ;01/23/12
 ;;1.0;PHARMACY DATA MANAGEMENT;**160,175,201**;9/30/97;Build 25
 ;
 ; Reference to ^PSNDF(50.68 is supported by DBIA #3735
 ; Reference to ^MXMLDOM is supported by DBIA #3561
 ;
 ; this routine is responsible for performing dosing information queries against a drug database to retrieve dose information.
 ; the architecture parses the XML stream into tokens and is stored in a ^TMP($J,"PSSFDBDI")
 ;
 ;NEW file structure:
 ;^TMP($J,"PSSFDBDI",0)=file description^^total # sequences^total # sequences
 ;^TMP($J,"PSSFDBDI",PSSGCN,0)=GCNSEQNO evaluated^passed in GCNSEQNO^dispensableDrugName^dispensableDrugDescription^fdbdx
 ;^TMP($J,"PSSFDBDI",PSSGCN,doseRanges",SEQ,1,0)=custom^category^dosetypeid^dosetypedescription^doserouteid^doseroutedescription^agelowindays^agehigh indays
 ;^TMP($J,"PSSFDBDI",PSSGCN,doseRanges",SEQ,2,0)=hitIndicationID^hitindication description^indicationid^indicationdescription^^indicationidtype^resulttype^warningcode
 ;^TMP($J,"PSSFDBDI",PSSGCN,doseRanges",SEQ,3,0)=bsarequired^weightrequired^hepaticimpairement^renal impairement^loweliminationhalflife^higheliminationhalflife^halflifeunit^crclthreshold^crclthresholdunit
 ;^TMP($J,"PSSFDBDI",PSSGCN,doseRanges",SEQ,4,0)=durationlow^durationhigh^maxduration^frequencylow^frequencyhigh
 ;^TMP($J,"PSSFDBDI",PSSGCN,doseRanges",SEQ,5,0)=doselow^doselowunit^dosehigh^dosehighunit^doseformlow^doseformlowunit^doseformhigh^doseformhighunit
 ;^TMP($J,"PSSFDBDI",PSSGCN,doseRanges",SEQ,6,0)=maxsingledose^maxsingledoseunit^maxsingledoseform^maxsingledoseformunit^maxdailydose^maxdailydoseunit^maxdailydoseform^maxdailydoseformunit
 ;^TMP($J,"PSSFDBDI",PSSGCN,doseRanges",SEQ,7,0)maxlidfetimedose^maxlifetimedoseunit^maxlifetimedoseform^maxlifetimedoseformunit
 ;no longer built;^TMP($J,"PSSFDBDI",PSSGCN,"minMax",ageLowInDays,ageHighInDays,1)=doseLow^doseLowUnit^doseHigh^doseHighUnit^doseFormLow^doseFormLowUnit^doseFormHigh^doseFormHighUnit
 ;no longer built^TMP($J,"PSSFDBDI",PSSGCN,"minMax",ageLowInDays,ageHighInDays,2)=maxDailyDose^maxDailyDoseUnit^maxDailyDoseForm^maxDailyDoseFormUnit^resultType^warningCode^bsaRequired^weightRequired
 ;
 ; Cross References "doseRanges" nodes:
 ;^TMP($J,"PSSFDBDI","A",doseTypeId,ageLowInDays,ageHighInDays,SEQ)=custom
 ;^TMP($J,"PSSFDBDI","B",gcnSeqNo)=dispensableDrugName
 ;^TMP($J,"PSSFDBDI","C",ageLowInDays,ageHighInDays,doseTypeId,SEQ)=custom
 ;
 Q
EN(PSSGCN,PSSOUT) ;get dosing information based on GCNSEQNO
 ; input: PSSGCN  - GCCNSEQNO from file 50.68
 ;
 ; output: builds TMP file for dosing information
 ;             e.g.  ^TMP($J,"PSSFDBDI"
 ;                     PSSOUT(0) = 1 for successful
 ;                                           -1^error message  (when an error occurs:  example  "-1^ERROR #6059: Unable to open TCP/IP socket to server nn.n.nnn.nn:nnnn"
 ;
 K ^TMP($J,"PSSFDBDI")
 I PSSGCN=""!(PSSGCN=0) S PSSOUT="",PSSOUT(0)="-1^GCN sequence number is not defined." Q
 N PSSXML,PSSFDBDX,GCNSEQ,BASE,PSSRETR2,PSSFDBDN
 S PSSFDBDN=$$CHKSTAT^PSSDSFDB() I PSSFDBDN S PSSOUT(0)=PSSFDBDN Q
 S GCNSEQ=PSSGCN,BASE=$T(+0)_" DOSEINFO"
 S PSSXML=$$BLDXML(GCNSEQ)   ; build the xml request
RETRY ;Retry line tag
 D POST(PSSXML,PSSGCN,.PSSOUT)    ; post the request and process the results
 I $P($G(PSSOUT(0)),"^")=-1,'$G(PSSRETR2) K PSSOUT S PSSRETR2=1 H 3 G RETRY
 Q
 ;
BLDXML(GCNSEQ) ; build and return the XML request with drug information for given GCN sequence number
 ;  input: drug IEN from drug file (#50)
 ; output: returns the XML request for given GCN sequence number
 ;             Example:  where 22211 is the GCN Sequence number passed by reference at line tag EN above.
 ;                                PSSXML="<?xml version=""1.0"" encoding=""utf-8"" ?><dosingInfoRequest  xmlns:xsi=""http://www.w3.org/2001/XMLSchema-instance"" 
 ;                                         xsi:schemaLocation=""gov/va/med/pharmacy/peps/external/common/preencapsulation/vo/dosing/info/request dosingInfoSchemaInput.xsd"" 
 ;                                         xmlns=""gov/va/med/pharmacy/peps/external/common/preencapsulation/vo/dosing/info/request"">
 ;                                         <dosingInfo gcnSeqNo=""22211"" fdbdx=""999"" />
 ;                                         </dosingInfoRequest>"
 ;
 N DRUGTAG,ENDTAG,FDBDX,SPACE,TAG,SUBXML,SCHEMA,XMLNS,SPACE,DOSETAG
 S PSSXML="",SPACE=$C(32)
 ;
 ;xml header info - <?xml version="1.0" encoding="utf-8" ?>
 S PSSXML=PSSXML_$$XMLHDR^MXMLUTL
 ;
 S SPACE=$C(32)
 S SCHEMA="gov/va/med/pharmacy/peps/external/common/preencapsulation/vo/dosing/info/request dosingInfoSchemaInput.xsd"
 S XMLNS="gov/va/med/pharmacy/peps/external/common/preencapsulation/vo/dosing/info/request"
 S TAG="dosingInfoRequest"
 S SUBXML="<"_TAG_SPACE
 S SUBXML=SUBXML_$$ATRIBUTE^PSSHRCOM(SPACE_"xmlns:xsi","http://www.w3.org/2001/XMLSchema-instance")
 S SUBXML=SUBXML_$$ATRIBUTE^PSSHRCOM(SPACE_"xsi:schemaLocation",SCHEMA)
 S SUBXML=SUBXML_$$ATRIBUTE^PSSHRCOM(SPACE_"xmlns",XMLNS)
 S PSSXML=PSSXML_SUBXML_">"
 S DOSETAG="<dosingInfo",ENDTAG="/>",FDBDX=999
 S PSSXML=PSSXML_DOSETAG_SPACE_$$ATRIBUTE^PSSHRCOM("gcnSeqNo",GCNSEQ)_SPACE_$$ATRIBUTE^PSSHRCOM("fdbdx",FDBDX)_SPACE_ENDTAG
 S PSSXML=PSSXML_"</"_TAG_">"
 Q PSSXML
 ;
POST(XML,PSSGCN,PSSOUT) ; post the XML request to PEPS server and return the routes
 ;  input: XML request
 ; output: PSSOUT - array containing the list of route names for the given drug.
 ;
 N PSS,PSSERR,PSSFDBDI S PSSFDBDI=1
 N $ETRAP,$ESTACK
 ; Set error trap
 SET $ETRAP="DO ERROR^PSSHTTP"
 K ^TMP($J,"OUT")    ; if exists from previous runs, posting would not execute.
 ;
 S PSS("server")="PEPS"
 S PSS("webserviceName")="DOSING_INFO"
 S PSS("path")="dosinginfo"
 S PSS("parameterName")="xmlRequest"
 S PSS("parameterValue")=XML
 ;
 ; get instance of client REST request object
 SET PSS("restObject")=$$GETREST^XOBWLIB(PSS("webserviceName"),PSS("server"))
 IF $DATA(^TMP($JOB,"OUT","EXCEPTION"))>0 S PSSOUT(0)="-1^"_^TMP($JOB,"OUT","EXCEPTION") K ^TMP($JOB,"OUT","EXCEPTION") Q PSSOUT
 ;
 ; insert XML as parameter
 DO PSS("restObject").InsertFormData(PSS("parameterName"),PSS("parameterValue"))
 IF $DATA(^TMP($JOB,"OUT","EXCEPTION"))>0 S PSSOUT(0)="-1^"_^TMP($JOB,"OUT","EXCEPTION") K ^TMP($JOB,"OUT","EXCEPTION") QUIT PSSOUT
 ;
 ; execute HTTP Post method
 SET PSS("postResult")=$$POST^XOBWLIB(PSS("restObject"),PSS("path"),.PSSERR)
 IF $DATA(^TMP($JOB,"OUT","EXCEPTION"))>0 S PSSOUT(0)="-1^"_^TMP($JOB,"OUT","EXCEPTION") K ^TMP($JOB,"OUT","EXCEPTION") QUIT PSSOUT
 ;
 ; error handling
 DO:'PSS("postResult")
 . SET PSSOUT(0)=-1_U_"Unable to make http request."
 . SET PSS("result")=0
 . QUIT
 ;
 ; if every thing is ok parse the returned xml result
 D:PSS("postResult")
 .S PSS("result")=##class(gov.va.med.pre.ws.XMLHandler).getHandleToXmlDoc(PSS("restObject").HttpResponse.Data, .DOCHAND) 
 .S PSSOUT(0)=0 ; this will be set to 1 if non-null route text value(s) are found in line tag PARSRTE
 .D PARSXML(DOCHAND,PSSGCN,.PSSOUT)
 .Q
 S PSSOUT(0)=1
 I $D(^TMP($J,"OUT","EXCEPTION")) S PSSOUT(0)="-1^"_^TMP($J,"OUT","EXCEPTION") K ^TMP($J,"OUT","EXCEPTION"),^TMP($J,"PSSFDBDI")
 ; Clean up after using the handle
 D DELETE^MXMLDOM(DOCHAND)
 K ^TMP($J,"OUT XML")
 Q PSS("result")
 ;
PARSXML(DOCHAND,PSSGCN,PSSOUT) ; read result
 ; @DOCHAND = Handle to XML Document
 ; @PSSOUT  = output array
 S PSS("rootName")=$$NAME^MXMLDOM(DOCHAND,1)
 S PSS("child")=0
 F  S PSS("child")=$$CHILD^MXMLDOM(DOCHAND,1,PSS("child")) Q:PSS("child")=0  D 
 .S PSS("childName")=$$NAME^MXMLDOM(DOCHAND,PSS("child"))
 .D:PSS("childName")="dosingInfo" PARSDOIN(DOCHAND,+PSSGCN,PSS("child"),.PSSOUT)
 Q
 ;
PARSDOIN(DOCHAND,PSSGCN,NODE,PSSOUT) ; parse dosingInfo element
 ; @DOCHAND = Handle to XML Document
 ; @NODE    = Document node
 ; @PSSOUT  = output array
 N PSS,PSSDR,PSSMM,PSSOUT2
 D GETFILE(.PSSDR,.PSSMM)
 D READDOIN(DOCHAND,PSSGCN,NODE,.PSSOUT,.PSSOUT2)
 S PSS("child")=0
 F  S PSS("child")=$$CHILD^MXMLDOM(DOCHAND,NODE,PSS("child")) Q:PSS("child")=0  D 
 .S PSS("childName")=$$NAME^MXMLDOM(DOCHAND,PSS("child"))
 .D:PSS("childName")="doseRanges" PARSDORG(DOCHAND,PSSGCN,PSS("child"),.PSSOUT,.PSSOUT2,.PSSDR)
 .;D:PSS("childName")="minMaxResults" PARSDOMM(DOCHAND,PSSGCN,PSS("child"),.PSSOUT,.PSSOUT2,.PSSMM)
 .;D:PSS("childName")="neonatalDoseRanges" PARSDONN(DOCHAND,PSSGCN,PSS("child"),.PSSOUT)
 .D:PSS("childName")="dispensableDrugName" READDODN(DOCHAND,PSSGCN,PSS("child"),.PSSOUT,.PSSOUT2)
 .D:PSS("childName")="dispensableDrugDescription" READDODD(DOCHAND,PSSGCN,PSS("child"),.PSSOUT,.PSSOUT2)
 D SETXREFS(.PSSOUT2)
 M ^TMP($J,"PSSFDBDI")=PSSOUT2
 Q
 ;
READDOIN(DOCHAND,PSSGCN,NODE,PSSOUT,PSSOUT2) ; read dosingInfo attributes
 ; @DOCHAND = Handle to XML Document
 ; @NODE    = Document node
 ; @PSSOUT  = output array
 ; @PSSOUT2 = output array for building ^tmp
 N PSS
 S PSS("attr")=""
 F  S PSS("attr")=$$ATTRIB^MXMLDOM(DOCHAND,NODE,PSS("attr")) Q:PSS("attr")=""  D 
 .I (PSS("attr"))="fdbdx" D  Q
 ..S PSS("fdbdx")=$$VALUE^MXMLDOM(DOCHAND,NODE,PSS("attr"))
 ..S $P(PSSOUT2(PSSGCN,0),U,5)=PSS("fdbdx")
 .I (PSS("attr"))="gcnSeqNo" D  Q
 ..S PSS("gcnSeqNo")=$$VALUE^MXMLDOM(DOCHAND,NODE,PSS("attr"))
 ..S $P(PSSOUT2(PSSGCN,0),U)=PSS("gcnSeqNo")
 S $P(PSSOUT2(PSSGCN,0),U,2)=PSSGCN
 Q
 ;
PARSDORG(DOCHAND,PSSGCN,NODE,PSSOUT,PSSOUT2,PSSDR) ; parse doseRange element
 ; @DOCHAND = Handle to XML Document
 ; @PSSGCN  = GCN passed in to API
 ; @NODE    = Document node
 ; @PSSOUT  = output array
 ; @PSSOUT2 = output array for building ^tmp
 ; @PSSDR   = array used for finding element with ^tmp node locations
 N PSS
 S PSS("child")=0
 F  S PSS("child")=$$CHILD^MXMLDOM(DOCHAND,NODE,PSS("child")) Q:PSS("child")=0  D 
 .S PSS("childName")=$$NAME^MXMLDOM(DOCHAND,PSS("child"))
 .S PSSDR(0)=PSSDR(0)+1
 .D:PSS("childName")="doseRange" 
 ..D READDORG(DOCHAND,PSSGCN,PSS("child"),.PSSOUT,.PSSOUT2,.PSSDR)
 ..D PARSDORC(DOCHAND,PSSGCN,PSS("child"),.PSSOUT,.PSSOUT2,.PSSDR)
 Q
 ;
READDORG(DOCHAND,PSSGCN,NODE,PSSOUT,PSSOUT2,PSSDR) ; read doseRange attributes
 ; @DOCHAND = Handle to XML Document
 ; @PSSGCN  = GCN passed in to API
 ; @NODE    = Document node
 ; @PSSOUT  = output array
 ; @PSSOUT2 = output array for building ^tmp
 ; @PSSDR   = array used for finding element with ^tmp node locations
 N PSS
 S PSS("attr")=""
 F  S PSS("attr")=$$ATTRIB^MXMLDOM(DOCHAND,NODE,PSS("attr")) Q:PSS("attr")=""  D:$D(PSSDR(PSS("attr"))) 
 .N ANODE,APIECE
 .S ANODE=$P(PSSDR(PSS("attr")),U,1)
 .Q:ANODE=""
 .S APIECE=$P(PSSDR(PSS("attr")),U,2)
 .Q:APIECE=""
 .S $P(PSSOUT2(PSSGCN,"doseRanges",PSSDR(0),ANODE,0),U,APIECE)=$$VALUE^MXMLDOM(DOCHAND,NODE,PSS("attr"))
 Q
 ;
PARSDORC(DOCHAND,PSSGCN,NODE,PSSOUT,PSSOUT2,PSSDR) ; parse doseRange child element
 ; @DOCHAND = Handle to XML Document
 ; @PSSGCN  = GCN passed in to API
 ; @NODE    = Document node
 ; @PSSOUT  = output array
 ; @PSSOUT2 = output array for building ^tmp
 ; @PSSDR   = array used for finding element with ^tmp node locations
 N PSS
 S PSS("child")=0
 F  S PSS("child")=$$CHILD^MXMLDOM(DOCHAND,NODE,PSS("child")) Q:PSS("child")=0  D 
 .S PSS("childName")=$$NAME^MXMLDOM(DOCHAND,PSS("child"))
 .D:$D(PSSDR(PSS("childName")))
 ..N ANODE,APIECE
 ..S ANODE=$P(PSSDR(PSS("childName")),U,1)
 ..Q:ANODE=""
 ..S APIECE=$P(PSSDR(PSS("childName")),U,2)
 ..Q:APIECE=""
 ..S $P(PSSOUT2(PSSGCN,"doseRanges",PSSDR(0),ANODE,0),U,APIECE)=$$GETTEXT^PSSHRCOM(DOCHAND,PSS("child"))
 Q
 ;
PARSDOMM(DOCHAND,PSSGCN,NODE,PSSOUT,PSSOUT2,PSSMM) ; parse minMaxResults element ; not implemented as of PSS*1*201
 ; @DOCHAND = Handle to XML Document
 ; @PSSGCN  = GCN passed in to API
 ; @NODE    = Document node
 ; @PSSOUT  = output array
 ; @PSSOUT2 = output array for building ^tmp
 ; @PSSMM   = array used for finding element with ^tmp node locations
 Q
 N PSS
 S PSS("child")=0
 F  S PSS("child")=$$CHILD^MXMLDOM(DOCHAND,NODE,PSS("child")) Q:PSS("child")=0  D 
 .S PSS("childName")=$$NAME^MXMLDOM(DOCHAND,PSS("child"))
 .;W !?6,PSS("child")_" : "_PSS("childName")
 Q
 ;
PARSDONN(DOCHAND,PSSGCN,NODE,PSSOUT) ; parse neonatalDoseRanges element ; not implemented as of PSS*1*201
 ; @DOCHAND = Handle to XML Document
 ; @PSSGCN  = GCN passed in to API
 ; @NODE    = Document node
 ; @PSSOUT  = output array
 Q
 N PSS
 S PSS("child")=0
 F  S PSS("child")=$$CHILD^MXMLDOM(DOCHAND,NODE,PSS("child")) Q:PSS("child")=0  D 
 .S PSS("childName")=$$NAME^MXMLDOM(DOCHAND,PSS("child"))
 .;W !?6,PSS("child")_" : "_PSS("childName")
 Q
 ;
READDODN(DOCHAND,PSSGCN,NODE,PSSOUT,PSSOUT2) ; read dispensableDrugName element
 ; @DOCHAND = Handle to XML Document
 ; @PSSGCN  = GCN passed in to API
 ; @NODE    = Document node
 ; @PSSOUT  = output array
 ; @PSSOUT2 = output array for building ^tmp
 N PSS
 S PSS("childText")=$$GETTEXT^PSSHRCOM(DOCHAND,NODE)
 D:PSS("childText")'="" 
 .S $P(PSSOUT2(PSSGCN,0),U,3)=PSS("childText")
 Q
 ;
READDODD(DOCHAND,PSSGCN,NODE,PSSOUT,PSSOUT2) ; read dispensableDrugDescription element
 ; @DOCHAND = Handle to XML Document
 ; @PSSGCN  = GCN passed in to API
 ; @NODE    = Document node
 ; @PSSOUT  = output array
 ; @PSSOUT2 = output array for building ^tmp
 N PSS
 S PSS("childText")=$$GETTEXT^PSSHRCOM(DOCHAND,NODE)
 D:PSS("childText")'="" 
 .S $P(PSSOUT2(PSSGCN,0),U,4)=PSS("childText")
 Q
 ;
SETXREFS(PSSOUT2) ; set "A","B","C", zero node cross references & values
 N FIRST,FLD2,FLD8,FLD7,FLD3,PSSSORT
 S (FIRST,GCNSEQ,SEQ,SEQ2,SEQ3,SEQ4,FTYPE,TYP2,TYP3)="",FTYPE=0
 M PSSSORT=PSSOUT2
 F  S GCNSEQ=$O(PSSOUT2(GCNSEQ)) Q:GCNSEQ=""  D
 .I '$G(FIRST),$D(PSSOUT2(GCNSEQ)) D 
 ..S PSSSORT("B",GCNSEQ)=$P(PSSOUT2(GCNSEQ,0),"^",3)
 ..S FIRST=1
 ..F  S FTYPE=$O(PSSOUT2(GCNSEQ,FTYPE)) Q:FTYPE=""!(FTYPE="A")  D 
 ...F  S SEQ=$O(PSSOUT2(GCNSEQ,FTYPE,SEQ)) Q:SEQ=""  D 
 ....F  S SEQ2=$O(PSSOUT2(GCNSEQ,FTYPE,SEQ,SEQ2)) Q:SEQ2=""  D
 .....F  S SEQ3=$O(PSSOUT2(GCNSEQ,FTYPE,SEQ,SEQ2,SEQ3)) Q:SEQ3=""  D
 ......I SEQ2=1,FTYPE="doseRanges" D 
 .......N FLDS,FLD1
 .......S (FLDS,FLD3,FLD7,FLD8,FLD1)=""
 .......S FLDS=PSSOUT2(GCNSEQ,FTYPE,SEQ,SEQ2,SEQ3)
 .......F I=1,3,7,8 S @("FLD"_I)=$P(FLDS,"^",I)
 .......S PSSSORT("A",FLD3,FLD7,FLD8,SEQ)=FLD1
 .......S PSSSORT("C",FLD7,FLD8,FLD3,SEQ)=FLD1
 S PSSSORT(0)="DOSING INFORMATION FOR A SPECIFIC DRUG^^1^1"
 M PSSOUT2=PSSSORT
 Q
 ;
GETFILE(PSSDR,PSSMM) ;
 N I,PSSTYPE,PSSFILE,PSSFLD,PSSNODE,PSSPIECE
 F I=1:1 S PSSFILE=$P($T(FILE+I),";;",2,99) Q:PSSFILE=""  D
 .S PSSTYPE=$P(PSSFILE,";"),PSSFLD=$P(PSSFILE,";",2),PSSNODE=$P(PSSFILE,";",3),PSSPIECE=$P(PSSFILE,";",4)
 .I PSSTYPE="" S PSSDR(PSSFLD)=PSSNODE_"^"_PSSPIECE
 .I PSSTYPE="MM" S PSSMM(PSSFLD)=PSSNODE_"^"_PSSPIECE
 Q
 ;
FILE ;file structure for the temp file for each data field imported from FDB
 ;;;0
 ;;;custom;1;1
 ;;;category;1;2
 ;;;doseTypeId;1;3
 ;;;doseTypeDescription;1;4
 ;;;doseRouteId;1;5
 ;;;intlDoseRouteDescription;1;6
 ;;;ageLowInDays;1;7
 ;;;ageHighInDays;1;8
 ;;;hitIndicationId;2;1
 ;;;hitIndicationDescription;2;2
 ;;;indicationId;2;3
 ;;;indicationDescription;2;4
 ;;;indicationIdType;2;5
 ;;;resultType;2;6
 ;;;warningCode;2;7
 ;;;bsaRequired;3;1
 ;;;weightRequired;3;2
 ;;;hepaticImpairment;3;3
 ;;;renalImpairment;3;4
 ;;;lowEliminationHalfLife;3;5
 ;;;highEliminationHalfLife;3;6
 ;;;halfLifeUnit;3;7
 ;;;crclThreshold;3;8
 ;;;crclThresholdUnit;3;9
 ;;;durationLow;4;1
 ;;;durationHigh;4;2
 ;;;maxDuration;4;3
 ;;;frequencyLow;4;4
 ;;;frequencyHigh;4;5
 ;;;doseLow;5;1
 ;;;doseLowUnit;5;2
 ;;;doseHigh;5;3
 ;;;doseHighUnit;5;4
 ;;;doseFormLow;5;5
 ;;;doseFormLowUnit;5;6
 ;;;doseFormHigh;5;7
 ;;;doseFormHighUnit;5;8
 ;;;maxSingleDose;6;1
 ;;;maxSingleDoseUnit;6;2
 ;;;maxSingleDoseForm;6;3
 ;;;maxSingleDoseFormUnit;6;4
 ;;;maxDailyDose6;5
 ;;;maxDailyDoseUnit;6;6
 ;;;maxDailyDoseForm;6;7
 ;;;maxDailyDoseFormUnit;6;8
 ;;;maxLifetimeDose;7;1
 ;;;maxLifetimeDoseUnit;7;2
 ;;;maxLifetimeDoseForm;7;3
 ;;;maxLifetimeDoseFormUnit;7;4
 ;;MM;0
 ;;MM;doseLow;1;1
 ;;MM;doseLowUnit;1;2
 ;;MM;doseHigh;1;3
 ;;MM;doseHighUnit;1;4
 ;;MM;doseFormLow;1;5
 ;;MM;doseFormLowUnit;1;6
 ;;MM;doseFormHigh;1;7
 ;;MM;doseFormHighUnit;1;8
 ;;MM;maxDailyDose;2;1
 ;;MM;maxDailyDoseUnit;2;2
 ;;MM;maxDailyDoseForm;2;3
 ;;MM;maxDailyDoseFormUnit;2;4
 ;;MM;resultType;2;5
 ;;MM;warningCode;2;6
 ;;MM;bsaRequired;2;7
 ;;MM;weightRequired;2;8
