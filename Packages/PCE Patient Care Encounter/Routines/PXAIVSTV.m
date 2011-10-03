PXAIVSTV ;ISL/JVS,ISA/KWP - VALIDATE THE VISIT DATA ;4/23/04 11:54am
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**9,15,19,74,111,116,130,124,168**;Aug 12, 1996;Build 14
 ;
 ;
 Q
VALSCC ;--VALIDATE SERVICE CONNECTIVENESS
 N ERR,ERR1
 D SCC^PXUTLSCC($G(PXAA("PATIENT")),$G(PXAA("ENC D/T")),$G(PXAA("HOS LOC")),$G(PXAVISIT),$G(AFTER800),.AFTER8A,.ERR)
 ;PX*1*111 - Add HNC
 I $P(ERR,"^",1)=0,$P(ERR,"^",2)=0,$P(ERR,"^",3)=0,$P(ERR,"^",4)=0,$P(ERR,"^",5)=0,$P(ERR,"^",6)=0,$P(ERR,"^",7)=0,$P(ERR,"^",8)=0 Q
 S PXADI("DIALOG")=8390001.003
 S PXAERRF=1
 S PXAERR("1W")=$S($P(AFTER800,"^",1)']"":"NULL",1:$P(AFTER800,"^",1))
 S PXAERR("2W")=$S($P(AFTER800,"^",2)']"":"NULL",1:$P(AFTER800,"^",2))
 S PXAERR("3W")=$S($P(AFTER800,"^",3)']"":"NULL",1:$P(AFTER800,"^",3))
 S PXAERR("4W")=$S($P(AFTER800,"^",4)']"":"NULL",1:$P(AFTER800,"^",4))
 S PXAERR("5W")=$S($P(AFTER800,"^",5)']"":"NULL",1:$P(AFTER800,"^",5))
 ;PX*1*111 - Add HNC
 S PXAERR("16W")=$S($P(AFTER800,"^",6)']"":"NULL",1:$P(AFTER800,"^",6))
 S PXAERR("19W")=$S($P(AFTER800,"^",7)']"":"NULL",1:$P(AFTER800,"^",7))
 S PXAERR("22W")=$S($P(AFTER800,"^",8)']"":"NULL",1:$P(AFTER800,"^",8))
 S ERR1=$P(ERR,"^",1),PXAERR("6W")=$S(ERR1=1:"Should be a YES or NO!, not NULL",ERR1=0:"No error",ERR1=-1:"Not a valid value",ERR1=-2:"Value must be NULL",ERR1=-3:"Must be NULL because Service Connected is yes",1:"")
 S ERR1=$P(ERR,"^",2),PXAERR("7W")=$S(ERR1=1:"Should be a YES or NO!, not NULL",ERR1=0:"No error",ERR1=-1:"Not a valid value",ERR1=-2:"Value must be NULL",ERR1=-3:"Must be NULL because Service Connected is yes",1:"")
 S ERR1=$P(ERR,"^",3),PXAERR("8W")=$S(ERR1=1:"Should be a YES or NO!, not NULL",ERR1=0:"No error",ERR1=-1:"Not a valid value",ERR1=-2:"Value must be NULL",ERR1=-3:"Must be NULL because Service Connected is yes",1:"")
 S ERR1=$P(ERR,"^",4),PXAERR("9W")=$S(ERR1=1:"Should be a YES or NO!, not NULL",ERR1=0:"No error",ERR1=-1:"Not a valid value",ERR1=-2:"Value must be NULL",ERR1=-3:"Must be NULL because Service Connected is yes",1:"")
 S ERR1=$P(ERR,"^",5),PXAERR("10W")=$S(ERR1=1:"Should be a YES or NO!, not NULL",ERR1=0:"No error",ERR1=-1:"Not a valid value",ERR1=-2:"Value must be NULL",ERR1=-3:"Must be NULL because Service Connected is yes",1:"")
 ;PX*1*111 - Add HNC
 S ERR1=$P(ERR,"^",6),PXAERR("17W")=$S(ERR1=1:"Should be a YES or NO!, not NULL",ERR1=0:"No error",ERR1=-1:"Not a valid value",ERR1=-2:"Value must be NULL",ERR1=-3:"Must be NULL because Service Connected is yes",1:"")
 S ERR1=$P(ERR,"^",7),PXAERR("20W")=$S(ERR1=1:"Should be a YES or NO!, not NULL",ERR1=0:"No error",ERR1=-1:"Not a valid value",ERR1=-2:"Value must be NULL",ERR1=-3:"Must be NULL because Service Connected is yes",1:"")
 S ERR1=$P(ERR,"^",8),PXAERR("23W")=$S(ERR1=1:"Should be a YES or NO!, not NULL",ERR1=0:"No error",ERR1=-1:"Not a valid value",ERR1=-2:"Value must be NULL",ERR1=-3:"Must be NULL because Service Connected is yes",1:"")
 S PXAERR("11W")=$S($P(AFTER8A,"^",1)']"":"NULL",1:$P(AFTER8A,"^",1))
 S PXAERR("12W")=$S($P(AFTER8A,"^",2)']"":"NULL",1:$P(AFTER8A,"^",2))
 S PXAERR("13W")=$S($P(AFTER8A,"^",3)']"":"NULL",1:$P(AFTER8A,"^",3))
 S PXAERR("14W")=$S($P(AFTER8A,"^",4)']"":"NULL",1:$P(AFTER8A,"^",4))
 S PXAERR("15W")=$S($P(AFTER8A,"^",5)']"":"NULL",1:$P(AFTER8A,"^",5))
 ;PX*1*111 - Add HNC
 S PXAERR("18W")=$S($P(AFTER8A,"^",6)']"":"NULL",1:$P(AFTER8A,"^",6))
 S PXAERR("21W")=$S($P(AFTER8A,"^",7)']"":"NULL",1:$P(AFTER8A,"^",7))
 S PXAERR("24W")=$S($P(AFTER8A,"^",8)']"":"NULL",1:$P(AFTER8A,"^",8))
 D ERR^PXAI K PXAERRF
 Q
 ;
VAL ;--VALIDATE ENOUGH DATA
 ;
 ;---Is the visit sent TO US valid?
 I $G(PXAVISIT) D  Q:$D(STOP)
 .I '$D(^AUPNVSIT(PXAVISIT,0)) D  Q:$G(STOP)
 ..S STOP=1
 ..S PXAERRF=1
 ..S PXADI("DIALOG")=8390001.001
 ..S PXAERR(11)=$G(PXAVISIT)
 ..S PXAERR(12)="The value that was sent to us is not a valid visit in the VISIT file # 9000010. The Patients name will be derived from the visit file and could cause the data to be given to the wrong patient if not correct."
 ..S PXAERR(13)="If the correct VISIT isn't known, set the 'ENCOUNTER' array and we will look it up or create a correct one. Setting both at the same time will only add confusion as to what data is correct."
 Q:$G(PXAVISIT)
 ;
 ;----Missing a date and time of visit
 I $G(PXAA("ENC D/T"))']"" D  Q:$G(STOP)
 .S STOP=1 ;--USED TO STOP DO LOOP
 .S PXAERRF=1 ;--FLAG INDICATES THERE IS AN ERR
 .S PXADI("DIALOG")=8390001.001
 .S PXAERR(9)="ENC D/T"
 .S PXAERR(11)=$G(PXAA("ENC D/T"))
 .S PXAERR(12)="You are missing the date and time of the visit in FileManager internal format."
 ;
 ;----Missing Time and not Historical Visit
 I $L($G(PXAA("ENC D/T")),".")=1,$G(PXAA("SERVICE CATEGORY"))'="E" D
 .S STOP=1 ;--USED TO STOP DO LOOP
 .S PXAERRF=1 ;--FLAG INDICATES THERE IS AN ERR
 .S PXADI("DIALOG")=8390001.001
 .S PXAERR(9)="ENC D/T"
 .S PXAERR(11)=$G(PXAA("ENC D/T"))
 .S PXAERR(12)="You are missing the TIME of the visit in FileManager internal format. Unless this is an HISTORICAL encounter, you must have the time."
 ;
 ;
 ;
 ;----MISSING a pointer to PATIENT/IHS FILE # 9000001
 I $G(PXAA("PATIENT"))']"" D  Q:$G(STOP)
 .S STOP=1
 .S PXAERRF=1
 .S PXADI("DIALOG")=8390001.001
 .S PXAERR(9)="PATIENT"
 .S PXAERR(11)=$G(PXAA("PATIENT"))
 .S PXAERR(12)="Missing a pointer to the PATIENT/IHS file #9000001"
 ;
 ;
 ;----Not a pointer to the PATIENT/IHS file #9000001
 I '$D(^AUPNPAT($G(PXAA("PATIENT")),0)) D  Q:$G(STOP)
 .S STOP=1
 .S PXAERRF=1
 .S PXADI("DIALOG")=8390001.001
 .S PXAERR(9)="PATIENT"
 .S PXAERR(11)=$G(PXAA("PATIENT"))
 .S PXAERR(12)="This value is not a pointer to file PATIENT/IHS file # 9000001"
 ;
 ;---Missing required information
 I $G(PXAA("OUTSIDE LOCATION"))']"",$G(PXAA("HOS LOC"))']"",$G(PXAA("SERVICE CATEGORY"))'="E" D  Q:$G(STOP)
 .S STOP=1
 .S PXAERRF=1
 .S PXADI("DIALOG")=8390001.001
 .S PXAERR(9)="HOS LOC or OUTSIDE LOC"
 .S PXAERR(11)="BOTH ENTRIES ARE NULL AND SERVICE CATEGORY IS NOT ""E"""
 .S PXAERR(12)="The HOSPITAL LOCATION (pointer to the HOSPITAL LOCATION file #44 ) needs to be sent in order to create a visit."
 ;
 ;---not a pointer to hospital location file
 I $D(PXAA("HOS LOC")) D  Q:$G(STOP)
 .I '$D(^SC($G(PXAA("HOS LOC")),0)) D  Q:$G(STOP)
 ..S STOP=1
 ..S PXAERRF=1
 ..S PXADI("DIALOG")=8390001.001
 ..S PXAERR(9)="HOS LOC"
 ..S PXAERR(11)=$G(PXAA("HOS LOC"))
 ..S PXAERR(12)="This HOSPITAL LOCATION is not a pointer to the HOSPITAL LOCATION file #44"
 ;---hospital location is the dispositioning location
 ;Allow a dispositioning location to be used
 ;I $D(PXAA("HOS LOC")) D  Q:$G(STOP)   ;PX*1.0*116
 ;.I $D(^PX(815,1,"DHL","B",$G(PXAA("HOS LOC")))) D  Q:$G(STOP)
 ;..S STOP=1
 ;..S PXAERRF=1
 ;..S PXADI("DIALOG")=8390001.001
 ;..S PXAERR(9)="HOS LOC"
 ;..S PXAERR(11)=$G(PXAA("HOS LOC"))
 ;..S PXAERR(12)="This HOSPITAL LOCATION is a dispositioning location and connot be used. Refer to entries in file#815 PCE PARAMETERS"
 ;--Not a service category
 I '$D(PXAA("SERVICE CATEGORY")) D  Q:$G(STOP)
 .S STOP=1
 .S PXAERRF=1
 .S PXADI("DIALOG")=8390001.001
 .S PXAERR(9)="SERVICE CATEGORY"
 .S PXAERR(11)=$G(PXAA("SERVICE CATEGORY"))
 .S PXAERR(12)="SERVICE CATEGORY is a required field"
 Q
 ;
VPTR ;---Is the visit sent TO US valid?
 I $G(PXAVISIT) D  Q:$D(STOP)
 .I '$D(^AUPNVSIT(PXAVISIT,0)) D  Q:$G(STOP)
 ..S STOP=1
 ..S PXAK=1
 ..S PXAERRF=1
 ..S PXADI("DIALOG")=8390001.001
 ..S PXAERR(7)="ENCOUNTER"
 ..S PXAERR(9)="GENERAL NATURE"
 ..S PXAERR(11)=$G(PXAVISIT)
 ..S PXAERR(12)="The value that was sent to us is not a valid visit in the VISIT file # 9000010. The Patients name will be derived from the visit file and could cause the data to be given to the wrong patient if not correct."
 ..S PXAERR(13)="If the correct VISIT isn't known, set the 'ENCOUNTER' array and we will look it up or create a correct one. Setting both at the same time will only add confusion as to what data is correct."
 Q:$G(PXAVISIT)
 Q
