RASTEXT1 ;HISC/CAH,FPT,GJC AISC/TMP,TAC-Selection of patient for status tracking ;9/4/97  15:10
 ;;5.0;Radiology/Nuclear Medicine;;Mar 16, 1998
SELECT ;
 S RACONTIN=0 ;ft
 I RADTI,(($O(^TMP($J,"RASTEXT",RADTI))>0)!($O(^TMP($J,"RASTEXT",RADTI,I1))>0)) S RACONTIN=1
 W !!,"Enter " W:RAED "Case #, " W "Status, (N)ext status" W:RACONTIN ", (C)ontinue"
 W ", '^' to Stop: "_$S(RACONTIN=1:"CONTINUE",1:"NEXT")_"// " R RAX:DTIME I '$T S RAQ=1 Q
 G:RAX["?" HELP S:RAX="^" RAQ=1 Q:RAQ
 I RAX="" S RAX=$S(RACONTIN=1:"C",1:"N")
 G NEXT:"Nn"[$E(RAX)
 G:RAX?1N.E&(RAED) CASE
 S RAX=$$UP^XLFSTR(RAX)
 I RAX=$E("CONTINUE",1,$L(RAX)) S RAX="C"
 G:RAX?1A.E SEL1
HELP W:RAX'["?" *7
 W !!,"Enter " W:RAED "a case number  OR",!,"Multiple case #'s separated by commas  OR",! W "The name of another status  OR",!,"'N' to get the screen containing the next status"
 W:RADTI "  OR",!,"'C' to continue with the next screen of patients for this status"
 G SELECT
 ;
SEL1 I "Cc"[RAX,RADTI,($O(^TMP($J,"RASTEXT",RADTI))>0!($O(^(RADTI,I1))>0)) Q
 I "Cc"[RAX,'RADTI G HELP
 S DIC="^RA(72,",DIC(0)="EQZF",X=RAX
 S DIC("S")="S RAZ=^(0) I $P(RAZ,U,3)>0,(+$P(RAZ,U,7)=+$O(^RA(79.2,""B"",RAIMGTY,0))),($P(RAZ,U,3)'>8),($P(RAZ,U,5)=""Y"")"
 D ^DIC K DIC("S"),RAZ I Y'>0 W !,"Status ",RAX," not selected." G SELECT
 I $P(Y(0),"^",3)>0,$D(^RADPT("AS",+Y)) K ^TMP($J,"RASTEXT") S RASTAT=+Y,RAORD=$P(Y(0),"^",3) D START^RASTEXT S (RADTI,RACTR)=0 Q
 W *7,!,"No data exists for status ",$P(Y(0),"^") G SELECT
 ;
CASE S X=RAX D ^RASTED Q:RAXIT  K ^TMP($J,"RASTEXT") D START^RASTEXT S (RADFN,RACTR,RADTI)=0 Q
 ;
NEXT I $O(RASEQARR(RAORD))=""!($O(RASEQARR(RAORD))>8) W *7,!,"Last status - Do you want to start over? YES// " R RAX:DTIME S:'$T RAQ=1 S RAX=$E(RAX) D  Q:RAQ  G:'$D(RAX) NEXT S RAORD=""
 .I RAX="?" W !!,"Answer YES or NO",! K RAX Q
 .S:"Yy"'[RAX!(RAX="^") RAQ=1
 K ^TMP($J,"RASTEXT") D NXTSTAT,START^RASTEXT G NEXT:'RACTR S (RACTR,RADTI)=0
 Q
 ;
NXTSTAT ;get next status
 S RAORD=$O(RASEQARR(RAORD)),RASTAT=RASEQARR(RAORD) I $D(^RA(72,+RASTAT,0)),$P(^(0),"^",5)'="Y" Q:'RAORD!(RAORD>8)  G NXTSTAT
 Q
