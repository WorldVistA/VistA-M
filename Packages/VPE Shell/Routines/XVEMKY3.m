XVEMKY3 ;DJB/KRN**Screen Variables ;2017-08-16  12:12 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ; GT.M support and Mumps V1 support by Sam Habiel (c) 2016-2017
 ;
BLANK ;
 D BLANK1,BLANK2,BLANK3,BLANK4
 Q
BLANK1 ;Blank - cursor to end-of-screen
 Q:$D(XVVS("BLANK_C_EOS"))
 I $G(IOST(0))]"",$D(^%ZIS(2,IOST(0),5)),$P(^(5),"^",7)]"" S XVVS("BLANK_C_EOS")=$P(^(5),"^",7) Q
 S XVVS("BLANK_C_EOS")="$C(27)_""[J"""
 Q
BLANK2 ;Blank - top-of-screen to cursor
 Q:$D(XVVS("BLANK_TOS_C"))
 I $G(IOST(0))]"",$D(^%ZIS(2,IOST(0),13)),$P(^(13),"^",1)]"" S XVVS("BLANK_TOS_C")=$P(^(13),"^",1) Q
 S XVVS("BLANK_TOS_C")="$C(27)_""[1J"""
 Q
BLANK3 ;Blank - cursor to end-of-line
 Q:$D(XVVS("BLANK_C_EOL"))
 I $G(IOST(0))]"",$D(^%ZIS(2,IOST(0),5)),$P(^(5),"^",6)]"" S XVVS("BLANK_C_EOL")=$P(^(5),"^",6) Q
 S XVVS("BLANK_C_EOL")="$C(27)_""[K"""
 Q
BLANK4 ;Blank - start-of-line to cursor
 Q:$D(XVVS("BLANK_SOL_C"))
 I $G(IOST(0))]"",$D(^%ZIS(2,IOST(0),13)),$P(^(13),"^",3)]"" S XVVS("BLANK_SOL_C")=$P(^(13),"^",3) Q
 S XVVS("BLANK_SOL_C")="$C(27)_""[1K"""
 Q
 ;====================================================================
