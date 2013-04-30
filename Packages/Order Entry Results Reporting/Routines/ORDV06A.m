ORDV06A ; slc/dcm - OE/RR Report Extracts ;3/8/04  11:17
 ;;3.0;ORDER ENTRY RESULTS REPORTING;**215,243**;Dec 17, 1997;Build 242
 ;Pharmacy Extracts
NVA(ROOT,ORALPHA,OROMEGA,ORMAX,ORDBEG,ORDEND,OREXT) ;All Outpatient Pharmacy
 ;Call to PSOHCSUM
 ;^TMP("PSOO",$J,"NVA",n,0)=Herbal/OTC/Non VA Medication^status (active or discontinued)^start date(fm format)^cprs order # (ptr to 100)
 ;                          ^date/time documented (fm format)^documented by (ptr to 200_";"_.01)^dc date/time(fm format)
 ;^TMP("PSOO",$J,"NVA",n,1,0)=dosage^med route^schedule (previous 3 fields are Instructions)^drug (file #50_";"_.01)^clinic (file #44_";"_.01)
 ;^TMP("PSOO",$J,"NVA",n,"DSC",nn,0)=statement/explanation/comments
 I $L($T(GCPR^OMGCOAS1)) D  ; Call if FHIE station 200
 . N BEG,END,MAX
 . S BEG=0,END=9999999,MAX=9999
 . D GCPR^OMGCOAS1(DFN,"RXOP",BEG,END,MAX)
 ;
 N GO
 Q:'$L(OREXT)
 S GO=$P(OREXT,";")_"^"_$P(OREXT,";",2)
 Q:'$L($T(@GO))
 D GET
 Q
GET N J,ORDT,ORDRGIEN,ORDRG,ORRXNO,ORSTAT,ORQTY,OREXP,ORISSUE,ORLAST,ORREF,ORPRVD,ORCOST,ORSIG,ORX0,ORX1
 N ECD,GMR,GMW,IX,PSOBEGIN,GMTSNDM,GMTS1,GMTS2,ORSITE,SITE
 S ORSITE=$$SITE^VASITE,ORSITE=$P(ORSITE,"^",2)_";"_$P(ORSITE,"^",3)
 S PSOBEGIN=0
 K ^TMP("ORDATA",$J)
 I '$L($T(GCPR^OMGCOAS1)) D
 . K ^TMP("PSOO",$J)
 . D @GO
 S ORDT=0
 F  S ORDT=$O(^TMP("PSOO",$J,"NVA",ORDT)) Q:(ORDT'>0)  S ORX0=$G(^(ORDT,0)) I ORX0'="" S ORX1=$G(^(1,0)) D
 . S SITE=$S($L($G(^TMP("PSOO",$J,"NVA",ORDT,"facility"))):^("facility"),1:ORSITE)
 . S ^TMP("ORDATA",$J,ORDT,"WP",1)="1^"_SITE ;Station ID
 . S ^TMP("ORDATA",$J,ORDT,"WP",2)="2^"_$P(ORX0,U) ;Herbal/OTC/Non VA Medication
 . S ^TMP("ORDATA",$J,ORDT,"WP",3)="3^"_$P(ORX0,U,2) ;Status
 . S ^TMP("ORDATA",$J,ORDT,"WP",4)="4^"_$$DATE^ORDVU($P(ORX0,U,3)) ;Start Date
 . S ^TMP("ORDATA",$J,ORDT,"WP",5)="5^"_$$DATE^ORDVU($P(ORX0,U,5)) ;Date Documented
 . S ^TMP("ORDATA",$J,ORDT,"WP",6)="6^"_$P($P(ORX0,U,6),";",2) ;Documented By
 . S ^TMP("ORDATA",$J,ORDT,"WP",7)="7^"_$$DATE^ORDVU($P(ORX0,U,7)) ;Date DC'd
 . S ^TMP("ORDATA",$J,ORDT,"WP",8)="8^"_$P(ORX1,U)_" "_$P(ORX1,U,2)_" "_$P(ORX1,U,3) ;SIG dose + route + schedule
 . S J=0
 . F  S J=$O(^TMP("PSOO",$J,"NVA",ORDT,"DSC",J)) Q:'J  S X=^(J,0),^TMP("ORDATA",$J,ORDT,"WP",10,J)="10^"_X
 . I $O(^TMP("PSOO",$J,"NVA",ORDT,"DSC",1)) S ^TMP("ORDATA",$J,ORDT,"WP",9)="9^[+]" ;flag for detail
 K ^TMP("PSOO",$J)
 S ROOT=$NA(^TMP("ORDATA",$J))
 Q
