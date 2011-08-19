IBCROIP ;ALB/ARH - RATES: REPORTS CHARGE ITEM: PROCEDURES ; 12/01/04
 ;;2.0;INTEGRATED BILLING;**287**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
EN ; OPTION ENTRY POINT:  Charge Item report for Procedures Only - get parameters then run the report
 N RATES,DIVS,CPTS,IBBDT,IBEDT,IBCS,IBCS0,IBSUB,IBQUIT,IBSCRPT
 ;
 W !!,"Procedure Charge Report: Print charges for selected CPT procedures.",!
 ;
 D SELRATE(.RATES) Q:'RATES  ;  get billing rates to include
 D SELDIVS(.DIVS) Q:DIVS<0  ;   get divisions
 D SELCPTS(.CPTS) Q:'CPTS  ;    get list of CPT codes
 ;
 S IBBDT=$$GETDT^IBCRU1(DT,"Charges effective beginning on") Q:IBBDT'?7N
 S IBEDT=$$GETDT^IBCRU1(DT,"Charges effective ending on") Q:IBEDT'?7N
 ;
 S IBQUIT=0 D DEV I IBQUIT G EXIT
 ;
RPT ; find, save, and print Charge Item report - entry for tasked jobs  DBIA #2815
 ;
 K ^TMP($J,"IBCROI") S IBSCRPT="IBCROI"
 ;
 S IBCS=0 F  S IBCS=$O(^IBE(363.1,IBCS)) Q:'IBCS  D
 . S IBCS0=$G(^IBE(363.1,IBCS,0))
 . ;
 . I '$D(RATES(+$P(IBCS0,U,2))) Q
 . I DIVS'=1,+$P(IBCS0,U,7) I '$$CHKDV(+$P(IBCS0,U,7),.DIVS) Q
 . ;
 . S IBSUB=+$P(IBCS0,U,4)_U_$P(IBCS0,U,1) ; sort by CT and charge set name
 . ;
 . D GET
 ;
 D PRINT^IBCROI
 ;
EXIT D EXIT^IBCROI
 Q
 ;
 ;
GET ; get charge items for selected procedures
 N IBCPTS,IBC1,IBC2,IBCFIRST,IBCLAST,IBCNEXT,IBCIFN
 ;
 S IBCPTS="" F  S IBCPTS=$O(CPTS(IBCPTS)) Q:IBCPTS=""  D
 . I IBCPTS'?5UN1"-"5UN Q
 . S IBC1=$P(IBCPTS,"-",1),IBCFIRST=$O(^ICPT("B",IBC1),-1)
 . S IBC2=$P(IBCPTS,"-",2),IBCLAST=$O(^ICPT("B",IBC2))
 . ;
 . S IBCNEXT=IBCFIRST F  S IBCNEXT=$O(^ICPT("B",IBCNEXT)) Q:(IBCNEXT="")!(IBCNEXT=IBCLAST)  D
 .. S IBCIFN=$O(^ICPT("B",IBCNEXT,0))
 .. ;
 .. D SRCHITM^IBCROI1(IBCS,IBSUB,3,IBBDT,IBEDT,IBCIFN)
 . ;
 . D TMPHDR^IBCROI1(IBSCRPT,IBSUB,0,"Procedure Charges","1^1",IBBDT,IBEDT)
 Q
 ;
CHKDV(RG,DIVS) ; check if Region contains a selected division (where DIVS is array of divisions)
 N IBDV,IBSEL S IBSEL=0
 I +$O(^IBE(363.31,+$G(RG),11,"B",0)) S IBDV=0 F  S IBDV=$O(DIVS(IBDV)) Q:'IBDV  D  Q:+IBSEL
 . I +$O(^IBE(363.31,RG,11,"B",IBDV,0)) S IBSEL=1
 Q IBSEL
 ;
