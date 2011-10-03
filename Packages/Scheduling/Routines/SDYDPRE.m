SDYDPRE ;MJK/ALB - API Post Init;01 APR 1993
 ;;5.3;Scheduling;**27**;08/13/93
 ;
EN ;
 D CLEAN44
 Q
 ;
CLEAN44 ;-- Remove Provider DD on file 44
 D BMES^XPDUTL(">>> Deleting Provider screen on file 44 ...")
 S DIK="^DD(44.1,",DA=.01,DA(1)=44
 D ^DIK
 Q
 ;
