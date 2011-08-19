ORQQPL ; slc/CLA/REV - Functions which return patient problem list data ;12/15/97  [ 23-APR-1999 11:02:10 ]
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**9,10,85,173**;Dec 17, 1997
LIST(ORPY,DFN,STATUS)  ;return pt's problem list in format: ien^description^
 ; ICD^onset^last modified^SC^SpExp
 ; STATUS = status of problems to return: (A)CTIVE, (I)NACTIVE, ("")ALL 
 Q:'DFN
 N ORGMPL,I,DETAIL,ORICD186
 S ORICD186=$$PATCH^XPDUTL("ICD*18.0*6")
 I $L($T(LIST^GMPLUTL2))>0 D
 .D LIST^GMPLUTL2(.ORGMPL,DFN,STATUS)
 .Q:'$D(ORGMPL(0))
 .S DETAIL=$$DETAIL^ORWCV1(10)
 .F I=1:1:ORGMPL(0) D
 ..S X=ORGMPL(I),ORPY(I)=$P(X,U)_U_$P(X,U,3)_U_$P(X,U,2)_U_$P(X,U,4)_U_$P(X,U,5)_U_$P(X,U,6)_U_$P(X,U,7)_U_$P(X,U,8)_U_$P(X,U,10)_U_$P(X,U,9)_U_U_DETAIL
 ..I +ORICD186,'+$$STATCHK^ICDAPIU($P(ORPY(I),U,4),DT) D
 ...S $P(ORPY(I),U,13)="#",$P(ORPY(I),U,9)="#"
 .S:+$G(ORPY(1))<1 ORPY(1)="^No problems found."
 I $L($T(LIST^GMPLUTL2))<1 S ORPY(1)="^Problem list not available.^"
 K X
 Q
DETAIL(Y,DFN,PROBIEN,ID)  ; RETURN DETAILED PROBLEM DATA
 N ORGMPL,GMPDT
 I $L($T(DETAIL^GMPLUTL2))>0 D
 .D DETAIL^GMPLUTL2(PROBIEN,.ORGMPL)
 .N CR,I,J S CR=$CHAR(13),I=1
 .S Y(I)=ORGMPL("NARRATIVE")_" ("_ORGMPL("DIAGNOSIS")_")",I=I+1
 .I $$PATCH^XPDUTL("ICD*18.0*6"),'+$$STATCHK^ICDAPIU(ORGMPL("DIAGNOSIS"),DT) D
 ..S Y(I)="*** The ICD code "_ORGMPL("DIAGNOSIS")_" is currently inactive. ***",I=I+1
 .S Y(I)=" ",I=I+1
 .S Y(I)="   Onset: "_ORGMPL("ONSET"),I=I+1
 .S Y(I)="  Status: "_ORGMPL("STATUS")
 .S Y(I)=Y(I)_$S(ORGMPL("PRIORITY")="ACUTE":"/ACUTE",ORGMPL("PRIORITY")="CHRONIC":"/CHRONIC",1:""),I=I+1
 .S Y(I)=" SC Cond: "_ORGMPL("SC"),I=I+1
 .S Y(I)="Exposure: "_$S($G(ORGMPL("EXPOSURE"))>0:ORGMPL("EXPOSURE",1),1:"None"),I=I+1
 .I $G(ORGMPL("EXPOSURE"))>1 F J=2:1:ORGMPL("EXPOSURE")  D
 ..S Y(I)="          "_ORGMPL("EXPOSURE",J),I=I+1
 .S Y(I)=" ",I=I+1
 .S Y(I)="Provider: "_ORGMPL("PROVIDER"),I=I+1
 .S Y(I)="  Clinic: "_ORGMPL("CLINIC"),I=I+1
 .S Y(I)=" ",I=I+1
 .S Y(I)="Recorded: "_$P(ORGMPL("RECORDED"),U)_", by "_$P(ORGMPL("RECORDED"),U,2),I=I+1
 .S Y(I)=" Entered: "_$P(ORGMPL("ENTERED"),U)_", by "_$P(ORGMPL("ENTERED"),U,2),I=I+1
 .S Y(I)=" Updated: "_ORGMPL("MODIFIED"),I=I+1
 .S Y(I)=" ",I=I+1
 .;S Y(I)=" Comment: "_$S($G(ORGMPL("COMMENT"))>0:ORGMPL("COMMENT"),1:"")
 .I $G(ORGMPL("COMMENT"))>0 D
 ..S Y(I)="----------- Comments -----------",I=I+1
 ..;F J=ORGMPL("COMMENT"):-1:1  D
 ..;.S Y(I)=ORGMPL("COMMENT",J)
 ..;.S Y(I)=$P(Y(I),U)_" by "_$P(Y(I),U,2)_": "_$P(Y(I),U,3),I=I+1
 ..F J=1:1:ORGMPL("COMMENT")  D
 ...S Y(I)=ORGMPL("COMMENT",J)
 ...S Y(I)=$P(Y(I),U)_" by "_$P(Y(I),U,2)_": "_$P(Y(I),U,3),I=I+1
 .S Y(I)=" ",I=I+1
 .D HIST^ORQQPL2(.GMPDT,PROBIEN)
 .I $G(GMPDT(0))>0 D
 ..S Y(I)="----------- Audit History -----------",I=I+1
 ..F J=1:1:GMPDT(0)  S Y(I)=$P(GMPDT(J),U)_":  "_$P(GMPDT(J),U,2),I=I+1
 I $L($T(DETAIL^GMPLUTL2))<1 S Y(1)="Problem list not available."
 Q