SELRATE(RATES) ; get rates to review, RATES(ptr to 363.3)=Billing Rate Name returned, or RATES=0 if none selected
 N IBN,IBX,IBY,IBCNT,IBDFLT,IBARR,DIR,DIRUT,DTOUT,DUOUT,X,Y K RATES S RATES=0
 ;
 S IBN="" F  S IBN=$O(^IBE(363.3,"B",IBN)) Q:IBN=""  D
 . S IBX=0 F  S IBX=$O(^IBE(363.3,"B",IBN,IBX)) Q:'IBX  D
 .. S IBY=$G(^IBE(363.3,IBX,0)) I $P(IBY,U,4)'=2 Q
 .. S IBCNT=$G(IBCNT)+1
 .. ;
 .. I $E(IBY,1,3)="RC " S IBDFLT=$G(IBDFLT)_IBCNT_","
 .. S IBARR(IBCNT)=IBX_U_IBN,IBARR=IBCNT
 ;
 W !,"Select Charge Billing Rates:"
 S IBCNT=0  F  S IBCNT=$O(IBARR(IBCNT)) Q:'IBCNT  W !,?10,IBCNT," - ",$P(IBARR(IBCNT),U,2)
 ;
 S DIR(0)="LO^1:"_IBARR_":0",DIR("A")="Charge Rates",DIR("B")=IBDFLT D ^DIR Q:$$QUIT
 ;
 F IBX=1:1:20 S IBCNT=$P(Y,",",IBX) Q:'IBCNT  S IBY=IBARR(IBCNT),RATES=$G(RATES)+1,RATES(+IBY)=$P(IBY,U,2)
 ;
 Q
 ;
SELDIVS(VAUTD) ; Issue prompt for Division (ALL: VAUTD=1,  SELECT: VAUTD=0, VAUTD(DV ptr)=DV Name, ELSE: VAUTD=-1)
 N Y D PSDR^IBODIV I Y<0 K VAUTD S VAUTD=-1
 Q
 ;
SELCPTS(CPTS) ; Select CPT Codes, returned in array ranges separated by dash, external form, or CPTS=0 if none selected
 ; will only allow ranges with matching first character because of length
 N IBI,IBCOD,IBCOD1,IBCOD2,DIC,DIR,DIRUT,DTOUT,DUOUT,X,Y K CPTS S CPTS=0
 ;
 S DIR("?")="Enter a CPT/HCPCS code or range of codes separated by a dash"
 S DIR("A")="Select CPT/HPCS Codes",DIR(0)="FO^^"
 ;
 F IBI=1:1 D ^DIR Q:$$QUIT  D
 . S IBCOD=$$UP^XLFSTR(Y),IBCOD1=$P(IBCOD,"-",1),IBCOD2=$P(IBCOD,"-",2)
 . ;
 . I IBCOD["-" S IBCOD1=$$LJ^XLFSTR(IBCOD1,5,0),IBCOD2=$$LJ^XLFSTR(IBCOD2,5,0)
 . I IBCOD'["-" S IBCOD1=$P($$CPTDIC(IBCOD),U,2),IBCOD2=IBCOD1 I IBCOD1="" W ?36,"??" Q
 . ;
 . I (IBCOD1'?5UN)!(IBCOD2'?5UN) W ?36,"??" Q
 . I IBCOD1'=IBCOD2,IBCOD2']IBCOD1 W ?36,IBCOD1,"-",IBCOD2," Invalid Range" Q
 . I $E(IBCOD1,1)'=$E(IBCOD2,1) W ?36,"Range too large, first character must match" Q
 . ;
 . S IBCOD=IBCOD1_"-"_IBCOD2 S CPTS=$G(CPTS)+1,CPTS(IBCOD)=""
 ;
 Q
 ;
CPTDIC(CODE) ; inquiry on CPT code, returns null or 'internal^external'
 N IBX,DIC,DUOUT,DTOUT,I,X,Y S IBX="" I $G(CODE)'="" S X=CODE,DIC="^ICPT(",DIC(0)="EM" D ^DIC I Y>1 S IBX=Y
 Q IBX
 ;
 ;
QUIT() N IBX S IBX=0 I ($G(Y)="")!($D(DIRUT))!($D(DUOUT))!($D(DTOUT)) S IBX=1
 Q IBX
 ;
DEV ; get device
 S IBQUIT=0 S %ZIS="QM",%ZIS("A")="OUTPUT DEVICE: " D ^%ZIS I POP S IBQUIT=1 Q
 I $D(IO("Q")) S ZTRTN="RPT^IBCROIP",ZTDESC="Charge Procedure Report",ZTSAVE("IB*")="",ZTSAVE("RATES(")="",ZTSAVE("CPTS(")="",ZTSAVE("DIVS(")="",ZTSAVE("DIVS")="" D ^%ZTLOAD K IO("Q") S IBQUIT=1
 Q
