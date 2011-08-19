MAGDAIRF ;WOIFO/PMK - Automatic Import Reconciliation Workflow ; 17 Nov 2009 7:31 AM
 ;;3.0;IMAGING;**53**;Mar 19, 2002;Build 1719;Apr 28, 2010
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
 ; Populate the OUTSIDE IMAGING LOCATION file (#2006.5759)
 ; This requires No Credit entries in the IMAGING LOCATIONS file (#79.1)
 ;
UPDATE ; update the OUTSIDE IMAGING LOCATION file
 S DTIME=$G(DTIME,300)
 N DIVISION ;------ INSTITUTION file #4 ien
 N IMAGETYPE ;----- IMAGE TYPE file #79.2 ien
 N NOCREDITLOCS ;-- array of IMAGING LOCATIONS with No Credit
 N RADIMGLOC ;----- Radiology IMAGING LOCATIONS file (file 79.1) pointer)
 N ERROR,I,N,X,Y
 S ERROR=$$DISPLAY^MAGDAIRG(1,.NOCREDITLOCS)
 Q:ERROR=-1  ; missing "No Credit" imaging location(s)
 S DIVISION=0
 F  S DIVISION=$O(NOCREDITLOCS(DIVISION)) Q:'DIVISION  D
 . W !!!,"OUTSIDE IMAGING LOCATIONS for ",$$GET1^DIQ(4,DIVISION,.01)
 . W " (",$$GET1^DIQ(4,DIVISION,99),")" S N=$X
 . W ! F I=1:1:N W "-"
 . S IMAGETYPE=""
 . F  S IMAGETYPE=$O(NOCREDITLOCS(DIVISION,IMAGETYPE)) Q:'IMAGETYPE  D
 . . K RADIMGLOC S RADIMGLOC=""
 . . F  S RADIMGLOC=$O(NOCREDITLOCS(DIVISION,IMAGETYPE,RADIMGLOC)) Q:RADIMGLOC=""  D
 . . . S RADIMGLOC(0)=$G(RADIMGLOC(0))+1,RADIMGLOC(RADIMGLOC(0))=RADIMGLOC
 . . . Q
 . . D SELECT(DIVISION,IMAGETYPE,.RADIMGLOC) W !
 . . Q
 . Q
 Q
 ;
SELECT(DIVISION,IMAGETYPE,RADIMGLOC) ; pick IMAGING LOCATION
 N OUTSIDE ; ------ OUTSIDE IMAGING LOCATIONS file #2006.5759 ien
 N ABORT,CHOICE,I,OPTION,PROMPT,QUIT,X
 W !,$$GET1^DIQ(79.2,IMAGETYPE,.01)," -- "
 S OUTSIDE=$O(^MAGD(2006.5759,"D",DIVISION,IMAGETYPE,""))
 I $O(^MAGD(2006.5759,"D",DIVISION,IMAGETYPE,OUTSIDE)) D  Q:ABORT
 . N X
 . S X=$X
 . W "*** Redundant records found! ***"
 . S I="" F  S I=$O(^MAGD(2006.5759,"D",DIVISION,IMAGETYPE,I)) Q:'I  D
 . . W !,?X,$$GET1^DIQ(2006.5759,I,.01)
 . . Q
 . W !,?X,"*** These must be deleted and replace by a single entry ***"
 . S PROMPT="Proceed",ABORT=1
 . S X=$$YESNO(PROMPT,"y",.CHOICE) Q:X<0
 . I "Nn"[$E(CHOICE) Q
 . S I="" F  S I=$O(^MAGD(2006.5759,"D",DIVISION,IMAGETYPE,I)) Q:'I  D
 . . D KILL(I) ; remove each entry
 . . Q 
 . S (ABORT,OUTSIDE)=0
 . Q
 I OUTSIDE D  Q:QUIT
 . S QUIT=1
 . W $$GET1^DIQ(2006.5759,OUTSIDE,.01)
 . S PROMPT="Change it"
 . S X=$$YESNO(PROMPT,"n",.CHOICE) Q:X<0
 . I "Nn"[$E(CHOICE) Q
 . D KILL(OUTSIDE)
 . S QUIT=0 ; this will force a drop though to reset the node
 . Q
 E  W "(not defined yet)"
 F I=1:1:RADIMGLOC(0) D
 . S OPTION(I)=$S(RADIMGLOC(0)>1:I_":",1:"")
 . S OPTION(I)=OPTION(I)_$$GET1^DIQ(79.1,RADIMGLOC(I),.01)
 . Q
 I RADIMGLOC(0)>1 D
 . S X=$$CHOOSE("Select location",,.CHOICE,.OPTION) Q:X<0
 . D SET(DIVISION,IMAGETYPE,RADIMGLOC(+CHOICE))
 . Q
 E  D
 . S PROMPT(1)=OPTION(1)
 . S PROMPT="Use this value?"
 . S X=$$YESNO(.PROMPT,"n",.CHOICE) Q:X<0
 . I "Nn"[$E(CHOICE) Q
 . D SET(DIVISION,IMAGETYPE,RADIMGLOC(1))
 . Q
 Q
 ;
SET(DIVISION,IMAGETYPE,RADIMGLOC) ; create the OUTSIDE IMAGING LOCATION fle (#2006.5759) entry
 N DIERR,IENS,MAGERR,MAGFDA,MAGIENS,SC44IEN
 ;
 ; check to see if it already exists
 S MAGIENS=$O(^MAGD(2006.5759,"B",RADIMGLOC,"")) Q:MAGIENS MAGIENS
 ;
 S SC44IEN=$$GET1^DIQ(79.1,RADIMGLOC,.01,"I")
 ;
 S IENS="+1,"
 S MAGFDA(2006.5759,IENS,.01)=RADIMGLOC    ; IMAGING LOCATION
 S MAGFDA(2006.5759,IENS,2)=IMAGETYPE      ; IMAGING TYPE
 S MAGFDA(2006.5759,IENS,3)=SC44IEN        ; HOSPITAL LOCATION
 S MAGFDA(2006.5759,IENS,4)=DIVISION       ; INSTITUTION
 D UPDATE^DIE("","MAGFDA","MAGIENS","MAGERR")
 I $D(DIERR) Q "-3 Entry not created in OUTSIDE IMAGING LOCATION file (#2006.5759)"
 Q MAGIENS(1)
 ;
KILL(OUTSIDE) ; delete the file 2006.5759 entry
 N DA,DIK
 S DIK="^MAGD(2006.5759,",DA=OUTSIDE
 D ^DIK
 Q
 ;
YESNO(PROMPT,DEFAULT,CHOICE) ; generic YES/NO question driver
 N DIR,DIRUT,DIROUT,X,Y
 S DIR(0)="Y" S DIR("A")=PROMPT M DIR("A")=PROMPT
 I $G(DEFAULT)'="" S DIR("B")=DEFAULT
 D ^DIR
 I $D(DIROUT) Q -2
 I $D(DIRUT) Q -1
 S CHOICE=Y(0)
 Q 1
 ;
CHOOSE(PROMPT,DEFAULT,CHOICE,OPTION) ; generic question driver
 N DIR,DIRUT,DIROUT,I,X,Y
 S DIR(0)="S^",I=0
 F  S I=$O(OPTION(I)) Q:'I  D
 . S DIR(0)=DIR(0)_$S(I>1:";",1:"")_OPTION(I)
 . Q
 S DIR("A")=PROMPT
 I $G(DEFAULT)'="" S DIR("B")=DEFAULT
 D ^DIR
 I $D(DIROUT) Q -2
 I $D(DIRUT) Q -1
 S CHOICE=Y
 Q 1
