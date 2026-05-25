PSOOCPGX ;BIR/KML - OUTPATIENT PHARMACY PGx ORDER CHECKS DRIVER ;9/10/14 10:53pm
 ;;7.0;OUTPATIENT PHARMACY;**737**;DEC 1997;Build 52
 ;
 ;External reference to PGXOC^PSSPGX is supported by ICR #7526
 ;External reference to $$PROD0^PSNAPIS(P1,P3) supported by ICR #2531
 ;External reference to $$PGX^PSNAPIS supported by ICR #2574
 ;
 Q
 ;
GETPGX(PSODFN,PSODRUG) ; called by POST^PSODRG
 ; input - PSODRUG = array of data from DRUG entry in file 50
 ;           PSODFN = patient identifier DFN
 Q:+$G(PSODGCK)  ;Not perform PGx OC from Check Interactions hidden action yet. PSODRUG may still hang around from the CK action.
 N PSOQUIT,PSORETURN,PSODRARRAY,PSODRUGDA
 S PSODRUGDA=$G(PSODRUG("IEN")),PSODRARRAY(PSODRUGDA)="",PSODRARRAY(PSODRUGDA,"DRUGNAME")=$G(PSODRUG("NAME"))
 D PGXOC^PSSPGX("PSOPGX",PSODFN,.PSODRARRAY,.PSORETURN,"O") ; call to PDM to request Order Check Results/Warnings
 I $D(^TMP($J,"PSSXWARN")) D DISPWARN
 K ^TMP($J,"PSSXWARN")
 Q
 ;
DISPWARN ;
 N PSOS4,PSOS5,PSOSEV,PSOSOP,DIR,PSOTAG,PRINT,PSOTXT,PSOEFLG
 S (PSOS4,PSOS5,PSOSOP,PRINT)=0
 ; loop through any warnings created
 F PSOSEV="ERROR","HIGH","MEDIUM","NONE" S PSOS4=0 F  S PSOS4=$O(^TMP($J,"PSSXWARN",PSOSEV,PSOS4)) Q:'PSOS4  D
 . W:'+$G(PSOEFLG) @IOF K PSOEFLG
 . S PSOS5=0 F  S PSOS5=$O(^TMP($J,"PSSXWARN",PSOSEV,PSOS4,PSOS5)) Q:'PSOS5  D
 . . I (PSOSEV="ERROR"),'$O(^TMP($J,"PSSXWARN",PSOSEV)) S PSOEFLG=1
 . . S PSOTXT=^TMP($J,"PSSXWARN",PSOSEV,PSOS4,PSOS5)
 . . I PSOSEV="ERROR" I ($Y+5)>IOSL,(PSOTXT["For more details") D PAUSE(1)
 . . I ($Y+4)>IOSL D PAUSE(1)
 . . W !,PSOTXT
 . I +$O(^TMP($J,"PSSXWARN",PSOSEV,PSOS4)) D PAUSE(1)
 . I '$D(^XUSEC("PSORPH",DUZ)),'$P($G(PSOPAR),"^",2),PSOSEV="HIGH" D MESS
 . S PRINT=0 I (PSOSEV="MEDIUM")!(PSOSEV="HIGH") S PRINT=$$ASKAI()
 . I PRINT D ADDINFO(PSOSEV,PSOS4)
 . Q:'$D(^XUSEC("PSORPH",DUZ))   ; need to be a pharmacist to create an intervention
 . S PSOTAG=$S(PSOSEV="HIGH":"REQINTERV",PSOSEV="MEDIUM":"OPTINTERV",1:"")
 . D:PSOTAG]"" @PSOTAG
 D PAUSE(1)
 Q
 ;
OPTINTERV ;Prompt end user for optional intervention
 N DIR,DTOUT,DIRUT,DIROUT,DUOUT,Y,X
 S DIR(0)="SA^1:YES;0:NO",DIR("A")="Do you want to Intervene? ",DIR("B")="NO"
 S DIR("?",1)="Answer 'YES' if you DO want to enter an intervention for this medication,"
 S DIR("?")="       'NO' if you DON'T want to enter an intervention for this medication,"
 W ! D ^DIR
 ; line below: already in the stack -  RX ien (PSORXIEN) for VERIFY and REINSTATE actions (PSOZVER and PSOREINO respectively)
 I Y D ENPGX^PSORXI("PHARMACOGENOMIC MEDIUM ORDER CHECK",$S($G(PSOZVER):$G(PSORXIEN),$G(PSOREINO):$G(PSORXIEN),1:""))
 W !
 Q
 ; 
