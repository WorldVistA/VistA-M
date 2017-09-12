DG53376A ;ALB/RTK-Edit Cat A MT; 04/11/01
 ;;5.3;Registration;**376**;Aug 13, 1993
 ;
 ;
 ;Ensure that all Cat A means tests dated within the last 
 ;year meet the following criteria:
 ;
 ;  AGREED TO PAY DEDUCTIBLE set to NULL
 ;  DECLINES TO GIVE INCOME INFO set to NULL
 ;
 ;Edit records that do not conform.
 ;
 F I="MTRC","EDIT","FERR" D
 .I $D(^XTMP("DG-"_I)) Q
 .S X1=DT
 .S X2=30
 .D C^%DTC
 .S ^XTMP("DG-"_I,0)=X_"^"_$$DT^XLFDT_"^DG*5.3*376 MT CAT A EDIT "_$S(I="MTRC":"cat a means test count",I="EDIT":"edited records",1:"filing errors")
 ;
 S (^XTMP("DG-MTRC",1),^XTMP("DG-EDIT",1))=0
 ;
 N CHKDT,CHKREC,MTIEN,DATA
 S CHKDT=$$FMADD^XLFDT(DT,-365) ;go back one year
 S MTIEN=0 F  S MTIEN=$O(^DGMT(408.31,MTIEN)) Q:'+MTIEN  D
 .I $G(^DGMT(408.31,MTIEN,"PRIM"))=1 D
 ..S CHKREC=$G(^DGMT(408.31,MTIEN,0))
 ..;if Cat A and less than 365 days old, process
 ..I CHKREC'="",$P(CHKREC,"^",3)=4,$P(CHKREC,"^")>CHKDT S ^XTMP("DG-MTRC",1)=^XTMP("DG-MTRC",1)+1 N DATA D
 ...;if AGREED TO PAY DEDUCT is not null, change
 ...I $P(CHKREC,"^",11)'="" S DATA(.11)=""
 ...;if DECLINE TO GIVE INCOME INFO is 1 (Yes), change to null
 ...I $P(CHKREC,"^",14)=1 S DATA(.14)=""
 ...I $D(DATA) S ^XTMP("DG-EDIT",1)=^XTMP("DG-EDIT",1)+1,DGENDA=MTIEN D
 ....I '$$UPD^DGENDBS(408.31,.DGENDA,.DATA) S FILERR(408.31,MTIEN)="Unable to edit means test"
 D MAIL^DG53376M
 D BMES^XPDUTL(" Cat A means test edit routine has completed successfully.")
 Q
