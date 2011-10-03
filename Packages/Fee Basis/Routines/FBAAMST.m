FBAAMST ;WCIOFO/SAB-MST REPORT ;6/12/2001
 ;;3.5;FEE BASIS;**30**;JAN 30, 1995
 ;
 ; locate POV for MST
 S FBPOV=$$POV^FBAAUTL3("55")
 I FBPOV'>0 D  G EXIT
 . W $C(7),!,"Purpose of Visit Code 55 (MST) not found.  Can't print the MST report."
 ;
 ; ask dates
 S DIR(0)="D^::EX",DIR("A")="From Date"
 ;   default from date is first day of previous month
 S DIR("B")=$$FMTE^XLFDT($E($$FMADD^XLFDT($E(DT,1,5)_"01",-1),1,5)_"01")
 D ^DIR K DIR G:$D(DIRUT) EXIT
 S FBDT1=Y
 S DIR(0)="DA^"_FBDT1_"::EX",DIR("A")="To Date: "
 ;   default to date is last day of specified month
 S X=FBDT1 D DAYS^FBAAUTL1
 S DIR("B")=$$FMTE^XLFDT($E(FBDT1,1,5)_X)
 D ^DIR K DIR G:$D(DIRUT) EXIT
 S FBDT2=Y
 ;
 ; ask if summary or detail
 S DIR(0)="S^S:Summary;D:Detail"
 S DIR("A")="Summary or Detail Output",DIR("B")="Summary"
 S DIR("?",1)="Enter D to print veteran, authorization, and payment details."
 S DIR("?",2)="Enter S to just print a report summary."
 S DIR("?")="Enter a code from the list."
 D ^DIR K DIR G:$D(DIRUT) EXIT
 S FBDETAIL=$S(Y="D":1,1:0)
 ;
 ; ask device
 S %ZIS="QM" D ^%ZIS G:POP EXIT
 I $D(IO("Q")) D  G EXIT
 . S ZTRTN="QEN^FBAAMST",ZTDESC="MST Report"
 . F FBX="FBPOV","FBDT*","FBDETAIL" S ZTSAVE(FBX)=""
 . D ^%ZTLOAD,HOME^%ZIS K ZTSK
 ;
QEN ; queued entry
 U IO
 ;
