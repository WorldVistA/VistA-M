DGPFUT64 ;SHRPE/SGM - FLAG UTILITIES ; Aug 17, 2018 09:30
 ;;5.3;Registration;**951**;Aug 13, 1993;Build 135
 ;     Last Edited: SHRPE/SGM - Aug 22, 2018 17:50
 ;
 ; This routine is to be invoked ONLY from ^DGPFUT6
 ;
 ; ICR#  TYPE  DESCRIPTION
 ;-----  ----  ------------------------------------
 ; 2051  Sup   $$FIND1^DIC
 ; 2056  Sup   $$GET1^DIQ
 ;10006  Sup   ^DIC
 ;
 ;=====================================================================
FLAG(DGPFIN,SCR,TYPE) ;
 ; Does flag name and flag variable pointer match?
 ; INPUT PARAMETERS:
 ;   DGPFIN - required - flag full name or variable-pointer syntax
 ;      SCR - required - flag name to use as a screen if DGPFIN is
 ;                       var-pointer
 ;     TYPE - optional - I:only return Cat I values
 ;                      II:only return Cat II values
 ;               null or 0:return either Cat I or Cat II  
 ; EXTRINSIC FUNCTION returns 0 or variable_pointer^flag_name
 ;
 I $G(SCR)="" Q 0
 N X,Y
 S X=$$FLAGCVRT(,$G(DGPFIN),$G(TYPE))
 S Y=$S(X=0:0,$P(X,U,2)=SCR:X,1:0)
 Q Y
 ;
 ;=====================================================================
FLAGCVRT(DGRET,VAL,TYPE) ;
 ;Convert flag name to variable pointer / variable pointer to flag name
 ;INPUT PARAMETERS:
 ;   TYPE - optional -  I:only return Cat I values
 ;                     II:only return Cat II values
 ;              null or 0:return either Cat I or Cat II   
 ;    VAL - required - flag name or variable pointer syntax
 ;
 ;EXTRINSIC FUNCTION and RETURN PARAMETER DGRET returns:
 ;   0 if no matches or error encountered
 ;   else variable_pointer ^ name of flag
 ;   This expects that there are not multiple flags with the same name
 ;
 N X,ERR,FLGX,NAME,PTR,ROOT
 S ERR=0
 S FLGX=$P($G(VAL),U) I FLGX="" Q 0
 S FLGX(1)=0 ;  extrinsic function return value
 S TYPE=$G(TYPE)
 I TYPE="",FLGX["26.15," S TYPE="I"
 I TYPE="",FLGX["26.11," S TYPE="II"
 I $L(TYPE),TYPE'="I",TYPE'="II" S TYPE=""
 S (NAME,PTR,ROOT)=""
 I FLGX'["(26.1" S NAME=FLGX
 E  D  I ERR Q 0
 . N X,Y,GL
 . S Y=$P(FLGX,";"),GL=$P(FLGX,";",2)
 . I Y'=+Y S ERR=1 Q
 . I (GL'="DGPF(26.11,"),(GL'="DGPF(26.15,") S ERR=1 Q
 . S PTR=Y,ROOT=GL
 . Q
 I PTR D
 . N X,Y,DGERR,DIERR,FILE,IENS
 . S FILE=$P($P(ROOT,"(",2),",")
 . S IENS=PTR_","
 . S Y=$$GET1^DIQ(FILE,IENS,.01,,,"DGERR")
 . I '$D(DIERR),$L(Y) S FLGX(1)=FLGX_U_Y
 . Q
 I $L(NAME) D
 . N X,Y,DGERR,DIERR,FLAG
 . I TYPE'="II" D
 . . S Y=$$FIND1^DIC(26.15,,"QX",FLGX,"B",,"DGERR")
 . . I '$D(DIERR),Y>0 S FLGX("I")=Y_";DGPF(26.15,"_U_NAME
 . . Q
 . I TYPE'="I" D
 . . S Y=$$FIND1^DIC(26.11,,"QX",FLGX,"B",,"DGERR")
 . . I '$D(DIERR),Y>0 S FLGX("II")=Y_"DGPF(26.11,"_U_NAME
 . . Q
 . I $D(FLGX("I")),'$D(FLGX("II")) S FLGX(1)=FLGX("I")
 . I $D(FLGX("II")),'$D(FLGX("I")) S FLGX(1)=FLGX("II")
 . Q
 S DGRET=FLGX(1)
 Q:$Q DGRET
 Q
 ;
 ;=====================================================================
SELASGN(DGSCR,FLG) ;
 ;  select an existing assignment from from 26.13
 ;INPUT PARAMETER: DGSCR - optional - ^DIC input parameter DIC("S")
 ;                 FLG   - optional. if "Z" then return zeroth node as
 ;                                   second and subsequent "^"-pieces 
 ;EXTRINSIC FUNCTION: ien or ien[^zeroth node] or 0 or -1
 ;
 N X,Y,DA,DIC,DTOUT,DUOUT,XQY0
 S DIC=26.13,DIC(0)="QAEMZ"
 S DIC("A")="Select PATIENT: "
 S DGSCR=$G(DGSCR) I $L(DGSCR) D
 . N BEH
 . I DGSCR'="BEH" S DIC("S")=DGSCR Q
 . S BEH=$$FLAGCVRT(,"BEHAVIORAL","I")
 . I BEH>0 S DIC("S")="I $P(^(0),U,2)="_$C(34)_$P(BEH,U)_$C(34)
 . Q
 S X="Select a Patient Record Flag Assignment"
 S:DGSCR="BEH" X="Select Patient who has a BEHAVIORAL flag assigned."
 W !!,X
 D ^DIC
 I Y>0 S X=+Y S:$G(FLG)="Z" X=X_U_Y(0) S Y=X
 Q $S($D(DTOUT):-1,Y>0:Y,1:0)
