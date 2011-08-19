LBRYX33 ; COMPILED XREF FOR FILE #682 ; 10/15/04
 ; 
 S DIKZK=1
 S DIKZ(0)=$G(^LBRY(682,DA,0))
 S X=$P(DIKZ(0),U,1)
 I X'="" S ^LBRY(682,"B",$E(X,1,30),DA)=""
 S X=$P(DIKZ(0),U,2)
 I X'="" S ^LBRY(682,"C",$E(X,1,30),DA)=""
 S X=$P(DIKZ(0),U,2)
 I X'="" S:$P($G(^LBRY(682,DA,1)),U) ^LBRY(682,"AC",$E(X,1,30),$P(^LBRY(682,DA,1),U),DA)=""
 S X=$P(DIKZ(0),U,2)
 I X'="" S:$P($G(^LBRY(682,DA,1)),U)'="" ^LBRY(682,"A1",$E(X,1,30),9999999-$P(^LBRY(682,DA,1),U),DA)=""
 S X=$P(DIKZ(0),U,2)
 I X'="" N LBRTYPE S LBRTYPE="SET" D A4^LBRYRTX
 S X=$P(DIKZ(0),U,4)
 I X'="" S ^LBRY(682,"E",$E(X,1,30),DA)=""
 S DIKZ(1)=$G(^LBRY(682,DA,1))
 S X=$P(DIKZ(1),U,1)
 I X'="" S:$P($G(^LBRY(682,DA,0)),U,2)'="" ^LBRY(682,"AC",$P(^LBRY(682,DA,0),U,2),$E(X,1,30),DA)=""
 S X=$P(DIKZ(1),U,1)
 I X'="" S:$P($G(^LBRY(682,DA,0)),U,2)'="" ^LBRY(682,"A1",$P(^LBRY(682,DA,0),U,2),9999999-X,DA)=""
 S X=$P(DIKZ(1),U,1)
 I X'="" D I^LBRYRTX
 S X=$P(DIKZ(1),U,1)
 I X'="" S ^LBRY(682,"D",$E(X,1,30),DA)=""
END G ^LBRYX34