GATHER ; collect and sort data
 K ^TMP($J)
 ; initialize totals
 F I="PATIENT","VISIT","AMTPAID" F J="F","M","U","T" S FBT(I,J)=0
 ;
 S FBQUIT=0
 ; loop thru Fee Basis Patients
 S FBC=0
 S FBDFN=0 F  S FBDFN=$O(^FBAAA(FBDFN)) Q:'FBDFN  D  Q:FBQUIT
 . S FBC=FBC+1
 . I $D(ZTQUEUED),FBC\1000,$$S^%ZTLOAD S ZTSTOP=1,FBQUIT=1 Q
 . ;
 . ; search for MST authoriztions that match criteron
 . S FBFNDAUT=0 ; init flag, true if 1 or more MST authorizations
 . ; loop thru authorizations
 . S FBAU=0 F  S FBAU=$O(^FBAAA(FBDFN,1,FBAU)) Q:'FBAU  D
 . . S FBA=$G(^FBAAA(FBDFN,1,FBAU,0))
 . . Q:$P($G(^FBAAA(FBDFN,1,FBAU,"ADEL")),U)  ; austin deleted
 . . Q:$P(FBA,U,7)'=FBPOV  ; not MST purpose of visit
 . . ; ensure authorization is not outside the period of interest
 . . Q:$P(FBA,U)>FBDT2  ; auth from date after specified rpt end
 . . Q:$P(FBA,U,2)<FBDT1  ; auth to date before specified rpt begin
 . . ; passed all criteria
 . . I 'FBFNDAUT D
 . . . ; this is the first MST authorization selected for patient
 . . . ; get patient name
 . . . S FBPNAME=$$GET1^DIQ(161,FBDFN,.01)
 . . . S:FBPNAME="" FBPNAME="UNKNOWN"
 . . . ; get gender 
 . . . S DFN=FBDFN K VAPTYP,VAHOW,VAROOT D DEM^VADPT
 . . . S FBGEN=$P(VADM(5),U) ; gender internal value
 . . . S FBSSN=$P(VADM(2),U,2) ; SSN external value 
 . . . I "^F^M^"'[(U_FBGEN_U) S FBGEN="U"
 . . . ; increment count of unique patients
 . . . S FBT("PATIENT",FBGEN)=FBT("PATIENT",FBGEN)+1
 . . . S ^TMP($J,"FBA",FBPNAME_U_FBDFN)=FBSSN_U_FBGEN
 . . . S FBFNDAUT=1 ; note that a MST authorization was found for patient
 . . . D KVA^VADPT ; clean up patient demographics
 . . ; save authorization by patient name^dfn,auth to date^auth ien
 . . S ^TMP($J,"FBA",FBPNAME_U_FBDFN,$P(FBA,U,2)_U_FBAU)=FBA
 . ;
 . ; look for payments related to the selected patient authorizations
 . Q:'FBFNDAUT  ; no selected MST authorizations for patient
 . ; loop thru vendor multiple
 . S FBV=0 F  S FBV=$O(^FBAAC(FBDFN,1,FBV)) Q:'FBV  D
 . . ; loop thru initial treatment date multiple
 . . S FBTDI=0 F  S FBTDI=$O(^FBAAC(FBDFN,1,FBV,1,FBTDI)) Q:'FBTDI  D
 . . . S FBY2=$G(^FBAAC(FBDFN,1,FBV,1,FBTDI,0))
 . . . Q:$P(FBY2,U)<FBDT1  ; date of service prior to report start
 . . . Q:$P(FBY2,U)>FBDT2  ; date of service after report end
 . . . S FBATO=$P($G(^FBAAA(FBDFN,1,$P(FBY2,U,4),0)),U,2) ; auth to date
 . . . Q:'$D(^TMP($J,"FBA",FBPNAME_U_FBDFN,FBATO_U_$P(FBY2,U,4)))  ; not one of the selected authorizations
 . . . ; loop thru service provided multiple
 . . . S FBSPI=0
 . . . F  S FBSPI=$O(^FBAAC(FBDFN,1,FBV,1,FBTDI,1,FBSPI)) Q:'FBSPI  D
 . . . . S FBY3=$G(^FBAAC(FBDFN,1,FBV,1,FBTDI,1,FBSPI,0))
 . . . . Q:$P(FBY3,U,6)=""  ; not finalized
 . . . . S ^TMP($J,"FBA",FBPNAME_U_FBDFN,FBATO_U_$P(FBY2,U,4),$P(FBY2,U)_U_FBSPI_","_FBTDI_","_FBV_","_FBDFN_",")=""
 . . . . S FBT("AMTPAID",FBGEN)=FBT("AMTPAID",FBGEN)+$P(FBY3,U,3)
 . . . . I '$D(^TMP($J,"FBV",FBDFN,$P(FBY2,U))) D
 . . . . . ; new visit
 . . . . . S FBT("VISIT",FBGEN)=FBT("VISIT",FBGEN)+1
 . . . . . S ^TMP($J,"FBV",FBDFN,$P(FBY2,U))=""
 ;
