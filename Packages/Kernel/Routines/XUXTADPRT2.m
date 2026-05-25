XUXTADPRT2 ;ESL/JAC/CM - UTL Printing subroutines & extrinsics #2 ; 06/26/2020@9:30
 ;;8.0;KERNEL;**807**;Oct 16, 2024;Build 56;
 ;
 ;
 ; External API'S
 ;
 ; XUXTAD API's
CONTINUE(AXUXTADLF,AXUXTADTYPE) D CONTINUE^XUXTADPRT1($G(AXUXTADLF),$G(AXUXTADTYPE)) Q
 ; Helper API's
UP(AXUXTADOPTION) Q $$UP^XLFSTR(AXUXTADOPTION)
 ;
 ;-- Integration Control Registrations
 ; Reference to $$UP^XLFSTR in ICR #10104
 ;
DOTS(XUXTADCURRCNT,XUXTADDISPCNT) ; Write dots '.....' to the video display every x number
 ;              of records, where x defaults to every 100 records
 ;-- Input:
 ;   XUXTADCURRCNT ; Required ; Current count
 ;   XUXTADDISPCNT ; Optional ; Display count (when to display the dot)
 ;-- Output:
 ;   No output variables will be returned.
 ;-- Intended use:
 ;   For periodically displaying dots across the video display screen
 ;   during processing loops to indicate processing is continually
 ;   taking place.
 ; Example calls:
 ;   D DOT2^XUXTADPRT2(CNT) ;...... Writes a dot every hundred records
 ;   D DOT2^XUXTADPRT2(CNT,25) ;... Writes a dot every 25 records
 ;   D DOT2^XUXTADPRT2(CNT,400) ;.. Writes a dot every 400 records
 ;
 S XUXTADDISPCNT=$G(XUXTADDISPCNT,100) ;-> Default to every 100 entries
 I XUXTADCURRCNT#XUXTADDISPCNT=0,$E(IOST)="C" W "."
 Q  ; DOTS
 ;
SHOWGOAL(XUXTADRTN) ; Display the purpose or goal of the routine/menu option
 ;      to the user.  This should be located at GOAL+1^XUXTADRTN and
 ;      the end of the goal should be documented by the following
 ;      code:  ;; *** END ***
 ;-- Input:
 ;   XUXTADRTN ; Required ; Name of executed routine which has the goal
 ;         documented.
 ;-- Output:
 ;   No output variables will be returned.
 ; Example use:
 ;   D ASKGOAL G:XUXTADQUIT EXIT ; Return: XUXTADGOAL ; Y,N, or '^'
 ;   D:XUXTADGOAL="Y" SHOWGOAL^XUXTADPRT2($T(+0)) ; Display goal to user
 ;   ; Note: See routine XUXTADDGPAL (Patient Address Labels for a good
 ;           example of the usage of the two APIs shown above.
 ;-- Intended use:
 ;   This was created to provide a standardized method for educating
 ;   the end user on the intention (goal and/or purpose), of the
 ;   calling routine's source code (or menu option).  Utilization of
 ;   this API will also allow the application developer to also
 ;   document his or her intentions inside the source code of the
 ;   calling module which can assist with future maintenance of
 ;   routine source code.  Newly released enhancements can also be
 ;   communicated easily by appending to the text to be displayed and
 ;   this makes it easier for the end user to become more informed.
 ;
 NEW XUXTADCNT,XUXTADGOALEND,XUXTADLINNUM,XUXTADROUTINE,XUXTADTEXT
 ;
 S XUXTADGOALEND="*** END ***"
 S XUXTADLINNUM=1
 S XUXTADCNT=0
 S XUXTADROUTINE="GOAL+"_XUXTADLINNUM_"^"_XUXTADRTN
 W !
 F  S XUXTADTEXT=$P($T(@XUXTADROUTINE),";;",2,999) Q:XUXTADTEXT[XUXTADGOALEND  D  ;
 . I $Y>(IOSL-5) D CONTINUE(2,"R") W @IOF
 . W !,XUXTADTEXT
 . S XUXTADLINNUM=XUXTADLINNUM+1
 . S XUXTADROUTINE="GOAL+"_XUXTADLINNUM_"^"_XUXTADRTN
 . S XUXTADCNT=XUXTADCNT+1
 ;
 D CONTINUE(2,"R") ;............. Press <ENTER> to continue
 W @IOF
 Q  ; SHOWGOAL
 ;
SHOWOPT(XUXTADOPTION) ; Display option text.
 ;-- Input:
 ;   XUXTADOPTION ; Required ; Option MENU TEXT
 ;-- Output:
 ;   No output variables will be returned.
 ; Example calls:
 ;   1. D SHOWOPT^XUXTADPRT2("PATIENT ADDRESS LABELS") ; hardcoded
 ;
 ;   2. NEW XUXTADOPTION
 ;      S XUXTADOPTION="OPTION MENU TEXT"
 ;      D SHOWOPT^XUXTADPRT2(XUXTADOPTION)
 ;-- Intended use:
 ;   To be used at the beginning of a routine, before prompting
 ;   begins, to display which menu option the user selected, which
 ;   can remind them after an interruption.
 Q:XUXTADOPTION=""
 W @IOF,!?1,"*** ",$$UP(XUXTADOPTION)," ***"
 Q  ; SHOWOPT
 ;
TRYAGAIN(XUXTADINPUTVAR) ; Generic user response message to try again or exit.
 ;-- Input:
 ;   XUXTADINPUTVAR ; Required ; User's response to the previous prompt
 ;
 ;-- Output:
 ;   XUXTADQUIT ; Set to 1 to indicate unsuccessful input response
 ;
 ;-- Intended use:
 ;   The intent of this API is to standardize the dialog that the
 ;   user would see when their response to an input prompt was not
 ;   what was expected.  A call to this API should be preceded by
 ;   a one or two line message on the nature of the specific error
 ;   made on user input, then this API would standardize the dialog
 ;   of options that the user would have moving forward.  This API
 ;   is NOT intended for use in silent (DIQUIET=1) programming
 ;   applications.
 ;
 ; Example usage:
 ;   ; User entered a package namespace for retrieving mail groups
 ;   W !
 ;   W !?6,"There are currently no Mail Groups that begin with '"_XUXTADINPUTVAR_"'."
 ;   D TRYAGAIN^XUXTADPRT2(XUXTADINPUTVAR)
 ;   G PROMPT ; Return to the beginning of prompting dialog.
 ;
 ; Verify that the response was not in lowercase.
 I $A($E(XUXTADINPUTVAR))>96 W !?6,"Make sure your <CAPS LOCK> key is on.",!
 ;
 ; Generic message always displayed to the user on input errors
 W !?6,"You may try again, or optionally exit this option by pressing"
 W !?6,"<Enter> or entering an up arrow ('^') after returning to the"
 W !?6,"first prompt."
 ;
 D CONTINUE(2,"R") ; Press <ENTER> to continue
 SET XUXTADQUIT=1 ; Set output status flag to unsuccessful
 Q  ; TRYAGAIN
 ;
 ;XUXTADPRT2 ;ESL/JAC/cm - UTL Printing subroutines & extrinsics #2 ; 06/26/2020  09:30
