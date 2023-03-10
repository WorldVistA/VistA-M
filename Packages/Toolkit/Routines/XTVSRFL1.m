XTVSRFL1 ;Albany FO/GTS - VistA Package Sizing Manager; 21-OCT-2016
 ;;7.3;TOOLKIT;**143**;Apr 25, 1995;Build 116
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
 ;   PKGNAME  - Package name to report
 ;   VALMCNT  - Current Node # on ListMan ^TMP("XTVS PKG MGR RPT",$JOB) global
 ;
 N Q,PCENUM,ADP,RDP,FTOT,FLDTOT,FFCTRSLT,RTOT,OTOT,PRCTOT,RPTOT,TPLTTOT,PKGIEN,PKGPFX,RNDT,TLCNT
 N PARMDAT,PARMDAT3,PARMDAT4,PARMDAT7,PARMDAT8
 D FULL^VALM1
 ;
 SET PKGIEN=0
 IF PKGNAME["''" DO
 . IF $D(^DIC(9.4,"B",$REPLACE(PKGNAME,"''",""""))) SET PKGIEN=$O(^DIC(9.4,"B",$REPLACE(PKGNAME,"''",""""),""))
 . IF '$D(^DIC(9.4,"B",$REPLACE(PKGNAME,"''",""""))),$D(^DIC(9.4,"B",PKGNAME)) SET PKGIEN=$O(^DIC(9.4,"B",PKGNAME,""))
 IF PKGNAME'["''" SET PKGIEN=+$O(^DIC(9.4,"B",PKGNAME,""))
 ;
 IF PKGIEN=0 W !!,"Selected package is not defined in the Package file (#9.4) on this VistA.",!,"Protocol count may be incorrect.",!!
 ;
 S PKGPFX=$G(^TMP("XTVS-PARAM-CAP",$J,PKGNAME,2,"Primary Prefix"))
 I PKGPFX="" W !!,"PREFIX not found for package selected.  Unable to continue." Q
 ;
 SET PARMDAT=^TMP("XTVS-PARAM-CAP",$J,PKGNAME,5,"Additional Prefixes")
 S (ADP,Q,PCENUM)=0
 FOR  SET PCENUM=PCENUM+1 SET Q=$P(PARMDAT,"|",PCENUM) Q:Q=""  IF $$MULTX(Q,PKGNAME) SET ADP=ADP+1 SET ADP(ADP)=Q
 ;
 SET PARMDAT=^TMP("XTVS-PARAM-CAP",$J,PKGNAME,6,"Excepted Prefixes")
 S (RDP,Q,PCENUM)=0
 FOR  SET PCENUM=PCENUM+1 SET Q=$P(PARMDAT,"|",PCENUM) Q:Q=""  SET RDP=RDP+1 SET RDP(RDP)=Q
 ;
 W !,"...counting...",!,"    ...files and fields..."
 SET PARMDAT3=^TMP("XTVS-PARAM-CAP",$J,PKGNAME,3,"*Lowest File#")
 SET PARMDAT4=^TMP("XTVS-PARAM-CAP",$J,PKGNAME,4,"*Highest File#")
 SET PARMDAT7=^TMP("XTVS-PARAM-CAP",$J,PKGNAME,7,"File Numbers")
 SET PARMDAT8=^TMP("XTVS-PARAM-CAP",$J,PKGNAME,8,"File Ranges")
 SET FFCTRSLT=$$COUNTFLS(PKGPFX,PARMDAT3,PARMDAT4,PARMDAT7,PARMDAT8) ; Count Files^Fields
 SET FTOT=$P(FFCTRSLT,"^") ;Extract File ctr
 SET FLDTOT=$P(FFCTRSLT,"^",2) ;Extract Field ctr
 ;
 W !,"    ...routines..."
 S TLCNT=0
 S RTOT=$$ROUTINE(PKGPFX,.TLCNT,.RDP,.ADP)
 I ADP F Q=1:1:ADP I ADP(Q)'="" S RTOT=RTOT+$$ROUTINE(ADP(Q),.TLCNT,.RDP,.ADP) ;ADP(Q) added prefixes called individually
 ;
 W !,"    ...options..."
 S OTOT=0
 D CNTR("^DIC(19,",.OTOT,PKGPFX,.RDP,.ADP)
 I ADP F Q=1:1:ADP I ADP(Q)'="" D CNTR("^DIC(19,",.OTOT,ADP(Q),.RDP,.ADP)
 ;
 W !,"    ...protocols..."
 S PRCTOT=$$PROTOCOL(PKGPFX,PKGIEN,.RDP)
 I ADP F Q=1:1:ADP I ADP(Q)'="" S PRCTOT=PRCTOT+$$PROTOCOL(ADP(Q),PKGIEN,.RDP)
 ;
 W !,"    ...remote procedures..."
 S RPTOT=0
 D CNTR("^XWB(8994,",.RPTOT,PKGPFX,.RDP,.ADP)
 I ADP F Q=1:1:ADP I ADP(Q)'="" D CNTR("^XWB(8994,",.RPTOT,ADP(Q),.RDP,.ADP)
 ;
 W !,"    ...edit, print, & sort templates..."
 S TPLTTOT=0
 D CNTR("^DIPT(",.TPLTTOT,PKGPFX,.RDP,.ADP) ;Print Templates
 I ADP F Q=1:1:ADP I ADP(Q)'="" D CNTR("^DIPT(",.TPLTTOT,ADP(Q),.RDP,.ADP)
 ;
 D CNTR("^DIBT(",.TPLTTOT,PKGPFX,.RDP) ;Sort Templates
 I ADP F Q=1:1:ADP I ADP(Q)'="" D CNTR("^DIBT(",.TPLTTOT,ADP(Q),.RDP,.ADP)
 ;
 D CNTR("^DIE(",.TPLTTOT,PKGPFX,.RDP) ;Input Templates
 I ADP F Q=1:1:ADP I ADP(Q)'="" D CNTR("^DIE(",.TPLTTOT,ADP(Q),.RDP,.ADP)
 ;
 DO ADD^XTVSLAPI(.VALMCNT," ")
 DO ADD^XTVSLAPI(.VALMCNT,"  VistA Application Sizing Information",1,3,36)
 DO NOW^%DTC S Y=X D DD^%DT
 SET RNDT=Y
 DO ADD^XTVSLAPI(.VALMCNT,"Run Date: "_RNDT)
 DO ADD^XTVSLAPI(.VALMCNT,"VistA Application: "_PKGNAME)
 DO ADD^XTVSLAPI(.VALMCNT,"==================")
 DO ADD^XTVSLAPI(.VALMCNT,"Number of Routines:     "_RTOT)
 DO ADD^XTVSLAPI(.VALMCNT,"Size of Routines:       "_TLCNT)
 DO ADD^XTVSLAPI(.VALMCNT,"Number of Files:        "_FTOT)
 DO ADD^XTVSLAPI(.VALMCNT,"Number of Fields:       "_FLDTOT)
 DO ADD^XTVSLAPI(.VALMCNT,"Number of Options:      "_OTOT)
 DO ADD^XTVSLAPI(.VALMCNT,"Number of Protocols:    "_PRCTOT)
 DO ADD^XTVSLAPI(.VALMCNT,"Number of RPCs:         "_RPTOT)
 DO ADD^XTVSLAPI(.VALMCNT,"Number of Templates:    "_TPLTTOT)
 QUIT
 ;
COUNTFLS(PKGPFX,LINE3,LINE4,LINE7,LINE8) ;Count total # of files for a package
 ; LINE3=*Lowest File # from ^TMP("XTVS-PARAM-CAP",$J,PKGNAME,3,"*Lowest File#") or SELPKGPM
 ; LINE4=*Highest File # from ^TMP("XTVS-PARAM-CAP",$J,PKGNAME,4,"*Highest File#") or SELPKGPM
 ; LINE7=File Numbers from ^TMP("XTVS-PARAM-CAP",$J,PKGNAME,7,"File Numbers") or SELPKGPM
 ; LINE8=File Ranges from ^TMP("XTVS-PARAM-CAP",$J,PKGNAME,8,"File Ranges") or SELPKGPM
 ;
 NEW FNDFLDAT,FILELIST,PCENUM,FLERNG,STRTFNUM,ENDFNUM,FTOT,FNUM,FLDCNT
 SET (FTOT,FNDFLDAT,FLDCNT)=0
 ;
 ; 1st look for delimited list of file ranges, if exists count it only
 SET FILELIST=LINE8
 IF FILELIST'="" DO
 . SET FNDFLDAT=1
 . SET PCENUM=0
 . FOR  SET PCENUM=PCENUM+1 SET FLERNG=$P(FILELIST,"|",PCENUM) QUIT:FLERNG']""  DO
 .. SET STRTFNUM=+$P(FLERNG,"-")
 .. SET ENDFNUM=+$P(FLERNG,"-",2)
 .. IF +STRTFNUM>0,+ENDFNUM>0 SET FTOT=FTOT+$$FLECNT(STRTFNUM,ENDFNUM,.FLDCNT)
 ;
 ; 2nd if no list of file ranges, look files between Lowest and Highest file number range
 IF 'FNDFLDAT,PKGPFX'="XU" DO
 . NEW STRTFNUM,ENDFNUM,FNUM,FILENAME
 . SET STRTFNUM=LINE3
 . SET ENDFNUM=LINE4
 . IF +STRTFNUM>0,+ENDFNUM>0  SET FNDFLDAT=1 SET FTOT=FTOT+$$FLECNT(STRTFNUM,ENDFNUM,.FLDCNT)
 ;
 ; 3rd if no list of file ranges & no High/Low file range, count files in File list data element
 SET FILELIST=LINE7
 IF 'FNDFLDAT,FILELIST'="" DO
 . SET FNDFLDAT=1
 . SET PCENUM=0
 . FOR  SET PCENUM=PCENUM+1 SET FNUM=$P(FILELIST,"|",PCENUM) QUIT:FNUM']""  SET FTOT=FTOT+1 SET FLDCNT=FLDCNT+$$FLDCNTR(FNUM)
 SET FTOT=FTOT_"^"_FLDCNT
 KILL ^TMP("XTVS-FILE-CNTD",$J,PKGPFX)
 QUIT FTOT
 ;
ROUTINE(PKGPFX,TLCNT,RDP,ADP) ; Returns # of routines & total characters in all routines
 ; CNT - # characters in each routine including line feeds on each line of each routine
 NEW CNT,LPPFX,PFXLN,X,ADPFXLN,ADPFX,ADPNDE,LPCT,ADPRSET
 SET PFXLN=$L(PKGPFX)
 SET (ADPRSET,CNT)=0
 FOR LPCT=1:1 Q:$G(ADP(LPCT))=""  IF ADP(LPCT)=PKGPFX SET ADPRSET=LPCT KILL ADP(LPCT)
 SET LPPFX=""
 DO RTNLST(PKGPFX,"^TMP(""XTVS"",""RTNLST"""_","_$J_")") ;Create global of Routines with Primary Prefix
 FOR  SET LPPFX=$ORDER(^TMP("XTVS","RTNLST",$J,LPPFX)) QUIT:LPPFX=""  DO
 .IF $$ADPRDPCK(LPPFX,.RDP),$$ADPRDPCK(LPPFX,.ADP) DO
 .. SET X=LPPFX
 .. X ^%ZOSF("TEST") IF $T SET TLCNT=TLCNT+$$RSIZE(LPPFX) SET CNT=CNT+1
 KILL ^TMP("XTVS","RTNLST",$J)
 IF ADPRSET SET ADP(ADPRSET)=PKGPFX
 QUIT CNT
 ;
RTNLST(PREFIX,RTNLIST) ; Create RTNLIST of routines in PREFIX namespace
 ; NOTE: NEW RTNS will destroy the ResultSet Query object when QUIT takes RTNS out of scope
 NEW RTNS,RTNNAME
 SET RTNS=##class(%ResultSet).%New("%Routine:RoutineList") ;Create Routine Query Class instance
 DO RTNS.Execute(PREFIX_"*.INT") ;Query Routines
 FOR  Q:'RTNS.Next()  SET RTNNAME=$P(RTNS.GetData(1),".") SET @RTNLIST@(RTNNAME)=""
 QUIT
 ;
ADPRDPCK(LPPFX,CKDP) ;Check for Excepted PREFIX [Result=0 when excepted] ; Additional PREFIX [Result=0 when included in Additional]
 N RESULT,CKFX,CKFXLN,CKPNDE
 S RESULT=1
 FOR CKPNDE=1:1:CKDP SET CKFX=$G(CKDP(CKPNDE)) Q:CKFX=""  Q:'RESULT  DO
 . SET CKFXLN=$L(CKFX)
 . IF $E(LPPFX,1,CKFXLN)=CKFX SET RESULT=0 ;Do not count OR will be/already counted
 Q RESULT
 ;
FLECNT(STRTFNUM,ENDFNUM,FLDCNT) ; Count Files & Fields
 NEW FCNT,FNUM
 SET FCNT=0
 SET FNUM=$O(^DIC(STRTFNUM),-1)
 FOR  SET FNUM=$O(^DIC(FNUM)) Q:'FNUM  Q:FNUM>ENDFNUM  DO
 . IF '$D(^TMP("XTVS-FILE-CNTD",$J,PKGPFX,FNUM)) DO
 .. SET FILENAME=$P($G(^DIC(FNUM,0)),"^")
 .. IF FILENAME]"" S FCNT=FCNT+1 SET FLDCNT=FLDCNT+$$FLDCNTR(FNUM)
 .. SET ^TMP("XTVS-FILE-CNTD",$J,PKGPFX,FNUM)=""
 Q FCNT
 ;
FLDCNTR(FILENUM) ; Return # of fields
 NEW FLDCT,FIELDNUM
 SET (FLDCT,FIELDNUM)=0
 IF $D(^DD(FILENUM)) DO
 .FOR  QUIT:FIELDNUM=""  QUIT:'$D(^DD(+FILENUM,+FIELDNUM))  DO
 ..SET FIELDNUM=$O(^DD(FILENUM,FIELDNUM))
 ..IF +FIELDNUM>0 DO
 ...SET FLDCT=FLDCT+1
 ...; Check for Multiples and recursively call FLDCNTR
 ...IF +$E($P($G(^DD(FILENUM,FIELDNUM,0)),"^",2),1,1)>0 SET FLDCT=FLDCT+$$FLDCNTR(+$P($G(^DD(FILENUM,FIELDNUM,0)),"^",2))
 QUIT FLDCT
 ;
PROTOCOL(PKGPFX,PKGIEN,RDP,ADP) ; Count Protocols
 NEW LPPFX,PFXLN,CNT,ORDIEN,SPCPOS,DASHPOS,UNDRSPOS,PRTPFX,LPCT,ADPRSET,PFXANLYS,PFXEXT
 SET PFXLN=$L(PKGPFX)
 SET (ADPRSET,CNT)=0
 IF '$D(PKGIEN) SET PKGIEN=0
 IF $D(PKGIEN),(PKGIEN="") SET PKGIEN=0
 FOR LPCT=1:1 SET LPPFX=$O(ADP(LPCT)) Q:$G(ADP(LPCT))=""  IF ADP(LPCT)=PKGPFX SET ADPRSET=LPCT KILL ADP(LPCT)
 SET LPPFX=$O(^ORD(101,"B",PKGPFX),-1)
 FOR  SET LPPFX=$O(^ORD(101,"B",LPPFX)) QUIT:LPPFX=""  Q:$E(LPPFX,1,$L(PKGPFX))'=PKGPFX  SET ORDIEN=$O(^ORD(101,"B",LPPFX,""))  QUIT:ORDIEN=""  DO
 . IF $P($G(^ORD(101,ORDIEN,0)),"^",12)=PKGIEN SET CNT=CNT+1 ;In Package; count it 
 . IF ($P($G(^ORD(101,ORDIEN,0)),"^",12)="") DO
 .. SET PRTPFX=LPPFX
 .. SET SPCPOS=$FIND(PRTPFX," ")
 .. SET DASHPOS=$FIND(PRTPFX,"-")
 .. SET UNDRSPOS=$FIND(PRTPFX,"_")
 .. SET:PRTPFX[$$PFXDLIM(SPCPOS,DASHPOS,UNDRSPOS) PRTPFX=$P(PRTPFX,$$PFXDLIM(SPCPOS,DASHPOS,UNDRSPOS))
 .. IF (PRTPFX=PKGPFX),($D(RDP)),($$ADPRDPCK(PRTPFX,.RDP)) SET CNT=CNT+1 ;Do NOT count if Prefix is in Excepted list
 .. IF PRTPFX'=PKGPFX DO
 ... SET PFXAVAIL=1
 ... SET PFXANLYS=PKGPFX
 ... FOR PFXEXT=PFXLN+1:1 Q:($E(PRTPFX,PFXEXT)'?1AN)  Q:'PFXAVAIL  SET PFXANLYS=PFXANLYS_$E(PRTPFX,PFXEXT) DO
 .... IF $D(^TMP("XTVS-FORUM-PFXS",$J,PFXANLYS)) SET PFXAVAIL=0 ;Do NOT count if extended Prefix is a Package Prefix
 .... IF $D(ADP),('$$ADPRDPCK(PFXANLYS,.ADP)) SET PFXAVAIL=0 ;Do NOT count if extended Prefix is an additional Prefix
 .... IF $D(RDP),('$$ADPRDPCK(PFXANLYS,.RDP)) SET PFXAVAIL=0 ;Do NOT count if extended Prefix is excluded from Package
 ... IF PFXAVAIL SET CNT=CNT+1
 . SET LPPFX=$$QUOTEFX(LPPFX) ;So LPPFX with quote will work with FOR loop
 IF ADPRSET SET ADP(ADPRSET)=PKGPFX
 Q CNT
 ;
CNTR(TMPGLB,CNT,PKGPFX,RDP,ADP) ; Count Templates & RPCs
 NEW LPPFX,PFXLN,TMPLTPFX,PFXEXT,PFXANLYS,PFXAVAIL,SPCPOS,DASHPOS,UNDRSPOS,LPCT,ADPRSET
 SET PFXLN=$L(PKGPFX)
 SET ADPRSET=0
 FOR LPCT=1:1 SET LPPFX=$O(ADP(LPCT)) Q:$G(ADP(LPCT))=""  IF ADP(LPCT)=PKGPFX SET ADPRSET=LPCT KILL ADP(LPCT)
 SET LPPFX=$O(@(TMPGLB_"""B"","""_PKGPFX_""")"),-1)
 IF LPPFX["""" SET LPPFX=QUOTEFX(LPPFX)
 FOR  SET LPPFX=$O(@(TMPGLB_"""B"","""_LPPFX_""")")) Q:LPPFX=""  Q:$E(LPPFX,1,PFXLN)'=PKGPFX  DO
 .SET TMPLTPFX=LPPFX
 .SET SPCPOS=$FIND(TMPLTPFX," ")
 .SET DASHPOS=$FIND(TMPLTPFX,"-")
 .SET UNDRSPOS=$FIND(TMPLTPFX,"_")
 .SET:TMPLTPFX[$$PFXDLIM(SPCPOS,DASHPOS,UNDRSPOS) TMPLTPFX=$P(TMPLTPFX,$$PFXDLIM(SPCPOS,DASHPOS,UNDRSPOS))
 .IF $L(TMPLTPFX)=PFXLN,($D(RDP)),($$ADPRDPCK(TMPLTPFX,.RDP)) SET CNT=CNT+1 ;Do NOT count if Prefix is in Excepted list
 .IF $L(TMPLTPFX)>PFXLN,('$D(^TMP("XTVS-FORUM-PFXS",$J,TMPLTPFX))) DO
 ..; Above IF: Prefix starts with PKGPFX and not a specified prefix for any package
 .. SET PFXAVAIL=1
 .. SET PFXANLYS=PKGPFX
 .. FOR PFXEXT=PFXLN+1:1 Q:($E(TMPLTPFX,PFXEXT)'?1AN)  Q:'PFXAVAIL  SET PFXANLYS=PFXANLYS_$E(TMPLTPFX,PFXEXT) DO
 ... IF $D(^TMP("XTVS-FORUM-PFXS",$J,PFXANLYS)) SET PFXAVAIL=0 ;Do NOT count if extended Prefix is a Package Prefix
 ... IF $D(ADP),('$$ADPRDPCK(PFXANLYS,.ADP)) SET PFXAVAIL=0 ;Do NOT count if extended Prefix is an additional Prefix
 ... IF $D(RDP),('$$ADPRDPCK(PFXANLYS,.RDP)) SET PFXAVAIL=0 ;Do NOT count if extended Prefix is excluded from Package
 .. IF PFXAVAIL SET CNT=CNT+1
 .SET LPPFX=$$QUOTEFX(LPPFX) ;So LPPFX with quote will work with FOR loop
 IF ADPRSET SET ADP(ADPRSET)=PKGPFX
 Q
 ;
QUOTEFX(ITEMNAME) ; Return ITEMNAME with single quotes changed to double
 NEW QUPDT,LPCNT,XTVSBPC
 SET QUPDT=""
 FOR LPCNT=1:1 SET XTVSBPC=$E(ITEMNAME,LPCNT) Q:XTVSBPC=""  S QUPDT=QUPDT_XTVSBPC IF XTVSBPC="""" S QUPDT=QUPDT_""""
 SET ITEMNAME=QUPDT
 Q ITEMNAME
 ;
 ;
MULTX(APFX,PKGNAME) ; Return indication of Multiple packages using same prefix
 ;MULTX can prevent Primary prefix from double counting when added prefix on another package
 ; NOTE: This creates an error in AMIE because (Retired) COMP & PEN Primary = DVBC when DVBC is a legitimate added prefix for AMIE
 ; COMP & PEN should be deleted from the Package Parameter file
 ;
 ; ^TMP("XTVS-PREFIX-IDX",$J,PKGPFX,PKGNAME)="" ;Primary Prefix,Pkg-Name for packages in Forum Param file
 ; ^TMP("XTVS-FORUM-PFXS",$J,PREFIX)="" ;All Prefixes in package file
 ; Following ^TMP for PACKAGES in Param file : Prefix,Pkg-Name = 1 when KIDS Prefix, Null when not KIDS Prefix
 ; ^TMP("XTVS-IDX-PKG",$J,PREFIX,PKGNAME)=$S($D(^TMP("XTVS-KIDSPFX-IDX",$J,PREFIX)):1,1:"")
 ; Output: Result - 1 count prefix ; 0 don't count prefix
 NEW RESULT,LPPKG
 SET RESULT=1
 SET LPPKG=""
 ;
 ; If not the KIDS Prefix or Primary prefix, check for duplication in other packages
 IF ($G(^TMP("XTVS-KIDSPFX-IDX",$J,APFX))'=PKGNAME),('$D(^TMP("XTVS-PREFIX-IDX",$J,APFX,PKGNAME))) SET RESULT=$$CHKOTHPK(APFX,PKGNAME)
 ;
 QUIT RESULT
 ;
CHKOTHPK(APFX,PKGNAME) ; Check other packages using the same prefix
 NEW LPPKG,RESULT
 SET LPPKG=""
 SET RESULT=1
 ;
 FOR  SET LPPKG=$O(^TMP("XTVS-IDX-PKG",$J,APFX,LPPKG)) Q:LPPKG=""  Q:'RESULT  IF (LPPKG'=PKGNAME) DO
 . IF $G(^TMP("XTVS-IDX-PKG",$J,APFX,LPPKG))=1 SET RESULT=0 ;APFX: KIDS prefix for another package in Param file
 . IF $D(^TMP("XTVS-PREFIX-IDX",$J,APFX,LPPKG)) SET RESULT=0 ;APFX: Primay prefix for other package in Param file
 ;
 QUIT RESULT
 ;
KIDSIDX ;Create Prefix-Package Indexes from KIDS patches for builds linked to Package file
 NEW KIDSIEN,KIDSPKG,KIDSPRFX,KIDSZERO,PKGIEN,PATCHNME
 SET KIDSIEN=0
 FOR  SET KIDSIEN=$O(^XPD(9.6,KIDSIEN)) Q:+KIDSIEN=0  DO
 . SET KIDSZERO=$G(^XPD(9.6,KIDSIEN,0))
 . IF KIDSZERO]"" DO
 .. SET PKGIEN=$P(KIDSZERO,"^",2)
 .. IF +PKGIEN>0 DO
 ... SET KIDSPKG=$P($G(^DIC(9.4,PKGIEN,0)),"^",1)
 ... SET PATCHNME=$P(KIDSZERO,"^",1)
 ... SET KIDSPRFX=$P(PATCHNME,"*",1)
 ... IF KIDSPRFX]"" SET ^TMP("XTVS-KIDSPFX-IDX",$J,KIDSPRFX)=KIDSPKG
 QUIT
 ;
PARAMIDX ;Create Prefix Indicies
 NEW PKGNAME,LINEITEM,TMPSUB,PKGPFX,ADDPRFX,PREFIX
 ;
 SET TMPSUB=0
 FOR  SET TMPSUB=$O(^TMP("XTVS-PARAM-CAP",$J,TMPSUB)) QUIT:TMPSUB=""  DO
 .SET LINEITEM=^TMP("XTVS-PARAM-CAP",$J,TMPSUB)
 .SET PKGNAME=$P(LINEITEM,"^")
 .SET PKGPFX=$P(LINEITEM,"^",2)
 .SET ^TMP("XTVS-PREFIX-IDX",$J,PKGPFX,PKGNAME)="" ;Primary Prefix,Pkg-Name for packages in remote (E.G. Forum) Param file
 .SET ^TMP("XTVS-FORUM-PFXS",$J,PKGPFX)="" ;Prefix
 .; Following ^TMP for PACKAGES in Param file: Prefix,Pkg-Name = 1 when KIDS Prefix, Null when not KIDS Prefix
 .;SET ^TMP("XTVS-IDX-PKG",$J,PKGPFX,PKGNAME)=$S($D(^TMP("XTVS-KIDSPFX-IDX",$J,PKGPFX)):1,1:"")
 . IF '$D(^TMP("XTVS-KIDSPFX-IDX",$J,PKGPFX)) SET ^TMP("XTVS-IDX-PKG",$J,PKGPFX,PKGNAME)=""
 . IF $D(^TMP("XTVS-KIDSPFX-IDX",$J,PKGPFX)) SET ^TMP("XTVS-IDX-PKG",$J,PKGPFX,PKGNAME)=$S(^TMP("XTVS-KIDSPFX-IDX",$J,PKGPFX)=PKGNAME:1,1:"")
 .;
 .SET ADDPRFX=$P(LINEITEM,"^",5)
 .SET LPCNT=0
 .FOR PCENUM=1:1 SET PREFIX=$P(ADDPRFX,"|",PCENUM) Q:PREFIX=""  DO
 .. SET ^TMP("XTVS-FORUM-PFXS",$J,PREFIX)="" ;Prefix
 .. ; Following ^TMP for PACKAGES in Param file : Prefix,Pkg-Name = 1 when KIDS Prefix, Null when not KIDS Prefix
 .. SET ^TMP("XTVS-IDX-PKG",$J,PREFIX,PKGNAME)=$S($D(^TMP("XTVS-KIDSPFX-IDX",$J,PREFIX)):1,1:"")
 ;
 QUIT
 ;
RSIZE(RTN) ; Compute routine size (# characters plus line feeds)  [^%ZOSF("SIZE") algorithm]
 NEW LINE,CT,RSIZEVAL
 SET (CT,RSIZEVAL)=0
 SET LINE=""
 X "ZL @RTN F  S CT=CT+1,LINE=$T(+CT) Q:$L(LINE)=0  SET RSIZEVAL=RSIZEVAL+$L(LINE)+2"
 QUIT RSIZEVAL
 ;
PFXDLIM(SPCPOS,DASHPOS,UNDRSPOS) ; Return the delimter for lowest pos #
 NEW DELIM
 SET:SPCPOS=0 SPCPOS=9999
 SET:DASHPOS=0 DASHPOS=9999
 SET:UNDRSPOS=0 UNDRSPOS=9999
 SET DELIM=" "
 SET:((SPCPOS<DASHPOS)&(SPCPOS<UNDRSPOS)) DELIM=" "
 SET:((DASHPOS<SPCPOS)&(DASHPOS<UNDRSPOS)) DELIM="-"
 SET:((UNDRSPOS<DASHPOS)&(UNDRSPOS<SPCPOS)) DELIM="_"
 QUIT DELIM
