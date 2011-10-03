ONCOMNI ;Hines OIFO/GWB - ALGORITHM FOR COMPUTING MIDDLE NAME/INITIAL ;12/10/99
 ;;2.11;ONCOLOGY;**1,11,13,22,25,28,49**;Mar 07, 1995;Build 38
 ;
 D SETUP^ONCOES
 S NAME=$P(@ONCOX1,U,1),FNMI=$P(NAME,",",2),MNI=$P(FNMI," ",2)
 I (MNI="JR")!(MNI="JR.")!(MNI="SR")!(MNI="SR.")!(MNI="MD")!(MNI="MD.")!(MNI="NMN")!(MNI="NMN.")!(MNI="NMI")!(MNI="NMI.")!(MNI="II")!(MNI="III")!(MNI="IV") S MNI=""
 I $L(MNI)=2,$E(MNI,2)="." S MNI=$E(MNI,1)
 S X=$E(MNI,1,14)
 K ONCON,ONCOX,ONCOX1,NAME,FNMI,MNI
 Q
CHFPS ;CALCULATE VALUE OF FIELD #803 (CANCER HISTORY-1ST PRIMARY SITE)
 I $P($G(^ONCO(165.5,D0,"NHL1")),U,4)'="" S X="" Q
 S CHFSNM=$P($G(^ONCO(165.5,D0,0)),U,2)
 S X="C88.8",CHFSFLG=0
 S CHFS="" F  S CHFS=$O(^ONCO(165.5,"C",CHFSNM,CHFS)) Q:CHFS'>""!(CHFSFLG>0)  I $$DIV^ONCFUNC(CHFS)=DUZ(2) D
 .I CHFS=D0 Q
 .S CHFSFLG=CHFSFLG+1,TPX=$P($G(^ONCO(165.5,CHFS,2)),U,1) S:TPX'="" TPX=$G(^ONCO(164,TPX,0)) S:TPX'="" X=$P(TPX,U,2) Q
 K CHFS,CHFSFLG,CHFSNM,TPX Q
CHFPH ;CALCULATE VALUE OF FIELD #804 (CANCER HISTORY-1ST PRIMARY HISTOLOGY)
 I $P($G(^ONCO(165.5,D0,"NHL1")),U,5)'="" S X="" Q
 S CHFHNM=$P($G(^ONCO(165.5,D0,0)),U,2)
 S X="8888/8",CHFHFLG=0
 S CHFH="" F  S CHFH=$O(^ONCO(165.5,"C",CHFHNM,CHFH)) Q:CHFH'>""!(CHFHFLG>0)  I $$DIV^ONCFUNC(CHFH)=DUZ(2) D
 .I CHFH=D0 Q
 .S CHFHFLG=CHFHFLG+1,TPX=$$HIST^ONCFUNC(CHFH,.HSTFLD,.HISTNAM,.ICDFILE) S:TPX'="" TPX=$G(^ONCO(ICDFILE,TPX,0)) S:TPX'="" X=$P(TPX,U,2) Q
 K CHFH,CHFHFLG,CHFHNM,HISTNAM,HSTFLD,ICDFILE,TPX Q
 ;
CHSPS ;CALCULATE VALUE OF FIELD #805 (CANCER HISTORY-2ND PRIMARY SITE)
 I $P($G(^ONCO(165.5,D0,"NHL1")),U,6)'="" S X="" Q
 S CHSSNM=$P($G(^ONCO(165.5,D0,0)),U,2)
 S X="C88.8",CHSSFLG=0
 S CHSS="" F  S CHSS=$O(^ONCO(165.5,"C",CHSSNM,CHSS)) Q:CHSS'>""!(CHSSFLG>1)  I $$DIV^ONCFUNC(CHSS)=DUZ(2) D
 .I CHSS=D0 Q
 .I CHSSFLG=0 S CHSSFLG=CHSSFLG+1 Q
 .S CHSSFLG=CHSSFLG+1,TPX=$P($G(^ONCO(165.5,CHSS,2)),U,1) S:TPX'="" TPX=$G(^ONCO(164,TPX,0)) S:TPX'="" X=$P(TPX,U,2) Q
 K CHSS,CHSSFLG,CHSSNM,TPX Q
