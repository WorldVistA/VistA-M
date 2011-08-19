TIULRR ; SLC/JM - Restricted Record Library functions ;7/17/01
 ;;1.0;TEXT INTEGRATION UTILITIES;**58,121**;Jun 20, 1997
 ;
 Q
 ;
INITRR(ASKONCE) ; Initializes Restricted Record List
 ; If ASKONCE is true, calls to PTRES will only ask once for any given
 ; patient.  If they answer no it will not ask again.  If ASKONCE is
 ; false, it will continue to ask on the same patient until they 
 ; answer Yes (used when called from list manager)
 N MSG
 S MSG=$S('($D(DUZ)#2):"user code",'$D(^VA(200,DUZ,0)):"user name",1:"")
 I MSG'="" D  Q
 .K TIURRECL
 .I $D(VALMAR) D FULL^VALM1
 .W !!?2,"Your ",MSG," is undefined. This must be defined to access"
 .W !?2,"patient information.",!
 I $G(TIURRECL("DUZ"))'=DUZ D  ;DUZ has changed - start over
 .K TIURRECL
 .S TIURRECL("DUZ")=DUZ
 S TIURRECL("RCNT")=+$G(TIURRECL("RCNT"))+1
 I TIURRECL("RCNT")=1 D  ; First reference call
 .S TIURRECL=0
 .I +$G(ASKONCE) S TIURRECL("ONCE")="X"
 Q
 ;
KILLRR ; Kills the Restricted Record List
 I '$D(TIURRECL) Q
 S TIURRECL("RCNT")=+$G(TIURRECL("RCNT"))-1
 I +TIURRECL("RCNT")<1 K TIURRECL
 Q
 ;
DOCRES(TIUDA)   ; Evaluate Restricted Record for a specific Document
 N TIUY,TIUD0 S TIUY=0
 S TIUD0=$G(^TIU(8925,TIUDA,0)) G:+$P(TIUD0,U,2)'>0 DOCRESX
 S TIUY=$$PTRES(+$P(TIUD0,U,2))
DOCRESX Q TIUY
PTRES(DFN) ; Returns TRUE if patient is restricted 
 I '$D(TIURRECL) Q 0 ; Does not function if INITRR has not been called
 N TIUBAD
 S TIUBAD=0
 I +$$GET1^DIQ(38.1,+$G(DFN),2,"I") D
 .N DOCHECK
 .S TIUBAD=1,DOCHECK=1
 .I TIURRECL>0 D
 ..N I,IDX,SRCH,DONE
 ..S SRCH=U_DFN_"=",DONE=0
 ..F I=1:1:TIURRECL D  Q:DONE
 ...S IDX=$F(TIURRECL(I),SRCH)
 ...I IDX D
 ....S DONE=1,DOCHECK=0
 ....I $D(TIURRECL("ONCE")) S TIUBAD=+$E(TIURRECL(I),IDX)
 ....E  S TIUBAD=0
 .I DOCHECK D
 ..I $D(VALMAR) D FULL^VALM1
 ..N Y,DTOUT,DUOUT,DOADD
 ..S Y=$$CHECK(DFN)
 ..I ($D(DTOUT))!($D(DUOUT)) S DOADD=0
 ..E  D
 ...I Y'=-1 S TIUBAD=0
 ...S DOADD=(Y'=-1)!($D(TIURRECL("ONCE")))
 ..I DOADD D
 ...N ADD
 ...S ADD=0
 ...I TIURRECL=0 S ADD=1
 ...E  I $L(TIURRECL(TIURRECL))>200 S ADD=1
 ...I ADD S TIURRECL=TIURRECL+1,TIURRECL(TIURRECL)=U
 ...S TIURRECL(TIURRECL)=TIURRECL(TIURRECL)_DFN_"="_TIUBAD_U
 Q TIUBAD
DOCCHK(TIUDA)   ; Wrap CHECK
 Q +$$CHECK($P($G(^TIU(8925,TIUDA,0)),U,2))
CHECK(DFN)      ; call ^DIC to execute check
 N DIC,X,Y
 S DIC=2,X="`"_DFN,DIC(0)="E"
 W !! D ^DIC
 Q Y
