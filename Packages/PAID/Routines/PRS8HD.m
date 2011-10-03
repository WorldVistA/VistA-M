PRS8HD ;HISC/MGD-DECOMPOSITION, DETERMINE HOLIDAYS ;12/17/2008
 ;;4.0;PAID;**4,33,72,88,94,98,113,118,122,123**;Sep 21, 1995;Build 1
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;This routine is used to determine legal holidays.  One calls
 ;^PRS8HD with nothing defined if one wants all holidays in the
 ;next year.  Tag EN can be called with PRS8D defined as a VA
 ;FileManager format date from which to calculate holidays.  See
 ;later documentation in this routine regarding further processing
 ;instructions.
 ;
 K PRS8D
 ;
EN ;--- entry point
 ;    pass PRS8D as date you want in VA FileMan format
 ;    -  where only year, i.e., 92 is passed, the first day is presumed
 ;    pass PRS8D(0) containing a holiday code if specific one wanted
 ;    if neither PRS8D or PRS8D(0) passed DT is assumed and all
 ;    holidays for next year are returned
 ;
 N CT,D,DD,DDQ,DN,DX,NY,%Y,PRSDT1 ;new variables used
 K HD,HO,PRS8D(1) ;remove existing array if there
 I '($D(DT)#2) D DT^DICRW ;get DT if none
 S X=$G(PRS8D) I X']"" S X=DT ;use DT if no X
 K %DT D ^%DT S X=Y I Y'>0 S PRS8D(1)=-1 G END ;bad date
 I '+$E(X,4,5) S X=$E(X,1,3)_"01"_$S(+$E(X,6,7):$E(X,6,7),1:"01")
 S PRSDT1=X
 ;
 ; Build sorted list (by month) of recurring holidays in array H()
 ; If specific holiday code passed just get it, else get all.
 ; Note that holiday code "E" is not a recurring holiday so it is
 ; handled in another section after the recurring holidays are done.
 S (CT,NY)=0,X1=$G(PRS8D(0)),X2="^K^P^M^I^L^C^V^T^X^N^"
 I X1]"",X2[("^"_X1_"^") S X1=$F(X2,X1)-1\2+1,J=$P($T(H+(X1+6)),";;",2),H($P(J,"^",2),$P(J,"^",1))=$P(J,"^",3,5)
 E  I X1'="E" F I=1:1 S J=$P($T(H+(I+7)),";;",2) Q:J=""  S H($P(J,"^",2),$P(J,"^",1))=$P(J,"^",3,5) ;get dates by month
 ;
 ; build output arrays for the recurring holidays
PASS ;--- come back here for a second pass if necessary
 S DN=X,D(1)=+$E(X,1,3),D(2)=0 F  S D(2)=$O(H(D(2))),D(3)="" Q:'D(2)  F  S D(3)=$O(H(D(2),D(3))) Q:D(3)=""  D
 .S DD=H(D(2),D(3))
 .S D=D(1)+($S(D(2)<(+$E(DN,4,5)):1,1:0))_$E("00",0,2-$L(D(2)))_D(2)_$E(DN,6,7)
 .I '$P(DD,"^",2) D
 ..S (DX,X)=$E(D,1,5)_$E("00",0,2-$L(+$P(DD,"^",1)))_+$P(DD,"^",1)
 ..D DW^%DTC S Y=%Y,X=DX
 ..Q  ;I Y,Y'=6 Q
 ..S X2=$S('Y:"",1:"-")_1,X1=X D C^%DTC
 .E  D
 ..S (DX,X)=$E(D,1,5)_"01"
 ..D DW^%DTC S Y=%Y,X=DX
 ..I Y'=+DD D
 ...I +Y<+DD S X2=DD-Y
 ...E  S X2=7-(+Y)+DD
 ...S X1=X D C^%DTC
 ..I +$P(DD,"^",2)=1 S DX=X Q
 ..S DD(1)=X,(DD(2),DD(3),DDQ)=0 F  Q:DD(2)&(DDQ)  D
 ...S X2=7,X1=DD(1) D C^%DTC
 ...S DD(2)=X,DDQ=1
 ...I $E(DD(1),1,5)=$E(X,1,5) S DD(1)=X,DDQ=0
 ...S DD(3)=DD(3)+1 I DD(3)=2,+$P(DD,"^",2)=3 S DDQ=1
 ...I DD(3)=1,+$P(DD,"^",2)=4 S DDQ=1
 ...I DD(3)=3,+$P(DD,"^",2)=5 S DDQ=1
 ..S (DX,X)=DD(1)
 .D DW^%DTC S Y=%Y,X=DX
 .Q:X<DN
 .D SET
 .I +DD=+D(2)=+$E(DN,4,5),$P(DD,"^",3)="N" D
 ..S NY=NY+1 Q:NY>1
 ..S X=$E(DN,1,3)+1,(DX,X)=X_"0101"
 ..D DW^%DTC S Y=%Y,X=DX
 ..Q  ;Q:Y'=6
 ..S X2=-1,X1=X D C^%DTC S DX=X
 ..D DW^%DTC S Y=%Y,X=DX
 ..D SET
 .K H(D(2),D(3))
 I $O(H(0))>0 D
 .S X=+$E(DN,4,5)
 .S X=$S(X=12:1,1:(X+1))
 .S X1=$E(DN,1,3)+$S(X=1:1,1:0),X=X1_$E("00",0,2-$L(X))_X_"01"
 .D PASS
 ;
 ;new section to add applicable extra (non-recurring) holidays
 I $G(PRS8D(0))=""!($G(PRS8D(0))="E") D
 . N PRSDT2,PRSI,PRSX
 . S PRSDT2=$$FMADD^XLFDT(PRSDT1,364)
 . ;
 . ; loop thru the extra holiday list
 . F PRSI=1:1 S PRSX=$P($T(EHOL+PRSI),";;",2) Q:PRSX=""  D
 . . Q:$P(PRSX,U)<PRSDT1  ; skip if before input date
 . . Q:$P(PRSX,U)>PRSDT2  ; skip if not within the next year
 . . ; need to add this extra holiday to list
 . . S HD($P(PRSX,U))=$P(PRSX,U,2,3)
 . . S HO("E",$P(PRSX,U))=""
 . . S CT=CT+1
 . ;
 . ; quit if site is not in the Washington DC area
 . Q:"^101^688^"'[(U_$E($$STA^XUAF4(+$$KSP^XUPARAM("INST")),1,3)_U)
 . ;
 . ; loop thru additional DC location extra holiday list
 . F PRSI=1:1 S PRSX=$P($T(EHOLDC+PRSI),";;",2) Q:PRSX=""  D
 . . Q:$P(PRSX,U)<PRSDT1  ; skip if before input date
 . . Q:$P(PRSX,U)>PRSDT2  ; skip if not within the next year
 . . ; need to add this extra holiday to list
 . . S HD($P(PRSX,U))=$P(PRSX,U,2,3)
 . . S HO("E",$P(PRSX,U))=""
 . . S CT=CT+1
 ;
 S PRS8D(1)=$S(CT:+CT,1:-1)
 ;
END ;--- That's all folks
 K %DT,H,I,J,X,X1,X2,Y Q
 ;
SET ;--- set nodes
 S HD(X)=D(3)_"^"_$P("SUN^MON^TUES^WEDNES^THURS^FRI^SATUR","^",Y+1)_"DAY",HO($P(DD,"^",3),X)="",CT=CT+1 Q
 ;
H ;--- Actual Holidays
 ;    PIECE1     PIECE2       PIECE3       PIECE4      PIECE5    PIECE6
 ;    actual     month        exact day    0=exact     holiday   how
 ;    holiday                 day-of-week  1=1st wk    code      deter-
 ;                                         2=last wk             mined
 ;    - pc3 and 4 are used in concert      3=3rd wk
 ;                                         4=2nd wk,5=4th wk
 ;
 ;;M.L. King's Birthday^1^1^3^K^3rd Monday in January
 ;;President's Day^2^1^3^P^3rd Monday in February
 ;;Memorial Day^5^1^2^M^Last Monday in May
 ;;Independence Day^7^4^0^I^July 4
 ;;Labor Day^9^1^1^L^First Monday in September
 ;;Columbus Day^10^1^4^C^Second Monday in October
 ;;Veterans Day^11^11^0^V^November 11
 ;;Thanksgiving Day^11^4^5^T^Fourth Thursday in November
 ;;Christmas Day^12^25^0^X^December 25
 ;;New Year's Day^1^1^0^N^January 1
 ;
 ;-Holiday Codes
 ;    - K = M.L. King         P = President's Day        M = Memorial Day
 ;    - I = Independence      L = Labor Day              C = Columbus Day
 ;    - V = Veterans Day      T = Thanksgiving           X = Christmas
 ;    - E = Extra Holiday (non-recurring)                N = New Year's
 ;
 ;HD(HOLIDAY) is returned by routine equal to "literal^Dow"
 ;HO("HOLIDAY CODE",HOLIDAY) is returned equal to null
 ;PRS8D* is returned in value passed
 ;PRS8D(1) is returned equal to # holidays found or -1 if none
 ;
 ;---------------------------------------------------------------------
 ;New Section Added for Extra Non-Recurring Holidays (holiday code E)
 ;
 ; format is
 ;   FM date of the declared holiday^text^day of week^patch number
 ;
 ; The following list will need to be updated for years that have an
 ; extra Christmas Holiday declared or and declared memorial day for
 ; past presidents.
 ;
EHOL ;
 ;;2940427^President Nixon Funeral^WEDNESDAY^PRS*3.1*2
 ;;2971226^Extra Christmas Day^FRIDAY^PRS*4*33
 ;;3011224^Extra Christmas Day^MONDAY^PRS*4*72
 ;;3031226^Extra Christmas Day^FRIDAY^PRS*4*88
 ;;3040611^President Reagan Funeral^FRIDAY^PRS*4*94
 ;;3070102^President Ford Funeral^TUESDAY^PRS*4*113
 ;;3071224^Extra Christmas Day^MONDAY^PRS*4*118
 ;;3081226^Extra Christmas Day^FRIDAY^PRS*4*122
 ;
 ;---------------------------------------------------------------------
 ;New Section Added for Extra Non-Recurring Holidays (holiday code E)
 ;that are location specifc to the DC area
 ;
 ; format is
 ;   FM date of the declared holiday^text^day of week^patch number
 ;
 ; The following list will need to be updated when additional specific
 ; holidays are declared that only apply to the DC area
 ;
EHOLDC ;
 ;;3050120^Presidential Inauguration Day^THURSDAY^PRS*4*98
 ;;3090120^Presidential Inauguration Day^TUESDAY^PRS*4*123
 ;
 ;PRS8HD
