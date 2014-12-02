ICDRGAPI ;ALB/JAM - DRG GROUPER APIS ;05/29/12 2:39pm
 ;;18.0;DRG Grouper;**64**;Oct 20, 2000;Build 103
 ;
ICDID(FILE,ID,CODE) ; Returns value indicating if identifier exist.
 ;
 ; Input:
 ;   FILE  File to look-up for identifier (required)
 ;           80   = File #80
 ;           80.1 = File #80.1
 ;     ID  Diagnosis/Procedure code identifier (required)
 ;   CODE  DX IEN or PX IEN (required)
 ;
 ; Output: Returns an 1, 0 or -1
 ;    1  if identifier was found
 ;    0  if identifier was not found
 ;   -1  error^error message
 ;
 N ICDIDIEN,ICDGBL
 I '+$G(FILE) Q "-1^Invalid File"
 I $G(ID)="" Q "-1^Missing identifier"
 I '+$G(CODE) Q "-1^Invalid IEN"
 ;S GBL=$$ROOT^ICDEX(FILE)
 ;I "^^ICD9(^^ICD0(^"'["^"_GBL_"^" Q "-1^Invalid Global"
 S ICDGBL=$S(FILE=80:"^ICD9(",1:"^ICD0(")
 S ICDIDIEN=$$IDIEN(FILE,ID) I '+ICDIDIEN Q "-1^Invalid identifier"
 I $D(@(ICDGBL_CODE_",73,""B"","_ICDIDIEN_")")) Q 1
 Q 0
 ;
IDIEN(FILE,ID) ;get IEN for identifier
 I FILE=80 Q $O(^ICDID("B",ID,""))
 E  Q $O(^ICDIP("B",ID,""))
 Q
 ;
ICDIDS(FILE,CODE,ARY) ; Returns an array of identifiers.
 ;
 ; Input:
 ;   FILE  File to look-up for identifier (required)
 ;           80   = File #80
 ;           80.1 = File #80.1
 ;   CODE  DX IEN or PX IEN (required)
 ;    ARY  Array Name passed by reference (required)
 ;
 ; Output: Return S an 1, 0 or -1
 ;    1  if identifier was found
 ;    0  if identifier was not found
 ;   -1  error^error message
 ;
 N ICDGBL,ICDX,ICDC,ICDID,ICDGBLT,ICDGBLID
 I '+$G(FILE) Q "-1^Invalid File"
 I '+$G(CODE) Q "-1^Invalid IEN"
 S ICDGBL=$P($$ROOT^ICDEX(FILE),"(",1)
 I "^^ICD9^^ICD0^"'["^"_ICDGBL_"^" Q "-1^Invalid Global"
 S ICDGBLT=$S(FILE=80:"^ICD9",1:"^ICD0"),ICDGBLID=$S(FILE=80:"^ICDID",1:"^ICDIP")
 S ICDC=0,ICDX=0 F  S ICDX=$O(@ICDGBLT@(CODE,73,"B",ICDX)) Q:ICDX=""  S ARY($P(@ICDGBLID@(ICDX,0),U,1))=1,ICDC=ICDC+1
 Q ICDC
 ;
CHGIEN(FILE,CODE) ;
 N ICDC
 I FILE=80 S ICDC=$G(^ICD9(CODE,0)) Q:ICDC="" ""  Q $O(^ICD9("B",ICDC,""))
 I FILE=80.1 S ICDC=$G(^ICD0(CODE,0)) Q:ICDC="" ""  Q $O(^ICD0("B",ICDC,""))
 Q ""
 ;
ICDIDF(ID,ARY) ; Returns value indicating if identifier(s) exist in an array.
 ;
 ; Input:
 ;     ID  Diagnosis/Procedure code identifier(s) (required)
 ;    ARY  Array Name passed by reference (required)
 ;
 ; Output: Returns an 1, 0 or -1
 ;    1  if all identifier(s) were found in array
 ;    0  if all identifiers were not found
 ;   -1  error^error message
 ;
 N ICDI,ICDFND,ICDIDV
 I $G(ID)="" Q "-1^Missing identifier"
 I $O(ARY(""))="" Q "-1^Missing array elements"
 S ICDFND=1
 F ICDI=1:1:$L(ID,"^") D  Q:'ICDFND
 .S ICDIDV=$P(ID,"^",ICDI) Q:ICDIDV=""
 .I '$D(ARY(ICDIDV)) S ICDFND=0
 Q ICDFND
 ;
