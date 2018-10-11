GMTSPSCK ;PBM/RMS - MED RECONCILIATION CONFIGURATION CHECKER ;Jun 07, 2018@21:40
 ;;2.7;Health Summary;**94**;Oct 20, 1995;Build 41
 ;
EN1 ; Main entry point
 N ASK,IDX,IDX1,IDX2,ORDER,REC,NAME,COMP,HAVET,HAVE1,HAVE2,HAVE3,FAILS
 S HAVE1=0,HAVE2=0,HAVE3=0,HAVET=0
 S FAILS=""
 W !,"Checking for TYPE 'Essential Med List for Review' ..."
 S IDX="" F  S IDX=$O(^GMT(142,IDX)) Q:IDX=""  D
 . S NAME=$P($G(^GMT(142,IDX,0)),U,1)
 . I NAME="Essential Med List for Review"  D
 .. S HAVET=1
 .. W " OK",!
 .. S IDX1=0 F  S IDX1=$O(^GMT(142,IDX,1,IDX1)) Q:IDX1=""  D
 ... S REC=$G(^GMT(142,IDX,1,IDX1,0))
 ... I REC'=""  D
 .... S ORDER=$P(REC,U,1)
 .... S IDX2=$P(REC,U,2)
 .... S COMP=$$GETCOMP(IDX2)
 .... I COMP'=""  D
 ..... I $P(COMP,U,1)="Allergies/ADRs (Tool #5)" S HAVE1=1
 ..... I $P(COMP,U,1)="Med. Reconciliation (Tool #1)" S HAVE2=1
 ..... I $P(COMP,U,1)="Med Recon NoGlossary (Tool #1)" S HAVE3=1
 .... E  D
 ..... W " FAIL (Component not found)",!
 . I HAVET Q
 I 'HAVET  D
 . W " FAIL (Missing)",!
 E  D
 . W "Checking for COMPONENT 'Allergies/ADRs (Tool #5)' configured in TYPE ..."
 . I HAVE1 W " OK",!
 . E  W !?5," FAIL (Missing)",!
 . W "Checking Tool #1 COMPONENTs to Verify One (and Only One) is Present ...",!
 . W "Checking for COMPONENT 'Med. Reconciliation (Tool #1)' configured in TYPE ...",!
 . W "Checking for COMPONENT 'Med Recon NoGlossary (Tool #1)' configured in TYPE ..."
 . I HAVE2,'HAVE3 W " OK",!
 . I 'HAVE2,HAVE3 W " OK",!
 . I HAVE2,HAVE3 W !?5," FAIL (Can't have both MRT1 & MRR1 Tool #1 COMPONENTs)"
 . I 'HAVE2,'HAVE3 W !?5," FAIL (Missing One)",!
 W !!,"Press <Return> to Continue..."  R ASK:300
 Q
 ;-------------------------------------------------------------
 ; GETCOMP - Retrieves a single Health Summary Component by IEN
 ; Parameters: IEN - IEN of HS component
 ; Returns: REC - parts 1,2,4 from HS component record
GETCOMP(IEN) ;
 N REC
 S REC=$G(^GMT(142.1,IEN,0))
 I REC'=""  D
 . S REC=$P(REC,U,1)_U_$P(REC,U,2)_U_$P(REC,U,4)
 Q REC
