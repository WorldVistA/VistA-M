RTYAFIX ;ALB/MLI - Set NOKILL node in OPTION file for RT ; 12/6/95 [12/6/95 4:30pm]
 ;;v 2.0;Record Tracking;**24**;10/22/91
 ;
 ; This routine will loop through all package namespaced RT options
 ; and set the NOKILL node of the option file to:
 ;                 RTAPL,RTDIV,RTFR,RTSYS
 ;
 ; This will cause KILL^XUSCLEAN to maintain (or NEW) these variables
 ; if the uers goes from RT to another application and back.
 ;
EN ; start processing
 N I,J,X
 F I=1:1 S X=$P($T(TEXT+I),";;",2) Q:X="QUIT"  D
 . S J=0
 . F  S J=$O(^DIC(19,"B",X,J)) Q:'J  D
 . . I '$D(^DIC(19,J,0)) Q
 . . S ^DIC(19,J,"NOKILL")="RTAPL,RTDIV,RTFR,RTSYS"
 . . W !,"Node set for option:  ",X
 Q
 ;
 ;
TEXT ; text lines holding menu option names
 ;;RT MAS-EXPED-MENU
 ;;RT MAS-FILE-CLERK-MENU
 ;;RT MAS-SUPER-MENU
 ;;RT OVERALL
 ;;RT PULL-MENU
 ;;RT RAD-FILE-CLERK-MENU
 ;;RT RAD-SUPER-MENU
 ;;RT TRANS-MENU
 ;;QUIT
