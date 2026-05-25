XUXTADASK1 ;ESL/JAC/CM - UTL Reusable prompting subroutines #1 ; 06/26/2020@9:30
 ;;8.0;KERNEL;**807**;Oct 16, 2024;Build 56;
 ;
 ;
 ; External API'S
 ;
 ; XUXTAD API's
CENTER(AXUXTADTEXT,AXUXTADLF,AXUXTADRM,AXUXTADRVIDEO) D CENTER^XUXTADPRT1($G(AXUXTADTEXT),$G(AXUXTADLF),$G(AXUXTADRM),$G(AXUXTADRVIDEO)) Q
 ;
 ; FileMan/ScreenMan API's
FMDIR D ^DIR Q 
 ;
 ;-- Integration Control Registrations
 ; Reference to ^DIR in ICR #10026
 ;
ASKLIST(XUXTADOUTPUT,XUXTADINPUT,XUXTADMAXNUM,XUXTADDEF) ; Prompt the user to 'Select NUMBER(S): '.
 ; The XUXTADOUTPUT and INPUT parameters must be passed by reference and are
 ; limited to local un-subscripted arrays.  Each of the local array variable
 ; names must be prefixed in the actual parameter list of the calling routine's
 ; DO command with a period.  See the example provided below which was provided
 ; as a reference.
 ;
 ; Input:
 ;   XUXTADOUTPUT ; Required - The programmer selected name for the output
 ;                array prefixed by a period.  This implies that this label
 ;                should be called by reference not by value.
 ;                Examples: .USER ; .DOMAIN ; .LOCATION  .SETOFCDS ; etc.
 ;   XUXTADINPUT  ; Required - A period followed by the programmer name of
 ;                the array from the calling routine in the following format:
 ;                XUXTADINPUT(SequenceNUM)=code_"^"_VALUE
 ;   XUXTADMAXNUM ; Required - Maximum number of input choices
 ;   XUXTADDEF    ; Optional - Default answer to DIR("B") prompt
 ; Output:
 ;   XUXTADOUTPUT=User's typed selection.
 ;     Examples: 1,4-6 ; 1,3 ; 1-9 ; 6 ; "^" ; etc.
 ;   XUXTADOUTPUT(code)=VALUE
 ;     Where code is one of the following:
 ;       1) Integer ; or
 ;       2) Internal code of a set of codes ; or
 ;       3) IEN (Pointer or internal entry number to some file)
 ;     code will be derived from the value of piece one of the XUXTADINPUT
 ;     array parameter.
 ;   XUXTADOUTPUT("CNT")=NumberOfPossibleListChoices
 ;   XUXTADQUIT 1 - User entered '^' to quit or no items were selected by the user.
 ;              0 - Indicates a successful API call and response.
 ; Note: XUXTADOUTPUT and XUXTADINPUT are arrays passed by reference.
 ;
 NEW %,DA,DIR,DIRUT,DTOUT,DUOUT,I,X,Y,XUXTADCODE,XUXTADNUM,XUXTADPCE,XUXTADVALUE
 ;
 KILL XUXTADOUTPUT ; Refresh output array
 S XUXTADQUIT=0 ;. Initialize output status flag to successful
 ;
 ; Setup input variables to DIR call
 S DIR(0)="LAO^1:"_XUXTADMAXNUM ;....... User may select list or range
 S DIR("A")="Select NUMBER(S): " ; Set text of prompt
 I $G(XUXTADDEF)]"" S DIR("B")=XUXTADDEF ;.... Optionally set prompt default value
 D FMDIR ; Prompt user
 ;
 S XUXTADOUTPUT=X ; Return user's selection in XUXTADOUTPUT
 S XUXTADOUTPUT("CNT")=XUXTADMAXNUM ; Number of choices in prompt list
 I "^"[X S XUXTADQUIT=1 Q  ; Set status to unsuccessful on '^'
 ;
 ; Process user's list of choices (comma delimited output by ^DIR)
 ;    Example Y="1,3,7,9,"
 ; and store them in the XUXTADOUTPUT(XUXTADCODE)=VALUE array
 ;
 S XUXTADNUM=""
 F XUXTADPCE=1:1 S XUXTADNUM=$P(Y,",",XUXTADPCE) Q:'XUXTADNUM  D  ;
 . S XUXTADCODE=$P(XUXTADINPUT(XUXTADNUM),U,1),XUXTADVALUE=$P(XUXTADINPUT(XUXTADNUM),U,2)
 . S XUXTADOUTPUT(XUXTADCODE)=XUXTADVALUE
 I '$O(XUXTADOUTPUT(""))']"" S XUXTADQUIT=1 Q  ; No choice made by user
 Q  ; ASKLIST
 ;
