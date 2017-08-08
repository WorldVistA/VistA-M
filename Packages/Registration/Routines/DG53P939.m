DG53P939 ;JLS - SOURCE OF NOTIFICATION UPDATE ;1/08/17 9:18am
 ;;5.3;Registration;**939**;Aug 13, 1993;Build 14
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; KUM; DG*5.3*939 Post Install routine to update label for 1 source
 ;  Integration Agreements:
 ;        10141 : BMES^XPDUTL
 ;              : MES^XPDUTL
 ;        10018 : UPDATE^DIE
 ;
 Q
 ;
POST ;Update entry in SOURCE OF NOTIFICATION file
 ;
 N ERR,MSG
 S (ERR,MSG)=""
 D UPDREQ
 I ERR'="" D
 . D BMES^XPDUTL("ERROR - "_ERR)
 . ; D BMES^XPDUTL("     *** An Error occurred during updating entry in SOURCE OF NOTIFICATION File ***  ;")
 . D MES^XPDUTL("     Please log a remedy ticket.")
 . Q
 I MSG'="" D
 . D BMES^XPDUTL("    SPOUSE/NOK/OTHER PERSON already exists in SOURCE OF NOTIFICATION file   ")
 . Q
 I (ERR="")&(MSG="") D
 . D BMES^XPDUTL("    SPOUSE/NEXT OF KIN/OTHER PERSON changed to SPOUSE/NOK/OTHER PERSON   ")
 . Q
 Q
 ;
UPDREQ ; Update entry in 47.76
 ;
 N IEN,NAME,NWNAME,FDA
 ; Check if new entry exists, quit if it does
 S NWNAME="SPOUSE/NOK/OTHER PERSON"
 S IEN=$O(^DG(47.76,"B",NWNAME,0))
 I IEN S MSG="SPOUSE/NOK/OTHER PERSON already exists in SOURCE OF NOTIFICATION File" Q
 ;
 ; Check if entry exists, use it if it does
 S NAME="SPOUSE/NEXT OF KIN/OTHER PERSON"
 S IEN=$O(^DG(47.76,"B",NAME,0))
 I 'IEN S ERR="SPOUSE/NEXT OF KIN/OTHER PERSON is not found in SOURCE OF NOTIFICATION File" Q
 ;
 L +^DG(47.76,IEN,0):2
 I '$T S ERR="SOURCE OF NOTIFICATION file (#47.76) is currently locked by another user. Try later"  Q
 ;
 S IEN=IEN_","
 ;
 S FDA(47.76,IEN,.01)="SPOUSE/NOK/OTHER PERSON"
 D UPDATE^DIE("E","FDA","","ERR")
 L -^DG(47.76,IEN,0)
 I $D(ERR("DIERR")) S ERR=$G(ERR("DIERR",1,"TEXT",1)) Q
 Q
 ;
