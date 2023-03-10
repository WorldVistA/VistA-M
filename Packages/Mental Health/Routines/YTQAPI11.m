YTQAPI11 ;ASF/ALB - MHAx API ; 8/9/10 10:34am
 ;;5.01;MENTAL HEALTH;**85,96,123,187**;DEC 30,1994;Build 73
 ;
 ;Reference to %ZIS supported by IA #10086
 ;Reference to %ZTLOAD supported by IA #10063
 ;Reference to DOB^DPTLK1 supported by IA #3266
 ;Reference to SSN^DPTLK1 supported by IA #3267
SCORSAVE(YSDATA,YS) ;save results to 601.92
 ; input: AD as administration ID
 ; output: DATA vs ERROR
 N YSAD,DIK,YSG,YSRNEW ; patch 123: don't need, removed tasking,Z,ZTRTN,ZTIO,ZTSAVE,ZTDESC,ZTDTH
 ; patch 123, new variables
 N DA,Z
 S YSAD=$G(YS("AD"))
 I YSAD'?1N.N S YSDATA(1)="[ERROR]",YSDATA(2)="bad ad num" Q  ;-->out
 I '$D(^YTT(601.84,YSAD)) S YSDATA(1)="[ERROR]",YSDATA(2)="ad not found" Q  ;-->out
 ;
 S YSDATA(1)="[DATA]"
 ;task
 ; patch 123 -- remove tasking call
 ;D  D ^%ZTLOAD D HOME^%ZIS K IO("Q") Q  ;-->out
 ;.S ZTIO="",ZTDTH=$H
 ;.S ZTRTN="SSEN^YTQAPI11",ZTDESC="MHA3 SCORSAVE",ZTSAVE("YS*")=""
 ;
SSEN ;scorsave entry
 ; patch 123 remove this, put in 2 other calls.
 ;D GETSCORE^YTQAPI8(.YSDATA,.YS)
 ; new subroutines
 D LOADANSW^YTSCORE(.YSDATA,.YS) ; put Answers for an Admin into YSDATA
 N IEN71
 S IEN71=$$GET1^DIQ(601.84,YSAD_",",2,"I")
 I 'IEN71 S ^TMP($J,"YSCOR",1)="[ERROR]",^TMP($J,"YSCOR",2)="No Instrument IEN in SCORSAVE" Q  ;-->out
 ; design is in doScoring logic document
 D SCOREINS^YTSCORE(.YSDATA,.IEN71) ; score the instrument passing Answer Array (YSDATA) and Instrument IEN
 I $G(^TMP($J,"YSCOR",1))'="[DATA]" S ^TMP($J,"YSCOR",1)="[ERROR]",^TMP($J,"YSCOR",2)="Scoring Error, in SCORSAVE" Q  ;-->out 
 D UPDSCORE^YTSCORE(.YSDATA,.YS)
 Q
 ;delete any previous scores for this admin
 ; patch 123, original code, no longer deleting scores
 ;S DIK="^YTT(601.92,",DA=0
 ;F  S DA=$O(^YTT(601.92,"AC",YSAD,DA)) Q:DA'>0  D ^DIK
 ;ADD SCORES
 ;S Z=1 F  S Z=$O(^TMP($J,"YSCOR",Z)) Q:Z'>0  D
 ;. S YSG=^TMP($J,"YSCOR",Z)
 ;. S YSRNEW=$$NEW^YTQLIB(601.92)
 ;. S ^YTT(601.92,YSRNEW,0)=YSRNEW_U_YSAD_U_$P(YSG,"=")_U_$P(YSG,"=",2)
 ;. S DA=YSRNEW D IX^DIK
 ;S YSDATA(1)="[DATA]"
 ;Q
SCALES ;from copy
 S YSSGOLD="" F  S YSSGOLD=$O(^YTT(601.86,"AD",YSOLDNUM,YSSGOLD)) Q:YSSGOLD'>0  D
 . S YSSGNEW=$$NEW^YTQLIB(601.86)
 . S ^YTT(601.86,YSSGNEW,0)=^YTT(601.86,YSSGOLD,0)
 . S $P(^YTT(601.86,YSSGNEW,0),U)=YSSGNEW
 . S $P(^YTT(601.86,YSSGNEW,0),U,2)=YSNEWNUM
 . S DA=YSSGNEW,DIK="^YTT(601.86," D IX^DIK
 . S YSSLOLD=0 F  S YSSLOLD=$O(^YTT(601.87,"AD",YSSGOLD,YSSLOLD)) Q:YSSLOLD'>0  D
 .. S YSSLNEW=$$NEW^YTQLIB(601.87)
 .. S ^YTT(601.87,YSSLNEW,0)=^YTT(601.87,YSSLOLD,0)
 .. S $P(^YTT(601.87,YSSLNEW,0),U)=YSSLNEW
 .. S $P(^YTT(601.87,YSSLNEW,0),U,2)=YSSGNEW
 .. S DA=YSSLNEW,DIK="^YTT(601.87," D IX^DIK
 .. S YSKEYOLD=0 F  S YSKEYOLD=$O(^YTT(601.91,"AC",YSSLOLD,YSKEYOLD)) Q:YSKEYOLD'>0  D
 ... S YSKEYNEW=$$NEW^YTQLIB(601.91)
 ... S ^YTT(601.91,YSKEYNEW,0)=^YTT(601.91,YSKEYOLD,0)
 ... S $P(^YTT(601.91,YSKEYNEW,0),U)=YSKEYNEW
 ... S $P(^YTT(601.91,YSKEYNEW,0),U,2)=YSSLNEW
 ... S YSQX=$P(^YTT(601.91,YSKEYNEW,0),U,3)
 ... I (YSQX?1N.N)&($D(^TMP($J,"YSM","O",YSQX))) S $P(^YTT(601.91,YSKEYNEW,0),U,3)=^TMP($J,"YSM","O",YSQX)
 ... S DA=YSKEYNEW,DIK="^YTT(601.91," D IX^DIK
 Q
