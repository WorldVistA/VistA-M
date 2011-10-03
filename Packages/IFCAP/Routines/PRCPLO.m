PRCPLO ;WOIFO/RLL/VAC/DAP-days of stock on hand report ; 2/26/07 1:53pm
 ;;5.1;IFCAP;**83,98**;Oct 20, 2000;Build 37
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ; Note: This routine was copied from PRCPRSOH
 ;*98 Code modification made to handle STD and ODI breakouts
 ;
 Q
ENT ; Entry Point to run Program
 L +^PRCP(446.7,"STATUS"):3 I $T=0 S PRCPMSG(1)="Error encountered when attempting to run CLO GIP Reports due to other CLRS extracts in progress, please try again later." D MAIL^PRCPLO3 Q
 N TOSTDCNT,TOODICNT,TOALLCNT,TOTCNT,VALUES
 D PRCPRINV  ; Run the logic from PRCPRSOH, get params
 D BLDFIL  ; Build the output data
 D GETVAL  ; Set the ^DIE Entries in 446.7
 L -^PRCP(446.7,"STATUS")
 ;
 K ^TMP($J,"PRCPSOH") ;kill off tmp data
 K ^TMP($J,"PRCPLO")  ;kill off tmp data
 K ^TMP($J,"PRCPSOH2") ; kill off ODI tmp data
 K ^TMP($J,"PRCPLO2") ;kill off ODI tmp data
 Q
 ;
 ;
PRCPRINV ; run INV Point
 N CLRSFLAG
 S CLRSFLAG="SOH"
 D GETIPT^PRCPLO1
 Q
