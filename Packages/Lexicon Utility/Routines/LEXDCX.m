LEXDCX ; ISL Default Shortcut Context             ; 09-23-96
 ;;2.0;LEXICON UTILITY;;Sep 23, 1996
 ;
 ; Entry:  D EN^LEXDCX              LEXAP is unknown
 ;
 ; Entry:  D EN1^LEXDCX(LEXAP)     LEXAP is known
 ;
 ; Single user entry point - Saves Default Shortcut 
 ;                           Context in file 757.2
 ;
 ; Where 
 ;
 ;      LEXAP     Pointer to file 757.2
 ;      LEXCA     Action (modify/delete)
 ;      LEXDEL    Flag default for Deletion
 ;      LEXDNAM   Default Name
 ;      LEXDVAL   Default Value
 ;      LEXFIL    Flag for Filter
 ;      LEXFLD    Default field (1-4) in file 757.201
 ;      LEXUSER   DUZ of user
 ;      LEXX      Returned value
 ;
EN ; Single user, LEXAP is unknown
 N LEXAP,X,Y S LEXAP=$$DFI^LEXDM4 Q:+LEXAP=0  W ! D EN1(LEXAP) Q
EN1(LEXAP) ; Single user, LEXAP is known
 N LEXUSER,LEXX S LEXUSER=$G(DUZ) Q:+LEXUSER'>0  Q:'$D(^VA(200,+LEXUSER))
 ;
 S LEXAP=$G(LEXAP) Q:LEXAP=""
 I '$D(^LEXT(757.2,+LEXAP,0))&('$D(^LEXT(757.2,"B",LEXAP)))&('$D(^LEXT(757.2,"C",$$UP^XLFSTR(LEXAP))))&('$D(^LEXT(757.2,"AN",LEXAP))) Q
 S:+LEXAP'>0 LEXAP=$$AP^LEXDFN2(LEXAP)
 ;
 Q:+($G(LEXAP))'>0  Q:+($P($G(^LEXT(757.2,+LEXAP,5)),"^",3))'>0
 K LEXFIL N LEXDVAL,LEXDNAM,LEXFLD S LEXFLD=4
 S LEXDVAL=$$EN^LEXDCXS Q:LEXDVAL="^^"
 S LEXDNAM=$P(LEXDVAL,"^",2),LEXDVAL=$P(LEXDVAL,"^",1)
 Q:LEXDVAL=""&(LEXDNAM="")  I LEXDVAL="",LEXDNAM'="" D  Q
 . N LEXDEL S LEXDEL=$$EN^LEXDM2(LEXUSER,LEXAP,4) I +LEXDEL>0 D KILL
 D SET
 Q
MGR(LEXX) ; Multi-user (for Manager options)
 ; Do not save display, return value to manager option
 N LEXCA,LEXDVAL S LEXCA=$$MOD^LEXDM(4) Q:LEXCA=0 "^" Q:(LEXCA="^^") "^^"
 Q:LEXCA="@" "@^Delete Shortcut Context" W ! S LEXDVAL=$$EN^LEXDCXS Q:LEXDVAL="^^" "^^"
 S LEXX=LEXDVAL Q LEXX
SET ; Set default Shortcut Context
 D SET^LEXDSV(LEXUSER,LEXAP,LEXDVAL,LEXDNAM,LEXFLD) Q
KILL ; Kill default Shortcut Context
 D SET^LEXDSV(LEXUSER,LEXAP,"@","Delete",LEXFLD) Q
