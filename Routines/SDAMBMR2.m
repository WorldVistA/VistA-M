SDAMBMR2 ;ALB/MLI - PRINT AMBULATORY PROCEDURES MANAGEMENT REPORTS ; 4/27/00 12:14pm
 ;;5.3;Scheduling;**28,140,132,180,339,387,402**;Aug 13, 1993
HD S SDPG=SDPG+1 W @IOF,!?20,"AMBULATORY PROCEDURE MANAGEMENT REPORTS",!!,"DATE RANGE: ",SDB,"-",SDE,?50,"DATE PRINTED: ",SDNOW,!,$S(SDFL:SDSTR_" NAME:",1:"ALL "_SDSTR_"S"),?16,SDT,?71,"PAGE: ",$J(SDPG,3) Q
DT S SDB=SDB+.1,SDE=SDE-.9,SDB=$TR($$FMTE^XLFDT(SDB,"5DF")," ","0"),SDE=$TR($$FMTE^XLFDT(SDE,"5DF")," ","0") Q
1 S SDSTR=$S(SDSC="C":"CLINIC",1:"SERVICE") D DT G 2:SDRT="E" I SDSC="C" S I=0 F I1=0:0 S I=$S(VAUTC:$O(^TMP($J,I)),1:$O(VAUTC(I))) Q:I=""!SDFG  I $D(^TMP($J,I,"T")),^("T") S SDT=I,SDFL=1 D P^SDAMBMR3 Q:SDFG
 I SDSC="S" F I="M","N","P","R","S" I SDAS!$D(SDS(I)) I ^TMP($J,I,"T") D SET,P^SDAMBMR3 Q:SDFG
 D TOT Q
2 G 3:SDPN="N" S I=0
 F I1=0:0 D:I'=0 P^SDAMBMR3 Q:SDFG  S I=$O(^TMP($J,"*PRO",I)) Q:I=""!(SDSC="S"&I)!SDFG  D SET,HD2 Q:SDFG  F J=0:0 D:J T S J=$O(^TMP($J,"*PRO",I,J)) Q:J=""  D CD,PN:SDPT=1 D:$Y>(IOSL-5) HD2 Q:SDFG
 D TOT Q
3 S (SDFL,I)=0,SDSTR=$S(SDSC="C":"CLINIC",1:"SERVICE")
 F I1=0:0 D:SDFL P^SDAMBMR3 S SDFL=0,I=$O(^TMP($J,"*PTC",I)) Q:I=""!SDFG  D SET,HD3 Q:SDFG  D CONT
 D TOT Q
CONT S J=0 F J1=0:0 S J=$O(^TMP($J,"*PTC",I,J)) Q:J=""!SDFG  S K=0 F K1=0:0 S K=$O(^TMP($J,"*PTC",I,J,K)) Q:K=""  D C D:$Y>(IOSL-5) HD3 Q:SDFG
 Q
PN S L=0,K="A"
 F K1=0:0 S K=$O(^TMP($J,"*PRO",I,J,K)) Q:K=""!SDFG  F L1=0:0 S L=$O(^TMP($J,"*PRO",I,J,K,L)) Q:L=""!SDFG  F M=0:0 S M=$O(^TMP($J,"*PRO",I,J,K,L,M)) Q:M=""  S SDINFO=^(M) D PNAME D:$Y>(IOSL-5) HD2 Q:SDFG
 Q
 ;
PNAME N %
 F %=1:1:$P(SDINFO,U,4) W !,?8,$E(K,1,18),?28,$P(SDINFO,U,10),?39,"AGE: ",$J($P(SDINFO,U,2),3),?49,$S($P(SDINFO,U)=1:"VETERAN",1:"NON-VET"),?58,$P(SDINFO,U,3),?61 S VADAT("W")=M D ^VADATE W VADATE("E")
 Q
 ;
 ;If prompt "Sort by 'P'rocedure or patient 'N'ame: P//PROCEDURE"
 ;CPTMOD is called to print Procedure (CPT) codes and associated
 ;Modifiers.
CD N BLKLN,MODCODE,MODINFO,MODTEXT,MODVAL,SDJJ,KK,ICPTVDT
 S (BLKLN,MODVAL)=0,SDHI=I D HD2:($Y>(IOSL-5)) Q:SDFG
 S %DT="X",X=SDE D ^%DT S ICPTVDT=$S(Y<0:DT,1:Y)
 S J=$P($$CPT^ICPTCOD(J,ICPTVDT),"^",1)  ; equals IEN for CPT
 S KK=$P($$CPT^ICPTCOD(J,ICPTVDT),"^",2)  ; SD*5.3*339 external CPT value
 W !!,$G(KK)  ; SD*5.3*339 print external CPT code
 S I=J D N W ?7,$E(SDN,1,72) S I=SDHI
 Q:'SDMOD
 I $D(^TMP($J,"*PRO",I,J,0)) S MODVAL=$P(^TMP($J,"*PRO",I,J,0),"^",2,99)
 I $D(^TMP($J,"*PRO",I,J,1)) S MODVAL=$P(^TMP($J,"*PRO",I,J,1),"^",2,99)
 Q:'MODVAL
 F SDJJ=1:1:$L(MODVAL,"^") S MODINFO=$P(MODVAL,"^",SDJJ)  D
 . S MODINFO=$$MOD^ICPTMOD(MODINFO,"I",ICPTVDT,1)
 . Q:MODINFO'>0
 . S MODCODE="-"_$P(MODINFO,"^",2)
 . S MODTEXT=$P(MODINFO,"^",3)
 . W !?2,MODCODE,?8,$E(MODTEXT,1,65)
 . Q
 W !
 Q
