TIUXRC2 ; COMPILED XREF FOR FILE #8925 ; 08/16/10
 ; 
 I X'="" I +$P($G(^TIU(8925,+DA,0)),U,2),+$P($G(^(0)),U,3) K ^TIU(8925,"AV",+$P(^TIU(8925,+DA,0),U,2),+X,+$P(^TIU(8925,+DA,0),U,3),+DA)
 S X=$P($G(DIKZ(0)),U,1)
 I X'="" I +$P($G(^TIU(8925,+DA,14)),U,2),+$P($G(^TIU(8925,+DA,13)),U),+$P($G(^TIU(8925,+DA,0)),U,5) K ^TIU(8925,"ATS",+$P($G(^TIU(8925,+DA,14)),U,2),+X,+$P($G(^TIU(8925,+DA,0)),U,5),(9999999-$P($G(^TIU(8925,+DA,13)),U)),DA)
 S X=$P($G(DIKZ(0)),U,1)
 I X'="" I +$P($G(^TIU(8925,+DA,13)),U,2),+$P($G(^TIU(8925,+DA,13)),U),+$P($G(^TIU(8925,+DA,0)),U,5) K ^TIU(8925,"ATC",+$P($G(^TIU(8925,+DA,13)),U,2),+X,+$P(^TIU(8925,+DA,0),U,5),(9999999-$P($G(^TIU(8925,+DA,13)),U)),DA)
 S X=$P($G(DIKZ(0)),U,1)
 I X'="" I +$P($G(^TIU(8925,+DA,13)),U),+$P($G(^TIU(8925,+DA,0)),U,5) K ^TIU(8925,"ALL","ANY",+X,+$P(^TIU(8925,+DA,0),U,5),(9999999-$P($G(^TIU(8925,+DA,13)),U)),DA)
 S X=$P($G(DIKZ(0)),U,1)
 I X'="" I $L($P(^TIU(8925,+DA,0),U,2)),(+$P(^(0),U,3)>0) K ^TIU(8925,"AA",+$P(^(0),U,2),+X,(9999999-$P(+^AUPNVSIT(+$P(^TIU(8925,+DA,0),U,3),0),".")),DA)
 S X=$P($G(DIKZ(0)),U,1)
 I X'="" I $L($P($G(^TIU(8925,+DA,17)),U)),+$P($G(^TIU(8925,+DA,13)),U),+$P($G(^TIU(8925,+DA,0)),U,5) D ASUBK^TIUDD($P($G(^TIU(8925,+DA,17)),U),+X,+$P(^TIU(8925,+DA,0),U,5),(9999999-+$G(^TIU(8925,+DA,13))),DA)
 S X=$P($G(DIKZ(0)),U,1)
 I X'="" I +$P($G(^TIU(8925,+DA,14)),U,4),+$P($G(^TIU(8925,+DA,13)),U),+$P($G(^TIU(8925,+DA,0)),U,5) K ^TIU(8925,"ASVC",+$P($G(^TIU(8925,+DA,14)),U,4),+X,+$P($G(^TIU(8925,+DA,0)),U,5),(9999999-$P($G(^TIU(8925,+DA,13)),U)),DA)
 S X=$P($G(DIKZ(0)),U,1)
 I X'="" I $L($P(^TIU(8925,+DA,0),U)),(+$P(^(0),U,3)>0) K ^TIU(8925,"AE",+$P($G(^TIU(8925,+DA,0)),U,2),(9999999-$P(+^AUPNVSIT(+$P(^TIU(8925,+DA,0),U,3),0),".")),+X,+DA)
 S X=$P($G(DIKZ(0)),U,1)
 I X'="" I +$P($G(^TIU(8925,+DA,12)),U,5),+$P($G(^TIU(8925,+DA,13)),U),+$P($G(^TIU(8925,+DA,0)),U,5) K ^TIU(8925,"ALOC",+$P($G(^TIU(8925,+DA,12)),U,5),+X,+$P($G(^TIU(8925,+DA,0)),U,5),(9999999-$P($G(^TIU(8925,+DA,13)),U)),DA)
 S X=$P($G(DIKZ(0)),U,1)
 I X'="" I +$P($G(^TIU(8925,+DA,13)),U),+$P($G(^TIU(8925,+DA,0)),U,5),+$O(^TIU(8925.9,"B",+DA,0)) D APRBK^TIUDD(+X,+$P(^TIU(8925,+DA,0),U,5),(9999999-+$G(^TIU(8925,+DA,13))),DA)
 S X=$P($G(DIKZ(0)),U,1)
 I X'="" I +$P(^TIU(8925,+DA,0),U,3),+$P($G(^TIU(8925,+DA,13)),U),+$P($G(^TIU(8925,+DA,0)),U,5) K ^TIU(8925,"AVSIT",+$P(^TIU(8925,+DA,0),U,3),+X,+$P(^TIU(8925,+DA,0),U,5),(9999999-$P(^TIU(8925,+DA,13),U)),DA)
 S X=$P($G(DIKZ(0)),U,1)
 I X'="" I +$P(^TIU(8925,+DA,0),U,2),+$P($G(^TIU(8925,+DA,13)),U) K ^TIU(8925,"APTCL",+$P(^TIU(8925,+DA,0),U,2),+$$CLINDOC^TIULC1(+X,+DA),(9999999-$P(^TIU(8925,+DA,13),U)),DA)
 S X=$P($G(DIKZ(0)),U,1)
 I X'="" I +$P(^TIU(8925,+DA,0),U,2),+$P($G(^TIU(8925,+DA,13)),U) K ^TIU(8925,"APTCL",+$P(^TIU(8925,+DA,0),U,2),38,(9999999-$P(^TIU(8925,+DA,13),U)),DA)
 S X=$P($G(DIKZ(0)),U,1)
 I X'="" D KACLPT^TIUDD01(.01,X)
 S X=$P($G(DIKZ(0)),U,1)
 I X'="" D KACLAU^TIUDD01(.01,X),KACLAU1^TIUDD01(.01,X)
 S X=$P($G(DIKZ(0)),U,1)
 I X'="" D KACLEC^TIUDD01(.01,X)
 S X=$P($G(DIKZ(0)),U,1)
 I X'="" D KACLSB^TIUDD01(.01,X)
 S X=$P($G(DIKZ(0)),U,1)
 I X'="" D KAPTLD^TIUDD01(.01,X)
