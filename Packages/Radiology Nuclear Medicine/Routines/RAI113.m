RAI113 ;HIRMFO/GJC - pre/post-init patch 113 ;12/26/13  13:05
VERSION ;;5.0;Radiology/Nuclear Medicine;**113**;Mar 16, 1998;Build 6
 ;
 ;--- IAs ---
 ;Call                  Number     Type
 ;------------------------------------------------
 ;$$NEWCP^XPDUTL        10141      S
 ;$$GET1^DID            2052       S
 ;PRD^DILFD             2055       S
 ;where 'S'=Supported; 'C'=Controlled Subscription; 'P'=Private
 ;
POST ;post-init
 ;
 S RACHK=$$NEWCP^XPDUTL("POST1","PRD^RAI113")
 ;set Package Revision Data node ^DD(file_#,0,"VRRV") to patch number.
XIT ;kill and quit
 K RACHK
 Q
 ;
 ;-----
 ;
PRD ;post - set Package Revision Data node ^DD(file_#,0,"VRRV") to patch
 ;number.
 S RAPATCH="RA*5.0*113"
 D:$$GET1^DID(70.3,,,"PACKAGE REVISION DATA")'=RAPATCH PRD^DILFD(70.3,RAPATCH)
 K RAPATCH
 Q
 ;
