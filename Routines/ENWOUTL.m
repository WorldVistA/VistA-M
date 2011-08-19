ENWOUTL ;(WCIOFO)/SAB-Work Order Utilities ;10/21/1998
 ;;7.0;ENGINEERING;**35,42,48,59**;Aug 17, 1993
 Q
 ;
ASKCC(ENWODA) ; Ask Condition Code Extrinsic Function
 ; Input ENWODA - ien of work order
 ; Output - 0 (don't ask) or 1 (ask) condition code
 N ENASK,ENEQDA,ENSHKEY,ENSHPAR
 S ENASK=0
 I $G(ENWODA) S ENEQDA=$P($G(^ENG(6920,ENWODA,3)),U,8) D:ENEQDA
 . S ENSHKEY=$P($G(^ENG(6920,ENWODA,2)),U) Q:'ENSHKEY
 . S ENSHPAR=+$P($G(^DIC(6922,ENSHKEY,0)),U,4)
 . S ENASK=$S(ENSHPAR=0:0,ENSHPAR=2:1,$P($G(^ENG(6914,ENEQDA,2)),U,3)>4999.99:1,1:0)
 Q ENASK
 ;
WO ; select work order entry point
 ; called from various places where work orders are selected
 ; Input
 ;   DIC("S") - (optional and not returned)
 ; Output
 ;   Y        - "ien^.01 value" or "-1" if unsuccessful
 N D,ENX,X
 S DIC="^ENG(6920,"
WOA ; ask user
 R !,"Select WORK ORDER #: ",ENX:DTIME I ENX=""!(ENX["^")!'$T S Y=-1 G WOX
 I $E(ENX,2,2)="." D  I D]"" S X=$E(ENX,3,99),DIC(0)="QE" D IX^DIC G WOR
 . S D=""
 . I $E(ENX)="E" S D="G" Q  ; equipment id#
 . I $E(ENX)="L" S D="C" Q  ; location
 I ENX="?" D
 . W !," Use 'E.value' to list W.O.s whose EQUIPMENT ID# equals 'value'"
 . W !," Use 'L.value' to list W.O.s whose LOCATION starts with 'value'"
 S X=ENX,DIC(0)="QEM" D ^DIC
WOR ; Result of DIC call
 I Y'>0 G WOA
WOX ; Exit
 K DIC
 Q
 ;
CDATE(Y) ; Check on COMPLETION DATE (field 36, file 6920)
 ;
 ;  Expects: Y as COMPLETION DATE (internal format)
 ;           DA as IEN in Work Order File (returned)
 ;
 ;  COMPLETION DATE may not preceed REQUEST DATE for unscheduled w.o.
 ;  For PM work orders, COMPLETION DATE may not preceed nominal date of
 ;    PM w.o. - where century is inferred
 ;
 ;  Returns X as "^" if no date
 ;               "^1" NOMINAL DATE > COMPLETE DATE (PM)
 ;               "^2" REQUEST DATE > COMPLETE DATE (unscheduled)
 ;               Y if acceptable
 ;
 I Y'>0 S X="^",EN("BAD COMPLETION DATE")="" D EN^DDIOL("Inappropriate COMPLETION DATE.") Q X
 N REQDATE,X S REQDATE=$P($P(^ENG(6920,DA,0),U,2),".")
 I REQDATE'>Y S X=Y Q X
 I $E($P(^ENG(6920,DA,0),U),1,3)="PM-" D  Q X
 . N DELYR,NOMDATE
 . S NOMDATE=$E($TR($P(^ENG(6920,DA,0),U),"ABCDEFGHIJKLMNOPQRSTUVWXYZ-",""),1,4)
 . S DELYR=$E(DT,2,3)-$E(NOMDATE,1,2),NOMDATE=$E(DT)+$S(DELYR>79:1,DELYR<-20:-1,1:0)_NOMDATE_"00"
 . I NOMDATE'>Y S X=Y,$P(^ENG(6920,DA,0),U,2)=NOMDATE Q
 . S X="^1",EN("BAD COMPLETION DATE")="" D EN^DDIOL("COMPLETION DATE may not precede nominal PM date.")
 S X="^2" D EN^DDIOL("COMPLETION DATE may not precede REQUEST DATE (unscheduled).")
 Q X
 ;
LBRCST(ENFLAG) ; Calculate work order TOTAL HOURS and the TOTAL LABOR COST
 ;         based on the TECHNICIANS ASSIGNED multiple in file 6920
 ; Called by MUMPS X-REFs in file 6920, fields .01 and 1 in multiple
 ; Input   ENFLAG (1 for SET LOGIC or 2 for KILL LOGIC)
 ; Expects DA(1) as work order IEN
 ;         DA as ASSIGNED TECH IEN [within DA(1)]
 ;
 N HOURS,WAGE,COST,X
 S (HOURS,WAGE,COST,X)=0
 F  S X=$O(^ENG(6920,DA(1),7,X)) Q:X'>0  D
 . I ENFLAG=2,X=DA Q  ; don't include hours of the deleted tech
 . S HOURS(X)=$P(^ENG(6920,DA(1),7,X,0),U,2)
 . S X(0)=$P(^ENG(6920,DA(1),7,X,0),U)
 . S WAGE(X)=$P($G(^ENG("EMP",X(0),0)),U,3)
 . I WAGE(X)'>0,$E(^ENG(6920,DA(1),0),1,3)="PM-" S WAGE(X)=$P($G(^DIC(6910,1,0)),U,4)
 . S COST(X)=HOURS(X)*WAGE(X)
 S X=0
 F  S X=$O(HOURS(X)) Q:X'>0  S HOURS=HOURS+HOURS(X),COST=COST+COST(X)
 S COST=$J(COST,0,2)
 S $P(^ENG(6920,DA(1),5),U,3)=HOURS,$P(^(5),U,6)=COST
 Q
 ;ENWOUTL
