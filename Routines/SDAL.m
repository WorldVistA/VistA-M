SDAL ;ALB/GRR,MJK - APPOINTMENT LIST ; 29 Jun 99  04:11PM  ; Compiled August 20, 2007 14:24:59
 ;;5.3;Scheduling;**37,46,106,171,177,80,266,491**;Aug 13, 1993;Build 53
EN W ! S SDEND=1 D ASK2^SDDIV G:Y<0 END
 W ! S VAUTNI=1 D NCOUNT^SDAL0 I SDCONC=U G END
 W ! D NCLINIC^SDAL0 G:Y<0 END
RD1 W ! N %DT K DIC("S") S %DT("A")="For date: ",%DT="AEX" D ^%DT
 I (X["^")!(Y<0) K %,VAUTD,VAUTC,X,Y Q
 S SDD=Y
 N DIR S DIR(0)="Y",DIR("B")="NO"
 S DIR("A")="Include Primary Care assignment information in the output"
 W ! D ^DIR I $D(DTOUT)!$D(DUOUT) K SDD,VAUTC,VAUTD,X,Y Q
 W ! S SDPCMM=Y
N K SDX,SDX1 R !,"Number of copies: 1// ",M:DTIME S:M="" M=1
 I M["^" K M,SDD,VAUTC,VAUTD,X,Y Q
 I (M'?.N)!((M'>0)!($L(M)>3)) W !,"ENTER A WHOLE NUMBER TO SELECT THE # OF COPIES OF THE APPOINTMENT LIST THAT ARE NEEDED- (1-999)" G N
 S SDCOPY=M
 ; -- specify device
 W ! N %ZIS K IO("Q") S %ZIS="QMP" D ^%ZIS G END:POP
 S SDBC=$$BARQ(+IOST(0),IOM) I SDBC="^" G END
 I $D(IO("Q")) D QUE W:$D(ZTSK) "   (Task#: ",ZTSK,")" G END
 ;
START U IO N CNT,SDCLAR,SDCOUNT S (SDCOUNT,CNT)=0
 ;SET UP A TEMP ARRAY -SDCLAR- WITH CLASSIFICATION ABBREVIATIONS
 F  S CNT=$O(^SD(409.41,CNT)) Q:CNT'>0  D
 .S SDCLAR(CNT)=$P(^SD(409.41,CNT,0),U,7)
 S:'$D(DTIME) DTIME=300 I '$D(DT) D DT^SDUTL
 S SDASH="",$P(SDASH,"_",IOM+1)="" S SDBC=+$G(SDBC),SDCOPY=$S($D(SDCOPY):+SDCOPY,$D(M):+M,1:1)
 D NOW^%DTC S Y=% X ^DD("DD") S SDPNOW=$P(Y,":",1,2)
 I SDBC S SDBC=$S(IOM<120:0,1:$$BARC^SDAMU(+IOST(0),.SDBCON,.SDBCOFF))
 S (SDEND,SD1,PCNT)=0,Y=DT D D^DIQ S SDNT=Y,Y=SDD,X=Y D D^DIQ S SDPD=Y D DW^%DTC S SDPD=X_" "_SDPD
 ;if user has selected 'all' clinics, populate VAUTC with all uncancelled TYPE=C clinics from ^SC
 I VAUTC=1 S SDIEN=0 F  S SDIEN=$O(^SC(SDIEN)) Q:+SDIEN=0  D
 . I $P(^SC(SDIEN,0),"^",3)="C",$G(^SC(SDIEN,"ST",SDD,1))'["CANCELLED" D
 .. S SDNAME=$P(^SC(SDIEN,0),"^",1) I $G(SDNAME)]"" S VAUTC(SDNAME)=SDIEN
 ;-------------CALL TO SDAPI^SDAMA301 TO RETRIEVE APPT DATA------------------
 K ^TMP($J,"SDAMA301") N SDARRAY,SDIEN,SDNAME,SDERR,SDCL,SDDFN,SDDT,SDRESULT
 S SDARRAY(1)=SDD_";"_SDD,SDARRAY(3)="I;R;NT",SDARRAY("FLDS")="4;6;7;8;10;19;20;21"
 ;if user has selected clinics, build clinic filter list
 I VAUTC'=1 D  I $L(SDARRAY(2)) S SDARRAY(2)=$E(SDARRAY(2),1,$L(SDARRAY(2))-1) ;remove last ';' from end
 . S SD="" F  S SD=$O(VAUTC(SD)) Q:SD']""  S SC=$G(VAUTC(SD)) I $G(SC)]"" S SDARRAY(2)=$G(SDARRAY(2))_SC_";"
 ;call SDAPI to retrieve appointment data
 S SDRESULT=$$SDAPI^SDAMA301(.SDARRAY)
 ;I SDRESULT<0 S SDERR=$$SDAPIERR^SDAMUTDT() I $L(SDERR) S SC=0 D HED W !!,SDERR,! I $E(IOST,1,2)="C-" D OUT^SDUTL
 ;if error returned from SDAPI, display on report and quit
 I SDRESULT<0 S SDERR=$$SDAPIERR^SDAMUTDT() I $L(SDERR) S SC=0 S SDPAGE=1 D HED W !!,SDERR,! D:$E(IOST,1,2)="C-" OUT^SDUTL D EXIT Q
 ;if appts returned from SDAPI, sort output by clinic, appt d/t, patient
 I SDRESULT>0 D
 . S SDCL=0 F  S SDCL=$O(^TMP($J,"SDAMA301",SDCL)) Q:'SDCL  D
 .. S SDDFN=0 F  S SDDFN=$O(^TMP($J,"SDAMA301",SDCL,SDDFN)) Q:'SDDFN  D
 ... S SDDT=0 F  S SDDT=$O(^TMP($J,"SDAMA301",SDCL,SDDFN,SDDT)) Q:'SDDT  D
 .... M ^TMP($J,"SDAMA301","S",SDCL,SDDT,SDDFN)=^TMP($J,"SDAMA301",SDCL,SDDFN,SDDT)
 ;---------------------------------------------------------------------------
