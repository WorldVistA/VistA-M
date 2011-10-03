PRCVRCA ;WOIFO/SC-SEND RIL CANCELLATION TO DYNAMED ; 5/31/05 2:24pm
 ;;5.1;IFCAP;**81**;Oct 20, 2000
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;PRCVRCA is called by routine PRCSRIE1.
 ;This routine is extracting RIL cancellation data and passing it to
 ;routine PRCVEE1 which formats data into HL7 Message and then
 ;sends data to DynaMed. It also updates relevant info in Audit File
 ;#414.02. A bulletin is send if DM DOC ID is missing from an item
 ;or if record doesn't get updated properly in Audit File.
 ;
EN(PRCVDA) ;
 ;  Input PRCVDA = ien of top entry of the file
 ;quit if system parameter is not set to DynaMed
 N PRCVSYS
 S PRCVSYS=$$GET^XPAR("SYS","PRCV COTS INVENTORY",1,"Q")
 Q:PRCVSYS'=1
 ;
 N PRCVRIEN,PRCVDUZ,PRCVNO,PRCVIT,PRCVEXTN,PRCVFLDS
 N PRCVSTA,CNT,PRCVTM,PRCVCRDT,PRCVPGDT,PRCVL,PRCVDT
 N PRCVI,PRCVJ,PRCVK,PRCVDID,PRCVITN,PRCVQTY,PRCVCOST,PRCVDNB
 N PRCVDTCR,PRCVNAM,PRCVIEN,PRCVTIME,PRCVOCD,PRCVNAME
 N PRCVFCP,PRCVTMGL,PRCVDMRL
 ;
 S PRCVDUZ=DUZ
 S PRCVRIEN=PRCVDA
 S PRCVTIME=$H
 S PRCVEXTN=$$GET1^DIQ(410.3,PRCVRIEN_",",.01) ;.01 value of RIL trx
 ;
 ;Quit if RIL .01 value is not found in Audit File 414.02 'C' x-ref
 S PRCVDMRL=""
 S PRCVDMRL=$O(^PRCV(414.02,"C",PRCVEXTN,PRCVDMRL)) Q:PRCVDMRL=""
 ;
 S PRCVFCP=$P($G(PRCVEXTN),"-",4)
 S PRCVNO="PRCVUP*"_PRCVEXTN ; Ext val in XTMP
 ;S PRCVNO="PRCVUP*"_PRCVRIEN ; IEN in setting up XTMP global
 S PRCVSTA=$$GET1^DIQ(4,$$KSP^XUPARAM("INST")_",",99)
 S PRCVNAME=$$GET1^DIQ(200,PRCVDUZ_",",.01,"E")
 ;
 S CNT=0
 K ^XTMP(PRCVNO,PRCVTIME)
 D SETUP0 ; set up XTMP global's zero node
 D ITEM ;   process all of the items
 I CNT>0 D SETUP1 ; if there is a line item then set Node 1
 I CNT'>0 K ^XTMP(PRCVNO,PRCVTIME)
 ;Call HL7 Message builder routine ONLY if there are DM line items
 ;PRCVNO is comprised of "PRCVUP*Trx#" & Trx#: Sta-fy-Qtr-FCP-cc-seq#
 ;PRCVTIME is time stamp in $H format
 I CNT>0 D BEGIN^PRCVEE1(PRCVNO,PRCVTIME) ; passing EXT value .01
 D EXIT
 Q
 ;
ITEM ;
 ;N PRCVARR
 S PRCVI=0
 F  S PRCVI=$O(^PRCS(410.3,PRCVRIEN,1,PRCVI)) Q:PRCVI'>0!(+PRCVI=0)  D
 . N PRCVARR
 . S PRCVFLDS=".01;1;2;3;4;6;7"
 . D GETS^DIQ(410.31,PRCVI_","_PRCVRIEN_",",PRCVFLDS,"I","PRCVARR")
 . D SETUP ; DO a setup in XTMP struct
 . Q
 Q
 ;
 ;
