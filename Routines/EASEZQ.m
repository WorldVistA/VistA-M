EASEZQ ;ALB/jap - 1010EZ Quick Lookup ;02/26/2001  13:07
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;;Mar 15, 2001
 ;
EN ;Main entry point from 1010EZ menu option
 N X,Y,DIC,DA,OUT,DTOUT,DUOUT
 ;Ask user to select processing status
 W @IOF
 W !,"10-10EZ Application Quick Lookup --",!
 W !,"At the prompt, you may enter any one of the following:"
 W !!,?5,"(1) Application ID"
 W !,?5,"    Example: 158"
 W !!,?5,"(2) Web Submission ID"
 W !,?5,"    Example: 4537-15222-2001"
 W !,?5,"             Hyphens must appear just as received from"
 W !,?5,"             the On-Line 1010-EZ application."
 W !!,?5,"(3) Applicant Name"
 W !,?5,"    Examples: SMITH,JOHN R"
 W !,?5,"              JONES,D"
 W !,?5,"              No space between last and first name."
 W !!,?5,"(4) Applicant SSN"
 W !,?5,"    Example: 111-22-3333"
 W !,?5,"             Must be entered as nnn-nn-nnnn."
 W !
 ;do lookup
 S OUT=0 F  D  Q:OUT
 .K X,Y
 .S DIC=712,DIC(0)="AEQMZ" D ^DIC
 .I ($D(DUOUT))!($D(DTOUT))!(Y=-1) S OUT=1 Q
 .I Y>0 D DISPLAY K X,Y
 D KILL^%ZISS
 Q
 ;