EN1 ; Added return from PRCPLO1
 ; Q
 N DATEEND,DATEENDD,DATESTRD,DATESTRT,DAYSLEFT,DIR,GROUPALL,PRCPDAYS,PRCPEND,PRCPSTRT,PRCPTYPE,TOTALDAY,X,X1,X2,Y,MNT,TODAY
 N ODICNT,ODIDOL,ODIFLAG,ODIFLG,STDCNT,STDDOL
 ;
 ; *83 The following was edited to always enter the LAST DAY
 ; of the previous month as the end date. End date for Oct 31, 2005
 ; in FM 3051031, can also use 3051100 equivalent for date sort
 ; this way, you do not have to handle months w/ 28, 29, 30 or 31 days
 D NOW^%DTC S TODAY=X,Y=$E(X,1,3),MNT=$E(X,4,5)
 S MNT=+(MNT)
 S MNT=MNT-1
 I MNT=0 S MNT=12,Y=Y-1
 I $L(MNT)=1 S MNT=0_MNT
 ;
 ; *83 Added day logic to handle month/leap year, etc.
 N DAYS,CKF
 S DAYS=$P("31^28^31^30^31^30^31^31^30^31^30^31",U,+(MNT))
 S DATEEND=Y_MNT_DAYS
 I DAYS=28  D
 . S CKF=(17+$E(DATEEND))_$E(DATEEND,2,3)
 . S DAYS=$S(CKF#400=0:29,(CKF#4=0&(CKF#100'=0)):29,1:28)
 . S DATEEND=Y_MNT_DAYS
 . Q
 ; S DATEEND=Y_MNT_"00"
 ; *83 The following was edited to always enter a 90 day previous
 ; to current date of report run (check param file, could change)
 ; for the DATESTRT. Once DATEEND and DATESTRT are determined, we
 ; can use the existing code to set the other variables
 S X1=TODAY
 ; *83 Report range supplied by site parameter and defaulted to 180
 S X2=$$GET^XPAR("SYS","PRCPLO REPORT RANGE",1,"Q")
 I X2="" S X2=180
 S X2=(X2*-1)
 D C^%DTC S DATESTRT=$E(X,1,5)_"01"
 ; DATEEND and DATESTRT are set above, pass them to existing
 ; logic below to set remaining variables
 S X1=DATEEND,X2=DATESTRT D ^%DTC S TOTALDAY=X+1
 S Y=DATEEND D DD^%DT S DATEENDD=Y,Y=DATESTRT D DD^%DT S DATESTRD=Y
 ;
 ;*83 Set PRCPTYPE=2 (always GREATER)
 S PRCPTYPE=2
 ;
 ;*83 PRCPDAYS is set based on value of CLRS GREATER THAN RANGE parameter
 ;if no value is presented in the parameter, it will default to 90
 ;
 S PRCPDAYS=$$GET^XPAR("SYS","PRCPLO GREATER THAN RANGE",1,"Q")
 I PRCPDAYS="" S PRCPDAYS=90
 ;
 ;*83 Return PRCPSTRT="" and PRCPEND=""
 I PRCP("DPTYPE")="W" D
 . S PRCPSTRT="",PRCPEND=""
 ;
 ;*83 RETURN GROUPALL=1 to select all groups
 I PRCP("DPTYPE")'="W" D
 .   S GROUPALL=1
 . ; finished adding variables
 ;
DQ ;  queue starts here
 N AVERAGE,DATE,GROUP,GROUPNM,ITEMDA,ITEMDATA,NSN,ONHAND,TOTAL,X,Y
 K ^TMP($J,"PRCPRSOH")
 S ITEMDA=0 F  S ITEMDA=$O(^PRCP(445,PRCP("I"),1,ITEMDA)) Q:'ITEMDA  S ITEMDATA=$G(^(ITEMDA,0)) I ITEMDATA'="" D
 .   S ODIFLG=1  S ODIFLAG=$$ODITEM^PRCPUX2(PRCP("I"),ITEMDA)
 .   I ODIFLAG="Y" S ODIFLG=2
 .   S TOTCNT(PRCP("I"),ODIFLG)=+$G(TOTCNT(PRCP("I"),ODIFLG))+1
 .   I $$REUSABLE^PRCPU441(ITEMDA) Q
 .   ;  calculate total usage between dates
 .   S DATE=$E(DATESTRT,1,5)-.01,TOTAL=0 F  S DATE=$O(^PRCP(445,PRCP("I"),1,ITEMDA,2,DATE)) Q:'DATE!(DATE>$E(DATEEND,1,5))  S TOTAL=TOTAL+$P($G(^(DATE,0)),"^",2)
 .   S AVERAGE=$J(TOTAL/TOTALDAY,0,2),ONHAND=$P(ITEMDATA,"^",7)+$P(ITEMDATA,"^",19)
 .   S DAYSLEFT=$S('AVERAGE&(ONHAND):9999999,'AVERAGE:0,1:ONHAND/AVERAGE\1)
 .   I PRCPTYPE=1,DAYSLEFT'<PRCPDAYS Q
 .   I PRCPTYPE=2,DAYSLEFT'>PRCPDAYS Q
 .   ;  sort for whse
 .   I PRCP("DPTYPE")="W" D  Q
 .   .   S NSN=$$NSN^PRCPUX1(ITEMDA) S:NSN="" NSN=" "
 .   .   I $E(NSN,1,$L(PRCPSTRT))'=PRCPSTRT,$E(NSN,1,$L(PRCPEND))'=PRCPEND I NSN']PRCPSTRT!(PRCPEND']NSN) Q
 .   .   ; S ^TMP($J,"PRCPRSOH",NSN,ITEMDA)=TOTAL_"^"_AVERAGE_"^"_ONHAND_"^"_$P(DAYSLEFT,".")_"^"_$P(ITEMDATA,"^",27)
 .   .   N ITMCHK
 .   .   S ITMCHK=0,ITMCHK=$O(^PRCP(445,PRCP("I"),1,ITMCHK))
 .   .   Q:ITMCHK=""!(+(ITMCHK)<1)
 .   .   Q:+(ITMCHK)<1  ; made it to x-ref
 .   .   D BLDTMP
 .   ;98* Accumulate count information
 .   S VALUES(PRCP("I"),ODIFLG)=+$G(VALUES(PRCP("I"),ODIFLG))+1
 .   ;  sort for primary and secondary
 .   S GROUP=+$P(ITEMDATA,"^",21)
 .   I 'GROUP,'$G(GROUPALL) Q
 .   I $G(GROUPALL),$D(^TMP($J,"PRCPURS1","NO",GROUP)) Q
 .   I '$G(GROUPALL),'$D(^TMP($J,"PRCPURS1","YES",GROUP)) Q
 .   S GROUPNM=$$GROUPNM^PRCPEGRP(GROUP)
 .   I GROUPNM'="" S GROUPNM=$E(GROUPNM,1,20)_" (#"_GROUP_")"
 .   S:GROUPNM="" GROUPNM=" "
 .   ;*83,  Create TMP structure for Report
 .   N ITMCHK
 .   S ITMCHK=0,ITMCHK=$O(^PRCP(445,PRCP("I"),1,ITMCHK))
 .   Q:ITMCHK=""!(+(ITMCHK)<1)
 .   Q:ITMCHK<1  ; made it to x-ref
 .   D BLDTMP
 .   Q
 Q
 ;