PRINT ; report data
 S FBPG=0 D NOW^%DTC S Y=% D DD^%DT S FBDTR=Y
 K FBDL S FBDL="",$P(FBDL,"-",IOM)=""
 ;
 ; build page header text for selection criteria
 K FBHDT
 S FBHDT(1)="  For "_$$FMTE^XLFDT(FBDT1)_" through "_$$FMTE^XLFDT(FBDT2)
 ;
 ;
 D HD
 I 'FBQUIT,'$D(^TMP($J)) W !,"No MST authorizations found during period."
 I 'FBQUIT,FBDETAIL D
 . ; loop thru veterans
 . S FBPAT=""
 . F  S FBPAT=$O(^TMP($J,"FBA",FBPAT)) Q:FBPAT=""  D  Q:FBQUIT
 . . S FBPNAME=$P(FBPAT,U)
 . . S FBDFN=$P(FBPAT,U,2)
 . . S FBX=$G(^TMP($J,"FBA",FBPAT))
 . . W !!,FBPNAME,?40,"Patient ID: ",$P(FBX,U),?67,"Gender: ",$P(FBX,U,2)
 . . ; loop thru authorizations
 . . S FBAUT=""
 . . F  S FBAUT=$O(^TMP($J,"FBA",FBPAT,FBAUT)) Q:FBAUT=""  D  Q:FBQUIT
 . . . S FBAU=$P(FBAUT,U,2)
 . . . S FBA=^TMP($J,"FBA",FBPAT,FBAUT)
 . . . I $Y+9>IOSL D HD Q:FBQUIT  D HDPAT
 . . . W !!,?2,"Authorization #: ",FBDFN,"-",FBAU
 . . . W ?32,"FR: ",$$FMTE^XLFDT($P(FBA,U),"2DF")
 . . . W ?47,"TO: ",$$FMTE^XLFDT($P(FBA,U,2),"2DF")
 . . . ; loop thru payments
 . . . I $O(^TMP($J,"FBA",FBPAT,FBAUT,""))']"" W !!,?4,"No finalized payments on file."
 . . . E  S FBPAY="" F  S FBPAY=$O(^TMP($J,"FBA",FBPAT,FBAUT,FBPAY)) Q:FBPAY=""  D  Q:FBQUIT
 . . . . S FBIENS=$P(FBPAY,U,2)
 . . . . S FBV=$P(FBIENS,",",3)
 . . . . S FBTDI=$P(FBIENS,",",2)
 . . . . S FBSPI=$P(FBIENS,",",1)
 . . . . S FBVY=$S(FBV:$G(^FBAAV(FBV,0)),1:"")
 . . . . S FBAACPT=$$GET1^DIQ(162.03,FBIENS,.01)
 . . . . S FBMODLE=$$MODL^FBAAUTL4("^FBAAC("_FBDFN_",1,"_FBV_",1,"_FBTDI_",1,"_FBSPI_",""M"")","E")
 . . . . I $Y+7>IOSL D HD Q:FBQUIT  D HDPAT,HDAUT
 . . . . W !!,?4,"Svc Date: ",$$FMTE^XLFDT($P(FBPAY,U),"2DF")
 . . . . W ?24,"CPT-MOD: "
 . . . . W FBAACPT_$S($G(FBMODLE)]"":"-"_$P(FBMODLE,","),1:"")
 . . . . W ?43,"DIAG: ",$$GET1^DIQ(162.03,FBIENS,28)
 . . . . W ?58,"AMT PAID: ",$J($$GET1^DIQ(162.03,FBIENS,2,"I"),9,2)
 . . . . I $P($G(FBMODLE),",",2)]"" D  Q:FBQUIT
 . . . . . N FBI,FBMOD
 . . . . . F FBI=2:1 S FBMOD=$P(FBMODLE,",",FBI) Q:FBMOD=""  D  Q:FBQUIT
 . . . . . . I $Y+4>IOSL D HD Q:FBQUIT  D HDPAT,HDAUT
 . . . . . . W !,?38,"-",FBMOD
 . . . . W !,?4,"Vendor: ",$E($P(FBVY,U),1,30)
 . . . . W ?44,"Vendor ID: ",$P(FBVY,U,2)
 ;
 I FBQUIT W !!,"REPORT STOPPED AT USER REQUEST"
 E  D RSUM
 ;
 I 'FBQUIT,$E(IOST,1,2)="C-" S DIR(0)="E" D ^DIR K DIR
 D ^%ZISC
 ;
