MAGIP39B ;Post init routine to queue site activity at install. ; 14 Oct 2010 4:41 PM
 ;;3.0;IMAGING;**39**;Mar 19, 2002;Build 2010;Mar 08, 2011
 ;; Per VHA Directive 2004-038, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 Q
POST ;
 N I,NLIST,PLACE,FLDAR,PL
 K ^MAG(2006.8,"B") ; Remove "B" cross-reference
 S PLACE=$O(^MAG(2006.1,"B",$$KSP^XUPARAM("INST"),""))
 D BMES^XPDUTL("Updating MAG WINDOWS: "_$$FMTE^XLFDT($$NOW^XLFDT))
 D ADDRPC^MAGQBUT4("MAGQB QUEDEL","MAG WINDOWS")
 D ADDRPC^MAGQBUT4("MAGQ JBQUE","MAG WINDOWS")
 D ADDRPC^MAGQBUT4("MAG FIELD VALIDATE","MAG WINDOWS")
 D ADDRPC^MAGQBUT4("MAG KEY VALIDATE","MAG WINDOWS")
 D ADDRPC^MAGQBUT4("MAGQ FTYPE","MAG WINDOWS")
 D ADDRPC^MAGQBUT4("MAGQ DFNIQ","MAG WINDOWS")
 D ADDRPC^MAGQBUT4("MAGQ JBSCN","MAG WINDOWS")
 D ADDRPC^MAGQBUT4("MAGQ FS CHNGE","MAG WINDOWS")
 D ADDRPC^MAGQBUT4("MAGQ QRNGE","MAG WINDOWS")
 D ADDRPC^MAGQBUT4("MAGQ FINDC","MAG WINDOWS")
 D ADDRPC^MAGQBUT4("MAGQ QCNT","MAG WINDOWS")
 D ADDRPC^MAGQBUT4("MAGQ ALL SERVER","MAG WINDOWS")
 D ADDRPC^MAGQBUT4("MAGQ ADD RAID GROUP","MAG WINDOWS")
 D ADDRPC^MAGQBUT4("MAGQ DEL NLOC","MAG WINDOWS")
 D ADDRPC^MAGQBUT4("MAGQBP ALL SHARES","MAG WINDOWS")
 D ADDRPC^MAGQBUT4("MAGQBP FREF","MAG WINDOWS")
 D ADDRPC^MAGQBUT4("MAGQ BP UAT","MAG WINDOWS")
 D BMES^XPDUTL("Add Generic Mail Message groups to the Mail Group file: "_$$FMTE^XLFDT($$NOW^XLFDT))
 D ADDMG ; Add Generic Mail Message groups to the Mail Group file (XMB(3.8)
 D BMES^XPDUTL("Add Message Subjects for Mail Management to Site Parameters - with interval: "_$$FMTE^XLFDT($$NOW^XLFDT))
 D ADDMS(6) ; Add Message Subjects for Mail Management to Site Parameters - with interval
 D BMES^XPDUTL("Add Generic Mail groups to BP Message subfile: "_$$FMTE^XLFDT($$NOW^XLFDT))
 D DLKP ; Add Generic Mail groups to BP Message subfile
 D BMES^XPDUTL("Add Raid Groups to the Network Location file: "_$$FMTE^XLFDT($$NOW^XLFDT))
 D ADDRG(4) ; Add Raid Groups to the Network Location file
 D FAR^MAGQBUT6(.FLDAR) ; Setup File/Node/Piece Table for FieldNumbers
 D GETRL^MAGQBU6A(.NLIST) ; Get a list of duplicate shares
 D BMES^XPDUTL("Initialize raid groups to group default: "_$$FMTE^XLFDT($$NOW^XLFDT))
 D IRG ; Initialize raid groups to group default
 D PRIME^MAGQBUT6(.NLIST) D BMES^XPDUTL("Setting Prime entries on line.")  ;Set prime entries online
 D SPRR^MAGQBUT6(.NLIST) D BMES^XPDUTL("Updating Imaging Site Parameter file with prime entries.")  ;Update the Site Parameter file
 D BMES^XPDUTL("Add Photo-ID Post Action to the Image Action file: "_$$FMTE^XLFDT($$NOW^XLFDT))
 D PID ;  Add Photo-ID Post Action to the Image Action file
 D BMES^XPDUTL("Set POP/AUTO Purge 'ON' as the default & Purge Factor as '2' & Purge by 'Last Access Date': "_$$FMTE^XLFDT($$NOW^XLFDT))
 D DPOP ; Set Express/AUTO Purge 'ON' as the default & Purge Factor as '2' & Purge by 'Last Access Date'
 D BMES^XPDUTL("Setup Auto-Verify: "_$$FMTE^XLFDT($$NOW^XLFDT))
 D AVSET ; Setup Auto-Verify
 D BMES^XPDUTL("Re-index Site Parameters, BP Servers, Network Location file: "_$$FMTE^XLFDT($$NOW^XLFDT))
 D INDEX
 D RMBPMSG
 D BMES^XPDUTL("Setup dummy UAT (Unassigned Tasks) BP Servers: "_$$FMTE^XLFDT($$NOW^XLFDT))
 D PURVER ; Add Auto Purge and Scheduled Verify to the BP server that has JUKEBOX assigned.
 D SUAT ; Setup dummy UAT (Unassigned Tasks) BP Servers
 D RTRS^MAGQBUT6 ;send an email on routers.
 D TASKIT("ACXREF^MAGQE7(0,0)","Setting AC X-reference in file 2006.95","Setting AC X-reference in file #2006.95.")
 D TASKIT("CONSHR^MAGQBUT6","Consolidate redundant shares utility","Consolidate redundant shares.")
 D TASKIT("CAS^MAGQBUT5","Purging queues in file 2006.041","Purging completed import queues in file #2006.041.")
 D RD ; Remove data from retired fields 2006.1:2.02,2.03,13,14,15,16,17,18,19,21,24 set photo id default
 S PL=0 F  S PL=$O(^MAG(2006.1,PL)) Q:'PL  S:$P($G(^MAG(2006.1,PL,1)),U,5)="" $P(^MAG(2006.1,PL,1),U,5)="30"   ;Restore a value - CR 685
 D BMES^XPDUTL("Post Install Mail Message: "_$$FMTE^XLFDT($$NOW^XLFDT))
 D INS^MAGQBUT4(XPDNM,DUZ,$$NOW^XLFDT,XPDA)
 Q
SUAT ; Setup dummy UAT (Unassigned Tasks) BP Servers
 N PL
 S PL=0
 F  S PL=$O(^MAG(2006.1,PL)) Q:'PL  D
 . Q:$D(^MAG(2006.8,"C",PL,"Unassigned Tasks"))  ; Do not re-configure
 . D UAT^MAGQBUT5("",PL)
 Q
ADDRG(CNT) ; Add Raid Groups to the Network Location file
 N PL,I,J,VALUE,NMSP,DUP,TMP,MAGFDA,RESULT
 S PL=0
 K ^MAG(2005.2,"AC"),^MAG(2005.2,"B"),^MAG(2005.2,"C"),^MAG(2005.2,"D"),^MAG(2005.2,"G")
 S DIK="^MAG(2005.2,"
 D IXALL^DIK K DIK
 F  S PL=$O(^MAG(2006.1,PL)) Q:'PL  D
 . Q:$D(^MAG(2005.2,"F",PL,"GRP"))  ; Do not reconfigure
 . S NMSP=$P($G(^MAG(2006.1,PL,0)),U,2)
 . I NMSP="" D  Q
 . . S TMP=$$GET1^DIQ("4",$P($G(^MAG(2006.1,PL,0)),U,1),".01","","","")
 . . D BMES^XPDUTL("No namespace is defined for: "_TMP_" in the Site Parameter file (#2006.1)")
 . . Q
 . D ADDRG^MAGQBUT5(.RESULT,CNT,PL)
 . Q
 Q
AVSET ; Setup Auto-Verify - To run at midnight, nightly (no more than 48 hours, limited to the run)
 N PL,DIERR,MAGERR,MAGFDA
 S PL=0
 F  S PL=$O(^MAG(2006.1,PL)) Q:'PL  D
 . Q:$P($G(^MAG(2006.1,PL,"BPVERIFIER")),U,1)'=""  ; Do not re-configure
 . S MAGFDA(2006.1,PL_",",62)="1" ; SCHEDULED VERIFY
 . S MAGFDA(2006.1,PL_",",62.2)="1" ; SCHEDULED VERIFIER FREQUENCY
 . S MAGFDA(2006.1,PL_",",62.4)="2355" ; SCHEDULED VERIFIER TIME
 . S MAGFDA(2006.1,PL_",",62.3)=$$DT^XLFDT ; DATE OF NEXT VERIFY  
 . D UPDATE^DIE("","MAGFDA","MAGIEN","MAGERR")
 . I $D(DIERR) D
 . . N TMP S TMP=$P(^DIC(4,$O(^DIC(4,"D",$P($G(^MAG(2006.1,PL,0)),U,1),"")),0),U,1)
 . . D BMES^XPDUTL("Error adding default Auto-Verify options to "_TMP_" Error text: "_MAGERR("DIERR",1,"TEXT",1))
 . . Q
 . K MAG,DIERR,MAGFDA,MAGERR
 . Q
 Q
IRG ; Initialize raid groups to group default
 N DA,EN,PC,PL,INDX,ZNODE,GD,MAGIEN,MAGERR,SUBIX
 ;The following sets all duplicate share as READ ONLY in preparation of adding enties to the Group.
 S EN="" S EN=$O(NLIST(EN)) D:EN'=""
 . S EN="" F  S EN=$O(NLIST(EN)) Q:EN=""  D
 . . F PC=2:1:$L(NLIST(EN),U) S DA=$P(NLIST(EN),U,PC) Q:'DA  D:$D(^MAG(2005.2,DA,0))
 . . . I $P(^MAG(2005.2,DA,0),U,7)="MAG",'+$P(^(0),U,9)!($P(^MAG(2005.2,DA,0),U,7)["WORM") D   ;Mag type and not router
 . . . . S MAGFDA(2005.2,DA_",",5.5)=1     ;Set as READ ONLY
 . . . . D FILE^DIE("","MAGFDA","MAGMSG")
 . . . . I $D(MSG("DIERR")) D BMES^XPDUTL("Duplicate entry: '"_DA_" failed to be set offline. ")
 . . . . K MAGFDA,MAGMSG
 . . . . Q
 . . . Q
 . . Q
 . Q
 S PL=0
 F  S PL=$O(^MAG(2006.1,PL)) Q:'PL  D
 . Q:$P($G(^MAG(2006.1,PL,0)),U,10)'=""  ; Do not Re-configure
 . S GD=$O(^MAG(2005.2,"F",PL,"GRP","")) ; first Raid Group
 . Q:'GD
 . S $P(^MAG(2006.1,PL,0),U,10)=GD ; by default set the sites Current Group to the 1st
 . S (INDX,SUBIX)=0
 . F  S INDX=$O(^MAG(2005.2,INDX)) Q:'INDX  D
 . . S ZNODE=$G(^MAG(2005.2,INDX,0))
 . . Q:$P(ZNODE,U,10)'=PL
 . . Q:$P(ZNODE,U,6,7)'["1^MAG"
 . . Q:$P(ZNODE,U,9)="1"  ;ROUTING SHARE
 . . Q:$P(ZNODE,U,8)'="Y"  ;not hashed
 . . Q:$P($G(^MAG(2005.2,INDX,1)),U,6)="1"  ;Read Only
 . . Q:+$P($G(^MAG(2005.2,INDX,1)),U,8)>0  ;Already assigned
 . . S $P(^MAG(2005.2,INDX,1),U,8)=GD
 . . S SUBIX=SUBIX+1
 . . S MAGFDA(2005.22,"+"_SUBIX_","_GD_",",.01)=INDX
 . . D UPDATE^DIE("","MAGFDA","MAGIEN","MAGERR")
 . . I $D(DIERR) D BMES^XPDUTL("Error adding Raid Group subentry: "_MAGERR("DIERR",1,"TEXT",1))
 . . K MAGFDA,DIERR,MSGIEN,MAGERR
 . . Q
 . Q
 Q
ADDMS(INTERVAL) ; Add Message Subjects for Mail Management
 N I,J,K,MAGFDA,MSG,IEN,MAGERR
 S IEN=0
 F  S IEN=$O(^MAG(2006.1,IEN)) Q:'IEN  D
 . F J=1:1:19 S K=$P($T(TEXT+J),";",3) D
 . . Q:$D(^MAG(2006.1,IEN,6,"B",K))  ; Do not re-configure
 . . S MAGFDA(2006.166,"?+1,"_IEN_",",.01)=K
 . . S MAGFDA(2006.166,"?+1,"_IEN_",",1)=INTERVAL
 . . D UPDATE^DIE("","MAGFDA","","MAGERR")
 . . I $D(DIERR) D BMES^XPDUTL("Error updating the BP Mail Message Subfile: "_MAGERR("DIERR",1,"TEXT",1)) K DIERR,MAGERR
 . . Q
 . Q
 Q
ADDMG ; Add Mail Message groups to the Mail Group file (XMB(3.8))
 N PL,NMSP
 S PL=0
 F  S PL=$O(^MAG(2006.1,PL)) Q:'PL  D
 . S NMSP=$P($G(^MAG(2006.1,PL,0)),U,2)
 . Q:NMSP=""
 . D ADD(NMSP)
 . Q
 Q 
ADD(NMSP) ;
 N J,K,L,MAGFDA,MSG,IEN,MAGIEN,MAGERR
 F J=1:1:19 S K=$P($T(TEXT+J),";",3) D
 . I '$D(^XMB(3.8,"B","MAG_"_NMSP_"_"_$E($$TRIM^MAGQBUT4(K),1,20))) D
 . . S L=$O(^XMB(3.8,"B","MAG_"_NMSP_"_"_$E($$TRIM^MAGQBUT4(K),1,20),""))
 . . S MAGFDA(3.8,"?+"_J_",",.01)="MAG_"_NMSP_"_"_$E($$TRIM^MAGQBUT4(K),1,20)
 . . D UPDATE^DIE("","MAGFDA","MAGIEN","MAGERR")
 . . I $D(DIERR) D BMES^XPDUTL("Error Adding Imaging Mail Groups: "_MAGERR("DIERR",1,"TEXT",1)) K DIERR,MAGERR,MAGFDA Q
 . . K MAGFDA,DIERR,MAGERR
 . . S MAGFDA(3.8,MAGIEN(J)_",",4)="PU"
 . . D FILE^DIE("I","MAGFDA","MAGERR")
 . . K MAGFDA,DIERR,MAGERR
 . . S MAGFDA(3.81,"?+1,"_MAGIEN(J)_",",.01)=DUZ
 . . D UPDATE^DIE("","MAGFDA","MAGIEN","MAGERR")
 . . I $D(DIERR) D BMES^XPDUTL("Error Adding Imaging Mail Group member: "_MAGERR("DIERR",1,"TEXT",1))
 . . K DIERR,MAGERR,MAGFDA,MAGIEN
 . E  D
 . . S L=$O(^XMB(3.8,"B","MAG_"_NMSP_"_"_$E($$TRIM^MAGQBUT4(K),1,20),""))
 . . S MAGFDA(3.81,"?+1,"_L_",",.01)=DUZ
 . . D UPDATE^DIE("","MAGFDA","MAGIEN","MAGERR")
 . . I $D(DIERR) D BMES^XPDUTL("Error Adding Imaging Mail Group member: "_MAGERR("DIERR",1,"TEXT",1))
 . . K DIERR,MAGERR,MAGFDA,MAGIEN
 . Q
 Q
DLKP ; Add Generic Mail groups to BP Message subfile
 N PL,I,J,MAGFDA,MSGROOT,MG,DIERR,MAGIEN,MAGERR,NMSP
 S PL=0
 F  S PL=$O(^MAG(2006.1,PL)) Q:'PL  D
 . S I=0,NMSP=$P($G(^MAG(2006.1,PL,0)),U,2)
 . Q:NMSP=""
 . F  S I=$O(^MAG(2006.1,PL,6,I)) Q:'I  D
 . . S MG=$P($G(^MAG(2006.1,PL,6,I,0)),"^",1)
 . . S J=$$FIND1^DIC(3.8,"","","MAG_"_NMSP_"_"_$E($$TRIM^MAGQBUT4(MG),1,20),"","","MSGROOT")
 . . Q:$D(^MAG(2006.1,PL,6,I,1,"B",J))  ; Do not re-configure
 . . I J  D
 . . . S MAGFDA(2006.1662,"+1,"_I_","_PL_",",.01)=J
 . . . D UPDATE^DIE("","MAGFDA","MAGIEN","MAGERR")
 . . . I $D(DIERR) D BMES^XPDUTL("Error Adding Generic Mail Groups: "_MAGERR("DIERR",1,"TEXT",1)) K DIERR,MAGERR
 . . . Q
 . . Q
 . Q
 K MAGFDA,MSGROOT,MAGIEN,MSGROOT
 Q
DPOP ; Set the POP Purge value to a default of 'ON' & Purge Factor as '2'
 N PL,MAGFDA,DIERR,MAGIEN,MAGERR
 S PL=0
 F  S PL=$O(^MAG(2006.1,PL)) Q:'PL  D
 . Q:$P($G(^MAG(2006.1,PL,"BPPURGE")),U,4)'=""  ; Do not re-configure
 . S MAGFDA(2006.1,PL_",",60.2)="1" ;Express Purge ON
 . S MAGFDA(2006.1,PL_",",60)="1" ;Auto Purge ON
 . S MAGFDA(2006.1,PL_",",60.1)="DA" ;Purge by: Date Accessed
 . S MAGFDA(2006.1,PL_",",60.3)="100000" ; Express Purge Rate 100,000
 . S MAGFDA(2006.1,PL_",",60.5)="1" ; Purge Factor
 . D UPDATE^DIE("","MAGFDA","","MAGERR")
 . I $D(DIERR) D BMES^XPDUTL("Error setting the POP/Auto Purge default as 'ON': "_MAGERR("DIERR",1,"TEXT",1))
 . K MAGFDA,MAGERR
 . Q
 Q
PID ;  Add Photo-ID Post Action to the Image Action file
 N MAGFDA,MAGERR,IEN,MSGROOT,ACTIVE,EXPLOC
 ;  If already configured, save and restore active and Export Location parameters 
 S IEN=$O(^MAG(2005.86,"B","PHOTO-ID COPY",""))
 I IEN'="" D
 . S ACTIVE=+$P($G(^MAG(2005.86,IEN,0)),U,2)
 . S EXPLOC=$P($G(^MAG(2005.86,IEN,0)),U,5)
 . S DIK="^MAG(2005.86,",DA=IEN D ^DIK
 . K DIK,DA
 . Q
 E  S ACTIVE="0",EXPLOC=""
 S MAGFDA(2005.86,"?+1,",.01)="PHOTO-ID COPY"
 S MAGFDA(2005.86,"?+1,",1)=ACTIVE
 S MAGFDA(2005.86,"?+1,",2)="PID"
 S MAGFDA(2005.86,"?+1,",3)="MAGQBGCC"
 S MAGFDA(2005.86,"?+1,",4)="This will copy photo ID's to an external share with the Patient's Name as the file name."
 S MAGFDA(2005.86,"?+1,",6)=EXPLOC
 D UPDATE^DIE("","MAGFDA","","MAGERR")
 I $D(DIERR) D BMES^XPDUTL("Error Adding PHOTO-ID Post Process Action: "_MAGERR("DIERR",1,"TEXT",1)) K DIERR,MAGERR
 S IEN=$$FIND1^DIC(2005.86,"","","PHOTO-ID COPY","","","MSGROOT")
 S MAGFDA(2005.865,"?+1,"_IEN_",",.01)="PHOTO ID"
 D UPDATE^DIE("E","MAGFDA","","MAGERR")
 I $D(DIERR) D BMES^XPDUTL("Error Adding PHOTO ID Action type: "_MAGERR("DIERR",1,"TEXT",1)) K DIERR,MAGERR
 K MAGFDA,MAGERR,MSGROOT
 Q
TASKIT(RTN,DESC,MSG) ;
 N MAGDATE,MAGTIME,MAGHR,ZTRTN,ZTDESC,ZTIO,ZTDTH,ZTSK
 Q:$G(RTN)=""!($G(DESC)="")
 S ZTRTN=$G(RTN),ZTDESC=$G(DESC),ZTIO=""
 S MAGDATE=$$NOW^XLFDT(),MAGTIME=$P(MAGDATE,".",2),MAGHR=$E(MAGTIME,1,2)
 I MAGHR>5,MAGHR<17 S MAGTIME=180000
 S MAGDATE=$P(MAGDATE,".")_"."_MAGTIME
 S ZTDTH=MAGDATE
 D ^%ZTLOAD
 D BMES^XPDUTL($G(MSG)_" TASK#: "_ZTSK)
 Q
INDEX ; Kill and Set All indexes for the BP Server file
 K ^MAG(2006.8,"C"),^MAG(2006.8,"D")
 S DIK="^MAG(2006.8," D IXALL^DIK
 K DIK
 K ^MAG(2006.1,"B")
 S DIK="^MAG(2006.1," D IXALL^DIK
 K DIK
 K ^MAG(2005.2,"AC"),^MAG(2005.2,"B"),^MAG(2005.2,"C"),^MAG(2005.2,"D"),^MAG(2005.2,"E"),^MAG(2005.2,"F"),^MAG(2005.2,"G")
 S DIK="^MAG(2005.2," D IXALL^DIK
 K DIK
 Q
RD ;Remove data for retired fields 11.5,11.9,13,14,15,16,17,18,19,21,24,60,61,62,63,64,65 set photo id default
 N PL,PIECE
 S PL=0
 F  S PL=$O(^MAG(2006.1,PL)) Q:'PL  D
 . K ^MAG(2006.1,PL,"JBX") ;2.01,2.02,2.03
 . S $P(^MAG(2006.1,PL,1),U,9)="" ;13
 . K ^MAG(2006.1,PL,"JBEX") ; 14,15,16,17,18,19
 . S $P(^MAG(2006.1,PL,3),U,1)="" ;21
 . S $P(^MAG(2006.1,PL,3),U,7)="" ;11.5 CRITICAL LOW MESSAGE INTERVAL - RETIRED
 . S $P(^MAG(2006.1,PL,3),U,11)="" ;11.9  ; DATE OF LAST CRITICAL MESSAGE - RETIRED
 . S $P(^MAG(2006.1,PL,3),U,4)="99999" ;24 Changed to Photo ID have 99999 set as the default
 . S $P(^MAG(2006.1,PL,5),U,1,6)="^^^^^" ;60,61,62,63,64,65
 . Q
 Q
 ;
PURVER ;Find the first BP server that has a JUKEBOX assignment and add Auto Purge & Scheduled Verify
 N BPNME,BPIEN,SITE,FDA
 S SITE=0 F  S SITE=$O(^MAG(2006.8,"D",SITE)) Q:'SITE  D
 . Q:$D(^MAG(2006.8,"C",SITE,"Unassigned Tasks"))  ;patch has been installed don't execute 
 . S BPNME="" F  S BPNME=$O(^MAG(2006.8,"D",SITE,BPNME)) Q:BPNME=""  D
 . . S BPIEN=$O(^MAG(2006.8,"D",SITE,BPNME,0))
 . . I +$P($G(^MAG(2006.8,BPIEN,0)),U,14) D  ;BP server has JUKEBOX task assigned 
 . . . S FDA(2006.8,BPIEN_",",3)="1",FDA(2006.8,BPIEN_",",4)="1" D FILE^DIE("","FDA")
 . . . Q
 . . Q
 . Q
 Q
RMBPMSG ;The following will remove P39T23's POST_INSTALL_ACQUISITION_SITE message and mail group.
 ;^MAG(2006.1,2,6,"B","Post_Install_Acquisition_Site",8)=
 N DA,DIK,I,L,K,MSG,MSGTXT,NMSP
 S MSG="Post_Install_Acquisition_Site"
 S PL=0  F  S PL=$O(^MAG(2006.1,PL)) Q:'PL  D
 . S I=0,NMSP=$P($G(^MAG(2006.1,PL,0)),U,2)
 . Q:NMSP=""
 . S MSGTXT="MAG_"_NMSP_"_"_$E($$TRIM^MAGQBUT4(MSG),1,20)
 . S K=$$FIND1^DIC(3.8,"","B",MSGTXT) D:+K
 . . S DA=K,DIK="^XMB(3.8," D ^DIK K DA,DIK
 . . Q
 . I $D(^MAG(2006.1,PL,6,"B",MSG)) D
 . . S L=$O(^MAG(2006.1,PL,6,"B",MSG,0)) D:+L
 . . S DA(1)=PL,DA=L,DIK="^MAG(2006.1,"_DA(1)_",6," D ^DIK K DA,DIK
 . . Q
 . Q
 Q
TEXT ; Message Subjects
 ;;Imaging_Integrity_Check
 ;;GCC_Copy_Error
 ;;Application_process_failure
 ;;Image_Cache_Critically_Low
 ;;Monthly_Image_Site_Usage
 ;;Ad_Hoc_Image_Site_Usage
 ;;INSTALLATION
 ;;Image_File_Size_Variance
 ;;Verifier_Scan_Error_log
 ;;Imaging_Site_Verification_Issue
 ;;VI_BP_Queue_Processor_failure
 ;;Photo_I_D_Action
 ;;Get_Next_RAID_Group_failure
 ;;Scheduled_Purge_failure
 ;;Scheduled_Verifier_failure
 ;;Site_report_task_was_restarted
 ;;Auto_RAID_group_purge
 ;;Scheduled_RAID_Group_Adv
 ;;VI_BP_Eval_Queue
 ;
