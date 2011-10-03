ECTCPP ;B'ham ISC/PTD-Construction Project Profiles ;01/29/91 08:00
V ;;1.05;INTERIM MANAGEMENT SUPPORT;**14**;
 I '$D(^ENG("PROJ")) W *7,!!?29,"OPTION IS UNAVAILABLE!",!,"The 'Construction Project' File - #6925 is not loaded on your system.",!! S XQUIT="" Q
 I '$O(^ENG("PROJ",0)) W *7,!!,"'Construction Project' File - #6925 has not been populated on your system.",!! S XQUIT="" Q
DIP S DIC="^ENG(""PROJ"",",BY="@",L=0,DHD="@"
 S FLDS="""PROJECT #: "";S2,.01,""PROJECT TITLE: "";C1,2,""PROJECT CATEGORY: "";C1,158.1,""FUNDING YEAR - CONST: "";C35,3.5,""APPROVED CONSTRUCTION: "";C1,4,""STATUS: "";C1,6,""CONSTR. METHOD: "";C1,8"
 D EN1^DIP
EXIT K BY,DHD,DIC,FLDS,L,P,X
 Q
 ;
