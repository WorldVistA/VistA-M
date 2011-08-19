ORDV02 ; slc/dcm - OE/RR Report Extracts ;10/8/03  11:18
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**109,118,146,141,208**;Dec 17, 1997
 ;LAB Components
LO(ROOT,ORALPHA,OROMEGA,ORMAX,ORDBEG,ORDEND,OREXT)      ; Lab Order Component
 ;External calls to ^GMTSLROE
 ;
 I $L($T(GCPR^OMGCOAS1)) D  ; Call if FHIE station 200
 . N BEG,END,MAX
 . Q:'$G(ORALPHA)  Q:'$G(OROMEGA)
 . S MAX=$S(+$G(ORMAX)>0:ORMAX,1:999)
 . S BEG=9999999-OROMEGA,END=9999999-ORALPHA
 . D GCPR^OMGCOAS1(DFN,"LRO",BEG,END,MAX)
 ;
 N D,SN,ORX0,MAX,GMTS1,GMTS2,GMTSBEG,GMTSEND,ORSITE,SITE,GO
 Q:'$L(OREXT)
 S GO=$P(OREXT,";")_"^"_$P(OREXT,";",2)
 Q:'$L($T(@GO))
 S MAX=$S(+$G(ORMAX)>0:ORMAX,1:999),GMTS1=OROMEGA,GMTS2=ORALPHA,GMTSBEG=ORDBEG,GMTSEND=ORDEND
 S ORSITE=$$SITE^VASITE,ORSITE=$P(ORSITE,"^",2)_";"_$P(ORSITE,"^",3)
 K ^TMP("ORDATA",$J)
 I '$L($T(GCPR^OMGCOAS1)) D
 . K ^TMP("LRO",$J)
 . D @GO
 S (CTR,D)=0
 F  S D=$O(^TMP("LRO",$J,D)) Q:'D  D
 . S SN=0
 . F  S SN=$O(^TMP("LRO",$J,D,SN)) Q:'SN  S ORX0=^(SN) I $L(ORX0) D
 .. S SITE=$S($L($G(^TMP("LRO",$J,D,SN,"facility"))):^("facility"),1:ORSITE)
 .. S ^TMP("ORDATA",$J,D,"WP",1)="1^"_SITE ;Station ID
 .. S ^TMP("ORDATA",$J,D,"WP",2)="2^"_$P(ORX0,U) ;collection date
 .. S ^TMP("ORDATA",$J,D,"WP",3)="3^"_$P($P(ORX0,U,2),";",2) ;test name
 .. S ^TMP("ORDATA",$J,D,"WP",4)="4^"_$P($P(ORX0,U,2),";") ;test ien
 .. S ^TMP("ORDATA",$J,D,"WP",5)="5^"_$P($P(ORX0,U,3),";",2) ;specimen name
 .. S ^TMP("ORDATA",$J,D,"WP",6)="6^"_$P($P(ORX0,U,3),";") ;specimen ien
 .. S ^TMP("ORDATA",$J,D,"WP",7)="7^"_$P(ORX0,U,4) ;urgency
 .. S ^TMP("ORDATA",$J,D,"WP",8)="8^"_$P($P(ORX0,U,6),";",2) ;provider name
 .. S ^TMP("ORDATA",$J,D,"WP",9)="9^"_$P($P(ORX0,U,6),";") ;provider ien
 .. S ^TMP("ORDATA",$J,D,"WP",10)="10^"_$P(ORX0,U,7) ;order date/time
 .. S ^TMP("ORDATA",$J,D,"WP",11)="11^"_$P(ORX0,U,8) ;accession number
 .. S ^TMP("ORDATA",$J,D,"WP",12)="12^"_$P(ORX0,U,9) ;available date/time
 .. S ^TMP("ORDATA",$J,D,"WP",13)="13^"_$P(ORX0,U,5) ;status
 K ^TMP("LRO",$J)
 S ROOT=$NA(^TMP("ORDATA",$J))
 Q
