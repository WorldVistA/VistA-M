ECXLARP ;BIR/CML/PTD/JRC-Print DSS Lab Tests Names Datasheet (LAR) ; 6/9/05 7:49pm
 ;;3.0;DSS EXTRACTS;**8,51,84**;Dec 22, 1997
EN ;entry point from option
 ;Init variables and sort array
 N QFLG,SORT
 ;
 S QFLG=1
 W !!,"This option prints a list of the DSS Lab Tests and associated LMIP workload",!,"codes used for the Lab Results Extract (LAR).  It will display the local lab"
 W !,"data names associated with each DSS Lab test name.  If there are LMIP workload",!,"codes they will be linked to the appropriate DSS lab test name or local lab",!,"test name."
 ;
 ;If no data in file (#727.2) quit
 I '$O(^ECX(727.2,0)) W !!,"The DSS LAB TEST file (#727.2) does not exist on your system!" Q
 ;
 ;Get sort
 D GETSORT Q:'QFLG
 ;
 W !!,"** REPORT REQUIRES 132 COLUMNS TO PRINT CORRECTLY **",!!
 ;
 ;Print report using fileman sort and print templates
 N L,DIC,FLDS,DHD,BY,FR,TO,DIOBEG
 S L=0,DIC="^ECX(727.2,"
 S FLDS="[ECX LAB TEST PRINT]",BY=$S(SORT=1:"[ECX LAB TEST SORT BY DSS NAME]",SORT=2:"[ECX LAB TEST SORT BY LOCAL]",SORT=3:"[ECX LAB TEST SORT BY NUMBER]"),FR="",TO="",DHD="[ECX LAB TEST HEADER]",DIOBEG="I $E(IOST,1,2)=""C-"" W @IOF"
 D EN1^DIP
 Q
 ;
GETSORT ;Prompt for sorting order for report
 N DIR,X,Y,DIRUT
 S DIR(0)="SC^1:DSS LAB TEST NAME;2:LOCAL LAB TEST NAME;3:RESULT TEST ID NUMBER"
 S DIR("A")="Select sort for DSS LAB TEST DATASHEET report"
 D ^DIR
 I $D(DIRUT) S QFLG="" Q
 S SORT=Y
 Q
 ;
