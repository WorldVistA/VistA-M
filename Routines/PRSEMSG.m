PRSEMSG ;HISC/JH-EDUCATION TRACKING MESSAGES ;4/14/91
 ;;4.0;PAID;**20,25**;Sep 21, 1995
MSG ;
 W !!,$C(7),"Another user is editing this record in ",PRSEGLO," File",!,"Try again later..."
 Q
MSG2 S I=0,Y=1 W !,?2,"Current assignees are: "
 F Y=0:0 S Y=$O(PRSEXMY(Y)) Q:Y'>0  W !,?6,$S('$D(^PRSPC(Y,0)):I,1:$P(^(0),U)) D W:Y-6<IOSL G QQ^PRSEED4:($D(DUOUT)!($D(DTOUT)))
 W !,?2,"Delete assignees from the list by putting a minus (-) in front"
 W !,?2,"of the name at the 'and Select:' prompt",!
 Q
W N %,DIR,I,J,Y S DIR(0)="E" D ^DIR W @IOF
 Q
MSG3 ;
 W !!,$C(7),"There is no COST CENTER/ORGANIZATION code or the SEPARATION IND is set to",!?2,"'Y'es in the PAID EMPLOYEE (#450) file for this employee - CANNOT CONTINUE: ",!
 Q
MSG4 ;
 W !!,$C(7),"CLASS NOT OPEN FOR REGISTRATION.",!
 Q
MSG5 ;
 W !,$C(7),"NEW ENTRIES CANNOT BE ADDED TO THE SUPPLIER/PRESENTER FILE FROM THIS OPTION",!,"CONTACT THE EDUCATION PACKAGE COORDINATOR OR IRM"
 Q
MSG6 ;
 W !!,$C(7),"THE EDUCATION TRACKING SYSTEM IS CURRENTLY OFF-LINE - CONTACT IRM OR THE"
 W !,$C(7),"EDUCATION TRACKING SYSTEM COORDINATOR: "
 Q
MSG7 ;
 W !!,$C(7),PRSENAM," is currently Registered for this ",PRSEPROG," Class!"
 Q
MSG12 S I=0,Y=1 W !,?2,"Current selections are: "
 F I=0:0 S I=$O(PRSEMI(I)) Q:I'>0  S Y=(Y+1) W !,?6,$S('$D(^PRSE(452.3,I,0)):I,1:$P(^(0),U)) D W:Y-6<IOSL G QQ^PRSEED4:($D(DUOUT)!($D(DTOUT)))
 W !,?2,"Delete selections from the list by putting a minus (-) in front"
 W !,?2,"of the name at the 'and Select:' prompt",!
 Q
MSG14 ;
 W !!,$C(7),"ANOTHER USER IS EDITING THIS CLASS - TRY LATER"
 Q
MSG15 ;
 W !!,$C(7),"NEW ENTRIES CANNOT BE ADDED TO THE NEW PERSON FILE FROM THIS OPTION - CONTACT",!,"THE EDUCATION PACKAGE COORDINATOR OR IRM.",!
 Q
MSG17 ;
 W !!,$C(7),"MAX NUMBER OF STUDENTS REGISTERED - CONTACT EDUCATION TRACKING COORDINATOR"
 Q
MSG18 ;
 W !!,$C(7),PRSENAM," has already attended a ",!?2,PRSECLS," Class on ",PRSEDAT,!!
 Q
MSG20 ;
 W !,$C(7),"NO "_$S($G(REGSW)=1:"FUTURE/PRESENT ",1:"PAST/PRESENT ")_"SESSIONS ENTERED FOR THIS CLASS/TYPE"
 Q
MSG21 ;
 W !,?2,"Enter the name(s) of the recipient(s) of this Group in the following format:"
 W !,?2,"   Lastname,first",!
 Q
MSG22 ;
 W !,?2,"In order to run the **Training Report By Service**"
 W !,?2,"you must have the PRSE CORD key or programmer access."
 Q
