TIUXRC4 ; COMPILED XREF FOR FILE #8925 ; 08/16/10
 ; 
 I X'="" I +$P($G(^TIU(8925,+DA,0)),U),+$P($G(^TIU(8925,+DA,0)),U,5),+$O(^TIU(8925.9,"B",+DA,0)) D APRBS^TIUDD(+$G(^TIU(8925,+DA,0)),+$P($G(^TIU(8925,+DA,0)),U,5),(9999999-+X),DA)
 S X=$P($G(DIKZ(13)),U,1)
 I X'="" I +$P($G(^TIU(8925,+DA,0)),U),+$P($G(^TIU(8925,+DA,0)),U,3),+$P($G(^TIU(8925,+DA,0)),U,5) S ^TIU(8925,"AVSIT",+$P(^TIU(8925,+DA,0),U,3),+$P(^TIU(8925,+DA,0),U),+$P(^TIU(8925,+DA,0),U,5),(9999999-X),DA)=""
 S X=$P($G(DIKZ(13)),U,1)
 I X'="" I +$P($G(^TIU(8925,+DA,0)),U,4),+$P($G(^TIU(8925,+DA,0)),U,2),+$P($G(^TIU(8925,+DA,0)),U,5) S ^TIU(8925,"ADCPT",+$P(^TIU(8925,+DA,0),U,2),+$P(^TIU(8925,+DA,0),U,4),+$P(^TIU(8925,+DA,0),U,5),(9999999-X),DA)=""
 S X=$P($G(DIKZ(13)),U,1)
 I X'="" S ^TIU(8925,"D",$E(X,1,30),DA)=""
 S X=$P($G(DIKZ(13)),U,1)
 I X'="" I +$P(^TIU(8925,+DA,0),U),+$P($G(^TIU(8925,+DA,0)),U,2) S ^TIU(8925,"APTCL",+$P(^TIU(8925,+DA,0),U,2),+$$CLINDOC^TIULC1(+$P(^TIU(8925,+DA,0),U),+DA),(9999999-X),DA)=""
 S X=$P($G(DIKZ(13)),U,1)
 I X'="" I +$P(^TIU(8925,+DA,0),U),+$P($G(^TIU(8925,+DA,0)),U,2) S ^TIU(8925,"APTCL",+$P(^TIU(8925,+DA,0),U,2),38,(9999999-X),DA)=""
 S X=$P($G(DIKZ(13)),U,1)
 I X'="" I +$P($G(^TIU(8925,+DA,0)),U),+$P($G(^TIU(8925,+DA,12)),U,5),+$P($G(^TIU(8925,+DA,0)),U,5) S ^TIU(8925,"ALOC",+$P(^TIU(8925,+DA,12),U,5),+$P(^TIU(8925,+DA,0),U),+$P(^TIU(8925,+DA,0),U,5),(9999999-X),+DA)=""
 S X=$P($G(DIKZ(13)),U,1)
 I X'="" D SACLPT^TIUDD0(1301,X)
 S X=$P($G(DIKZ(13)),U,1)
 I X'="" D SACLAU^TIUDD0(1301,X),SACLAU1^TIUDD0(1301,X)
 S X=$P($G(DIKZ(13)),U,1)
 I X'="" D SACLEC^TIUDD0(1301,X)
 S X=$P($G(DIKZ(13)),U,1)
 I X'="" D SACLSB^TIUDD0(1301,X)
 S X=$P($G(DIKZ(13)),U,2)
 I X'="" S ^TIU(8925,"TC",$E(X,1,30),DA)=""
 S X=$P($G(DIKZ(13)),U,2)
 I X'="" I +$P($G(^TIU(8925,+DA,0)),U),+$P($G(^TIU(8925,+DA,13)),U),+$P($G(^TIU(8925,+DA,0)),U,5) S ^TIU(8925,"ATC",+X,+$P($G(^TIU(8925,+DA,0)),U),+$P(^TIU(8925,+DA,0),U,5),(9999999-$P($G(^TIU(8925,+DA,13)),U)),DA)=""
 S X=$P($G(DIKZ(13)),U,2)
 I X'="" D SACLAU1^TIUDD0(1302,X)
 S X=$P($G(DIKZ(13)),U,4)
 I X'="" S ^TIU(8925,"E",$E(X,1,30),DA)=""
 S DIKZ(14)=$G(^TIU(8925,DA,14))
 S X=$P($G(DIKZ(14)),U,2)
 I X'="" S ^TIU(8925,"TS",$E(X,1,30),DA)=""
 S X=$P($G(DIKZ(14)),U,2)
 I X'="" I +$P($G(^TIU(8925,+DA,0)),U),+$P($G(^TIU(8925,+DA,13)),U),+$P($G(^TIU(8925,+DA,0)),U,5) S ^TIU(8925,"ATS",+X,+$P($G(^TIU(8925,+DA,0)),U),+$P($G(^TIU(8925,+DA,0)),U,5),(9999999-$P($G(^TIU(8925,+DA,13)),U)),DA)=""
 S X=$P($G(DIKZ(14)),U,4)
 I X'="" I +$P($G(^TIU(8925,+DA,0)),U),+$P($G(^TIU(8925,+DA,13)),U),+$P($G(^TIU(8925,+DA,0)),U,5) S ^TIU(8925,"ASVC",+X,+$P($G(^TIU(8925,+DA,0)),U),+$P($G(^TIU(8925,+DA,0)),U,5),(9999999-$P($G(^TIU(8925,+DA,13)),U)),DA)=""
 S X=$P($G(DIKZ(14)),U,4)
 I X'="" S ^TIU(8925,"SVC",$E(X,1,30),DA)=""
 S X=$P($G(DIKZ(14)),U,5)
 I X'="" S ^TIU(8925,"G",$E(X,1,30),DA)=""
 S DIKZ(15)=$G(^TIU(8925,DA,15))
 S X=$P($G(DIKZ(15)),U,1)
 I X'="" I +$$ALOCP^TIULX(+DA),+$P($G(^TIU(8925,+DA,12)),U,5) S ^TIU(8925,"ALOCP",+$P($G(^TIU(8925,+DA,12)),U,5),+X,+DA)=""
 S X=$P($G(DIKZ(15)),U,1)
 I X'="" I +$$APTP^TIULX(+DA),+$P($G(^TIU(8925,+DA,0)),U,2) S ^TIU(8925,"APTP",+$P($G(^TIU(8925,+DA,0)),U,2),+X,+DA)=""
 S X=$P($G(DIKZ(15)),U,1)
 I X'="" I +$$AAUP^TIULX(+DA),+$P($G(^TIU(8925,+DA,12)),U,2) S ^TIU(8925,"AAUP",+$P($G(^TIU(8925,+DA,12)),U,2),+X,+DA)=""
 S X=$P($G(DIKZ(15)),U,1)
 I X'="" D SACLPT^TIUDD0(1501,X)
 S X=$P($G(DIKZ(15)),U,1)
 I X'="" D SACLEC^TIUDD0(1501,X)
 S X=$P($G(DIKZ(15)),U,1)
 I X'="" D KACLAU^TIUDD01(1501,X),KACLAU1^TIUDD01(1501,X)
 S X=$P($G(DIKZ(15)),U,2)
 I X'="" D SACLSB^TIUDD0(1502,X)
 S X=$P($G(DIKZ(15)),U,7)
 I X'="" D KACLEC^TIUDD01(1507,X)
 S X=$P($G(DIKZ(15)),U,7)
 I X'="" D SACLPT^TIUDD0(1507,X)
 S DIKZ(17)=$G(^TIU(8925,DA,17))
 S X=$P($G(DIKZ(17)),U,1)
 I X'="" I +$P($G(^TIU(8925,+DA,0)),U),+$P($G(^TIU(8925,+DA,0)),U,5),+$P($G(^TIU(8925,+DA,13)),U) D ASUBS^TIUDD($G(X),+$G(^TIU(8925,+DA,0)),+$P(^TIU(8925,+DA,0),U,5),(9999999-+$G(^TIU(8925,+DA,13))),DA)
 S DIKZ(21)=$G(^TIU(8925,DA,21))
 S X=$P($G(DIKZ(21)),U,1)
 I X'="" S ^TIU(8925,"GDAD",$E(X,1,30),DA)=""
 S DIKZ(150)=$G(^TIU(8925,DA,150))
 S X=$P($G(DIKZ(150)),U,1)
 I X'="" S ^TIU(8925,"VID",$E(X,1,30),DA)=""
