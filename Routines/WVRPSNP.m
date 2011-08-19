WVRPSNP ;HCIOFO/FT,JR-REPORT: SNAPSHOT OF PROGRAM  ;10/14/99  14:02
 ;;1.0;WOMEN'S HEALTH;**7,8**;Sep 30, 1998
 ;;  Original routine created by IHS/ANMC/MWR
 ;;* MICHAEL REMILLARD, DDS * ALASKA NATIVE MEDICAL CENTER *
 ;;  CALLED BY OPTION: "WV PRINT SNAPSHOT" TO DISPLAY FROM 1/1 CURRENT
 ;;  YEAR TO PRESENT #PATIENTS, #PAPS, #MAMS, #DELINQUENT NEEDS, ETC.
 ;
 D SETVARS^WVUTL5 S WVFAC=DUZ(2) K ^TMP("WVF",$J)
 N A,B,C,D,E,F,G,H,I,J,K,L,M,N,P,Q,R,S,X,Y,WA,WB,WC,WE,WF,WG,WH,WX,N0
 N WVBRTXND,WVCXTXND
 D TITLE^WVUTL5("PROGRAM SNAPSHOT")
 D ASKTOY G:WVPOP EXIT
 D ASKSAVE G:WVPOP EXIT
 D DEVICE  G:WVPOP EXIT
 D GATHER
 D:WVA STORE
 K WVDTIEN
 D ^WVRPSNP1
 ;
EXIT ;EP
 D KILLALL^WVUTL8
 K ^TMP("WVF",$J)
 Q
 ;
ASKTOY ;
 S WVTOY="" S DIR("A")="   Report by (C)alendar or (F)iscal year? "
 S DIR(0)="SAO^C:Calendar Year;F:Fiscal Year",DIR("B")="Fiscal"
 D ^DIR
 I "FC"'[Y S WVPOP=1 Q
 S WVTOY=Y
 S WVJDT=$E(DT,1,3)_"0000"
 I WVTOY="C" Q
 I $E(DT,4,5)<10 S WVJDT=$E(DT-10000,1,3)_"1000" Q
 S WVJDT=$E(DT,1,3)_"1000"
 Q
DEVICE ;EP
 ;---> GET DEVICE AND POSSIBLY QUEUE TO TASKMAN.
 S ZTRTN="DEQUEUE^WVRPSNP"
 F WVSV="A","FAC","TOY","JDT" D
 .I $D(@("WV"_WVSV)) S ZTSAVE("WV"_WVSV)=""
 D ZIS^WVUTL2(.WVPOP,1,"HOME")
 Q
 ;
ASKSAVE ;EP
 ;---> ASK IF THIS REPORT SHOULD BE SAVED FOR LATER RETRIEVAL.
 N DIR,DIRUT,Y
 W !!?3,"Should today's Snapshot be stored for later retrieval and"
 W " comparisons?"
 S DIR(0)="Y",DIR("A")="   Enter Yes or No",DIR("B")="NO"
 S WVA=0 D HELP1
 D ^DIR K DIR W !
 S:$D(DIRUT) WVPOP=1
 S:Y WVA=1
 Q
 ;
DEQUEUE ;EP
 ;---> QUEUED REPORT
 N A,B,C,D,E,F,G,H,J,K,L,M,N,P,Q,R,S,X,Y
 D SETVARS^WVUTL5,GATHER,STORE,^WVRPSNP1,EXIT
 Q
 ;
