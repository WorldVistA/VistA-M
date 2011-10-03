PSUENV ;BIR/PDW ; PBM V 3.0 ENVIRONMENTAL CHECK ROUTINE
 ;;4.0;PHARMACY BENEFITS MANAGEMENT;;MARCH, 2005
EN ; CHECK ENVIRONMENT
 ;
 ; 
 S (PSUPSJOK,PSUPSOOK,PSUOK,PSUNDFOK)=0
 K XPDQUIT
 ;   Check Pharmacy Benefits Managment installed
 S X=$$VERSION^XPDUTL("PSS")
 I +X'=1 D  G END
 . Q:$G(ZTQUEUED)
 . W !,"**INSTALLATION ABORTED** "
 . W "Pharmacy Data Managment Version 1 is REQUIRED for this install !!"
 ; 
 S X=$$PATCH^XPDUTL("PSS*1.0*13")
 I 'X D  G END
 . Q:$G(ZTQUEUED)
 . W !,"**INSTALLATION ABORTED** "
 . W "Patch PSS*1*13 is REQUIRED for this install !!"
 ;
 ;   Check In Patient version and Patch
 S X=$$VERSION^XPDUTL("PSJ")
 I +X=0 S PSUPSJOK=1 G OP ; IP not installed.. proceed to OP
 I +X=4.5 D
 . S Y=$$PATCH^XPDUTL("PSJ*4.5*61")
 . I Y S PSUPSJOK=1 Q
 . Q:$G(ZTQUEUED)
 . W !,"**INSTALLATION ABORTED** "
 . W "Patch PSJ*4.5*61 is REQUIRED for this install !!"
 ;
 I +X=5,PSUPSJOK=0 D
 . S Y=$$PATCH^XPDUTL("PSJ*5.0*13")
 . I Y S PSUPSJOK=1 Q
 . Q:$G(ZTQUEUED)
 . W !,"**INSTALLATION ABORTED** "
 . W "Patch PSJ*5.0*13 is REQUIRED for this install !!"
 ;
OP ;    Check Out Patient Version and Patch
 S X=$$VERSION^XPDUTL("PSO")
 I "6^7"'[$E(+X) D  G END
 . W !,"**INSTALLATION ABORTED** "
 . W "Version 6 or 7 of Outpatient Pharmacy is REQUIRED for this install !!"
 I +X=6 S PSUPSOOK=1
 I +X=7 D
 . S Y=$$PATCH^XPDUTL("PSO*7.0*11")
 . I Y S PSUPSOOK=1 Q
 . Q:$G(ZTQUEUED)
 . W !,"**INSTALLATION ABORTED** "
 . W "Patch PS0*7.0*11 is REQUIRED for this install !!"
 ;
 ;    Check if proper version of NDF is installed
 S X=$$VERSION^XPDUTL("PSN")
 I X'>3.17 D  G END
 . Q:$G(ZTQUEUED)
 . W !,"**INSTALLATION ABORTED** ",!
 . W "National Drug File Version 3.18 or higher is REQUIRED for this install !!"
 S PSUNDFOK=1
 ;
END ;EP
 I PSUPSJOK,PSUPSOOK,PSUNDFOK S PSUOK=1
 I 'PSUOK W:'$G(ZTQUEUED) !,"Installation Stopping",! S XPDQUIT=1
 Q
