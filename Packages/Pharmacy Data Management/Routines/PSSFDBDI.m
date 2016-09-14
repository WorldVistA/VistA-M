PSSFDBDI ;BIR/LE - Sends XML Request to PEPS via HWSC for Dose Information ;01/23/12
 ;;1.0;PHARMACY DATA MANAGEMENT;**160,175**;9/30/97;Build 9
 ;
 ;Reference to PSNDF(50.68 supported by DBIA 3735
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
 ;^TMP($J,"PSSFDBDI",PSSGCN,"minMax",ageLowInDays,ageHighInDays,1)=doseLow^doseLowUnit^doseHigh^doseHighUnit^doseFormLow^doseFormLowUnit^doseFormHigh^doseFormHighUnit
 ;^TMP($J,"PSSFDBDI",PSSGCN,"minMax",ageLowInDays,ageHighInDays,2)=maxDailyDose^maxDailyDoseUnit^maxDailyDoseForm^maxDailyDoseFormUnit^resultType^warningCode^bsaRequired^weightRequired
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
 I PSS("postResult") S PSS("result")=1 D PRSSTRM(PSS("restObject"),PSSGCN,.PSSOUT)
 S PSSOUT(0)=1
 I $D(^TMP($J,"OUT","EXCEPTION")) S PSSOUT(0)="-1^"_^TMP($J,"OUT","EXCEPTION") K ^TMP($J,"OUT","EXCEPTION"),^TMP($J,"PSSFDBDI")
 Q PSS("result")
 ;
PRSSTRM(RESTOBJ,PSSGCN,PSSOUT) ;  parse the XML into token
 ;  input: RESTOBJ--a rest object
 ; output: PSSOUT - array containing the list of route names for the given drug.
 ;
 ; parse the XML into tokens. the first part of the token is the type of node being read.
 ; the second part is the data--either the name of the node, or data. these fields are delimited using "<>".
 ; if the node is type attribute, each attribute is separated by a caret ("^").
 ;
 N AREADER
 S AREADER=$$GETREADR^PSSFDBRT(RESTOBJ)
 D PARSXML(AREADER,PSSGCN,.PSSOUT)
 Q
 ;
PARSXML(AREADER,PSSGCN,PSSOUT) ; extract the list of routes from XML results
 ;  input: AREADER-%XML.TextReader object.
 ;
 N DRGDESC,DRGFLG,ATOKEN,DTOKEN,NODETYPE,GCNSEQ,FDBDX,PSSDR,PSSMM,PSSOUT2,PSSSEQ,I,SEQ,SEQ2,SEQ3,SEQ4,TYP2,TYP3,LDAY,HDAY,FTYPE,MMSEQ,MMATR
 D GETFILE(.PSSDR,.PSSMM) S (PSSSEQ,MMSEQ,MMATR)=0
 F  D  Q:AREADER.EOF
 .S ATOKEN=$$GETTOKEN(AREADER)
 .I '$L(ATOKEN) Q
 .S NODETYPE=$P(ATOKEN,"<>"),ATOKEN=$P(ATOKEN,"<>",2)
 .Q:NODETYPE["exception"
 .; inside dosing attributes
 .I ATOKEN="dispensableDrugName" S DTOKEN="",DTOKEN=$$GETTOKEN(AREADER) S $P(PSSOUT2(GCNSEQ),"^",3)=$P(DTOKEN,"<>",2) Q
 .I ATOKEN="dispensableDrugDescription"  S DTOKEN="",DTOKEN=$$GETTOKEN(AREADER) S $P(PSSOUT2(GCNSEQ),"^",4)=$P(DTOKEN,"<>",2) Q
 .I NODETYPE="dosingInfo(attributes)" S FTYPE="doseRanges",GCNSEQ=$P($P(ATOKEN,"^",2),"=",2),FDBDX=$P($P(ATOKEN,"^",1),"=",2) S:$G(GCNSEQ)="999" GCNSEQ=$G(FDBDX),FDBDX="999" S PSSOUT2(GCNSEQ)=GCNSEQ_"^"_PSSGCN_"^^^"_FDBDX Q
 .I NODETYPE="doseRange(attributes)"  S (FIELD,FLDNAM,FLDDATA)="" S PSSSEQ=PSSSEQ+1,FTYPE="doseRanges" D 
 ..F I=1:1:4 S FIELD=$P(ATOKEN,"^",I),FLDNAM=$P(FIELD,"="),FLDDATA=$P(FIELD,"=",2) D SETARRAY
 ..D DOSE
 .I NODETYPE="minMax(attributes)" D
 ..S MMSEQ=MMSEQ+1,MMATR=1,FTYPE="minMax",LDAY=$P($P(ATOKEN,"^",1),"=",2),HDAY=$P($P(ATOKEN,"^",2),"=",2) D DOSE
 ;
 N FIRST,FLD2,FLD8,FLD7,FLD3
 S (FIRST,GCNSEQ,SEQ,SEQ2,SEQ3,SEQ4,FTYPE,TYP2,TYP3)="",FTYPE=0
 F  S GCNSEQ=$O(PSSOUT2(GCNSEQ)) Q:GCNSEQ=""  D
 .I '$G(FIRST),$D(PSSOUT2(GCNSEQ)) D
 ..S ^TMP($J,"PSSFDBDI",GCNSEQ,0)=PSSOUT2(GCNSEQ)
 ..S ^TMP($J,"PSSFDBDI","B",GCNSEQ)=$P(PSSOUT2(GCNSEQ),"^",3),FIRST=1
 ..F  S FTYPE=$O(PSSOUT2(GCNSEQ,FTYPE)) Q:FTYPE=""!(FTYPE="A")  F  S SEQ=$O(PSSOUT2(GCNSEQ,FTYPE,SEQ)) Q:SEQ=""  F  S SEQ2=$O(PSSOUT2(GCNSEQ,FTYPE,SEQ,SEQ2)) Q:SEQ2=""  D
 ...F  S SEQ3=$O(PSSOUT2(GCNSEQ,FTYPE,SEQ,SEQ2,SEQ3)) Q:SEQ3=""  D
 ....S ^TMP($J,"PSSFDBDI",GCNSEQ,FTYPE,SEQ,SEQ2,SEQ3)=PSSOUT2(GCNSEQ,FTYPE,SEQ,SEQ2,SEQ3)  I SEQ2=1,FTYPE="doseRanges" D SETXREF
 S ^TMP($J,"PSSFDBDI",0)="DOSING INFORMATION FOR A SPECIFIC DRUG^^"_(SEQ3)_"^"_(SEQ3)
 Q
 ;
SETXREF ;
 Q:FTYPE="minMax"
 N FLDS,FLD1
 S (FLDS,FLD3,FLD7,FLD8,FLD1)="",FLDS=PSSOUT2(GCNSEQ,FTYPE,SEQ,SEQ2,SEQ3) F I=1,3,7,8 S @("FLD"_I)=$P(FLDS,"^",I)
 S ^TMP($J,"PSSFDBDI","A",FLD3,FLD7,FLD8,SEQ)=FLD1
 S ^TMP($J,"PSSFDBDI","C",FLD7,FLD8,FLD3,SEQ)=FLD1
 Q
  ;
DOSE ; extract list of routes
 N ID,BNODE,BTOKEN,CTOKEN,CTYPE,ROUTNM,FIELD,OFLDNAM,FLDNAM,FLDDATA,I
 S FLDNAM=""
 F  D  Q:(CTOKEN="/doseRange"!(CTOKEN="/minMax"))!(AREADER.EOF)
 .S BTOKEN=$$GETTOKEN(AREADER)
 .Q:'$L(BTOKEN)
 .S CTYPE=$P(BTOKEN,"<>"),CTOKEN=$P(BTOKEN,"<>",2)
 .I CTOKEN="/doseRange" Q
 .I (CTOKEN="/minMax") Q
 .Q:CTYPE="endElement"&(BTOKEN="/"_FLDNAM)
 .I CTYPE="element" S FLDNAM="",FLDNAM=CTOKEN
 .I CTYPE="chars" S FLDDATA="",FLDDATA=CTOKEN D SETARRAY
 Q
 ;
SETARRAY ;set dose ranges array
 N ANODE,APIECE,FILENAME,FILENODE
 I '$G(MMATR) D  Q
 .S (FILENAME,APIECE,ANODE)="",FILENODE=$G(PSSDR(FLDNAM)) S:FILENODE'="" ANODE=$P(FILENODE,"^"),APIECE=$P(FILENODE,"^",2)
 .S:ANODE'="" $P(PSSOUT2(GCNSEQ,FTYPE,PSSSEQ,ANODE,0),"^",APIECE)=FLDDATA
 I $G(MMATR) D
 .S (FILENAME,APIECE,ANODE)="",FILENODE=$G(PSSMM(FLDNAM)) S:FILENODE'="" ANODE=$P(FILENODE,"^"),APIECE=$P(FILENODE,"^",2)
 .S:ANODE'="" $P(PSSOUT2(GCNSEQ,FTYPE,LDAY,HDAY,ANODE),"^",APIECE)=FLDDATA
 Q
 ;
GETTOKEN(READER) ; get a token at a time
 ;  input: AREADER-%XML.TextReader object
 ; Output: returns a token
 ;
 ;   this is the key to the parsing of the XML stream.
 ;   each element is parsed with its associated data (if any)
 ;   the nodetype is concatenated with "<>" with the Token
 ;   which can be the tag or the data.
 ;   for example each time is called return one of the following:
 N TOKEN,NODETYPE,SUBTOKEN,ALLTOKEN
 S TOKEN="",SUBTOKEN="",NODETYPE="",ALLTOKEN=""
 D
 .Q:READER.EOF
 .D READER.Read()  ; go to first node
 .Q:READER.EOF     ; try before and after read
 .;W !,READER.NodeTypeGet()
 .;S NODETYPE=READER.NodeTypeGet()
 .I READER.HasAttributes D
 ..S NODETYPE=READER.Name_"(attributes)"
 ..S TOKEN=$$GETATTS(READER)
 .I '$L(TOKEN) S NODETYPE=READER.NodeTypeGet() D
 ..I NODETYPE="element" S TOKEN=READER.Name Q
 ..I NODETYPE="chars" S TOKEN=READER.Value Q
 ..I NODETYPE="endelement" S TOKEN="/"_READER.Name Q
 ..I NODETYPE="comment" S TOKEN="^"
 ..I NODETYPE="processinginstruction" S TOKEN=READER.Value Q
 ..I NODETYPE="ignorablewhitespace" S TOKEN="^" Q
 ..I NODETYPE="startprefixmapping" S TOKEN=READER.Value Q
 ..I NODETYPE="warning" S TOKEN=READER.Value Q
 ..I '$L(TOKEN) S TOKEN="^"
 ..;
 .I $L(NODETYPE) S ALLTOKEN=NODETYPE_"<>"_TOKEN
 ;W !,"TOKEN="_ALLTOKEN
 Q ALLTOKEN
 ;
GETATTS(AREADER) ; get attributes
 ;  input: AREADER-%XML.TextReader object
 ; Output: returns the attributes
 ;
 N I,INDEX,TOKEN,SUBTOKEN,ATTRB
 S (TOKEN,SUBTOKEN)=""
 S INDEX=AREADER.AttributeCountGet()
 FOR I=1:1:INDEX D
 .S ATTRB=AREADER.MoveToAttributeIndex(I) D
 .S SUBTOKEN=AREADER.Name_"="_AREADER.Value
 .I '$L(TOKEN) S TOKEN=SUBTOKEN Q
 .S TOKEN=TOKEN_"^"_SUBTOKEN
 ;W !,"  ATT=",TOKEN
 Q TOKEN
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
