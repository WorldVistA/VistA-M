DGMTDD2 ;ALB/RMO,LBD - Income Relation file (#408.22) Data Dictionary Calls ;13 MAR 1992 3:00 pm
 ;;5.3;Registration;**33,45,518,688**;Aug 13, 1993;Build 29
 ;
ID ;Identifier for Income Relation file
 N DGIN0,DGPRI,Y
 S DGIN0=$G(^DGMT(408.21,+$P($G(^(0)),U,2),0))
 S DGPRI=+$P(DGIN0,U,2),Y=+DGIN0 X ^DD("DD")
 W "  ",Y W:$P($G(^DGPR(408.12,DGPRI,0)),U,2)'=1 "    Relation: ",$$NAME^DGMTU1(DGPRI),"  (",$$REL^DGMTU1(DGPRI),")" W !
 Q
 ;
FUN ;"Trigger" Cross-reference on the Married field (#.05) and
 ;Dependent Children field (#.08) to delete funeral and burial
 ;expenses
 ;  If the test is a LTC Copay test do not delete the funeral and
 ;  burial expenses.  Added for LTC Phase III (DG*5.3*518)
 N DGFLD,DGIN0,DGINI,DGVAL,DGMT,DGMTIR ;DG5.3*688 added DGMTIR
 S DGINI=+$P($G(^DGMT(408.22,DA,0)),U,2),DGIN1=$G(^DGMT(408.21,DGINI,1))
 S DGMTIR=$P($G(^DGMT(408.22,DA,"MT")),U) ;DG5.3*688 defines DGMTIR
 S DGMT=+$G(^DGMT(408.21,DGINI,"MT"))
 I DGMT,$P($G(^DGMT(408.31,DGMT,0)),U,19)=3 Q
 I DGMT,$P($G(^DGMT(408.31,DGMT,2)),U,11)=1 Q  ;* GTS DG*688 - MT V1 does not require Spouse or Children for F&B
 I DGMTIR,$P($G(^DGMT(408.31,DGMTIR,2)),U,11)=1 Q  ;* DG*688 - Check for Version 1 using 408.22 MT Ptr
 S DGFLD=1.02,DGVAL=$P(DGIN1,U,2)
 I DGVAL]"" D KILL S $P(^DGMT(408.21,DGINI,1),U,2)=""
 Q
 ;
SP ;"Trigger" Cross-reference on the Amount Contributed to Spouse field
 ;(#.07) to delete net worth on file for a spouse
 N DFN,DGIN2,DGINI,DGLY,DGREL,DGVAL
 S DGIR0=$G(^DGMT(408.22,DA,0))
 S DFN=+DGIR0,DGLY=+$G(^DGMT(408.21,+$P(DGIR0,U,2),0)) D
 .N DA,X
 .D GETREL^DGMTU11(DFN,"S",DGLY,$S($G(DGMTI):DGMTI,1:""))
 S DGINI=+$$IAI^DGMTU3(+$G(DGREL("S")),DGLY)
 S DGIN2=$G(^DGMT(408.21,DGINI,2))
 F DGFLD=2.01:.01:2.05 S DGVAL=$P(DGIN2,U,(DGFLD-2)/.01) I DGVAL]"" D
 .D KILL
 .S $P(^DGMT(408.21,DGINI,2),U,(DGFLD-2)/.01)=""
 Q
 ;
INC ;"Trigger" Cross-reference on the Child Had Income field (#.11) and
 ;Income Available To You field (#.12) to delete educational expenses
 ;on file for a child
 N DGINI
 S DGINI=+$P($G(^DGMT(408.22,DA,0)),U,2)
 I $P($G(^DGMT(408.21,DGINI,0)),U,14)]"" D
 .N DGFLD,DGVAL
 .I $P($G(^DGMT(408.21,DGINI,1)),U,3)]"" S DGVAL=$P(^(1),U,3),DGFLD=1.03 D KILL S $P(^DGMT(408.21,DGINI,1),U,3)=""
 Q
KILL ;Kill Cross-Reference
 N DA,DGIX,X
 S DA=DGINI,X=DGVAL,DGIX=0
 F  S DGIX=$O(^DD(408.21,DGFLD,1,DGIX)) Q:'DGIX  X ^(DGIX,2) S X=DGVAL
 Q
 ;
MAR ;Input Transform check for the Married field (#.05)
 ;for an active spouse
 N DFN,DGIR0,DGLY,DGREL
 S DGIR0=$G(^DGMT(408.22,DA,0))
 S DFN=+DGIR0,DGLY=+$G(^DGMT(408.21,+$P(DGIR0,U,2),0)) D
 .N DA,X
 .D GETREL^DGMTU11(DFN,"S",DGLY,$S($G(DGMTI):DGMTI,1:""))
 I $D(DGREL("S")) W !?5,"An active spouse exists.  Married cannot be 'NO'.",!?5,"You have to use the 'Expand Dependent' action and inactive first." K X
 Q
 ;
DEP ;Input Transform check for the Dependent Children field (#.08)
 ;for active children
 N DFN,DGDEP,DGIR0,DGLY,DGREL
 S DGIR0=$G(^DGMT(408.22,DA,0))
 S DFN=+DGIR0,DGLY=+$G(^DGMT(408.21,+$P(DGIR0,U,2),0)) D
 .N DA,X
 .D GETREL^DGMTU11(DFN,"C",DGLY,$S($G(DGMTI):DGMTI,1:""))
 I $D(DGREL("C")) W !?5,"Active children exist.  Dependent Children cannot be 'NO'." K X
 Q
 ;
LIV ;Input Transform check for Lived With Patient field (#.06)
 N DGIR0,DGPRI
 S DGIR0=$G(^DGMT(408.22,DA,0)),DGPRI=+$P($G(^DGMT(408.21,+$P(DGIR0,U,2),0)),U,2)
 I $P($G(^DGPR(408.12,DGPRI,0)),U,2)=1,'$P(DGIR0,U,5) W !?5,"This field does not need to be filled in unless the patient is married." K X
 Q
 ;
AMT ;Input Transform check for Amount Contributed To Spouse field (#.07)
 N DGIR0,DGPRI
 S DGIR0=$G(^DGMT(408.22,DA,0)),DGPRI=+$P($G(^DGMT(408.21,+$P(DGIR0,U,2),0)),U,2)
 I $P($G(^DGPR(408.12,DGPRI,0)),U,2)=1,('$P(DGIR0,U,5)!($P(DGIR0,U,6)'=0)) W !?5,"This field does not need to be filled in unless the patient was married",!?5,"and did not live with his or her spouse." K X
 Q
 ;
CON ;Input Transform check for Contributed To Support field (#.1)
 N DGIR0,DGPRI
 S DGIR0=$G(^DGMT(408.22,DA,0)),DGPRI=+$P($G(^DGMT(408.21,+$P(DGIR0,U,2),0)),U,2)
 I "^3^4^5^6^"[(U_$P($G(^DGPR(408.12,DGPRI,0)),U,2)_U),$P(DGIR0,U,6)'=0 W !?5,"This field does not need to be filled in unless the child did not",!?5,"live with the patient." K X
 Q
 ;
AVL ;Input Transform check for Income Available To You field (#.12)
 I '$P($G(^DGMT(408.22,DA,0)),U,11) W !?5,"This field does not need to be filled in unless the child has income." K X
 Q
 ;
NAM ;Output Transform for Individual Annual Income field (#.02)
 N DGIN0,DGPRI
 S DGIN0=$G(^DGMT(408.21,Y,0)),DGPRI=+$P(DGIN0,U,2),Y=+DGIN0 X ^DD("DD")
 S Y=Y_"  "_$$NAME^DGMTU1(DGPRI)
 Q
 ;
LIVHLP ;Help for Lived With Patient field (#.06)
 N DGIR0,DGPRI
 S DGIR0=$G(^DGMT(408.22,DA,0)),DGPRI=+$P($G(^DGMT(408.21,+$P(DGIR0,U,2),0)),U,2)
 I $P($G(^DGPR(408.12,DGPRI,0)),U,2)=1 W !?5,"Enter in this field whether the veteran resided with his or her spouse",!?5,"last calendar year.  If they were living apart because one was",!?5,"hospitalized or in a nursing home, enter 'YES'."
 I "^3^4^5^6^"[(U_$P($G(^DGPR(408.12,DGPRI,0)),U,2)_U) W !?5,"Enter in this field whether the child resided with the veteran last",!?5,"calendar year."
 W !
 Q
