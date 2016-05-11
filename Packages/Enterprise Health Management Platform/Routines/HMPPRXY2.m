HMPPRXY2 ;ASMR/JCH,PB - Post-Install Routine to Create HMP User ; 02/01/16 11:56
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**;Feb 03, 2015;Build 63
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ;Jan 29, 2016 - PB added code to add the APPLICATION PROXY user class to the HMP,APPLILCATION PROXY proxy account
 Q
 ;
POST ; Entry point for post install
 D BMES^XPDUTL("  Starting post-install")
 D ADDUSR
 Q
 ;
ADDUSR() ; FileMan calls to add user, update fields, update sub-files
 N DIC ; DIC(0) is required by the LAGYO code attached to NAME (#.01) field in NEW  PERSON (#200) file (see below)
 ;  NEW PERSON (#200 file :          ^DD(200,.01,"LAYGO",1,0)="D LAYGO^XUA4A7"
 ;  Routine XUA4A7 :        LAYGO    ;Called from ^DD(200,.01,"LAYGO",1,0)
 ;                                   Q:DIC(0)'["E"
 N FDA ; The name of the root of a VA FileMan Data Array, which describes the entries to add to the database.
 N ERR ; Array containing error messages.
 N HMPERTXT ; Array containing generic user message text indicating fields/files that were not updated
 N USRIEN ; The Internal Entry Number (IEN) of the 
 N FDAIEN ; The IEN of HMP,APPLICATION PROXY user found in the NEW PERSON (#200) file
 N HMPERR ; The full reference to each ERR error node, including the array with subscripts and data (i.e., ERR("DIERR",1,"TEXT")="Error Message")
 ;
 ; Add new user to ^VA(200
 S DIC(0)="" ; Define DIC(0) so DD(200,.01,"LAGYO" code doesn't blow up (LAYGO^XUA4A7)
 S FDA(200,"?+1,",.01)="HMP,APPLICATION PROXY"
 D UPDATE^DIE("E","FDA","FDAIEN","ERR")
 ; Quit if user not added
 S USRIEN=$G(FDAIEN(1))
 I '$G(USRIEN) D  Q
 .D BMES^XPDUTL("HMP,APPLICATION PROXY user not added")
 .I $D(ERR) D ERROUT(.ERR)
 ;
 S HMPERTXT=$S($G(FDAIEN(1,0))="?":"User HMP,APPLICATION PROXY already on file.",$G(FDAIEN(1,0))="+":"User HMP,APPLICATION PROXY added",1:"")
 D BMES^XPDUTL(HMPERTXT)
 ;
 ; Add fields for new user file entry
 K FDA,ERR
 S FDA(200,USRIEN_",",1)="PU"                ; Initials
 S FDA(200,USRIEN_",",7.2)="Y"
 S FDA(200,USRIEN_",",20.2)="HMPPROXY USER"  ; Signature Block
 S FDA(200,USRIEN_",",101.01)="NO"           ; Restrict Patient Selection
 S FDA(200,USRIEN_",",201)="XMUSER"             ; Primary Menu Option
 D FILE^DIE("E","FDA","ERR")
 ;
 ;  display progress (Data is refiled each time post-install is run - updated message will display each time)
 K HMPERTXT
 S HMPERTXT(1)="The following HMP,APPLICATION PROXY fields were "_$S($D(ERR):"NOT updated: ",1:"updated: ")
 S HMPERTXT(2)="INITIALS, ACCESS CODE, SIGNATURE BLOCK, RESTRICT PATIENT SELECTION, PRIMARY MENU OPTION"
 D BMES^XPDUTL(.HMPERTXT)
 ;
 ; If failure, provide details
 I $D(ERR) D ERROUT(.ERR)
 ;
 ; Update sub-files for new user file entry
 K FDA,ERR
 S FDA(200.051,"?+1,"_USRIEN_",",.01)="HMP ADMIN"
 S FDA(200.051,"?+2,"_USRIEN_",",.01)="PROVIDER"
 S FDA(200.010113,"?+3,"_USRIEN_",",.01)="COR"
 S FDA(200.03,"?+5,"_USRIEN_",",.01)="HMP UI CONTEXT"
 S FDA(200.03,"?+6,"_USRIEN_",",.01)="HMP SYNCHRONIZATION CONTEXT"
 D UPDATE^DIE("E","FDA",,"ERR")
 ;
 ; It's an all or nothing transaction - display progress (Data is refiled each time post-install is run - updated message will display each time)
 K HMPERTXT
 S HMPERTXT(1)="The following sub-files for user HMP,APPLICATION PROXY were "_$S($D(ERR):"NOT updated: ",1:"updated: ")
 S HMPERTXT(2)="  KEYS, CPRS TAB, SECONDARY MENU OPTIONS"
 D BMES^XPDUTL(.HMPERTXT)
 ; 
 ; If failure, provide details
 I $D(ERR) D ERROUT(.ERR)
 ;
 ;JAN 29, 2016 - PB - Add User Class, APPLICATION PROXY to the HMP,APPLICATION PROXY account
 ;get pointers for classes in file 201
 K FDA,ERR
 S FDA(200.07,"?+1,"_USRIEN_",",.01)="APPLICATION PROXY"
 S FDA(200.07,"?+1,"_USRIEN_",",2)="1"
 D UPDATE^DIE("E","FDA",,"ERR")
 ;if user class, APPLICATION PROXY is not added notify users
 K HMPERTXT
 S HMPERTXT(1)="The following sub-files for user HMP,APPLICATION PROXY were "_$S($D(ERR):"NOT updated: ",1:"updated: ")
 S HMPERTXT(2)="  User Class - APPLICATION PROXY"
 D BMES^XPDUTL(.HMPERTXT)
 Q
 ;end changes to add user classes to the HMP,APPLICATION PROXY proxy user account.
 ;
ERROUT(ERR) ; Output ERR array
 D BMES^XPDUTL("Error Details:")
 S HMPERR="ERR(""DIERR"")" F  S HMPERR=$Q(@HMPERR) Q:HMPERR=""  D MES^XPDUTL(HMPERR_"="_@HMPERR)
 Q
