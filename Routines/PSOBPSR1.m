PSOBPSR1 ;BHM/LE - continued Ignored Claims Report ;03/01/07
 ;;7.0;OUTPATIENT PHARMACY;**260**;13 Feb 97;Build 84
 ;External reference to File ^PS(55 supported by DBIA 2228
 ;External reference to $$GET1^DIQ is supported by DBIA 2056
 ;External reference to ^VADPT is supported by DBIA 10061
 ;External reference to ^XLFDT is supported by DBIA 10103
 ;External reference to ^%ZISC is supported by DBIA 10089
 ;
EN N CLOSE,CDATE,DFN,DRG,RXIEN,PAG,PCNT,PRTD,PNAM,I,II,J,Y,X,XX,S1,S2,S3,S4,S5,FCNT,CBYI
 N SP1,SP2,SEQ2,CINFO,RDATE,RSEQ,PSORX,RXINFO,DNAMI,CDIV,CDIVN,OCDIV,RXNUMB,PSORXN,RXE
 U IO K ^TMP("PSOBPSRP",$J),^TMP("PSOBPSRC",$J)
 S (SP1,SP2)="",$P(SP1,"=",81)="",$P(SP2,"-",81)=""
 ;
 ; - Loop through reject dates xref
 S (RXIEN,PCNT,FCNT,PRTD)=0 K DIRUT
 S RDATE=PSOSD
 ;
DATE ;
 S RDATE=$O(^PSRX("REJDAT",RDATE)) G NEXT:RDATE=""!(RDATE>PSOED)
RX ;
 S RXIEN=$O(^PSRX("REJDAT",RDATE,RXIEN)) G DATE:RXIEN=""
 S (DFN,DRG,PNAM,DNAM,DNAMI,RXE)=""
 K RXINFO D GETS^DIQ(52,RXIEN_",",".01;2;6","IE","RXINFO")
 S PNAM=$G(RXINFO(52,RXIEN_",",2,"E")),DNAM=$G(RXINFO(52,RXIEN_",",6,"E"))
 S DFN=$G(RXINFO(52,RXIEN_",",2,"I")),DNAMI=$G(RXINFO(52,RXIEN_",",6,"I"))
 S RXE=$G(RXINFO(52,RXIEN_",",.01,"E"))_" "
 I '$G(PSOAPT),'$D(PSOPT(DFN)) G RX   ;user selected specific patients
 I '$G(PSODRUG),'$D(PSODRG(DNAMI)) G RX
 ;
 ;look for ignored rejects 
 S SEQ2=0 F  S SEQ2=$O(^PSRX(RXIEN,"REJ",SEQ2)) Q:'SEQ2&(SEQ2'?1N.N)  D
 . S (CDATE,CBY,CBYI,CFILL,CDIV)=""
 . K CLOSE D GETS^DIQ(52.25,SEQ2_","_RXIEN_",","5;10;11;12","IE","CLOSE")
 . S CDATE=$G(CLOSE(52.25,SEQ2_","_RXIEN_",",10,"I"))
 . S CFILL=$G(CLOSE(52.25,SEQ2_","_RXIEN_",",5,"I"))
 . S CDIV=$$RXSITE^PSOBPSUT(RXIEN,CFILL)
 . I '$G(PSOSIT)&'$D(PSODIV(CDIV)) Q
 . I $G(CLOSE(52.25,SEQ2_","_RXIEN_",",12,"I"))=6,(CDATE'<PSOSD&(CDATE'>PSOED)) D
 . . S CBY=$G(CLOSE(52.25,SEQ2_","_RXIEN_",",11,"E"))
 . . S CBYI=$G(CLOSE(52.25,SEQ2_","_RXIEN_",",11,"I"))
 . . I '$G(PSOUSER),'$D(PSOU(CBYI)) Q  ;user selected specific user for "ignored by" column in report
 . . D SET
 G RX
 ;
