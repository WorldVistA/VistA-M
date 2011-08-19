PRCVLIC ;WOIFO/BMM - update message for 2237 line item cancel; 2/11/05 ; 3/24/05 2:50pm
V ;;5.1;IFCAP;**81**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 Q
 ;
EN ;code to send update to DM notifying of canceled line item
 ;in 2237
 ;DA, DA(1) are defined since this code is called from a MUMPS
 ;cross-reference
 ;
 ;do not process if 2237 # not cross-referenced in DynaMed IFCAP
 ;Audit file #414.02
 ;
 ;FIELDS RETRIEVED:
 ;.01 - transaction number
 ;.5 - station number
 ;5 - Dt requested
 ;12 - vendor number
 ;
 ;OTHER DATA RETRIEVED:
 ;DUZ - PRCVDZ
 ;PRCVLN, PRCVFN - last name, first name from New Person (#200)
 ;
 Q:$$GET^XPAR("SYS","PRCV COTS INVENTORY",1,"Q")'=1
 N PRCVA,PRCVFH,PRCVNM
 ;create PRCVA array of header fields in 410
 S PRCVFH=".01;.5;5;12"
 D GETS^DIQ(410,DA(1)_",",PRCVFH,"I","PRCVA")
 ;quit if 2237# not in 414.02
 Q:'$D(^PRCV(414.02,"D",PRCVA(410,DA(1)_",",.01,"I")))
 D:'$D(DT) DT^DICRW
 ;add other data to PRCVA
 S PRCVA(410,DA(1)_",","DT")=$$NOW^XLFDT
 S PRCVA(410,DA(1)_",","DT7")=$$FMADD^XLFDT($$NOW^XLFDT,7,"","","")
 S PRCVA(410,DA(1)_",","DUZ")=DUZ,PRCVNM=$$GET1^DIQ(200,DUZ_",",.01)
 S PRCVA(410,DA(1)_",","LN")=$P(PRCVNM,",")
 S PRCVA(410,DA(1)_",","FN")=$P(PRCVNM,",",2)
 S PRCVA(410,DA(1)_",","DA1")=DA(1)
 ;add PRCVA to data in job
 M X1(9999)=PRCVA(410,DA(1)_",")
 ;call Kernel API, job off rest
 D OPKG^XUHUI("","PRCV 410 2237 LINE ITEM CANCEL","K","AH")
 K X1(9999)
 ;
 Q
 ;
CREATEM ;use data from 410 and 441 to create ^XTMP structure for sending
 ;message to DynaMed
 ;
 ;XUHUIX1 ARRAY SHOULD BE:
 ;XUHUIX1(9999,.01,"I") - transaction number (file 410, field .01)
 ;XUHUIX1(9999,.5,"I") - station number (410, 0.5)
 ;XUHUIX1(9999,5,"I") - date requested (410, 5)
 ;XUHUIX1(9999,12,"I") - vendor number (410, 12)
 ;XUHUIX1(9999,"DT") - FM date now
 ;XUHUIX1(9999,"DT7") - FM date 7 days from now
 ;XUHUIX1(9999,"DUZ") - user DUZ
 ;XUHUIX1(9999,"FN") - user first name
 ;XUHUIX1(9999,"LN") - user last name
 ;XUHUIX1(9999,"DA1") - DA(1), IEN of 2237 in 410
 ;XUHUIX1(1) - LINE ITEM NUMBER  (410.02,.01)
 ;XUHUIX1(2) - QUANTITY  (410.02,2)
 ;XUHUIX1(3) - UNIT OF PURCHASE  (410.02,3)
 ;XUHUIX1(4) - BOC  (410.02,4)
 ;XUHUIX1(5) - ITEM MASTER FILE NO.  (410.02,5)
 ;XUHUIX1(6) - STOCK NUMBER  (410.02,6)
 ;XUHUIX1(7) - EST. ITEM (UNIT) COST  (410.02,7)
 ;XUHUIX1(8) - DM DOC ID  (410.02,17)
 ;XUHUIX1(9) - DATE NEEDED BY  (410.02,18)
 ;
 ;other variables/data:
 ;PRCVST - station number
 ;PRCVNIF - NIF #
 ;PRCVPM - packaging multiple
 ;PRCVFV - FMS Vendor #
 ;PRCV2237 - ^XTMP message id
 ;PRCVNR - number of records (always 1)
 ;
 N PRCV2237,PRCVCT,PRCVDTD,PRCVDZ,PRCVFV,PRCVH,PRCVLI,PRCVND
 N PRCVNR,PRCVOCC,PRCVUP,PRCVPM,PRCVST,PRCVUM
 S PRCVH=$H,PRCVOCC="CA",PRCVNR=1,(PRCVUP,PRCVND,PRCVUM)=""
 S (PRCVPM,PRCVFV)=0
 S PRCVST=$$GET1^DIQ(4,$$KSP^XUPARAM("INST")_",",99)
 ;S PRCVST=XUHUIX1(9999,.5,"I")
 ;now- line items in PRCVLI, rest in XUHUIX1
 ;get NIF#, pkging multiple from 441
 S PRCVITM=XUHUIX1(5),PRCVVN=XUHUIX1(9999,12,"I")
 S PRCVNIF=$$GET1^DIQ(441,PRCVITM_",",51)
 S PRCVPM=$$GET1^DIQ(441.01,PRCVVN_","_PRCVITM_",",1.6)
 S PRCVFV=$$GET1^DIQ(440,PRCVVN_",",34)
 S PRCVUP=$P($G(^PRCD(420.5,XUHUIX1(3),0)),U)
 ;now- build ^XTMP
 S PRCV2237="PRCVUP*"_XUHUIX1(9999,.01,"I")
 ;0 node
 S PRCVND=XUHUIX1(9999,"DT7")_"^"_XUHUIX1(9999,"DT")
 K ^XTMP(PRCV2237,PRCVH)
 S PRCVUM="^Transmit message to DynaMed for updates"
 S ^XTMP(PRCV2237,0)=PRCVND_PRCVUM
 S ^XTMP(PRCV2237,PRCVH,0)=PRCVND_"^Line item cancel message to DynaMed"
 ;1 node
 S PRCVND=PRCVNR_"^"_PRCVST_"^"_XUHUIX1(9999,"DUZ")
 S PRCVND=PRCVND_"^"_XUHUIX1(9999,"LN")_"^"_XUHUIX1(9999,"FN")
 S PRCVND=PRCVND_"^"_XUHUIX1(9999,"DA1")
 S ^XTMP(PRCV2237,PRCVH,1)=PRCVND
 ;2 node
 S PRCVND=PRCVOCC_"^"_XUHUIX1(5)_"^"_XUHUIX1(2)
 S PRCVND=PRCVND_"^"_XUHUIX1(9999,12,"I")_"^"_PRCVFV
 S PRCVND=PRCVND_"^"_XUHUIX1(7)_"^"_XUHUIX1(8)_"^"_XUHUIX1(9)
 S PRCVND=PRCVND_"^"_PRCVUP_"^"_XUHUIX1(6)_"^"_PRCVPM
 S PRCVND=PRCVND_"^"_$P(XUHUIX1(4)," ")_"^"_PRCVNIF
 S ^XTMP(PRCV2237,PRCVH,2,1)=PRCVND
 ;
 ;call Vic's code to process the data you put in ^XTMP
 D BEGIN^PRCVEE1(PRCV2237,PRCVH)
 ;
 ;update Audit file
 D UPDAUD
 ;
 Q
 ;
UPDAUD ;update the Audit file entry for this DM Doc ID
 ;XUHUIX1(8) is DM Doc ID
 ;adding 2237# (414.02 #7), Date/Time Removed From IFCAP
 ;(414.02, 8), and Who Deleted (414.02, 9)
 ;
 ;note: the error of DM Doc ID being null won't happen here because
 ;this code isn't called unless the protocol "PRCV 410 2237 LINE ITEM
 ;CANCEL" fires, and that won't fire unless the cross reference on the
 ;410.02 Line Item field fires, and that won't happen if the DM Doc ID
 ;field of the 2237 line item being canceled is NULL.
 ;
 N PRCVAIEN,PRCVMSG,PRCVADR
 S PRCVAIEN=$O(^PRCV(414.02,"B",XUHUIX1(8),0))
 ;if no entry found in Audit file, send bulletin
 I PRCVAIEN="" D  Q
 . S XMB(1)="canceling a line item during edit of 2237 #"
 . S XMB(1)=XMB(1)_XUHUIX1(9999,.01,"I")
 . S XMB(2)=XUHUIX1(8)
 . S XMB(3)="the item is missing from the DynaMed Audit file (#414.02)"
 . K ^TMP($J,"PRCVLIC") S PRCVTMP="PRCVLIC"
 . S ^TMP($J,"PRCVLIC",1,0)=""
 . S ^TMP($J,"PRCVLIC",2,0)="2237 #: "_XUHUIX1(9999,.01,"I")
 . S ^TMP($J,"PRCVLIC",3,0)="Date/time deleted: "_XUHUIX1(9999,"DT")
 . S ^TMP($J,"PRCVLIC",4,0)="Who deleted: "_XUHUIX1(9999,"LN")_","_XUHUIX1(9999,"FN")_" ("_XUHUIX1(9999,"DUZ")_")"
 . S ^TMP($J,"PRCVLIC",5,0)="Item #: "_XUHUIX1(5)
 . S PRCVFCP=$P(XUHUIX1(9999,.01,"I"),"-",4)
 . S PRCVST=XUHUIX1(9999,.5,"I")
 . D DMERXMB(PRCVTMP,PRCVST,PRCVFCP)
 ;
 N PRCVA
 S PRCVA(414.02,PRCVAIEN_",",7)=XUHUIX1(9999,.01,"I")
 S PRCVA(414.02,PRCVAIEN_",",8)=XUHUIX1(9999,"DT")
 S PRCVA(414.02,PRCVAIEN_",",9)=XUHUIX1(9999,"DUZ")
 D FILE^DIE("","PRCVA")
 ;
 I $D(^TMP("DIERR",$J)) D  Q
 . S XMB(1)="canceling a line item during edit of 2237 #"
 . S XMB(1)=XMB(1)_XUHUIX1(9999,.01,"I")
 . S XMB(2)=XUHUIX1(8)
 . S XMB(3)="error while updating DynaMed Audit file (#414.02)"
 . K ^TMP($J,"PRCVLIC") S PRCVTMP="PRCVLIC"
 . S ^TMP($J,"PRCVLIC",1,0)=""
 . S ^TMP($J,"PRCVLIC",2,0)="2237 #: "_XUHUIX1(9999,.01,"I")
 . S ^TMP($J,"PRCVLIC",3,0)="Item #: "_XUHUIX1(5)
 . S ^TMP($J,"PRCVLIC",4,0)="Date/time deleted: "_XUHUIX1(9999,"DT")
 . S ^TMP($J,"PRCVLIC",5,0)="Who deleted: "_XUHUIX1(9999,"LN")_","_XUHUIX1(9999,"FN")_" ("_XUHUIX1(9999,"DUZ")_")"
 . S ^TMP($J,"PRCVLIC",6,0)="Error text: "_$G(^TMP("DIERR",$J,1,"TEXT",1))
 . S PRCVFCP=$P(XUHUIX1(9999,.01,"I"),"-",4)
 . S PRCVST=XUHUIX1(9999,.5,"I")
 . D DMERXMB(PRCVTMP,PRCVST,PRCVFCP)
 Q
 ;
DMERXMB(PRCVTMP,PRCVST,PRCVFCP) ;create a bulletin to send to FCP users 
 ;notifying of line item missing a DM Doc ID value or error 
 ;updating the Audit file.
 ;
 ;the bulletin has these variable components:
 ;XMB - bulletin name (PRCV_AUDIT_FILE_ERROR)
 ;XMB(1) - action/event/identifier ex. "line item cancel during edit 
 ;  of 2237 #516-05-2-076-0445"
 ;XMB(2) - DM Doc ID value
 ;XMB(3) - error reason, either "an error updating the Audit file" or
 ;  "the item was missing its DynaMed Doc ID value" 
 ;XMTEXT - overflow global in ^TMP, contains values that would've
 ;  been added to Audit file had error not occurred
 ;XMSUB - set in Bulletin file, "ERROR UPDATING DYNAMED AUDIT FILE"
 ;XMY - array of FCP users to receive bulletin, built in GETFCPU
 ;XMDUZ - new value ensures bulletin is seen by user as new mail
 ;
 ;input parameters
 ;PRCVTMP - suscript for ^TMP array in bulletin
 ;PRCVFCP - fund control point
 ;PRCVST - station number
 ;
 N XMY,XMDUZ
 I $G(PRCVTMP)'="" S XMTEXT="^TMP($J,"""_PRCVTMP_""","
 S XMB="PRCV_AUDIT_FILE_ERROR"
 S XMDUZ="DOCUMENT PROCESSOR"
 ;D GETFCPU(.XMY,PRCVST,PRCVFCP)
 ;send to special mail group
 S XMY("G.PRCV Audit File Alerts")=""
 D ^XMB
 Q
 ;
GETFCPU(PRCVXMY,PRCVST,PRCVFCP) ;retrieve all the FCP users who are Control
 ;Point Officials or Control Point Clerks and are enabled to
 ;receive the bulletin
 ;PRCVFCP is fund control point
 ;PRCVST is station number
 ;
 N A,I,PRCVX K PRCVXMY
 S PRCVX="",PRCVFCP=+PRCVFCP
 F I=0:0 S PRCVX=$O(^PRC(420,PRCVST,1,PRCVFCP,1,PRCVX)) Q:PRCVX=""  D
 . S A=$G(^(PRCVX,0))
 . I $P(A,U,3)="Y",($P(A,U,2)=1!($P(A,U,2)=2)) S PRCVXMY(PRCVX)=""
 ;S (PRCVXMY(36002),PRCVXMY(35994),PRCVXMY(35993))=""
 Q
 ;
CHKDM(PRCVSUB) ;function that checks if the given value in PRCVSUB
 ;is in the Audit file index passed in PRCVIND.
 ;1=yes, 0=no
 ;
 N PRCVP2,PRCVPC,PRCVPI,PRCVVAL
 S (PRCVPI,PRCVP2,PRCVVAL)=0
D1 I $D(^PRCV(414.02,"D",PRCVSUB)) S PRCVVAL=1 G EX
 ;not there, check for child
 S PRCVPI=$O(^PRCS(410,"B",PRCVSUB,0))
 I +PRCVPI=0 G EX
 S PRCVPC=$P($G(^PRCS(410,PRCVPI,10)),U,2)
 I +PRCVPC=0 G EX
 S PRCVSUB=PRCVPC G D1
EX Q PRCVVAL
 ;
