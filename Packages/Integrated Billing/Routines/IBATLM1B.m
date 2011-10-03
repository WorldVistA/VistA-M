IBATLM1B ;LL/ELZ - TRANSFER PRICING TRANSACTION LIST MENU ; 15-SEP-1998
 ;;2.0;INTEGRATED BILLING;**115,261,389**;21-MAR-94;Build 6
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
CF ; -- change facility from patient level
 D LMOPT^IBATUTL,CFP^IBATLM0A(DFN),HDR^IBATLM1
 Q
CS ; -- change status of patient from patient level
 D LMOPT^IBATUTL,CSP^IBATLM0A(DFN),HDR^IBATLM1
 Q
CT ; -- cancel a transaction
 N IBVAL,DIE,DA,DR,DTOUT,%
 D LMOPT^IBATUTL,EN^VALM2($G(XQORNOD(0)))
 S (DA,IBVAL)=0,IBVAL=$O(VALMY(IBVAL)) Q:'IBVAL
 S DA=$O(@VALMAR@("INDEX",IBVAL,DA))
 I $P(^IBAT(351.61,DA,0),U,5)="X" W !!,"Transaction already cancelled!" D H Q
 W !!,"Are you sure you want to cancel this transaction"
 S %=2 D YN^DICN Q:%'=1
 D CANC^IBATFILE(DA),ARRAY^IBATLM1A(VALMAR)
 Q
CD ; -- change the current date range for transactions displayed
 N IBSAVE S IBSAVE=IBBDT_"^"_IBEDT
 D LMOPT^IBATUTL
 I $$SLDR^IBATUTL S IBBDT=$P(IBSAVE,"^"),IBEDT=$P(IBSAVE,"^",2)
 D ARRAY^IBATLM1A(VALMAR),HDR^IBATLM1
 Q
CP ; -- change the currently selected patient
 N IBDFN
 D LMOPT^IBATUTL
 S IBDFN=$$SLPT^IBATUTL I 'IBDFN Q
 I $$SLDR^IBATUTL Q
 S DFN=IBDFN K ^TMP("VALM DATA",$J),^TMP("VALMAR",$J)
 D HDR^IBATLM1,ARRAY^IBATLM1A(VALMAR)
 Q
AT ; -- add a transaction
 N X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 D LMOPT^IBATUTL
 S DIR(0)="SMBA^I:Inpatient;O:Outpatient;P:Prescription;R:Prosthetic"
 S DIR("A")="Select type of Transaction to add: " D ^DIR Q:$D(DIRUT)
 D @Y K ^TMP("VALM DATA",$J),^TMP("VALMAR",$J)
 D HDR^IBATLM1,ARRAY^IBATLM1A(VALMAR)
 Q
I ; -- select an inpatient stay and add
 N IBXA,IBADM,DIRUT,IBIEN,VAIP,IBCHARGE,IBPPF,IBRES
 S IBXA=7,IBADM=+$$ADSEL^IBECEA31(DFN) Q:IBADM<0
 I IBADM=0 W !!,"Patient has no admissions on file." D H Q
 D DUP(IBADM_";DGPM(",.DIRUT)
 I $D(DIRUT) D H Q
 S VAIP("E")=IBADM D IN5^VADPT S IBPPF=$$PPF^IBATUTL(DFN)
 S IBIEN=$$ADM^IBATFILE(DFN,+VAIP(13,1),IBPPF,(+IBADM)_";DGPM(")
 I 'IBIEN D M(,$P(IBIEN,"^",2)) Q
 I '$G(VAIP(17)) D M(IBIEN,"missing discharge information") Q
 S IBRES=$$DIS^IBATFILE(IBIEN,+VAIP(17,1),VAIP(12),VAIP(17))
 I 'IBRES D M(IBIEN,$P(IBRES,"^",2)) Q
 S IBFINDRT=$$FINDRT^IBATEI(VAIP(12),VAIP(13),DFN)
 I '+IBFINDRT D M(IBIEN,"Cannot price transaction") Q
 I $P(IBFINDRT,"^",3)="B" S IBRES=$$INPT^IBATFILE(IBIEN,0,0,$P(IBFINDRT,"^",4),0,$P(IBFINDRT,"^",4),$P(IBFINDRT,"^",7))
 E  S IBRES=$$INPT^IBATFILE(IBIEN,$P(IBFINDRT,"^",3),$P(IBFINDRT,"^",2),$P(IBFINDRT,"^",4),$P(IBFINDRT,"^",5),$P(IBFINDRT,"^",6),$P(IBFINDRT,"^",7))
 I 'IBRES D M(IBIEN,"Error in filling pricing information") Q
 D M(IBIEN)
 Q
M(X,Y) ; Prints message and hangs
 N IBSITE S IBSITE=$$SITE^IBATUTL
 I $D(X) W !,"Transaction #",IBSITE,X," Added"
 I $D(Y) W !,"Cannot complete, ",Y
 D H
 Q
