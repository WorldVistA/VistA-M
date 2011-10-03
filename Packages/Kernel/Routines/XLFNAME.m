XLFNAME ;CIOFO-SF/TKW,MKO-Utilities for person name fields ;10:12 AM  29 Jan 2003
 ;;8.0;KERNEL;**134,211,240**;Jul 10, 1995
 ;
STDNAME(XUNAME,XUFLAG,XUAUD) ;Standardize name XUNAME
 ; XUNAME - In, name to be standardized. Out, standardized name
 ; XUFLAG - In, "C" : return components in XUNAME array
 ;              "F" : Assume input is in general form
 ;                     Family,Given Middle Suffix
 ;              "G" : Don't return XUAUD("GIVEN")
 ;              "P" : Remove parenthetical text
 ;.XUAUD  - Out:
 ;           XUAUD = original name passed in
 ;           XUAUD(subsc)="" if problems
 ;
 N I,XUFAM,XUNM,XUOUT,XUMOV,XUREST,XUSP
 S XUOUT=$G(XUFLAG)["C"
 N:XUOUT XUFAMO,XURESTO
 K XUAUD S XUAUD=XUNAME
 ;
 F I="FAMILY","GIVEN","MIDDLE","SUFFIX" S XUNM(I)="" S:XUOUT XUOUT(I)=""
 S:XUNAME?.E1" TEST" XUNAME=$E(XUNAME,1,$L(XUNAME)-5)
 ;
 I $G(XUFLAG)["P",XUNAME?.E1(1"(",1"[",1"{").E D
 . S XUNAME=$$PARENS^XLFNAME1(XUNAME)
 . S:XUAUD'=XUNAME XUAUD("STRIP")=""
 ;
 S:XUNAME?1"EEE".E!(XUNAME?.E1" FEE")!(XUNAME?1A1"-".E) XUAUD("NOTE")=""
 ;
 ;If no comma, assume given name first
 I XUNAME'[",",$G(XUFLAG)'["F" G GIVFRST
 ;
 ;Standardize Family
 ;(don't remove internal spaces or convert suffixes yet)
 I $E(XUNAME,1,3)="ST." S XUAUD("FAMILY")=""
 S XUFAM=$$CLEANC^XLFNAME1($P(XUNAME,","),"FI",.XUAUD)
 S XUFAM=$$PUNC(XUFAM,.XUAUD)
 D:XUOUT
 . S XUFAMO=$$CLEANC^XLFNAME1($P(XUNAME,","),"FO",.XUAUD)
 . S XUFAMO=$$PUNC(XUFAMO,.XUAUD)
 ;
 ;Look for suffixes at end of Family
 D SUFEND^XLFNAME1(.XUFAM,.XUFAMO,.XUNM,.XUOUT,.XUAUD)
 S:XUNM("SUFFIX")]"" XUAUD("SUFFIX")=""
 S XUNM("FAMILY")=XUFAM S:XUOUT XUOUT("FAMILY")=XUFAMO
 ;
 ;Parse rest of name
 S XUREST=$P(XUNAME,",",2,999)
 S XUSP=XUREST?1" "1.E
 D:XUOUT
 . S XURESTO=$$CLEANC^XLFNAME1(XUREST,"O",.XUAUD)
 . S XURESTO=$$PUNC(XUREST,.XUAUD)
 S XUREST=$$CLEANC^XLFNAME1(XUREST,"I",.XUAUD)
 S XUREST=$$PUNC(XUREST,.XUAUD)
 D MOVSUF(.XUREST,.XUOUT,.XURESTO,.XUAUD,.XUMOV)
 D N2(XUREST,.XUNM,.XUOUT,$G(XURESTO),.XUAUD)
 ;
 ;Account for names that look like only Family and Suffix(es)
 I XUNM("MIDDLE")="",$$CHKSUF^XLFNAME1(XUNM("GIVEN"))]"" D
 . N XUCNT,XUSUF1,XUSUF2
 . I 'XUSP Q:$E(XUNM("GIVEN"))'?1N
 . S XUCNT=$L(XUNM("SUFFIX")," ")
 . S XUSUF1=$P(XUNM("SUFFIX")," ",XUCNT-XUMOV+1,XUCNT)
 . S XUSUF2=$P(XUNM("SUFFIX")," ",1,XUCNT-XUMOV)
 . S XUNM("SUFFIX")=$$JOIN($$JOIN(XUSUF1,$$ROMAN^XLFNAME1(XUNM("GIVEN"))),XUSUF2)
 . S XUNM("GIVEN")=""
 . D:XUOUT
 .. S XUSUF1=$P(XUOUT("SUFFIX")," ",XUCNT-XUMOV+1,XUCNT)
 .. S XUSUF2=$P(XUOUT("SUFFIX")," ",1,XUCNT-XUMOV)
 .. S XUOUT("SUFFIX")=$$JOIN($$JOIN(XUSUF1,XUOUT("GIVEN")),XUSUF2)
 .. S XUOUT("GIVEN")=""
 ;
 D BLDSTD(.XUNAME,.XUNM,.XUOUT,.XUAUD)
 K:$G(XUFLAG)["G" XUAUD("GIVEN")
 Q
 ;
BLDSTD(XUNAME,XUNM,XUOUT,XUAUD) ;Build standard name in XUNAME
 ;Put components in XUNAME array
 N I,J
 K XUNAME M:XUOUT XUNAME=XUOUT
 ;
 S XUNAME=XUNM("FAMILY")_","
 S:XUNAME[" " XUNAME=$TR(XUNAME," "),XUAUD("SPACE")=""
 ;
 I XUNM("GIVEN")]"" S XUNAME=XUNAME_XUNM("GIVEN")
 E  S XUAUD("GIVEN")=""
 S:XUNM("MIDDLE")]"" XUNAME=XUNAME_" "_XUNM("MIDDLE")
 S:XUNM("SUFFIX")]"" XUNAME=XUNAME_" "_XUNM("SUFFIX")
 S:XUNAME?.E1"," XUNAME=$E(XUNAME,1,$L(XUNAME)-1)
 S:XUNAME?.E1N.E XUAUD("NUMBER")=""
 ;
 ;Remove spaces after periods, and ~ and ^, in name components
 I XUOUT S I="" F  S I=$O(XUNAME(I)) Q:I=""  D
 . S XUNAME(I)=$TR(XUNAME(I),"`^") Q:XUNAME(I)'[". "
 . N J S J=0 F  S J=$F(XUNAME(I),". ",J) Q:'J  S $E(XUNAME(I),J-1)=""
 Q
 ;
GIVFRST ;Come here if name has no comma.
 N XUCNT,XUNAM,XUNAMO
 ;
 ;Do initial standardizing
 S XUNAM=$$CLEANC^XLFNAME1(XUNAME,"I",.XUAUD)
 S XUNAM=$$PUNC(XUNAME,.XUAUD)
 D:XUOUT
 . S XUNAMO=$$CLEANC^XLFNAME1(XUNAME,"O",.XUAUD)
 . S XUNAMO=$$PUNC(XUNAMO,.XUAUD)
 ;
 ;Look for suffixes at end
 D SUFEND^XLFNAME1(.XUNAM,.XUNAMO,.XUNM,.XUOUT,.XUAUD)
 S XUCNT=$L(XUNAM," ")
 ;
 ;If name contains only suffixes, make first suffix the Family Name
 I XUCNT=0 D  Q
 . S XUNM("FAMILY")=$P(XUNM("SUFFIX")," ")
 . S XUNM("SUFFIX")=$P(XUNM("SUFFIX")," ",2,999)
 . S:$G(XUFLAG)'["G" XUAUD("GIVEN")=""
 . D:XUOUT
 .. S XUOUT("FAMILY")=$P(XUOUT("SUFFIX")," ")
 .. S XUOUT("SUFFIX")=$P(XUOUT("SUFFIX")," ",2,999)
 . D BLDSTD(.XUNAME,.XUNM,.XUOUT,.XUAUD)
 ;
 ;Set Family and rest of name
 S XUNM("FAMILY")=$P(XUNAM," ",XUCNT),XUREST=$P(XUNAM," ",1,XUCNT-1)
 S:XUOUT XUOUT("FAMILY")=$P(XUNAMO," ",XUCNT),XURESTO=$P(XUNAMO," ",1,XUCNT-1)
 ;
 ;Process rest of name (don't look for suffixes)
 D N2(XUREST,.XUNM,.XUOUT,$G(XURESTO),.XUAUD,"s")
 D BLDSTD(.XUNAME,.XUNM,.XUOUT,.XUAUD)
 K:$G(XUFLAG)["G" XUAUD("GIVEN")
 Q
 ;
NAMECOMP(XUNM) ;Build components from standard name
 S XUNM("FAMILY")=$P(XUNM,",")
 D N2($P(XUNM,",",2,999),.XUNM)
 S XUNM("MIDDLE")=$G(XUNM("MIDDLE"))
 S XUNM("SUFFIX")=$G(XUNM("SUFFIX"))
 Q
 ;
MOVSUF(XUREST,XUOUT,XURESTO,XUAUD,XUMOV) ;Move suffixes immediately in front to the end
 N XUI,XUCNT
 S XUCNT=$L(XUREST," "),XUMOV=0
 F XUI=1:1:XUCNT I $$CHKSUF1^XLFNAME1($P(XUREST," ",XUI))="" S XUI=XUI-1 Q
 I XUI,XUI<XUCNT D
 . S XUMOV=XUI
 . S XUREST=$P(XUREST," ",XUI+1,999)_" "_$P(XUREST," ",1,XUI)
 . S:XUOUT XURESTO=$P(XURESTO," ",XUI+1,999)_" "_$P(XURESTO," ",1,XUI)
 . S XUAUD("SUFFIX")=""
 Q
 ;
PUNC(XUNAME,XUAUD) ;Remove name pieces that are purely punctuation
 N XUC,XUI,XUNEW
 S XUNEW=""
 F XUI=1:1:$L(XUNAME," ") D
 . S XUC=$P(XUNAME," ",XUI)
 . I XUC?1.P S:XUC'?1."." XUAUD("PUNC")="" Q
 . S XUNEW=$$JOIN(XUNEW,XUC)
 Q XUNEW
 ;
N2(XUREST,XUNM,XUOUT,XURESTO,XUAUD,XUFLAG) ;Build components from non-family name
 N XUCNT,XUGIVEN,XUI,XUMIDDLE,XUSUF,XUSUFFIX,XUX,X
 S XUOUT=$G(XUOUT) N:XUOUT XUGIVENO,XUMIDO,XUSUFO,XUXO
 S XUCNT=$L(XUREST," ")
 ;
 ;Get Given from 1st space-piece, quit if only name
 S XUNM("GIVEN")=$P(XUREST," ") S:XUOUT XUOUT("GIVEN")=$P(XURESTO," ")
 Q:XUCNT<2
 ;
 S (XUSUF,XUMIDDLE,XUGIVEN)="" S:XUOUT (XUSUFO,XUMIDO,XUGIVENO)=""
 ;
 F XUI=XUCNT:-1:2 D
 . S XUX=$P(XUREST," ",XUI)
 . S:XUOUT XUXO=$P(XURESTO," ",XUI)
 . ;
 . ;If no middle yet, check for suffix
 . I XUMIDDLE="",$G(XUFLAG)'["s" D  Q:XUSUFFIX]""
 .. S XUSUFFIX=""
 .. I XUI=2,"I^V^X"[XUX S XUAUD("SUFFIX")="" Q
 .. I XUI>2,XUX="D",$P(XUREST," ",XUI-1)="M" S XUAUD("SUFFIX")="" Q
 .. S XUSUFFIX=$$CHKSUF^XLFNAME1(XUX) Q:XUSUFFIX=""
 .. S X=XUSUFFIX,XUSUFFIX=$$ROMAN^XLFNAME1(XUSUFFIX)
 .. I XUI=2,X=XUSUFFIX S XUAUD("SUFFIX")=""
 .. S XUSUF=$$JOIN(XUSUFFIX,XUSUF)
 .. S:XUOUT XUSUFO=$$JOIN(XUXO,XUSUFO)
 . ;
 . ;If not suffix, and no middle, set middle
 . I XUMIDDLE="" S XUMIDDLE=XUX S:XUOUT XUMIDO=XUXO Q
 . ;
 . ;Otherwise, put in Given
 . S:XUI=2 XUAUD("MIDDLE")=""
 . S XUGIVEN=$$JOIN(XUX,XUGIVEN)
 . S:XUOUT XUGIVENO=$$JOIN(XUXO,XUGIVENO)
 ;
 D:XUSUF]""
 . S XUNM("SUFFIX")=$$JOIN($G(XUNM("SUFFIX")),XUSUF)
 . S:XUOUT XUOUT("SUFFIX")=$$JOIN($G(XUOUT("SUFFIX")),XUSUFO)
 ;
 S XUNM("MIDDLE")=XUMIDDLE
 S:XUOUT XUOUT("MIDDLE")=XUMIDO
 D:"^NMI^NMN^"[(U_XUNM("MIDDLE")_U)
 . S XUNM("MIDDLE")="" S:XUOUT XUOUT("MIDDLE")=""
 . S XUAUD("NM")=""
 ;
 D:XUGIVEN]""
 . S XUNM("GIVEN")=XUNM("GIVEN")_" "_XUGIVEN
 . S:XUOUT XUOUT("GIVEN")=XUOUT("GIVEN")_" "_XUGIVENO
 Q
 ;
JOIN(S1,S2) ;Return S1 joined with S2 (separate by a space)
 Q $G(S1)_$E(" ",$G(S1)]""&($G(S2)]""))_$G(S2)
 ;
NAMEFMT(XUNAME,XUFMT,XUFLAG,XUDLM) ;Name formatting routine
 G NAMEFMTX^XLFNAME1
 ;
CLEANC(XUPART,XUFLAG,XUAUD) ;Component standardization
 G CLEANCX^XLFNAME1
 ;
BLDNAME(XUNC,XUMAX) ;Build standard name from components
 Q $$NAMEFMT(.XUNC,"F","CSL"_+$G(XUMAX))
 ;
HLNAME(XUNAME,XUFLAG,XUDLM) ;Convert name to HL7 format
 N XUF
 S XUF=$E("S",$G(XUFLAG)["S")
 S:$G(XUFLAG)["L" XUF=XUF_"L"_+$P(XUFLAG,"L",2)
 Q $$NAMEFMT^XLFNAME(.XUNAME,"H",XUF,$G(XUDLM))
 ;
FMNAME(XUNAME,XUFLAG,XUDLM) ;Convert HL7 name string to standard name or name components
 G F^XLFNAME6
 ;
PRE ;Pre-install for patch XU*8.0*134
 G PRE^XLFNAME3
 ;
POST ;Post-install for XU*8.0*134 (conversion)
 G POST^XLFNAME3
 ;
GENERATE ;Generate information in ^XTMP about changes that will take
 ;place when CONVERT^XLFNAME is run
 G GENERATE^XLFNAME5
 ;
PRINT ;Print the information in ^XTMP
 G PRINT^XLFNAME4
 ;
CONVERT ;Convert the Names in the New Person file
 G CONVERT^XLFNAME5
