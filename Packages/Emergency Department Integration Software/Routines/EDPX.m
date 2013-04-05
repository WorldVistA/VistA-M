EDPX ;SLC/KCM - Common Utilities ;4/25/12 12:51pm
 ;;2.0;EMERGENCY DEPARTMENT;;May 2, 2012;Build 103
 ;
ESC(X) ; Escape for XML transmission
 ; Q $ZCONVERT(X,"O","HTML")  ; uncomment for fastest performance on Cache
 ;
 N I,Y,QOT S QOT=""""
 S Y=$P(X,"&") F I=2:1:$L(X,"&") S Y=Y_"&amp;"_$P(X,"&",I)
 S X=Y,Y=$P(X,"<") F I=2:1:$L(X,"<") S Y=Y_"&lt;"_$P(X,"<",I)
 S X=Y,Y=$P(X,">") F I=2:1:$L(X,">") S Y=Y_"&gt;"_$P(X,">",I)
 S X=Y,Y=$P(X,"'") F I=2:1:$L(X,"'") S Y=Y_"&apos;"_$P(X,"'",I)
 S X=Y,Y=$P(X,QOT) F I=2:1:$L(X,QOT) S Y=Y_"&quot;"_$P(X,QOT,I)
 Q Y
 ;
UES(X) ; Unescape XML
 Q X  ; java side is unescaping this already
 ; Q $ZCONVERT(X,"I","HTML")
 ;
UESREQ(REQ) ; Unescape HTTP post
 N I,X
 S X="" F  S X=$O(REQ(X)) Q:X=""  D
 . S I=0 F  S I=$O(REQ(X,I)) Q:'I  D
 . . S REQ(X,I)=$$UES(REQ(X,I))
 Q
VAL(X,R) ; Returns parameter value or null
 ; HTTP passes HTML-escaped values in an array as REC(param,1)
 Q $G(R(X,1))
 ;
NVPARSE(LST,IN) ; Parses tab delimited name-value pairs into array
 N I,X,TAB,NM,VAL
 S TAB=$C(9)
 F I=1:1:$L(IN,TAB) S X=$P(IN,TAB,I),NM=$P(X,"="),VAL=$P(X,"=",2,999) S:$L(NM) LST(NM)=VAL
 Q
XMLS(TAG,DATA,LBL) ; Return XML node as <TAG data="9" label="XXX" />
 Q "<"_TAG_" data="""_$$ESC(DATA)_""" label="""_$$ESC(LBL)_""" />"
 ;
XMLA(TAG,ATT,END) ; Return XML node as <TAG att1="a" att2="b"... />
 N NODE S NODE="<"_TAG_" "
 N X
 S X="" F  S X=$O(ATT(X)) Q:X=""  I $L(ATT(X)) S NODE=NODE_X_"="""_$$ESC(ATT(X))_""" "
 S NODE=NODE_$G(END,"/")_">"
 Q NODE
 ;
XMLE(SRC) ; Append list to XML array as elements
 N X,NODE
 S X="" F  S X=$O(SRC(X)) Q:X=""  D
 . S NODE="<"_X_">"_$$ESC(SRC(X))_"</"_X_">"
 . D XML(NODE)
 Q
XML(X) ; Add a line of XML to be returned
 S EDPXML=$G(EDPXML)+1
 S EDPXML(EDPXML)=X
 Q
CODE(X) ; Return internal value for a code
 Q $O(^EDPB(233.1,"B",X,0))
 ;
SAVERR(TYP,ERR) ; Output a save error
 D XML^EDPX("<save status='"_TYP_"' >"_ERR_"</save>")
 Q
MSG(MSG) ; Write out error message
 I MSG=1       S X="some error"
 I MSG=2300001 S X="Station Number is missing"
 I MSG=2300002 S X="Patient is already active in log"
 I MSG=2300003 S X="Unable to create lock for new record"
 I MSG=2300004 S X="Error creating new record"
 I MSG=2300005 S X="Error creating sub-record"
 I MSG=2300006 S X="Missing log record"
 I MSG=2300007 S X="Missing log IEN"
 I MSG=2300008 S X="Error updating record"
 I MSG=2300009 S X="Error updating sub-record"
 I MSG=2300010 S X="Command missing or not recognized:  "
 I MSG=2300011 S X="Unknown report type"
 I MSG=2300012 S X="Missing or invalid date range"
 I MSG=2300013 S X="Shift times not defined for this site"
 I MSG=2300014 S X="Name missing"
 I MSG=2300015 S X="Unable to lock record"
 I MSG=2300016 S X="The selected room/area is now occupied."
 I MSG=2300017 S X="Report too big, unable to task."
 I MSG=2300018 S X="Required parameters missing or invalid."
 Q $$ESC^EDPX(X)
