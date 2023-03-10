PSO630PI ;BIRM/SJA - PSO*7*630 Post-install routine ;1/19/21  16:19
 ;;7.0;OUTPATIENT PHARMACY;**630**;DEC 1997;Build 26
 ;
 ;1) Adding the PRE09 Data Element for Provider DETOX Number to ASAP
 ;   (American Society for Automation in Pharmacy) standard version 4.2
 ;2) Updating the OE/RR NOTIFICATIONS File 100.9 for 75 and 76
 ;3) Adding a standard menu with five items
 ;
POST ;
 N V,S,D,E,L
 S V="VER",S="SEG",D="DAT",E="DES",L="VAL",U="^"
 S ^PS(58.4,1,V,7,S,4,D,0)="^58.400111I^3^3"
 S ^PS(58.4,1,V,7,S,4,D,3,0)="PRE09^Provider DETOX Number^AN^9^9^O"
 S ^PS(58.4,1,V,7,S,4,D,3,E,0)="^58.4001111^3^3^3210111^^"
 S ^PS(58.4,1,V,7,S,4,D,3,E,1,0)="Provider's DETOX NUMBER is transmitted to the state when the NDC# for the "
 S ^PS(58.4,1,V,7,S,4,D,3,E,2,0)="prescribed drug contains Buprenorphine and is NOT represented by a "
 S ^PS(58.4,1,V,7,S,4,D,3,E,3,0)="product listed in the PSS BUPRENORPHINE PAIN VAPRODS parameter."
 S ^PS(58.4,1,V,7,S,4,D,3,L,0)="^58.410111^1^1^3210108^^"
 S ^PS(58.4,1,V,7,S,4,D,3,L,1,0)="$$PRE09^PSOASAP0()"
 S ^PS(58.4,1,V,7,S,4,D,"B","PRE09",3)=""
 ;
 ;Update OE/RR NOTIFICATIONS File 100.9
 S $P(^ORD(100.9,75,0),U,1)="PIV Certificate Revoked"
 S $P(^ORD(100.9,75,0),U,3)="Rx NOT processed: PIV Card Certificate Revoked"
 S $P(^ORD(100.9,76,0),U,1)="PIV Certificate Expired"
 S $P(^ORD(100.9,76,0),U,3)="Rx processed: PIV Card Cert Expired - NO ACTION REQ"
 ;
 D MENU
 Q
 ;
MENU ;
 N MENU,OPTION,CHECK,CHOICE,SYN,ORD,TYPE,OFF,UPDATE
 S TYPE="MENUADD" F OFF=1:1 S CHOICE=$P($T(@TYPE+OFF),";;",2) Q:CHOICE="DONE"  D
 . S OPTION=$P(CHOICE,"^"),MENU=$P(CHOICE,"^",2),SYN=$P(CHOICE,"^",3),ORD=$P(CHOICE,"^",4)
 . S CHECK=$$ADD^XPDMENU(MENU,OPTION,SYN,ORD)
 . D BMES^XPDUTL(">>> "_OPTION_" Option"_$S('CHECK:" created",1:" added to "_MENU)_" <<<")
 S OPTION=$$LKOPT^XPDMENU("PSO MBM-VPS PHARMACY MENU") Q:'+OPTION
 S UPDATE(19,OPTION_",",1)="MbM-VPS Pharmacy Users Menu"
 D FILE^DIE("","UPDATE")
 D BMES^XPDUTL("MbM-VPS Pharmacy Menu Options added")
 Q
 ;
MENUADD ; Menu items to be added
 ;;PSO MBM-VPS PHARMACY MENU^^VPS^
 ;;PSO LMOE FINISH^PSO MBM-VPS PHARMACY MENU^C^1
 ;;PSO LM BACKDOOR ORDERS^PSO MBM-VPS PHARMACY MENU^P^2
 ;;PSO VIEW^PSO MBM-VPS PHARMACY MENU^V^3
 ;;PSS LOOK^PSO MBM-VPS PHARMACY MENU^L^4
 ;;PSO MBM-VPS PRODUCTIVITY RPT^PSO MBM-VPS PHARMACY MENU^R^5
 ;;DONE
