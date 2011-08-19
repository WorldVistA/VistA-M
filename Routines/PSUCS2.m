PSUCS2 ;BIR/DJE,DJM - Generate CS records (TYPE2) ;25 AUG 1998
 ;;4.0;PHARMACY BENEFITS MANAGEMENT;;MARCH, 2005
 ;
 ;DBIA's
 ; Reference to File #58.81  supported by DBIA 2520
 ; Reference to File #50     supported by DBIA 221
 ; Reference to File #58.8   supported by DBIA 2519
 ; Reference to File #59     supported by DBIA 2510
 ;
 ; *
 ; TYPE 2 - "Dispensed from pharmacy"
 ; *
 ;
TYP2 ; Processing the transaction for dispensing type 2 
 ;('logged for patient'). If the  pharmacy location for transactions 
 ;with a dispensing type = 2 is associated with either an Outpatient
 ; Or Inpatient site, it may be possible to break down the sender by 
 ;the outpatient clinic or inpatient division.
 ;
 K PSUQUIT
 S PSUDRG(4)=$$VALI^PSUTL(58.81,PSUIENDA,4)
 ;
 ;(type 2 specific call)
 D QTY2
 I 'PSUTQY(5) S PSUQUIT=1 Q  ; do not send if QTY=0
 ;
 ;  Unit cost
 S PSUPDU(16)=$$VALI^PSUTL(50,PSUDRG(4),16)
 ;
 ; DIVISION
 D DIVISION
 ;
 ;(Type 2 specific call)
 D NAOU
 ;
 ;        
 ; Generic name, Location type.       
 D GNAME^PSUCS4,LOCTYP^PSUCS4
 ;Requirement 3.2.5.7
 I "SM"'[PSULTP(1) S PSUQUIT=1 Q  ;**9
 ;W PSULTP(1)
 ;Requirement 3.2.5.8
 I CPFLG="N" S PSUQUIT=1 Q  ;**9
 ;
 ;VA Drug class, Formulary/Non-formulary, National formulary Indicator
 D NDC^PSUCS4,FORMIND^PSUCS4,NFIND^PSUCS4
 ;
 ;
 ; VA Product name, VA drug class, Package details.
 D VPNAME^PSUCS4,VDC^PSUCS4,PDT^PSUCS4
 ;
 Q
 ;
 ;
 ; 
 ; 
 ;      
DIVISION ;
 ;Field # 58.81,2 [PHARMACY LOCATION]  Points to File # 58.8
 S PSUPL(2)=$$VALI^PSUTL(58.81,PSUIENDA,"2")
 S SENDER=""
 N MAPLOCI
 D GETM^PSUTL(59.7,1,"90.02*^.01;.02;.03","MAPLOCI","I")
 D MOVEMI^PSUTL("MAPLOCI")
 ;
 I $G(MAPLOCI(PSUPL(2),.01)) D
 .S X=$G(MAPLOCI(PSUPL(2),.02)) I X S SENDER=$$VALI^PSUTL(40.8,X,1)
 .S X=$G(MAPLOCI(PSUPL(2),.03)) I X S SENDER=$$VALI^PSUTL(59,X,.06)
 I '$G(MAPLOCI(PSUPL(2),.01)) D
 .S SENDER=PSUSNDR,PSURI="H"
 Q
 ;
NAOU ;3.2.5.6.   Functional Requirement 6
 ;The product shall extract the NAOU if the dispensing type =2.
 ;Field # 58.81,17 [NAOU]  Points to File # 58.8
 S PSUNAOU(17)=$$VALI^PSUTL(58.81,PSUIENDA,"17")
 S PSUNAOU=PSUNAOU(17)
 ;
 ;If the NAOU does not exist for that transaction,
 ;extract the Pharmacy PSULOCation.
 ;Field # 58.81,2 [PHARMACY PSULOCATION] Points to File # 58.8
 I PSUNAOU="" D
 .S PSUNAOU(2)=$$VALI^PSUTL(58.81,PSUIENDA,"2")
 .S PSUNAOU=PSUNAOU(2)
 ;
 ;Field # 58.8,.01 [PHARMACY PSULOCATION]***Field to be extracted
 S PSUPLC(.01)=$$VALI^PSUTL(58.8,PSUNAOU,".01")
 Q
 ;       
QTY2 ;3.2.5.10.   Functional Requirement 10
 ;The product shall extract the total quantity dispensed.  
 ;For transactions with a dispensing type=2, check to see if 
 ;the quantity was edited (Field # 58.81,48).
 ;If so, use the edited (new quantity).
 ; if there is a date present then use the NEW QUANTITY value.
 ;Field # 58.81,50 [NEW QUANTITY]**Field to be extracted       
 S PSUQED(48)=$$VALI^PSUTL(58.81,PSUIENDA,"48")
 S PSUTQY(5)=$$VALI^PSUTL(58.81,PSUIENDA,5)
 S:'PSUDRG(4) PSUDRG(4)=$$VALI^PSUTL(58.81,PSUIENDA,4)
 ;
 I PSUQED(48) S PSUTQY(5)=$$VALI^PSUTL(58.81,PSUIENDA,50)
 S:PSUTQY(5) ^XTMP(PSUCSJB,"TQTY",PSULOC,PSUIENDA,PSUDRG(4))=PSUTQY(5)
 Q
 ;
