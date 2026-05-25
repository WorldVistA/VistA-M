PSS264PI ;HDSO/TTN - PSS*1.0*264 Post-install routine; Mar 19, 2024@16:00
 ;;1.0;PHARMACY DATA MANAGEMENT;**264**;DEC 1997;Build 35
 ;
 ;
 Q  ; Must be run from a specific tag
 ;
 ; This post install for patch #264 does the following:
 ; 1) Deletes the B cross-reference for File 51.7 Field #.01,
 ; 2) RE-INDEX the new style B cross-reference since we are changing from 30 to 40 chars
 ;
ENT ;Install Entry point
 K ^XTMP("PSS*1.0*264")
 S ^XTMP("PSS*1.0*264",0)=$$FMADD^XLFDT(DT,90)_"^"_DT_"^PSS*1.0*264 Post Install Routine"
 M ^XTMP("PSS*1.0*264","BACKUP","B")=^PS(51.7,"B")
 M ^XTMP("PSS*1.0*264","BACKUP",".01")=^DD(51.7,.01)
 D DELIX^DDMOD(51.7,.01,1) ;REFERENCE NUMBER - "B", delete traditional xref
 D CLRINDX ; DELETE THE OLD "B" INDEX for the data
 Q
 ;
CLRINDX  ;Delete and set the "B" index of file 51.7 
 D BMES^XPDUTL("Clearing and Recreate the 'B' indexes for file 51.7")
 N DIK
 S DIK="^PS(51.7,",DIK(1)=".01^B" D ENALL2^DIK K DIK
 S DIK="^PS(51.7,",DIK(1)=".01^B" D ENALL^DIK K DIK
 D MES^XPDUTL("   Completed!")
 Q
 ;
BACKOUT ;
 N DIK
 D DELIXN^DDMOD(51.7,"B","K")
 S DIK="^PS(51.7," D IXALL^DIK
 Q
 ;
