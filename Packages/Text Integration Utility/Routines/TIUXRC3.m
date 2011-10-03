TIUXRC3 ; COMPILED XREF FOR FILE #8925 ; 08/16/10
 ; 
 S DIKZK=1
 S DIKZ(0)=$G(^TIU(8925,DA,0))
 S X=$P($G(DIKZ(0)),U,1)
 I X'="" S ^TIU(8925,"B",$E(X,1,30),DA)=""
 S X=$P($G(DIKZ(0)),U,1)
 I X'="" I +$P(^TIU(8925,+DA,0),U,2),+$P($G(^TIU(8925,+DA,13)),U),+$P($G(^TIU(8925,+DA,0)),U,5) S ^TIU(8925,"APT",+$P(^TIU(8925,+DA,0),U,2),+X,+$P(^TIU(8925,+DA,0),U,5),(9999999-$P(^TIU(8925,+DA,13),U)),DA)=""
 S X=$P($G(DIKZ(0)),U,1)
 I X'="" I +$P($G(^TIU(8925,+DA,12)),U,2),+$P($G(^TIU(8925,+DA,13)),U),+$P($G(^TIU(8925,+DA,0)),U,5) S ^TIU(8925,"AAU",+$P($G(^TIU(8925,+DA,12)),U,2),+X,+$P(^TIU(8925,+DA,0),U,5),(9999999-$P($G(^TIU(8925,+DA,13)),U)),DA)=""
 S X=$P($G(DIKZ(0)),U,1)
 I X'="" I +$P($G(^TIU(8925,+DA,12)),U,8),+$P($G(^TIU(8925,+DA,13)),U),+$P($G(^TIU(8925,+DA,0)),U,5) S ^TIU(8925,"ASUP",+$P($G(^TIU(8925,+DA,12)),U,8),+X,+$P(^TIU(8925,+DA,0),U,5),(9999999-$P($G(^TIU(8925,+DA,13)),U)),DA)=""
 S X=$P($G(DIKZ(0)),U,1)
 I X'="" I $P($$DOCTYPE^TIULF(+DA),U)="DOC",+$P($G(^TIU(8925,+DA,0)),U,2),+$P($G(^(0)),U,3) S ^TIU(8925,"AV",+$P(^TIU(8925,+DA,0),U,2),+X,+$P(^TIU(8925,+DA,0),U,3),+DA)=""
 S X=$P($G(DIKZ(0)),U,1)
 I X'="" I +$P($G(^TIU(8925,+DA,14)),U,2),+$P($G(^TIU(8925,+DA,13)),U),+$P($G(^TIU(8925,+DA,0)),U,5) S ^TIU(8925,"ATS",+$P($G(^TIU(8925,+DA,14)),U,2),+X,+$P($G(^TIU(8925,+DA,0)),U,5),(9999999-$P($G(^TIU(8925,+DA,13)),U)),DA)=""
 S X=$P($G(DIKZ(0)),U,1)
 I X'="" I +$P($G(^TIU(8925,+DA,13)),U,2),+$P($G(^TIU(8925,+DA,13)),U),+$P($G(^TIU(8925,+DA,0)),U,5) S ^TIU(8925,"ATC",+$P($G(^TIU(8925,+DA,13)),U,2),+X,+$P(^TIU(8925,+DA,0),U,5),(9999999-$P($G(^TIU(8925,+DA,13)),U)),DA)=""
 S X=$P($G(DIKZ(0)),U,1)
 I X'="" I +$P($G(^TIU(8925,+DA,13)),U),+$P($G(^TIU(8925,+DA,0)),U,5) S ^TIU(8925,"ALL","ANY",+X,+$P(^TIU(8925,+DA,0),U,5),(9999999-$P($G(^TIU(8925,+DA,13)),U)),DA)=""
 S X=$P($G(DIKZ(0)),U,1)
 I X'="" I $P($$DOCTYPE^TIULF(+DA),U)="DOC",$L($P(^TIU(8925,+DA,0),U,2)),(+$P(^(0),U,3)>0) S ^TIU(8925,"AA",+$P(^(0),U,2),+X,(9999999-$P(+^AUPNVSIT(+$P(^TIU(8925,+DA,0),U,3),0),".")),DA)=""
 S X=$P($G(DIKZ(0)),U,1)
 I X'="" I $L($P($G(^TIU(8925,+DA,17)),U)),+$P($G(^TIU(8925,+DA,13)),U),+$P($G(^TIU(8925,+DA,0)),U,5) D ASUBS^TIUDD($P($G(^TIU(8925,+DA,17)),U),+X,+$P(^TIU(8925,+DA,0),U,5),(9999999-+$G(^TIU(8925,+DA,13))),DA)
 S X=$P($G(DIKZ(0)),U,1)
 I X'="" I +$P($G(^TIU(8925,+DA,14)),U,4),+$P($G(^TIU(8925,+DA,13)),U),+$P($G(^TIU(8925,+DA,0)),U,5) S ^TIU(8925,"ASVC",+$P($G(^TIU(8925,+DA,14)),U,4),+X,+$P($G(^TIU(8925,+DA,0)),U,5),(9999999-$P($G(^TIU(8925,+DA,13)),U)),DA)=""
 S X=$P($G(DIKZ(0)),U,1)
 I X'="" I $P($$DOCTYPE^TIULF(+DA),U)="DOC",+$P($G(^TIU(8925,+DA,0)),U,2),(+$P($G(^(0)),U,3)>0) S ^TIU(8925,"AE",+$P($G(^TIU(8925,+DA,0)),U,2),(9999999-$P(+^AUPNVSIT(+$P(^TIU(8925,+DA,0),U,3),0),".")),+X,+DA)=""
 S X=$P($G(DIKZ(0)),U,1)
 I X'="" I +$P($G(^TIU(8925,+DA,12)),U,5),+$P($G(^TIU(8925,+DA,13)),U),+$P($G(^TIU(8925,+DA,0)),U,5) S ^TIU(8925,"ALOC",+$P($G(^TIU(8925,+DA,12)),U,5),+X,+$P($G(^TIU(8925,+DA,0)),U,5),(9999999-$P($G(^TIU(8925,+DA,13)),U)),DA)=""
 S X=$P($G(DIKZ(0)),U,1)
 I X'="" I +$P($G(^TIU(8925,+DA,13)),U),+$P($G(^TIU(8925,+DA,0)),U,5),+$O(^TIU(8925.9,"B",+DA,0)) D APRBS^TIUDD(+X,+$P(^TIU(8925,+DA,0),U,5),(9999999-+$G(^TIU(8925,+DA,13))),DA)
 S X=$P($G(DIKZ(0)),U,1)
 I X'="" I +$P(^TIU(8925,+DA,0),U,3),+$P($G(^TIU(8925,+DA,13)),U),+$P($G(^TIU(8925,+DA,0)),U,5) S ^TIU(8925,"AVSIT",+$P(^TIU(8925,+DA,0),U,3),+X,+$P(^TIU(8925,+DA,0),U,5),(9999999-$P(^TIU(8925,+DA,13),U)),DA)=""
 S X=$P($G(DIKZ(0)),U,1)
 I X'="" I +$P(^TIU(8925,+DA,0),U,2),+$P($G(^TIU(8925,+DA,13)),U) S ^TIU(8925,"APTCL",+$P(^TIU(8925,+DA,0),U,2),+$$CLINDOC^TIULC1(+X,+DA),(9999999-$P(^TIU(8925,+DA,13),U)),DA)=""
 S X=$P($G(DIKZ(0)),U,1)
 I X'="" I +$P(^TIU(8925,+DA,0),U,2),+$P($G(^TIU(8925,+DA,13)),U) S ^TIU(8925,"APTCL",+$P(^TIU(8925,+DA,0),U,2),38,(9999999-$P(^TIU(8925,+DA,13),U)),DA)=""
 S X=$P($G(DIKZ(0)),U,1)
 I X'="" D SACLPT^TIUDD0(.01,X)
 S X=$P($G(DIKZ(0)),U,1)
 I X'="" D SACLAU^TIUDD0(.01,X),SACLAU1^TIUDD0(.01,X)
 S X=$P($G(DIKZ(0)),U,1)
 I X'="" D SACLEC^TIUDD0(.01,X)
 S X=$P($G(DIKZ(0)),U,1)
 I X'="" D SACLSB^TIUDD0(.01,X)
 S X=$P($G(DIKZ(0)),U,1)
 I X'="" D SAPTLD^TIUDD0(.01,X)
 S X=$P($G(DIKZ(0)),U,2)
 I X'="" I $P($$DOCTYPE^TIULF(+DA),U)="DOC",$L($P(^TIU(8925,+DA,0),U)),(+$P(^(0),U,3)>0) S ^TIU(8925,"AA",+X,+^TIU(8925,+DA,0),(9999999-$P(+^AUPNVSIT($P(^TIU(8925,+DA,0),U,3),0),".")),+DA)=""
 S X=$P($G(DIKZ(0)),U,2)
 I X'="" I +$P($G(^TIU(8925,+DA,0)),U),+$P($G(^TIU(8925,+DA,13)),U),+$P($G(^TIU(8925,+DA,0)),U,5) S ^TIU(8925,"APT",+X,+$P(^TIU(8925,+DA,0),U),+$P(^TIU(8925,+DA,0),U,5),(9999999-$P(^TIU(8925,+DA,13),U)),DA)=""
 S X=$P($G(DIKZ(0)),U,2)
 I X'="" I $P($$DOCTYPE^TIULF(+DA),U)="DOC",$L($P(^TIU(8925,+DA,0),U)),(+$P(^(0),U,3)>0) S ^TIU(8925,"AE",+X,(9999999-$P(+^AUPNVSIT($P(^TIU(8925,+DA,0),U,3),0),".")),+^TIU(8925,+DA,0),+DA)=""
 S X=$P($G(DIKZ(0)),U,2)
 I X'="" S ^TIU(8925,"C",$E(X,1,30),DA)=""
 S X=$P($G(DIKZ(0)),U,2)
 I X'="" I $P($$DOCTYPE^TIULF(+DA),U)="DOC",+$P($G(^TIU(8925,+DA,0)),U),+$P($G(^(0)),U,3) S ^TIU(8925,"AV",+X,+$P(^TIU(8925,+DA,0),U),+$P(^TIU(8925,+DA,0),U,3),+DA)=""
 S X=$P($G(DIKZ(0)),U,2)
 I X'="" I +$$APTP^TIULX(+DA),+$P($G(^TIU(8925,+DA,15)),U) S ^TIU(8925,"APTP",+X,+$P($G(^TIU(8925,+DA,15)),U),+DA)=""
 S X=$P($G(DIKZ(0)),U,2)
 I X'="" I +$P($G(^TIU(8925,+DA,0)),U,4),+$P($G(^TIU(8925,+DA,13)),U),+$P($G(^TIU(8925,+DA,0)),U,5) S ^TIU(8925,"ADCPT",+X,+$P(^TIU(8925,+DA,0),U,4),+$P(^TIU(8925,+DA,0),U,5),(9999999-$P(^TIU(8925,+DA,13),U)),DA)=""
 S X=$P($G(DIKZ(0)),U,2)
 I X'="" I +$P(^TIU(8925,+DA,0),U),+$P($G(^TIU(8925,+DA,13)),U) S ^TIU(8925,"APTCL",+X,+$$CLINDOC^TIULC1(+$P(^TIU(8925,+DA,0),U),+DA),(9999999-$P(^TIU(8925,+DA,13),U)),DA)=""
 S X=$P($G(DIKZ(0)),U,2)
 I X'="" I +$P(^TIU(8925,+DA,0),U),+$P($G(^TIU(8925,+DA,13)),U) S ^TIU(8925,"APTCL",+X,38,(9999999-$P(^TIU(8925,+DA,13),U)),DA)=""
 S X=$P($G(DIKZ(0)),U,2)
 I X'="" D SACLPT^TIUDD0(.02,X)
 S X=$P($G(DIKZ(0)),U,2)
 I X'="" D SACLAU^TIUDD0(.02,X),SACLAU1^TIUDD0(.02,X)
 S X=$P($G(DIKZ(0)),U,2)
 I X'="" D SACLEC^TIUDD0(.02,X)
 S X=$P($G(DIKZ(0)),U,2)
 I X'="" D SACLSB^TIUDD0(.02,X)
 S X=$P($G(DIKZ(0)),U,2)
 I X'="" D SAPTLD^TIUDD0(.02,X)
 S X=$P($G(DIKZ(0)),U,3)
 I X'="" I $P($$DOCTYPE^TIULF(+DA),U)="DOC",$L($P(^TIU(8925,+DA,0),U)),(+$P(^(0),U,2)>0) S ^TIU(8925,"AA",$P(^(0),U,2),+$P(^(0),U),(9999999-$P(+$G(^AUPNVSIT(X,0)),".")),DA)=""
 S X=$P($G(DIKZ(0)),U,3)
 I X'="" I $P($$DOCTYPE^TIULF(+DA),U)="DOC",$L($P(^TIU(8925,+DA,0),U)),(+$P(^(0),U,2)>0) S ^TIU(8925,"AE",+$P(^TIU(8925,+DA,0),U,2),(9999999-$P(+$G(^AUPNVSIT(+X,0)),".")),+^TIU(8925,+DA,0),+DA)=""
 S X=$P($G(DIKZ(0)),U,3)
 I X'="" I $P($$DOCTYPE^TIULF(+DA),U)="DOC",+$P($G(^TIU(8925,+DA,0)),U),+$P($G(^(0)),U,2) S ^TIU(8925,"AV",+$P(^TIU(8925,+DA,0),U,2),+$P(^TIU(8925,+DA,0),U),+X,+DA)=""
 S X=$P($G(DIKZ(0)),U,3)
 I X'="" D:$D(^AUPNVSIT(+X)) ADD^AUPNVSIT
 S X=$P($G(DIKZ(0)),U,3)
 I X'="" I +$P($G(^TIU(8925,+DA,0)),U),+$P($G(^TIU(8925,+DA,13)),U),+$P($G(^TIU(8925,+DA,0)),U,5) S ^TIU(8925,"AVSIT",+X,+$P(^TIU(8925,+DA,0),U),+$P(^TIU(8925,+DA,0),U,5),(9999999-$P(^TIU(8925,+DA,13),U)),DA)=""
 S X=$P($G(DIKZ(0)),U,3)
 I X'="" S ^TIU(8925,"V",$E(X,1,30),DA)=""
 S X=$P($G(DIKZ(0)),U,3)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^TIU(8925,D0,150)):^(150),1:"") S X=$P(Y(1),U,1),X=X S DIU=X K Y X ^DD(8925,.03,1,7,1.1) X ^DD(8925,.03,1,7,1.4)
 S X=$P($G(DIKZ(0)),U,3)
 I X'="" D SAPTLD^TIUDD0(.03,X)
 S DIKZ(0)=$G(^TIU(8925,DA,0))
 S X=$P($G(DIKZ(0)),U,4)
 I X'="" I +$P($G(^TIU(8925,+DA,0)),U,2),+$P($G(^TIU(8925,+DA,13)),U),+$P($G(^TIU(8925,+DA,0)),U,5) S ^TIU(8925,"ADCPT",+$P(^TIU(8925,+DA,0),U,2),+X,+$P(^TIU(8925,+DA,0),U,5),(9999999-$P(^TIU(8925,+DA,13),U)),DA)=""
 S X=$P($G(DIKZ(0)),U,5)
 I X'="" I +$P($G(^TIU(8925,+DA,0)),U),+$P($G(^TIU(8925,+DA,12)),U,8),+$P($G(^TIU(8925,+DA,0)),U,5) S ^TIU(8925,"ASUP",+$P(^TIU(8925,+DA,12),U,8),+$P(^TIU(8925,+DA,0),U),+X,(9999999-+$P(^TIU(8925,+DA,13),U)),+DA)=""
 S X=$P($G(DIKZ(0)),U,5)
 I X'="" I +$P($G(^TIU(8925,+DA,0)),U),+$P($G(^TIU(8925,+DA,12)),U,2),+$P($G(^TIU(8925,+DA,13)),U) S ^TIU(8925,"AAU",+$P(^TIU(8925,+DA,12),U,2),+$P(^TIU(8925,+DA,0),U),+X,(9999999-$P(^TIU(8925,+DA,13),U)),+DA)=""
 S X=$P($G(DIKZ(0)),U,5)
 I X'="" I +$P($G(^TIU(8925,+DA,0)),U),+$P($G(^TIU(8925,+DA,0)),U,2),+$P($G(^TIU(8925,+DA,13)),U) S ^TIU(8925,"APT",+$P(^TIU(8925,+DA,0),U,2),+$P(^TIU(8925,+DA,0),U),+X,(9999999-$P(^TIU(8925,+DA,13),U)),+DA)=""
 S X=$P($G(DIKZ(0)),U,5)
 I X'="" I +$P($G(^TIU(8925,+DA,0)),U),+$P($G(^TIU(8925,+DA,13)),U,2),+$P($G(^TIU(8925,+DA,13)),U) S ^TIU(8925,"ATC",+$P($G(^TIU(8925,+DA,13)),U,2),+$P(^TIU(8925,+DA,0),U),+X,(9999999-$P($G(^TIU(8925,+DA,13)),U)),DA)=""
 S X=$P($G(DIKZ(0)),U,5)
 I X'="" I +$P($G(^TIU(8925,+DA,0)),U),+$P($G(^TIU(8925,+DA,14)),U,2),+$P($G(^TIU(8925,+DA,13)),U) S ^TIU(8925,"ATS",+$P($G(^TIU(8925,+DA,14)),U,2),+$P(^TIU(8925,+DA,0),U),+X,(9999999-$P($G(^TIU(8925,+DA,13)),U)),DA)=""
 S X=$P($G(DIKZ(0)),U,5)
 I X'="" I +$P($G(^TIU(8925,+DA,0)),U),+$P($G(^TIU(8925,+DA,13)),U) S ^TIU(8925,"ALL","ANY",+$P(^TIU(8925,+DA,0),U),+X,(9999999-$P(^TIU(8925,+DA,13),U)),+DA)=""
 S X=$P($G(DIKZ(0)),U,5)
 I X'="" I +$P($G(^TIU(8925,+DA,0)),U),$L($P($G(^TIU(8925,+DA,17)),U)),+$P($G(^TIU(8925,+DA,13)),U) D ASUBS^TIUDD($P($G(^TIU(8925,+DA,17)),U),+$G(^TIU(8925,+DA,0)),+X,(9999999-+$G(^TIU(8925,+DA,13))),DA)
 S X=$P($G(DIKZ(0)),U,5)
 I X'="" I +$P($G(^TIU(8925,+DA,0)),U),+$P($G(^TIU(8925,+DA,14)),U,4),+$P($G(^TIU(8925,+DA,13)),U) S ^TIU(8925,"ASVC",+$P($G(^TIU(8925,+DA,14)),U,4),+$P(^TIU(8925,+DA,0),U),+X,(9999999-$P($G(^TIU(8925,+DA,13)),U)),DA)=""
 S X=$P($G(DIKZ(0)),U,5)
 I X'="" I +$P($G(^TIU(8925,+DA,12)),U,5),+$P($G(^TIU(8925,+DA,13)),U),+$P($G(^TIU(8925,+DA,0)),U) S ^TIU(8925,"ALOC",+$P($G(^TIU(8925,+DA,12)),U,5),+$P($G(^TIU(8925,+DA,0)),U),+X,(9999999-$P($G(^TIU(8925,+DA,13)),U)),DA)=""
 S X=$P($G(DIKZ(0)),U,5)
 I X'="" I +$P($G(^TIU(8925,+DA,0)),U),+$P($G(^TIU(8925,+DA,13)),U),+$O(^TIU(8925.9,"B",+DA,0)) D APRBS^TIUDD(+$G(^TIU(8925,+DA,0)),+X,(9999999-+$G(^TIU(8925,+DA,13))),DA)
 S X=$P($G(DIKZ(0)),U,5)
 I X'="" I +$P($G(^TIU(8925,+DA,0)),U),+$P($G(^TIU(8925,+DA,0)),U,3),+$P($G(^TIU(8925,+DA,13)),U) S ^TIU(8925,"AVSIT",+$P(^TIU(8925,+DA,0),U,3),+$P(^TIU(8925,+DA,0),U),+X,(9999999-$P(^TIU(8925,+DA,13),U)),+DA)=""
 S X=$P($G(DIKZ(0)),U,5)
 I X'="" I +$P($G(^TIU(8925,+DA,0)),U,2),+$P($G(^TIU(8925,+DA,13)),U),+$P($G(^TIU(8925,+DA,0)),U,4) S ^TIU(8925,"ADCPT",+$P(^TIU(8925,+DA,0),U,2),+$P(^TIU(8925,+DA,0),U,4),+X,(9999999-$P(^TIU(8925,+DA,13),U)),DA)=""
 S X=$P($G(DIKZ(0)),U,5)
 I X'="" D SACLPT^TIUDD0(.05,X)
 S X=$P($G(DIKZ(0)),U,5)
 I X'="" D SACLEC^TIUDD0(.05,X)
 S X=$P($G(DIKZ(0)),U,5)
 I X'="" D SACLAU^TIUDD0(.05,X),SACLAU1^TIUDD0(.05,X)
 S X=$P($G(DIKZ(0)),U,6)
 I X'="" S ^TIU(8925,"DAD",$E(X,1,30),DA)=""
 S X=$P($G(DIKZ(0)),U,7)
 I X'="" D SAPTLD^TIUDD0(.07,X)
 S X=$P($G(DIKZ(0)),U,12)
 I X'="" S ^TIU(8925,"FIX",$E(X,1,30),DA)=""
 S X=$P($G(DIKZ(0)),U,13)
 I X'="" D SAPTLD^TIUDD0(.13,X)
 S DIKZ(12)=$G(^TIU(8925,DA,12))
 S X=$P($G(DIKZ(12)),U,1)
 I X'="" S ^TIU(8925,"F",$E(X,1,30),DA)=""
 S X=$P($G(DIKZ(12)),U,2)
 I X'="" S ^TIU(8925,"CA",$E(X,1,30),DA)=""
 S X=$P($G(DIKZ(12)),U,2)
 I X'="" I +$P($G(^TIU(8925,+DA,0)),U),+$P($G(^TIU(8925,+DA,13)),U),+$P($G(^TIU(8925,+DA,0)),U,5) S ^TIU(8925,"AAU",+X,+$P(^TIU(8925,+DA,0),U),+$P(^TIU(8925,+DA,0),U,5),(9999999-$P(^TIU(8925,+DA,13),U)),+DA)=""
 S X=$P($G(DIKZ(12)),U,2)
 I X'="" I +$$AAUP^TIULX(+DA),+$P($G(^TIU(8925,+DA,15)),U) S ^TIU(8925,"AAUP",+X,+$P($G(^TIU(8925,+DA,15)),U),+DA)=""
 S X=$P($G(DIKZ(12)),U,2)
 I X'="" D SACLAU^TIUDD0(1202,X)
 S X=$P($G(DIKZ(12)),U,2)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(0)=X I '+$$ISDS^TIULX(+$G(^TIU(8925,+DA,0))) I X S X=DIV S Y(1)=$S($D(^TIU(8925,D0,14)):^(14),1:"") S X=$P(Y(1),U,4),X=X S DIU=X K Y X ^DD(8925,1202,1,5,1.1) X ^DD(8925,1202,1,5,1.4)
 S DIKZ(12)=$G(^TIU(8925,DA,12))
 S X=$P($G(DIKZ(12)),U,5)
 I X'="" I +$P($G(^TIU(8925,+DA,0)),U),+$P($G(^TIU(8925,+DA,13)),U),+$P($G(^TIU(8925,+DA,0)),U,5) S ^TIU(8925,"ALOC",+X,+$P($G(^TIU(8925,+DA,0)),U),+$P($G(^TIU(8925,+DA,0)),U,5),(9999999-$P($G(^TIU(8925,+DA,13)),U)),DA)=""
 S X=$P($G(DIKZ(12)),U,5)
 I X'="" I +$$ALOCP^TIULX(+DA),+$P($G(^TIU(8925,+DA,15)),U) S ^TIU(8925,"ALOCP",+X,+$P($G(^TIU(8925,+DA,15)),U),+DA)=""
 S X=$P($G(DIKZ(12)),U,7)
 I X'="" D:$D(^AUPNVSIT(+X)) ADD^AUPNVSIT
 S X=$P($G(DIKZ(12)),U,8)
 I X'="" S ^TIU(8925,"CS",$E(X,1,30),DA)=""
 S X=$P($G(DIKZ(12)),U,8)
 I X'="" I +$P($G(^TIU(8925,+DA,0)),U),+$P($G(^TIU(8925,+DA,13)),U),+$P($G(^TIU(8925,+DA,0)),U,5) S ^TIU(8925,"ASUP",+X,+$P(^TIU(8925,+DA,0),U),+$P(^TIU(8925,+DA,0),U,5),(9999999-$P($G(^TIU(8925,+DA,13)),U)),DA)=""
 S X=$P($G(DIKZ(12)),U,8)
 I X'="" D SACLEC^TIUDD0(1208,X)
 S X=$P($G(DIKZ(12)),U,11)
 I X'="" D SAPTLD^TIUDD0(1211,X)
 S DIKZ(13)=$G(^TIU(8925,DA,13))
 S X=$P($G(DIKZ(13)),U,1)
 I X'="" I +$P($G(^TIU(8925,+DA,0)),U),+$P($G(^TIU(8925,+DA,12)),U,2),+$P($G(^TIU(8925,+DA,0)),U,5) S ^TIU(8925,"AAU",+$P(^TIU(8925,+DA,12),U,2),+$P(^TIU(8925,+DA,0),U),+$P(^TIU(8925,+DA,0),U,5),(9999999-X),+DA)=""
 S X=$P($G(DIKZ(13)),U,1)
 I X'="" I +$P($G(^TIU(8925,+DA,0)),U),+$P($G(^TIU(8925,+DA,12)),U,8),+$P($G(^TIU(8925,+DA,0)),U,5) S ^TIU(8925,"ASUP",+$P(^TIU(8925,+DA,12),U,8),+$P(^TIU(8925,+DA,0),U),+$P(^TIU(8925,+DA,0),U,5),(9999999-X),+DA)=""
 S X=$P($G(DIKZ(13)),U,1)
 I X'="" I +$P($G(^TIU(8925,+DA,0)),U),+$P($G(^TIU(8925,+DA,0)),U,2),+$P($G(^TIU(8925,+DA,0)),U,5) S ^TIU(8925,"APT",+$P(^TIU(8925,+DA,0),U,2),+$P(^TIU(8925,+DA,0),U),+$P(^TIU(8925,+DA,0),U,5),(9999999-X),+DA)=""
 S X=$P($G(DIKZ(13)),U,1)
 I X'="" I +$P($G(^TIU(8925,+DA,0)),U),+$P($G(^TIU(8925,+DA,14)),U,2),+$P($G(^TIU(8925,+DA,0)),U,5) S ^TIU(8925,"ATS",+$P(^TIU(8925,+DA,14),U,2),+$P(^TIU(8925,+DA,0),U),+$P(^TIU(8925,+DA,0),U,5),(9999999-X),+DA)=""
 S X=$P($G(DIKZ(13)),U,1)
 I X'="" I +$P($G(^TIU(8925,+DA,0)),U),+$P($G(^TIU(8925,+DA,13)),U,2),+$P($G(^TIU(8925,+DA,0)),U,5) S ^TIU(8925,"ATC",+$P(^TIU(8925,+DA,13),U,2),+$P(^TIU(8925,+DA,0),U),+$P(^TIU(8925,+DA,0),U,5),(9999999-X),+DA)=""
 S X=$P($G(DIKZ(13)),U,1)
 I X'="" I +$P($G(^TIU(8925,+DA,0)),U),+$P($G(^TIU(8925,+DA,0)),U,5) S ^TIU(8925,"ALL","ANY",+$P(^TIU(8925,+DA,0),U),+$P(^TIU(8925,+DA,0),U,5),(9999999-X),+DA)=""
 S X=$P($G(DIKZ(13)),U,1)
 I X'="" I +$P($G(^TIU(8925,+DA,0)),U),+$P($G(^TIU(8925,+DA,0)),U,5),$L($P($G(^TIU(8925,+DA,17)),U)) D ASUBS^TIUDD($P($G(^TIU(8925,+DA,17)),U),+$G(^TIU(8925,+DA,0)),+$P($G(^TIU(8925,+DA,0)),U,5),(9999999-+X),DA)
 S X=$P($G(DIKZ(13)),U,1)
 I X'="" I +$P($G(^TIU(8925,+DA,0)),U),+$P($G(^TIU(8925,+DA,14)),U,4),+$P($G(^TIU(8925,+DA,0)),U,5) S ^TIU(8925,"ASVC",+$P(^TIU(8925,+DA,14),U,4),+$P(^TIU(8925,+DA,0),U),+$P(^TIU(8925,+DA,0),U,5),(9999999-X),+DA)=""
 S X=$P($G(DIKZ(13)),U,1)
END G ^TIUXRC4
