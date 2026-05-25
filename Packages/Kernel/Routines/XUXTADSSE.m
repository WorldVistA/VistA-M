XUXTADSSE ;ESL/JAC/CM - Service/Section Edit ; JUN 26, 2020@9:30
 ;;8.0;KERNEL;**807**;Oct 16, 2024;Build 56;
 ;
 ;
 ; External API'S
 ;
 ; XUXTAD API's
SHOWOPT(AXUXTADOPTION) D SHOWOPT^XUXTADPRT2($G(AXUXTADOPTION)) Q
SHOWGOAL(XUXTADRTN) D SHOWGOAL^XUXTADPRT2($G(XUXTADRTN)) Q
CONTINUE(AXUXTADLF,AXUXTADTYPE) D CONTINUE^XUXTADPRT1($G(AXUXTADLF),$G(AXUXTADTYPE)) Q
ASKYESNO(AYESNOPROMPT,AXUXTADDEF) Q $$ASKYESNO^XUXTADASK1($G(AYESNOPROMPT),$G(AXUXTADDEF))
 ;
 ; FileMan/ScreenMan API's
FMDIC D ^DIC Q 
SMDDS D ^DDS Q
 ;
 ;
 ;-- Integration Control Registrations
 ; Reference to ^DDS in ICR #10031
 ; Reference to ^DIC in ICR #10006
 ;
 ; From option: Service/Section Edit [XUXTAD SERVICE/SECTION EDIT]
 ;
GOAL ;; Display the goal of this routine.
 ;;                       Purpose (or goal)
 ;;
 ;; This option was created in support of the CPRS Parameter Definition
 ;; 'ORB FORWARD SUPERVISOR'.  This parameter value documents the number of
 ;; days before a notification is forwarded to a recipient's supervisor for
 ;; an unprocessed clinical alert.
 ;;
 ;; Determination of recipients who have not processed the notification and
 ;; who their supervisors are is made by the Kernel Alert Utility.
 ;;
 ;; The CHIEF (or SUPERVISOR) field associated with the user's SERVICE/SECTION
 ;; entry will be utilized by the Kernel Alert Utility for this important
 ;; clinical notification process.
 ;;
 ;;*** END ***
 ;
 ; Requested by:
 ;   Franklin Scott, RN-BC, MSN
 ;   Chief Health Informatics Officer
 ;   Central Texas VHCS
 ;   (254) 742-4951 Office
 ;   (254) 379-0791 Cell
 ;
 ; Others consulted:
 ;   Emily Mellecker, IT Specialist (Systems Analyst),
 ;                    Service Operations - Infrastructure Operations
 ;   Patti Howard,    IT Analyst, R2 Applications, VistA
 ;                    Service Operation - Enterprise Command Center
 ;
