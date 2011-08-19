LRMITSPE ;SLC/STAFF - MICRO TREND PROCESS EXTRACT ;10/28/93  15:17
 ;;5.2;LAB SERVICE;**96,257,344**;Sep 27, 1994
 ; from LRMITSP
 ;Reference to ^SC supported by IA# 10040
 ;Reference to ^SC C xref supported by IA# 908
 ;Reference to ^DD supported by IA# 10154
 ;Reference to ^DPT supported by IA# 10035
 ;Reference to Y^DIQ supported by IA# 10004
 ;Reference to $$NS^XUAF4 supported by IA# 2171
 ;
 S LRSEQN=0
 ; if report type is only for specific patients, collect only that data
 I '$D(LRM("O")),'$D(LRM("S")),'$D(LRM("L")),'$D(LRM("D")),'$D(LRM("C")),'$D(LRM("DIV")),$D(LRM("P","S")) D  Q
 .S DFN=0 F  S DFN=$O(LRM("P","S",DFN)) Q:DFN<1  S LRDFN=+$P(LRM("P","S",DFN),U,2) I LRDFN D DATA Q:LREND
 .D CLEANUP
 ; otherwise, go thru all patients
 S LRDFN=0 F  S LRDFN=$O(^LR(LRDFN)) Q:LRDFN<1  D DATA Q:LREND
CLEANUP K DFN,LRACC,LRADMD,LRANTIM,LRANTIN,LRANTINM,LRATS,LRCDATE,LRCOLN,LRCOLNM,LRDCHD,LRDFN,LRDN,LRDOCN,LRDOCNM,LRGPN,LRGPNM,LRIDT,LRINTERP,LRLOCN,LRLOCNM
 K LRMERGEV,LRN1,LRN2,LRN3,LROK,LRORGN,LRORGNM,LRPATN,LRPATNM,LRPLOS,LRR,LRRTYPE,LRSEQN,LRSPECN,LRSPECNM,LRSUBN,LRSUSR,LRSUSS,LRTSAL,LRTB,LRTYPE,LRX,Y
 K LRX13,LRXN,LRDIV,LRDIVNM,LRSDIV,LRASK
 K LRAPRT,LRBLIK,LRPX
 Q
DATA ; quit if not a valid patient or task is stopped
 Q:'$D(^LR(LRDFN,0))  Q:$P(^(0),U,2)'=2  S LRPATN=+$P(^(0),U,3) I $$S^%ZTLOAD S (LREND,ZTSTOP)=1 Q
 ; go thru valid collection dates with available data
 S LRIDT=LRTSAL F  S LRIDT=$O(^LR(LRDFN,"MI",LRIDT)) Q:LRIDT<1!((LRIDT\1)>LRATS)  S LRX=$G(^(LRIDT,0)) I LRX,$$CHECK(LRDFN,LRIDT,.LROTYPE) D
 .; get date, los, acc, patient, provider, site/specimen, location, col samp #s and names
 .S LRCDATE=+LRX
 .S LRPLOS=$S(LRLOS!LRDETAIL:$$LOS(LRPATN,LRCDATE),1:"") I LRLOS Q:'$L(LRPLOS)  Q:LRPLOS<LRLOS
 .S LRACC=$P(LRX,U,6)
 .S LRPATNM=$P($G(^DPT(LRPATN,0)),U) I '$L(LRPATNM) S LRPATNM=LRUNK
 .S LRDOCN=+$P(LRX,U,7),LRDOCNM=$$VALUE(LRDOCN,63.05,.07) I '$L(LRDOCNM) S LRDOCNM=LRUNK
 .S LRSPECN=+$P(LRX,U,5),LRSPECNM=$P($G(^LAB(61,LRSPECN,0)),U) I '$L(LRSPECNM) S LRSPECNM=LRUNK
 .S LRLOCNM=$P(LRX,U,8) S:'$L(LRLOCNM) LRLOCNM=LRUNK
 .S X=LRLOCNM,DIC="^SC(",DIC(0)="",D="C" D IX^DIC
 .I Y=-1 S LRLOCN=0
 .E  S LRLOCN=+Y ;S LRLOCN=+$O(^SC("C",LRLOCNM,0))
 .K DIC,Y
 .;MULTIDIVISIONAL PATCH LR*5.2*257 - 08/04
 .S LRX13=$P(LRX,U,13),LRXN=$P(LRX13,";")
 .I LRX13>0,$P(LRX13,";",2)="SC(" S LRLOCNM=$P(^SC(LRXN,0),U),LRDIV=$P(^SC(LRXN,0),U,4)
 .I LRX13>0,$P(LRX13,";",2)="DIC(4," S LRDIV=LRXN
 .I '$G(LRDIV) S LRDIV=$P($G(^SC(+LRLOCN,0)),U,4)
 .I LRDIV S LRDIVNM=$P($$NS^XUAF4(LRDIV),U)
 .E  S LRDIV=0,LRDIVNM="UNKNOWN"
 .S:LRDIV="" LRDIV=0
 .S LRCOLN=+$P(LRX,U,11),LRCOLNM=$P($G(^LAB(62,LRCOLN,0)),U) I '$L(LRCOLNM) S LRCOLNM=LRUNK
 .;MULTIDIVISIONAL PATCH LR*5.2*257 -3/01
 .;if report is for specific division, collect only that data
 .I $D(LRM("DIV","S")) D  Q
 ..S LRSDIV=0
 ..F  S LRSDIV=$O(LRM("DIV","S",LRSDIV)) Q:LRSDIV=""  D
 ...I LRSDIV=LRDIV,LRDIV'=0 D ^LRMITSPO
 ..Q 
 .; get data on organisms
 .D ^LRMITSPO
 Q
CHECK(LRDFN,LRIDT,LROTYPE) ; lab patient, time, organism types -> 1 or 0 if data available
 I $D(LROTYPE("B")),$D(^LR(LRDFN,"MI",LRIDT,3)) Q 1
 I $D(LROTYPE("F")),$D(^LR(LRDFN,"MI",LRIDT,8)) Q 1
 I $D(LROTYPE("M")),$D(^LR(LRDFN,"MI",LRIDT,11)) Q 1
 I $D(LROTYPE("P")),$D(^LR(LRDFN,"MI",LRIDT,5)) Q 1
 I $D(LROTYPE("V")),$D(^LR(LRDFN,"MI",LRIDT,16)) Q 1
 I '$D(LROTYPE("B")),$D(^LR(LRDFN,"MI",LRIDT,3)) Q 1
 Q 0
VALUE(Y,FILE,FIELD) ; $$(internal value,file,field) -> external value or ""
 I 'Y Q ""
 N C S C=$P(^DD(FILE,FIELD,0),U,2) D Y^DIQ Q Y
LOS(DFN,CDATE) ; $$(patient,collection date) -> length of stay or ""
 N ADATE S VAINDT=CDATE D INP^VADPT S ADATE=$P(VAIN(7),U) D KVAR^VADPT I '$L(ADATE) Q ""
 Q $$FMDIFF^XLFDT(CDATE,ADATE)
