NURXP43 ;HIRMFO/FT-Nursing Service v4.0 Post-Initialization Routine ;8-16-2011
 ;;4.0;NURSING SERVICE;**43**;Apr 25, 1997;Build 19
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; This routine contains the post-initialization code for Nursing
 ; Service package v4.0. Patch 43
 ;
 ;Reindex Nurse primary location
 N DIK,DA
 S DIK="^NURSF(211.8,DA(1),1,"
 S DIK(1)="6^D"
 S DA(1)=0
 F  S DA(1)=$O(^NURSF(211.8,DA(1))) Q:DA(1)'?1.N  D
 .S DA=0
 .F  S DA=$O(^NURSF(211.8,DA(1),1,DA)) Q:DA'?1.N  D
 ..D EN^DIK
 ;
 N DA,X,PAIDDT,TEST,ACDT
 S TEST='$$PROD^XUPROD
 S PAIDDT=""
 ;GO BACK 5 PAYPERIODS JUST FOR TESTING PURPOSES
 F I=1:1:14*5 S PAIDDT=$O(^PRST(458,"AD",PAIDDT),-1)
 S DA=0
 F  S DA=$O(^NURSF(211.4,DA)) Q:DA'?1.N  D
 .S ACDT=$S(TEST:PAIDDT,1:DT),X=$G(^NURSF(211.4,DA,"I"))
 .D SERVICE
 Q
 ;
SERVICE ; set the Service date multiple (field 16) in file 211.4, whenever
 ; the inactive flag (1.5) is changed (called from index on field 1.5)
 ;
 Q:$G(DA)'>0!($G(X)="")
 N REC,RECEXIST,IENS,PRSFDA
 S RECEXIST=0
 S REC=$O(^NURSF(211.4,DA,7,0))
 ;IF THERE ARE 7 LEVEL DECENDANTS THEN THIS PROCESS HAS BEEN RUN BEFORE FOR THIS LOCATION
 Q:REC
 S IENS="+1,"_DA_","
 S PRSFDA(211.416,IENS,.01)=ACDT
 S PRSFDA(211.416,IENS,1)=X
 D UPDATE^DIE("","PRSFDA","IENS")
 D MSG^DIALOG()
 Q
