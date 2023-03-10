IBY641PO ;EDE/JWS - POST-INSTALL FOR IB*2.0*641 ;13-JUL-2018
 ;;2.0;INTEGRATED BILLING;**641**;21-MAR-94;Build 61
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;
 Q
 ;
EN ;Entry Point
 N XSTNUM,A,B,C,D,D1,DA,DIE,DR,STATUS,PAYER,DATE,X,X1,STOP,IB3641
 ;
 S A=0
 ;
 S XSTNUM=$P($$SITE^VASITE,U,3)
 ; MARTINEZ #612
 I XSTNUM=612 S A=8160000
 ; Boston #523 
 I XSTNUM=523 S A=9160000
 ; Orlando #675
 I XSTNUM=675 S A=6000000
 ; Richmond #652
 I XSTNUM=652 S A=8090000
 ; N. Chicago #556
 I XSTNUM=556 S A=7020000
 ; 
 I A=0 Q  ;don't run on all sites, only our 641 IOC sites
 ;
 D CLEANUP
 ; only run once
 Q:$D(^XTMP("IB641",0))
 S ^XTMP("IB641",0)=$$FMADD^XLFDT(DT,180)_U_DT_U_"Post Install Cleanup IB*2*641 at IOC sites only"
 ; 
 F  S A=$O(^IBA(364,"B",A)) Q:A'=+A  D  ;example 8230518
 . S B=$O(^IBA(364,"B",A,0))
 . S C=$O(^IBA(364,"B",A,B))
 . I C="" Q   ; only one with the claim numbers so quit - issue only impacts medicare secondary (aka claims that keep same number).
 . S D=$O(^IBA(364,"B",A,C)) I D Q  ;tertiary claim  ; should never hit - 3 claims as same number
 . I $P(^IBA(364,C,0),"^",3)'="P" Q  ; secondary must be pending
 . I $P(^IBA(364,B,0),"^",3)'="Z" Q  ; primary must be closed
 . I $P(^IBA(364,C,0),"^",9)="" Q  ;if [9] = "", then it did not go out FHIR
 . S D=0,STATUS=""
 . F  S D=$O(^IBM(361,"B",A,D)) Q:D=""  S STOP=0,DATE=$P(^IBM(361,D,0),"^",2),PAYER="" D
 .. S D1=0 F  S D1=$O(^IBM(361,D,1,D1)) Q:D1'=+D1  S X=^(D1,0) D  I STOP Q
 ... I $F(X,"CLAIM SENT TO CLEARINGHOUSE") S STATUS="A0"
 ... I $F(X,"Accepted Claim sent out electronically") S STATUS="A0"  ;,DATE=$P(^IBM(361,D,0),"^",2)
 ... I $F(X,"ACCEPTED FOR PROCESSING") S STATUS="A1"
 ... I $F(X,"THIS CODE REQUIRES USE") S STATUS="E"
 ... I $F(X,"Electronic Claim rejected by Emdeon") S STATUS="E"
 ... I $F(X,"Payer Name: ") D  I STOP Q
 .... S X1=$P($P(X,"Payer ID"),"Payer Name: ",2)
 .... I $F(X1,"MEDICARE") S STOP=1 Q
 .... S PAYER=X1
 ... ;if not MEDICARE claim, reset batch number if not correct
 ... I PAYER="" Q
 ... I $P(^IBM(361,D,0),"^",11)=C Q  ;checking batch pointer to see if it is needed to be corrected
 ... S ^XTMP("IB641","POSTINSTALL",361,D,".11")=$$GET1^DIQ(361,D_",",.11,"I")_"^"_C
 ... S DIE="^IBM(361",DA=D,DR=".11////"_C D ^DIE
 .. I STOP S STATUS="",PAYER="",DATE=""
 . S IB3641=$P(^IBA(364,C,0),"^",2)
 . I $$GET1^DIQ(364,C_",",.03,"I")'=STATUS S ^XTMP("IB641","POSTINSTALL",364,C,".03")=$$GET1^DIQ(364,C_",",.03,"I")_"^"_STATUS
 . I $$GET1^DIQ(364.1,IB3641_",",.02,"I")'="A0" S ^XTMP("IB641","POSTINSTALL",364.1,IB3641,".02")=$$GET1^DIQ(364.1,IB3641_",",.02,"I")_"^A0"
 . I STATUS'="" D
 .. I $$GET1^DIQ(364,C_",",.04,"I")'=DATE S ^XTMP("IB641","POSTINSTALL",364,C,".04")=$$GET1^DIQ(364,C_",",.04,"I")_"^"_DATE
 .. I $$GET1^DIQ(364.1,IB3641_",",1.05,"I")'=DATE S ^XTMP("IB641","POSTINSTALL",364.1,IB3641,"1.05")=$$GET1^DIQ(364.1,IB3641_",",1.05,"I")_"^"_DATE
 . I STATUS'="" D  Q  ;"Update status of 364 entry to STATUS and update 364.1
 .. S DIE="^IBA(364,",DA=C,DR="" D
 ... I $$GET1^DIQ(364,C_",",.03,"I")'=STATUS S DR=".03////"_STATUS
 ... I $$GET1^DIQ(364,C_",",.04,"I")'=DATE S DR=$S(DR'="":DR_";",1:"")_".04////"_DATE
 ... D ^DIE
 .. S DIE="^IBA(364.1",DA=IB3641,DR="" D
 ... I $$GET1^DIQ(364.1,IB3641_",",.02,"I")'="A0" S DR=".02////A0"
 ... I $$GET1^DIQ(364.1,IB3641_",",1.05,"I")'=DATE S DR=$S(DR'="":DR_";",1:"")_"1.05////"_DATE
 ... D ^DIE
 . ; if STATUS = "", then no messages have been received yet, so set status = 'A0' and leave date the same
 . I $$GET1^DIQ(364,C_",",.03,"I")'="A0" S DIE="^IBA(364,",DA=C,DR=".03////A0" D ^DIE
 . I $$GET1^DIQ(364.1,IB3641_",",.02,"I")'="A0" S DIE="^IBA(364.1",DA=IB3641,DR=".02////A0" D ^DIE
 . ;IBA(364,#,0)[3], [4]
 . ;IBA(364.1,#,0)[2], IBA(364.1,#,1)[5] 
 . Q
 Q
 ;
CLEANUP ; clean up partial 364.1 entries
 ;641 v15
 N DIK,DA,A
 S ^XTMP("IB641_364.1",0)=$$FMADD^XLFDT(DT,180)_U_DT_U_"Post Install Cleanup IB*2*641 of file 364.1 at IOC sites only"
 ; this loop cleans up invalid entries in file 364.1, that contain no .01 field value, no BATCH#, but have status of 'A0'
 ; example is:
 ; ^IBA(364.1,2087976,0)="^A0"
 ; ^IBA(364.1,2087976,1)="^^^^3200611.0015^3200611.0015"
 ; 
 ; also this example, which appears to be very old:
 ; ^IBA(364.1,5230018828,0)="^^^^1^1^^^^^222"
 ;                       1)="^^^^3040703.08^3040707.1049"
 ;
 S A=0
 F  S A=$O(^IBA(364.1,A)) Q:A'=+A  D
 . I $P(^IBA(364.1,A,0),"^")="" D  Q
 .. M ^XTMP("IB641_364.1",A)=^IBA(364.1,A)
 .. S DIK="^IBA(364.1,",DA=A D ^DIK
 .. Q
 . ;
 . ; next is cleaning up entries caused by POSTMAN calls testing 837 FHIR and WriteBack failures
 . ; resulting in:
 . ; ^IBA(364.1,9450450,0)=6408882077
 . ;
 . I $P(^IBA(364.1,A,0),"^")'="",$P(^(0),"^",2)="" D
 .. M ^XTMP("IB641_364.1",A)=^IBA(364.1,A)
 .. S DIK="^IBA(364.1,",DA=A D ^DIK
 .. Q
 . Q
 Q
 ;
