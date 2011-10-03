MAGDRCU1 ;WOIFO/PMK - List entries in ^MAG(2006.5839) ; 05/18/2007 11:23
 ;;3.0;IMAGING;**10,30,54**;03-July-2009;;Build 1424
 ;; Per VHA Directive 2004-038, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 Q
 ; This routine lists the entries in the temporary Imaging/CPRS Consult
 ; Request Tracking association file
 ;
 ;     XXXX                                         XXX       X
 ;    XX  XX                                         XX      XX
 ;   XX         XXXX    XX XXX  XXXXXXX  XX  XXX     XX     XXXXX
 ;   XX        XX  XX   XXX XX  XX       XX  XX      XX      XX
 ;   XX    X   XX  XX   XX  XX  XXXXXXX  XX  XX      XX      XX
 ;    XX  XX   XX  XX   XX  XX       XX  XX  XX      XX      XX XX
 ;     XXXX     XXXX    XX  XX  XXXXXXX   XXX XX    XXXX      XXX
 ;
 ; Routine 1/2 for application
 ;
ENTRY ; read the entries in file ^MAG(2006.5839)
 N COUNT,CUTOFF,DAYS,DIVISION,DONE,INDEX,SELECT,SERVICE,SORT,SUBTITLE,TITLE,X
 ;
 S TITLE="UNREAD LIST FOR HEALTHCARE PROVIDERS"
 W !!,TITLE,!!
 ;
 ; get the division and service list
 S SERVICE=0 F  S SERVICE=$O(^MAG(2006.5831,SERVICE)) Q:'SERVICE  D
 . S X=^MAG(2006.5831,SERVICE,0)
 . S INDEX=$P(X,"^",2),DIVISION=$P(X,"^",3)
 . S SERVICE(DIVISION)=$$GET1^DIQ(4,DIVISION,.01)
 . S SERVICE(DIVISION,INDEX)=$P(^MAG(2005.84,INDEX,0),"^",1)
 . S SERVICE(DIVISION,INDEX,SERVICE)=$$GET1^DIQ(123.5,SERVICE,.01)
 . Q
 ;
 I '$D(SERVICE) W !,"No SERVICEs are defined in file 2006.5831" Q
 ;
 ; select the SERVICE of interest
 S DONE=0 F  D  Q:DONE
 . S COUNT=0,DIVISION=""
 . W !
 . F  S DIVISION=$O(SERVICE(DIVISION)) Q:'DIVISION  D
 . . S INDEX=""
 . . F  S INDEX=$O(SERVICE(DIVISION,INDEX)) Q:INDEX=""  D
 . . . S COUNT=COUNT+1
 . . . W !,$J(COUNT,2),") ",$J(DIVISION,4)," -- ",SERVICE(DIVISION)
 . . . W " -- ",SERVICE(DIVISION,INDEX)
 . . . S SERVICE("B",COUNT)=DIVISION_"^"_INDEX
 . . . Q
 . . Q
 . I COUNT=1 S SELECT="ALL",DONE=1
 . E  D
 . . W !!,"Select the proper service (1-",COUNT,") or enter ALL: " R X:DTIME
 . . I X?.N,X,X'>COUNT S SELECT=SERVICE("B",X),DONE=1
 . . E  I $L(X),"Aa"[$E(X) S SELECT="ALL",DONE=1
 . . E  I X["^" S DONE=-1
 . . E  I X["?" D
 . . . W !!,"Please enter the number of the corresponding service."
 . . . W !,"Enter ""ALL"" if you want all of the services."
 . . . Q
 . . E  W " ???"
 . . Q
 . Q
 I DONE=-1 Q  ; cancelled by user
 ;
 I SELECT="ALL" D
 . S DIVISION=""
 . F  S DIVISION=$O(SERVICE(DIVISION)) Q:'DIVISION  D
 . . S INDEX=""
 . . F  S INDEX=$O(SERVICE(DIVISION,INDEX)) Q:INDEX=""  D
 . . . D SELSERV(DIVISION,INDEX)
 . . . Q
 E  D
 . S DIVISION=$P(SELECT,"^",1),INDEX=$P(SELECT,"^",2)
 . D SELSERV(DIVISION,INDEX)
 . Q
 ;
 S DONE=0 F  D  Q:DONE
 . W !!,"Display studies older than how many days?  0// "
 . R X:DTIME I X="" S X=0 W X
 . I X?.N S DAYS=X,DONE=1 Q
 . E  I X["^" S DONE=-1
 . E  I X["?" D
 . . W !!,"Please enter the minimum number of days that have elapsed since"
 . . W !,"the examination was performed.  This allows only the old studies"
 . . W !,"to be reported.  Enter 0 days to display all the studies."
 . . Q
 . E  W " ???"
 . Q
 I DONE=-1 Q  ; cancelled by user
 S CUTOFF=$$HTFM^XLFDT($H+1-DAYS,0)
 ;
 S DONE=0 F  D  Q:DONE
 . W !!,"Sort by patient name or examination date? (N or D) D// "
 . R X:DTIME I X="" S X="D" W X
 . I "NnDd"[$E(X) S SORT=X,DONE=1 Q
 . E  I X["^" S DONE=-1
 . E  I X["?" D
 . . W !!,"Designate the sort order for the report, alphabetically by patient"
 . . W !,"name or chronologically by the examination date."
 . . Q
 . E  W " ???"
 . Q
 I DONE=-1 Q  ; cancelled by user
 ;
 I SELECT="ALL" S SUBTITLE(1)="ALL SERVICES"
 E  D
 . S SUBTITLE(1)=$P(SELECT,"^",1)_" -- "_SERVICE($P(SELECT,"^",1))
 . S SUBTITLE(1)=SUBTITLE(1)_" -- "_SERVICE($P(SELECT,"^",1),$P(SELECT,"^",2))
 . Q
 I DAYS S SUBTITLE(2)="Studies more than "_DAYS_" days old"
 E  S SUBTITLE(2)="All studies regardless of age"
 S SUBTITLE(2)=SUBTITLE(2)_" sorted by "_$S(SORT="D":"date",1:"name")
 ;
 ; Output the report
 ;
 W ! S %ZIS="Q" D ^%ZIS I POP Q  ; select the output device, quit if none
 ;
 ; setup for queueing the report to print in the background via Taskman 
 I $D(IO("Q")) D  ; queued
 . S ZTSAVE("CUTOFF")=""
 . S ZTSAVE("SELECT")=""
 . S ZTSAVE("SERVICE(")=""
 . S ZTSAVE("SORT")=""
 . S ZTSAVE("SUBTITLE(")=""
 . S ZTSAVE("TITLE")=""
 . S ZTRTN="REPORT^MAGDRCU2",ZTDESC=TITLE
 . D ^%ZTLOAD D HOME^%ZIS K IO("Q")
 . Q
 E  D  ; immediate
 . D REPORT^MAGDRCU2
 . Q
 Q
 ;
SELSERV(DIVISION,INDEX) ; select service
 N S
 S S=""
 F  S S=$O(SERVICE(DIVISION,INDEX,S)) Q:S=""  D
 . S SERVICE("S",S)=SERVICE(DIVISION,INDEX,S)
 . Q
 Q
 ;
