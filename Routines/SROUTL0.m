SROUTL0 ;BIR/DLR,ADM - UTILITY ROUTINE ; [ 06/20/01  2:33 PM ]
 ;;3.0; Surgery ;**50,100**;24 Jun 93
 ;
 ; Reference to ^SC( supported by DBIA #964
 ;
NODATA() ;;utility to write no data
 W !!
 Q "No data for selected date range."
DIV(CASE) ;define the division of this case
 ; CASE - File 130 ien
 ; returns 0 - non-divisional match; 1 - divisonal match
 N SRDIV,SROR I '$D(^SRF(CASE,0)) Q 0
 I '$O(^SRO(133,1)) Q 1
 I '$D(^SRF(CASE,"NON")) S SRDIV="",SROR=$P(^SRF(CASE,0),U,2) I SROR'="" S SROR=$P(^SRS(SROR,0),U) I SROR'="" S SRDIV=$P(^SC(SROR,0),U,4)
 I $D(^SRF(CASE,"NON")) S SRDIV="",SROR=$P(^SRF(CASE,"NON"),U,2) I SROR'="" S SRDIV=$P(^SC(SROR,0),U,4)
 I SRDIV="" S SRDIV=$P($G(^SRF(CASE,8)),U)
 Q SRDIV=$G(SRSITE("DIV"))
ORDIV(OR,SRINST) ;define the division of this OR
 ; OR - .01 of Operating Room in file 131.7
 ; returns 0 - non-divisional match; 1 - divisonal match
 N SRDIV
 I '$O(^SRO(133,1)) Q 1
 I SRINST="" Q 1
 I SRINST["ALL" Q 1
 I $G(OR)'="" S OR=$P(^SRS(OR,0),U),SRDIV=$P($G(^SC(OR,0)),U,4) I SRDIV'="" S SRDIV=$P(^(0),U,4)
 Q SRDIV=SRINST
NONORDIV(CASE,NONOR) ;define nonor divisional locations (File #130,119 input transform)
 ; CASE - File 130 ien
 ; NONOR - File 44 ien
 ; returns 0 - non-divisional match; 1 - divisonal match
 N CD,IORD,RORD,SRDIV
 ; CD - case date
 ; SRDIV - boolean (case division MATCH)
 ; IORD - Location file inactive date
 ; RORD - Location file inactive date
 ; 
 S SRDIV=1
 I '$D(^SC(NONOR,0))!$G(NONOR)=""!$G(CASE)="" Q SRDIV
 I '$D(^SRF(CASE,"NON")) Q 0
 ;if there is no institution set for this non-or location quit
 I $P(^SC(NONOR,0),U,4)="" Q 0
 I $D(SRSITE("DIV")) I $P(^SC(NONOR,0),U,4)'=$G(SRSITE("DIV")) Q 0
 I $D(^SC(NONOR,"I")) S CD=$P(^SRF(CASE,"NON"),U,3),IORD=$P(^SC(NONOR,"I"),U),RORD=$P(^SC(NONOR,"I"),U,2) D:IORD'=""
 .I CD'<IORD,((RORD="")!(CD<RORD)) S SRDIV=0 Q
 Q SRDIV
MANDIV(SRINST,CASE) ;a boolean divisional call for managerial reports
 I '$D(^SRF(CASE,0)) Q 0
 I '$O(^SRO(133,1)) Q 1
 I SRINST["ALL" Q 1
 I +SRINST'>0 Q 0
 N SRDIV,SROR
 I '$D(^SRF(CASE,"NON")) S SRDIV="",SROR=$P(^SRF(CASE,0),U,2) I SROR'="" S SROR=$P(^SRS(SROR,0),U) I SROR'="" S SRDIV=$P(^SC(SROR,0),U,4)
 I $D(^SRF(CASE,"NON")) S SRDIV="",SROR=$P(^SRF(CASE,"NON"),U,2) I SROR'="" S SRDIV=$P(^SC(SROR,0),U,4)
 I SRDIV="" S SRDIV=$P($G(^SRF(CASE,8)),U)
 Q SRDIV=SRINST
INST() ;extrinsic call used by the management reports to determine division
 ; Returns:
 ;   inst#^inst name - for one division
 ;   "ALL DIVISIONS" - all divisions
 ;   "^"             - no division
 N SR,SRCNT,SRINST,X S (SRCNT,X)=0 F  S X=$O(^SRO(133,X)) Q:'X  I '$P($G(^SRO(133,X,0)),"^",21) S SRCNT=SRCNT+1
 I SRCNT=1 S SRINST=$P($$SITE^SROVAR,"^",1,2) Q SRINST
 W ! K DIR,Y S DIR(0)="YO",DIR("?")="Enter 'Yes' to include all divisions, or 'No' to pick one division",DIR("A")="Do you want to print all divisions",DIR("B")="YES" D ^DIR S SRINST=$S($G(Y(0))'="":Y(0),1:"^")
 I SRINST="YES" S SRINST=$P($$SITE^SROVAR,U,2)_" - ALL DIVISIONS"
 I SRINST="NO" D LIST^DIC(133,"",".01","B","*","","","","","","SR") W ! D
 .S X=0 F  S X=$O(SR("DILIST",1,X)) Q:'X  W !,X,". ",SR("DILIST",1,X)
 .K DIR W ! S DIR(0)="NO^1:"_$P(SR("DILIST",0),U),DIR("A")="Select Number" D ^DIR S:+Y<1 SRINST="^" S:+Y>0 SRINST=SR("DILIST",2,+Y),DIR("?")="Enter the corresponding number of the hospital for which you want the report to run"
 Q $S(SRINST["ALL DIVISIONS":SRINST,SRINST=U:SRINST,1:$P(^SRO(133,SRINST,0),U)_U_SR("DILIST",1,+Y))
SITE(CASE) ; returns pointer to file 133 indicating where case was performed
 ; CASE - ien in File 130
 N SRDIV,SROR S SRDIV="" I '$D(^SRF(CASE,"NON")) S SROR=$P($G(^SRF(CASE,0)),"^",2) I SROR'="" S SROR=$P(^SRS(SROR,0),"^") I SROR'="" S SRDIV=$P(^SC(SROR,0),"^",4)
 I $P($G(^SRF(CASE,"NON")),"^")="Y" S SROR=$P(^SRF(CASE,"NON"),"^",2) I SROR'="" S SRDIV=$P(^SC(SROR,0),"^",4)
 I SRDIV="" S SRDIV=$P($G(^SRF(CASE,8)),"^")
 S:SRDIV'="" SRDIV=$O(^SRO(133,"B",SRDIV,0))
 S:SRDIV="" SRDIV=$O(^SRO(133,0))
 Q SRDIV
WARD(SRW,SRINST,DGPMOS) ;a boolean divisional call for active ward location
 ; SRW - IEN in File 42
 ; SRINST - user division
 ; DGPMOS - date to check for active ward
 ; returns 0 - non-divisional match; 1 - divisional match
 N SRLOC,D0,X
 S D0=SRW D WIN^DGPMDDCF I X=1 Q 0
 I '$O(^SRO(133,1))!(SRINST="")!(SRINST["ALL") Q 1
 S SRLOC=$P($G(^DIC(42,SRW,44)),"^") I SRLOC="" Q 1
 S SRDIV=$P($G(^SC(SRLOC,0)),"^",4) I SRDIV="" Q 1
 Q SRDIV=SRINST
HL(SRLOC,SRINST) ; define division of this hospital location
 ; SRLOC - File 44 IEN
 ; SRINST - user division
 ; returns 0 - non-divisional match; 1 - divisional match
 N SRDIV I SRINST="" Q 1
 S SRDIV=0
 I $G(SRLOC)'="" S SRDIV=$P($G(^SC(SRLOC,0)),"^",4) I SRDIV="" Q 1
 Q SRDIV=SRINST
