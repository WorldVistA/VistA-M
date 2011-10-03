PRCVTAP ;WOIFO/SC-2237 APPROVAL TO DYNAMED ; 5/31/05 2:30pm
 ;;5.1;IFCAP;**81**;Oct 20, 2000
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;PRCVTAP is called by routine PRCSAPP2
 ;This routine is extracting 2237 APPROVED data and passing that info
 ;to routine PRCVEE1 which formats data into HL7 Message and then
 ;sends data to DynaMed. It also updates relevant info in Audit File
 ;#414.02.  A bulletin is send if DM DOC ID is missing from an item 
 ;or if record doesn't get updated properly in Audit File.
 ;
EN(PRCVDA) ;
 ;  Input         PRCVDA = ien of top entry of the file
 ;Quit if system parameter is not set to DynaMed
 N PRCVSYS
 S PRCVSYS=$$GET^XPAR("SYS","PRCV COTS INVENTORY",1,"Q")
 Q:PRCVSYS'=1
 ;
 N PRCVRIEN,PRCVDUZ,PRCVNO,PRCVIT,PRCVEXTN,PRCVV,PRCVFLDS
 N PRCVSTA,CNT,PRCVTM,K,PRCVCRDT,PRCVPGDT,PRCVL,PRCVDT
 N PRCVI,PRCVJ,PRCVK,PRCVDID,PRCVITN,PRCVQTY,PRCVCST,PRCVDNB
 N PRCVDTCR,PRCVNAME,PRCVIEN,PRCVTIME,PRCVOCD,PRCV2IEN
 N PRCVAR,PRCVFMS,PRCVUOP,PRCVSTK,PRCVPKG,PRCVBOC,PRCVNIF
 N PRCVFCP,PRCVTMG,PRCVTT
 ;
 S PRCVDUZ=DUZ
 S PRCV2IEN=PRCVDA ; ien of the 2237 trx.
 S PRCVTIME=$H
 S PRCVEXTN=$$GET1^DIQ(410,PRCV2IEN_",",.01) ;.01 value of 2237 trx
 ;
 ;Quit if DM 2237 .01 value is not found in Audit file 414.02 'D' xref
 ;And check if child 2237 that was split has a parent 2237 (in
 ;file 410, node 10, piece 2, fld51) is recorded in Audit File 414.02
 ;'D' x-ref.
 S PRCVTT=$$CHKDM^PRCVLIC(PRCVEXTN) Q:PRCVTT'=1
 ;
 D NOW^%DTC,YX^%DTC
 S PRCVTM=Y ;date/time in ext format MAR 07, 2005@16:08
 S PRCVFCP=$P($G(PRCVEXTN),"-",4)
 S PRCVNO="PRCVUP*"_PRCVEXTN ; .01 val in the XTMP subscript
 ;S PRCVNO="PRCVUP*"_PRCV2IEN ; ien in the XTMP subscript
 S PRCVSTA=$$GET1^DIQ(4,$$KSP^XUPARAM("INST")_",",99)
 S PRCVNAME=$$GET1^DIQ(200,PRCVDUZ_",",.01,"E")
 ;
 S CNT=0
 K ^XTMP(PRCVNO,PRCVTIME)
 D SETUP0 ; set up XTMP global's zero node
 D ITEM ;   process all of the items
 I CNT>0 D SETUP1 ; if there is a line item then set Node 1
 I CNT'>0 K ^XTMP(PRCVNO,PRCVTIME)
 ;Call HL7 Message builder/transmitter routine
 ;PRCVNO is comprised of "PRCVUP*Trx#" & Trx# is Sta-fy-Qtr-FCP-seq#
 ;PRCVTIME is time stamp in $H format
 I CNT>0 D BEGIN^PRCVEE1(PRCVNO,PRCVTIME)
 D EXIT
 Q
 ;
ITEM ;
 ;N PRCVAR
 S (PRCVI,PRCVJ,PRCVL)=0
 S PRCVIEN=$$GET1^DIQ(410,PRCV2IEN_",",12,"I") ;vendor ien F410N3P4
 S PRCVFMS=$$GET1^DIQ(440,PRCVIEN_",",34,"I") ;FMS vendor ien F440N3P4
 ;
 F  S PRCVI=$O(^PRCS(410,PRCV2IEN,"IT",PRCVI)) Q:PRCVI'>0!(+PRCVI=0)  D
 . N PRCVAR
 . S PRCVFLDS="2;3;4;5;6;7;17"
 . D GETS^DIQ(410.02,PRCVI_","_PRCV2IEN_",",PRCVFLDS,"","PRCVAR")
 . S PRCVDNB=$$GET1^DIQ(410.02,PRCVI_","_PRCV2IEN_",",18,"I")
 . D SETUP ; DO a setup in XTMP struct
 . Q
 Q
 ;
 ;
