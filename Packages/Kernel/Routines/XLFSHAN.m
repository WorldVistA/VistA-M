XLFSHAN ;ISL/PKR SHA secure hash routines. ;2018-05-03  4:05 PM
 ;;8.0;KERNEL;**657,10003**;Jul 10, 1995;Build 9
 ;
 D TEST^XLFSHANT
 QUIT
 ;
 ;=============================
AND(X,Y) ;Bitwise logical AND, 32 bits. IA #6157
 ; NB: NON-PORTABLE. GT.M PROGRAM IS DIFFERENT.
 I ^%ZOSF("OS")["OpenM" Q $ZBOOLEAN(X,Y,1) ;Cache
 I ^%ZOSF("OS")["GT.M" Q $ZBITAND(X,Y)
 S $EC=",U-UNIMPLEMENTED,"
 ;
 ;=============================
OR(X,Y) ;Bitwise logical OR, 32 bits. IA #6157
 ; NB: NON-PORTABLE. GT.M PROGRAM IS DIFFERENT.
 I ^%ZOSF("OS")["OpenM" Q $ZBOOLEAN(X,Y,7) ;Cache
 I ^%ZOSF("OS")["GT.M" Q $ZBITOR(X,Y)
 S $EC=",U-UNIMPLEMENTED,"
 ;
 ;=============================
XOR(X,Y) ;Bitwise logical XOR, 32 bits. IA #6157
 ; NB: NON-PORTABLE. GT.M PROGRAM IS DIFFERENT.
 I ^%ZOSF("OS")["OpenM" Q $ZBOOLEAN(X,Y,6) ;Cache
 I ^%ZOSF("OS")["GT.M" Q $ZBITXOR(X,Y)
 S $EC=",U-UNIMPLMENTED,"
 ;
 ;=============================
CHASHLEN(HASHLEN) ;Make sure the hash length is one of the acceptable
 ;values.
 I HASHLEN=160 Q 1
 I HASHLEN=224 Q 1
 I HASHLEN=256 Q 1
 I HASHLEN=384 Q 1
 I HASHLEN=512 Q 1
 Q 0
 ;
 ;=============================
CPUTIME() ;Returns two comma-delimited pieces, "system" CPU time and "user"
 ;CPU time (except on VMS where no separate times are available).
 ;Time is returned as milliseconds of CPU time.
 ; ZEXCEPT: Process,GetCPUTime
 I ^%ZOSF("OS")["OpenM" Q $SYSTEM.Process.GetCPUTime()
 I ^%ZOSF("OS")["GT.M" Q $ZGETJPI("","CPUTIM")*10
 S $EC=",U-UNIMPLEMENTED,"
 ;
 ;
 ;=============================
ETIMEMS(START,END) ;Calculate and return the elapsed time in milliseconds.
 ;START and STOP times are set by calling $$CPUTIME.
 N ETIME,TEXT
 S END=$P(END,",",2)
 S START=$P(START,",",2)
 S ETIME=END-START
 S TEXT=ETIME_" milliseconds"
 Q TEXT
 ;
 ;=============================
FILE(HASHLEN,FILENUM,IEN,FIELD,FLAGS) ;Return a SHA hash for the specified
 ;file entry. IA #6157
 I '$$CHASHLEN(HASHLEN) Q -1
 N IENS,IND,FIELDNUM,FNUM,HASH,MSG,NBLOCKS,NL,TARGET,TEMP,TEXT,WPI,WPZN
 K ^TMP($J,"XLFDIQ"),^TMP($J,"XLFMSG")
 S TARGET=$NA(^TMP($J,"XLFDIQ"))
 S WPI=$P(TARGET,")",1)
 S FLAGS=$G(FLAGS)
 S WPZN=$S(FLAGS["Z":1,1:0)
 I $G(FIELD)="" S FIELD="**"
 D GETS^DIQ(FILENUM,IEN,FIELD,FLAGS,TARGET,"XLFMSG")
 I $D(MSG) Q 0
 ;Build the message array
 S NBLOCKS=0,(FNUM,TEMP)=""
 F  S FNUM=$O(^TMP($J,"XLFDIQ",FNUM)) Q:FNUM=""  D
 . S IENS=""
 . F  S IENS=$O(^TMP($J,"XLFDIQ",FNUM,IENS)) Q:IENS=""  D
 .. S FIELDNUM=""
 .. F  S FIELDNUM=$O(^TMP($J,"XLFDIQ",FNUM,IENS,FIELDNUM)) Q:FIELDNUM=""  D
 ... S TEXT(0)=$G(^TMP($J,"XLFDIQ",FNUM,IENS,FIELDNUM))
 ... S TEXT("E")=$G(^TMP($J,"XLFDIQ",FNUM,IENS,FIELDNUM,"E"))
 ... S TEXT("I")=$G(^TMP($J,"XLFDIQ",FNUM,IENS,FIELDNUM,"I"))
 ... N JND F JND=0,"E","I" D
 .... I TEXT(JND)="" Q
 .... S TEXT=TEXT(JND)
 ....;Do not include the word-processing field indicator.
 .... I TEXT'[WPI D
 ..... F IND=1:1:$L(TEXT) D
 ...... S TEMP=TEMP_$E(TEXT,IND)
 ...... I $L(TEMP)=1024 S NBLOCKS=NBLOCKS+1,^TMP($J,"XLFMSG",NBLOCKS)=TEMP,TEMP=""
 .... I TEXT[WPI D
 ..... S NL=0
 ..... F  S NL=+$O(^TMP($J,"XLFDIQ",FNUM,IENS,FIELDNUM,NL)) Q:NL=0  D
 ...... I WPZN S TEXT=^TMP($J,"XLFDIQ",FNUM,IENS,FIELDNUM,NL,0)
 ...... E  S TEXT=^TMP($J,"XLFDIQ",FNUM,IENS,FIELDNUM,NL)
 ...... F IND=1:1:$L(TEXT) D
 ....... S TEMP=TEMP_$E(TEXT,IND)
 ....... I $L(TEMP)=1024 S NBLOCKS=NBLOCKS+1,^TMP($J,"XLFMSG",NBLOCKS)=TEMP,TEMP=""
 I $L(TEMP)>0 S NBLOCKS=NBLOCKS+1,^TMP($J,"XLFMSG",NBLOCKS)=TEMP
 K ^TMP($J,"XLFDIQ")
 S HASH=$$LSHAN(HASHLEN,"XLFMSG",NBLOCKS)
 K ^TMP($J,"XLFMSG")
 Q HASH
 ;
 ;=============================
GENAREF(HASHLEN,AREF,DATAONLY) ;Return an SHA hash for a general array. AREF
 ;is the starting array reference, for example ABC or ^TMP($J,"XX").
 ;IA #6157
 I '$$CHASHLEN(HASHLEN) Q -1
 N DONE,HASH,IND,LEN,NBLOCKS,PROOT,ROOT,START,TEMP,TEXT
 I AREF="" Q 0
 S PROOT=$P(AREF,")",1)
 S TEMP=$NA(@AREF)
 S ROOT=$P(TEMP,")",1)
 S AREF=$Q(@AREF)
 I AREF'[ROOT Q 0
 S TEMP=""
 S (DONE,NBLOCKS)=0
 F  Q:(AREF="")!(DONE)  D
 . S START=$F(AREF,ROOT)
 . I DATAONLY S TEXT=@AREF
 . E  S LEN=$L(AREF),IND=$E(AREF,START,LEN),TEXT=PROOT_IND_"="_@AREF
 . F IND=1:1:$L(TEXT) D
 .. S TEMP=TEMP_$E(TEXT,IND)
 .. I $L(TEMP)=1024 S NBLOCKS=NBLOCKS+1,^TMP($J,"XLFMSG",NBLOCKS)=TEMP,TEMP=""
 . S AREF=$Q(@AREF)
 . I AREF'[ROOT S DONE=1
 I $L(TEMP)>0 S NBLOCKS=NBLOCKS+1,^TMP($J,"XLFMSG",NBLOCKS)=TEMP
 S HASH=$$LSHAN(HASHLEN,"XLFMSG",NBLOCKS)
 K ^TMP($J,"XLFMSG")
 Q HASH
 ;
 ;=============================
GLOBAL(HASHLEN,FILENUM,DATAONLY) ;Return an SHA hash for a global. IA #6157
 I '$$CHASHLEN(HASHLEN) Q -1
 N DONE,HASH,IND,NBLOCKS,ROOT,ROOTN,TEMP,TEXT
 S ROOT=$$ROOT^DILFD(FILENUM)
 I ROOT="" Q 0
 S ROOTN=$TR(ROOT,",",")")
 S TEMP=$L(ROOTN)
 I $E(ROOTN,TEMP)="(" S ROOTN=$E(ROOTN,1,(TEMP-1))
 K ^TMP($J,"XLFMSG")
 S NBLOCKS=0,TEMP=""
 S DONE=0
 F  Q:DONE  D
 . S ROOTN=$Q(@ROOTN)
 . I (ROOTN="")!(ROOTN'[ROOT) S DONE=1 Q
 . I DATAONLY S TEXT=@ROOTN
 . E  S TEXT=ROOTN_"="_@ROOTN
 . F IND=1:1:$L(TEXT) D
 .. S TEMP=TEMP_$E(TEXT,IND)
 .. I $L(TEMP)=1024 S NBLOCKS=NBLOCKS+1,^TMP($J,"XLFMSG",NBLOCKS)=TEMP,TEMP=""
 I $L(TEMP)>0 S NBLOCKS=NBLOCKS+1,^TMP($J,"XLFMSG",NBLOCKS)=TEMP
 S HASH=$$LSHAN(HASHLEN,"XLFMSG",NBLOCKS)
 K ^TMP($J,"XLFMSG")
 Q HASH
 ;
 ;=============================
HOSTFILE(HASHLEN,PATH,FILENAME) ;Return a SHA hash for a host file. IA #6157
 I '$$CHASHLEN(HASHLEN) Q -1
 N GBLZISH,HASH,IND,LN,OVFLN,NBLOCKS,SUCCESS,TEMP,TEXT
 K ^TMP($J,"HF")
 S GBLZISH="^TMP($J,""HF"",1)"
 S GBLZISH=$NA(@GBLZISH)
 S SUCCESS=$$FTG^%ZISH(PATH,FILENAME,GBLZISH,3)
 I 'SUCCESS Q 0
 S (NBLOCKS,LN)=0,TEMP=""
 F  S LN=+$O(^TMP($J,"HF",LN)) Q:LN=0  D
 . S TEXT=^TMP($J,"HF",LN)
 . F IND=1:1:$L(TEXT) D
 .. S TEMP=TEMP_$E(TEXT,IND)
 .. I $L(TEMP)=1024 S NBLOCKS=NBLOCKS+1,^TMP($J,"XLFMSG",NBLOCKS)=TEMP,TEMP=""
 .;Check for overflow lines
 . I '$D(^TMP($J,"HF",LN,"OVF")) Q
 . S OVFLN=0
 . F  S OVFLN=+$O(^TMP($J,"HF",LN,"OVF",OVFLN)) Q:OVFLN=0  D
 .. S TEXT=^TMP($J,"HF",LN,"OVF",OVFLN)
 .. F IND=1:1:$L(TEXT) D
 ... S TEMP=TEMP_$E(TEXT,IND)
 ... I $L(TEMP)=1024 S NBLOCKS=NBLOCKS+1,^TMP($J,"XLFMSG",NBLOCKS)=TEMP,TEMP=""
 I $L(TEMP)>0 S NBLOCKS=NBLOCKS+1,^TMP($J,"XLFMSG",NBLOCKS)=TEMP
 K ^TMP($J,"HF")
 S HASH=$$LSHAN(HASHLEN,"XLFMSG",NBLOCKS)
 K ^TMP($J,"XLFMSG")
 Q HASH
 ;
 ;=============================
LSHAN(HASHLEN,MSUB,NBLOCKS) ;SHA hash for a message too long for a single
 ;string. Cache objects version. IA #6157
 ;The message is in ^TMP($J,MSUB,N) where N goes from 1 to NBLOCKS.
 ;
 I ^%ZOSF("OS")["OpenM" G LSHANONT
 I ^%ZOSF("OS")["GT.M" G LSHANGUX
 S $EC=",U-UNIMPLMENTED,"
 ;
 ;
LSHANONT ; [Private, Cache]
 ; ZEXCEPT: %New,%Save,%Stream,Encryption,GlobalCharacter,LineTerminator,SHAHashStream,WriteLine,class
 ; ZEXCEPT: HASHLEN,MSUB,NBLOCKS
 N CHAR,COHASH,HASH,IND,LOCATION,STATUS,STREAM
 K ^TMP($J,"STREAM")
 ;Put the message into a stream global.
 S LOCATION=$NA(^TMP($J,"STREAM"))
 S STREAM=##class(%Stream.GlobalCharacter).%New(LOCATION)
 S STREAM.LineTerminator=""
 F IND=1:1:NBLOCKS S STATUS=STREAM.WriteLine(^TMP($J,"XLFMSG",IND))
 S STATUS=STREAM.%Save()
 S COHASH=$SYSTEM.Encryption.SHAHashStream(HASHLEN,STREAM)
 ;Convert the string to hex.
 S HASH=""
 F IND=1:1:$L(COHASH) D
 . S CHAR=$A(COHASH,IND)
 . S HASH=HASH_$$RJ^XLFSTR($$CNV^XLFUTL(CHAR,16),2,"0")
 K ^TMP($J,"STREAM")
 Q HASH
 ;
LSHANGUX ; [Private, GT.M] Contributed K.S. Bhaskar. IA #6157
 ; ZEXCEPT: HASHLEN,MSUB,NBLOCKS
 N OLDIO,IND,SHA
 S OLDIO=$IO
 S:HASHLEN=160 HASHLEN=1
 ;name of program for 160 bit hash is sha1sum; other names use actual
 ;hash size
 ; 
 ; ZEXCEPT: SHELL,COMMAND,STREAM,NOWRAP,EOF,%utNoOpenssl
 i $ztrnlnm("GTMXC_openssl")'="",'$d(%utNoOpenssl) d  quit SHA
 . d &openssl.init("sha"_HASHLEN)
 . F IND=1:1:NBLOCKS d &openssl.add(^TMP($J,MSUB,IND))
 . d &openssl.finish(.SHA)
 ;
 ; command line way - takes 5 seconds
 O "SHA":(SHELL="/bin/sh":COMMAND="sha"_HASHLEN_"sum":STREAM:NOWRAP)::"PIPE" U "SHA"
 F IND=1:1:NBLOCKS W ^TMP($J,MSUB,IND) S $X=0
 W /EOF R SHA
 U OLDIO C "SHA"
 Q $$UP^XLFSTR($P(SHA," ",1))
 ;
 ;=============================
ROUTINE(HASHLEN,ROUTINE) ;Return a SHA hash for a routine. IA #6157
 I '$$CHASHLEN(HASHLEN) Q -1
 N DIF,HASH,IND,LN,NBLOCKS,RA,TEMP,X,XCNP
 K ^TMP($J,"XLFMSG")
 S XCNP=0
 S DIF="RA("
 S X=ROUTINE
 ;Make sure the routine exists.
 X ^%ZOSF("TEST")
 I '$T Q 0
 X ^%ZOSF("LOAD")
 S NBLOCKS=0,TEMP=""
 F LN=1:1:(XCNP-1) D
 . F IND=1:1:$L(RA(LN,0)) D
 .. S TEMP=TEMP_$E(RA(LN,0),IND)
 .. I $L(TEMP)=1024 S NBLOCKS=NBLOCKS+1,^TMP($J,"XLFMSG",NBLOCKS)=TEMP,TEMP=""
 I $L(TEMP)>0 S NBLOCKS=NBLOCKS+1,^TMP($J,"XLFMSG",NBLOCKS)=TEMP
 S HASH=$$LSHAN(HASHLEN,"XLFMSG",NBLOCKS)
 K ^TMP($J,"XLFMSG")
 Q HASH
 ;
 ;=============================
SHAN(HASHLEN,MESSAGE) ;SHA hash for a message that can be passed as a single
 ;string. IA #6157
 ; ZEXCEPT: Encryption,SHAHash
 I '$$CHASHLEN(HASHLEN) Q -1
 I ^%ZOSF("OS")["OpenM" G SHANONT
 I ^%ZOSF("OS")["GT.M" G SHANGUX
 S $EC=",U-UNIMPLMENTED,"
 ;
SHANONT ; [Private, Cache]
 ; ZEXCEPT: HASHLEN,MESSAGE
 N CHAR,COHASH,HASH,IND
 S COHASH=$SYSTEM.Encryption.SHAHash(HASHLEN,MESSAGE)
 ;Convert the string to hex.
 S HASH=""
 F IND=1:1:$L(COHASH) D
 . S CHAR=$A(COHASH,IND)
 . S HASH=HASH_$$RJ^XLFSTR($$CNV^XLFUTL(CHAR,16),2,"0")
 Q HASH
 ;
SHANGUX ; [Private, GT.M] - Contributed by KS Bhaskar
 ; ZEXCEPT: HASHLEN,MESSAGE
 ; ZEXCEPT: STREAM,NOWRAP,SHELL,COMMAND,EOF,%utNoOpenssl
 S:HASHLEN=160 HASHLEN=1 ; name of program for 160 bit hash is sha1sum
 N SHA
 i $ztrnlnm("GTMXC_openssl")'="",'$d(%utNoOpenssl) d  quit SHA
 . d &openssl.md(MESSAGE,"sha"_HASHLEN,.SHA)
 N OLDIO S OLDIO=$IO
 ;other names use actual hash size
 O "SHA":(SHELL="/bin/sh":COMMAND="sha"_HASHLEN_"sum":STREAM:NOWRAP)::"PIPE" U "SHA"
 W MESSAGE S $X=0 W /EOF R SHA
 U OLDIO C "SHA"
 Q $$UP^XLFSTR($P(SHA," ",1))
 ;
 ;
TMPLOAD(SUB,BLKSIZE,STR,REPS,NBLOCKS) ;Load the ^TMP global.
 N STRLEN
 K ^TMP($J,SUB)
 S STRLEN=$L(STR)
 N LEN S LEN=STRLEN*REPS
 I LEN'>BLKSIZE S ^TMP($J,SUB,1)=STR,NBLOCKS=1 Q
 N IND,JND,TEMP
 S NBLOCKS=0,TEMP=""
 F IND=1:1:REPS D
 . F JND=1:1:STRLEN D
 .. S TEMP=TEMP_$E(STR,JND)
 .. I $L(TEMP)=BLKSIZE S NBLOCKS=NBLOCKS+1,^TMP($J,SUB,NBLOCKS)=TEMP,TEMP=""
 I $L(TEMP)>0 S NBLOCKS=NBLOCKS+1,^TMP($J,SUB,NBLOCKS)=TEMP
 Q
 ;
