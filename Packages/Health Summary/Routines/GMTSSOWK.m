GMTSSOWK ; SLC/SBW,KER/NDBI - Social Work ; 08/27/2002
 ;;2.7;Health Summary;**28,56**;Oct 20, 1995
 ;
 ; External References
 ;   DBIA   915  ^SOWKHSUM
 ;   DBIA  2929  SW^A7RHSM
 ;                    
MAIN ; Control branching
 N GMTSI K ^TMP("SOWK",$J) D ^SOWKHSUM
 D:$$ROK^GMTSU("A7RHSM")&($$NDBI^GMTSU)&('$D(^TMP("SOWK",$J))) SW^A7RHSM
 Q:'$D(^TMP("SOWK",$J))  S GMTSI=0
 F  S GMTSI=$O(^TMP("SOWK",$J,GMTSI)) Q:+GMTSI'>0  D
 . D CKP^GMTSUP Q:$D(GMTSQIT)  W $G(^TMP("SOWK",$J,GMTSI)),!
 K ^TMP("SOWK",$J)
 Q
