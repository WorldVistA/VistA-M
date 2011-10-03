SPNPRT02 ;HIRMFO/WAA- PRINT Patient Listing ; 8/21/96
 ;;2.0;Spinal Cord Dysfunction;**1,12,13**;01/02/1997
 ;
EN1 ; Main Entry Point
 S SPNC=0 ;Line counter
 N SPNLEXIT,SPNIO
 S SPNLEXIT=0 D EN1^SPNPRTMT Q:SPNLEXIT  ;Filters
 F SPNG="SPNAEREC","SPNAENXT","SPNETIOL","SPNETPV","SPNHLOI","SPNPCP","SPNDATOC","SPNPAGE","SPNC","SPNNAME","SPNDFN" S:$D(@SPNG) ZTSAVE(SPNG)=""
 W !!,"### This report is designed for 132 column viewing/printing     ###"
 W !,"### Set your terminal display to 132 columns                    ###"
 W !,"### For screen viewing, answer DEVICE prompt with 0;132         ###"
 W !,"### For file capture, answer DEVICE prompt with 0;132;9999      ###"
 W !,"### For a hardcopy, answer with a 132 column printer or subtype ###",!
 D DEVICE^SPNPRTMT("PRINT^SPNPRT02","SCD Patient Listing",.ZTSAVE) Q:SPNLEXIT
 I SPNIO="Q" D EXIT Q  ; Print was Queued
 I IO'="" D PRINT D EXIT Q  ; Print was not Queued
 Q
EXIT ; Exit routine 
 K ^TMP($J,"SPN"),^TMP($J,"SPNPRT","AUTO"),^TMP($J,"SPNPRT","POST")
 K SPNAEREC,SPNAENXT,SPNHLOI,SPNANS,SPNDATOC,SPNNAME,SPNPCP,SPNC,SPNETIOL,SPNETPV,VA,VAEL,VADM,ZTSAVE
 K SPNDFN,SPNG,SPNLPRT,SPNLEXIT
 Q
PRINT ; Print main Body
 U IO
 K ^TMP($J,"SPN")
 S SPNLEXIT=$G(SPNLEXIT) ; Ensure that the exit is set
 N SPNDFN,SPNX
 W !,"Patient Listing",?55,"Date: ",$$FMTE^XLFDT($$NOW^XLFDT,"5DZP"),!
 W !,$$REPEAT^XLFSTR("-",132)
 W !,"Patient",?14,"SSN",?27,"DOB",?40,"Eligibility",?57,"Means",?67,"LOI",?72,"Prov.",?78,"Etiology",?97,"Date Occ",?110,"AE Receivd",?122,"AE Next"
 W !,$$REPEAT^XLFSTR("-",132)
 S (SPNDFN,SPNLPRT)=0
 F  S SPNDFN=$O(^SPNL(154,SPNDFN)) Q:SPNDFN<1  D  Q:SPNLEXIT
 . Q:SPNLEXIT
 . Q:$G(^SPNL(154,SPNDFN,0))=""  ; No Zero node
 . I '$$EN2^SPNPRTMT(SPNDFN) Q  ; Patient fail the filters
 . S DFN=SPNDFN D DEM^VADPT
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
 E  W !,"     ******* No Data for this report. *******"
 I $E(IOST,1)="C" N DIR S DIR(0)="E" D ^DIR  K Y
 D CLOSE^SPNPRTMT
 K ^TMP($J,"SPN")
 Q
PATIENT(SPNDFN) ;PRINT PATIENT DATA
 ;INPUT:
 ; SPNFDFN = patient DFN
 ;
 N SPNX
 S DFN=SPNDFN D DEM^VADPT D ELIG^VADPT ; Get patient data
 S SPNHLOI=$$GET^DDSVAL(154,SPNDFN,2.1,"","E")
 S SPNPCP=$$GET^DDSVAL(154,SPNDFN,8.1,"","E")
 ;--- get etiol data
 S SPNETPV="" S SPNETPV=$S($D(^SPNL(154,SPNDFN,"E",1,0)):$P(^SPNL(154,SPNDFN,"E",1,0),U,1),1:10) ; Etiol pointer value - 'OTHER' if missing
 S SPNETIOL="" S SPNETIOL=$P(^SPNL(154.03,SPNETPV,0),U,1)
 S SPNDATOC=$S($D(^SPNL(154,SPNDFN,"E",1,0)):$P(^SPNL(154,SPNDFN,"E",1,0),U,2),1:"") ; etiol date of occurance
 ;--- get annual eval data
 S D0=SPNDFN
 D REC^SPNEVAL S SPNAEREC=X
 D NEXT^SPNEVAL S SPNAENXT=X
 W !,$E(VADM(1),1,12),?14,VA("PID"),?27,$P(VADM(3),U,2),?40,$E($P(VAEL(1),U,2),1,15),?57,$E($P(VAEL(8),U,2),1,8),?67,SPNHLOI
 W ?72,$E(SPNPCP,1,5),?78,$E(SPNETIOL,1,18),?97,$$FMTE^XLFDT(SPNDATOC,"5DZP"),?110,$$FMTE^XLFDT(SPNAEREC,"5DZP"),?122,$$FMTE^XLFDT(SPNAENXT,"5DZP")
 D KVAR^VADPT ; Clean up VA Stuff
 Q
