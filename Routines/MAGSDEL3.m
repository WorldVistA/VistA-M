MAGSDEL3 ;WOIFO/LB - Delete image pointers in the lab file ; [ 06/20/2001 08:57 ]
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
EN(IMAGE,RESULT) ;
 ;IMAGE is the ien in file 2005
 S RESULT="0^Parent File Delete Failed"
 Q:'IMAGE
 Q:'$D(^MAG(2005,IMAGE,0))
 N DIK,DA
 N MAGLRDFN,MAGLRTYP,MAGLRI,MAGLIEN,MAGLRNOD,FIELD,COMPARE
 ;
 S MAGLRDFN=$P(^MAG(2005,IMAGE,2),"^",7),MAGLRTYP=$P(^(2),"^",6)
 S MAGLRI=$P(^MAG(2005,IMAGE,2),"^",10),MAGLIEN=$P(^(2),"^",8)
 I 'MAGLRI!('MAGLIEN) Q     ;No parent pointers
 S MAGLRNOD=$S(MAGLRTYP=63.08:"SP",MAGLRTYP=63.02:"EM",MAGLRTYP=63.09:"CY",1:"AY")
 ;"AY" Has two fields, 2005 and 2005.1
 S FIELD=$S(MAGLRTYP=63:2005.1,1:2005)
 Q:'$D(^LR(MAGLRDFN,MAGLRNOD,MAGLRI,FIELD,MAGLIEN,0))
 ; EXAMPLE ^LR(48,"AY",1,2005.1,3,0) = 49345
 S COMPARE=$P($G(^LR(MAGLRDFN,MAGLRNOD,MAGLRI,FIELD,MAGLIEN,0)),"^")
 Q:COMPARE'=IMAGE    ;Not same image pointer
 S DA(2)=MAGLRDFN,DA(1)=MAGLRI,DA=MAGLIEN
 S DIK="^LR("_MAGLRDFN_","""_MAGLRNOD_""","_MAGLRI_","_FIELD_","
 D ^DIK
 S RESULT="1^SUCCESS"
 Q
