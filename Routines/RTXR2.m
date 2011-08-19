RTXR2 ; COMPILED XREF FOR FILE #190 ; 10/15/04
 ; 
 S DIKZK=1
 S DIKZ(0)=$G(^RT(DA,0))
 S X=$P(DIKZ(0),U,1)
 I X'="" S ^RT("B",$E(X,1,30),DA)=""
 S X=$P(DIKZ(0),U,3)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^RT(D0,0)):^(0),1:"") S X=$P(Y(1),U,4),X=X S DIU=X K Y X ^DD(190,3,1,1,1.1) X ^DD(190,3,1,1,1.4)
 S X=$P(DIKZ(0),U,3)
 I X'="" S ^RT("AT",X,$P(^RT(DA,0),U),DA)=""
 S DIKZ(0)=$G(^RT(DA,0))
 S X=$P(DIKZ(0),U,4)
 I X'="" S ^RT("AA",X,$P(^RT(DA,0),U),DA)=""
 S X=$P(DIKZ(0),U,5)
 I X'="" S ^RT("P",$E(X,1,30),DA)=""
 S X=$P(DIKZ(0),U,6)
 I X'="" S ^RT("AH",$E(X,1,30),DA)=""
 S X=$P(DIKZ(0),U,6)
 I X'="" X ^DD(190,6,1,2,1)
 S DIKZ(0)=$G(^RT(DA,0))
 S X=$P(DIKZ(0),U,9)
 I X'="" S ^RT("C",$E(X,1,30),DA)=""
 S X=$P(DIKZ(0),U,11)
 I X'="" S ^RT("AR",$E(X,1,30),DA)=""
 S X=$P(DIKZ(0),U,13)
 I X'="" S:X="y" ^RT("AL",X,DA)=""
 S DIKZ("CL")=$G(^RT(DA,"CL"))
 S X=$P(DIKZ("CL"),U,5)
 I X'="" S ^RT("ABOR",$E(X,1,30),DA)=""
 S X=$P(DIKZ("CL"),U,5)
 I X'="" X ^DD(190,105,1,2,1)
 S DIKZ("CL")=$G(^RT(DA,"CL"))
 S X=$P(DIKZ("CL"),U,6)
 I X'="" X ^DD(190,106,1,1,1)
 S DIKZ("OLDBC")=$G(^RT(DA,"OLDBC"))
 S X=$E(DIKZ("OLDBC"),1,45)
 I X'="" S ^RT("AOLDBC",$E(X,1,30),DA)=""
END Q
