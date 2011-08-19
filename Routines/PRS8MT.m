PRS8MT ;HISC/MRL-DECOMPOSITION, MEALTIME ;03/10/08
 ;;4.0;PAID;**2,40,69,102,109,112,116,117**;Sep 21, 1995;Build 32
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;This routine is used to determine placement of mealtime where
 ;necessary.
 ;
 ;Called by Routines:  PRS8ST
 ;
MULT ; --- checking 1 node
 I $$HOLIDAY^PRS8UT(PY,DFN,MDY),$G(^PRST(458,PY,"E",DFN,"D",MDY,2))["MID^MID^ON" Q  ;don't add meal if mid-mid on-call on a holiday, quit routine
 S TWO=DAY(MDY,"TWO")
 S S=1 D SET D:'Q  I TWO S S=2 D SET D:'Q
 .S D1="",$P(D1,"0",193)="",V(1)=97,V(2)=0
 .F I=1:3:28 S V=$P(N,"^",I,I+2) Q:$P(V,"^",1)=""  D
 ..S X=$P(V,"^",3) I "^^6^7^3^8^"'[("^"_X_"^") Q  ;quit if not NH
 ..F M=$P(V,"^"):1:$P(V,"^",2) D  ; build up tour
 ...S D1=$E(D1,1,M-1)_$S(X=""!(X=3):1,X=6:2,1:3)_$E(D1,M+1,192)
 ...I V(1)>M S V(1)=M
 ...I V(2)<M S V(2)=M
 ..Q
 .D:V(2) GETY
 .F I="N","W" F J=MDY,MDY+1 S X=$G(DAY(J,I)) D
 ..I X'="" S ^TMP($J,"PRS8",J,I)=X
 ..Q
 .Q
 ;
END ; --- all done here
 K A,B,C,D,DIF,DIF1,J,L,M,M1,MID,MT,N,PM,T,SPL,SPLX,USE,V(1),V(2),VT,X,X1,X2,Y
 Q
 ;
GETY ; --- this is where Y (placement of mealtime) is defined
 S X=$E(D,V(1),V(2)),D1=$E(D1,V(1),V(2))
 N ORIGX,RECESS
 S ORIGX=X ; Original copy of codes in X and
 S RECESS=DAY(MDY,"r")_$G(DAY(MDY,"rN"))
 S RECESS=$E(RECESS,V(1),V(2)) ; load any Recess
 I X["5" D
 . N DAYP
 . ; loop thru string X and replace 5s by a leave code if one exists
 . S DAYP=$E(DAY(MDY,"P"),V(1),V(2)) ; leave may be hidden here
 . F M=1:1:$L(X) D
 . . I $E(X,M)=5,$E(DAYP,M)'=0 S $E(X,M)=$E(DAYP,M)
 S MID=V(2)-V(1)+1-MT\2,MID=MID+V(1) ;middle of tour
 S PM=+$P($G(^PRST(457.1,+$P(DAY(MDY,0),"^",$S(S=1:2,1:13)),0)),"^",7) ;0=non=prem meal/1=prem. meal
 S X1=$E(X),Q=1
 F M=1:1:$L(X) D  Q:'Q
 .S Y=$E(X,M)
 .I "1235C"[Y,"1235C"[X1 Q  ; scheduled work time
 .I "4OC"[Y,$E(RECESS,M)="r" S Q=0 Q  ; Work performed while on Recess (9mo AWS)
 .I Y'="O",Y'=X1 S Q=0 Q  ; not same type of time, and non-OT
 .I Y="O",($E(DAY($S(V(1)+M-1<97:MDY,1:MDY+1),"HOL"),$S(V(1)+M-1<97:V(1)+M-1,1:V(1)+M-1-96))'=2) S Q=0 Q  ; OT indicating non-holiday worked gets no meal
 .I Y="O",($E(DAY($S(V(1)+M-1<97:MDY,1:MDY+1),"HOL"),$S(V(1)+M-1<97:V(1)+M-1,1:V(1)+M-1-96))=2),"123C"[X1 S Q=0 Q  ; OT indicating holiday worked and Excused.
 .Q
 I X["0" D
 .I RECESS'["r" S SPL=$TR(X,"1235"),SPLX=$TR(X,SPL,$TR($J("",$L(SPL))," "))
 .I RECESS["r" S SPL=$TR(X,"01235"),SPLX=$TR(X,SPL,$TR($J("",$L(SPL))," "))
 .I SPLX="" S Q=1
 ;
 K M
 ;--- one activity for entire tour
 I Q S Q=0 D  F M=1:1:MT S M(M)=Y+M-1
 .I V(1)>24,V(2)<73 S Y=MID Q  ;no premium time involved/ meal in middle
 .S Q=0 D  ;check for all premium
 ..I V(1)<25,V(2)<25 S Q=1 Q  ;all hours before 6am
 ..I V(1)>72,V(2)>72,V(2)'>120 S Q=1 Q  ;all hours after 6pm
 .I Q S Y=MID Q  ; all time premium time/ meal in middle
 .I PM S Y=0 D
 ..I V(2)>72 S Y=73-$S(V(2)-73>MT&(V(1)'>73):0,V(1)<25!(V(2)'<121):73,1:MT-(V(2)-73))
 ..I 'Y,V(1)<25 S Y=$S(25-V(1)>MT:25-MT,1:V(1))
 ..I 'Y S Y=$S(121-V(1)>MT:121-MT,1:V(1))
 .E  S Y=0 D
 ..I V(2)>72 S Y=$S(73-MT>V(1):73-MT,V(1)<25!(V(2)'<121):0,1:V(1))
 ..I 'Y,V(1)<25 S Y=$S(V(2)-MT>24:25,1:V(2)-MT+1)
 ..I 'Y S Y=$S(V(2)-MT>120:121,1:V(2)-MT+1)
 .I 'Y S Y=MID
 .Q
 ; --- multiple activities per tour
 E  D
 .S Z=$TR(X,"1235"),X=$TR(X,Z,$TR($J("",$L(Z))," ","0"))
 .;
 .; if leave posted > or = to tour length + mt (ie didn't post around 
 .; lunch) it was resulting in OT (ZRIK strips HOL, OC, & no tour time)
 .;
 .N ZRIK
 .S ZRIK=$TR(Z,"HC0") I MT>0,$L(ZRIK)'<(($P(DAY(DAY,0),"^",8)*4)+MT) S X="",$P(X,"1",$L(ZRIK)+1)="" ;if leave posted > or = to tour length + mt (ie didn't post around lunch) it was resulting in OT (ZRIK strips HOL & OC)
 .Q:X?1"0"."0"&(RECESS'["r")
 .S M=0 F A=1,2 Q:M=MT  F B=MID,MID+1,MID-1:-1:V(1),MID+2:1:V(2) D  Q:M=MT
 ..Q:'$E(X,B-V(1)+1)
 ..I A=1,PM,B<25!(B>72&(B<121)) S M=M+1,M(M)=B
 ..I A=1,'PM,B>24&(B<73)!(B>120) S M=M+1,M(M)=B
 ..I A=2 S M=M+1,M(M)=B
 ..Q
 .Q
 Q:'$O(M(0))
Y ; --- this is where meals get placed in string
 F Y=0:0 S Y=$O(M(Y)) Q:Y'>0  D
 . N ORIGAC ; original activity code
 . S M=M(Y),(X,ORIGAC)=$E(D,M),X=$S(X="J":"A",X=5:$E(DAY(MDY,"P"),M),1:X)
 . ; If a 9mo AWS works during Recess don't place meal over that type of time
 . I +NAWS=9 D  ; 9mo AWS nurses
 . . ; If extra work (UN,OT,CT) was posted over the entire tour including the meal time
 . . ; don't include meal time in the W node or you will reduce the extra work count.
 . . ; Set X=0 to reduce the Recess count below.
 . . I "4OECQ"[ORIGAC&($L(ORIGX)=$L($TR(ORIGX,"1235"))) S X=0 Q
 . . ;
 . . ; If extra work posted over tour time that wasn't covered by Recess it will
 . . ; be stored in the r node.  If this time exists, add that time back into the 
 . . ; W node instead of the meal time.
 . . I "1235"[ORIGAC,"4OEC"[$E(RECESS,M-V(1)+1) D  Q
 . . . S D=$E(D,0,M-1)_$E(RECESS,M-V(1)+1)_$E(D,M+1,999)
 . . . S ORIGX=$E(ORIGX,1,M-V(1)-1)_$E(RECESS,M-V(1)+1)_$E(ORIGX,M-V(1)+2,999)
 . . ;
 . . ; For everything else, update D and ORIGX
 . . S D=$E(D,0,M-1)_"m"_$E(D,M+1,999)
 . . S ORIGX=$E(ORIGX,M-V(1)-1)_"m"_$E(ORIGX,M-V(1)+2,999)
 . ;
 . ; All employees other than 9mo AWS
 . I +NAWS'=9 S D=$E(D,0,M-1)_"m"_$E(D,M+1,999)
 . ;
 . ; The following line has been updated to include a check for Recess as the 48th piece.
 . ; Recess will be designated as a zero (0).
 . S X=$S(X'="M":$F("LSWnAR*U************************V********YXFGD*0****Z*q",X)-1,1:5)
 . ;
 . ; Firefighter checks
 . I "Ff"[TYP,NH'=480!(NH(1)'=NH(2)) S X=32
 . ;I X'=4,CYA2806>0 S CYA2806=CYA2806-1 ; << ADDED-> DROP LUNCH FROM CY ALSO>>
 . Q:X'>0
 . Q:MDY=0&(M(Y)<96)!(MDY=14&(M(Y)>97))
 . S W=$S(MDY<8:1,1:2) I MDY=7&(M(Y)>96) S W=2
 . I $P(WK(W),"^",+X)>0 S $P(WK(W),"^",+X)=$P(WK(W),"^",+X)-1 ;subtract
 . ;
 . ; If Military Leave subtract the mealtime out of the WK(3) array.
 . I ORIGAC="M",$P(WK(3),U,11)>0 S $P(WK(3),U,11)=$P(WK(3),U,11)-1
 . ;I WPCYA>0 S WPCYA=WPCYA-1 ;lunch from total << AND FROM CA TOTAL >>
 . ; PRS*4*40 added 8 (U), 44 (F), 45 (G), 46 (D) to following line
 . ; because PRS8AC also increments LU for those types of time
 . I +X,"^1^2^6^8^44^45^46^53^55^"[("^"_+X_"^") S LU=LU-1 ;reduce leave used
 . I +X,"^3^"[("^"_+X_"^"),"P"[TYP S TH=TH+1,TH(W)=TH(W)+1
 . Q
 S DAY(MDY,"W")=$E(D,1,96)
 S X=$E(D,97,999) I $L(X) D
 .I $D(DAY(MDY+1,"W")) S DAY(MDY+1,"W")=X_$E(DAY(MDY+1,"W"),$L(X)+1,999)
 .S DAY(MDY,"N")=X
 Q
 ;
SET ; --- set up for processing
 K A,B S (A,B,Q,Y)=0
 S MT=$G(DAY(MDY,"MT"_S)) I MT'>0 S Q=1 Q  ; mealtime for tour?
 S D=DAY(MDY,"W")_$G(DAY(MDY,"N")) ; get daily activity
 S N=DAY(MDY,S*S) ; get tour
 Q
