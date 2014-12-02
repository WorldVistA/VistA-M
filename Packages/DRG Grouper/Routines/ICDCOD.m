ICDCOD ;ALB/ABR/ADL/KUM - INQUIRE TO ICD CODES ;10/23/00 11:36am
 ;;18.0;DRG Grouper;**7,57,64**;Oct 20, 2000;Build 103
 ;;ADL;Update for CSV project - 03/20/03
 ;;KUM;Added new items to search ICD-10 diagnosis and ICD-10 procedure code
 ;
 ;This routine allows entry of an ICD9 or ICD10 code, and returns the description.
 ;It also alerts the user if it is an inactive code.
 ;
 ; $$ICDDX^ICDEX covered by ICR#5747
 ; $$ICDOP^ICDEX covered by ICR#5747
 ;
EN ;
 N DIRUT,DTOUT,DUOUT,DIR,DIC,DR,DIQ,X,Y,ICDTMP,ICDSYS
DATE D EFFDATE^ICDDRGM G EXIT:$D(DUOUT),EXIT:$D(DTOUT)
 F  S DIR(0)="SO^1:ICD 9 DIAGNOSIS CODE;2:ICD 9 OPERATION/PROCEDURE CODE;3:ICD 10 DIAGNOSIS CODE;4:ICD 10 OPERATION/PROCEDURE CODE" D ^DIR Q:Y<0!$D(DIRUT)  D @Y  Q:$D(DTOUT)
 G DATE
 ;
1 ;ICD-9 DIAGNOSIS CODE
 S ICDSYS="ICD9"
 S IENT="I"
 F  W !! S DIC("A")="Select ICD-9 Diagnosis: ",Y=$$SEARCH^ICDSAPI(80,"I $P($$ICDDX^ICDEX(+$G(Y),$G(ICDDATE),1,IENT),U,1)>0","AEMQZI",$G(ICDDATE)) Q:Y<=0  D
 . S ICDTMP=$$ICDDX^ICDEX(+$G(Y),$G(ICDDATE),1,IENT)
 . W !!,$P(ICDTMP,U,2),?15,$P(ICDTMP,U,4),!,$P(ICDTMP,U,11),"     ",$P(ICDTMP,U,18),!  ;add printing of descript disclaimer msg
 . I '$P(ICDTMP,U,10) W "   **CODE INACTIVE" I $P(ICDTMP,U,12)'="" S Y=$P(ICDTMP,U,12) D DD^%DT W " AS OF   ",Y," **",!
 Q
 ;
2 ;ICD-9 OPERATION/PROCEDURE
 S IENT="I"
 F  W !! S DIC("A")="Select ICD-9 Procedure: ",Y=$$SEARCH^ICDSAPI(80.1,"I $P($$ICDOP^ICDEX(+$G(Y),$G(ICDDATE),2,IENT),U,1)>0","AEMQZI",$G(ICDDATE)) Q:Y<=0  D
 . S ICDTMP=$$ICDOP^ICDEX(+$G(Y),$G(ICDDATE),2,IENT)
 . W !!,$P(ICDTMP,U,2),?15,$P(ICDTMP,U,5),!,$P(ICDTMP,U,11),"     ",$P(ICDTMP,U,14),!  ;add printing of descript disclaimer msg
 . I '$P(ICDTMP,U,10) W "   **CODE INACTIVE" I $P(ICDTMP,U,12)'="" S Y=$P(ICDTMP,U,12) D DD^%DT W " AS OF   ",Y," **",!
 Q
3 ;ICD-10 DIAGNOSIS CODE
 D ^ICDDSLK
 Q
 ;
4 ;ICD-10 OPERATION/PROCEDURE
 D ^ICDCODLK
 Q
EXIT Q  ;Exit subroutine
