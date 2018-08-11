LR500PO ;BPFO/MBS - POST INSTALL ROUTINE FOR PATCH LR*5.2*500 ;12/26/2017
 ;;5.2;LAB SERVICE;**500**;Sep 27, 1994;Build 29
 ;
 ;pre-/post-install routine to change site lab addresses in LAB MLTF MANAGED ITEMS (#66.4)
 ; file to use net name.
 ;
PRE ; pre-install
 ;Save off MLTF data before install
 ;We don't want to do this if fields have already been moved; previous install means we 
 ;already have data moved
 ;If unsuccessful install happened previously, either the data has been moved or it hasn't
 ;.If it hasn't, the data should still be there and we want to save/restore the most recent data
 ;.If it has, then there is no data to save (since the post-install routine probably didn't run)
 ;.so we want to use previously saved data
 N FLDDTA,XUXNM,XUDTA,CNT,XPDIDTOT
 D FIELD^DID(66.3,.05,,"GLOBAL SUBSCRIPT LOCATION","FLDDTA")
 ;Q:(+$G(FLDDTA("GLOBAL SUBSCRIPT LOCATION")))=4
 S XUXNM="LR PATCH 500 SAVE OF FILE 66.3"
 S XUDTA=$G(^XTMP(XUXNM,0)) S:XUDTA="" $P(XUDTA,U,3)="Save of file 66.3 for patch LR*5.2*500"
 S $P(XUDTA,U,1)=$$FMADD^XLFDT(DT,90),$P(XUDTA,U,2)=DT,^XTMP(XUXNM,0)=XUDTA
 S CNT=$G(^XTMP(XUXNM,"CNT",0))+1,^XTMP(XUXNM,"CNT",0)=CNT
 M ^XTMP(XUXNM,66.3,CNT)=^LRMLTF
 ;Delete "B" x-ref, since we are replacing it
 D DELIX^DDMOD(66.3,.02,1,"K"),DELIX^DDMOD(66.3,.01,1,"K")
 ;Just to be sure
 K ^LRMLTF("B"),^LRMLTF("C")
 Q
POST ; post-install
 N IEN,DA,DIK,A,MLTF2,MLTF3,CNT,XUXNM,LRMSG
 S IEN=0 F  S IEN=$O(^LAB(66.4,IEN)) Q:'IEN  D
 . N X,LRFDA
 . S X=$$GET1^DIQ(66.4,IEN_",","2")
 . S $P(X,"@",2)=$G(^XMB("NETNAME"))
 . S LRFDA(66.4,IEN_",",2)=X
 . S X=$$GET1^DIQ(66.4,IEN_",",3)
 . S $P(X,"@",2)=$G(^XMB("NETNAME"))
 . S LRFDA(66.4,IEN_",",3)=X
 . S LRFDA(66.4,IEN_",",.02)="M"
 . S LRFDA(66.4,IEN_",",.1)="0"
 . S LRFDA(66.4,IEN_",",.05)="N"
 . S LRFDA(66.4,IEN_",",4)="vaausctt203.aac.domain.ext"
 . S LRFDA(66.4,IEN_",",5)="8088"
 . S LRFDA(66.4,IEN_",",6)="ntrt~projects~NTRT~queues~custom~1"
 . S LRFDA(66.4,IEN_",",7)="JIRAORAUSER"
 . ;
 . D FILE^DIE(,"LRFDA")
 ;
 ; invoke cross reference re-build for 66.3 with addition of new cross reference
 S LRMSG(1)=""
 S LRMSG(2)=" Validating MASTER LABORATORY TEST File (#66.3) Cross Reference's"
 S LRMSG(3)=""
 D MES^XPDUTL(.LRMSG)
 ;
 S DIK="^LRMLTF("
 D IXALL2^DIK,IXALL^DIK
 ;
 S LRMSG(1)=""
 S LRMSG(2)=" MASTER LABORATORY TEST File (#66.3) Cross Reference's Are Validated"
 S LRMSG(3)=""
 D MES^XPDUTL(.LRMSG)
