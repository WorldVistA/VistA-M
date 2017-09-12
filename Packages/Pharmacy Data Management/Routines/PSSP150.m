PSSP150 ;SMT - PSS*150 Post Install ; 8/31/2012
 ;;1.0;PHARMACY DATA MANAGEMENT;**150**;9/30/97;Build 2
 ;
 ; To correct Remedy HD344317, 
 ; Field .03 (IV FLAG) of File 50.7 (Pharmacy Orderable Item)
 ; will have write access from fileman restricted.
 ;
EN ;
 ;Update write access for IV FLAG field
 S ^DD(50.7,.03,9)="^"
 Q
