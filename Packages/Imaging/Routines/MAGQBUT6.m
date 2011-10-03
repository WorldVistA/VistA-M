MAGQBUT6 ;WIOFO/RMP - Utility to Consolidate Redundant Network Location file Entries ; 18 Jan 2011 5:21 PM
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
CHKNAM(MAG) ; This is the input transform for the PLACE field in the Network location file.
 N IEN,PLACE,VALUE
 Q:'$D(MAG)
 I 'DUZ(2) D  K X Q
 . D EN^DDIOL("You may only edit records for the configuration to which your login is associated!")
 . Q
 S PLACE=$$PLACE^MAGBAPI(+$G(DUZ(2)))
 I $D(DA),$P($G(^MAG(2005.2,DA,0)),U,10),PLACE'=$P($G(^MAG(2005.2,DA,0)),U,10) D  K X Q
 . D EN^DDIOL("You may only edit records for the configuration to which your login is associated!")
 . Q
 S IEN="",VALUE=MAG
 F  S IEN=$O(^MAG(2005.2,"B",VALUE,IEN)) Q:'IEN  D
 . Q:$G(DA)=IEN
 . I $P($G(^MAG(2005.2,IEN,0)),U,10)=PLACE D
 . . D EN^DDIOL("Duplicate NAMES within the same VistA Imaging configuration (PLACE) is not allowed.")
 . . K X
 . . Q
 . Q
 Q
