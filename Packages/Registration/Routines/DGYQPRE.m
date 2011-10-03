DGYQPRE ;AISC/TET - PRE INIT TO PATCH DG*5.3*41
 ;;5.3;Registration;**41**;Aug 13, 1993
PRE ;pre init after committment
 ;delete field in multiple of file 2 (Patient), field 1000 (disp log enter/edit), subfile 2.101, field 3 (facility applying to)
 S DIK="^DD(2.101,",DA=3,DA(1)=2.101 D ^DIK
 K DA,DIK Q
