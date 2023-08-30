PSODEARA ;WILM/BDB - Print active prescribers with privledges; ;9/28/21  12:59
 ;;7.0;OUTPATIENT PHARMACY;**545**;DEC 1997;Build 270
 ;External reference to VA(200 is supported by DBIA 10060
 ;Reference DBIA 2343  - $$ACTIVE^XUSER
 ;Reference DBIA 2171  - PARENT^XUAF4()
 ;----------------------------------------------------------------
 ;
 Q
 ;
PRIVSRT ; Print active prescribers with privledges
 ;
 ;ePCS on demand report
 N PSONS,RHD,RT,PSOION D INIT K %DT,DTOUT,ZPR,POP
 K IOP,%ZIS S PSOION=ION,%ZIS="MQ" D ^%ZIS I POP S IOP=PSOION D ^%ZIS G EXIT
AUTPRT ;
 I $G(ZPR)!$D(IO("Q")) D  G EXIT
 . N ZTRTN,ZTDESC,ZTIO,ZTSAVE,ZTDTH,ZTSK,ZTREQ,ZTQUEUED
 . S:$G(ZPR) ZTIO="`"_ZPR,ZTDTH=$H S ZTRTN="OEN^PSODEARA"
 . S ZTSAVE("PSONS")="",ZTSAVE("RHD")="",ZTSAVE("RT")="",ZTSAVE("FSP")=""
 . D ^%ZTLOAD W:$D(ZTSK) !,"Report is Queued to print !!"
OEN ;
 U IO
 N PAGE,LINE,LEN,XTV,ARR,I,J,RHD,HCL,FSP,RDT,DV,FE,NPIEN,RET,PSOSPS
 N DV,ND,DAT,IEN,DVS,CNT,NDEA,DEA,DEAVA,PSOSRC,PSOSRCI K DIRUT,DTOUT
 S CNT=0
 K ^XTMP(PSONS,$J),^TMP(PSONS,$J)
 S NPIEN=.99 F  S NPIEN=$O(^VA(200,NPIEN)) Q:'NPIEN  D
 . I '$$ACTIVE^XUSER(NPIEN) Q
 . K DAT D DEALIST^PSOEPUT(.DAT,NPIEN)
 . I '$D(DAT) D
 . . S DAT(1)="^^^^^^^^^^^^^"
 . S NDEA=0 F  S NDEA=$O(DAT(NDEA)) Q:'NDEA  D
 .. S DAT(NDEA)=$$UP^XLFSTR(DAT(NDEA))
 .. D DATCHK ;Check for no new DEA numbers, use 200 schedules
 .. I DAT(NDEA)?1"^"."^" Q  ;Quit if no data
 .. S CNT=CNT+1
 .. S ^TMP(PSONS,$J,CNT)=NPIEN_"^"_DAT(NDEA)
 .. S (DV,DVS)=0 F  S DV=$O(^VA(200,NPIEN,2,DV)) Q:('DV)&(DVS>0)  S:'DV DV=999999 D
 ... S DVS=DVS+1
 ... S ^XTMP(PSONS,$J,DV,CNT)=""
 ... S:$O(^VA(200,NPIEN,2,DV)) ^XTMP(PSONS,$J,"Z",NPIEN)=""
 S RHD="PRESCRIBERS WITH PRIVILEGES"
 S HCL=(80-$L(RHD))\2,RDT=$$UP^XLFSTR($$FMTE^XLFDT($$NOW^XLFDT,"1M"))
 S PAGE=1,$P(LINE,"-",79)="",$P(FSP," ",25)=""
 D HD
 I '$D(^XTMP(PSONS,$J)) D  G QT
 . W !!,"          ***************  NO MATCHING DATA  ***************",!!
 S DV="" F  S DV=$O(^XTMP(PSONS,$J,DV)) Q:'DV  D  G:$D(DIRUT) QT
 . K ARR S LEN="DIVISION: "_$S(DV=999999:"NO DIVISION",1:$$GET1^DIQ(4,DV,.01))
 . W !!,?9,LEN
 . S ND=0 F  S ND=$O(^XTMP(PSONS,$J,DV,ND)) Q:'ND  D  Q:$D(DIRUT)
 .. S DAT=^TMP(PSONS,$J,ND),NPIEN=$P(DAT,"^"),DEA=$P(DAT,"^",2)
 .. I $P(DAT,"^",9,14)'["Y" Q  ;check for a schedule
 .. S ARR(NPIEN)=""
 .. S PSOSPS=$G(^VA(200,NPIEN,"PS"))
 .. W !,$E($$GET1^DIQ(200,NPIEN,.01)_FSP,1,25),?32,$E(NPIEN_FSP,1,12),?45,$E(DEA_FSP,1,13),?60,$E($P(PSOSPS,U,3)_FSP,1,15)
 .. W ?72,$E($S($P(DAT,"^",15)="":"NO",1:$P(DAT,"^",15))_FSP,1,5)
 .. W !,"         SCHEDULE II:",?29,$S($P(DAT,"^",9)="":"NO",1:$P(DAT,"^",9))
 .. W !,"         SCHEDULE II NON:",?29,$S($P(DAT,"^",10)="":"NO",1:$P(DAT,"^",10))
 .. W !,"         SCHEDULE III:",?29,$S($P(DAT,"^",11)="":"NO",1:$P(DAT,"^",11))
 .. W !,"         SCHEDULE III NON:",?29,$S($P(DAT,"^",12)="":"NO",1:$P(DAT,"^",12))
 .. W !,"         SCHEDULE IV:",?29,$S($P(DAT,"^",13)="":"NO",1:$P(DAT,"^",13))
 .. W !,"         SCHEDULE V:",?29,$S($P(DAT,"^",14)="":"NO",1:$P(DAT,"^",14))
 .. S PSOSRC="",PSOSRCI=$P(DAT,"^",8) D  W PSOSRC
 ... I PSOSRCI']"" S PSOSRC=" (Source: File #200)" Q
 ... S PSOSRC=$$GET1^DIQ(8991.9,PSOSRCI,.07)
 ... I PSOSRC="INDIVIDUAL" S PSOSRC=" (Source: File #8991.9)" Q
 ... I PSOSRC="INSTITUTIONAL" S PSOSRC=" (Source: File #200)" Q
 .. D:($Y+4)>IOSL HD
 . S J=0 F  S J=$O(ARR(J)) Q:'J  D:$D(^XTMP(PSONS,$J,"Z",J)) FT
QT ;
 K DIR,DTOUT,DUOUT,DIRUT
 D EXIT
 Q
 ;
EXIT K ^TMP(PSONS,$J),^XTMP(PSONS,$J)
 D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 Q
 ;
HD ;
 I PAGE>1,$E(IOST)="C" S DIR(0)="E",DIR("A")=" Press Return to Continue or ^ to Exit" D ^DIR K DIR
 Q:$D(DIRUT)!($D(DTOUT))
 W @IOF
 W !,RHD,?50,RDT,?72,"PAGE "_PAGE S PAGE=PAGE+1
 W !,"NAME",?32,"DUZ",?45,"DEA #",?60,"VA#",?73,"INPAT"
 W !,?45,"(E)=EXPIRED"
 W !,LINE
 Q
 ;
FT ;
 S LEN="**Note: This user is defined under these divisions"
 W !!,LEN
 W ! F I=1:1:$L(LEN) W "-"
 S (DAT,ND)=0 F  S ND=$O(^VA(200,J,2,ND)) Q:'ND  D
 . S DAT=DAT+1 W ! W:DAT=1 $$GET1^DIQ(200,J,.01) W ?32,$$GET1^DIQ(4,ND,.01)
 I $E(IOST)="C" S DIR(0)="E" D ^DIR K DIR
 Q
 ;
INIT ;
 S PSONS="PSODEAA",$P(FSP," ",25)=""
 S RHD="PRINT PRESCRIBERS WITH PRIVILEGES"
 S ZPR=""
 S RT=$$NOW^XLFDT
 K ^XTMP(PSONS,$J),^TMP(PSONS,$J)
 Q
 ;
GUI ;
 N PSONS,ZPR,RHD,RT,PSOSCR,BDT,EDT,PSOION
 D INIT K %DT,DTOUT,ZPR
 ;
 ;I $G(ECPTYP)="E" D EXPORT,^EPCSKILL Q  ; ePCS not exporting to Excel at this point
 S PSOSCR=$S($E($G(IOST),1,2)="C-":1,1:0)
 ;
 D OEN                           ; Run Report
 ;I $D(EPCSGUI) D ^EPCSKILL Q    // Kill variables...
 Q
 ;
DATCHK ;Check for no new DEA numbers, use 200 schedules
 N X,EXPDTFM,NPSCHED,RET,Y
 S RET=""
 S X=$P(DAT(NDEA),"^",1) I X="" D
 . ; Use #200 schedules
 . K NPSCHED D GETS^DIQ(200,NPIEN_",","55.1:55.6","E","NPSCHED")
 . S RET=RET_NPSCHED(200,NPIEN_",",55.1,"E")_"^"  ; SCHEDULE II NARCOTIC
 . S RET=RET_NPSCHED(200,NPIEN_",",55.2,"E")_"^"  ; SCHEDULE II NON-NARCOTIC
 . S RET=RET_NPSCHED(200,NPIEN_",",55.3,"E")_"^"  ; SCHEDULE III NARCOTIC
 . S RET=RET_NPSCHED(200,NPIEN_",",55.4,"E")_"^"  ; SCHEDULE III NON-NARCOTIC
 . S RET=RET_NPSCHED(200,NPIEN_",",55.5,"E")_"^"  ; SCHEDULE IV
 . S RET=RET_NPSCHED(200,NPIEN_",",55.6,"E")_"^"  ; SCHEDULE V
 . S DAT(NDEA)=$P(DAT(NDEA),"^",1,7)_"^"_RET_"^"_$P(DAT(NDEA),"^",14)
 . S DAT(NDEA)=$$UP^XLFSTR(DAT(NDEA))
 S X=$P(DAT(NDEA),"^",5) I X]"" D
 . D ^%DT S EXPDTFM=Y Q:Y<0
 . I EXPDTFM'<DT Q
 . S:$P(DAT(NDEA),"^",1)]"" $P(DAT(NDEA),"^",1)=$P(DAT(NDEA),"^",1)_"(E)"
 Q
 ;
