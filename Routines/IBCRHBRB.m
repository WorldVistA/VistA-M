IBCRHBRB ;ALB/ARH - RATES: UPLOAD RC V1.4 MOVE LAB CODES ; 06-JAN-2002
 ;;2.0;INTEGRATED BILLING;**169**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ; 
 ; move selected Lab procedure RC V1.4 charges from Physician file to Outpatient Facility file
 ; although the charges are calculated as Physician charges they usually should be billed on the UB-92
 ;
LAB ; move selected RV v1.4 Lab charges from Physician to Facility charge sets
 N IBXRF,IBOX2,IBOX3,IBPHYS,IBPX2,IBPX3,IBLINE,IBCNT S IBCNT=0
 ; 
 I $G(^XTMP("IBCR RC SITE","VERSION"))'=1.4 Q
 ;
 S IBXRF=$O(^XTMP("IBCR UPLOAD RC ")) I IBXRF'["IBCR UPLOAD RC " Q
 ;
 I '$D(ZTQUEUED) W !!,"Moving Lab charges from Physician to Facility Charge Sets ... "
 ;
 S IBOX2="Opt Fac",IBOX3=$O(^XTMP(IBXRF,IBOX2,999999999999),-1)
 ;
 S IBPHYS="Phys Fee "
 S IBPX2=IBPHYS F  S IBPX2=$O(^XTMP(IBXRF,IBPX2)) Q:IBPX2'[IBPHYS  D
 . S IBPX3="" F  S IBPX3=$O(^XTMP(IBXRF,IBPX2,IBPX3)) Q:IBPX3=""  D
 .. S IBLINE=$G(^XTMP(IBXRF,IBPX2,IBPX3)) Q:IBLINE=""
 .. I '$$MOVE($P(IBLINE,U,1)) Q
 .. ;
 .. S IBOX3=IBOX3+1,IBCNT=IBCNT+1
 .. S $P(^XTMP(IBXRF,IBOX2),U,1)=$P(^XTMP(IBXRF,IBOX2),U,1)+1
 .. S ^XTMP(IBXRF,IBOX2,IBOX3)=IBLINE
 .. ;
 .. S $P(^XTMP(IBXRF,IBPX2),U,1)=$P(^XTMP(IBXRF,IBPX2),U,1)-1
 .. K ^XTMP(IBXRF,IBPX2,IBPX3)
 ;
 I '$D(ZTQUEUED) W IBCNT," charges moved"
 Q
 ;
MOVE(CPT) ; return true if the Lab (8xxxx) code should be moved to the facility charge file
 ;
 N IBCPTX,MOVE S MOVE=0
 I $E($G(CPT))=8,CPT?5N S MOVE=1,IBCPTX=","_$G(CPT)_","
 I 'MOVE G MOVEQ
 ;
 I ",80500,80502,83020,83912,84165,84181,84182,85060,85097,85390,85576,"[IBCPTX S MOVE=0 G MOVEQ
 I ",86077,86078,86079,86255,86256,86320,86325,86327,86334,87164,87207,"[IBCPTX S MOVE=0 G MOVEQ
 I ",88141,88291,"[IBCPTX S MOVE=0 G MOVEQ
 ;
 I CPT'<88000,CPT'>88130 S MOVE=0 G MOVEQ
 I CPT'<88160,CPT'>88162 S MOVE=0 G MOVEQ
 I CPT'<88172,CPT'>88182 S MOVE=0 G MOVEQ
 I CPT'<88300,CPT'>88372 S MOVE=0 G MOVEQ
 I CPT'<89060,CPT'>89105 S MOVE=0 G MOVEQ
 I CPT'<89130,CPT'>89141 S MOVE=0 G MOVEQ
MOVEQ Q MOVE
