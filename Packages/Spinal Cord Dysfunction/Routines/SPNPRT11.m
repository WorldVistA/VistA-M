SPNPRT11 ;SD/CM- PRINT EXPANDED INFORMATIONAL PT LIST ; 07/31/02
 ;;2.0;Spinal Cord Dysfunction;**12,13,15,16,19**;01/02/1997
 ;
EN1 ; Main Entry Point
 S SPNC=0 ;Line counter
 N SPNLEXIT,SPNIO
 S SPNLEXIT=0 D EN1^SPNPRTMT Q:SPNLEXIT  ;Filters
 F SPNG="SPNC","SPNDFN","SPNAEREC","SPNETIOL","SPNETPV","SPNHLOI","SPNPCP","SPNDATOC","SPNPVA","SPNNTWK","SPNREG" S:$D(@SPNG) ZTSAVE(SPNG)=""
 W !!,"### This report is designed for importing into a spreadsheet    ###"
 W !,"### Turn OFF line wrap.  Capture file as raw text               ###"
 W !,"### For file capture, answer DEVICE prompt with 0;255;9999      ###"
 W !,"### File will import into spreadsheet, 1 patient per row        ###",!
 D DEVICE^SPNPRTMT("PRINT^SPNPRT11","SCD Expanded Patient Listing",.ZTSAVE) Q:SPNLEXIT
 I SPNIO="Q" D EXIT Q  ; Print was Queued
 I IO'="" D PRINT D EXIT Q  ; Print was not Queued
 Q
EXIT ; Exit routine 
 K ^TMP($J,"SPN"),^TMP($J,"SPNPRT","AUTO"),^TMP($J,"SPNPRT","POST")
 K SPNAEREC,SPNAEOFF,SPNHLOI,SPNANS,SPNDATOC,SPNG,SPNNAME,SPNPCP,SPNPVA,SPNNTWK,SPNREG,SPNC,SPNPH,SPNLPRT,SPNPVAPV,SPNETIOL,SPNETPV,ZTSAVE
 Q
PRINT ; Print main Body
 U IO
 K ^TMP($J,"SPN")
 S SPNLEXIT=$G(SPNLEXIT) ; Ensure that the exit is set
 N SPNDFN,SPNX
 W !,"Expanded Patient List",?55,"Date: ",$$FMTE^XLFDT($$NOW^XLFDT,"5DZP"),!
 W !,$$REPEAT^XLFSTR("-",253)
 W !,"Patient",?14,"SSN",?27,"Home Phone",?40,"NtWk",?46,"Reg Status",?58,"Street Address 1",?86,"Str Addr 2",?97,"City",?113,"St",?116,"Zip"
 W ?123,"County",?143,"Eligibility",?160,"Last AE Offrd",?175,"Last AE Recvd",?190,"Primary VA",?202,"Provider",?211,"SCI Level",?221,"Etiology",?241,"Date of Onset"
 W !,$$REPEAT^XLFSTR("-",253)
 S (SPNDFN,SPNLPRT)=0
 F  S SPNDFN=$O(^SPNL(154,SPNDFN)) Q:SPNDFN<1  D  Q:SPNLEXIT
 . Q:SPNLEXIT
 . Q:$G(^SPNL(154,SPNDFN,0))=""  ; No Zero node
 . I '$$EN2^SPNPRTMT(SPNDFN) Q  ; Patient fail the filters
 . S DFN=SPNDFN D DEM^VADPT,ADD^VADPT
 . S ^TMP($J,"SPN",VADM(1),SPNDFN)="" ; Sort the data
 . D KVAR^VADPT
 . Q
 I $D(^TMP($J,"SPN")) D  Q:SPNLEXIT  ; Indicates the report had data
 . S SPNNAME="" F  S SPNNAME=$O(^TMP($J,"SPN",SPNNAME)) Q:SPNNAME=""  Q:SPNLEXIT  S SPNDFN=0 F  S SPNDFN=$O(^TMP($J,"SPN",SPNNAME,SPNDFN)) Q:SPNDFN<1  D  Q:SPNLEXIT
 .. I $E(IOST,1)="C",(IOSL<26) S SPNC=SPNC+1 I SPNC=22 R !!,"Enter RETURN to continue or '^' to exit: ",SPNANS:DTIME
 .. I $G(SPNANS)="^" S SPNLEXIT=1
 .. I SPNC=22 S SPNC=0
 .. D PATIENT(SPNDFN)
 .. Q
 . Q
 E  W !,"    *******  No Data for this Report  *******"
 I $E(IOST,1)="C" N DIR S DIR(0)="E" D ^DIR  K Y
 D CLOSE^SPNPRTMT
 K ^TMP($J,"SPN")
 Q
