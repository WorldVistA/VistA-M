ACKQUTL ;AUG/JLTP BIR/PTD HCIOFO/BH-QUASAR Utility Routine ; [ 06/06/99 10:03 ]
V ;;3.0;QUASAR;;Feb 11, 2000
 ;Per VHA Directive 10-93-142, this routine SHOULD NOT be modified.
 ;
 ;
CNTR(X) ;  "CENTER" FUNCTION
 D:'$D(IOM) HOME^%ZIS W ?(IOM\2-($L(X)\2)),X
 Q
 ;
MIXC(X) ;  CHANGES X TO MIXED CASE
 N I,Y,Y1
 S Y=$$LOWC(X),X=""
 F I=1:1:$L(Y) S Y1=$E(Y,I),X=X_$S(I=1:$$UPC(Y1),$E(Y,I-1)?1P:$$UPC(Y1),1:Y1)
 Q X
 ;
SSN(X) ;  FORMAT SSN
 Q:X'?9N X  Q $E(X,1,3)_"-"_$E(X,4,5)_"-"_$E(X,6,9)
 ;
LOWC(X) ;  CONVERT X TO LOWERCASE
 Q $TR(X,"ABCDEFGHIJKLMNOPQRSTUVWXYZ","abcdefghijklmnopqrstuvwxyz")
 ;
UPC(X) ;  CONVERT X TO UPPERCASE
 Q $TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 ;
NUMDT(X1,X2) ;  LIKE FILEMAN'S GREAT NUMDATE
 S:'$D(X2) X2="/" I $G(X1)'?7N.".".6N Q ""
 Q $E(X1,4,5)_X2_$E(X1,6,7)_X2_$E(X1,2,3)
 ;
XDAT(X) ;  FILEMAN INTERNAL TO EXTERNAL
 N MO,DA,YR Q:X="" X
 S MO=$E(X,4,5),DA=$E(X,6,7),YR=1700+$E(X,1,3)
 S MO(1)=$S(MO:$P("January$February$March$April$May$June$July$August$September$October$November$December","$",+MO),1:"")
 S X=YR S:+DA X=+DA_", "_X S:MO X=MO(1)_" "_X
 Q X
 ;
FTIME(X) ;
 S X=$P(X,".",2)_"0000"
 Q $E(X,1,2)_":"_$E(X,3,4)
 ;
STACT(ACKXX,ACKXX1) ;
 ;Entry point to determine if staff member ACKXX is/was active on
 ;date ACKXX1.  If ACKXX1 is undefined, TODAY is used.
 ;Returns the following codes: 0=active, -1=not a&sp staff
 ;-2=student, -3=never activated, -4=inactivated on or before X1
 ;-5=not activated until after X1, -6=other provider (health technician)
 I '$D(^ACK(509850.3,+$G(ACKXX),0)) Q -1
 N ZERONODE,ACTIVE,INACTIVE,STANDING,DATE
 S DATE=$S(+$G(ACKXX1):ACKXX1,1:DT),ZERONODE=^ACK(509850.3,+ACKXX,0),STANDING=$P(ZERONODE,U,2),ACTIVE=$P(ZERONODE,U,3),INACTIVE=$P(ZERONODE,U,4)
 Q $S('ACTIVE:-3,ACTIVE>DATE:-5,(INACTIVE)&((INACTIVE<DATE)!(INACTIVE=DATE)):-4,"S"[STANDING:-2,"O"[STANDING:-6,1:0)
 ;
YN(X) ;  YES OR NO READER
 K DTOUT,DUOUT,DIRUT
 S X("B")=$S('$D(X):"",X:"Y",1:"N")
ASKYN W "  (Y/N) " W:X("B")]"" X("B")_"// " R X:DTIME S:'$T DTOUT=1 S:X="" X=X("B"),X("D")=1 I U[X!($D(DTOUT)) S DIRUT=1 S:X=U DUOUT=1 Q -1
 I "??"[X W !,"Answer Y for Yes or N for No." G ASKYN
 S X=$$UPC(X)
 I $E("YES",1,$L(X))=X W $S($D(X("D")):"  (YES)",1:$E("YES",$L(X)+1,3)) Q 1
 I $E("NO",1,$L(X))=X W $S($D(X("D")):"  (NO)",1:$E("NO",$L(X)+1,3)) Q 0
 W "  ??",!,$C(7) G ASKYN
 ;
PAUSE N DIR,DTOUT,DUOUT,JJ,SS,X,Y
 S SS=22-$Y F JJ=1:1:SS W !
 S DIR(0)="E" D ^DIR S:$D(DUOUT)!($D(DTOUT)) DIRUT=1 Q
 ;
TRIGCP ;  TRIGGER OF C AND P STATUS FIELD FROM #2.5, #4.17, & #4.19
 N Y
 S Y(0)=$G(^ACK(509850.6,DA,0)),Y(4)=$G(^(4)),Y(1)=$P(Y(0),U,5)
 S Y(2)=$P(Y(4),U,17),Y(3)=$P(Y(4),U,19)
 S X=$S(('Y(1)&('Y(2))):0,Y(3)]"":3,Y(2)]"":2,1:1)
 Q
 ;