BLDTMP ;*83 Build ^TMP Structure for Report Server
 ;
 N INVTYPE,ITEMDESC,CSTCTR,INDAT,NUMLNIT,DATRN,DATRN1,INVPTID
 N CSTC1,CSTC2,CSTC3,CSCE1,CSCE2,V4TR,V4TR1
 ;
 S DATRN=$$FMTE^XLFDT(+DATEEND)
 S DATRN1=$P(DATRN," ",1)_","_$P(DATRN," ",3)
 S ITEMDESC=$E($$DESCR^PRCPUX1(PRCP("I"),ITEMDA),1,15)  ; item Desc
 I ITEMDESC="" S ITEMDESC="No Item Desc"
 Q:ITEMDA=""!(+(ITEMDA)<1)
 ;
 S NUMLNIT=1  ; set to 1 for each line item.
 S INVTYPE=PRCP("DPTYPE")
 I INVTYPE="" S INVTYPE="No Inv Type"
 S INDAT=$G(PRCP("PAR"))
 S INVPTID=PRCP("I")  ; inv point id #
 ; Cost Center logic
 ; Get ^PRCP(445,INVPTID,0) 7th piece (int. Cost Center #)
 ; Get ^PRCD(420.1,IntCstCtr,0) 1st piece (external format)
 S CSTC1=$G(^PRCP(445,INVPTID,0)),CSTC2=$P(CSTC1,"^",7),CSTC3=$P(CSTC1,"^",3)
 S V4TR=$P(CSTC1,"^",1),V4TR1=$P(V4TR,"-",2,99)  ; *83 look up name
 S V4TR1=$TR(V4TR1,"*","|")  ; $TR name to replace "*"'s with "|"'s
 I CSTC2'="" S CSCE1=$G(^PRCD(420.1,CSTC2,0)),CSCE2=$P(CSCE1,"^",1)
 I CSTC2="" S CSCE2="No Cost Center"
 ; *83, Set 5th Node from ITEMDESC to ITEMDA
 S ^TMP($J,"PRCPLO",V3,INVPTID,ITEMDA)=V3_"*"_DATRN1_"*"_INVPTID_"*"_V4TR1_"*"_NUMLNIT_"*"_$P(ITEMDATA,"^",27)_"*"_CSCE2_"*"_INVTYPE
 ; *98 Split information for ODI and Standard
 S ^TMP($J,"PRCPLO2",V3,INVPTID,ITEMDA,ODIFLG)=+$G(^TMP($J,"PRCPLO2",V3,INVPTID,ITEMDA,ODIFLG))+$P(ITEMDATA,"^",27)
 Q
BLDFIL ; Build output file
 N IN1,IN2,IN3,IN4,IN5,OLPV,NWPV,INDDAT,TOTDOL,LNDOL,CSTCTR,LNCT,PRCPDX,INPTVAL,POINT,STID,DTTM,INVVTYP,INVPTLN
 S IN1=0,IN2=0,IN3=0,IN4=0,IN5="INVPT",INDDAT=0,OLPV=0,NWPV=0,LNCT=0,CSTCTR=0,TOTDOL=0,LNDOL=0,INVPTLN=0
 S STDCNT=0,ODICNT=0
 S (STDDOL,ODIDOL)=0
 F  S IN1=$O(^TMP($J,"PRCPLO",IN1)) Q:IN1=""  D
 . ;S (STDDOL,ODIDOL)=0
 . F  S IN2=$O(^TMP($J,"PRCPLO",IN1,IN2)) Q:IN2=""  D
 . . I IN5'="INVPT"  D  ; init for first time through
 . . . S INVPTLN=+$P($G(^PRCP(445,+INPTVAL,1,0)),"^",4)
 . . . S TOSTDCNT=+$G(TOTCNT(IN2,1)),TOODICNT=+$G(TOTCNT(IN2,2)),TOALLCNT=TOSTDCNT+TOODICNT
 . . . S PRCPDX=STID_"*"_DTTM_"*"_INPTVAL_"*"_POINT_"*"_INVVTYP_"*"_TOTDOL_"*"_IN4_"*"_INVPTLN_"*"_CSTCTR
 . . . ; set up new ^TMP($J NODE to store totals for ^DIE set
 . . . S ^TMP($J,"PRCPSOH",+(STID_INPTVAL))=PRCPDX
 . . . S STDCNT=+$G(VALUES(INPTVAL,1)),ODICNT=+$G(VALUES(INPTVAL,2))
 . . . S TOSTDCNT=+$G(TOTCNT(INPTVAL,1)),TOODICNT=+$G(TOTCNT(INPTVAL,2))
 . . . S TOALLCNT=TOSTDCNT+TOODICNT
 . . . S ^TMP($J,"PRCPSOH2",+(STID_INPTVAL))=STDDOL_"*"_ODIDOL_"*"_(STDDOL+ODIDOL)_"*"_STDCNT_"*"_ODICNT_"*"_(STDCNT+ODICNT)_"*"_TOSTDCNT_"*"_TOODICNT_"*"_TOALLCNT
 . . . S IN4=0  ; reset to 0, begin counting Line items for INVPT
 . . . S TOTDOL=0
 . . . S LNDOL=0
 . . . S PRCPDX=""
 . . . S CSTCTR=""
 . . . S (STDDOL,ODIDOL)=0
 . . F  S IN3=$O(^TMP($J,"PRCPLO",IN1,IN2,IN3)) Q:IN3=""  D
 . . . S INDDAT=$G(^TMP($J,"PRCPLO",IN1,IN2,IN3))
 . . . S STID=$P(INDDAT,"*",1)
 . . . S DTTM=$P(INDDAT,"*",2)
 . . . S POINT=$P(INDDAT,"*",4)
 . . . S INPTVAL=$P(INDDAT,"*",3)  ; Inv Point ID# for DIE Set
 . . . S CSTCTR=$P(INDDAT,"*",7)
 . . . S LNDOL=$P(INDDAT,"*",6)
 . . . S INVVTYP=$P(INDDAT,"*",8)
 . . . S TOTDOL=TOTDOL+LNDOL
 . . . S IN4=IN4+1  ; Count # of line items in Inv Pt
 . . . S IN5=IN2  ; Invt. Point
 . . . S STDDOL=STDDOL+$G(^TMP($J,"PRCPLO2",IN1,IN2,IN3,1))
 . . . S ODIDOL=ODIDOL+$G(^TMP($J,"PRCPLO2",IN1,IN2,IN3,2))
 . . . Q
 . . Q
 . Q
 Q
GETVAL ; Get values from ^TMP($J,"PRCPSOH"
 N LP1,SOHIEN,PRCPDX
 S LP1=0
 F  S LP1=$O(^TMP($J,"PRCPSOH",LP1)) Q:LP1=""  D
 . S PRCPDX=$G(^TMP($J,"PRCPSOH",LP1))
 . S SOHIEN=+LP1
 . S DR="1///"_PRCPDX
 . D SETREC
 . S PRCPDX=$G(^TMP($J,"PRCPSOH2",LP1))
 . S DR="2///"_PRCPDX
 . D SETREC
 . Q
 Q
SETREC ; Set record using DIE in 446.7
 ;
 N PRCPDR,PRCPST,PRCPSNM,PRCPDA,PRCPDX,PRCPST,X,Y
 S PRCPDR=DR
 S DIC="^PRCP(446.7,",DIC(0)="L",DLAYGO=446.7,X=SOHIEN D ^DIC K DIC,DLAYGO
 S PRCPDA=Y+0
 S PRCPST=$P(^TMP($J,"PRCPSOH",LP1),"*",1)
 S PRCPSNM=$$GET1^DIQ(4,PRCPST_",",.01)
 ;*98 Send enhanced mail message if exception occurs during FileMan set
 I Y=-1 N PRCPMSG D  Q
 . S PRCPMSG(1)="Error saving to File #446.7 for Days of Stock on Hand Report, related data: "
 . S PRCPMSG(2)="",PRCPMSG(3)="Station: "_PRCPST_" "_PRCPSNM
 . S PRCPMSG(4)="Inventory Point: "_$P(^TMP($J,"PRCPSOH",LP1),"*",3)_" "_$P(^TMP($J,"PRCPSOH",LP1),"*",4)
 . S PRCPMSG(5)="File #446.7 Field Set Attempted: "_PRCPDR
 . D MAIL^PRCPLO3 Q
 ;
 S DIE="^PRCP(446.7,",DA=PRCPDA D ^DIE K DIE,DR,DA
 Q
