PSUCS4 ;BIR/DJE - PBM CS GENERATE RECORDS ;13 OCT 1999
 ;;4.0;PHARMACY BENEFITS MANAGEMENT;;MARCH, 2005
 ; 
 ; **
 ; General Calls from type 2 & 17
 ; **
 ;DBIAs
 ; Reference to file #50    supported by DBIA 221
 ; Reference to file #58.8  supported by DBIA 2519
 ; Reference to file #58.81 supported by DBIA 2520
 ;
GNAME ;3.2.5.11. Functional Requirement 11
 ;Field   # 58.81,4 [DRUG] Points to File # 50
 S PSUDRG(4)=$$VALI^PSUTL(58.81,PSUIENDA,"4")
 ;
 ;Generic Drug Name 
 ;Field   # 50,.01 [GENERIC NAME]**Field to be extracted
 S PSUGDN(.01)=$$VALI^PSUTL(50,PSUDRG(4),".01")
 I $G(PSUGDN(.01))="" S PSUGDN(.01)="Unknown Generic Name"
 Q 
 ;  
LOCTYP ;3.2.5.7.   Functional Requirement 7
 ;Transactions with a dispensing type (field # 58.81,1) of '2' 
 ; - Dispensed from Pharmacy must be associated with a location type 
 ;(field # 58.8,1) of 'M' for Master or 'S' for Satellite.
 ;Transactions with a dispensing type (field # 58.81,1) of '17' 
 ;- Logged for Patient must  be associated with a location type 
 ;(field # 58.8,1) of 'N' for narcotic location.
 ;S PSULTP(1)=$$VALI^PSUTL(58.81,PSUIENDA,"1")
 ;D MOVEI^PSUTL("PSULTP")
 S PSULTP(1)=$$VALI^PSUTL(58.8,PSULOC,1)
 Q:PSUTYP=17
 ;
 ;3.2.5.8.   Functional Requirement 8
 ;Transactions with a dispensing type '2'-dispensed from pharmacy 
 ;(field # 58.81,1) and a Location type of 'M' for 'S' (field # 58.8,1)
 ;
 ; Continue Processing Flag (CPFLG)
 S CPFLG="Y"
 ; but that have been cancelled (field # 58.81,55) will be excluded.
 ; (ie.If there is a 'cancel verified order date' - PSUCDT)
 S PSUCDT(55)=$$VALI^PSUTL(58.81,PSUIENDA,"55")
 Q:$G(PSUCDT(55))=""
 S CPFLG="N"
 Q 
 ;
 ;3.2.5.9.   Functional Requirement 9
 ;Dispensing transactions that meet the criteria in functional 
 ;requirements 3.2.5.3., 3.2.5.7. and 3.2.5.8. will have the following 
 ;additional data elements for the  drug extracted.
 ;
NDC ;NDC
 ;Field # 50,31 [NDC]**Field to be extracted
 ;If no data found, send "No NDC".
 S PSUNDC(31)=$$VALI^PSUTL(50,PSUDRG(4),"31")
 I $G(PSUNDC(31))="" S PSUNDC(31)="No NDC"
 Q 
 ; 
 ;
FORMIND ;Formulary/Non-Formulary Indicator
 ;Field # 50,51 [NON-FORMULARY]**Field to be extracted
 S PSUFID(51)=$$VALI^PSUTL(50,PSUDRG(4),"51")
 Q
 ;
NFIND ;National Formulary Indicator
 ;Product will need to check whether or not Vs 4.0 of 
 ;National Drug File is installed. If not, this field will not exist.
 ;Check for National Drug File
 S (NFIND,NFRES)=""
 S VERSION=$$VERSION^XPDUTL("PSN")
 Q:VERSION<4.0
 ;Field # 50.68,17 [NATIONAL FORMULARY INDICATOR]***Field to be extracted
 ;If  National Drug File vs 4.0 is not installed
 ;Transmission format: Send null
 ;If National Drug File vs 4.0 is installed
 S PSUDRG4=PSUDRG(4)
 D GETS^PSUTL(50,PSUDRG4,"20;22;3;52","PSUDRG","I")
 D MOVEI^PSUTL("PSUDRG")
 S PSUDRG(4)=PSUDRG4
 ;
 S PSUNFI(17)=$$FORMI^PSNAPIS(PSUDRG(20),PSUDRG(22))
 ;Transmission format: Internal value ('1' for Yes, '0' for  No)
 ;National Formulary Restriction Indicator
 ;Product shall check whether or not Vs 4.0 of National Drug File 
 ;is installed. If not, this field will not exist.
 ;Field #50.6818,.01[NATIONAL FORMULARY RESTRICTION]Field to be extracted
 ;
 S PSUNFR(.01)=$$FORMR^PSNAPIS(PSUDRG(20),PSUDRG(22))>0
 S PSUNFR(.01)=$S($G(PSUNFR(.01))="":0,1:PSUNFR(.01))
 ;
 ;If  National Drug File vs 4.0 is not installed
 ;Transmission format: Send null
 ;If National Drug File vs 4.0 is installed 
 ;Transmission format:  If no value is found send '0', 
 ;if data exists sent '1'
 Q
 ;   
VPNAME ;VA Product Name
 ;Field # 50,21[VA PRODUCT NAME]**Field to be extracted
 S PSUVPN(21)=$$VALI^PSUTL(50,PSUDRG(4),"21")
 S PSUDRG4=PSUDRG(4) ;if no value found, send "Unknown VA Product Name"
 I $G(PSUVPN(21))="" S PSUVPN(21)="Unknown VA Product Name"
 D GETS^PSUTL(50,PSUDRG(4),"3;52","PSUDRG","I"),MOVEI^PSUTL("PSUDRG")
 S PSUDRG(4)=PSUDRG4 ;DEA, NFI
 Q 
 ;
VDC ; VA Drug Class
 ;Field   # 50,2 [NATIONAL DRUG CLASS] Pointer to File # 50.605
 ;used DRUG pointer from previous quantity check.
 S PSUNAC(2)=$$VALI^PSUTL(50,PSUDRG(4),"2")
 ;
 ;Field   # 50.605,.01 [CODE]**Field to be extracted
 S PSUFID(.01)=PSUNAC(2)
 Q
 ;Field   # 58.8001,.01 [DRUG] Pointer to File # 50
 ;
PDT ;Package details
 ;Field   # 58.8001,7 [BREAKDOWN UNIT]**Field to be extracted
 ;Field   # 58.8001,8 [PACKAGE SIZE]**Field to be extracted
 S PSUSITE=0
 S PSUSITE=$$VALI^PSUTL(58.8,PSUIENDA,20)
 S:'PSUSITE PSUSITE=$$VALI^PSUTL(58.81,PSUIENDA,2)
 D GETS^PSUTL(58.8001,"PSUSITE,PSUDRG(4)","7;8","PSUPDT","I")
 D MOVEI^PSUTL("PSUPDT")
 S UNIT=$G(PSUPDT(7),"NA")
 Q
