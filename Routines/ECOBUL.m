ECOBUL ;BP/CMF - List Utility object
 ;;2.0;EVENT CAPTURE;**100**;8 May 96;Build 21
 ;@author  - Chris Flegel
 ;@date    - 17 May 2009
 ;@version - 1.0
 ;;
 Q
 ;;protected methods
ADD(RESULT,HANDLE,PARAMS) ; add simple list item
 D METHOD(.RESULT,HANDLE_".List.Add."_PARAMS)
 Q
 ;;
CLEAR(RESULT,HANDLE,PARAMS) ; restore object to default state
 D CLEAR^ECOBU(.RESULT,HANDLE,PARAMS)  ; parent method
 D METHOD(.RESULT,HANDLE_".List.Clear")
 Q
 ;;
COLLECT(RESULT,HANDLE,CHILD) ; add a child object to the list
 N ITEM
 D ADD(.ITEM,HANDLE,CHILD)
 S @HANDLE@("Pr","list","Handle",CHILD)=ITEM
 S RESULT=ITEM
 Q
 ;;
FIRST(RESULT,HANDLE,PARAMS)  ;
 D METHOD(.RESULT,HANDLE_".List.Criteria.First")
 Q
 ;;
FIND(RESULT,HANDLE,PARAMS)  ;
 D METHOD(.RESULT,HANDLE_".List.Criteria.Find."_PARAMS)
 Q
 ;;
FIND1(RESULT,HANDLE,PARAMS)  ;
 D METHOD(.RESULT,HANDLE_".List.Criteria.Find1."_PARAMS)
 Q
 ;;
GET(RESULT,HANDLE,SCOPE,PROPERTY)  ;
 ; if unique get methods, call them first, else call parent
 D GET^ECOB(.RESULT,HANDLE,SCOPE,PROPERTY)
 Q
    ;;
GETITEM(RESULT,HANDLE,ITEM) ; get simple list item
 D METHOD(.RESULT,HANDLE_".List.GetItem."_ITEM)
 Q
 ;;
INFO(RESULT,HANDLE,PARAMS)  ;
 N LIST,JUSTIFY,OFFSET
 D PARSE("Offset",PARAMS)
 D INFO^ECOBU(.RESULT,HANDLE,PARAMS)  ; parent method
 D METHOD^ECOB2(.LIST,HANDLE_".GetList")
 D METHOD^ECOBL(.RESULT,LIST_".Info."_JUSTIFY)
 Q
 ;;
ISHANDLE(RESULT,HANDLE,PARAMS) ; is value a collected handle
 D METHOD(.RESULT,HANDLE_".List.IsHandle."_PARAMS)
 Q
 ;
LAST(RESULT,HANDLE,PARAMS) ; get the last referenced item from the list
 D METHOD(.RESULT,HANDLE_".List.Criteria.Last")
 Q
 ;
NEXT(RESULT,HANDLE,PARAMS) ; get the next item from the list
 D METHOD(.RESULT,HANDLE_".List.Criteria.Next")
 Q
 ;;
SETITEM(RESULT,HANDLE,PARAMS) ; set simple list item
 D METHOD(.RESULT,HANDLE_".List.SetItem."_PARAMS)
 Q
 ;;
PARSE(PARSE,VALUE)  ;
 D PARSE^ECOBL(PARSE,VALUE)
 Q
 ;;
ECOBL(RESULT,HANDLE,ARGUMENT) ; handler for the actual list object
 N CHILD
 D METHOD(.CHILD,HANDLE_".GetList")
 D METHOD^ECOBL(.RESULT,CHILD_"."_ARGUMENT)
 Q
 ;;
OB2(RESULT,ARGUMENT) ;short cut to primitive object
 D METHOD^ECOB2(.RESULT,ARGUMENT) Q
 ;;
OBM(RESULT,ARGUMENT) ;short cut to method object
 D METHOD^ECOBM(.RESULT,ARGUMENT) Q
 ;;
 ;; public methods
