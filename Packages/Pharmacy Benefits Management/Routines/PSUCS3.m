PSUCS3 ;BIR/DJE,DJM - GENERATE PSU CS RECORDS (TYPE 17) ;25 AUG 1998
 ;;4.0;PHARMACY BENEFITS MANAGEMENT;;MARCH, 2005
 ;
 ;DBIA'S
 ; Reference to file #40.8   supported by DBIA 2438
 ; Reference to file #58.81  supported by DBIA 2520
 ; Reference to file #50     supported by DBIA 221
 ; Reference to file #42     supported by DBIA 1848
 ; Reference to file #2      supported by DBIA 10035
 ; Reference to file #58.8   supported by DBIA 2519
 ; ***
 ; TYPE 17 - "Logged for patient"
 ; ***
 ;     
TYP17 ; Processing the transaction for dispensing type 17 
 ;('logged for patient'). If the dispensing type=17 and a patient IEN 
 ;is identified, one can use this information one find the ward location
 ;if the patient is still an inpatient when the extract is done.
 D FACILTY
 ;     
 ; (type 17 specific call)
 ; Patient SSN
 D SSN
 ;
 ; Generic name, Location type.
 D GNAME^PSUCS4,LOCTYP^PSUCS4
 ; Requirement 3.2.5.7
 Q:"N"'[PSULTP(1)
 ;
 ; check if drug administered multiple times for a patient
 D MULTCHK
 ;
 ;VA Drug class, Formulary/Non-formulary, National formulary Indicator.
 D NDC^PSUCS4,FORMIND^PSUCS4,NFIND^PSUCS4
 ;
 ;(type 17 specific call)
 ; Dispense unit, unit cost, Quantity
 D DUNIT,UNITC,QTY17
 ;
 ; VA Product name, VA drug class, Packaging
 D VPNAME^PSUCS4,VDC^PSUCS4
 ;
 Q 
 ;
 ;
 ; 
 ; Type 17 specific calls
 ; 
 ;
MULTCHK ; 
 ; store in array (quit if already administered) 
 S PSUMCHK=0
 S PSUQT(5)=$$VALI^PSUTL(58.81,PSUIENDA,5)
 ;  if patient,drug collection started increment QT
 I $D(^XTMP(PSUCSJB,"MC",PSULOC,PSUPIEN(73),PSUDRG(4))) D  Q
 . S X=^XTMP(PSUCSJB,"MC",PSULOC,PSUPIEN(73),PSUDRG(4),"QT")
 . S ^("QT")=X+PSUQT(5)
 ; Save the IEN of the first transaction for collection
 ;S PSUMCIEN=PSUIENDA
 ;  start patient drug collection
 S ^XTMP(PSUCSJB,"MC",PSULOC,PSUPIEN(73),PSUDRG(4))=PSUIENDA
 S ^XTMP(PSUCSJB,"MC",PSULOC,PSUPIEN(73),PSUDRG(4),"QT")=PSUQT(5)
 Q
 ;           
FACILTY ;
 ;Field # 2,.1[WARD LOCATION]
 S PSUWLC(.01)=$$VALI^PSUTL(2,PSUPIEN(73),".01")
 Q:PSUWLC(.01)=""
 S PSUWLC(.01)=$O(^DIC(42,"B",PSUWLC(.01),""))
 Q:PSUWLC(.01)=""
 ;
 ;Field # 58.842,.01 [WARD]  Points to File # 42
 S PSUWARD(1)=$$VALI^PSUTL(58.842,PSUWLC(.01),"1")
 ;D GETS^PSUTL(58.842,PSUWLC(.1),"1","PSUWARD","I")
 ;D MOVEI^PSUTL("PSUWARD")
 ;        
 ;Field # 42,.015 [DIVISION]  Points to File # 40.8
 S PSUDIV(.015)=$$VALI^PSUTL(42,PSUWARD(1),".015")
 ;
 ;Field # 40.8,1 [FACILITY NUMBER]**Field to be extracted
 S PSUFCN(1)=$$VALI^PSUTL(40.8,PSUDIV(.015),"1")
 S SENDER=PSUFCN(1)
 S PSURI=""
 Q
 ;
SSN ;Field # 58.81,73 [PATIENT]  Points to File # 2
 ;Field # 2,.09 [SOCIAL SECURITY NUMBER]**Field to be extracted
 Q:$G(PSUPIEN(73))=""
 S DFN=PSUPIEN(73) D PID^VADPT
 S PSUSSN(.09)=$TR(VA("PID"),"-","")
 Q
 ; 
DUNIT ;Dispense Unit
 ;Field # 50,14.5 [DISPENSE UNIT]**Field to be extracted
 S PSUDUN(14.5)=$$VALI^PSUTL(50,PSUDRG(4),"14.5")
 S UNIT=PSUDUN(14.5)
 Q
 ;
UNITC ;Unit Cost
 ;Field # 50,16 [PRICE PER DISPENSE UNIT]**Field to be extracted
 S PSUPDU(16)=$$VALI^PSUTL(50,PSUDRG(4),"16")
 Q
 ;
QTY17 ;For transactions with a dispensing type =17, total the number of doses
 ;dispensed for the same drug (Field # 58.81,4), regardless of the date 
 ;dispensed within the reporting month. The dispensed (transaction) date
 ;will be the date the first dose was administered to the patient during
 ;the reporting period. The data will be transmitted as a single data
 ;record.
 ;Sum of Values # 58.81,5 [TOTAL QUANTITY]**Field to be extracted
 Q  ;this is handled in gathering into "MC"
 S PSUTQ(5)=$$VALI^PSUTL(58.81,PSUIENDA,5)
 S OLDXTMP=$G(^XTMP(PSUCSJB,"MC",PSULOC,PSUPIEN(73),PSUDRG(4)),"QT")
 S ^XTMP(PSUCSJB,"MC",PSULOC,PSUPIEN(73),PSUDRG(4),"QT")=OLDXTMP+PSUTQ(5)
 Q
