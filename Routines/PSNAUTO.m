PSNAUTO ;BIR/WRT-Builds temporary file for matches (for new version 2.0 drugs and any unmatched drugs) ; 10/20/98 12:50
 ;;4.0; NATIONAL DRUG FILE;; 30 Oct 98
MESSGE W !,"This option will attempt to automatically match by NDC code, drugs which have",!,"not been"
 W " matched to the National Drug File. These matches must be verified",!,"and merged.",!
STWHN W !!,"AUTOMATIC MATCH by NDC Code process will begin. It will attempt to match",!,"all items that are not presently MATCHED to the National Drug File.",!!
 R "Are you sure you want to continue ?  N// ",ANS:DTIME S:'$T ANS="^" S:ANS']"" ANS="N" G:"^Nn"[$E(ANS) KILL
 I $D(ANS),ANS?.E1C.E K ANS G PSNAUTO
 I $D(ANS),"?"[$E(ANS) D AUTO^PSNHELP1 G PSNAUTO
 I $D(ANS),"NnYy^"'[$E(ANS) G PSNAUTO
 I $D(ANS) D:"Yy"[$E(ANS) ^PSNNDC1 S:$D(XRT0) XRTN=$T(+0) D:$D(XRT0) T1^%ZOSV W:$P(^PS(59.7,1,10),"^",3)=1 !!,"OK, I'm through. Please verify these matches.",! D KILL Q
KILL K PSNB,PSNDA,PSNSTDA,PSNUNDA,PSNDDA,ANS,DIC,II,MJL,JJ,NBR,PSNCLASS,PSNFL,PSNFLB,PSNFNM,PSNFORM,PSNNAM,PSNNAME,PSNNDA,PSNNDC,PSNNDF,PSNSP,PSNVAR,PSNSIZE,PSNTYPE,PSNSZ,PSNTRFL,PSNTYP,PSNPD
 K X,Y,KK,PS,PT,STR,UNT,NDP,DOS,PSNP,PSND,PSNDFM,PSNVC,PSNVCL,STOP,VAR,PSNDEA,PSNENT,PSNF,PSNM Q
