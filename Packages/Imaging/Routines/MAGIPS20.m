MAGIPS20 ;Pre-init routine to queue site activity at install.
 ;;3.0;IMAGING;**20**;Apr 12, 2006
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; |                                                               |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed             |
 ;; | in any way.  Modifications to this software may result in an  |
 ;; | adulterated medical device under 21CFR820, the use of which   |
 ;; | is considered to be a violation of US Federal Statutes.       |
 ;; +---------------------------------------------------------------+
 ;;
EC ; This is the Patch 20 Environment Check Routine
 N MESSAGE,ERR
 S ERR=0
 I DUZ(2)'=$$KSP^XUPARAM("INST") D
 . S MESSAGE="You must be logged in to the same institution on which you"
 . D BMES^XPDUTL(MESSAGE)
 . S MESSAGE="are installing this KIDS package"
 . D BMES^XPDUTL(MESSAGE)
 . S MESSAGE="Your DUZ(2) is: "_$G(DUZ(2))_" and the host system is: "_$$KSP^XUPARAM("INST")
 . D BMES^XPDUTL(MESSAGE)
 . S XPDQUIT=2 Q
 I '$P($G(^MAG(2006.1,$O(^MAG(2006.1," "),-1),0)),U),(+$P($G(^MAG(2006.1,0)),U,4))>1 D
 . S MESSAGE="Your Site Parameter file has more than one entry."
 . D BMES^XPDUTL(MESSAGE)
 . S MESSAGE="In order for the post-install"
 . D BMES^XPDUTL(MESSAGE)
 . S MESSAGE="to successfully convert your system it is necessary"
 . D BMES^XPDUTL(MESSAGE)
 . S MESSAGE="to remove the inactive Site Parameter file entry."
 . D BMES^XPDUTL(MESSAGE)
 . S XPDQUIT=2 Q
 I DUZ(2)=$$KSP^XUPARAM("INST"),ERR=0  D
 . S MESSAGE="Environment check: OK!"
 . D BMES^XPDUTL(MESSAGE) Q
 ;
 Q
PRE ; Remove DD field definitions so that new definition can be laid down cleanly
 N DIK,DA
 S DIK="^DD(2005,",DA=1,DA(1)=2005 D ^DIK
 S DIK="^DD(2005.1,",DA=1,DA(1)=2005.1 D ^DIK
 S DIK="^DD(2005.2,",DA=.04,DA(1)=2005.2 D ^DIK
 S DIK="^DD(2005.2,",DA=1,DA(1)=2005.2 D ^DIK
 S DIK="^DD(2005.2,",DA=2,DA(1)=2005.2 D ^DIK
 S DIK="^DD(2005.2,",DA=3,DA(1)=2005.2 D ^DIK
 S DIK="^DD(2005.2,",DA=4,DA(1)=2005.2 D ^DIK
 S DIK="^DD(2005.2,",DA=6,DA(1)=2005.2 D ^DIK
 S DIK="^DD(2005.2,",DA=14,DA(1)=2005.2 D ^DIK
 S DIK="^DD(2005.2,",DA=26,DA(1)=2005.2 D ^DIK
 S DIK="^DD(2005.04,",DA=1,DA(1)=2005.04 D ^DIK
 S DIK="^DD(2005.04,",DA=2,DA(1)=2005.04 D ^DIK
 S DIK="^DD(2006.1,",DA=.01,DA(1)=2006.1 D ^DIK
 S DIK="^DD(2006.1,",DA=.02,DA(1)=2006.1 D ^DIK
 S DIK="^DD(2006.1,",DA=.03,DA(1)=2006.1 D ^DIK
 S DIK="^DD(2006.1,",DA=.04,DA(1)=2006.1 D ^DIK
 S DIK="^DD(2006.1,",DA=.07,DA(1)=2006.1 D ^DIK
 S DIK="^DD(2006.1,",DA=.08,DA(1)=2006.1 D ^DIK
 S DIK="^DD(2006.1,",DA=1.01,DA(1)=2006.1 D ^DIK
 S DIK="^DD(2006.1,",DA=1.02,DA(1)=2006.1 D ^DIK
 S DIK="^DD(2006.1,",DA=1.03,DA(1)=2006.1 D ^DIK
 S DIK="^DD(2006.1,",DA=2.01,DA(1)=2006.1 D ^DIK
 S DIK="^DD(2006.1,",DA=2.02,DA(1)=2006.1 D ^DIK
 S DIK="^DD(2006.1,",DA=2.03,DA(1)=2006.1 D ^DIK
 S DIK="^DD(2006.1,",DA=6,DA(1)=2006.1 D ^DIK
 S DIK="^DD(2006.1,",DA=8,DA(1)=2006.1 D ^DIK
 S DIK="^DD(2006.1,",DA=9,DA(1)=2006.1 D ^DIK
 S DIK="^DD(2006.1,",DA=11,DA(1)=2006.1 D ^DIK
 S DIK="^DD(2006.1,",DA=21,DA(1)=2006.1 D ^DIK
 S DIK="^DD(2006.1,",DA=22,DA(1)=2006.1 D ^DIK
 S DIK="^DD(2006.1,",DA=25,DA(1)=2006.1 D ^DIK
 S DIK="^DD(2006.1,",DA=64,DA(1)=2006.1 D ^DIK
 S DIK="^DD(2006.1,",DA=102,DA(1)=2006.1 D ^DIK
 S DIK="^DD(2006.1,",DA=103,DA(1)=2006.1 D ^DIK
 S DIK="^DD(2006.1,",DA=201,DA(1)=2006.1 D ^DIK
 S DIK="^DD(2006.81,",DA=.04,DA(1)=2006.81 D ^DIK
 S DIK="^DD(2006.82,",DA=.04,DA(1)=2006.82 D ^DIK
 S DIK="^DD(2006.82,",DA=2,DA(1)=2006.82 D ^DIK
 D RX ;Remove "A" cross-references from the site parameter file
 ;remove file definitions so that the new file definitions will lay down cleanly
 N DIU
 F DIU=2006.03,2006.031,2006.032,2006.8,2006.12,2006.1201,2006.12201 D
 . S DIU(0)="" D EN^DIU2
 . Q
 D RMRPC("MAGQ FS CHNGE") ; Removing an RPC so that the revison installs cleanly
 Q
