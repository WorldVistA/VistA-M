DGMTDD3 ;ALB/RMO - Individual Annual Income file (#408.21) Data Dictionary Calls ;17 MAR 1992 10:46 am
 ;;5.3;Registration;**688**;Aug 13, 1993;Build 29
 ;
 ;DG*688 changed NET tag to only screen entry of Child Net Worth data when the means test is version 0
 ;
ID ;Identifier for Individual Annual Income file
 N DGPRI
 S DGPRI=+$P($G(^(0)),U,2)
 W "  ",$P($G(^DPT(+$G(^DGPR(408.12,DGPRI,0)),0)),U) W:$P($G(^DGPR(408.12,DGPRI,0)),U,2)'=1 "    Relation: ",$$NAME^DGMTU1(DGPRI),"  (",$$REL^DGMTU1(DGPRI),")"
 Q
 ;
EMP ;"Trigger" Cross-reference on the Total Income From Employment
 ;field (#.14) to delete educational expenses on file for a child
 N DGFLD,DGIN0,DGLY,DGMTPAR,DGVAL
 S DGIN0=$G(^DGMT(408.21,DA,0)),DGLY=+DGIN0 D PAR^DGMTSCU
 I "^3^4^5^6^"[(U_$P($G(^DGPR(408.12,+$P(DGIN0,U,2),0)),U,2)_U),$P(DGIN0,U,14)-$P(DGMTPAR,U,17)'>0 D
 . I $P($G(^DGMT(408.21,DA,1)),U,3)]"" S DGVAL=$P(^(1),U,3),DGFLD=1.03 D KILL S $P(^DGMT(408.21,DA,1),U,3)=""
 Q
 ;
OTH ;"Trigger" Cross-reference on the Other Property or Assets
 ;field (#2.04) to delete debts on file
 N DGFLD,DGVAL
 I $P($G(^DGMT(408.21,DA,2)),U,5)]"" S DGVAL=$P(^(2),U,5),DGFLD=2.05 D KILL S $P(^DGMT(408.21,DA,2),U,5)=""
 Q
 ;
KILL ;Kill Cross-references
 N DGIX,X
 S X=DGVAL,DGIX=0
 F  S DGIX=$O(^DD(408.21,DGFLD,1,DGIX)) Q:'DGIX  X ^(DGIX,2) S X=DGVAL
 Q
 ;
FUN ;Input Transform check for Funeral and Burial Expenses field (#1.02)
 N DGIRI
 S DGIRI=+$O(^DGMT(408.22,"AIND",DA,0))
 I $D(^DGMT(408.22,DGIRI,0)),'$P(^(0),U,5),'$P(^(0),U,8) W !?5,"This field does not need to be filled in unless the patient was married",!?5,"or had dependent children last calendar year." K X
 Q
 ;
NET ;Input Transform check for Net Worth fields (#2.01-#2.05)
 N DGPRI
 S DGPRI=+$P($G(^DGMT(408.21,DA,0)),U,2)
 ;DG*5.3*688 -- DGMTVR is the Means Test version indicator
 I '$D(DGMTVR) D
 . N DGMT22I,DGMTVR1,DGMTVR2
 . S (DGMT22I,DGMTVR2)=0 F  Q:DGMTVR2  S DGMT22I=$O(^DGMT(408.22,"AIND",DA,DGMT22I)) Q:'DGMT22I  D
 . . S DGMTVR2=+$G(^DGMT(408.22,DGMT22I,"MT"))
 . I DGMTVR2 S DGMTVR=+$P($G(^DGMT(408.31,DGMTVR2,2)),U,11) Q
 . S DGMTVR1=+$G(^DGMT(408.21,DA,"MT"))
 . I DGMTVR1 S DGMTVR=+$P($G(^DGMT(408.31,DGMTVR1,2)),U,11) Q
 I +$G(DGMTVR)=0 DO
 . I "^3^4^5^6^"[(U_$P($G(^DGPR(408.12,DGPRI,0)),U,2)_U) W !?5,"This field does not need to be filled in for a child." K X
 Q
 ;
DEB ;Input Transform check for Net Worth Debts field (#2.05)
 D NET
 I $D(X),$P($G(^DGMT(408.21,DA,2)),U,4)<X W !?5,"'Debts' cannot exceed 'Other Property or Assets'." K X
 Q
 ;
NAM ;Output Transform for Patient Relation field (#.02)
 S Y=$$NAME^DGMTU1(Y)
 Q
 ;
EDHLP ;Executable Help for Educational Expenses field (#1.03)
 N DGPRI
 S DGPRI=+$P($G(^DGMT(408.21,DA,0)),U,2)
 I $P($G(^DGPR(408.12,DGPRI,0)),U,2)=1 D VET
 I "^3^4^5^6^"[(U_$P($G(^DGPR(408.12,DGPRI,0)),U,2)_U) D CHILD
 W !!?5,"Type a Dollar Amount between 0 and 99999, 2 Decimal Digits",!
 Q
 ;
VET ;Veteran's educational expenses
 W !?5,"Enter in this field amounts paid by the veteran during the previous",!?5,"calendar year for the veteran's educational expense.  Do not report"
 W !?5,"educational expenses of the veteran's children or spouse.  Educational",!?5,"expenses include tuition, fees, and books if the veteran is enrolled",!?5,"in a program of education."
 Q
 ;
CHILD ;Child's educational expenses
 W !?5,"Enter in this field the child's educational expenses if the child is",!?5,"enrolled in a program of education beyond the high school level."
 W !?5,"Educational expenses include amounts paid for tuition, fees and books."
 Q
