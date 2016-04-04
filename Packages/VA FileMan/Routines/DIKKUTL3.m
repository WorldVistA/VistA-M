DIKKUTL3 ;SFISC/MKO-VERIFY KEY INTEGRITY ;3:10 PM  27 Oct 1998
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
VERIFY(DIKKEY,DIKKTOP,DIKKFILE) ;Verify key integrity
 N DIKKTEMP,POP,%ZIS
 ;
 ;Ask whether to save records in a template
 S DIKKTEMP=$$ASKTEMP(DIKKTOP)
 ;
 ;Select Device
 S %ZIS=$S($D(^%ZTSK):"Q",1:"")
 W ! D ^%ZIS Q:$G(POP)
 K %ZIS,POP
 ;
 ;Queue report
 I $D(IO("Q")) D  Q
 . N I,ZTSK
 . S ZTRTN="MAIN^DIKKUTL3"
 . S ZTDESC="KEY INTEGRITY CHECK"
 . F I="DIKKEY","DIKKTOP","DIKKFILE","DIKKTEMP" S ZTSAVE(I)=""
 . D ^%ZTLOAD
 . I $D(ZTSK)#2 W !,"Report queued!",!,"Task number: "_$G(ZTSK),!
 . E  W !,"Report canceled!",!
 . S IOP="HOME" D ^%ZIS
 ;
 U IO
 ;
MAIN ;Queued tasks enter here
 N DIKKHLIN,DIKKFIL,DIKKNAME,DIKKPAGE,DIKKTAB,DIKKUI,DIKKUIFL,DIKKUINM
 N DIKKIENS,DIKKFLD,DIKKFNAM,DIKKROOT,DIKKSUPP
 K ^TMP("DIKKUTL",$J)
 ;
 ;Check key integrity
 D INTEG^DIKK(DIKKTOP,"","",DIKKEY,"",1)
 I $D(DIERR) D MSG^DIALOG() Q
 ;
 ;Initialize "global" variables for report
 S DIKKPAGE=0
 S %H=$H D YX^%DTC
 S DIKKHLIN=$P(Y,"@")_"  "_$P($P(Y,"@",2),":",1,2)_"    PAGE "
 S DIKKTAB(1)=9,DIKKTAB(2)=41
 S DIKKNAME=$P($G(^DD("KEY",DIKKEY,0)),U,2)
 S DIKKUI=$P($G(^DD("KEY",DIKKEY,0)),U,4)
 S DIKKUINM=$P($G(^DD("IX",+DIKKUI,0)),U,2),DIKKUIFL=$P($G(^(0)),U)
 ;
 ;Print first header
 W:$E(IOST,1,2)="C-" @IOF
 D HDR
 I '$D(^TMP("DIKKTAR",$J)) W !!," ** NO PROBLEMS **" G END
 ;
 ;Loop through target error and list problems
 S DIKKFIL=0
 F  S DIKKFIL=$O(^TMP("DIKKTAR",$J,DIKKFIL)) Q:'DIKKFIL!$D(DIRUT)  D
 . D COLHDR
 . S DIKKROOT=$$FROOTDA^DIKCU(DIKKFIL)
 . S DIKKIENS=" "
 . F  S DIKKIENS=$O(^TMP("DIKKTAR",$J,DIKKFIL,DIKKIENS)) Q:DIKKIENS=""!$D(DIRUT)  D
 .. D:$D(^TMP("DIKKTAR",$J,DIKKFIL,DIKKIENS,"K",DIKKEY)) KEYERR(DIKKFIL,DIKKIENS,DIKKEY,DIKKROOT)
 .. S (DIKKSUPP,DIKKFLD)=0
 .. F  S DIKKFLD=$O(^TMP("DIKKTAR",$J,DIKKFIL,DIKKIENS,DIKKFLD)) Q:'DIKKFLD!$D(DIRUT)  D FLDERR(DIKKFIL,DIKKIENS,DIKKFLD,DIKKROOT,.DIKKSUPP)
 .. Q:$D(DIRUT)
 .. D W()
 ;
END D:'$D(DIRUT) EOPREAD
 ;
 ;Save in template, cleanup, and quit
 D:$G(DIKKTEMP) SAVETEMP(DIKKTEMP)
 K ^TMP("DIKKTAR",$J)
 I $D(ZTQUEUED) S ZTREQ="@"
 E  X $G(^%ZIS("C"))
 Q
 ;
KEYERR(RFIL,IENS,KEY,ROOT) ;
 D WRREC(RFIL,IENS,DIKKTAB(1),.ROOT) Q:$D(DIRUT)
 W ?DIKKTAB(2),"Duplicate Key "_$P($G(^DD("KEY",KEY,0)),U,2)_" (#"_KEY_")"
 Q
 ;
