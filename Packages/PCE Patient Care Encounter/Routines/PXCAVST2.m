PXCAVST2 ;ISL/dee & LEA/Chylton - Validates data from the PCE Device Interface for the Visit and Providers ;3/14/97
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**27,33**;Aug 12, 1996
 Q
 ;
PROVIDER ;Now do the providers
 N PXCAPERR,PXCAPRCK
 S PXCAPERR=1
 S (PXCAITEM,PXCAPRCK)=+$P(PXCAENC,"^",4)
 I PXCAPRCK,'$$ACTIVPRV^PXAPI(PXCAITEM,PXCADT) S PXCAPERR=0,PXCA("ERROR","ENCOUNTER",0,0,4)="Provider is not active or valid^"_PXCAITEM
 ;  add check if no provider sent
 I 'PXCAPRCK S PXCAPERR=0,PXCA("ERROR","ENCOUNTER",0,0,4)="No Provider entered"
 S PXCAITEM=$P(PXCAENC,"^",15)
 I PXCAPRCK,'(PXCAITEM="P"!(PXCAITEM="S")) S PXCAPERR=0,PXCA("ERROR","ENCOUNTER",0,0,15)="Provider indicator code must be P|S^"_PXCAITEM
 E  I PXCAITEM="P" D
 . I 'PXCAPPRV S PXCAPPRV=+$P(PXCAENC,"^",4)
 . E  I PXCAPPRV'=+$P(PXCAENC,"^",4) D
 .. S PXCA("WARNING","ENCOUNTER",0,0,15)="There is already a Primary Provider this one is changed to Secondary^"_PXCAITEM
 .. S $P(PXCAENC,"^",15)="S"
 S PXCAITEM=$P(PXCAENC,"^",16)
 I PXCAITEM]"" D
 . I '$$ACTIVPRV^PXAPI(PXCAITEM,PXCADT) S PXCAPERR=0,PXCA("ERROR","ENCOUNTER",0,0,16)="Attending Provider is not active or valid^"_PXCAITEM
 I PXCABULD&PXCAPERR!PXCAERRS D PROVIDER^PXCAPRV(PXCAENC)
 Q
 ;
EVALCODE(PXCAEVAL) ;Now do the Evaluation and Management CPT
 S PXCAITEM=+$P(PXCAENC,"^",5)
 I PXCAITEM D
 . N DIC,DR,DA,DIQ,PXCADIQ1
 . S DIC=357.69
 . S DR=".01;4"
 . S DA=+PXCAITEM
 . S DIQ="PXCADIQ1("
 . S DIQ(0)="I"
 . D EN^DIQ1
 . I $G(PXCADIQ1(357.69,DA,.01,"I"))="" S PXCA("ERROR","ENCOUNTER",0,0,5)="Evaluation and Management CPT code not in File 357.69^"_PXCAITEM Q
 . I $G(PXCADIQ1(357.69,DA,4,"I")) S PXCA("ERROR","ENCOUNTER",0,0,5)="Evaluation and Management CPT code is INACTIVE^"_PXCAITEM Q
 . S PXCAEVAL=1
 Q
 ;
