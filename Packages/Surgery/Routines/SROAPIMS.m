SROAPIMS ;BIR/ADM - PIMS Information Retrieval ;01/24/07
 ;;3.0; Surgery ;**38,46,47,57,71,81,86,100,125,134,160**;24 Jun 93;Build 7
 ; 
 ; Reference to ^MCAR(690,"AC" supported by DBIA #1999
 ; Reference to ^DGPM("APTT1" supported by DBIA #565
 ;
 ; SRTN must be defined before calling this routine.
 ; This routine will return the following array
 ; SRVADPT(1)  = Name of the patient (e.g., SMITH,JOHN R.)
 ; SRVADPT(2)  = Patient ID (e.g., 123-45-6789)
 ; SRVADPT(3)  = Age of patient on date of operation (e.g., 36)
 ; SRVADPT(4)  = Sex of patient (e.g., M^MALE)
 ; SRVADPT(5)  = Race of patient (e.g., 6^WHITE, NOT OF HISPANIC ORIGIN)
 ; SRVADPT(6)  = Date of death
 ; SRVADPT(7)  = Hospital admission date
 ; SRVADPT(8)  = Hospital discharge date
 ; SRVADPT(9)  = Admission/transfer to surgical specialty
 ; SRVADPT(10) = Discharge/tranfer to chronic care
 ; SRVADPT(11) = Length of Post-Operative Hospital Stay (number of days)
 ; SRVADPT(12) = Admission to Observation
 ; SRVADPT(13) = Discharge from Observation
 ; SRVADPT(14) = Observation Specialty (PTF #)
 ; SRVADPT(15) = Bad Address Indicator
 ;
 N SR,SRCC,SRDT,SRNON,SRSRV S SR(0)=^SRF(SRTN,0),DFN=$P(SR(0),"^") F I=1:1:15 S SRVADPT(I)=""
 D DEM^VADPT S SRVADPT(1)=VADM(1),SRVADPT(2)=VA("PID"),SRVADPT(4)=VADM(5),SRVADPT(6)=VADM(6) S Y=$E($P(SR(0),"^",9),1,7),Z=$P(VADM(3),"^") S SRVADPT(3)=$E(Y,1,3)-$E(Z,1,3)-($E(Y,4,7)<$E(Z,4,7))
 S SRX=$P(VADM(8),"^") I SRX K DA,DIC,DIQ,DR,SRY S DIC=10,DR=2,DA=SRX,DIQ="SRY",DIQ(0)="I" D EN^DIQ1 S SRVADPT(5)=SRY(10,SRX,2,"I")_"^"_$P(VADM(8),"^",2)
 S SRVADPT(15)=$$BADADR^DGUTL3(DFN),$P(^SRF(SRTN,209),"^")=$S(SRVADPT(15):"Y",1:"N")
ADM ; find date(s) of admission and discharge
 N SRSOUT S SRSOUT=0,(VAIP("D"),SRSDATE)=$P(SR(0),"^",9) D IN5^VADPT
 ; if not admitted before surgery, look for admission within 24 hours of leaving OR
 I 'VAIP(13) S X1=$P($G(^SRF(SRTN,.2)),"^",12),X2=1 D C^%DTC S SR24=X,SRDT=$O(^DGPM("APTT1",DFN,SRSDATE)) G:'SRDT!(SRDT>SR24) END S VAIP("D")=SRDT D IN5^VADPT I 'VAIP(13) G END
 I VAIP(13) D ADM1 G:SRSOUT END
ADSS ; find date of admission/transfer to surgical service
 S SRSERV="" I VAIP(1) S SRX=$P(VAIP(8),"^") D SERV G:'SRSRV DISSS S:$P(VAIP(2),"^")=1 SRVADPT(9)=$E($P(VAIP(3),"^"),1,12) I $P(VAIP(2),"^")'=1 S SRSERV=$P(VAIP(3),"^")
 I VAIP(15) D PRIOR
DISSS ; find date of discharge/transfer to chronic care
 S SRNON=0,SRCC="",VAIP("D")=SRSAVE D IN5^VADPT
FOLLOW I VAIP(16) D  I 'SRNON S SRCC=VAIP(16,1),VAIP("D")=$P(SRCC,"^") D IN5^VADPT G FOLLOW
 .I $P(VAIP(16,2),"^")=3 S SRNON=1 Q
 .I "26"[$P(VAIP(16,2),"^") S SRX=$P(VAIP(16,6),"^") D NACUTE
 S SRVADPT(10)=SRVADPT(8) I SRNON S SRVADPT(10)=$E($P(VAIP(16,1),"^"),1,12)
STAY ; find length of post-operative hospital stay
 S X=$P($G(^SRF(SRTN,.2)),"^",3),X1=$P(SRVADPT(10),"^") I 'X!('X1)!(X>X1) G END
 S Y=$E(X1_"000",9,10)-$E(X_"000",9,10)*60+$E(X1_"00000",11,12)-$E(X_"00000",11,12),X2=X,X=$P(X,".",1)'=$P(X1,".",1) D ^%DTC:X S X=X*1440+Y,SRVADPT(11)=X\1440
END S $P(^SRF(SRTN,208),"^",10)=$P(SRVADPT(5),"^"),SRINOUT=$P(^SRF(SRTN,0),"^",12) I SRVADPT(7)'="",SRVADPT(9)="" S SRVADPT(9)=$P($G(^SRF(SRTN,.2)),"^",10)
 F I=7:1:10,12,13 S X=$P(SRVADPT(I),"^") I $L(X)>7 S $P(SRVADPT(I),"^")=+X
 I SRVADPT(7)'="" S $P(^SRF(SRTN,205),"^")=SRVADPT(11),L=6 F J=14:1:17 S L=L+1,$P(^SRF(SRTN,208),"^",J)=$P(SRVADPT(L),"^")
 I SRVADPT(7)="" S $P(^SRF(SRTN,205),"^")=$S(SRINOUT="O":"NA",1:SRVADPT(11)) S L=6 F J=14:1:17 S L=L+1 S $P(^SRF(SRTN,208),"^",J)=$S(SRINOUT="O":"NA",1:$P(SRVADPT(L),"^"))
 I SRVADPT(12)="" F J=1:1:3 S $P(^SRF(SRTN,208.1),"^",J)="NA"
 S $P(^SRF(SRTN,205),"^",3)=$S($P(SRVADPT(6),"^")'="":$E($P(SRVADPT(6),"^"),1,12),1:"NA")
 D MCAR,EMPLOY
 D KVA^VADPT K DIE,DR,I,SR,SR24,SR48,SRCC,SRD,SRDD,SRDO,SRDT,SRF,SRINOUT,SRNON,SRSP,SRSRV,SRQ,SRX,SRY,X,X1,Y
 Q
PRIOR ; loop through previous movements
 S SRX=$P(VAIP(15,6),"^") D SERV D  I SRSRV,VAIP(15) G PRIOR
 .I SRSRV S SRSERV=VAIP(15,1),VAIP("D")=$P(SRSERV,"^") D IN5^VADPT Q
 S SRVADPT(9)=$E($P(SRSERV,"^"),1,12)
 Q
SERV ; find service associated with movement
 S SRSRV="" D SPEC S Y="50,51,52,53,54,55,56,57,58,59,60,61,62,63" S:Y[SRSP SRSRV=1
 Q
SPEC ; find specialty associated with movement
 K DA,DIC,DIQ,DR,SRY S DIC=45.7,DR=1,DA=SRX,DIQ="SRY",DIQ(0)="I" D EN^DIQ1 S SRSP=SRY(45.7,SRX,1,"I") I SRSP,$L(SRSP)=1 S SRSP="0"_SRSP
 Q
NACUTE ; determine if non-acute care transfer
 D SPEC S Y="05,20,21,22,25,26,27,28,29,32,33,34,35,40,70,71,72,73,74,75,76,77,79,80,81,83,84,85,86,87,88,89,90,91,92,93,98,99" S:Y[SRSP SRNON=1
 Q
MCAR S (SRD,SRF,SRQ)=0,DFN=$P(^SRF(SRTN,0),"^"),SRDO=$P(^SRF(SRTN,0),"^",9)
 F  S SRD=$O(^MCAR(690,"AC",DFN,SRD)) Q:SRD=""!(SRQ=9)  S SRF=0 F  S SRF=$O(^MCAR(690,"AC",DFN,SRD,SRF)) Q:SRF=""!(SRQ=9)  I SRF="MCAR(691.1" D
 .S SRDD=9999999.9999-SRD
 .I SRDD<SRDO S $P(^SRF(SRTN,207),"^",21)=SRDD,SRQ=9
 Q
EMPLOY ; employment status preoperatively
 S DFN=$P(^SRF(SRTN,0),"^") D OPD^VADPT S $P(^SRF(SRTN,208),"^",18)=$P(VAPD(7),"^")
 Q
ADM1 ; get information related to admission
 ; determine if admission was for observation
 ; quit if no specialty defined for admission
 S SRX=$P($G(VAIP(13,6)),"^") I SRX="" S SRSOUT=1 Q
 D SPEC S Y="18,23,24,36,41,65,94" I Y[SRSP D  Q:SRSOUT
 .S SRVADPT(14)=SRSP,SRVADPT(12)=$E($P(VAIP(13,1),"^"),1,12),SRVADPT(13)=$E($P(VAIP(17,1),"^"),1,12)
 .S I=1 F J=12:1:14 S $P(^SRF(SRTN,208.1),"^",I)=SRVADPT(J),I=I+1
 .; look for admission following discharge from observation
 .S X1=$P($G(^SRF(SRTN,.2)),"^",12),X2=2 D C^%DTC S SR48=X,SRDT=$O(^DGPM("APTT1",DFN,$P(VAIP(13,1),"^"))) I 'SRDT!(SRDT>SR48) S SRSOUT=1 Q
 .S VAIP("D")=SRDT D IN5^VADPT I 'VAIP(13) S SRSOUT=1
 S SRVADPT(7)=$E($P(VAIP(13,1),"^"),1,12),SRVADPT(8)=$E($P(VAIP(17,1),"^"),1,12),SRSAVE=$S(SRVADPT(7)<SRSDATE:SRSDATE,1:$P(VAIP(13,1),"^"))
