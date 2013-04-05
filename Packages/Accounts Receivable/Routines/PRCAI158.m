PRCAI158 ;ALB/MFR-PATCH PRCA*4.5*158 POST INIT ; 06/27/00
 ;;4.5;Accounts Receivable;**158**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 D DATADEL
 Q
 ;
DATADEL ; Delete the "-1" Bills from the Accounts Receivable file (430)
 ;
 N DA,DIK,RCIDX,RCXRF,RCCNT
 ;
 D BMES^XPDUTL(" >>  Removing inconsistent entries from file 430...")
 ;
 S (DA,RCCNT)="",DIK="^PRCA(430,"
 F RCIDX="B","D" D
 . S RCXRF=$S(RCIDX="B":"-1^",1:"1^")
 . F  S RCXRF=$O(^PRCA(430,RCIDX,RCXRF)) Q:RCXRF=""!(RCXRF'["^")  D
 . . F  S DA=$O(^PRCA(430,RCIDX,RCXRF,DA)) Q:DA=""  D
 . . . I $D(^PRCA(430,DA,0)) D ^DIK S RCCNT=RCCNT+1
 . . . K ^PRCA(430,RCIDX,RCXRF,DA)
 ;
 D BMES^XPDUTL(" >>  Total of "_+RCCNT_" bills removed.")
 ;
 Q
