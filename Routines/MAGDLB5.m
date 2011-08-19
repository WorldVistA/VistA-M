MAGDLB5 ;WOIFO/LB - XREF code for DICOM ; 02/17/2004  07:18
 ;;3.0;IMAGING;**11**;14-April-2004
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
MOVE ;Called from MAGDIR1 to move the failed entry into file 2006.575
 ;(Waiting for Peter's code to use FM instead of Direct sets.)
 N CASECD,CNT,DA,DR,DIC,REASON,X,Y S CNT=0
 I '$D(FROMPATH) W !,"FROMPATH is missing" Q
 Q:'$D(FROMPATH)     ;This variable should be around when called
 S X=FROMPATH,DIC="^MAGD(2006.575," D FILE^DICN
 I Y<1 W !,"Couldn't add an entry in file ^MAG(2006.575" Q
 S REASON=$P(PIDCHECK,",",2)
 S CASECD=$TR(CASECODE,"^","~")
 S DA=+Y,DR="[MAGD-ENTRY]",DIE=DIC
ADD ;
 L +^MAGD(2006.575,DA) I $T D ^DIE L -^MAGD(2006.575,DA) Q
 S CNT=CNT+1 H 2 G:CNT<3 ADD   ;HANG 2 SECS AND TRY TWICE
 W !,"Couldn't update the MAGD(2006.575 file."
 Q
REMOVE(ENTRY) ;Called to delete entry once processed.
 N DA,DIK
 Q:'$D(ENTRY)
 I 'ENTRY W !,"ENTRY variable is missing" Q
 Q:'$D(^MAGD(2006.575,ENTRY,0))     ;MISSING ENTRY
 ;I '$P($G(^MAGD(2006.575,ENTRY,"FIXD")),"^") W !,"Entry has not been corrected." Q
 S DA=+ENTRY,DIK="^MAGD(2006.575," D ^DIK
 Q
UPDT(ENTRY) ;Called to update entry.
 Q:'$D(ENTRY)!'ENTRY
 Q:'$D(^MAGD(2006.575,ENTRY,0))
 N DIE,DR,DA,DIC,GWLOC,MACHID
 S DIE="^MAGD(2006.575,",DR="[MAGD-UPDT]"
 S DA=ENTRY
 D ^DIE
 I '$L(^MAGD(2006.575,ENTRY,"FIXD")) W !,"Entry not updated" Q
 S MACHID=$P(^MAGD(2006.575,ENTRY,1),"^",4),GWLOC=$P(^(1),"^",5)
 I GWLOC D  Q
 . S ^MAGD(2006.575,"AFX",GWLOC,MACHID,ENTRY)=""
 . Q
 E  S ^MAGD(2006.575,"AFX",MACHID,ENTRY)=""
 Q
