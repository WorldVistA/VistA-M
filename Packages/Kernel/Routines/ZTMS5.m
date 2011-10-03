%ZTMS5 ;ISF/RWF - TaskMan utility ;2/19/08  13:46
 ;;8.0;KERNEL;**275,446**;Jul 10, 1995;Build 35
 ;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;Called from ZTMON1, Jobed from %ZTM5.
SUBCHK(DILOCKTM) ;Check for lost submanagers, Update Count
 N %C,%N,%J,ZT2,ZT3,TO
 I '$D(DILOCKTM) S DILOCKTM=+$G(^DD("DILOCKTM"),0) ;p446
 S %N="",MARK=$G(MARK)
 F  S %N=$O(^%ZTSCH("SUB",%N)) Q:%N=""  D
 . L +^%ZTSCH("SUB",%N):DILOCKTM
 . S %C=0,%J=0,ZT3=$$H3^%ZTM($H)
 . F  S %J=$O(^%ZTSCH("SUB",%N,%J)) Q:%J'>0  D
 . . S ZT2=$$H3^%ZTM($G(^(%J)))
 . . ;Check for old
 . . I (ZT2+30)<ZT3 K ^%ZTSCH("SUB",%N,%J) Q
 . . ;Check for not locked.
 . . L +^%ZTSCH("SUBLK",%N,%J):DILOCKTM I $T L -^%ZTSCH("SUBLK",%N,%J) K ^%ZTSCH("SUB",%N,%J) Q
 . . S %C=%C+1
 . . Q
 . S ^%ZTSCH("SUB",%N)=%C
 . L -^%ZTSCH("SUB",%N)
 . Q
 Q
