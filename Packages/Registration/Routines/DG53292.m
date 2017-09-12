DG53292 ;ALB/RKS-DG*5.3*292 Post-Install to clean ANNUAL MEANS TEST ;05/22/00
 ;;5.3;Registration;**292**;Aug 13,  1993
 ;
 ; This routine is the post installation for patch DG*5.3*292
 ;
 ; The clean up is required as there are a number of null entries
 ; in the DATE/TIME COMPLETED (#.07) field in the Annual Means Test
 ; file (408.31). When appropriate, this field will be populated with
 ; the DATE OF TEST (#.01) field and a time of .0001 concatenated.
 ;
 ; ^XTMP("DG-DTC") track number of records processed:
 ; ^XTMP("DG-DTCERR") contains error messages returned from FM DBS calls:
 ; ^XTMP("DG-DTCERR",file#,record#)=error message
 ;
POST ;
 ; post-install set up checkpoints and tracking global...
 N %,I,X,X1,X2
 I $D(XPDNM) D
 . ; checkpoints
 . I $$VERCP^XPDUTL("DGPAT")'>0 D
 . . S %=$$NEWCP^XPDUTL("DGPAT","",0)
 . ;
 ;
 ; initialize tracking global (see text above for description)...
 F I="DTC","DTCERR" D
 . I $D(^XTMP(I)) Q
 . S X1=DT
 . S X2=30
 . D C^%DTC
 . S ^XTMP("DG-"_I,0)=X_"^"_$$DT^XLFDT_"^DG*5.3*292 POST-INSTALL "_$S(I="DTC":"record count",1:"filing errors")
 ;
EN ; begin processing...
 N %
 ; check status and if root checkpoint has not completed start clean up
 I $D(XPDNM) S %=$$VERCP^XPDUTL("DGPAT")
 I $G(%)="" S %=0
 I %=0 D EN1
 Q
 ;
EN1 ; begin purge...
 ; write message to installation device and to INSTALL file (#9.7)
 D BMES^XPDUTL("POST INSTALLATION PROCESSING")
 D MES^XPDUTL("Once the post-install is completed, a mail message will")
 D MES^XPDUTL("be sent that will report the count of records which")
 D MES^XPDUTL("had to have a DATE/TIME COMPLETED entry added.")
 D MES^XPDUTL("Additionally, the report will contain notes about")
 D MES^XPDUTL("any errors encountered during the post-installation")
 D BMES^XPDUTL("Beginning update process "_$$FMTE^XLFDT($$NOW^XLFDT))
 ;
 ; process control body
 N DGPAT,DOT,DGX,DGENDA,DATA,ERR
 ;
 I '$D(XPDNM) S DGPAT=0
 I $D(XPDNM) S DGPAT=$$PARCP^XPDUTL("DGPAT")
 ;
 F  S DGPAT=$O(^DGMT(408.31,DGPAT)) Q:'DGPAT  I $G(^(DGPAT,0)) D
 . I $P(^DGMT(408.31,DGPAT,0),U,7)'="" Q
 . I (($P(^DGMT(408.31,DGPAT,0),U,4)="")&('$P(^(0),U,14))) Q
 . S DGX=^DGMT(408.31,DGPAT,0),DOT=+DGX_".0001"
 . S DGENDA=DGPAT,DATA(.07)=DOT
 . I '$$UPD^DGENDBS(408.31,.DGENDA,.DATA,.ERR) S:$D(ERR) ^XTMP("DG-DTCERR",408.31,DGENDA)=ERR
 . S ^XTMP("DG-DTC")=+$G(^XTMP("DG-DTC"))+1
 . I $D(XPDNM) S %=$$UPCP^XPDUTL("DGPAT",DGPAT)
 ;Send mailman message to user/HEC with results
 D MAIL^DG53292M
 I $D(XPDNM) S %=$$COMCP^XPDUTL("DGPAT")
 D MES^XPDUTL(" >>update process completed "_$$FMTE^XLFDT($$NOW^XLFDT))
 Q
 ;