CHSPH ;CALCULATE VALUE OF FIELD #806 (CANCER HISTORY-2ND PRIMARY HISTOLOGY)
 I $P($G(^ONCO(165.5,D0,"NHL1")),U,7)'="" S X="" Q
 S CHSHNM=$P($G(^ONCO(165.5,D0,0)),U,2)
 S X="8888/8",CHSHFLG=0
 S CHSH="" F  S CHSH=$O(^ONCO(165.5,"C",CHSHNM,CHSH)) Q:CHSH'>""!(CHSHFLG>1)  I $$DIV^ONCFUNC(CHSH)=DUZ(2) D
 .I CHSH=D0 Q
 .I CHSHFLG=0 S CHSHFLG=CHSHFLG+1 Q
 .S CHSHFLG=CHSHFLG+1,TPX=$$HIST^ONCFUNC(CHSH,.HSTFLD,.HISTNAM,.ICDFILE) S:TPX'="" TPX=$G(^ONCO(ICDFILE,TPX,0)) S:TPX'="" X=$P(TPX,U,2) Q
 K CHSH,CHSHFLG,CHSHNM,TPX Q
ARCHHLP ;AIDS RISK CATEGORY FOR HIV POSITIVE PATIENT (#822) HELP
 W !?5,"Choose from the following codes:",!
 W !?8,"0  Not HIV positive"
 W !?8,"1  No known risk category"
 W !?8,"2  Homosexual/Bisexual"
 W !?8,"3  IV drug user"
 W !?8,"4  Blood product recipient"
 W !?8,"5  Heterosexual transmission"
 W !?8,"6  Congenitally acquired"
 W !?8,"7  Multiple categories"
 W !?8,"8  Other/Unknown risk category"
 W !?8,"9  Unknown if HIV positive",!
 Q
ARCHP ;AIDS RISK CATEGORY FOR HIV POSITIVE PATIENT (#822) OUTPUT TRANSFORM
 I Y=0 S Y="Not HIV positive" Q
 I Y=1 S Y="No known risk category" Q
 I Y=2 S Y="Homosexual/Bisexual" Q
 I Y=3 S Y="IV drug user" Q
 I Y=4 S Y="Blood product recipient" Q
 I Y=5 S Y="Heterosexual transmission" Q
 I Y=6 S Y="Congenitally acquired" Q
 I Y=7 S Y="Multiple categories" Q
 I Y=8 S Y="Other/Unknown risk category" Q
 I Y=9 S Y="Unknown if HIV positive" Q
 Q
EXNSIT ;EXTRANODAL SITE 1,2,3 (FIELDS #852,#853,#854) INPUT TRANSFORM
 N CCD
 I X[U!(X="") K X Q
 I $L(X)<3 W *7,"  Must be at least 3 characters " K X Q
 I X=888!(X="C888")!(X=88.8)!(X="C88.8") S X="C888" W "  None" Q
 I X=999!(X="C999")!(X=99.9)!(X="C99.9") S X="C999" W "  Unknown" Q
 K DIC S DIC="^ONCO(164,",DIC(0)="EMQ" D ^DIC
 I Y<0 K X Q
 I +Y'<0 S CCD=$P($G(^ONCO(164,+Y,0)),U,2) S X=$E(CCD,1,3)_$E(CCD,5) Q
EXNSOT ;EXTRANODAL SITE 1,2,3 (FIELDS #852,#853,#854) OUTPUT TRANSFORM
 I Y="C888" S Y="None" Q
 I Y="C999" S Y="Unknown" Q
 S EXN=$E(Y,1,3)_"."_$E(Y,4)
 F TPG=0:0 S TPG=$O(^ONCO(164,TPG)) Q:TPG'>0  D
 .I EXN'=$P($G(^ONCO(164,TPG,0)),U,2) Q
 .S TPGNM=$P($G(^ONCO(164,TPG,0)),U,1),EXN=EXN_"  "_TPGNM Q
 S Y=EXN K EXN,TPG,TPGNM Q
XHP ;EXTRANODAL SITE 1,2,3 (FIELDS #852,#853,#854) EXECUTABLE HELP
 I X'="?",X'="??" Q
 K DIC S DIC="^ONCO(164,",DIC(0)="EMQ" D ^DIC Q
RCSIT ;RADIATION/CHEMOTHERAPY SEQUENCE (#862) INPUT TRANSFORM
 I X=0!(X=5)!(X=6) K X Q
 S Y=X D RCSOT W "  ",Y K Y
 Q
RCSOT ;RADIATION/CHEMOTHERAPY SEQUENCE (#862) OUTPUT TRANSFORM
 I Y=1 S Y="Radiation before chemotherapy"
 I Y=2 S Y="Chemotherapy before radiation"
 I Y=3 S Y="Chemotherapy before and after radiation"
 I Y=4 S Y="Radiation and chemotherapy concurrently"
 I Y=7 S Y="Unknown if radiation and/or chemo given"
 I Y=8 S Y="NA, no radiation and/or no chemo given"
 I Y=9 S Y="Sequence unknown"
 Q
RCSHP ;RADIATION/CHEMOTHERAPY SEQUENCE (#862) HELP
 N DTDX,FSDX
 W !,"  1  Radiation before chemotherapy"
 W !,"  2  Chemotherapy before radiation"
 W !,"  3  Chemotherapy before and after radiation"
 W !,"  4  Radiation and chemotherapy concurrently"
 W !,"  7  Unknown if radiation and/or chemo given"
 W !,"  8  NA, no radiation and/or no chemo given"
 W !,"  9  Sequence unknown",!
 Q
 S %DT="EP",%DT(0)="-NOW" D ^%DT S X=Y K:Y<1 X K %DT
 I $D(X) S DTDX=$P($G(^ONCO(165.5,D0,0)),U,16) I DTDX'="" K:X<DTDX X
FSC ;Calculate default for fields #1102,#1103
 ;I $P($G(^ONCO(165.5,D0,"MEL1")),U,3)'="" S X="" Q
 S PNM=$P($G(^ONCO(165.5,D0,0)),U,2),X="C88.8",FSDX="88/8888"
 S ST=0 F  S ST=$O(^ONCO(165.5,"C",PNM,ST)) Q:ST'>0  I $$DIV^ONCFUNC(ST)=DUZ(2) S LAST=ST
 I LAST'=D0 D
 .S Y=$P($G(^ONCO(165.5,LAST,0)),U,16) D CHDTOT^ONCOPCE S FSDX=Y
 .S TPX=$P($G(^ONCO(165.5,LAST,2)),U,1) I TPX="" Q
 .S TPX=$G(^ONCO(164,TPX,0)) S:TPX'="" X=$P(TPX,U,2) Q
 I LAST=D0 F  S LAST=$O(^ONCO(165.5,"C",PNM,LAST),-1) Q:LAST=""  I $$DIV^ONCFUNC(LAST)=DUZ(2) D  Q
 .S Y=$P($G(^ONCO(165.5,LAST,0)),U,16) D CHDTOT^ONCOPCE S FSDX=Y
 .S TPX=$P($G(^ONCO(165.5,LAST,2)),U,1) I TPX="" Q
 .S TPX=$G(^ONCO(164,TPX,0)) S:TPX'="" X=$P(TPX,U,2) Q
 K LAST,PNM,ST,TPX Q
SSC ;Calculate default for fields #1104,#1105
 S PNM=$P($G(^ONCO(165.5,D0,0)),U,2),X="C88.8",SSDX="88/8888",FLG=0
 S ST=0 F  S ST=$O(^ONCO(165.5,"C",PNM,ST)) Q:ST'>0  I $$DIV^ONCFUNC(ST)=DUZ(2) S LAST=ST
 I LAST'=D0 S FLG=FLG+1
 S SSC=LAST F  S SSC=$O(^ONCO(165.5,"C",PNM,SSC),-1) Q:SSC'>""!(FLG>1)  I $$DIV^ONCFUNC(SSC)=DUZ(2) D
 .I SSC=D0 Q
 .I FLG=0 S FLG=FLG+1 Q
 .S FLG=FLG+1
 .S Y=$P($G(^ONCO(165.5,SSC,0)),U,16) D CHDTOT^ONCOPCE S SSDX=Y
 .S TPX=$P($G(^ONCO(165.5,SSC,2)),U,1) S:TPX'="" TPX=$G(^ONCO(164,TPX,0)) S:TPX'="" X=$P(TPX,U,2) Q
 K FLG,LAST,PNM,SSC,SSDX,ST,TPX Q
 ;
NSNIT ;Number of Satellite Nodules (#1112)
 I X'?1.2N K X Q
 I X=0!(X="00") S X="00" W "  No satellite nodules"
 I X=96 W "  96 or more nodules"
 I X=97 W "  Satellite nodules, # unknown"
 I X=98 W "  NA, non-cutaneous melanoma"
 I X=99 W "  Unknown"
 S X=$S($L(X)=1:"0"_X,1:X)
 Q
NSNOT ;Number of Satellite Nodules (#1112)
 I Y="00" S Y="No satellite nodules" Q
 I Y=96 S Y="96 or more nodules" Q
 I Y=97 S Y="Satellite nodules, # unknown" Q
 I Y=98 S Y="NA, non-cutaneous melanoma" Q
 I Y=99 S Y="Unknown" Q
 S Y=$S(Y="01":Y_" nodule",1:Y_" nodules")
 Q
BTIT ;Breslow's Thickness (#1113)
 I X'?1.3N K X Q
 I X=997 W "  Cutaneous melanoma, thickness unk"
 I X=998 W "  NA, non-cutaneous melanoma"
 I X=999 W "  Primary site unknown"
 S X=$S($L(X)=1:"00"_X,$L(X)=2:"0"_X,1:X)
 Q
BTOT ;Breslow's Thickness (#1113)
 I Y=997 S Y="Cutaneous melanoma, thickness unk" Q
 I Y=998 S Y="NA, non-cutaneous melanoma" Q
 I Y=999 S Y="Primary site unknown" Q
 S Y=Y_" mm"
 Q
MDIT ;Margin Distance (#1120)
 I X'?1.3N K X Q
 I X=997 W "  Margins free, distance unknown"
 I X=998 W "  NA, surgery not performed"
 I X=999 W "  Unknown"
 S X=$S($L(X)=1:"00"_X,$L(X)=2:"0"_X,1:X)
 Q
MDOT ;Margin Distance (#1120)
 I Y=996 S Y=Y_"mm or more" Q
 I Y=997 S Y="Margins free, distance unknown" Q
 I Y=998 S Y="NA, surgery not performed" Q
 I Y=999 S Y="Unknown" Q
 S Y=Y_"mm"
 Q
 ;
SNPIT ;Sentinel Nodes Positive (#1125)
 N SNE
 I X=0!(X>6) Q
 S SNE=$P($G(^ONCO(165.5,D0,"MEL1")),U,25) I SNE=""!(SNE>5) Q
 I X>SNE W !,"     Sentinel Nodes Positive MUST be less than/equal Sentinel Nodes Examined! " K X Q
 Q
 ;
NBPIT ;Number of Basins Positive (#1129)
 N NBD
 I X=0!(X>6) Q
 S NBD=$P($G(^ONCO(165.5,D0,"MEL1")),U,29) I NBD=""!(NBD>5) Q
 I X>NBD W !,"     Number of Basins Positive MUST be less than/equal to Basins Detected! " K X Q
 Q
