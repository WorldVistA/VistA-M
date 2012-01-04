DGYPSDE3 ;ALB/RMO - Classification Cont. - Check Out ;31 MAR 1993 3:10 pm
 ;;5.2;REGISTRATION;**27**;JUL 29,1992
 ;; ;
 ;
BLD(DFN,DGYPY) ; -- build class array
 I $$AO(DFN) S DGYPCL(1)=""
 I $$IR(DFN) S DGYPCL(2)=""
 I $$SC(DFN) S DGYPCL(3)=""
 I $$EC(DFN) S DGYPCL(4)=""
 Q
 ;
AO(DFN) ;Agent Orange Exposure Screen
 ; Input  -- DFN      Patient file IEN  
 ; Output -- Ask Agent Orange Exposure Classification
 ;           1=Yes and 0=No
 N DGYPELG,Y
 I $P($G(^DPT(DFN,.321)),"^",2)'="Y" G AOQ
 S DGYPELG=$P($G(^DIC(8,+$G(^DPT(DFN,.36)),0)),"^",9)
 I DGYPELG=5!(DGYPELG=3) S Y=1
AOQ Q +$G(Y)
 ;
IR(DFN) ;Ionizing Radiation Exposure Screen
 ; Input  -- DFN      Patient file IEN  
 ; Output -- Ask Ionizing Radiation Exposure Classification
 ;           1=Yes and 0=No
 N DGYPELG,Y
 I $P($G(^DPT(DFN,.321)),"^",3)'="Y" G IRQ
 S DGYPELG=$P($G(^DIC(8,+$G(^DPT(DFN,.36)),0)),"^",9)
 I DGYPELG=5!(DGYPELG=3) S Y=1
IRQ Q +$G(Y)
 ;
SC(DFN) ;Service Connected Condition Screen
 ; Input  -- DFN      Patient file IEN  
 ; Output -- Ask Service Connected Condition Classification
 ;           1=Yes and 0=No
 N Y
 I "^1^3^"[("^"_$P($G(^DIC(8,+$G(^DPT(DFN,.36)),0)),"^",9)_"^") S Y=1
SCQ Q +$G(Y)
 ;
EC(DFN) ;Environmental Contaminant Exposure Screen
 ; Input  -- DFN      Patient file IEN  
 ; Output -- Ask Environmental Contaminant Exposure Classification
 ;           1=Yes and 0=No
 N Y
 I $P($G(^DPT(DFN,.322)),"^",10)="Y" S Y=1
ECQ Q +$G(Y)
