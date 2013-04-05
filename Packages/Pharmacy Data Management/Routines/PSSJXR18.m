PSSJXR18 ; COMPILED XREF FOR FILE #55 ; 09/12/12
 ; 
 S DIKZK=1
 S DIKZ(0)=$G(^PS(55,DA,0))
 S X=$P($G(DIKZ(0)),U,1)
 I X'="" S ^PS(55,"B",$E(X,1,30),DA)=""
 S X=$P($G(DIKZ(0)),U,1)
 I X'="" I '$D(PSGINITF) S ^PS(55,"ALCNVRT")=$S($D(^PS(59.7,1,20)):$P(^(20),"^"),1:"")
 S X=$P($G(DIKZ(0)),U,1)
 I X'="" I '$D(PSGINITF) S ^PS(55,"AUDDD")=$S($D(^PS(59.7,1,20)):$P(^(20),"^"),1:"")
 S X=$P($G(DIKZ(0)),U,1)
 I X'="" I '$D(PSGINITF) S ^PS(55,"AUDAPM")=$S($D(^PS(59.7,1,20)):$P(^(20),"^"),1:"")
 S X=$P($G(DIKZ(0)),U,4)
 I X'="" S ^PS(55,"ADIA",$E(X,1,30),DA)=""
 S DIKZ("SAND")=$G(^PS(55,DA,"SAND"))
 S X=$P($G(DIKZ("SAND")),U,1)
 I X'="" S ^PS(55,"ASAND",DA)=""
 S X=$P($G(DIKZ("SAND")),U,1)
 I X'="" S ^PS(55,"ASAND1",$E(X,1,30),DA)=""
CR1 S DIXR=816
 K X
 S X(1)=$P(DIKZ(0),U,7)
 S X=$G(X(1))
 I $G(X(1))]"" D
 . K X1,X2 M X1=X,X2=X
 . D LOGDFN^PSUHL(DA)
CR2 K X
END G ^PSSJXR19
