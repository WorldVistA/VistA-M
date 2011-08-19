PXCASOR ;ISL/dee - Validates & Translates data from the PCE Device Interface into PCE's PXK format for the Source ;6/20/96
 ;;1.0;PCE PATIENT CARE ENCOUNTER;;Aug 12, 1996
 Q
 ; Variables
 ;   PXCASOR   Copy of the source node of the PXCA array
 ;
SOR(PXCASOR) ;
 S ^TMP(PXCAGLB,$J,"SOR")=$P(PXCASOR,"^",1)
 S PXKDUZ=$P(PXCASOR,"^",2)
 Q
 ;
SOURCE(PXCA,PXCABULD,PXCAERRS) ;
 I '($D(PXCA("SOURCE"))#2) S PXCA("ERROR","SOURCE",0,0,0)="SOURCE node of the local data array is missing" Q
 N PXCASOR,PXCAITEM
 S PXCASOR=$G(PXCA("SOURCE"))
 I PXCASOR="" S PXCA("ERROR","SOURCE",0,0,0)="SOURCE data missing" Q
 S PXCAITEM=+$P(PXCASOR,"^",1)
 I 'PXCAITEM S PXCA("ERROR","SOURCE",0,0,1)="Data Sourec is Missing^"_PXCAITEM
 E  I '$D(^PX(839.7,PXCAITEM,0)) S PXCA("ERROR","SOURCE",0,0,1)="Data Sourec is not in File 839.7^"_PXCAITEM
 S PXCAITEM=+$P(PXCASOR,"^",2)
 I '$D(^VA(200,PXCAITEM,0)) S PXCA("ERROR","SOURCE",0,0,2)="User is not in File 200^"_PXCAITEM
 I PXCABULD&'$D(PXCA("ERROR","SOURCE"))!PXCAERRS D SOR(PXCASOR)
 Q
 ;
