PSUCSR1 ;BIR/DJM - Drug breakdown ;25 AUG 1998
 ;;4.0;PHARMACY BENEFITS MANAGEMENT;;MARCH, 2005
 ; DBIA(s)
 ; Reference to file #40.8 supported by DBIA 2438
 ;
EN ;EP -- DRUG BREAKDOWN REPORT
 ;
 S RC="^XTMP(PSUCSJB,""RECORDS"",PSUDIV,PSUTIEN,PSURC)"
 I $G(@RC@(0))'=2 Q
 S PSUGNM=$G(@RC@(9))
 S PSUBU=$G(@RC@(14))
 S PSUBU=$S(PSUBU="":"N/A",1:PSUBU)
 S PSUPSZ=$G(@RC@(15))
 S PSUPSZ=$S(PSUPSZ="":"N/A",1:PSUPSZ)
 S PSUNFI=$G(@RC@(10))
 S PSUVFI=$G(@RC@(11))
 S PSUCST=$G(@RC@(16))
 S PSUQTY=$G(@RC@(17))
 S PSUCST=PSUCST*PSUQTY
 S PSUTCST=$G(PSUTCST)+PSUCST
 ; pull previous counters
 ; PSUGNM-drug name; PSUBU-break down unit/dispense unit
 ; PSUPSZ-package size
 S PSUX=$G(^XTMP(PSUCSJB,"CSFR-37",PSUDIV,PSUGNM,PSUBU,PSUPSZ))
 S PSUOQTY=$P(PSUX,U,3)
 S PSUOCST=$P(PSUX,U,4)
 S PSUOCNT=$P(PSUX,U,5)
 ; update/store counters
 S PSUTCST=PSUOCST+PSUCST
 S PSUTQTY=PSUOQTY+PSUQTY
 S PSUTCNT=PSUOCNT+1
 S PSUX=PSUNFI_U_PSUVFI_U_PSUTQTY_U_PSUTCST_U_PSUTCNT
 S ^XTMP(PSUCSJB,"CSFR-37",PSUDIV,PSUGNM,PSUBU,PSUPSZ)=PSUX
 Q
 ;
 ;
GENREP(PSUMSG) ;EP - Generate the report based on the collected information
 ;
 S PSUPGS("PG")=1
 D PGHDR1
 S PSUL=3
 F  S PSUL=$O(^XTMP("PSU_"_PSUJOB,"CSAMIS",PSUL)) Q:PSUL=""  D
 .I LNCNT+4>IOSL D PGHDR1
 .W !,^XTMP("PSU_"_PSUJOB,"CSAMIS",PSUL)
 .S LNCNT=LNCNT+1
 Q
COMBO(PSUMSG) ;EP - Generate the report based on the collected information
 ;
 S PSUPGS("PG")=1
 D PGHDR2
 S PSUL=3
 F  S PSUL=$O(^XTMP("PSU_"_PSUJOB,"COMBOAMIS",PSUL)) Q:PSUL=""  D
 .I LNCNT+4>IOSL D PGHDR2
 .W !,^XTMP("PSU_"_PSUJOB,"COMBOAMIS",PSUL)
 .S LNCNT=LNCNT+1
 Q
 ;
PGHDR1 ;AMIS PAGE HEADER
 U IO
 W @IOF
 W !,^XTMP("PSU_"_PSUJOB,"CSAMIS",1)
 W !!,?68,"Page: ",PSUPGS("PG")
 W !,$G(^XTMP("PSU_"_PSUJOB,"IVAMIS",2))
 S LNCNT=3
 Q
 ;
PGHDR2 ;COMBO AMIS PAGE HEADER
 U IO
 W @IOF
 W !,^XTMP("PSU_"_PSUJOB,"COMBOAMIS",1)
 W !!,?68,"Page: ",PSUPGS("PG")
 W !,$G(^XTMP("PSU_"_PSUJOB,"COMBOAMIS",2))
 S LNCNT=3
 Q
 ;
PG ;EP  Page controller
 S PSUQUIT=0
 I $Y<(IOSL-4) Q
 S:'$D(PSUPG("PG")) PSUPG("PG")=0
 S PSUPG("PG")=PSUPG("PG")+1
 I $E(IOST)="C" K DIR S DIR(0)="E" D ^DIR
 I $G(DIROUT)!$G(DUOUT)!$G(DTOUT)!$G(DIRUT) S PSUQUIT=1
 U IO W @IOF
 Q:$G(PSUQUIT)
 ;
PGHDR ;EP write header & page number
 F I=1,2 W !,^XTMP(PSUCSJB,"MAIL",PSUMC,I)
 W !,?60,"PAGE: ",PSUPG("PG")
 F I=4,5,6 I $D(^XTMP(PSUCSJB,"MAIL",PSUMC,I)) W !,^(I)
 Q
 ;
