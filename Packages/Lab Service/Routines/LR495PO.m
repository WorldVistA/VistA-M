LR495PO ;BPFO/DTG - POST INSTALL ROUTINE FOR PATCH LR*5.2*495 ;09/18/2017
 ;;5.2;LAB SERVICE;**495**;Sep 27, 1994;Build 6
 ;
 ;post install routine to save a copy of 61, 61.2, 62, 95.4 in ^XTEMP
 ;
 ;
EN ; entry for data save
 S U="^" I $G(DT)="" S DT=$$DT^XLFDT
 N WB,LRX,LRXNM,LRDTA,LRMSG
 S WB=$$SITE^VASITE,WB=$P(WB,U,1)
 S LRXNM="LR SAVE OF 61,61.2,62,95.4",LRX=0
 S LRDTA=$G(^XTMP(LRXNM,0)) S:LRDTA="" $P(LRDTA,U,3)="Save of file 61,61.2,62 and 95.4 for patch LR*5.2*495"
 S $P(LRDTA,U,1)=$$FMADD^XLFDT(DT,365),$P(LRDTA,U,2)=$$NOW^XLFDT(),^XTMP(LRXNM,0)=LRDTA
 S LRX=$G(^XTMP(LRXNM,"D",0)),LRX=LRX+1,^XTMP(LRXNM,"D",0)=LRX
 ;save 61
 M ^XTMP(LRXNM,"D",LRX,"61")=^LAB(61)
 ;save 61.2
 M ^XTMP(LRXNM,"D",LRX,"61.2")=^LAB(61.2)
 ;save 62
 M ^XTMP(LRXNM,"D",LRX,"62")=^LAB(62)
 ;save 95.4
 M ^XTMP(LRXNM,"D",LRX,"95.4")=^LAHM(95.4)
 ;
PSTDONE ; display FINISHED message
 K LRMSG
 S LRMSG(1)=""
 S LRMSG(2)=""
 S LRMSG(3)="***** Post-installation of Patch LR*5.2*495 has completed successfully. *****"
 S LRMSG(4)=""
 D MES^XPDUTL(.LRMSG)
 ;
 K WB,LRX,LRXNM,LRDTA,LRMSG
 ;
 Q
 ;
