YSDX3RU ;SLC/DJP/LJA-Print Utilities for Diagnoses Reporting in the MH Medical Record ;12/14/93 12:58
 ;;5.01;MENTAL HEALTH;;Dec 30, 1994
 ;D RECORD^YSDX0001("YSDX3RU^YSDX3RU") ;Used for testing.  Inactivated in YSDX0001...
 ;
DX ; Called from routins YSDX3R, YSPP6
 ; Lists out diagnoses sequentially
 ;D RECORD^YSDX0001("DX^YSDX3RU") ;Used for testing.  Inactivated in YSDX0001...
 S L="" ; DFN
 F  S L=$O(^YSD(627.8,"AG",L)) QUIT:L=""  D
 .  S L1="" ; Global Reference to DSM or ICD9
 .  F  S L1=$O(^YSD(627.8,"AG",L,YSDFN,L1)) QUIT:L1=""  D
 .  .  S L2=0 ; IEN
 .  .  F  S L2=$O(^YSD(627.8,"AG",L,YSDFN,L1,L2)) QUIT:'L2  D COND Q:YSLFT  D DXVAR
 QUIT
 ;
CHR ; called from routine YSDX3R, YSPP6
 ;D RECORD^YSDX0001("CHR^YSDX3RU") ;Used for testing.  Inactivated in YSDX0001...
 S L=0
 F  S L=$O(^YSD(627.8,"AF",YSDFN,L)) QUIT:'L  D  ;Inverse date
 .  S L1=""
 .  F  S L1=$O(^YSD(627.8,"AF",YSDFN,+L,L1)) QUIT:L1=""  D  ;Global ref
 .  .  S L2=0
 .  .  F  S L2=$O(^YSD(627.8,"AF",YSDFN,L,L1,L2)) QUIT:'L2  D COND Q:YSLFT  S (YSTOP1,YSTOP2)=1 D DXVAR
 QUIT
 ;
