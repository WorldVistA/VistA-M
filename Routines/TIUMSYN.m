TIUMSYN ; SLC/JER - TIU Mapping Synonyms ;7/6/06  16:13
 ;;1.0;TEXT INTEGRATION UTILITIES;**211**;Jun 20, 1997;Build 26
MAIN(TIUFN) ; Controls looping and subroutine calls
 N TIUY W !
 F  D FINDEDIT(TIUFN) Q:TIUY'>0
 Q
FINDEDIT(TIUFN) ; Calls ^DIC to look-up entry, ^DIE to edit
 N DA,DIC,X,Y,DIE,DR,DLAYGO,FILENM
 S FILENM=$S(TIUFN=8926.72:"SMD",TIUFN=8926.73:"ROLE",TIUFN=8926.74:"SETTING",TIUFN=8926.75:"SERVICE",TIUFN=8926.76:"DOCUMENT TYPE",1:"")
 S (DIC,DLAYGO)=TIUFN
 S DIC("A")="Please Enter "_FILENM_" Synonym: ",DIC(0)="AEMQL"
 D ^DIC W !
 S (DA,TIUY)=+Y
 Q:+Y'>0
 S DIE=DIC,DR=".01;.02"
 D ^DIE W !
 ; If .02 field is empty, DELETE record
 I $S(+$G(DA)'>0:1,+$P($G(@("^TIU("_TIUFN_",DA,0)")),U,2)>0:1,1:0) Q
 W !,"You MUST associate your synonym with a ",$S(FILENM="SMD":"Subject Matter Domain",1:FILENM),".",!!,"Deleting synonym record.."
 S DR=".01///@" D ^DIE W ".",!
 Q
