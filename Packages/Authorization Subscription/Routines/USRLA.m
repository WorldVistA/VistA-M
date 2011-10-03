USRLA ; SLC/JER,MA - Authorization Library functions ;6/29/01  11:19
 ;;1.0;AUTHORIZATION/SUBSCRIPTION;**15,20,29**;Jun 20, 1997;Build 7
CANDO(DOCTYPE,STATUS,EVENT,USER,USRROLE) ; Evaluate Authorization
 ; 18 JUNE 2001 MA added a change to check for "OR" logic
 ; when checking roles.
 ; Receives:  DOCTYPE = Pointer to TIU DOCMT DEF FILE (8925.1)
 ;             STATUS = Pointer to TIU STATUS FILE (8925.6)
 ;              EVENT = Pointer to USR EVENT FILE (8930.8)
 ;               USER = Pointer to NEW PERSON FILE (200)
 ;          [USRROLE] = Pointer to USER ROLE FILE (8930.2)
 ;                      Role, if received, is a particular role
 ;                      already known to belong to USER for docmt
 ;                      being checked.  See CANDO^TIULP.
 ;   DBIA  2321  ^TIU(8925.1)
 N USRC,USRCY,USRRY,USRR,USRY,USRFALSE
 ; First, loop thru Class xref "AC" to determine whether USER
 ; is a member of any subclasses which are authorized to perform
 ; EVENT on DOCTYPE with STATUS.
 ;
 ; Class Section
 ;
 S (USRC,USRY,USRFALSE)=0
 F  S USRC=$O(^USR(8930.1,"AC",DOCTYPE,STATUS,EVENT,USRC)) Q:+USRC'>0!(+$G(USRCY)>0&(USRY>0))  D
 . N USRADA,USRAND S USRADA=0
 . F  S USRADA=+$O(^USR(8930.1,"AC",DOCTYPE,STATUS,EVENT,USRC,USRADA)) Q:+USRADA'>0!(+$G(USRY)>0)  D
 . . S USRCY=+$$ISA^USRLM(USER,USRC)
 . . ; If user is NOT a member of the class for which a rule has been
 . . ; defined, set USRFALSE to indicate evaluation of a rule that
 . . ; was NOT satisfied.
 . . I +USRCY'>0 S USRFALSE=1
 . . ; If a match is obtained on user class, check to see whether
 . . ; additional conditions on user role exist.
 . . I +USRCY>0 D
 . . . S USRFALSE=0
 . . . I $P($G(^USR(8930.1,USRADA,0)),U,5)="&",($G(USRROLE)=$P($G(^(0)),U,6)) S USRY=1
 . . . I $P($G(^USR(8930.1,USRADA,0)),U,5)'="&" S USRY=1
 ; In the event that authorization is granted to users with a
 ; particular role with respect to the document, without concern
 ; for class membership, check the Role xref "AR".
 ;
 ; Role Section.
 ;
 I +USRY'>0,+$G(USRROLE) D
 . S USRR=0
 . F  S USRR=$O(^USR(8930.1,"AR",DOCTYPE,STATUS,EVENT,USRROLE,USRR)) Q:+USRR'>0!(USRY>0)  D
 . . ; Check for "&" condition
 . . I $P($G(^USR(8930.1,+USRR,0)),U,5)="&",+$P($G(^(0)),U,4) D
 . . . I +$$ISA^USRLM(+$G(USER),+$P($G(^USR(8930.1,+USRR,0)),U,4)) S USRY=1 ; **15** Changed DUZ to USER.
 . . ; Check for only a role needed
 . . I '+USRY,'+$P($G(^USR(8930.1,+USRR,0)),U,4) S USRY=1
 . . ; Check for an "OR" condition
 . . ;I '+USRY,$P($G(^USR(8930.1,+USRR,0)),U,5)="!" D
 . . I '+USRY,$P($G(^USR(8930.1,+USRR,0)),U,5)'="&" D
 . . . N USRCLS
 . . . S USRCLS=+$P($G(^USR(8930.1,+USRR,0)),U,4)
 . . . I +$$ISA^USRLM(+$G(USER),+USRCLS)!USRROLE=+$P($G(^USR(8930.1,+USRR,0)),U,6) S USRY=1
 ;
 I +USRY'>0,+$G(USRROLE)'>0,$D(^USR(8930.1,"AR",DOCTYPE,STATUS,EVENT)) S USRFALSE=1
 ;
 ; To allow heritability of authorization, if the user is not
 ; authorized to perform the specified action on the specific
 ; document in its current state, AND if no explicit rule for
 ; the current document definition failed (i.e., USRFALSE'>0),
 ; then traverse up the document class hierarchy and evaluate
 ; whether authorization is granted at a higher level.
 I +USRY'>0,(+$G(USRFALSE)'>0) D
 . N USRTYP S USRTYP=0
 . F  S USRTYP=$O(^TIU(8925.1,"AD",DOCTYPE,USRTYP)) Q:+USRTYP'>0!(+USRY>0)  D
 . . S USRY=$$CANDO(USRTYP,STATUS,EVENT,USER,$G(USRROLE))
 Q USRY
