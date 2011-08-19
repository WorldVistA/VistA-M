IBDFDE3 ;ALB/AAS - AICS Manual Data Entry, process handprint fields ; 24-FEB-96
 ;;3.0;AUTOMATED INFO COLLECTION SYS;;APR 24, 1997
 ;
% G ^IBDFDE
 ;
HNDPR(RESULT,IBDF) ; -- Procedure
 ; -- Manual Data entry routine for Hand Print Fields
 ;    Input :  Result := call by reference, used to output results
 ;             IBDF("IEN")    := pointer to hand print file (359.94)
 ;             IBDF("PI")     := pointer to input package interface
 ;             IBDF("DFN")    := pointer to patient
 ;             IBDF("CLINIC") := pointer to hospital location
 ;
 ;    output:  Result(n)  $p1 := pointer to package interface
 ;                        $p2 := input value (validated user input)
 ;                        $p3 := null
 ;                        $p4 := null
 ;                        $p5 := null
 ;                        $p6 := measurement type for vitals
 ;                        $p7 := ien in handprint file
 ;                        $p8 := vital type (name from 359.1)
 ;                        $P9 := Units (for Vitals)
 ;            ibdpi(package interface, qlfr or n) := result(n)
 ;                       $P13 := number of the selection
 ;
 N I,J,X,Y,ANS,DISPTXT,HDR,DIR,DIRUT,DUOUT,DTOUT,IBDX,QLFR,CHOICE,OVER,IBDPRE
 S (IBQUIT,OVER)=0,(ANS,QLFR)=""
 D OBJLST^IBDFRPC1(.CHOICE,.IBDF)
 I +CHOICE(0)<1 G HPQ
 S IBDASK=$P(CHOICE(1),"^")_" "
 I '$D(^TMP("IBD-ASK",$J,IBDFMIEN,IBDASK)) S ^TMP("IBD-ASK",$J,IBDFMIEN,$$UP^XLFSTR(IBDASK),IBDF("IBDF"))=""
 I $P($G(^IBE(357.6,+IBDF("PI"),0)),"^")["INPUT VITALS" S QLFR=$P(CHOICE(1),"^",5)
 ;
OVER ;
 K X,Y,DIR,DIRUT,DUOUT,DTOUT
 S OVER=0
 S DIR("?")="Enter the value on the form, or enter Return if there is no value"
 S DIR(0)="FOA^2:"_$P(CHOICE(1),"^",3)
 I $G(QLFR)'="",$P($G(IBDPI(IBDF("PI"),QLFR)),"^",2)'="" S DIR("B")=$P($G(IBDPI(IBDF("PI"),QLFR)),"^",2)
 S DIR("A")=$P(CHOICE(1),"^")_" "
 I $D(IBDF("ASKDATE")) S Y=$$ASKDT^IBDFDE0(DIR("A"),$S($D(DIR("B")):DIR("B"),1:$G(IBDF("DEFLT"))),"",IBDF("APPT")) G REV
 D ^DIR
REV I $G(IBDREDIT),$G(DIR("B"))'="" S IBDPRE=DIR("B") G:Y=$G(DIR("B")) HPQ
 S ANS=$$UP^XLFSTR(Y)
 K DIR
 I $G(IBDREDIT),$G(IBDPRE)'="",ANS="" D DELETE W "   Deleted!" G HPQ
 I ANS="" G HPQ
 I ANS["^",ANS'="^" D  G HPOVER
 .S GOTO=$$UP^XLFSTR($P(ANS,"^",2))
 .I "????"[GOTO X "W !!,""Valid Blocks to Jump to: "" S IBDX=0 F  S IBDX=$O(^TMP(""IBD-ASK"",$J,IBDFMIEN,IBDX)) Q:IBDX=""""  W !,?6,IBDX" S OVER=1 Q
 .S X=$O(^TMP("IBD-ASK",$J,IBDFMIEN,GOTO))
 .I X'="",X[GOTO W $E(X,$L(GOTO)+1,$L(X)) S IBDF("GOTO")=+$O(^TMP("IBD-ASK",$J,IBDFMIEN,X,""))-1,IBDREDIT=1 Q
 .S IBQUIT=1
 I $D(DIRUT) S IBQUIT=1 G HPQ
 ;
VITALS ; -- if vitals, validate input
 S OVER=0
 I $G(QLFR)'="" D  I OVER G HPOVER
 .I $L($T(RATECHK^GMRVPCE0)) D  Q
 ..S OVER='$$RATECHK^GMRVPCE0(QLFR,ANS,$P(CHOICE(1),"^",6))
 ..Q:'OVER
 ..D HELP^GMRVPCE0(QLFR,"HELP")
 ..W ! S IBDX="" F  S IBDX=$O(HELP(IBDX)) Q:IBDX=""  W !,HELP(IBDX)
 ..W ! K ANS,HELP
 .I $L($T(@(QLFR))) D @QLFR Q
 ;
 ; -- delete old answer
 I $G(IBDREDIT),$G(IBDPRE)'="",$G(IBDPRE)'=ANS D DELETE
 ;
 I ANS'="" D
 .S RESULT(0)=$G(RESULT(0))+1
 .S RESULT(RESULT(0))=+IBDF("PI")_"^"_ANS_"^^^^"_QLFR_"^"_$G(IBDF("IEN"))_"^"_$G(IBDF("VITAL"))_"^"_$P(CHOICE(1),"^",4)
 .S IBDPI(IBDF("PI"),$S($G(QLFR)'="":QLFR,1:RESULT(0)))=IBDSEL(RESULT(0))
 .S $P(IBDPI(IBDF("PI"),$S($G(QLFR)'="":QLFR,1:RESULT(0))),"^",13)=RESULT(0)
 ;
HPOVER G:OVER OVER
HPQ Q
 ;
DELETE ; -- delete old answer if changed
 Q:'$G(IBDREDIT)!(ANS=$G(IBDPRE))
 S SEL=+$P($G(IBDPI(IBDF("PI"),QLFR)),"^",13) Q:'SEL
 K IBDPI(IBDF("PI"),QLFR),RESULT(SEL)
 I $G(RESULT(0))=1 S RESULT(0)=0
 Q
 ;
BP ; -- validate blood pressure
 N D,S
 I ANS'?2.3N1"/"2.3N S OVER=1 K ANS G BPQ
 S S=$P(ANS,"/"),D=$P(ANS,"/",2)
 I D<20!(D>200)!(S<20)!(S>275) K ANS S OVER=1
 I S'>D K ANS S OVER=1
BPQ I OVER W !,"Invalid format.  Enter as SYSTOLIC/DIASTOLIC (120/80).  SYSTOLIC must be",!,"between 20 and 275.  DIASTOLIC must be between 20 and 200.  SYSTOLIC must be",!,"greater than DIASTOLIC.",!
 Q
 ;
WT ; -- validate body weight
 I ANS'?1.3N.1".".1N!(ANS<2)!(ANS>750)!(+ANS'=ANS) K ANS S OVER=1
WTQ I OVER W !,"Enter a body weight, 1 decimal place allowed, between 2 and 750 lbs.",!
 Q
 ;
HT ; --validate body height
 I ANS'?2N.1".".1N!(ANS<10)!(ANS>80) K ANS S OVER=1
 I OVER W !,"Enter the body height in inches, 1 decimal place allowed, between 10 and 80.",!
 Q
 ;
AG ; -- validate adominal girth
 I +ANS'=ANS!(ANS?.E1"."1N.N)!(ANS<10)!(ANS>750) K ANS S OVER=1
 I OVER W !,"Enter the abdominal girth in inches, no decimal places, between 10 and 750.",!
 Q
 ;
AUD ; -- validate audiometry
 N %AUI,%AUX
 I $L(ANS,"/")'=17 K ANS S OVER=1
 F %AUI=1:1:16 S %AUX=$P(X,"/",%AUI) I %AUX'="" I %AUX'?1.3N!(+%AUX>110) K ANS S OVER=1
 I OVER W !,"Enter 8 readings for right ear followed by 8 readings for left ear,",!,"all followed by slashes (/).  Values must be between 0 and 110.",!,"EXAMPLE:  100/100/100/95/90/90/85/80/105/105/105/105/100/100/95/90/",!
 Q
 ;
TMP ; -- validate temperature
 I ANS'?2.3N.1".".1N!(ANS<94)!(ANS>109.9)!(+ANS'=ANS) K ANS S OVER=1
 I OVER W !,"Enter the body temperature in degrees fahrenheit, must be between 94 and 109.9.",!
 Q
 ;
FT ; -- validate fetal heart tones
 I ANS'=+ANS!(ANS<50)!(ANS>250)!(ANS?.E1"."1N.N) K ANS S OVER=1
 I OVER W !,"Enter Fetal Heart Tone.  Must be in the range 50 -250.",!
 Q
 ;
FH ; -- validate fundal height
 I ANS'=+ANS!(ANS<10)!(ANS>250)!(ANS?.E1"."1N.N) K ANS S OVER=1
 I OVER W !,"Enter a fundal Height.  Must be in the range 10 - 50",!
 Q
 ;
HC ; -- validate head circumference
 I ANS'=+ANS!(ANS<10)!(ANS>30)!(ANS?.E1"."3N.N) K ANS S OVER=1
 I OVER W !,"To enter head circumference in inches, enter the inches",!,"and decimal.  Must be 10 - 30 inches and the fractional decimal part must",!,"be a multiple of 1/8 (.125)",!
 Q
 ;
HE ; -- validate hearing
 S ANS=$$UP^XLFSTR($E(ANS))
 I "AN"'[ANS K ANS S OVER=1
 I OVER W !,"Enter 'A' for abnormal, or 'N' for Normal.",!
 Q
 ;
PU ; -- validate pulse
 I ANS'?1.3N!(ANS<30)!(ANS>250) K ANS S OVER=1
 I OVER W !,"Enter the patients 1 minute pulse, enter a number between 30 and 250.",!
 Q
 ;
RS ; -- validate respirations
 I ANS'?1.2N!(ANS<8)!(ANS>90) K ANS S OVER=1
 I OVER W !,"Enter the patients 1 minute number of resperations, enter a number between 8 and 90.",!
 Q
 ;
TON ; -- validate tonometry
 N AUTONR,AUTONL
 I $L(ANS)>7!($L(ANS)<2)!'((ANS?.1"R"1.2N1"/")!(ANS?1"/".1"L"1.2N)!(ANS?.1"R"1.2N1"/".1"L"1.2N)) K ANS S OVER=1
 S AUTONR=$P(ANS,"/",1) S:AUTONR?1"R".N AUTONR=$E(AUTONR,2,10)
 S AUTONL=$P(ANS,"/",2) S:AUTONL?1"L".N AUTONL=$E(AUTONL,2,10)
 I AUTONR'="" I AUTONR<0!(AUTONR>80) K ANS S OVER=1
 I AUTONL'="" I AUTONL<0!(AUTONL>80) K ANS S OVER=1
TONX I OVER W !,"Enter a reading for the RIGHT eye, followed by a SLASH, followed",!,"by the reading for the LEFT eye.  The SLASH is required.  Readings can be",!,"between 0 and 80.  Examples:  18/18, /20, 18/, 10/13"
 Q
 ;
VC ; -- validate vision corrected
 ;    same input as uncorrected
VU ; -- validate vision uncorrected
 I $L(ANS)>7!($L(ANS)<2)!'((ANS?2.3N)!(ANS?1"/"2.3N)!(ANS?2.3N1"/"2.3N)) K ANS S OVER=1
 I $P(ANS,"/",1)'="" I $P(ANS,"/",1)<10!($P(ANS,"/",1)>999) K ANS S OVER=1
 I $P(ANS,"/",2)'="" I $P(ANS,"/",2)<10!($P(ANS,"/",2)>999) K ANS S OVER=1
 I OVER W !,"Enter denominators only.  The 20/ is assumed.  Enter right eye",!,"/ left eye in form n/n (20/20).  If right eye only enter n (20).",!,"If left eye only enter /n (/20).  Must be between 10 and 999."
 Q
