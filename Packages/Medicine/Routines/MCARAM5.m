MCARAM5 ;WASH ISC/JKL-MUSE TRANSFER LOCAL DATA INTO DHCP ;4/24/96  09:24
 ;;2.3;Medicine;**31**;09/13/1996
 ;
 ;
EKG(MCA,MCE) ;Transfer local array data into new EKG record in DHCP
 ; USAGE: S X=$$EKG^MCARAM5(.A,.B)
 ; WHERE: A=array of local data 
 ;        B=array of DHCP data
 ;          including internal record number of EKG file
 ; if successful, returns function value of 0
 ; if unsuccessful, returns error message
 ; check for valid SSN
 N MCI,%,MCERR,Y,DIC,X,MCP
 S MCERR=$$LSSN^MCARAM6(MCA("DT"),MCA(.02),.MCP)
 I +MCERR'=55 S MCERR=$$NMCHK^MCARAM5(.MCA,.MCP) I +MCERR>50 Q MCERR
 I +MCERR=55 S MCERR=$$LNAME^MCARAM6(MCA("DT"),MCA("NAME"),.MCP) Q:+MCERR>50 "55-Social Security Number not in Patient file"  S MCERR=$$SSNCHK^MCARAM5(.MCA,.MCP) I +MCERR>50 Q MCERR
 ; if PID not a medical patient, add PID to medical patient file
 I '$D(^MCAR(690,MCP(1))) S ^MCAR(690,MCP(1),0)=MCP(1),^MCAR(690,"B",MCP(1),MCP(1))="",$P(^MCAR(690,0),U,4)=$P(^MCAR(690,0),U,4)+1 S:$P(^MCAR(690,0),U,3)<MCP(1) $P(^MCAR(690,0),U,3)=MCP(1)
 ; set confirmation status, field 11,of record
 S MCA(11)="C"
 S MCI=.02,MCA(1)=MCP(1),DIC("DR")=".02///"_MCA(.02) F  S MCI=$O(MCA(MCI)) Q:MCI=""!(MCI?1A.A)  S DIC("DR")=DIC("DR")_";"_MCI_"///"_MCA(MCI)
 ; EKG Data dictionary identified by PID of 690, PID of 690 .01 is file 2
 S DIC("DR")=$P(DIC("DR"),"1///")_"1////"_$P(DIC("DR"),"1///",2,99)
 K DD,DO N DLAYGO S DLAYGO=691.5,DIC="^MCAR(691.5,",DIC(0)="LXZ",X=MCA("DT")
 D FILE^DICN
 I +Y'>0 Q $$LOG^MCARAM7("58-ECG record not filed")
 ; set automated instrument data, field 21,of record
 S MCE("EKG")=+Y
 D NOW^%DTC S ^MCAR(691.5,MCE("EKG"),"A")=%
 Q 0
 ;
EKGDG(MCA,MCE) ; Transfer local array diagnosis data into EKG record
 ; USAGE: S X=$$EKGDG^MCARAM5(.A,.B)
 ; WHERE: A=array of diagnosis data
 ;        B=array of DHCP data
 ;          including internal record number of EKG file
 ; if successful, returns function value of 0
 ; if unsuccessful, returns error message
 N MCI,MCJ
 I '$D(^MCAR(691.5,MCE("EKG"))) Q $$LOG^MCARAM7("59-ECG record undefined-Diagnosis not filed")
 S MCERR=$$DGCK^MCARAM4(.MCA) I +MCERR>50 Q $$LOG^MCARAM7(MCERR)
 S MCI="DX,0"
 F MCJ=1:1:MCA(MCI) S MCI=$O(MCA(MCI)),^MCAR(691.5,MCE("EKG"),9,MCJ,0)=MCA(MCI)
 S ^MCAR(691.5,MCE("EKG"),9,0)=U_U_MCJ_U_MCJ
 Q 0
 ;
EKGRX(MCA,MCE) ; Transfer local array medication data into EKG record
 ; USAGE: S X=$$EKGDG^MCARAM5(.A,.B)
 ; WHERE: A=array of medication data
 ;        B=array of DHCP data
 ;          including internal record number of EKG file
 ; if successful, returns function value of 0
 ; if unsuccessful, returns error message
 N MCI
 I '$D(^MCAR(691.5,MCE("EKG"))) Q $$LOG^MCARAM7("60-ECG record undefined-Medication not filed")
 S ^MCAR(691.5,MCE("EKG"),2,0)="^691.53PA"
 S MCERR=$$RXCK^MCARAM4(.MCA) I +MCERR>0 Q $$LOG^MCARAM7(MCERR)
 S DIE="^MCAR(691.5,"_MCE("EKG")_",2,",DA(1)=MCE("EKG")
 F MCI=1:1:MCA("RX,0") S DA=MCI,DR=".01///^S X=$P(MCA(""RX,""_MCI),U);1///^S X=$P(MCA(""RX,""_MCI),U,2);2///^S X=$P(MCA(""RX,""_MCI),U,3)" D ^DIE
 S ^MCAR(691.5,MCE("EKG"),2,0)="^691.53PA^"_MCI_U_MCI
 Q 0
 ;
EKGOR(MCA,MCE) ;Transfer order entry data into EKG record
 ; USAGE: S X=$$EKGOR^MCARAM5(.A,.B)
 ; WHERE: A=array of local data
 ;          including print name for ECG procedure/subspecialty
 ;        B=array of DHCP data 
 ;          including internal record number of EKG file
 ; if successful, returns function value of 0
 ; if unsuccessful, returns error message
 Q 0
NMCHK(MCA,MCP) ;Check name input against patient data
 ; Marquette allows 16 chars for last name and 10 chars for first etc.
 ; USAGE: S X=$$NMCHK^MCARAM5(.MCA,.MCP)
 ; WHERE: MCA=array of local data
 ;        MCP=array of DHCP patient data
 ; if successful, returns function value of 0
 ; if unsuccessful, returns error message
 N MCI,MCERR S MCERR=0
 S MCP("LNAME")=$P(MCP("NAME"),","),MCA("LNAME")=$P(MCA("NAME"),",")
 F MCI=1:1:$L(MCP("LNAME")) Q:$L(MCP("LNAME"))>16  I $E(MCA("LNAME"),MCI,MCI)'=$E(MCP("LNAME"),MCI,MCI) S MCERR="56-Name does not match Patient file" Q
 Q MCERR
 ;
SSNCHK(MCA,MCP) ;Check SSN input
 ; USAGE: S X=$$SSNCHK^MCARAM5(.MCA,.MCP)
 ; WHERE: MCA=array of local data
 ;        MCP=array of DHCP patient data
 ; if successful, returns function value of 0
 ; if unsuccessful, returns error message
 N MCI,MCERR S MCERR=0
 S MCP("SSN")=$P(^DPT(MCP(1),0),"^",9)
 I $E(MCA(.02),1,8)'=$E(MCP("SSN"),1,8) S MCERR="55-Social Security Number not in Patient file"
 Q MCERR
