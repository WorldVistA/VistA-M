LBRYX53 ; COMPILED XREF FOR FILE #680.5 ; 10/15/04
 ; 
 S DIKZK=1
 S DIKZ(0)=$G(^LBRY(680.5,DA,0))
 S X=$P(DIKZ(0),U,1)
 I X'="" S ^LBRY(680.5,"B",$E(X,1,30),DA)=""
 S X=$P(DIKZ(0),U,1)
 I X'="" S %1=1 F %=1:1:$L(X)+1 S I=$E(X,%) I "(,.?! '-/&:;)"[I S I=$E($E(X,%1,%-1),1,30),%1=%+1 I $L(I)>2,^DD("KWIC")'[I,I'="AMERICAN",I'="AMERICA",I'="JOURNAL" S ^LBRY(680.5,"C",I,DA)=""
 S DIKZ(3)=$G(^LBRY(680.5,DA,3))
 S X=$P(DIKZ(3),U,1)
 I X'="" S ^LBRY(680.5,"H",$E(X,1,30),DA)=""
 S X=$P(DIKZ(3),U,5)
 I X'="" S ^LBRY(680.5,"E",$E(X,1,30),DA)=""
 S X=$P(DIKZ(3),U,8)
 I X'="" S ^LBRY(680.5,"D",$E(X,1,30),DA)=""
 S X=$P(DIKZ(0),U,6)
 I X'="" S ^LBRY(680.5,"F",$E(X,1,30),DA)=""
END G ^LBRYX54
