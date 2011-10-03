GMTSPSG5 ; SLC/JER,KER - UD Rx Summary Component (V5) ; 08/27/2002
 ;;2.7;Health Summary;**15,28,56**;Oct 20, 1995
 ; 
 ; External References
 ;   DBIA   486  ENHS^PSJEEU0
 ;                    
MAIN ; Controls Branching
 N GMI,IX,ON,PS,PSIVREA,PSJEDT,PSJNKF,PSJPFWD,GMR,TN,UDS
 S PSJEDT=$S(GMTS2'=9999999:(9999999-GMTS2),1:""),PSJNKF=1
 K ^UTILITY("PSG",$J) I '$L($T(ENHS^PSJEEU0)) D NOPSJ Q
 D ENHS^PSJEEU0
 I '$D(^UTILITY("PSG",$J)) Q
 S IX=-9999999,GMI=0
 F  S IX=$O(^UTILITY("PSG",$J,IX)) Q:'IX  S GMR=^(IX) D WRT  Q:$D(GMTSQIT)
 W !
 K ^UTILITY("PSG",$J),^UTILITY("PSIV",$J)
 Q
NOPSJ ; Handles case where routine ^PSJEEU0 not installed
 D CKP^GMTSUP Q:$D(GMTSQIT)  W "Inpatient Pharmacy version 3.2 or greater is required.",!
 Q
WRT ; Writes the Unit Dose Component
 N SD,FD,DRG,DOSE,GMV,RT,STAT,SIG
 S SD=$P(GMR,U),FD=$P(GMR,U,2),DRG=$P($P(GMR,U,3),";",2),STAT=$P($P(GMR,U,5),";")
 ;                    
 ;   Don't display data when start date is after 
 ;   Date Range To Date and stop date is before 
 ;   Date Range End Date. (Need end date because of
 ;   FOR LOOP on $O(^PS(53.1,"AC",DFN,Y)) in PSJEEU0
 ;                    
 I +$G(GMRANGE),(SD>(9999999-GMTS1))!(FD<(9999999-GMTS2)) Q
 F GMV="SD","FD" S X=@GMV D REGDT4^GMTSU S @GMV=X
 D CKP^GMTSUP Q:$D(GMTSQIT)  W:GMI>0&('GMTSNPG) !
 I GMTSNPG!(GMI'>0) D HEAD
 S GMI=1
 S DOSE=$P(GMR,U,6),RT=$P($P(GMR,U,7),";",3),SIG=$P(GMR,U,8)
 D CKP^GMTSUP Q:$D(GMTSQIT)  D:GMTSNPG HEAD W $E(DRG,1,36),?38,DOSE,?50,STAT,?57,SD,?69,FD,!
 D CKP^GMTSUP Q:$D(GMTSQIT)  G:GMTSNPG WRT W ?2,SIG," ",RT
 Q
HEAD ; Prints Header
 D CKP^GMTSUP Q:$D(GMTSQIT)
 W "Drug",?38,"Dose",?50,"Status",?58,"Start",?68,"Stop",! W:$Y'>(IOSL-GMTSLO) !
 Q
