SD5377PT ;ALB/MLI - Routine to inactivate entries in file 409.45 ; 10/6/95
 ;;5.3;Scheduling;**77,85**,Aug 13, 1993
 ;
 ; (based from routine SD5363PT)
 ;
 ; This routine will add a 10/1/96 inactivate date for the following
 ; code so classification questions will be asked.
 ;
 ; 165       BEREAVEMENT COUNSELING
 ;
EN ; entry point to inactivate stop codes in file 409.45
 N DA,MSG,SDYQSTOP,STOPIEN,X,Y
 D BMES^XPDUTL(">>>Inactivating the following entry:")
 S SDYQSTOP=165 D
 . S MSG="   Stop code "_SDYQSTOP
 . S DA=$O(^SD(409.45,"B",SDYQSTOP,0))
 . I 'DA D MES^XPDUTL(MSG_" could not be found in exemption file...nothing updated") Q
 . S STOPIEN=$O(^DIC(40.7,"C",SDYQSTOP,0))
 . I STOPIEN,$$EX^SDCOU2(STOPIEN) D  Q
 . . D STORE(DA,0)
 . . D MES^XPDUTL(MSG_" no longer exempt from classification questions")
 . D MES^XPDUTL(MSG_" already exempt")
 Q
 ;
 ;
STORE(DA,ONOFF) ; create entry for act/inact
 ;  Input:  DA as IEN of 409.45
 ;          ONOFF as 1 for act; 0 for inact
 ;
 N DIC,DLAYGO,X,Y
 S DIC="^SD(409.45,"_DA_",""E"",",DIC("P")=$P(^DD(409.45,75,0),"^",2)
 S DA(1)=DA,DIC(0)="L"
 S X="2961001",DIC("DR")=".02///^S X=ONOFF"
 K DD,DO
 D FILE^DICN
 Q
