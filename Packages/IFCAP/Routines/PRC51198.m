PRC51198 ;OI&T/LKG - ENV CHECK & POST-INIT PRC*5.1*198 ;4/24/17  18:06
 ;;5.1;IFCAP;**198**;OCT 20, 2000;Build 6
 ;Per VA Directive 6402, this routine should not be modified.
 ;Integration agreements
 ; ICR #2052:  FIELD^DID()
 ; ICR #2055:  $$VFIELD^DILFD()
 ; ICR #10141: BMES^XPDUTL(), MES^XPDUTL()
 ;
ENV ;Environmental Check
 I $$VFIELD^DILFD(441,25) D  Q
 . N PRCARR,PRCERR
 . D FIELD^DID(441,25,"","TYPE;LABEL","PRCARR","PRCERR")
 . I PRCARR("LABEL")'="MANUFACTURER"!(PRCARR("TYPE")'="POINTER") D
 . . S XPDQUIT=2
 . . D BMES^XPDUTL("Your IFCAP instance already has in the Item Master (#441) file")
 . . D MES^XPDUTL("  a field #25 which is in conflict with the field #25 being")
 . . D MES^XPDUTL("  introduced by patch PRC*5.1*198.")
 . . D BMES^XPDUTL("Please submit a Product Support ticket for resolution.")
 Q
 ;
 ;PRC51198