CHKNET(MAG) ; This is the input transform for the share path (PHYSICAL REFERENCE  FIELD #1) in the network location file.
 N UPPER,VALUE,PLACE,TABLE,IEN,TEMP,FAILED ; should convert all physical reference values to upper case
 Q:'$D(MAG)
 I '$G(DUZ(2)) D  K X Q
 . D EN^DDIOL("You may only edit records for the configuration to which your login is associated!")
 . Q
 S VALUE="",PLACE=$$PLACE^MAGBAPI(+$G(DUZ(2)))
 I PLACE'=$P($G(^MAG(2005.2,DA,0)),U,10),DA'["+1" D  K X Q
 . D EN^DDIOL("You may only edit records for the configuration to which your login is associated!")
 . Q 
 S UPPER=$$UPPER^MAGQE4(MAG),FAILED=""
 F  S VALUE=$O(^MAG(2005.2,"G",PLACE,VALUE)) Q:VALUE=""  D  Q:'$D(X)
 . I UPPER=$$UPPER^MAGQE4(VALUE) D
 . . S IEN=""
 . . F  S IEN=$O(^MAG(2005.2,"G",PLACE,VALUE,IEN)) Q:'IEN  D  Q:FAILED
 . . . S TEMP=$P(^MAG(2005.2,IEN,0),U,7)_U_$P(^MAG(2005.2,IEN,0),U,8)_U_$P(^MAG(2005.2,IEN,0),U,9)
 . . . I $D(TABLE(TEMP)) S FAILED=1 Q
 . . . S TABLE(TEMP)=""
 . . . Q
 . . I +FAILED D  Q
 . . D EN^DDIOL("Duplicate PHYSICAL REFERENCE values within the same VistA Imaging configuration (PLACE) is not allowed.")
 . . K X
 . . Q
 . Q
 K TABLE
 Q
CONSHR ;  This is the interface for the Consolidate redundant shares utility
 N LIST,EN,ENTRY,FLDAR,PLACE
 S PLACE=$O(^MAG(2006.1,"B",$$KSP^XUPARAM("INST"),""))
 D GETRL^MAGQBU6A(.LIST) ;  Get Redundant List (of shares) where the path is the same.
 S EN=$O(LIST("")) I EN="" D  Q
 . D PMSG("======================================================================")
 . D DFNIQ^MAGQBPG1(""," Production Account: "_$$PROD^XUPROD("1"),0,PLACE,"Consolidate Shares")
 . D PMSG(" Imaging patch MAG*3.0*39 found no redundant Network Location shares to consolidate.")
 . D DFNIQ^MAGQBPG1("","Installation: Redundant Network Location Utility",1,PLACE,"Consolidate Shares")
 . Q
 D PMSG("======================================================================")
 D DFNIQ^MAGQBPG1(""," Production Account: "_$$PROD^XUPROD("1"),0,PLACE,"Consolidate Shares")
 D PMSG("Redundant Share List ")
 D PMSG("(Share ^ Hash ^ Place) Prime IEN ^ 2nd IEN ...")
 S EN="" F  S EN=$O(LIST(EN)) Q:EN=""  D PMSG("("_EN_")"_LIST(EN))
 D PMSG("======================================================================")
 D PMSG("")
 D PMSG("Here is the list of shares that will be consolidated")
 D PMSG("The share references that exist in both the 2005, 2005.1 & 2006.035 files")
 D PMSG("will be reset to the PRIME share entry. ")
 D DSPNL^MAGQBU6A ; Display the original Network Location file
 D FAR(.FLDAR) ; Setup File/Node/Piece Table for FieldNumbers
 ;The following is being performed during the post install phase.
 ;D PRIME(.LIST) ; If any like shares are on - set the prime shares on
 D SFRP(.LIST) ; DESTINATION field (#1) of the SEND QUEUE File (#2006.035)
 ;The following is being performed during the post install phase.
 ;D SPRR(.LIST) ; Site Parameter file re-reference (#.03,.07,.08,1.02,1.03,2.01,52,53,55)
 S ENTRY=0 D RSREF(.LIST,ENTRY) ; Consolidate references
 D RLOC^MAGQBU6A(.LIST) ; Delete Network Location file entry
 D REQDUP^MAGQBU6A ; rename any duplicate .01 network location entries.
 D REPNAM^MAGQBU6A ;Report residual duplicate names
 D DFNIQ^MAGQBPG1("","Installation: Redundant Network Location Utility",1,PLACE,"Consolidate Shares")
 K LIST
 K ^TMP($J,"MAGQDFN")
 Q
PRIME(LIST) ; If any like shares are on - set the prime shares on
 N EMSG,EN,PC,FDA,MSG,PTMP,TMP
 S EN="" F  S EN=$O(LIST(EN)) Q:EN=""  D
 . S PTMP=$P(^MAG(2005.2,($P(LIST(EN),U)),0),U,6) Q:PTMP  D
 . . S FDA(2005.2,$P(LIST(EN),U,1)_",",5)="1"
 . . D FILE^DIE("I","FDA","MSG")
 . . I $D(MSG("DIERR")) D PMSG("Prime entry: '"_IEN_" failed to be set online. "_MSG("DIERR",1,"TEXT",1)) D  Q
 . . . K FDA,MSG
 . . . Q
 . . S EMSG="Prime entry "_$P(^MAG(2005.2,$P(LIST(EN),U),0),U)_", ^MAG(2005.2,"_$P(LIST(EN),U)_",0), was set to Online."
 . . D DFNIQ^MAGQBPG1("",EMSG,0,PLACE,"Consolidate Shares")
 . . K FDA,MSG
 . . Q
 . Q
 Q
SPRR(LIST) ; Site Parameter file re-reference (#.03,.07,.08,1.02,1.03,2.01,52,53,55)
 N EN,FDA,NEW,MSG,OLD,PC,MSG,TMP,VALUE
 S EN=0 F  S EN=$O(^MAG(2006.1,EN)) Q:'EN  D
 . ; fields: .03,.07,.08
 . F PC=3,7,8 S (VALUE,TMP)=$P($G(^MAG(2006.1,EN,0)),U,PC) D
 . . S VALUE=$$FRP(VALUE,.LIST) I VALUE D
 . . . S FDA(2006.1,EN_",",FLDAR(2006.1,0,PC))=VALUE
 . . . D FILE^DIE("I","FDA","MSG")
 . . . I $D(MSG("DIERR")) D  Q
 . . . . D PMSG("Site Parameter Filing Error for IEN: "_IEN_MSG("DIERR",1,"TEXT",1)) K FDA,MSG
 . . . . Q
 . . . S FLD=$P(FLDAR(2006.1,0,PC),"^"),OLD=$P(^MAG(2005.2,TMP,0),"^"),NEW=$P(^MAG(2005.2,VALUE,0),"^")
 . . . D PMSG("Field #"_FLDAR(2006.1,0,PC)_" Value: "_OLD_" Changed to New Value: "_NEW)
 . . . D PMSG("^MAG(2006.1,"_EN_",0)"_" Piece "_PC) K FDA,MSG
 . . . Q
 . . Q
 . ; fields: 1.02, 1.03
 . F PC=2,3 S (VALUE,TMP)=$P($G(^MAG(2006.1,EN,"PACS")),U,PC) D
 . . S VALUE=$$FRP(VALUE,.LIST) I VALUE D
 . . . S FDA(2006.1,EN_",",FLDAR(2006.1,"PACS",PC))=VALUE
 . . . D FILE^DIE("I","FDA","MSG")
 . . . I $D(MSG("DIERR")) D  Q
 . . . . D PMSG("Site Parameter Filing Error for IEN: "_EN_MSG("DIERR",1,"TEXT",1)) K FDA,MSG
 . . . . Q
 . . . S OLD=$P(^MAG(2005.2,TMP,0),"^"),NEW=$P(^MAG(2005.2,VALUE,0),"^")
 . . . D PMSG("Field #"_FLDAR(2006.1,"PACS",PC)_" Value: "_OLD_" Changed to New Value: "_NEW)
 . . . D PMSG("^MAG(2006.1,"_EN_",PACS)"_" Piece "_PC) K FDA,MSG
 . . . Q
 . . Q
 . ; field: 2.01
 . S (VALUE,TMP)=$P($G(^MAG(2006.1,EN,1)),U,6) D
 . . S VALUE=$$FRP(VALUE,.LIST) I VALUE D
 . . . S FDA(2006.1,EN_",",FLDAR(2006.1,1,6))=VALUE
 . . . D FILE^DIE("I","FDA","MSG")
 . . . I $D(MSG("DIERR")) D  Q
 . . . . D PMSG("Site Parameter Filing Error for IEN: "_EN_" "_MSG("DIERR",1,"TEXT",1)) K FDA,MSG
 . . . . Q
 . . . S OLD=$P(^MAG(2005.2,TMP,0),"^"),NEW=$P(^MAG(2005.2,VALUE,0),"^")
 . . . D PMSG("Field #"_FLDAR(2006.1,1,6)_" Value: "_OLD_" Changed to New Value: "_NEW)
 . . . D PMSG("^MAG(2006.1,"_EN_",1)"_" Piece "_6) K FDA,MSG
 . . . Q
 . . Q
 . ; fields: 52,53,55
 . F PC=3,4,5 S (VALUE,TMP)=$P($G(^MAG(2006.1,EN,"NET")),U,PC) D
 . . S VALUE=$$FRP(VALUE,.LIST) I VALUE D
 . . . S FDA(2006.1,EN_",",FLDAR(2006.1,"NET",PC))=VALUE
 . . . D FILE^DIE("I","FDA","MSG")
 . . . I $D(MSG("DIERR")) D  Q
 . . . . D PMSG("Site Parameter Filing Error for IEN: "_EN_" "_MSG("DIERR",1,"TEXT",1)) K FDA,MSG
 . . . . Q
 . . . S OLD=$P(^MAG(2005.2,TMP,0),"^"),NEW=$P(^MAG(2005.2,VALUE,0),"^")
 . . . D PMSG("Field #"_FLDAR(2006.1,"NET",PC)_" Value: "_OLD_" Changed to New Value: "_NEW)
 . . . D PMSG("^MAG(2006.1,"_EN_",NET)"_" Piece "_PC) K FDA,MSG
 . . . Q
 . . Q
 . Q
 Q
SFRP(LIST) ; DESTINATION field (#1) of the SEND QUEUE File (#2006.035).
 N EN,VALUE,TMP,FDA,MSG,TEXT,TMP,OLD
 S EN=0 F  S EN=$O(^MAGQUEUE(2006.035,EN)) Q:'EN  D
 . I $P($P($G(^MAGQUEUE(2006.035,EN,0)),U,2),";",2)="MAG(2005.2," D
 . . S (VALUE,TMP)=$P($P($G(^MAGQUEUE(2006.035,EN,0)),U,2),";",1)
 . . S VALUE=$$FRP(VALUE,.LIST) I VALUE D
 . . . S TMP=$P($G(^MAGQUEUE(2006.035,EN,0)),U,2),OLD=$P(TMP,";"),$P(TMP,";")=VALUE
 . . . S $P(^MAGQUEUE(2006.035,EN,0),U,2)=TMP,OLD=$P(^MAG(2005.2,OLD,0),U),NEW=$P(^MAG(2005.2,VALUE,0),U)
 . . . S TEXT=("DESTINATION (#1) value: "_OLD_" changed to: "_NEW)
 . . . S ^XTMP("MAGP39","IMAGEFILE",2006.035,EN,1)=TEXT
 . . . Q
 . . Q
 . Q
 Q
RSREF(LIST,IEN) ; Consolidate references
 N GL,IEN,IENS,NODE,PIECE,FNUM,VALUE,SIEN,SPIECE,SNODE,FLD,SUB,MSG,FDA,TMP,TEXT
 S GL="",IEN=$S(+$G(IEN):IEN,1:0)
 F  D SCAN^MAGQBPG1(.IEN,"F",.GL) D  Q:'IEN
 . Q:'IEN
 . S FNUM=$S(GL[2005.1:2005.1,GL[2005:2005,1:"")
 . S NODE=$G(^MAG(FNUM,IEN,0))
 . F PIECE=3,4,5 S (VALUE,TMP)=$P(NODE,U,PIECE) D:VALUE
 . . S VALUE=$$FRP(VALUE,.LIST) I VALUE D
 . . . S FDA(FNUM,IEN_",",FLDAR(FNUM,0,PIECE))=VALUE
 . . . D FILE^DIE("I","FDA","MSG")
 . . . I $D(MSG("DIERR")) D  Q
 . . . . D PMSG($S(FNUM=2005:"Image File",1:"Image Archive")_" Filing Error for entry: "_IEN_MSG("DIERR",1,"TEXT",1)) K FDA,MSG
 . . . . Q
 . . . S TEXT="FIELD #"_FLDAR(FNUM,0,PIECE)_" value: "_TMP_" changed to: "_VALUE
 . . . S ^XTMP("MAGP39","IMAGEFILE",FNUM,IEN,$G(FLDAR(FNUM,0,PIECE)))=TEXT
 . . . Q
 . . Q
 . S NODE=$G(^MAG(FNUM,IEN,"FBIG"))
 . F PIECE=1,2 S VALUE=$P(NODE,U,PIECE) D:VALUE
 . . S (VALUE,TMP)=$$FRP(VALUE,.LIST) I VALUE D
 . . . S FDA(FNUM,IEN_",",FLDAR(FNUM,"FBIG",PIECE))=VALUE
 . . . D FILE^DIE("I","FDA","MSG")
 . . . I $D(MSG("DIERR")) D  Q
 . . . . D PMSG($S(FNUM=2005:"Image File",1:"Image Archive")_" Filing Error for IEN: "_IEN_MSG("DIERR",1,"TEXT",1)) K FDA,MSG
 . . . . Q
 . . . S TEXT="FIELD #"_FLDAR(FNUM,"FBIG",PIECE)_" Value: "_TMP_" changed to: "_VALUE
 . . . S ^XTMP("MAGP39","IMAGEFILE",FNUM,IEN,$G(FLDAR(FNUM,"FBIG",PIECE)))=TEXT
 . . . Q
 . . Q
 . F SNODE=4,5,6 I $D(^MAG(FNUM,IEN,SNODE)) D  ;ROUTING TIMESTAMP, EXPORT LOCATION, ROUTING LOG
 . . S SIEN=0,SPIECE=$S(SNODE=4:2,SNODE=5:1,SNODE=6:2) F  S SIEN=$O(^MAG(FNUM,IEN,SNODE,SIEN)) Q:'SIEN  D
 . . . S (VALUE,TMP)=$P($G(^MAG(FNUM,IEN,SNODE,SIEN,0)),U,SPIECE)
 . . . S VALUE=$$FRP(VALUE,.LIST) I VALUE D
 . . . . I SNODE=4,FNUM=2005 S SUB=2005.0106
 . . . . I SNODE=4,FNUM=2005.1 S SUB=2005.1106
 . . . . I SNODE=5,FNUM=2005 S SUB=2005.01
 . . . . I SNODE=5,FNUM=2005.1 S SUB=2005.11
 . . . . I SNODE=6,FNUM=2005 S SUB=2005.0111
 . . . . I SNODE=6,FNUM=2005.1 S SUB=2005.1111
 . . . . S IENS=SIEN_","_IEN_","
 . . . . S FDA(SUB,IENS,FLDAR(SUB,0,SPIECE))=VALUE
 . . . . D FILE^DIE("I","FDA","MSG")
 . . . . I $D(MSG("DIERR")) D  Q
 . . . . . D PMSG($S(FNUM=2005:"Image File",1:"Image Archive")_" Filing Error for IEN: "_IEN_MSG("DIERR",1,"TEXT",1)) K FDA,MSG
 . . . . . Q
 . . . . S TEXT=SUB_" FIELD #"_FLDAR(SUB,0,SPIECE)_" value: "_TMP_" changed to: "_VALUE
 . . . . S ^XTMP("MAGP39","IMAGEFILE",FNUM,IEN,SUB_$G(FLDAR(SUB,0,SPIECE)))=TEXT
 . . . . Q
 . . . Q
 . . Q
 . S ^XTMP("MAGP39","DUPSHARE","LAST")=IEN
 . Q
 Q
FRP(IEN,LIST) ;Find entry number in list and return the primary
 N EN,PN,PC
 S EN="",PN=0 F  S EN=$O(LIST(EN)) Q:EN=""  D  Q:PN
 . I (U_$P(LIST(EN),U,2,99)_U)[(U_IEN_U) S PN=$P(LIST(EN),U)
 . Q
 Q PN
PMSG(TXT) ; Display to Screen and Build E-MAIL content
 D DFNIQ^MAGQBPG1("",TXT,0,PLACE,"Consolidate Shares")
 Q
FAR(FLDAR) ; Setup File/Node/Piece Table for FieldNumbers
 S FLDAR(2006.1,0,3)=.03
 S FLDAR(2006.1,0,7)=.07
 S FLDAR(2006.1,0,8)=.08
 S FLDAR(2006.1,1,6)=2.01
 S FLDAR(2006.1,"PACS",2)=1.02
 S FLDAR(2006.1,"PACS",3)=1.03
 S FLDAR(2006.1,"NET",3)=52
 S FLDAR(2006.1,"NET",4)=53
 S FLDAR(2006.1,"NET",5)=55
 S FLDAR(2005,0,3)=2
 S FLDAR(2005,0,4)=2.1
 S FLDAR(2005,0,5)=2.2
 S FLDAR(2005,"FBIG",1)=102
 S FLDAR(2005,"FBIG",2)=103
 S FLDAR(2005.1,0,3)=2
 S FLDAR(2005.1,0,4)=2.1
 S FLDAR(2005.1,0,5)=2.2
 S FLDAR(2005.1,"FBIG",1)=102
 S FLDAR(2005.1,"FBIG",2)=103
 S FLDAR(2005.0106,0,2)=2
 S FLDAR(2005.1106,0,2)=2
 S FLDAR(2005.01,0,1)=.01
 S FLDAR(2005.11,0,1)=.01
 S FLDAR(2005.0111,0,2)=2
 S FLDAR(2005.1111,0,2)=2
 Q
RTRS ;Check to see if any network locations are routers & send an email
 N EN,IEN,IENS,NLIST,PRIME,RTR,SITE
 D GETRL^MAGQBU6A(.NLIST) S PLACE=$O(^MAG(2006.1,"B",$$KSP^XUPARAM("INST"),""))
 S EN=$O(NLIST("")) I EN="" Q  ;No duplicate network locations.
 S (RTR,EN)="" F  S EN=$O(NLIST(EN)) Q:EN=""  F PC=2:1:$L(NLIST(EN),U) D
 . I $P(^MAG(2005.2,+$P(NLIST(EN),U,PC),0),U,9) S RTR(EN)=$G(NLIST(EN)) Q
 . Q
 S EN=$O(RTR("")) I EN="" Q  ;No duplicate router network locations.
 D RMSG S EN="" F  S EN=$O(RTR(EN)) Q:EN=""  D 
 . S IEN=$P(RTR(EN),U),PRIME=$P(^MAG(2005.2,+IEN,0),U),SITE=$P(^MAG(2005.2,+IEN,0),U,10)
 . D PMSG("Prime entry is IEN:"_IEN_" Name: "_PRIME_" "_$P(^MAG(2005.2,+IEN,0),U,2)_" SITE: "_$P(^MAG(2006.1,+SITE,0),U))
 . D PMSG("  Duplicate entries that are marked for deletion: ") F PC=2:1:$L(RTR(EN),U) D
 . . D PMSG("   IEN: "_+$P(RTR(EN),U,PC)_" Name: "_$P(^MAG(2005.2,+$P(RTR(EN),"^",PC),0),U))
 . . Q
 . Q
 D:$G(PRIME)]"" DFNIQ^MAGQBPG1("","Installation: Possible Duplicate Router Shares",1,PLACE,"Consolidate Shares")
 Q
RMSG ;
 D PMSG("The following entries may be defined as 'ROUTERS'.")
 D PMSG("Review the ROUTE.DIC file on each Routing DICOM Gateway")
 D PMSG("and replace any duplicate entries with prime entries.")
 D PMSG("======================================================================")
 Q
