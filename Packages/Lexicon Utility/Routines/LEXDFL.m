LEXDFL ;ISL/KER - Default Filter ;04/21/2014
 ;;2.0;LEXICON UTILITY;**80**;Sep 23, 1996;Build 1
 ;               
 ; Global Variables
 ;    None
 ;               
 ; External References
 ;    $$GET1^DIQ          ICR   2056
 ;    $$UP^XLFSTR         ICR  10103
 ;               
 ; Entry:  D EN^LEXDFL             LEXAP is unknown
 ;
 ; Entry:  D EN1^LEXDFL(LEXAP)    LEXAP is known
 ;
 ; Single user entry point - Saves Filter in file 757.2
 ;
 ; Where 
 ;
 ;      LEXAP     Pointer to file 757.2
 ;      LEXUSER   DUZ of user
 ;      LEXCA     Action (modify/delete)
 ;      LEXCM     Method (predefined/create)
 ;
EN ; Single user, LEXAP is unknown
 N LEXAP S LEXAP=$$DFI^LEXDM4 Q:+LEXAP=0  W ! D EN1(LEXAP) Q
EN1(LEXAP) ; Single user, LEXAP is known
 N LEXUSER,LEXX S LEXUSER=$G(DUZ) Q:+LEXUSER'>0  Q:'$L($$GET1^DIQ(200,+($G(DUZ)),.01))
 ;
 S LEXAP=$G(LEXAP) Q:LEXAP=""
 I '$D(^LEXT(757.2,+LEXAP,0))&('$D(^LEXT(757.2,"B",LEXAP)))&('$D(^LEXT(757.2,"C",$$UP^XLFSTR(LEXAP))))&('$D(^LEXT(757.2,"AN",LEXAP))) Q
 S:+LEXAP'>0 LEXAP=$$AP^LEXDFN2(LEXAP)
 ;
 Q:+($G(LEXAP))'>0  Q:+($P($G(^LEXT(757.2,+LEXAP,5)),"^",3))'>0
 N LEXCA,LEXCM,LEXDVAL,LEXDNAM,LEXFLD,LEXFIL S LEXFIL=""
 S LEXFLD=1,LEXCA=$$MOD^LEXDM(1) Q:LEXCA=0!(LEXCA="^^")
 D:LEXCA="@" KILL Q:LEXCA="@"  W ! S LEXCM=$$MTH^LEXDM(1) Q:LEXCM["^"
 S:LEXCM=1 LEXDVAL=$$EN^LEXDFLS
 S:LEXCM=2 LEXDVAL=$$EN^LEXDFLC Q:LEXDVAL="^^"
 S LEXDNAM=$P(LEXDVAL,"^",$L(LEXDVAL,"^")),LEXDVAL=$P(LEXDVAL,"^",1,($L(LEXDVAL,"^")-1))
 D SET
 Q
MGR(LEXX) ; Multi-user (for Manager options)
 ; Do not save filter, return value to manager option
 N LEXCA,LEXCM,LEXDVAL S LEXX=""
 S LEXCA=$$MOD^LEXDM(1) Q:LEXCA=0 "^" Q:(LEXCA="^^") "^^"
 Q:LEXCA="@" "@^Delete filter"
 W ! S LEXCM=$$MTH^LEXDM(1) S:LEXCM[U LEXX=U S:LEXCM["^^" LEXX="^^"
 Q:LEXX["^" LEXX
 S:LEXCM=1 LEXDVAL=$$EN^LEXDFLS S:LEXCM=2 LEXDVAL=$$EN^LEXDFLC
 Q:LEXDVAL="^^" "^^"
 S LEXX=LEXDVAL Q LEXX
SET ; Set default filter
 D SET^LEXDSV(LEXUSER,LEXAP,LEXDVAL,LEXDNAM,LEXFLD) Q
KILL ; Kill default filter
 D SET^LEXDSV(LEXUSER,LEXAP,"@","Delete",LEXFLD) Q
