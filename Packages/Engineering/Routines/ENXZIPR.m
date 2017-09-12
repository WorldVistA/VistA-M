ENXZIPR ;CIOFO2/DH-Pre Init to Equipment Management Fixes ;10.15.97
 ;;7.0;ENGINEERING;**45**;Aug 17,1993
 ; Delete .01 field from ^DD(6910.1, in order to remove dead
 ; code that contains a $N
EN N DIK,DA
 S DIK="^DD(6910.1,",DA=.01,DA(1)=6910.1
 D ^DIK
 Q
