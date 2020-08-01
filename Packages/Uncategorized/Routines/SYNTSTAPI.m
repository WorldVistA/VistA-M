SYNTSTAPI ; HC/art - HealthConcourse - run in code unit tests ;07/30/2019
 ;;1.0;DHP;;Jan 17, 2017;Build 46
 ;;
 ;;Original routine authored by Andrew Thompson & Ferdinand Frankson of Perspecta 2017-2019
 ;
 QUIT
 ;
EN ;Run unit tests
 ;
 W !!!,"----- Patient Vitals",!
 I $$DOIT D
 .D T1^SYNDHP01
 .W !!
 .D T2^SYNDHP01
 .W !!
 .D T3^SYNDHP01
 W !!!,"----- Patient Immunizations",!
 I $$DOIT D
 .D T1^SYNDHP02
 .W !!
 .D T2^SYNDHP02
 .W !!
 .D T3^SYNDHP02
 W !!!,"----- Patient Conditions",!
 I $$DOIT D
 .D T1^SYNDHP03
 .W !!
 .D T2^SYNDHP03
 .W !!
 .D T6^SYNDHP03
 .W !!
 .D T7^SYNDHP03
 .W !!!,"----- Patients with a Condition",!
 .D T3^SYNDHP03
 .W !!
 .D T4^SYNDHP03
 .W !!
 .D T5^SYNDHP03
 W !!!,"----- Patient Procedures",!
 I $$DOIT D
 .D T1^SYNDHP04
 .W !!
 .D T2^SYNDHP04
 W !!!,"----- Patient Diagnostic Reports",!
 I $$DOIT D
 .D T1^SYNDHP05
 .W !!
 .D T2^SYNDHP05
 .W !!
 .D T3^SYNDHP05
 W !!!,"----- Institution Details for Hospital Location",!
 I $$DOIT D
 .D T1^SYNDHP06
 .W !!
 .D T2^SYNDHP06
 W !!!,"----- Patient Nursing Care Plan Goals",!
 I $$DOIT D
 .D T1^SYNDHP07
 .W !!
 .D T2^SYNDHP07
 .W !!
 .D T3^SYNDHP07
 W !!!,"----- Patient Flags",!
 I $$DOIT D
 .D T1^SYNDHP08
 .W !!
 .D T2^SYNDHP08
 W !!!,"----- Patient Health Factors",!
 I $$DOIT D
 .D T1^SYNDHP09
 .W !!
 .D T2^SYNDHP09
 .W !!
 .D T3^SYNDHP09
 .;D HLFTEST0^SYNDHP09
 .;D HLFTEST1^SYNDHP09
 W !!!,"----- Patient Encounters",!
 I $$DOIT D
 .D T1^SYNDHP40
 .W !!
 .D T2^SYNDHP40
 .W !!
 .D T3^SYNDHP40
 W !!!,"----- Patient Appointments",!
 I $$DOIT D
 .D T1^SYNDHP41
 .W !!
 .D T2^SYNDHP41
 .W !!
 .D T3^SYNDHP41
 W !!!,"----- validate patient",!
 I $$DOIT D
 .D TESTP^SYNDHP43
 .W !!
 .D TESTF1^SYNDHP43
 .W !!
 .D TESTF2^SYNDHP43
 .W !!
 .D TESTF3^SYNDHP43
 .W !!
 .D TESTF4^SYNDHP43
 .W !!
 .D TESTF5^SYNDHP43
 .W !!
 .D T3^SYNDHP43
 W !!!,"----- Patient Demographics",!
 I $$DOIT D
 .D T1^SYNDHP47
 .W !!
 .D T2^SYNDHP47
 .W !!
 .D T3^SYNDHP47
 .W !!
 .D T4^SYNDHP47
 .;D T5^SYNDHP47  ;all patients
 W !!!,"----- Patient Medication Administration",!
 I $$DOIT D
 .;D T1^SYNDHP48  ;all ICNs
 .D T4^SYNDHP48
 .W !!
 .D T5^SYNDHP48
 W !!!,"----- Patient Medication Dispense",!
 I $$DOIT D
 .;D T2^SYNDHP48  ;all ICNs
 .D T6^SYNDHP48
 .W !!
 .D T7^SYNDHP48
 W !!!,"----- Patient Medication Statement",!
 I $$DOIT D
 .;D T3^SYNDHP48  ;all ICNs
 .D T8^SYNDHP48
 .W !!
 .D T9^SYNDHP48
 W !!!,"----- Patient Chem Labs",!
 I $$DOIT D
 .D T1^SYNDHP53
 .W !!
 .D T2^SYNDHP53
 .W !!
 .D T3^SYNDHP53
 W !!!,"----- Patient Providers for Encounters",!
 I $$DOIT D
 .D T1^SYNDHP54
 .W !!
 .D T2^SYNDHP54
 .W !!
 .D T3^SYNDHP54
 W !!!,"----- Patient Observations",!
 I $$DOIT D
 .D T1^SYNDHP56
 .W !!
 .D T2^SYNDHP56
 .W !!
 .D T3^SYNDHP56
 W !!!,"----- Patient Allergies",!
 I $$DOIT D
 .D T1^SYNDHP57
 .W !!
 .D T2^SYNDHP57
 .W !!
 .D T3^SYNDHP57
 .W !!
 .D ALLTEST0^SYNDHP57
 .;D PROTEST^SYNDHP57
 W !!!,"----- Care Team",!
 I $$DOIT D
 .D T1^SYNDHP58
 .W !!
 .D T2^SYNDHP58
 W !!!,"----- Care Teams",!
 I $$DOIT D
 .D T3^SYNDHP58
 .W !!
 .D T4^SYNDHP58
 .W !!
 .D T5^SYNDHP58
 W !!!,"----- Patient Care Plans",!
 I $$DOIT D
 .D T1^SYNDHP59
 .W !!
 .D T2^SYNDHP59
 .W !!
 .D T3^SYNDHP59
 W !!!,"----- Patient Care Plan for a Visit",!
 I $$DOIT D
 .D T4^SYNDHP59
 .W !!
 .D T5^SYNDHP59
 W !!!,"----- Patient TIU Notes",!
 I $$DOIT D
 .D T1^SYNDHP67
 .W !!
 .D T2^SYNDHP67
 .W !!
 .D T3^SYNDHP67
 .W !!
 .D T4^SYNDHP67
 .W !!
 .D T5^SYNDHP67
 W !!!,"----- M Unit Test",!
 .;D T1^SYNDHP69
 W !!!,"----- VistA Record by Resource ID",!
 I $$DOIT D
 .D T1^SYNDHP99
 .W !!
 .D T2^SYNDHP99
 ;
 ;
 QUIT
 ;
DOIT() ;
 N X,Y,DIR,DTOUT,DUOUT,DIRUT,DIROUT
 S DIR(0)="YAO"
 S DIR("A")="Do you want to run these? (Y/N): "
 S DIR("B")="N"
 S DIR("?")="Enter Y to run, N to skip."
 ;S DIR("??")="Enter Y to run, N to skip."
 D ^DIR
 I $D(DTOUT)!$D(DUOUT)!$D(DIRUT)!$D(DIROUT) QUIT 0
 QUIT Y
 ;
