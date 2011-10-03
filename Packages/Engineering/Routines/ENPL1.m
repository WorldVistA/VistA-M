ENPL1 ;(WASH ISC)/LKG,SAB-UTILITY FXS ;6/10/97
 ;;7.0;ENGINEERING;**23,28**;Aug 17, 1993
A ;Create string of Building Nos. from multiple for display
 N Y S Y=0,X=""
 F  S Y=$O(^ENG("PROJ",D0,34,Y)) Q:Y'?1.N!($L(X)>235)  S X=X_$S(X]"":",",1:"")_$P($G(^ENG(6928.3,$P(^ENG("PROJ",D0,34,Y,0),U),0)),U)
 Q
V ;Validate format for name
 X ^%ZOSF("UPPERCASE") S X=Y
 I $TR(X,"-' .")'?1.U1","1.U K X Q
 I X[" ,"!(X[", ") K X Q
 Q
SH(ENPR) ; executable help for STATUS field
 ; ENPR - program (internal value)
 N ENI,ENY0
 I $G(ENPR)]"" S ENI=0 F  S ENI=$O(^ENG(6925.2,"AC",ENI)) Q:'ENI  D
 . S ENY0=$G(^ENG(6925.2,$O(^ENG(6925.2,"AC",ENI,0)),0))
 . I $P(ENY0,U,5)[ENPR W ?3,$P(ENY0,U),!
 ;R "  Press RETURN to continue",ENI:DTIME
 Q
ECS ; File 6925, Field 158.7 Environmental Category - Screen
 S DIC("S")="I $S('$D(ENDA):1,$P($G(^(0)),U,5)=$P($G(^ENG(""PROJ"",ENDA,52)),U):1,'$P($G(^ENG(""PROJ"",ENDA,52)),U):1,'$O(^ENG(6925.3,""AC"",$P(^ENG(""PROJ"",ENDA,52),U),0)):1,1:0)"
 Q
XA ; File 6925, Field 233.1 MI/MM CITATION POINTS computed expression
 N ENDA,ENF
 I $D(D0)#10'=1 S X="" G XAE
 I ",MI,MM,"'[(","_$P($G(^ENG("PROJ",D0,0)),U,6)_",") S X="" G XAE
 S ENDA=D0 D A^ENPL3 S X=$P(ENF,U)+$P(ENF,U,2)
XAE Q
XB ; File 6925, Field 233.2 MI/MM SPACE POINTS computed expression
 N ENDA,ENG
 I $D(D0)#10'=1 S X="" G XBE
 I ",MI,MM,"'[(","_$P($G(^ENG("PROJ",D0,0)),U,6)_",") S X="" G XBE
 S ENDA=D0 D B^ENPL3 S X=ENG+0
XBE Q
XC ; File 6925, Field 233.3 MI/MM ENERGY POINTS computed expression
 N ENDA,ENH
 I $D(D0)#10'=1 S X="" G XCE
 I ",MI,MM,"'[(","_$P($G(^ENG("PROJ",D0,0)),U,6)_",") S X="" G XCE
 S ENDA=D0 D C^ENPL3 S X=ENH+0
XCE Q
XD ; File 6925, Field 233.4 MI/MM CATEGORY POINTS computed expression
 N ENDA,ENI
 I $D(D0)#10'=1 S X="" G XDE
 I ",MI,MM,"'[(","_$P($G(^ENG("PROJ",D0,0)),U,6)_",") S X="" G XDE
 D XB I X>0 S X=0 G XDE ; If space points then no points here
 S ENDA=D0 D D^ENPL3 S X=ENI+0
XDE Q
XE ; File 6925, Field 233.5 MI/MM VAMC PRIORITY POINTS computed expression
 N ENDA,ENJ
 I $D(D0)#10'=1 S X="" G XEE
 I ",MI,MM,"'[(","_$P($G(^ENG("PROJ",D0,0)),U,6)_",") S X="" G XEE
 S ENDA=D0 D E^ENPL3 S X=ENJ+0
XEE Q
XF ; File 6925, Field 262.4 NRM CITATION POINTS computed expression
 N ENI,ENP,ENY
 I $D(D0)#10'=1 S X="" G XFE
 I ",NR,"'[(","_$P($G(^ENG("PROJ",D0,0)),U,6)_",") S X="" G XFE
 S (ENI,ENP)=0 F  S ENI=$O(^ENG("PROJ",D0,21,ENI)) Q:ENI'>0  D
 . N %Y,X,X1,X2,Y
 . S ENY=$G(^ENG("PROJ",D0,21,ENI,0))
 . I '$P(ENY,U,8) Q
 . ; base 6-yr limit on 1/15 of current year
 . S X1=$E(DT,1,3)_"0115",X2=$P(ENY,U,3) D ^%DTC I X>2190 Q
 . S ENP=1
 . Q
 S X=$S(ENP:12,1:0)
XFE Q
 ;ENPL1
