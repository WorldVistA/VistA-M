WVLETPR ;HCIOFO/FT,JR-WV PRINT LETTERS.  ;1/10/00  16:45
 ;;1.0;WOMEN'S HEALTH;**7,9**;Sep 30, 1998
 ;;  Original routine created by IHS/ANMC/MWR
 ;;* MICHAEL REMILLARD, DDS * ALASKA NATIVE MEDICAL CENTER *
 ;;  CALLED BY OPTION: "WV PRINT INDIVIDUAL LETTERS" TO PRINT A
 ;;  LETTER FOR A SINGLE INDIVIDUAL (AS OPPOSED TO ALL THOSE QUEUED).
 ;
 D SETVARS^WVUTL5 S (WVPOP1,WVPOP)=0
 N WVDA,WVTITLE
 F  S WVPOP=0 D  Q:WVPOP1
 .D SELECT Q:WVPOP
 .D DEVICE Q:WVPOP
 .S WVCRT=$S($E(IOST)="C":1,1:0)
 .D PRINT
 D ^%ZISC
 ;
EXIT ;EP
 D KILLALL^WVUTL8
 Q
 ;
SELECT ;EP
 ;---> SELECT PATIENT, THEN SELECT NOTIFICATION.
 N DIC,X,Y
 D TITLE^WVUTL5("PRINT INDIVIDUAL PATIENT LETTERS")
 D PATLKUP^WVUTL8(.Y)
 I Y<0 S (WVPOP,WVPOP1)=1 Q
 S WVDFN=+Y,X=$$NAME^WVUTL1(WVDFN)
 D DIC^WVFMAN(790.4,"EM",.Y,"","","",X,.WVPOP)
 I $D(DUOUT)!($D(DTOUT)) S WVPOP=1 Q
 I Y<0 D NONE S WVPOP=1 Q
 S WVDA=+Y
 ;
 ;---> IF FACILITIES OF LETTER AND USER DON'T MATCH, QUIT.
 N WVFACIL S WVFACIL=$P(^WV(790.4,WVDA,0),U,7)
 I ((WVFACIL'=DUZ(2))&(WVFACIL)) D TEXT1,DIRZ^WVUTL3 S WVPOP=1 Q
 ;
 S WVPURP=$P(^WV(790.4,WVDA,0),U,4)
 S WVTYPE=$P(^WV(790.4,WVDA,0),U,3)
 ;
 ;---> CHECK IF PURPOSE HAS BEEN ENTERED.
 I 'WVPURP D  Q
 .W !!?5,"No Purpose has been entered for this Notification."
 .D DIRZ^WVUTL3 S WVPOP=1 Q
 ;
 ;---> CHECK IF THIS PURPOSE OF NOTIFICATION HAS A LETTER.
 I '$D(^WV(790.404,WVPURP,1,0)) D  Q
 .W !!!?5,"No letter has been entered for this Purpose of Notification."
 .W !?5,"Programmer information: Notification=^WV(790.4,"_WVDA_",0)."
 .W !?5,"                         Purpose IEN=",WVPURP
 .W !?5,"                         Patient IEN=",WVDFN
 .D DIRZ^WVUTL3 S WVPOP=1 Q
 ;
 ;---> CHECK IF TYPE OF NOTIFICATION FOR THIS NOTIFICATION IS PRINTABLE.
 I 'WVTYPE D CANTPRT Q
 I '$P(^WV(790.403,WVTYPE,0),U,2) D CANTPRT Q
 Q
 ;
CANTPRT ;EP
 ;---> CAN'T PRINT THIS NOTIFICATION.
 W !!?5,"This Type of Notification"
 W:WVTYPE ", ",$P(^WV(790.403,WVTYPE,0),U),"," W " is not printable."
 D DIRZ^WVUTL3 S WVPOP=1
 Q
 ;
DEVICE ;EP
 ;---> GET DEVICE AND POSSIBLY QUEUE TO TASKMAN.
 K %ZIS,IOP
 S ZTRTN="PRINT^WVLETPR",ZTSAVE("WVDA")=""
 D ZIS^WVUTL2(.WVPOP,1)
 Q
 ;
PRINT ;EP
 ;---> REQUIRED VARIABLE: WVDA=IEN IN ^WV(790.4, ION=DEVICE
 ;---> NEXT LINE: IOP WILL INHIBIT ^DIWF FROM PROMPTING FOR DEVICE.
 D SETVARS^WVUTL5
 N WVDFN,WVPURP,IOP
 S IOP=ION
 ;---> IF FACILITIES OF LETTER AND USER DON'T MATCH, QUIT (IF NULL, OK).
 N WVFACIL S WVFACIL=$P(^WV(790.4,WVDA,0),U,7)
 I ((WVFACIL'=DUZ(2))&(WVFACIL)) D TEXT1 H 5 S WVPOP=1 Q
 ;
 S WVDFN=$P(^WV(790.4,WVDA,0),U)
 S WVPURP=$P(^WV(790.4,WVDA,0),U,4)
 ;---> WVN=DATE OF "PRINT DATE", USE TO KILL "APRT" XREF BELOW.
 S:'$D(WVKDT) WVKDT=$P(^WV(790.4,WVDA,0),U,11)
 ;---> IF NO PURPOSE (DELETED), KILL "APRT" XREF AND QUIT.
 I 'WVPURP D  Q
 .W !!?5,"No Purpose of Notification has been chosen; therefore, this"
 .W !?5,"notification cannot be printed."
 .D KILLXREF(WVDA,WVKDT)
 ;---> IF QUEUED AND WVCRT IS NOT SET, THEN SET IT.
 S:'$D(WVCRT) WVCRT=$S($E(IOST)="C":1,1:0)
 S DIWF="^WV(790.404,WVPURP,1,"
 S DIWF(1)=790
 S BY="INTERNAL(#.01)="_WVDFN
 ;---> IF LOCKED, PROMPT DEVICE, QUIT AND LEAVE IN THE QUEUE.
 L +^WV(790.4,WVDA):0 I '$T U IO D  D PROMPT Q
 .W !!?5,"The selected Notification is being edited by another user."
 .W !?5,"Programmer information: Notification=^WV(790.4,"_WVDA_",0)."
 .W:'WVCRT @IOF
 ;
 ;---> IF PATIENT IS DECEASED, DON'T PRINT LETTER; PRINT EXPLANATION,
 ;---> CHANGE THE STATUS OF THE NOTIFICATION TO "CLOSED", AND GIVE
 ;---> THE OUTCOME OF "PATIENT DECEASED".
 I $$DECEASED^WVUTL1(WVDFN) D DECEASED Q
 ;---> Compute future appointments
 D KAPPT^WVUTL9(WVDFN) ;kill off old computed appts.
 D GAPPT^WVUTL9(WVDFN) ;get future appts
 D SAPPT^WVUTL9(WVDFN) ;set appts in File 790
 D KILLUG^WVUTL9 ;kill off Utility global off future appts
 D KADD^WVUTL9(WVDFN) ;kill off old computed address
 D GADD^WVUTL9(WVDFN) ;get current complete address
 D SADD^WVUTL9(WVDFN) ;set complete address in File 790
 D KVAR^WVUTL9 ;clean-up VADPT variables used
 ;---> PRINT IT TO IOP, PRESERVE WVPOP.
 D EN2^DIWF
 D PROMPT
 ;---> DON'T STUFF "DATE PRINTED" IF IT ALREADY HAS A "DATE PRINTED".
 I $P(^WV(790.4,WVDA,0),U,10)]"" D KILLXREF(WVDA,WVKDT) L -^WV(790.4,WVDA) Q
 ;
 ;---> DON'T STUFF "DATE PRINTED" IF IT'S JUST TO THE SCREEN.
 I WVCRT D  Q
 .W !!?3,"NOTE: Because this letter was only displayed on a screen and"
 .W !?9,"not printed on a printer, it will NOT yet be logged by the"
 .W !?9,"program as having been ""PRINTED"".",!
 .L -^WV(790.4,WVDA) D DIRZ^WVUTL3
 ;
 ;---> NEXT LINES KILL "APRT" XREF AND SET "DATE PRINTED"=TODAY.
 ;---> ("APRT" XREF INDICATE A NOTIFICATION IS QUEUED TO BE PRINTED.)
 D KILLXREF(WVDA,WVKDT)
 D DIE^WVFMAN(790.4,".1////"_DT,WVDA)
 L -^WV(790.4,WVDA) Q
 Q
 ;
KILLXREF(WVDA,WVKDT) ;EP
 ;---> KILL "APRT" XREF (REMOVE LETTER FROM QUEUE).
 Q:'$G(WVDA)  Q:'$G(WVKDT)
 K ^WV(790.4,"APRT",WVKDT,WVDA)
 Q
 ;
DECEASED ;EP
 ;---> IF THE PATIENT IS DECEASED.
 ;---> DON'T STUFF "DATE PRINTED" IF IT'S JUST TO THE SCREEN.
 W !!?3,"NOTE: Because this patient, ",$$NAME^WVUTL1(WVDFN)," #"
 W $$SSN^WVUTL1(WVDFN),", is now"
 W !?9,"registered as deceased, the letter will NOT be printed."
 W !?9,"Instead, this notification will be given a status of CLOSED"
 W !?9,"and an outcome of ""Patient Deceased""."
 D:WVCRT&('$D(IO("S"))) DIRZ^WVUTL3
 W:'WVCRT @IOF
 S DR=".14////c;.05///Patient Deceased"
 D DIE^WVFMAN(790.4,DR,WVDA)
 ;---> KILL "APRT" XREF (FLAGS NOTIFICATION AS QUEUED TO BE PRINTED).
 D KILLXREF(WVDA,WVKDT)
 L -^WV(790.4,WVDA)
 Q
 ;
PROMPT ;EP
 ;---> PROMPT IF NECESSARY, PROMPT DEVICE.
 D:WVCRT DIRZ^WVUTL3
 Q
 ;
NONE ;EP
 S WVTITLE="* No letters selected for printing. *"
 D CENTERT^WVUTL5(.WVTITLE)
 W !!!!,WVTITLE,!!
 D DIRZ^WVUTL3
 Q
 ;
TEXT1 ;EP
 ;;
 ;;* NOTE: The Facility with which this letter is associated does not
 ;;        match the Facility under which you are currently logged on.
 ;;        To print this Notification, you must either edit the Facility
 ;;        for this Notification, or log off and log back in under the
 ;;        same Facility with which the Notification is associated.
 S WVTAB=5,WVLINL="TEXT1" D PRINTX
 Q
 ;
PRINTX ;EP
 N I,T,X S T=$$REPEAT^XLFSTR(" ",WVTAB)
 F I=1:1 S X=$T(@WVLINL+I) Q:X'[";;"  W !,T,$P(X,";;",2)
 Q