STORE ;EP
 ;---> STORE REPORT DATA IN FILE #790.71.
 Q:'WVA
 N WVDR,DA,DIC,DIE,X,Y
 S WVDR=".02////"_WVFAC,Y=.02
 F WVI=A,B,C,D,E,F,G,H,S,J,K,L,P,Q,R D
 .S Y=Y+.01,WVDR=WVDR_";"_Y_"////"_WVI
 S Y=.5,WVJDR=".5////"_WVI(1)
 F WVJ=2:1:30 S Y=Y+.01 S WVJDR=WVJDR_";"_Y_"////"_WVI(WVJ)
 S WVDR=WVDR_";.18////"_WVTOY
 N A,B,C,D,E,F,G,H,S,J,K,L,P,Q,R D
 .S A=0,WVJNDA="" F  S A=$O(^WV(790.71,"B",DT,A)) Q:A'>0  D  Q:WVJNDA>0
 ..S:$D(^WV(790.71,"T",WVTOY,A)) WVJNDA=A
 .I WVJNDA'>0 D 
 ..K DD,DO S DIC="^WV(790.71,",DIC(0)="ML",X=DT
 ..D FILE^DICN Q:Y<0  S WVJNDA=+Y
 .S Y=$G(WVJNDA) Q:Y'>0
 .D DIE^WVFMAN(790.71,WVDR,WVJNDA)
 .D DIE^WVFMAN(790.71,WVJDR,WVJNDA)
 Q
 ;
 ;
