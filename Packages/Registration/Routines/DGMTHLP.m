DGMTHLP ;ALB/GTS - Means Test Help processing code; 12/15/2005 ; 8/1/08 1:49pm
 ;;5.3;Registration;**688**;AUG 13, 1993;Build 29
 ;
CHLDINNW ; * Displays help for CHILD HAD INCOME (.11) in INCOME RELATION (408.22)
 N MTVER,MTIEN S MTVER=0
 S MTIEN=+$P($G(^DGMT(408.22,DA,"MT")),"^",1)
 I MTIEN S MTVER=+$P($G(^DGMT(408.31,MTIEN,2)),"^",11)
 W !
 I X="?" DO
 . I MTVER=0 W !,"Enter in this field whether the child had income last calendar year."
 . I MTVER=1 DO
 . . W !,"Enter in this field whether the child had earned or unearned income"
 . . W !,"and/or net worth last calendar year."
 I X="??" DO
 . I MTVER=0 DO
 . . W !,"Enter in this field whether the child had income last calendar year."
 . . W !,"Income payable to another person as guardian or custodian of the"
 . . W !,"child is considered to be the child's income."
 . I MTVER=1 DO
 . . W !,"Enter in this field whether the child had earned or unearned income"
 . . W !,"and/or net worth last calendar year.  Income payable to another person"
 . . W !,"as guardian or custodian of the child is considered to be the child's income."
 Q
 ;
INNWAVAL ; * Displays help for INCOME AVAILABLE TO YOU (.12) in INCOME RELATION (408.22)
 N MTVER,MTIEN,DGRDVAR S MTVER=0
 S MTIEN=+$P($G(^DGMT(408.22,DA,"MT")),"^",1)
 I MTIEN S MTVER=+$P($G(^DGMT(408.31,MTIEN,2)),"^",11)
 W !
 I X="?" DO
 . I MTVER=0 DO
 . . W !,"Enter in this field whether the child's income was available to the"
 . . W !,"veteran last calendar year."
 . I MTVER=1 DO
 . . W !,"Enter in this field whether the child's income and/or net worth were"
 . . W !,"available to the veteran last calendar year."
 I X="??" DO
 . I MTVER=0 DO
 . . W !,"Enter in this field whether the child's income was available to"
 . . W !,"the veteran last calendar year.  The child's income is deemed to be"
 . . W !,"available if it can be used to pay expenses of the veteran's household."
 . . W !,"For example, a Social Security check payable to the veteran's estranged"
 . . W !,"spouse as custodian of the child is probably not available to the"
 . . W !,"veteran.  On the other hand, a Social Security check on behalf of the child"
 . . W !,"payable to someone living in the veteran's household is probably available."
 . I MTVER=1 DO
 . . W !,"Enter in this field whether the child's income and/or net worth were"
 . . W !,"available to the veteran last calendar year.  The child's income and/or"
 . . W !,"net worth are almost always determined to be available.  A child's income"
 . . W !,"and/or net worth may be excluded when the child is not in the veteran's"
 . . W !,"custody and the veteran does not have direct access to the child's income"
 . . W !,"or when the veteran has custody, but he/she can prove that the income is not"
 . . W !,"available to him/her (e.g. a trust that the veteran doesn't have access to)"
 . . W !,"OR social security that's going to a separated spouse."
 . I $G(DA) W !,"Enter RETURN to continue:" R DGRDVAR:DTIME W !
 Q
