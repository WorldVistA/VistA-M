MAGDLBSR ;WOIFO/LB,MLH - Sort/print for 2006.575 ; 01/30/2004  17:11
 ;;3.0;IMAGING;**10,11**;14-April-2004
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; |                                                               |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 Q
SRT ;Sort the file first by the patient name but only the unique entries.
 ;The "F" cross reference uses the study uid number and gateway site.
 N MAGSUID,MAGIEN,MAGPT
 N GWLOC ; -- gateway site number
 N KFIXALL ; -- does user hold MAGDFIX ALL security key?
 N MAGTYPE ; -- type of image (rad/med/clinspec)
 ;
 S KFIXALL=$$SECKEY^MAGDLB12
 Q:'$D(^MAGD(2006.575,"F"))    ;nothing to sort
 K ^MAGD(2006.575,"D")
 S GWLOC=""
 F  S GWLOC=$O(^MAGD(2006.575,"F",GWLOC)) Q:GWLOC=""  D
 . ; if this isn't the user's site, bail unless the user holds the
 . ; MAGDFIX ALL security key
 . I GWLOC'=DUZ(2),'KFIXALL Q
 . S MAGSUID=""
 . F  S MAGSUID=$O(^MAGD(2006.575,"F",GWLOC,MAGSUID)) Q:MAGSUID=""  D
 . . S MAGIEN=0
 . . F  S MAGIEN=$O(^MAGD(2006.575,"F",GWLOC,MAGSUID,MAGIEN)) Q:'MAGIEN  D
 . . . ; if no main failed image rec, there's a xref prob, so bail
 . . . I '$D(^MAGD(2006.575,MAGIEN,0)) D  Q  ; clean up xref
 . . . . K ^MAGD(2006.575,"F",GWLOC,MAGSUID,MAGIEN)
 . . . . Q
 . . . ; If entry has been corrected, do not include in sort
 . . . I $D(^MAGD(2006.575,MAGIEN,"FIXD")),$P(^("FIXD"),"^") Q
 . . . ;Only radiology images!
 . . . I $P($G(^MAGD(2006.575,MAGIEN,"TYPE")),U)'="RAD" Q
 . . . S MAGPT=$P(^MAGD(2006.575,MAGIEN,0),"^",4)
 . . . S ^MAGD(2006.575,"D",MAGPT,MAGIEN)=""
 . . . Q
 . . Q
 . Q
 Q
SRTDT ;Provide sorting by date entry but only if NOT fixed and by unique suid
 N MAGSUID,MAGIEN,MAGDT
 N KFIXALL ; -- does user hold MAGDFIX ALL security key?
 N GWLOC ; -- gateway site number
 ;
 S KFIXALL=$$SECKEY^MAGDLB12
 Q:'$D(^MAGD(2006.575,"F"))
 K ^MAGD(2006.575,"AD")
 S GWLOC=""
 F  S GWLOC=$O(^MAGD(2006.575,"F",GWLOC)) Q:'GWLOC  D
 . ; if this isn't the user's site, bail unless the user holds the
 . ; MAGDFIX ALL security key
 . I GWLOC'=DUZ(2),'KFIXALL Q
 . S MAGSUID=""
 . F  S MAGSUID=$O(^MAGD(2006.575,"F",GWLOC,MAGSUID)) Q:MAGSUID=""  D
 . . S MAGIEN=0
 . . F  S MAGIEN=$O(^MAGD(2006.575,"F",GWLOC,MAGSUID,MAGIEN)) Q:'MAGIEN  D
 . . . ; if no main failed image rec, there's a xref prob, so bail
 . . . I '$D(^MAGD(2006.575,MAGIEN,0)) D  Q  ; CLEAN UP XREF
 . . . . K ^MAGD(2006.575,"F",GWLOC,MAGSUID,MAGIEN)
 . . . . Q
 . . . ; If entry has been corrected, do not include in sort
 . . . I $D(^MAGD(2006.575,MAGIEN,"FIXD")),$P(^("FIXD"),"^") Q
 . . . ;Only radiology images!
 . . . I $P($G(^MAGD(2006.575,MAGIEN,"TYPE")),U)'="RAD" Q
 . . . Q:'$D(^MAGD(2006.575,MAGIEN,1))
 . . . S MAGDT=$P(^MAGD(2006.575,MAGIEN,1),"^",3)
 . . . S ^MAGD(2006.575,"AD",MAGDT,MAGIEN)=""
 . . . Q
 . . Q
 . Q
 Q
PRTDT(SORT,START,STOP) ;
 ;Print entries using the "AD" cross reference (date order)
 ; OR the "F" cross reference (unique study uid)
 I '$D(DUZ) W !,"DUZ variable not defined." Q
 I "DF"'[SORT Q  ;only the date or unique suid
 N DIC,BY,FLDS,L,FR,TO
 ;I 'STOP!'START Q
 S L(0)=2
 I SORT="D" S SORT="AD" D
 . I $L($G(START))>1,$L($G(STOP))>1 S FR(0,1)=START,TO(0,1)=STOP
 S DIC="^MAGD(2006.575,",BY(0)="^MAGD(2006.575,"""_SORT_""","
 S FLDS="[MAG FAILED IMAGES]",L=0
 D EN1^DIP
 Q
ADATE() ;date
 N DIR,X,Y
 S DIR(0)="DU",DIR("A")=$G(MESSAGE) D ^DIR
 Q Y
ASKDT ;Ask date range
 N MESSAGE
 S MESSAGE="Enter start date" S STR=$$ADATE
 I '$D(DTOUT),'$D(DUOUT)
 E  K STR,STP Q
 Q:'STR
 I STR'?7N W "Wrong date format." Q
 S MESSAGE="Enter stop date" S STP=$$ADATE
 I '$D(DTOUT),'$D(DUOUT)
 E  K STR,STP Q
 I STP'?7N W "Wrong date format." Q
 Q
PRNT ;
 N DIR,X,Y,BY
 S DIR(0)="S^D:Date;F:Unique Entries"
 D ^DIR
 Q:"DF"'[Y
 I Y="D" D  Q:'$D(STR)!'$D(STP) 
 . D ASKDT Q:'$D(STR)!'$D(STP)
 . W !,"Please hold sorting by Date. " D SRTDT
 S BY=Y K DIR,X,Y,DTOUT,DIRUT,DTOUT
 D PRTDT(BY,$G(STR),$G(STP))
 K BY,STR,STP
 Q
