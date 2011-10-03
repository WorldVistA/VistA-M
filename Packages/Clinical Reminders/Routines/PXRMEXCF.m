PXRMEXCF ; SLC/PKR - Reminder exchange routines for computed findings. ;10/17/2008
 ;;2.0;CLINICAL REMINDERS;**6,12**;Feb 04, 2005;Build 73
 ;==============================================
EXISTS(ROUTINE) ;Return true if routine ROUTINE exists.
 I ROUTINE="" Q 0
 N RTN
 S RTN="^"_ROUTINE
 Q $S($T(@RTN)'="":1,1:0)
 ;
 ;==============================================
GETRACT(ATTR,NEWNAME,NAMECHG,RTN,EXISTS) ;Get the action for a routine.
 N ACTION,CHOICES,CSUM,DIR,DIROUT,DIRUT,DTOUT,DUOUT,ECS,IND,MSG
 N PCS,ROUTINE,SAME,TEXT,X,Y
 S NEWNAME=""
 S ROUTINE=ATTR("NAME")
 I EXISTS="" S EXISTS=$$EXISTS^PXRMEXCF(ROUTINE)
 S CHOICES=$S(EXISTS:"COQS",1:"CIQS")
 I EXISTS D
 .;If the routine exists compare the existing routine checksum with the
 .;the checksum of the routine in the packed definition.
 . S CSUM=$$RTNCS^PXRMEXCS(ROUTINE)
 . S SAME=$S(ATTR("CHECKSUM")=CSUM:1,1:0)
 . S TEXT(1)="Routine "_ROUTINE_" already exists "
 . I SAME D
 .. S TEXT(1)=TEXT(1)_"and the packed routine is identical, skipping."
 .. I $D(PXRMDEBG) W !,TEXT(1),! H 2
 .. S ACTION="S"
 . I 'SAME D
 .. S TEXT(1)=TEXT(1)_"but the packed routine is different,"
 .. S TEXT(2)="what do you want to do?"
 .. W !,TEXT(1),!,TEXT(2)
 .. S DIR("B")="O"
 .. S ACTION=$$GETACT^PXRMEXIU(CHOICES,.DIR)
 E  D
 . W !!,"Routine "_ROUTINE_" is new, what do you want to do?"
 . S DIR("B")="I"
 . S ACTION=$$GETACT^PXRMEXIU(CHOICES,.DIR)
 ;
 I (ACTION="Q")!(ACTION="S") Q ACTION
 ;
 I ACTION="C" D
 . N CDONE
 . S CDONE=0
 . F  Q:CDONE  D
 .. S NEWNAME=$$GETNAME^PXRMEXIU(ATTR("MIN FIELD LENGTH"),ATTR("FIELD LENGTH"))
 .. I NEWNAME="" S ACTION="S",CDONE=1 Q
 .. S EXISTS=$$EXISTS^PXRMEXCF(NEWNAME)
 .. I EXISTS W !,"Routine ",NEWNAME," already exists, try again."
 .. E  D  Q
 ... S CDONE=1
 ... S NAMECHG(ATTR("FILE NUMBER"),ROUTINE)=NEWNAME
 ;
 I (ACTION="I")&(EXISTS) D
 .;If the action is overwrite double check that overwrite is what the
 .;user really wants to do.
 . K DIR
 . S DIR(0)="Y"_U_"A"
 . S DIR("A")="Are you sure you want to overwrite"
 . S DIR("B")="N"
 . D ^DIR
 . I $D(DIROUT)!$D(DIRUT) S Y=0
 . I $D(DTOUT)!$D(DUOUT) S Y=0
 . I 'Y S ACTION="S"
 . S NAMECHG(ATTR("FILE NUMBER"),ROUTINE)=NEWNAME
 Q ACTION
 ;
