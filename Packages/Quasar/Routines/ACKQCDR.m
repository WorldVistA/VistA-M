ACKQCDR ;AUG/JLTP BIR/PTD HCIOFO/AG -Generate A&SP Service CDR ; [ 03/03/98  3:10 PM ]
 ;;3.0;QUASAR;;Feb 11, 2000
 ;Per VHA Directive 10-93-142, this routine SHOULD NOT be modified.
 ;
SITE ; check whether the CDR should be run for the site or for each Division
 S ACKQCDR=$$GET1^DIQ(509850.8,"1,",.1,"I")
 I ACKQCDR'="S" G ^ACKQCDD  ; generate for a single Division
 ;
OPTN ;Introduce option.
 W @IOF,!,"This option generates and prints the Audiology and",!,"Speech Pathology Service Cost Distribution Report.",!
 K ^TMP("ACKQCDR",$J) D SAVE G:$D(DIRUT) EXIT D DATES G:$D(DIRUT) EXIT
HRS D CLINH^ACKQCD2 I '(ACKTCH+ACKTSH),'$$OK G EXIT
 W !!,"Total Clinic Hours for ",ACKXRNG,": ",$J((ACKTCH+ACKTSH),0,2)
 I ACKTSH W !,"Of that total, ",$J(ACKTSH,0,2)," hours are Instructional Support (.12).",!,"Remaining Clinic Hours: ",$J(ACKTCH,0,2)
 D TPH^ACKQCD2 G:$D(DIRUT) EXIT S ACKRTH=ACKTPH
