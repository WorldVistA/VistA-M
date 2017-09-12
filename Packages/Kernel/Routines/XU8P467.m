XU8P467 ; BT/OAKLAND - POST ROUTINE;8/2/07
 ;;8.0;KERNEL;**467**;Jul 10, 1995;Build 12
 Q
POST ;
 D ADD,EDIT,COMP
 S X="XU8P467A" X ^%ZOSF("DEL")
 Q
COMP ; compile template
 N X,Y,DMAX S X="XUCT01"
 S Y=$$FIND1^DIC(.4,"","MX","XUSERINQ","","","ERR")
 S DMAX=$$ROUSIZE^DILF I +Y>0 D EN^DIPZ
 Q
ADD ; Add new entries from 957-1131 
 N XUI,XUPR,XUCL,XUSP,XUX12,XUIEN,XUDATA
 F XUI=1:1:150 S XUDATA=$T(DATA+XUI^XU8P467A) Q:XUDATA=" ;;END"  D
 . S XUDATA=$P(XUDATA,";;",2) Q:XUDATA="END"
 . S XUIEN=$P(XUDATA,"^"),XUPR=$P(XUDATA,"^",2),XUCL=$P(XUDATA,"^",3),XUSP=$P(XUDATA,"^",4),XUX12=$P(XUDATA,"^",5)
 . D UPDT(XUIEN,XUPR,XUCL,XUSP,XUX12)
 F XUI=1:1:150 S XUDATA=$T(DATA+XUI) Q:XUDATA=" ;;END"  D
 . S XUDATA=$P(XUDATA,";;",2) Q:XUDATA="END"
 . S XUIEN=$P(XUDATA,"^"),XUPR=$P(XUDATA,"^",2),XUCL=$P(XUDATA,"^",3),XUSP=$P(XUDATA,"^",4),XUX12=$P(XUDATA,"^",5)
 . D UPDT(XUIEN,XUPR,XUCL,XUSP,XUX12)
 Q
EDIT ;Edit entries 954,955,956
 N FDA
 S FDA(8932.1,"954,",.01)="Hospitals",FDA(8932.1,"954,",1)="General Acute Care Hospital",FDA(8932.1,"954,",3)="a"
 D FILE^DIE("","FDA","ZZERR")
 N FDA
 S FDA(8932.1,"955,",.01)="Ambulatory Health Care Facilities",FDA(8932.1,"955,",1)="Clinic/Center"
 S FDA(8932.1,"955,",2)="VA",FDA(8932.1,"955,",3)="a"
 D FILE^DIE("","FDA","ZZERR")
 N FDA
 S FDA(8932.1,"956,",.01)="Suppliers",FDA(8932.1,"956,",1)="Department of Veterans Affairs (VA) Pharmacy",FDA(8932.1,"956,",3)="a"
 D FILE^DIE("","FDA","ZZERR")
 ;
 N FDA ; inactivate the entry #1046
 S FDA(8932.1,"1046,",3)="i",FDA(8932.1,"1046,",4)=3050401
 D FILE^DIE("","FDA","ZZERR")
 Q
UPDT(XUIEN,XUPR,XUCL,XUSP,XUX12) ; add single entry
 N FDA,FDAIEN S FDAIEN(1)=XUIEN
 S FDA(8932.1,"+1,",.01)=XUPR,FDA(8932.1,"+1,",1)=XUCL
 S FDA(8932.1,"+1,",2)=XUSP,FDA(8932.1,"+1,",3)="a"
 S FDA(8932.1,"+1,",6)=XUX12,FDA(8932.1,"+1,",90002)="N"
 D UPDATE^DIE("","FDA","FDAIEN","ERR")
 Q