SETUP ;set up XTMP ITEM node(S) & UPDATE audit file for each item on a RIL
 ;Order Control code^Item ien^Qty^Vendor ien^^Cost^DynaMed doc ID^Date Needed By^Unit of Purchase^Vendor Stock Number^Packaging Mult.^BOC^Nif #
 ;
 S PRCVOCD="NW" ; order control code for 2237 approval
 S PRCVQTY=PRCVAR(410.02,PRCVI_","_PRCV2IEN_",",2) ; qty N0P2
 S PRCVUOP=PRCVAR(410.02,PRCVI_","_PRCV2IEN_",",3) ; unit of purchase N0P3
 S PRCVBOC=PRCVAR(410.02,PRCVI_","_PRCV2IEN_",",4) ; BOC w descr N0P4
 S PRCVITN=PRCVAR(410.02,PRCVI_","_PRCV2IEN_",",5) ; item ien N0P5
 S PRCVSTK=PRCVAR(410.02,PRCVI_","_PRCV2IEN_",",6) ; stock # N0P6
 S PRCVCST=PRCVAR(410.02,PRCVI_","_PRCV2IEN_",",7) ; unit cost N0P7
 S PRCVDID=PRCVAR(410.02,PRCVI_","_PRCV2IEN_",",17) ; DM doc id N4P1
 I PRCVDID="" D  Q  ; if DM doc id is missing, send a bulletin
 . S XMB(1)="doing an approval of the 2237 #: "_PRCVEXTN
 . S XMB(2)="    ...None Found"
 . S XMB(3)="The line item ien: "_$G(PRCVITN)_" is missing it's DM DOC ID."
 . K ^TMP($J,"PRCVTAP") S PRCVTMG="PRCVTAP"
 . S ^TMP($J,"PRCVTAP",1,0)=""
 . S ^TMP($J,"PRCVTAP",2,0)="2237 #: "_$G(PRCVEXTN)
 . S ^TMP($J,"PRCVTAP",3,0)="Item's IEN: "_$G(PRCVITN)
 . D DMERXMB^PRCVLIC(PRCVTMG,PRCVSTA,PRCVFCP)
 . Q
 ;S PRCVDNB=PRCVAR(410.02,PRCVI_","_PRCV2IEN_",",18) ; dt needed in external FM format N4P2
 ;S PRCVDT=$$HLDATE^HLFNC(PRCVDNB,"DT") ; YYYYMMDD -- hl7 format
 ;S PRCVDT=$$FMTE^XLFDT(PRCVDNB,"7D") ; YYYY/M/D or YYYY/MM/DD
 S PRCVPKG=$$GET1^DIQ(441.01,PRCVIEN_","_PRCVITN_",",1.6) ; pkg mult F441.01N0P8
 S PRCVNIF=$$GET1^DIQ(441,PRCVITN_",",51) ; nif no F441N0P15
 ;
 ;
 S CNT=CNT+1
 S $P(^XTMP(PRCVNO,PRCVTIME,2,CNT),"^",1)=PRCVOCD
 S $P(^XTMP(PRCVNO,PRCVTIME,2,CNT),"^",2)=PRCVITN
 S $P(^XTMP(PRCVNO,PRCVTIME,2,CNT),"^",3)=PRCVQTY
 S $P(^XTMP(PRCVNO,PRCVTIME,2,CNT),"^",4)=PRCVIEN
 S $P(^XTMP(PRCVNO,PRCVTIME,2,CNT),"^",5)=PRCVFMS
 S $P(^XTMP(PRCVNO,PRCVTIME,2,CNT),"^",6)=PRCVCST
 S $P(^XTMP(PRCVNO,PRCVTIME,2,CNT),"^",7)=PRCVDID
 S $P(^XTMP(PRCVNO,PRCVTIME,2,CNT),"^",8)=PRCVDNB
 S $P(^XTMP(PRCVNO,PRCVTIME,2,CNT),"^",9)=PRCVUOP
 S $P(^XTMP(PRCVNO,PRCVTIME,2,CNT),"^",10)=PRCVSTK
 S $P(^XTMP(PRCVNO,PRCVTIME,2,CNT),"^",11)=PRCVPKG
 S $P(^XTMP(PRCVNO,PRCVTIME,2,CNT),"^",12)=+PRCVBOC
 S $P(^XTMP(PRCVNO,PRCVTIME,2,CNT),"^",13)=PRCVNIF
 QUIT
 ;
 ;*****************************************************************
 ;UPDATE to Audit File 414.02 is NOT needed at this time, however
 ;leaving the code in as commented lines for future use.
 ;*****************************************************************
 ;update Audit File 414.02 for 2237 approval
 ;audit file field numbers #1/#2/#3/#7/#12
 ;
 N PRCVZ,PRCVARR
 ;S PRCVZ=""
 ;S PRCVZ=$O(^PRCV(414.02,"B",PRCVDID,PRCVZ))
 ;I +$G(PRCVZ)'>0 D BULLET Q  ;if record is missing fr 414.02 file
 ;S PRCVARR(414.02,PRCVZ_",",1)=PRCVITN
 ;S PRCVARR(414.02,PRCVZ_",",2)=PRCVIEN
 ;S PRCVARR(414.02,PRCVZ_",",3)=PRCVDUZ
 ;S PRCVARR(414.02,PRCVZ_",",7)=PRCVEXTN
 ;S PRCVARR(414.02,PRCVZ_",",12)=PRCVDNB
 ;D UPDATE^DIE("","PRCVARR")
 ;I $D(^TMP("DIERR",$J)) D  Q
 ;.S XMB(1)="processing an approval of 2237 #: "_$G(PRCVEXTN)
 ;.S XMB(2)=$G(PRCVDID)
 ;.S XMB(3)="ERROR while updating AUDIT FILE #414.02"
 ;.K ^TMP($J,"PRCVTAP") S PRCVTMG="PRCVTAP"
 ;.S ^TMP($J,"PRCVTAP",1,0)=""
 ;.S ^TMP($J,"PRCVTAP",2,0)="2237 #: "_$G(PRCVEXTN)
 ;.S ^TMP($J,"PRCVTAP",3,0)="Item's IEN: "_$G(PRCVITN)
 ;.S ^TMP($J,"PRCVTAP",4,0)="DM DOC ID: "_$G(PRCVDID)
 ;.S ^TMP($J,"PRCVTAP",5,0)="Error Text: "_$G(^TMP("DIERR",$J,1,"TEXT",1))
 ;.D DMERXMB^PRCVLIC(PRCVTMG,PRCVSTA,PRCVFCP)
 ;QUIT
 ;
