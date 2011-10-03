IBQL356 ;LEB/MRY - UM ROLLUP - IBT DATA EXTRACTS ; 6-JUN-95
 ;;1.0;UTILIZATION MGMT ROLLUP LOCAL;**4**;Oct 01, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 Q
CLAIMS ; -- Extract Claims Tracking, Inpatient Provider, and Movement info.
 ; -- input:  IBTRN from ^IBT(356,IBTRN...
 ; -- output: IB(array)=data from RESETC
 D RESETC^IBQL356A S IBTRND=$G(^IBT(356,IBTRN,0)) I 'IBTRND S IBQUIT=1 Q
 ; -- get site and discharge date.
 S IB(.02)=$P($$SITE^VASITE,"^",3),IB(.1)=$P($G(^IBT(356,IBTRN,1)),"^",9)
 ;-- get claims tracking data, entry id, admission, enrollement code
 S IB(.01)=$P(IBTRND,"^"),DFN=$P(IBTRND,"^",2),IBNAM=$P($G(^DPT(DFN,0)),"^"),IB(.03)=$P($G(^DPT(DFN,0)),"^",9)
 S IBR=$P(IBTRND,"^",25),IBD=$P(IBTRND,"^",26),IBL=$P(IBTRND,"^",27)
 S IB(.05)=IBR_"-"_IBD_"-"_IBL I '(+IBR+IBD+IBL) S IB(.05)=""
 S IB(1.06)=$S((+IBR+IBD)&(+IBL):"B",(+IBR+IBD):"N",(+IBL):"L",1:"")
 S DGPM=$P(IBTRND,"^",5) I DGPM D
 .S IB(.09)=$P($G(^DGPM(DGPM,0)),"^")
 .; -- get inpatient provider data, admitting, attending, and resident physician
 .S I="" F  S I=$O(^IBT(356.94,"C",DGPM,I)) Q:'I  S X=$G(^IBT(356.94,I,0)),IBTY=$P(X,"^",4),IB($S(IBTY=1:.07,IBTY=2:.08,IBTY=3:.06,1:"ERR"))=$P(X,"^",3)
 .; - get patient movement data, treating specialty, ward, admitting diagnosis
 .;S VAINDT=IB(.09) D INP^VADPT S IB(.12)=$P(VAIN(3),"^",2),IB(.11)=$P(VAIN(4),"^",2)
 .;S IB(1.07)=$P($G(^DIC(42.4,+$P($G(^DIC(45.7,+$P($G(VAIN(3)),"^"),0)),"^",2),0)),"^",3)
 .S X=+$O(^IBT(356.9,"ADG",DGPM,0)) S:X IB(.04)=$P(^ICD9(X,0),"^")
 Q
 ;
ADMIT ; -- Extract Hospital Review Admission information
 ; -- input:  IBTRV from ^IBT(356.1,IBTRN...
 ; -- output: IB(array)=data from RESETA
 D RESETA^IBQL356A S IBTRVD=$G(^IBT(356.1,IBTRV,0)) I 'IBTRVD S IBQUIT=1 Q
 ; -- get hospital review admission data, acute adm?, si, is, reasons
 ;    admission review
 S IB(.13)=$P(IBTRVD,"^",6)!0,IB(1.01)=$P(IBTRVD,"^",4),IB(1.02)=$P(IBTRVD,"^",5),IB(1.04)=$P(IBTRVD,"^",10)!0,IB(1.05)=$P(IBTRVD,"^",11)!0
 F I=1:1:3 Q:'$D(^IBT(356.1,IBTRV,12,I,0))  S X=+^(0),IB(1.03)=IB(1.03)_$P($G(^IBE(356.4,X,0)),"^",2)_" "
 ; -- if local and no si/is's and no reasons, try specialized units
 I IBL,'IB(1.01),'IB(1.02),'IB(1.03) S IB(1.01)=$P(IBTRVD,"^",8),IB(1.02)=$P(IBTRVD,"^",9)
 S:IB(1.01) IB(1.01)=$P(^IBE(356.3,IB(1.01),0),"^",3) S:IB(1.02) IB(1.02)=$P(^IBE(356.3,IB(1.02),0),"^",3)
 ; -- acute 
 I 'IB(1.03)!IB(.13) S IB("ACUTE ADMISSION")=1
 S IB(.12)=$P($G(^DIC(45.7,+$P(IBTRVD,"^",7),0)),"^") I IB(.12)'="" S IB(1.07)=$P($G(^DIC(42.4,+$P($G(^DIC(45.7,+$P(IBTRVD,"^",7),0)),"^",2),0)),"^",3)
 S VAINDT=$$VNDT^IBTRV(IBTRV) D INP^VADPT S:IB(.12)="" IB(.12)=$P(VAIN(3),"^",2),IB(1.07)=$P($G(^DIC(42.4,+$P($G(^DIC(45.7,+$P($G(VAIN(3)),"^"),0)),"^",2),0)),"^",3) S IB(.11)=$P(VAIN(4),"^",2)
 Q
 ;
STAY ; -- Extract Continued Stay Review information
 ; -- input:  IBTRN, IBTRV from ^IBT356,IBTRN...
 ; -- output: IB(array)=data from RESETS
 D RESETS^IBQL356A S IBTRVD=$G(^IBT(356.1,IBTRV,0)) I 'IBTRVD S IBQUIT=1 Q
 ; -- get hospital review continued stay reviews, is, si, d/s, interviewed?, reasons
 ;   continued stay reviews
 S IB(13.01)=$P(IBTRVD,"^",3)
 S IB(13.07)=$P($G(^DIC(45.7,+$P(IBTRVD,"^",7),0)),"^") I IB(13.07)'="" S IB(13.08)=$P($G(^DIC(42.4,+$P($G(^DIC(45.7,+$P(IBTRVD,"^",7),0)),"^",2),0)),"^",3)
 I IB(13.07)="" S VAINDT=$$VNDT^IBTRV(IBTRV) D INP^VADPT S IB(13.07)=$P(VAIN(3),"^",2),IB(13.08)=$P($G(^DIC(42.4,+$P($G(^DIC(45.7,+$P($G(VAIN(3)),"^"),0)),"^",2),0)),"^",3)
 S IB(13.03)=$P(IBTRVD,"^",4),IB(13.02)=$P(IBTRVD,"^",5),IB(13.04)=$P(IBTRVD,"^",12),IB(13.05)=$P(IBTRVD,"^",10)!0
 S I=0,IBCNT=0 F  S I=$O(^IBT(356.1,IBTRV,13,I)) Q:'I!(IBCNT>2)  S IBCNT=IBCNT+1,X=+^IBT(356.1,IBTRV,13,I,0),IB(13.06)=IB(13.06)_$P($G(^IBE(356.4,X,0)),"^",2)_" "
 ; -- if local and no si/is's and no reasons, try specialized units
 I IBL,'IB(13.03),'IB(13.02),'IB(13.06) S IB(13.03)=$P(IBTRVD,"^",8),IB(13.02)=$P(IBTRVD,"^",9)
 S:IB(13.03) IB(13.03)=$P($G(^IBE(356.3,IB(13.03),0)),"^",3) S:IB(13.02) IB(13.02)=$P($G(^IBE(356.3,IB(13.02),0)),"^",3) S:IB(13.04) IB(13.04)=$P($G(^IBE(356.3,IB(13.04),0)),"^",3)
 ; -- if no d/c, no is, and no reasons, try 24 Hour Rule
 I 'IB(13.04),'IB(13.02),'IB(13.06),IBPIS S IB(13.02)="24??"
 ; -- for 24 Hour Rule save previous Intensity of Service
 S IBPIS=IB(13.02) S:IBPIS="24??" IBPIS=""
 ; acute stay
 I 'IB(13.06) S IB("ACUTE STAY")=1
 Q
