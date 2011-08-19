FBUTL3 ;WOIFO/SAB-FEE BASIS UTILITY ;6/19/2003
 ;;3.5;FEE BASIS;**61**;JAN 30, 1995
 Q
ARCDES ; Adjustment Reason Current Description Identifier
 ; Called by File 161.91 "CDES" Write Identifier
 N FBFMT,FBI,FBARTXT,FBX
 N DIWF,DIWL,DIWR,X
 ;
 ; get current description
 S FBX=$$AR^FBUTL1(Y,,,"FBARTXT")
 I '$O(FBARTXT(0)) Q  ; no description found
 ;
 ; reformat text into 50 character width
 K ^UTILITY($J,"W")
 S DIWL=1,DIWR=50,DIWF=""
 S FBI=0 F  S FBI=$O(FBARTXT(FBI)) Q:'FBI  S X=FBARTXT(FBI) D ^DIWP
 ;
 ;  'display' idenitifer using EN^DDIOL
 S FBI=0 F  S FBI=$O(^UTILITY($J,"W",DIWL,FBI)) Q:'FBI  D
 . S FBFMT=$S(FBI=1:"?15",1:"!?15")
 . S FBX=$G(^UTILITY($J,"W",DIWL,FBI,0))
 . D EN^DDIOL(FBX,,FBFMT)
 ;
 ; cleanup
 K ^UTILITY($J,"W")
 Q
 ;
AGCDN ; Adjustment Group Current Descriptive Name Identifier
 ; Called by File 161.92 "CDN" Write Identifier
 N FBX
 ;
 ; get current descriptive name
 S FBX=$$AG^FBUTL1(Y)
 ;
 ; 'display' using EN^DDIOL
 I $P(FBX,U,5)]"" D EN^DDIOL($P(FBX,U,5),,"?15")
 ;
 Q
 ;
RRCDES ; Remittance Remarks Current Description Identifier
 ; Called by File 161.93 "CDES" Write Identifier
 N FBFMT,FBI,FBRRTXT,FBX
 N DIWF,DIWL,DIWR,X
 ;
 ; get current description
 S FBX=$$RR^FBUTL1(Y,,,"FBRRTXT")
 I '$O(FBRRTXT(0)) Q  ; no description found
 ;
 ; reformat text into 50 character width
 K ^UTILITY($J,"W")
 S DIWL=1,DIWR=50,DIWF=""
 S FBI=0 F  S FBI=$O(FBRRTXT(FBI)) Q:'FBI  S X=FBRRTXT(FBI) D ^DIWP
 ;
 ;  'display' idenitifer using EN^DDIOL
 S FBI=0 F  S FBI=$O(^UTILITY($J,"W",DIWL,FBI)) Q:'FBI  D
 . S FBFMT=$S(FBI=1:"?15",1:"!?15")
 . S FBX=$G(^UTILITY($J,"W",DIWL,FBI,0))
 . D EN^DDIOL(FBX,,FBFMT)
 ;
 ; cleanup
 K ^UTILITY($J,"W")
 Q
 ;
 ;FBUTL3