SETUP0 ;set up XTMP 0 node
 ;Termination Date^Entry Date^Descriptive Text_Time in ext format
 ;D NOW^%DTC,YX^%DTC
 ;S PRCVTM=Y ;date/time in ext format MAR 07, 2005@16:08
 S PRCVCRDT=DT ; DT is FM internal dt 3050307
 S PRCVPGDT=$$FMADD^XLFDT(DT,5) ; purge XTMP global in 5 days
 ;adding extra 0 node to comply w SACC std 4/28/05
 S ^XTMP(PRCVNO,0)=PRCVPGDT_"^"_PRCVCRDT_"^"_"Transmit message to DynaMed for updates"
 S $P(^XTMP(PRCVNO,PRCVTIME,0),"^",1)=PRCVPGDT
 S $P(^XTMP(PRCVNO,PRCVTIME,0),"^",2)=PRCVCRDT
 S $P(^XTMP(PRCVNO,PRCVTIME,0),"^",3)="2237 Approval Update to DynaMed: "_PRCVTM
 Q
 ;
SETUP1 ;set up XTMP 1 node
 ;Number of records^Site^DUZ^Entered By Last Name^Entered By First Name^IEN of 2237
 ;
 I $D(PRCVNAME),PRCVNAME]"" D NAMECOMP^XLFNAME(.PRCVNAME)
 S $P(^XTMP(PRCVNO,PRCVTIME,1),"^")=CNT ; total no of items
 S $P(^XTMP(PRCVNO,PRCVTIME,1),"^",2)=PRCVSTA ; Sta
 ;S $P(^XTMP(PRCVNO,PRCVTIME,1),"^",3)=PRCVDTCR ; dt/time created
 S $P(^XTMP(PRCVNO,PRCVTIME,1),"^",3)=PRCVDUZ ; DUZ
 S $P(^XTMP(PRCVNO,PRCVTIME,1),"^",4)=PRCVNAME("FAMILY")
 S $P(^XTMP(PRCVNO,PRCVTIME,1),"^",5)=PRCVNAME("GIVEN")
 S $P(^XTMP(PRCVNO,PRCVTIME,1),"^",6)=PRCV2IEN ; ien of 2237
 Q
 ;
 ;PRCVZ - record in Audit File
BULLET ;Send a bulletin if record is missing from audit file
 I PRCVZ="" D  Q
 .S XMB(1)="processing an approval of 2237 #: "_$G(PRCVEXTN)
 .S XMB(2)=$G(PRCVDID)
 .S XMB(3)="the record related to DM DOC ID is missing in AUDIT FILE #414.02"
 .K ^TMP($J,"PRCVTAP") S PRCVTMG="PRCVTAP"
 .S ^TMP($J,"PRCVTAP",1,0)=""
 .S ^TMP($J,"PRCVTAP",2,0)="2237 #: "_$G(PRCVEXTN)
 .S ^TMP($J,"PRCVTAP",3,0)="DM DOC ID: "_$G(PRCVDID)
 .S ^TMP($J,"PRCVTAP",4,0)="Item's IEN: "_$G(PRCVITN)
 .D DMERXMB^PRCVLIC(PRCVTMG,PRCVSTA,PRCVFCP)
 Q
 ;
 ;
EXIT ;kill variables and quit
 K %,X,Y
 Q
 ;
 ;
