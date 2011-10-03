ECOBPC ;BP/CMF - Properties object
 ;;2.0;EVENT CAPTURE;**100**;8 May 96;Build 21
 ;@author  - Chris Flegel
 ;@date    - 17 May 2009
 ;@version - 1.0
 ;;
 Q
 ;;private methods
ADD(RESULT,HANDLE,VALUE) ; add Property object to list
 N NAME,CHILD,ITEM,PROP
 D METHOD(.NAME,HANDLE_".Get_namespace")
 S CHILD=$$CREATE^ECOBP(NAME)
 D COLLECT^ECOBL(.ITEM,HANDLE,CHILD)
 S PROP("Name")=$P(VALUE,".")
    D METHOD^ECOBP(.RESULT,CHILD_".SetName."_PROP("Name"))
 ;D METHOD^ECOBP(.RESULT,CHILD_".SetName."_VALUE)
 D METHOD(.X,HANDLE_".Criteria.Index."_ITEM)
 ;support for property types
 S PROP("Type")=$P(VALUE,".",2)
 D:PROP("Type")'=""
 .S PROP("Build")=$$GET^XPAR("PKG","ECOB PROPERTY TYPE",PROP("Type"),"E")
 .Q:PROP("Build")=""
 .S PROP("Tag")=$P(PROP("Build"),".")
 .S PROP("Routine")=$P(PROP("Build"),".",2)
 .S PROP("Execute")=PROP("Tag")_U_PROP("Routine")
 .Q:$T(@$P(PROP("Execute"),"("))=""
 .Q:$P(PROP("Execute"),"(",2)'="HANDLE,CHILD)"
 .D @PROP("Execute")
 .Q
 S RESULT=CHILD
 Q
 ;;
INFO(RESULT,HANDLE,PARAMS) ; view property details
 N PROPERTY,JUSTIFY,OFFSET
 D PARSE("Offset",PARAMS)
 D METHOD(.PROPERTY,HANDLE_".First")
 F  Q:PROPERTY="-1^End of list"  D
 .D METHOD^ECOBP(.RESULT,PROPERTY_".ShowName."_JUSTIFY)
 .D METHOD^ECOBP(.RESULT,PROPERTY_".ShowValue."_OFFSET)
 .D METHOD^ECOBP(.RESULT,PROPERTY_".ShowDefaultValue."_OFFSET)
 .D METHOD(.PROPERTY,HANDLE_".Next")
 .Q
 Q
 ;;
PARSE(PARSE,VALUE)  ;
 D PARSE^ECOBL(PARSE,VALUE) ; parent method
 Q
 ;;
PROPERTY(HANDLE,SCOPE,PROPERTY,VALUE) ; parent method
 D PROPERTY^ECOBL(HANDLE,SCOPE,PROPERTY,VALUE)
 Q
 ;;
 ;; public methods
CREATE(NAME)  ;
 ; call parent first
 N HANDLE,X
 S HANDLE=$$CREATE^ECOBL(NAME)
 ;;
 D SELF^ECOB(.X,HANDLE,"Properties","Properties","METHOD^ECOBMC(.RESULT,ARGUMENT)","ECOBL")
 ;;
 D METHOD(.X,HANDLE_".Criteria.SetArgument.GetName")
 D METHOD(.X,HANDLE_".Criteria.SetOnReturn.handle")
 Q HANDLE
 ;;
DESTROY(HANDLE)  ;
 ; call parent last
 N CHILD
 D METHOD(.CHILD,HANDLE_".First")
 F  Q:+CHILD=-1  D
 .D DESTROY^ECOBP(CHILD)
 .D METHOD(.CHILD,HANDLE_".Next")
 .Q
 Q $$DESTROY^ECOBL(HANDLE)
 ;;
METHOD(RESULT,ARGUMENT)  ;
 ; argument= handle.method.(additional.params...)
 N HANDLE,METHOD,PARAMS
 D PARSE("Handle",ARGUMENT)
 D PARSE("Method",ARGUMENT)
 D PARSE("Params",ARGUMENT)
 I METHOD="Add" D ADD(.RESULT,HANDLE,PARAMS) Q
 I METHOD="Info" D INFO(.RESULT,HANDLE,PARAMS) Q
 D METHOD^ECOBL(.RESULT,ARGUMENT)
 Q
 ;;
