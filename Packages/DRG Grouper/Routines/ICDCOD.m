ICDCOD ;ALB/ABR/ADL - INQUIRE TO ICD CODES ; 10/23/00 11:36am
 ;;18.0;DRG Grouper;**7**;Oct 20, 2000
 ;;ADL;Update for CSV project - 03/20/03
 ;
 ;This routine allows entry of an ICD9 or ICD0 code, and returns the description.
 ;It also alerts the user if it is an inactive code.
 ;
EN ;
 N DIRUT,DTOUT,DUOUT,DIR,DIC,DA,DR,DIQ,X,Y,ICDTMP
DATE D EFFDATE^ICDDRGM G EXIT:$D(DUOUT),EXIT:$D(DTOUT)
 F  S DIR(0)="SO^1:ICD DIAGNOSIS CODE;2:ICD OPERATION/PROCEDURE CODE" D ^DIR Q:Y<0!$D(DIRUT)  D @Y  Q:$D(DTOUT)
 G DATE
 ;
1 ;ICD DIAGNOSIS CODE
 S DIR(0)="PO^80:QAEM"
 F  W !! D ^DIR Q:Y<0!$D(DIRUT)  D
 .N ICDASK
 . S DR=".01;3;10;100;102"
 . S DIC="^ICD9(",DA=+Y,DIQ(0)="EN",DIQ="ICDASK"
 . D EN^DIQ1
 . S ICDTMP=$$ICDDX^ICDCODE(+DA,ICDDATE)
 . W !!,ICDASK(80,DA,.01,"E"),?15,ICDASK(80,DA,3,"E"),!,$G(ICDASK(80,DA,10,"E")),"     ",$P(ICDTMP,U,18),!  ;add printing of descript disclaimer msg
 . I '$P(ICDTMP,U,10) W "   **CODE INACTIVE" I $P(ICDTMP,U,12)'="" S Y=$P(ICDTMP,U,12) D DD^%DT W " AS OF   ",Y," **",!
 Q
 ;
2 ;ICD OPERATION/PROCEDURE
 S DIR(0)="PO^80.1:QAEM"
 F  W !! D ^DIR Q:Y<0!$D(DIRUT)  D
 . N ICDASK
 . S DIC="^ICD0(",DA=+Y,DR=".01;4;10;100;102",DIQ(0)="EN",DIQ="ICDASK"
 . D EN^DIQ1
 . S ICDTMP=$$ICDOP^ICDCODE(+DA,ICDDATE)
 . W !!,ICDASK(80.1,DA,.01,"E"),?15,ICDASK(80.1,DA,4,"E"),!,$G(ICDASK(80.1,DA,10,"E")),"     ",$P(ICDTMP,U,14),!  ;add printing of descript disclaimer msg
 . I '$P(ICDTMP,U,10) W "   **CODE INACTIVE" I $P(ICDTMP,U,12)'="" S Y=$P(ICDTMP,U,12) D DD^%DT W " AS OF   ",Y," **",!
 Q
EXIT Q  ;Exit subroutine
