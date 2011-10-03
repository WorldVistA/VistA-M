ICPTCR ;ALB/ABR - MUMPS CROSS REFERENCE ROUTINE ; 3/10/97
 ;;6.0;CPT/HCPCS;;May 19, 1997
 ;
 ;  VARIABLES
 ;     ICPTA = Begin Range
 ;     ICPTX = End Range
 ;
CATEG ;  For CATEGORY x-refs  (file 81.1, fields 4-BEGIN CPT RANGE, and
 ;                    5-END CPT RANGE)
 ;     CAT = category type;  used to determine x-ref "M" or "R"
 ;           where "M" is used only for Major categories, and
 ;           "R" is used for all others (not major) categories.
 ;
CSET(DA,ICPTX,CAT) ;  category range x-ref on END range
 N ICPTA
 S ICPTA=$P(^DIC(81.1,DA,0),U,4),ICPTA=$$NUM^ICPTAPIU(ICPTA) ; begin cpt range
 S ICPTX=$$NUM^ICPTAPIU(ICPTX)
 D CXSET
 Q
 ;
CKIL(DA,CAT) ; x-ref kill on END range
 N ICPTA
 S ICPTA=$P(^DIC(81.1,DA,0),U,4),ICPTA=$$NUM^ICPTAPIU(ICPTA)
 I ICPTA<0 Q
 D CXKIL
 Q
 ;
 ;
CBSET(DA,ICPTA) ; x-ref on begin range for categories
 ;
 N ICPTX,CAT
 D CVAR
 S ICPTA=$$NUM^ICPTAPIU(ICPTA),ICPTX=$$NUM^ICPTAPIU(ICPTX)
 D CXSET
 Q
 ;
CBKIL(DA,ICPTA) ; x-ref kill on begin range for categories
 N ICPTX,CAT
 D CVAR
 S ICPTA=$$NUM^ICPTAPIU(ICPTA)
 D CXKIL
 Q
 ;
CVAR ;  set begin range x-ref variables.
 ;     ICPTX = end range
 N ICPTSTR
 S ICPTSTR=^DIC(81.1,DA,0),CAT=$S($P(ICPTSTR,U,2)="m":"M",1:"R"),ICPTX=$P(ICPTSTR,U,5)
 Q
 ;
CXSET ; set of category x-ref
 S ^DIC(81.1,CAT,ICPTA,DA)=ICPTX
 Q
 ;
CXKIL ; kill of category x-ref
 K ^DIC(81.1,CAT,ICPTA,DA)
 Q
 ;
MODIFIER ;   Mod x-refs
 ;  ICPTA = begin range
 ;  ICPTX = end range
 ;      M = If $G(M), do whole file x-ref,
 ;          else, just x-ref within multiple
 ;
MSET(DA,ICPTX,M) ; x-ref on end range
 N ICPTA
 S ICPTA=$P(^DIC(81.3,DA(1),10,DA,0),U),ICPTA=$$NUM^ICPTAPIU(ICPTA)
 S ICPTX=$$NUM^ICPTAPIU(ICPTX)
 I $G(M) D MXMSET Q
 D MXSET
 Q
 ;
MKIL(DA,ICPTX,M) ; x-ref kill on end range
 N ICPTA
 S ICPTA=$P(^DIC(81.3,DA(1),10,DA,0),U),ICPTA=$$NUM^ICPTAPIU(ICPTA)
 S ICPTX=$$NUM^ICPTAPIU(ICPTX)
 I $G(M) D MXMKIL Q
 D MXKIL
 Q
 ;
MBSET(DA,ICPTA,M) ;  modifier begin range x-ref
 N ICPTX
 S ICPTX=$P(^DIC(81.3,DA(1),10,DA,0),U,2),ICPTX=$$NUM^ICPTAPIU(ICPTX)
 S ICPTA=$$NUM^ICPTAPIU(ICPTA)
 I $G(M) D MXMSET Q
 D MXSET
 Q
 ;
MBKIL(DA,ICPTA,M) ;  modifier begin range x-ref kill
 N ICPTX
 S ICPTX=$P(^DIC(81.3,DA(1),10,DA,0),U,2),ICPTX=$$NUM^ICPTAPIU(ICPTX)
 S ICPTA=$$NUM^ICPTAPIU(ICPTA)
 I $G(M) D MXMKIL Q
 D MXKIL
 Q
 ;
MXSET ; set modifier x-ref
 S ^DIC(81.3,DA(1),"M",ICPTA)=ICPTX
 Q
 ;
MXKIL ; kill modifier x-ref
 K ^DIC(81.3,DA(1),"M",ICPTA)
 Q
 ;
MXMSET ;  set full file x-ref on range
 S ^DIC(81.3,"M",ICPTA,ICPTX,DA(1))=DA
 Q
MXMKIL ;  kill full file x-ref on range
 K ^DIC(81.3,"M",ICPTA,ICPTX,DA(1))
 Q