CR1 S DIXR=247
 K X
 S X(1)=$P(DIKZ(12),U,12)
 S X(2)=$P(DIKZ(0),U,1)
 S X(3)=$P(DIKZ(0),U,5)
 S X=$P(DIKZ(13),U,1)
 I $G(X)]"" S X=9999999-X
 S:$D(X)#2 X(4)=X
 S X=$G(X(1))
 I $G(X(1))]"",$G(X(2))]"",$G(X(3))]"",$G(X(4))]"" D
 . K X1,X2 M X1=X,X2=X
 . S:$D(DIKIL) (X2,X2(1),X2(2),X2(3),X2(4))=""
 . K ^TIU(8925,"ADIV",X(1),X(2),X(3),X(4),DA)
CR2 S DIXR=308
 K X
 S DIKZ(12)=$G(^TIU(8925,DA,12))
 S X(1)=$P(DIKZ(12),U,7)
 S X=$G(X(1))
 I $G(X(1))]"" D
 . K X1,X2 M X1=X,X2=X
 . S:$D(DIKIL) (X2,X2(1))=""
 . K ^TIU(8925,"VS",X,DA)
CR3 S DIXR=557
 K X
 S DIKZ(12)=$G(^TIU(8925,DA,12))
 S X(1)=$P(DIKZ(12),U,1)
 S DIKZ(18)=$G(^TIU(8925,DA,18))
 S X(2)=$P(DIKZ(18),U,1)
 S X=$G(X(1))
 I $G(X(1))]"",$G(X(2))]"" D
 . K X1,X2 M X1=X,X2=X
 . S:$D(DIKIL) (X2,X2(1),X2(2))=""
 . K ^TIU(8925,"VBC",$E(X(1),1,14),$E(X(2),1,6),DA)
CR4 K X
END Q
