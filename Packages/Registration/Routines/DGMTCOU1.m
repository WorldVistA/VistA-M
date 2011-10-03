DGMTCOU1 ;ALB/REW,LD,JAN,AEG,LBD - COPAY UTILITIES ; 8/13/04 8:31am
 ;;5.3;Registration;**33,45,54,335,358,401,436,445,564**;Aug 13, 1993
AUTO(DFN,AUTOEX) ;
 ; Returns 1 if Exempt from CP w/o needing MT/CP information
 ;  INPUT: DFN     [Required]
 ;         AUTOEX  [Optional]
 ;  RETURNS 1=Exempt 0=Not Exempt
 ;
 ; Hold the Auto exclusion information for later use
 S AUTOEX=$$AUTOINFO(DFN)
 ;
 Q AUTOEX["1"
AUTOINFO(DFN) ;
 ; This returns info needed to IB to see if MT information needs to be
 ; looked at to determine Copay Exemption Status
 ;
 ;  INPUT: DFN - IEN of Patient File (Required)
 ; OUTPUT: (SC>50%^REC.A&A^REC.HB^REC.PEN^DOM PT^NON.VET^INPT^POW^UNEMP)
 ;  Piece: (   1  ^   2   ^   3  ^   4   ^   5  ^   6   ^  7 ^ 8 ^  9  )
 ;  PIECES =1 IF TRUE
 ;
 N DGALLEL,DGDOM,DGEL,DGNODE,DGX,DGYR,VADMVT,DGI
 S DGX=""
 I $P($G(^DPT(DFN,"VET")),U,1)'="Y" S $P(DGX,U,6)=1 G QTAUTO ;NON-VET
 S DGEL=0,DGALLEL=U
 F  S DGEL=$O(^DPT("AEL",DFN,DGEL)) Q:'DGEL  S DGALLEL=DGALLEL_$P($G(^DIC(8,DGEL,0)),U,9)_U
 F DGI=.3,.362,.52 S DGNODE(DGI)=$G(^DPT(DFN,DGI))
 I (DGALLEL["^1^") S $P(DGX,U,1)=1 G QTAUTO ;SC>50
 I $P(DGNODE(.362),U,12)["Y"!(DGALLEL["^2^") S $P(DGX,U,2)=1 G QTAUTO ;A&A
 I $P(DGNODE(.362),U,13)["Y"!(DGALLEL["^15^") S $P(DGX,U,3)=1 G QTAUTO ;HB
 I $P(DGNODE(.362),U,14)["Y"!(DGALLEL["^4^") S $P(DGX,U,4)=1 G QTAUTO ;PENSION
 I $P(DGNODE(.52),U,5)["Y"!(DGALLEL["^18^") S $P(DGX,U,8)=1 G QTAUTO ;POW
 I $P(DGNODE(.3),U,5)["Y"&($P(DGNODE(.3),U,2)>0)&($P(DGNODE(.362),U,20)>0) S $P(DGX,U,9)=1 G QTAUTO ;UNEMPLOYABLE
 N DGDOM,DGDOM1,VAHOW,VAROOT,VAINDT,VAIP,VAERR
 D DOM^DGMTR I $G(DGDOM) S $P(DGX,U,5)=1 G QTAUTO ;DOM
 D IN5^VADPT I $G(VAIP(1))'="" S $P(DGX,U,7)=1 G QTAUTO ;INPAT
QTAUTO Q DGX
 ;
LST(DFN,DGDT,DGMTYPT1) ;Last Copay Exemption or Means Test for a patient
 ;   Input  -- DFN   Patient IEN
 ;             DGDT  Date/Time  (Optional- default today@2359)
 ;             DGMTYPT1 (Optional (1:MT, 2:CP, Null/Default or 3:Either)
 ;   Output -- MT IEN^Date of Test ^Status Name^Status Code^Type of Test
 ;      Piece:   1   ^     2              3         4            5
 ;
 N DGCPDT,DGIDT,DGIDT,DGMTDT,DGMTI,Y
 S DGIDT=$S($G(DGDT)>0:-DGDT,1:-DT) S:'$P(DGIDT,".",2) DGIDT=DGIDT_.2359
 I '$D(DGMTYPT1) S DGMTYPT1=3
 I DGMTYPT1=3 D  ;EITHER
 .S DGMTDT=+$O(^DGMT(408.31,"AID",1,DFN,DGIDT))
 .S DGCPDT=+$O(^DGMT(408.31,"AID",2,DFN,DGIDT))
 .S DGMTYPT1=$S(DGCPDT<DGMTDT:2,(DGCPDT>DGMTDT):1,$D(^DGMT(408.31,"AS",1,3,+DGMTDT,DFN)):2,1:1)
 S DGMTI=+$$LST^DGMTU(DFN,$P(DGIDT,"-",2),DGMTYPT1)
 I $D(^DGMT(408.31,DGMTI,0)) S Y=DGMTI_"^"_$P(^(0),"^")_"^"_$$MTS^DGMTU(DFN,+$P(^(0),"^",3))_"^"_DGMTYPT1
 Q $G(Y)
THRESH(DGDT) ;PRINTS THE YEAR'S COPAY THRESHOLDS
 ;UPDATE 11/15/00 TO REFLECT YEAR'S COPAY THRESHOLDS PER VHA DIRECTIVE
 ;99-064
 N DGCPLEV,DGDEP,DGNODE,DGTYPE,Y
 I '$D(DGDT) S DGDT=DT
 S DGDT=DGDT\1
 S Y=DGDT X ^DD("DD") W !,?2,"Net Annual Income Thresholds on ",Y,":"
 S DGTYPE=$S(DGDT<2961201:2,1:1)
 S DGCPLEV=$$THRES^IBARXEU1(DGDT,DGTYPE,0)
 I DGCPLEV']"" W !,"None for this date..." G THRESHQT
 W !,?5,"Num. Dependents: ",?25,"0 (Self)",?42,1,?52,2,?62,3,?72,4
 W !,?5,"Net Income:"
 F DGDEP=0:1:4 W ?(23+(DGDEP*10)),$J(+$$THRES^IBARXEU1(DGDT,DGTYPE,DGDEP),10)
THRESHQT Q
DISPMAS(DFN) ; Displays Co
 N DGCPS,DGEX,Y,AUTOEX
 S DGEX=$$AUTO(DFN,.AUTOEX)
 I $P($G(AUTOEX),U,5)!($P($G(AUTOEX),U,7)) Q
 I DGEX W !,"Patient is exempt from Copay."
 I 'DGEX D
 .S DGCPS=$$LST365(DFN,DT,2),Y=$P(DGCPS,U,2)
 .I DGCPS]"" D
 ..X ^DD("DD")
 ..W !,"Patient's Copay Status is ",$P(DGCPS,U,3)
 ..W ".  Last Test Date: ",Y,"."
 Q
LST365(DFN,DGDT,DGMTYPT1) ;RETURNS CURRENT MT/CP  (WITHIN 365 DAYS)
 ;  Input:   DGDT - IB DATE
 ;           DGMTYPT1 (Optional (1:MT, 2:CP, Null/Default or 3:Either)
 ;  Output -- MT IEN^Date of Test ^Status Name^Status Code^Type of Test
 ;     Piece:   1   ^     2              3         4            5
 N DGLST
 S DGDT=$G(DGDT)
 I '$D(DGMTYPT1) S DGMTYPT1=3
 S DGLST=$$LST(DFN,DGDT,DGMTYPT1)
 S:$P(DGLST,U,4)="N" DGLST=$$LST(DFN,DGDT,2)
 S:$$365($P(DGLST,U,2),DGDT) DGLST="" ;RETURN NULL IF LAST >365
 Q DGLST
365(X1,DGDT) ; RETURNS 1 IF X1 IS MORE THAN 1 YEAR BEFORE DGDT
 Q X1+10000'>DGDT
