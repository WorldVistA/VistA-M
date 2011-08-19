TIUPRPN5 ;SLC/MJC-Sort PNs for Prting by Location;6/26/01
 ;;1.0;TEXT INTEGRATION UTILITIES;**100,121**;Jun 20, 1997
 ;
LOC ;sorts PNs for prting by CLINIC location
 ;these notes are chartable contiguous or separate
 ;this option is screened to exclude WARDs 
 ;sites should use the [TIU PRINT PN WARD] option which sorts
 ;by BED NUMBER for current inpts on that ward for INPT notes
 ;[TIU PRINT PN OUTPT LOC]
 ;
 N DIC,Y,TIUQT,TIULOC
 D SETUP^TIUPRPN3("Print Progress Notes for OUTPATIENT LOCATION")
DIC F  D  Q:$D(TIUQT)
 .S DIC=8925.93,DIC(0)="AEQMNZ",DIC("A")="Select OUTPATIENT location: "
 .S DIC("S")="I $P($G(^SC(+$P($G(^TIU(8925.93,+Y,0)),U),0)),U,3)'=""W"""
 .W ! D ^DIC K DIC("S") I Y<0 S TIUQT=1 Q
 .S TIULOC=+Y(0)_U_+Y_U_Y(0,0)
 .I '$D(^TIU(8925,"ALOCP",+TIULOC)) D  Q
 ..W !,$C(7),"There are no signed Progress Notes for this location!!"
 .D NOTES(TIULOC)
 Q
 ;
NOTES(TIULOC) ;returns date/time;ien of last note prted
 N OLD,NEW,Y,BEG,IFN,TIUSPG,CTR,TIULAST,ANS,MSG,TIUQT,DFN,SORT
 K ^TMP("TIUREPLACE",$J)
 S MSG=1,TIULAST=$P($G(^TIU(8925.93,+$P(TIULOC,U,2),1)),U,2)
 I TIULAST]"" D  Q:$D(TIUQT)
 .I '+$G(TIULAST)!'$P(TIULAST,";",2)!('$D(^TIU(8925,"ALOCP",+TIULOC,+TIULAST,+$P(TIULAST,";",2)))) S $P(^TIU(8925.93,+$P(TIULOC,U,2),1),U,2)="",MSG=2 Q
 .S BEG=+TIULAST
 .W !!,"The last note printed for this location using this option was "
 .W !,"signed ",$$FMTE^XLFDT(BEG,"1P"),!!
 .S ANS=$$READ^TIUU("YA","Print from this point on? ","YES","^D HELP^TIUPRPN5")
 .I $D(DIRUT) S TIUQT=1 Q
 .I +$G(ANS) S IFN=$P(TIULAST,U,2) Q
 .S $P(^TIU(8925.93,+$P(TIULOC,U,2),1),U,2)="",MSG=3
 I $P($G(^TIU(8925.93,+$P(TIULOC,U,2),1)),U,2)']"" D  Q:$D(TIUQT)
 .D @MSG ;writes message to explain date selection
RANGE .S OLD=$O(^TIU(8925,"ALOCP",+TIULOC,0))
 .S NEW=$O(^TIU(8925,"ALOCP",+TIULOC,9999999),-1)
 .W !,"     The OLDEST note was signed: ",$$FMTE^XLFDT(OLD,"1P")
 .W !,"The MOST RECENT note was signed: ",$$FMTE^XLFDT(NEW,"1P"),!
 .W !,"Select a date and I will print all signed notes for "
 .W !,$P(TIULOC,U,3)," from this date until NOW.",!
DATE .S %DT="AEPX",%DT(0)="-NOW",%DT("A")="Print Notes Beginning: "
 .D ^%DT K %DT I $D(DTOUT)!(Y<0) S TIUQT=1 Q
 .I Y>NEW W $C(7),!?5,"Pick a date between the OLDEST and the MOST "
 .I  W "RECENT." G DATE
 .S BEG=Y
 S CTR=0 F  S BEG=$O(^TIU(8925,"ALOCP",+TIULOC,BEG)) Q:'BEG  D
 .I '$D(IFN) S IFN=0
 .F  S IFN=$O(^TIU(8925,"ALOCP",+TIULOC,BEG,IFN)) Q:'IFN  D
 ..W "." D REPLACE^TIUPRPN3(IFN,BEG,1501)
 S IFN=0 F  S IFN=$O(^TMP("TIUREPLACE",$J,IFN)) Q:'IFN  D
 .S DFN=$P(^TIU(8925,IFN,0),U,2),SORT=$P(^DPT(DFN,0),U)_";"_DFN
 .S BEG=^TMP("TIUREPLACE",$J,IFN,"DT")
 .S ^TMP("TIUPR",$J,SORT,BEG,IFN)="Vice SF 509"
 .S TIULAST=BEG_";"_IFN
 S CTR=+$G(^TMP("TIUREPLACE",$J))
 I CTR=0 W $C(7),!!,"No notes have been signed for this location since "
 I  W $$FMTE^XLFDT(+TIULAST,"1P") G NOTESX
 W !,">> "_CTR_" note"_$S(CTR>1:"s",1:"")_" found for "_$P(TIULOC,U,3)
 I CTR'>1 S TIUSPG=1
 E  S TIUSPG=$$PAGE^TIUPRPN3 G:TIUSPG']"" NOTESX S TIUSPG=$S(+$G(TIUSPG):0,1:1)
DEV S %ZIS("B")=$P($G(^%ZIS(1,+$P($G(^TIU(8925.93,$P(TIULOC,U,2),1)),U,3),0),""),U) ;brings up default prter from param file
 W ! S %ZIS="Q" D ^%ZIS I POP K POP G EXIT
 I $E(IOST)="C" W $C(7),$C(7),!?5,"You must select a "
 I  W "printer for this option!!" G DEV
 S $P(^TIU(8925.93,$P(TIULOC,U,2),0),U,4)=""
 I $D(IO("Q")) K IO("Q") D  G EXIT
 .S ZTRTN="PRINT^TIUPRPN5",ZTSAVE("^TMP(""TIUPR"",$J,")=""
 .S ZTSAVE("TIUSPG")="",ZTSAVE("TIULAST")="",ZTSAVE("TIULOC")=""
 .S ZTDESC="TIU PRT PNS BY LOCATION"
 .D ^%ZTLOAD W !,$S($D(ZTSK):"Request Queued!",1:"Request Canceled!")
 .K ZTSK,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,%ZIS,TIULAST,TIUSPG,TIULOC
 .D HOME^%ZIS
 U IO D PRINT,^%ZISC
NOTESX ;
 K ^TMP("TIUREPLACE",$J)
 Q
PRINT ;
 K ^TMP("TIULQ",$J)
 I $D(ZTQUEUED) S ZTREQ="@"
 D PRINT^TIUPRPN1(1,$G(TIUSPG))
 S $P(^TIU(8925.93,$P(TIULOC,U,2),1),U,2)=TIULAST
EXIT K ^TMP("TIULQ",$J),^TMP("TIUPR",$J),^TMP("TIUREPLACE",$J)
 Q
 ;
1 W !!,"I don't seem to have any record of you having used this option "
 W !,"to print progress notes for this location.",!
 Q
2 W !!,"I could not determine what the last note printed for this "
 W !,"location was."
 W !!,"Please select a date and all notes from that date to NOW will be"
 W !,"printed.  The last note printed will become the new base date.",!
 Q
3 W !!,"OK- then select a different date.",!
 Q
HELP ; help for continue from this point prompt
 W !!,"Every note that has been signed since this date (last time this"
 W !,"notes were printed using this option) until NOW will be printed."
 Q
