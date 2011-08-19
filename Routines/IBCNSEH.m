IBCNSEH ;ALB/AAS - EXTENDED HELP FOR INSURANCE MANAGEMENT ;28-MAY-93
 ;;2.0;INTEGRATED BILLING;**6,28,371**;21-MAR-94;Build 57
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
INS ; -- Help for Insurance Type
 Q:'$G(IBCNSEH)
 W !!,"The way we store and think about patient insurance information has been"
 W !,"dramatically changed.  We are separating out information that is specific"
 W !,"to an insurance company, specific to the patient, specific to the group plan,"
 W !,"specific to the annual benefits available, and the annual benefits already"
 W !,"used."
 W !!,"To start, you must select the insurance company for the patient's policy.",!
 Q
PAT ; -- Help for entering patient specific information
 Q:'$G(IBCNSEH)
 W !!,"Now you may enter the patient specific policy information.",!
 Q
POL ; -- Help for policy specific information
 Q:'$G(IBCNSEH)
 W !!,"You can now edit information specific to the PLAN.  Remember, updating"
 W !,"PLAN information will affect all patients with this plan, if it is a"
 W !,"group plan, and not just the current patient.",!
 Q
 ;
SEL ; -- help for selecting a new HIP
 Q:'$G(IBCNSEH)
 W !!,"Each Insurance policy entry for a patient must be associated with an"
 W !,"Insurance Plan offered by the Insurance company you just selected."
 W !,"You will be given a choice of selecting previously entered Group Plans or"
 W !,"you may enter a new one.  If you enter a new Insurance Plan you"
 W !,"must enter whether or not this is a group or individual plan.",!
 Q
AB ;
 Q:'$G(IBCNSEH)
 Q
BU ;
 Q:'$G(IBCNSEH)
 Q
