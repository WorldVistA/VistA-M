VAFCMGA1 ;BIR/LTL-DEMOGRAPHIC MERGE SCREEN ACTIONS cont. ;24 Sep 96
 ;;5.3;Registration;**149,477**;Aug 13, 1993
 ;
 ;NOTE: The VAFCMGA* routines contain line tags used to implement
 ;      the actions of a List Manager user interface.  All line
 ;      tags assume that the following variables and arrays are
 ;      defined.
 ;
 ;Input  : VAFCDFN - Pointer to entry in PATIENT file (#2) to merge
 ;                   data into
 ;         VAFCARR - Array contain data to merge (full global reference)
 ;                   VAFCARR() should be set as follows:
 ;                     VAFCARR(File,Field) = Value
 ;                       Where File = File number Value is from
 ;                             Field = Field number Value is from
 ;                             Value = Info to merge
 ;                       Notes: Dates must be in FileMan format
 ;                            : Special considerations for Value
 ;                             "@"  - Displays <Data Deleted> and deletes
 ;                                       local value if merged
 ;                                "^text"  - Displays text and ignores
 ;                                           field if merged
 ;                                NULL  - Displays <No Data Found> and
 ;                                        ignores field if merged
 ;                                Doesn't exist  - Displays <UR>
 ;                                                 and ignores field
 ;                                                 if merged
 ;         VAFCFROM - Text denoting where merge data cam from (1-35)
 ;         VAFCEVDT - Date/time merge data was instantiated (FileMan)
 ;         All variables set by List Manager Interface
 ;         Display area and variables required List Manager interface
 ;         Display
 ;           VALMAR(Line,0) = Line of text in display
 ;         Indexes
 ;           VALMAR("IDX",Line,Entry) = ""
 ;           VALMAR("E2F",Entry,N) = File^Field
 ;             N => Allows for multiple fields per entry (starts with 1)
 ;           VALMAR("E2G",Entry) = Group entry is contained in
 ;           VALMAR("GRP",Group) = First line of group in display
 ;             Note: The E2F and E2G indexes are only set if the data
 ;                   to merge does not match the local data
 ;
UNDO ;Undo selected merges
 ;
 ;Input  : See above note on input variables
 ;Output : VALMAR() array will be rebuilt accordingly
 ;
 ;Declare variables
 N VAFCDOTS
 N ENTRY,IENS,FDAROOT,MSGROOT,QUOTE
 S FDAROOT="^TMP(""VAFC-UNDO"","_$J_",""FDA"")"
 S MSGROOT="^TMP(""VAFC-UNDO"","_$J_",""MSG"")"
 S QUOTE=$C(34)
 S IENS=VAFCDFN_","
 I '$O(@FDAROOT@(0)) S VALMSG="You haven't merged anything yet?!" G UNDOQ
 ;undo
 S VALMSG="Merge undone."
 N DGNOFDEL S DGNOFDEL=1 ;**477 stop NOK Name x-ref from firing.
 ;NEW EASZIPLK S EASZIPLK=1 ;**477 zipcode lookup for GMT
 D FILE^DIE("E",FDAROOT,MSGROOT)
 ;Rebuild required portion of display
 S VAFCDOTS=1
 F ENTRY=1:1:4 D RBLDGRP^VAFCMGB(ENTRY)
 ;No more differences
 S:('$D(@VALMAR@("E2F"))) VALMSG="** No differences found **"
 ;Done - refresh List Manager display
UNDOQ K @FDAROOT,@MSGROOT S VALMBCK="R"
 Q
 ;
PDAT ;remote pdat ;**477
 NEW DFN,ICN,VAFCDEL,VAFCDIR,VAFCFILE
 S DFN=VAFCDFN
 S ICN=+$$GETICN^MPIF001(DFN)
 S VALMBCK="" ;clear bottom portion of screen and prompt for action
 S VAFCDIR=$$GET^XPAR("SYS","VAFC HFS SCRATCH") ;hfs directory
 S VAFCFILE="VAFC"_DUZ_".DAT" ;file name for local pdat
 S IOM=132,IOSL=99999,IOST="P-DUMMY",IOF=""""""
 D OPEN^%ZISH("VAFC",VAFCDIR,VAFCFILE,"W") Q:POP  ;open up file
 U IO
 I ICN'="" D START^VAFCPDAT ;local pdat to file
 D CLOSE^%ZISH("VAFC") ;close up file
 K ^TMP("RGPDAT",$J) ;global array to hold pdat for listman
 S X=$$FTG^%ZISH(VAFCDIR,VAFCFILE,$NAME(^TMP("RGPDAT",$J,1)),3) ;file to global
 S VAFCDEL(VAFCFILE)="" ;list of file(s) to delete
 S X=$$DEL^%ZISH(VAFCDIR,$NA(VAFCDEL)) ;delete file
 I $D(^TMP("RGPDAT",$J)) D EN^RGEX04 ;list manager for remote pdat
 S VALMBCK="R" ;refresh screen
 Q
 ;
RAUD ;remote audit ;**477
 NEW DFN,ICN,VAFCBDT,VAFCEDT,VAFCDEL,VAFCDIR,VAFCFILE
 S DFN=VAFCDFN
 S ICN=+$$GETICN^MPIF001(DFN)
 S VALMBCK="" ;clear bottom portion of screen and prompt for action
 D ASK2^VAFCAUD I '$G(VAFCBDT)!'$G(VAFCEDT) Q  ;date range of local and remote audits
 S VAFCDIR=$$GET^XPAR("SYS","VAFC HFS SCRATCH") ;hfs directory
 S VAFCFILE="VAFC"_DUZ_".DAT" ;file name for local audit
 S IOM=132,IOSL=99999,IOST="P-DUMMY",IOF=""""""
 D OPEN^%ZISH("VAFC",VAFCDIR,VAFCFILE,"W") Q:POP  ;open up file
 U IO
 I '$O(^DIA(2,"B",DFN,0)) W !,"This patient has no audit data available."
 I $O(^DIA(2,"B",DFN,0)) S QFLG=1,RPCFLG=1 D START^VAFCAUD(DFN,VAFCBDT,VAFCEDT,RPCFLG) ;local audit to file
 D CLOSE^%ZISH("VAFC") ;close up file
 K ^TMP("VAFCRAUD",$J) ;global array to hold audit for listman
 S X=$$FTG^%ZISH(VAFCDIR,VAFCFILE,$NAME(^TMP("VAFCRAUD",$J,1)),3) ;file to global
 S VAFCDEL(VAFCFILE)="" ;list of file(s) to delete
 S X=$$DEL^%ZISH(VAFCDIR,$NA(VAFCDEL)) ;delete file
 I $D(^TMP("VAFCRAUD",$J)) D EN^VAFCLAU ;list manager for remote audit
 S VALMBCK="R" ;refresh screen
 Q
