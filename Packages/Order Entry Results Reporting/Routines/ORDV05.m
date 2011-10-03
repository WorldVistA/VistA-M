ORDV05 ; slc/jdl - OE/RR Report Extracts ;10/8/03  11:18
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**109,208**;Dec 17, 1997
 ;
MI(ROOT,ORALPHA,OROMEGA,ORMAX,ORDBEG,ORDEND,OREXT) ;Microbiology
 ;External references to ^DPT(DFN,"LR"),^LR(LRDFN, extract:GET^ORDV05E
 ;
 I $L($T(GCPR^OMGCOAS1)) D  ; Call if FHIE station 200
 . N BEG,END,MAX
 . Q:'$G(ORALPHA)  Q:'$G(OROMEGA)
 . S MAX=$S(+$G(ORMAX)>0:ORMAX,1:999)
 . S BEG=9999999-ORALPHA,END=9999999-OROMEGA
 . D GCPR^OMGCOAS1(DFN,"MI",BEG,END,MAX)
 ;
 N MAX,GMTS1,GMTS2,ORSITE,SITE,GO,N1,S1,OREC,CNT
 Q:'$L(OREXT)
 S GO=$P(OREXT,";")_"^"_$P(OREXT,";",2)
 Q:'$L($T(@GO))
 S GMTSNDM=$S(+$G(ORMAX)>0:ORMAX,1:999),GMTS2=ORALPHA,GMTS1=OROMEGA
 S ORSITE=$$SITE^VASITE,ORSITE=$P(ORSITE,"^",2)_";"_$P(ORSITE,"^",3)
 K ^TMP("ORDATA",$J)
 I '$L($T(GCPR^OMGCOAS1)) D
 . K ^TMP("ORM",$J),^TMP("OR7OGX",$J),^TMP("OR7OG",$J)
 . D @GO
 S N1=0,CNT=0
 F  S N1=$O(^TMP("ORM",$J,N1)) Q:'N1  S S1="" F  S S1=$O(^TMP("ORM",$J,N1,S1)) Q:S1=""  S OREC=^(S1) D
 . S CNT=CNT+1,SITE=$S($L($G(^TMP("ORM",$J,N1,S1,"facility"))):^("facility"),1:ORSITE)
 . S ^TMP("ORDATA",$J,CNT,"WP",1)="1^"_SITE ;Station ID
 . S ^TMP("ORDATA",$J,CNT,"WP",2)="2^"_$P(OREC,U) ;Collect dt
 . S ^TMP("ORDATA",$J,CNT,"WP",3)="3^"_$P(OREC,U,5) ;Test name
 . S ^TMP("ORDATA",$J,CNT,"WP",4)="4^"_$P(OREC,U,3) ;Collection sample
 . S ^TMP("ORDATA",$J,CNT,"WP",5)="5^"_$P(OREC,U,4) ;Specimen
 . S ^TMP("ORDATA",$J,CNT,"WP",6)="6^"_$P(OREC,U,2) ;Accession
 . D SPMRG^ORDVU($NA(^TMP("ORM",$J,N1,S1,"REPORT")),$NA(^TMP("ORDATA",$J,CNT,"WP",7)),7) ;report
 . I $O(^TMP("ORM",$J,N1,S1,"REPORT",0)) S ^TMP("ORDATA",$J,CNT,"WP",8)="8^[+]" ;flag for detail
 K ^TMP("ORM",$J),^TMP("OR7OGX",$J),^TMP("OR7OG",$J)
 S ROOT=$NA(^TMP("ORDATA",$J))
 Q
