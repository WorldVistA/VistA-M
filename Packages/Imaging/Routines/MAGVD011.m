MAGVD011 ;WOIFO/NST - Work item deletion utility ; OCT 24, 2018@1:42PM
 ;;3.0;IMAGING;**201**;Dec 02, 2009;Build 163
 ;;Per VHA Directive 2004-038, this routine should not be modified.
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
 ;
DELWIDTS ; Delete work items in date range by work item TYPE and SUBTYPE
 ;
 N DIR,X,Y,MAGDATE,MAGFDATE,MAGTDATE,MAGIEN,MAGOUT,MAGTYPE,MAGSUB
 ;
 ; Get from date
 S DIR(0)="D^::EP",DIR("A")="Enter from date"
 S DIR("?")="Enter a date."
 D ^DIR
 I 'Y!(Y="^") Q
 S MAGFDATE=Y\1
 ;
 ; Get through date
 K X,Y
 S DIR(0)="D^::EP",DIR("A")="Enter through date"
 S DIR("?")="Enter a date."
 D ^DIR
 I 'Y!(Y="^") Q
 S MAGTDATE=Y\1
 ;
 ; Get Type
 K X,Y
 S DIR(0)="P^2006.9412:E",DIR("A")="Select work item type"
 S DIR("?")="Enter a work item type."
 D ^DIR
 I 'Y!(Y="^") Q
 S MAGTYPE=$P(Y,"^",1)
 ;
 ; Get Subtype
 K X,Y
 S DIR(0)="P^2006.9414:E",DIR("A")="Select work item subtype"
 S DIR("?")="Enter a work item subtype."
 D ^DIR
 I 'Y!(Y="^") Q
 S MAGSUB=$P(Y,"^",1)
 ;
 ; Confirm deletion
 K X,Y
 S DIR(0)="Y",DIR("A")="ARE YOU SURE YOU WANT TO DELETE WORK ITEMS"
 S DIR("B")="NO"
 D ^DIR
 I 'Y D EN^DDIOL("Deletion Canceled. Work items were not deleted.","","!!") Q
 ;
 S MAGDATE=MAGFDATE-.0000001
 S MAGIEN=0
 F  S MAGDATE=$O(^MAGV(2006.941,"B",MAGDATE)) Q:'MAGDATE!((MAGDATE\1)>MAGTDATE)  D
 . F  S MAGIEN=$O(^MAGV(2006.941,"B",MAGDATE,MAGIEN)) Q:'MAGIEN  D
 . . Q:$$GET1^DIQ(2006.941,MAGIEN,1,"I")'=MAGTYPE
 . . Q:$$GET1^DIQ(2006.941,MAGIEN,2,"I")'=MAGSUB
 . . D DELWITEM^MAGVIM01(.MAGOUT,MAGIEN)
 . . Q
 . Q
 Q
