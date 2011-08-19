PSJBCMA3 ;BIR/JLC-ADD BCMA STATUS UPDATE TO PS(55 ;21 FEB 01
 ;;5.0; INPATIENT MEDICATIONS ;**58,91,190**;16 DEC 97;Build 12
 ;
 ;Reference to ^PS(55 is supported by DBIA 2191
 ;
EN(DFN,ON,BCID,STATUS,DATE)         ;
 I '$D(DFN)!'$D(ON)!'$D(BCID)!'$D(STATUS)!'$D(DATE) Q
 I '$D(^PS(55,DFN,"IV",ON)) Q
 N PSJBLN,UON
 D SEARCH(ON)
 I $D(PSJBLN) S UON=ON G UPDATE
 S (PON,OPON)=ON F  S PON=$P(^PS(55,DFN,"IV",PON,2),"^",5) S:PON["P" PON=$$PNDV(PON) S PON=+PON Q:'PON  Q:PON=OPON  D SEARCH(PON) Q:$D(PSJBLN)  S OPON=PON
 I $D(PSJBLN) S UON=PON G UPDATE
 Q
SEARCH(ON) S X1=0 F  S X1=$O(^PS(55,DFN,"IV",ON,"BCMA",X1)) Q:X1=""!(X1'?1.N)  I $D(^PS(55,DFN,"IVBCMA",X1)),$P(^(X1,0),"^")=BCID S PSJBLN=X1 Q
 Q
UPDATE K DA,DR,DIE S DIE="^PS(55,"_DFN_",""IVBCMA"",",DA=PSJBLN,DA(1)=DFN,DR="1////"_DATE_";2////"_STATUS
 I STATUS="" S DR="1///@;2///@"
 D ^DIE
 K DA,DR,DIE S DIE="^PS(55,"_DFN_",""IV"",",DA=UON,DA(1)=DFN,DR="144////"_STATUS_";145////"_BCID
 I STATUS="" S DR="144///@;145///@"
 D ^DIE
 Q
 ;
PNDV(PNDON) ;
 Q:PNDON'["P" ""
 N PRV S PRV=""
 F  S PRV=$P($G(^PS(53.1,+PNDON,0)),"^",25) Q:PRV=""!(PRV["V")  S PNDON=PRV
 Q $S(PRV["V":PRV,1:"")
 ;
OTPRN(SCH1) ; Determine if this order is a one-time PRN  PSJ*5*190
 N SCH2 S TYP=""
 ;actual schedule of "x PRN" exists in schedule file. Don't remove PRN from it.
 I $D(^PS(51.1,"AC","PSJ",SCH1)) D  Q $G(TYP)
 .S SCH2=$O(^PS(51.1,"AC","PSJ",SCH1,"")) Q:'$D(^PS(53.1,SCH2))
 .S TYP=$P($G(^PS(51.1,SCH2,0)),"^",5)
 S SCH1=$P(SCH1," PRN",1)
 I '$D(^PS(51.1,"AC","PSJ",SCH1)) Q ""
 S SCH2=$O(^PS(51.1,"AC","PSJ",SCH1,""))
 I '$D(^PS(51.1,SCH2)) Q ""
 Q $P($G(^PS(51.1,SCH2,0)),"^",5)
