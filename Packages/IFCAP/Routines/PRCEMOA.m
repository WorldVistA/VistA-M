PRCEMOA ;WOIFO/SAB - 1358 OBLIGATION APIS ;6/30/11  15:34
V ;;5.1;IFCAP;**152,158**;Oct 20, 2000;Build 1
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
UOKCERT(PRCOUT,PRC1358,PRCPER) ; User OK as Certifier for a 1358
 ; This API verifies that the person would not violate segregation of
 ; duty when certifying an invoice associated with a 1358 obligation
 ; by ensuring that they have not previously acted as a requestor,
 ; approver, or obligator on that 1358.
 ;
 ; inputs
 ;   PRCOUT  - output variable, passed by reference
 ;   PRC1358 - 1358 obligation number (e.g. 688-C15001)
 ;   PRCPER  - User, NEW PERSON (#200) file IEN
 ; output
 ;   PRCOUT will be set equal to one of the following values
 ;   =1  if person can certify an invoice associated with the 1358
 ;   =0^text  if person not OK as certifier due to segregation of duties
 ;     where text is of the form
 ;       You are the 'role' of 'an event'.
 ;       e.g. "You are the Requestor of an Adjustment to the 1358."
 ;   =E^text  if problem with inputs or the 1358 data
 ;     where list of possible error text is:
 ;       The 1358 number was not specified.
 ;       The Person was not specified.
 ;       The 1358 was not found in file 442.
 ;       The document is not a 1358.
 ;       The PRIMARY 2237 value is missing.
 ;
 N PRC410P,PRC442,PRCLIST,PRCODI
 S PRCOUT=1 ; init output value
 ;
 ; verify inputs
 D
 . N PRCY0
 . ; check for required inputs
 . I $G(PRC1358)="" S PRCOUT="E^The 1358 number was not specified." Q
 . I $G(PRCPER)="" S PRCOUT="E^The Person was not specified." Q
 . ;
 . ; find 1358 in file 442
 . S PRC442=$O(^PRC(442,"B",PRC1358,0))
 . I PRC442'>0 S PRCOUT="E^The 1358 was not found in file 442." Q
 . ;
 . S PRCY0=$G(^PRC(442,PRC442,0))
 . ;
 . ; Verify METHOD OF PROCESSING = IEN 21 1358 OBLIGATION
 . I $P(PRCY0,U,2)'=21 S PRCOUT="E^The document is not a 1358." Q
 . ;
 . ; get PRIMARY 2237
 . S PRC410P=$P(PRCY0,U,12)
 . I PRC410P="" S PRCOUT="E^The PRIMARY 2237 value is missing." Q
 ;
 ; loop thru OBLIGATION DATA multiple
 I PRCOUT D
 . S PRCODI=0
 . F  S PRCODI=$O(^PRC(442,PRC442,10,PRCODI)) Q:'PRCODI  D  Q:'PRCOUT
 . . N PRC410,PRC410A,PRC7Y,PRCACT,PRCEVENT,PRCODY0,PRCROLE
 . . S PRCODY0=$G(^PRC(442,PRC442,10,PRCODI,0))
 . . ;
 . . ; skip entries that are not SO or AR code sheet (excludes PV)
 . . Q:"^SO^AR^"'[(U_$E(PRCODY0,1,2)_U)
 . . ;
 . . S PRC410A=$P(PRCODY0,U,11) ; 1358 ADJUSTMENT
 . . S PRC410=$S(PRC410A]"":PRC410A,1:PRC410P) ; associated 410 entry
 . . ;
 . . ; determine event type and if not rebuild add 410 entry to list
 . . I $D(PRCLIST(PRC410)) S PRCEVENT="R"  ; rebuild
 . . E  S PRCEVENT=$S(PRC410A]"":"A",1:"O"),PRCLIST(PRC410)=""
 . . ;
 . . ; quit if rebuild since that does not impact certifier role
 . . Q:PRCEVENT="R"
 . . ;
 . . I $P(PRCODY0,U,2) S PRCACT($P(PRCODY0,U,2))="O" ; OBLIGATED BY
 . . ; get REQUESTOR and APPROVER from file 410
 . . S PRC7Y=$G(^PRCS(410,PRC410,7))
 . . I $P(PRC7Y,U,1) S PRCACT($P(PRC7Y,U,1))="R" ; REQUESTOR
 . . I $P(PRC7Y,U,3) S PRCACT($P(PRC7Y,U,3))="A" ; APPROVING OFFICIAL
 . . ;
 . . ; check if person acted on this 1358 event in IFCAP 
 . . S PRCROLE=$G(PRCACT(PRCPER))
 . . I PRCROLE]"" D
 . . . S PRCOUT="0^You are the "
 . . . S PRCOUT=PRCOUT_$S(PRCROLE="R":"Requestor",PRCROLE="A":"Approving Official",1:"Obligator")
 . . . S PRCOUT=PRCOUT_" "_$S(PRCEVENT="O":"of the 1358",1:"of an Adjustment to the 1358")_"."
 ;
 Q
 ;