EXIT ;
 I $D(ZTQUEUED) S ZTREQ="@"
 K ^TMP($J)
 K FBA,FBAACPT,FBATO,FBAU,FBAUT,FBC,FBDETAIL,FBDFN,FBDL,FBDT1,FBDT2
 K FBDTR,FBFNDAUT,FBGEN,FBHDT,FBI,FBIENS,FBMODLE,FBPAT,FBPAY,FBPG
 K FBPNAME,FBPOV,FBSPI,FBT,FBTDI,FBSSN,FBQUIT,FBV,FBVY,FBX,FBY2,FBY3
 K %,DFN,DIC,DIR,DIROUT,DIRUT,DTOUT,DUOUT,I,J,POP,X,Y
 Q
HD ; page header
 N FBI
 I $D(ZTQUEUED),$$S^%ZTLOAD S ZTSTOP=1,FBQUIT=1 Q
 I $E(IOST,1,2)="C-",FBPG S DIR(0)="E" D ^DIR K DIR I 'Y S FBQUIT=1 Q
 I $E(IOST,1,2)="C-"!FBPG W @IOF
 S FBPG=FBPG+1
 W !,"MST "_$S(FBDETAIL:"Detailed",1:"Summary")_" Report"
 W ?49,FBDTR,?72,"page ",FBPG
 S FBI=0 F  S FBI=$O(FBHDT(FBI)) Q:'FBI  W !,FBHDT(FBI)
 W !,FBDL
 Q
HDPAT ; page header for continued Patient
 W !,"Patient: ",FBPNAME," (continued)"
 Q
HDAUT ; page header for continued Authorization
 W !,"  Authorization: ",FBDFN,"-",FBAU," (continued)"
 Q
RSUM ; report summary
 I $Y+14>IOSL D HD Q:FBQUIT
 W !!,"REPORT SUMMARY"
 W !!,"Gender",?8,"# Unique",?18,"# Visits"
 W ?28,"    Total",?44,"Average Paid",?58,"Average Paid"
 W !,?8,"Patients"
 W ?28,"   Payments",?44," Per Patient",?58,"  Per Visit"
 W !,"------",?8,"--------",?18,"--------"
 W ?28,"--------------",?44,"------------",?58,"------------"
 F I="F","M","U" D RSUML(I)
 W !,?8,"--------",?18,"--------"
 W ?28,"--------------",?44,"------------",?58,"------------"
 D RSUML("T")
 I $Y+8>IOSL D HD Q:FBQUIT
 W !!,"Notes:  (1) # Unique Patients represents patients having one or more MST"
 W !,"            authorizations that overlap the period being reported."
 W !,"        (2) # Visits and Total Payments are obtained from any finalized"
 W !,"            payment(s) that are linked to the MST authorizations and have a"
 W !,"            date of service within the period being reported."
 Q
RSUML(FBI) ; report summary number line
 N FBTX
 S FBTX=$S(FBI="F":"Female",FBI="M":"Male",FBI="U":"Unspec.",1:"Total")
 I FBI="U",FBT("PATIENT",FBI)'>0 Q
 I "^F^M^U^"[(U_FBI_U) F I="PATIENT","VISIT","AMTPAID" S FBT(I,"T")=FBT(I,"T")+FBT(I,FBI)
 W !,FBTX,?8,$J($FN(FBT("PATIENT",FBI),","),8)
 W ?18,$J($FN(FBT("VISIT",FBI),","),8)
 W ?28,$J($FN(FBT("AMTPAID",FBI),",",2),14)
 I FBT("PATIENT",FBI)>0 W ?44,$J($FN(FBT("AMTPAID",FBI)/FBT("PATIENT",FBI),",",2),12)
 I FBT("VISIT",FBI)>0 W ?58,$J($FN(FBT("AMTPAID",FBI)/FBT("VISIT",FBI),",",2),12)
 Q
 ;
 ;FBAAMST
