EDPQLW ;SLC/KCM - Retrieve Log Entry for Worksheet ;2/28/12 08:33am
 ;;2.0;EMERGENCY DEPARTMENT;;May 2, 2012;Build 103
 ;
LOAD(CTXT,ARRAY) ; create XML for log entry
 N LOG S LOG=CTXT("log")
 N AREA S AREA=$P(^EDP(230,LOG,0),U,3)
 N EDPTIME S EDPTIME=$$NOW^XLFDT
 N EDPNOVAL S EDPNOVAL=+$O(^EDPB(233.1,"B","edp.reserved.novalue",0))
 N X,X0,X1,X3
 ;
 L +^EDP(230,LOG):3
 S X0=^EDP(230,LOG,0),X1=$G(^(1)),X3=$G(^(3))
 D XMLTS("loadTS",$$NOW^XLFDT)
 ;S X("loadTS")=$$NOW^XLFDT
 L -^EDP(230,LOG)
 ;
 D XMLPTR("log",LOG,"")
 D XMLBOOL("closed",$P(X0,U,7))
 D XMLTS("inTS",$P(X0,U,8))
 D XMLTS("outTS",$P(X0,U,9))
 D XMLCODE("arrival",$P(X0,U,10))
 D XMLPTR("visit",$P(X0,U,12),"")
 N CLIN S CLIN=$P(X0,U,14)
 I CLIN D XMLPTR("clinic",CLIN,$P($G(^SC(CLIN,0)),U))
 D XMLTEXT("complaint",$P(X1,U,1))
 D XMLTEXT("compLong",$G(^EDP(230,LOG,2)))
 D XMLCODE("status",$P(X3,U,2))
 D XMLCODE("acuity",$P(X3,U,3))
 D XMLPTR("bed",$P(X3,U,4),$P($G(^EDPB(231.8,+$P(X3,U,4),0)),U,6))
 D XMLPERS("md",$P(X3,U,5))
 D XMLPERS("nurse",$P(X3,U,6))
 D XMLPERS("res",$P(X3,U,7))
 D XMLTEXT("comment",$P(X3,U,8))
 D XMLCODE("delay",$P(X1,U,5))
 D XMLCODE("disposition",$P(X1,U,2))
 D XMLTEXT("required",$$REQ^EDPQLE(.X))
 N CURBED S CURBED=$P(X3,U,4)
 Q
REFS(AREA) ; create XML for log entry references
 Q
XMLCODE(ELEMENT,ID) ; add XML node for coded value
 Q:'ID  Q:ID=EDPNOVAL
 N ECODE S ECODE=$P($G(^EDPB(233.1,ID,0)),U,2)  ;TODO: lookup site name
 S ARRAY(ELEMENT,1,"id")=ID
 S:$L(ECODE) ARRAY(ELEMENT,1,"name")=ECODE
 ;D XMLOUT(ELEMENT,"id",ID,ECODE)
 Q
XMLPERS(ELEMENT,ID) ; add XML node for person
 Q:'ID
 N NAME S NAME=$P($G(^VA(200,ID,0)),U)
 S ARRAY(ELEMENT,1,"id")=ID
 S:$L(NAME) ARRAY(ELEMENT,1,"name")=NAME
 ;D XMLOUT(ELEMENT,"id",ID,$P($G(^VA(200,ID,0)),U))
 Q
XMLPTR(ELEMENT,ID,NAME) ; add XML node for a pointer value
 S ARRAY(ELEMENT,1,"id")=ID
 S:$L(NAME) ARRAY(ELEMENT,1,"name")=NAME
 ;D XMLOUT(ELEMENT,"id",ID,NAME)
 Q
XMLTEXT(ELEMENT,TEXT) ; add XML node for a text value
 S ARRAY(ELEMENT,1,0)=TEXT
 ;D XMLOUT(ELEMENT,"","",TEXT)
 Q
XMLTS(ELEMENT,TS) ; add XML node for a date/time
 S ARRAY(ELEMENT,1,"fm")=TS
 ;D XMLOUT(ELEMENT,"fm",TS,"")
 Q
XMLBOOL(ELEMENT,VAL) ; add XML node for a boolean
 S ARRAY(ELEMENT,1,"value")=$S(+VAL:"true",1:"false")
 Q
XMLOUT(ELEMENT,ATTRNM,ATTRVAL,TEXT) ; add XML
 N X
 I $L(ATTRNM) D
 . S X="<"_ELEMENT_" "_ATTRNM_"="""_$$ESC^EDPX(ATTRVAL)_""""
 E  D
 . S X="<"_ELEMENT
 S X=X_$S($L(TEXT):">"_TEXT_"</"_ELEMENT_">",1:"/>")
 D XML^EDPX(X)
 Q