O ; -- select an outpatient stay
 N X,Y,DIR,DTOUT,DUOUT,DIRUT,DIROUT,IBDATA,IBX,IBC,CPTLIST,IBIEN,IBFAC
 K ^TMP("IBAT",$J)
 S DIR(0)="D^::AEPX",DIR("A")="Visit Date" D ^DIR Q:$D(DIRUT)
 S IBDATA("DFN")=DFN,IBDATA("BDT")=Y,IBDATA("EDT")=Y+.99999
 ;
 ; scan for the appointments and set up tmp global
 ; screen to eliminate children and inpatient appointments
 D SCAN^IBSDU("PATIENT/DATE",.IBDATA,"I '$P(Y0,""^"",6),$P(Y0,""^"",12)'=8","S ^TMP(""IBAT"",$J,Y)=Y0","")
 ;
 I '$D(^TMP("IBAT",$J)) W !!,"No appointments exist for the date!" D H Q
 W !,?10,"Choose which Visit:" S IBX=0
 F IBC=1:1 S IBX=$O(^TMP("IBAT",$J,IBX)) Q:IBX<1  S IBDATA=^(IBX) D
 . W !,?4,IBC,?10,$$FMTE^XLFDT($P(IBDATA,"^"),"1P")
 . W ?35,$$EX^IBATUTL(409.68,.04,$P(IBDATA,"^",4))
 . W ?55,$$EX^IBATUTL(409.68,.12,$P(IBDATA,"^",12))
 S DIR(0)="N^1:"_(IBC-1),DIR("A")="Select" D ^DIR Q:$D(DIRUT)
 S IBX=0 F IBC=1:1:Y S IBX=$O(^TMP("IBAT",$J,IBX))
 ; check for duplicates
 D DUP(IBX_";SCE(",.DIRUT) I $D(DIRUT) D H Q
 ; setup visit info
 S IBX(0)=^TMP("IBAT",$J,IBX)
 D GETCPT^SDOE(IBX,"CPTLIST") ;GETDX^SDOE(IBX,"DXLIST")
 S IBFAC=$$PPF^IBATUTL(DFN)
 ; ok now lets format cpts and price
 S IBIEN=0 F  S IBIEN=$O(CPTLIST(IBIEN)) Q:IBIEN<1  D
 . N IBCPT,IBQTY,IBPRICE
 . S IBCPT=$P(CPTLIST(IBIEN),"^"),IBQTY=$P(CPTLIST(IBIEN),"^",16)
 . S IBPRICE=$$OPT^IBATCM(IBCPT,$P(IBX(0),"^"),IBFAC)
 . S IBIEN(IBCPT)=IBQTY_"^"_$S(IBPRICE:$P(IBPRICE,"^",4),1:0)
 S IBIEN=$$OUT^IBATFILE(DFN,$P(IBX(0),"^"),IBFAC,IBX_";SCE(",.IBIEN)
 W !!,"Transaction Number ",$P(^IBAT(351.61,IBIEN,0),"^")," Added!" D H
 K ^TMP("IBAT",$J)
 Q
P ; -- select an rx
 N IBRX,IBPSRX,IBOUT,IBCOUNT,DIRUT,DIR,IBP,IBNUM,IBSITE,IBQUIT,IBBDT,IBEDT
 S (IBCOUNT,IBOUT)=0
 Q:$$SLDR^IBATUTL
 D RX^IBATRX(DFN,IBBDT,IBEDT,.IBRX)
 I '$D(IBRX) W !!,"No Rx's on file for date range selected." D H Q
 W @IOF,!,"Prescriptions Issued:",!
 S IBPSRX=0 F  S IBPSRX=$O(IBRX(IBPSRX)) Q:IBPSRX=""!(IBOUT)  D
 . S IBDT=0 F  S IBDT=$O(IBRX(IBPSRX,IBDT)) Q:IBDT<1!(IBOUT)  D
 .. S IBDAT=IBRX(IBPSRX,IBDT),IBCOUNT=IBCOUNT+1
 .. W !,IBCOUNT,?4,$$FMTE^XLFDT(IBDT,"5D"),?18,$P(IBDAT,"^")
 .. W "(",$P(IBDAT,"^",2),")",?35,$E($P(IBDAT,"^",4),1,27)
 .. W ?65,$J($FN($P(IBDAT,"^",5)*$P(IBDAT,"^",6),",",2),12)
 .. ;I $Y+4>IOSL D H X:'$D(DIRUT) "W @IOF,!" I $D(DIRUT) S IBOUT=1 Q
 .. S IBNUM(IBCOUNT)=IBPSRX_"^"_IBDT
 W ! K DIRUT S DIR(0)="L^1:"_IBCOUNT,DIR("A")="Which Prescriptions"
 D ^DIR Q:$D(DIRUT)  W !!,"Selected number(s): "_Y S IBNUM=Y
 W !,"Ok to add: " S %=1 D YN^DICN I %'=1 D H Q
 S IBFAC=$$PPF^IBATUTL(DFN),IBSITE=$$SITE^IBATUTL
 F IBP=1:1 S IBRX=$P(IBNUM,",",IBP) Q:'IBRX  D
 . S IBRX(0)=IBRX($P(IBNUM(IBRX),"^"),$P(IBNUM(IBRX),"^",2))
 . D DUP($P(IBRX(0),"^")_";PSRX(;"_$P(IBRX(0),"^",2),.IBQUIT)
 . I $G(IBQUIT) K IBQUIT Q
 . W !!,"Adding Transaction number ",IBSITE
 . W $$RX^IBATFILE(DFN,$P(IBNUM(IBRX),"^",2),IBFAC,$P(IBRX(0),"^")_";PSRX(;"_$P(IBRX(0),"^",2),$P(IBRX(0),"^",3),$P(IBRX(0),"^",5),$P(IBRX(0),"^",6))
 . W "!" H 1
 D H
 Q
