GMVUT0 ;HIOFO/RM,YH,FT-INPUT TRANSFORMS FOR VITAL TYPES ;2/5/02  14:54
 ;;5.0;GEN. MED. REC. - VITALS;;Oct 31, 2002
 ;
 ; This routine uses the following IAs:
 ; <None>
 ;
EN3 ; INPUT TRANSFORM FOR HEIGHT RATES
 ; Called from ^GMRD(120.51,8,1)
 N GMR
 S GMR=$P(X,+X,2,10) I GMR="" S X=0 Q
 I $E(GMR)="C"!($E(GMR)="c")&("CMCmcMcm"[GMR) S X=$J(.3937*(+X),0,2) Q
 I $E(GMR)="I"!($E(GMR)="i")!($E(GMR)="""") S X=+X Q
 I $E(GMR)="F"!($E(GMR)="f")!($E(GMR)="'") D FTIN Q
 S X=0
 Q
FTIN ; Feet and Inches
 N GMRF,GMRIN,GMRXX,GMRYY
 S GMRF=$E(GMR),GMR=$E(GMR,2,$L(GMR)) F GMRXX=1:0 S GMRYY=$E(GMR) Q:GMRYY?1N!(GMRYY="")  S GMRF=GMRF_GMRYY,GMR=$E(GMR,2,$L(GMR))
 I "FTFtfTft'"'[GMRF Q
 S GMRIN=$P(GMR,+GMR,2) I "INIniNin""''"'[GMRIN!(GMRIN="'") Q
 S X=+X*12+(+GMR)
 Q
