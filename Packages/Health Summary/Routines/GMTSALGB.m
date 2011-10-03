GMTSALGB ; SLC/DLT,KER - Brief Adverse Reaction/Allergy ; 02/27/2002
 ;;2.7;Health Summary;**28,49**;Oct 20, 1995
 ;                 
 ; External References
 ;   DBIA 10096  ^%ZOSF("TEST"
 ;   DBIA 10099  EN1^GMRADPT 
 ;                   
ALLRG ; Allergies
 N I,Z,X,SEQ,GMTSA,ALLRG K GMTSA S (SEQ,ALLRG)=0 S X="GMRADPT" X ^%ZOSF("TEST")
 I $T D  Q:$D(GMTSQIT)
 . D GETALLRG I ALLRG D
 . . D CKP^GMTSUP Q:$D(GMTSQIT)  W ?3,"Allergy/Reaction: " D ALLRGP
 Q
ALLRGP ; Allergy Print
 D CKP^GMTSUP Q:$D(GMTSQIT)  W ?21 S X=0
 F I=0:0 S I=$O(GMTSA(I)) Q:I=""  D  Q:$D(GMTSQIT)
 . S X=X+1 W:X>1 ", " W:(77)'>($X+$L(GMTSA(I))) !
 . D CKP^GMTSUP Q:$D(GMTSQIT)  W GMTSA(I)
 Q:$D(GMTSQIT)  D CKP^GMTSUP Q:$D(GMTSQIT)  W ! Q
GETALLRG ; Get Allergies
 N GMI,GMJ,GMRAL D EN1^GMRADPT I GMRAL="" S ALLRG=0 Q
 I GMRAL="0" S ALLRG=1,GMTSA(1)="No Known Allergies" Q
 S ALLRG=1,GMI=0 F  S GMI=$O(GMRAL(GMI)) Q:GMI'>0  D
 . S GMTSA(GMI)=$P(GMRAL(GMI),U,2)
 . S GMJ=0 F  S GMJ=$O(GMTSA(GMJ)) Q:GMJ'>0  I GMI'=GMJ,(GMTSA(GMI)=$G(GMTSA(GMJ))) K GMTSA(GMI) Q
 Q
