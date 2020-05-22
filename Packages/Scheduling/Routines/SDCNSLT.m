SDCNSLT ;ALB/HAG - LINK APPOINTMENTS TO CONSULTS ;JAN 15, 2016
 ;;5.3;Scheduling;**478,496,630,627,686,737**;Aug 13, 1993;Build 13
 ;;Per VHA Directive 2004-038, this routine should not be modified
A ;===GET ACTIVE AND PENDING CONSULT
 N A,ND,CNT,CONS,CPRSTAT,DTENTR,DTIN,DTLMT,DTR,NOS,NOSHOW,SENDER,SERVICE,SRV,P8,PROC,PT,PTNM,STATUS
 K TMP S NOSHOW="no-show",CNT=0,$P(DSH,"-",IOM-1)="",PT=DFN,X1=DT,X2=-365 D C^%DTC S DTLMT=X
 S A=":" F  S A=$O(^GMR(123,"F",PT,A),-1) Q:'+A  S ND=$G(^GMR(123,A,0)) Q:ND=""  S PROC=$P($G(^GMR(123,A,1.11)),U),DTENTR=$P(ND,U) I DTENTR>DTLMT S CPRSTAT=$P(ND,U,12) D:CPRSTAT=5!(CPRSTAT=6)!(CPRSTAT=8)!(CPRSTAT=13)
 .Q:$D(^XTMP("SDECLKC-"_A))  ;do not display consult if locked by VS GUI  ;alb/sat 627
 .I STPCOD'="" S SRV=$P(ND,U,5) Q:'+SRV  I $D(^GMR(123.5,"AB1",STPCOD,SRV)) S PTIEN=$P(ND,U,2) D
 ..I CPRSTAT=8 S SHOW=0 Q:$D(^SC("AWAS1",A))  S NOS=$O(^GMR(123,A,40,":"),-1) Q:'+NOS  S X2=$P($G(^GMR(123,A,40,NOS,0)),U),X1=DT D ^%DTC Q:X'=""&(X>180)  D SCHED(PTIEN,STPCOD,.SHOW) Q:'SHOW
 ..;CPRSTAT 13 is a cancel
 ..I CPRSTAT=13 S NOS=$O(^GMR(123,A,40,":"),-1) Q:'+NOS  S NOS=$O(^GMR(123,A,40,NOS),-1) Q:'+NOS  S X2=$P($G(^GMR(123,A,40,NOS,0)),U),X1=DT D ^%DTC Q:X'=""&(X>180)  S COMMENT=$G(^GMR(123,A,40,NOS,1,1,0)) Q:COMMENT'[NOSHOW
 ..S:+PTIEN PTNM=$P(^DPT(PTIEN,0),U) S SERVICE=$P(^GMR(123.5,SRV,0),U),STATUS=$P(^ORD(100.01,CPRSTAT,0),U),SENDER=$P(ND,U,14) S:+SENDER SENDER=$P(^VA(200,SENDER,0),U)
 ..S Y=DTENTR D DD^%DT S DTIN=Y,DTR=$E(DTENTR,4,5)_"/"_$E(DTENTR,6,7)_"/"_$E(DTENTR,2,3)_"@"_$P(Y,"@",2)
 ..S CNT=CNT+1,TMP(CNT)=PTIEN_U_SERVICE_U_SENDER_U_STATUS_U_DTR_U_A_U_DTIN_U_$P(ND,U,17)_U_PROC
 Q:'$D(TMP)
QST N DIR,DTOUT,DUOUT,CNSULT
 S DIR(0)="Y",DIR("A")="Will this appointment be for a CONSULT/PROCEDURE",DIR("B")="YES",DIR("?")="Answer 'Y'es if appointment is for a Consult or Procedure." W ! D ^DIR S CNSULT=Y
 I CNSULT[U!(CNSULT=0)!(CNSULT="") K TMP Q
HDR W !!,"Please select from the list of consult(s), press 0 for none.",! ;LLS 05-JAN-2015 SD*5.3*630
 W !,PTNM,!!,"# Service",?68,"Cons #",!,DSH ;LLS 05-JAN-2015 SD*5.3*630
 S A=0 F  S A=$O(TMP(A)) Q:'+A  S ND=TMP(A),P8=$P(ND,U,8) D  ;LLS 05-JAN-2015 SD*5.3*630
 . W !,A,".",?3,$S(P8="P":$E($P(ND,U,9),1,63),1:$E($P(ND,U,2),1,63)),?68,$P(ND,U,6) W !,?4,"Request DT: ",$E($P(ND,U,5),1,14),?31,"FROM: ",$E($P(ND,U,3),1,33),?71,"TYPE: ",$S(P8="P":"P",P8="C":"C",1:"") ;LLS 05-JAN-2015 SD*5.3*630
 W !
READ R !,"Select Consult: ",CONS:DTIME G:CONS="" A
 I CONS=0!(CONS[U) W " ... NONE." K TMP Q
 I "? "[CONS W !," Select consult by number on the left side." G READ
 I '$D(TMP(CONS)) W *7," ?? Select consult by number on the left side." G READ
 S CNSLTLNK=$P(TMP(CONS),U,6)
 Q
SCHED(PTIEN,STPCOD,SHOW) ;===CONSULT IS SCHEDULE NOW CHECK IF IT HAS APPOINTMENT BY STOP CODE.
 N APT,CLNC,B,S1,S2,S3,S4,STOP,STOPCOD,X,Y
 S %DT="ST",X="T-1" D ^%DT S APT=Y,S1=0,STOP=0 F  S APT=$O(^DPT(PTIEN,"S",APT)) Q:'+APT!(STOP)  S S1=1,CLNC=$P(^DPT(PTIEN,"S",APT,0),U) I CLNC'="" S STOPCOD=$P(^SC(CLNC,0),U,7) I STOPCOD'="" S S2=0 I STOPCOD=STPCOD S S2=1 D
 .S S3=0,S4=0,B=0 F  S B=$O(^SC(CLNC,"S",APT,1,B)) Q:'+B!(STOP)  S S3=1 D
 ..I ($P($G(^SC(CLNC,"S",APT,1,B,0)),U)=PTIEN) S S4=1,STOP=1,SHOW=0
 I S1=0 S SHOW=1 Q  ;show if no appointment in the patient side
 I S2=0 S SHOW=1 Q  ;show if stop code does not match
 I S3=0 S SHOW=1 Q  ;show if no appointment in the clinic
 I S4=0 S SHOW=1 Q  ;show if patient does not match in appointment
 Q
LINK(SC,SDY,SD,CNSLTLNK) ;===LINK APPOINTMENT TO CONSULT
 N DA,DIE,DR,TDA,X
 S TDA=SDY,DA(2)=SC,DA(1)=SD,DA=TDA,DIE="^SC("_DA(2)_",""S"","_DA(1)_",1,",DR="688////^S X=CNSLTLNK" D ^DIE
 Q
EDITCS(SD,TMPD,TMPYCLNC,CNSLTLNK) ;===MARK CONSULT AS SCHEDULED
 N CSCHDT,SNDPRV,TME,X,Y,COMMENT,ER
 S %DT="ST",X="NOW" D ^%DT S CSCHDT=Y
 S SNDPRV=$P($G(^GMR(123,CNSLTLNK,0)),U,14),Y=SD D DD^%DT S TME=$P($P(Y,"@",2),":",1,2)
 S COMMENT(1)=$P(TMPYCLNC,U,2)_" Consult Appt. on "_$E(SD,4,5)_"/"_$E(SD,6,7)_"/"_$E(SD,2,3)_" @ "_TME
 S COMMENT(2)=TMPD
 D SCH^SDQQCN2(.ER,CNSLTLNK,SNDPRV,CSCHDT,0,,.COMMENT) K COMMENT
 Q
SDECCAN(SCLNK,SCSNOD,SDTTM,SDSC,SDWH,SDPL,SDECNOTE) ; patch 686 wtc/zeb 3.21.18 cancel consult appointment.  called from SDEC07A.
 S SNDPRV=$P($G(^GMR(123,SCLNK,0)),U,14) ;
 ;
CANCEL ;===appt was cancelled then mark consult as edit/resubmit, add comment.
 N APPT,CONSULT,CPRSSTAT,ER,GM40,GMRND,SDPATNT,USER,SNDPRV,J
 ;Variables CNDIE, CNDA and CNINDX used in calling routine for Cancel letter printed comment in consult.
 ;TMPD is assumed by the existing code
 S:$D(SDECNOTE) TMPD=SDECNOTE_$S($D(TMPD):"; ",1:"")_$G(TMPD) ;*zeb 686 10/30/18 keep cancel comment from GUI
 S:$D(SCLNK) CONSULT=SCLNK
 I SDPL S:'$D(SCLNK) CONSULT=$P($G(^SC(SDSC,"S",SDTTM,1,SDPL,"CONS")),U) ; check for value of SDPL - wtc 737 1/21/20
 Q:'+CONSULT
 S:$D(SCSNOD) SDPATNT=$P(SCSNOD,U)
 I SDPL S:'$D(SCSNOD) SDPATNT=$P($G(^SC(SDSC,"S",SDTTM,1,SDPL,0)),U) ; check for value of SDPL - wtc 737 1/21/20
 S CPRSSTAT=$P($G(^GMR(123,CONSULT,0)),U,12) I CPRSSTAT'="" S CPRSSTAT=$P($G(^ORD(100.01,CPRSSTAT,0)),U) Q:CPRSSTAT'="SCHEDULED"
 S SNDPRV=$P($G(^GMR(123,CONSULT,0)),U,14)
 S USER=$P(^VA(200,DUZ,0),U),Y=SDTTM D DD^%DT S APPT=$E(SDTTM,4,5)_"/"_$E(SDTTM,6,7)_"/"_$E(SDTTM,2,3)_" @ "_$P(Y,"@",2)
 S COMMENT(1)=$P(^SC(SDSC,0),U)_" Appt. on "_APPT_" was cancelled"_$S($D(SDWH):$S(SDWH["P":" by the Patient.",SDWH["C":" by the Clinic.",1:"."),$D(SDADM):" for administrative purposes.",1:", whole clinic.")
 S CNINDX=2 S:$D(TMPD) COMMENT(2)="Remarks: "_TMPD,CNINDX=CNINDX+1 K TMPD,SDECNOTE ;*zeb 686 10/30/18 clean up SDECNOTE in case SDECCAN not used
 N SDERR S SDERR=$$STATUS^GMRCGUIS(CONSULT,6,3,SNDPRV,"","",.COMMENT)
 S CNDIE="^GMR(123,"_CONSULT_",40,",CNDA=+$G(COMMENT(0))
 K COMMENT,DA
 S AUTO(SDSC,SDTTM,SDPATNT)=CONSULT
 I SDPL S DA(2)=SDSC,DA(1)=SDTTM,DA=SDPL,DIE="^SC("_DA(2)_",""S"","_DA(1)_",1,",DR="688///@" D ^DIE ; check for value of SDPL - wtc 737 1/21/20
 K SCSNOD,SDADM,SCLNK
 Q
AUTOREB(SC,NDATE,LNK,CY) ;===AUTO REBOOK
 N DIC,DA,DIE,DR,Y,TME,SNDPRV,CSCHDT,COMMENT,ER
 S DA(2)=SC,DA(1)=NDATE,DA=CY,DIE="^SC("_DA(2)_",""S"","_DA(1)_",1,",DR="688////^S X=LNK" D ^DIE
 S Y=NDATE D DD^%DT S TME=$P(Y,"@",2)
 S COMMENT(1)=$P(^SC(SC,0),U)_" Consult Appt. on "_$E(NDATE,4,5)_"/"_$E(NDATE,6,7)_"/"_$E(NDATE,2,3)_" @ "_TME_" (Auto Rebooked)."
 S %DT="ST",X="NOW" D ^%DT S CSCHDT=Y
 S SNDPRV=$P($G(^GMR(123,LNK,0)),U,14)
 D SCH^SDQQCN2(.ER,LNK,SNDPRV,CSCHDT,0,,.COMMENT) K COMMENT
 Q
NOSHOW(SC,SDDTM,CNPAT,CNSTLNK,CN,AUTO,NSDIE,NSDA) ;
 ;Appt. was a NoShow, then mark Consult as Edit/Resubmit, add comment using silent call to notify user.
 ;Variables NSDIE and NSDA used in calling routine for NoShow letter printed comment in consult.
 N CSNOD,CPRSSTAT,NOSHOW,CSRQSRV,TPRNT,CSPRT,USER,Y,APPT,COMMENT,DA,DIC,DUZ2,DIC,DR,GM40,GMRND,ER,SNDPRV,J
 S CSNOD=$G(^GMR(123,CNSTLNK,0)),CPRSSTAT=$P(CSNOD,U,12),SNDPRV=$P(CSNOD,U,14),NOSHOW="no-show",AUTO(SC,SDDTM,CNPAT)=CNSTLNK
 I CPRSSTAT'="" S CPRSSTAT=$P($G(^ORD(100.01,CPRSSTAT,0)),U) Q:CPRSSTAT'="SCHEDULED"
 S CSRQSRV=$P(CSNOD,U,5) I CSRQSRV'="" S TPRNT=$P($G(^GMR(123.5,CSRQSRV,123)),U,9) I TPRNT'="" S:$P($G(^%ZIS(1,TPRNT,0)),U)'="" CSPRT=$P(^(0),U) ;reprint consult
 S USER=$P(^VA(200,DUZ,0),U),Y=SDDTM D DD^%DT S APPT=$E(SDDTM,4,5)_"/"_$E(SDDTM,6,7)_"/"_$E(SDDTM,2,3)_" @ "_$P(Y,"@",2)
 S COMMENT(1)=$P(^SC(SC,0),U)_" Appt. on "_APPT_" was a "_NOSHOW_"." ;no-show is a key word used by a search do not change
 N SDERR S SDERR=$$STATUS^GMRCGUIS(CNSTLNK,6,3,SNDPRV,"","",.COMMENT)
 S NSDIE="^GMR(123,"_CNSTLNK_",40,",NSDA=+$G(COMMENT(0))
 K COMMENT,DA
 S DA(2)=SC,DA(1)=SDDTM,DA=CN,DIE="^SC("_DA(2)_",""S"","_DA(1)_",1,",DR="688///@" D ^DIE
 I $D(CSPRT) D EN^GMRCP5(CNSTLNK,"C",CSPRT)
 K CNSTLNK Q
