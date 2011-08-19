XLFNAME1 ;CIOFO-SF/TKW,MKO-Utilities for person name fields ;9:25 AM  29 Jan 2003
 ;;8.0;KERNEL;**134,240**;Jul 10, 1995
 ;
REMDBL(X,S) ;For each char in S, remove double chars
 N I,J
 F I=1:1:$L(S) S C=$E(S,I) D
 . F  S J=$F(X,C_C) Q:'J  S $E(X,J-1)=""
 Q X
 ;
REMBE(X,S) ;Remove each char in S from the beg and end of X
 N I
 F I=1:1:$L(X) Q:S'[$E(X,I)
 S X=$E(X,I,999)
 F I=$L(X):-1:1 Q:S'[$E(X,I)
 S X=$E(X,1,I)
 Q X
 ;
ROMAN(X) ; Replace numeric suffixes to Roman Numeral equivalents
 Q:X'?.E1.N.E X
 N IN,OUT
 ;
 S IN="^1ST^2ND^3RD^4TH^5TH^6TH^7TH^8TH^9TH^10TH^"
 S OUT="I^II^III^IV^V^VI^VII^VIII^IX^X"
 S:IN[(U_X_U) X=$P(OUT,U,$L($P(IN,U_X_U),U))
 Q X
 ;
CHKSUF(X) ;Return X if it looks like a suffix; otherwise, return null
 N V
 Q:"^I^II^III^IV^V^VI^VII^VIII^IX^X^JR^SR^DR^MD^ESQ^DDS^RN^"[(U_X_U) X
 Q:"^1ST^2ND^3RD^4TH^5TH^6TH^7TH^8TH^9TH^10TH^"[(U_X_U) X
 I $L(X)>1,X'[" ",X'="NMN" D  I V="" S XUAUD("SUFFIX")="" Q X
 . F V="A","E","I","O","U","Y","" Q:X[V
 Q ""
 ;
CHKSUF1(X) ; Return X if it looks like a suffix, but not I, V, X
 N V
 Q:"^II^III^IV^VI^VII^VIII^IX^JR^SR^DR^MD^ESQ^DDS^RN^"[(U_X_U) X
 Q:"^1ST^2ND^3RD^4TH^5TH^6TH^7TH^8TH^9TH^10TH^"[(U_X_U) X
 Q ""
 ;
PERIOD(X) ; Change X so that there is a space after every period
 Q:X'["." X
 N I
 S I=0 F  S I=$F(X,".",I) Q:'I!(I'<$L(X))  D
 . S:$E(X,I)'=" " X=$E(X,1,I-1)_" "_$E(X,I,999)
 Q X
 ;
PARENS(X) ;Strip parenthetical part(s) from X
 N C,DONE,LEV,P,P1,P2
 F  Q:X'?.E1(1"(",1"[",1"{").E  D  Q:'P2
 . S (DONE,LEV,P1,P2)=0
 . F P=1:1:$L(X) D  Q:DONE
 .. S C=$E(X,P)
 .. I C?1(1"(",1"[",1"{") S:'LEV P1=P S LEV=LEV+1
 .. E  I P1,C?1(1")",1"]",1"}") S P2=P,LEV=LEV-1 S:'LEV DONE=1
 . S:P2 X=$E(X,1,P1-1)_$E(X,P2+1,999)
 Q X
 ;
SUFEND(XUN,XUNO,XUNM,XUOUT,XUAUD) ;Look for suffixes at end of XUN
 ;Put in XUNM("SUFFIX")
 ;Remove those suffixes from XUN and XUNO
 N XUI,XUSUF,XUSUFO,XUSUFFIX,XUX
 S XUSUF="" S:XUOUT XUSUFO=""
 ;
 F XUI=$L(XUN," "):-1:2 D  Q:XUSUFFIX=""
 . S XUX=$P(XUN," ",XUI)
 . S XUSUFFIX=$$CHKSUF(XUX) Q:XUSUFFIX=""
 . S XUSUF=$$JOIN($$ROMAN(XUSUFFIX),XUSUF)
 . S XUN=$P(XUN," ",1,XUI-1)
 . D:XUOUT
 .. S XUSUFO=$P(XUNO," ",XUI)_$E(" ",XUSUFO]"")_XUSUFO
 .. S XUNO=$P(XUNO," ",1,XUI-1)
 ;
 I XUSUF]"" S XUNM("SUFFIX")=XUSUF S:XUOUT XUOUT("SUFFIX")=XUSUFO
 Q
 ;
CLEANC(XUPART,XUFLAG,XUAUD) ; Component standardization
CLEANCX ; Entry point from CLEANC^XLFNAME
 Q:$G(XUPART)="" ""
 N XUX,I
 S XUFLAG=$G(XUFLAG)
 ;
 S:XUPART?.E1.L.E XUPART=$$UP^XLFSTR(XUPART)
 ;
 S XUX=$S(XUFLAG["F":"-",1:" ")
 S I=XUPART,XUPART=$TR(XUPART,",:;",XUX_XUX_XUX)
 S:XUPART'=I XUAUD("PUNC")=""
 ;
 Q:XUFLAG["O" $$REMBE($$REMDBL($$PERIOD(XUPART),"- "),"- ")
 ;
 I XUPART["." S XUPART=$TR(XUPART,"."," "),XUAUD("PERIOD")=""
 ;
 I XUFLAG'["I" D
 . F I=1:1:$L(XUPART," ") S $P(XUPART," ",I)=$$ROMAN($P(XUPART," ",I))
 . S:XUPART?.E1N.E XUAUD("NUMBER")=""
 ;
 S I=XUPART,XUPART=$TR(XUPART,"!""#$%&'()*+,./:;<=>?@[\]^_`{|}~")
 S:XUPART'=I XUAUD("PUNC")=""
 ;
 ;Remove all spaces and double hyphens from Family Name
 I XUFLAG["F",XUFLAG'["I" D  Q $$REMBE($$REMDBL(XUPART,"-"),"-")
 . S:XUPART?." "1.ANP1." "1.ANP." " XUAUD("SPACE")=""
 . S XUPART=$TR(XUPART," ")
 ;
 Q $$REMBE($$REMDBL(XUPART,"- "),"- ")
 ;
NAMEFMT(XUNAME,XUFMT,XUFLAG,XUDLM) ; Name formatting routine (extrinsic)
NAMEFMTX ;
 ; XUNAME: Input name components array or Name Components Key fields
 ; XUFMT:  F=Family name first,G=Given name first,H=HL7 (default G)
 ; XUFLAG: P=Include prefix,D=Include degree,S=Standardize components,M=Mixed case
 ; XUDLM:  Delimiter if HL7 message (def = ^)
 N XUBLD,XUI,XULEN,XUN,XUSTEP
 ;
 ;Set defaults
 S XUFMT=$G(XUFMT) S:XUFMT="" XUFMT="G"
 S XUFLAG=$G(XUFLAG)
 S:$G(XUDLM)="" XUDLM=U
 S:XUFLAG["L" XULEN=+$P(XUFLAG,"L",2) S:$G(XULEN)<1 XULEN=256
 ;
 ;Get XUN (name array)
 ;If a name (no array) is passed in
 I $D(XUNAME)<10 D
 . S XUN=$G(XUNAME) Q:XUN=""
 . D STDNAME^XLFNAME(.XUN,"CP")
 ;
 ;Else, if a file, field, iens passed in
 E  I $G(XUNAME("FILE")),$G(XUNAME("FIELD")),$G(XUNAME("IENS"))]"" D
 . N IEN,IENS
 . S IENS=$G(XUNAME("IENS")) S:IENS'?.E1"," IENS=IENS_","
 . S IEN=$O(^VA(20,"BB",+XUNAME("FILE"),+$G(XUNAME("FIELD")),IENS,0))
 . I IEN D
 .. N I
 .. S I=0 F XUI="FAMILY","GIVEN","MIDDLE","PREFIX","SUFFIX","DEGREE" D
 ... S I=I+1,XUN(XUI)=$P($G(^VA(20,IEN,1)),U,I)
 . E  D
 .. N MSG,NAM,DIERR
 .. S NAM=$$GET1^DIQ(+XUNAME("FILE"),IENS,+$G(XUNAME("FIELD")),"I","MSG")
 .. I NAM]"" S XUN=NAM D STDNAME^XLFNAME(.XUN,"CP")
 ;
 ;Else, components passed in
 E  M XUN=XUNAME
 ;
 ;Standardize
 F XUI="FAMILY","GIVEN","MIDDLE","SUFFIX","PREFIX","DEGREE" D
 . S XUN(XUI)=$G(XUN(XUI))
 . I XUFLAG["S",XUN(XUI)]"" S XUN(XUI)=$$CLEANC(XUN(XUI),$E("F",XUI="FAMILY"))
 Q:$G(XUN("FAMILY"))="" ""
 ;
 ; Return in mixed case
 I XUFLAG["M" D
 . N XUCMP,X
 . F XUCMP="FAMILY","GIVEN","MIDDLE","PREFIX" I XUN(XUCMP)]"" S XUN(XUCMP)=$$MIX(XUN(XUCMP))
 . I XUN("DEGREE")]"" S XUN("DEGREE")=$$MIX2(XUN("DEGREE"))
 . I XUN("SUFFIX")]"" S XUN("SUFFIX")=$$MIX2(XUN("SUFFIX"))
 . Q
 ;
 ;Build formatted name, truncate if necessary
 S XUBLD=1 F XUSTEP=0:1 D  Q:$L(XUN)'>XULEN
 . ;Build formatted name
 . I XUBLD S XUBLD=0 D  Q:$L(XUN)'>XULEN
 .. I XUFMT["H" S XUN=$$H(.XUN,XUDLM) Q
 .. I XUFMT["O" S XUN=$$O(.XUN) Q
 .. I XUFMT["G" S XUN=$$G(.XUN,XUFLAG) Q
 .. S XUN=$$F(.XUN,XUFLAG) Q
 . ;
 . ;Truncation steps
 . Q:'XUSTEP
 . I XUSTEP=1 S:XUN("DEGREE")]"" XUN("DEGREE")="",XUBLD=1 Q
 . I XUSTEP=2 S:XUN("PREFIX")]"" XUN("PREFIX")="",XUBLD=1 Q
 . I XUSTEP=3 S:XUN("MIDDLE")]"" XUN("MIDDLE")=$$TRUNC(XUN("MIDDLE"),$L(XUN)-XULEN),XUBLD=1 Q
 . I XUSTEP=4 S:XUN("SUFFIX")]"" XUN("SUFFIX")="",XUBLD=1 Q
 . I XUSTEP=5 S:XUN("GIVEN")]"" XUN("GIVEN")=$$TRUNC(XUN("GIVEN"),$L(XUN)-XULEN),XUBLD=1 Q
 . I XUSTEP=6 S:XUN("FAMILY")]"" XUN("FAMILY")=$$TRUNC(XUN("FAMILY"),$L(XUN)-XULEN),XUBLD=1 Q
 . I XUSTEP=7 S XUN=$E(XUN,1,XULEN) F  Q:XUN'?.E1" "  S XUN=$E(XUN,1,$L(XUN)-1)
 Q XUN
 ;
MIX(X) ; Return name part with only first letter upper-case
 N %,L
 F %=2:1:$L(X) I $E(X,%)?1U,$E(X,%-1)?1A S L=$E(X,%),L=$C($A(L)+32),$E(X,%)=L
 Q X
 ;
MIX2(XUN) ; Properly capitalize suffixes, degrees
 N P,I,L,DIOUT
 F P="DR","PHD","JR","SR","ESQ" S I=$F(XUN,P) I I D
 . Q:$E(XUN,I)?1A
 . I P="PHD" Q:$E(XUN,I-4)?1A  S $E(XUN,I-3,I-1)="PhD" Q
 . S L=$L(P) Q:$E(XUN,I-(L+1))?1A
 . S X=$$MIX($E(XUN,I-L,I-1)),$E(XUN,I-L,I-1)=X
 . Q
 I XUN?.E1.N1.U.E S DIOUT=0 F P=1:1:10 S I=$F(XUN,P) I I D  Q:DIOUT
 . S L=$S(P=1:"ST",P=2:"ND",P=3:"RD",1:"TH")
 . I $E(XUN,I,I+1)'=L Q
 . S $E(XUN,I,I+1)=$S(P=1:"st",P=2:"nd",P=3:"rd",1:"th")
 . S DIOUT=1 Q
 Q XUN
 ;
O(N) ;O format
 Q N("FAMILY")
 ;
F(N,F) ;F format
 N NAM
 S NAM=N("FAMILY")_$S(F["C":",",1:" ")_N("GIVEN")_$E(" ",N("MIDDLE")]"")_N("MIDDLE")
 S NAM=$$SPD(NAM,.N,F)
 S:NAM?.E1(1",",1" ") NAM=$E(NAM,1,$L(NAM)-1)
 Q NAM
 ;
G(N,F) ;G format
 N NAM,I
 S NAM="" F I="GIVEN","MIDDLE","FAMILY" S NAM=$$JOIN(NAM,N(I))
 Q $$SPD(NAM,.N,F)
 ;
H(N,D) ;H format
 N NAM
 S NAM=N("FAMILY")_D_N("GIVEN")_D_N("MIDDLE")_D_N("SUFFIX")_D_N("PREFIX")_D_N("DEGREE")
 F  Q:$E(NAM,$L(NAM))'=D  S NAM=$E(NAM,1,$L(NAM)-1)
 Q NAM
 ;
SPD(NAM,N,F) ;Add Suffix, Prefix, and Degree
 S NAM=$$JOIN(NAM,N("SUFFIX"),$E(",",F["Xc")_" ")
 S:F["P" NAM=$$JOIN(N("PREFIX"),NAM)
 S:F["D" NAM=$$JOIN(NAM,N("DEGREE"),$E(",",F["Dc")_" ")
 Q NAM
 ;
JOIN(S1,S2,D) ;Return S1 joined with S2 (separate by D)
 S:$G(D)="" D=" "
 Q S1_$S($L(S1)&$L(S2):D,1:"")_S2
 ;
TRUNC(NC,OVR) ;Truncate component
 S NC=$E(NC,1,$S($L(NC)>OVR:$L(NC)-OVR,1:1))
 F  Q:NC'?.E1" "  S NC=$E(NC,1,$L(NC)-1)
 Q NC
