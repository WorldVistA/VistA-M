EAS1190P ;ALB/KUM - Patch Post-Install functions EAS*1*190 ; 4/17/20 3:03pm
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**190**;17-APR-20;Build 45
 ;Per VHA Directive 2004-038, this routine should not be modified. 
 ;
 Q
 ;
 ;Supported ICRs
 ; #5567 - XPDPROT call
 ; #10141 - XPDUTL - Public APIs for KIDS
 ; #2056 - $$GET1^DIQ(}
 ; #2051 - $$FIND1^DIQ(}
 ; 
EN  ;Disable protocol
 ;
 ; EASPRT - Protocol to disable
 ; EASTXT - Disabled protocol message text
 ;
 N EASOUT
 Q:$$PATCH^XPDUTL("EAS*1.0*190")
 N EASPRT,EASTXT
 S EASTXT="Link to Patient File has been disabled."
 ;
 S EASPRT="EAS EZ LINK TO FILE 2"
 D OUT^XPDPROT(EASPRT,EASTXT) ;Disable protocol
 D MES^XPDUTL("EAS EZ LINK TO FILE 2 - protocol was disabled.")
 D MES^XPDUTL(" ")
 Q
