SPNLENV ;HIRMFO-WAA; ENVIRONMENT CHECK ROUTINE
 ;;2.0;Spinal Cord Dysfunction;;01/02/1997
 ;;
 ;ENV
 ; This routine is to check to see that the correct version of
 ; SCD is installed or that this is a virgin install.
 ;
ENV ;Environment Check
 N SPNENV,SPNNAME
 S SPNENV=+$$VERSION^XPDUTL("SCD")
 I SPNENV=1 D
 . W $C(7)
 . W !,"      You are trying to install Version 2.0 of"
 . W !,"      SCD over version 1.0.  Please first install"
 . W $C(7),!,"      SCD version 1.5 then install SCD Version 2.0"
 . S XPDQUIT=1
 . Q
 S SPNNAME=$G(^GMT(142.1,74,0))
 I SPNNAME'="" D  ; If entry #74 is not empty.
 . I $P(SPNNAME,U)="SPINAL CORD DYSFUNCTION" Q  ; Entry Already exists.
 . ; Entry is illegal and needs to be fixed.
 . W $C(7)
 . W !,"      Entry # 74 in the Health Summary Component file 142.1"
 . W !,"      is currently being used by an illegal entry.  Please"
 . W !,"      contact Customer Support to fix this problem."
 . W $C(7)
 . S XPDQUIT=1
 .Q
 Q
PRE ;Pre init Control point
 N SPNPRE
 S SPNPRE=$$NEWCP^XPDUTL("PRE01","^SPNLPRE1")
 S SPNPRE=$$NEWCP^XPDUTL("PRE02","EN2^SPNLPRE1")
 Q
POS ;Post init Control point
 N SPNPOS
 S SPNPOS=$$NEWCP^XPDUTL("POS01","EN1^SPNLPST1")
 Q
