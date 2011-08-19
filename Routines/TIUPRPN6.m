TIUPRPN6 ;SLC/MJC-Print PNs-Most Current Admission ; 6/26/01
 ;;1.0;TEXT INTEGRATION UTILITIES;**100,121**;Jun 20, 1997
 ;
ADM ;prints PNs for LAST admission to either date of discharge or NOW
 ;this sort is chartable for either contiguous or separate
 ;also supports WORK copy
 ;TIU PRINT PN ADMISSION]
 ;
 N TIUDFN,TIUQT,DIC,Y
 D SETUP^TIUPRPN3("Print Progress Notes for selected patient's LAST admission")
 F  W ! S DIC=2,DIC(0)="AEQMN" D ^DIC Q:Y<0  D  K TIUQT
 .I '$O(^TIU(8925,"APTP",+Y,0)) W !!?5,$C(7),"There are no signed "
 .I  W "progress notes on file for this patient.",! Q
 .N TIUFLAG,TIUSPG
 .S TIUDFN=Y
 .D NOTES(TIUDFN) Q:$D(TIUQT)
 .S TIUFLAG=$$FLAG^TIUPRPN3() Q:TIUFLAG']""
 .S TIUSPG=1
 .D DEVICE^TIUPRPN(TIUFLAG,TIUSPG)
 Q
 ;
NOTES(TIUDFN) ;get the notes for the admission
 N VAIP,ADMDT,BEG,END,HOLD,CTR,DATE,IFN,DFN,DIR,Y
 S DFN=+TIUDFN,VAIP("D")="LAST" D IN5^VADPT
 I '$G(VAIP(1)) W !!?5,$C(7),"I don't have any record of an admission "
 I  W "for this patient.",!?5,"Select another patient." S TIUQT=1 Q
 S ADMDT=VAIP(13,1)
 W !!,"Patient was admitted:  ",$P(ADMDT,U,2)
 I $D(VAIP(17,1)) D
 .W !,"Patient was discharged: ",$P(VAIP(17,1),U,2),!
 .S DIR("A")="Print all progress notes written during this admission? "
 E  D
 .W !!,"Patient has not been DISCHARGED.",!
 .S DIR("A")="Print all progress notes from admission date until NOW? "
 S DIR(0)="YA",DIR("B")="YES",DIR("A")=DIR("A")_"(Y/N) "
 S DIR("?")="^D HELP^TIUPRPN6" D ^DIR
 I $D(DIRUT) S TIUQT=1 Q
 I +$G(Y) S BEG=+ADMDT,END=$S($G(VAIP(17,1)):+VAIP(17,1),1:9999999)
 E  D  K %DT Q:$D(TIUQT)
 .W ! S %DT="AEPTX",%DT(0)="-NOW",%DT("A")="Print Notes Beginning: "
 .D ^%DT I $D(DTOUT)!(Y<0) S TIUQT=1 Q
 .S BEG=Y,%DT("A")="                 Thru: "
 .S %DT="AEPTX" D ^%DT I $D(DTOUT)!(Y<0) S TIUQT=1 Q
 .S END=Y I END<BEG S HOLD=BEG,BEG=END,END=HOLD
 ;load up the notes
 W !!,"Searching for the notes "
 K ^TMP("TIUPR",$J),^TMP("TIUREPLACE",$J)
 S DATE=BEG
 F  S DATE=$O(^TIU(8925,"APTP",DFN,DATE)) Q:'DATE!(DATE>END)  D
 .S IFN=0 F  S IFN=$O(^TIU(8925,"APTP",DFN,DATE,IFN)) Q:'IFN  D
 ..W "." D REPLACE^TIUPRPN3(IFN,DATE,1501)
 S IFN=0 F  S IFN=$O(^TMP("TIUREPLACE",$J,IFN)) Q:'IFN  D
 .S DATE=^TMP("TIUREPLACE",$J,IFN,"DT")
 .S ^TMP("TIUPR",$J,$P(TIUDFN,U,2)_";"_DFN,DATE,IFN)="Vice SF 509"
 S CTR=+$G(^TMP("TIUREPLACE",$J))
 I '$D(^TMP("TIUPR",$J)) W !!,"No SIGNED notes found in this date "
 I  W "range for this patient." S TIUQT=1 G NOTESX
 W !!,">> "_CTR_" note"_$S(CTR>1:"s",1:"")_" found.",!
NOTESX ;
 K ^TMP("TIUREPLACE",$J)
 Q
HELP ;help for yes/no print all notes for admission question
 W !!?5,"Answer YES and all the progress notes for this admission will "
 W !?5,"be printed in CONTIGUOUS format."
 W !!?5,"Answer NO and you will be asked to select a date range for "
 W !?5,"this patient."
 Q
