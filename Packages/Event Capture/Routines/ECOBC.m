ECOBC ;BP/CMF - Criteria Object
 ;;2.0;EVENT CAPTURE;**100**;8 May 96;Build 21
 ;@author  - Chris Flegel
 ;@date    - 17 May 2009
 ;@version - 1.0
 ;;
 Q
 ;; private methods
CLEAR(RESULT,HANDLE,PARAMS) ; restore criteria to default values
 D METHOD(.RESULT,HANDLE_".SetLastItem.0")
 D METHOD(.RESULT,HANDLE_".SetLastValue.")
 K @HANDLE@("CriteriaItem")
 K @HANDLE@("CriteriaValue")
 Q
 ;;
FIND(RESULT,HANDLE,PARAMS) ; return list that matches params
 ;be certain to set 'last' property to last found result
 ;RESULT.Count   = # of matching items found
 ;RESULT.Search  = actual string searched for
 ;RESULT.Pattern = the piece pattern used for result.item
 ;RESULT.Item.1  = 1st item found
 ;RESULT.Item.2  = 2nd item found...
 N EQUALS,ITEM,ITEMS,VALUE,NAME,OUT,RETURN,X ;,CONTAINS,BEGINS
 ;;;D PARSE("Handle",HANDLE)
 S VALUE=$S($G(PARAMS)'="":PARAMS,1:"~nil~")
 D METHOD(.NAME,HANDLE_".Get_namespace")
 S OUT=$$CREATE^ECOBL(NAME)
 S RESULT=OUT
 D PROPERTY^ECOBL(OUT,"Pu","Search",VALUE)
 D PROPERTY^ECOBL(OUT,"Pu","Result","0^No items found.")
 D METHOD(.EQUALS,HANDLE_".GetEquals")
 D:EQUALS="true"  Q
 .Q:'$D(@HANDLE@("CriteriaValue",VALUE))
 .S ITEM=0
 .S ITEMS=0
 .F  S ITEM=$O(@HANDLE@("CriteriaValue",VALUE,ITEM)) Q:ITEM=""  D
 ..S ITEMS=ITEMS+1
 ..S RETURN=$$ONRETURN(ITEM,VALUE)
 ..D METHOD^ECOBL(.X,OUT_".Add."_RETURN)
 ..D METHOD(.X,HANDLE_".SetLastItem."_ITEM)
 ..D METHOD(.X,HANDLE_".SetLastValue."_VALUE)
 ..Q
 .D METHOD(.X,OUT_".SetResult."_ITEMS_"^Item(s) found")
 .S RESULT=OUT
 .Q
 .;;
 ;;D METHOD(.CONTAINS,HANDLE_".GetContains")
 ;;D:CONTAINS="true" 
 ;;.Q
 ;;.;;
 ;;D METHOD(.BEGINS,HANDLE_".GetBeginsWith")
 ;;D:BEGINS="true" 
 ;;.Q
 ;;.;;
 S RESULT="-1^'Find' method not fully implemented yet"
 Q
 ;;
FIND1(RESULT,HANDLE,PARAMS) ; return first value that matches params
 N ITEM,VALUE
 S RESULT=""
 S VALUE=$G(PARAMS)
 Q:VALUE=""
 Q:'$D(@HANDLE@("CriteriaValue",VALUE))
 S ITEM=$O(@HANDLE@("CriteriaValue",VALUE,""))
 S RESULT=$$ONRETURN(ITEM,VALUE)
 Q
 ;;
FIRST(RESULT,HANDLE,PARAMS) ; return first item in sequence
 N X
 D METHOD(.X,HANDLE_".SetLastItem.0")
 D METHOD(.X,HANDLE_".SetLastValue.")
 D NEXT(.RESULT,HANDLE,PARAMS)
 Q
 ;;
INDEX(RESULT,HANDLE,PARAMS) ; params are item of parent collector
 N PARENT,ITEM,VALUE,NAME,COUNT,ARGUMENT,INDEXOF,CHILD
 ;;;D PARSE("Handle",HANDLE)
 D GET^ECOBL(.PARENT,HANDLE,"Pr","_collector")
 S ITEM=+PARAMS
 I ITEM<1 S RESULT="-1^Invalid item "_ITEM_" for index" Q
 ;kill old indices
 D
 .Q:'$D(@HANDLE@("CriteriaItem",ITEM))
 .S VALUE=$O(@HANDLE@("CriteriaItem",ITEM,""))
 .S VALUE=$S(VALUE="":"~nil~",1:VALUE)
 .K @HANDLE@("CriteriaItem",ITEM)
 .K @HANDLE@("CriteriaValue",VALUE,ITEM)
 ;set new indices
 D METHOD(.INDEXOF,HANDLE_".GetIndexOf")
 I INDEXOF="list" D
 .D GETITEM^ECOBL(.VALUE,PARENT,ITEM)
 .S VALUE=$S(VALUE="":"~nil~",1:VALUE)
 .Q
 E  D
 .D METHOD(.ARGUMENT,HANDLE_".GetArgument")
 .D GETITEM^ECOBL(.CHILD,PARENT,ITEM)
 .D METHOD^ECOB(.VALUE,CHILD_"."_ARGUMENT) ;generic call
 .S VALUE=$S(VALUE="":"~nil~",1:VALUE)
 .Q
 S @HANDLE@("CriteriaItem",ITEM,VALUE)=""
 S @HANDLE@("CriteriaValue",VALUE,ITEM)=""
 Q
 ;;
INFO(RESULT,HANDLE,PARAMS)  ;
 D INFO^ECOB2(.RESULT,HANDLE,PARAMS)
 Q
 ;;
LAST(RESULT,HANDLE,PARAMS)  ; return last referenced item
 ;to do: implement .object argument method calls
 N LASTITEM,LASTVALU,ONRETURN
 D METHOD(.LASTITEM,HANDLE_".GetLastItem")
 D METHOD(.LASTVALU,HANDLE_".GetLastValue")
 S RESULT=$$ONRETURN(LASTITEM,LASTVALU) ;NEXT_"^"_VALUE
 Q
 ;;
NEXT(RESULT,HANDLE,PARAMS) ; return next item^value in sequence
 ;be certain to set 'last' property to result
 N ARGUMENT,INDEXOF,LASTITEM,LASTVALU
 N NAME,COUNT,NEXT,VALUE,X
 D METHOD(.ARGUMENT,HANDLE_".GetArgument")
 D METHOD(.INDEXOF,HANDLE_".GetIndexOf")
 D METHOD(.LASTITEM,HANDLE_".GetLastItem")
 D METHOD(.LASTVALU,HANDLE_".GetLastValue")
 ;D METHOD(.LVALITEM,HANDLE_".GetLastValueItem")
 ;;;D PARSE("Handle",HANDLE)
 I INDEXOF="list" D  Q
 .S NEXT=$O(@HANDLE@("CriteriaItem",LASTITEM))
 .I NEXT="" S RESULT="-1^End of list" Q
 .S VALUE=$O(@HANDLE@("CriteriaItem",NEXT,""))
 .S RESULT=$$ONRETURN(NEXT,VALUE) ;NEXT_"^"_VALUE
 .D METHOD(.X,HANDLE_".SetLastItem."_NEXT)
 .D METHOD(.X,HANDLE_".SetLastValue."_VALUE)
 .;D METHOD(.X,HANDLE_".SetLastValueItem.")
 ;;
 I INDEXOF="value" D  Q
 .S VALUE=$O(@HANDLE@("CriteriaValue",LASTVALU))
 .;S VALUE=$O(@HANDLE@("CriteriaValue",LASTVALU,LVALITEM))
 .I VALUE="" S RESULT="-1^End of list" Q
 .S NEXT=$O(@HANDLE@("CriteriaValue",VALUE,""))
 .;S NEXT=$O(@HANDLE@("CriteriaValue",VALUE,LVALITEM))
 .S RESULT=$$ONRETURN(NEXT,VALUE) ;NEXT_"^"_VALUE
 .D METHOD(.X,HANDLE_".SetLastItem."_NEXT)
 .D METHOD(.X,HANDLE_".SetLastValue."_VALUE)
 .;D METHOD(.X,HANDLE_".SetLastValueItem."_LVALITEM)
 .Q
 ;;
 I INDEXOF="object" D
 .;to do: Get object handle (use _collector),
 .;         then call method represented by PARAMS
 .Q 
 S RESULT="-1^'Next' method not fully implemented"
 Q
 ;;
ONRETURN(ITEM,VALUE)  ;
 N ONRETURN,RESULT,PARENT
 S RESULT=ITEM_"^"_VALUE
 D METHOD(.ONRETURN,HANDLE_".GetOnReturn")
 I ONRETURN="value" Q VALUE
 I ONRETURN="item" Q ITEM
 I ONRETURN="handle" D  Q RESULT
 .D GET^ECOBL(.PARENT,HANDLE,"Pr","_collector")
 .D METHOD^ECOBL(.RESULT,PARENT_".GetItem."_ITEM)
 .Q
 ;;
PARSE(PARSE,VALUE)  ;
 D PARSE^ECOBL(PARSE,VALUE)
 Q
 ;;
PROPERTY(HANDLE,SCOPE,PROPERTY,VALUE)  ;
 D PROPERTY^ECOBL(HANDLE,SCOPE,PROPERTY,VALUE)
 Q
 ;;
REINDEX(RESULT,HANDLE) ; Reindex collection
 N PARENT,ITEM
 D GET^ECOBL(.PARENT,HANDLE,"Pr","_collector")
 ;;;D PARSE("Handle",PARENT)
 S ITEM=0
 F  S ITEM=$O(@HANDLE@("Pr","list",ITEM)) Q:+ITEM=0  D
 .D INDEX(.RESULT,HANDLE,ITEM)
 .Q
 Q
 ;;
SETARG(RESULT,HANDLE,PARAMS) ;set argument
 N VALUE,INDEXOF
 S VALUE=$G(PARAMS)
 S INDEXOF=$S(VALUE="":"list",1:"value")
 D SET^ECOBL(.RESULT,HANDLE,"Pu","Argument",VALUE)
 D SET^ECOBL(.RESULT,HANDLE,"Pu","IndexOf",INDEXOF)
 D REINDEX(.RESULT,HANDLE)
 Q
 ;;
SETIND(RESULT,HANDLE,PARAMS) ;set indexOf
 N VALUE,ARGUMENT
 S VALUE=$G(PARAMS)
 S VALUE=$S(VALUE="value":VALUE,1:"list")
 D SET^ECOBL(.RESULT,HANDLE,"Pu","IndexOf",VALUE)
 I VALUE="list" D SET^ECOBL(.RESULT,HANDLE,"Pu","Argument","~nil~")
 D REINDEX(.RESULT,HANDLE)
 Q
 ;;
SETRET(RESULT,HANDLE,PARAMS) ;set OnReturn
 N VALUE
 S VALUE=$G(PARAMS)
 S VALUE=$S(VALUE="value":VALUE,VALUE="handle":VALUE,1:"item")
 D SET^ECOBL(.RESULT,HANDLE,"Pu","OnReturn",VALUE)
 Q
 ;; protected methods
CREATE(NAME)  ;
 ; call parent first
 N HANDLE,X
 S HANDLE=$$CREATE^ECOB(NAME)
 ;;
 D SELF^ECOB(.X,HANDLE,"ECOBC","Criteria","METHOD^ECOBC(.RESULT,ARGUMENT)","ECOBC")
 ;;
 D PROPERTY(HANDLE,"Pr","_collector","")
 D PROPERTY(HANDLE,"Pu","Argument","~nil~")
 D PROPERTY(HANDLE,"Pu","BeginsWith","false")
 D PROPERTY(HANDLE,"Pu","Contains","false")
 D PROPERTY(HANDLE,"Pu","Equals","true")
 D PROPERTY(HANDLE,"Pu","IndexOf","list")
 D PROPERTY(HANDLE,"Pu","LastItem",0)
 D PROPERTY(HANDLE,"Pu","LastValue","")
 D PROPERTY(HANDLE,"Pu","LastValueItem","")
 D PROPERTY(HANDLE,"Pu","OnReturn","value")
 D PROPERTY(HANDLE,"Pu","Unique","false")
 ; complex properties last
 Q HANDLE
 ;;
DESTROY(HANDLE)  ;
 ; call parent last
 Q $$DESTROY^ECOB(HANDLE)
 ;;
METHOD(RESULT,ARGUMENT)  ;
 N HANDLE,METHOD,PARAMS
 D PARSE("Handle",ARGUMENT)
 D PARSE("Method",ARGUMENT)
 D PARSE("Params",ARGUMENT)
 I METHOD="Clear" D CLEAR(.RESULT,HANDLE,PARAMS) Q
 I METHOD="Find" D FIND(.RESULT,HANDLE,PARAMS) Q
 I METHOD="Find1" D FIND1(.RESULT,HANDLE,PARAMS) Q
 I METHOD="First" D FIRST(.RESULT,HANDLE,PARAMS) Q
 I METHOD="Index" D INDEX(.RESULT,HANDLE,PARAMS) Q
 I METHOD="Last" D LAST(.RESULT,HANDLE,PARAMS) Q
 I METHOD="Next" D NEXT(.RESULT,HANDLE,PARAMS) Q
 I METHOD="SetOnReturn" D SETRET(.RESULT,HANDLE,PARAMS) Q
 I METHOD="SetArgument" D SETARG(.RESULT,HANDLE,PARAMS) Q
    I METHOD="SetIndexOf" D SETIND(.RESULT,HANDLE,PARAMS) Q
 D METHOD^ECOB2(.RESULT,ARGUMENT)
 Q
 ;;
