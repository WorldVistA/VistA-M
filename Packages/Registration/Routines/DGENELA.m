DGENELA ;ALB/CJM,KCL,Zoltan/PJR,RGL,LBD,EG,TMK,CKN,ERC,TDM,JLS,HM - Patient Eligibility API ;3/3/11 3:40pm
 ;;5.3;Registration;**121,147,232,314,451,564,631,672,659,583,653,688,841,909,972,952**;Aug 13,1993;Build 160
 ;
GET(DFN,DGELG) ;
 ;Description: Used to obtain the patient eligibility data.
 ;  The data is placed in the local DGELG array.
 ;Input:
 ;  DFN - internal entry number of a record in the PATIENT file
 ;Output:
 ;  Function Value - returns 1 on success, 0 on failure
 ;  DGELG - this is  a local array that will be used to return patient eligibility data. The array subscripts and the fields mapped to are defined below. (pass by reference)
 ;
 ;subscript             field name
 ;"DFN"                ien Patient record
 ;"ELIG","CODE"        Primary Eligibility Code
 ;"ELIG","CODE",<ien>  Patient Eligibilities
 ;"SC"                 Service Connected
 ;"SCPER"              Service Connected Percentage
 ;"EFFDT"              SC Combined Effective Date
 ;"POW"                POW Status Indicated
 ;"A&A"                Receiving A&A Benefits
 ;"HB"                 Receiving Housebound Benefits
 ;"VAPEN"              Receiving a VA Pension
 ;"VACKAMT"            Total Annual VA Check Amount
 ;"DISRET"             Military Disability Retirement
 ;"DISLOD"             Discharge Due to Disability (added with DG 672)
 ;"MEDICAID"           Medicaid
 ;"MEDASKDT"           Date Medicaid Last Asked
 ;"AO"                 Exposed to Agent Orange
 ;"IR"                 Radiation Exposure Indicated
 ;"RADEXPM"            Radiation Exposure Method
 ;"EC"                 SW Asia Cond - change from Env Con, DG*5.3*688
 ;"MTSTA"              Means Test Status
 ;P&T                  P&T
 ;P&TDT                P&T EFFECTIVE DATE (added with DG 688)
 ;POS                  PERIOD OF SERVICE
 ;UNEMPLOY             UNEMPLOYABLE
 ;SCAWDATE             SC AWARD DATE
 ;RATEINC              RATED INCOMPETENT
 ;CLAIMNUM             CLAIM NUMBER
 ;CLAIMLOC             CLAIM FOLDER LOCATION
 ;VADISAB              RECEIVING VA DISABILITY?
 ;ELIGSTA              ELIGIBILITY STATUS
 ;ELIGSTADATE          ELIGIBILITY STATUS DATE
 ;ELIGVERIF            ELIGIBILITY VERIF. METHOD
 ;ELIGVSITE            ELIGIBILITY VERIFICATION SITE
 ;ELIGENTBY            ELIGIBILITY STATUS ENTERED BY
 ;RATEDIS
 ;  <COUNT>,"RD"      RATED DISABILITY
 ;  <COUNT>,"PER"      DISABILITY %
 ;  <COUNT>,"RDSC"     SERVICE CONNECTED
 ;  <COUNT>,"RDEXT"    EXTREMITY
 ;  <COUNT>,"RDORIG"   ORIGINAL RD EFFECTIVE DATE
 ;  <COUNT>."RDCURR"   CURRENT RD EFFECTIVE DATE
 ;"VCD"               Veteran Catastrophically Disabled? (#.39)
 ;"PH"                PURPLE HEART INDICATED
 ;"AOEXPLOC"          AGENT ORANGE EXPOSURE LOCATION
 ;"CVELEDT"           COMBAT VETERAN END DATE
 ;"SHAD"              SHAD EXPOSURE
 ;"MOH"               MEDAL OF HONOR
 ;"MOHAWRDDATE"       MEDAL OF HONOR AWARD DATE
 ;"MOHSTATDATE"       MEDAL OF HONOR CHANGE DATE
 ;"MOHEXEMPDATE"      MEDAL OF HONOR COPAYMENT EXEMPTION DATE
 ;"CLE"                CAMP LEJEUNE INDICATED?
 ;"CLEDT"              CAMP LEJEUNE DATE
 ;"CLEST"              CAMP LEJEUNE CHANGE SITE
 ;"CLESOR"             CAMP LEJEUNE SOURCE
 ;"OTHTYPE"           EXPANDED MH CARE TYPE (OTH)
 ;
 K DGELG
 S DGELG=""
 Q:'$D(^DPT(DFN)) 0
 N NODE,SUBREC,COUNT,CODE,IEN
 ;
 S DGELG("DFN")=DFN
 S DGELG("VCD")=$$VCD^DGENA5(DFN)
 ;
 ;
 S NODE=$G(^DPT(DFN,.29))
 S DGELG("RATEINC")=$P(NODE,"^",12)
 ;
 S NODE=$G(^DPT(DFN,.3))
 S DGELG("SC")=$P(NODE,"^")
 S DGELG("SCPER")=$P(NODE,"^",2)
 S DGELG("P&T")=$P(NODE,"^",4)
 S DGELG("P&TDT")=$P(NODE,"^",13)
 S DGELG("UNEMPLOY")=$P(NODE,"^",5)
 S DGELG("SCAWDATE")=$P(NODE,"^",12)
 S DGELG("VADISAB")=$P(NODE,"^",11)
 S DGELG("EFFDT")=$P(NODE,"^",14)
 ;
 S NODE=$G(^DPT(DFN,.31))
 S DGELG("CLAIMNUM")=$P(NODE,"^",3)
 S DGELG("CLAIMLOC")=$P(NODE,"^",4)
 ;
 S NODE=$G(^DPT(DFN,.32))
 S DGELG("POS")=$P(NODE,"^",3)
 ;
 S NODE=$G(^DPT(DFN,.36))
 S DGELG("ELIG","CODE")=$P(NODE,"^") ;primary eligibility
 S DGELG("DISRET")=$P(NODE,"^",12)
 S DGELG("DISLOD")=$P(NODE,"^",13)
 ;
 S NODE=$G(^DPT(DFN,.38))
 S DGELG("MEDICAID")=$P(NODE,"^")
 S DGELG("MEDASKDT")=$P(NODE,"^",2) ;Date Medicaid Last Asked
 ;
 S NODE=$G(^DPT(DFN,.361))
 S DGELG("ELIGSTA")=$P(NODE,"^")
 S DGELG("ELIGSTADATE")=$P(NODE,"^",2)
 S DGELG("ELIGVERIF")=$P(NODE,"^",5)
 S DGELG("ELIGENTBY")=$P(NODE,"^",6)
 ;
 S NODE=$G(^DPT(DFN,.362))
 S DGELG("VACKAMT")=$P(NODE,"^",20)
 S DGELG("VAPEN")=$P(NODE,"^",14)
 S DGELG("A&A")=$P(NODE,"^",12)
 S DGELG("HB")=$P(NODE,"^",13)
 ;
 ;
 S NODE=$G(^DPT(DFN,.321))
 S DGELG("AO")=$P(NODE,"^",2)
 S DGELG("IR")=$P(NODE,"^",3)
 S DGELG("RADEXPM")=$P(NODE,"^",12)
 S DGELG("AOEXPLOC")=$P(NODE,"^",13)
 S DGELG("SHAD")=$P(NODE,"^",15)  ;added with DG*5.3*653
 ;
 S NODE=$G(^DPT(DFN,.322))
 S DGELG("EC")=$P(NODE,"^",13)
 ;
 S NODE=$G(^DPT(DFN,.52))
 S DGELG("POW")=$P(NODE,"^",5)
 S DGELG("CVELEDT")=$P(NODE,"^",15)
 ;
 ; Purple Heart Indicator
 S NODE=$G(^DPT(DFN,.53))
 S DGELG("PH")=$P(NODE,"^")
 ;
 ; Medal of Honor Indicator
 S NODE=$G(^DPT(DFN,.54))
 S DGELG("MOH")=$P(NODE,"^",1)
 S DGELG("MOHAWRDDATE")=$P(NODE,"^",2) ;MH AWARD DATE DG*5.3*972 HM
 S DGELG("MOHSTATDATE")=$P(NODE,"^",3) ;MH STATUS DATE DG*5.3*972 HM
 S DGELG("MOHEXEMPDATE")=$P(NODE,"^",4) ;MH COPAYMENT EXEMPTION DATE DG*5.3*972 HM
 ;
 ; Camp Lejeune Eligibility Indicator  DG*5.3*909
 S NODE=$G(^DPT(DFN,.3217))
 S DGELG("CLE")=$P(NODE,"^",1)
 S DGELG("CLEDT")=$P(NODE,"^",2)
 S DGELG("CLEST")=$P(NODE,"^",3)
 S DGELG("CLESOR")=$P(NODE,"^",4)
 ;
 ; Expanded MH care type for OTH patients DG*5.3*952
 S NODE=$G(^DPT(DFN,.55))
 S DGELG("OTHTYPE")=$P(NODE,U)
 ;
 ;means test category
 S DGELG("MTSTA")=""
 S IEN=$P($$LST^DGMTU(DFN),"^")
 I IEN S DGELG("MTSTA")=$P($G(^DGMT(408.31,IEN,0)),"^",3)
 ;
 ;get the other eligibilities multiple
 S SUBREC=0
 F  S SUBREC=$O(^DPT(DFN,"E",SUBREC)) Q:'SUBREC  D
 .S CODE=+$G(^DPT(DFN,"E",SUBREC,0))
 .;
 .;need to check the "B" x-ref, because when a code is deleted from the multiple, the kill logic is executed BEFORE the data is actually removed - but the "B" x-ref has been deleted at this point
 .I CODE,$D(^DPT(DFN,"E","B",CODE)) S DGELG("ELIG","CODE",CODE)=SUBREC
 ;
 ;rated disability multiple
 S SUBREC=0,COUNT=0
 F  S SUBREC=$O(^DPT(DFN,.372,SUBREC)) Q:'SUBREC  D
 .S NODE=$G(^DPT(DFN,.372,SUBREC,0))
 .Q:'$P(NODE,"^")
 .S COUNT=COUNT+1
 .S DGELG("RATEDIS",COUNT,"RD")=$P(NODE,"^")
 .S DGELG("RATEDIS",COUNT,"PER")=$P(NODE,"^",2)
 .S DGELG("RATEDIS",COUNT,"RDSC")=$P(NODE,"^",3)
 .S DGELG("RATEDIS",COUNT,"RDEXT")=$P(NODE,"^",4)
 .S DGELG("RATEDIS",COUNT,"RDORIG")=$P(NODE,"^",5)
 .S DGELG("RATEDIS",COUNT,"RDCURR")=$P(NODE,"^",6)
 ;
 Q 1
 ;
NATNAME(CODE) ;
 ;Description: Given an entry in file #8, Eligibility Code file,
 ;  finds the corresponding entry in file 8.1, MAS Eligibility Code file,
 ;  and returns the name
 ;Input:
 ;  CODE - pointer to file #8
 ;Output:
 ;  Function Value - name of corresponding code in file #8.1
 ;
 Q:'$G(CODE) ""
 Q $$CODENAME($P($G(^DIC(8,CODE,0)),"^",9))
 ;
NATCODE(CODE) ;
 ;Description: Given an entry in file #8, Eligibility Code file,
 ;  finds the corresponding entry in file 8.1, MAS Eligibility Code file
 ;Input:
 ;  CODE - pointer to file #8
 ;Output:
 ;  Function Value - pointer to file #8.1
 ;
 Q:'$G(CODE) ""
 Q $P($G(^DIC(8,CODE,0)),"^",9)
 ;
CODENAME(CODE) ;
 ;Description: Given a pointer to file #8.1, MAS Eligibility Code file,
 ;  it returns the name of the code 
 ;Input:
 ;  CODE - pointer to file #8.1
 ;Output:
 ;  Function Value - name of the code pointed to
 ;
 Q:'$G(CODE) ""
 Q $P($G(^DIC(8.1,CODE,0)),"^")
 ;
ELIGSTAT(DFN,DGELG) ;
 ;Description: Used to get the ELIGIBILITY STATUS and the 
 ;ELIGIBILITY STATUS DATE of the patient.
 ;
 ;Input:
 ;  DFN - ien of patient record
 ;
 ;Output:
 ;  Function Value - 1 on success, 0 on failure
 ;  DGELG array (pass by reference)
 ;    "ELIGSTA" - ELIGIBILITY STATUS
 ;    "ELIGSTADATE" - ELIGIBILITY STATUS DATE
 ;
 N NODE,SUCCESS
 D
 .S SUCCESS=1
 .I '$G(DFN) S SUCCESS=0 Q
 .S NODE=$G(^DPT(DFN,.361))
 .S DGELG("ELIGSTA")=$P(NODE,"^")
 .S DGELG("ELIGSTADATE")=$P(NODE,"^",2)
 Q SUCCESS
