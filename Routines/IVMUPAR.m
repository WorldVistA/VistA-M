IVMUPAR ;ALB/CPM - IVM PARAMETER ENTER/EDIT ; 14-JUN-94
 ;;2.0;INCOME VERIFICATION MATCH;**111**; 21-OCT-94
 ;;Version 2.0 ; INCOME VERIFICATION MATCH ;**111**; 21-OCT-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
EN ; Entry point for IVM Parameter Enter/Edit
 ;
 W !!,"IVM Parameter Enter/Edit",!
 ;
 I '$D(^IVM(301.9,1,0)) D
 .W !,"You do not have an entry in your parameter file!!"
 .W !,"Creating a new entry in the IVM SITE PARAMETER (#301.9) file... ",!
 .S DIC="^IVM(301.9,",DIC(0)="",X=$P($$SITE^VASITE,"^",3),DINUM=1
 .K DD,DO D FILE^DICN W " done."
 .K %,DA,DIC,DIE,X,Y
 ;
 ;
 S DIE="^IVM(301.9,",DA=1,DR=".03//0;.05//0" D ^DIE
 K DIE,DR,DA
 Q