ICDIDC(FILE,ID,ARY,RESULTS) ; Returns value indicating if identifier(s) exist in a cluster.
 ;
 ; Input:
 ; FILE File to look-up for identifier (required)
 ; 82.11 = File #82.11
 ; 82.12 = File #82.12
 ; ID Diagnosis/Procedure code identifier(s) (required)
 ; ARY Array Name passed by reference (required)
 ;
 ; Output:
 ; RESULTS array subscripted by MDC and DRG (ex, RESULTS(MDC,DRG)=""
 ; Returns an 1, 0 or -1
 ; 1 if all identifier(s) were found in array
 ; 0 if all identifiers were not found
 ; -1 error^error message
 ;
 ;
 N ICDGBL,ICDIEN,ICDX,ICDDA,ICDI1,ICDI2,ICDI3,ICDI4,ICDJ,ICDDRGDX,ICDCX,ICDFND,ICDARR,ICDMDC,ICDDRG,ICDDRGDX,ICDSUB
 I '+$G(FILE) Q "-1^Invalid File"
 I $G(ID)="" Q "-1^Missing identifier"
 I $O(ARY(""))="" Q "-1^Missing array elements"
 S ICDGBL=$P($$ROOT^DILFD(FILE),"(",1)
 I "^^ICDIDP(^^ICDIDD(^"'["^"_ICDGBL_"^" Q "-1^Invalid Global"
 ;create temp array ARR subscripted by IEN
 S ICDX=0 F  S ICDX=$O(ARY(ICDX)) Q:'ICDX  S ICDCX=ARY(ICDX) I ICDCX'="" S ICDARR(ICDCX)=ICDX
 S ICDFND=0
 ;get ID from "B" x-ref
 ;S IEN=$$GET1^DIQ($S(FILE=82.11:82.1,1:82),ID,.01,"I")
 I FILE=82.11 S ICDIEN=$O(^ICDIP("B",ID,""))
 I FILE=82.12 S ICDIEN=$O(^ICDID("B",ID,""))
 ;S IEN=$$FIND1^DIC(82,"","BX",ID) Q "-1^Invalid identifier"
 ;get all the entries for the ID
 ;F S X=$O(@(GBL_CODE_",73,""B"",X)"))
 ;S DA=0 F S DA=$O(@(GBL_"""B"","_IEN_","_DA_")")) Q:'DA D I FND Q
 ;S DA=0 F S DA=$O(@(GBL_"""B"",IEN,DA)")) Q:'DA D I FND Q
 S ICDDA=0 F  S ICDDA=$O(@ICDGBL@("B",ICDIEN,ICDDA)) Q:'ICDDA  D  I ICDFND Q
 .I '$D(@ICDGBL@(ICDDA,0)) Q
 .S ICDI1=0 F  S ICDI1=$O(@ICDGBL@(ICDDA,"BL",ICDI1)) Q:'ICDI1  D   I ICDFND Q
 ..F ICDJ=1:1:5 S ICDI2=0,ICDSUB=$P("ONE/WITH1/WITH2/WITH3/WITH4/","/",ICDJ) F  S ICDI2=$O(@ICDGBL@(ICDDA,"BL",ICDI1,ICDSUB,ICDI2)) Q:'ICDI2  D
 ...S ICDCX=$G(@ICDGBL@(ICDDA,"BL",ICDI1,ICDSUB,ICDI2,0))
 ...S ICDDRGDX(ICDJ,ICDCX)=""
 ..;check if DX/PX codes are in cluster
 ..S ICDFND=$$BLKCHK()
 ..Q:'ICDFND
 ..;get MDC and DRG
 ..S ICDI3=0 F  S ICDI3=$O(@ICDGBL@(ICDDA,"BL",ICDI1,"MDC",ICDI3)) Q:'ICDI3  D
 ...S ICDMDC=$G(@ICDGBL@(ICDDA,"BL",ICDI1,"MDC",ICDI3,0))
 ...S ICDI4=0 F  S ICDI4=$O(@ICDGBL@(ICDDA,"BL",ICDI1,"MDC",ICDI3,"DRG",ICDI4)) Q:'ICDI4  D
 ....S ICDDRG=$G(@ICDGBL@(ICDDA,"BL",ICDI1,"MDC",ICDI3,"DRG",ICDI4,0))
 ....S RESULTS(ICDMDC,ICDDRG)=""
 Q ICDFND
 ;
BLKCHK() ;check if DX/PX code is in cluster
 N ICDJ,ICDX1,ICDC,ICDFND
 S (ICDFND,ICDC)=0
 S ICDJ=0 F  S ICDJ=$O(ICDDRGDX(ICDJ)) Q:'ICDJ  D
 .S ICDC=ICDC+1
 .S ICDX1=0 F  S ICDX1=$O(ICDDRGDX(ICDJ,ICDX1)) Q:'ICDX1  I $D(ICDARR(ICDX1)) S ICDFND=ICDFND+1 Q
 S ICDFND=$S('ICDC:0,ICDFND=ICDC:1,1:0)
 Q ICDFND
 ;
ISOWNCC(IEN,CDT,FMT) ; If DX is Own CC, return the CC value else zero
 ;
 ; Input:
 ;
 ;   IEN   IEN in file 80 (required)
 ;   CDT   Date to use to Extract CC (default TODAY)
 ;   FMT   Output Format
 ;           0 = CC only (default)
 ;           1 = CC ^ Effective Date
 ;
 ; Output:
 ;
 ;   $$ISOWNCC  Complication/Comorbidity (FMT=0)
 ;              Complication/Comorbidity^Effective Date (FMT=1)
 ;
 N ICDCCDAT,ICDCCIEN,ICDCCOUT,ICDCCX,ICDCCOWN
 S FMT=+($G(FMT)) S:FMT'=1 FMT=0 S:CDT="" CDT=DT S ICDCCDAT=$O(^ICD9(IEN,69,"B",CDT+.0001),-1) Q:'$L(ICDCCDAT) 0
 S ICDCCIEN=$O(^ICD9(IEN,69,"B",ICDCCDAT,""),-1)
 S ICDCCX=^ICD9(IEN,69,ICDCCIEN,0),ICDCCOWN=$P(ICDCCX,U,3) I 'ICDCCOWN Q 0
 S ICDCCOUT=$P(ICDCCX,U,2) S:FMT>0 ICDCCOUT=ICDCCOUT_"^"_$P(^ICD9(IEN,69,ICDCCIEN,0),U,1)
 Q ICDCCOUT
 ;
ICDMRG(ARY1,ARY2) ; Merge ARY2 with ARY1 and increment the counter
 ;
 N ICD10I,ICD10CNT
 S ICD10I=""
 F ICD10CNT=0:0 S ICD10I=$O(ARY2(ICD10I)) Q:ICD10I=""  D
 . I $D(ARY1(ICD10I)) S ARY1(ICD10I)=ARY1(ICD10I)+1
 . E  S ARY1(ICD10I)=1
 Q
 ;
CLUSTERS ; Load Cluster Identifier Codes into ICD10SD, ICD10OR
 N ICDIEN,ICDID,ICDX,ICD10SDT,ICD10ORT,ICDTMP,ICD10PCT,ICDIDC
 S ICDID=0 F  S ICDID=$O(^ICDIDD(ICDID)) Q:'ICDID  S ICDIEN=$G(^ICDIDD(ICDID,0)) I ICDIEN D
 . S ICDIDC=$P(^ICDID(ICDIEN,0),U,1)
 . S ICDX=$$ICDIDC^ICDRGAPI(82.12,ICDIDC,.ICDDX,.ICDTMP)
 . I $P(ICDX,U,1)>0 D
 . . S ICD10SD(ICDIDC)=$G(ICD10SD(ICDIDC))+1
 . . D LDMDDRGD ; Load DRG and Check MDC for Diagnosis Clusters
 I $D(ICDPRC) S ICDID=0 F  S ICDID=$O(^ICDIDP(ICDID)) Q:'ICDID  S ICDIEN=$G(^ICDIDP(ICDID,0)) I ICDIEN D
 . S ICDIDC=$P(^ICDIP(ICDIEN,0),U,1)
 . S ICDX=$$ICDIDC^ICDRGAPI(82.11,ICDIDC,.ICDPRC,.ICD10PCT)
 . I $P(ICDX,U,1)>0 D
 . . S ICD10OR(ICDIDC)=$G(ICD10OR(ICDIDC))+1
 . . D LDMDDRGP ; Load DRG and Check MDC for Procedure Clusters
 Q
 ;
LDMDDRGD ; Load DRG and Check MDC for Diagnosis Clusters
 N ICDMDCT,ICDDRGT
 S ICDMDCT="" F  S ICDMDCT=$O(ICDTMP(ICDMDCT)) Q:'ICDMDCT  D
 . S ICDDRGT="" F  S ICDDRGT=$O(ICDTMP(ICDMDCT,ICDDRGT)) Q:'ICDDRGT  D
 . . S ICDSDRG(ICDDRGT)=""
 Q
 ;
LDMDDRGP ; Load DRG and Check MDC for Procedure Clusters 
 N ICDMDCT,ICDDRGT
 S ICDMDCT="" F  S ICDMDCT=$O(ICD10PCT(ICDMDCT)) Q:'ICDMDCT  D
 . I (ICDMDC=ICDMDCT)!(($D(ICDMDC(12))!($D(ICDMDC(13)))>0)&$D(ICDMDC(ICDMDCT))) S ICDONR=ICDONR+1
 . S ICDDRGT="" F  S ICDDRGT=$O(ICD10PCT(ICDMDCT,ICDDRGT)) Q:'ICDDRGT  D
 . . S ICDODRG(ICDDRGT)=ICDDRGT
 Q
 ;
ICDRGCC(DRG,CDT) ;Get CC/MCC flag from DRG (Temporary hard-code of ^ICD pending API)
 N ICDCC,ICDIEN,ICDDA,ICDAIEN
 S ICDCC=-1,ICDIEN=$O(^ICD("B","DRG"_DRG,"")) I ICDIEN D
 . S ICDDA=$O(^ICD(ICDIEN,2,"B",(CDT_".1")),-1) I ICDDA D
 . . S ICDAIEN=$O(^ICD(ICDIEN,2,"B",ICDDA,"")) I ICDAIEN D
 . . . S ICDCC=$P(^ICD(ICDIEN,2,ICDAIEN,0),U,4)
 Q ICDCC
 ;
ISACCEX(IEN1,IEN2) ; Is Code 2 an Excluded code of Code 1 so MCC/CC=0
 ;
 ; Input:
 ;
 ;   IEN1   This is the internal entry number (IEN) of a
 ;          code in file 80 used as a Secondary diagnosis
 ;          with IEN2 which is the Principal diagnosis
 ;
 ; Output:
 ;
 ;   $$ISACCEX  Boolean value
 ;
 ;          1   Yes - IEN2 is an excluded PDX of IEN1 for MCC/CC
 ;          0   No  - IEN2 is NOT an excluded PDX of IEN1 for MCC/CC
 ;
 N ICD1,ICD2,ICDPDX,ICDXIEN
 S ICD1=$G(IEN1),ICD2=$G(IEN2)
 S ICDPDX=$$GET1^DIQ(80,ICD1,1.11,1) I ICDPDX="" Q 0
 S ICDXIEN=$O(^ICDCCEX("B",ICDPDX,"")) I ICDXIEN="" Q 0
 Q $S($D(^ICDCCEX(ICDXIEN,1,"B",ICD2)):1,1:0)
 ;
ICDXEXPT(DXIEN,LIST) ;
 ; Checks if the DX code indicated by the DXIEN matches any code in LIST
 ;
 ; Input:
 ;    DXIEN is IEN in file 80 Ex: ICDDX(1) in ICDDRG
 ;         LIST  is a list of DX codes in this format ^code^code^code^
 ;
 ; Output:
 ;    1     The DX Code indicated by DXIEN is present in LIST
 ;    0     The DX Code indicated by DXIEN is NOT present in LIST
 ;
 N ICDCODE
 S ICDCODE=U_$$GET1^DIQ(80,DXIEN,.01,"E")_U
 Q $S(LIST[ICDCODE:1,1:0)
 ;
