ORY629 ;NA/WAT - PRE/POST OR*3.0*629  ;Jan 27, 2025@11:14:53
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**629**;;Build 5
 ; Reference to ^XPAR in ICR #2263
 Q
POST ; post-init
 ;find any SYS entries where value = cprsdevsonly@dvagov.onmicrosoft.com
 ;and change those entries to the new value of oitspmhspcprser@domain.ext
 ;if no SYS value found, set it.
 ;D ENVAL^XPAR(.LIST,"OR CPRS EXCEPTION EMAIL",,.ERR)
 ;if SYS and old email, update to new
 N LIST,PARM,VALUE
 S PARM="OR CPRS EXCEPTION EMAIL",VALUE="oitspmhspcprser@domain.ext"
 D ENVAL^XPAR(.LIST,PARM,,.ERR)
 I $G(ERR)'=0 D ERROR K ERR Q  ;can't find parameter
 N I,J S I="",J=0
 F  S I=$O(LIST(I))  Q:$G(I)=""  D
 . Q:$G(I)'["DIC(4.2"
 . F  S J=$O(LIST(I,J))  Q:+$G(J)=0  D
 . . I LIST(I,J)["CPRSDevsOnly" D
 . . . D BMES^XPDUTL("Updating exception email SYS parameter value...")
 . . . D CHG^XPAR(I,PARM,J,VALUE,.ERR)
 . . . I $G(ERR)'=0 D ERROR Q
 . . . D MES^XPDUTL("Update complete.")
 I $$GET^XPAR("SYS",PARM,1,"E")'=VALUE  D
 . ;no SYS value for CPRS found, set it.
 . D BMES^XPDUTL("Setting exception email SYS parameter value...")
 . D EN^XPAR("SYS",PARM,,VALUE,.ERR)
 . I $G(ERR)'=0 D ERROR
 . D MES^XPDUTL("Set complete.")
 K ERR
 Q
ERROR ; display error
 D BMES^XPDUTL("  ERROR UPDATING THE ""OR CPRS EXCEPTION EMAIL"" PARAMETER  ")
 D MES^XPDUTL("ERROR MESSAGE: "_$P(ERR,"^",2))
 Q