REQINTERV ;Prompt end user for required intervention
 N DIR,DTOUT,DIRUT,DIROUT,DUOUT,Y,X
 W !
 S DIR(0)="SA^1:YES;0:NO",DIR("A")="Do you want to Continue? ",DIR("B")="NO"
 I $G(PSODRUG("NAME"))]"" S DIR("A")="Do you want to Continue with "_$G(PSODRUG("NAME"))_"? "
 S DIR("?",1)="Enter 'NO' if you wish to exit without continuing with the order,",DIR("?")="or 'YES' to continue with the order entry process."
 D ^DIR
 I 'Y S PSORX("DFLG")=1  ; PSONEW("DFLG") is set when end-user needs to quit processing the order
 I Y D
 . N X1 D SIG^XUSESIG I X1="" W !!,"Signature Code not valid." S PSORX("DFLG")=1 H 1 Q
 . ; line below: already in the stack -  RX ien (PSORXIEN) for VERIFY and REINSTATE actions (PSOZVER and PSOREINS respectively)
 . D ENPGX^PSORXI("PHARMACOGENOMIC HIGH ORDER CHECK",$S($G(PSOZVER):$G(PSORXIEN),$G(PSOREINS):$G(PSORXIEN),1:"")) ; ; pass in RX ien for VERIFY and REINSTATE actions
 Q
 ;
ASKAI() ;  additional information prompt
 N DIR,DIRUT,DUOUT,DTOUT,DIROUT
 S DIR("A")="Display Additional Information on Pharmacogenomic Order Check(s)"
 s DIR("B")="NO",DIR(0)="Y"
 S DIR("?",1)="Enter 'YES' to see the additional information on Pharmacogenomic Order Check."
 S DIR("?")=" "
 D ^DIR K DIR
 Q $S(+Y=1:1,1:0)
 ;
ADDINFO(PSOSEV,PSOS4) ;Display additional information
 N ZTDESC,ZTRTN,ZTSAVE
 N IOP,%ZIS,POP
 S %ZIS="QM"
 W ! D ^%ZIS
 Q:POP
 I $D(IO("Q")) D  Q
 .S ZTRTN="PRINTAI^PSOOCPGX",ZTDESC="Pharmacogenomic Order Check - Additional Information"
 .S ZTSAVE("^TMP($J,""PSSXWARN"",")="",ZTSAVE("PSOSEV")="",ZTSAVE("PSOS4")=""
 .D ^%ZTLOAD,^%ZISC
 .I $G(ZTSK) W !,"Pharmacogenomic Additional Information Queued, task# ",ZTSK,".",! S:$D(ZTQUEUED) ZTREQ="Q"
 D PRINTAI,^%ZISC
 Q
 ;
PRINTAI ;
 U IO
 I $E(IOST)="C" W @IOF
 N PSOX1,DIR,Y,STOP
 S (PSOX1,STOP)=0
 S PSOX1=0 F  S PSOX1=$O(^TMP($J,"PSSXWARN",PSOSEV,PSOS4,"AI",PSOX1)) Q:'PSOX1  Q:STOP  D
 . W !,^TMP($J,"PSSXWARN",PSOSEV,PSOS4,"AI",PSOX1)
 . I $Y+4>IOSL,$E(IOST)="C" D
 . . W ! S DIR(0)="EA",DIR("A")="Press Return to continue..."
 . . D ^DIR
 . . I 'Y S STOP=1 Q
 . . W @IOF
 Q
 ;
PAUSE(PSOIOF) ;
 W ! S DIR(0)="EA",DIR("A")="Press ENTER to continue ..." D ^DIR W:$G(PSOIOF) @IOF
 Q
 ;
BLD(PSOXDFN,PSOPGXS) ;
 N PSOPGXCT,PSOXINDX,X,Y,X1,X2
 K ^TMP($J,"ORDERS") I '$G(PSOXDFN) Q
 I '$G(DT) S DT=$$DT^XLFDT
 I '$G(PSOPGXS) S PSOPGXS=120
 S X1=DT,X2=-PSOPGXS D C^%DTC S PSOPGXCT=X D BUILD
 Q
