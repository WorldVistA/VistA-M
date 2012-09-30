NURSUT6 ;HIRMFO/KJS-API FOR NURS LOCATION (#211.4) FILE ;8-18-2011
 ;;4.0;NURSING SERVICE;**43**;APR 25, 1997;Build 19
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ;
SERVICE ; set the Service date multiple (field 16) in file 211.4, whenever
 ; the inactive flag (1.5) is changed (called from index on field 1.5)
 ;
 Q:$G(DA)'>0!($G(X)="")
 N REC,RECEXIST,IENS
 S RECEXIST=0
 S REC=$O(^NURSF(211.4,DA,7,"B",DT,0))
 I REC S RECEXIST=$D(^NURSF(211.4,DA,7,REC,0))
 I RECEXIST D
 . S IENS=REC_","_DA_","
 . S PRSFDA(211.416,IENS,1)=X
 . D FILE^DIE(,"PRSFDA",)
 E  D
 . N PRSFDA,IENS
 . S IENS="+1,"_DA_","
 . S PRSFDA(211.416,IENS,.01)=DT
 . S PRSFDA(211.416,IENS,1)=X
 . D UPDATE^DIE("","PRSFDA","IENS")
 D MSG^DIALOG()
 Q
