SOWAPOI ;B'HAM ISC/DLR - POST-INIT for 94 CDC account (651) [ 11/16/94  7:44 AM ]
V ;;3.0; Social Work ;**36**;27 Apr 93
POST ;POST-INIT
 N X,X2
 S (X,X2)=0
 F  S X=$O(^SOWK(651,"C",X)) Q:'X  I $D(^TMP($J,"CDC",X)) S X2=0 F  S X2=$O(^SOWK(651,"C",X,X2)) Q:'X2  S:$P(^SOWK(651,X2,0),U,8)'=1 $P(^SOWK(651,X2,0),U,5)=^TMP($J,"CDC",X)
 K ^TMP($J,"CDC")
 S DIK(1)="4^AC",DIK="^SOWK(651," D ENALL^DIK K DIK
 Q