SETUP ;set up XTMP ITEM node(S) & UPDATE audit file for each item on a RIL
 ;Order Control code^Item ien^Qty^Vendor ien^^Cost^DynaMed doc ID^Date Needed By
 ;
 S PRCVOCD="CA" ; order control code  ALWAYS=CA for RIL cancel
 S PRCVITN=PRCVARR(410.31,PRCVI_","_PRCVRIEN_",",.01,"I") ;item ien N0P1
 S PRCVDID=PRCVARR(410.31,PRCVI_","_PRCVRIEN_",",6,"I") ;DM docId N0P7
 S PRCVQTY=PRCVARR(410.31,PRCVI_","_PRCVRIEN_",",1,"I") ; qty N0P2
 S PRCVNAM=PRCVARR(410.31,PRCVI_","_PRCVRIEN_",",2,"I") ;vendor text name N0P3
 S PRCVCOST=PRCVARR(410.31,PRCVI_","_PRCVRIEN_",",3,"I") ;est unit cost N0P4
 S PRCVIEN=PRCVARR(410.31,PRCVI_","_PRCVRIEN_",",4,"I") ;vendor ien N0P5
 S PRCVDNB=PRCVARR(410.31,PRCVI_","_PRCVRIEN_",",7,"I") ;dt needed by N0P8
 I $G(PRCVDID)="" D IDBULET Q  ; I DMdocid is missing send a bulletin
 ;
 ;
 S CNT=CNT+1
 S $P(^XTMP(PRCVNO,PRCVTIME,2,CNT),"^",1)=PRCVOCD
 S $P(^XTMP(PRCVNO,PRCVTIME,2,CNT),"^",2)=PRCVITN
 S $P(^XTMP(PRCVNO,PRCVTIME,2,CNT),"^",3)=PRCVQTY
 S $P(^XTMP(PRCVNO,PRCVTIME,2,CNT),"^",4)=PRCVIEN
 S $P(^XTMP(PRCVNO,PRCVTIME,2,CNT),"^",6)=PRCVCOST
 S $P(^XTMP(PRCVNO,PRCVTIME,2,CNT),"^",7)=PRCVDID
 S $P(^XTMP(PRCVNO,PRCVTIME,2,CNT),"^",8)=PRCVDNB
 ;
 ;update Audit File 414.02 for RIL cancel fields 8 and 9
 ;#8 Date/Time removed from IFCAP      #9 Who deleted
 D NOW^%DTC
 N PRCVZ,PRCVX
 S PRCVZ=0
 S PRCVZ=$O(^PRCV(414.02,"B",PRCVDID,PRCVZ))
 I +$G(PRCVZ)'>0 D RDBULET Q  ; if record is missing fr 414.02 file
 ;S PRCVX(414.02,PRCVZ_",",1)=PRCVITN ; item ien
 ;S PRCVX(414.02,PRCVZ_",",2)=PRCVIEN ; vendor ien
 ;S PRCVX(414.02,PRCVZ_",",4)=PRCVEXTN ;    RIL .01 value
 S PRCVX(414.02,PRCVZ_",",8)=% ;           int dt/time for removing
 S PRCVX(414.02,PRCVZ_",",9)=PRCVDUZ ;     who deleted
 D UPDATE^DIE("","PRCVX")
 I $D(^TMP("DIERR",$J)) D  Q
 . S XMB(1)="cancelling a Repetitive Item Entry (RIL)#: "_$G(PRCVEXTN)
 . S XMB(2)=$G(PRCVDID)
 . S XMB(3)="ERROR while updating the AUDIT FILE #414.02"
 . K ^TMP($J,"PRCVRCA") S PRCVTMGL="PRCVRCA"
 . S ^TMP($J,"PRCVRCA",1,0)=""
 . S ^TMP($J,"PRCVRCA",2,0)="RIL #: "_$G(PRCVEXTN)
 . S ^TMP($J,"PRCVRCA",3,0)="Item's IEN: "_$G(PRCVITN)
 . S ^TMP($J,"PRCVRCA",4,0)="DM DOC ID: "_$G(PRCVDID)
 . S ^TMP($J,"PRCVRCA",5,0)="Deleted By: "_$G(PRCVNAME)_"  (DUZ: "_$G(PRCVDUZ)_")"
 . S ^TMP($J,"PRCVRCA",6,0)="Date/Time of deletion: "_$G(PRCVTM)
 . S ^TMP($J,"PRCVRCA",7,0)="Error Text: "_$G(^TMP("DIERR",$J,1,"TEXT",1))
 . D DMERXMB^PRCVLIC(PRCVTMGL,PRCVSTA,PRCVFCP)
 Q
 ;