LOOPA ;S SD=0 F  S SD=$S(VAUTC:$O(^SC("B",SD)),1:$O(VAUTC(SD))) Q:SD']""!SDEND  D CLIN
 ;if no error returned from SDAPI, start looping through clinics in VAUTC (sorted by name)
 I SDRESULT'<0 S SD=0 F  S SD=$O(VAUTC(SD)) Q:SD']""!SDEND  D CLIN
 G:SDEND END
OVER ;S PCNT=PCNT+1 I PCNT<SDCOPY,SDCOUNT S VAUTC=0 G LOOPA
 S PCNT=PCNT+1 I PCNT<SDCOPY,SDCOUNT G LOOPA
END I $G(SDCOUNT)="" G EXIT
 ;I SDCOUNT=0 S SDPCT="No activity found for this date!" D HED W !!?$L(SDPCT)\2,SDPCT,!
 I SDCOUNT=0 S SDPCT="No activity found for this date!" S SDPAGE=1,SC=0 D HED W !!?$L(SDPCT)\2,SDPCT,!
 I $E(IOST,1,2)="C-" D:'$G(SDEND)&$G(SDCOUNT) OUT^SDUTL W @IOF
EXIT K %,%H,%H,A,ALL,DFN,DIC,I,INC,K,M,PCNT,POP,PT,SC,SD,SD1,SDCC,SDCONC,SDCP,SDD,SDEM1,SDDIF,SDDIF1,SDEA,SDEC,SDEDT,SDEM,SDEND,SDFL,SDFS,SDIN,SDNT
 K DIRUT,SDCOPY,SDPAGE,SDPCT,SDPNOW,SDPT0,SDOI,SDPD,SDREV,SDT,SDX,SDXX,SDZ,VADAT,VADATE,VAUTC,VAUTNI,VAUTSTR,VAUTVB,VAUTD,VAQK,X,Y,Y1,Y2,Z
 K SDBC,SDBCON,SDBCOFF,SDASH,SDPCMM,^TMP($J,"SDAMA301")
 D CLOSE^DGUTQ Q
 ;
