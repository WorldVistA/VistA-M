ENFARC ;WIRMFO/SAB-FIXED ASSET RPT, TRANSACTION REGISTER; 6/30/97
 ;;7.0;ENGINEERING;**39**;Aug 17, 1993
EN ; Report FAP Documents (FA, FB, FC, FD, and FR) during Selected Period
 ;
ASKDATE ; ask start date
 S DIR(0)="D^::EX",DIR("A")="Start Date"
 S ENX("Y")=$E(DT,1,3),ENX("M")=$E(DT,4,5)
 S ENX=$S(ENX("M")="01":(ENX("Y")-1)_"12",1:ENX("Y")_$E("00",1,2-$L(ENX("M")-1))_(ENX("M")-1))_"01"
 S DIR("B")=$$FMTE^XLFDT(ENX,"2D")
 D ^DIR K DIR,ENX G:$D(DIRUT) EXIT
 S ENDTS=Y
 ; ask end date
 S DIR(0)="D^::EX",DIR("A")="End Date"
 S ENDTE=$$EOM^ENUTL(ENDTS)
 S DIR("B")=$$FMTE^XLFDT(ENDTE,"2D")
 D ^DIR K DIR G:$D(DIRUT) EXIT
 I Y<ENDTS W $C(7),!,"End date must be after start date!",! G ASKDATE
 S ENDTE=Y
 ; ask about adjustment vouchers
 S DIR(0)="Y",DIR("A")="Include Adjustment Voucher data",DIR("B")="YES"
 S DIR("?",1)="Answer YES if you want adjustment voucher reason codes"
 S DIR("?",2)="and comments (if any) to print with the FAP Documents."
 S DIR("?",3)=" "
 S DIR("?")="Enter 'Y' or 'N'"
 D ^DIR K DIR G:$D(DIRUT) EXIT
 S ENAV=Y
 ; ask device
 S %ZIS="QM" D ^%ZIS G:POP EXIT
 I $D(IO("Q")) D  G EXIT
 . S ZTRTN="QEN^ENFARC1",ZTDESC="Transaction Register Report"
 . F X="ENDTS","ENDTE","ENAV" S ZTSAVE(X)=""
 . D ^%ZTLOAD,HOME^%ZIS K ZTSK
 D QEN^ENFARC1
EXIT ;
 K DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 K ENAV,ENDTE,ENDTS
 Q
 ;ENFARC
