SDPURG2 ;ALB/TMP - Purge-Print Routine - Patient File nodes ; 12/24/85
 ;;5.3;Scheduling;;Aug 13, 1993
 S SDCT=0
 W !,"Begin purge of Patient File nodes" S Y=% D DT^DIQ
 S (B,SDCT)=0 F A=0:0 S B=$N(^DPT("ASDPSD",B)) W:B=-1 !,SDCT," SPECIAL SURVEY XREFS PURGED",!!,"End of Patient File purge" Q:B=-1  D DEL2,DOT
 G END^SDPURG1
DOT W:'(SDCT#100)&('SDPR) "."
 Q
DEL2 I B'["B",B'["C" F C=0:0 S C=$N(^DPT("ASDPSD",B,C)) Q:C'>0!(C'<SDLIM1)  S X="^DPT(""ASDPSD"","""_B_""","_C_")" D PRT K @X D CT
 I B["B" S D=0 F C=0:0 S D=$N(^DPT("ASDPSD",B,D)) Q:D=-1  F E=0:0 S E=$N(^DPT("ASDPSD",B,D,E)) Q:E'>0!(E'<SDLIM1)  D MORE2 S X="^DPT(""ASDPSD"","""_B_""","""_D_""","_E_")" K @X
 S D=0
 I B["C" F C=0:0 S D=$N(^DPT("ASDPSD",B,D)) Q:D<0  S E=-1 F E1=0:0 S E=$N(^DPT("ASDPSD",B,D,E)) Q:E<0  F F=0:0 S F=$N(^DPT("ASDPSD",B,D,E,F)) Q:F<0!(F'<SDLIM1)  D MORE1 S X="^DPT(""ASDPSD"","""_B_""","""_D_""","_G_","_F_")" K @X
 Q
MORE1 S G=$S(E:E,1:""""_E_"""") Q:'SDPR  F I=0:0 S I=$N(^DPT("ASDPSD",B,D,E,F,I)) Q:I'>0  S X="^DPT(""ASDPSD"","""_B_""","""_D_""","_G_","_F_","_I_")" D PRT D CT
 Q
MORE2 Q:'SDPR  F I=0:0 S I=$N(^DPT("ASDPSD",B,D,E,I)) Q:I'>0  S Y=+^(I) I 'Y!(Y>6) K Y S X="^DPT(""ASDPSD"","""_B_""","""_D_""","_E_","_I_")" D PRT D CT
 Q
PRT I SDPR W:$S(($D(@X)#2):1,1:0) !,X," = ",@X
 Q
CT S SDCT=SDCT+1 Q