ZSAVE ;Set up XVVS("ZS") to zsave a routine.
 ;
 I $D(^DD("OS",XVV("OS"),"ZS")) S XVVS("ZS")=^("ZS") Q:XVVS("ZS")]""
 I $D(^DD("OS")),'$D(^DD("OS",XVV("OS"),"ZS")) S FLAGQ=1 D  Q
 . W $C(7),!!?5,"Your Mumps system has no way to ZSAVE a routine. I'm aborting.",!!
 ;
 ;DSM,MSM,DSM for Open VMS
 I ",2,8,16,"[(","_XVV("OS")_",") D  Q
 . S XVVS("ZS")="NEW %Y ZR  S %Y=0 X ""F  S %Y=$O(^UTILITY($J,0,%Y)) Q:%Y'>0  ZI ^(%Y)"" ZS @X"
 ;
 ;DTM
 I XVV("OS")=9 D  Q
 . S XVVS("ZS")="NEW %X,%Y S %X="""",%Y=0 X ""F  S %Y=$O(^UTILITY($J,0,%Y)) Q:%Y'>0  S %X=%X_$C(10)_^(%Y)"" ZS @X:$E(%X,2,999999)"
 ;
 ;CACHE
 I XVV("OS")=18 D  Q
 . S XVVS("ZS")="NEW %Y ZR  S %Y=0 X ""F  S %Y=$O(^UTILITY($J,0,%Y)) Q:%Y'>0  Q:'$D(^(%Y))  ZI ^(%Y)"" ZS @X"
 ;
 ;-> GTM
 I XVV("OS")=17 D  Q
 . S XVVS("ZS")="N %I,%F,%S S %I=$I,%F=$P($ZRO,"","")_X_"".m"" O %F:(NEWVERSION) U %F X ""S %S=0 F  S %S=$O(^UTILITY($J,0,%S)) Q:%S=""""""""  Q:'$D(^(%S))  S %=^UTILITY($J,0,%S) I $E(%)'="""";"""" W %,!"" C %F U %I"
 ;
 I XVV("OS")=19 D  Q
 . S XVVS("ZS")="D SAVEGUX^XVEMKY3(X)" ;
 ;
 ; -> MV1
 I XVV("OS")=20 D  Q
 . S XVVS("ZS")="M ^$ROUTINE(X)=^UTILITY($J,0) N % S %=$&%ROUCHK(X)"
 ;
 ;-> Abort if no XVVS("ZS")
 D ZSAVEMSG S FLAGQ=1
 Q
ZSAVEMSG ;Can't ZSAVE a routine
 W $C(7),!!?5,"You don't have VA Fileman in this UCI, and I don't know how to"
 W !?5,"ZSAVE a routine on your Mumps system. I'm aborting."
 W !!?5,"Review subroutine ZSAVE^XVEMKY3. You may edit this routine and"
 W !?5,"add code to cover your M system. If you are running VA Fileman,"
 W !?5,"see ^DD(""OS"",system#,""ZS"") for your M system.",!!
 Q
 ;
 ; -- EPs for GT.M/Unix for saving routines -- 
SAVEGUX(RN) ;Save a routine
 N %,%F,%I,%N,SP
 S %I=$I,SP=" ",%F=$$RTNDIR()_$TR(RN,"%","_")_".m"
 O %F:(NEWVERSION:NOREADONLY:NOWRAP:STREAM) U %F
 N %S F %S=0:0 S %S=$O(^UTILITY($J,0,%S))  Q:'%S  D 
 . S %=^UTILITY($J,0,%S)
 . Q:$E(%,1)="$" 
 . W %,!
 C %F
 U %I
 Q
 ;
RTNDIR() ; primary routine source directory
 N DIRS
 D PARSEZRO(.DIRS,$ZRO)
 N I F I=1:1 Q:'$D(DIRS(I))  I DIRS(I)[".so" K DIRS(I)
 I '$D(DIRS) S $EC=",U255,"
 QUIT $$ZRO1ST(.DIRS)
 ;
PARSEZRO(DIRS,ZRO) ; Parse $zroutines properly into an array
 ; Eat spaces
 F  Q:($E(ZRO)'=" ")  S ZRO=$E(ZRO,2,999)
 ;
 N PIECE
 N I
 F I=1:1:$L(ZRO," ") S PIECE(I)=$P(ZRO," ",I)
 N CNT S CNT=1
 F I=0:0 S I=$O(PIECE(I)) Q:'I  D
 . S DIRS(CNT)=$G(DIRS(CNT))_PIECE(I)
 . I DIRS(CNT)["("&(DIRS(CNT)[")") S CNT=CNT+1 QUIT
 . I DIRS(CNT)'["("&(DIRS(CNT)'[")") S CNT=CNT+1 QUIT
 . S DIRS(CNT)=DIRS(CNT)_" " ; prep for next piece
 QUIT
 ;
ZRO1ST(DIRS) ; $$ Get first usable routine directory
 N OUT S OUT="" ; $$ Return; default empty
 N I F I=0:0 S I=$O(DIRS(I)) Q:'I  D  Q:OUT]""  ; 1st directory
 . N %1 S %1=DIRS(I)
 . N SO S SO=$E(%1,$L(%1)-2,$L(%1))
 . S SO=$$ALLCAPS^XVEMKU(SO)
 . I SO=".SO" QUIT
 . ;
 . ; Parse with (...)
 . I %1["(" DO
 . . S OUT=$P(%1,"(",2)
 . . I OUT[" " S OUT=$P(OUT," ")
 . . E  S OUT=$P(OUT,")")
 . ; no parens
 . E  S OUT=%1
 ;
 ; Add trailing slash
 I OUT]"",$E(OUT,$L(OUT))'="/" S OUT=OUT_"/"
 QUIT OUT
 ;
