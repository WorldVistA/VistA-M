ECOBU ;BP/CMF - Utility Object
 ;;2.0;EVENT CAPTURE;**100**;8 May 96;Build 21
 ;@author  - Chris Flegel
 ;@date    - 17 May 2009
 ;@version - 1.0
 ;;
 Q
 ;; private methods
HANDLERS(RESULT,HANDLE,METHOD,PARAMS) ;;
 ; find & execute handlers
 N PROPERTY,HANDLES,FOUND,HANDLER,EXECUTER
 S RESULT="-1^Invalid method"
 I $E(METHOD,1,3)="Get" D 
 .D PARSE("Get",METHOD)
 .S PARAMS=PROPERTY_"."_PARAMS
 .S METHOD="Get"
 .Q
 I $E(METHOD,1,3)="Set" D 
 .D PARSE("Set",METHOD)
 .S PARAMS=PROPERTY_"."_PARAMS
 .S METHOD="Set"
 .Q
 I $E(METHOD,1,4)="Show" D 
 .D PARSE("Show",METHOD)
 .S PARAMS=PROPERTY_"."_PARAMS
 .S METHOD="Show"
 .Q
 D METHOD(.HANDLER,HANDLE_".Methods.Find1."_METHOD)
 D METHOD^ECOBM(.EXECUTER,HANDLER_".GetHandler")
 D @EXECUTER
 Q
 ;;
OBM(RESULT,ARGUMENT) ;shortcut to method class
 D METHOD^ECOBM(.RESULT,ARGUMENT) Q
 ;;
OBP(RESULT,ARGUMENT) ;shortcut to property class
 D METHOD^ECOBP(.RESULT,ARGUMENT) Q
 ;;
OB2(RESULT,ARGUMENT) ;shortcut to utility class
 D METHOD^ECOB2(.RESULT,ARGUMENT) Q
 ;;
ECOB30(RESULT,HANDLE,PARAMS) ;handler for collect object
 N CHILD
 D GET^ECOB(.CHILD,HANDLE,"Pu","Collect")
 D METHOD^ECOB30(.RESULT,CHILD_"."_PARAMS)
 Q
 ;;
ECOBL(RESULT,HANDLE,METHOD,PARAMS) ;handler for simple list
 N CHILD
 D GET^ECOB(.CHILD,HANDLE,"Pu",METHOD)
 D METHOD^ECOBL(.RESULT,CHILD_"."_PARAMS)
 Q
 ;;
ECOBMC(RESULT,HANDLE,PARAMS) ;handler for method collection
 N CHILD
 D GET^ECOB(.CHILD,HANDLE,"Pu","Methods")
 D METHOD^ECOBMC(.RESULT,CHILD_"."_PARAMS)
 Q
 ;;
ECOBPC(RESULT,HANDLE,PARAMS) ;handler for property collection
 N CHILD
 D GET^ECOB(.CHILD,HANDLE,"Pu","Properties")
 D METHOD^ECOBPC(.RESULT,CHILD_"."_PARAMS)
 Q 
 ;;
ECOBM(RESULT,HANDLE,PARAMS) ;; pass-through
 D OBM(.RESULT,HANDLE_"."_PARAMS) Q
 ;;
ECOB2(RESULT,HANDLE,PARAMS) ;; pass-through
 D OB2(.RESULT,HANDLE_"."_PARAMS) Q
 ;;
ECOBP(RESULT,HANDLE,PARAMS) ; pass-through
 D OBP(.RESULT,HANDLE_"."_PARAMS) Q
 ;;
DIAGHDR(VALUE,WIDTH) ;;
 N I,J
 S J=WIDTH-$L(VALUE)-1
 W !," "_VALUE_" "
 F J=1:1:J W "-"
 W "+"
 Q
