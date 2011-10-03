DIPS95 ;SFISC/MKO-POST INSTALL ROUTINE FOR PATCH DI*22*95 ;8:38 AM  18 Sep 2002
 ;;22.0;VA FileMan;**95**;Mar 30, 1999
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;Recompile all input templates that contain fields with new-style
 ;cross-references defined on them.
RECOMP N CNT,FIL,FLD,NAM,TEM
 K ^TMP("DIPS95",$J)
 D BMES^XPDUTL("Recompiling input templates...")
 S FIL=.9999 F  S FIL=$O(^DD("IX","F",FIL)) Q:'FIL  D
 . S FLD=0 F  S FLD=$O(^DD("IX","F",FIL,FLD)) Q:'FLD  D
 .. S TEM=0 F  S TEM=$O(^DIE("AF",FIL,FLD,TEM)) Q:'TEM  D
 ... Q:$D(^TMP("DIPS95",$J,"TEM",TEM))  S ^(TEM)=""
 ... S NAM=$G(^DIE(TEM,"ROUOLD")) Q:NAM=""
 ... S CNT=$G(CNT)+1
 ... D MES^XPDUTL("  #"_TEM_"    "_$P($G(^DIE(TEM,0)),U)_"    File #"_$P($G(^DIE(TEM,0)),U,4)_"    ^"_NAM)
 ... D EN2^DIEZ(TEM,"",NAM)
 D:'$G(CNT) MES^XPDUTL("  -- No input template needed to be recompiled.")
 K ^TMP("DIPS95",$J)
 Q
