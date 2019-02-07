PSBMMRB ;AITC/CR - REPORT FOR RESPIRATORY THERAPY MEDS ;11/29/18 5:37am
 ;;3.0;BAR CODE MED ADMIN;**103**;Mar 2004;Build 21
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ; Reference/ICR #
 ; ^DPT("CN"/6984    (private)
 ; $$GET1^DIQ/2056   (supported)
 ; ^DG(40.8/2817     (controlled)
 ; ^DG(43/6812       (private)
 ; File #44/10040    (supported)
 ; ^VA(200/10060     (supported)
 ; %ZTLOAD/10063     (supported)
 ; %ZIS/10086        (supported)
 ; %ZISC/10089       (supported)
 ;
 ;=================================================================
EN1 ;
 W !!,"Report for Respiratory Therapy Medications",!
 N D0,DIC,PSBDATA,PSBDPTR,PSBDIV,PSBDVNM,PSBNAME,PSBMUDV,PSBSTIEN,X,Y
 K ^TMP($J),^TMP("PSBMMRB")
 S D0=1,PSBMUDV=$S($$GET1^DIQ(43,D0,11,"I")=1:1,1:0)
 I PSBMUDV=1 D CHK1,EN2 Q
 I PSBMUDV=0 D ALL,EN2 Q
 Q
 ;
EN2 I $P($G(^VA(200,DUZ,2,0)),U,4)=0 W !!,$C(7),"You have no valid divisions in the NEW PERSON file." S Y="^" Q
 I '$O(^DG(40.8,"AD",DUZ(2),"")) W !!,$C(7),"Your NEW PERSON file division was not found in the MEDICAL CENTER DIVISION file." S Y="^" Q
 I Y=""!(Y<0)!(Y="^") Q
 S PSBDIV=$P($G(^TMP("PSBMMRB",$J)),U,2)
 S PSBNAME=$P($G(^TMP("PSBMMRB",$J)),U,3)
 W !
 S %DT="AE"
 S %DT("A")="Select date of Respiratory Therapy Meds Report (e.g., T or T-1, etc.): "
 D ^%DT
 I Y'=-1 D
 . S RDATE=Y
 . W !!,"Please choose a 132 character printer",!
 . W "Queuing of this report is recommended",!
 . S %ZIS="MQ"
 . D ^%ZIS
 . I POP K %ZIS W !,"Device not ready" Q
 . I $D(IO("Q")) D
 .. S ZTRTN="EN3^PSBMMRB"
 .. S ZTSAVE("RDATE")=""
 .. S ZTSAVE("PSBMUDV")=""
 .. S ZTSAVE("PSBDIV")=""
 .. S ZTSAVE("PSBNAME")=""
 .. S ZTDESC("Respiratory Therapy Meds Report")=""
 .. D ^%ZTLOAD
 . ; allow user to send report immediately to the screen
 . I '$D(IO("Q")) D
 .. D WAIT^DICD U IO D EN3^PSBMMRB
 .. I IO'=IO(0) D ^%ZISC
 D ^%ZISC
 D EXIT
 Q
 ;
EN3 ; create new entry; note: national routine PSBO1 is modified for a new report,
 ; at NEW+3^PSBO1 add RT code for Respiratory Therapy Meds report
 ;
 D NEW^PSBO1(.PSBRPT,"RT")     ;for Respiratory Therapy Meds report
 G:$P($G(PSBRPT(0)),U)<1 EXIT
 ; edit new entry.
 S DA=$P($G(PSBRPT(0)),U),DIE="^PSB(53.69,"
 S DR=".06///^S X=ION;.11///W;.15=///B;.16=///"_RDATE_";.17=///0001;.19=///2400"
 L +(^PSB(53.69,DA)):$S($G(DILOCKTM)>30:DILOCKTM,1:30) I '$T G EXIT
 D ^DIE
 L -(^PSB(53.69,DA))
 ; loop thru ^DPT("CN" and get all wards with patients
 ; ZZA is the ward name, ZZB is the IEN for the patient
 N ZZA,ZZB,WARD
 S ZZA="" F  S ZZA=$O(^DPT("CN",ZZA)) Q:ZZA=""  D
 . N DIVPTR,PSBSTA42,ZZAIEN
 . S ZZB="" F  S ZZB=$O(^DPT("CN",ZZA,ZZB)) Q:ZZB=""  D
 .. S ZZAIEN=$O(^SC("B",ZZA,""))
 .. Q:+$G(ZZAIEN)=""
 .. S DIVPTR=$$GET1^DIQ(44,ZZAIEN,3.5,"I") ; station # for ward
 .. S PSBSTA42=$$GET1^DIQ(40.8,DIVPTR,.07,"I")
 .. ; capture the ward name
 .. S WARD=$$GET1^DIQ(44,ZZAIEN,.01,"E") ; ward name
 .. I (PSBMUDV=1)&(PSBDIV'=PSBSTA42) Q  ; single division only
 .. S ^TMP($J,WARD)=""
 ;
 ; if there are no wards in the division queried, issue a blank report
 I '$D(^TMP($J)) D  Q
 . S PSBHDR(1)="RESPIRATORY THERAPY MEDICATIONS from "_$$FMTE^XLFDT(DT)_"@00:01"_" thru "_$$FMTE^XLFDT(DT)_"@24:00"
 . S PSBWRD=""
 . D WRDHDR^PSBORT
 . W !,"No Medications Found"
 . Q
 ;
 N NUM,NURIEN,WARD1,WARD2
 D NWLIST^PSBRPC(.WARD1,) ; get only active wards from #211.4
 S NUM=0 F  S NUM=$O(WARD1(NUM)) Q:NUM'>0  I $P($G(WARD1(NUM)),U,2)["[MAS WARD]" S WARD2($P($P($G(WARD1(NUM)),U,2),"[",1))=$P($G(WARD1(NUM)),U,1)
 N FLAGPRT ; used in PSBORT to track wards printed
 S FLAGPRT=""
 S WARD="" F  S WARD=$O(^TMP($J,WARD)) Q:WARD=""  D
 . N SUB
 . S SUB=$O(WARD2(WARD))
 . S NURIEN=$P($G(WARD2(SUB)),U)
 . S DA=$P($G(PSBRPT(0)),U),DIE="^PSB(53.69,"
 . S DR=".13////^S X=NURIEN"  ; don't prompt when finding similar ward names
 . L +(^PSB(53.69,DA)):$S($G(DILOCKTM)>30:DILOCKTM,1:30) I '$T G EXIT
 . D ^DIE
 . L -(^PSB(53.69,DA))
 . D DQ^PSBO(DA)
 Q
 ;
EXIT ; clean up.
 K DA,DIE,DR,PSBRPT,RDATE
 K D0,^TMP($J),^TMP("PSBMMRB",$J)
 Q
 ;
CHK1 ; The user must have at least one division from file #40.8 in his file #200 record.
 N DIR
 W !
 S DIR(0)="SB^A:All Divisions;O:One Division"
 S DIR("?")="Select either All Divisions or One Division."
 S DIR("A")="Do you want (A)ll Divisions or just (O)ne Division"
 S DIR("B")="O"
 D ^DIR K DIR I $D(DUOUT)!$D(DTOUT)!$D(DIROUT)!$D(DIRUT) Q
 I Y="" Q
 I Y(0)="One Division" D ONE Q   ; regardless user divisions in file #200
 I Y(0)="All Divisions" S PSBMUDV=2 ; for all divisions in a multisite setup
 Q
 ;
ALL ; user gets all divisions
 S Y(0)="All Divisions"  ; all divisions selected
 S PSBDIV=DUZ(2)
 S PSBSTIEN=+$O(^DG(40.8,"AD",DUZ(2),"")) ; current IEN for station
 S Y=$$GET1^DIQ(40.8,PSBSTIEN,.01,"E")
 I '$D(Y) S Y=DUZ(2)
 S PSBNAME=$$NAME^XUAF4(DUZ(2))
 S PSBMUDV=0
 S ^TMP("PSBMMRB",$J)=PSBMUDV_U_PSBDIV_U_PSBNAME
 Q
 ;
ONE ; when user selects one division from many in file #200, look at file #40.8 for a match if available
 W !
 S PSBSTIEN=+$O(^DG(40.8,"AD",DUZ(2),"")) ; current IEN for station
 S PSBDVNM=$$GET1^DIQ(40.8,PSBSTIEN,.01,"I") ;division name
 S DIC("B")=PSBDVNM
 S DIC("A")="Select Division: ",DIC="^DG(40.8,",DIC(0)="AEMQ",DIC("S")="I $$SITE^VASITE(,+Y)>0"
 D ^DIC
 ; capture the division name and number after user selection
 S PSBNAME=$$GET1^DIQ(40.8,+Y,.01,"E")
 S PSBDPTR=$$GET1^DIQ(40.8,+Y,.07,"I") ; pointer to file #4
 S PSBDIV=PSBDPTR
 S ^TMP("PSBMMRB",$J)=PSBMUDV_U_PSBDIV_U_PSBNAME
 Q
