YS107P ;ALB/RBD - YS*5.01*107 PATCH POST INIT ROUTINE ;16 May 2013  3:59 PM
 ;;5.01;MENTAL HEALTH;**107**;Dec 30, 1994;Build 23
 ;
 ; IA 5924 Created for this post-init routine to update DESCRIPTION
 ;  of File (#627.8)
 ;
EN ;
 D BMES^XPDUTL("**** ICD 10 Remediation ****")
 N YSUPDMSG S YSUPDMSG="**** Updating Mental Health - Diagnostic "
 S YSUPDMSG=YSUPDMSG_"Condition File (#627.8) DESCRIPTION ****"
 D BMES^XPDUTL(YSUPDMSG)
 S YSUPDMSG="**** Occurrences of 'ICD9' changed to 'ICD DIAGNOSIS' ****"
 D BMES^XPDUTL(YSUPDMSG)
CHANGE ;
 N YSREC
 S YSREC=$C(34)_"AE"_$C(34)_" Xref  -  Type (DSM or ICD DIAGNOSIS), "
 S YSREC=YSREC_"DFN, System Dte, Dx, DFN."
 S ^DIC(627.8,"%D",7,0)=YSREC
 S YSREC=$C(34)_"AG"_$C(34)_" Xref  -  Type (DSM or ICD DIAGNOSIS), "
 S YSREC=YSREC_"DFN, Dx, IFN."
 S ^DIC(627.8,"%D",13,0)=YSREC
 D BMES^XPDUTL("**** Done ****")
EXIT ;
 Q
