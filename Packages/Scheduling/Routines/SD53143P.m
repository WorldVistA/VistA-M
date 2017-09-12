SD53143P ;ALB/JLU;Post init for SD*5.3*143;2/10/98
 ;;5.3;Scheduling;**143**;AUG 13,1993
 ;
EN ;main entry point.
 ;This is to reindex the 'C' x ref that sites have killed off because of
 ;the A020 problems.
 ;
 W !!,"Re-indexing the 'C' cross reference in the Clinic Stop file."
 N DIK
 S DIK="^DIC(40.7,"
 S DIK(1)="1^C"
 D ENALL^DIK
 W !,"Completed."
 Q
