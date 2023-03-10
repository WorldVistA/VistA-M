XTVSLPER ;Albany FO/GTS - VistA Package Sizing Manager; 7-JUL-2016
 ;;7.3;TOOLKIT;**143**;Apr 25, 1995;Build 116
 ;
EN ; -- main entry point for XTVS PKG MGR PARAM ERROR DISP
 D EN^VALM("XTVS PKG MGR PARAM ERROR DISP")
 Q
 ;
HDR ; -- header code
 NEW DEFDIR,SPCPAD,DIRHEAD
 SET SPCPAD=""
 SET DEFDIR=$$GET^XPAR("SYS","XTVS PACKAGE MGR DEFAULT DIR",1,"I")
 SET VALMHDR(1)="           VistA Package Size Analysis Manager - Prefix/File Overlap"
 SET VALMHDR(2)="                         Version: "_$$VERNUM^XTVSLM()_"     Build: "_$$BLDNUM^XTVSLM()
 SET DIRHEAD="Default Directory: "_DEFDIR
 SET $P(SPCPAD," ",(80-$L(DIRHEAD))/2)=""
 SET VALMHDR(3)=SPCPAD_DIRHEAD
 SET SPCPAD=""
 SET DIRHEAD="Parameter file: "_XTVPSPRM
 SET $P(SPCPAD," ",(80-$L(DIRHEAD))/2)=""
 SET VALMHDR(4)=SPCPAD_DIRHEAD
 QUIT
 ;
INIT ; -- init variables and list array
 DO KILL
 DO INCONSCK^XTVSLPR1 ; Check for package Prefix/File Range Overlaps
 DO MSG
 ;
 NEW CMBLP
 SET CMBLP=""
 SET VALMCNT=0
 FOR  SET CMBLP=$O(^TMP("XTVS-ERROR",$J,"COMB-PFX-FLRNG",CMBLP)) Q:CMBLP=""  DO ADD^XTVSLAPI(.VALMCNT,^TMP("XTVS-ERROR",$J,"COMB-PFX-FLRNG",CMBLP))
 QUIT
 ;
