ORXPAR08 ; ; Dec 17, 1997@11:35:35
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;;Dec 17, 1997
 ;;
LOAD ; load data into ^TMP (expects ROOT to be defined)
 S I=1 F  S REF=$T(DATA+I) Q:REF=""  S VAL=$T(DATA+I+1) D
 . S I=I+2,REF=$P(REF,";",3,999),VAL=$P(VAL,";",3,999)
 . S @(ROOT_REF)=VAL
 G ^ORXPAR09
DATA ; parameter data
 ;;1033,"KEY")
 ;;ORB ARCHIVE PERIOD^IMAGING RESULTS AMENDED
 ;;1033,"VAL")
 ;;30
 ;;1034,"KEY")
 ;;ORB ARCHIVE PERIOD^LAB ORDER CANCELED
 ;;1034,"VAL")
 ;;30
 ;;1036,"KEY")
 ;;ORB ARCHIVE PERIOD^MEDICATIONS EXPIRING
 ;;1036,"VAL")
 ;;30
 ;;1037,"KEY")
 ;;ORB ARCHIVE PERIOD^NEW ORDER
 ;;1037,"VAL")
 ;;30
 ;;1038,"KEY")
 ;;ORB ARCHIVE PERIOD^NEW SERVICE CONSULT/REQUEST
 ;;1038,"VAL")
 ;;30
 ;;1039,"KEY")
 ;;ORB ARCHIVE PERIOD^NPO DIET MORE THAN 72 HRS
 ;;1039,"VAL")
 ;;30
 ;;1040,"KEY")
 ;;ORB ARCHIVE PERIOD^ORDER CHECK
 ;;1040,"VAL")
 ;;30
 ;;1041,"KEY")
 ;;ORB ARCHIVE PERIOD^ORDER REQUIRES CHART SIGNATURE
 ;;1041,"VAL")
 ;;30
 ;;1042,"KEY")
 ;;ORB ARCHIVE PERIOD^ORDER REQUIRES CO-SIGNATURE
 ;;1042,"VAL")
 ;;30
 ;;1043,"KEY")
 ;;ORB ARCHIVE PERIOD^ORDER REQUIRES ELEC SIGNATURE
 ;;1043,"VAL")
 ;;30
 ;;1044,"KEY")
 ;;ORB ARCHIVE PERIOD^ORDERER-FLAGGED RESULTS
 ;;1044,"VAL")
 ;;30
 ;;1045,"KEY")
 ;;ORB ARCHIVE PERIOD^SERVICE ORDER REQ CHART SIGN
 ;;1045,"VAL")
 ;;30
 ;;1046,"KEY")
 ;;ORB ARCHIVE PERIOD^SITE-FLAGGED ORDER
 ;;1046,"VAL")
 ;;30
 ;;1047,"KEY")
 ;;ORB ARCHIVE PERIOD^SITE-FLAGGED RESULTS
 ;;1047,"VAL")
 ;;30
 ;;1048,"KEY")
 ;;ORB ARCHIVE PERIOD^STAT IMAGING REQUEST
 ;;1048,"VAL")
 ;;30
 ;;1049,"KEY")
 ;;ORB ARCHIVE PERIOD^STAT ORDER
 ;;1049,"VAL")
 ;;30
 ;;1050,"KEY")
 ;;ORB ARCHIVE PERIOD^STAT RESULTS
 ;;1050,"VAL")
 ;;30
 ;;1051,"KEY")
 ;;ORB ARCHIVE PERIOD^TRANSFER FROM PSYCHIATRY
 ;;1051,"VAL")
 ;;30
 ;;1053,"KEY")
 ;;ORB ARCHIVE PERIOD^UNSCHEDULED VISIT
 ;;1053,"VAL")
 ;;30
 ;;1055,"KEY")
 ;;ORB ARCHIVE PERIOD^UNVERIFIED MEDICATION ORDER
 ;;1055,"VAL")
 ;;30
 ;;1056,"KEY")
 ;;ORB ARCHIVE PERIOD^URGENT IMAGING REQUEST
 ;;1056,"VAL")
 ;;30
 ;;1058,"KEY")
 ;;ORB ARCHIVE PERIOD^LAB RESULTS
 ;;1058,"VAL")
 ;;30
 ;;1062,"KEY")
 ;;ORB FORWARD SUPERVISOR^LAB RESULTS
 ;;1062,"VAL")
 ;;0
 ;;1063,"KEY")
 ;;ORB FORWARD SUPERVISOR^ORDER REQUIRES CHART SIGNATURE
 ;;1063,"VAL")
 ;;0
 ;;1064,"KEY")
 ;;ORB FORWARD SUPERVISOR^FLAGGED ORDERS
 ;;1064,"VAL")
 ;;0
 ;;1066,"KEY")
 ;;ORB FORWARD SUPERVISOR^ORDER REQUIRES ELEC SIGNATURE
 ;;1066,"VAL")
 ;;0
 ;;1068,"KEY")
 ;;ORB FORWARD SUPERVISOR^ABNORMAL LAB RESULTS (ACTION)
 ;;1068,"VAL")
 ;;0
 ;;1072,"KEY")
 ;;ORB FORWARD SUPERVISOR^ADMISSION
 ;;1072,"VAL")
 ;;0
 ;;1073,"KEY")
 ;;ORB FORWARD SUPERVISOR^UNSCHEDULED VISIT
 ;;1073,"VAL")
 ;;0
 ;;1074,"KEY")
 ;;ORB FORWARD SUPERVISOR^DECEASED PATIENT
 ;;1074,"VAL")
 ;;0
 ;;1075,"KEY")
 ;;ORB FORWARD SUPERVISOR^IMAGING PATIENT EXAMINED
 ;;1075,"VAL")
 ;;0
 ;;1076,"KEY")
 ;;ORB FORWARD SUPERVISOR^IMAGING REQUEST CANCEL/HELD
 ;;1076,"VAL")
 ;;0
 ;;1077,"KEY")
 ;;ORB FORWARD SUPERVISOR^IMAGING RESULTS
 ;;1077,"VAL")
 ;;0
 ;;1078,"KEY")
 ;;ORB FORWARD SUPERVISOR^IMAGING RESULTS AMENDED
 ;;1078,"VAL")
 ;;0
 ;;1079,"KEY")
 ;;ORB FORWARD SUPERVISOR^CONSULT/REQUEST CANCEL/HOLD
 ;;1079,"VAL")
 ;;0
 ;;1080,"KEY")
 ;;ORB FORWARD SUPERVISOR^CONSULT/REQUEST RESOLUTION
 ;;1080,"VAL")
 ;;0
 ;;1081,"KEY")
 ;;ORB FORWARD SUPERVISOR^CRITICAL LAB RESULT (INFO)
 ;;1081,"VAL")
 ;;0
 ;;1082,"KEY")
 ;;ORB FORWARD SUPERVISOR^ABNORMAL IMAGING RESULTS
 ;;1082,"VAL")
 ;;0
 ;;1083,"KEY")
 ;;ORB FORWARD SUPERVISOR^NEW SERVICE CONSULT/REQUEST
 ;;1083,"VAL")
 ;;0
 ;;1084,"KEY")
 ;;ORB FORWARD SUPERVISOR^SERVICE ORDER REQ CHART SIGN
 ;;1084,"VAL")
 ;;0
 ;;1085,"KEY")
 ;;ORB FORWARD SUPERVISOR^NPO DIET MORE THAN 72 HRS
 ;;1085,"VAL")
 ;;0
 ;;1086,"KEY")
 ;;ORB FORWARD SUPERVISOR^SITE-FLAGGED ORDER
 ;;1086,"VAL")
 ;;0
 ;;1087,"KEY")
 ;;ORB FORWARD SUPERVISOR^SITE-FLAGGED RESULTS
 ;;1087,"VAL")
 ;;0
 ;;1088,"KEY")
 ;;ORB FORWARD SUPERVISOR^ORDERER-FLAGGED RESULTS
 ;;1088,"VAL")
 ;;0
 ;;1090,"KEY")
 ;;ORB FORWARD SUPERVISOR^DISCHARGE
 ;;1090,"VAL")
 ;;0
 ;;1091,"KEY")
 ;;ORB FORWARD SUPERVISOR^TRANSFER FROM PSYCHIATRY
 ;;1091,"VAL")
 ;;0
 ;;1092,"KEY")
 ;;ORB FORWARD SUPERVISOR^ORDER REQUIRES CO-SIGNATURE
 ;;1092,"VAL")
 ;;0
 ;;1094,"KEY")
 ;;ORB FORWARD SUPERVISOR^LAB ORDER CANCELED
 ;;1094,"VAL")
 ;;0
 ;;1095,"KEY")
 ;;ORB FORWARD SUPERVISOR^STAT IMAGING REQUEST
 ;;1095,"VAL")
 ;;0
 ;;1096,"KEY")
 ;;ORB FORWARD SUPERVISOR^STAT ORDER
 ;;1096,"VAL")
 ;;0
 ;;1097,"KEY")
 ;;ORB FORWARD SUPERVISOR^STAT RESULTS
 ;;1097,"VAL")
 ;;0
 ;;1098,"KEY")
 ;;ORB FORWARD SUPERVISOR^DNR EXPIRING
 ;;1098,"VAL")
 ;;0
 ;;1099,"KEY")
 ;;ORB FORWARD SUPERVISOR^FREE TEXT
 ;;1099,"VAL")
 ;;0
 ;;1100,"KEY")
 ;;ORB FORWARD SUPERVISOR^MEDICATIONS EXPIRING
 ;;1100,"VAL")
 ;;0
 ;;1101,"KEY")
 ;;ORB FORWARD SUPERVISOR^UNVERIFIED MEDICATION ORDER
 ;;1101,"VAL")
 ;;0
 ;;1102,"KEY")
 ;;ORB FORWARD SUPERVISOR^NEW ORDER
 ;;1102,"VAL")
 ;;0
 ;;1103,"KEY")
 ;;ORB FORWARD SUPERVISOR^URGENT IMAGING REQUEST
 ;;1103,"VAL")
 ;;0
 ;;1104,"KEY")
 ;;ORB FORWARD SUPERVISOR^ORDER CHECK
 ;;1104,"VAL")
 ;;0
 ;;1105,"KEY")
 ;;ORB FORWARD SUPERVISOR^FOOD/DRUG INTERACTION
 ;;1105,"VAL")
 ;;0
 ;;1106,"KEY")
 ;;ORB FORWARD SUPERVISOR^ERROR MESSAGE
 ;;1106,"VAL")
 ;;0
 ;;1109,"KEY")
 ;;ORB FORWARD SURROGATES^LAB RESULTS
 ;;1109,"VAL")
 ;;0
 ;;1110,"KEY")
 ;;ORB FORWARD SURROGATES^ORDER REQUIRES CHART SIGNATURE
 ;;1110,"VAL")
 ;;0
 ;;1111,"KEY")
 ;;ORB FORWARD SURROGATES^FLAGGED ORDERS
 ;;1111,"VAL")
 ;;0
 ;;1113,"KEY")
 ;;ORB FORWARD SURROGATES^ORDER REQUIRES ELEC SIGNATURE
 ;;1113,"VAL")
 ;;0
 ;;1115,"KEY")
 ;;ORB FORWARD SURROGATES^ABNORMAL LAB RESULTS (ACTION)
 ;;1115,"VAL")
 ;;0
 ;;1119,"KEY")
 ;;ORB FORWARD SURROGATES^ADMISSION
 ;;1119,"VAL")
 ;;0
 ;;1120,"KEY")
 ;;ORB FORWARD SURROGATES^UNSCHEDULED VISIT
 ;;1120,"VAL")
 ;;0
 ;;1121,"KEY")
 ;;ORB FORWARD SURROGATES^DECEASED PATIENT
 ;;1121,"VAL")
 ;;0
 ;;1122,"KEY")
 ;;ORB FORWARD SURROGATES^IMAGING PATIENT EXAMINED
 ;;1122,"VAL")
 ;;0
 ;;1123,"KEY")
 ;;ORB FORWARD SURROGATES^CONSULT/REQUEST RESOLUTION
 ;;1123,"VAL")
 ;;0
 ;;1124,"KEY")
 ;;ORB FORWARD SURROGATES^IMAGING RESULTS
 ;;1124,"VAL")
 ;;0
 ;;1125,"KEY")
 ;;ORB FORWARD SURROGATES^CRITICAL LAB RESULT (INFO)
 ;;1125,"VAL")
 ;;0
 ;;1126,"KEY")
 ;;ORB FORWARD SURROGATES^ABNORMAL IMAGING RESULTS
 ;;1126,"VAL")
 ;;0
 ;;1127,"KEY")
 ;;ORB FORWARD SURROGATES^IMAGING REQUEST CANCEL/HELD
 ;;1127,"VAL")
 ;;0
 ;;1128,"KEY")
 ;;ORB FORWARD SURROGATES^NEW SERVICE CONSULT/REQUEST
 ;;1128,"VAL")
 ;;0
 ;;1129,"KEY")
 ;;ORB FORWARD SURROGATES^SERVICE ORDER REQ CHART SIGN
 ;;1129,"VAL")
 ;;0
 ;;1130,"KEY")
 ;;ORB FORWARD SURROGATES^CONSULT/REQUEST CANCEL/HOLD
 ;;1130,"VAL")
 ;;0
 ;;1131,"KEY")
 ;;ORB FORWARD SURROGATES^NPO DIET MORE THAN 72 HRS
 ;;1131,"VAL")
 ;;0
 ;;1132,"KEY")
 ;;ORB FORWARD SURROGATES^SITE-FLAGGED RESULTS
 ;;1132,"VAL")
 ;;0
 ;;1133,"KEY")
 ;;ORB FORWARD SURROGATES^ORDERER-FLAGGED RESULTS
 ;;1133,"VAL")
 ;;0
 ;;1135,"KEY")
 ;;ORB FORWARD SURROGATES^DISCHARGE
