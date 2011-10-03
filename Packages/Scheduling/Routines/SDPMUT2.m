SDPMUT2 ;BPFO/JRC - Performance Monitors Utilities ; 11/3/03 3:24pm
 ;;5.3;SCHEDULING;**292,322,474**;AUGUST 13, 1993;Build 4
 ;
SCREEN(PTRENC,SCRNARR) ;Screen Outpatient Encounter
 ;Input  : PTRENC - Outpatient Encounter IEN
 ;         SCRNARR - Screening array full global reference
 ;Output : 1 = Screen encounter out
 ;         0 = Keep encounter and process
 ;
 ;Declare variables
 N PCODE,SCODE,CLINIC,NODE,Y,I,CHLD,PROV,TYPE
 S NODE=$G(^SCE(PTRENC,0))
 ;Can not be test patient
 I $$TESTPAT^VADPT($P(NODE,U,2)) Q 1
 ;Encounter must be checked out
 I '$P(NODE,U,7) Q 1
 ;Can't be child encounter
 I +$P(NODE,U,6) Q 1
 ;Screen out non-count clinics
 S CLINIC=$P($G(NODE),U,4)
 I 'CLINIC Q 1
 I $P($G(^SC(CLINIC,0)),U,17)="Y" Q 1
 ;Appointment type must be regular or service connected
 ;service connected added - SD*5.3*474
 I $P($G(NODE),U,10) S TYPE=$P($G(^SD(409.1,$P($G(NODE),U,10),0)),U,1)
 I '$D(TYPE) Q 1
 I TYPE'["REGULAR" I TYPE'["SERVICE CONNECTED" Q 1
 ;Get primary & secondary stop codes
 S PCODE=+$P(NODE,U,3)
 S CHLD=+$O(^SCE("APAR",PTRENC,0))
 S SCODE=0
 I CHLD D
 .S SCODE=+$P($G(^SCE(CHLD,0)),U,3)
 ;Check stop codes (in inclusion list and/or not in exclusion list)
 S Y=$S($O(@SCRNARR@("DSS",0)):1,$O(@SCRNARR@("DSS-PAIR",0)):1,1:0)
 I 'PCODE Q 1
 I @SCRNARR@("DSS")=1 S Y=0
 I $D(@SCRNARR@("DSS",PCODE)) S Y=0
 I $D(@SCRNARR@("DSS-EXCLUDE",PCODE))!$D(@SCRNARR@("DSS-EXCLUDE",SCODE)) S Y=1
 I Y Q 1
 ;Check division (must be in list)
 S Y=1
 S DIV=$P(NODE,U,11)
 I 'DIV Q 1
 I @SCRNARR@("DIVISION")=1 S Y=0
 I $D(@SCRNARR@("DIVISION",DIV)) S Y=0
 I Y Q 1
 ;Get primary encounter provider
 S Y=1
 S PROV=$$ENCPROV(PTRENC)
 ;Check primary encounter provider (must be in list)
 I 'PROV Q 1
 I @SCRNARR@("PROVIDERS")=1 S Y=0
 I $D(@SCRNARR@("PROVIDERS",PROV)) S Y=0
 I Y Q 1
 ;Passed all screens
 Q 0
 ;
NOTEINF(PTRENC) ;Returns performance monitor information for a given encounter
 ;Input : PTRENC - Outpatient Encounter IEN
 ;Output: Results of calling $$PM^TIUPXPM
 ;        String with 6 fields ('^' delimiter)
 ;          1  VIEN
 ;          2  Note Category (A-E)
 ;          3  Signed By (pointer to File #200)
 ;          4  Signed Date.Time (FM format)
 ;          5  Co-signed By (pointer to File #200) - defined only if necessary
 ;          6  Co-signed Date.Time - defined only if necessary    
 ;
 N VIEN
 S VIEN=$P(^SCE(PTRENC,0),U,5)
 Q $$PM^TIUPXPM(VIEN)
 ;
ENCPROV(PTRENC) ;Return primary encounter provider
 ;Input  : ENCPTR - Pointer to Outpatient Encounter
 ;Output : Pointer to New Person File
 ;Note   : 0 returned if primary encounter provider not found
 N NODE,PROV,X
 D GETPRV^SDOE(PTRENC,"NODE")
 S PROV=0
 S X=0 F  S X=+$O(NODE(X)) Q:'X  D  Q:PROV
 .I $P(NODE(X),"^",4)="P" S PROV=+NODE(X)
 Q PROV
