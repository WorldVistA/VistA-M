VPSDDCU ;WOIFO/KC - DD clean up;1/15/15 11:26
 ;;1.0;VA POINT OF SERVICE (KIOSKS);**3**;Jan 15, 2015;Build 64
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 QUIT
 ;
 ; Remove fields that are obsolute
REMOVE ;
 S DIK="^DD(853.54,",DA=30,DA(1)=853.54
 D ^DIK
 S DIK="^DD(853.54,",DA=31,DA(1)=853.54
 D ^DIK
 S DIK="^DD(853.54,",DA=32,DA(1)=853.54
 D ^DIK
 S DIK="^DD(853.52,",DA=12,DA(1)=853.52
 D ^DIK
 S DIK="^DD(853.52,",DA=13,DA(1)=853.52
 D ^DIK
 S DIK="^DD(853.52,",DA=14,DA(1)=853.52
 D ^DIK
 Q
