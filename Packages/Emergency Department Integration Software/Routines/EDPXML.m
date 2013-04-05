EDPXML ;SLC/KCM - XML Array Utilities ;4/25/12 12:51pm
 ;;2.0;EMERGENCY DEPARTMENT;;May 2, 2012;Build 103
 ;
 Q
TOARR(SRC,DEST,WAITPAST) ; convert XML in global reference to global/local array
 ; SRC(n) contains the lines of an XML document
 ; DEST is return array, DEST(ELE,n,ELE,n....ATTR)= attribute value
 ;                       DEST(ELE,n,ELE,n,...0)=element text
 ; WAITPAST is node to wait for before adding nodes to DEST
 ;
 K ^TMP($J,"EDPXMLSRC") M ^TMP($J,"EDPXMLSRC")=SRC
 N STACK,CALLBACK,REF,CREF,WAITING
 S STACK=0 S WAITING=($G(WAITPAST)'="")
 S CALLBACK("STARTELEMENT")="STARTEL^EDPXML"
 S CALLBACK("ENDELEMENT")="ENDEL^EDPXML"
 S CALLBACK("CHARACTERS")="CHARS^EDPXML"
 D EN^MXMLPRSE($NA(^TMP($J,"EDPXMLSRC")),.CALLBACK,"W")
 K ^TMP($J,"EDPXMLSRC")
 Q
STARTEL(ELEMENT,ATTR) ; start element
 I WAITING,ELEMENT=WAITPAST S WAITING=0 Q
 Q:WAITING
 N I,X
 ; new stack level, remove former descendants
 S STACK=STACK+1 K STACK(STACK+1)
 S STACK(STACK,ELEMENT)=$G(STACK(STACK,ELEMENT))+1
 S REF(STACK)=""""_ELEMENT_""","_STACK(STACK,ELEMENT)_","
 S REF="DEST(" S I=0 F  S I=$O(REF(I)) Q:'I  Q:I>STACK  S REF=REF_REF(I)
 I $D(ATTR) S X="" F  S X=$O(ATTR(X)) Q:X=""  S @(REF_""""_X_""")")=ATTR(X)
 S CREF=$E(REF,1,$L(REF)-1)_",0)"
 Q
ENDEL(ELEMENT) ; end element
 Q:WAITING
 S STACK=STACK-1
 Q
CHARS(TXT) ; character data
 Q:WAITING  Q:'$D(CREF)  Q:TXT?.C  Q:TXT?." "
 S @CREF=TXT
 Q
 ;
TOXML(SOURCE,XMLDOC) ; convert array variable to XML document
 ; SOURCE is array to convert, SOURCE(ELE,n,ELE,n,...,ATTR)=attribuite value
 ;                             SOURCE(ELE,n,ELE,n,...,0)=element text
 ;                             SOURCE(ELE,n,ELE,n,...,#)=XML
 ; XMLDOC(n) contains the lines of the output XML document
 N LINE,TOP
 S LINE=0
 S TOP="" F  S TOP=$O(SOURCE(TOP)) Q:TOP=""  D BLDELEM("SOURCE",TOP)
 Q
BLDELEM(REF,ELEMENT) ; Build an XML element (attributes & value)
 N SEQ,SUB,VALUE,ATTRIB,LLINE,CHILDREN
 S SEQ=0 F  S SEQ=$O(@REF@(ELEMENT,SEQ)) Q:'SEQ  D
 . S LINE=LINE+1,LLINE=LINE,VALUE="",ATTRIB="",CHILDREN=0
 . S SUB="" F  S SUB=$O(@REF@(ELEMENT,SEQ,SUB)) Q:SUB=""  D
 . . I $D(@REF@(ELEMENT,SEQ,SUB))=1 D
 . . . I +SUB S CHILDREN=1,LINE=LINE+1,XMLDOC(LINE)=@REF@(ELEMENT,SEQ,SUB) Q
 . . . I SUB=0 S VALUE=@REF@(ELEMENT,SEQ,SUB) Q
 . . . I 'SUB S ATTRIB=ATTRIB_" "_SUB_"="""_@REF@(ELEMENT,SEQ,SUB)_"""" Q
 . . I $D(@REF@(ELEMENT,SEQ,SUB))>1 D
 . . . S CHILDREN=1
 . . . D BLDELEM($NA(@REF@(ELEMENT,SEQ)),SUB)
 . S XMLDOC(LLINE)="<"_ELEMENT_ATTRIB_$S(CHILDREN!$L(VALUE):">",1:"/>")_$$ESC^EDPX(VALUE)
 . I 'CHILDREN,$L(VALUE) S XMLDOC(LLINE)=XMLDOC(LLINE)_"</"_ELEMENT_">"
 . I CHILDREN S LINE=LINE+1,XMLDOC(LINE)="</"_ELEMENT_">"
 Q
 ;
TOXMLG(SOURCE,XMLDOC) ; convert array variable to XML document
 ; SOURCE is array to convert, SOURCE(ELE,n,ELE,n,...,ATTR)=attribuite value
 ;                             SOURCE(ELE,n,ELE,n,...,0)=element text
 ;                             SOURCE(ELE,n,ELE,n,...,#)=XML
 ; XMLDOC(n) contains the lines of the output XML document
 N LINE,TOP
 S LINE=0
 S TOP="" F  S TOP=$O(@SOURCE@(TOP)) Q:TOP=""  D BLDELEMG(SOURCE,TOP)
 Q
BLDELEMG(REF,ELEMENT) ; Build an XML element (attributes & value)
 N SEQ,SUB,VALUE,ATTRIB,LLINE,CHILDREN
 S SEQ=0 F  S SEQ=$O(@REF@(ELEMENT,SEQ)) Q:'SEQ  D
 . S LINE=LINE+1,LLINE=LINE,VALUE="",ATTRIB="",CHILDREN=0
 . S SUB="" F  S SUB=$O(@REF@(ELEMENT,SEQ,SUB)) Q:SUB=""  D
 . . I $D(@REF@(ELEMENT,SEQ,SUB))=1 D
 . . . I +SUB S CHILDREN=1,LINE=LINE+1,@XMLDOC@(LINE)=@REF@(ELEMENT,SEQ,SUB) Q
 . . . I SUB=0 S VALUE=@REF@(ELEMENT,SEQ,SUB) Q
 . . . I 'SUB S ATTRIB=ATTRIB_" "_SUB_"="""_@REF@(ELEMENT,SEQ,SUB)_"""" Q
 . . I $D(@REF@(ELEMENT,SEQ,SUB))>1 D
 . . . S CHILDREN=1
 . . . D BLDELEMG($NA(@REF@(ELEMENT,SEQ)),SUB)
 . S @XMLDOC@(LLINE)="<"_ELEMENT_ATTRIB_$S(CHILDREN!$L(VALUE):">",1:"/>")_$$ESC^EDPX(VALUE)
 . I 'CHILDREN,$L(VALUE) S @XMLDOC@(LLINE)=@XMLDOC@(LLINE)_"</"_ELEMENT_">"
 . I CHILDREN S LINE=LINE+1,@XMLDOC@(LINE)="</"_ELEMENT_">"
 Q 
 ;
 ; bwf: 12/19/2011 - commenting test logic for the time being.
 ;
 ;TESTXML ;
 ;N XMLIN,SKIP
 ;M XMLIN=^KCM("VitalRead") S SKIP="data"
 ;D TOARR(.XMLIN,.EDPARR,SKIP) ZW EDPARR
 ;Q
 ;TESTGBL ;
 ;D TOXML(.EDPARR,.XMLOUT) ZW XMLOUT
 ;Q
