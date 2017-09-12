SD5363PT ;ALB/MLI - Routine to put entries in file 409.45 ; 10/6/95
 ;;5.3;Scheduling;**63**,Aug 13, 1993
 ;
 ; This routine will set the following entries into the OUTPATIENT
 ; CLASSIFICATION TYPE file (#409.45) so that classification
 ; questions are no longer asked for stop codes:
 ;
 ; 421       VASCULAR LABORATORY
 ; 703       MAMMOGRAM
 ;
 ; It will add the following inactivate dates for the following
 ; codes so classification questions will be asked.
 ;
 ; 117       NURSING
 ; 118       HOME TREATMENT SERVICES
 ; 119       COMM NURSING HOME FOLLOW-UP
 ; 120       HEALTH SCREENING
 ; 121       RESID CARE PROGRAM FOLLOW-UP
 ; 122       PUBLIC HEALTH NURSING
 ; 123       NUTRITION/DIETETICS-INDIVIDUAL
 ; 124       NUTRITION/DIETETICS-GROUP
 ; 125       SOCIAL WORK SERVICE
 ;
EN ; entry point to add stop codes to file 409.45
 N DA,DIC,DLAYGO,MSG,SDYQERR,SDYQSTOP,STOPIEN,X,Y
 S SDYQERR=0
 D BMES^XPDUTL(">>>Adding entries to the OUTPATIENT CLASSIFICATION STOP CODE EXCEPTION")
 D MES^XPDUTL("file (#409.45)..."),MES^XPDUTL("")
 F SDYQSTOP=421,703 D
 . S MSG="   Stop code "_SDYQSTOP
 . S DA=$O(^SD(409.45,"B",SDYQSTOP,0))
 . I 'DA D  Q:SDYQERR
 . . K DD,DO
 . . S X=SDYQSTOP,DIC="^SD(409.45,",DIC(0)="L",DLAYGO=409.45
 . . D FILE^DICN S DA=+Y
 . . I Y<0 S SDYQERR=1 D MES^XPDUTL(MSG_"...could not be added...try again later.")
 . . I Y>0 D MES^XPDUTL(MSG_"...added to file as of 9/1/96")
 . I $O(^SD(409.45,DA,"E","B",2960901,0)) D MES^XPDUTL(MSG_"...already in file.") Q
 . D STORE(DA,1)
 ;
 D BMES^XPDUTL(">>>Inactivating the following entries:")
 F SDYQSTOP=117:1:125 D
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
