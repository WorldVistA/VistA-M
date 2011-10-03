ECOB40 ;BP/CMF - Generic Table Print Object
 ;;2.0;EVENT CAPTURE;**100**;8 May 96;Build 21
 ;@author  - Chris Flegel
 ;@date    - 17 May 2009
 ;@version - 1.0
 ;;
 Q
 ;; private methods
OUT(HANDLE,METHOD)  ;
    N RESULT
    D METHOD(.RESULT,HANDLE_"."_METHOD)
 Q RESULT
 ;;
ECOBL(RESULT,HANDLE,ARGUMENT) ; handler for the actual list object
 N CHILD
 D METHOD(.CHILD,HANDLE_".GetHeaders")
 D METHOD^ECOBL(.RESULT,CHILD_"."_ARGUMENT)
 Q
 ;;
HEADER(HANDLE)  ;
 N HDR,HDRNAME,HDRWIDTH,PAGE
 W @IOF
 S PAGE=$$OUT(HANDLE,"GetPage")
 W !,$$CJ^XLFSTR($$OUT(HANDLE,"GetTableName"),IOM)
 W !,$$CJ^XLFSTR($$FMTE^XLFDT($$NOW^XLFDT()),IOM)
 W !,$$CJ^XLFSTR("Page: "_PAGE,IOM)
 W !!
 S HDR=$$OUT(HANDLE,"Headers.First")
 F  Q:HDR="-1^End of list"  D
 .S HDRNAME=$P(HDR,U)
 .S HDRWIDTH=$P(HDR,U,2)
 .W $$LJ^XLFSTR(HDRNAME,HDRWIDTH)
 .S HDR=$$OUT(HANDLE,"Headers.Next")
 .Q
 S PAGE=PAGE+1
 D OUT(HANDLE,"SetPage."_PAGE)
 Q
    ;;
FOOTER(HANDLE)  ;
 N PAGE
 S PAGE=$$OUT(HANDLE,"GetPage")
 W !!
 W $$CJ^XLFSTR("Page: "_PAGE,IOM)
 S PAGE=PAGE+1
 D OUT(HANDLE,"SetPage."_PAGE)
 Q
WIDTH(HANDLE,HEADER)  ;
 Q $P($$OUT(HANDLE,"Headers.GetItem."_HEADER),U,2)
 ;;
 ;; protected methods
PRINT(RESULT,HANDLE,PARAMS)  ;
 N COLUMNS,COLUMN,TXT,WIDTH,VALUE
 S COLUMNS=$$OUT(HANDLE,"Headers.GetCount")
 D OUT(HANDLE,"SetPage.1")
 D HEADER(HANDLE)
 S TXT=$$OUT(HANDLE,"List.First")
 F  Q:TXT="-1^End of list"  D
 .W !
 .F COLUMN=1:1:COLUMNS D
 ..S WIDTH=$$WIDTH(HANDLE,COLUMN)
 ..S VALUE=$E($P(TXT,U,COLUMN),1,WIDTH-2)
 ..W $$LJ^XLFSTR(VALUE,WIDTH)
 ..Q
 .S TXT=$$OUT(HANDLE,"List.Next")
 .I ($Y+5)>IOSL D HEADER(HANDLE)
 Q
 ;; public methods
CREATE(NAME)  ;
 ; call parent first
 N HANDLE,X,CHILD
 S HANDLE=$$CREATE^ECOBUL(NAME)
 D METHOD(.X,HANDLE_".of.Set_class.EC GENERIC TABLE PRINT")
 D METHOD(.X,HANDLE_".of.Set_name.Generic Table Print")
 D METHOD(.X,HANDLE_".of.Set_routine.METHOD^ECOB40(.RESULT,ARGUMENT)")
 ;;
 D METHOD(.CHILD,HANDLE_".Methods.Add.Execute")
 D METHOD(.X,CHILD_".mf.SetAddedByClass.Generic Table Print")
 D METHOD(.X,CHILD_".mf.SetDescription.Print contents to IO device.")
 D METHOD(.X,CHILD_".mf.SetHandler.PRINT^ECOB40(.RESULT,HANDLE,PARAMS)")
 D METHOD(.X,CHILD_".mf.SetParams.")
 D METHOD(.X,CHILD_".mf.SetReturns.1")
 ;;
 D METHOD(.CHILD,HANDLE_".Properties.Add.TableName")
 D METHOD(.X,CHILD_".pf.SetAddedByClass.EC GENERIC TABLE PRINT")
 D METHOD(.X,CHILD_".pf.SetValue.Generic Table")
 D METHOD(.X,CHILD_".pf.SetDefaultValue.")
 ;;
 D METHOD(.CHILD,HANDLE_".Properties.Add.Page")
 D METHOD(.X,CHILD_".pf.SetAddedByClass.EC GENERIC TABLE PRINT")
 D METHOD(.X,CHILD_".pf.SetValue.1")
 D METHOD(.X,CHILD_".pf.SetDefaultValue.1")
 ;;
 ; complex properties last
 S CHILD=$$CREATE^ECOBL(NAME)
 D METHOD(.X,HANDLE_".Collect.SetChild."_CHILD)
 D METHOD(.X,HANDLE_".Collect.SetName.Headers")
 D METHOD(.X,HANDLE_".Collect.SetHandler.ECOBL^ECOB40(.RESULT,HANDLE,PARAMS)")
 D METHOD(.X,HANDLE_".Collect.Execute")
 ;;
 D METHOD(.X,HANDLE_".Root.Add.EC GENERIC TABLE PRINT")
 ;
 Q HANDLE
 ;;
DESTROY(HANDLE)  ;
 ; call parent last
 N CHILD
 D METHOD(.CHILD,HANDLE_".GetHeaders")
 D DESTROY^ECOBL(CHILD)
 Q $$DESTROY^ECOBUL(HANDLE)
 ;;
METHOD(RESULT,ARGUMENT)  ;
 ; call parent last
 D METHOD^ECOBUL(.RESULT,ARGUMENT)  ; parent method
 Q
 ;;
