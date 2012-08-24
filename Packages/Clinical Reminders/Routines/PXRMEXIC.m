PXRMEXIC ;SLC/PKR/PJH - Routines to install repository entry components. ;2/17/2012
 ;;2.0;CLINICAL REMINDERS;**6,12,17,16,18,22**;Feb 04, 2005;Build 160
 ;=================================================
FILE(PXRMRIEN,SITEIEN,IND120,JND120,ACTION,ATTR,NAMECHG) ;Read and process a
 ;file entry in repository entry PXRMRIEN. IND120 and JND120 are the
 ;indexes for the component list. ACTION is one of the possible actions.
 I ACTION="S" Q
 N DATA,DUZ0S,EDULIST,FDA,FDAEND,FDASTART,FIELD,FILENUM
 N IEN,IENS,IENREND,IENROOT,IENRSTR,IENUSED,IND,INDICES
 N LINE,MSG,NAME,NEW01,PXNAT,PXRMEDOK,PXRMEXCH
 N SRCIEN,START,TEMP,TEXT,TFDA,TIENROOT,TIUFPRIV,TNAME,TOPFNUM,VERSN,XUMF
 N WPLCNT,WPTMP
 ;I $G(PXRMIGDS) S DUZ0S=DUZ(0),DUZ(0)="^",XUMF=1
 ;Set PXRMEDOK so files pointing to sponsors can be installed.
 ;Set PXRMEXCH so national entries can be installed and prevent
 ;execution of the input transform for custom logic fields.
 ;Set PXNAT to allow installation of national (those starting with VA-)
 ;PCE items.
 S (PXNAT,PXRMEDOK,PXRMEXCH)=1
 S TEMP=^PXD(811.8,PXRMRIEN,120,IND120,1,JND120,0)
 S FDASTART=+$P(TEMP,U,2)
 S FDAEND=+$P(TEMP,U,3)
 S IENRSTR=+$P(TEMP,U,4)
 S IENREND=+$P(TEMP,U,5)
 F IND=FDASTART:1:FDAEND D
 . S LINE=^PXD(811.8,PXRMRIEN,100,IND,0)
 . S INDICES=$P(LINE,"~",1)
 . S DATA=$P(LINE,"~",2)
 . S FILENUM=$P(INDICES,";",1)
 . S IENS=$P(INDICES,";",2)
 . I IND=FDASTART S SRCIEN=+IENS
 . S FIELD=$P(INDICES,";",3)
 . I LINE["WP-start" D
 .. S DATA="WPTMP("_IND_","_+FIELD_")"
 .. S WPLCNT=$P(LINE,"~",3)
 .. D WORDPROC(PXRMRIEN,.WPTMP,IND,+FIELD,.IND,WPLCNT)
 . I (IND=FDASTART)&((FIELD=.01)!(FIELD=.001)) D
 ..;Save the top level file number.
 .. S TOPFNUM=FILENUM
 ..;If the action is copy put it in the first open spot. PCE files go
 ..;in the site number space.
 .. I ACTION="C" D
 ... S START=$S($$ISPCEFIL^PXRMEXU0(TOPFNUM):$P($$SITE^VASITE,U,3)_"000",1:0)
 ... S IENROOT(SRCIEN)=$$LOIEN^PXRMEXU5(TOPFNUM,START)
 ..;
 ..;If the entry does not exist and the action is not copy set the
 ..;action to install.
 .. I SITEIEN=0 S ACTION="I"
 ..;
 ..;If the action is install try to install at the source ien. If
 ..;an entry already exists at the source ien put it in the first
 ..;open spot. For PCE entries install at source ien unless they
 ..;are national.
 .. I ACTION="I" D
 ... S IENUSED=+$$FIND1^DIC(FILENUM,"","Q","`"_SRCIEN)
 ... S IENROOT(SRCIEN)=$S(IENUSED=0:SRCIEN,1:$$LOIEN^PXRMEXU5(FILENUM))
 ... I $$ISPCEFIL^PXRMEXU0(TOPFNUM) D
 .... I IENUSED=0 S IENROOT(SRCIEN)=SRCIEN
 .... I IENUSED>0 D
 ..... S START=$S(IENUSED>100000:$E(IENUSED,1,3)_"000",1:0)
 ..... S IENROOT(SRCIEN)=$$LOIEN^PXRMEXU5(TOPFNUM,START)
 .... I $G(PXRMMNAT) S IENROOT(SRCIEN)=$$LOIEN^PXRMEXU5(TOPFNUM)
 ..;
 ..;If the action is merge, overwrite,or update install at the site's
 ..;ien.
 .. I (ACTION="M")!(ACTION="O")!(ACTION="U") S IENROOT(SRCIEN)=SITEIEN
 .;
 .;This line is use to convert pre-patch 12 disable text to the new
 .;value of 1 for disable
 . I FILENUM=801.41,FIELD=3,DATA'="",$L(DATA)>1 S DATA=1
 . S FDA(FILENUM,IENS,FIELD)=DATA
 ;
 ;Initialize the edit history.
 D INIEH(TOPFNUM,IENS,.FDA,.WPTMP)
 ;Build the IENROOT
 F IND=IENRSTR:1:IENREND D
 . I IND=0 Q
 . S TEMP=^PXD(811.8,PXRMRIEN,100,IND,0)
 . S IENROOT($P(TEMP,U,1))=$P(TEMP,U,2)
 ;Check for name changes, i.e., the copy action.
 D NAMECHG(.FDA,.NAMECHG,TOPFNUM)
 ;
 ;Special handling for file 142.
 I TOPFNUM=142 D  Q:'$D(FDA)
 . D SFMVPI^PXRMEXIU(.FDA,.NAMECHG,142.14)
 ;
 ;Special handling for file 801
 I TOPFNUM=801 D  Q:PXRMDONE
 . D SFMVPI^PXRMEXIU(.FDA,.NAMECHG,801.015)
 . D ROC^PXRMEXU5(.FDA)
 ;
 ;Special handling for file 801.1
 I TOPFNUM=801.1 D  Q:PXRMDONE
 . D ROCR^PXRMEXU5(.FDA)
 ;
 ;Special handling for file 801.41
 I TOPFNUM=801.41 D  Q:PXRMDONE
 . I ACTION="M" D MOU^PXRMEXU5(801.41,SITEIEN,"**",.FDA,.IENROOT,ACTION,.WPTMP)
 . I ACTION="U" D MOU^PXRMEXU5(801.41,SITEIEN,"18*",.FDA,.IENROOT,ACTION,.WPTMP)
 . D DLG^PXRMEXU4(.FDA,.NAMECHG)
 ;
 ;Special handling for file 810.9
 I TOPFNUM=810.9 D LOC^PXRMEXU0(.FDA)
 ;
 ;If the file number is 811.4 the user must have programmer
 ;access to install it.
 I (TOPFNUM=811.4)&(DUZ(0)'="@") D  Q
 . W !,"Only programmers can install Reminder Computed Findings."
 ;
 ;Special handling for file 811.5.
 I TOPFNUM=811.5 D  Q:'$D(FDA)
 .;If the site has any findings already mapped merge them in.
 . I (ACTION="M")!(ACTION="U") D MOU^PXRMEXU5(811.5,SITEIEN,"20*",.FDA,.IENROOT,ACTION,.WPTMP)
 . D SFMVPI^PXRMEXIU(.FDA,.NAMECHG,811.52)
 ;
 ;Special handling for file 811.9.
 I TOPFNUM=811.9 D
 .;Don't execute the input transform for custom logic fields.
 . S PXRMEXCH=1
 . D DEF^PXRMEXIU(.FDA,.NAMECHG)
 ;
 ;Special handling for file 9999999.09, EDUCATION TOPICS.
 I TOPFNUM=9999999.09 D
 . S IENS=$O(FDA(TOPFNUM,""))
 . S EDULIST(FDA(TOPFNUM,IENS,.01))=""
 ;
 ;Special handling for file 8925.1
 I TOPFNUM=8925.1 D
 . S TIUFPRIV=1
 . D TIUOBJ^PXRMEXIU(.FDA)
 ;
 ;Special handling for file 9999999.64.
 I TOPFNUM=9999999.64 D
 . D HF^PXRMEXIU(.FDA,.NAMECHG)
 ;
 ;If FDA is not defined at this point the user has opted to abort
 ;the install.
 I '$D(FDA) Q
 ;
 ;If the action is merge, overwrite, or update do a test install
 ;before deleting the original entry.
 I (ACTION="M")!(ACTION="O")!(ACTION="U") D
 .;Make the .01 unique for the test install.
 . S IENS=$O(FDA(TOPFNUM,""))
 .;Get the length of the .01 field
 . D FIELD^DID(TOPFNUM,.01,"","FIELD LENGTH","ATTR")
 . S TNAME="tmp"_$E(FDA(TOPFNUM,IENS,.01),1,ATTR("FIELD LENGTH")-3)
 .;Make sure the test entry does not already exist.
 . D DELALL^PXRMEXFI(TOPFNUM,TNAME)
 . M TFDA=FDA
 . S TFDA(TOPFNUM,IENS,.01)=TNAME
 . K TIENROOT M TIENROOT=IENROOT
 . S TIENROOT(SRCIEN)=$$LOIEN^PXRMEXU5(TOPFNUM)
 . D UPDATE^DIE("E","TFDA","TIENROOT","MSG")
 . I $D(MSG) D  Q
 .. S TEXT(1)=ATTR("FILE NAME")_" entry "_$G(ATTR("PT01"))_" did not get installed!"
 .. S TEXT(2)="Examine the following error message for the reason."
 .. S TEXT(3)=""
 .. S TEXT(4)="The test update failed, UPDATE^DIE returned the following error message:"
 .. D MES^XPDUTL(.TEXT)
 .. D AWRITE^PXRMUTIL("MSG")
 .. H 2
 .;Delete the test entry.
 . D DELALL^PXRMEXFI(TOPFNUM,TNAME)
 .;If the original update worked put the entry at its original ien.
 .;Delete the existing entry.
 . D DELETE^PXRMEXFI(TOPFNUM,SITEIEN)
 D UPDATE^DIE("E","FDA","IENROOT","MSG")
 I $D(MSG) D
 . S TEXT(1)=ATTR("FILE NAME")_" entry "_$G(ATTR("PT01"))_" did not get installed!"
 . S TEXT(2)="Examine the following error message for the reason."
 . S TEXT(3)=""
 . S TEXT(4)="The update failed, UPDATE^DIE returned the following error message:"
 . D MES^XPDUTL(.TEXT)
 . D AWRITE^PXRMUTIL("MSG")
 . W !
 . H 2
 S VERSN=$$GETTAGV^PXRMEXU3(^PXD(811.8,PXRMRIEN,100,3,0),"<PACKAGE_VERSION>")
 I TOPFNUM=811.2 D
 .;Rebuild taxonomy expansions.
 . N IEN,PXRMEXCH
 . S IEN=+$O(^PXD(811.2,"B",ATTR("PT01"),""))
 . I IEN>0 D EXPAND^PXRMBXTL(IEN,"")
 I TOPFNUM=811.9,VERSN=1.5 D
 . N IEN,PXRMEXCH,X
 . S IEN=+$O(^PXD(811.9,"B",ATTR("PT01"),""))
 . I IEN=0 Q
 .;For reminder definitions build the found/not found text counts.
 . D SFNFTC^PXRMEXU0(IEN)
 .;Build the internal logic and finding strings.
 . S X=$G(^PXD(811.9,IEN,30))
 . I X'="" D CPPCLS^PXRMLOGX(IEN,X)
 . S X=$G(^PXD(811.9,IEN,34))
 . I X'="" D CPRESLS^PXRMLOGX(IEN,X)
 . D BLDALL^PXRMLOGX(IEN,"","")
 ;If there are national education topics rename them so they start
 ;with VA-
 I $D(EDULIST),$G(PXRMMNAT) D
 .;Get the length of the .01 field
 . D FIELD^DID(TOPFNUM,.01,"","FIELD LENGTH","ATTR")
 . S NAME=""
 . F  S NAME=$O(EDULIST(NAME)) Q:NAME=""  D
 .. I $E(NAME,1,3)="VA-" Q
 .. S TNAME="VA-"_$E(ATTR("FIELD LENGTH")-3)
 .. D RENAME^PXRMUTIL(TOPFNUM,NAME,TNAME)
 ;I $G(PXRMIGDS) S DUZ(0)=DUZ0S
 Q
 ;
 ;=================================================
INIEH(FILENUM,IENS,FDA,WPTMP) ;If the file is a clinical reminder file and
 ;it has an edit history initialize the history.
 I (FILENUM<800)!(FILENUM>811.9) Q
 N IENS,SFN,TARGET,WP
 D FIELD^DID(FILENUM,"EDIT HISTORY","","SPECIFIER","TARGET")
 S SFN=+$G(TARGET("SPECIFIER"))
 I SFN=0 Q
 S IENS=$O(FDA(SFN,""))
 I IENS="" Q
 S FDA(SFN,IENS,.01)=$$FMTE^XLFDT($$NOW^XLFDT,"5Z")
 S FDA(SFN,IENS,1)="`"_DUZ
 ;The word-processing field is set when the packing is done.
 S WP=FDA(SFN,IENS,2)
 K @WP
 S @WP@(1)="Exchange Install"
 Q
 ;
 ;=================================================
NAMECHG(FDA,NAMECHG,FILENUM) ;If this component has been copied to a new
 ;name make the change.
 N CLASS,IENS,PT01
 S IENS=$O(FDA(FILENUM,""))
 S PT01=FDA(FILENUM,IENS,.01)
 I $D(NAMECHG(FILENUM,PT01)) D
 . S FDA(FILENUM,IENS,.01)=NAMECHG(FILENUM,PT01)
 . I (FILENUM<801.41)!(FILENUM>811.9) Q
 .;Once a component has been copied CLASS can no longer be national.
 . S CLASS=$G(FDA(FILENUM,IENS,100))
 . I CLASS["N" S FDA(FILENUM,IENS,100)="LOCAL"
 .;The Sponsor is also removed.
 . K FDA(FILENUM,IENS,101)
 Q
 ;
 ;=================================================
RTNLD(PXRMRIEN,START,END,ATTR,RTN) ;Load a routine from the repository into
 ;the array RTN.
 N IND,LINE,LN,ROUTINE
 S LINE=^PXD(811.8,PXRMRIEN,100,START,0)
 S ROUTINE=$P(LINE,";",1)
 S ROUTINE=$TR(ROUTINE," ","")
 S ATTR("FILE NUMBER")=0
 S ATTR("NAME")=$P(LINE,";",1)
 S ATTR("NAME")=$TR(ATTR("NAME")," ","")
 S ATTR("MIN FIELD LENGTH")=3
 S ATTR("FIELD LENGTH")=8
 S LN=0
 F IND=START:1:END D
 . S LN=LN+1
 . S LINE=^PXD(811.8,PXRMRIEN,100,IND,0)
 . S RTN(LN,0)=LINE
 Q
 ;
 ;=================================================
RTNSAVE(RTN,NAME) ;Save the routine loaded in RTN to the name
 ;found in NAMECHG.
 N DIE,XCN
 ;%ZOSF("SAVE") requires a global.
 K ^TMP($J,"PXRMRTN")
 S DIE="^TMP($J,""PXRMRTN"","
 M ^TMP($J,"PXRMRTN")=RTN
 S XCN=0
 S X=NAME
 X ^%ZOSF("SAVE")
 K ^TMP($J,"PXRMRTN")
 Q
 ;
 ;=================================================
WORDPROC(PXRMRIEN,WPTMP,I1,I2,IND,WPLCNT) ;Load WPTMP with the word
 ;processing field.
 N I3
 F I3=1:1:WPLCNT D
 . S IND=IND+1
 . S WPTMP(I1,I2,I3)=$G(^PXD(811.8,PXRMRIEN,100,IND,0))
 Q
 ;