DISPLAY ;display application data
 N APPNO,WEBID,APPNM,APPSSN,APPDOB,RECDT,NEWPT,EXPECT,FIDIS,CURR,COMM,ARRAY,DA,DIQ,DIC,DR,XX
 S X="IORVON;IORVOFF" D ENDR^%ZISS
 W @IOF
 I $G(Y(0))'="" D
 .S APPNO=$P(Y(0),U,1),WEBID=$P(Y(0),U,2),APPNM=$P(Y(0),U,4)
 .S APPSSN=$P($P(Y(0),U,5),"&",1),APPDOB=$P($P(Y(0),U,5),"&",2)
 .S X=$P(Y(0),U,11),NEWPT=$S(X=1:"YES",1:"")
 .S X=$P(Y(0),U,13),EXPECT=$S(X=1:"YES",X=0:"NO",1:"")
 .S X=$P(Y(0),U,14),FIDIS=$S(X=1:"YES",X=0:"NO",1:"")
 .S Y=$P(Y(0),U,6) D DD^%DT S RECDT=Y
 .S DIQ="ARRAY",DIQ(0)="E",DA=+APPNO,DR="3.3;4;4.1;4.3;4.4;4.5;5.1;6.1;7.1;9.1;12",DIC=712 D EN^DIQ1
 .S X=$$GET1^DIQ(712,APPNO_",",13,"","COMM")
 .S X=$$CURRSTAT^EASEZU2(APPNO)
 .S CURR=$S(X="CLS":"INACTIVATED",X="FIL":"FILED",X="SIG":"SIGNED",X="PRT":"PRINTED,PENDING SIG.",X="REV":"IN REVIEW",1:"NEW")
 .;display screen1 of data
 .;line1
 .S X=""
 .S X=$$SETSTR^VALM1("App #: ",X,1,8),X=$$SETSTR^VALM1(APPNO,X,9,6)
 .S X=$$SETSTR^VALM1("Web ID: ",X,40,8),X=$$SETSTR^VALM1(WEBID,X,53,20)
 .W !,X
 .;line2
 .S X=""
 .S X=$$SETSTR^VALM1("To: ",X,1,7),XX=$G(ARRAY(712,APPNO,4.5,"E")),X=$$SETSTR^VALM1(XX,X,9,8)
 .S X=$$SETSTR^VALM1("Date Rec'd: ",X,40,12),X=$$SETSTR^VALM1(RECDT,X,53,18)
 .W !,X
 .;line3
 .S X=""
 .S X=$$SETSTR^VALM1("Status: ",X,1,8),X=$$SETSTR^VALM1(IORVON_CURR_IORVOFF,X,9,30)
 .W !,X
 .;line4
 .S X=""
 .S X=$$SETSTR^VALM1("Applicant: ",X,1,11),X=$$SETSTR^VALM1(APPNM,X,12,26)
 .S X=$$SETSTR^VALM1("SSN: ",X,40,5),X=$$SETSTR^VALM1(APPSSN,X,45,11)
 .S X=$$SETSTR^VALM1("DOB: ",X,61,5),X=$$SETSTR^VALM1(APPDOB,X,66,14)
 .W !,X
 .W !
 .;line5
 .S X=""
 .S X=$$SETSTR^VALM1("Vet Type: ",X,1,11),XX=$G(ARRAY(712,APPNO,3.3,"E")),X=$$SETSTR^VALM1(XX,X,12,10)
 .S X=$$SETSTR^VALM1("Vet new to Vista?:",X,40,22),X=$$SETSTR^VALM1(NEWPT,X,63,4)
 .W !,X
 .;line6
 .S X=""
 .S X=$$SETSTR^VALM1("Financial Disclosure: ",X,1,22),X=$$SETSTR^VALM1(FIDIS,X,23,4)
 .S X=$$SETSTR^VALM1("Expect copy from vet?:",X,40,22),X=$$SETSTR^VALM1(EXPECT,X,63,4)
 .W !,X
 .W !
 .;line7
 .S X=""
 .S X=$$SETSTR^VALM1("Review start date: ",X,1,20),XX=$G(ARRAY(712,APPNO,5.1,"E")),X=$$SETSTR^VALM1(XX,X,21,14)
 .S X=$$SETSTR^VALM1("Print date: ",X,40,13),XX=$G(ARRAY(712,APPNO,6.1,"E")),X=$$SETSTR^VALM1(XX,X,53,14)
 .W !,X
 .;line8
 .S X=""
 .S X=$$SETSTR^VALM1("Sign date: ",X,1,20),XX=$G(ARRAY(712,APPNO,4.1,"E")),X=$$SETSTR^VALM1(XX,X,21,14)
 .S X=$$SETSTR^VALM1("File date: ",X,40,13),XX=$G(ARRAY(712,APPNO,7.1,"E")),X=$$SETSTR^VALM1(XX,X,53,14)
 .W !,X
 .;line9
 .S X=""
 .S X=$$SETSTR^VALM1("Inactivate date: ",X,1,20),XX=$G(ARRAY(712,APPNO,9.1,"E")),X=$$SETSTR^VALM1(XX,X,21,14)
 .W !,X
 .W !
 .;line10
 .S X=""
 .S X=$$SETSTR^VALM1("Services Requested: ",X,1,20),XX=$G(ARRAY(712,APPNO,12,"E")),X=$$SETSTR^VALM1(XX,X,21,78)
 .W !,X
 .;line11
 .S X=""
 .S X=$$SETSTR^VALM1("Appt. Requested: ",X,1,20),XX=$G(ARRAY(712,APPNO,4.4,"E")),X=$$SETSTR^VALM1(XX,X,21,78)
 .W !,X
 .;line12
 .S X=""
 .S X=$$SETSTR^VALM1("e-mail Address: ",X,1,20),XX=$G(ARRAY(712,APPNO,4.3,"E")),X=$$SETSTR^VALM1(XX,X,21,78)
 .W !,X
 .;end of screen1
 .K DIR D PAUSE^VALM1
 .Q:X="^"
 .;display screen2 of data
 .W @IOF
 .;line1
 .S X=""
 .S X=$$SETSTR^VALM1("App #: ",X,1,8),X=$$SETSTR^VALM1(APPNO,X,9,6)
 .S X=$$SETSTR^VALM1("Web ID: ",X,40,8),X=$$SETSTR^VALM1(WEBID,X,53,20)
 .W !,X
 .;line2
 .S X=""
 .S X=$$SETSTR^VALM1("Status: ",X,1,8),X=$$SETSTR^VALM1(IORVON_CURR_IORVOFF,X,9,30)
 .W !,X
 .;line3
 .S X=""
 .S X=$$SETSTR^VALM1("Applicant: ",X,1,11),X=$$SETSTR^VALM1(APPNM,X,12,26)
 .W !,X
 .W !
 .;comments
 .W !,"Comments --"
 .S I=0 F  S I=$O(COMM(I)) Q:'I  D
 ..W !,?3,COMM(I)
 ..W !
 .K DIR D PAUSE^VALM1
 Q
