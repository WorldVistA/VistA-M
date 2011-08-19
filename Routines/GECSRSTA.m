GECSRSTA ;WISC/RFJ-stack reports                                    ;22 Dec 93
 ;;2.0;GCS;;MAR 14, 1995
 N %DT,%I,DIR,DIRUT,GECSCODE,GECSDATE,GECSDESC,GECSEND,GECSFALL,GECSFLAG,GECSSSET,GECSSTAT,GECSSTRT,X,Y
 ;  ask starting and ending transaction code
 F  D  Q:$G(GECSFLAG)
 .   W !,"START with TRANSACTION CODE: FIRST// " R X:DTIME I '$T!(X["^") S GECSFLAG=1 Q
 .   I X["?" W !?2,"Select the starting TRANSACTION CODE.  The TRANSACTION CODE is the two",!?2,"character code which identifies the document type." Q
 .   S GECSSTRT=X,GECSFLAG=1
 I '$D(GECSSTRT) Q
 K GECSFLAG
 F  D  Q:$G(GECSFLAG)
 .   W !,"  END with TRANSACTION CODE: LAST// " R X:DTIME I '$T!(X["^") S GECSFLAG=1 Q
 .   I X["?" W !?2,"Select the ending TRANSACTION CODE." Q
 .   I X="" S X="z"
 .   I GECSSTRT]X W !?4,"Ending TRANSACTION CODE must follow starting TRANSACTION CODE." Q
 .   S GECSEND=X,GECSFLAG=1
 I '$D(GECSEND) Q
 ;
 ;  ask starting created date
 S %DT="AEP",%DT("A")="Print documents created after DATE: ",%DT("B")="JAN 1,1993",%DT(0)=-DT W ! D ^%DT Q:Y<1  S GECSDATE=Y
 ;
 ;  ask for status to print
 S GECSSSET=$P(^DD(2100.1,3,0),"^",3)_"N:TRANSMITTED WITH NO CONFIRMATION MESSAGE RETURNED"
 S DIR(0)="SO^"_GECSSSET,DIR("A")="Select STATUS(ES) to display"
 K GECSSTAT
 F  W ! D ^DIR Q:Y=""  D
 .   I $D(GECSSTAT(Y)) W !?5,"-- previously selected --" Q
 .   S GECSSTAT(Y)=""
 I '$D(GECSSTAT) W !,"A STATUS was not selected !" D  Q:'$G(GECSFALL)
 .   S XP="  Do you want to print ALL stack documents",XH="  Enter YES to print all documents, NO or '^' to exit."
 .   I $$YN^GECSUTIL(1)=1 S GECSFALL=1
 W !!,"SELECTED STATUS(ES) to display:"
 I $G(GECSFALL) W "  ALL STATUS(ES)"
 I '$G(GECSFALL) S Y="" F  S Y=$O(GECSSTAT(Y)) Q:Y=""  W !?10,$P($P(GECSSSET,Y_":",2),";")
 ;
 W !!
 S XP="Print DESCRIPTION of event" S GECSDESC=$$YN^GECSUTIL(2) Q:'GECSDESC
 S XP="Print DOCUMENT code sheets" S GECSCODE=$$YN^GECSUTIL(2) Q:'GECSCODE
 W !
 S %ZIS="Q" D ^%ZIS Q:POP  I $D(IO("Q")) D  D ^%ZTLOAD K IO("Q"),ZTSK Q
 .   S ZTDESC="GCS Stack File Report",ZTRTN="DQ^GECSRST1"
 .   S ZTSAVE("GECS*")="",ZTSAVE("ZTREQ")="@"
 W !!,"<*> please wait <*>"
 D DQ^GECSRST1
 Q