RULES ;from copy
 S N=$O(^YTT(601.83,"C",YSOLDNUM,N)) Q:N'>0  D
 . S G1=^YTT(601.83,N,0)
 . S YSISRNEW=$$NEW^YTQLIB(YSFILE)
 . S ^YTT(601.83,YSISRNEW,0)=G1
 . S $P(^YTT(601.83,YSISRNEW,0),U)=YSISRNEW
 . S $P(^YTT(601.83,YSISRNEW,0),U,2)=YSNEWNUM
 . S YSQX=$P(G1,U,3)
 . I (YSQX?1N.N)&($D(^TMP($J,"YSM","O",YSQX))) S $P(^YTT(601.83,YSECNEW,0),U,3)=^TMP($J,"YSM","O",YSQX)
 . S DA=YSISRNEW,DIK="^YTT("_YSFILE_"," D IX^DIK
 . ;add rule
 . S YSRULOLD=$P(G,U,4)
 . S G2=^YTT(601.82,YSRULOLD,0)
 . S YSRULNEW=$$NEW^YTQLIB(601.82)
 . S $P(^YTT(601.83,YSISRNEW,0),U,4)=YSRULNEW
 . S ^YTT(601.82,YSRULNEW,0)=G2
 . S $P(^YTT(601.82,YSRULNEW,0),U)=YSRULNEW
 . S YSQX=$P(G2,U,2)
 . I (YSQX?1N.N)&($D(^TMP($J,"YSM","O",YSQX))) S $P(^YTT(601.82,YSRULNEW,0),U,2)=^TMP($J,"YSM","O",YSQX)
 . S YSQX=$P(G2,U,7)
 . I (YSQX?1N.N)&($D(^TMP($J,"YSM","O",YSQX))) S $P(^YTT(601.82,YSRULNEW,0),U,7)=^TMP($J,"YSM","O",YSQX)
 . S DA=YSRULNEW,DIK="^YTT(601.82," D IX^DIK
 Q
FULLWP(YSDATA,YS) ;first line of all WPS
 ;returns a WP field
 ;Input: FILEN(file number), FIELD (WP filed #)
 ;Ouput IEN^WP Text line N
 N N,YSN,YSN1,YSFILEN,YSFIELD
 S YSDATA=$NA(^TMP($J,"YSWP")) K ^TMP($J,"YSWP")
 S YSFILEN=$G(YS("FILEN"),0) I $$VFILE^DILFD(YSFILEN)<1 S ^TMP($J,"YSWP",1)="[ERROR]",^TMP($J,"YSWP",2)="BAD FILE N" Q  ;--->out
 S YSFIELD=$G(YS("FIELD"),0) S N=$$VFIELD^DILFD(YSFILEN,YSFIELD) I N<1 S ^TMP($J,"YSWP",1)="[ERROR]",^TMP($J,"YSWP",2)="BAD field" Q  ;--> out
 S YSN=0,N=1,^TMP($J,"YSWP",1)="[DATA]"
 F  S YSN=$O(^YTT(YSFILEN,YSN)) Q:YSN'>0  D
 . S YSN1=0 F  S YSN1=$O(^YTT(YSFILEN,YSN,YSFIELD,YSN1)) Q:YSN1'>0  D
 .. S N=N+1
 .. S ^TMP($J,"YSWP",N)=YSN_U_$G(^YTT(YSFILEN,YSN,YSFIELD,YSN1,0))
 Q
FINDP(YSDATA,YS) ; patient lookup
 ; input:
 ;   VALUE = value to lookup
 ;   NUMBER= maximum number to find
 ;     Lookup uses multiple index lookup of File #2
 ; output:
 ;   [DATA]^number of records returned
 ;    DFN^patient name^DOB^PID^Gender
 ;
 N DIERR,YSVALUE,NODE,SSN,DSSN,PLID,YSN,YSX,YSNUMBER
 S YSVALUE=$G(YS("VALUE"))
 S YSNUMBER=$G(YS("NUMBER"),"*")
 K ^TMP("YSDATA",$J) S YSDATA=$NA(^TMP("YSDATA",$J))
 D FIND^DIC(2,,".01;.03;.363;.09;.02","PS",YSVALUE,YSNUMBER,"B^BS^BS5^SSN")
 I $G(DIERR) D CLEAN^DILF Q
 S YSN=1,^TMP("YSDATA",$J,YSN)="[DATA]"_U_+^TMP("DILIST",$J,0)
 S YSX=0 F  S YSX=$O(^TMP("DILIST",$J,YSX)) Q:YSX'>0  D
 . S NODE=^TMP("DILIST",$J,YSX,0)
 . ;Apply DOB screen
 . S $P(NODE,U,3)=$$DOB^DPTLK1(+NODE)
 . ;Apply SSN screen
 . S SSN=$$SSN^DPTLK1(+NODE)
 . ;S DSSN=$E(SSN,1,3)_"-"_$E(SSN,4,5)_"-"_$E(SSN,6,11)
 . S DSSN="xxx-xx-"_$E(SSN,6,11)
 . S PLID=$P(NODE,U,4)
 . I $E(SSN,1,9)'?9N S (DSSN,PLID)=SSN
 . S $P(NODE,U,4)=$S($L(PLID)>5:PLID,1:DSSN)
 . ;Move screened data back into output global
 . S YSN=YSN+1,^TMP("YSDATA",$J,YSN)=$P(NODE,U,1,4)_U_$P(NODE,U,6)
 K ^TMP("DILIST",$J)
 Q
