PSO583PI ;BIR/MFR-Post-install routine for Patch PSO*7*583 ; 02 Aug 2018  2:00 PM
 ;;7.0;OUTPATIENT PHARMACY;**583**;DEC 1997;Build 3
 ;
 Q
POST ; entry point
 D BMES^XPDUTL("  Starting post-install for PSO*7*583")
 N ISSDT,FOUND,RXIEN,DIVNAM,PATNAM,PATIEN,STATUS,DRGIEN,DRGNAM,DOSIEN,DOSE,Z,UNITS,PSOLINE
 S PSOLINE=0 K ^TMP("PSO583PI",$J),^XTMP("PSO583PI",$J)
 D SETTXT("The CPRS patch OR*3*440 was released Back in 2017 to address a problem with")
 D SETTXT("the Ward Clerk Menu [OR MAIN MENU WARD CLERK] option that was causing some")
 D SETTXT("Outpatient Pharmacy orders and prescriptions to have the wrong dispense units.")
 D SETTXT("Although the problem seems to have been resolved by preventing new orders with")
 D SETTXT("the problem from being created it did not go far enough to prevent that")
 D SETTXT("existing orders with the problem could propagate the problem well into the")
 D SETTXT("future by being copied or renewed.")
 D SETTXT("The list below should be analyzed entry by entry and a determination should be")
 D SETTXT("made by the Pharmacy ADPAC at the site whether the outpatient prescription dose")
 D SETTXT("and dispense units are correct for the dispense drug or not.")
 D SETTXT("If it is determined that the prescription dose/dispense unit is incorrect the")
 D SETTXT("Outpatient Pharmacy staff should take action to discontinue the prescription")
 D SETTXT("and re-renter it with the correct dosing and dispense unit information.")
 D SETTXT("-------------------------------------------------------------------------------")
 D SETTXT("PATIENT (L4SSN)")
 D SETTXT("  RX #         DISPENSE DRUG                    DOSE ORD.     UNITS    STRENGTH")
 D SETTXT("-------------------------------------------------------------------------------")
 ; Looking for Dose/Drug mismatches - Look back 1 year for Active prescriptions
 S ISSDT=$$FMADD^XLFDT(DT,-367),FOUND=0
 F  S ISSDT=$O(^PSRX("AC",ISSDT)) Q:'ISSDT  D
 . S RXIEN=0 F  S RXIEN=$O(^PSRX("AC",ISSDT,RXIEN)) Q:'RXIEN  D
 . . S DIVNAM=$$GET1^DIQ(52,RXIEN,20)
 . . S PATNAM=$$GET1^DIQ(52,RXIEN,2),PATIEN=$$GET1^DIQ(52,RXIEN,2,"I")
 . . ; Skip entry if Rx is DC'd/Expired/Deleted
 . . S STATUS=$$GET1^DIQ(52,RXIEN,100,"I") I STATUS>10 Q
 . . S DRGIEN=$$GET1^DIQ(52,RXIEN,6,"I"),DRGNAM=$$GET1^DIQ(50,DRGIEN,.01)
 . . ; Skip a few False positives for the logic because of Drug Composition
 . . I (DRGNAM["ZINC")!(DRGNAM["POTASSIUM")!(DRGNAM["CALCIUM")!(DRGNAM["FISH")!(DRGNAM["FERROUS") Q
 . . I (DRGNAM["PHENOBARBITAL")!(DRGNAM["LEVOTHYROXINE") Q
 . . ; Skip entry if Drug does not have Strength
 . . S STREN=$$GET1^DIQ(50,DRGIEN,901) I 'STREN Q
 . . ; Skip entry if Rx does not have a dose
 . . S DOSIEN=$O(^PSRX(RXIEN,6,0)) I 'DOSIEN Q
 . . ; Skip entry if Rx dose is not numeric
 . . S Z=$G(^PSRX(RXIEN,6,DOSIEN,0)),DOSE=+Z,UNITS=$P(Z,"^",2) I 'DOSE!'UNITS Q
 . . ; Skip entry if Dose = Units * Drug Strength
 . . I (UNITS*STREN)=DOSE Q
 . . ; Skip entry if discrepancy is minimal (false positive)
 . . I (((DOSE/STREN)<2)&((STREN/DOSE)<2)&((STREN/DOSE)'=1)) Q
 . . S ^TMP("PSO583PI",$J,DIVNAM_" ",PATNAM_"^"_PATIEN,RXIEN)=DOSE_"^"_UNITS_"^"_STREN
 . . S FOUND=FOUND+1
 ;
 I FOUND D
 . S (DIVNAM,PATNAM,RXIEN)=""
 . F  S DIVNAM=$O(^TMP("PSO583PI",$J,DIVNAM)) Q:(DIVNAM="")  D
 . . D SETTXT("Division: "_DIVNAM)
 . . F  S PATNAM=$O(^TMP("PSO583PI",$J,DIVNAM,PATNAM)) Q:(PATNAM="")  D
 . . . D SETPAT($P(PATNAM,"^",2))
 . . . F  S RXIEN=$O(^TMP("PSO583PI",$J,DIVNAM,PATNAM,RXIEN)) Q:'RXIEN  D
 . . . . S Z=^TMP("PSO583PI",$J,DIVNAM,PATNAM,RXIEN)
 . . . . D SETRX(RXIEN,$P(Z,"^"),$P(Z,"^",2),$P(Z,"^",3))
 . . D SETTXT(" ")
 . D SETTXT(" "),SETTXT(FOUND_" prescriptions found.")
 E  D
 . D SETTXT("No prescriptions were found with a potential dose/dispense unit problem.")
 ;
 D MAIL
 ;
 D BMES^XPDUTL("  Mailman message sent.")
 D BMES^XPDUTL("  Finished post-install for PSO*7*583.")
 ;
END ; Exit point
 K ^TMP("PSO583PI",$J),^XTMP("PSO583PI",$J)
 Q
 ;
SETTXT(TXT) ; Setting Plain Text
 S PSOLINE=$G(PSOLINE)+1,^XTMP("PSO583PI",$J,PSOLINE)=TXT
 Q
 ;
SETPAT(DFN) ; Setting Patient Line
 N L4SSN,VADM
 D DEM^VADPT S L4SSN=$P($P(VADM(2),"^",2),"-",3)
 S PSOLINE=$G(PSOLINE)+1,^XTMP("PSO583PI",$J,PSOLINE)=$P(VADM(1),"^")_" ("_L4SSN_")"
 Q
 ;
SETRX(RXIEN,DOSE,UNITS,STREN) ; Setting Rx Line
 N TXTLN
 S $E(TXTLN,3)=$$GET1^DIQ(52,RXIEN,.01),$E(TXTLN,16)=$E($$GET1^DIQ(52,RXIEN,6),1,30)
 S $E(TXTLN,48)=$J(DOSE,7),$E(TXTLN,62)=$J(UNITS,4),$E(TXTLN,73)=$J(STREN,5)
 S PSOLINE=$G(PSOLINE)+1,^XTMP("PSO583PI",$J,PSOLINE)=TXTLN
 Q
 ;
MAIL ; Sends Mailman message
 N II,XMX,XMSUB,XMDUZ,XMTEXT,XMY
 S II=0 F  S II=$O(^XUSEC("PSNMGR",II)) Q:'II  S XMY(II)=""
 S XMY(DUZ)="",XMSUB="PSO*7*583 - Renewed/Copied Rx Dose/Dispense Unit Discrepancies"
 S XMDUZ=.5,XMTEXT="^XTMP(""PSO583PI"",$J," N DIFROM D ^XMD
 Q
