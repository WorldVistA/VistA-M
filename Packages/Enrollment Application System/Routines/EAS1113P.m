EAS1113P  ;ALB/TGH - Patch EAS*1.0*113 Post Install ;02/20/2015 8:43am
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**113**;FEB 20, 2015;Build 53
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; EAS*1*113 Post Install will add BT CLAIMS PROCESSING Mail Group to 
 ; EAS BT CLAIMS PROCESSING Bulletin 
 ;
EN  ;
 ; If the BT CLAIMS PROCESSING Mail Group is already set up for the EAS 
 ; BT CLAIMS PROCESSING Bulletin, Quit and write message to screen and do
 ; not continue
 N BUL,MG
 S MG=$$FIND1^DIC(3.8,,"BX","BT CLAIMS PROCESSING")
 S BUL=$$FIND1^DIC(3.6,,"BX","EAS BT CLAIMS PROCESSING")
 I $D(^XMB(3.6,BUL,2,"B",MG)) D  Q
 . N ARR
 . S ARR(1)="========================================================"
 . S ARR(2)="Mail Group already set. Update of Bulletin Not Required."
 . S ARR(3)="========================================================"
 . D BMES^XPDUTL(.ARR)
 ;
 ; Otherwise, set Mail Group into Bulletin
 N IENS,FDA,ERROR,ERR,TXT
 S IENS="+1,"_BUL_","
 S FDA(3.62,IENS,.01)=MG
 D UPDATE^DIE("","FDA","","ERROR")
 ;
 ; Process errors if any exist and display to screen
 S ERR="" F  S ERR=$O(ERROR("DIERR",ERR)) Q:ERR=""  D
 . S TXT="" F  S TXT=$O(ERROR("DIERR",ERR,"TEXT",TXT)) Q:TXT=""  D
 . . D ERROR(ERROR("DIERR",ERR,"TEXT",TXT))
 ;
 ; Print success message to screen if no Errors
 I '$D(ERROR("DIERR")) D
 . N ARR
 . S ARR(1)="========================================================"
 . S ARR(2)="BT CLAIMS PROCESSING Mail Group has been successfully"
 . S ARR(3)="added to EAS BT CLAIMS PROCESSING Bulletin."
 . S ARR(4)="========================================================"
 . D BMES^XPDUTL(.ARR)
 ;
 Q  ; EN
 ;
ERROR(ERRMSG) ;Display error message
 ;
 N ARR
 S ARR(1)="===================================================="
 S ARR(2)="= ERROR ="
 S ARR(3)="===================================================="
 S ARR(4)="While updating Bulletin with Mail Group"
 S ARR(5)="===================================================="
 S ARR(6)="**ERROR MSG: "_ERRMSG
 ;
 D BMES^XPDUTL(.ARR)
 ;
 Q