ASKNUM(XUXTADMAXNUM,XUXTADDEF,XUXTADPROMPT,XUXTADLINFED) ; Extrinsic to prompt from 1 to XUXTADMAXNUM
 ; Input:
 ;   XUXTADMAXNUM   Optional - Maximum number of input choices
 ;   XUXTADDEF      Optional - Default response (if user hits <Enter> key)
 ;   XUXTADPROMPT   Optional - Input prompt text, for example:
 ;                         "How many days? 90//" ; when XUXTADDEF = 90
 ;   XUXTADLINFED   Optional - Number of linefeeds before prompting user
 ;                         (defaults to 1, if not passed)
 ; Output:
 ;   User's response (Usually an integer, could be '^' or null)
 ;   Note: The calling routine should check for  '^' response.
 ;
 NEW XUXTADCNT,XUXTADRESPONSE
 S XUXTADMAXNUM=$G(XUXTADMAXNUM) ; There is not a default maximum number set
 S XUXTADDEF=$G(XUXTADDEF) ; There is no default response to the prompt, unless the default is passed.
 S XUXTADPROMPT=$G(XUXTADPROMPT,"Select NUMBER")
 S XUXTADPROMPT=XUXTADPROMPT_$S(XUXTADMAXNUM<2:": ",1:"(1-"_XUXTADMAXNUM_"): ")
 S XUXTADLINFED=$G(XUXTADLINFED,1)
 F XUXTADCNT=1:1:XUXTADLINFED W ! ; Issue number of linefeeds based on XUXTADLINFED variable
 ;
