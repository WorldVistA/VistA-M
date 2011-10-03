SROESHL ;BIR/ADM - E-SIG HL7 UTILITY ; [ 02/06/01  9:28 AM ]
 ;;3.0; Surgery ;**100**;24 Jun 93
 ;
 ;** NOTICE: This routine is part of an implementation of a nationally
 ;**         controlled procedure.  Local modifications to this routine
 ;**         are prohibited.
 ;
 N SRESARF,SRESNRF S SRESQ=0 I $G(SRESAR) D  Q:SRESQ
 .S SRESARF="58,57,21,111,61,15,14,60,54,29,20,69,22,75,68,92,63,62,52,51,53,47,50,45,42,115,96,18,55,19,40,39,49,43,44,23,65,64"
 .I SRESARF[IEN D XTMP S SRESQ=1
 I $G(SRESNR) D
 .S SRESNRF="58,57,54,20,114,22,31,52,51,53,47,50,115,18,55,40,39,34,113,13,49,7,8,10,12,17,33,36,23,35,37"
 .I SRESNRF[IEN D XTMP S SRESQ=1
 Q
XTMP ; store info for alert in ^XTMP
 S SRESCNT=SRESCNT+1 I SRESCNT=1 S XQAID="SRESHL_"_CASE,XQAKILL=0 D DELETEA^XQALERT K ^XTMP("SRESHL_"_CASE)
 I '$D(^XTMP("SRESHL_"_CASE,0)) D
 .N X,X1,X2 S X1=DT,X2=14 D C^%DTC S ^XTMP("SRESHL_"_CASE,0)=X_"^"_DT_"^Surgery HL7 Transmission Alert"
 .S ^XTMP("SRESHL_"_CASE,1,1)="The following data elements are contained on an electronically signed report"
 .S ^XTMP("SRESHL_"_CASE,1,2)="and cannot be uploaded to the surgical record in VistA.  These data elements"
 .S ^XTMP("SRESHL_"_CASE,1,3)="must be entered manually and will require that an addendum be made to the"
 .S ^XTMP("SRESHL_"_CASE,1,4)="signed report.",^XTMP("SRESHL_"_CASE,1,5)=""
 .N DFN S DFN=$P(^SRF(CASE,0),"^") D DEM^VADPT
 .S ^XTMP("SRESHL_"_CASE,1,6)="Patient: "_VADM(1)_" ("_VA("PID")_") - Case #"_CASE,^XTMP("SRESHL_"_CASE,1,7)=""
 S SRESFLD=$P(^SRO(133.2,IEN,0),"^"),SRESVAL=$$VALUE^SRHLUI(IEN)
 S ^XTMP("SRESHL_"_CASE,2,IEN)=" "_SRESFLD_" : "_SRESVAL
ALERT ; send alert to prin. anesthetist and anes. supervisor
 Q:'$O(^XTMP("SRESHL_"_CASE,0))  N X,Y,Z
 S XQAID="SRESHL_"_CASE,XQAKILL=0 D DELETEA^XQALERT
 S Z=$G(^SRF(CASE,.3)),X=$P(Z,"^"),Y=$P(Z,"^",4) Q:X=""&(Y="")
 S:X XQA(X)="" S:Y XQA(Y)="" S XQAMSG="Cannot upload Surgery data on signed report."
 S XQAROU="ACTION^SROESHL",XQAID="SRESHL_"_CASE D SETUP^XQALERT
 Q
ACTION ; alert action
 N SRID S SRID=$P(XQAID,";") Q:'$O(^XTMP(SRID,0))
 W @IOF
 D EN^DDIOL("","^XTMP(SRID,1)")
 D EN^DDIOL("","^XTMP(SRID,2)")
 Q
