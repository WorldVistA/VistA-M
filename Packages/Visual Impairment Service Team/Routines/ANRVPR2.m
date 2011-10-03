ANRVPR2 ;AUG/JLTP - PRINT PATIENT RECORD CONT'D ; 30 Mar 98 / 7:47 am
 ;;4.0; Visual Impairment Service Team ;;12 Jun 98
GETDATA ;------ Gather Data into ANRV( array ------
 D 6^VADPT ;K ANRV ;demographics & address
 S (ANRV(1),PNM)=VADM(1),ANRV(2)=VAPA(1)
 S ANRV(3)=$S(VAPA(4)]"":VAPA(4)_", ",1:"")_$S(+VAPA(5)>0:$P($G(^DIC(5,+VAPA(5),0)),U,2),1:"")_"  "_VAPA(6)
 S ANRV(4)=$P(VAPA(7),U,2),ANRV(5)=VAPA(8)
 K VAPA S (ANRV(6),SSN)=$P(VADM(2),U,2),ANRV(10)=$P(VADM(3),U,2)
 S (ANRV(12),AGE)=VADM(4),ANRV(13)=$P(VADM(10),U,2) ;K VADM
 ;D ELIG^VADPT ;eligibility information
 S ANRV(7)=VAEL(7),ANRV(9)=$P(VAEL(2),U,2) ;claim#, pos
 S ANRVPS=$P(VAEL(2),U,2) ;K VAEL ;period of service
 D SVC^VADPT ;service record
 S ANRV(9)=ANRV(9)_$S($P(VASV(6,4),U,2)]"":" ("_$P(VASV(6,4),U,2),1:"")_$S($P(VASV(6,5),U,2)]"":" - "_$P(VASV(6,5),U,2)_")",1:"")
 S ANRV(9.5)=$P(VASV(6,1),U,2) ;last branch of service
 ;K VASV
 D OPD^VADPT ;other patient data
 S ANRV(11)=VAPD(1)_$S(+VAPD(2)>0:", "_$P($G(^DIC(5,+VAPD(2),0)),U,2),1:"")
 S ANRV(12.5)=$P(VAPD(7),U,2) ;employment status
 ;K VAPD
 D KVAR^VADPT,KVA^VADPT
OTHER ;------ Data not available from VADPT ------
 S DIC="^DPT(",DA=DFN,DR=.314,DIQ="ANRV(" D EN^DIQ1
 S ANRV(8)=ANRV(2,DFN,.314)
 S ANRVFN=$O(^ANRV(2040,"B",DFN,0)) ;vist roster internal number
 ;Living Arrangements
 S Y=$P($G(^ANRV(2040,ANRVFN,7)),U,5),C=$P(^DD(2040,1.2,0),U,2) D Y^DIQ S ANRV(13.5)=Y
 S ANRV(15)=$P($G(^ANRV(2040,ANRVFN,13)),U) ;spouse
 S ANRV(17)=$P($G(^ANRV(2040,ANRVFN,2)),U) ;eligibility
 K ANRV(17.1) S X=1 ;prepare to gather rated disabilities
 F I=0:0 S I=$O(^DPT(DFN,.372,I)) Q:'I  D
 .S Y=+$G(^DPT(DFN,.372,I,0)),Y(1)=$P(^(0),U,2)
 .S Y(0)=$G(^DIC(31,Y,0))
 .S Y=$S($P(Y(0),U,4)]"":$P(Y(0),U,4),1:$P(Y(0),U))
 .I Y]"" D
 ..S Y=Y_" ("_Y(1)_"%)"
 ..S ANRV(17.1,X)=Y,X=X+1
 S ANRV(14)=0 F I=0:0 S I=$O(^ANRV(2040,ANRVFN,1,I)) Q:'I  D
 .S ANRV(14)=ANRV(14)+1,ANRV(16,ANRV(14))=$P(^ANRV(2040,ANRVFN,1,I,0),U) ;dependants
 S I=+$P($G(^ANRV(2040,ANRVFN,3,0)),U,3),ANRV(18)=$G(^(I,0)) ;last eye
 S $P(ANRV(18),U)=$$DATE(+ANRV(18)) ;date of last eye exam
 K ANRV(17.5) S X=1 ;Next we will gather all eye diagnoses
 F I=0:0 S I=$O(^ANRV(2040,ANRVFN,15,I)) Q:'I  S Y=+^(I,0) D
 .S:$G(ANRV(17.5,X))]"" ANRV(17.5,X)=ANRV(17.5,X)_", "
 .S X1=$P($G(^ANRV(2041.5,Y,0)),U)
 .I ($L($G(ANRV(17.5,X)))+$L(X1)+31)>IOM S X=X+1
 .S ANRV(17.5,X)=$G(ANRV(17.5,X))_X1
 S I=+$P($G(^ANRV(2040,ANRVFN,6,0)),U,3),ANRV(19)=$G(^(I,0)) ;last
 I I'=0 S $P(ANRV(19),U)=$$DATE(+ANRV(19)) ;vist review date
 ;Type of Review
 I I'=0 S Y=$P(ANRV(19),U,2),C=$P(^DD(2040.06,1,0),U,2) D Y^DIQ S $P(ANRV(19),"^",2)=Y
 ;elegibility on review date
 I I'=0 S Y=$P(ANRV(19),U,3),C=$P(^DD(2040.06,2,0),U,2) D Y^DIQ S $P(ANRV(19),"^",3)=Y
ANRVZ I I=0 S ANRV(19)="^^^^^"
 S I=+$P($G(^ANRV(2040,ANRVFN,10,0)),U,3),Y=$G(^(I,0)) ;last
 S ANRV(20)=$$DATE(Y) ;field visit date
 Q
SET ;------ Resolve Set of Codes ------
 Q
INIT ;------ Set up headings, footers, etc ------
 S ANRVPG=0
 K ANRV,ANRVH,ANRVC S ANRVH(1)="VISUAL IMPAIRMENT SERVICE TEAM (VIST)"
 S ANRVH(2)="PATIENT RECORD"
 S ANRVSITE=$O(^ANRV(2041,0)),SITE=$P(^ANRV(2041,ANRVSITE,0),"^"),ANRVH(3)=$P(^DIC(4,SITE,0),"^")_" ("_$P(^DIC(4,SITE,99),"^")_")"
 D NOW^%DTC S DT=X S ANRVH(4)=$$DATE(X)
 S X=$G(^ANRV(2041,1,0)),ANRVC(1)=$P(X,U,2)
 S ANRVC(2)="VIST Coordinator - "_$P(^ANRV(2041,ANRVSITE,0),U,3)
 Q
DATE(Y) ;------ Convert Y to external format ------
 D DD^%DT Q Y