HELP ; -- help code
 IF $D(X),X'["??" DO
 . SET X="?"
 . DO DISP^XQORM1 W !
 IF $D(X),X["??",X'["???" DO
 . SET XTQVAR=0
 . DO CLEAR^VALM1
 . DO FULL^VALM1
 . FOR TXTCT=1:1 SET XTX=$P($T(LPERTXT2+TXTCT^XTVSHELP),";",3,99) QUIT:XTX="$END"  QUIT:XTQVAR  DO
 .. IF XTX="$PAUSE" DO PAUSE^VALM1 D:Y CLEAR^VALM1 IF 'Y SET XTQVAR=1 QUIT
 .. W !,$S(XTX["$PAUSE":"",1:XTX)
 . IF 'XTQVAR DO
 .. D CLEAR^VALM1
 .. WRITE !,"Possible actions on the Prefix/File Overlap list are the following:"
 .. SET X="?"
 .. DO DISP^XQORM1 W !!
 IF $D(X),X["???" DO
 . DO CLEAR^VALM1
 . DO FULL^VALM1
 . SET XTQVAR=0
 . FOR TXTCT=1:1 SET XTX=$P($T(LPERTXT3+TXTCT^XTVSHELP),";",3,99) QUIT:XTX="$END"  QUIT:XTQVAR  DO
 .. IF XTX="$PAUSE" DO PAUSE^VALM1 D:Y CLEAR^VALM1 IF 'Y SET XTQVAR=1 QUIT
 .. W !,$S(XTX["$PAUSE":"",1:XTX)
 . IF 'XTQVAR DO
 .. D CLEAR^VALM1
 .. WRITE !,"Possible actions on the Prefix/File Overlap list are the following:"
 .. SET X="?"
 .. DO DISP^XQORM1 W !!
 D MSG
 S VALMBCK="R"
 K XTX,Y,TXTCT,XTQVAR
 QUIT
 ;
MSG(TEXT) ; -- set default message
 IF $G(TEXT)]"" SET VALMSG=TEXT
 IF $G(TEXT)']"" SET VALMSG="Enter ?? : more actions & Help, ??? : Prefix Help"
 QUIT
 ;
EXIT ; -- exit code
 DO KILL
 Q
 ;
KILL ; - Clean up local and global display arrays
 DO CLEAN^VALM10 ;Kill data and video control arrays
 DO KILL^VALM10() ;Kill Video attributes
 KILL ^TMP("XTVS PKG MGR PARAM ERROR DISP",$JOB),^TMP("XTVS-ERROR",$J)
 QUIT
 ;
 ;Action Protocol APIs
DPFXERR ; Display prefix overlap list
 ; -- Protocol: XTVS PKG MGR PREFIX OVERLAP ACTION
 ;
 NEW LPITEM
 SET VALMHDR(1)="           VistA Package Size Analysis Manager - Prefix Overlap"
 KILL ^TMP("XTVS PKG MGR PARAM ERROR DISP",$JOB)
 SET VALMCNT=0
 NEW LPITEM
 SET LPITEM=""
 FOR  SET LPITEM=$O(^TMP("XTVS-ERROR",$J,"PREFIX",LPITEM)) Q:LPITEM=""  DO ADD^XTVSLAPI(.VALMCNT,^TMP("XTVS-ERROR",$J,"PREFIX",LPITEM))
 SET VALMBG=1
 DO MSG
 SET VALMBCK="R"
 QUIT
 ;
DRNGERR ; Display File range errors
 ; -- Protocol: XTVS PKG MGR FILE OVERLAP ACTION
 ;
 NEW LPITEM
 SET VALMHDR(1)="           VistA Package Size Analysis Manager - File Overlap"
 KILL ^TMP("XTVS PKG MGR PARAM ERROR DISP",$JOB)
 SET VALMCNT=0
 SET LPITEM=""
 FOR  SET LPITEM=$O(^TMP("XTVS-ERROR",$J,"FILERNG",LPITEM)) Q:LPITEM=""  DO ADD^XTVSLAPI(.VALMCNT,^TMP("XTVS-ERROR",$J,"FILERNG",LPITEM))
 SET VALMBG=1
 DO MSG
 SET VALMBCK="R"
 QUIT
 ;
CMBERR ; Redisplay Prefix/File Range overlaps
 ; -- Protocol: XTVS PKG MGR PARAM OVRLP REDISP ACTION
 ;
 NEW CMBLP
 ;
 SET VALMHDR(1)="           VistA Package Size Analysis Manager - Prefix/File Overlap"
 KILL ^TMP("XTVS PKG MGR PARAM ERROR DISP",$JOB)
 SET VALMCNT=0
 SET CMBLP=0
 FOR  SET CMBLP=$O(^TMP("XTVS-ERROR",$J,"COMB-PFX-FLRNG",CMBLP)) Q:CMBLP=""  DO ADD^XTVSLAPI(.VALMCNT,^TMP("XTVS-ERROR",$J,"COMB-PFX-FLRNG",CMBLP))
 SET VALMBG=1
 DO MSG
 SET VALMBCK="R"
 QUIT
 ;
ERPT ; Email ^TMP("XTVS PKG MGR PARAM ERROR DISP") displayed report
 ; -- Protocol: XTVS PKG MGR EMAIL OVRLAP RPT ACTION
 ;
 NEW XTINSTMM,XTTOMM,XMERR,XMZ,XTTYPE
 DO FULL^VALM1
 WRITE !!," The message can take some time to be sent.",!
 KILL XMERR
 SET XTINSTMM("ADDR FLAGS")="R"  ;Do not Restrict addressing
 SET XTTYPE="S"
 DO TOWHOM^XMXAPIU(DUZ,,XTTYPE,.XTINSTMM)
 IF +$G(XMERR)'>0 DO
 . NEW XMY,XMTEXT,XMDUZ,XMSUB,XTLPCNT
 . SET XTLPCNT=""
 . FOR  SET XTLPCNT=$O(^TMP("XMY",$J,XTLPCNT)) QUIT:XTLPCNT=""  SET XMY(XTLPCNT)=""
 . SET XMDUZ=DUZ
 . SET XMSUB=$P(VALMHDR(4),":",2)_" ("_$P(VALMHDR(1)," - ",2)_")"
 . SET XMTEXT="^TMP(""XTVS PKG MGR PARAM ERROR DISP"","_$JOB_","
 . DO ^XMD
 . IF +XMZ>0 DO JUSTPAWS^XTVSLAPI($P(VALMHDR(1)," - ",2)_" Emailed.  [MSG #:"_XMZ_"]")
 . IF +XMZ'>0  DO JUSTPAWS^XTVSLAPI("Error: ^TMP(""XTVS PKG MGR PARAM ERROR DISP"","_$JOB_") not Emailed! ["_XMZ_"]")
 ;
 DO MSG
 SET VALMBCK="R"
 QUIT
