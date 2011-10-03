ECTCLP ;B'ham ISC/PTD-List Construction Projects ;01/29/91 08:00
V ;;1.05;INTERIM MANAGEMENT SUPPORT;;
 I '$D(^ENG("PROJ")) W *7,!!?29,"OPTION IS UNAVAILABLE!",!,"The 'Construction Project' File - #6925 is not loaded on your system.",!! S XQUIT="" Q
 I '$O(^ENG("PROJ",0)) W *7,!!,"'Construction Project' File - #6925 has not been populated on your system.",!! S XQUIT="" Q
DIP S DIC="^ENG(""PROJ"",",BY="@",L=0,DHD="CONSTRUCTION PROJECT LIST",FLDS=".01,2;C20" D EN1^DIP
EXIT K BY,DHD,DIC,FLDS,L,P,X
 Q
 ;
