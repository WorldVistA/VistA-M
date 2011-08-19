ENTIRA ;WOIFO/SAB - IT EQUIPMENT RESPONSIBILITY ASSIGN ;2/4/2008
 ;;7.0;ENGINEERING;**87**;Aug 17, 1993;Build 16
 ;
 N ENC,ENDA,ENIA,ENPER,ENSM,ENSMV,ENSRT,ENX,ENY
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 ;
GETEQ ; get equipment
 W !!,"Selecting accountable IT equipment to be assigned..."
 ;   ask method of selection
 S ENX=$$ASKEQSM^ENTIUTL2("ECULS","E")
 S ENSM=$P(ENX,U),ENSMV=$P(ENX,U,2)
 G:"^E^C^U^L^S^"'[(U_ENSM_U) EXIT
 ;
 ;   ask if already assigned equipment should be included
 I ENSM="E" S ENIA="1"
 E  S ENIA=$$ASKIAEQ^ENTIUTL2()
 G:ENIA="" EXIT
 ;
 ;   select equipment using method
 S ENSRT="E" ; set sort method = E
 D GETEQ^ENTIUTL2(ENSM,ENSMV,ENSRT,ENIA)
 ;
 ; display count of selected equipment
 S ENY=$G(^TMP($J,"ENITEQ",0))
 W !!,+ENY," equipment item(s) selected."
 ;
 I ENY'>0 D  G:Y GETEQ G EXIT
 . W !!
 . S DIR(0)="Y"
 . S DIR("A")="No equipment was selected. Do you want to try again"
 . S DIR("B")="YES"
 . D ^DIR K DIR
 ;
 ; ask if detailed report desired
 S DIR(0)="Y"
 S DIR("A")="Do you want to print a list of the equipment"
 S DIR("B")="YES"
 D ^DIR K DIR G:$D(DIRUT) EXIT
 I Y D AEN^ENTIRRE
 ;
GETPE ; get people that will be assigned the equipment
 W !!,"Selecting person(s) to be assigned responsibility..."
 D SELPER
 ;
 ; display count of selected persons
 S ENY=$G(^TMP($J,"ENITPE",0))
 W !!,+ENY," person(s) selected."
 I ENY'>0 D  G:Y GETPE G EXIT
 . W !!
 . S DIR(0)="Y"
 . S DIR("A")="No responsible person selected. Do you want to try again"
 . S DIR("B")="YES"
 . D ^DIR K DIR
 ;
 ; confirm
 S DIR(0)="Y"
 S DIR("A")="OK to create assignments"
 S DIR("B")="YES"
 D ^DIR K DIR G:'Y EXIT
 ;
 ; make assignments
 K ENC
 ;  loop thru equipment list
 S ENDA=0 F  S ENDA=$O(^TMP($J,"ENITEQ","NA",ENDA)) Q:'ENDA  D
 . ; loop thru person list
 . S ENPER=0 F  S ENPER=$O(^TMP($J,"ENITPE",ENPER)) Q:'ENPER  D
 . . ; create assignment
 . . S ENX=$$ASGN^ENTIUTL1(ENDA,ENPER)
 . . I ENX S ENC(1)=$G(ENC(1))+1
 . . I ENX=0 W !,"  Equipment # ",ENDA," is already assigned to ",$$GET1^DIQ(200,ENPER,.01) S ENC(0)=$G(ENC(0))+1
 . . I ENX="E" W !,"  ERROR. Equipment ",ENDA," was not assigned to ",$$GET1^DIQ(200,ENPER,.01) S ENC("E")=$G(ENC("E"))+1
 ;
 ; display totals
 W !!,+$G(ENC(1))," equipment assignment(s) created."
 W:$G(ENC(0)) !,ENC(0)," equipment assignment(s) already in place."
 W:$G(ENC("E")) !,ENC("E")," assignment(s) not created due to an error."
 ;
EXIT ;
 K ^TMP($J,"ENITEQ"),^TMP($J,"ENITPE")
 Q
 ;
SELPER ; Select Person(s)
 ; output
 ;   ^TMP($J,"ENITPE",0)=count
 ;   ^TMP($J,"ENITPE",ien)="" list of persons by internal entry number
 ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 N ENCNT,END,ENDA,ENNAME
 S ENCNT=0,END=0
 K ^TMP($J,"ENITPE")
 ;
 ; ask person in loop
 F  D  Q:END
 . S DIC="^VA(200,"
 . S DIC(0)="AQEM"
 . I ENCNT>0 S DIC("A")="Select Another NEW PERSON NAME: "
 . W !
 . D ^DIC K DIC  I Y<1 S END=1 Q
 . S ENDA=+Y
 . S ENNAME=$P(Y,U,2)
 . S DIR(0)="Y",DIR("A")="Assign responsibility to "_ENNAME
 . D ^DIR I $D(DIRUT) S END=1 Q
 . I 'Y Q
 . ; user confirmed
 . S ENCNT=ENCNT+1
 . S ^TMP($J,"ENITPE",ENDA)=""
 ;
 ; set output header node
 S ^TMP($J,"ENITPE",0)=ENCNT
 ;
 ;ENTIRA
