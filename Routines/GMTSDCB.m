GMTSDCB ; SLC/TRS,KER - Brief Discharge ; 03/24/2004
 ;;2.7;Health Summary;**28,49,71**;Oct 20, 1995
 ;                
 ; External References
 ;   DBIA  3390  $$ICDDX^ICDCODE
 ;   DBIA 10035  ^DPT(
 ;   DBIA  1372  ^DGPT(
 ;   DBIA 10082  ^ICD9(
 ;   DBIA 10015  EN^DIQ1 (file #45)
 ;   DBIA  3145 ^DIC(42.4,
 ;   DBIA  3146 ^DIC(45.6,
 ;                     
ENDC ; Brief Discharge (no captions)
 S N="",ADM=GMTS1,GMC=0,LF=0
 I $D(GMTSNDM),(GMTSNDM>0) S CNTR=GMTSNDM
 E  S CNTR=100
 S T1=GMTSEND,T2=GMTSBEG
 F  S ADM=$O(^DPT(DFN,"DA","AA",ADM)) Q:'ADM!(ADM>GMTS2)  F  S N=$O(^DPT(DFN,"DA","AA",ADM,N)) Q:'N  D PROC I CNTR=0 Q
 D KILLADM Q
PROC ; Process Admissions
 S AD0=^DPT(DFN,"DA",N,0),PTF=$P(AD0,U,12)
 S CNTR=CNTR-1 I CNTR=0 Q
 I $S('PTF:1,1:'$D(^DGPT(PTF,70))) S GMC=-1 Q
 S:$D(^DGPT(PTF,70)) ICD=^DGPT(PTF,70)
 I $P(ICD,"^",1)="" S GMC=-1 Q
 S DATE=$P((ICD),"^",1) I (DATE'<T1)!(DATE'>T2) Q:GMC  S GMC=-1 Q
 S GMC=2 S X=DATE D REGDT4^GMTSU S XD=X
 I $P(ICD,U,10)'="" N ICDX S ICDX=$$ICDDX^ICDCODE($P(ICD,U,10)),DXL=$P(ICDX,"^",4)
 I $P((ICD),"^",2)'="" S BS=$P((ICD),"^",2),BS=$S($D(^DIC(42.4,BS,0)):^DIC(42.4,BS,0),1:"") S BDS=$S($P((BS),"^",2)'="":$P(BS,U,2),$P(BS,U,1)'="":$P(BS,U,1),1:"UNKNOWN")
 I $P(ICD,"^",3)'="" S DIC="^DGPT(",DR=72,DA=PTF,DIQ="ARRAY",DIQ(0)="E" D EN^DIQ1 S SDS=ARRAY(45,DA,72,"E")
 S DP=$S($P((ICD),"^",6)'="":$P(ICD,U,6),1:""),DP=$S(DP'="":^DIC(45.6,DP,0),1:"")
 S OT=$P(ICD,"^",4),OP=$S(OT=3:"NO",OT="":"UNKNOWN",1:"YES")
 D CKP^GMTSUP Q:$D(GMTSQIT)  W ?3,XD,?21,SDS,!
 I $D(DXL) D CKP^GMTSUP Q:$D(GMTSQIT)  W ?15,"DXLS: ",DXL,!
 K DXL,BS,BDS,ICD,DATE
 Q
KILLADM ; Kills Admission variables
 K END,TDT,HH,MM,TN,LF,DATE,AT,ITR,TRT,TI,TO,N,CNTR,BDS,SDS,GMC,ARRAY,DXL,TOM,TR,T1,T2,DATE,I,A,AD0,ADM,BS,D,DA,DP,DR,ICD,OP,OT,PTF,X,XD,DIQ,DIC
 Q
