XUXTADDILG ;ESL/JAC/CM - UTL Reusable FM DIALOG Calls #1 ; 06/26/2020@9:30
 ;;8.0;KERNEL;**807**;Oct 16, 2024;Build 56;
 ;
 ;
 ; External API'S
 ;
 ; XUXTAD API's
CENTER(AXUXTADTEXT,AXUXTADLF,AXUXTADRM,AXUXTADRVIDEO) D CENTER^XUXTADPRT1($G(AXUXTADTEXT),$G(AXUXTADLF),$G(AXUXTADRM),$G(AXUXTADRVIDEO)) Q
CONTINUE(AXUXTADLF,AXUXTADTYPE) D CONTINUE^XUXTADPRT1($G(AXUXTADLF),$G(AXUXTADTYPE)) Q
MSG(ADIFLGS,ADIOUT,ADIMARGIN,ADICOLUMN,ADIINNAME) D MSG^DIALOG($G(ADIFLGS),$G(ADIOUT),$G(ADIMARGIN),$G(ADICOLUMN),$G(ADIINNAME)) Q
 ;
 ;-- Integration Control Registrations
 ; Reference to MSG^DIALOG in ICR #2050
 ; Reference to CLEAN^DILF in ICR #2054
 ;
DIERR(XUXTADWIDTH,XUXTADLFTMAR,XUXTADMSGROOT,XUXTADFRMRTN,XUXTADNOPAUSE) ; Display DBS error messages.
 ; Call this subroutine after a database server API call.  If DIERR
 ; is not detected, the API will return XUXTADQUIT=0 and quit; otherwise
 ; the error message will be displayed.
 ;
 ;-- Input:
 ;   XUXTADWIDTH   ; Required ; Maximum line length or text width
 ;                        for formatting the text.
 ;   XUXTADLFTMAR    ; Required ; Starting position of left margin for writing
 ;                        the text of the error message.
 ;   XUXTADMSGROOT ; Optional ; Closed root of which the local input error
 ;                        message resides.
 ;   XUXTADFRMRTN ; Optional ; Calling entry point that generates this
 ;                        error.  For example: 'BUILD1^R2IVVUO1'.
 ;   XUXTADNOPAUSE ; Optional ; If 1 don't pause screen output for user
 ;                        response, continue processing.
 ;
 ;-- Output:
 ;   XUXTADQUIT ; 0 ; if everything is ok
 ;            1 ; when a required parameter is missing or a database
 ;                server error was detected.
 ;
 SET XUXTADQUIT=0 ; Initialize output flag XUXTADQUIT to successful (0).
 S XUXTADFRMRTN=$G(XUXTADFRMRTN)
 ;
 ; Check for required input parameters
 ;
 I '$G(XUXTADWIDTH)!('$G(XUXTADLFTMAR)) D  Q
 . I $E(IOST,1,2)="C-" D  ; Output message only to a display screen.
 . . NEW XUXTADERRMSG
 . . S XUXTADERRMSG="One or more required input parameters are missing "
 . . D CENTER(XUXTADERRMSG,2,IOM,1)
 . . I XUXTADFRMRTN]"" D  ;
 . . . S XUXTADERRMSG="in calling routine "_XUXTADFRMRTN
 . . . D CENTER(XUXTADERRMSG,1,IOM,1)
 . . S XUXTADERRMSG="to the DIERR^R2IVVOAU API call"
 . . D CENTER(XUXTADERRMSG,1,IOM,1)
 . . Q:$G(XUXTADNOPAUSE)  I $E(IOST,1,2)="C-" D CONTINUE(2,"R")
 . SET XUXTADQUIT=1 ; Set return flag to unsuccessful
 Q:'$G(DIERR)  ; Quit if no database server error message detected.
 ;
 ; Display database server error message & cleanup message array
 ;
 ;   Flags "WE":
 ;     (W)rite text to current device
 ;     (E)rror array text is processed
 ;
 I $E(IOST,1,2)="C-" D  ; Output message only to a display screen.
 . W !
 . I $G(XUXTADMSGROOT)]"" D MSG("WE",,XUXTADWIDTH,XUXTADLFTMAR,XUXTADMSGROOT)
 . I $G(XUXTADMSGROOT)']"" D MSG("WE","",XUXTADWIDTH,XUXTADLFTMAR)
 . I $G(XUXTADIENS)]"" W !,?XUXTADLFTMAR,"For IENS: ",XUXTADIENS D  ;
 . . Q:'$G(XUXTADFILE)  W " file #",XUXTADFILE
 . I $G(XUXTADIENS)]"" W !,?XUXTADLFTMAR,"For IENS: ",XUXTADIENS D  ;
 . . Q:'$G(XUXTADFILE)  W " file #",XUXTADFILE
 . I XUXTADFRMRTN]"" W !,?XUXTADLFTMAR,"Error generated from "_XUXTADFRMRTN_"."
 . Q:$G(XUXTADNOPAUSE)  I $E(IOST,1,2)="C-" D CONTINUE(2,"R")
 D CLEAN^DILF ; Kills standard ^TMP DBS global and local variables.
 I $G(XUXTADMSGROOT)]"" KILL @XUXTADMSGROOT ; Cleanup local message array
 SET XUXTADQUIT=1 ; Set return flag to unsuccessful
 Q  ; DIERR
 ;
 ;XUXTADDILG ;ESL/JAC/cm - UTL Reusable FM DIALOG Calls #1 ; 06/26/2020  09:30
