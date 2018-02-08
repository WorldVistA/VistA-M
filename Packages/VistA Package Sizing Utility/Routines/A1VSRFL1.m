A1VSRFL1 ;Albany FO/GTS - VistA Package Sizing Manager; 21-OCT-2016
 ;;1.0;VistA Package Sizing;;Oct 10, 2016;Build 25
 ;
 ;;Variable glosary (local, for each package)
 ;; PKGIEN = Package IEN
 ;; PKGNAME = Package NAME (.01 - $P(^(0),"^",1))
 ;; PKGPFX = Package PREFIX / NAMESPACE (1 - $P(^(0),"^",2))
 ;; 
 ;; RTOT = total ROUTINEs
 ;; TLCNT = total SIZE of all ROUTINES
 ;; FTOT = total FILEs
 ;; FLDTOT = total FIELDs of all FILES (Future: TBD)
 ;; OTOT = total OPTIONs (^DIC(19,)
 ;; PRCTOT = total PROTOCOLs (^ORD(101,)
 ;; RPTOT = total REMOTE PROCEDUREs (^XWB(8994,)
 ;; TPLTTOT = total Fileman Templates
 ;
ONERPT(PKGNAME,VALMCNT) ; Report a single package
 ;;INPUT:
 ;   VALMCNT  - Current Node # on ListMan ^TMP("A1VS PKG MGR RPT",$JOB) global
 ;   PKGNAME  - Package name to report
 ;
 N Q,PCENUM,ADP,RDP,FTOT,RTOT,OTOT,PRCTOT,RPTOT,TPLTTOT,PKGIEN,PKGPFX,RNDT,TLCNT
 N PARMDAT,PARMDAT3,PARMDAT4,PARMDAT7,PARMDAT8
 D FULL^VALM1
 IF '$D(^DIC(9.4,"B",PKGNAME)) W !!,"Selected package is not defined on this VistA Instance.  Unable to continue."
 SET PKGIEN=$O(^DIC(9.4,"B",PKGNAME,""))
 S PKGPFX=$G(^TMP("A1VS-PARAM-CAP",$J,PKGNAME,2,"Primary Prefix"))
 I PKGPFX="" W !!,"PREFIX not found for package selected.  Unable to continue." Q
 ;
 SET PARMDAT=^TMP("A1VS-PARAM-CAP",$J,PKGNAME,5,"Additional Prefixes")
 S (ADP,Q,PCENUM)=0
 FOR  SET PCENUM=PCENUM+1 SET Q=$P(PARMDAT,"|",PCENUM) Q:Q=""  SET ADP=ADP+1 SET ADP(ADP)=Q
 ;
 SET PARMDAT=^TMP("A1VS-PARAM-CAP",$J,PKGNAME,6,"Excepted Prefixes")
 S (RDP,Q,PCENUM)=0
 FOR  SET PCENUM=PCENUM+1 SET Q=$P(PARMDAT,"|",PCENUM) Q:Q=""  SET RDP=RDP+1 SET RDP(RDP)=Q
 ;
 W !,"...counting...",!,"    ...files..."
 SET PARMDAT3=^TMP("A1VS-PARAM-CAP",$J,PKGNAME,3,"*Lowest File#")
 SET PARMDAT4=^TMP("A1VS-PARAM-CAP",$J,PKGNAME,4,"*Highest File#")
 SET PARMDAT7=^TMP("A1VS-PARAM-CAP",$J,PKGNAME,7,"File Numbers")
 SET PARMDAT8=^TMP("A1VS-PARAM-CAP",$J,PKGNAME,8,"File Ranges")
 SET FTOT=$$COUNTFLS(PKGPFX,PARMDAT3,PARMDAT4,PARMDAT7,PARMDAT8) ; Count Files
 ;
 W !,"    ...routines..."
 S TLCNT=0,RTOT=$$ROUTINE(PKGPFX,.TLCNT)
 I ADP F Q=1:1:ADP I ADP(Q)'="" S RTOT=RTOT+$$ROUTINE(ADP(Q),.TLCNT) ; Count Routines
 ;
 W !,"    ...options..."
 S OTOT=$$OPTION(PKGPFX)
 I ADP F Q=1:1:ADP I ADP(Q)'="" S OTOT=OTOT+$$OPTION(ADP(Q)) ;Count Options
 ;
 S PRCTOT=$$PROTOCOL(PKGPFX,PKGIEN)
 I ADP F Q=1:1:ADP I ADP(Q)'="" S PRCTOT=PRCTOT+$$PROTOCOL(ADP(Q),PKGIEN) ;Count Protocols
 ;
 W !,"    ...remote procedures..."
 S RPTOT=0
 D CNTR("^XWB(8994,",.RPTOT,PKGPFX,PKGNAME,.RDP,.ADP) ;Count Remote Procedure Calls
 ;
 W !,"    ...edit, print, & sort templates..."
 S TPLTTOT=0
 D CNTR("^DIPT(",.TPLTTOT,PKGPFX,PKGNAME,.RDP,.ADP) ;Count Print Templates
 D CNTR("^DIBT(",.TPLTTOT,PKGPFX,PKGNAME,.RDP,.ADP) ;Count Sort Templates
 D CNTR("^DIE(",.TPLTTOT,PKGPFX,PKGNAME,.RDP,.ADP) ;Count Input Templates
 ;
 DO ADD^A1VSLAPI(.VALMCNT," ")
 DO ADD^A1VSLAPI(.VALMCNT,"  VistA Application Sizing Information",1,3,36)
 DO NOW^%DTC S Y=X D DD^%DT
 SET RNDT=Y
 DO ADD^A1VSLAPI(.VALMCNT,"Run Date: "_RNDT)
 DO ADD^A1VSLAPI(.VALMCNT,"VistA Application: "_PKGNAME)
 DO ADD^A1VSLAPI(.VALMCNT,"==================")
 DO ADD^A1VSLAPI(.VALMCNT,"Number of Routines:     "_RTOT)
 DO ADD^A1VSLAPI(.VALMCNT,"Size of Routines:       "_TLCNT)
 DO ADD^A1VSLAPI(.VALMCNT,"Number of Files:        "_FTOT)
 DO ADD^A1VSLAPI(.VALMCNT,"Number of Fields:       TBD")
 DO ADD^A1VSLAPI(.VALMCNT,"Number of Options:      "_OTOT)
 DO ADD^A1VSLAPI(.VALMCNT,"Number of Protocols:    "_PRCTOT)
 DO ADD^A1VSLAPI(.VALMCNT,"Number of RPCs:         "_RPTOT)
 DO ADD^A1VSLAPI(.VALMCNT,"Number of Templates:    "_TPLTTOT)
 QUIT
 ;
COUNTFLS(PKGPFX,LINE3,LINE4,LINE7,LINE8) ;Count total # of files for a package
 ; LINE3=^TMP("A1VS-PARAM-CAP",$J,PKGNAME,3,"*Lowest File#")
 ; LINE4=^TMP("A1VS-PARAM-CAP",$J,PKGNAME,4,"*Highest File#")
 ; LINE7=^TMP("A1VS-PARAM-CAP",$J,PKGNAME,7,"File Numbers")
 ; LINE8=^TMP("A1VS-PARAM-CAP",$J,PKGNAME,8,"File Ranges")
 ;
 NEW FNDFLDAT,FILELIST,PCENUM,FLERNG,STRTFNUM,ENDFNUM,FTOT,FNUM
 SET (FTOT,FNDFLDAT)=0
 ;
 ; 1st look for delimited list of file ranges, if exists count it only
 SET FILELIST=LINE8
 IF FILELIST'="" DO
 . SET FNDFLDAT=1
 . SET PCENUM=0
 . FOR  SET PCENUM=PCENUM+1 SET FLERNG=$P(FILELIST,"|",PCENUM) QUIT:FLERNG']""  DO
 .. SET STRTFNUM=+$P(FLERNG,"-")
 .. SET ENDFNUM=+$P(FLERNG,"-",2)
 .. IF +STRTFNUM>0,+ENDFNUM>0 SET FTOT=FTOT+$$FLECNT(STRTFNUM,ENDFNUM)
 ;
 ; 2nd if no list of file ranges, look files between Lowest and Highest file number range
 IF 'FNDFLDAT,PKGPFX'="XU" DO
 . NEW STRTFNUM,ENDFNUM,FNUM,FILENAME
 . SET STRTFNUM=LINE3
 . SET ENDFNUM=LINE4
 . IF +STRTFNUM>0,+ENDFNUM>0  SET FNDFLDAT=1 SET FTOT=FTOT+$$FLECNT(STRTFNUM,ENDFNUM)
 ;
 ; 3rd if no list of file ranges & no High/Low file range, count files in File list data element
 SET FILELIST=LINE7
 IF 'FNDFLDAT,FILELIST'="" DO
 . SET FNDFLDAT=1
 . SET PCENUM=0
 . FOR  SET PCENUM=PCENUM+1 SET FNUM=$P(FILELIST,"|",PCENUM) QUIT:FNUM']""  SET FTOT=FTOT+1
 QUIT FTOT
 ;
ROUTINE(PKGPFX,TLCNT,RDP,ADP) ; Returns total of all characters in all routines
 ; ...Including line feeds on each line of each routine in characters counted
 ; Input - PKGPFX : Prefix for routine in package
 ;       - TLCNT  : Sum of routine sizes in package
 ;       - RDP    : Removed (Excepted) Prefixes
 ;       - ADP    : Additional Prefixes
 ;
 ; Output - TLCNT : Sum of routine sizes incremented by routines in PKGPFX
 ;
 NEW CNT,LPPFX,PFXLN,X,ADPFXLN,ADPFX
 SET PFXLN=$L(PKGPFX)
 SET CNT=0
 SET LPPFX=""
 DO RTNLST(PKGPFX,"^TMP(""A1VS"",""RTNLST"""_","_$J_")") ;Create global of Routines with Primary Prefix
 FOR  SET LPPFX=$ORDER(^TMP("A1VS","RTNLST",$J,LPPFX))  QUIT:LPPFX=""  QUIT:($E(LPPFX,1,PFXLN)'=PKGPFX)  DO
 .IF $$RDPCK(LPPFX,.RDP) DO
 .. SET X=LPPFX
 .. X ^%ZOSF("TEST") IF $T SET TLCNT=TLCNT+$$RSIZE(LPPFX) SET CNT=CNT+1
 KILL ^TMP("A1VS","RTNLST",$J)
 ;
 SET ADPFX=""
 FOR  SET ADPFX=$O(ADP(ADPFX)) Q:ADPFX=""  DO
 . SET ADPFXLN=$L(ADPFX)
 . DO RTNLST(ADPFX,"^TMP(""A1VS"",""RTNLST"""_","_$J_")") ;Create global of Routines with Additional Prefix
 . FOR  SET LPPFX=$ORDER(^TMP("A1VS","RTNLST",$J,LPPFX)) QUIT:LPPFX=""  QUIT:($E(LPPFX,1,ADPFXLN)'=ADPFX)  DO
 .. IF ($E(LPPFX,1,PFXLN)'=PKGPFX),($$RDPCK(LPPFX,.RDP)) DO
 ... SET X=LPPFX
 ... X ^%ZOSF("TEST") IF $T SET TLCNT=TLCNT+$$RSIZE(LPPFX) SET CNT=CNT+1
 . KILL ^TMP("A1VS","RTNLST",$J)
 QUIT CNT
 ;
RTNLST(PREFIX,RTNLIST) ; Create RTNLIST of routines in PREFIX namespace
 NEW RTNS,RTNNAME
 SET RTNS=##class(%ResultSet).%New("%Routine:RoutineList") ;Create Routine Query Class instance
 DO RTNS.Execute(PREFIX_"*.INT") ;Query Routines
 FOR  Q:'RTNS.Next()  SET RTNNAME=$P(RTNS.GetData(1),".") SET @RTNLIST@(RTNNAME)=""
 QUIT
 ;
RDPCK(LPPFX,RDP) ;Check for excepted PREFIX [Result=0 when Excepted]
 N RESULT,RPFX,RPFXLN
 S RESULT=1
 S RPFX=""
 FOR  SET RPFX=$O(RDP(RPFX))  Q:RPFX=""  Q:'RESULT  DO
 . SET RPFXLN=$L(RPFX)
 . IF $E(LPPFX,1,RPFXLN)=RPFX SET RESULT=0
 Q RESULT
 ;
FLECNT(STRTFNUM,ENDFNUM) ; Count Files
 NEW FCNT,FNUM
 SET FCNT=0
 SET FNUM=$O(^DIC(STRTFNUM),-1)
 FOR  SET FNUM=$O(^DIC(FNUM)) Q:'FNUM  Q:'FNUM  Q:FNUM>ENDFNUM  DO
 . KILL VPSFAT
 . SET FILENAME=$P($G(^DIC(FNUM,0)),"^")
 . IF FILENAME]"" S FCNT=FCNT+1
 KILL VPSFAT
 Q FCNT
 ;
PROTOCOL(PKGPFX,PKGIEN,RDP,ADP) ; Count Protocols
 NEW LPPFX,PFXLN,ADPFXLN,ADPFX,CNT,ORDIEN
 SET PFXLN=$L(PKGPFX)
 SET CNT=0
 SET LPPFX=""
 IF '$D(PGKIEN) SET PKGIEN=0
 IF $D(PKGIEN),(PKGIEN="") SET PKGIEN=0
 FOR  SET LPPFX=$O(^ORD(101,"B",LPPFX)) QUIT:LPPFX=""  SET ORDIEN=$O(^ORD(101,"B",LPPFX,""))  QUIT:ORDIEN=""  DO 
 . IF $P($G(^ORD(101,ORDIEN,0)),"^",12)=PKGIEN SET CNT=CNT+1
 . IF $E(LPPFX,1,PFXLN)=PKGPFX,$$RDPCK(LPPFX,.RDP) DO
 .. IF ($P($G(^ORD(101,ORDIEN,0)),"^",12)'=PKGIEN) S CNT=CNT+1
 .;
 . IF ($E(LPPFX,1,PFXLN)'=PKGPFX),($P($G(^ORD(101,ORDIEN,0)),"^",12)'=PKGIEN) DO
 .. SET ADPFX=""
 .. FOR  SET ADPFX=$O(ADP(ADPFX)) QUIT:ADPFX=""  DO
 ... SET ADPFXLN=$L(ADPFX)
 ... IF $E(LPPFX,1,ADPFXLN)=ADPFX,$$RDPCK(LPPFX,.RDP) SET CNT=CNT+1
 ;
 Q CNT
 ;
CNTR(TMPGLB,CNT,PKGPFX,PKGNAME,RDP,ADP) ;Count Templates & RPCs
 NEW LPPFX,PFXLN,TMPLTPFX,PFXEXT,PFXANLYS,PFXAVAIL
 SET PFXLN=$L(PKGPFX)
 SET LPPFX=$O(@(TMPGLB_"""B"","""_PKGPFX_""")"),-1)
 FOR  SET LPPFX=$O(@(TMPGLB_"""B"","""_LPPFX_""")")) Q:$E(LPPFX,1,PFXLN)'=PKGPFX  DO
 .SET TMPLTPFX=LPPFX
 .SET:TMPLTPFX[" " TMPLTPFX=$P(TMPLTPFX," ")
 .IF $L(TMPLTPFX)=PFXLN SET CNT=CNT+1
 .IF $L(TMPLTPFX)>PFXLN,('$D(^TMP("A1VS-PREFIX-IDX",$J,PKGNAME,TMPLTPFX))),('$D(^TMP("A1VS-FORUM-PFXS",$J,TMPLTPFX))) DO
 ..; Prefix starts with PKGPFX, is not part of another package's main prefix, and is not the current package
 .. SET PFXAVAIL=1
 .. SET PFXANLYS=PKGPFX
 .. FOR PFXEXT=PFXLN+1:1 Q:($E(TMPLTPFX,PFXEXT)'?1AN)  Q:'PFXAVAIL  SET PFXANLYS=PFXANLYS_$E(TMPLTPFX,PFXEXT) DO
 ... IF ($D(^TMP("A1VS-FORUM-PFXS",$J,PFXANLYS))),'$$RDPCK(PFXANLYS,.RDP) SET PFXAVAIL=0 ;Parsed prefix belongs to other package or excluded from current pkg
 .. IF PFXAVAIL SET CNT=CNT+1
 QUIT
 ;
OPTION(PKGPFX,PKGNME,RDP) ;Count Options
 ;
 NEW CNT,LPPFX,PFXLN,OPTPFX,PFXEXT,PFXANLYS,PFXAVAIL
 SET PFXLN=$L(PKGPFX)
 SET CNT=0
 SET LPPFX=$O(^DIC(19,"B",PKGPFX),-1)
 FOR  SET LPPFX=$O(^DIC(19,"B",LPPFX)) Q:$E(LPPFX,1,PFXLN)'=PKGPFX  DO
 .SET OPTPFX=LPPFX
 .SET:OPTPFX[" " OPTPFX=$P(OPTPFX," ")
 .IF $L(OPTPFX)=PFXLN SET CNT=CNT+1
 .IF $L(OPTPFX)>PFXLN,('$D(^TMP("A1VS-PREFIX-IDX",$J,PKGNAME,OPTPFX))),('$D(^TMP("A1VS-FORUM-PFXS",$J,OPTPFX))) DO
 ..; Prefix starts with PKGPFX, is not part of another package, or the current package
 .. SET PFXAVAIL=1
 .. SET PFXANLYS=PKGPFX
 .. FOR PFXEXT=PFXLN+1:1 Q:($E(OPTPFX,PFXEXT)'?1AN)  Q:'PFXAVAIL  SET PFXANLYS=PFXANLYS_$E(OPTPFX,PFXEXT) DO
 ... IF ($D(^TMP("A1VS-FORUM-PFXS",$J,PFXANLYS))),'$$RDPCK(PFXANLYS,.RDP) SET PFXAVAIL=0 ;Parsed prefix belongs to other package or excluded from current pkg
 .. IF PFXAVAIL SET CNT=CNT+1
 Q CNT
 ;
 ; - NOTE: Check for Primary Prefix (=1) will count DVBC for COMP & PEN package but NOT AMIE.
MULTX(APFX,PKGNAME) ; Return indication of Multiple packages using same prefix
 ;Prevent Primary prefix from double counting as added prefix
 NEW RESULT,LPPKG
 SET RESULT=1
 SET LPPKG=""
 ;
 ; Return RESULT=0 if PKGNAME is not LPPKG and LPPKG is primary package
 FOR  SET LPPKG=$O(^TMP("A1VS-IDX-PKG",$J,APFX,LPPKG)) Q:LPPKG=""  Q:'RESULT  DO
 . IF LPPKG'=PKGNAME,^TMP("A1VS-IDX-PKG",$J,APFX,LPPKG)=1 SET RESULT=0
 QUIT RESULT
 ;
 ;
KIDSIDX() ;Create Prefix-Package Indicies from KIDS
 NEW KIDSIEN,KIDSPKG,KIDSPRFX,KIDSZERO,PKGIEN,PATCHNME
 SET KIDSIEN=0
 FOR  SET KIDSIEN=$O(^XPD(9.6,KIDSIEN)) Q:+KIDSIEN=0  DO
 . SET KIDSZERO=$G(^XPD(9.6,KIDSIEN,0))
 . IF KIDSZERO]"" DO
 .. SET PKGIEN=$P(KIDSZERO,"^",2)
 .. SET:+PKGIEN>0 KIDSPKG=$P($G(^DIC(9.4,PKGIEN,0)),"^",1)
 .. SET PATCHNME=$P(KIDSZERO,"^",1)
 .. SET KIDSPRFX=$P(PATCHNME,"*",1)
 .. IF KIDSPRFX]"" SET ^TMP("A1VS-KIDSPFX-IDX",$J,KIDSPRFX)=KIDSPKG
 QUIT
 ;
RSIZE(RTN) ; Compute routine size (# characters plus line feeds)  [^%ZOSF("SIZE") algorithm]
 NEW LINE,CT,RSIZEVAL
 SET (CT,RSIZEVAL)=0
 SET LINE=""
 X "ZL @RTN F  S CT=CT+1,LINE=$T(+CT) Q:$L(LINE)=0  SET RSIZEVAL=RSIZEVAL+$L(LINE)+2"
 QUIT RSIZEVAL
