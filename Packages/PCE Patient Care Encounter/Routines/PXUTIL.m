PXUTIL ;SLC/PKR - Utility routines for use by PX. ;11/06/2017
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**211**;Aug 12, 1996;Build 244
 ;
 ;=================================
ACOPY(REF,OUTPUT) ;Copy all the descendants of the array reference into a linear
 ;array. REF is the starting array reference, for example A or
 ;^TMP("PX",$J). OUTPUT is the linear array for the output. It
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
 ;^TMP("PX",$J).
 N DONE,IND,LEN,LN,PROOT,ROOT,START,TEMP,TEXT
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
 . S LN=LN+1,TEXT(LN)=@REF
 . S REF=$Q(@REF)
 . I REF'[ROOT S DONE=1
 D MES^XPDUTL(.TEXT)
 Q
 ;
 ;=================================
AWRITE(REF) ;Write all the descendants of the array reference, including the
 ;array. REF is the starting array reference, for example A or
 ;^TMP("PX",$J).
 N DONE,IND,LEN,LN,PROOT,ROOT,START,TEMP,TEXT
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
 . S LN=LN+1,TEXT(LN)=PROOT_IND_"="_@REF
 . S REF=$Q(@REF)
 . I REF'[ROOT S DONE=1
 I $D(XPDNM) D MES^XPDUTL(.TEXT)
 E  D EN^DDIOL(.TEXT)
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
FNFR(ROOT) ;Given the root of a file return the file number.
 Q +$P(@(ROOT_"0)"),U,2)
 ;
 ;=================================
GPRINT(REF) ;General printing.
 N DIR,IOTP,POP
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
 . S ZTRTN="GPRINTQ^PXUTIL"
 . S ZTDESC="Queued print job"
 . D ^%ZTLOAD
 . W !,"Task number ",ZTSK
 . D HOME^%ZIS
 . K IO("Q")
 . H 2
 ;If this is being called from List Manager go to full screen.
 I $D(VALMDDF) D FULL^VALM1
 U IO
 S IOTP=IOT
 D APRINT^PXUTIL(REF)
 D ^%ZISC
 I IOTP["TRM" S DIR(0)="E",DIR("A")="Press ENTER to continue" D ^DIR
 I $D(VALMDDF) S VALMBCK="R"
 Q
 ;
 ;=================================
GPRINTQ ;Queued general printing.
 U IO
 D APRINT^PXUTIL(REF)
 D ^%ZISC
 S ZTREQ="@"
 Q
 ;
 ;=================================
RENAME(FILENUM,OLDNAME,NEWNAME) ;Rename entry OLDNAME to NEWNAME in
 ;file number FILENUM.
 N IEN,NIEN,MSG,PXNAT
 S IEN=+$$FIND1^DIC(FILENUM,"","BXU",OLDNAME)
 I IEN=0 Q
 S PXNAT=1
 S NIEN=+$$FIND1^DIC(FILENUM,"","BXU",NEWNAME) I NIEN>0 Q
 S FDA(FILENUM,IEN_",",.01)=NEWNAME
 D FILE^DIE("ET","FDA","MSG")
 Q
 ;
 ;=================================
RMANPC(STRING) ;Remove any non-printing characters from the end of STRING.
 N DONE,LC,LEN
 S DONE=0,LEN=$L(STRING)
 F  Q:DONE  D
 . S LC=$E(STRING,LEN)
 . I (LC=" ")!(LC?1C) S LEN=LEN-1,STRING=$E(STRING,1,LEN)
 . E  S DONE=1
 Q STRING
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
