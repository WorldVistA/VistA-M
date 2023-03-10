XPDID ;SFISC/VYD,RSD - Display Install Progress ; Mar 28, 2022@12:48
 ;;8.0;KERNEL;**81,768**;Jul 10, 1995;Build 8
 ;Per VHA Directive 2004-038, this routine should not be modified.
 Q
INIT ;initialize progress screen
 N X,XPDSTR
 S XPDIDVT=0 ;turn off graphic
 ;If not C-VT, quit
 Q:IO'=IO(0)!(IOST'["C-VT")
 S X="IOSTBM",XPDSTR="             25             50             75     "
 D ENDR^%ZISS
 ;If bottom margin is null, quit
 Q:$G(IOSTBM)=""  ;p768
 ;if graphic routine is missing, quit
 Q:$T(PREP^XGF)=""
 ;S X="XGF" X ^%ZOSF("TEST") E  S XPDIDVT=0 Q
 D PREP^XGF
 ;everything looks good, turn on graphic
 S IOTM=3,IOBM=IOSL-4,XPDIDVT=1
 W @IOSTBM
 D FRAME^XGF(IOTM-2,0,IOTM-2,IOM-1)
 D FRAME^XGF(IOBM,0,IOBM,IOM-1)
 D FRAME^XGF(IOBM+1,10,IOBM+3,71)
 D SAY^XGF(IOBM+2,11,XPDSTR)
 D SAY^XGF(IOBM+2,0,$J("0",5)_"%")
 D SAY^XGF(IOBM+3,0,"Complete")
 D IOXY^XGF(IOTM-2,0)
 Q
 ;
EXIT(XPDM) ;exit progress screen restore screen to normal
 I $G(XPDIDVT) D
 .S IOTM=1,IOBM=IOSL
 .W:IOSTBM]"" @IOSTBM W:IOF]"" @IOF ;p768
 .W:$G(XPDM)]"" !!,XPDM,!!
 .D CLEAN^XGF
 K IOTM,IOBM,IOSTBM,XPDIDCNT,XPDIDMOD,XPDIDTOT,XPDIDVT
 Q
 ;
TITLE(X) ;display title X
 Q:'XPDIDVT
 N XPDOX,XPDOY
 S XPDOX=$X,XPDOY=$Y
 D SAY^XGF(0,0,$$CJ^XLFSTR(X,IOM_"T")),CURSOR
 Q
 ;
SETTOT(X) ;X=file # from build
 Q:'$D(XPDIDVT)
 S XPDIDTOT=$S(X=4:+$P($G(^XTMP("XPDI",XPDA,"BLD",XPDBLD,4,0)),U,4),X=9.8:+$G(^XTMP("XPDI",XPDA,"RTN")),1:+$P($G(^XTMP("XPDI",XPDA,"BLD",XPDBLD,"KRN",X,"NM",0)),U,4))
 S XPDIDMOD=$S(XPDIDTOT<60:1,1:XPDIDTOT\60),XPDIDCNT=0
 Q:'XPDIDVT
 D UPDATE(0)
 Q
 ;
UPDATE(XPDN) ;update the progress bar
 I 'XPDIDVT W "." Q
 N XPDLEN,XPDMC,XPDOX,XPDOY,XPDS,XPDSTR
 S XPDOX=$X,XPDOY=$Y,XPDMC=60,XPDSTR="             25             50             75               "
 S XPDLEN=$S(XPDIDTOT:XPDN/XPDIDTOT*XPDMC\1,1:0),XPDS=$E(XPDSTR,1,XPDLEN)
 D SAY^XGF(IOBM+2,11,XPDS,"R1")
 S XPDS=$E(XPDSTR,XPDLEN+1,XPDMC)
 D SAY^XGF(IOBM+2,11+XPDLEN,XPDS)
 D SAY^XGF(IOBM+2,0,$J(XPDLEN/XPDMC*100,5,0)),CURSOR
 Q
 ;
CURSOR ;put cursor back
 S:XPDOY>(IOBM-1) XPDOY=IOBM-1
 D IOXY^XGF(XPDOY,XPDOX)
 Q