INPUT F ACKCAT="E^ADMIN SUPT (.13) & CONT ED (.14)","R^RESEARCH" Q:$D(DIRUT)  D
 .S ACKCATI=$P(ACKCAT,U),ACKCAT=$P(ACKCAT,U,2)
 .D YNFLAT Q:$D(DIRUT)
 .I ACKFLAT D FNH Q:$D(DIRUT)
 .I 'ACKFLAT D  Q:$D(DIRUT)
 ..S ACKIC=0 F  S ACKIC=$O(^ACK(509850,"AT",ACKCATI,ACKIC)) Q:'ACKIC  S ACKCDZ=^ACK(509850,ACKIC,0) I +ACKCDZ'[.12 D INDCAT^ACKQCD2(ACKIC) Q:$D(DIRUT)
 G:$D(DIRUT) EXIT
PASS W !!,"Now for pass through CDR accounts..."
 F  D PASS^ACKQCD2 I $D(DIRUT) K DIRUT Q
 S ACKRTH=ACKRTH-(ACKTCH+ACKTSH)
 I 'ACKTCH,ACKRTH W !!,$C(7),"You have hours remaining but no clinic visits to which they can be",!,"distributed!  That won't work...",!! G EXIT
 I ACKRTH D DISREM^ACKQCD2
 D PERCENT^ACKQCD2,INDEX^ACKQCD2 D:ACKSAV SAVE^ACKQCD2
DEV W !!,"The right margin for this report is 80.",!,"You can queue it to run at a later time.",!
 K %ZIS,IOP S %ZIS="QM",%ZIS("B")="" D ^%ZIS I POP W !,"NO DEVICE SELECTED OR REPORT PRINTED." G EXIT
 I $D(IO("Q")) K IO("Q") S ZTRTN="DQ^ACKQCDR",ZTDESC="QUASAR - Generate A&SP Service CDR",ZTSAVE("ACK*")="",ZTSAVE("^TMP(""ACKQCDR"",$J,")="" D ^%ZTLOAD D HOME^%ZIS K ZTSK G EXIT
DQ ;
 U IO
 D NOW^%DTC S ACKPDT=$$NUMDT^ACKQUTL(%)_" at "_$$FTIME^ACKQUTL(%),ACKPG=0
 D PRINT^ACKQCD3
EXIT ;
 K ACK2,ACKCAT,ACKCATI,ACKCDZ,ACKED,ACKFLAT,ACKIC,ACKLAYGO,ACKMO,ACKPDT,ACKPG,ACKRTH,ACKSAV,ACKSD,ACKTCH,ACKTP,ACKTPH,ACKTSH,ACKXRNG
 K %,%I,%ZIS,CDR,D,D0,DA,DIC,DIE,DI,DIK,DIR,DIRUT,DQ,DR,DTOUT,DUOUT,HD,I,M,NEWHD,SUB,X,X1,X2,Y,YN,ZTDESC,ZTRTN,ZTSAVE,ZTSK,^TMP("ACKQCDR",$J)
 K ACKQCDR
 W:$E(IOST)'="C" @IOF D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 Q
SAVE ;
 N DIR,X,Y
SAVE2 K DTOUT,DUOUT,DIRUT
 S DIR(0)="Y",DIR("A")="Save Report Data",DIR("B")="YES"
 S DIR("?")="Answer YES or NO.",DIR("??")="^D SAVE^ACKQCD1"
 D ^DIR K DTOUT,DUOUT
 I Y?1"^"1.E W !,"Jumping not allowed.",! G SAVE2
 S ACKSAV=Y
 Q
DATES ;
 N DIR,X,Y
 I ACKSAV D MONTH Q
DATES2 K DTOUT,DUOUT,DIRUT,DIR
 S DIR(0)="SB^M:MONTH;D:DATE RANGE",DIR("B")="M"
 S DIR("A")="Generate CDR for a (M)onth or a (D)ate Range"
 S DIR("?")="Enter 'M' for MONTH or 'D' for DATE RANGE."
 S DIR("??")="^D DATES^ACKQCD1"
 D ^DIR K DIR
 I Y?1"^"1.E W !,"Jumping not allowed.",! G DATES2
 Q:$D(DIRUT)
 I Y="D" D RANGE Q
MONTH S DIR(0)="D^::AEP",DIR("A")="Select Month and Year",DIR("B")=$$LM
 S DIR("?")="^D HELP^%DTC",DIR("??")="^D MONTH^ACKQCD1"
 D ^DIR
 I Y?1"^"1.E W !,"Jumping not allowed.",! G MONTH
 Q:$D(DIRUT)
 I '$E(Y,4,5) W !,$C(7),"Month Required!" G MONTH
 I Y>DT W !,$C(7),"Can't run for future dates!",! G MONTH
 S ACKSD=$E(Y,1,5)_"01",ACKED=$E(Y,1,5)_$$LD(Y),ACKMO=$E(Y,1,5)_"00"
 S ACKXRNG=$$XDAT^ACKQUTL(ACKMO)
 Q
RANGE ;
 S DIR(0)="D^::AEXP",DIR("A")="Select Starting Date"
 S DIR("?")="^D HELP^%DTC",DIR("??")="^D STARTD^ACKQCD1"
 D ^DIR K DIR
 I Y?1"^"1.E W !,"Jumping not allowed.",! G RANGE
 Q:$D(DIRUT)
 I Y>DT W !,$C(7),"Can't run for future dates!",! G RANGE
 S ACKMO="",ACKSD=Y,ACKXRNG=$$XDAT^ACKQUTL(Y)_" to "
ENDD S DIR(0)="D^::AEXP",DIR("A")="Select Ending Date"
 S DIR("?")="^D HELP^%DTC",DIR("??")="^D ENDD^ACKQCD1"
 D ^DIR K DIR
 I Y?1"^"1.E W !,"Jumping not allowed.",! G ENDD
 Q:$D(DIRUT)
 I Y>DT W !,"Can't run for future dates!",! G ENDD
 I Y<ACKSD W !,"Can't be before Start Date!",! G ENDD
 S ACKED=Y,ACKXRNG=ACKXRNG_$$XDAT^ACKQUTL(Y)
 Q
YNFLAT ;
 N DIR,X,Y
YNFLAT2 K DTOUT,DUOUT,DIRUT,DIR
 S DIR(0)="Y",DIR("B")="NO",DIR("?")="Answer YES or NO."
 S DIR("A")="Want to enter flat number of hours for "_ACKCAT
 S DIR("??")="^D FLAT^ACKQCD1"
 D ^DIR
 I Y?1"^"1.E W !,"Jumping not allowed.",! G YNFLAT2
 S ACKFLAT=+Y
 Q
FNH ;
 N DIR,X,Y
FNH2 K DTOUT,DUOUT,DIRUT,DIR
 S DIR(0)="N^0:"_ACKRTH,DIR("A")="Enter Hours"
 S DIR("?")="^W !!,""Enter the number of hours you wish to spread over all of"",!,""the "",ACKCAT,"" accounts."""
 D ^DIR
 I Y?1"^"1.E W !,"Jumping not allowed.",! G FNH2
 Q:$D(DIRUT)
 S ACKRTH=ACKRTH-Y D SPREAD(Y,ACKCATI)
 Q
SPREAD(X,Y) ;
 N C,I,ACKTMP,ACKCDZ
 S (C,I)=0 F  S I=$O(^ACK(509850,"AT",Y,I)) Q:'I  S ACKCDZ=^ACK(509850,I,0) I +ACKCDZ'[.12 S C=C+1,ACKTMP(+ACKCDZ)=0
 S I=0 F  S I=$O(ACKTMP(I)) Q:'I  S ^TMP("ACKQCDR",$J,"ACKH",I)=X/C
 Q
LM() ;RETURN EXTERNAL VALUE OF LAST MONTH
 N X
 S X(1)=$E(DT,1,3),X(2)=$E(DT,4,5)-1
 I 'X(2) S X(2)=12,X(1)=X(1)-1
 S X(2)=$$PAD^ACKQUTL(X(2),"R",2,"0") Q $$XDAT^ACKQUTL(X(1)_X(2)_"00")
LD(M) ;RETURN LAST DATE OF MONTH M
 N X,Y
 S Y=$E(M,1,3)+1700,M=+$E(M,4,5),X="31^28^31^30^31^30^31^31^30^31^30^31"
 S:(Y#4=0&(Y#100'=0))!(Y#100=0&(Y#400=0)) $P(X,U,2)=29 Q $P(X,U,M)
OK(YN) ;
 N DIR,DUOUT,DTOUT,DIRUT
OK2 S DIR(0)="Y",DIR("B")="NO",DIR("A")="Is that ok"
 S DIR("A",1)="There are no clinic hours for the specified date range!"
 S DIR("?")="Answer YES to continue with CDR or NO to quit."
 D ^DIR
 I Y?1"^"1.E W !,"Jumping not allowed.",! G OK2
 S:$D(DIRUT) Y=0
 Q Y