SETUP0 ;set up XTMP 0 node
 D NOW^%DTC,YX^%DTC
 S PRCVTM=Y ;date/time in ext format
 S PRCVCRDT=DT
 S PRCVPGDT=$$FMADD^XLFDT(DT,5) ; purge XTMP global in 5 days
 ;adding this extra 0 node to comply w SACC 4/28/05
 S ^XTMP(PRCVNO,0)=PRCVPGDT_"^"_PRCVCRDT_"^"_"RIL Cancellation Update to DynaMed"
 S $P(^XTMP(PRCVNO,PRCVTIME,0),"^",1)=PRCVPGDT
 S $P(^XTMP(PRCVNO,PRCVTIME,0),"^",2)=PRCVCRDT
 S $P(^XTMP(PRCVNO,PRCVTIME,0),"^",3)="RIL Cancellation Update to DynaMed: "_PRCVTM
 Q
 ;
SETUP1 ;set up XTMP 1 node
 ;Number of records^Site^Date/Time msg created^DUZ^Entered By Last Name^Entered By First Name^ien of the record
 ;
 S PRCVDTCR=$$GET1^DIQ(410.3,PRCVRIEN_",",4) ; Trx dt/tm in IFCAP
 I $D(PRCVNAME),PRCVNAME]"" D NAMECOMP^XLFNAME(.PRCVNAME)
 S $P(^XTMP(PRCVNO,PRCVTIME,1),"^",1)=CNT ;       total no of items
 S $P(^XTMP(PRCVNO,PRCVTIME,1),"^",2)=PRCVSTA ;   Sta
 ;S $P(^XTMP(PRCVNO,PRCVTIME,1),"^",3)=PRCVDTCR ; dt/time created
 S $P(^XTMP(PRCVNO,PRCVTIME,1),"^",3)=PRCVDUZ ;   DUZ
 S $P(^XTMP(PRCVNO,PRCVTIME,1),"^",4)=PRCVNAME("FAMILY")
 S $P(^XTMP(PRCVNO,PRCVTIME,1),"^",5)=PRCVNAME("GIVEN")
 S $P(^XTMP(PRCVNO,PRCVTIME,1),"^",6)=PRCVRIEN ;  ien of RIL
 Q
 ;
IDBULET ; send a bulletin if DM DOC ID is missing
 I PRCVDID="" D  Q
 . S XMB(1)="cancelling a Repetitive Item Entry (RIL)#: "_$G(PRCVEXTN)
 . S XMB(2)="    ...None Found"
 . S XMB(3)="The line item ien: "_$G(PRCVITN)_" is missing it's DM DOC ID"
 . K ^TMP($J,"PRCVRCA") S PRCVTMGL="PRCVRCA"
 . S ^TMP($J,"PRCVRCA",1,0)=""
 . S ^TMP($J,"PRCVRCA",2,0)="RIL #: "_$G(PRCVEXTN)
 . S ^TMP($J,"PRCVRCA",3,0)="Item's IEN: "_$G(PRCVITN)
 . S ^TMP($J,"PRCVRCA",4,0)="Vendor Name: "_$G(PRCVNAM)
 . S ^TMP($J,"PRCVRCA",5,0)="Deleted By: "_$G(PRCVNAME)_"  (DUZ: "_$G(PRCVDUZ)_")"
 . S ^TMP($J,"PRCVRCA",6,0)="Date/Time of deletion: "_$G(PRCVTM)
 . D DMERXMB^PRCVLIC(PRCVTMGL,PRCVSTA,PRCVFCP)
 Q
 ;
 ;PRCVZ - record in Audit File
RDBULET ;if record is missing from file 414.02
 I PRCVZ']"" D  Q
 . S XMB(1)="processing a cancel of a Repetitive Item Entry (RIL)#: "_$G(PRCVEXTN)
 . S XMB(2)=$G(PRCVDID)
 . S XMB(3)="the record related to DM DOC ID is missing in AUDIT FILE #414.02"
 . K ^TMP($J,"PRCVRCA") S PRCVTMGL="PRCVRCA"
 . S ^TMP($J,"PRCVRCA",1,0)=""
 . S ^TMP($J,"PRCVRCA",2,0)="RIL #: "_$G(PRCVEXTN)
 . S ^TMP($J,"PRCVRCA",3,0)="DM DOC ID: "_$G(PRCVDID)
 . S ^TMP($J,"PRCVRCA",4,0)="Item's IEN: "_$G(PRCVITN)
 . D DMERXMB^PRCVLIC(PRCVTMGL,PRCVSTA,PRCVFCP)
 Q
 ;
EXIT ;kill variables and quit
 K %,X,Y
 Q
 ;
 ;