CREATE(NAME) ; call parent first
 N HANDLE,CHILD,X
 S HANDLE=$$CREATE^ECOBU(NAME)
 ;;
 D METHOD(.X,HANDLE_".of.Set_name.List Utility")
 D METHOD(.X,HANDLE_".of.Set_class.EC OBU UTILITY LIST")
 D METHOD(.X,HANDLE_".of.Set_routine.METHOD^ECOBUL(.RESULT,ARGUMENT)")
 D METHOD(.X,HANDLE_".Root.Add.EC OBU UTILITY LIST")
 ;;
 D METHOD(.CHILD,HANDLE_".Methods.Add.Add")
 D METHOD(.X,CHILD_".mf.SetAddedByClass.List Utility")
 D METHOD(.X,CHILD_".mf.SetDescription.Default Add for list objects.")
 D METHOD(.X,CHILD_".mf.SetHandler.ADD^ECOBUL(.RESULT,HANDLE,PARAMS)")
 D METHOD(.X,CHILD_".mf.SetParams.Value ... to be added")
 D METHOD(.X,CHILD_".mf.SetReturns.Item # added to the list")
    ;;
 D METHOD(.CHILD,HANDLE_".Methods.Override.Clear")
 D METHOD(.X,CHILD_".mf.SetAddedByClass.List Utility")
 D METHOD(.X,CHILD_".mf.SetDescription.Restore object to default state.")
 D METHOD(.X,CHILD_".mf.SetHandler.CLEAR^ECOBUL(.RESULT,HANDLE,PARAMS)")
 D METHOD(.X,CHILD_".mf.SetParams.")
 D METHOD(.X,CHILD_".mf.SetReturns.1")
 ;;
 D METHOD(.CHILD,HANDLE_".Methods.Add.Find")
 D METHOD(.X,CHILD_".mf.SetAddedByClass.List Utility")
 D METHOD(.X,CHILD_".mf.SetDescription.Default Find for list objects.")
 D METHOD(.X,CHILD_".mf.SetHandler.FIND^ECOBUL(.RESULT,HANDLE,PARAMS)")
 D METHOD(.X,CHILD_".mf.SetParams.Value ... what to look for")
 D METHOD(.X,CHILD_".mf.SetReturns.Array of matches")
 ;
 D METHOD(.CHILD,HANDLE_".Methods.Add.Find1")
 D METHOD(.X,CHILD_".mf.SetAddedByClass.List Utility")
 D METHOD(.X,CHILD_".mf.SetDescription.Default Find1 for list objects.")
 D METHOD(.X,CHILD_".mf.SetHandler.FIND1^ECOBUL(.RESULT,HANDLE,PARAMS)")
 D METHOD(.X,CHILD_".mf.SetParams.Value ... what to look for")
 D METHOD(.X,CHILD_".mf.SetReturns.First matching value")
 ;
 D METHOD(.CHILD,HANDLE_".Methods.Add.First")
 D METHOD(.X,CHILD_".mf.SetAddedByClass.List Utility")
 D METHOD(.X,CHILD_".mf.SetDescription.Default First for list objects.")
 D METHOD(.X,CHILD_".mf.SetHandler.FIRST^ECOBUL(.RESULT,HANDLE,PARAMS)")
 D METHOD(.X,CHILD_".mf.SetParams.")
 D METHOD(.X,CHILD_".mf.SetReturns.Handle, Item or Value of first object")
 ;
 D METHOD(.CHILD,HANDLE_".Methods.Add.GetItem")
 D METHOD(.X,CHILD_".mf.SetAddedByClass.List Utility")
 D METHOD(.X,CHILD_".mf.SetDescription.Default GetItem for list objects.")
 D METHOD(.X,CHILD_".mf.SetHandler.GETITEM^ECOBUL(.RESULT,HANDLE,PARAMS)")
 D METHOD(.X,CHILD_".mf.SetParams.Item #")
 D METHOD(.X,CHILD_".mf.SetReturns.Value of item")
 ;;
 D METHOD(.CHILD,HANDLE_".Methods.Override.Info")
 D METHOD(.X,CHILD_".mf.SetAddedByClass.List Utility")
 D METHOD(.X,CHILD_".mf.SetDescription.Displays business information.")
 D METHOD(.X,CHILD_".mf.SetHandler.INFO^ECOBUL(.RESULT,HANDLE,PARAMS)")
 D METHOD(.X,CHILD_".mf.SetParams.[Justify]")
 D METHOD(.X,CHILD_".mf.SetReturns.1")
 ;;
 D METHOD(.CHILD,HANDLE_".Methods.Add.Last")
 D METHOD(.X,CHILD_".mf.SetAddedByClass.List Utility")
 D METHOD(.X,CHILD_".mf.SetDescription.Default Last for list objects.")
 D METHOD(.X,CHILD_".mf.SetHandler.LAST^ECOBUL(.RESULT,HANDLE,PARAMS)")
 D METHOD(.X,CHILD_".mf.SetParams.")
 D METHOD(.X,CHILD_".mf.SetReturns.Handle, Item or Value of most recent object")
 ;;
 D METHOD(.CHILD,HANDLE_".Methods.Add.Next")
 D METHOD(.X,CHILD_".mf.SetAddedByClass.List Utility")
 D METHOD(.X,CHILD_".mf.SetDescription.Default Next for list objects.")
 D METHOD(.X,CHILD_".mf.SetHandler.NEXT^ECOBUL(.RESULT,HANDLE,PARAMS)")
 D METHOD(.X,CHILD_".mf.SetParams.")
 D METHOD(.X,CHILD_".mf.SetReturns.Handle, Item or Value of next object")
 ;;
 D METHOD(.CHILD,HANDLE_".Methods.Add.SetItem")
 D METHOD(.X,CHILD_".mf.SetAddedByClass.List Utility")
 D METHOD(.X,CHILD_".mf.SetDescription.Default SetItem for list objects.")
 D METHOD(.X,CHILD_".mf.SetHandler.SETITEM^ECOBUL(.RESULT,HANDLE,PARAMS)")
 D METHOD(.X,CHILD_".mf.SetParams.Item #.Value ... to be stored")
 D METHOD(.X,CHILD_".mf.SetReturns.1 if successful")
 ;;
 S CHILD=$$CREATE^ECOBL(NAME)
 D METHOD(.X,HANDLE_".Collect.SetChild."_CHILD)
 D METHOD(.X,HANDLE_".Collect.SetName.List")
 D METHOD(.X,HANDLE_".Collect.SetHandler.ECOBL^ECOBUL(.RESULT,HANDLE,PARAMS)")
 D METHOD(.X,HANDLE_".Collect.Execute")
 ;
 Q HANDLE
 ;;
DESTROY(HANDLE) ; call parent last
 N CHILD
 D METHOD(.CHILD,HANDLE_".GetList")
 D DESTROY^ECOBL(CHILD)
 Q $$DESTROY^ECOBU(HANDLE)
 ;;
METHOD(RESULT,ARGUMENT) ; argument=[handle].[method].(additional.params...)
 D METHOD^ECOBU(.RESULT,ARGUMENT) Q
 ;;
