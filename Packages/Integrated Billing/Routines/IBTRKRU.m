IBTRKRU ;WAS/RFJ - claims tracking file utilities ; 07 Feb 96
 ;;Version 2.0 ; INTEGRATED BILLING ;**56,62**; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
INACTIVE(DA)       ;  inactivate record in ct, delete admission field if
 ;  entry in file 405 is deleted
 N %,D,D0,DATA,DI,DIC,DIE,DIG,DIH,DIU,DIV,DQ,DR,X
 S DATA=$G(^IBT(356,DA,0)) I DATA="" Q
 ;  entry inactive (.2 field equal 0) and adm ptr removed (.05 deleted)
 S DR=".2////0;.05///@;.32///@"
 S DIE="^IBT(356,"
 D ^DIE
 Q
 ;
 ;
RELINK(DA,ADMPTR,EPISDATE)         ;  relink a deleted admission
 ;  admptr   = admission pointer to file 405
 ;  episdate = episode date
 N %,D,D0,DI,DIC,DIE,DIG,DIH,DIU,DIV,DQ,DR,X
 S DR=".05////"_ADMPTR_";.06////"_EPISDATE_";.2////1"
 S DIE="^IBT(356,"
 D ^DIE
 Q
 ;
 ;
DELETE(FILE,DA) ;  delete entry da from file
 N %,DIC,DIK,X,Y
 I '$D(^IBT(FILE,DA,0)) Q
 S DIK="^IBT("_FILE_","
 D ^DIK
 Q
 ;
 ;
COMMENT(FILE,DA)    ;  hospital (file 356.1) or insurance (file 356.2) review
 ;  add comments field 11 for entry da
 I $G(^IBT(FILE,DA,0))="" Q
 N %,D,D0,DI,DIC,DIE,DIG,DIH,DIU,DIV,DQ,DR,J,X
 S DR="11///Entry created by major change in specialty."
 S DIE="^IBT("_FILE_","
 D ^DIE
 Q
 ;
 ;
INQUIRE(FILE,DA) ;  return inquire data for file and entry da
 K IBDATA(FILE,DA_",")
 D GETS^DIQ(FILE,DA,"**","R","IBDATA")
 Q
