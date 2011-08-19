TIUPRPN4 ;SLC/MJC;Print Progress Notes for Inpt Location; 6/26/01
 ;;1.0;TEXT INTEGRATION UTILITIES;**25,100,121**;Jun 20, 1997
 ;
LOC ;sorts PNs for prting by WARD location
 ;this option is for inpts
 ;it prts all PNs for a selected date range for all patients
 ;currently on the WARD
 ;these notes are chartable contiguous or separate
 ;[TIU PRINT PN WARD]
 ;
 N DIC,Y,TIUQT,TIULOC,WARD
 D SETUP^TIUPRPN3("Print Progress Notes for ALL patients on WARD")
DIC F  D  Q:$D(TIUQT)
 .S DIC=8925.93,DIC(0)="AEQMNZ",DIC("A")="Select WARD Location: "
 .S DIC("S")="I $P($G(^SC(+$P($G(^TIU(8925.93,+Y,0)),U),0)),U,3)=""W"""
 .W ! D ^DIC K DIC I Y<0 S TIUQT=1 Q
 .S WARD=Y(0,0)
 .I '+$O(^DIC(42,"B",WARD,0)) D
 ..S WARD=$P($G(^DIC(42,+$G(^SC(+$P(Y,U,2),42)),0)),U)
 .I '+$O(^DIC(42,"B",WARD,0)) D  Q
 ..S TIUQT=1
 ..W !!,"Invalid WARD LOCATION...Contact IRM."
 .S TIULOC=+Y(0)_U_+Y_U_Y(0,0)
 .;ien hosp loc^ien tiu prt param^external ward loc
 .D NOTES(TIULOC)
 Q
 ;
NOTES(TIULOC) ;sets date/time of when notes prted
 N Y,BEG,MOVE,BED,DATE,CTR,TIULAST,ANS,IFN,TIUSPG,DFN,TIUQT
 K ^TMP("TIUREPLACE",$J)
 S TIULAST=$P($G(^TIU(8925.93,+$P(TIULOC,U,2),1)),U,2)
 I TIULAST']"" S BEG=$$DATE() Q:BEG']""
 I TIULAST]"" D  Q:$D(TIUQT)
 .I '+$G(TIULAST) D 2^TIUPRPN5 S BEG=$$DATE() I BEG']"" S TIUQT=1 Q
 .W !!,"Notes were last printed for "_WARD_" at "
 .W $$FMTE^XLFDT(+TIULAST,"1P"),!
 .S ANS=$$READ^TIUU("YA","Print from this DATE/TIME on? ","YES","^D HELP^TIUPRPN5")
 .I $D(DIRUT) S TIUQT=1 Q
 .I +$G(ANS) S BEG=+TIULAST Q
 .D 3^TIUPRPN5 S BEG=$$DATE() I BEG']"" S TIUQT=1 Q
 S TIULAST=BEG
 S MOVE=0 F  S MOVE=$O(^DGPM("CN",WARD,MOVE)) Q:'MOVE  D
 .Q:'$D(^DGPM(MOVE,0))
 .S DFN=$P(^DGPM(MOVE,0),U,3)
 .S BEG=$E(TIULAST,1,12)-.0001 ;back up one minute
 .F  S BEG=$O(^TIU(8925,"APTP",DFN,BEG)) Q:'BEG  D
 ..S IFN=0 F  S IFN=$O(^TIU(8925,"APTP",DFN,BEG,IFN)) Q:'IFN  D
 ...W "." D REPLACE^TIUPRPN3(IFN,BEG,1501)
 S IFN=0 F  S IFN=$O(^TMP("TIUREPLACE",$J,IFN)) Q:'IFN  D
 .S DFN=$P(^TIU(8925,IFN,0),U,2),BED=$G(^DPT(DFN,.101))_" "
 .S BEG=^TMP("TIUREPLACE",$J,IFN,"DT")
 .S ^TMP("TIUPR",$J,BED_";"_DFN,BEG,IFN)="Vice SF 509"
 S CTR=+$G(^TMP("TIUREPLACE",$J))
 I CTR=0 W $C(7),!!,"No notes have been signed for "_WARD_" since "
 I  W $$FMTE^XLFDT(TIULAST,"1P") G NOTESX
 W !,">> "_CTR_" note"_$S(CTR>1:"s",1:"")_" found for WARD "_WARD
 S TIUSPG=1,TIULAST=$$NOW^XLFDT
 D DEV^TIUPRPN5
NOTESX ;
 K ^TMP("TIUREPLACE",$J)
 Q
DATE() W ! S %DT="AESTPX",%DT(0)="-NOW"
 S %DT("A")="Print Notes Starting With (DATE/TIME): "
 D ^%DT K %DT
 S BEG=$S($D(DTOUT):"",Y<0:"",1:Y)
 Q BEG
 ;
ADD ; enter/edit locations in file 8925.93
 N DA,DIC,DIE,DR,TIUQT,Y
 F  W ! D  Q:$D(TIUQT)
 .S (DIC,DLAYGO)=8925.93,DIC(0)="AEQMNL"
 .S DIC("A")="Select Clinic or Ward: "
 .D ^DIC I Y<0 S TIUQT=1 Q
 .S DIE=DIC,DA=+Y,DR="1.03;3" D ^DIE
 K DLAYGO
 Q
 ;
DIV ; enter/edit division params in file 8925.94
 N DA,DIC,DIE,DR,TIUQT,Y
 F  W ! D  Q:$D(TIUQT)
 .S (DIC,DLAYGO)=8925.94,DIC(0)="AEQMNL"
 .S DIC("A")="Select Division for PNs Outpatient Batch Print: "
 .D ^DIC I Y<0 S TIUQT=1 Q
 .S DIE=DIC,DA=+Y,DR=".02;1.02" D ^DIE
 K DLAYGO
 Q
