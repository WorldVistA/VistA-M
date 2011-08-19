PSONVAR1 ;BHM/MFR - Non-VA Med Usage Report ;04/10/03
 ;;7.0;OUTPATIENT PHARMACY;**132,118**;13 Feb 97
 ;External reference to File ^PS(55 supported by DBIA 2228
 ;External reference to $$GET1^DIQ is supported by DBIA 2056
 ;External reference to ^VADPT is supported by DBIA 10061
 ;External reference to ^XLFDT is supported by DBIA 10103
 ;External reference to ^%ZISC is supported by DBIA 10089
 ;
EN N DATE,DFN,ORD,PAG,PCNT,PRTD,OINAM,PNAM,I,J,Y,X,C,XX,S1,S2,S3,S4,S5,OCNT
 N OCK,OK,STS,SUB,SP1,SP2,SPF
 ;
 U IO K ^TMP("PSONV",$J),^TMP("PSOCNT",$J)
 S SPF=0,(SP1,SP2)="",$P(SP1,"=",80)="",$P(SP2,"-",80)=""
 ;
 ; - Loop through the Non-VA Med orders x-reference
 S DATE=PSOSD,(DFN,ORD)="",(PCNT,OCNT,PRTD)=0 K DIRUT
DATE S DATE=$O(^PS(55,"ADCDT",DATE)) G NEXT:DATE=""!(DATE>PSOED)
 W:SPF SP1
 ;
DFN I PSOAPT S DFN=$O(^PS(55,"ADCDT",DATE,DFN)) G DATE:DFN=""
 I 'PSOAPT S DFN=$O(PSOPT(DFN)) G DATE:DFN=""        ;Patient Filter
 ;
 I $$DEAD^PSONVARP(DFN) G DFN                        ;Patient is Dead
 ;
ORD S ORD=$O(^PS(55,"ADCDT",DATE,DFN,ORD)) G DFN:ORD=""
 S XX=$G(^PS(55,DFN,"NVA",ORD,0))
 I 'PSOAOI,'$D(PSOOI(+$P(XX,"^"))) G ORD             ;OI Filter
 I '$P(XX,"^",6),PSOST="D" G ORD                     ;Status Filter
 I $P(XX,"^",6),PSOST="A" G ORD
 I '$D(^PS(55,DFN,"NVA",ORD,"OCK")),PSOOC="Y" G ORD  ;Order Checks Filter
 I $D(^PS(55,DFN,"NVA",ORD,"OCK")),PSOOC="N" G ORD
 ;
 I PSOSRT=3 D  G CLOSE:$D(DIRUT),ORD                 ;If not Sorting,
 . I $Y>(IOSL-9) D HDR I $D(DIRUT) Q                 ;Print the Report
 . D PRINT(DFN,ORD) Q:$D(DIRUT)  S SPF=1             ;Then G ORD
 ;
 I PSOSRT[1 S PNAM=$$GET1^DIQ(2,DFN,.01)             ;Retrieving Patient
 I PSOSRT[2 S OINAM=$$GET1^DIQ(50.7,+$P(XX,"^"),.01) ;Name and Orderable
 S:$G(PNAM)="" PNAM=0 S:$G(OINAM)="" OINAM=0         ;Item Name
 S (S1,S2,S3,S4,S5)=0
 F I=1:1:$L(PSOSRT,",") D
 . S Y=$P(PSOSRT,",",I),STS=+$P(XX,"^",6)
 . S OCK=$S($D(^PS(55,DFN,"NVA",ORD,"OCK")):1,1:2)
 . S @("S"_I)=$S(Y=1:PNAM,Y=2:OINAM,Y=3:DATE,Y=4:+STS,Y=5:OCK)
 S ^TMP("PSONV",$J,S1,S2,S3,S4,S5,DFN,ORD)=""
 G ORD
 ;
NEXT ; - If not Sorting (already printed), SKIP, otherwise, print the report
 I PSOSRT="" G NDTP
 S (S1,S2,S3,S4,S5,DFN,ORD)=""
 F  S S1=$O(^TMP("PSONV",$J,S1)) Q:S1=""  D  Q:$D(DIRUT)
 . F  S S2=$O(^TMP("PSONV",$J,S1,S2)) Q:S2=""  D  Q:$D(DIRUT)
 . . F  S S3=$O(^TMP("PSONV",$J,S1,S2,S3)) Q:S3=""  D  Q:$D(DIRUT)
 . . . F  S S4=$O(^TMP("PSONV",$J,S1,S2,S3,S4)) Q:S4=""  D  Q:$D(DIRUT)
 . . . . F  S S5=$O(^TMP("PSONV",$J,S1,S2,S3,S4,S5)) Q:S5=""  D  Q:$D(DIRUT)
 . . . . . F  S DFN=$O(^TMP("PSONV",$J,S1,S2,S3,S4,S5,DFN)) Q:DFN=""  D  Q:$D(DIRUT)
 . . . . . . F   S ORD=$O(^TMP("PSONV",$J,S1,S2,S3,S4,S5,DFN,ORD)) Q:ORD=""  D  Q:$D(DIRUT)
 . . . . . . . I $Y>(IOSL-12) D HDR I $D(DIRUT) Q
 . . . . . . . D PRINT(DFN,ORD)
 . . I '$D(DIRUT),S2'=0,$O(^TMP("PSONV",$J,S1,S2))'="" W SP2
 . I '$D(DIRUT),$O(^TMP("PSONV",$J,S1))'="" W SP1
 G CLOSE:$D(DIRUT)
 ;
NDTP I 'PRTD D HDR W !!?18,"**********   NO DATA TO PRINT   **********"
 I PRTD D
 . W SP1
 . W !,"Total: ",PCNT," patient",$S(PCNT>1:"s",1:"")
 . W " and ",OCNT," order",$S(OCNT>1:"s",1:""),"."
 ;
CLOSE D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
END K ^TMP("PSONV",$J),^TMP("PSOCNT",$J)
 Q
 ;
PRINT(DFN,ORD) ; - Print a Non-VA Med Order
 ;Input: DFN-Patient;ORD-Non-VA Order#
 N X,XX,K,OI,OIX,OINAM,DGNAM,PNAM,PSSN,CLNAM,PRV,I,J,Z,TXT,VAPA,VADM,SCH
 N STR,OCK
 ;
 I '$D(^PS(55,DFN,"NVA",ORD)) Q
 I '$G(PAG) D HDR I $D(DIRUT) Q
 ;
 S XX=^PS(55,DFN,"NVA",ORD,0),OINAM=$$GET1^DIQ(50.7,+$P(XX,"^"),.01)
 S DGNAM="" I $P(XX,"^",2) S DGNAM=$$GET1^DIQ(50,+$P(XX,"^",2),.01)
 D DEM^VADPT,ADD^VADPT S PNAM=$P(VADM(1),"^"),PSSN=$P($G(VADM(2)),"^",2)
 W !,PNAM," (ID:",$S(PSSN:$P(PSSN,"-",3),1:"0000"),")"
 W ?46,"Patient Phone #: ",$E($P(VAPA(8),"^"),1,16)
 S:'$D(^TMP("PSOCNT",$J,DFN)) PCNT=PCNT+1 S ^TMP("PSOCNT",$J,DFN)=""
 ;
 W !?5,"Non-VA Med: ",OINAM
 W !?2,"Dispense Drug: ",$E(DGNAM,1,37)
 W ?55,"Dosage: ",$E($P(XX,"^",3),1,16)
 W !?7,"Schedule: " S X=$E($P(XX,"^",5),1,30)
 S SCH=$S($L($P(XX,"^",5))>30:$P(X," ",1,$L(X," ")-1),1:X) W SCH
 W ?52,"Med Route: ",$E($P(XX,"^",4),1,35)
 I $E($P(XX,"^",5),$L(SCH)+1,99)'="" D
 . W !?16,$E($P(XX,"^",5),$L(SCH)+1,99)
 W !?9,"Status: ",$S('$P(XX,"^",6):"ACTIVE",1:"DISCONTINUED on "_$$DT($P(XX,"^",7)))
 W ?49,"CPRS Order #: ",$P(XX,"^",8)
 W !?2,"Documented By: ",$E($$GET1^DIQ(200,+$P(XX,"^",11),.01),1,29)
 W ?46,"Documented Date: ",$$DT($P(XX,"^",10))
 S CLNAM=$$GET1^DIQ(44,+$P(XX,"^",12),.01)
 W !?9,"Clinic: " W:$P(XX,"^",12) $E($P(XX,"^",12)_" - "_CLNAM,1,33)
 W ?51,"Start Date: ",$$DT($P(XX,"^",9)),!
 ;
 ; - Printing "Order Checks" fields
 W:$D(^PS(55,DFN,"NVA",ORD,"OCK")) !
 F I=0:0 S I=$O(^PS(55,DFN,"NVA",ORD,"OCK",I)) Q:'I  D  Q:$D(DIRUT)
 . S OCK=^PS(55,DFN,"NVA",ORD,"OCK",I,0),STR=$P(OCK,"^"),PRV=+$P(OCK,"^",2)
 . I $Y>(IOSL-5) D HDR Q:$D(DIRUT)  W !
 . W ?1,"Order Check #",I,": " K TXT D TEXT(.TXT,STR,61)
 . F K=1:1 Q:'$D(TXT(K))  D  Q:$D(DIRUT)
 . . W ?17,TXT(K),! I $Y>(IOSL-4) D HDR Q:$D(DIRUT)  W !
 . Q:$D(DIRUT)  K TXT
 . F J=0:0 S J=$O(^PS(55,DFN,"NVA",ORD,"OCK",I,"OVR",J)) Q:'J  D
 . . S STR=^PS(55,DFN,"NVA",ORD,"OCK",I,"OVR",J,0)
 . . D TEXT(.TXT,STR,56)
 . W ?6,"Override Reason: " W:'$D(TXT) !
 . F K=1:1 Q:'$D(TXT(K))  D  Q:$D(DIRUT)
 . . W ?23,TXT(K),! I $Y>(IOSL-4) D HDR Q:$D(DIRUT)  W !
 . Q:$D(DIRUT)
 . W ?6,"Override Provider: " W:PRV $$GET1^DIQ(200,+PRV,.01) W !
 Q:$D(DIRUT)
 ;
 ; - Printing "Statement/Explanation/Comments" field
 I $D(^PS(55,DFN,"NVA",ORD,"DSC")) D  Q:$D(DIRUT)
 . W !,"Statement/Explanation/Comments: " K TXT
 . F I=0:0 S I=$O(^PS(55,DFN,"NVA",ORD,"DSC",I)) Q:'I  D
 . . S STR=^PS(55,DFN,"NVA",ORD,"DSC",I,0)
 . . D TEXT(.TXT,STR,47)
 . F K=1:1 Q:'$D(TXT(K))  D  Q:$D(DIRUT)
 . . W ?32,TXT(K),! I $Y>(IOSL-4) D HDR Q:$D(DIRUT)  W !
 ;
 S PRTD=1,OCNT=OCNT+1
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
 N X,DIR S PAG=$G(PAG)+1
 I PAG>1,$E(IOST)="C" D  Q:$D(DIRUT)
 . S DIR(0)="E",DIR("A")=" Press ENTER to Continue or ^ to Exit" D ^DIR
 ;
 W @IOF,"Non-VA Meds Usage Report",?74,"Page: ",$J(PAG,3)
 W !,"Sorted by",$$SRT(PSOSRT)
 W !,"Date Range: "_$$DT(PSOSD+1\1)_" - "_$$DT(PSOED\1)
 W ?48,"Run Date: "_$$FMTE^XLFDT($$NOW^XLFDT())
 S X="",$P(X,"-",80)="" W !,X
 Q
 ;
SRT(ST) ; - Convert the "1,2,4" (example) to "PATIENT,ORDERABLE ITEM,STATUS"
 ;Input: ST-String with the Sorting fields by number
 ;Output: ST-String with the Sorting fields by name
 N I,X,STR,FLD
 S STR="PATIENT NAME^ORDERABLE ITEM^DATE DOCUMENTED^STATUS^ORDER CHECKS"
 F I=1:1:$L(ST,",") D
 . S FLD=+$P(ST,",",I),X=$P(STR,"^",FLD)
 . S $P(ST,",",I)=" "_X
 Q ST
 ;
DT(DT) ; - Convert FM Date to MM/DD/YYYY
 I 'DT Q ""
 I '(DT#10000) Q (1700+$E(DT,1,3))
 I '(DT#100) Q $E(DT,4,5)_"/"_(1700+$E(DT,1,3))
 Q $E(DT,4,5)_"/"_$E(DT,6,7)_"/"_(1700+$E(DT,1,3))
