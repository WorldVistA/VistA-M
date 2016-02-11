SRONRPT4 ;BIR/SJA - NURSE INTRAOP REPORT ;04/27/2015
 ;;3.0;Surgery;**184**;24 Jun 93;Build 35
 ;** NOTICE: This routine is part of an implementation of a nationally
 ;**         controlled procedure.  Local modifications to this routine
 ;**         are prohibited.
 ;
LASER ;
 S SRLF=1,SRLINE="Laser Performed: "
 I $O(^SRF(SRTN,44,0)) S SRLINE="Laser Unit(s): " D LINE(1) S @SRG@(SRI)=SRLINE D LAS129 Q
 I '$O(^SRF(SRTN,56,0)),SRALL D LINE(1) S @SRG@(SRI)=SRLINE_"N/A" Q
 I $O(^SRF(SRTN,56,0)) D LINE(1) S @SRG@(SRI)=SRLINE D LAS135
 Q
LAS129 ; laser units
 N C,DUR,ID,LAS,OP,PE,SRCT,WAT,X,Y
 S LAS=0 F  S LAS=$O(^SRF(SRTN,44,LAS)) Q:'LAS  D
 .S X=^SRF(SRTN,44,LAS,0),ID=$P(X,"^"),DUR=$P(X,"^",2),WAT=$P(X,"^",3),OP=$P(X,"^",4),PE=$P(X,"^",5)
 .D LINE(1) S @SRG@(SRI)="  "_ID,@SRG@(SRI)=@SRG@(SRI)_$$SPACE(40)_"Duration: "_$S(DUR'="":DUR_" min.",1:"N/A")
 .D LINE(1) S @SRG@(SRI)="    Wattage: "_$S(WAT'="":WAT,1:"N/A"),@SRG@(SRI)=@SRG@(SRI)_$$SPACE(40)_"Plume Evacuator: "_$S(PE="Y":"YES",PE="N":"NO",1:"N/A")
 .S Y=OP,C=$P(^DD(130.0129,3,0),"^",2) D:Y Y^DIQ S:Y="" Y="N/A" D LINE(1) S @SRG@(SRI)="    Operator: "_Y
 .S (SRCT,SRLINE)=0 F  S SRLINE=$O(^SRF(SRTN,44,LAS,1,SRLINE)) Q:'SRLINE  S SRCT=SRCT+1
 .Q:'SRCT  D LINE(1) S SRLINE=0,SRL=4,SRLINE=$O(^SRF(SRTN,44,LAS,1,SRLINE)),X=^SRF(SRTN,44,LAS,1,SRLINE,0)
 .I SRCT=1,$L(X)<67 S @SRG@(SRI)="    Comments: "_X Q
 .S @SRG@(SRI)="    Comments:" D COMM^SRONRPT3(X,SRL)
 .F  S SRLINE=$O(^SRF(SRTN,44,LAS,1,SRLINE)) Q:'SRLINE  S X=^SRF(SRTN,44,LAS,1,SRLINE,0) D COMM^SRONRPT3(X,SRL)
 Q
LAS135 ; laser Performed
 N C,DUR,DUR,ID,II,III,LAS,LAON,LASOFF,OP,PE,PATPREC,PERPREC,SRCT,TYPE,START,END,FIRE,LDS,PM,POWER,INTVL,JOULES,WATTSD,WAVE,PULSE,EJOULES,WAT,X,Y
 S LAS=0 F  S LAS=$O(^SRF(SRTN,56,LAS)) Q:'LAS  D
 .S X=$G(^SRF(SRTN,56,LAS,0)),ID=$P(X,"^")
 .S XX=$P(X,"^",2),TYPE=$S(XX=1:"HOLMIUM-YAG",XX=2:"NEODYMIUM-(NG-YAG)",XX=3:"CO2",XX=4:"KTP",XX=5:"EYE DIODE GREEN (532 NM)",XX=6:"EYE DIODE",1:"")
 .S START=$P(X,"^",3),END=$P(X,"^",4),FIRE=$P(X,"^",5)
 .S XX=$P(X,"^",6),LDS=$S(XX=1:"ENDOSCOPE",XX=2:"HAND PIECE",XX=3:"HEAD PIECE",XX=4:"LAPARASCOPE",XX=5:"LASER FIBER",XX=6:"MICROSCOPE",1:"")
 .S XX=$P(X,"^",7),PM=$S(XX=1:"CONTINUOUS",XX=2:"REPEAT PULSE",XX=3:"SINGLE PULSE",1:"")
 .S POWER=$P(X,"^",8),INTVL=$P(X,"^",9),JOULES=$P(X,"^",10),WATTSD=$P(X,"^",11),WAVE=$P(X,"^",12),PULSE=$P(X,"^",13),EJOULES=$P(X,"^",14),DUR=$P(X,"^",15)
 .S LAON=$P(X,"^",17),LASOFF=$P(X,"^",18),PERPREC=$P(X,"^",19)
 .D LINE(1) S @SRG@(SRI)="  "_ID,@SRG@(SRI)=@SRG@(SRI)_$$SPACE(40)_"Laser Type: "_$S(TYPE'="":TYPE,1:"N/A")
 .S Y=START I Y D D^DIQ S START=$P(Y,"@")_"  "_$P(Y,"@",2),Y=END I Y D D^DIQ S END=$P(Y,"@")_"  "_$P(Y,"@",2)
 .D LINE(1) S @SRG@(SRI)="    Laser Start Time: "_$S(START'="":START,1:"N/A"),@SRG@(SRI)=@SRG@(SRI)_$$SPACE(40)_"Laser End Date: "_$S(END'="":END,1:"N/A")
 .D LINE(1) S @SRG@(SRI)="    Laser Test Fire: "_$S(FIRE'="":FIRE,1:"N/A"),@SRG@(SRI)=@SRG@(SRI)_$$SPACE(40)_"Laser Delivery System: "_$S(LDS'="":LDS,1:"N/A")
 .D LINE(1) S @SRG@(SRI)="    Pulse Mode: "_$S(PM'="":PM,1:"N/A"),@SRG@(SRI)=@SRG@(SRI)_$$SPACE(40)_"Power/Average Power: "_$S(POWER'="":POWER,1:"N/A")
 .D LINE(1) S @SRG@(SRI)="    Interval/Repetition Rate: "_$S(INTVL'="":INTVL,1:"N/A"),@SRG@(SRI)=@SRG@(SRI)_$$SPACE(40)_"Total Joules Delivered: "_$S(JOULES'="":JOULES,1:"N/A")
 .D LINE(1) S @SRG@(SRI)="    Watts Delivered: "_$S(WATTSD'="":WATTSD,1:"N/A"),@SRG@(SRI)=@SRG@(SRI)_$$SPACE(40)_"Wave Form: "_$S(WAVE'="":WAVE,1:"N/A")
 .D LINE(1) S @SRG@(SRI)="    Pulse Width: "_$S(PULSE'="":PULSE,1:"N/A"),@SRG@(SRI)=@SRG@(SRI)_$$SPACE(40)_"Energy Joules: "_$S(EJOULES'="":EJOULES,1:"N/A")
 .D LINE(1) S @SRG@(SRI)="    Duration: "_$S(DUR'="":DUR_" min.",1:"N/A")
 .D LINE(1) S @SRG@(SRI)="    Laser On Standby: "_$S(LAON'="":LAON,1:"N/A"),@SRG@(SRI)=@SRG@(SRI)_$$SPACE(40)_"Laser Off and Key Secured : "_$S(LASOFF'="":LASOFF,1:"N/A")
 .I '$O(^SRF(SRTN,56,LAS,1,0)) D LINE(1) S @SRG@(SRI)="    Patient Precautions: N/A",@SRG@(SRI)=@SRG@(SRI)
 .S (II,III)=0
 .F  S II=$O(^SRF(SRTN,56,LAS,1,II)) Q:'II  S XX=$G(^SRF(SRTN,56,LAS,1,II,0)),PATPREC=$S(XX=1:"EYE PADS",XX=2:"TAPE",XX=3:"SAFETY GLASSES/GOOGLES",XX=4:"LASER ET TUBE",XX=5:"MOIST DRAPES",XX=6:"WATER AVAILABLE",XX=7:"RECTAL PACK",1:"") D
 ..S III=III+1 D LINE(1) S @SRG@(SRI)=$S(III=1:"    Patient Precautions: ",1:"                         ")_$S(PATPREC'="":PATPREC,1:"N/A"),@SRG@(SRI)=@SRG@(SRI)
 .I '$O(^SRF(SRTN,56,LAS,2,0)) D LINE(1) S @SRG@(SRI)="    Personnel Precautions: N/A",@SRG@(SRI)=@SRG@(SRI)
 .S (II,III)=0
 .F  S II=$O(^SRF(SRTN,56,LAS,2,II)) Q:'II  D
 ..S XX=$G(^SRF(SRTN,56,LAS,2,II,0)),PERPREC=$S(XX=1:"EYE SAFETY FILTER (MICROSCOPE)",XX=2:"HIGH FILTRATION MASKS",XX=3:"SAFETY GLASSES INSPECTED",XX=4:"SAFETY GLASSES USED",XX=5:"SIGNAGE ON DOORS WITH APPROPRIATE WAVE LENGTH",1:"") D
 ...S III=III+1 D LINE(1) S @SRG@(SRI)=$S(III=1:"    Personnel Precautions: ",1:"                           ")_$S(PERPREC'="":PERPREC,1:"N/A")
 Q
ORGDNR N II,ORG,SRDONR1,SRDONR2,VER1 S ORG="",VER1=$G(^SRF(SRTN,"VER1"))
 S SRDONR1=$$VER1^SRTOVRF(SRTN),SRDONR2=$$VER2^SRTOVRF(SRTN)
 I 'SRDONR1&'SRDONR2 Q
 S SRLF=1,SRLINE="Transplant Information: " D LINE(1) S @SRG@(SRI)=SRLINE
 S II=0 F  S II=$O(^SRF(SRTN,63,"B",II)) Q:'II  S ORG=ORG_"-  "_$S(II=1:"HEART",II=2:"LUNG",II=3:"KIDNEY",II=4:"LIVER",II=5:"PANCREAS",II=6:"INTESTINE",II=7:"OTHER",1:"")
 S ORG=$S($L(ORG):ORG,1:"* NOT ENTERED *") D LINE(1) S @SRG@(SRI)="      Organ to be Transplanted: "_ORG
 D LINE(1) S @SRG@(SRI)="      UNOS Identification Number of Donor: "_$P(VER1,"^",2)
 D LINE(1) S @SRG@(SRI)="      Donor Serology Hepatitis C virus (HCV): "_$$OUT($P(VER1,U,3))
 D LINE(1) S @SRG@(SRI)="      Donor Serology Hepatitis B Virus (HBV): "_$$OUT($P(VER1,U,4))
 D LINE(1) S @SRG@(SRI)="      Donor Serology Cytomegalovirus (CMV): "_$$OUT($P(VER1,U,5))
 D LINE(1) S @SRG@(SRI)="      Donor Serology HIV: "_$$OUT($P(VER1,U,6))
 D LINE(1) S @SRG@(SRI)="      Donor ABO Type: "_$$ABO($P(VER1,U,7))
 D LINE(1) S @SRG@(SRI)="      Recipient ABO Type: "_$$ABO($P(VER1,U,8))
 D LINE(1) S @SRG@(SRI)="      Blood Bank Verification of ABO Type: "_$$OUT($P(VER1,U,9))
 D LINE(1) S @SRG@(SRI)="      Blood Bank ABO Verification Comments: "_$P(VER1,U,18)
 S Y=$P(VER1,U,19) I Y D D^DIQ S SRTIME=$P(Y,"@")_"  "_$P(Y,"@",2)
 S:Y="" SRTIME="* NOT ENTERED *" D LINE(1) S @SRG@(SRI)="      Date/Time of Blood Bank ABO Verification: "_SRTIME
 D LINE(1) S @SRG@(SRI)="      OR Verification of ABO Type: "_$$OUT($P(VER1,U,10))
 D LINE(1) S @SRG@(SRI)="      OR ABO Verification Comments: "_$P(VER1,U,20)
 S Y=$P(VER1,U,21) I Y D D^DIQ S SRTIME=$P(Y,"@")_"  "_$P(Y,"@",2)
 S:Y="" SRTIME="* NOT ENTERED *" D LINE(1) S @SRG@(SRI)="      Date/Time OR ABO Verification: "_SRTIME
 D LINE(1) S @SRG@(SRI)="      Surgeon Performing UNET Verification: "_$$VA($P(VER1,U,11))
 D LINE(1) S @SRG@(SRI)="      UNET Verification by Surgeon: "_$$OUT($P(VER1,U,22))
 D LINE(1) S @SRG@(SRI)="      Organ Verification Prior to Anesthesia: "_$$OUT($P(VER1,U,12))
 D LINE(1) S @SRG@(SRI)="      Surgeon Verifying Organ Prior to Anesthesia: "_$$VA($P(VER1,U,23))
 D LINE(1) S @SRG@(SRI)="      Surgeon Verifying Organ Prior to Donor Anesthesia: "_$$VA($P(VER1,U,13))
 D LINE(1) S @SRG@(SRI)="      Donor Organ Verification Prior to Anesthesia: "_$$OUT($P(VER1,U,24))
 D LINE(1) S @SRG@(SRI)="      Organ Verification Prior to Transplant: "_$$OUT($P(VER1,U,14))
 D LINE(1) S @SRG@(SRI)="      Surgeon Verifying the Organ Prior to Transplant: "_$$VA($P(VER1,U,25))
 D LINE(1) S @SRG@(SRI)="      Donor Vessel Usage: "_$$OUT($P(VER1,U,15))
 S Y=$P(VER1,U,16) D LINE(1) S @SRG@(SRI)="      Donor Vessel Disposition if not used: "_$S(Y="N":"NO DONOR VESSELS RECEIVED",Y="D":"DISCARDED",Y="R":"RETURNED TO OPO",Y="S":"STORED",1:"")
 S ORG="",II="" F  S II=$O(^SRF(SRTN,57,"B",II)) Q:II=""  S ORG=ORG_"-  "_II
 D LINE(1) S @SRG@(SRI)="      Donor Vessel UNOS ID: "_ORG
 Q
SPACE(NUM) ; create spaces
 ;pass in position returns number of needed spaces
 I '$D(@SRG@(SRI)) S @SRG@(SRI)=""
 Q $J("",NUM-$L(@SRG@(SRI)))
LINE(NUM) ; create carriage returns
 I $G(SRLF) S NUM=NUM+1,SRLF=0
 F J=1:1:NUM S SRI=SRI+1,@SRG@(SRI)=""
 Q
OUT(VAL) ;
 Q $S(VAL="Y":"YES",VAL="N":"NO",VAL="NA":"NOT APPLICABLE",1:"* NOT ENTERED *")
 ;
ABO(VAL) ; ABO type
 Q $S(VAL=1:"A RH(+)",VAL=2:"A RH(-)",VAL=3:"B RH(+)",VAL=4:"B RH(-)",VAL=5:"AB RH(+)",VAL=6:"AB RH(-)",VAL=7:"O RH(+)",VAL=8:"O RH(-)",1:"* NOT ENTERED *")
 ;
VA(VAL) ;
 I VAL="" Q "* NOT ENTERED *"
 Q $P($G(^VA(200,VAL,0)),"^")
 ;
