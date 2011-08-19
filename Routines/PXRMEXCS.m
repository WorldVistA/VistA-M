PXRMEXCS ; SLC/PKR - Routines to compute checksums. ;07/20/2009
 ;;2.0;CLINICAL REMINDERS;**6,12**;Feb 04, 2005;Build 73
 ;====================================================
CHECKSUM(ATTR,START,END) ;Get the the checksum for a packed reminder
 ;component and load it into the attribute array.
 N CS,LINE
 ;If checksum is in packed component return it otherwise calculate it.
 I ATTR("FILE NUMBER")=0 D
 . S LINE=^PXD(811.8,PXRMRIEN,100,START-3,0)
 . S CS=$$GETTAGV^PXRMEXU3(LINE,"<CHECKSUM>")
 . I CS="" S CS=$$PRTNCS(PXRMRIEN,START,END)
 I ATTR("FILE NUMBER")>0 D
 . S LINE=^PXD(811.8,PXRMRIEN,100,START-2,0)
 . S CS=$$GETTAGV^PXRMEXU3(LINE,"<CHECKSUM>")
 . I CS="" S CS=$$PFDACS(PXRMRIEN,START,END)
 S ATTR("CHECKSUM")=CS
 Q
 ;
 ;====================================================
DIQOUTCS(DIQOUT) ;Return checksum for a processed DIQOUT array.
 N CS,DATA,FIELD,FNUM,IENS,IND,SFN,STRING,TARGET,TEXT,WP
 S FNUM=$O(DIQOUT(""))
 D FIELD^DID(FNUM,"EDIT HISTORY","","SPECIFIER","TARGET")
 S SFN=+$G(TARGET("SPECIFIER"))
 S (CS,FNUM)=0
 F  S FNUM=$O(DIQOUT(FNUM)) Q:FNUM=""  D
 . I FNUM=SFN Q
 . S IENS=""
 . F  S IENS=$O(DIQOUT(FNUM,IENS)) Q:IENS=""  D
 .. S FIELD=0
 .. F  S FIELD=$O(DIQOUT(FNUM,IENS,FIELD)) Q:FIELD=""  D
 ... S DATA=DIQOUT(FNUM,IENS,FIELD)
 ... S TEXT=FNUM_$L(IENS,",")_FIELD_DATA
 ... S CS=$$CRC32^XLFCRC(TEXT,CS)
 ... I DATA["WP-start" F IND=1:1:$P(DATA,"~",2) D
 .... S TEXT=DIQOUT(FNUM,IENS,FIELD,IND)
 .... S CS=$$CRC32^XLFCRC(TEXT,CS)
 Q CS
 ;
 ;====================================================
FILE(FILENUM,IEN) ;Return checksum for entry IEN in file FILENUM.
 ;Make sure the entry exists.
 I +$$FIND1^DIC(FILENUM,,"A","`"_IEN)=0 Q 0
 N CS,DIQOUT,IENROOT,MSG
 D GETS^DIQ(FILENUM,IEN,"**","N","DIQOUT","MSG")
 D CLDIQOUT^PXRMEXPD(FILENUM,IEN,"**",.IENROOT,.DIQOUT)
 S CS=$$DIQOUTCS(.DIQOUT)
 Q CS
 ;
 ;====================================================
HFCS(PATH,FILENAME) ;Return checksum for host file.
 N CS,GBL,GBLZISH,SUCCESS
 K ^TMP($J,"PXRMHFCS")
 S GBL="^TMP($J,""PXRMHFCS"")"
 S GBLZISH="^TMP($J,""PXRMHFCS"",1)"
 S GBLZISH=$NA(@GBLZISH)
 S SUCCESS=$$FTG^%ZISH(PATH,FILENAME,GBLZISH,3)
 S CS=$S(SUCCESS:$$HFCSGBL(GBL),1:-1)
 K ^TMP($J,"PXRMHFCS")
 Q CS
 ;
 ;====================================================
HFCSGBL(GBL) ;Return checksum for host file loaded into global GBL.
 N CS,IND,LINE
 S (CS,IND)=0
 F  S IND=$O(@GBL@(IND)) Q:+IND=0  S LINE=@GBL@(IND),CS=$$CRC32^XLFCRC(LINE,CS)
 Q CS
 ;
 ;====================================================
MMCS(XMZ) ;Return checksum for MailMan message ien XMZ.
 N CS,IND,LINE,NLINES
 S NLINES=+$P($G(^XMB(3.9,XMZ,2,0)),U,3)
 S CS=0
 F IND=1:1:NLINES S LINE=$G(^XMB(3.9,XMZ,2,IND,0)),CS=$$CRC32^XLFCRC(LINE,CS)
 Q CS
 ;
 ;====================================================
PFDACS(IEN,FDASTART,FDAEND) ;Return checksum for FDA array of packed
 ;reminder component.
 N CS,DATA,IENS,IND,JND,FIELD,FNUM,SFN,TARGET,TEMP,TEXT
 S TEMP=^PXD(811.8,IEN,100,FDASTART,0)
 S FNUM=$P(TEMP,";",1)
 D FIELD^DID(FNUM,"EDIT HISTORY","","SPECIFIER","TARGET")
 S SFN=+$G(TARGET("SPECIFIER"))
 S CS=0
 F IND=FDASTART:1:FDAEND D
 . S TEMP=^PXD(811.8,IEN,100,IND,0)
 . S DATA=$P(TEMP,"~",2,99)
 . S TEMP=$P(TEMP,"~",1)
 . S FNUM=$P(TEMP,";",1)
 . I FNUM=SFN Q
 . I FNUM="Exchange Stub" Q
 . S IENS=$P(TEMP,";",2)
 . S FIELD=$P(TEMP,";",3)
 . S TEXT=FNUM_$L(IENS,",")_FIELD_DATA
 . S CS=$$CRC32^XLFCRC(TEXT,CS)
 . I DATA["WP-start" F JND=1:1:$P(DATA,"~",2) D
 .. S IND=IND+1
 .. S TEXT=^PXD(811.8,IEN,100,IND,0)
 .. S CS=$$CRC32^XLFCRC(TEXT,CS)
 Q CS
 ;
 ;====================================================
ROUTINE(RA) ;Return checksum for a routine loaded in array RA. RA has the
 ;form created by ^%ZOSF("LOAD") i.e, RA(1,0) ... RA(N,0).
 N CS,IND,TEXT
 S (CS,IND)=0
 ;Get rid of the build number on the second line.
 S RA(2,0)=$P(RA(2,0),";",1,6)
 F  S IND=$O(RA(IND)) Q:+IND=0  D
 . S TEXT=RA(IND,0)
 . S CS=$$CRC32^XLFCRC(RA(IND,0),CS)
 Q CS
 ;
 ;====================================================
RTNCS(ROUTINE) ;Return checksum for a routine ROUTINE.
 N CS,DIF,RA,X,XCNP
 S XCNP=0
 S DIF="RA("
 S X=ROUTINE
 ;Make sure the routine exists.
 X ^%ZOSF("TEST")
 I $T D
 . X ^%ZOSF("LOAD")
 . S CS=$$ROUTINE(.RA)
 E  S CS=-1
 Q CS
 ;
 ;====================================================
PRTNCS(IEN,START,END) ;Return checksum for a packed routine.
 N CS,IND,SL,TEXT
 S CS=0,SL=START+1
 F IND=START:1:END D
 . S TEXT=^PXD(811.8,IEN,100,IND,0)
 . ;Get rid of the build number on the second line.
 . I IND=SL S TEXT=$P(TEXT,";",1,6)
 . S CS=$$CRC32^XLFCRC(TEXT,CS)
 Q CS
 ;