HASPROB(ORDFN,ORPROB) ;extrinsic function returns 1^problem text;ICD9 if
 ;pt has an active problem which contains any piece of ORPROB
 ;ORDFN   patient DFN
 ;ORPROB  problems to check vs. active prob list in format: PROB1TEXT;PROB1ICD^PROB2TEXT;PROB2ICD^PROB3...
 ;if ICD includes "." an exact match will be sought
 ;if not, a match of general ICD category will be sought
 ;Note: All ICD codes passed must be preceded with ";"
 Q:+$G(ORDFN)<1 "0^Patient not identified."
 Q:'$L($G(ORPROB)) "0^Problem not identified."
 N ORQAPL,ORQY,ORI,ORJ,ORCNT,ORQPL,ORQICD,ORQRSLT
 D LIST(.ORQY,ORDFN,"A")
 Q:$P(ORQY(1),U)="" "0^No active problems found."
 S ORQRSLT="0^No matching problems found."
 S ORCNT=$L(ORPROB,U)
 S ORI=0 F  S ORI=$O(ORQY(ORI)) Q:ORI<1  D
 .S ORQAPL=ORQY(ORI)
 .F ORJ=1:1:ORCNT D
 ..S ORQPL=$P($P(ORPROB,U,ORJ),";"),ORQICD=$P($P(ORPROB,U,ORJ),";",2)
 ..;if problem text and pt's problem contains problem text passed:
 ..I $L(ORQPL),($P(ORQAPL,U,2)[ORQPL) D
 ...S ORQRSLT="1^"_$P(ORQAPL,U,2)_";"_$P(ORQAPL,U,4)
 ..;
 ..;if specific ICD (contains ".") and pt's ICD equals ICD passed:
 ..I $L(ORQICD),(ORQICD["."),($P(ORQAPL,U,4)=ORQICD) D
 ...S ORQRSLT="1^"_$P(ORQAPL,U,2)_";"_$P(ORQAPL,U,4)
 ..;
 ..;if non-specific ICD and pt's ICD category equals ICD category passed:
 ..I $L(ORQICD),(ORQICD'["."),($P($P(ORQAPL,U,4),".")=ORQICD) D
 ...S ORQRSLT="1^"_$P(ORQAPL,U,2)_";"_$P(ORQAPL,U,4)
 Q ORQRSLT
