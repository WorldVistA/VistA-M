PRSXP57 ;WCIOFO/SAB-INSTALL ROUTINE FOR PATCH PRS*4*57 ;2/29/2000
 ;;4.0;PAID;**57**;Sep 21, 1995
 ; This routine can be deleted after patch PRS*4*57 is installed.
 Q
PS ; Post Install
 N DIE,DR,DA
 I '$D(^PRST(457.4,9,0)) D  Q
 . D BMES^XPDUTL("ERROR: Entry #9 in TIME REMAKRS file is missing")
 S DIE="^PRST(457.4,",DR="5///OT CT RG",DA=9 D ^DIE
 D BMES^XPDUTL("    Updated entry #9 in TIME REMAKRS (#457.4) file.")
 Q
