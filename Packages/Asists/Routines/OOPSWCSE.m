OOPSWCSE ;WIOFO/LLH-Workers' Comp Sign for Employee ;01/20/01
 ;;2.0;ASISTS;;Jun 03, 2002
 ;
EN1(CALLER) ; Entry point for routine
 ;  Input:   CALLER = "S" for Safety Officer
 ;                    "H" for Employee Health
 ;                    "W" for Workers' Comp
 ;
 N DIC,IEN,FORM,PRM1,PRM2,SIGN,VALID,Y
 Q:DUZ<1
 Q:$G(^VA(200,DUZ,1))=""
 S IEN=0
 S DIC="^OOPS(2260,"
 S DIC("S")="I $$SCR^OOPSWCSE(Y)"_",'$$GET1^DIQ(2260,Y,51,""I"")"
 S DIC(0)="AEMNZ",DIC("A")="   Select Case: "
 D ^DIC
 I (Y<1)!$D(DTOUT)!($D(DUOUT)) Q
 S IEN=$P(Y,U)
 S FORM=$$GET1^DIQ(2260,IEN,52,"I")
 S FORM=$S(FORM=1:"CA1",FORM=2:"CA2",1:"")
 I $G(FORM)="" Q
 D ^OOPSDIS
 S PRM1=$S(CALLER="S":"Safety Officer",CALLER="H":"Employee Health",1:0)
 S PRM2=PRM1_" approves the WCP signing for the Employee: "
 S SIGN=""
 I CALLER="W" G WCPS4E
 I $$VALID^OOPSWCSE() D
 . W !,PRM2
 . S SIGN=$$SIG^OOPSESIG(DUZ,IEN)
 . Q:+SIGN=0                          ; form not signed
 . I CALLER="S" S $P(^OOPS(2260,IEN,"WCSE"),U,1,3)=SIGN
 . I CALLER="H" S $P(^OOPS(2260,IEN,"WCSE"),U,4,6)=SIGN
 G EXIT
WCPS4E ; allow WCP to sign for employee if all approvals given
 N CONT,EHS,SIGN,SOS,VALID,VIEW
 S SIGN=0,VALID=0,VIEW=1
 S SOS=$$GET1^DIQ(2260,IEN,76,"I")
 S EHS=$$GET1^DIQ(2260,IEN,79,"I")
 S CONT=$S(DUZ=SOS:"S",DUZ=EHS:"H",1:"")
 I (CONT="S")!(CONT="H") D
 . W !,"You have approved as "_$S(CONT="S":"Safety Officer",CONT="H":"Emp Health Rep",1:"")
 . W " and cannot sign as Employee."
 . W !,"Three different individuals must be involved."
 . S VIEW=0
 I '$G(SOS) S VIEW=0 W !,"Safety Officer has not approved WCP signing for employee."
 I '$G(EHS) S VIEW=0 W !,"Employee Health has not approved WCP signing for employee."
 I VIEW D
 . ; Allow clearing WCP signature, employee may be able to sign
 . I $$GET1^DIQ(2260,IEN,119,"I") D CLRES^OOPSUTL1(IEN,"E",FORM)
 . W ! D VALIDATE^OOPSUTL4(IEN,FORM,"E",.VALID)
 . I 'VALID Q
 . S SIGN=$$SIG^OOPSESIG(DUZ,IEN)
 . Q:+SIGN=0
 . D EMP^OOPSVAL1
EXIT ;
 K DTOUT,DUOUT,SUP                           ; left over from OOPSDIS
 Q
VALID() ; make sure same person is not signing for both safety and EH and if
 ; signed from menu option being called not needed again - so quit
 N CONT,EHAPP,ERR,SOAPP,VALID
 S VALID=1,ERR=0
 S SOAPP=$P($G(^OOPS(2260,IEN,"WCSE")),U)
 S EHAPP=$P($G(^OOPS(2260,IEN,"WCSE")),U,4)
 S CONT=$S(DUZ=SOAPP:"S",DUZ=EHAPP:"H",1:"")
 I CALLER="S" D
 . I CONT="S" S ERR=1
 . I $G(EHAPP)=DUZ S ERR=2
 . I $G(SOAPP)&($G(CONT)="") S ERR=3
 I CALLER="H" D
 . I CONT="H" S ERR=1
 . I $G(SOAPP)=DUZ S ERR=2
 . I $G(EHAPP)&($G(CONT)="") S ERR=3
 I ERR=1 D
 . W !,"You have signed as "_PRM1_" if you continue, your ES will be removed"
 . N DIR,FLD,Y
 . W !
 . S DIR("A")="Continue",DIR(0)="SBM^Y:Yes;N:No"
 . D ^DIR
 . I Y="Y" D
 .. S FLD=$S(CALLER="S":"1,3",CALLER="H":"4,6",1:"")
 .. F I=$P(FLD,","):1:$P(FLD,",",2) S $P(^OOPS(2260,IEN,"WCSE"),U,I)=""
 . I Y'="Y" S VALID=0
 I ERR=2 D
 . W !,"You have already signed as "
 . W $S(CALLER="S":"Employee Health",CALLER="H":"Safety Officer",1:0)
 . W ".",!,"Both signatures cannot be made by the same person."
 . S VALID=0
 I ERR=3 D
 . W !,PRM1_" has already signed, re-signing is not required."
 . S VALID=0
 Q VALID
SCR(IEN) ; Screen to allow access to claims that have not been
 ; signed by the Employee
 ; Input:  IEN = Internal record number of claim
 N VIEW,EES,ESTAT,FORM,FLD
 S VIEW=1
 S FORM=$$GET1^DIQ(2260,IEN,52,"I")
 I '$$ISEMP^OOPSUTL4(IEN) S VIEW=0                  ; not emp, can't sign
 S ESTAT=$$EDSTA^OOPSUTL1(IEN,"E")                  ; employee signed?
 I CALLER'="W",$P(ESTAT,U,FORM) S VIEW=0            ; employee signed
 I CALLER="W" D                                     ; from WC menu
 . S FLD=$S(FORM=1:119,FORM=2:221,1:"")
 . I 'FLD S VIEW=0 Q
 . S EES=$$GET1^DIQ(2260,IEN,FLD,"I")
 . I 'EES Q                                         ; not signed by emp
 . I EES'=DUZ S VIEW=0 Q                            ; signer = user
 . I $P($$EDSTA^OOPSUTL1(IEN,"S"),U,FORM) S VIEW=0  ; Super Signed
 Q VIEW
