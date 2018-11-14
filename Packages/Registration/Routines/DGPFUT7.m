DGPFUT7 ;ALB/RBS - PRF COMMON PROMPTS ; 05/11/2018 10:00
 ;;5.3;Registration;**960**;Aug 13, 1993;Build 22
 ;     Last Edited: SHRPE/sgm - May 29, 2018 17:14
 ;
 ; ICR#  TYPE  DESCRIPTION
 ;-----  ----  ------------------------------------
 ; 2050  Sup   MSG^DIALOG
 ; 2055  Sup   $$EXTERNAL^DILFD
 ;
 ;This routine contains common prompts asked in various DGPF routines.
 ;DATA - checks to see if any assignments exist for a flag
 ;
 Q
 ;
CAT() ; ----- prompt for Category I, II, Both
 ; RETURN: -1 or 1^Catetory I (National)
 ;               2^Category II (Local)
 ;               3^Category I & II
 N X,Y,ANS,DGDIRA,DGDIRB,DGDIRH,DGDIRO
 S DGDIRA="Select Flag Category"
 S DGDIRB=""
 S DGDIRH="Enter one of the category selections to report on"
 S DGDIRO="S^1:Category I (National);2:Category II (Local);3:Both"
 S ANS=$$ANSWER^DGPFUT(DGDIRA,DGDIRB,DGDIRO,DGDIRH)
 S X="Category I (National)^Category II (Local)^Category I & II"
 S Y=$S(ANS<1:-1,1:ANS_U_$P(X,U,ANS))
 Q Y
 ;
DATA() ; ----- check for any flag assignment
 ;check for database for first assignment date
 N X S X=$P(+$O(^DGPF(26.14,"D","")),".") I X Q X
 S X="  >>> No Patient Record Flag Assignments have been found."
 N MSG S MSG("DIMSG",1)=X D DIALOG(,"MSG")
 Q $$E
 ;
DIALOG(FLAG,INPUT) ;
 ;  .INPUT - required - passed by reference
 N DTOUT,DUOUT
 S FLAG=$G(FLAG) S:FLAG="" FLAG="MW"
 I $G(INPUT)="" S INPUT="INPUT"
 D MSG^DIALOG(FLAG,,,,"INPUT")
 Q
 ;
E(MSG) ; ----- ask user to press enter to continue
 ;  Return: -2:Time-out; -1:'^'-out  1:anything else
 S MSG=$G(MSG)
 N X,Y,Z,DIR,DIROUT,DIRUT,DTOUT,DUOUT
 S DIR(0)="E"
 I $L(MSG) S DIR("A")=MSG
 D ^DIR
 S X=$S($D(DTOUT):-2,$D(DUOUT):-1,1:1)
 Q X
 ;