NEXT ; - If not Sorting (already printed), SKIP, otherwise, print the report
 I '$D(^TMP("PSOBPSRP")) G NDTP
 S (S1,S2,S3,DFN,RSEQ,PSORX,PSORXN,RXNUMB,CDIV,OCDIV,CDIVN)=""
 F  S CDIV=$O(^TMP("PSOBPSRP",$J,CDIV)) Q:CDIV=""  D  Q:$D(DIRUT)
 . F  S S1=$O(^TMP("PSOBPSRP",$J,CDIV,S1)) Q:S1=""  D  Q:$D(DIRUT)
 . . F  S S2=$O(^TMP("PSOBPSRP",$J,CDIV,S1,S2)) Q:S2=""  D  Q:$D(DIRUT)
 . . . F  S S3=$O(^TMP("PSOBPSRP",$J,CDIV,S1,S2,S3)) Q:S3=""  D  Q:$D(DIRUT)
 . . . . F  S DFN=$O(^TMP("PSOBPSRP",$J,CDIV,S1,S2,S3,DFN)) Q:DFN=""  D  Q:$D(DIRUT)
 . . . . . F  S PSORXN=$O(^TMP("PSOBPSRP",$J,CDIV,S1,S2,S3,DFN,PSORXN)) Q:PSORXN=""  D  Q:$D(DIRUT)
 . . . . . . F  S RSEQ=$O(^TMP("PSOBPSRP",$J,CDIV,S1,S2,S3,DFN,PSORXN,RSEQ)) Q:RSEQ=""  D  Q:$D(DIRUT)
 . . . . . . . I $Y>(IOSL-7)&($E(IOST)="C") D HDR I $D(DIRUT) Q
 . . . . . . . I $Y>(IOSL-12)&($E(IOST)'="C") D HDR I $D(DIRUT) Q
 . . . . . . . S (RXNUMB,PSORX)="",RXNUMB=$E(PSORXN,1,$L(PSORXN)-1),PSORX=$O(^PSRX("B",RXNUMB,PSORX))
 . . . . . . . D PRINT(DFN,PSORX)
 . . . I '$D(DIRUT),S2'=0,$O(^TMP("PSOBPSRP",$J,CDIV,S1,S2))'="" W SP2
 . . I '$D(DIRUT),$O(^TMP("PSOBPSRP",$J,CDIV,S1))'="" W !,SP1
 G CLOSE:$D(DIRUT)
 ;
NDTP I 'PRTD D HDR W !!?18,"**********   NO DATA TO PRINT   **********"
 I $G(PCNT) D
 . W !,SP1
 . W !,"Total: ",PCNT," patient",$S(PCNT>1:"s",1:"")
 . W " and ",FCNT," prescription fill",$S(FCNT>1:"s",1:""),"."
 ;
CLOSE ;
 D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
END K ^TMP("PSOBPSRP",$J),^TMP("PSOBPSRC",$J)
 K PSOAPT,PSODRUG,PSOUSER,PSOU,PSODRG,PSOPT,PSOSRT,PSOED,PSOSD,PSODIV,PSOSIT
 Q
 ;
SET ;
 S (S1,S2,S3)=0
 F I=1:1:$L(PSOSRT,",") D
 . S Y=$P(PSOSRT,",",I)
 . S @("S"_I)=$S(Y=1:PNAM,Y=2:DNAM,Y=3:CBY)
 S ^TMP("PSOBPSRP",$J,CDIV,S1,S2,S3,DFN,RXE,SEQ2)=""
 Q
 ;
PRINT(DFN,RXIEN) ; - Print
 ;Input: DFN-Patient;RXIEN=Prescription IEN
 N X,XX,K,PNAM,PSSN,II,J,STR,CCOM,PMES,CBY,CREAS,CDAT,CFILL,RXNUM,DNAM,CINFO
 S (CDAT,CREAS,CBY,DNAM,PNAM,PMES,PSSN,CCOM,CINFO,RXNUM)=""
 ;
 I OCDIV'=CDIV!(OCDIV="") D HDR I $D(DIRUT) Q
 S OCDIV=CDIV
 ;
 D DEM^VADPT S PSSN=$P($G(VADM(2)),"^",2) K VADM
 K RXINFO D GETS^DIQ(52,RXIEN_",",".01;2;6","EI","RXINFO")
 S PNAM=RXINFO(52,RXIEN_",",2,"E"),DNAM=RXINFO(52,RXIEN_",",6,"E")
 D GETS^DIQ(52.25,RSEQ_","_RXIEN_",","5;10;11;12;2;13","IE","CINFO")
 S:$D(RXINFO(52,RXIEN_",",.01,"E")) RXNUM=RXINFO(52,RXIEN_",",.01,"E")
 S:$D(CINFO(52.25,RSEQ_","_RXIEN_",",10,"I")) CDAT=CINFO(52.25,RSEQ_","_RXIEN_",",10,"I")
 S CDAT=$$DT(CDAT)
 S:$D(CINFO(52.25,RSEQ_","_RXIEN_",",12,"I")) CREAS=CINFO(52.25,RSEQ_","_RXIEN_",",12,"E")
 S:$D(CINFO(52.25,RSEQ_","_RXIEN_",",11,"E")) CBY=CINFO(52.25,RSEQ_","_RXIEN_",",11,"E")
 S:$D(CINFO(52.25,RSEQ_","_RXIEN_",",2,"E")) PMES=CINFO(52.25,RSEQ_","_RXIEN_",",2,"E")
 D TEXT(.PMES,PMES,65)
 S:$D(CINFO(52.25,RSEQ_","_RXIEN_",",13,"E")) CCOM=CINFO(52.25,RSEQ_","_RXIEN_",",13,"E")
 D TEXT(.CCOM,CCOM,65)
 S:$D(CINFO(52.25,RSEQ_","_RXIEN_",",5,"I")) CFILL=CINFO(52.25,RSEQ_","_RXIEN_",",5,"I")
 ;
 W !,RXNUM_"/"_CFILL,?15,$E(DNAM,1,21),?37,$E(PNAM,1,13)_"("_$P(PSSN,"-",3)_")",?57,CDAT,?66,$E(CBY,1,14)
 S II="" F  S II=$O(CCOM(II)) Q:II=""  D
 . W:II=1 !,"     Comments: "
 . W:$D(CCOM(II)) ?15,CCOM(II),!
 S II="" F  S II=$O(PMES(II)) Q:II=""  D
 .  W:II=1 "Payer Message: "
 .  W:$D(PMES(II)) ?15,PMES(II),!
 ;
 S:'$D(^TMP("PSOBPSRC",$J,DFN)) PCNT=PCNT+1 S ^TMP("PSOBPSRC",$J,DFN)=""
 ;
 S PRTD=1,FCNT=FCNT+1
 Q
 ;
TEXT(TEXT,STR,L) ; Formats STR into TEXT array, lines lenght = L
 N J,WORD,K S K=+$O(TEXT(""),-1) S:'K K=1
 F J=1:1:$L(STR," ") D
 . S WORD=$P(STR," ",J) I ($L($G(TEXT(K))_WORD))>L S K=K+1
 . S TEXT(K)=$G(TEXT(K))_WORD_" "
 Q
 ;
HDR ; - Prints the Header
 N X,DIR,CDIVN S PAG=$G(PAG)+1
 S CDIVN=$$GET1^DIQ(59,$G(CDIV)_",",".01")
 I PAG>1,$E(IOST)="C" D  Q:$D(DIRUT)
 . S DIR(0)="E",DIR("A")=" Press ENTER to Continue or ^ to Exit" D ^DIR
 ;
 W @IOF,"Ignored Rejects Report",?71,"Page: ",$J(PAG,3)
 W !,"Sorted by",$$SRT(PSOSRT),?48,"Division: ",CDIVN
 W !,"Date Range: "_$$DT(PSOSD+1\1)_" - "_$$DT(PSOED\1)
 W ?48,"Run Date: "_$$FMTE^XLFDT($$NOW^XLFDT())
 S X="",$P(X,"-",81)="" W !,X
 W !,"RX#/FILL",?15,"DRUG",?37,"PATIENT",?56,"IGNORE DT",?66,"IGNORED BY"
 W !,"--------------",?15,"---------------------",?37,"------------------",?56,"---------",?66,"--------------"
 Q
 ;
SRT(ST) ; - Convert the "2,1" (example) to "DRUG,PATIENT"
 ;Input: ST-String with the Sorting fields by number
 ;Output: ST-String with the Sorting fields by name
 N I,X,STR,FLD
 S STR="PATIENT^DRUG^USER"
 F I=1:1:$L(ST,",") D
 . S FLD=+$P(ST,",",I),X=$P(STR,"^",FLD)
 . S $P(ST,",",I)=" "_X
 Q ST
 ;
DT(DT) ; - Convert FM Date to MM/DD/YYYY
 I 'DT Q ""
 I '(DT#10000) Q (1700+$E(DT,1,3))
 I '(DT#100) Q $E(DT,4,5)_"/"_(1700+$E(DT,1,3))
 Q $E(DT,4,5)_"/"_$E(DT,6,7)_"/"_$E((1700+$E(DT,1,3)),3,4)
 ;
