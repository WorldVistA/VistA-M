YSXRAR2 ; COMPILED XREF FOR FILE #618 ; 10/15/04
 ; 
 S DIKZK=1
 S DIKZ(0)=$G(^YSG("CEN",DA,0))
 S X=$P(DIKZ(0),U,1)
 I X'="" S ^YSG("CEN","B",$E(X,1,30),DA)=""
 S X=$P(DIKZ(0),U,2)
 I X'="" S ^YSG("CEN","SYN",$E(X,1,30),DA)=""
 S X=$P(DIKZ(0),U,3)
 I X'="" S ^YSG("CEN","AFS",$E(X,1,30),DA)=""
 S X=$P(DIKZ(0),U,12)
 I X'="" S ^YSG("CEN","ABS",$E(X,1,30),DA)=""
END Q
