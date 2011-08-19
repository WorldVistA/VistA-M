TIUPS163 ; SLC/JER,AJB - More Review Screen Actions ;14-MAY-2004 [10/18/04 11:47am]
 ;;1.0;TEXT INTEGRATION UTILITIES;**163**;Jun 20, 1997
MAIN ;controls branching
 D REINDEX,NEWXREF
 Q
NEWXREF ;creates new xref "VS" on field 1207
 N TIUD0,TIUARR,TIURES
 S TIUD0=0
 S TIUD0=$O(^TIU(8925,"VS",TIUD0))
 I 'TIUD0 D
 . S TIUARR("FILE")=8925
 . S TIUARR("NAME")="VS"
 . S TIUARR("USE")="LS"
 . S TIUARR("TYPE")="R"
 . S TIUARR("SHORT DESCR")="REGULAR XREF ON FIELD 1207"
 . S TIUARR("DESCR",1)="THIS XREF CONTAINS AS A SUBSCRIPT"
 . S TIUARR("DESCR",2)="THE VALUE OF FIELD 1207 OF FILE #8925"
 . S TIUARR("VAL",1)=1207
 . S TIUARR("VAL",1,"SUBSCRIPT")=1
 . D CREIXN^DDMOD(.TIUARR,"W",.TIURES,"OUT")
 D QUE
 Q
QUE ;queue the indexing of the VS xref
 N TIUD0
 S TIUD0=0
 S TIUD0=$O(^TIU(8925,"VS",TIUD0))
 I 'TIUD0 D
 . N ZTDESC,ZTIO,ZTRTN,ZTSAVE,ZTSK,DIR,TIUQUIT
 . S ZTRTN="INDEXVS^TIUPS163",ZTIO="",ZTSAVE("DUZ")=""
 . S ZTDESC="Index the new VS XRef on file 8925"
 . D ^%ZTLOAD
 . I $G(ZTSK) D
 . . K ^XTMP("TIUPS163")
 . . N X,X1,X2 S X1=DT,X2=30
 . . D C^%DTC
 . . S ^XTMP("TIUPS163",0)=X_"^"_DT_"^"
 . . S ^XTMP("TIUPS163","COUNT")=0
 . . W !!,"A task has been queued in the background."
 . . W !,"  The task number is "_$G(ZTSK)_"."
 . . W !,"  To check on the status of the task, in programmer mode "
 . . W !,"    type D STATUS^TIUPS163"
 Q
REINDEX ;reindex the ACL xref on 8925.1
 N DIK
 S DIK="^TIU(8925.1,",DIK(1)=".01^ACL"
 D BMES^XPDUTL("REBUILDING NEW ""ACL"" CROSS-REFERENCE ON FILE 8925.1")
 K ^TIU(8925.1,"ACL") ; Remove the existing ACL x-ref
 D ENALL^DIK
 D BMES^XPDUTL("DONE")
 Q
INDEXVS ;index the VS xref on 8925
 N TIUDA,TIUCNT,%,%H,%I,X
 D NOW^%DTC
 S ^XTMP("TIUPS163","STARTDT")=%
 S TIUDA=0,TIUCNT=0
 F  S TIUDA=$O(^TIU(8925,TIUDA)) Q:'TIUDA  S TIUCNT=TIUCNT+1 S ^XTMP("TIUPS163","COUNT")=TIUCNT I $P($G(^TIU(8925,TIUDA,12)),U,7)  S ^TIU(8925,"VS",$P($G(^TIU(8925,TIUDA,12)),U,7),TIUDA)=""
 D NOW^%DTC
 S ^XTMP("TIUPS163","ENDDT")=%
 Q
STATUS ;check on status of VS xref indexing
 I $G(^XTMP("TIUPS163","ENDDT")) D
 . N START,END,X,Y
 . W !,"Indexing completed!"
 . S Y=$G(^XTMP("TIUPS163","STARTDT")) D DD^%DT
 . W !,"Task started: "_Y
 . S Y=$G(^XTMP("TIUPS163","ENDDT")) D DD^%DT
 . W !,"Task ended:   "_Y
 I '$G(^XTMP("TIUPS163","ENDDT")) D
 . W "Still working on the index."
 . W !,$G(^XTMP("TIUPS163","COUNT"))_" of "_$P($G(^TIU(8925,0)),U,4)
 . W " completed"
 . I $G(^XTMP("TIUPS163","COUNT"))=0 W !,"You must have tasked it!"
 Q
