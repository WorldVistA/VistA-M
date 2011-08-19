ORCDADT ;SLC/MKB-Utility functions for ADT dialogs ;9/13/02  08:31 [9/25/02 4:28pm]
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**142,141**;Dec 17, 1997
 ;DBIA reference section
 ;10015- DIQ
 ;
ENTS(EVT) ; -- Get list of specialties from EVT (#100.5)
 Q:$G(ORDIALOG(PROMPT,"LIST"))  Q:'$G(EVT)
 N I,CNT,IEN,X,Y S (I,CNT)=0
 S IEN=$S($P($G(^ORD(100.5,+EVT,0)),U,12):+$P(^(0),U,12),1:+EVT)
 F  S I=$O(^ORD(100.5,IEN,"TS",I)) Q:I<1  S X=+$G(^(I,0)) D
 . S Y=$$GET1^DIQ(45.7,X_",",.01)
 . S CNT=CNT+1,ORDIALOG(PROMPT,"LIST",CNT)=X_U_Y
 . S ORDIALOG(PROMPT,"LIST","B",Y)=X
 S:CNT ORDIALOG(PROMPT,"LIST")=CNT_"^1"
 Q
 ;
DEFTS(EVT) ; -- Return default specialty for EVT (#100.5)
 N I,Y,IEN S Y=""
 ;If child event then get parent event for default:
 S IEN=$S($P($G(^ORD(100.5,+$G(EVT),0)),U,12):+$P(^(0),U,12),1:+$G(EVT))
 S I=+$O(^ORD(100.5,IEN,"TS","DEF",1,0))
 S:I Y=+$G(^ORD(100.5,IEN,"TS",I,0)) ;default selection
 Q Y
 ;
XHELP(PTR) ; -- Xecutable help
 I $D(ORDIALOG(PTR,"LIST")),X="?"!$P(ORDIALOG(PTR,"LIST"),U,2) D LIST^ORCD Q
 D P^ORCDLGH ; ??-help
 Q
