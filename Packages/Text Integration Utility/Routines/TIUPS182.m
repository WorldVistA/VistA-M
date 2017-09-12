TIUPS182 ; SLC/MAM - TIU*1*182 Post Install ; 05/25/2004
 ;;1.0;Text Integration Utilities;**182**;Jun 20, 1997
 ;
 ; -- Edit Print Form Header,delete PF Number of Class CP:
 N FDA,TIUFPRIV,CPCLASS
 S CPCLASS=$$CLASS^TIUCP,FDA(8925.1,CPCLASS_",",6.1)="Clinical Procedures"
 S FDA(8925.1,CPCLASS_",",6.12)="@"
 S TIUFPRIV=1
 D FILE^DIE("TE","FDA")
 I '$D(^TMP("DIERR",$J)) D BMES^XPDUTL("Class Clinical Procedures Print Form Header and Number updated successfully.") Q
 D BMES^XPDUTL("Couldn't update Class CP Print Form Header or Number. See patch description or contact EVS.")
 K ^TMP("DIERR",$J)
 Q
