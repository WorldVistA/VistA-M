PXCEVFI5 ;ISL/dee - Check to see if the encounter is a standalone and if it needs to be deleted ;3/17/04 12:24pm
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**14,99,124**;Aug 12, 1996
 ;
 Q
CHECK ;Check to see if this is a standalone and if it is make sure it has
 ;  a procedure or stop code.  If it does not have either then allow the
 ;  user to continueing edit it or delete the encounter.
 ;Also check that if there are diagnosis for the encounter that one of
 ;  them is primary.
 ;
 ;Quit if no visit ien
 I '$D(^AUPNVSIT(PXCEVIEN)) S PXCEEXIT=1 Q
 N PXCEVST0,PXCEPDX,PXCEAPPT
 S PXCEVST0=^AUPNVSIT(PXCEVIEN,0)
 ;Quit if Historical visit
 I $P(PXCEVST0,"^",7)="E" S PXCEEXIT=1 Q
 ;Get primary Dx if one
 I '$D(^AUPNVPOV("AD",PXCEVIEN)) S PXCEPDX=-1 ;no Dx so do not need a primary one
 E  S PXCEPDX=$$PRIMVPOV^PXUTL1(PXCEVIEN)
 ;Get if there is an appointment
 S PXCEAPPT=$$VSTAPPT^PXUTL1(PXCEPAT,+PXCEVST0,$P(PXCEVST0,"^",22),PXCEVIEN)
 ;Quit if there is an appointment and primary Dx
 I PXCEPDX,PXCEAPPT S PXCEEXIT=1 Q
 ;Quit if there are procedures or stop codes and a primary Dx
 ;DROP PROCEDURE CHECK
 S PXCEEXIT=1 Q
 ;
 I PXCEPDX,$D(^AUPNVCPT("AD",PXCEVIEN))!($D(^AUPNVSIT("AD",PXCEVIEN))) S PXCEEXIT=1 Q
 N DIR,X,Y,PXCECNT
 S DIR("B")="NO"
 S DIR(0)="Y"
 S PXCECNT=1
 I 'PXCEPDX D
 . S DIR("A",PXCECNT)="None of the diagnosis for this encounter are Primary."
 . S PXCECNT=PXCECNT+1
 I 'PXCEAPPT,'$D(^AUPNVCPT("AD",PXCEVIEN)),'$D(^AUPNVSIT("AD",PXCEVIEN)) D
 . I $G(PXQUIT) D  Q
 .. N DIR
 .. S DIR(0)="FOA"
 .. S DIR("A",1)="This encounter does not have a procedure, it will be DELETED."
 .. S DIR("A")="Press any key to continue: "
 .. D ^DIR
 .. I $$DELVFILE^PXAPI("ALL",PXCEVIEN)
 . S DIR("A",PXCECNT)="This encounter must have a procedure."
 . S PXCECNT=PXCECNT+1
 . S DIR("A",PXCECNT)="It will be deleted if a procedure is not added."
 . S PXCECNT=PXCECNT+1
 . S DIR("A")="Delete this encounter"
 . D ^DIR
 . I Y=1 D
 .. I $$DELVFILE^PXAPI("ALL",PXCEVIEN)
 .. S PXCEEXIT=1
 . E  S PXCEEXIT=0
 E  D
 . S DIR("A")="Quit anyway"
 . D ^DIR
 . I Y=0 S PXCEEXIT=0
 . E  S PXCEEXIT=1
 Q
 ;