DIAGSGMT(VALUE,WIDTH) ;;
 N I,J,OUT,FILL
 S J=WIDTH-$L(VALUE)
 S OUT=" + "_VALUE_" "
 S FILL=""
 F J=1:1:J S FILL=FILL_"-"
 S OUT=$E(OUT_FILL,1,WIDTH)_" |"
 W !,OUT
 Q
DIAGATTR(VALUE,WIDTH) ;;
 N I,J,OUT,FILL
 S J=WIDTH-$L(VALUE)
 S OUT=" | * "_VALUE
 D:$L(VALUE)<WIDTH
 .S FILL=""
 .F J=1:1:J S FILL=FILL_" "
 .S OUT=$E(OUT_FILL,1,WIDTH)_" |"
 .Q
 W !,OUT
 Q
DIAGFTR(WIDTH) ;;
 N I,J,OUT,FILL
 S J=WIDTH
 S OUT=" + "
 S FILL=""
 F J=1:1:J S FILL=FILL_"-"
 S OUT=$E(OUT_FILL,1,J)_" +"
 W !,OUT
 Q
 ;;
    ;;protected methods
CLASS(RESULT,HANDLE,PARAMS) ;handler for class info display
 N JUSTIFY,OFFSET,X,METH,PROP,ITEM
 D PARSE("Offset",PARAMS)
 D SHOW^ECOB(.X,HANDLE,"Pu","_class",JUSTIFY)
 ;;
 D SHOW^ECOB(.X,HANDLE,"Pu","Methods",JUSTIFY)
 D METHOD(.X,HANDLE_".Methods.Info."_OFFSET)
 D SHOW^ECOB(.X,HANDLE,"Pu","Methods",JUSTIFY_"/")
 ;;
 D SHOW^ECOB(.X,HANDLE,"Pu","Properties",JUSTIFY)
 D METHOD(.X,HANDLE_".Properties.Info."_OFFSET)
 D SHOW^ECOB(.X,HANDLE,"Pu","Properties",JUSTIFY_"/")
 ;;
 D SHOW^ECOB(.X,HANDLE,"Pu","Root",JUSTIFY)
 D METHOD(.X,HANDLE_".Root.Info."_OFFSET)
 D SHOW^ECOB(.X,HANDLE,"Pu","Root",JUSTIFY_"/")
 ;;
 D SHOW^ECOB(.X,HANDLE,"Pu","_class",JUSTIFY_"/")
 S RESULT=1
 Q
 ;;
CLEAR(RESULT,HANDLE,PARAMS) ; restore object to default state
 N PROPERTY,DEFAULT,X
 D METHOD(.PROPERTY,HANDLE_".Properties.First")
 F  Q:PROPERTY="-1^End of list"  D
 .D OBP(.DEFAULT,PROPERTY_".GetDefaultValue")
 .D OBP(.X,PROPERTY_".SetValue."_DEFAULT)
 .D METHOD(.PROPERTY,HANDLE_".Properties.Next")
 S RESULT=1
 Q
 ;
DIAGRAM(RESULT,HANDLE,PARAMS) ; draw class diagram
 N CLASS,X,WIDTH,METHOD,PROPERTY,EXTEND,COLLECT,NAME
 D GET^ECOB(.CLASS,HANDLE,"Pu","_class")
 S X=$L(CLASS)+2
 S WIDTH=$S(X<20:20,X<40:40,X<60:60,1:70)
 D DIAGHDR(CLASS,WIDTH)
 ;;
 D DIAGSGMT("Methods",WIDTH)
 D METHOD(.METHOD,HANDLE_".Methods.First")
 F  Q:METHOD="-1^End of list"  D
 .D OBM(.NAME,METHOD_".GetName")
 .D DIAGATTR(NAME,WIDTH)
 .D METHOD(.METHOD,HANDLE_".Methods.Next")
 .Q
 ;;
 D DIAGSGMT("Properties",WIDTH)
 D METHOD(.PROPERTY,HANDLE_".Properties.First")
 F  Q:PROPERTY="-1^End of list"  D
 .D OBP(.NAME,PROPERTY_".GetName")
 .D DIAGATTR(NAME,WIDTH)
 .D METHOD(.PROPERTY,HANDLE_".Properties.Next")
 .Q
 ;;
 D DIAGSGMT("Extends",WIDTH)
 D METHOD(.EXTEND,HANDLE_".Root.First")
 F  Q:EXTEND="-1^End of list"  D
 .D:EXTEND'=CLASS DIAGATTR(EXTEND,WIDTH)
 .D METHOD(.EXTEND,HANDLE_".Root.Next")
 .Q
 D DIAGFTR(WIDTH)
 S RESULT=1
 Q
 ;
