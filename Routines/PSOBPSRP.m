PSOBPSRP ;BHM/LE - Ignored Rejects Report ;03/01/07
 ;;7.0;OUTPATIENT PHARMACY;**260,345,352**;13 Feb 97;Build 5
 ;
EN N PSOSD,PSOED,PSOST,PSOSRT,PSOAPT,PSODRUG,PSODIV,PSODRG,PSOST,PSOOC,PSOU,PSOUSER,PSOAPT,PSOIBP,Y
 N OK,X,C,%DT,PSOSIT
 ;
DIV ; - Ask for Division 
 D SEL^PSOREJU1("DIVISION","^PS(59,",.PSODIV,$$GET1^DIQ(59,+$G(PSOSITE),.01)) Q:$G(PSODIV)="^"
 I $G(PSODIV)="ALL" S PSOSIT=1 K PSODIV
 ;
BEGD ; - Ask for FROM DATE DOCUMENTED
 S %DT(0)=-DT,%DT="AEP",%DT("A")="BEGIN REJECT DATE: "
 W ! D ^%DT I Y<0!($D(DTOUT)) G END
 S PSOSD=Y\1-.00001
 ;
ENDT ; - Ask for TO DATE DOCUMENTED
 S %DT(0)=PSOSD+1\1,%DT("A")="END REJECT DATE: "
 W ! D ^%DT I Y<0!($D(DTOUT)) G END
 S PSOED=Y\1+.99999
 ;
SORT ; - Ask for SORT BY
 K DIR S DIR("B")="PATIENT" D HL1("A")
SORT1 S PSOSRT="",(PSOAPT)=1,(PSOST,PSOOC)="B"
 S DIR("A")="SORT BY",DIR(0)="FO" D HL1("?")
 W ! D ^DIR K DIR I $D(DIRUT) G END
 ;
 S OK=1,C=15 W !
 F PSOIBP=1:1:$L(Y,",") D  ;352 CHANGED ALL VARIABLES OF 'I' TO PSOIBP
 . S X=$P(Y,",",PSOIBP) S:X'?.N X=$$TRNS(X) I PSOSRT[X Q
 . W !?(C-10),$S(PSOIBP=1:"SORT BY ",1:"THEN BY ") S C=C+5
 . I X<1!(X>3) W X,"???",$C(7) S OK=0 Q
 . W $P("PATIENT^DRUG^USER","^",X)
 . S PSOSRT=PSOSRT_","_X
 I 'OK S DIR("B")=Y G SORT1
 S $E(PSOSRT)=""
 ;
 S OK=1
 F PSOIBP=1:1:$L(PSOSRT,",") D  I 'OK Q
 . S X=$P(PSOSRT,",",PSOIBP) D @("SRT"_X)
 I 'OK S DIR("B")="PATIENT" G SORT1
 ;
DEV W ! K %ZIS,IOP,POP,ZTSK S %ZIS="QM" D ^%ZIS K %ZIS I POP G END
 ;If user didn't select a particular sort, assume all values for that sort
 S:'$G(PSOAPT)&('$D(PSOPT)) PSOAPT=1
 S:'$G(PSODRUG)&('$D(PSODRG)) PSODRUG=1
 S:'$G(PSOUSER)&('$D(PSOU)) PSOUSER=1
 ;
 I $D(IO("Q")) D  G END
 . N G K IO("Q"),ZTIO,ZTSAVE,ZTDTH,ZTSK
 . S ZTRTN="EN^PSOBPSR1",ZTDESC="Ignored Rejects Report"
 . F G="PSOSD","PSOED","PSOSRT","PSOPT","PSODRG" S:$D(@G) ZTSAVE(G)=""
 . F G="PSOST","PSOOC","PSOAPT","PSODRUG","PSOUSER","PSOSIT" S:$D(@G) ZTSAVE(G)=""
 . S:$D(PSOPT) ZTSAVE("PSOPT(")="" S:$D(PSODRG) ZTSAVE("PSODRG(")=""
 . S:$D(PSOU) ZTSAVE("PSOU(")="" S:$D(PSODIV) ZTSAVE("PSODIV(")=""
 . D ^%ZTLOAD W:$D(ZTSK) !,"Report is Queued to print!" K ZTSK
 ;
 G EN^PSOBPSR1
 ;
END Q
 ;
HL1(S) ; - Help for the SORT BY prompt
 S DIR(S,1)="    Enter the SORT field(s) for this Report:"
 S DIR(S,2)=" "
 S DIR(S,3)="       1 - PATIENT"
 S DIR(S,4)="       2 - DRUG"
 S DIR(S,5)="       3 - USER"
 S DIR(S,6)=" "
 S DIR(S,7)="    Or any combination of the above, separated by comma,"
 S DIR(S,8)="    as in these examples:"
 S DIR(S,9)=" "
 S DIR(S,10)="       2,1  - BY PATIENT, THEN DRUG"
 S DIR(S,11)="      3,1,2 - BY USER, THEN BY PATIENT, THEN BY DRUG"
 S DIR(S,12)=" "
 S DIR(S)=" "
 Q
 ;
SRT1 ; - Selection of PATIENTS to print on the Report
 N PSOIBP K PSOPT S PSOAPT=0 ;345 ADDED N PSOIBP
 D SEL^PSOREJU1("PATIENT","^DPT(",.PSOPT)  I $G(PSOPT)="^" S OK=0 Q
 I $G(PSOPT)="ALL" S PSOAPT=1 K PSOPT
 Q
 ;
SRT2 ; - Selection of Drugs to print on the Report
 N PSOIBP K PSODRG S PSODRUG=0  ;345 ADDED N PSOIBP
 D SEL^PSOREJU1("DRUG","^PSDRUG(",.PSODRG)  I $G(PSODRG)="^" S OK=0 Q
 I $G(PSODRG)="ALL" S PSODRUG=1 K PSODRG
 Q
 ;
SRT3 ; - Selection of Users to print on the Report
 N PSOIBP K PSOU S PSOUSER=0 ;345 ADDED N PSOIBP
 D SEL^PSOREJU1("USER","^VA(200,",.PSOU)  I $G(PSOU)="^" S OK=0 Q
 I $G(PSOU)="ALL" S PSOUSER=1 K PSOU
 Q
 ;
TRNS(X) ; - Translates Alpha into the corresponding Sorting Code
 N L,UPX S L=$L(X),UPX=$$UP^XLFSTR(X)
 I $E("PATIENT",1,L)=UPX Q 1
 I $E("DRUG",1,L)=UPX Q 2
 I $E("USER",1,L)=UPX Q 3
 Q X
 ;
