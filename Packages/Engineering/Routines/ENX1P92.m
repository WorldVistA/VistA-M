ENX1P92 ;ALB/BR - ENG National Update ; 4/15/13 1:03pm
 ;;7.0;ENGINEERING;**92**;Aug 17, 1993;Build 10
 ;
 ;this routine is used as a post-init in a KIDS build
 ;to modify the NX SGL (#6914.3) file
 ;and the NX BOC (#6914.4) file
 ;
 Q
 ;
START ; entry point for post-init
 ;
 D ADDBOC
 D CHNGSGL
 Q
 ;
ADDBOC ;* add new entry to the NX BOC (#6914.4) file
 ;
 ;
 ;  ENGBOC is in format:
 ;   CODE^TITLE^CORRESPONDING SGL
 ;
 N ENGBOC,ENGDINUM,ENGNX,ENGCBOC,ENGBOCT,ENGCSGL
 D MES^XPDUTL(" ")
 D BMES^XPDUTL("Adding new entries to the NX BOC #6914.4 File...")
 D MES^XPDUTL(" ")
 F ENGNX=1:1 S ENGBOC=$P($T(NXBOC+ENGNX),";;",2) Q:ENGBOC="QUIT"  D
 .S ENGCBOC=$P(ENGBOC,U,1),ENGBOCT=$P(ENGBOC,U,2),ENGCSGL=$P(ENGBOC,U,3)
 .D FILBOC
 Q
FILBOC ;file boc
 N X,Y,ENGSTR
 I $D(^ENG(6914.4,"B",ENGCBOC)) D
 .D MES^XPDUTL(" ")
 .D BMES^XPDUTL("Entry # "_ENGCBOC_" already added")
 .D MES^XPDUTL(" ")
 I '$D(^ENG(6914.4,"B",ENGCBOC)) D
 .S X=ENGCBOC,DIC="^ENG(6914.4,",DIC(0)="",DIC("DR")="1///^S X=ENGBOCT;2///^S X=ENGCSGL"
 .D FILE^DICN
 .I +Y>0 D
 ..D MES^XPDUTL(" ")
 ..S ENGSTR="   Entry #"_+Y_" for "_$P(Y,U,2)
 ..D BMES^XPDUTL(ENGSTR_"  ...successfully added.")
 .I Y=-1 D
 ..D MES^XPDUTL(" ")
 ..D BMES^XPDUTL("ERROR when attempting to add "_ENGCBOC)
 Q
NXBOC ;CAPITALIZED BUDGET OBJECT CODE^BOC TITLE^CORRESPONDING SGL
 ;;2335^SOFTWARE^1830
 ;;QUIT
 ;
 Q
CHNGSGL ;Change 1524 SGL to 1995 in 6914.4 file  
 N ENDA,ENFDA
 ;
 ;update fields .01,1, and 3.  prevent adding entry during install
 S ENDA=$$FIND1^DIC(6914.3,"","X","1524","B")
 I ENDA D
 .D BMES^XPDUTL(" Renaming the Excess SGL from 1524 to 1995. ")
 .K ENFDA S ENFDA(6914.3,ENDA_",",.01)="1995"
 .S ENFDA(6914.3,ENDA_",",1)="PP&E REMOVED FROM SERVICE BUT NOT DISPOSED"
 .S ENFDA(6914.3,ENDA_",",3)="EQ PEND DISP"
 .D FILE^DIE("","ENFDA") D MSG^DIALOG()
 .D BMES^XPDUTL("Renaming completed")
 Q
