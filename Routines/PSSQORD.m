PSSQORD ;BIR/RTR-POE Quick Order Conversion ;08/21/00
 ;;1.0;PHARMACY DATA MANAGEMENT;**38**;9/30/97
 ;S X=$$EN^PSSQORD(V1,V2)
 ;V1=Orderable Item of Quick Order
 ;V2=Dispense Drug of the Quick Order
 ;If we get V2, we get current OI, and return
 ; piece 1 is returned as IEN from 50.7
 ; piece 2 is 1 if active
 ; piece 2 is 0 if inactive
 ; piece 3 is the inactive date, only if piece 2 is 0
EN(PSS1,PSS2) ;
 N PSSNW,PSSNEWIT,PSSDT,PSSLA,PSSLS,PSSOFLAG,PSSDR
 I '$G(PSS1),'$G(PSS2) Q -1
 I $G(PSS2) S PSSNEWIT=+$P($G(^PSDRUG(PSS2,2)),"^") G AC
 I '$D(^PS(50.7,+$G(PSS1),0)) Q -1
 I '$P($G(^PS(50.7,+$G(PSS1),0)),"^",3) S PSSNEWIT=$G(PSS1) G AC
 S (PSSNW,PSSOFLAG)=0
 F PSSLS=0:0 S PSSLS=$O(^XTMP("PSSCONS",PSS1,PSSLS)) Q:'PSSLS!($G(PSSOFLAG))  D
 .I 'PSSNW S PSSNW=$P($G(^XTMP("PSSCONS",PSS1,PSSLS)),"^") Q
 .I PSSNW,PSSNW'=$P($G(^XTMP("PSSCONS",PSS1,PSSLS)),"^") S PSSOFLAG=1
 I $G(PSSOFLAG) Q -1
 F PSSLA=0:0 S PSSLA=$O(^XTMP("PSSCONA",PSS1,PSSLA)) Q:'PSSLA!($G(PSSOFLAG))  D
 .I 'PSSNW S PSSNW=$P($G(^XTMP("PSSCONA",PSS1,PSSLA)),"^") Q
 .I PSSNW,PSSNW'=$P($G(^XTMP("PSSCONA",PSS1,PSSLA)),"^") S PSSOFLAG=1
 I $G(PSSOFLAG) Q -1
 I '$G(PSSNW) Q -1
 S PSSNEWIT=$G(PSSNW)
AC ;
 I '$G(PSSNEWIT) Q -1
 I '$D(^PS(50.7,PSSNEWIT,0)) Q -1
 S PSSDT=$P($G(^PS(50.7,PSSNEWIT,0)),"^",4)
 I PSSDT Q PSSNEWIT_"^0^"_PSSDT
 Q PSSNEWIT_"^"_1