PATIENT(SPNDFN) ;PRINT PATIENT DATA
 ;INPUT:
 ; SPNFDFN = patient DFN
 ;
 N SPNX
 S DFN=SPNDFN D DEM^VADPT,ADD^VADPT D ELIG^VADPT ; Get patient data
 S SPNNTWK=$$GET^DDSVAL(154,SPNDFN,1.1,"","E")
 S SPNREG=$$GET^DDSVAL(154,SPNDFN,.03,"","E")
 S SPNHLOI=$$GET^DDSVAL(154,SPNDFN,2.1,"","E")
 S SPNPCP=$$GET^DDSVAL(154,SPNDFN,8.1,"","E")
 S SPNPVAPV=$S($D(^SPNL(154,SPNDFN,3)):$P(^SPNL(154,SPNDFN,3),U,2),1:"") ; Primary Care VA pointer value
 S SPNPVA="" S SPNPVA=$S(SPNPVAPV'="":$P($G(^DIC(4,SPNPVAPV,0)),U,1),1:"")
 ;--- get etiol data
 S SPNETPV="" S SPNETPV=$S($D(^SPNL(154,SPNDFN,"E",1,0)):$P(^SPNL(154,SPNDFN,"E",1,0),U,1),1:10) ; Etiol pointer value - 'OTHER' if missing
 S SPNETIOL="" S SPNETIOL=$P(^SPNL(154.03,SPNETPV,0),U,1)
 S SPNDATOC=$S($D(^SPNL(154,SPNDFN,"E",1,0)):$P(^SPNL(154,SPNDFN,"E",1,0),U,2),1:"") ; etiol date of occurance
 ;--- get annual eval data
 S D0=SPNDFN
 D OFFER^SPNEVAL S SPNAEOFF=X
 D REC^SPNEVAL S SPNAEREC=X
 S SPNPH=VAPA(8)
 S SPNPH=$TR($G(SPNPH),"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz ()[];*?")
 I $L(SPNPH)=7,SPNPH?7N S SPNPH=$E(SPNPH,1,3)_"-"_$E(SPNPH,4,7)
 I $L(SPNPH)=10,SPNPH?10N S SPNPH=$E(SPNPH,1,3)_"-"_$E(SPNPH,4,6)_"-"_$E(SPNPH,7,10)
 I $L(SPNPH)=11,$E(SPNPH,7)="-" S SPNPH=$E(SPNPH,1,3)_"-"_$E(SPNPH,4,11)
 I $L(SPNPH)=11,$E(SPNPH,4)="-" S SPNPH=$E(SPNPH,1,7)_"-"_$E(SPNPH,8,11)
 I $L(SPNPH)=14,$E(SPNPH,1,2)="1-" S SPNPH=$E(SPNPH,3,14)
 W !,$E(VADM(1),1,12),?14,VA("PID"),?27,$S(SPNPH'="":$E(SPNPH,1,12),1:""),?40,SPNNTWK,?46,$E(SPNREG,1,10),?58,$S(VAPA(1)'="":$E(VAPA(1),1,28),1:"")
 W ?86,$S(VAPA(2)'="":$E(VAPA(2),1,10),1:""),?97,$S(VAPA(4)'="":VAPA(4),1:""),?113,$S(VAPA(5)'="":$P($G(^DIC(5,$P(VAPA(5),U,1),0)),U,2),1:"")
 W ?116,$S(VAPA(6)'="":VAPA(6),1:""),?123,$P(VAPA(7),U,2),?143,$E($P(VAEL(1),U,2),1,15),?160,$$FMTE^XLFDT(SPNAEOFF,"5DZP"),?175,$$FMTE^XLFDT(SPNAEREC,"5DZP"),?190,$E(SPNPVA,1,10),?202,$E(SPNPCP,1,6),?211,SPNHLOI
 W ?221,$E(SPNETIOL,1,18),?241,$$FMTE^XLFDT(SPNDATOC,"5DZP")
 D KVAR^VADPT ; Clean up VA Stuff
 Q
