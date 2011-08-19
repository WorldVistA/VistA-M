PSJORREN ;BIR/MV-RENEWAL FLAG ;6 DEC 00 / 3:11 PM 
 ;;5.0; INPATIENT MEDICATIONS ;**50,70,58,89,91,110,127,134**;16 DEC 97;Build 124
 ;
 ; Reference to ^PS(50.7 supported by DBIA #2180
 ; References to ^PS(52.6 supported by DBIA #1231
 ; References to ^PS(52.7 supported by DBIA #2173
 ; References to ^PS(55 supported by DBIA #2191
 ; Reference to ^PSDRUG( is supported by DBIA 2192
 ;
ACTIVE(DFN,ON) ;
 ;DFN: Patient IEN
 ;ON : Order number_"U/V/P"
 ;Output: 0^reason not renewable (Can't renew)
 ;        2^New OI (Need to create a new order as in edit)
 ;          note: with PSJ*5*70 - instead of 2, IV order will return 0
 ;        1 (OK to renew)
 NEW PSJRT,PSJEXP
 I '$D(^PS(53.1,+ON))&'$D(^PS(55,+DFN,5,+ON,0))&'$D(^PS(55,+DFN,"IV",+ON,0)) S PSJRT="0^Invalid Package Reference" Q $G(PSJRT)
 D:ON["U" UD
 D:ON["V" IV
 I (+$G(PSJRT)=1) S PSJEXP=$$EXPIRED^PSGOER(DFN,ON) I PSJEXP S PSJRT="0^Expired Time Limit Exceeded"
 Q $G(PSJRT)
UD ;
 ;If both PSJRT(2) & (3) existed it meant order has multiple DDs and one
 ;is tied to a different OI. It's best to not allow renewal of the order.
 ;
 NEW PSJDD,PSJDDOI,PSJDDX,PSJACT,PSJOI,PSJOIACT,PSJUSE,PSJPRI,X,ND2
 K PSJRT
 S PSJOI=+^PS(55,DFN,5,+ON,.2)
 S PSJPRI=$P(^PS(55,DFN,5,+ON,.2),"^",4)
 I PSJPRI="D" S PSJRT="0^Orders with a Done priority may not be renewed" Q
 S ND0=$G(^PS(55,DFN,5,+ON,0)) I $P(ND0,"^",7)="O" S PSJRT="0^One Time orders may not be renewed" Q
 N PSJCANT,PSJDAD,NDP2,PSJORKID,PSJKID S NDP2=$G(^PS(55,DFN,5,+ON,.2)),PSJDAD=$P(NDP2,"^",8) I PSJDAD D
 .S PSJORKID="" F  S PSJORKID=$O(^PS(55,"ACX",PSJDAD,PSJORKID)) Q:'PSJORKID!$G(PSJCANT)  S PSJKID="" F  S PSJKID=$O(^PS(55,"ACX",PSJDAD,PSJORKID,PSJKID)) Q:'PSJKID!$G(PSJCANT)  D
 ..S ND0=$G(^PS(55,DFN,5,+PSJKID,2)) I $P(ND0,"^",7)="O" S PSJRT="0^Complex Orders with One-Time doses may not be renewed",PSJCANT=1
 Q:$G(PSJCANT)
 F PSJDD=0:0 S PSJDD=$O(^PS(55,DFN,5,+ON,1,PSJDD)) Q:('PSJDD!$D(PSJRT(1)))  D
 . S (PSJACT,PSJOIACT)=0 S PSJDDX=^PS(55,DFN,5,+ON,1,PSJDD,0)
 . S X=$P(PSJDDX,U,3) I X]"",(X'>DT) S PSJACT=1
 . S X=$G(^PSDRUG(+PSJDDX,"I")) I X]"",(X'>DT) S PSJACT=1
 . S X=$G(^PSDRUG(+PSJDDX,2)),PSJUSE=$P(X,U,3)["U",PSJDDOI=+X I '+PSJDDOI S PSJRT(3)="0^Dispense drug is not matched to an Orderable Item" Q
 . S X=$P($G(^PS(50.7,+PSJDDOI,0)),U,4) I X]"",(X'>DT) S PSJOIACT=1
 . I 'PSJACT,PSJUSE D  Q
 .. I PSJOI=PSJDDOI D  Q
 ... I 'PSJOIACT S PSJRT(1)=1 Q
 ... S:PSJOIACT PSJRT(3)="0^Inactive Orderable Item"
 .. I +PSJDDOI,(PSJOI'=PSJDDOI) D
 ... S:'PSJOIACT PSJRT(2)="2"_U_PSJDDOI
 ... S:PSJOIACT PSJRT(3)="0^Dispense drug ties to an inactive Orderable Item"
 . I PSJACT S PSJRT(3)="0^This drug has been Inactivated"
 . I 'PSJUSE S PSJRT(3)="0^Drug is No longer used in Inpatient Meds"
 I $D(PSJRT(1)) S PSJRT=1 Q
 I $D(PSJRT(2)),$D(PSJRT(3)) S PSJRT=PSJRT(3) Q
 I '$D(PSJRT) S PSJRT="0^Order has no Dispense drug" Q
 S X=$O(PSJRT(0)),PSJRT=$G(PSJRT(X))
 Q
IV ;
 NEW FIL,PSJACT,PSJAS,PSJASNO,PSJASOI,PSJCNT,PSJIEN,PSJOI,PSJOIACT,PSJPRI,X
 K PSJRT
 S PSJCNT=0
 S PSJOI=+$G(^PS(55,DFN,"IV",+ON,.2))
 S PSJPRI=$P(^PS(55,DFN,"IV",+ON,.2),"^",4)
 I PSJPRI="D" S PSJRT="0^Orders with a Done priority may not be renewed" Q
 N ND2,PSBACT,IVSCHED
 S ND0=$G(^PS(55,DFN,"IV",+ON,0)) I ($P(ND0,"^",4)="P")!($P(ND0,"^",23)="P")!$P(ND0,"^",5) D  Q:$G(PSJRT)]""
 .N X,PSGOES,ZZND S PSGOES=2,X=$P(ND0,"^",9) D ENOS^PSGS0 Q:($G(X)="")!($P($G(ZZND),"^",5)'="O")
 .S PSJRT="0^This One-Time order may not be renewed"
 F FIL="AD","SOL"  F PSJAS=0:0 S PSJAS=$O(^PS(55,DFN,"IV",+ON,FIL,PSJAS)) Q:'PSJAS  D
 . S (PSJACT,PSJOIACT)=0
 . S PSJASNO=$S(FIL="AD":52.6,1:52.7)
 . S PSJIEN=+^PS(55,DFN,"IV",+ON,FIL,PSJAS,0)
 . S X=$G(^PS(PSJASNO,+PSJIEN,"I")) I X]"",(X'>DT) S PSJACT=1
 . S PSJASOI=$P(^PS(PSJASNO,PSJIEN,0),U,11)
 . S X=$P($G(^PS(50.7,+PSJASOI,0)),U,4) I X]"",(X'>DT) S PSJOIACT=1
 . I PSJACT S PSJCNT=PSJCNT+1,PSJRT(3)="0^Inactive "_$S(FIL="AD":"Additive",1:"Solution") Q
 . I PSJOI=PSJASOI D  Q
 .. I 'PSJOIACT S PSJRT(1)="" Q
 .. I PSJOIACT S PSJRT(3)="0^Inactive Orderable Item"
 . I PSJOI'=PSJASOI D
 .. I 'PSJOIACT S PSJCNT=PSJCNT+1,PSJRT(2)=2_U_PSJASOI
 .. I PSJOIACT S PSJRT(3)="0^Inactive Orderable Item"
 I $D(PSJRT(1)) S PSJRT=1 Q
 I $D(PSJRT(3)) S PSJRT=PSJRT(3) Q
 I $D(PSJRT(2)),PSJCNT=1 S PSJRT="0^New Orderable Item" Q
 S PSJRT="0^Inactive drug"
 Q
