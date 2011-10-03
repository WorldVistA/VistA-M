PRS8UP ;HISC/MRL,JAH/WIRMFO-DECOMPOSITION, UPDATE TOTALS ;7/10/08
 ;;4.0;PAID;**6,21,30,45,117**;Sep 21, 1995;Build 32
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;This routine is used to collect information related to
 ;weekly activity which is unrelated to actual time, including
 ;VCS Sales, Environmental Differential, Hazard Pay, 
 ;Lump Sum Data, etc.
 ;
 ;Called by Routines:  PRS8ST
 ;
 ; -- VCS Sales (VC, VS)/Fee Basis (FE)
 ;
 ; If there is data (X) on the VCS sales node.  (Both VCS sales and
 ; Fee Basis data is stored on this node).  Then we need to check to
 ; see if the employee's pay plan is F=Fee Basis or U=VCS Sales.
 ;
 ;
 ; If we're dealing w/ previous pay period where an employee
 ; has changed pay plans, we need to check their pay plan for the 
 ; pay period we are dealing with.
 N PAYPDTMP,PPLOLD
 S PAYPDTMP=$G(^PRST(458,+PY,0)) ;pay period we're working with.
 S PPLOLD=$$OLDPP^PRS8UT(PAYPDTMP,+DFN) ;pay plan from PAYPDTMP.
 S PPL=$P($G(^PRSPC(+DFN,0)),"^",21) ;pay plan in master record.
 ;
 ;if we find an old pay plan and it's different than the master record
 ;use the old pay plan to determine VCS or FEE.
 I PPLOLD'=0,(PPL'=PPLOLD) S PPL=PPLOLD
 ;
 S X=$G(^PRST(458,+PY,"E",+DFN,2)),(T,T(1),T(2))=0
 I PPL'="F",X'="" F I=1:1:14 S V=+$P(X,"^",I),W=$S(I<8:1,1:2),T(W)=T(W)+V
 I PPL'="F" F I=1,2 I $D(T(I)) D
 .S X1=$P(T(I),".",2)
 .S X1=X1_$E("00",0,2-$L(X1)) ;2 numbers for cents (X1)
 .S X=+$P(T(I),".",1)
 .S X=X_X1 I '+X Q  ;no value/don't report
 .S $P(WK(I),"^",37)=X
 S X=$G(^PRST(458,+PY,"E",+DFN,2))
 I PPL="F",X'="" F I=1:1:14 S V=+$P(X,"^",I),T=T+V
 I PPL="F",$D(T) D
 .S X1=$P(T,".",2)
 .S X1=X1_$E("00",0,2-$L(X1))
 .S X=+$P(T,".",1)
 .S X=X_X1 I '+X Q  ;if no value, don't save
 .S $P(WK(3),"^",17)=X
 K I,PPL,T,V,W,X,X1
 ;
 ; -- Environmental Differential (EA, EC)
 ; -- Hazardous Duty Pay (EB, ED)
 ;
 S X=$G(^PRST(458,+PY,"E",+DFN,4))
 F I=1,3,5,7,9,11 S Y=+$P(X,"^",I) D
 .I I=1!(I=7) S T=0,W=1+(I=7)
 .S Y=$G(^PRST(457.6,+Y,0)) Q:Y=""
 .S Y=+$P(Y,"^",3) Q:'Y
 .S Y=$E("00",0,2-$L(Y))_Y ;percentage
 .S Y(1)=+$P(X,"^",I+1) Q:'Y(1)
 .S Y(1)=$E("000",0,3-$L(Y(1)))_Y(1) ;hours
 .S T=T+1
 .I T<3 S $P(WK(W),"^",36+(T*2))=Y,$P(WK(W),"^",37+(T*2))=Y(1)
 .K Y
 K I,T,W,X,Y
 ;
 ;PRS4*117 CT Trav Earnd Wk 1&2. Convert file decimal to 1/4 hr integer
 ;
 N CTTNODE,CTTW1,CTTW2 S CTTNODE=$G(^PRST(458,+PY,"E",+DFN,6))
 S CTTW1=+$P(CTTNODE,U)*100/.25\100
 S CTTW2=+$P(CTTNODE,U,2)*100/.25\100
 I CTTW1>0 S $P(WK(1),"^",52)=CTTW1
 I CTTW2>0 S $P(WK(2),"^",52)=CTTW2
 ;
 ;PRS4*117 Move Credit Hours back to the comptime buckets.
 ;   Credit hours still reported under comptime 8B codes but are
 ;   split out during decomp so appropriate rules are applied 
 ;   for credit hours. When credit hours 8B code reporting is 
 ;   implemented this code should be removed.[credit hours future use]
 ;
 ;     { begin credit hours move to ct buckets
 ;
 ;       For week 1 & 2, add credit hours to comptime buckets and zero 
 ;       out credit hours buckets.
 ;
 F I=1,2 D
 .;      add
 .  S $P(WK(I),U,7)=$P(WK(I),U,7)+$P(WK(I),U,54)
 .  S $P(WK(I),U,8)=$P(WK(I),U,8)+$P(WK(I),U,55)
 .;
 .;      zero out
 .  S $P(WK(I),U,54)=""
 .  S $P(WK(I),U,55)=""
 ;
 ;      end credit hours move to ct buckets }
 ;
 ; -- Lump Sum Data (LY, LH, LD, DT)
 ;
 S (X,Y)=$G(^PRST(458,+PY,"E",+DFN,3)),(C,T(1),T(2),T(3))=""
 I X'="" F I=2,3,4 S T(I-1)=+$P(X,"^",I) I +T(I-1) S C=1
 I C F I=1,2,3 I +T(I) D
 .S X1="."_$P(T(I),".",2)\.25 ;turn % into quarter hours
 .S X=+$P(T(I),".",1)
 .S X=X_+X1 I '+X Q
 .S $P(WK(3),"^",4+I)=X
 S X=$P(Y,"^",5)
 I X?7N S X=$E(X,4,7)_$E(X,2,3),$P(WK(3),"^",8)=X
 K I,C,T,X ;clean up/save new T&L as Y (if there)
 ;
 ; -- T&L Change (TL)
 ;
 S X=$P(Y,"^") I $L(X)=3 S $P(WK(3),"^",4)=X
 K X
 ;
 ; -- Optional Withholding Tax (TO)
 ;
 I $P(Y,"^",7)="Y" S $P(WK(3),"^",9)=1
 ;
 ; -- Foreign Cola (LA)
 ;
 I $P(Y,"^",8)="Y" S $P(WK(3),"^",10)=2
 ;
 ; -- Payment Records (RR)
 ;
 I $P(Y,"^",6)="Y" S $P(WK(3),"^",15)=1
 ;
 ; -- Days Worked (DW)
 ;
 I DWK,TYP["I" S $P(WK(3),"^",2)=+DWK
 ;
 ; -- Calendar Year Adjustment (CA)
 ;
 ; I $D(WPCY) S X=WPCYA S X=(X\4)_"0",$P(WK(3),"^",12)=X K WPCY,WPCYA
 I $D(WPCY) D
 . S X=WPCYA S:$E(ENT,1,2)["H" X=(X\4) I +X S X=X_"0",$P(WK(3),"^",12)=X
 . K WPCY,WPCYA
 E  S X=+CAMISC I TYP["I",+X S X=X_"0",$P(WK(3),"^",12)=X
 ;
 ; -- Days Worked [SF 2806] (CY)
 ;
 I CYA2806'=0 S X=+CYA2806 I (TYP["I"!(TYP["P")),TYP'["B",+X S:"56U"'[$P(C0,"^",21) X=(X\4)_(X#4),$P(WK(3),"^",14)=X
 E  S X=+CAMISC I TYP["I",+X S:"56U"'[$P(C0,"^",21) X=X_"0",$P(WK(3),"^",14)=X
 ;
 ; -- Fire Fighter Normal Hours (FF)
 ;      Sum PT from week 1 with PH from week 2 and copy into FF
 ;
 S $P(WK(3),"^",16)=""
 I "Ff"[TYP,(("RC"[PMP)!(NH=448)!(NH>320&(NH(1)'=NH(2)))) D
 .  F I=1,2 D
 ..    S X=+$P(WK(I),"^",32)
 ..    I +X S $P(WK(3),"^",16)=$P(WK(3),"^",16)+X
 ;
 S X=$P(WK(3),"^",16)
 I X S $P(WK(3),"^",16)=(X\4)_(X#4) ;quarter hours
 K I,X,Y
 ;
 ; -- reduce OC by OT where applicable
 F I=1,2 I $P(WK(I),"^",35),+$G(CBCK(I)) D
 .S $P(WK(I),"^",35)=$P(WK(I),"^",35)-CBCK(I)
 ;
 ; -- Military Leave (ML)
 ;I $G(MILV) S P=11 D DAYS
 ;
 ; -- Work Comp [Count COP days] (PC)
 I $G(WCMP) S P=13 D DAYS
 ;
END ; --- all done here
 Q
 ;
DAYS ; --- count total number of days for ML and PC
 K NODE S NODE=$P("ML^^CP","^",P-10),(NODE(1),NODE(2))=""
 F D=1:1:14 D
 .S NODE(1)=NODE(1)_+$G(^TMP($J,"PRS8",D,NODE))
 .S NODE(2)=NODE(2)_+$G(^TMP($J,"PRS8",D,"OFF"))
 .I $E(NODE(1),D) D SET ;save day in WK(3)
 S NODE(1)=$E("0*",1+$G(^TMP($J,"PRS8",0,NODE)))_NODE(1)_$E("0*",1+$G(^TMP($J,"PRS8",15,NODE))) ; assume ML/CP has been counted for past/future ppd
 S NODE(2)=+$G(^TMP($J,"PRS8",0,"OFF"))_NODE(2)_+$G(^TMP($J,"PRS8",15,"OFF")) ; set off days for past/future ppd
 S F=1 ;F=Forward check needed
 F I=2:1:15 S X=$E(NODE(1),I),X1=$E(NODE(2),I) D
 .I 'X1 S F=$S(X="*":I,1:-1) ;go forward into next week
 .S (C,Q)=0 I X1,X'="*",$E(NODE(1),I-1)="*" F J=F+1:1:15 Q:Q  D  ; X'="*"" ==> X=1 for NODE="ML" if there is a problem with the counting of ML when the orders specify days off are not to be counted.
 ..S X=$E(NODE(1),J),X1=$E(NODE(2),J)
 ..I 'X1,X=0 S Q=1 Q  ;worked
 ..I X="*" S Q=1,C=J-2 Q  ;military leave
 ..I J=15,$E(NODE(1),J+1)="*" S Q=1,C=14 Q  ; if last day in ppd, and there is ML/CP on the first day of next ppd, then count this ML/CP
 .I C F J=I-1:1:C S D=J D SET ;save off days in pp
 Q
 ;
SET ; --- set WK(3) Node for ML
 S $P(WK(3),"^",+P)=$P(WK(3),"^",+P)+1
 S NODE(1)=$E(NODE(1),0,D-1)_"*"_$E(NODE(1),D+1,99)
 Q
