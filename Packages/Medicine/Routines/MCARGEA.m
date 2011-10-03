MCARGEA ;WISC/MLH-GI ENTER/EDIT-DISPLAY ALLERGY INFO ;7/12/00  11:53
 ;;2.3;Medicine;**28**;09/13/1996
 ;
 IF '$D(^DIC(120.8)) D  Q  ;display allergy info from patient file
 .  S DIC="^DPT(",DR="PA"
 .  D EN^DIQ
 .  K DIC,DR
 .  Q
 ;    display allergy info from new allergy pkg [RM-MLH]
 W !!,"Allergies/Adverse Reactions:"
 N DFN K GMRAL S DFN=$P($G(^MCAR(699,MCARGDA,0)),U,2) D ^GMRADPT
 I $G(GMRAL)=1 D
 .  N MCAR,MCAR0 F MCAR=0:0 S MCAR=$O(GMRAL(MCAR)) Q:MCAR'>0  W:$X>5 ! W ?5,$P(GMRAL(MCAR),U,2) F MCAR1=0:0 S MCAR1=$O(^GMR(120.8,MCAR,10,MCAR1)) Q:MCAR1'>0  W:$X>35 ! W ?35,$$RXN(MCAR,MCAR1)
 .  W !
 .  K GMRAL
 .  Q
 E  W ?35,$S($G(GMRAL)=0:"NKA",1:""),!
 QUIT
 ;
RXN(X,Y) ; FUNCTION WHOSE VALUE IS PRINTABLE RXN IN ENTRY ^GMR(120.8,X,10,Y,0) [RM-MLH]
 N MCAR,MCAR1 S MCAR=$G(^GMR(120.8,X,10,Y,0)),MCAR1=$P(MCAR,U)
 Q $S('MCAR1:"",MCAR1'=$O(^GMRD(120.83,"B","OTHER REACTION",0)):$P($G(^GMRD(120.83,MCAR1,0)),U),1:$P(MCAR,U,2))
