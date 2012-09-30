RGPDENV ;B'HAM/PTD-CIRN PD build environment check routine ;4/15/99
 ;;1.0; CLINICAL INFO RESOURCE NETWORK ;;30 Apr 99
PSJ ;Determine which version of Inpatient Medications is installed.
 S RGOUT="^",RGVER=$$VERSION^XPDUTL("PSJ")
 ;If version not 4.5 or 5.0, abort install.
 I (RGVER'="4.5"),(RGVER'="5.0") W !!,"Inpatient Medications version 4.5 or 5.0 must be installed." S XPDQUIT=2 K RGVER G PSO
 ;If version 5.0 installed, we're ok; go to PSO.
 I RGVER="5.0" G PSO
 ;If version 4.5 installed, check for patch PSJ*4.5*43.
 I RGVER="4.5" S RGPCH=$$PATCH^XPDUTL("PSJ*4.5*43")
 ;If patch PSJ*4.5*43 is installed, continue with PSO.
 I RGPCH=1 G PSO
 ;Else PSJ*4.5*43 is missing; continue with PSO.
 S RGOUT=RGOUT_"INP^",XPDQUIT=2
 ;
PSO ;Determine which version of Outpatient Pharmacy is installed.
 S RGVER=$$VERSION^XPDUTL("PSO")
 ;If version not 6.0 or 7.0, abort install.
 I (RGVER'="6.0"),(RGVER'="7.0") W !!,"Outpatient Pharmacy version 6.0 or 7.0 must be installed." S XPDQUIT=2 G END
 I RGVER="7.0" G PSO7
PSO6 ;If version 6.0 installed, check for patch PSO*6*156.
 I RGVER="6.0" S RGPCH=$$PATCH^XPDUTL("PSO*6.0*156")
 ;If patch PSO*6*156 is installed, quit.
 I RGPCH=1 G END
 ;Else PSO*6*156 is missing.
 S RGOUT=RGOUT_"OUT6^",XPDQUIT=2 G END
PSO7 ;If version 7.0 installed, check for patch PSO*7*11.
 I RGVER="7.0" S RGPCH=$$PATCH^XPDUTL("PSO*7.0*11")
 ;If patch PSO*7*11 is installed, quit.
 I RGPCH=1 G END
 ;Else PSO*7*11 is missing.
 S RGOUT=RGOUT_"OUT7^",XPDQUIT=2
 ;
END ;Write install message based on set conditions.
 ;Patch PSJ*4.5*43 missing.
 I RGOUT["IMP" W !!,"You must have patch PSJ*4.5*43 installed for Inpatient Medications."
 ;Patch PSO*6*156 missing.
 I RGOUT["OUT6" W !!,"You must have patch PSO*6*156 installed for Outpatient Pharmacy."
 ;Patch PSO*7*11 missing.
 I RGOUT["OUT7" W !!,"You must have patch PSO*7*11 installed for Outpatient Pharmacy."
 ;All conditions are OK.
 I '$D(XPDQUIT) W !!,"Environment check is ok.",!
 K RGOUT,RGPCH,RGVER
 Q
 ;