CLIN ;S (SDFL,SC)=0 F  S SC=$O(^SC("B",SD,SC)) Q:SC'>0!SDEND  I $D(^SC(SC,0)),$P(^(0),"^",3)="C" I $S(VAUTC:1,'$D(VAUTC(SD)):0,VAUTC(SD)=SC:1,1:0) D LOOP^SDAL0
 ;process each clinic IEN from VAUTC array
 S (SDFL,SC)=0 S SC=$G(VAUTC(SD)) I $G(SC)>0,$D(^SC(SC,0)) D LOOP^SDAL0
 Q
 ;
BARQ(TTYPE,MARGIN) ;
 N ON,OFF,Y
 I MARGIN<120 S Y=0 G BARCQ
 I '$$BARC^SDAMU(.TTYPE,.ON,.OFF) S Y=0 G BARCQ
 S DIR(0)="Y",DIR("B")="NO",DIR("A")="SHOULD BARCODES BE PRINTED ON LIST(S)"
 D ^DIR K DIR S:$D(DIRUT) Y="^"
BARCQ Q Y
 ;
QUE ;Queue output
 N ZTDESC,ZTSAVE,ZTRTN
 K ZTSK,IO("Q")
 S ZTDESC="Appointment Lists",ZTRTN="START^SDAL"
 F X="VAUTD(","VAUTC(","SDCOPY","SDD","SDBC","VAUTD","VAUTC","SDCONC","SDPCMM" S ZTSAVE(X)=""
 D ^%ZTLOAD
 Q
 ;
STOP ;Check for stop task request
 S:$D(ZTQUEUED) (SDEND,ZTSTOP)=$S($$S^%ZTLOAD:1,1:0) Q
 ;
HED ;Print report header
 I SD1,$E(IOST)="C" D OUT^SDUTL Q:SDEND
 D STOP Q:SDEND
 S SDCOUNT=SDCOUNT+1,SD1=1
 W:SDCOUNT>1!($E(IOST)="C") $$XY^SCRPW50(IOF,1,0) W:$X $$XY^SCRPW50("",0,0)
 W:SC "Appointments for ",$P(^SC(SC,0),"^",1)," clinic on ",SDPD
 W:'SC "Appointments for ",SDPD
 W !,"Date printed: ",SDPNOW,?(IOM-6-$L(SDPAGE)),"Page: ",SDPAGE,!
 W !," Appt.",?11,"Patient Name",?44,"SSN",?53,"Lab",?62,"X-Ray",?73,"EKG"
 ;W !," Time",?53,"Time",?62,"Time",?73,"Time",!,?15,"Other Information",?40,"Ward Location",!,?41,"Room-Bed"
 W !," Time",?53,"Time",?62,"Time",?73,"Time",!,?15,"Other Information",?40,"Ward Location",!,?41,"Room-Bed"
 W !,SDASH S SDPAGE=SDPAGE+1
 D:SDBC PAINT(SC,SDD)
 Q
 ;
PAINT(CLINIC,DATE) ; -- paint header barcodes
 ; input:  CLINIC := clinic ifn
 ;           DATE := appt date only
 ;
 W !?10,"Date",?45,"Clinic#",?85,"No",?110,"Yes",!
 D BARC(10,$E(DATE,4,7)_$E(DATE,2,3))
 D BARC(45,"%"_CLINIC_"$")
 D BARC(85,"N"),BARC(110,"Y")
 W !!!!,SDASH
 Q
 ;
BARC(TAB,X) ; --print barcode
 ; input: TAB := tab position
 ;          X := string to print
 ;
 W *13,?TAB W @SDBCON,X,@SDBCOFF
 Q
 ;
