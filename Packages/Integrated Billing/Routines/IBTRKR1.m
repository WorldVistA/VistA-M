IBTRKR1 ;ALB/AAS - CLAIMS TRACKER - AUTO-ENROLLER ; 4-AUG-93
 ;;Version 2.0 ; INTEGRATED BILLING ;**10,23,56**;; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
RANDOM(IBSPEC) ; -- see if random sample
 ; -- input  = treating specialty from 45.7 (piece 9 of dgpma)
 ;    output = 1 if random sample
 ;             0 if not random sample
 ;
 N SPECALTY
 I '$G(IBSPEC) Q 0
 ;
 I $$FMDIFF^XLFDT(DT,$P($G(^IBE(350.9,1,6)),"^",7))>7 D UP1
 ;
 ;  specialty field (piece 2) is ptr to file 42.4
 S SPECALTY="^"_$P($G(^DIC(45.7,+IBSPEC,0)),"^",2)_"^"
 ;
 ;  medicine sample
 I "^1^2^3^4^5^6^7^8^9^10^14^15^31^"[SPECALTY Q $$PROC("M")
 ;
 ;  surgery sample
 I "^50^51^52^53^54^55^56^57^58^59^61^62^"[SPECALTY Q $$PROC("S")
 ;
 ;  psychiatry sample - none
 Q 0
 ;
 ;
PROC(TYPE)         ;  process random sample
 ;  type = 'M'edicine, 'S'urgery, or 'P'sych
 N IBTRKR,PIECE,RANDNUMB,SAMPMET,SAMPSIZE,SVCCOUNT
 S PIECE=$S(TYPE="M":8,TYPE="S":13,TYPE="P":18,1:0) I 'PIECE Q 0
 ;
 ;  allow only 1 process to update site params
 L +^IBE(350.9,1,6):10 I '$T Q 0
 S IBTRKR=$G(^IBE(350.9,1,6))
 ;
 ;  check sample size greater than 0
 S SAMPSIZE=$P(IBTRKR,"^",PIECE) I SAMPSIZE<1 L -^IBE(350.9,1,6) Q 0
 ;
 ;  increment service counter
 S SVCCOUNT=$P(IBTRKR,"^",PIECE+4)+1,$P(^IBE(350.9,1,6),"^",PIECE+4)=SVCCOUNT
 ;
 ;  sample entries met to date, quit if greater or equal to samples
 S SAMPMET=$P(IBTRKR,"^",PIECE+3) I SAMPSIZE'>SAMPMET L -^IBE(350.9,1,6) Q 0
 ;
 ;  service random number, default 3
 S RANDNUMB=$P(IBTRKR,"^",PIECE+2) I RANDNUMB<1 S RANDNUMB=3
 ;
 ;  if service counter mod random number = 0, then its a random sample
 I SVCCOUNT#RANDNUMB'=0 L -^IBE(350.9,1,6) Q 0
 S $P(^IBE(350.9,1,6),"^",PIECE+3)=SAMPMET+1
 L -^IBE(350.9,1,6)
 Q 1
 ;
 ;
UPDATE ; -- weekly update of random sampler called from nightly job
 ;
 I $$DOW^XLFDT(DT,1)'=0 Q  ; run on sunday night only
 ;
UP1 ; -- enter here to force update, nightly job didn't update in over 7 days
 N %,AVGADM,IBTRKR,PIECE,SAMPSIZE,RANDNUMB
 ;
 I '$D(^IBE(350.9,1,6)) Q
 I $P(^IBE(350.9,1,6),"^",7)=DT Q
 ;  prevent updating site params during weekly update
 L +^IBE(350.9,1,6):10 I '$T Q
 ;
 ;  set random sample date to today
 S $P(^IBE(350.9,1,6),"^",7)=DT
 ;
 S IBTRKR=^IBE(350.9,1,6)
 ;  piece 8 for medicine, piece 13 for surgery, piece 18 for psych
 F PIECE=8,13,18 D
 .   ;  average weekly admissions, default is 5
 .   S AVGADM=$P(IBTRKR,"^",PIECE+1) I AVGADM<5 S AVGADM=5
 .   ;
 .   ;  generate random number if sample size is greater than 0
 .   S SAMPSIZE=$P(IBTRKR,"^",PIECE)
 .   I SAMPSIZE>0 S %=AVGADM/SAMPSIZE S:%<1 %=1 S RANDNUMB=$R(%)+1
 .   ;
 .   S $P(^IBE(350.9,1,6),"^",PIECE+1,PIECE+4)=AVGADM_"^"_+$G(RANDNUMB)_"^0^0"
 L -^IBE(350.9,1,6)
 Q
 ;
 ;
CLEAR ; -- Clear random sampler
 ;
 N PIECE
 L +^IBE(350.9,1,6):10 I '$T Q
 S $P(^IBE(350.9,1,6),"^",7)=DT
 F PIECE=8,13,18 S $P(^IBE(350.9,1,6),"^",PIECE,PIECE+4)="2^5^1^0^0"
 L -^IBE(350.9,1,6)
 Q