CR1 S DIXR=247
 K X
 S X(1)=$P(DIKZ(12),U,12)
 S DIKZ(0)=$G(^TIU(8925,DA,0))
 S X(2)=$P(DIKZ(0),U,1)
 S X(3)=$P(DIKZ(0),U,5)
 S X=$P(DIKZ(13),U,1)
 I $G(X)]"" S X=9999999-X
 S:$D(X)#2 X(4)=X
 S X=$G(X(1))
 I $G(X(1))]"",$G(X(2))]"",$G(X(3))]"",$G(X(4))]"" D
 . K X1,X2 M X1=X,X2=X
 . S ^TIU(8925,"ADIV",X(1),X(2),X(3),X(4),DA)=""
CR2 S DIXR=308
 K X
 S DIKZ(12)=$G(^TIU(8925,DA,12))
 S X(1)=$P(DIKZ(12),U,7)
 S X=$G(X(1))
 I $G(X(1))]"" D
 . K X1,X2 M X1=X,X2=X
 . S ^TIU(8925,"VS",X,DA)=""
CR3 S DIXR=557
 K X
 S DIKZ(12)=$G(^TIU(8925,DA,12))
 S X(1)=$P(DIKZ(12),U,1)
 S DIKZ(18)=$G(^TIU(8925,DA,18))
 S X(2)=$P(DIKZ(18),U,1)
 S X=$G(X(1))
 I $G(X(1))]"",$G(X(2))]"" D
 . K X1,X2 M X1=X,X2=X
 . S ^TIU(8925,"VBC",$E(X(1),1,14),$E(X(2),1,6),DA)=""
CR4 K X
END Q
