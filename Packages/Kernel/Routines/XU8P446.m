XU8P446 ;ISF/RWF - POST INIT FOR PATCH XU*8*446 ;08/27/08  15:06
 ;;8.0;KERNEL;**446**;JUL 10, 1995;Build 35
 Q
 ;
POST ;
 D PROXY
 D PATCH^ZTMGRSET(446)
 Q
 ;
PROXY ;Setup Proxy User
 N X,NAME
 S NAME="TASKMAN,PROXY USER"
 S X=$$APFIND^XUSAP(NAME) I X>0 Q  ;All ready setup
 I (+X)'=-1 Q  ;Some problem
 ;Setup Proxy
 S X=$$CREATE^XUSAP(NAME,"#")
 D BMES^XPDUTL("POST-INIT: Taskman proxy "_$S(X>0:"created.",1:"Failed"))
 Q