SUMMRY(PSUMSG,PSUMFL) ; Mail the drug summary report (by division)
 K PSUTCSO,PSUTCST
 S X=PSUDIV,DIC=40.8,DIC(0)="X",D="C" D IX^DIC ;**1
 S X=+Y S PSUDIVNM=$$VAL^PSUTL(40.8,X,.01)
 S PSUMFL=$G(PSUMFL,1)
 S PSUOMC=PSUMC,PSUMLC=0
 S PSUMC=PSUMC+1,PSULC=0,PSUTLC=0
 S PSUDRG="",PSUQDTL=0,PSUTCSO=0,PSUTCST=0
 S PSUDSHL=$$PAD("","-",76)
 S PSULC=PSULC+1
 S ML="^XTMP(PSUCSJB,""MAIL"",PSUMC)"
 S @ML@(1)=$$CTR("Controlled Substance Statistical Data"," ",75)
 S @ML@(2)="                   "_PSUDTS_" through "_PSUDTE_" for "_PSUDIVNM
 S @ML@(3)=" "
 S X=$$PAD(" "," ",45)_$$CTR("Breakdown"," ",10)_$$CTR("Package"," ",10)_"Quantity"
 S @ML@(4)=X
 S X=$$PAD("Drug Name"," ",45)_$$PAD("Unit"," ",10)_$$CTR("Size"," ",10)_"Dispensed"
 S @ML@(5)=X
 S @ML@(6)=PSUDSHL,PSULC=6
 ;
 F  S PSUDRG=$O(^XTMP(PSUCSJB,"CSFR-37",PSUDIV,PSUDRG)) Q:PSUDRG=""  D
 . S PSUBU=""
 . F  S PSUBU=$O(^XTMP(PSUCSJB,"CSFR-37",PSUDIV,PSUDRG,PSUBU)) Q:PSUBU=""  D
 .. S PSUSZ=""
 .. F  S PSUSZ=$O(^XTMP(PSUCSJB,"CSFR-37",PSUDIV,PSUDRG,PSUBU,PSUSZ)) Q:PSUSZ=""  D
 ... S X=$G(^XTMP(PSUCSJB,"CSFR-37",PSUDIV,PSUDRG,PSUBU,PSUSZ),"^^0")
 ... S PSUNFI=$P(X,U,1)
 ... S PSUVFI=$P(X,U,2)
 ... S PSUQTY=$P(X,U,3)
 ... S PSUCST=$P(X,U,4)
 ... S PSUTCST=PSUTCST+PSUCST
 ... S PSUCNT=$P(X,U,5),PSUTCSO=PSUTCSO+PSUCNT
 ... S X=PSUDRG_" "_$S(PSUVFI=0:"#",1:"")_$S(PSUNFI'="":"*",1:"")
 ... S X=$$PAD(X," ",45)
 ... S X=X_$$PAD(PSUBU," ",10)
 ... S X=X_$$PAD($J(PSUSZ,7)," ",12)
 ... S X=X_$$PAD($J(PSUQTY,7)," ",10)
 ... S PSUQDTL=PSUQDTL+PSUQTY ; Sum up the total quantity dispensed
 ... S PSULC=PSULC+1,PSUTLC=PSUTLC+1
 ... S @ML@(PSULC)=X
 S ^XTMP(PSUCSJB,"REPORT",PSUMC)="" ; trigger print report
 S ^XTMP(PSUCSJB,"SUMMARY 2",PSUMC)="" ;trigger mail & XMY group
 I $G(PSUTCSO)=0 D  ; No mail summary to send
 . K ^XTMP(PSUCSJB,"MAIL",PSUMC)
 . S ^XTMP(PSUCSJB,"MAIL",PSUMC)=PSUDIV
 . S ^XTMP(PSUCSJB,"REPORT",PSUMC)=""
 . S @ML@(1)=$$CTR("Controlled Substance Statistical Data"," ",75)
 . S @ML@(2)="                   "_PSUDTS_" through "_PSUDTE_" for "_PSUDIVNM
 . S @ML@(3)="  "
 . S @ML@(4)="No data to report"
 . S @ML@(5)=" "
 I $G(PSUSMRY,0) D
 . K ^XTMP(PSUCSJB,"MAIL",PSUMC),^XTMP(PSUCSJB,"REPORT",PSUMC)
 I '$G(PSUSMRY,0),PSUTLC D
 . S PSUTLC=PSUTLC+6 ; Adjust for the header
 . ; Set total line
 . S ^XTMP(PSUCSJB,"MAIL",PSUMC)=PSUDIV
 . S PSULC=PSULC+1,PSUTLC=PSUTLC+1
 . S @ML@(PSULC)=PSUDSHL ; dashes line
 . S PSULC=PSULC+1,PSUTLC=PSUTLC+1
 . S @ML@(PSULC)=$$PAD("Totals:"," ",64)_$J(PSUQDTL,10)
 . S PSULC=PSULC+1
 . S @ML@(PSULC)="   "
 . S PSULC=PSULC+1
 . S @ML@(PSULC)=" * Non-Formulary"
 . S PSULC=PSULC+1
 . S @ML@(PSULC)=" # Not on National Formulary"
 ;
 Q
 ;
EXIT1 S PSUMLC=0
 Q
PAD(S,P,L) ; Pad string S with P to length L
 S $P(P,P,L)=""
 Q $E(S_P,1,L)
CTR(S,P,L) ; Center string S left and right P in size L
 Q $$PAD($$PAD(P,P,L-$L(S)\2)_S,P,L)