FLDERR(FIL,IENS,FLD,ROOT,SUPP) ;
 I '$G(SUPP) D  Q:$D(DIRUT)
 . D WRREC(FIL,IENS,DIKKTAB(1),.ROOT) Q:$D(DIRUT)
 . W ?DIKKTAB(2),"Missing Key Field(s):"
 D W($P($G(^DD(FIL,FLD,0)),U)_" ["_FIL_","_FLD_"]",DIKKTAB(2)+1)
 S SUPP=1
 Q
 ;
WRREC(FILE,IENS,TAB,ROOT) ;Write the record info
 N DA,DIERR,ENAM,MSG
 S:$G(ROOT)="" ROOT=$$FROOTDA^DIKCU(FILE)
 D DA(IENS,.DA) Q:$D(DIRUT)
 S ENAM=$P($G(@ROOT@(DA,0)),U)
 S:ENAM]"" ENAM=$$EXTERNAL^DILFD(FILE,.01,"",ENAM,"MSG")
 W ?TAB,$S(ENAM]"":ENAM,1:"Unknown record name")
 Q
 ;
W(STR,TAB,KWN) ;Write STR
 I $Y+3+$G(KWN)'<IOSL D  Q:$D(DIRUT)
 . D EOP Q:$D(DIRUT)
 . D HDR,COLHDR
 W !?+$G(TAB),$G(STR)
 Q
 ;
EOP ;Check whether task should be stopped
 I $D(ZTQUEUED),$$S^%ZTLOAD S (ZTSTOP,DIRUT)=1 Q
 D EOPREAD Q:$D(DIRUT)
 W @IOF
 Q
 ;
EOPREAD ;
 Q:$E(IOST,1,2)'="C-"!$D(ZTQUEUED)
 N DIR,DIROUT,DTOUT,DUOUT,X,Y
 S DIR(0)="E" W ! D ^DIR
 Q
 ;
HDR ;Write page header
 S DIKKPAGE=$G(DIKKPAGE)+1
 S $X=0 W "KEY INTEGRITY CHECK"
 W ?(IOM-$L(DIKKHLIN)-$L(DIKKPAGE)-1),DIKKHLIN_DIKKPAGE
 W !,$TR($J("",IOM-1)," ","-")
 W !,"             Key: "_DIKKNAME_" (#"_DIKKEY_"), File #"_DIKKFILE
 W !,"Uniqueness Index: "_DIKKUINM_" (#"_DIKKUI_")"
 W:DIKKFILE'=DIKKUIFL ", Whole File #"_DIKKUIFL
 Q
 ;
COLHDR ;Write column headers
 N FNAM
 S FNAM=$P($G(^DD(DIKKFIL,.01,0)),U)
 D W() Q:$D(DIRUT)
 D W("ENTRY #","",2) Q:$D(DIRUT)  W ?DIKKTAB(1),FNAM,?DIKKTAB(2),"ERROR"
 W !,"-------",?DIKKTAB(1),$TR($J("",$L(FNAM))," ","-"),?DIKKTAB(2),"-----"
 Q
 ;
ASKTEMP(DIKKTOP) ;Ask for a template name
 N DDA,DIC,DICKL,DIR,DIROUT,DIRUT,DIU0,DK,DQ,DTOUT,DUOUT
 N C,D,D1,D1,D2,D3,D4,I,J,L,O,X,Y
 ;
 S DK=DIKKTOP
 D S2^DIBT1 Q:Y<0!$D(DIRUT) ""
 Q +Y
 ;
SAVETEMP(Y) ;Save records in template Y
 N CNT,DK,FILE,FLD,IENS,REC
 S (CNT,FILE)=0 F  S FILE=$O(^TMP("DIKKTAR",$J,FILE)) Q:'FILE  D
 . S IENS="" F  S IENS=$O(^TMP("DIKKTAR",$J,FILE,IENS)) Q:IENS=""  D
 .. S REC=$P(IENS,",",$L(IENS,",")-1)
 .. S:$D(^DIBT(+Y,1,REC))[0 CNT=CNT+1,^DIBT(+Y,1,REC)=""
 S:CNT>0 ^DIBT(+Y,"QR")=DT_U_CNT
 Q
 ;
DA(IENS,DA) ;Given IENS, write ien's and setup DA array
 N I
 D W("","",$L(IENS,",")-2) Q:$D(DIRUT)
 K DA
 F I=$L(IENS,",")-1:-1:2 S DA(I-1)=$P(IENS,",",I) W DA(I-1),!
 S DA=$P(IENS,",") W DA
 Q
 ;
