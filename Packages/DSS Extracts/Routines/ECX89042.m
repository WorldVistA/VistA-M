ECX89042 ; COMPILED XREF FOR FILE #728.904 ; 11/01/12
 ; 
 S DIKZK=1
 S DIKZ(0)=$G(^ECX(728.904,DA,0))
 S X=$P($G(DIKZ(0)),U,1)
 I X'="" S ^ECX(728.904,"AINV",-X,DA)=""
 S X=$P($G(DIKZ(0)),U,3)
 I X'="" S ^ECX(728.904,"A",$E(X,1,30),DA)=""
 S DIKZ(1)=$G(^ECX(728.904,DA,1))
 S X=$P($G(DIKZ(1)),U,1)
 I X'="" S ^ECX(728.904,"AC",$E(X,1,30),DA)=""
CR1 S DIXR=317
 K X
 S X(1)=$P(DIKZ(0),U,2)
 S X(2)=$P(DIKZ(0),U,10)
 S X=$G(X(1))
 I $G(X(1))]"",$G(X(2))]"" D
 . K X1,X2 M X1=X,X2=X
 . S ^ECX(728.904,"AO",X(1),X(2),DA)=""
CR2 K X
END Q