GATHER ;EP
 ;---> GATHER DATA
 S (A,B,C,D,E,F,G,H,J,K,L,M,N,P,Q,R,S)=0
 ;---> USE WVDT SO THAT THE DATE WON'T CHANGE IF RUN SPANS MIDNIGHT.
 D SETVARS^WVUTL5 S WVDT=DT
 S WVBRTXND=$$IEN^WVUTL9(790.51,"Not Indicated")
 S WVCXTXND=$$IEN^WVUTL9(790.5,"Not Indicated")
 ;
 ;---> PATIENT DATA
 F  S N=$O(^WV(790,N)) Q:'N  S Y=^WV(790,N,0) D
 .;---> QUIT IF PATIENT IS NOT ACTIVE.
 .Q:$P(Y,U,24)
 .;---> QUIT IF PATIENT IS DECEASED.
 .Q:$$DECEASED^WVUTL1($P(Y,U))
 .;---> TOTAL ACTIVE WOMEN IN REGISTER.
 .S A=A+1
 .;---> WOMEN PREGNANT.
 .I $P(Y,U,13)&($P(Y,U,14)>WVDT) S B=B+1
 .;---> DES DAUGHTERS.
 .S:$P(Y,U,15) C=C+1
 .;---> WOMEN WITH CERVICAL TX NEEDS NOT SPECIFIED OR NOT DATED.
 .;     Don't count if need is "Not Indicated"
 .I ($P(Y,U,11)'=WVCXTXND) I 5[$P(Y,U,11)!('$P(Y,U,12)) S D=D+1
 .;---> IF DATE DUE=NULL IT WAS COUNTED LINE ABOVE, SO DON'T COUNT
 .;---> IT IN THE LINE BELOW: +$P(Y,U,19).
 .;---> WOMEN WITH CERVICAL TX NEEDS SPECIFIED AND PAST DUE.
 .I ($P(Y,U,11)'=WVCXTXND) I 5'[$P(Y,U,11)&($P(Y,U,12)<WVDT)&(+$P(Y,U,12)) S E=E+1
 .;---> WOMEN WITH BREAST TX NEEDS NOT SPECIFIED OR NOT DATED.
 .;     Don't count if need is "Not Indicated"
 .I ($P(Y,U,18)'=WVBRTXND) I 8[$P(Y,U,18)!('$P(Y,U,19)) S F=F+1
 .;---> WOMEN WITH BREAST TX NEEDS SPECIFIED AND PAST DUE.
 .I ($P(Y,U,18)'=WVBRTXND) I 8'[$P(Y,U,18)&($P(Y,U,19)<WVDT)&(+$P(Y,U,19)) S G=G+1
 ;
 ;---> PROCEDURE DATA
 S N=0
 F  S N=$O(^WV(790.1,"S","o",N)) Q:'N  S Y=^WV(790.1,N,0) D
 .Q:"o"'[$P(Y,U,14)
 .Q:$P(Y,U,5)=8
 .S H=H+1 S:$P(Y,U,13)<WVDT S=S+1
 ;
 ;---> TOTAL PAPS, CBES, AND MAMS FOR THIS YEAR (SINCE JAN 1, OR FISCAL).
 S N=WVJDT,WVENDDT1=WVDT+.9999
 F  S N=$O(^WV(790.1,"D",N)) Q:'N!(N>WVENDDT1)  D
 .S M=0
 .F  S M=$O(^WV(790.1,"D",N,M)) Q:'M  S Y=^WV(790.1,M,0) D
 ..;---> BELOW IS HARD CODED FOR IENS IN ^WV(790.2, (PAP, CBE, OR MAM) AND
 ..;---> ^WV(790.31, (ERROR/DISREGARD).  COULD BE MORE ROBUST BY LOOKING
 ..;---> AT #.10 FIELD OF ^WV(790.2 AND #.23 FIELD OF ^WV(790.31,.
 ..Q:$P(Y,U,5)=8
 ..I $P(Y,U,4)=1 S P=P+1 Q                                    ;---> PAP
 ..I $P(Y,U,4)=25!($P(Y,U,4)=26)!($P(Y,U,4)=28) S Q=Q+1 Q     ;---> MAM
 ..I $P(Y,U,4)=27 S R=R+1                                     ;---> CBE
 ;
 ;---> NOTIFICATION DATA
 S N=0
 F  S N=$O(^WV(790.4,"AOPEN",N)) Q:'N  D
 .S M=0
 .F  S M=$O(^WV(790.4,"AOPEN",N,M)) Q:'M  D
 ..I '$D(^WV(790.4,M,0)) K ^WV(790.4,"AOPEN",N,M) Q
 ..S Y=^WV(790.4,M,0)
 ..S:$P(Y,U,14)="o" J=J+1
 ..S:$P(Y,U,14)="o"&($P(Y,U,13)<WVDT) K=K+1
 ;---> LETTERS QUEUED
 S N=0 F  S N=$O(^WV(790.4,"APRT",N)) Q:'N  D
 .S M=0 F  S M=$O(^WV(790.4,"APRT",N,M)) Q:'M  S L=L+1
R ;---> TREATMENT REFUSALS
 N WVREFPCE
 ;piece # and its value form a link for refusal counts
 ; (e.g., piece 1 has a value of 24). Entry #1 in File 790.2 is Pap Smear
 ; and the # of refused Pap Smears is stored in piece 24 (of node 2) 
 ; in File 790.71.
 S WVREFPCE="24^4^13^6^^^7^9^^^^^^^^^16^8^5^25^26^14^15^12^18^19^2^20^11^22^23^17^21^10^27^^3^1^28^29^30"
 F WA=1:1:41 D
 .S WB=$P(WVREFPCE,U,WA)
 .Q:'WB
 .S WVI(WB)=0
 S WA=WVJDT F  S WA=$O(^WV(790.3,"B",WA)) Q:WA'>0  D
 .S WB=0 F  S WB=$O(^WV(790.3,"B",WA,WB)) Q:WB'>0  D
 ..S N0=$G(^WV(790.3,WB,0))
 ..N P1 F P1=1,2,3,4 S P1(P1)=$P(N0,U,P1) S:P1(P1)="" P1(P1)="NOT ENTERED"
 ..Q:'P1(3)
 ..S WVCN=+$P(WVREFPCE,U,+P1(3)) Q:'WVCN
 ..S WVI(WVCN)=WVI(WVCN)+1
 Q
 ;
 ;
HELP1 ;EP
 ;;Answer "YES" to store the results of today's snapshot after they
 ;;have been printed out.  These results can then be retrieved in the
 ;;future (by calling up today's date) and compared to other Snapshots
 ;;in order to look at the trends and progress of your program over
 ;;time. (Note: If a previous snapshot for today has been run, it will
 ;;be overwritten by this or any later run today.)
 ;;
 ;;Answer "NO" to simply print today's Snapshot without storing it.
 S WVTAB=5,WVLINL="HELP1" D HELPTX
 Q
 ;
HELPTX ;EP
 N I,T,X S T=$$REPEAT^XLFSTR(" ",WVTAB)
 F I=1:1 S X=$T(@WVLINL+I) Q:X'[";;"  S DIR("?",I)=T_$P(X,";;",2)
 S DIR("?")=DIR("?",I-1) K DIR("?",I-1)
 Q
