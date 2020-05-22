PSOCLOLS ; HEC/hrub ;4 May 2019 18:48:29
 ;;7.0;OUTPATIENT PHARMACY;**457,593**;DEC 1997;Build 2
 ;
 W !,"Print clozapine prescriptions with lockout override.",!
 D DT^DICRW N %ZIS,DIR,PSOCLDT
 S DIR(0)="DA^:"_DT_":XE",DIR("A")="Override Beginning date: " D ^DIR G EXIT:'(Y>0) S PSOCLDT("beg")=Y
 K DIR S DIR(0)="DA^"_Y_":"_DT_":XE",DIR("A")="   Override Ending date: " D ^DIR G EXIT:Y<0 S PSOCLDT("end")=Y
 K %ZIS S %ZIS="Q" D ^%ZIS G EXIT:POP
 I $D(IO("Q")) D QUE G EXIT
DQ ; List of Override Prescriptions [PSOLIST OVERRIDES] report
 N PSIEN,PSOHDR,PSOLPDT,X
 S PSOHDR(1)=" Clozapine Lockout Override Prescriptions - "_$$FMTE^XLFDT($$NOW^XLFDT)_"   Page: "
 S PSOHDR(2)="    From "_$$FMTE^XLFDT(PSOCLDT("beg"))_" through "_$$FMTE^XLFDT(PSOCLDT("end"))
 S PSOHDR(0,"pg#")=0
 W:$Y @IOF D PGHDR(.PSOHDR) I '$O(^PS(52.52,"B",PSOCLDT("beg"))) D NOTFND(.PSOHDR) G EXIT
 I $O(^PS(52.52,"B",PSOCLDT("beg")))>PSOCLDT("end") D NOTFND(.PSOHDR) G EXIT
 S PSOLPDT=PSOCLDT("beg")-.1,PSOLPDT("stop")=0  ; PSOLPDT("stop") - flag to exit loop
 F  S PSOLPDT=$O(^PS(52.52,"B",PSOLPDT)) Q:'PSOLPDT!PSOLPDT("stop")!(PSOLPDT>PSOCLDT("end"))  D
 . S PSIEN=0 F  S PSIEN=$O(^PS(52.52,"B",PSOLPDT,PSIEN)) Q:'PSIEN  S X=$G(^PS(52.52,PSIEN,0)) D:$L(X) PRINT(X)
 ;
 D:'PSOLPDT("stop") RPTEND  ; only if user didn't enter '^'
 ;
EXIT ;
 D ^%ZISC Q
 ;
PRINT(OVRDND) ;OVRDND - zero node of entry in file 52.52
 I $Y+7>IOSL D
 . I '$G(ZTSK),$E(IOST,1,2)="C-"  D   ; only if interactive user
 ..  N DIR S DIR(0)="E" D ^DIR S:'Y PSOLPDT("stop")=1
 . I 'PSOLPDT("stop") W @IOF D PGHDR(.PSOHDR)
 N CLUSR,RPTLN,RXCLO,Y
 S RXCLO("rxIen")=+$P(OVRDND,U,2),RXCLO("ntryDuz")=+$P(OVRDND,U,3),RXCLO("apprvDuz")=+$P(OVRDND,U,4),RXCLO("ovrdRsn")=$P(OVRDND,U,6)
 S RXCLO("ntryNm")=$P($G(^VA(200,RXCLO("ntryDuz"),0)),U),RXCLO("apprvNm")=$P($G(^VA(200,RXCLO("apprvDuz"),0)),U)
 S RXCLO("cmmnt")=$P(OVRDND,U,6),RXCLO("rxZroNd")=$S($D(^PSRX(RXCLO("rxIen"),0)):^(0),1:""),RXCLO("rxDfn")=$P(RXCLO("rxZroNd"),U,2),RXCLO("rxDrgIen")=$P(RXCLO("rxZroNd"),U,6),RXCLO("rx#")=$P(RXCLO("rxZroNd"),U)
 I RXCLO("rxIen") S RXCLO("rxPtNm")=$P(^DPT(RXCLO("rxDfn"),0),U),RXCLO("drugNm")=$P($G(^PSDRUG(RXCLO("rxDrgIen"),0)),U)
 S Y=$$FMTE^XLFDT(PSOLPDT,2),RPTLN="Date: "_Y_$J(" ",18-$L(Y))_" Rx #"_$S(RXCLO("rxIen"):RXCLO("rx#"),1:" UNKNOWN (Rx Deleted)")
 S RPTLN=RPTLN_"   Patient: "_$S(RXCLO("rxIen"):RXCLO("rxPtNm"),1:"UNKNOWN")
 W !,RPTLN
 W !,"  Drug: "_$S(RXCLO("rxIen"):RXCLO("drugNm"),1:"UNKNOWN (PRESCRIPTION DELETED)")
 W !,"  Entered by: "_RXCLO("ntryNm")_"  Approved by: "_RXCLO("apprvNm")
 W !,"  Override reason: "_$P(RXCLO("ovrdRsn"),":",2)
 W !,"  Comments: "_RXCLO("cmmnt"),!
 Q
PGHDR(PSOHDR) ; header, PSOHDR passed by ref.
 S PSOHDR(0,"pg#")=PSOHDR(0,"pg#")+1
 U IO W !,PSOHDR(1)_PSOHDR(0,"pg#"),!,PSOHDR(2),! Q
 ;
RPTEND ;
 W !," ** End of Clozapine Override Report **",! Q
QUE ;queue job
 N ZTDESC,ZTRTN,ZTSAVE,ZTSK
 S ZTRTN="DQ^"_$T(+0),ZTDESC="Clozapine Override Report",ZTSAVE("PSOCLDT(")="" D ^%ZTLOAD  ;593 Added ( to ZTSAVE
 W !,$S($G(ZTSK):"Override Report queued as task #"_ZTSK,1:"* Report NOT queued.")
 Q
 ;
NOTFND(PSOHDR) ;
 W !," * No CLOZAPINE PRESCRIPTION OVERRIDES"_PSOHDR(2)_" *",!
 D RPTEND
 Q
 ;