GET(RESULT,HANDLE,METHOD,PARAMS)  ;
 N PROPERTY,PROP
 S RESULT="-1^Invalid property"
 S PROPERTY=$P(PARAMS,".")
 D METHOD(.PROP,HANDLE_".Properties.Find1."_PROPERTY)
 D:PROP'="" OBP(.RESULT,PROP_".GetValue")
 Q
 ;;
INFO(RESULT,HANDLE,PARAMS) ;handler for business info display
 N JUSTIFY,OFFSET,PROPERTY
 D PARSE("Offset",PARAMS)
 W !,$J("Name : ",JUSTIFY),"Value"
 W !,$J("-----|-",JUSTIFY),"-----"
 D METHOD(.PROPERTY,HANDLE_".Properties.First")
 F  Q:PROPERTY="-1^End of list"  D
 .D OBP(.NAME,PROPERTY_".GetName")
 .D METHOD(.RESULT,HANDLE_".Show"_NAME_"."_JUSTIFY)
 .D METHOD(.PROPERTY,HANDLE_".Properties.Next")
 .Q
 S RESULT=1
 ;;
PARSE(PARSE,VALUE)  ;
 I PARSE="Get" D  Q
 .S PROPERTY=$P(VALUE,".",1)
 .S PROPERTY=$P(PROPERTY,"Get",2)
 .Q
 I PARSE="Handle" D  Q
 .S HANDLE=$P(VALUE,".")
 .Q
 I PARSE="Handle1" D  Q
 .S NAME=$P(VALUE,".",1)
 .S COUNT=$P(VALUE,".",2)
 .Q
 I PARSE="Justify" D  Q
 .S JUSTIFY=$S(+VALUE:+VALUE,1:0)
 .Q
 I PARSE="Method" D  Q
 .S METHOD=$P(VALUE,".",2)
 .Q
 I PARSE="Offset" D  Q
 .S JUSTIFY=$S(+VALUE:+VALUE,1:0)
 .S OFFSET=JUSTIFY+5
 .Q
 I PARSE="Params" D  Q
 .S PARAMS=$P(VALUE,".",3,99)
 .Q
 I PARSE="Set" D  Q
 .S PROPERTY=$P(VALUE,".",1)
 .S PROPERTY=$P(PROPERTY,"Set",2)
 .S VALUE=$P(VALUE,".",2)
 .Q
 I PARSE="Show" D  Q
 .S PROPERTY=$P(VALUE,".",1)
 .S PROPERTY=$P(PROPERTY,"Show",2)
 .Q
 Q
 ;
SET(RESULT,HANDLE,METHOD,PARAMS)  ;
 N PROPERTY,PROP
 S RESULT="-1^Invalid property"
 S PROPERTY=$P(PARAMS,".")
 S PARAMS=$P(PARAMS,".",2,99)
 D METHOD(.PROP,HANDLE_".Properties.Find1."_PROPERTY)
 D:PROP'="" OBP(.RESULT,PROP_".SetValue."_PARAMS)
 Q
 ;
SHOW(RESULT,HANDLE,METHOD,PARAMS) ; show a property
 N JUSTIFY,PROPERTY
 S PROPERTY=$P(PARAMS,".")
 S PARAMS=$P(PARAMS,".",2,99)
 D METHOD(.RESULT,HANDLE_".Get"_PROPERTY)
 Q:RESULT="-1^Invalid property"
 S JUSTIFY=$S(+PARAMS:+PARAMS,1:0)
 W !,$J("<"_PROPERTY_"> : ",JUSTIFY),RESULT
 Q
 ;;
 ;; public methods
