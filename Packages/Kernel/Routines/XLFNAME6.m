XLFNAME6 ;CIOFO-SF/TKW,MKO-Utilities for person name fields ;11:41 AM  14 Mar 2000
 ;;8.0;KERNEL;**134**;Jul 10, 1995
 ;
FMNAME(XUNAME,XUFLAG,XUDLM) ; Convert HL7 format name to regular name
 ; XUNAME   - HL7 string to be converted
 ; XUDLM  - Delimiter (defaults to "^")
 ; XUFLAG   [ C  : Returns name components
 ;            L# : Truncate to length of #
 ;            M  : Mixed case
 ;            S  : Standardize name
F N I,N,S,XUF
 Q:$G(XUNAME)="" ""
 S:$G(XUDLM)="" XUDLM="^"
 S XUFLAG=$G(XUFLAG)
 I XUFLAG'["C" N X S X=XUNAME N XUNAME S XUNAME=X
 ;
 S I=0 F S="FAMILY","GIVEN","MIDDLE","SUFFIX" S I=I+1 D
 . S XUNAME(S)="",N=$P(XUNAME,XUDLM,I) Q:N=""""""
 . S XUNAME(S)=N Q
 ;
 S XUF="C"_$E("M",XUFLAG["M")_$E("S",XUFLAG["S")
 S:XUFLAG["L" XUF=XUF_"L"_+$P(XUFLAG,"L",2)
 Q $$NAMEFMT^XLFNAME(.XUNAME,"F",XUF)
