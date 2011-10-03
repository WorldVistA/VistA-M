GMTSMAG ;SLC/RMP - Imaging Health Summary Component ; 08/27/2002
 ;;2.7;Health Summary;**26,56**;Oct 20, 1995
 ;                    
 ; External References
 ;   DBIA  2791  ^MAG(2005
 ;   DBIA 10022  %XY^%RCR
 ;                    
MAIN ; Imaging Component
 N %X,%Y,GMI,MAX,MAGDFN,IX,X,PROC,GMTSXX Q:'$D(^MAG(2005,"AC",DFN))
 S MAGDFN=DFN,MAX=$S(+($G(GMTSNDM))>0:+($G(GMTSNDM)),1:99999)
 D IMGPTRE^GMTSMAGE(.GMTSXX,MAGDFN_"^"_DUZ)
 S %X="GMTSXX",%Y="^TMP(""MAG"",$J," D %XY^%RCR Q:'$D(^TMP("MAG",$J))
 D WRTMAG S IX=0
 F  S IX=$O(^TMP("MAG",$J,IX)) Q:IX=""  S X=^TMP("MAG",$J,IX) D WRT
 K ^TMP("MAG",$J)
 Q
WRTMAG ; Writes Imaging Header
 D CKP^GMTSUP Q:$D(GMTSQIT)  W ?1,"Date/Time",?20,"Procedure",?34,"Short Description",!!
 Q
WRT ; Writes Image date/time, procedure, short text
 N Y S Y=$P(X,U) S Y=$$FMTE(Y) D CKP^GMTSUP Q:$D(GMTSQIT)  D
 . W Y,?20,$E($P(X,U,2),1,12),?34,$E($P(X,U,3),1,43),!
 Q
FMTE(X) ; Fileman to External
 S X=$G(X) D REGDTM4^GMTSU Q X
