PXRMUTIL ;SLC/PKR/PJH - Utility routines for use by PXRM. ;05/16/2017
 ;;2.0;CLINICAL REMINDERS;**4,6,11,12,17,18,24,26,47,42**;Feb 04, 2005;Build 80
 ;
 ;=================================
ATTVALUE(STRING,ATTR,SEP,AVSEP) ;STRING contains a list of attribute value
 ;pairs. Each pair is separated by SEP and the attribute value pair
 ;is separated by AVSEP. Return the value for the attribute ATTR.
 N AVPAIR,IND,NUMAVP,VALUE
 S NUMAVP=$L(STRING,SEP)
 S VALUE=""
 F IND=1:1:NUMAVP Q:VALUE'=""  D
 . S AVPAIR=$P(STRING,SEP,IND)
 . I AVPAIR[ATTR S VALUE=$P(AVPAIR,AVSEP,2)
 Q VALUE
 ;
 ;=================================
ACOPY(REF,OUTPUT) ;Copy all the descendants of the array reference into a linear
 ;array. REF is the starting array reference, for example A or
 ;^TMP("PXRM",$J). OUTPUT is the linear array for the output. It
 ;should be in the form of a closed root, i.e., A() or ^TMP($J,).
 ;Note OUTPUT cannot be used as the name of the output array.
 N DONE,IND,LEN,NL,OROOT,OUT,PROOT,ROOT,START,TEMP
 I REF="" Q
 S NL=0
 S OROOT=$P(OUTPUT,")",1)
 S PROOT=$P(REF,")",1)
 ;Build the root so we can tell when we are done.
 S TEMP=$NA(@REF)
 S ROOT=$P(TEMP,")",1)
 S REF=$Q(@REF)
 I REF'[ROOT Q
 S DONE=0
 F  Q:(REF="")!(DONE)  D
 . S START=$F(REF,ROOT)
 . S LEN=$L(REF)
 . S IND=$E(REF,START,LEN)
 . S NL=NL+1
 . S OUT=OROOT_NL_")"
 . S @OUT=PROOT_IND_"="_@REF
 . S REF=$Q(@REF)
 . I REF'[ROOT S DONE=1
 Q
 ;
 ;=================================
APRINT(REF) ;Write all the descendants of the array reference.
 ;REF is the starting array reference, for example A or
 ;^TMP("PXRM",$J).
 N APTEXT,DONE,IND,LEN,LN,PROOT,ROOT,START,TEMP
 I REF="" Q
 S LN=0
 S PROOT=$P(REF,")",1)
 ;Build the root so we can tell when we are done.
 S TEMP=$NA(@REF)
 S ROOT=$P(TEMP,")",1)
 S REF=$Q(@REF)
 I REF'[ROOT Q
 S DONE=0
 F  Q:(REF="")!(DONE)  D
 . S START=$F(REF,ROOT)
 . S LEN=$L(REF)
 . S IND=$E(REF,START,LEN)
 . S LN=LN+1,APTEXT(LN)=@REF
 . S REF=$Q(@REF)
 . I REF'[ROOT S DONE=1
 I $D(XPDNM) D MES^XPDUTL(.APTEXT)
 E  D EN^DDIOL(.APTEXT)
 Q
 ;
 ;=================================
AWRITE(REF) ;Write all the descendants of the array reference, including the
 ;array. REF is the starting array reference, for example A or
 ;^TMP("PXRM",$J).
 N AWTEXT,DONE,IND,LEN,LN,PROOT,ROOT,START,TEMP
 I REF="" Q
 S LN=0
 S PROOT=$P(REF,")",1)
 ;Build the root so we can tell when we are done.
 S TEMP=$NA(@REF)
 S ROOT=$P(TEMP,")",1)
 S REF=$Q(@REF)
 I REF'[ROOT Q
 S DONE=0
 F  Q:(REF="")!(DONE)  D
 . S START=$F(REF,ROOT)
 . S LEN=$L(REF)
 . S IND=$E(REF,START,LEN)
 . S LN=LN+1,AWTEXT(LN)=PROOT_IND_"="_@REF
 . S REF=$Q(@REF)
 . I REF'[ROOT S DONE=1
 I $D(XPDNM) D MES^XPDUTL(.AWTEXT)
 E  D EN^DDIOL(.AWTEXT)
 Q
 ;
 ;=================================
BORP(DEFAULT) ;Ask the user if they want to browse or print.
 N DIR,POP,X,Y
 S DIR(0)="SA"_U_"B:Browse;P:Print"
 S DIR("A")="Browse or Print? "
 S DIR("B")=DEFAULT
 D ^DIR
 I $D(DIROUT) S DTOUT=1
 I $D(DTOUT)!($D(DUOUT)) Q ""
 Q Y
 ;
 ;=================================
DEFURLAD(DEF,NEWURL) ;Add a new URL to a reminder definition.
 N FDA,IEN,IENS,MSG,WPTMP
 S IEN=+$O(^PXD(811.9,"B",DEF,""))
 I IEN=0 Q
 I $D(^PXD(811.9,IEN,50,"B",NEWURL)) Q
 S IENS="+1,"_IEN_","
 S FDA(811.9002,IENS,.01)=NEWURL
 I $D(NEWURL("TITLE")) S FDA(811.9002,IENS,.02)=NEWURL("TITLE")
 I $D(NEWURL("DESC")) D
 . M WPTMP=NEWURL("DESC")
 . S FDA(811.9002,IENS,1)="WPTMP"
 D UPDATE^DIE("","FDA","","MSG")
 Q
 ;
 ;=================================
DEFURLUP(DEF,OLDURL,NEWURL) ;Update a URL in a reminder definition.
 N FDA,IEN,IENS,IND,MSG,WPTMP
 S IEN=+$O(^PXD(811.9,"B",DEF,""))
 I IEN=0 Q
 S IND=+$O(^PXD(811.9,IEN,50,"B",OLDURL,""))
 I IND=0 Q
 S IENS=IND_","_IEN_","
 S FDA(811.9002,IENS,.01)=NEWURL
 I $D(NEWURL("TITLE")) S FDA(811.9002,IENS,.02)=NEWURL("TITLE")
 I $D(NEWURL("DESC")) D
 . M WPTMP=NEWURL("DESC")
 . S FDA(811.9002,IENS,1)="WPTMP"
 D FILE^DIE("","FDA","MSG")
 Q
 ;
 ;=================================
DELTLFE(FILENUM,NAME) ;Delete top level entries from a file.
 N FDA,IENS,MSG
 S IENS=+$$FIND1^DIC(FILENUM,"","BXU",NAME)
 I IENS=0 Q
 S IENS=IENS_","
 S FDA(FILENUM,IENS,.01)="@"
 D FILE^DIE("","FDA","MSG")
 Q
 ;
 ;=================================
DIP(VAR,IEN,PXRMROOT,FLDS) ;Do general inquiry for IEN return formatted
 ;output in VAR. VAR can be either a local variable or a global.
 ;If it is a local it is indexed for the broker. If it is a global
 ;it should be passed in closed form i.e., ^TMP("PXRMTEST",$J).
 ;It will be returned formatted for ListMan i.e.,
 ;^TMP("PXRMTEST",$J,N,0).
 N %ZIS,ARRAY,BY,DC,DHD,DIC,DONE,FF,FILENAME,FILESPEC,FR,GBL,HFNAME
 N IND,IOP,L,NOW,PATH,SUCCESS,TO,UNIQN
 S BY="NUMBER",(FR,TO)=+$P(IEN,U,1),DHD="@@"
 ;Make sure the PXRM WORKSTATION device exists.
 D MKWSDEV^PXRMHOST
 ;Set up the output file before DIP is called.
 S PATH=$$PWD^%ZISH
 S NOW=$$NOW^XLFDT
 S NOW=$TR(NOW,".","")
 S UNIQN=$J_NOW
 S FILENAME="PXRMWSD"_UNIQN_".DAT"
 S HFNAME=PATH_FILENAME
 S IOP="PXRM WORKSTATION;80"
 S %ZIS("HFSMODE")="W"
 S %ZIS("HFSNAME")=HFNAME
 S L=0,DIC=PXRMROOT
 D EN1^DIP
 ;Move the host file into a global.
 S GBL="^TMP(""PXRMUTIL"",$J,1,0)"
 S GBL=$NA(@GBL)
 K ^TMP("PXRMUTIL",$J)
 S SUCCESS=$$FTG^%ZISH(PATH,FILENAME,GBL,3)
 ;Look for a form feed, remove it and all subsequent lines.
 S FF=$C(12)
 I $G(VAR)["^" D
 . S VAR=$NA(@VAR)
 . S VAR=$P(VAR,")",1)
 . S VAR=VAR_",IND,0)"
 . S (DONE,IND)=0
 . F  Q:DONE  S IND=$O(^TMP("PXRMUTIL",$J,IND)) Q:+IND=0  D
 .. I ^TMP("PXRMUTIL",$J,IND,0)=FF S DONE=1 Q
 .. S @VAR=^TMP("PXRMUTIL",$J,IND,0)
 E  D
 . S (DONE,IND)=0
 . F  Q:DONE  S IND=$O(^TMP("PXRMUTIL",$J,IND)) Q:+IND=0  D
 .. S VAR(IND)=^TMP("PXRMUTIL",$J,IND,0)
 .. I VAR(IND)=FF K ARRAY(IND) S DONE=1
 K ^TMP("PXRMUTIL",$J)
 ;Delete the host file.
 S FILESPEC(FILENAME)=""
 S SUCCESS=$$DEL^%ZISH(PATH,$NA(FILESPEC))
 Q
 ;
 ;=================================
EXCHINCK(EXNAME,DPACKED) ;Given the name and the date packed of an Exchange
 ;entry return:
 ; -1 if the entry does not exist
 ;  0 if it has never been installed
 ;  1^installation date/time 
 I $G(EXNAME)="" Q -1
 I $G(DPACKED)="" Q -1
 N DTP,IEN,IND,LASTINDT
 D DT^DILF("ST",DPACKED,.DTP)
 S IEN=+$O(^PXD(811.8,"B",EXNAME,DTP,""))
 I IEN=0 Q -1
 S IND=+$O(^PXD(811.8,IEN,130,"B"),-1)
 I IND=0 Q 0
 S LASTINDT=$P(^PXD(811.8,IEN,130,IND,0),U,1)
 Q 1_U_LASTINDT
 ;
 ;=================================
FNFR(ROOT) ;Given the root of a file return the file number.
 Q +$P(@(ROOT_"0)"),U,2)
 ;
 ;=================================
GPRINT(REF) ;General printing.
 N DIR,POP,SAVEIOT
 S %ZIS="Q"
 D ^%ZIS
 I POP Q
 I $D(IO("Q")) D  Q
 . N ZTDESC,ZTRTN,ZTSAVE
 . S ZTSAVE("IO")=""
 .;Save the evaluated name of REF.
 . S ZTSAVE("REF")=$NA(@$$CREF^DILF(REF))
 .;Save the open root form for TaskMan.
 . S ZTSAVE($$OREF^DILF(ZTSAVE("REF")))=""
 . S ZTRTN="GPRINTQ^PXRMUTIL"
 . S ZTDESC="Queued print job"
 . D ^%ZTLOAD
 . W !,"Task number ",ZTSK
 . D HOME^%ZIS
 . K IO("Q")
 . H 2
 ;If this is being called from List Manager go to full screen.
 I $D(VALMDDF) D FULL^VALM1
 U IO
 D APRINT^PXRMUTIL(REF)
 ;Save IOT before it is reset.
 S SAVEIOT=IOT
 D ^%ZISC
 I SAVEIOT["TRM" S DIR(0)="E",DIR("A")="Press ENTER to continue" D ^DIR
 I $D(VALMDDF) S VALMBCK="R"
 Q
 ;
 ;=================================
GPRINTQ ;Queued general printing.
 U IO
 D APRINT^PXRMUTIL(REF)
 D ^%ZISC
 S ZTREQ="@"
 Q
 ;
 ;=================================
NTOAN(NUMBER) ;Given an integer N return an alphabetic string that can be
 ;used for sorting. This will be modulus 26. For example N=0 returns
 ;A, N=26 returns BA etc.
 N ALPH
 S ALPH(0)="A",ALPH(1)="B",ALPH(2)="C",ALPH(3)="D",ALPH(4)="E"
 S ALPH(5)="F",ALPH(6)="G",ALPH(7)="H",ALPH(8)="I",ALPH(9)="J"
 S ALPH(10)="K",ALPH(11)="L",ALPH(12)="M",ALPH(13)="N",ALPH(14)="O"
 S ALPH(15)="P",ALPH(16)="Q",ALPH(17)="R",ALPH(18)="S",ALPH(19)="T"
 S ALPH(20)="U",ALPH(21)="V",ALPH(22)="W",ALPH(23)="X",ALPH(24)="Y"
 S ALPH(25)="Z"
 ;
 N ANUM,DIGIT,NUM,P26,PC,PWR
 S ANUM="",NUM=NUMBER,PWR=0
 S P26(PWR)=1
 F PWR=1:1 S P26(PWR)=26*P26(PWR-1) I P26(PWR)>NUMBER Q
 S PWR=PWR-1
 F PC=PWR:-1:0 D
 . S DIGIT=NUM\P26(PC)
 . S ANUM=ANUM_ALPH(DIGIT)
 . S NUM=NUM-(DIGIT*P26(PC))
 Q ANUM
 ;
 ;=================================
OPTION(OPTLU,ACTION,OOM,OOMTEXT) ;Out of order loop over options in list.
 N EXISTOOM,IEN,IND,LIST,OPT
 D FIND^DIC(19,"","@;.01","",OPTLU,"*","B","","","LIST")
 F IND=1:1:+LIST("DILIST",0) D
 . S IEN=LIST("DILIST",2,IND)
 . S EXISTOOM=$$GET1^DIQ(19,IEN,2)
 . I (ACTION="DISABLE"),(EXISTOOM'="") Q
 . I (ACTION="ENABLE"),(EXISTOOM'=OOMTEXT) Q
 . S OPT=LIST("DILIST","ID",IND,.01)
 . D OUT^XPDMENU(OPT,OOM)
 Q
 ;
 ;=================================
OPTIONS(ACTION,OOMTEXT) ;Disable/enable options.
 N OOM
 S OOM=$S(ACTION="DISABLE":OOMTEXT,ACTION="ENABLE":"",1:"")
 D BMES^XPDUTL(ACTION_" options.")
 D OPTION^PXRMUTIL("GMTS",ACTION,OOM,OOMTEXT)
 D OPTION^PXRMUTIL("IBDF PRINT",ACTION,OOM,OOMTEXT)
 D OPTION^PXRMUTIL("OR CPRS GUI CHART",ACTION,OOM,OOMTEXT)
 D OPTION^PXRMUTIL("ORS HEALTH SUMMARY",ACTION,OOM,OOMTEXT)
 D OPTION^PXRMUTIL("PXRM",ACTION,OOM,OOMTEXT)
 Q
 ;
 ;=================================
PROTOCOL(PROTLU,ACTION,DISABLE,DISTEXT) ;Disable/enable protocols.
 N EXISTDIS,FDA,IEN,IENS,MSG
 S IEN=+$$FIND1^DIC(101,"","X",PROTLU,"B")
 I IEN=0 Q
 S EXISTDIS=$$GET1^DIQ(101,IEN,2)
 I (ACTION="DISABLE"),(EXISTDIS'="") Q
 I (ACTION="ENABLE"),(EXISTDIS'=DISTEXT) Q
 S IENS=IEN_","
 S FDA(101,IENS,2)=DISABLE
 D FILE^DIE("","FDA","MSG")
 Q
 ;
 ;=================================
PROTCOLS(ACTION,DISTEXT) ;Disable/enable protocols.
 N DISABLE,PROT,RESULT
 S DISABLE=$S(ACTION="DISABLE":DISTEXT,ACTION="ENABLE":"",1:"")
 D BMES^XPDUTL(ACTION_" protocols.")
 ;
 D PROTOCOL^PXRMUTIL("ORS HEALTH SUMMARY",ACTION,DISABLE,DISTEXT)
 D PROTOCOL^PXRMUTIL("ORS AD HOC HEALTH SUMMARY",ACTION,DISABLE,DISTEXT)
 D PROTOCOL^PXRMUTIL("PXRM PATIENT DATA CHANGE",ACTION,DISABLE,DISTEXT)
 Q
 ;
 ;=================================
RENAME(FILENUM,OLDNAME,NEWNAME) ;Rename entry OLDNAME to NEWNAME in
 ;file number FILENUM.
 N DA,DIE,DR,NIEN,PXRMINST,MSG
 S DA=$$FIND1^DIC(FILENUM,"","BXU",OLDNAME,"","","MSG")
 I DA=0 Q
 I $D(MSG) D  Q
 . N TEXT
 . S TEXT(1)="Renaming "_OLDNAME_" in file #"_FILENUM_" failed."
 . S TEXT(2)="Examine the following error message for the reason."
 . S TEXT(3)=""
 . S TEXT(4)="The test update failed, UPDATE^DIE returned the following error message:"
 . D MES^XPDUTL(.TEXT)
 . D AWRITE^PXRMUTIL("MSG")
 . H 2
 S PXRMINST=1
 S NIEN=$$FIND1^DIC(FILENUM,"","BXU",NEWNAME) I NIEN>0 Q
 S DIE=FILENUM
 S DR=".01///^S X=NEWNAME"
 D ^DIE
 Q
 ;
 ;=================================
RMEHIST(FILENUM,IEN) ;Remove the edit history for a reminder file.
 I (FILENUM<800)!(FILENUM>811.9)!(FILENUM=811.8) Q
 N DA,DIK,GLOBAL,ROOT
 S GLOBAL=$$GET1^DID(FILENUM,"","","GLOBAL NAME")
 ;Edit History is stored in node 110 for all files.
 S DA(1)=IEN
 S DIK=GLOBAL_IEN_",110,"
 S ROOT=GLOBAL_IEN_",110,DA)"
 S DA=0
 F  S DA=+$O(@ROOT) Q:DA=0  D ^DIK
 Q
 ;
 ;=================================
SEHIST(FILENUM,ROOT,IEN) ;Set the edit date and edit by and prompt the
 ;user for the edit comment.
 N DIC,DIR,DWLW,DWPK,ENTRY,FDA,FDAIEN,IENS,IND,MSG,SFN,TARGET,X,Y
 K ^TMP("PXRMWP",$J)
 D FIELD^DID(FILENUM,"EDIT HISTORY","","SPECIFIER","TARGET")
 S SFN=+$G(TARGET("SPECIFIER"))
 I SFN=0 Q
 S ENTRY=ROOT_IEN_",110)"
 S IND=$O(@ENTRY@("B"),-1)
 S IND=IND+1
 S IENS="+"_IND_","_IEN_","
 S FDAIEN(IEN)=IEN
 S FDA(SFN,IENS,.01)=$$FMTE^XLFDT($$NOW^XLFDT,"5Z")
 S FDA(SFN,IENS,1)=$$GET1^DIQ(200,DUZ,.01)
 ;Prompt the user for edit comments.
 S DIC="^TMP(""PXRMWP"",$J,"
 S DWLW=72
 S DWPK=1
 W !,"Input your edit comments."
 S DIR(0)="Y"_U_"AO"
 S DIR("A")="Edit"
 S DIR("B")="NO"
 D ^DIR
 I Y D
 . D EN^DIWE
 . K ^TMP("PXRMWP",$J,0)
 . I $D(^TMP("PXRMWP",$J)) S FDA(SFN,IENS,2)="^TMP(""PXRMWP"",$J)"
 D UPDATE^DIE("E","FDA","FDAIEN","MSG")
 I $D(MSG) D AWRITE^PXRMUTIL("MSG")
 K ^TMP("PXRMWP",$J)
 Q
 ;
 ;=================================
SETPVER(VERSION) ;Set the package version
 N DA,DIE,DR
 S DIE="^PXRM(800,",DA=1,DR="5////"_VERSION
 D ^DIE
 Q
 ;
 ;=================================
SFRES(SDIR,NRES,FIEVAL) ;Save the finding result.
 I NRES=0 S FIEVAL=0 Q
 N DATE,IND,OA,SUB,TF
 F IND=1:1:NRES S OA(FIEVAL(IND,"DATE"),FIEVAL(IND),IND)=""
 ;If SDIR is positive get the oldest date otherwise get the most
 ;recent date.
 S DATE=$S(SDIR>0:$O(OA("")),1:$O(OA(""),-1))
 ;If there is a true finding on DATE get it.
 S TF=$O(OA(DATE,""),-1)
 S IND=$O(OA(DATE,TF,""))
 S FIEVAL=TF
 S SUB=""
 F  S SUB=$O(FIEVAL(IND,SUB)) Q:SUB=""  M FIEVAL(SUB)=FIEVAL(IND,SUB)
 Q
 ;
 ;=================================
SSPAR(FIND0,NOCC,BDT,EDT) ;Set the finding search parameters.
 S BDT=$P(FIND0,U,8),EDT=$P(FIND0,U,11),NOCC=$P(FIND0,U,14)
 I +NOCC=0 S NOCC=1
 ;Convert the dates to FileMan dates.
 S BDT=$S(BDT="":0,BDT=0:0,1:$$CTFMD^PXRMDATE(BDT))
 I EDT="" S EDT="T"
 S EDT=$$CTFMD^PXRMDATE(EDT)
 ;If EDT does not contain a time set it to the end of the day.
 I (EDT'=-1),EDT'["." S EDT=EDT_".235959"
 I $G(PXRMDDOC)'=1 Q
 S ^TMP("PXRMDDOC",$J,$P(FIND0,U,1,11))=BDT_U_EDT
 Q
 ;
 ;=================================
STRREP(STRING,TS,RS) ;Replace every occurrence of the target string (TS)
 ;in STRING with the replacement string (RS).
 ;Example 9.19 (page 220) in "The Complete Mumps" by John Lewkowicz:
 ;  F  Q:STRING'[TS  S STRING=$P(STRING,TS)_RS_$P(STRING,TS,2,999)
 ;fails if any portion of the target string is contained in the with
 ;string. Therefore a more elaborate version is required.
 ;
 N IND,NPCS,STR
 I STRING'[TS Q STRING
 ;Count the number of pieces using the target string as the delimiter.
 S NPCS=$L(STRING,TS)
 ;Extract the pieces and concatenate RS
 S STR=""
 F IND=1:1:NPCS-1 S STR=STR_$P(STRING,TS,IND)_RS
 S STR=STR_$P(STRING,TS,NPCS)
 Q STR
 ;
 ;=================================
UPEHIST(FILENUM,IEN,TEXT,MSG) ;Update the edit history.
 N FDA,GBL,IENS,IND,LN,NEXT,SUBFN,TARGET,WPTMP
 D FIELD^DID(FILENUM,"EDIT HISTORY","","SPECIFIER","TARGET")
 S SUBFN=+$G(TARGET("SPECIFIER"))
 I SUBFN=0 Q
 S GBL=$$GET1^DID(FILENUM,"","","GLOBAL NAME")_IEN_",110)"
 S NEXT=$O(@GBL@("B"),-1)+1
 S (IND,LN)=0
 F  S IND=$O(TEXT(IND)) Q:IND=""  D
 . S LN=LN+1
 . S WPTMP(1,2,LN)=TEXT(IND)
 S IENS="+"_NEXT_","_IEN_","
 S FDA(SUBFN,IENS,.01)=$$NOW^XLFDT
 S FDA(SUBFN,IENS,1)=$G(DUZ)
 S FDA(SUBFN,IENS,2)="WPTMP(1,2)"
 D UPDATE^DIE("","FDA","","MSG")
 Q
 ;
 ;=================================
VEDIT(ROOT,IEN) ;This is used as a DIC("S") screen to select which entries
 ;a user can edit.
 N CLASS,ENTRY,VALID
 S ENTRY=ROOT_IEN_")"
 S CLASS=$P($G(@ENTRY@(100)),U,1)
 I CLASS="N" D
 . I ($G(PXRMINST)=1),(DUZ(0)="@") S VALID=1
 . E  S VALID=0
 E  S VALID=1
 Q VALID
 ;
