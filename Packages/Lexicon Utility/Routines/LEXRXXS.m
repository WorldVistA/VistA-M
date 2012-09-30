LEXRXXS ;ISL/KER - Re-Index Save/Send ;08/17/2011
 ;;2.0;LEXICON UTILITY;**81**;Sep 23, 1996;Build 1
 ;               
 ; Global Variables
 ;    ^LEX(               SACC 1.3
 ;    ^LEXT(              SACC 1.3
 ;    ^TMP("LEXRX")       SACC 2.3.2.5.1
 ;               
 ; External References
 ;    HOME^%ZIS           ICR  10086
 ;    $$TITLE^XLFSTR      ICR  10104
 ;    ^XMD                ICR  10070
 ;               
 ; Local Variables NEWed or KILLed Elsewhere
 ;     LEXAMSO    User Selection  NEWed/KILLed by LEXRX
 ;     LEXSUBJ    Msg Subject     NEWed/KILLed by LEXRXXT
 ;     LEXTITL    Msg Title       NEWed/KILLed by LEXRXXT
 ;     LEXFMT     Display format  NEWed/KILLed by LEXRXXT2
 ;     LEXQ       Quiet flag      NEWed/KILLed by LEXRXXT2
 ;     LEXNAM     Task Name       NEWed/KILLed by LEXRXXT2
 ;     LEXINS     Install Flag    NEWed/KILLed by Post-Install
 ;     ZTQUEUED   Task flag       NEWed/KILLed by Taskman
 ;
 Q
 ; Repair Index Report
REP(LEXFI,LEXFS,LEXIDX,LEXNDS,LEXERR,LEXIDXT,LEXELP) ;   Build
 S LEXFI=$G(LEXFI),LEXFS=$G(LEXFS),LEXIDX=$G(LEXIDX),LEXNDS=+($G(LEXNDS))
 S LEXERR=+($G(LEXERR)),LEXIDXT=$G(LEXIDXT),LEXELP=$G(LEXELP) H 1
 S:+($G(LEXFI))>0&('$L($G(LEXELP))) LEXELP="00:00:01"
 N LEXT,LEXNM,LEXTELP,LEXTERR,LEXTFI,LEXTFS,LEXTIDT,LEXTIDX,LEXTNDS,LEXIDXN
 S LEXTFI=+LEXFI Q:+LEXTFI'>0  Q:$P(LEXTFI,".",1)'="757"  S LEXNM=$$FN(+LEXFI)
 S:'$L(LEXNM) LEXTFI="  "_LEXTFI
 S LEXTFS=+($G(LEXFS))
 Q:+LEXTFS'>0  Q:$P(LEXTFS,".",1)'="757"
 S:'$L(LEXNM) LEXTFS="  "_LEXTFS
 S LEXTIDX=$G(LEXIDX)  Q:'$L(LEXTIDX)
 S LEXTNDS=LEXNDS S:+LEXTNDS'>0 LEXTNDS=""
 I +LEXNDS'>0,+LEXFI>0,+LEXFS>0,$L(LEXIDX),LEXIDX'="ALLIX" D  Q
 . K ^TMP("LEXRX",$J,"D",1,+LEXFI,+LEXFS,LEXIDX)
 . D REPS
 S LEXTERR=+($G(LEXERR)) S:+LEXTERR'>0 LEXTERR=""
 S:+($G(LEXERR))>0 LEXTERR=$J(LEXTERR,7)_" "
 S:+($G(LEXERR))'>0 LEXTERR=" ------ "
 S:+($G(LEXERR))'>0&(LEXIDX="ALLIX") LEXTERR="        "
 S:LEXIDX="ALLIX" LEXTNDS=""
 S LEXTNDS=$J(LEXTNDS,8)_" "
 S LEXTIDT=$G(LEXIDXT)
 S:LEXIDX="ALLIX" LEXIDXT="All Cross-References"
 S LEXIDXT=$E(LEXIDXT,1,35)
 Q:'$L(LEXTIDT)
 S LEXTELP=LEXELP
 S LEXTELP=LEXTELP_$J(" ",(9-$L(LEXTELP)))
 S LEXTFI=LEXTFI_$J(" ",(9-$L(LEXTFI)))
 S LEXTFS=LEXTFS_$J(" ",(9-$L(LEXTFS)))
 S:LEXIDX="ALLIX" LEXTIDX="Re-Index"
 S LEXTIDX=LEXTIDX_$J(" ",(9-$L(LEXTIDX)))
 S:LEXTFI=LEXTFS LEXT=LEXTFI_LEXTIDX_LEXTNDS_LEXTERR_LEXTELP_LEXIDXT
 S:LEXTFI'=LEXTFS LEXT=LEXTFS_LEXTIDX_LEXTNDS_LEXTERR_LEXTELP_LEXIDXT
 S:+($G(LEXERR)) ^TMP("LEXRX",$J,"ERR")=+($G(^TMP("LEXRX",$J,"ERR")))+($G(LEXERR))
 I $L($G(LEXELP)) D
 . N LEXT S LEXT=$G(^TMP("LEXRX",$J,"T",1,"ELAP"))
 . S ^TMP("LEXRX",$J,"T",1,"ELAP")=$$ADDT^LEXRXXM(LEXT,$G(LEXELP))
 S LEXIDXN=LEXIDX S:LEXIDX="ALLIX" LEXIDXN="~"
 I LEXT["Re-Index"&(LEXT["All Cross-References") D
 . S ^TMP("LEXRX",$J,"D",1,+LEXFI,"~",LEXIDXN)=LEXT
 I LEXT'["Re-Index"!(LEXT'["All Cross-References") D
 . S ^TMP("LEXRX",$J,"D",1,+LEXFI,+LEXFS,LEXIDXN)=LEXT
 D REPS
 Q
REPS ;   Save
 K ^TMP("LEXRX",$J,"R",1)
 N LEXALL,LEXTFI,LEXTFS,LEXTIX,LEXC,LEXT K LEXALL S LEXC=0,LEXTFI="" F  S LEXTFI=$O(^TMP("LEXRX",$J,"D",1,LEXTFI)) Q:'$L(LEXTFI)  D
 . S LEXTFS="" F  S LEXTFS=$O(^TMP("LEXRX",$J,"D",1,LEXTFI,LEXTFS)) Q:'$L(LEXTFS)  D
 . . K LEXALL S LEXTIX="" F  S LEXTIX=$O(^TMP("LEXRX",$J,"D",1,LEXTFI,LEXTFS,LEXTIX)) Q:'$L(LEXTIX)  D
 . . . S LEXT=$G(^TMP("LEXRX",$J,"D",1,LEXTFI,LEXTFS,LEXTIX)) Q:'$L(LEXT)  S LEXC=LEXC+1
 . . . I LEXT["Re-Index"&(LEXT["All Cross-References") S LEXALL=LEXT Q
 . . . I LEXC=1 D
 . . . . S ^TMP("LEXRX",$J,"R",1,1)="Repair Summary (large files only)"
 . . . . S:$G(LEXNAM)="LEXRXONE" ^TMP("LEXRX",$J,"R",1,1)="Repair File"
 . . . . S ^TMP("LEXRX",$J,"R",1,2)="   "
 . . . . S ^TMP("LEXRX",$J,"R",1,3)="File     Index    Nodes    Errors    Time   Index Format"
 . . . . S ^TMP("LEXRX",$J,"R",1,4)="-------- ------   -------- ------- -------- -----------------------------------"
 . . . . S ^TMP("LEXRX",$J,"R",1,0)=4,LEXC=5
 . . . S ^TMP("LEXRX",$J,"R",1,LEXC)=LEXT,^TMP("LEXRX",$J,"R",1,0)=LEXC
 . . I $L($G(LEXALL)) D
 . . . N LEXC S LEXC=$O(^TMP("LEXRX",$J,"R",1," "),-1)+1
 . . . S ^TMP("LEXRX",$J,"R",1,LEXC)=LEXALL,^TMP("LEXRX",$J,"R",1,0)=LEXC
 D RCMP
 Q
REPD ;   Display
 N LEXC W ! S LEXC=0 F  S LEXC=$O(^TMP("LEXRX",$J,"R",1,LEXC)) Q:+LEXC'>0  W !,$G(^TMP("LEXRX",$J,"R",1,LEXC))
 W !
 Q
 ;               
 ; Re-Index Report
REX(LEXFI,LEXNM,LEXELP,LEXIX) ;    Build
 K ^TMP("LEXRX",$J,"R",2)
 N LEXI,LEXSP,LEXTFI,LEXTNM,LEXTELP,LEXC S $P(LEXSP," ",40)=" ",LEXFI=+($G(LEXFI))
 S:+($G(LEXFI))>0&($L($G(LEXNM)))&('$L($G(LEXELP))) LEXELP="00:00:01"
 K:+LEXFI>0 ^TMP("LEXRX",$J,"D",2,+LEXFI)
 S LEXTFI=+($G(LEXFI)) Q:+LEXTFI'>0  Q:$P(LEXTFI,".",1)'="757"
 S LEXTFI=LEXTFI_$J(" ",(8-$L(LEXTFI))) S LEXTNM=$G(LEXNM) S LEXTNM=LEXTNM_$J(" ",(22-$L(LEXTNM)))
 S LEXTELP=$G(LEXELP) S LEXTELP=LEXTELP_$J(" ",(10-$L(LEXTELP)))
 S LEXT=LEXTFI_LEXTNM_LEXTELP_$G(LEXIX(1))
 I $L($G(LEXELP)) D
 . S ^TMP("LEXRX",$J,"T",2,"ELAP")=$$ADDT^LEXRXXM($G(^TMP("LEXRX",$J,"T",2,"ELAP")),$G(LEXELP))
 S ^TMP("LEXRX",$J,"D",2,LEXFI,1)=LEXT
 S LEXC=1 I $O(LEXIX(1))>0 D
 . S LEXI=1 F  S LEXI=$O(LEXIX(LEXI)) Q:+LEXI'>0  D
 . . N LEX S LEX=$G(LEXIX(LEXI)) Q:'$L(LEX)
 . . S LEXT=LEXSP_LEX,LEXC=LEXC+1
 . . W !,LEXT S ^TMP("LEXRX",$J,"D",2,+LEXFI,LEXC)=LEXT
 D REXS
 Q
REXS ;   Save
 K ^TMP("LEXRX",$J,"R",2)
 N LEXFIT,LEXI,LEXC,LEXT,LEXE S LEXC=0,LEXFIT="" F  S LEXFIT=$O(^TMP("LEXRX",$J,"D",2,LEXFIT)) Q:'$L(LEXFIT)  D
 . S LEXI=0 F  S LEXI=$O(^TMP("LEXRX",$J,"D",2,LEXFIT,LEXI)) Q:+LEXI'>0  D
 . . S LEXT=$G(^TMP("LEXRX",$J,"D",2,LEXFIT,LEXI)) Q:'$L(LEXT)  S LEXC=LEXC+1 I LEXC=1 D
 . . . S ^TMP("LEXRX",$J,"R",2,1)="Re-Index Summary (small files only)"
 . . . S:$G(LEXNAM)="LEXRXONE" ^TMP("LEXRX",$J,"R",2,1)="Re-Index File"
 . . . S ^TMP("LEXRX",$J,"R",2,2)=" "
 . . . S ^TMP("LEXRX",$J,"R",2,3)="File    File Name               Time    Cross-References"
 . . . S ^TMP("LEXRX",$J,"R",2,4)="------- --------------------- --------  -------------------------------------"
 . . . S ^TMP("LEXRX",$J,"R",2,0)=4,LEXC=5
 . . S ^TMP("LEXRX",$J,"R",2,LEXC)=LEXT,^TMP("LEXRX",$J,"R",2,0)=LEXC
 D RCMP
 Q
REXD ;   Display
 N LEXC W ! S LEXC=0 F  S LEXC=$O(^TMP("LEXRX",$J,"R",2,LEXC)) Q:+LEXC'>0  W !,$G(^TMP("LEXRX",$J,"R",2,LEXC))
 W !
 Q
 ;               
 ; Compile Report (Repair/Re-Index)
RCMP ;   Compile
 K ^TMP("LEXRX",$J,"R",3)
 N LEXI,LEXC,LEXE,LEXN1,LEXN2,LEXTT,LEXT1,LEXT2,LEXLEN
 S LEXLEN=33 S:$G(LEXFMT)=2!($G(LEXFMT)=0) LEXLEN=30
 S (LEXI,LEXC)=0 F  S LEXI=$O(^TMP("LEXRX",$J,"R",1,LEXI))  Q:+LEXI'>0  D
 . N LEXT S LEXC=LEXC+1,LEXT=$G(^TMP("LEXRX",$J,"R",1,LEXI)),^TMP("LEXRX",$J,"R",3,LEXC)=LEXT
 I $O(^TMP("LEXRX",$J,"R",1,0))>0,$O(^TMP("LEXRX",$J,"R",2,0))>0 D
 . S LEXC=$O(^TMP("LEXRX",$J,"R",3," "),-1)+1,^TMP("LEXRX",$J,"R",3,LEXC)=" "
 S LEXI=0 F  S LEXI=$O(^TMP("LEXRX",$J,"R",2,LEXI))  Q:+LEXI'>0  D
 . N LEXT S LEXC=LEXC+1,LEXT=$G(^TMP("LEXRX",$J,"R",2,LEXI)),^TMP("LEXRX",$J,"R",3,LEXC)=LEXT
 S LEXTT=$$TOT^LEXRXXM
 S LEXT1=$G(^TMP("LEXRX",$J,"T",1,"ELAP")),LEXT2=$G(^TMP("LEXRX",$J,"T",2,"ELAP"))
 S LEXN1=+($P(LEXT1,":",1))+($P(LEXT1,":",2))+($P(LEXT1,":",3))
 S LEXN2=+($P(LEXT2,":",1))+($P(LEXT2,":",2))+($P(LEXT2,":",3))
 S:LEXN1'>0&($G(LEXAMSO)="O")&(+($G(LEXFI))>0) LEXTT=$$ADD^LEXRXXM(LEXT1,1)
 S:LEXN2'>0&($G(LEXAMSO)="O")&(+($G(LEXFI))>0) LEXTT=$$ADD^LEXRXXM(LEXT2,1)
 S:LEXN1>0&(LEXN2'>0) LEXTT=$$ADD^LEXRXXM(LEXT1,1)
 S:LEXN1'>0&(LEXN2>0) LEXTT=$$ADD^LEXRXXM(LEXT2,1)
 S:LEXN1>0&(LEXN2>0) LEXTT=$$ADDT^LEXRXXM(LEXT1,LEXT2)
 S LEXC=$O(^TMP("LEXRX",$J,"R",3," "),-1)+1,^TMP("LEXRX",$J,"R",3,LEXC)=" "
 I $G(LEXFMT)=3 D
 . Q  S LEXC=$O(^TMP("LEXRX",$J,"R",3," "),-1)+1,^TMP("LEXRX",$J,"R",3,LEXC)=" Elapsed Time"
 . I +($G(LEXN1))>0 D
 . . N LEXT S LEXC=$O(^TMP("LEXRX",$J,"R",3," "),-1)+1,LEXT="     Repair Large Files:",LEXT=LEXT_$J(" ",(LEXLEN-$L(LEXT)))
 . . S ^TMP("LEXRX",$J,"R",3,LEXC)=LEXT_$G(LEXT1)
 . I +($G(LEXN2))>0 D
 . . N LEXT S LEXC=$O(^TMP("LEXRX",$J,"R",3," "),-1)+1
 . . S LEXT="     Re-Index Small Files:",LEXT=LEXT_$J(" ",(LEXLEN-$L(LEXT)))
 . . S ^TMP("LEXRX",$J,"R",3,LEXC)=LEXT_$G(LEXT2)
 . I +LEXN1>0!(LEXN2>0) D
 . . N LEXT S LEXC=$O(^TMP("LEXRX",$J,"R",3," "),-1)+1,LEXT="     Total All Files:",LEXT=LEXT_$J(" ",(LEXLEN-$L(LEXT)))
 . . S ^TMP("LEXRX",$J,"R",3,LEXC)=LEXT_$G(LEXTT)
 I $G(LEXFMT)=1 D
 . Q  N LEXE,LEXT S LEXT=" Repair Large Files:"
 . S:$G(LEXAMSO)="O"&(+($G(LEXFI))>0) LEXT=" Repair File "_+($G(LEXFI))_":"
 . S LEXT=LEXT_$J(" ",(LEXLEN-$L(LEXT)))
 . S LEXE=$$ADD^LEXRXXM($G(LEXT1),1) I +($G(LEXN1))>0!(LEXAMSO="O") D
 . . S LEXC=$O(^TMP("LEXRX",$J,"R",3," "),-1)+1
 . . S ^TMP("LEXRX",$J,"R",3,LEXC)=LEXT_$G(LEXE)
 I $G(LEXFMT)=2 D
 . Q  N LEXE,LEXT S LEXT=" Re-Index Small Files:"
 . S:$G(LEXAMSO)="O"&(+($G(LEXFI))>0) LEXT=" Re-Index File "_+($G(LEXFI))_":"
 . S:$G(LEXTITL)["Kill" LEXT=" Kill/Re-Index All Files:"
 . S LEXT=LEXT_$J(" ",(LEXLEN-$L(LEXT)))
 . N LEXE S LEXE=$$ADD^LEXRXXM(LEXT2,1) I +LEXN2>0!($G(LEXAMSO)="O") D
 . . S LEXC=$O(^TMP("LEXRX",$J,"R",3," "),-1)+1
 . . S ^TMP("LEXRX",$J,"R",3,LEXC)=LEXT_$G(LEXE)
 Q
RCMD ;   Display
 N LEXC W ! S LEXC=0 F  S LEXC=$O(^TMP("LEXRX",$J,"R",3,LEXC)) Q:+LEXC'>0  W !,$G(^TMP("LEXRX",$J,"R",3,LEXC))
 W !
 Q
 ;                
SEND ; Task MAILMAN to Send Message
 G:$D(LEXQ) MAILQ N LEX,LEXC,LEXI,LEXS,LEXT
 K ^TMP("LEXRX",$J,"MSG")
 S LEXC=1,LEXI=0 F  S LEXI=$O(^TMP("LEXRX",$J,"R",3,LEXI)) Q:+LEXI'>0  D
 . S LEXT=$E($G(^TMP("LEXRX",$J,"R",3,LEXI)),1,79)
 . I LEXT[" (large files only)"!(LEXT[" (small files only)") D  Q
 . . S LEXC=LEXC+1,^TMP("LEXRX",$J,"MSG",LEXC,0)=LEXT
 . S LEXC=LEXC+1,^TMP("LEXRX",$J,"MSG",LEXC,0)=LEXT
 D ERR,SUM S LEXC=$O(^TMP("LEXRX",$J,"MSG"," "),-1)
 I +LEXC>1 S ^TMP("LEXRX",$J,"MSG",1,0)=" ",^TMP("LEXRX",$J,"MSG",(LEXC+1),0)=" "
 S LEXC=$O(^TMP("LEXRX",$J,"MSG"," "),-1),^TMP("LEXRX",$J,"MSG",0)=+LEXC
 S LEXS="Lexicon Index Repair/Re-Index Report" S:$L($G(LEXSUBJ)) LEXS=$G(LEXSUBJ)
 D PRG,MAIL,HOME^%ZIS
 Q
MAIL ;   MAILMAN
 N DIFROM,XCNP,XMDUZ,XMSUB,XMTEXT,XMY,XMZ,Y
 G:'$D(^TMP("LEXRX",$J,"MSG")) MAILQ G:+($G(^TMP("LEXRX",$J,"MSG",0)))=0 MAILQ
 K XMZ N DIFROM S XMSUB="Lexicon Cross-Reference Repair/Re-Index"
 S:$L($G(LEXSUBJ)) XMSUB=$G(LEXSUBJ)
 K XMY S:+($G(DUZ))>0 XMY(+($G(DUZ)))=""
 I $D(LEXINS) D
 . K XMY N LEXADR S LEXADR=$$ADR Q:'$L(LEXADR)
 . S LEXADR="G.LEXINS@"_LEXADR S XMY(LEXADR)=""
 G:'$D(XMY) MAILQ
 S XMTEXT="^TMP(""LEXRX"",$J,""MSG"",",XMDUZ=.5 D ^XMD
 I '$D(ZTQUEUED),+($G(XMZ))>0,'$D(LEXINS) D
 . W !!," Lexicon Cross-Reference Repair/Re-Index message (#",+($G(XMZ)),") sent"
MAILQ ;   End of MAILMAN
 K ^TMP("LEXRX",$J) K DIFROM,XCNP,XMDUZ,XMSUB,XMTEXT,XMY,XMZ,Y
 Q
 ;
 ; Miscellaneous
SUM ;   Timing Summary 
 I $O(^TMP("LEXRX",$J,"MSG",0))>0 D
 . N LEXBEG,LEXEND,LEXELP,LEXC
 . S LEXBEG=+($G(^TMP("LEXRX",$J,"P",1))) Q:$P(LEXBEG,".",1)'?7N
 . S LEXEND=+($G(^TMP("LEXRX",$J,"P",2))) Q:$P(LEXEND,".",1)'?7N
 . Q:LEXBEG=LEXEND  S LEXELP=$$FMDIFF^XLFDT(LEXEND,LEXBEG,3) Q:$L(LEXELP,":")'=3
 . S:$E(LEXELP,1)=" "&($E(LEXELP,3)=":") LEXELP=$TR(LEXELP," ","0")
 . S LEXC=$O(^TMP("LEXRX",$J,"MSG"," "),-1)
 . S LEXT=$$TM^LEXRXXM($G(^TMP("LEXRX",$J,"MSG",LEXC,0)))
 . I $L(LEXT) D
 . . S LEXC=$O(^TMP("LEXRX",$J,"MSG"," "),-1)+1
 . . S ^TMP("LEXRX",$J,"MSG",LEXC,0)=" "
 . S LEXT="Re-Index Started:   "_$$ED^LEXRXXM(LEXBEG)
 . S LEXC=$O(^TMP("LEXRX",$J,"MSG"," "),-1)+1
 . S ^TMP("LEXRX",$J,"MSG",LEXC,0)=LEXT
 . S LEXT="Re-Index Finished:  "_$$ED^LEXRXXM(LEXEND)
 . S LEXC=$O(^TMP("LEXRX",$J,"MSG"," "),-1)+1
 . S ^TMP("LEXRX",$J,"MSG",LEXC,0)=LEXT
 . S LEXT="Elapsed Time:       "_LEXELP
 . S LEXC=$O(^TMP("LEXRX",$J,"MSG"," "),-1)+1
 . S ^TMP("LEXRX",$J,"MSG",LEXC,0)=LEXT
 Q
ERR ;   Error Summary 
 I $O(^TMP("LEXRX",$J,"MSG",0))>0 D
 . N LEXE,LEXT,LEXC
 . S LEXE=+($G(^TMP("LEXRX",$J,"ERR"))) Q:LEXE'>0
 . S LEXC=$O(^TMP("LEXRX",$J,"MSG"," "),-1)
 . S LEXT=$$TM^LEXRXXM($G(^TMP("LEXRX",$J,"MSG",LEXC,0)))
 . I $L(LEXT) D
 . . S LEXC=$O(^TMP("LEXRX",$J,"MSG"," "),-1)+1
 . . S ^TMP("LEXRX",$J,"MSG",LEXC,0)=" "
 . S LEXT="Errors Repaired:    "
 . S LEXT=LEXT_LEXE
 . S LEXC=$O(^TMP("LEXRX",$J,"MSG"," "),-1)+1
 . S ^TMP("LEXRX",$J,"MSG",LEXC,0)=LEXT
 Q
ADR(LEX) ; Mailing Address -G.LEXINS@FO-SLC.DOMAIN.EXT,
 N DIC,DTOUT,DUOUT,X,Y
 S DIC="^DIC(4.2,",DIC(0)="M",(LEX,X)="FO-SLC.DOMAIN.EXT" D ^DIC Q:+Y>0 LEX
 S DIC="^DIC(4.2,",DIC(0)="M",(LEX,X)="FO-SLC.DOMAIN.EXT" D ^DIC Q:+Y>0 LEX
 S DIC="^DIC(4.2,",DIC(0)="M",(LEX,X)="ISC-SLC.DOMAIN.EXT" D ^DIC Q:+Y>0 LEX
 Q "ISC-SLC.DOMAIN.EXT"
FN(X) ;   Filename
 Q:$D(^LEX(+($G(X)),0)) $$TITLE^XLFSTR($P($G(^LEX(+($G(X)),0)),"^",1))
 Q:$D(^LEXT(+($G(X)),0)) $$TITLE^XLFSTR($P($G(^LEXT(+($G(X)),0)),"^",1))
 Q ""
PRG ;   Purge ^TMP("LEXRX"
 N LEX S LEX="" F  S LEX=$O(^TMP("LEXRX",$J,LEX)) Q:'$L(LEX)  K:LEX'="MSG" ^TMP("LEXRX",$J,LEX)
 Q
ST ;   Show ^TMP
 N LEXNN,LEXNC S LEXNN="^TMP(""LEXRX"","_$J_")",LEXNC="^TMP(""LEXRX"","_$J_","
 W !! F  S LEXNN=$Q(@LEXNN) Q:'$L(LEXNN)!(LEXNN'[LEXNC)  W !,LEXNN,"=",@LEXNN
 W !!
 Q
CLR ;   Clear
 K LEXAMSO,LEXFMT,LEXQ,LEXSUBJ,LEXTITL,LEXINS,ZTQUEUED,LEXNAM
 Q
