DGMTEVT ;ALB/RMO - Means Test Event Driver; 24 JAN 92
 ;;5.3;Registration;;Aug 13, 1993
 ;
 ;Invokes items on the means test event protocol menu
 ; Input  -- DFN      Patient IEN
 ;           DGMTACT  Means Test Action
 ;                     ADD=Add, EDT=Edit, COM=Complete, ADJ=Adjudicate
 ;                     DEL=Delete, CAT=Category change,
 ;                     STA=Status Change
 ;           DGMTI    Means Test IEN
 ;           DGMTINF  Means Test Interactive/Non-interactive flag
 ;                     0=Interactive
 ;                     1=Non-interactive
 ;           DGMTP    Annual Means Test 0th node PRIOR to
 ;                     Add, Edit or Delete
 ;           DGMTA    Annual Means Test 0th node AFTER
 ;                     Add, Edit or Delete
 ; Output -- None
 ;
EN K DTOUT,DIROUT
 S X=$O(^ORD(101,"B","DG MEANS TEST EVENTS",0))_";ORD(101," D EN1^XQOR:X K X
 Q
 ;
PRIOR ;Set DGMTP prior to Add, Edit or Delete
 ; Input  -- DGMTACT  Means Test Action
 ;           DGMTI    Means Test IEN
 ; Output -- DGMTP    Means Test 0th node prior to action
 S DGMTP=$S(DGMTACT'="ADD":$G(^DGMT(408.31,DGMTI,0)),1:"")
 Q
 ;
AFTER ;Set DGMTA after to Add, Edit or Delete
 ; Input  -- DGMTACT  Means Test Action
 ;           DGMTI    Means Test IEN
 ; Output -- DGMTA    Means Test 0th node after action
 S DGMTA=$S(DGMTACT'="DEL":$G(^DGMT(408.31,DGMTI,0)),1:"")
 Q
