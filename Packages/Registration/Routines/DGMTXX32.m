DGMTXX32 ; COMPILED XREF FOR FILE #408.31 ; 04/23/09
 ; 
 S DIKZK=1
 S DIKZ(0)=$G(^DGMT(408.31,DA,0))
 S X=$P(DIKZ(0),U,1)
 I X'="" S ^DGMT(408.31,"B",$E(X,1,30),DA)=""
 S X=$P(DIKZ(0),U,1)
 I X'="" S:$P(^DGMT(408.31,DA,0),U,2)&($P(^(0),U,3))&($P(^(0),U,19)) ^DGMT(408.31,"AS",+$P(^(0),U,19),+$P(^(0),U,3),-X,+$P(^(0),U,2),DA)=""
 S X=$P(DIKZ(0),U,1)
 I X'="" S:$P(^DGMT(408.31,DA,0),U,2)&($P(^(0),U,19)) ^DGMT(408.31,"AID",+$P(^(0),U,19),+$P(^(0),U,2),-X,DA)=""
 S X=$P(DIKZ(0),U,1)
 I X'="" S:$P(^DGMT(408.31,DA,0),U,2)&($P(^(0),U,19)) ^DGMT(408.31,"AD",+$P(^(0),U,19),+$P(^(0),U,2),X,DA)=""
 S X=$P(DIKZ(0),U,1)
 I X'="" S:$P(^DGMT(408.31,DA,0),U,2) ^DGMT(408.31,"ADFN"_$P(^(0),U,2),X,DA)=""
 S X=$P(DIKZ(0),U,19)
 I X'="" S:$P(^DGMT(408.31,DA,0),U,2)&($P(^(0),U,3)) ^DGMT(408.31,"AS",X,+$P(^(0),U,3),-$P(^(0),U),+$P(^(0),U,2),DA)=""
 S X=$P(DIKZ(0),U,19)
 I X'="" S:$P(^DGMT(408.31,DA,0),U,2) ^DGMT(408.31,"AID",X,+$P(^(0),U,2),-$P(^(0),U),DA)=""
 S X=$P(DIKZ(0),U,19)
 I X'="" S:$P(^DGMT(408.31,DA,0),U,2) ^DGMT(408.31,"AD",X,+$P(^(0),U,2),$P(^(0),U),DA)=""
 S X=$P(DIKZ(0),U,19)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(0)=X S X=Y(0),X=X S X=X=2 I X S X=DIV S Y(1)=$S($D(^DGMT(408.31,D0,0)):^(0),1:"") S X=$P(Y(1),U,3),X=X S DIU=X K Y S X=DIV S X="9" X ^DD(408.31,.019,1,4,1.4)
 S DIKZ(0)=$G(^DGMT(408.31,DA,0))
 S X=$P(DIKZ(0),U,2)
 I X'="" S:$P(^DGMT(408.31,DA,0),U,3)&($P(^(0),U,19)) ^DGMT(408.31,"AS",$P(^(0),U,19),$P(^(0),U,3),-$P(^(0),U),X,DA)=""
 S X=$P(DIKZ(0),U,2)
 I X'="" S:$P(^DGMT(408.31,DA,0),U,19) ^DGMT(408.31,"AID",$P(^(0),U,19),X,-$P(^DGMT(408.31,DA,0),U),DA)=""
 S X=$P(DIKZ(0),U,2)
 I X'="" S ^DGMT(408.31,"C",$E(X,1,30),DA)=""
 S X=$P(DIKZ(0),U,2)
 I X'="" S:$P(^DGMT(408.31,DA,0),U,19) ^DGMT(408.31,"AD",$P(^DGMT(408.31,DA,0),U,19),X,$P(^(0),U),DA)=""
 S X=$P(DIKZ(0),U,2)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(0)=X X ^DD(408.31,.02,1,5,69.2) S Y=X,X=Y(2),X=X&Y I X S X=DIV S Y(1)=$S($D(^DGMT(408.31,D0,0)):^(0),1:"") S X=$P(Y(1),U,3),X=X S DIU=X K Y S X=DIV S X="1" X ^DD(408.31,.02,1,5,1.4)
 S X=$P(DIKZ(0),U,2)
 I X'="" S ^DGMT(408.31,"ADFN"_X,+^DGMT(408.31,DA,0),DA)=""
 S DIKZ(0)=$G(^DGMT(408.31,DA,0))
 S X=$P(DIKZ(0),U,3)
 I X'="" S:$P(^DGMT(408.31,DA,0),U,2)&($P(^(0),U,19)) ^DGMT(408.31,"AS",$P(^(0),U,19),X,-$P(^(0),U),+$P(^(0),U,2),DA)=""
 S X=$P(DIKZ(0),U,3)
 I X'="" D CUR^DGMTDD
 S X=$P(DIKZ(0),U,7)
 I X'="" S ^DGMT(408.31,"AG",$E(X,1,30),DA)=""
 S X=$P(DIKZ(0),U,11)
 I X'="" D:$G(DGMTYPT)<3 AUTOUPD^DGENA2(+$P(^DGMT(408.31,DA,0),U,2),2)
 S X=$P(DIKZ(0),U,16)
 I X'="" S ^DGMT(408.31,"AP",X,$P(^DGMT(408.31,DA,0),U),DA)=""
 S X=$P(DIKZ(0),U,20)
 I X'="" S ^DGMT(408.31,"AE",$E(X,1,30),DA)=""
 S X=$P(DIKZ(0),U,20)
 I X'="" S:'X $P(^DGMT(408.31,DA,0),U,21,22)="^"
 S DIKZ(2)=$G(^DGMT(408.31,DA,2))
 S X=$P(DIKZ(2),U,2)
 I X'="" D E40831^DGRTRIG(DA)
 S X=$P(DIKZ(2),U,8)
 I X'="" S ^DGMT(408.31,"AT",$E(X,1,30),DA)=""
END Q
