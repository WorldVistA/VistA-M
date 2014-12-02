MAGDIWDX ;WOIFO/PMK - Formatted listing of On Demand Routing request file ; 06 Mar 2013 8:05 AM
 ;;3.0;IMAGING;**138**;Mar 19, 2002;Build 5380;Sep 03, 2013
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
 ;
 ; This routine is the same on VistA and the DICOM Gateway
 ;
REPORT(LOC,A,ODEVNAME,ODEVTYPE) ; display the list of studing in the output file
 N ACCNUMB,COUNT,D0,DATETIME,DEFAULT,GROUP,I,IGNORESUCCESS,J
 N LOCATION,LOCATIONLAST,MSG
 N POP,PRIORITY,REQUESTDATETIME,SCP,STATUS,STOP,USERAPP,USERAPPLAST,X,Y
 F I=2:1:LOC(1) D
 . S LOCATION($P(LOC(I),"^",1))=$P(LOC(I),"^",2)
 . S LOCATION("N",I-1)=$P(LOC(I),"^",1)
 . Q
 ;
 ; select the sending location
 S DEFAULT=""
 I LOC(1)>2 D
 . S LOC="" F  D  Q:LOC'=""
 . . W !!,"There are multiple sending locations on file:",!
 . . F I=1:1:LOC(1)-1 D
 . . . S LOCATION=LOCATION("N",I)
 . . . W !,$J(I,5)," -- ",LOCATION(LOCATION)
 . . . I LOCATION=LOC("DEFAULT") S DEFAULT=I
 . . . Q
 . . W !!,"Enter 1-",I," or ""A"" for all: "
 . . I DEFAULT'="" W DEFAULT,"// "
 . . R X:DTIME E  S X="^"
 . . I X="" S X=DEFAULT W X
 . . I "^"[X S LOC="^"
 . . E  I X?1N.N,X>=1,X<=I S LOC=LOCATION("N",X) W " -- ",LOCATION(LOC)
 . . E  I "Aa"[$E(X) S LOC="A" W " -- All"
 . . Q
 . Q
 E  S LOC="A" ; just one location
 ;
 ; select the Store SCP userapp
 S J=0,USERAPP="" F I=1:1:$G(A(1)) D
 . S USERAPP=$P(A(I+1),"^",2)
 . I '$D(USERAPP(USERAPP)) S J=J+1,USERAPP(USERAPP)=J,USERAPP("N",J)=USERAPP
 . Q
 S DEFAULT="A"
 I J>1 D
 . S SCP="" F  D  Q:SCP'=""
 . . W !!,"There are multiple Store SCPs on file:",!
 . . F I=1:1:J  D
 . . . W !,$J(I,5)," -- ",USERAPP("N",I)
 . . . Q
 . . W !!,"Enter 1-",J," or ""A"" for all: "
 . . I DEFAULT'="" W DEFAULT,"// "
 . . R X:DTIME E  S X="^"
 . . I X="" S X=DEFAULT W X
 . . I "^"[X S SCP="^"
 . . E  I X?1N.N,X>=1,X<=J S SCP=USERAPP("N",X) W " -- ",SCP
 . . E  I "Aa"[$E(X) S SCP="A" W " -- All"
 . . Q
 . Q
 E  S SCP="A" ; just one Store SCP
 ;
 S DEFAULT=$S(ODEVTYPE="SCREEN":"Y",1:"N")
 S X=$$YESNO("Ignore Successful Transmissions?",DEFAULT,.IGNORESUCCESS)
 ;
 ; output the report
 ;
 I ODEVTYPE="FILE" O ODEVNAME:"NW" U ODEVNAME
 ;
 S (MSG(1),MSG(3))=""
 S $Y=0,STOP=0
 S MSG(2)="DICOM Object Export File Status -- "_$$HTE^XLFDT($H)
 I ODEVTYPE="SCREEN" Q:$$NEWLINE()  Q:$$NEWLINE()
 Q:$$HEADING(.MSG) 
 S LOCATIONLAST=""
 F I=1:1:$G(A(1)) S X=A(I+1) D  Q:STOP
 . N WRITEACCNUMB
 . S WRITEACCNUMB=0
 . S LOCATION=$P(X,"^",1),USERAPP=$P(X,"^",2)
 . I LOC'="A",LOCATION'=LOC Q
 . I SCP'="A",SCP'=USERAPP Q
 . S PRIORITY=$P(X,"^",3),D0=$P(X,"^",4),ACCNUMB=$P(X,"^",5)
 . S REQUESTDATETIME=$P(X,"^",6),GROUP=$P(X,"^",7)
 . I LOCATION'=LOCATIONLAST S LOCATIONLAST=LOCATION,USERAPPLAST=""
 . I USERAPP'=USERAPPLAST D
 . . N MSG
 . . S (MSG(1),MSG(3),MSG(5))=""
 . . S MSG(2)="Sending Site: "_LOCATION(LOCATION)
 . . S MSG(4)="Destination: "_USERAPP
 . . Q:$$NEWLINE()  Q:$$NEWLINE()
 . . Q:$$HEADING(.MSG)
 . . S USERAPPLAST=USERAPP
 . . Q
 . F J=1:1:$L(X,"^")-7 D  Q:STOP
 . . S Y=$P(X,"^",J+7),STATUS=$P(Y,"|",1)
 . . I IGNORESUCCESS="YES",STATUS="SUCCESS" Q
 . . I 'WRITEACCNUMB D  Q:STOP
 . . . S STOP=$$NEWLINE() Q:STOP  S STOP=$$NEWLINE() Q:STOP
 . . . W ACCNUMB S WRITEACCNUMB=1
 . . . Q
 . . S DATETIME=$P(Y,"|",2),COUNT=$P(Y,"|",3)
 . . I $X>20 S STOP=$$NEWLINE() Q:STOP
 . . W ?20,$J(COUNT,4),?28,STATUS,?40,$$HTE^XLFDT(DATETIME,"2M")
 . . W ?57,"(",$$FMTE^XLFDT(REQUESTDATETIME,"2M"),")"
 . . Q
 . Q
 ;
 Q:$$NEWLINE()  Q:$$NEWLINE()
 W "End of Report" Q:$$NEWLINE()
 I ODEVTYPE'="SCREEN" D
 . I ODEVTYPE="FILE" C ODEVNAME
 . U $P
 . W !!,"Report successfully writen to file """,ODEVNAME,"""",!
 . Q
 Q
 ;
HEADING(MSG) ;
 N I,STOP
 Q:$$NEWLINE() 1 W $TR($J("",80)," ","*")
 I $D(MSG)=1  Q:$$NEWLINE() 1 W "*** ",MSG,?76," ***"
 E  S STOP=0 D  Q:STOP 1
 . F I=1:1 Q:'$D(MSG(I))  D  Q:STOP
 . . S STOP=$$NEWLINE() Q:STOP
 . . W "*** ",MSG(I),?76," ***"
 . . Q
 . Q
 Q:$$NEWLINE() 1 W $TR($J("",80)," ","*")
 Q 0
 ;
NEWLINE() ; output a <carriage return> <line feed> with scrolling control
 N I,STOP,X
 S STOP=0
 W !
 I ODEVTYPE="SCREEN",$Y>=23 D
 . W "more..." R X:DTIME F I=1:1:$X W $C(8,32,8)
 . S $Y=0 Q:X=""
 . S:$TR(X,"quitexnQUITEXN","^^^^^^^^^^^^^^")["^" STOP=1
 . Q
 Q STOP
 ;
YESNO(PROMPT,DEFAULT,CHOICE) ; generic YES/NO question driver
 N OK,X
 S OK=0 F  D  Q:OK
 . W !!,PROMPT," " I $L($G(DEFAULT)) W DEFAULT," // "
 . R X:DTIME E  S OK=-1 Q
 . I X="",$L($G(DEFAULT)) S X=DEFAULT W X
 . I X="",'$L($G(DEFAULT)) S X="*" ; fails Y/N tests
 . I X["^" S CHOICE="^",OK=-1 Q
 . I "Yy"[$E(X) S CHOICE="YES",OK=1 Q
 . I "Nn"[$E(X) S CHOICE="NO",OK=1 Q
 . W "   ??? - Please enter ""Yes"" or ""No""."
 . Q
 Q OK