COND ;
 ;D RECORD^YSDX0001("COND^YSDX3RU") ;Used for testing.  Inactivated in YSDX0001...
 S:$D(YSPPF) YSPPF=2 K YSSTOP S YSCD=$P(^YSD(627.8,L2,1),U,4)
 S YSCOND=$S(YSCD["A":"A C T I V E",YSCD["I":"I N A C T I V E",1:"")
 I YSTY="ACT" S:YSCD="I" YSSTOP=1
 QUIT
 ;
DXVAR ;
 ;D RECORD^YSDX0001("DXVAR^YSDX3RU") ;Used for testing.  Inactivated in YSDX0001...
 N YSDXI
 QUIT:$D(YSSTOP)  ;->
 ;
 ;  Points to ^YSD(627.7 ?
 I L1["YSD" D
 .  S YSD3FLG="DSM DIAGNOSES: "
 .  S L4=$P(L1,";",2) ;             Global reference
 .  S L5=+$P(L1,";") ;              IEN
 .  S L6="^"_L4_L5_","_0_")" ;      Global reference of 0 node
 .  S L60=@L6 ;                     0 node's data
 .  S YSDXN=^YSD(627.7,+L5,"D") ;   Diagnosis name
 .  S YSDXNN=$P(L60,U) ;            ICD9 #
 ;
 ;  Points to ^ICD9( ?
 I L1["ICD" D
 .  S YSDIFLG="ICD9 DIAGNOSES: "
 .  S L4=$P(L1,";",2) ;             Global reference
 .  S L5=+$P(L1,";") ;              IEN
 .  S L6="^"_L4_L5_","_0_")" ;      Global reference of 0 node
 .  S L60=@L6 ;                     0 node's data
 .  S YSDXN=$P(L60,U,3) ;           Diagnosis (free text)
 .  S YSDXNN=$P(L60,U) ;            ICD9 #
 ;
 ;  Modifiers?
 I $D(^YSD(627.8,+L2,5)) D
 .  S YSML=$P(^YSD(627.8,+L2,5,0),U,3)
 .  F YSDXI=1:1:YSML D
 .  .  S M1=$G(^YSD(627.8,+L2,5,+YSDXI,0))
 .  .  QUIT:M1']""  ;->
 .  .  S YSMOD(+YSDXI)=$P(M1,U,3)
 .  .  K M1
 ;
 ;  Status
 S L8=$P(^YSD(627.8,+L2,1),U,2)
 S YSDXS=$S(L8="v":"VERIFIED",L8="p":"PROVISIONAL",L8="i":"INACTIVE",L8="r":"REFORMULATED",L8="n":"NOT FOUND",L8="ru":"RULE OUT",1:"")
 S Y=$P(^YSD(627.8,+L2,0),U,3) D DD^%DT S YSDXDT=Y
 ;
AUTH ;
 ;D RECORD^YSDX0001("AUTH^YSDX3RU") ;Used for testing.  Inactivated in YSDX0001...
 ;  Diagnosed by
 S L9=+$P(^YSD(627.8,L2,0),U,4)
 I L9>0 D
 .  S L10=$P($G(^VA(200,L9,0)),U) ;      New Person's name
 .  S L11=$P($G(^VA(200,L9,0)),U,9) ;    Title
 .  S:L11>0 L11=$P(^DIC(3.1,+L11,0),U) ; Title file
 .  S YSAUTH=L10_"  "_L11
PRINTL ;
 ;D RECORD^YSDX0001("PRINTL^YSDX3RU") ;Used for testing.  Inactivated in YSDX0001...
 I $Y+YSSL+4>IOSL D CK Q:YSTOUT!(YSUOUT)!(YSLFT)
 I $D(YSD3FLG)&'$D(YSTOP1) W !!,YSD3FLG S YSTOP1=1
 I $D(YSDIFLG)&'$D(YSTOP2) W !!,YSDIFLG S YSTOP2=1
 W !!,YSDXNN,!?3,$E(YSDXN,1,76),!?3,YSCOND
 I $D(YSMOD) F I=1:1:YSML I $D(YSMOD(I)) W:$TR(YSMOD(I)," ","")]"" !?8,"--- "_YSMOD(I)
 W:YSDXS'=" " !?8,"--- "_YSDXS
 I $D(^YSD(627.8,L2,80,0)) W !?8,"Comments:  " S DIWL=20,DIWR=75,DIWF="W" K ^UTILITY($J,"W") S M=0 F  S M=$O(^YSD(627.8,L2,80,M)) Q:'M  S X=^(M,0) D ^DIWP
 I $D(M),M<1 D ^DIWW K ^UTILITY($J,"W")
 W !?8,"Entered by:  " W:$D(YSAUTH) YSAUTH W !?8,"Dated: ",?21,YSDXDT
 QUIT
 ;
CK ; Called by routines YSDX3R1, YSDX3RUA
 ;D RECORD^YSDX0001("CK^YSDX3RU") ;Used for testing.  Inactivated in YSDX0001...
 I 'YST D WAIT^YSUTL W:YSTOUT!YSUOUT @IOF Q
 S:YSSL YSCON=1 D ENFT^YSFORM D:($Y+YSSL+4>IOSL) ENHD^YSFORM Q
ENPP ;
 ;D RECORD^YSDX0001("ENPP^YSDX3RU") ;Used for testing.  Inactivated in YSDX0001...
 S YSFHDR="DIAGNOSIS LIST",YSPP=1 G PR^YSDX3R
 ;
FINISH ; Called by routines YSDX3R, YSDX3RUA
 ;D RECORD^YSDX0001("FINISH^YSDX3RU") ;Used for testing.  Inactivated in YSDX0001...
 K YSFFS I $D(YSNOFORM) D ^%ZISC,KILL^%ZTLOAD Q
 W !!?10,"*** LIST COMPLETE ***",! S YSFFS=1
 I YST=1 D ENFT^YSFORM,^%ZISC,KILL^%ZTLOAD Q
 D WAIT^YSUTL
 QUIT
 ;
EOR ;YSDX3RU-Print Utilities for Diagnoses in Med Record ;10/19/89  17:10