FLAG() ; ----- prompt for All or Select Flag
 ;       RETURN:  -1 or A:All Flags or S:Single Flag
 N X,Y,ANS,DGDIRA,DGDIRB,DGDIRH,DGDIRO
 S DGDIRA="Select to report on a (S)ingle flag or (A)ll flags"
 S DGDIRB="Single Flag"
 S DGDIRO="S^S:Single Flag;A:All Flags"
 S DGDIRH="Enter one of the flag selections to report on"
 S ANS=$$ANSWER^DGPFUT(DGDIRA,DGDIRB,DGDIRO,DGDIRH)
 I $L(ANS) S X=ANS_U_$S(ANS="S":"Single Flag",ANS="A":"All Flags",1:"")
 S Y=$S('$L(ANS):-1,"AS"'[ANS:-1,1:X)
 Q Y
 ;
ONEFLAG(CAT,VALID) ; ----- prompt for name of flag
 ;  INPUT PARAMETERS:
 ;      CAT - optional - I:National Flag   II:Local Flag
 ;                       default to I
 ;    VALID - optional - 1:verify at least one assignment
 ;                       0:do not verify any current assignments
 ;                       default to 1
 ;  RETURN:  -1  or
 ;            0 if no flag assignments found
 ;            variable_pointer^flagname
 ;
 N X,Y,ANS,DGDIRA,DGDIRB,DGDIRH,DGDIRO,DGFILE,FLAG,RET
 S CAT=$G(CAT) I CAT'="I",CAT'="II" S CAT="I"
 I CAT="I" S DGFILE=26.15
 I CAT="II" S DGFILE=26.11
 S VALID=$G(VALID) I VALID'=0,VALID'=1 S VALID=1
 S DGDIRA="Select Record Flag Name"
 S DGDIRB=""
 S DGDIRO="P^"_DGFILE_",.01:EMZ"
 S ANS=$$ANSWER^DGPFUT(DGDIRA,DGDIRB,DGDIRO)
 I ANS<1 Q -1
 S ANS=ANS_";DGPF("_DGFILE_","
 ;
 S FLAG=$$EXTERNAL^DILFD(26.13,.02,"F",ANS)
 S RET=ANS_U_FLAG
 I 'VALID Q RET
 ;
 ;   see if there is at least one assignment
 I $$ASGNCNT^DGPFLF6(ANS) Q RET
 ;
 W !,"  >>> No Patient Record Flag Assignments have been found."
 Q 0
 ;
OWNACT() ; -- prompt for local/not local ownership of assignment action
 ;   Use this for testing ^DD(26.14) ownership
 ;   RETURN: -1 or 1:Local Facility
 ;                 2:Other Facilities
 ;                 3:All Facilities
 N X,Y,ANS,DGDIRA,DGDIRB,DGDIRH,DGDIRO
 S DGDIRA="Select Ownership Type"
 S DGDIRB=""
 S DGDIRH="Local means this facility generated the PRF History action record"
 S DGDIRO="S^1:Local Facility Only;2:Other Facilities;3:All Facilities"
 S ANS=$$ANSWER^DGPFUT(DGDIRA,DGDIRB,DGDIRO,DGDIRH)
 S X="Local Facility^Other Facilities^All Facilities"
 S Y=$S(ANS<1:-1,1:ANS_U_$P(X,U,ANS))
 Q Y
 ;
OWNASGN() ; ----- prompt for local/not local ownership of assignment
 ;   Use for testing ^DD(26.13,.04) OWNER SITE
 ;   RETURN: -1 or 1:Local Facility
 ;                 2:Other Facilities
 ;                 3:All Facilities
 N X,Y,ANS,DGDIRA,DGDIRB,DGDIRH,DGDIRO
 S DGDIRA="Select Ownership Type"
 S DGDIRB=""
 S DGDIRH="Local means the PRF assignment is owned by this facility"
 S DGDIRO="S^1:Local Facility Only;2:Other Facilities;3:All Facilities"
 S ANS=$$ANSWER^DGPFUT(DGDIRA,DGDIRB,DGDIRO,DGDIRH)
 S X="Local Facility^Other Facilities^All Facilities"
 S Y=$S(ANS<1:-1,1:ANS_U_$P(X,U,ANS))
 Q Y
 ;
STATUS(BOTH) ; ----- prompt for assignment status
 ;   INPUT PARAMETER: Both - optional, default to 1
 ;                    1:include both as a choice; 0:do not include both
 ;   Used for asking ^DD(26.13,.03) STATUS
 ;   RETURN: -1 or 1^Active
 ;                 2:^Inactive
 ;                 3^Both Active & Inactive
 N X,Y,ANS,DGDIRA,DGDIRB,DGDIRH,DGDIRO
 S BOTH=$G(BOTH) I 10'[$E(BOTH) S BOTH=1
 S DGDIRA="Select Current Assignment Status"
 S DGDIRB=""
 S DGDIRH="Enter the current assignment Status to be in the report"
 S DGDIRO="S^1:Active;2:Inactive" S:BOTH DGDIRO=DGDIRO_";3:Both"
 S ANS=$$ANSWER^DGPFUT(DGDIRA,DGDIRB,DGDIRO,DGDIRH)
 S X="Active^Inactive^Both Active & Inactive"
 S Y=$S(ANS<1:-1,1:ANS_U_$P(X,U,ANS))
 Q Y
 ;
 ;    Prompts for Asking Date Range
START(BEG,END) ; ----- prompt for starting date
 ;  INPUT PARAMTERS:
 ;    BEG - optional - earliest date allowed
 ;    END - optional - latest   date allowed
 ;                     default to DT
 ;  RETURN: -1 or Fileman date
 N X,Y,ANS,DGDIRA,DGDIRB,DGDIRH,DGDIRO
 S DGDIRA="Select Beginning Date"
 S DGDIRB=""
 S DGDIRH="^D HELP^DGPFUT7(1)"
 S X=$G(BEG)_":"_$S(+$G(END):END,1:DT)
 S DGDIRO="D^"_X_":EX"
 S ANS=$$ANSWER^DGPFUT(DGDIRA,DGDIRB,DGDIRO,DGDIRH)
 S X=$S(ANS<1:-1,1:ANS)
 Q X
 ;
END(BEG,END) ; ----- prompt for ending date
 ;  INPUT PARAMTERS:
 ;    BEG - optional - earliest date allowed
 ;    END - optional - latest   date allowed
 ;                     default to DT
 ;  RETURN: -1 or Fileman date
 N X,Y,ANS,DGDIRA,DGDIRB,DGDIRH,DGDIRO
 S DGDIRA="Select Ending Date"
 S DGDIRB=""
 S DGDIRH="^D HELP^DGPFUT7(2)"
 S X=$G(BEG)_":"_$S(+$G(END):END,1:DT)
 S DGDIRO="D^"_X_":EX"
 S ANS=$$ANSWER^DGPFUT(DGDIRA,DGDIRB,DGDIRO,DGDIRH)
 S X=$S(ANS<1:-1,1:ANS)
 Q X
 ;
HELP(DGPF) ;provide extended DIR("?") help text.
 ;
 ;  Input: DGSEL - prompt var for help text word selection
 ; Output: none
 ;
 N A,T,MSG
 S DGPF=$G(DGPF) S:DGPF="" DGPF=1 S DGPF=(DGPF=1)
 S T=$P("latest^earliest",U,DGPF+1)
 S A="  Enter the "_T_" Assignment Date to include in the report."
 S MSG("DIMSG",1)=A
 S A="  Please enter a date from the specified date range displayed."
 S MSG("DIMSG",2)=A
 D DIALOG(,"MSG")
 Q
