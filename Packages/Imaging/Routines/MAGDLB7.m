MAGDLB7 ;WOIFO/LB - Utilities for file 2006.575 ; [ 06/20/2001 08:56 ]
 ;;3.0;IMAGING;;Mar 01, 2002
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
REINDXF ;Reindex field 9 - Unique Study Identifications
 N DIK
 S DIK="^MAGD(2006.575,",DIK(1)="9"
 D ENALL^DIK
 Q
EN ;
 N DIR,DDAY,X,Y,DOUT,DROUT,NOWDAY
 W !,"Will re-index field 9, Unique Study Id."
 D REINDXF
 I '$D(^MAGD(2006.575,"F")) W !,"Nothing to process" Q
 D NOW^%DTC S NOWDAY=X
 W !,"Entries will be delete up to the date you specify."
EN1 ;restart point
 S DIR(0)="DA",DIR("A")="Last date to keep."
 S DIR("?")="Enter a date."
 D ^DIR I 'Y!(Y="^") W !,"No date entered. Quitting." Q
 S DDAY=Y I NOWDAY=DDAY W !,"Can not be today." G EN1
 D PURGE
 Q
PURGE ;
 N DATEPROC,IEN,NIEN,ITEM,SUID
 S IEN=0,SUID="" F  S SUID=$O(^MAGD(2006.575,"F",SUID)) W !,SUID Q:SUID=""  D
 . F  S IEN=$O(^MAGD(2006.575,"F",SUID,IEN)) W !,IEN Q:'IEN  D
 . . I '$D(^MAGD(2006.575,IEN,0)) D  Q
 . . . K ^MAGD(2006.575,"F",SUID,IEN)    ;Tidy up.
 . . S DATEPROC=$P(^MAGD(2006.575,IEN,1),"^",3)
 . . I DATEPROC>DDAY Q
 . . I $D(^MAGD(2006.575,IEN,"RLATE")) D
 . . . ;start purging the related entries 1st before the parent entry
 . . . S NIEN=0 F  S NIEN=$O(^MAGD(2006.575,IEN,"RLATE",NIEN)) Q:'NIEN  D
 . . . . Q:'$D(^MAGD(2006.575,IEN,"RLATE",NIEN,0))
 . . . . S ITEM=$P(^MAGD(2006.575,IEN,"RLATE",NIEN,0),"^") Q:'ITEM
 . . . . D REMOVE^MAGDLB5(ITEM) W "."
 . . D REMOVE^MAGDLB5(IEN) W "."
 W !,"Finished."
 Q
