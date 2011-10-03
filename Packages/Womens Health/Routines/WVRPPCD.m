WVRPPCD ;HCIOFO/FT,JR-REPORT: PROCEDURES STATISTICS; ;7/23/01  13:33
 ;;1.0;WOMEN'S HEALTH;**12**;Sep 30, 1998
 ;;  Original routine created by IHS/ANMC/MWR
 ;;* MICHAEL REMILLARD, DDS * ALASKA NATIVE MEDICAL CENTER *
 ;;  CALLED BY OPTION: "WV PRINT PROCEDURE STATS".
 ;
 ; This routine uses the following IAs:
 ; <NONE>
 ;
 N N,R,X,T,Y,R,PG,PA,JC,J,TR,TR2,JR,JR2,CM,CM2,WVJRC,FE,FI,WVSB
 K ^TMP("WVRES",$J),^TMP("WVAR",$J),^TMP("WVNOHCF",$J)
 S WVPOP=0 K WVRES
 D TITLE^WVUTL5("PROCEDURE STATISTICS REPORT")
 D DATES                  G:WVPOP EXIT
 D SELECT                 G:WVPOP EXIT
 D BYAGE(.WVAGRG,.WVPOP)  G:WVPOP EXIT
 D FAC                    G:WVPOP EXIT
 D DEVICE                 G:WVPOP EXIT
 D ^WVRPPCD2
 D COPYGBL
 D ^WVRPPCD1
 ;
EXIT ;EP
 K ^TMP("WVRES",$J),^TMP("WVAR",$J),^TMP("WVNOHCF",$J)
 D KILLALL^WVUTL8
 Q
 ;
DATES ;EP
 ;---> ASK DATE RANGE.  RETURN DATES IN WVBEGDT AND WVENDDT.
 D ASKDATES^WVUTL3(.WVBEGDT,.WVENDDT,.WVPOP,"T-365","T")
 Q
 ;
SELECT ;EP
 D SELECT^WVSELECT("Procedure Type",790.2,"WVARR","","",.WVPOP)
 Q
 ;
BYAGE(WVAGRG,WVPOP) ;EP
 ;---> RETURN AGE RANGE IN WVAGRG.
 N DIR,DIRUT,Y S WVPOP=0
 W !!?3,"Do you wish to display statistics by age group?"
 S DIR(0)="Y",DIR("B")="YES" D HELP1
 S DIR("A")="   Enter Yes or No"
 D ^DIR K DIR W !
 S:$D(DIRUT) WVPOP=1
 ;---> IF NOT DISPLAYING BY AGE GROUP, SET WVAGRG (AGE RANGE)=1, QUIT.
 I 'Y S WVAGRG=1 Q
BYAGE1 ;
 W !?5,"Enter the age ranges you wish to select for in the form of:"
 W !?5,"  15-29,30-39,40-105"
 W !?5,"Use a dash ""-"" to separate the limits of a range,"
 W !?5,"use a comma to separate the different ranges."
 W !!?5,"NOTE: Patient ages will reflect the age they were on the"
 W !?5,"      dates of their procedures.  Patient ages will NOT"
 W !?5,"      necessarily be their ages today.",!
 K DIR D HELP2
 S DIR(0)="FOA",DIR("A")="     Enter age ranges: "
 S:$D(^WV(790.72,DUZ,0)) DIR("B")=$P(^(0),U,2)
 D ^DIR K DIR
 I $D(DIRUT) S WVPOP=1 Q
 D CHECK(.Y)
 I Y="" D  G BYAGE1
 .W !!?5,"* INVALID AGE RANGE.  Please begin again. (Enter ? for help.)"
 ;---> WVAGRG=SELECTED AGE RANGE(S).
 S WVAGRG=Y
 D DIC^WVFMAN(790.72,"L",.Y,"","","","`"_DUZ)
 Q:Y<0
 D DIE^WVFMAN(790.72,".02////"_WVAGRG,+Y,.WVPOP,1)
 Q
 ;
FAC ; Select one or more facilities
 D SELECT^WVSELECT("Facility",790.02,"WVSB","",DUZ(2),.WVPOP)
 Q
