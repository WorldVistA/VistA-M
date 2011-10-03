YSXRAX3 ; COMPILED XREF FOR FILE #627.5 ; 10/15/04
 ; 
 S DIKZK=1
 S DIKZ(0)=$G(^DIC(627.5,DA,0))
 S X=$P(DIKZ(0),U,1)
 I X'="" S ^DIC(627.5,"B",$E(X,1,30),DA)=""
 S X=$P(DIKZ(0),U,2)
 I X'="" S ^DIC(627.5,"D",$E(X,1,30),DA)=""
 S DIKZ(1)=$G(^DIC(627.5,DA,1))
 S X=$P(DIKZ(1),U,1)
 I X'="" S %1=1 F %=1:1:$L(X)+1 S I=$E(X,%) I " "[I S I=$E($E(X,%1,%-1),1,30),%1=%+1 I $L(I)>2,^DD("KWIC")'[I S ^DIC(627.5,"E",I,DA)=""
END G ^YSXRAX4