CH(ROOT,ORALPHA,OROMEGA,ORMAX,ORDBEG,ORDEND,OREXT)     ;Chemistry/Hematology
 ;External references to ^DPT(DFN,"LR"),^LR(LRDFN, ^GMTSLRCE
 ;
 I $L($T(GCPR^OMGCOAS1)) D  ; Call if FHIE station 200
 . N BEG,END,MAX
 . Q:'$G(ORALPHA)  Q:'$G(OROMEGA)
 . S MAX=$S(+$G(ORMAX)>0:ORMAX,1:999)
 . S BEG=9999999-OROMEGA,END=9999999-ORALPHA
 . D GCPR^OMGCOAS1(DFN,"LRC",BEG,END,MAX)
 ;
 N CTR,ORI,TST,PC,ORX0,GMCFLAG,GMCMNT,GMW,IX0,IX,LRDFN,CNT,PTR,MAX,GMTS1,GMTS2,GMTSAGE,ORSITE,SEX,SITE,GO,VA,VAIN,VAERR,VAIN,VADM
 Q:'$L(OREXT)
 S GO=$P(OREXT,";")_"^"_$P(OREXT,";",2)
 Q:'$L($T(@GO))
 S LRDFN=+$G(^DPT(DFN,"LR"))
 I GO["GMTSLRCE" Q:'LRDFN
 D OERR^VADPT
 S GMTSAGE=$S(+VADM(4)>0:+VADM(4),1:99),SEX=$P(VADM(5),"^")
 S MAX=$S(+$G(ORMAX)>0:ORMAX,1:999),GMTS1=OROMEGA,GMTS2=ORALPHA
 S ORSITE=$$SITE^VASITE,ORSITE=$P(ORSITE,"^",2)_";"_$P(ORSITE,"^",3)
 K ^TMP("ORDATA",$J)
 I '$L($T(GCPR^OMGCOAS1)) D
 . K ^TMP("LRC",$J)
 . D @GO
 S CTR=0,ORI=GMTS1
 F  S ORI=$O(^TMP("LRC",$J,ORI)) Q:'ORI!(ORI>GMTS2)  D
 . S TST=""
 . F  S TST=$O(^TMP("LRC",$J,ORI,TST)) Q:TST=""  D
 .. I TST S ORX0=$G(^TMP("LRC",$J,ORI,TST)) Q:ORX0=""  D
 ... S SITE=$S($L($G(^TMP("LRC",$J,ORI,TST,"facility"))):^("facility"),1:ORSITE)
 ... S ^TMP("ORDATA",$J,ORI,TST,"WP",1)="1^"_SITE ;Station ID
 ... S ^TMP("ORDATA",$J,ORI,TST,"WP",2)="2^"_$P(ORX0,U) ;collection date
 ... S ^TMP("ORDATA",$J,ORI,TST,"WP",3)="3^"_$P(ORX0,U,3) ;test name
 ... S ^TMP("ORDATA",$J,ORI,TST,"WP",4)="4^"_$P(ORX0,U,2) ;specimen
 ... S ^TMP("ORDATA",$J,ORI,TST,"WP",5)="5^"_$P(ORX0,U,4) ;result
 ... S ^TMP("ORDATA",$J,ORI,TST,"WP",6)="6^"_$P(ORX0,U,5) ;indicator
 ... S ^TMP("ORDATA",$J,ORI,TST,"WP",7)="7^"_$P(ORX0,U,6) ;units
 ... S ^TMP("ORDATA",$J,ORI,TST,"WP",8)="8^"_$P(ORX0,U,7) ;ref low
 ... S ^TMP("ORDATA",$J,ORI,TST,"WP",9)="9^"_$P(ORX0,U,8) ;ref high
 ... D SPMRG^ORDVU("^TMP(""LRC"","_$J_","_ORI_",""C"")","^TMP(""ORDATA"","_$J_","_ORI_","_TST_",""WP"",10)",10) ;comments
 ... I $O(^TMP("LRC",$J,ORI,"C",0)) S ^TMP("ORDATA",$J,ORI,TST,"WP",11)="11^[+]" ;flag for details
 .. S CTR=CTR+1
 K ^TMP("LRC",$J)
 S ROOT=$NA(^TMP("ORDATA",$J))
 Q
SP(ROOT,ORALPHA,OROMEGA,ORMAX,ORDBEG,ORDEND,OREXT)      ;Surgical Pathology
 ;External references to ^DPT(DFN,"LR"), ^GMTSLRAE,
 ;
 I $L($T(GCPR^OMGCOAS1)) D  ; Call if FHIE station 200
 . N BEG,END,MAX
 . Q:'$G(ORALPHA)  Q:'$G(OROMEGA)
 . S MAX=$S(+$G(ORMAX)>0:ORMAX,1:999)
 . S BEG=9999999-OROMEGA,END=9999999-ORALPHA
 . D GCPR^OMGCOAS1(DFN,"SP",BEG,END,MAX)
 ;
 N ORDT,ORX0,ORCNT,GMI,MAX,LRDFN,IX,X,IX0,GMTS1,GMTS2,ORSITE,SITE,GO
 Q:'$L(OREXT)
 S GO=$P(OREXT,";")_"^"_$P(OREXT,";",2)
 Q:'$L($T(@GO))
 S LRDFN=+$G(^DPT(DFN,"LR"))
 I GO["GMTSLRAE" Q:'LRDFN
 S MAX=$S(+$G(ORMAX)>0:ORMAX,1:999),GMTS1=OROMEGA,GMTS2=ORALPHA
 S ORSITE=$$SITE^VASITE,ORSITE=$P(ORSITE,"^",2)_";"_$P(ORSITE,"^",3)
 K ^TMP("ORDATA",$J)
 I '$L($T(GCPR^OMGCOAS1)) D
 . K ^TMP("LRA",$J)
 . D @GO
 S ORDT=GMTS1,ORCNT=0
 F  S ORDT=$O(^TMP("LRA",$J,ORDT)) Q:(ORDT'>0)!(ORDT>GMTS2)  S ORX0=^(ORDT,0) D
 . S SITE=$S($L($G(^TMP("LRA",$J,ORDT,"facility"))):^("facility"),1:ORSITE)
 . S ^TMP("ORDATA",$J,ORDT,"WP",1)="1^"_SITE ;Station ID
 . S ^TMP("ORDATA",$J,ORDT,"WP",2)="2^"_$P(ORX0,U) ;collection date
 . S ^TMP("ORDATA",$J,ORDT,"WP",4)="4^"_$P(ORX0,U,2) ;accession number
 . D SPMRG^ORDVU("^TMP(""LRA"","_$J_","_ORDT_",.1)","^TMP(""ORDATA"","_$J_","_ORDT_",""WP"",3)",3) ;specimen
 . D SPMRG^ORDVU("^TMP(""LRA"","_$J_","_ORDT_",.2)","^TMP(""ORDATA"","_$J_","_ORDT_",""WP"",5)",5) ;brief Clinical Hx
 . D SPMRG^ORDVU("^TMP(""LRA"","_$J_","_ORDT_",1)","^TMP(""ORDATA"","_$J_","_ORDT_",""WP"",6)",6) ;gross Description
 . D SPMRG^ORDVU("^TMP(""LRA"","_$J_","_ORDT_",1.1)","^TMP(""ORDATA"","_$J_","_ORDT_",""WP"",7)",7) ;microscopic Exam
 . I $D(^TMP("LRA",$J,ORDT,1.2,1,0)) S X=^(0) D
 .. S ^TMP("LRA",$J,ORDT,1.2,1,0)=$$DATE^ORDVU(X)
 .. D SPMRG^ORDVU("^TMP(""LRA"","_$J_","_ORDT_",1.2)","^TMP(""ORDATA"","_$J_","_ORDT_",""WP"",8)",8) ;supplemetary Report
 . D SPMRG^ORDVU("^TMP(""LRA"","_$J_","_ORDT_",1.3)","^TMP(""ORDATA"","_$J_","_ORDT_",""WP"",9)",9) ;frozen Section
 . D SPMRG^ORDVU("^TMP(""LRA"","_$J_","_ORDT_",1.4)","^TMP(""ORDATA"","_$J_","_ORDT_",""WP"",10)",10) ;surgical path Dx
 . S ^TMP("ORDATA",$J,ORDT,"WP",11)="11^[+]" ;flag for detail
 K ^TMP("LRA",$J)
 S ROOT=$NA(^TMP("ORDATA",$J))
 Q
CY(ROOT,ORALPHA,OROMEGA,ORMAX,ORDBEG,ORDEND,OREXT)      ;Cytopathology
 ;External references to ^DPT(DFN,"LR"), ^GMTSLRPE
 ;
 I $L($T(GCPR^OMGCOAS1)) D  ; Call if FHIE station 200
 . N BEG,END,MAX
 . Q:'$G(ORALPHA)  Q:'$G(OROMEGA)
 . S MAX=$S(+$G(ORMAX)>0:ORMAX,1:999)
 . S BEG=9999999-OROMEGA,END=9999999-ORALPHA
 . D GCPR^OMGCOAS1(DFN,"CY",BEG,END,MAX)
 ;
 N ORDT,ORX0,GMI,IX0,MAX,LRDFN,IX,GMTS1,GMTS2,ORSITE,SITE,GO,ORMORE
 Q:'$L(OREXT)
 S GO=$P(OREXT,";")_"^"_$P(OREXT,";",2)
 Q:'$L($T(@GO))
 S LRDFN=+$G(^DPT(DFN,"LR"))
 I GO["GMTSLRPE" Q:'LRDFN
 S MAX=$S(+$G(ORMAX)>0:ORMAX,1:999),GMTS1=OROMEGA,GMTS2=ORALPHA
 S ORSITE=$$SITE^VASITE,ORSITE=$P(ORSITE,"^",2)_";"_$P(ORSITE,"^",3)
 K ^TMP("ORDATA",$J)
 I '$L($T(GCPR^OMGCOAS1)) D
 . K ^TMP("LRCY",$J)
 . D @GO
 S ORDT=GMTS1,ORSITE=$$SITE^VASITE,ORSITE=$P(ORSITE,"^",2)_";"_$P(ORSITE,"^",3)
 F  S ORDT=$O(^TMP("LRCY",$J,ORDT)) Q:(ORDT'>0)!(ORDT>GMTS2)  S ORX0=$G(^(ORDT,0)) D
 . S ORMORE=0,SITE=$S($L($G(^TMP("LRCY",$J,ORDT,"facility"))):^("facility"),1:ORSITE)
 . S ^TMP("ORDATA",$J,ORDT,"WP",1)="1^"_SITE ;Station ID
 . S ^TMP("ORDATA",$J,ORDT,"WP",2)="2^"_$P(ORX0,U)       ;collection date
 . S ^TMP("ORDATA",$J,ORDT,"WP",5)="5^"_$P(ORX0,U,2)     ;accession number
 . S ^TMP("ORDATA",$J,ORDT,"WP",4)="4^"_$$DATE^ORDVU($P($G(^TMP("LRCY",$J,ORDT,1)),U,2)) ;report release date
 . I $O(^TMP("LRCY",$J,ORDT,1,0)) S ORMORE=1 D SPMRG^ORDVU("^TMP(""LRCY"","_$J_","_ORDT_",1)","^TMP(""ORDATA"","_$J_","_ORDT_",""WP"",3)",3) ;specimen
 . I $O(^TMP("LRCY",$J,ORDT,"AH",0)) S ORMORE=1 D SPMRG^ORDVU("^TMP(""LRCY"","_$J_","_ORDT_",""AH"")","^TMP(""ORDATA"","_$J_","_ORDT_",""WP"",6)",6) ;brief Clinical Hx
 . I $O(^TMP("LRCY",$J,ORDT,"G",0)) S ORMORE=1 D SPMRG^ORDVU("^TMP(""LRCY"","_$J_","_ORDT_",""G"")","^TMP(""ORDATA"","_$J_","_ORDT_",""WP"",7)",7) ;gross Description
 . I $O(^TMP("LRCY",$J,ORDT,"MI",0)) S ORMORE=1 D SPMRG^ORDVU("^TMP(""LRCY"","_$J_","_ORDT_",""MI"")","^TMP(""ORDATA"","_$J_","_ORDT_",""WP"",8)",8) ;microscopic Exam
 . I $O(^TMP("LRCY",$J,ORDT,"NDX",0)) S ORMORE=1 D SPMRG^ORDVU("^TMP(""LRCY"","_$J_","_ORDT_",""NDX"")","^TMP(""ORDATA"","_$J_","_ORDT_",""WP"",9)",9) ;cythopathology DX
 . I $O(^TMP("LRCY",$J,ORDT,"SR",0)) S ORMORE=1 D SPMRG^ORDVU("^TMP(""LRCY"","_$J_","_ORDT_",""SR"")","^TMP(""ORDATA"","_$J_","_ORDT_",""WP"",10)",10) ;supplemetary Report
 . I ORMORE S ^TMP("ORDATA",$J,ORDT,"WP",11)="11^[+]" ;flag for detail
 K ^TMP("LRCY",$J)
 S ROOT=$NA(^TMP("ORDATA",$J))
 Q