R ; -- select an prosthetic
 N IBBDT,IBEDT,IBCOUNT,IBOUT,IBDA,IBDATA,IBDATA1,IBP,IBC,IBCOUNT,%,DIRUT
 ;
 S (IBCOUNT,IBOUT)=0
 Q:$$SLDR^IBATUTL
 ;
 ; look up prosthetic devices issued
 S IBDA="" F  S IBDA=$O(^RMPR(660,"C",DFN,IBDA)) Q:'IBDA  D
 . ;
 . ; valid data
 . S IBDATA=$G(^RMPR(660,+IBDA,0)) Q:IBDATA=""  S IBDATA1=$G(^RMPR(660,+IBDA,1))
 . ;
 . ; valid date range
 . I $P(IBDATA,"^",12)<IBBDT!($P(IBDATA,"^",12)>IBEDT) Q
 . ;
 . ; checks from RMPRBIL copied 4/7/2000 with mod for AM node patients
 . I $S('$D(^RMPR(660,IBDA,"AM")):1,$P(IBDATA,"^",9)="":1,$P(IBDATA,"^",12)="":1,$P(IBDATA1,"^",4)="":1,$P(IBDATA,"^",14)="V":1,$P(IBDATA,"^",15)="*":1,1:0) Q
 . ;
 . ; set array
 . S IBCOUNT=IBCOUNT+1,IBP(IBCOUNT,IBDA)=IBDATA
 ;
 I 'IBCOUNT W !!,"No Prosthetic Devices on file for date range selected." D H Q
 ;
 W @IOF,!,"Prosthetic Devices Issued:",!
 F IBC=1:1:IBCOUNT Q:IBOUT  D
 . S IBDATA=IBP(IBC,$O(IBP(IBC,0)))
 . W !,IBC,?4,$$FMTE^XLFDT($P(IBDATA,"^",12),"5D")
 . W ?20,$E($P($$PIN^IBATUTL($O(IBP(IBC,0))),U,2),1,28),?50,"("
 . W $$EX^IBATUTL(660,62,$P(^RMPR(660,$O(IBP(IBC,0)),"AM"),"^",3)),")"
 . W ?65,$J($FN($P(IBDATA,"^",16),",",2),12)
 ;
 W ! K DIRUT S DIR(0)="N^1:"_IBCOUNT_":0"
 S DIR("A")="Which Prosthetic Device" D ^DIR Q:$D(DIRUT)  S IBC=+Y
 W !,"Ok to add: " S %=1 D YN^DICN I %'=1 D H Q
 S IBDA=$O(IBP(IBC,0)),IBDATA=IBP(IBC,IBDA)
 D DUP(IBDA_";RMPR(660,",.DIRUT)
 I $D(DIRUT) D H Q
 W !!,"Adding Transaction number ",$$SITE^IBATUTL
 W $$RMPR^IBATFILE(DFN,$P(IBDATA,"^",12),$$PPF^IBATUTL(DFN),(IBDA_";RMPR(660,"),,$P(IBDATA,"^",16))
 W "!" H 1
 D H
 Q
H ; -- page reader
 N DIR,X,Y,DTOUT,DUOUT,DIROUT
 W !! S DIR(0)="E" D ^DIR
 Q
DUP(IBSOURCE,IBQUIT) ; -- checks for dups that are not cancelled
 N IBT S IBT=0
 F  S IBT=$O(^IBAT(351.61,"AD",IBSOURCE,IBT)) Q:IBT<1!($D(IBQUIT))  D
 . Q:$P(^IBAT(351.61,IBT,0),"^",5)="X"
 . W !,$S(IBSOURCE["SCE(":"Visit",IBSOURCE["DGPM(":"Admission",IBSOURCE["RMPR(":"Prosthetic",1:"Prescription")," exists already!" S IBQUIT=1
 Q