BUILD ;build profiles
 N PSOPGXEX,PSOPGXRX,PSOEN,PSOEN1,PSOOI,PSODD
 S PSOPGXEX=PSOPGXCT-1,PSOPGXRX=0
 F  S PSOPGXEX=$O(^PS(55,PSOXDFN,"P","A",PSOPGXEX)) Q:'PSOPGXEX  F  S PSOPGXRX=$O(^PS(55,PSOXDFN,"P","A",PSOPGXEX,PSOPGXRX)) Q:'PSOPGXRX  I $D(^PSRX(PSOPGXRX,0)) D GET
 S PSOEN1=0
 F PSOEN=0:0 S PSOEN=$O(^PS(52.41,"AOR",PSOXDFN,PSOEN)) Q:'PSOEN  D
 .F  S PSOEN1=$O(^PS(52.41,"AOR",PSOXDFN,PSOEN,PSOEN1)) Q:'PSOEN1  D
 ..Q:'$P(^PS(52.41,PSOEN1,0),"^",8)
 ..S PSOOI=^PS(52.41,PSOEN1,0)
 ..I $P(PSOOI,"^",3)'="DC"&($P(PSOOI,"^",3)'="DE") D
 ...I '$P(^PS(52.41,PSOEN1,0),"^",9) D BLDOI Q
 ...S PSODD=+$P(PSOOI,"^",9) D SETTMP
 Q
 ;
BLDOI ;If no DD/non-standard dose, get all drugs for OI
 N PSOI S PSOI=$P(PSOOI,"^",8) Q:'PSOOI
 S PSODD="" F  S PSODD=$O(^PSDRUG("ASP",PSOI,PSODD)) Q:'PSODD  D SETTMP
 Q
 ;
SETTMP ;Create ^TMP($J,"ORDERS"
 N PSOXDRG
 Q:$P(PSOOI,"^",3)="RF"
 S PSOXDRG=$S(PSODD:$P($G(^PSDRUG(PSODD,0)),"^"),1:"") Q:PSOXDRG']""
 S PSOXINDX=$G(PSOXINDX)+1,^TMP($J,"ORDERS",PSOXINDX)=$S(PSODD:$P(^PSDRUG(PSODD,0),"^",2),1:"")_"^"_$S($G(^PSDRUG(PSODD,"ND"))]"":+^("ND")_"A"_$P(^("ND"),"^",3),1:0)_"^"_PSOXDRG_"^"_$P(^PS(52.41,PSOEN1,0),"^")_"^"_PSOEN1_"P;O"
 Q
 ;
GET ;data for profiles
 N PSOPGX0,PSOPGX2,PSOPGXST,PSOPGXOR,PSOPGXDG,PSOPGXD0,PSOPGXVC
 S PSOPGX0=^PSRX(PSOPGXRX,0),PSOPGXST=+^("STA") Q:(PSOPGXST'=0)&(PSOPGXST'=3)&(PSOPGXST'=5)&(PSOPGXST'=11)&(PSOPGXST'=16)
 S PSOPGX2=$G(^PSRX(PSOPGXRX,2)),PSOPGXOR=$P($G(^("OR1")),"^",2)
 S PSOPGXDG=+$P(PSOPGX0,"^",6) Q:'$D(^PSDRUG(PSOPGXDG,0))
 S PSOPGXD0=^PSDRUG(PSOPGXDG,0),PSOPGXVC=$P(PSOPGXD0,"^",2)
 ;
 I PSOPGXEX<DT,(PSOPGXST<6)!(PSOPGXST=16) D
 .N DIE,DIC,DR,DA,PSOGSTAT,PSOGCOMM,PSOPGXDA,PSOPSTAT S PSOGSTAT="SC",DIE=52,DA=PSOPGXRX,DR="100////11" D ^DIE K DIE,DIC,DR,DA
 .D ECAN^PSOUTL(PSOPGXRX) S PSOPGXDA=PSOPGXRX
 .S PSOGCOMM="Prescription Expired",PSOPSTAT="ZE" D EN^PSOHLSN1(PSOPGXDA,PSOGSTAT,PSOPSTAT,PSOGCOMM)
 S PSOXINDX=$G(PSOXINDX)+1
 S ^TMP($J,"ORDERS",PSOXINDX)=PSOPGXVC_"^"_$S($G(^PSDRUG(PSOPGXDG,"ND"))]"":+^("ND")_"A"_$P(^("ND"),"^",3),1:0)_"^"_$P(^PSDRUG(PSOPGXDG,0),"^")_"^"_PSOPGXOR_"^"_PSOPGXRX_"R;O"
 Q
 ;
MESS ;display technician message
 N DIR,DUOUT,DTOUT,DIRUT,DIROUT,DA,DR,X,Y
 W !?3,"WARNING: Unlike other orders with Critical Order Checks, this order will"
 W !?3,"not be placed in a Non-Verified status for pharmacist verification after"
 W !?3,"you process it. If you are unsure about this order, please stop processing"
 W !?3,"by '^'ing out, and consult a pharmacist.",!
 K DIR S DIR(0)="E",DIR("A")="  Press Return to continue" D ^DIR K DIR W !
 Q