ENTER ; Allow the ADPAC to update CHIEF of the SERVICE/SECTION file (#49)
 ;
 ; From option: Service/Section Edit [XUXTAD SERVICE/SECTION EDIT]
 ;
 NEW XUXTADGOAL,XUXTADOPTION,XUXTADQUIT,XUXTADXUDA,XUXTADSSFILE
 ;
 S XUXTADOPTION="SERVICE/SECTION EDIT"
 S XUXTADQUIT=0 ; Quit flag, set to 1 when it is time to terminate routine
 S XUXTADSSFILE=49 ; File number of SERVICE/SECTION file
 ;
 D SHOWOPT(XUXTADOPTION) ; Display menu text
 D ASKGOAL G:XUXTADQUIT EXIT ; Return: XUXTADGOAL ; Y,N, or '^'
 D:XUXTADGOAL="Y" SHOWGOAL($T(+0)) ; Display goal to user
 ;
PROMPT ; Begin & loopback entry point
 ;
 D SHOWOPT(XUXTADOPTION) W ! ; Display menu text
 D GETSVC(XUXTADSSFILE) G:XUXTADQUIT EXIT  ;
 ;
START ; Call the FM ScreenMan SERVICE/SECTION EDIT form
 ;
 D EDIT(XUXTADSSFILE,XUXTADXUDA) G:XUXTADQUIT PROMPT
 ;
 G PROMPT ; Loopback to PROMPT, allow editing another (or same) entry
 ;
EXIT ; Exit option
 KILL ^TMP("SS",$J)
 Q  ; Quit Routine XUXTADXUSSE
 ;
ASKGOAL ;Prompt to determine if user want to see purpose/goal of option
 ;-- Input:
 ;   XUXTADRTN   ; Use $T(+0) or calling routine name
 ;-- Output:
 ;   XUXTADGOAL  ; Y to include only users that are not cloned
 ;             N to process only cloned and non-cloned users
 ;             ^ if user up-arrows out
 ;   XUXTADQUIT  ; Set to 1 if the user up-arrows out
 NEW XUXTADDEF
 ;
 S XUXTADQUIT=0 ; Routine quit processing variable initialed to No (0)
 I $D(XUXTADGOAL) Q
 E  S XUXTADDEF="Y"
 W !
 S XUXTADGOAL=$$ASKYESNO(" Display goal of this option",$S(XUXTADDEF="Y":"YES",XUXTADDEF="N":"NO",1:""))
 I XUXTADGOAL["^" S XUXTADQUIT=1 Q
 Q  ; Quit ASKGOAL
 ;
DDSERR ; Display FM ScreenMan error(s)
 ;
 NEW XUXTADNUM
 ;
 W @IOF,!!
 ;
 S XUXTADNUM=0 ; Display any FM ScreenMan error(s)
 F  S XUXTADNUM=$O(^TMP("DIERR",$J,1,"TEXT",XUXTADNUM)) Q:'XUXTADNUM  D  ;
 . W !,?1,^TMP("DIERR",$J,1,"TEXT",XUXTADNUM)
 ;
 D CONTINUE(2,"R")
 ;
 KILL ^TMP("DIERR",$J)
 Q  ; Quit DDSERR
 ;
EDIT(XUXTADXUFILE,XUXTADXUDA) ; Edit SERVICE/SECTION ScreenMan form
 ;-- Input:
 ;   XUXTADXUFILE ; Required ; 49 (File number for SERVICE/SECTION file)
 ;   XUXTADXUDA   ; Required ; IEN of the SERVICE/SECTION entry to edit
 ;-- Output:
 ;   XUXTADQUIT ; Set to 1 if a FM ScreenMan error was detected.
 ;
 NEW %,DA,DDSCHANG,DDSFILE,DDSPAGE,DDSPARM,DDSSAVE,DIERR,DIMSG
 NEW DINUM,DILOCKTM,DR,DTOUT,DUTOUT,I,IOPAR,IOUPAR
 ;
 S DDSFILE=XUXTADXUFILE ; SERVICE/SECTION file (#49)
 S DA=XUXTADXUDA ; IEN of the SERVICE/SECTION file entry
 S DR="[XUXTAD "_XUXTADOPTION_"]" ; Name of ScreenMan form
 ; ScreenMan (DDS) Parameters:
 ;   C ; Return DDSCHANG=1 if user made a change to the database entry
 ;   E ; Return Error messages in ^TMP("DIERR",$J & DIERR if ScreenMan
 ;       encounters problems when initially loading the form
 ;   S ; Return DDSAVE=1 if user issued some form of a Save, whether
 ;       or not any changes to the database were made.
 S DDSPARM="CES" ; See ScreenMan (DDS) Parameters (above)
 S DDSPAGE=1 ;.... Start with Page 1
 D SMDDS ;......... Execute ScreenMan form
 I $G(DIERR) D DDSERR S XUXTADQUIT=1 Q  ; Process error & quit
 Q  ; Quit EDIT
 ;
GETSVC(XUXTADXUFILE) ; Ask/prompt for SERVICE/SECTION using DIC utility call
 ;-- Output:
 ;   XUXTADXUDA ; Internal entry number of the SERVICE/SECTION file (#49)
 ;            or return null if error detected
 ;   XUXTADQUIT ; Set to 1 when an error is detected, otherwise 0
 ;
 NEW %,C,D,D0,DA,DBT,DDH,DG,DIC,DILN,DINUM,DIPGM
 NEW DISYS,DIY,DST,DTOUT,DUOUT,DZ,I,X,Y
 ;
 KILL XUXTADXUDA ; Refresh output variable do to multiple executions
 S DIC="^DIC("_XUXTADXUFILE_","
 S DIC(0)="AEMQ"
 S DIC("A")="Select SERVICE/SECTION NAME: "
 ;
 D FMDIC
 I X["^" S XUXTADQUIT=2 Q  ; XUXTADQUIT=2 when user enters an '^'
 I Y<0 S XUXTADQUIT=1 Q
 S XUXTADXUDA=$P(Y,U) ; IEN of the selected SERVICE/SECTION entry
 Q  ; Quit GETSVC
 ;
 ;ESL/JAC/cm - Service/Section Edit
 ;