EV1358(PRC1358,PRCARR) ; Events (and Actors) for a 1358
 ; input
 ;   PRC1358 - 1358 number (e.g. 688-C15001)
 ;   PRCARR  - (optional) results array name, passed by value,
 ;             closed root, default value is "^TMP(""PRC1358"",$J)"
 ;             The root must NOT be a variable name newed by this API
 ;              (PRC1358,PRCARR,PRC410P,PRC442,PRCLIST,PRCODI,PRCRET)
 ; return value = 1 or E^text
 ;   = 1 if no problems
 ;   = E^text if problem with inputs or 1358 data
 ;     List of possible errors
 ;       The array name is invalid.
 ;       The 1358 number was not specified.
 ;       The 1358 was not found in file 442.
 ;       The document is not a 1358.
 ;       The PRIMARY 2237 value is missing.
 ; output
 ;   PRCARR - array is initialized and populated
 ;      PRCARR(DATE/TIME,EVENT)=REQUESTOR^APPROVER^OBLIGATOR
 ;      where
 ;        DATE/TIME is a FileMan Date/Time (internal format) when
 ;          the transaction was obligated
 ;        EVENT is O (OBLIGATE), or A (ADJUST)
 ;        REQUESTOR is a NEW PERSON ien or null value
 ;        APPROVER is a NEW PERSON ien or null value
 ;        OBLIGATOR is a NEW PERSON ien or null value
 ;      e.g. ^TMP("PRCS1358",$J,3101005.091223,"O")=134^5432^43
 ;           ^TMP("PRCS1358",$J,3101007.101501,"A")=134^9473^4677
 ;
 N PRC410P,PRC442,PRCLIST,PRCODI,PRCRET
 K ^TMP("PRC1358",$J) ; init results
 S PRCRET=1 ; init return value
 ;
 ; verify inputs
 D
 . N PRCY0
 . ; check optional array root name
 . I "^PRC1358^PRCARR^PRC410P^PRC442^PRCLIST^PRCODI^PRCRET^"[(U_$P($G(PRCARR),"(")_U) S PRCRET="E^The array name is invalid." Q
 . ;
 . ; check for required inputs
 . I $G(PRC1358)="" S PRCRET="E^The 1358 number was not specified." Q
 . ;
 . ; find 1358 in file 442
 . S PRC442=$O(^PRC(442,"B",PRC1358,0))
 . I PRC442'>0 S PRCRET="E^The 1358 was not found in file 442." Q
 . ;
 . S PRCY0=$G(^PRC(442,PRC442,0))
 . ;
 . ; Verify METHOD OF PROCESSING = IEN 21 1358 OBLIGATION
 . I $P(PRCY0,U,2)'=21 S PRCRET="E^The document is not a 1358." Q
 . ;
 . ; get PRIMARY 2237
 . S PRC410P=$P(PRCY0,U,12)
 . I PRC410P="" S PRCRET="E^The PRIMARY 2237 value is missing." Q
 ;
 ; loop thru OBLIGATION DATA multiple
 I PRCRET D
 . S PRCODI=0 F  S PRCODI=$O(^PRC(442,PRC442,10,PRCODI)) Q:'PRCODI  D
 . . N PRC410,PRC410A,PRC7Y,PRCDT,PRCODY0,PRCEVENT,PRCRA,PRCRO,PRCRR
 . . S PRCODY0=$G(^PRC(442,PRC442,10,PRCODI,0))
 . . ;
 . . ; skip entries that are not SO or AR code sheet (excludes PV)
 . . Q:"^SO^AR^"'[(U_$E(PRCODY0,1,2)_U)
 . . ;
 . . S PRCDT=$P(PRCODY0,U,6) ; DATE SIGNED
 . . S PRC410A=$P(PRCODY0,U,11) ; 1358 ADJUSTMENT
 . . S PRC410=$S(PRC410A]"":PRC410A,1:PRC410P) ; associated 410 entry
 . . ;
 . . ; determine event type and if not rebuild add 410 entry to list
 . . I $D(PRCLIST(PRC410)) S PRCEVENT="R" ; REBUILD
 . . E  S PRCEVENT=$S(PRC410A]"":"A",1:"O"),PRCLIST(PRC410)=""
 . . ;
 . . ; quit if rebuild since that does not impact certifier role
 . . Q:PRCEVENT="R"
 . . ;
 . . S PRCRO=$P(PRCODY0,U,2) ; OBLIGATED BY
 . . ; get REQUESTOR and APPROVER from file 410
 . . S PRC7Y=$G(^PRCS(410,PRC410,7))
 . . S PRCRR=$P(PRC7Y,U,1) ; REQUESTOR
 . . S PRCRA=$P(PRC7Y,U,3) ; APPROVING OFFICIAL
 . . ;
 . . ; save data to ^TMP
 . . S ^TMP("PRC1358",$J,PRCDT,PRCEVENT)=$G(PRCRR)_U_$G(PRCRA)_U_$G(PRCRO)
 ;
 ; if an output array was specified, move the data to it
 I PRCRET,$G(PRCARR)]"",$D(^TMP("PRC1358",$J)) D
 . Q:($NA(@PRCARR,2))=("^TMP(""PRC1358"","_$J_")")  ; same as default
 . K @PRCARR
 . M @PRCARR=^TMP("PRC1358",$J)
 . K ^TMP("PRC1358",$J)
 ;
 Q PRCRET
 ;
 ;
AUTHR(PRCSTR) ;Returns string AuthorityDesc^Sub-AuthorityDesc for 1358 request
 ; given string of AuthorityIEN^Sub-AuthorityIEN
 N PRCX S PRCX=""
 I PRCSTR]"" S PRCX=$P($G(^PRCS(410.9,+PRCSTR,0)),U,2)_"^"_$P($G(^PRCS(410.9,+$P(PRCSTR,U,2),0)),U,2)
 Q PRCX
