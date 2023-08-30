XU8P689 ;ALB/MA - Patch XU*8*689 Pre/Post init ;12/05/18
 ;;8.0;KERNEL;**689**;May 17, 2012;Build 113
 Q
PRE  ;
 ;Deletes FIELD EDITED (#.03) of XUEPCS DATA FILE (#8991.6). A modified copy is sent in this patch
 N DIK,DA S DIK="^DD(8991.6,",DA=.03,DA(1)=8991.6 D ^DIK
 Q
 ;
POST ;The listed XU EPCS options are placed out of order as they are moved over to PSO namespace
 D BMES^XPDUTL("...Placing XU EPCS UTILITY FUNCTIONS menu options out of order...")
 N XUOO,AA,I S XUOO="PLACED OUT OF ORDER BY XU*8*689"
 F I=1:1:14 S AA=$P($T(OO+I),";;",2) Q:AA=""  D OUT^XPDMENU(AA,XUOO)
 Q
 ;
 ;
OO ;
 ;;XU EPCS PRIVS
 ;;XU EPCS DISUSER PRIVS
 ;;XU EPCS SET PARMS
 ;;XU EPCS PRINT EDIT AUDIT
 ;;XU EPCS PSDRPH
 ;;XU EPCS PSDRPH KEY
 ;;XU EPCS EDIT DATA
 ;;XU EPCS EDIT DEA# AND XDATE