DATA ; information of entries from 1076-1131
 ;;1076^Residential Treatment Facilities^Community Based Residential Treatment Facility, Mental Retardation and/or Developmental Disabilities^^320900000X
 ;;1077^Residential Treatment Facilities^Psychiatric Residential Treatment Facility^^323P00000X
 ;;1078^Residential Treatment Facilities^Residential Treatment Facility, Emotionally Disturbed Children^^322D00000X
 ;;1079^Residential Treatment Facilities^Residential Treatment Facility, Mental Retardation and/or Developmental Disabilities^^320600000X
 ;;1080^Residential Treatment Facilities^Residential Treatment Facility, Physical Disabilities^^320700000X
 ;;1081^Residential Treatment Facilities^Substance Abuse Rehabilitation Facility^^324500000X
 ;;1082^Residential Treatment Facilities^Substance Abuse Rehabilitation Facility^Substance Abuse Treatment, Children^3245S0500X
 ;;1083^Respite Care Facility^Respite Care^^385H00000X
 ;;1084^Respite Care Facility^Respite Care^Respite Care Camp^385HR2050X
 ;;1085^Respite Care Facility^Respite Care^Respite Care, Mental Illness, Child^385HR2055X
 ;;1086^Respite Care Facility^Respite Care^Respite Care, Mental Retardation and/or Developmental Disabilities^385HR2060X
 ;;1087^Respite Care Facility^Respite Care^Respite Care, Physical Disabilities, Child^385HR2065X
 ;;1088^Suppliers^Blood Bank^^331L00000X
 ;;1089^Suppliers^Durable Medical Equipment & Medical Supplies^^332B00000X
 ;;1090^Suppliers^Durable Medical Equipment & Medical Supplies^Customized Equipment^332BC3200X
 ;;1091^Suppliers^Durable Medical Equipment & Medical Supplies^Dialysis Equipment & Supplies^332BD1200X
 ;;1092^Suppliers^Durable Medical Equipment & Medical Supplies^Nursing Facility Supplies^332BN1400X
 ;;1093^Suppliers^Durable Medical Equipment & Medical Supplies^Oxygen Equipment & Supplies^332BX2000X
 ;;1094^Suppliers^Durable Medical Equipment & Medical Supplies^Parenteral & Enteral Nutrition^332BP3500X
 ;;1095^Suppliers^Emergency Response System Companies^^333300000X
 ;;1096^Suppliers^Eye Bank^^332G00000X
 ;;1097^Suppliers^Eyewear Supplier (Equipment, not the service)^^332H00000X
 ;;1098^Suppliers^Hearing Aid Equipment^^332S00000X
 ;;1099^Suppliers^Home Delivered Meals^^332U00000X
 ;;1100^Suppliers^Indian Health Service/Tribal/Urban Indian Health (I/T/U) Pharmacy^^332800000X
 ;;1101^Suppliers^Military/U.S. Coast Guard Pharmacy^^332000000X
 ;;1102^Suppliers^Non-Pharmacy Dispensing Site^^332900000X
 ;;1103^Suppliers^Organ Procurement Organization^^335U00000X
 ;;1104^Suppliers^Pharmacy^^333600000X
 ;;1105^Suppliers^Pharmacy^Clinic Pharmacy^3336C0002X
 ;;1106^Suppliers^Pharmacy^Community/Retail Pharmacy^3336C0003X
 ;;1107^Suppliers^Pharmacy^Compounding Pharmacy^3336C0004X
 ;;1108^Suppliers^Pharmacy^Home Infusion Therapy Pharmacy^3336H0001X
 ;;1109^Suppliers^Pharmacy^Institutional Pharmacy^3336I0012X
 ;;1110^Suppliers^Pharmacy^Long Term Care Pharmacy^3336L0003X
 ;;1111^Suppliers^Pharmacy^Mail Order Pharmacy^3336M0002X
 ;;1112^Suppliers^Pharmacy^Managed Care Organization Pharmacy^3336M0003X
 ;;1113^Suppliers^Pharmacy^Nuclear Pharmacy^3336N0007X
 ;;1114^Suppliers^Pharmacy^Specialty Pharmacy^3336S0011X
 ;;1115^Suppliers^Portable X-Ray Supplier^^335V00000X
 ;;1116^Suppliers^Prosthetic/Orthotic Supplier^^335E00000X
 ;;1117^Transportation Services^Ambulance^^341600000X
 ;;1118^Transportation Services^Ambulance^Air Transport^3416A0800X
 ;;1119^Transportation Services^Ambulance^Land Transport^3416L0300X
 ;;1120^Transportation Services^Ambulance^Water Transport^3416S0300X
 ;;1121^Transportation Services^Bus^^347B00000X
 ;;1122^Transportation Services^Military/U.S. Coast Guard Transport^^341800000X
 ;;1123^Transportation Services^Military/U.S. Coast Guard Transport^Military or U.S. Coast Guard Ambulance, Air Transport^3418M1120X
 ;;1124^Transportation Services^Military/U.S. Coast Guard Transport^Military or U.S. Coast Guard Ambulance, Ground Transport^3418M1110X
 ;;1125^Transportation Services^Military/U.S. Coast Guard Transport^Military or U.S. Coast Guard Ambulance, Water Transport^3418M1130X
 ;;1126^Transportation Services^Non-emergency Medical Transport (VAN)^^343900000X
 ;;1127^Transportation Services^Private Vehicle^^347C00000X
 ;;1128^Transportation Services^Secured Medical Transport (VAN)^^343800000X
 ;;1129^Transportation Services^Taxi^^344600000X
 ;;1130^Transportation Services^Train^^347D00000X
 ;;1131^Transportation Services^Transportation Broker^^347E00000X
 ;;END