RX ; REMOVE A SET OF CROSS REFERENCES
 N FILE,FIELD,CROSSREF,IEN,NAME
 S CROSSREF="^ALTR^ARITE^AIMPORT^AIMDELBIG^AIMDELPACS^AIMDELPACS2^AIMDELPACS3^AIMDELPACSBIG^"
 S CROSSREF=CROSSREF_"AJBXDEV^AJBXTOT^AJBXPTR^APACS^APXDR^APXWRITE^ATRABS^"
 S FILE=2006.1,NAME=""
 F FIELD=.02,.03,.08,22,9,102,103,21,2.01,2.02,2.03,1.01,1.02,1.03,6 D
 . S IEN=$$CREF(FILE,FIELD,CROSSREF,.NAME) I IEN D
 . . K RXERR
 . . D DELIX^DDMOD(FILE,FIELD,IEN,"KW","MYOUT","RXERR")
 . . I $D(^DD(FILE,0,"IX",NAME,FILE,FIELD)) K ^DD(FILE,0,"IX",NAME,FILE,FIELD)
 . . Q
 . Q
 Q
CREF(FILE,FIELD,CROSSREF,NAME) ;
 N I,J
 S I=0 F  S I=I+1 Q:'$D(^DD(FILE,FIELD,1,I,0))  Q:CROSSREF[("^"_$P(^DD(FILE,FIELD,1,I,0),U,2)_"^")
 S J=1 F  S J=J+1 S NAME=$P(CROSSREF,U,J) Q:NAME=""  Q:$D(^DD(FILE,0,"IX",NAME,FILE,FIELD))
 Q $S(NAME'="":I,1:0)
RMRPC(NAME) ; Removing an RPC in order to revise
 N MW,RPC,MWE,DIERR
 S MW=$$FIND1^DIC(19,"","X","MAG WINDOWS","","","")
 D CLEAN^DILF
 Q:'MW
 S RPC=$$FIND1^DIC(8994,"","X",NAME,"","","")
 D CLEAN^DILF
 Q:'RPC
 S MWE=$$FIND1^DIC(19.05,","_MW_",","X","NAME","","","")
 D CLEAN^DILF
 Q:'MWE
 S DA=MWE,DA(1)=MW,DIK="^DIC(19,"_DA(1)_",""RPC"","
 D ^DIK
 K DA,DIK
 S DA=RPC,DIK="^XWB(8994,"
 D ^DIK
 K DA,DIK
 Q
 ;
