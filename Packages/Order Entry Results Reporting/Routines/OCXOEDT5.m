OCXOEDT5 ;SLC/RJS,CLA -  Edit Compiler Function Code ;10/29/98  12:37
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**32**;Dec 17,1997
 ;;  ;;ORDER CHECK EXPERT version 1.01 released OCT 29,1998
 ;
S ;
 ;
 N OCXERR,OCXR,DIE,DIC,DR,X,Y
 ;
 S OCXERR=0 F  W !! Q:$$DIE($$DIC)
 ;
 Q
 ;
DIC() N DLAYGO,DIC,X,Y S DLAYGO=860.8,DIC="^OCXS(860.8,",DIC(0)="AEQML" D ^DIC Q:(Y<0) 0 Q +Y
 ;
DIE(DA) Q:'DA 1 N DIC,DIE,DR,X,Y S (DIC,DIE)="^OCXS(860.8,",DR="100" D ^DIE Q 0
 ;
TODAY() N X,%DT S X="T",%DT="" D ^%DT Q +Y
 ;
LAST() Q $O(^TMP($J,1," "),-1)
 ;
DT(X,%DT) N Y D ^%DT Q +Y
 ;