HTIM(%H,%S) ;
 ;  Expected Input: %H = Full $H, %S = 1 if seconds desired
 N X
 S:'$D(%H) %H=$H S:%H["," %H=$P(%H,",",2)
 S X(3)=$$PAD(%H#60,"R",2,"0"),%H=%H\60
 S X(2)=$$PAD(%H#60,"R",2,"0"),%H=$$PAD(%H\60,"R",2,0)
 S X=%H_":"_X(2)_$S('$D(%S):"",'%S:"",1:":"_X(3))
 Q X
 ;
PAD(X,X1,X2,X3) ;
 ; Required Input: X = String to Pad, X1 = "R" or "L" (right/left justify)
 ; X2 = Number of Spaces, X3 = Pad character
 F  Q:$L(X)'<X2  S X=$S(X1="R":X3_X,1:X_X3)
 Q X
 ;
BFY(X) ;  RETURNS FM BEGIN OF FY FOR DATE X
 N M,D,Y S M=$E(X,4,5),D="00",Y=$E(X,1,3)-(M<10),M=10
 Q Y_M_D
 ;
INTRO ;  QUASAR Introduction: 
 ;  Called by the entry action of the ACKQAS SUPER menu option.
 ;
 K %ZIS S IOP="HOME" D ^%ZIS K %ZIS,IOP
 W @IOF
 W ! D CNTR("Quality:")
 W ! D CNTR("Audiology and Speech")
 W ! D CNTR("Analysis and Reporting")
 W ! D CNTR("(QUASAR)")
 W !! D CNTR("Version "_$P($T(V),";",3))
 W !
 Q
IVD ;  INITIAL VISIT DATE  ** TRIGGERED FROM PATIENT NAME ***
 N Y,DDD,DD,DFN,D0,%DT
 S DFN=X,X=$S('$D(^ACK(509850.2,DFN,0)):"",'$P(^(0),U,2):"",1:$P(^(0),U,2))
 I 'X D
 . F  D  Q:X=""!(X'>DT)
 .. S Y=ACKVD D DD^%DT S %DT="AEP",%DT("A")="INITIAL VISIT DATE: "
 .. S %DT("B")=Y D ^%DT K %DT S X=$S(Y<1:"",1:Y)
 .. I X>DT W !,"No Future Dates Allowed",!
 K A1
 Q
 ;
ADDPROV(ACKVIEN,X) ;  Add Procedure Provider to List of Secondary
 ;  Providers if it is not already there.
 ;  X=Provider
 ;  ACKVIEN=IEN of Visit
 ;
 N ACK2,ACKMSG,ACKTGT,ACKARR,ACKARR1
 D LIST^DIC(509850.66,","_ACKVIEN_",",".01","I","*","","","","","","ACKTGT","ACKMSG")
 S ACK2=""
 F  S ACK2=$O(ACKTGT("DILIST",1,ACK2)) Q:ACK2=""  D
 . S ACKARR(ACKTGT("DILIST",1,ACK2))=""
 S ACKPRIM=$$GET1^DIQ(509850.6,ACKVIEN_",",6,"I")
 I ACKPRIM S ACKARR(ACKPRIM)=""
 I $D(ACKARR(X)) Q
 S ACKARR1(509850.66,"+1,"_ACKVIEN_",",.01)=X
 D UPDATE^DIE("","ACKARR1","","")
 Q 
 ;