HD2 Q:SDFG  I IOST?1"C-".E R !?20,"Enter <RETURN> to continue",SDFG1:DTIME I SDFG1["^"!'$T S SDFG=1 Q
 D HD W !!?25,"SUMMARY OF PROCEDURES PERFORMED",! K Y S $P(Y,"-",81)="" W Y Q
HD3 Q:SDFG  I IOST?1"C-".E R !?20,"Enter <RETURN> to continue",SDFG1:DTIME I SDFG1["^"!'$T S SDFG=1 Q
 D HD W !!?31,"SUMMARY BY PATIENT",!,"NAME",?27,"SSN",?38,"AGE",?43,"VET/NON",?53,"SEX",?60,"DATE/TIME OF STOP",! K Y S $P(Y,"-",81)="" W Y
SET S SDT=$S(SDSC="C":I,I="M":"MEDICINE",I="N":"NEUROLOGY",I="P":"PSYCHIATRY",I="R":"REHAB MEDICINE",I="S":"SURGERY",I="Z":"NONE",1:"UNKNOWN"),SDFL=1 Q
T W !?8,"TOTAL PROCEDURES==>",?30,"VETERAN:",?39,$J($S($D(^TMP($J,"*PRO",I,J,1)):$P(^(1),"^",1),1:0),4),?47,"NON-VETERAN:",$J($S($D(^(0)):$P(^(0),"^",1),1:0),4)
 W ?69,"TOTAL:",?76,$J($S($D(^TMP($J,"*PRO",I,J,0))&$D(^(1)):$P(^(0),"^",1)+$P(^(1),"^",1),'$D(^(0)):$P(^(1),"^",1),1:$P(^(0),"^",1)),4) Q
C F L=-1:0 S L=$O(^TMP($J,"*PTC",I,J,K,L)) Q:L=""  F M=0:0 S M=$O(^TMP($J,"*PTC",I,J,K,L,M)) Q:M=""  M SDINFO=^(M) D C2
 Q
C2 W !!,$E(J,1,24),?27,$P(SDINFO,U,10) ; 10th piece is ssn
 W ?38,$P(SDINFO,U),?43,$S(L=1:"VETERAN",1:"NON-VET"),?52,$S($P(SDINFO,U,2)="M":" MALE",1:"FEMALE"),?60 S VADAT("W")=M D ^VADATE W VADATE("E") D LIST
 Q
 ;
 ;If "Sort by 'P'rocedure or patient 'N'ame: P//NAME" the patient name
 ;,Procedure (CPT) Codes and Modifiers will be printed.
LIST N BLKLN,MODCODE,MODINFO,MODTEXT,MODVAL,SDJJ,ICPTVDT
 S %DT="X",X=SDE D ^%DT S ICPTVDT=$S(Y<0:DT,1:Y)
 S BLKLN=1
 F PR=11:1 S SDPRO=$P(SDINFO,U,PR) Q:'SDPRO  D
 . S SDHI=I D HD:($Y>(IOSL)) Q:SDFG
 . W !?5,$P($$CPT^ICPTCOD(SDPRO,ICPTVDT),U,2) S I=SDPRO D N  ; SD*5.3*402
 . W ?12,$E(SDN,1,67) S I=SDHI
 . Q:'SDMOD
 . S MODVAL=SDINFO(PR-10)
 . F SDJJ=1:1:$L(MODVAL,"^") S MODINFO=$P(MODVAL,"^",SDJJ)  D
 . . S MODINFO=$$MOD^ICPTMOD(MODINFO,"I",ICPTVDT,1)
 . . Q:MODINFO'>0
 . . S MODCODE="-"_$P(MODINFO,"^",2)
 . . S MODTEXT=$P(MODINFO,"^",3)
 . . W !?7,MODCODE,?13,$E(MODTEXT,1,65)
 . . Q
 . W !
 . Q
 Q
TOT Q:SDFG  K I S SDT="",SDFL=0 D P^SDAMBMR3 Q
 ;
 ;Retrieves the Procedure (CPT) Code description by calling API
 ;CPTD^ICPTCOD
N N DATA,SDIX,SDDATA,SDCOUNT,ICPTVDT
 S %DT="X",X=SDE D ^%DT S ICPTVDT=$S(Y<0:DT,1:Y)
 S SDN="",DATA=""
 ;F  S DATA=$O(DESCR(DATA)) Q:'DATA  S SDN=SDN_" "_DESCR(DATA) Q:$L(SDN)>72
 ;SDDATA will contain the returned information from the call to CPTD^ICPTCOD.
 ;This is an extrinsic function, and can't be called with a "Do" statement.
 S SDDATA=$$CPTD^ICPTCOD(I,"DESCR",,ICPTVDT)
 S SDCOUNT=$P(SDDATA,"^",1)
 F SDIX=1:1:SDCOUNT S SDN=SDN_" "_DESCR(SDIX) Q:$L(SDN)>72
 S SDN=$E(SDN,1,72)
 Q
