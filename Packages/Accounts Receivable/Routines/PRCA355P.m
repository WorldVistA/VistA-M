PRCA355P ;ALB/JSG - PATCH PRCA*4.5*355 PRE/POST-INSTALL ROUTINE ;5/28/19 6:22pm
 ;;4.5;Accounts Receivable;**355**;Mar 20, 1995;Build 10
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; DBIA#10141
 ;
 Q
 ;
BMSG(MESS) ; spit out message (preceded by a blank line 
 D BMES^XPDUTL(MESS)
 Q
 ;
POSTINS ;
 Q:($$PROD^XUPROD(1))&($$INSTALDT^XPDUTL("PRCA*4.5*355"))  ; DBIA#10141
 D CHGSTDAY  ; Change statement day
 ;
 Q
 ;
CHGSTDAY ; Change statement day
 ;
 ; Get the statement day
 N DOM
 S DOM=$$GETDOM
 Q:DOM=0  ; Not one of the 16 sites needing new statement day
 D BMSG("Reset Site Parameter - SITE STATEMENT DAY to "_DOM)
 N DA,DR,DIE,X,RCT
 S DIE="^RC(342,"
 S DA=1
 S DR=".11///"_DOM ; Stuff field value (Validated)
 D ^DIE
 ;
 ; set of Patient Statement Day dependent upon site (must be a patient - DPT)
 D BMES^XPDUTL("Resetting Patient Statement Day to "_DOM)
 N DEBT,DIE
 S DIE="^RCD(340,"
 S DEBT=""
 F  S DEBT=$O(^RCD(340,"AB","DPT(",DEBT)) Q:DEBT=""  D
 . N DA,DR
 . S DA=DEBT
 . S DR=".03////"_DOM ; Stuff field value (Unvalidated)
 . D ^DIE
 Q 
 ;
GETDOM() ; Get site and statement day
 ; Input:  None
 ;
 ; Output:  New statement day or flag
 ;     0 - Flag for sites that do not need to get new statement day
 ;    26 - New statement day for 10 selected sites
 ;    28 - New statement day for 6 selected sites
 ;
 N FLG,SITE,SITES26,SITES28
 S SITE=+$$SITE^VASITE
 S SITES26=$P($T(SITES26),";",3)
 S SITES28=$P($T(SITES28),";",3)
 S FLG=$S(SITES26[(","_SITE_","):26,SITES28[(","_SITE_","):28,1:0)
 Q FLG
 ;
 ; From PRCA*4.5*355 Patch Description:
 ;
 ; Sites with new statement day = 26
SITES26 ;;,438,501,504,542,562,568,649,656,688,756,
 ;
 ; Sites with new statement day = 28
SITES28 ;;,565,621,658,664,671,740,