DEVICE ;EP
 ;---> GET DEVICE AND POSSIBLY QUEUE TO TASKMAN.
 S ZTDESC="Procedure Statistics Report"
 S ZTRTN="DEQUEUE^WVRPPCD"
 F WVSV="AGRG","BEGDT","ENDDT" D
 .I $D(@("WV"_WVSV)) S ZTSAVE("WV"_WVSV)=""
 ;---> SAVE PROCEDURES ARRAY.
 I $D(WVARR) N N S N=0 F  S N=$O(WVARR(N)) Q:N=""  D
 .S ZTSAVE("WVARR("""_N_""")")=""
 ; Save Facility array
 I $D(WVSB) N N S N=0 F  S N=$O(WVSB(N)) Q:N=""  D
 .S ZTSAVE("WVSB("""_N_""")")=""
 .Q
 D ZIS^WVUTL2(.WVPOP,1)
 Q
 ;
COPYGBL ;EP
 ;---> COPY ^TMP("WVRES",$J,"R") TO ^TMP("WVAR",$J, TO MAKE IT FLAT.
 N FE,FI,I,M,N K WVAR
 S I=0,FE=""
 F  S FE=$O(^TMP("WVRES",$J,"R",FE)) Q:FE=""  S FI=0 F  S FI=$O(^TMP("WVRES",$J,"R",FE,FI)) Q:'FI  S N=0 F  S N=$O(^TMP("WVRES",$J,"R",FE,FI,N)) Q:N=""  D
 .S M=0
 .F  S M=$O(^TMP("WVRES",$J,"R",FE,FI,N,M)) Q:M=""  D
 ..S I=I+1,^TMP("WVAR",$J,FE,FI,I)=^TMP("WVRES",$J,"R",FE,FI,N,M)
 Q
 ;
DEQUEUE ;EP
 ;---> TASKMAN QUEUE OF PRINTOUT.
 D SETVARS^WVUTL5,^WVRPPCD2
 I $G(ZTSTOP)=1 D EXIT Q  ;user requested the job to stop
 D COPYGBL,^WVRPPCD1,EXIT
 Q
 ;
HELP1 ;EP
 ;;Answer "YES" to display statistics by age group.  If you choose
 ;;to display by age group, you will be given the opportunity to
 ;;select the age ranges.  For example, you might choose to display
 ;;from ages 15-40,41-65,65-99.
 ;;Answer "NO" to display statistics without grouping by age.
 S WVTAB=5,WVLINL="HELP1" D HELPTX
 Q
 ;
HELP2 ;EP
 ;;Enter each age range you wish to report on by entering the
 ;;earlier age-dash-older age.  For example, 20-29 would report
 ;;on all patients between the ages of 20 and 29 inclusive.
 ;;You may select as many age ranges as you wish.  Age ranges must
 ;;be separated by commas.  For example: 15-19,20-29,30-39
 ;;To select only one age, simply enter that age, with no dashes,
 ;;for example, 30 would report only on women who were 30 years
 ;;of age.
 S WVTAB=5,WVLINL="HELP2" D HELPTX
 Q
 ;
HELPTX ;EP
 ;---> CREATES DIR ARRAY FOR DIR.  REQUIRED VARIABLES: WVTAB,WVLINL.
 N I,T,X S T=$$REPEAT^XLFSTR(" ",WVTAB)
 F I=1:1 S X=$T(@WVLINL+I) Q:X'[";;"  S DIR("?",I)=T_$P(X,";;",2)
 S DIR("?")=DIR("?",I-1) K DIR("?",I-1)
 Q
 ;
CHECK(X) ;EP
 ;---> CHECK SYNTAX OF AGE RANGE STRING.
 ;---> IF X=ONE AGE ONLY, SET IT IN THE FORM X-X AND QUIT.
 I X?1N.N S X=X_"-"_X Q
 ;
 N WV1,FAIL,I,Y,Y1,Y2
 S FAIL=0
 ;---> CHECK EACH RANGE.
 F I=1:1:$L(X,",") S Y=$P(X,",",I) D  Q:FAIL
 .S Y1=$P(Y,"-"),Y2=$P(Y,"-",2)
 .;---> EACH END OF EACH RANGE SHOULD BE A NUMBER.
 .I (Y1'?1N.N)!(Y2'?1N.N) S FAIL=1 Q
 .;---> THE LOWER NUMBER SHOULD BE FIRST.
 .I Y2<Y1 S FAIL=1
 I FAIL S X="" Q
 ;
 ;---> MAKE SURE ORDER IS FROM LOWEST (YOUNGEST) TO HIGHEST (OLDEST).
 F I=1:1:$L(X,",") S Y=$P(X,",",I),Y1=$P(Y,"-"),WV1(Y1)=Y
 S N=0,X=""
 F  S N=$O(WV1(N)) Q:'N  S X=X_WV1(N)_","
 S:$E(X,$L(X))="," X=$E(X,1,($L(X)-1))
 Q