ASKNUM1 ; Return to this label upon receiving an incorrect response
 W XUXTADPROMPT I XUXTADDEF]"" W XUXTADDEF_"// "
 R XUXTADRESPONSE:DTIME I XUXTADRESPONSE="",XUXTADDEF="" S XUXTADRESPONSE="^"
 S:$T XUXTADRESPONSE="^"
 I XUXTADDEF]"",XUXTADRESPONSE="" S XUXTADRESPONSE=XUXTADDEF
 I "^"[XUXTADRESPONSE QUIT XUXTADRESPONSE
 I XUXTADRESPONSE'?1.20N!(XUXTADRESPONSE<1)!((XUXTADRESPONSE>XUXTADMAXNUM)&(XUXTADMAXNUM>1)) D  G ASKNUM1
 . Q:XUXTADMAXNUM'>1
 . I XUXTADMAXNUM>1 D  Q  ;
 . . W $C(7),"  Enter a number from 1 to "_$FN(XUXTADMAXNUM,",")_" or '^' to exit."
 . . W !
 . W $C(7),"  Enter a positive integer (1, 2, etc.); or '^' to exit."
 . W !
 Q XUXTADRESPONSE ; ASKNUM
 ;
ASKPKG(XUXTADPROMPT) ; Prompt for 2-7 character Package NAMESPACE
 ; Input:
 ;   XUXTADPROMPT Optional - Text for input prompt - for example: "Enter NAMESPACE: "
 ; Output:
 ;   XUXTADPKG   Chosen namespace (2 to 7 characters)
 ;   XUXTADQUIT  0 - If a successful package namespace was entered.
 ;               1 - If prompt times out; user enters an '^' or the user simply hits
 ;                   <Enter> without answering.
 NEW XUXTADASCII,XUXTADPOS
 ;
ASKPKG1 ; Return to this label upon receiving an incorrect response
 S XUXTADQUIT=0 ; Initialize quit status flag to 0 (or do not quit)
 S XUXTADPROMPT=$G(XUXTADPROMPT,"Which 2-7 character Package NAMESPACE: ")
 ;
 ; Prompt for Package NAMESPACE, quit if user timed out,
 ; no entry was made, or an '^' was entered
 ;
 W !!,XUXTADPROMPT
 ; If user times out or enters a '^' to exit, set XUXTADQUIT=1
 R XUXTADPKG:DTIME I '$T!("^"[XUXTADPKG) S XUXTADQUIT=1 Q
 ;
 ; Test each character entered, do NOT allow lowercase characters
 ; and the first character should be alphabetic (or %).
 ;
 F XUXTADPOS=1:1 Q:XUXTADPOS>$L(XUXTADPKG)!XUXTADQUIT  D  ;
 . I XUXTADPOS=1,"%ABCDEFGHIJKLMNOPQRSTUVWXYZ"'[$E(XUXTADPKG) D  Q
 . . S XUXTADQUIT=1 ; 1st character must be % or alphabetic
 . S XUXTADASCII=$A($E(XUXTADPKG,XUXTADPOS,XUXTADPOS)) ; ASCII character representation
 . I "0123456789"'[$E(XUXTADPKG,XUXTADPOS,XUXTADPOS),XUXTADASCII>96,XUXTADASCII<123 D  ;
 . . S XUXTADQUIT=1 ; Non-alphabetic or numeric char. found
 ;
 I XUXTADPKG["?"!(XUXTADPKG="")!($L(XUXTADPKG)<2)!($L(XUXTADPKG)>7) D  ;
 . S XUXTADQUIT=1 ; Namespace must be 2 to 7 characters
 ;
 I XUXTADQUIT D ERRMSG1,ERRMSG2 G ASKPKG1
 Q  ; ASKPKG
 ;
ASKYESNO(XUXTADPROMPT,XUXTADDEF) ; Extrinsic, prompt for YES, NO response
 ; Input:
 ;   XUXTADPROMPT  Optional - Text of prompt....input to DIR("A")
 ;   XUXTADDEF     Optional - Default response..input to DIR("B")
 ;                       will be "NO" if not passed on input
 ; Output: Y (for YES), N (for NO), or '^"
 ; Intended use:
 ;   This API call was developed as a standardized wrapper call
 ;   to the FM DIR utility when a YES or NO response is required.
 ; Note: The calling routine will be responsible for checking for a
 ;       '^' response as shown in the example calls below.
 ;
 NEW %,DA,DIR,DIRUT,DTOUT,DUOUT,I,X,Y
 S XUXTADPROMPT=$G(XUXTADPROMPT) ; Default response to "NO" if not passed
 S XUXTADDEF=$G(XUXTADDEF,"NO")
 ;
 ;S (DIR("?"),DIR("??"))="Enter 'Y' (for YES), 'N' (for NO), or '^' (to exit)"
 S DIR("?")="Enter 'Y' (for YES), 'N' (for NO), or '^' (to exit)"
 S DIR(0)="Y",DIR("A")=XUXTADPROMPT
 I XUXTADDEF]"" S DIR("B")=XUXTADDEF
 ;
 D FMDIR
 I "^"[Y!(Y["^") Q "^"
 I Y=1 Q "Y"
 I Y=0 Q "N"
 Q "N" ; ASKYESNO
 ;
ERRMSG1 ; Package NAMESPACE requirements were NOT met.
 I XUXTADPKG'["?" W " ??"
 W !!?6,"Enter the first 2 to 7 characters of the Package NAMESPACE, or"
 W !?6,"enter an '^' to exit."
 W !!?6,"The first character must be an alphabetic or % character, followed by"
 W !?6,"any alphanumeric combination, however, all alphabetic characters"
 W !?6,"must be in uppercase with no lowercase characters allowed."
 Q  ; ERRMSG1
 ;
ERRMSG2 ; <CAPS LOCK> key if not on.
 D CENTER("Make sure your <CAPS LOCK> key is on.",2,IOM,1)
 Q  ; ERRMSG2
 ;
GETKEYWD(XUXTADMINLEN,XUXTADMAXLEN) ; Prompt for KEYWORD
 ; Input:
 ;   XUXTADMINLEN Required - Minimum length of KEYWORD specification
 ;   XUXTADMAXLEN Required - Maximum length of KEYWORD specification
 ;   XUXTADKEYWRD Required - externally defined, returned to caller.
 ; Output:
 ;   XUXTADKEYWRD Keyword to be used later for screening output records
 ;              (or user's response which could be null or "^")
 ;   XUXTADQUIT   0 - Keyword successfully chosen
 ;              1 - User entered '^' or no keyword was chosen
 ;
 NEW XUXTADPOS
 W !
GETKEY1 ; Return to this label upon receiving an incorrect response
 ;
 W !,"Select a KEYWORD (from "_XUXTADMINLEN_" to "_XUXTADMAXLEN_" characters): "
 S XUXTADQUIT=0 ; Do not quit when returning to the calling module
 ;
 R XUXTADKEYWRD:DTIME S:'$T XUXTADKEYWRD="^"
 I XUXTADKEYWRD="" S XUXTADQUIT=1 Q  ; No keyword found
 I XUXTADKEYWRD["^" S XUXTADQUIT=1 Q  ;User entered an '^'
 I $L(XUXTADKEYWRD)<XUXTADMINLEN!($L(XUXTADKEYWRD)>XUXTADMAXLEN) W " ??" G GETKEY1
 F XUXTADPOS=1:1:$L(XUXTADKEYWRD) D  I XUXTADQUIT G GETKEY1
 . ; Verify that the Keyword is in uppercase format.
 . I $A($E(XUXTADKEYWRD,XUXTADPOS,XUXTADPOS))>96,$A($E(XUXTADKEYWRD,XUXTADPOS,XUXTADPOS))<123 D  ;
 . . NEW XUXTADMSG
 . . S XUXTADMSG="Make sure <Caps Lock> key in on and re-enter your keyword"
 . . D CENTER(XUXTADMSG,1,IOM,1)
 . . S XUXTADQUIT=1 ; Keyword entered is not all uppercase chars.
 Q  ; GETKEYWD
 ;
GETSORT(XUXTADRTN,XUXTADINPUT,XUXTADDEF) ; Get sorting criteria (generic subroutine call)
 ; Input:
 ;   XUXTADRTN..... ; Required - Name of calling routine, typically $T(+0)
 ;   XUXTADINPUT(n)=Sorting_Option - Required
 ;     Where XUXTADINPUT represents the name of the input array, and n is a
 ;           consecutive integer from 1 to the (n)umber of sorting options presented
 ;     The input array name is passed by reference and any local array
 ;     name can be used, although passing '.XUXTADSORT' is preferred
 ;     which then allows the calling routine to utilize the user
 ;     selected sorting option to be referenced as XUXTADSORT(XUXTADSORT).
 ;     This also minimizes the number of variables that would have to
 ;     be NEWed by the calling routine.
 ;   XUXTADDEF  Optional - Default integer response to prompt.
 ;            Defaults to 1 if not passed
 ;            If XUXTADDEF is passed and XUXTADINPUT(XUXTADDEF) exists, then XUXTADDEF
 ;            becomes the default integer response allowing the
 ;            developer to always override other previous default responses.
 ; Output:
 ;   XUXTADSORT Integer representing user's sorting choice
 ;   XUXTADQUIT Set to 1 if the user up-arrows out, otherwise 0.
 ;
 NEW XUXTADCNT,XUXTADPOS,XUXTADRESPONSE
 ;
 ; Set default response to input prompt in variable XUXTADDEF
 ;
 I $G(XUXTADDEF)>0,$D(XUXTADINPUT(XUXTADDEF)) S XUXTADDEF=XUXTADDEF
 E  S XUXTADDEF=1
 S XUXTADQUIT=0 ; Do not quit when returning to the calling module
 ;
 W !!,"Sort by"
 F XUXTADCNT=1:1 Q:'$D(XUXTADINPUT(XUXTADCNT))  D  ;
 . S XUXTADPOS=$S($L(XUXTADCNT)>9:$L(XUXTADCNT),1:2) ; Horizontal print position
 . W !?XUXTADPOS,$J(XUXTADCNT,2),") ",XUXTADINPUT(XUXTADCNT)
 S XUXTADCNT=XUXTADCNT-1
 ;
 S XUXTADRESPONSE=$$ASKNUM(XUXTADCNT,XUXTADDEF) I XUXTADRESPONSE="" S XUXTADRESPONSE=XUXTADDEF
 I XUXTADRESPONSE["^" S XUXTADQUIT=1 Q  ; User entered an '^'
 ;
 S XUXTADINPUT=XUXTADRESPONSE ;;02020-03-09 update
 S XUXTADSORT=XUXTADRESPONSE
 Q  ; GETSORT
 ;
USRLIMIT(XUXTADRTN) ; Include (active users, inactive users, or both active and inactive users)
 ; Output:
 ;   XUXTADULIMIT  1 for both active & inactive users
 ;                2 for active users
 ;                3 for inactive users
 ;   XUXTADQUIT   0 - for successful selection at prompt
 ;                1 - if user enters an '^' to exit at prompt
 ; Input:
 ;   XUXTADRTN    Required - Name of calling routine; usually $T(+0)
 ;
 NEW XUXTADDEF
 ;
 S XUXTADDEF=1
 ;
 W !!,"Include"
 W !?4,"1) Both active and inactive users"
 W !?4,"2) Only active users"
 W !?4,"3) Only inactive users"
 ;
 S XUXTADULIMIT=$$ASKNUM(3,XUXTADDEF)
 I XUXTADULIMIT="^" S XUXTADQUIT=1 Q  ; User entered an '^'
 ;
 S XUXTADQUIT=0 ; Do not quit when returning to the calling module
 Q  ; USRLIMIT
 ;
 ;XUXTADASK1 ;ESL/JAC/cm - UTL Reusable prompting subroutines #1 ; 06/26/2020  09:30
