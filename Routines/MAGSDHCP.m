MAGSDHCP ;WOIFO/LB - Routine to delete entries in file 2006.5839 ; 10/08/2003  09:54
 ;;3.0;IMAGING;**10**;Nov 06, 2003
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
DCMTEMP(RESULT,IMAGE) ;
 N DA,DIK,IEN,FILE,ENTRY,IMG
 S RESULT="0^Failure could not delete entry from file."
 Q:'IMAGE
 Q:'$D(^MAG(2005,IMAGE,0))
 I $P(^MAG(2005,IMAGE,0),"^",10) D  Q
 . S RESULT="1^Parent pointer does not need to be resolved."
 . ; This should allow code to continue deleting image entry.
 . Q
 ; Can only delete if the image is a group entry.
 ; Find the DA entry. 
 S DA=0
 S FILE=$P(^MAG(2005,IMAGE,2),"^",6) Q:FILE'=2006.5839
 S ENTRY=$P(^MAG(2005,IMAGE,2),"^",7) Q:'ENTRY
 I $D(^MAG(2006.5839,"C",123,ENTRY)) D
 . S IEN=$O(^MAG(2006.5839,"C",123,ENTRY,0)) Q:'IEN
 . Q:'$D(^MAG(2006.5839,IEN,0))
 . S IMG=$P(^MAG(2006.5839,IEN,0),"^",3)
 . I IMAGE'=IMG S DA=0
 . S DA=IEN
 . Q
 I 'DA S RESULT="0^Entry in file 2006.5839 does not exist" Q
 S IEN=DA
 S DIK="^MAG(2006.5839," D ^DIK
 I '$D(^MAG(2006.5839,IEN,0)) D
 . S RESULT="1^Success in deleting entry in file 2006.5839."
 . Q
 Q