CREATE(NAME)  ;
 ; call parent first
 N HANDLE,CHILD,METHOD,PROPERTY,X
 S HANDLE=$$CREATE^ECOB(NAME)
 D SELF^ECOB(.RESULT,HANDLE,"EC OBU UTILITY","Utility","METHOD^ECOBU(.RESULT,ARGUMENT)","ECOB")
 ;;
 S CHILD=$$CREATE^ECOB30(NAME)
 D COLLECT^ECOB(HANDLE,CHILD,"Pu","Collect")
 D METHOD^ECOB30(.X,CHILD_".SetCollector."_HANDLE)
 ;;
 S CHILD=$$CREATE^ECOBMC(NAME)
 D COLLECT^ECOB(HANDLE,CHILD,"Pu","Methods")
 ;; default ClassDiagram method
 D METHOD(.METHOD,HANDLE_".Methods.Add.ClassDiagram")
 D OBM(.X,METHOD_".SetAddedByClass.Utility")
 D OBM(.X,METHOD_".SetDescription.Displays diagram of the class.")
 D OBM(.X,METHOD_".SetHandler.DIAGRAM^ECOBU(.RESULT,HANDLE,PARAMS)")
 D OBM(.X,METHOD_".SetParams.")
 D OBM(.X,METHOD_".SetReturns.1")
 ;;
 ;; default ClassInfo method
 D METHOD(.METHOD,HANDLE_".Methods.Add.ClassInfo")
 D OBM(.X,METHOD_".SetAddedByClass.Utility")
 D OBM(.X,METHOD_".SetDescription.Displays information about the class.")
 D OBM(.X,METHOD_".SetHandler.CLASS^ECOBU(.RESULT,HANDLE,PARAMS)")
 D OBM(.X,METHOD_".SetParams.[Justify]")
 D OBM(.X,METHOD_".SetReturns.1")
 ;; default Clear method
 D METHOD(.METHOD,HANDLE_".Methods.Add.Clear")
 D OBM(.X,METHOD_".SetAddedByClass.Utility")
 D OBM(.X,METHOD_".SetDescription.Restores public attributes to default state.")
 D OBM(.X,METHOD_".SetHandler.CLEAR^ECOBU(.RESULT,HANDLE,PARAMS)")
 D OBM(.X,METHOD_".SetParams.")
 D OBM(.X,METHOD_".SetReturns.1")
 ;; default Get method
 D METHOD(.METHOD,HANDLE_".Methods.Add.Get")
 D OBM(.X,METHOD_".SetAddedByClass.Utility")
 D OBM(.X,METHOD_".SetDescription.Gets a property value.")
 D OBM(.X,METHOD_".SetHandler.GET^ECOBU(.RESULT,HANDLE,METHOD,PARAMS)")
 D OBM(.X,METHOD_".SetParams.Get[propertyName]")
 D OBM(.X,METHOD_".SetReturns.Property.Value")
 ;; default Set method
 D METHOD(.METHOD,HANDLE_".Methods.Add.Set")
 D OBM(.X,METHOD_".SetAddedByClass.Utility")
 D OBM(.X,METHOD_".SetDescription.Sets a property value.")
 D OBM(.X,METHOD_".SetHandler.SET^ECOBU(.RESULT,HANDLE,METHOD,PARAMS)")
 D OBM(.X,METHOD_".SetParams.Set[propertyName].[Value]")
 D OBM(.X,METHOD_".SetReturns.1 if successful, -1 otherwise")
 ;;
 D METHOD(.METHOD,HANDLE_".Methods.Add.Show")
 D OBM(.X,METHOD_".SetAddedByClass.Utility")
 D OBM(.X,METHOD_".SetDescription.Displays a property value.")
 D OBM(.X,METHOD_".SetHandler.SHOW^ECOBU(.RESULT,HANDLE,METHOD,PARAMS)")
 D OBM(.X,METHOD_".SetParams.[Justify]")
 D OBM(.X,METHOD_".SetReturns.[Property.Name] : [Property.Value]")
 ;;
 D METHOD(.METHOD,HANDLE_".Methods.Add.Info")
 D OBM(.X,METHOD_".SetAddedByClass.Utility")
 D OBM(.X,METHOD_".SetDescription.Displays business information.")
 D OBM(.X,METHOD_".SetHandler.INFO^ECOBU(.RESULT,HANDLE,PARAMS)")
 D OBM(.X,METHOD_".SetParams.[Justify]")
 D OBM(.X,METHOD_".SetReturns.1")
 ;;
 S CHILD=$$CREATE^ECOBPC(NAME)
 D COLLECT^ECOB(HANDLE,CHILD,"Pu","Properties")
 ;;
 D METHOD(.PROPERTY,HANDLE_".Properties.Add._this")
 D OBP(.X,PROPERTY_".SetAddedByClass.Utility")
 D OBP(.X,PROPERTY_".SetValue."_HANDLE)
 D OBP(.X,PROPERTY_".SetDefaultValue."_HANDLE)
 ;;
 S CHILD=$$CREATE^ECOBL(NAME)
 D COLLECT^ECOB(HANDLE,CHILD,"Pu","Root")
 ;;
 D METHOD(.X,HANDLE_".Root.Add.EC BASE")
 D METHOD(.X,HANDLE_".Root.Add.EC OBU UTILITY")
 ; complex properties last
 Q HANDLE
 ;;
