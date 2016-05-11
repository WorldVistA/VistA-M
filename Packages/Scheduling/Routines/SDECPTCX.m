SDECPTCX ;ALB/SAT - VISTA SCHEDULING RPCS ;JAN 15, 2016
 ;;5.3;Scheduling;**627**;Aug 13, 1993;Build 249
 ;
 Q
 ;
 ;=================================================================
 ; Selects patient & returns key information
 ;  1    2   3   4    5      6    7    8      9       10     11  12 13  14  15  16     17     18      19
 ; NAME^SEX^DOB^SSN^LOCIEN^LOCNM^RMBD^VET^SENSITIVE^ADMITTED^HRN^SC^SC%^ICN^DOD^TS^PRIMTEAM^PRIMPRV^ATTND
PTINFO(DATA,DFN,SLCT) ;
 N X,CA,WL,RB,TS,DOD,AT,VT,VAEL,VAERR,VDT,LINE
 K ^TMP("ORWPCE",$J)
 Q:'$D(^DPT(+DFN,0))
 S X=^DPT(DFN,0),WL=$P($G(^(.1)),U),RB=$P($G(^(.101)),U),CA=+$G(^(.105)),TS=+$G(^(.103)),DOD=+$G(^(.35)),AT=+$G(^(.1041)),VT=$G(^("VET"))
 S DATA=$P(X,U,1,3)_U_$$FMTSSN($P(X,U,9))_U_U_WL_U_RB
 S:$L(WL) $P(DATA,U,5)=+$G(^DIC(42,+$O(^DIC(42,"B",WL,0)),44))
 S $P(DATA,U,8)=VT="Y"
 S $P(DATA,U,9)=$$ISSENS(DFN)
 S:CA $P(DATA,U,10)=$P($G(^DGPM(CA,0)),U)
 S:'$D(IOST) IOST="P-OTHER"
 S $P(DATA,U,11)=$$HRN(DFN)
 D ELIG^VADPT
 S $P(DATA,U,12,13)=$P($G(VAEL(3)),U,1,2)
 S $P(DATA,U,14)=$$ICN(DFN)
 S $P(DATA,U,15)=DOD
 S $P(DATA,U,16)=TS
 S $P(DATA,U,17)=$P($$OUTPTTM^SDECPTPC(DFN),U,2)
 S $P(DATA,U,18)=$P($$OUTPTPR^SDECPTPC(DFN),U,2)
 S $P(DATA,U,19)=$S(AT:$P($G(^VA(200,AT,0)),U),1:"")
 ;D:$G(SLCT) LAST(,DFN)
 Q
 ; Save/retrieve last patient selected for current institution
LAST(DATA,DFN) ;
 S DATA=""
 Q
 ;D:$$ISACTIVE($G(DFN)) EN^XPAR("USR","BEHOPTCX LAST PATIENT","`"_DUZ(2),"`"_DFN)
 ;S DATA=$$GET^XPAR("USR","BEHOPTCX LAST PATIENT",DUZ(2),"I")
 ;S:DATA ^DISV(DUZ,"^DPT(")=DATA
 ;S:'$$GET^XPAR("ALL","BEHOPTCX RECALL LAST") DATA=""
 Q
 ; Returns true if selectable patient
ISACTIVE(DFN,QUALS) ;EP
 N X
 ;S:'$D(DEMO) DEMO=+$$GET^XPAR("ALL","BEHOPTCX DEMO MODE",,"Q")
 S X=$G(^DPT(+DFN,0))
 Q:'$L(X)!$P(X,U,19) 0
 ;I '$P(X,U,21),$$LKPQUAL("@BEHOPTCX DEMO MODE",.QUALS) Q 0
 ;Q:$$LKPQUAL("MSC DG ALL SITES HIPAA",.QUALS) 1
 ;Q:'$O(^AUPNPAT(DFN,41,0)) '$$LKPQUAL("@BEHOPTCX REQUIRES HRN",.QUALS)
 Q ''$L($$HRN(DFN))
 ; Return requested lookup qualifier  (NOT USED)
LKPQUAL(QUAL,CACHE) ;EP
 N RET
 S RET=$G(CACHE(QUAL))
 S:'$L(RET) (RET,CACHE(QUAL))=+$$APSEC^SDEC01(QUAL,DUZ)
 Q RET
 ; Returns sensitive patient status
ISSENS(DFN) ;
 N RET
 D PTSEC^DGSEC4(.RET,DFN,0)
 Q $G(RET(1))
 ; Return ICN
ICN(DFN) N X
 S X=$S($L($T(GETICN^MPIF001)):+$$GETICN^MPIF001(DFN),1:"")
 Q $S(X>0:X,1:"")
 ; Return HRN given DFN
HRN(DFN) ;EP
 N X
 S X=$G(^AUPNPAT(DFN,41,+$G(DUZ(2)),0))
 Q $S($P(X,U,3):"",1:$P(X,U,2))
 ;
FMTSSN(SSN,MF) ;EP - P7  ;msc/sat add MF flag to mask SSN  0=no mask; 1=mask
 N X
 S MF=$G(MF,0)
 S X=$S(MF:$E(SSN,6,$L(SSN)),1:SSN)
 Q:MF "XXX-XX-"_$S($L(X):X,1:"XXXX")
 Q X
