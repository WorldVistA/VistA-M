ECOBA ;BP/CMF - Attribute Object
 ;;2.0;EVENT CAPTURE;**100**;8 May 96;Build 21
 ;@author  - Chris Flegel
 ;@date    - 17 May 2009
 ;@version - 1.0
 ;;
 Q
 ;; private methods
 ;;
PROPERTY(HANDLE,SCOPE,PROPERTY,VALUE)  ;
 D PROPERTY^ECOB(HANDLE,SCOPE,PROPERTY,VALUE)
 Q
 ;;
 ;; public methods
CREATE(NAME)  ;
 ; call parent first
 N HANDLE,CHILD
 S HANDLE=$$CREATE^ECOB2(NAME)
 D SELF^ECOB(.RESULT,HANDLE,"Attribute","Attribute","METHOD^ECOBA(.RESULT,ARGUMENT)","ECOB2")
 ;;
 D PROPERTY(HANDLE,"Pu","AddedByClass","")
 D PROPERTY(HANDLE,"Pu","Cleared","false")
 D PROPERTY(HANDLE,"Pu","DefaultValue","")
 D PROPERTY(HANDLE,"Pu","Description","")
 D PROPERTY(HANDLE,"Pu","Edited","false")
 D PROPERTY(HANDLE,"Pu","Name","")
 D PROPERTY(HANDLE,"Pu","Obtained","false")
 D PROPERTY(HANDLE,"Pu","Persisted","false")
 D PROPERTY(HANDLE,"Pu","Scope","")
 D PROPERTY(HANDLE,"Pu","Value","")
 ; complex properties last
 Q HANDLE
 ;;
DESTROY(HANDLE)  ;
 ; call parent last
 Q $$DESTROY^ECOB2(HANDLE)
 ;;
METHOD(RESULT,ARGUMENT)  ;
 ; argument=(name.count[handle]).method.(additional.params...)
 D METHOD^ECOB2(.RESULT,ARGUMENT)
 Q
 ;;
