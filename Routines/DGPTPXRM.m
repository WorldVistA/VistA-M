DGPTPXRM ;SLC/PKR - Routines for Clinical Reminder index. ;09/30/2004
        ;;5.3;Registration;**478**;Aug 13, 1993
 ;===========================================================
PTF(DAS,DATA) ;Return data for a PTF entry
 N D0,TEMP
 S D0=$P(DAS,";",1)
 S TEMP=^DGPT(D0,0)
 S DATA("ADMISSION DATE")=$P(TEMP,U,2)
 S DATA("FACILITY")=$P(TEMP,U,3)
 S DATA("FEE BASIS")=$P(TEMP,U,4)
 I $D(^DGPT(D0,70)) D
 . S TEMP=$G(^DGPT(D0,70))
 . S DATA("DISCHARGE DATE")=$P(TEMP,U,1)
 . S DATA("DISCHARGE SPECIALITY")=$P(TEMP,U,2)
 . S DATA("DISCHARGE STATUS")=$P(TEMP,U,14)
 . S DATA("DISCHARGE PROVIDER")=$P(TEMP,U,15)
 I DAS["M" D
 . N D1
 . S D1=$P(DAS,";",3)
 . S TEMP=^DGPT(D0,"M",D1,0)
 . S DATA("MOVEMENT RECORD")=$P(TEMP,U,1)
 Q
 ;