DESTROY(HANDLE)  ;
 ; call parent last
 N CHILD
 D GET^ECOB(.CHILD,HANDLE,"Pu","Collect")
 D DESTROY^ECOB30(CHILD)
 D GET^ECOB(.CHILD,HANDLE,"Pu","Methods")
 D DESTROY^ECOBMC(CHILD)
 D GET^ECOB(.CHILD,HANDLE,"Pu","Properties")
 D DESTROY^ECOBPC(CHILD)
 D GET^ECOB(.CHILD,HANDLE,"Pu","Root")
 D DESTROY^ECOBL(CHILD)
 Q $$DESTROY^ECOB(HANDLE)
 ;;
FUNCTION(HANDLE,ARGUMENT)  ;
 ; argument=method.(additional.params....)
 N RESULT
 D METHOD(.RESULT,HANDLE_"."_ARGUMENT)
 Q RESULT
 ;
OUT(HANDLE,ARGUMENT)  ;
 ; argument=method.(additional.params....)
 N RESULT
 D METHOD(.RESULT,HANDLE_"."_ARGUMENT)
 Q RESULT
 ;
METHOD(RESULT,ARGUMENT)  ;
 ; argument=handle.method.(additional.params...)
 N HANDLE,METHOD,PARAMS
 D PARSE("Handle",ARGUMENT)
 D PARSE("Method",ARGUMENT)
 D PARSE("Params",ARGUMENT)
 I METHOD="Collect" D ECOB30(.RESULT,HANDLE,PARAMS) Q
 I METHOD="Methods" D ECOBMC(.RESULT,HANDLE,PARAMS) Q
 I METHOD="Properties" D ECOBPC(.RESULT,HANDLE,PARAMS) Q
 I METHOD="Root" D ECOBL(.RESULT,HANDLE,METHOD,PARAMS) Q
 I METHOD="mf" D ECOBM(.RESULT,HANDLE,PARAMS) Q
 I METHOD="of" D ECOB2(.RESULT,HANDLE,PARAMS) Q
 I METHOD="pf" D ECOBP(.RESULT,HANDLE,PARAMS) Q
 D HANDLERS(.RESULT,HANDLE,METHOD,PARAMS) Q
 ;;
