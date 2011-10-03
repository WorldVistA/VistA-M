ONCOSO ;Hines OIFO/GWB - CALL TO ^DIS FOR FILEMANAGER SEARCH OPTION ;9/3/93
 ;;2.11;ONCOLOGY;**39**;Mar 07, 1995
 ;
HD ;Header
 W @IOF,!!?10,"This option allows you to create 'SEARCH TEMPLATES'",!?10,"which are used in Cross-Tabs and Survival Analysis"
 W !!?15,"REMEMBER to name templates beginning with"
 W !?24,"ONCOZ for USER defined templates"
 W !?17,"verses Package distributed (ONCOS).",!!
 W ?17,"To 'RUN' Existing Templates enter '[ONCOS' to begin,",!
 W ?17,"to bring up pre-defined tempates for use with Cross-tabs.",!!
 Q
 ;
SEL ;SELECT FILE
 K DIR
 S DIR(0)="SO^1:ONCOLOGY PRIMARY;2:ONCOLOGY PATIENT;3:ONCOLOGY CONTACT"
 S DIR("A")=" Select File"
 D ^DIR Q:$D(DIRUT)
 S GL="^ONCO(16",DIC=$S(Y=1:GL_"5.5,",Y=2:GL_"0,",1:GL_"5,")
 S ONCOF=$P($P(DIR(0),";",Y),":",2)
 Q
 ;
SER ;REQUEST FILE TO SEARCH, THEN SEARCH CRITERIA
 D HD,SEL G EX:$D(DIRUT) W !!!,"We will search entries in "_ONCOF_" file...",!!! D EN^DIS G EX
 ;
IN ;CALL TO CROSS-TAB ROUTINES
 K ONCOS("AF") G ST^ONCOSCT0
 W !!!?10,"This Option will allow you to define the necessary",!?10,"variables for Cross-Tabulations - refer to the User's",!?10,"manual for HELP in answering questions",!!
 K DIR S DIR("A")="     Continue",DIR(0)="Y",DIR("B")="Y" D ^DIR G EX:Y'=1 D ^ONCOSCT0 G EX
 ;
EX ;Exit and kill
 K DIC,DIR,GL,ONCOF,ONCOEX,ONCON,ONCOX,ONCOX1,ROWDEF,%T,%,%K,%DT,%ZISOS,G,L,O,W Q
