GMRANKA ;HIRMFO/WAA - ALLERGY/ADVERSE REACTION PATIENT NKA DRIVE ;04/07/2016  13:21
 ;;4.0;Adverse Reaction Tracking;**2,21,36,48**;Mar 29, 1996;Build 13
NKA(DFN) ;See if patient has reaction on file
 ;  Input Variables:
 ;       DFN = Patient Internal Entry Number
 ;
 ;  Output Variables:
 ;       GMA = 1 Patient has known reaction
 ;             0 Patient has No known reaction
 ;             Null Patient has never been asked about reaction
 N GMRAIEN
 S GMA="",GMRAIEN=+$O(^GMR(120.86,"B",DFN,0))
 S:GMRAIEN>0 GMA=$P($G(^GMR(120.86,GMRAIEN,0)),U,2)
 Q GMA
 ;
NKAASK(DFN,GMRAOUT) ; Ask a Patient if patient has any known allergens
 ;  Input Variables
 ;     DFN = Patient Internal entry number
 ;  GMRAOUT = Up Caret or time out flag
 ;
 ;Ask if patient has allergies
 N DIR,Y,DIROUT,DTOUT,DIRUT,DUOUT,GMAOLD,GMRAIEN
 S GMRAIEN=+$O(^GMR(120.86,"B",DFN,0))
 S GMAOLD=$S(GMRAIEN>0:$P($G(^GMR(120.86,GMRAIEN,0)),U,2),1:"")
 S DIR(0)="120.86,1^AO^I Y=0&'$$NKASCR^GMRANKA(DFN) D INFO^GMRANKA K X"
 S DIR("A")="Does this patient have any known allergies or adverse reactions? "
 S DIR("B")=$S(GMAOLD=1:"Yes",GMAOLD=0:"No",1:"") K:DIR("B")="" DIR("B")
 S DIR("?")=$S(GMAOLD=0:"You may also enter @ to delete a previous NKA assessment and return the patient to a 'not assessed' state.  Use this if the NKA assessment was previously incorrectly entered.",1:"") ;21
 D ^DIR
 I $G(X)="@" D:GMAOLD=0 CLN W:GMAOLD=0 !,"Assessment deleted." Q  ;21 Allow removal of NKA
 I $D(DTOUT)!$D(DIROUT) S GMRAOUT=1 Q  ;36
 I $D(DUOUT) S GMRAOUT=2 Q  ;36
 ; User Hits return and doesn't answer question
 I Y="",GMAOLD="" Q  ;36
 I Y'="",GMAOLD'=Y D
 . N DIE,DA,DR,DO,DIC,X,DINUM
 . I 'GMRAIEN D
 . . S DIC="^GMR(120.86,",DIC(0)="",X=DFN,DIC("DR")="1////"_Y_";2////"_DUZ_";3///NOW"
 . . I '$D(^GMR(120.86,DFN)) S DA=DFN,DINUM=DFN
 . . D FILE^DICN
 . I GMRAIEN>0 D
 . . S DIE="^GMR(120.86,",DA=GMRAIEN,DR=$S(GMAOLD="":(".01////"_DFN_";"),1:"")_"1////"_Y_";2////"_DUZ_";3///NOW" ;36
 . . D ^DIE
 . Q
 Q
CLN ; Clean out entries that have not been answered.
 S DIK="^GMR(120.86,",DA=$S($G(GMRAIEN)>0:GMRAIEN,1:DFN) D ^DIK K DIK,DA
 Q
INFO ; Info string
 N GMASTR
 S GMASTR(1)="Currently this patient has Causative Agents on file."
 S GMASTR(2)="You will have to answer YES to this question and then"
 S GMASTR(3)="indicate that each of the Causative Agents are incorrect."
 S GMASTR(4)="Then you will be reasked this question and will be able"
 S GMASTR(5)="to enter NO."
 D WRITE^GMRADSP8(1,0,$C(7))
 D WRITE^GMRADSP8(1,10,.GMASTR)
 Q
NKASCR(DFN) ; Is Patient NKA (No Known Allergy)
 ;   Input Variable:
 ;        DFN = Patient DFN in Patient file
 ;
 ;  Output Variable:
 ;        GMA = 1 Patient is True NKA
 ;            = 0 Patient has a reaction in file 120.8
 ;
 ; This code will screen out Entered in Error entries
 S GMA=1
 N GMAX
 S GMAX=0
 F  S GMAX=$O(^GMR(120.8,"B",DFN,GMAX)) Q:GMAX<1  D  Q:'GMA
 .I +$G(^GMR(120.8,GMAX,"ER")) Q
 .S GMA=0
 .Q
 Q GMA
 ;
DELNKA ;Remove assessment of NKA for a selected patient
 N Y,DFN,DIR,DIC
 S DIC=120.86,DIC(0)="AEMQZ",DIC("A")="Select PATIENT NAME: " D ^DIC Q:Y=-1
 S DFN=+Y
 W !
 I $$NKA^GMRANKA(DFN)'=0 W !,"This patient doesn't currently have an assessment of NKA." Q
 S DIR(0)="Y",DIR("A")="Delete NKA assessment for patient "_$G(Y(0,0)),DIR("B")="NO"
 S DIR("?")="Enter Y to delete the NKA assessment and return the patient to a 'not assessed' status.  Enter N to cancel this action."
 D ^DIR
 I Y=1 D CLN^GMRANKA W "...Done"
 Q
