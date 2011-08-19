PRCVIBH ;WOIFO/DST - Issue Book Processing, from DynaMed to IFCAP ;7/26/05  17:10
 ;;5.1;IFCAP;**81,86**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; IV - Internal Voucher, SV - Standard Voucher
 Q
CRT ; Process Issue Book transactions sent from DynaMed to IFCAP
 K HLERR
 N %,PRCVDT,PRCVI,PRCVJ,PRCVK,PRCVIBF,PRCVSUB,PRCVSITE
 D:'$D(U) DT^DICRW
 D NOW^%DTC S PRCVDT=%
 S PRCVSUB="PRCVFMS2;"_HL("MID")
 K ^TMP(PRCVSUB),^TMP($J,"PRCVIB")
 F PRCVI=1:1 X HLNEXT Q:HLQUIT'>0  D
 . S ^TMP($J,"PRCVIB",PRCVI)=HLNODE,PRCVJ=0
 . F  S PRCVJ=$O(HLNODE(PRCVJ)) Q:'PRCVJ  S ^TMP($J,"PRCVIB",PRCVI,PRCVJ)=HLNODE(PRCVJ)
 . Q
 ; 
MAIN ; Main routine
 ; Check HL7 message type and message event
 ; PRCVEA - Error message array
 ; PRCVTDT - Transaction Date 
 ; PRCVDAC - Document Action
 N PRCVFS,PRCVRS,PRCVCS,PRCVES,PRCVSS,PRCVCC,PRCVSCC
 N PRCVEA,PRCVTDT,PRCVBID,PRCVLID,PRCVND,PRCVSEG,PRCVY,X,X1,X2
 ;
 S PRCVK=0
 S PRCVFS=$G(HL("FS")),PRCVCS=$E($G(HL("ECH"))),PRCVRS=$E($G(HL("ECH")),2),PRCVES=$E($G(HL("ECH")),U,3),PRCVSS=$E($G(HL("ECH")),U,4)
 ;
HEADER I HL("MTN")'="DFT"!(HL("ETN")'="P03") D  Q
 . D ADDERR("PRCV1"_U_"Wrong Message or Event Type: "_HL("MTN")_U_HL("ETN"))
 . D GENACK("AR",HL("MID"),PRCVDT,.PRCVEA)
 . Q
 ;
 S X1=$P(PRCVDT,"."),X2=14 D C^%DTC
 S ^TMP(PRCVSUB,$J,0)=X_U_$P(PRCVDT,".")_"^IB Sent from DynaMed to IFCAP"
 ;
 ; Check each segments - EVN,PID,FT1
 ;   PRCVTCD - Transaction Code - "IV" or "SV"
 ;   PRCVSTN - Station Number
 ;
START N PREVSEG,PRCVSTN,PRCVDAC,PRCVTDT,PRCVTCD
 S PRCVSITE=$$GET1^DIQ(4,$$KSP^XUPARAM("INST")_",",99)
 S PREVSEG=""
 S PRCVI=0
 D NOW^%DTC S PRCVDT=%
 F  S PRCVI=$O(^TMP($J,"PRCVIB",PRCVI)) Q:'PRCVI  D
 . S PRCVND=$G(^TMP($J,"PRCVIB",PRCVI))
 . S PRCVSEG=$P(PRCVND,PRCVFS)
 . Q:PRCVSEG="MSH"!(PRCVSEG="")
 . I $$CHKSEQ(PRCVSEG) K ^TMP($J,"PRCVIB") S PRCVI="" Q
 . S PREVSEG=PRCVSEG
 . D @PRCVSEG
 . Q
 I PRCVSEG'="FT1" D ADDERR("PRCV1"_U_"No Item line for this transaction.")
 ; 
 ; If errored, send AE ACK, clean up and QUIT
ERR I $D(PRCVEA)!(PRCVTCD']"") D XTMP("AE"),FIN Q
OK ; Calling IFCAP and FMS routines for Issue Book and FMS update
 ;
 I PRCVTCD="SV" D
 . I '$$ENT^PRCVFMS2(PRCVSUB) D
 .. D ADDERR("PRCV3"_U_"Error in generating FMS Code Sheet.")
 .. D XTMP("AE")
 .. Q
 . Q
 I PRCVTCD="IV" D
 . S PRCVIBF=$$INIT^PRCVIBF(PRCVSUB)
 . ; PRCVIBF - return "IEN of 410^Error Code^Error Description"
 . ; If errored, move ^TMP to ^XTMP and quit
 . I '+PRCVIBF D  Q
 .. D ADDERR("PRCV3"_U_$P(PRCVIBF,U,2)_"-"_$P(PRCVIBF,U,3))
 .. D XTMP("AE")
 .. Q
 . I '$$ENT^PRCVFMS1(PRCVSUB,+PRCVIBF) D
 .. D ADDERR("PRCV3"_U_"Error in generating FMS Code Sheet.")
 .. D XTMP("AE")
 .. Q
 . Q
 ;
 I '$D(PRCVEA) D GENACK("AA",HL("MID"),PRCVDT)
 D FIN
 Q
 ;
CHKSEQ(SEG) ; SEG - Segment name
 N SEGERR,PREV1,PREV2,PRCVER1
 S SEGERR=0
 S PREV1=$P($P($T(@(SEG_1)),";;",2),U)
 S PREV2=$P($P($T(@(SEG_1)),";;",2),U,2)
 I PREVSEG=PREV1!(PREVSEG=PREV2) Q SEGERR
 S SEGERR=1
 S PRCVER1=$P($P($T(@(SEG_1)),";;",2),U,4)_SEG
 D ADDERR("PRCV1"_U_PRCVER1)
 Q SEGERR
 ;
EVN ; Process EVN segment
 ;
 S PRCVSTN=$P(PRCVND,PRCVFS,8)
 I PRCVSTN']"" D ADDERR("PRCV2"_U_"Station Number is missing.",8)
 I PRCVSTN'=PRCVSITE D ADDERR("PRCV2"_U_"Invalid Station Number: "_PRCVSTN,8)
 S PRCVDAC=$P(PRCVND,PRCVFS,5)
 I "EMX"'[PRCVDAC!(PRCVDAC']"") D ADDERR("PRCV2"_U_"Invalid Document Action: "_PRCVDAC,5)
 S PRCVTDT=$P(PRCVND,PRCVFS,3)
 I PRCVTDT']"" D ADDERR("PRCV2"_U_"Transaction Date is missing.",3) Q
 S PRCVTDT=$$HL7TFM^XLFDT(PRCVTDT,"L",0)
 I $P(PRCVTDT,".")>PRCVDT D ADDERR("PRCV2"_U_"Invalid Transaction Date: "_PRCVTDT,3)
 Q
 ;
PID ; Process PID segment
 ;
 N PRCVDUZ,PRCVFCP1,PRCVFCP2,PRCVBOC,PRCVTERM
 ;
 S PRCVBID=$P(PRCVND,PRCVFS,4)
 I PRCVBID']"" D ADDERR("PRCV2"_U_"Batch ID is missing.",4)
 S PRCVTCD=$P(PRCVND,PRCVFS,5)
 I PRCVTCD']"" D ADDERR("PRCV2"_U_"Transaction Code is missing.",5)
 I PRCVTCD'="IV",(PRCVTCD'="SV") D ADDERR("PRCV2"_U_"Invalid Transaction Code: "_PRCVTCD,5)
 ; Check User ID, Termination Date and is authorized FCP user
 S PRCVDUZ=$P(PRCVND,PRCVFS,3)
 I PRCVDUZ']"" D ADDERR("PRCV2"_U_"User ID is missing.",3)
 I PRCVDUZ]"" D
 . I '$$FIND1^DIC(200,"","","`"_PRCVDUZ,"","","PRCVERR") D ADDERR("PRCV2"_U_"Invalid User ID: "_PRCVDUZ,3)
 . E  D
 .. S PRCVTERM=$$GET1^DIQ(200,PRCVDUZ_",",9.2,"I")
 .. I +PRCVTERM>0,(PRCVTERM<DT) D ADDERR("PRCV2"_U_"Invalid User ID: "_PRCVDUZ,3)
 .. Q
 .Q
 S PRCVFCP1=$P(PRCVND,PRCVFS,22)
 I PRCVFCP1']"" D ADDERR("PRCV2"_U_$S(PRCVTCD="IV":"Seller's",1:"Warehouse's")_" Fund Control Point is missing.",22)
 I '$D(^PRC(420,PRCVSITE,1,+PRCVFCP1)) D ADDERR("PRCV2"_U_"Invalid "_$S(PRCVTCD="IV":"Seller's",1:"Warehouse's")_" Fund Control Point.",22)
 I $D(^PRC(420,PRCVSITE,1,+PRCVFCP1)),$P(^PRC(420,PRCVSITE,1,+PRCVFCP1,0),U,19) D ADDERR("PRCV2"_U_"Inactivated "_$S(PRCVTCD="IV":"Seller's",1:"Warehouse's")_" Fund Control Point.",22)
 I PRCVTCD="IV" D
 . S PRCVFCP2=$P(PRCVND,PRCVFS,24)
 . I PRCVFCP2']"" D ADDERR("PRCV2"_U_"Buyer's Fund Control Point is missing.",24)
 . E  D
 .. I '$D(^PRC(420,PRCVSITE,1,+PRCVFCP2)) D ADDERR("PRCV2"_U_"Invalid Buyer's Fund Control Point.",24)
 .. I $D(^PRC(420,PRCVSITE,1,+PRCVFCP2)),$P(^PRC(420,PRCVSITE,1,+PRCVFCP2,0),U,19) D ADDERR("PRCV2"_U_"Inactivated Buyer's Fund Control Point.",24)
 .. Q
 . S PRCVCC=$P(PRCVND,PRCVFS,19)
 . I PRCVCC']"" D ADDERR("PRCV2"_U_"Buyer's Cost Center is missing.",19)
 . S PRCVSCC=$P(PRCVND,PRCVFS,20)
 . I PRCVSCC']"" D ADDERR("PRCV2"_U_"Buyer's Sub-cost Center is missing.",20)
 . I PRCVCC,(PRCVSCC'="") D
 .. I '$D(^PRCD(420.1,PRCVCC_PRCVSCC)) D ADDERR("PRCV2"_U_"Invalid Buyer's Cost Center. Cost Center not defined in Cost Center file 420.1",19) Q
 .. I '$D(^PRC(420,PRCVSTN,1,+PRCVFCP2,2,PRCVCC_PRCVSCC)) D ADDERR("PRCV2"_U_"Invalid Buyer's Cost Center. Cost Center not used for this Fund Control Point.",19)
 .. Q
 . Q
 I PRCVDUZ]"",('$D(^PRC(420,PRCVSTN,1,$S(PRCVTCD="IV":+PRCVFCP2,1:+PRCVFCP1),1,PRCVDUZ))) D ADDERR("PRCV2"_U_"Unauthorized User for this FCP.",3)
 S ^TMP(PRCVSUB,$J,1)=PRCVSTN_U_PRCVBID_U_PRCVTCD_U_PRCVDAC_U_PRCVTDT_U_PRCVDUZ
 S ^TMP(PRCVSUB,$J,2)=PRCVFCP1_U_$G(PRCVFCP2)_U_$G(PRCVCC)_U_$G(PRCVSCC)
 Q
 ;
FT1 ; Process FT1 segment
 N PRCVACC,PRCVBOC,PRCVINV,PRCVSAL,PRCVRCD
 ;
 S PRCVLID=$P(PRCVND,PRCVFS,3)
 I 'PRCVLID D ADDERR("PRCV2"_U_"Line ID is missing.",3)
 S PRCVACC=$P(PRCVND,PRCVFS,9)
 I 'PRCVACC D ADDERR("PRCV2"_U_"Account Code is missing.",9)
 I PRCVACC,((PRCVACC'?1N)!("12368"'[PRCVACC)) D ADDERR("PRCV2"_U_"Invalid Account Code: "_PRCVACC,9)
 I PRCVTCD="IV" D
 . S PRCVBOC=$P(PRCVND,PRCVFS,10)
 . I PRCVBOC=2696 D ADDERR("PRCV2"_U_"Invalid Buyer's Budget Object Code: "_PRCVBOC,10)
 . I 'PRCVBOC D ADDERR("PRCV2"_U_"Budget Object Code is missing.",10)
 . I '$D(^PRCD(420.1,PRCVCC_PRCVSCC,1,PRCVBOC)) D ADDERR("PRCV2"_U_"Invalid Budget Object Code for this Cost Center: "_PRCVBOC,10)
 . I $P($G(^PRCD(420.2,PRCVBOC,0)),"^",2)=1 D ADDERR("PRCV2"_U_"Inactivated Budget Object Code: "_PRCVBOC,10)
 . S PRCVSAL=$P(PRCVND,PRCVFS,13)
 . I 'PRCVSAL D ADDERR("PRCV2"_U_"Sale Value is missing.",13)
 . Q
 S PRCVINV=$P(PRCVND,PRCVFS,12)
 I 'PRCVINV D ADDERR("PRCV2"_U_"Inventory Value is missing.",12)
 I PRCVTCD="SV" D
 . S PRCVRCD=$P(PRCVND,PRCVFS,8)
 . I PRCVRCD']"" D ADDERR("PRCV2"_U_"Reason Code is missing.",8)
 . I PRCVRCD'?1N!(PRCVRCD<1)!(PRCVRCD>7) D ADDERR("PRCV2"_U_"Invalid Reason Code: "_PRCVRCD,8)
 . Q
 S ^TMP(PRCVSUB,$J,3,0)=PRCVLID
 S ^TMP(PRCVSUB,$J,3,PRCVLID,0)=PRCVLID_U_PRCVACC_U_$G(PRCVBOC)_U_PRCVINV_U_$G(PRCVSAL)_U_$G(PRCVRCD)
 Q
 ;
GENACK(PRCVAC,PRCVMCID,PRCVDT,PRCVOCCR) ;
 ;
 ;PRCVAC - Acknowledgment Code
 ;PRCVMCID - Message Control ID which you're acknowledging
 ;PRCVDT - Date/Time of Transaction
 ;PRCVOCCR - Error message array
 ;
 N PRCVFS,PRCVCNT,PRCVCS,PRCVI,PRCVJ,PRCVND,PRCVRES
 ;
 S PRCVFS=$G(HL("FS")),PRCVCS=$E($G(HL("ECH"))),PRCVRS=$E($G(HL("ECH")),2),PRCVES=$E($G(HL("ECH")),U,3),PRCVSS=$E($G(HL("ECH")),U,4)
 S PRCVRES="",PRCVJ=0,PRCVI=1
 ;
 ; MSA Segment
 S HLA("HLA",1)="MSA"_PRCVFS_PRCVAC_PRCVFS_PRCVMCID_PRCVFS_$G(PRCVBID)
 ; 
 ; ERR Segment
 I $G(PRCVOCCR)'="" D
 . F  S PRCVJ=$O(PRCVOCCR(PRCVJ)) Q:'PRCVJ  D
 .. S PRCVI=PRCVI+1
 .. S HLA("HLA",PRCVI)="ERR"_PRCVFS_PRCVOCCR(PRCVJ)
 .. Q
 . Q
 ;
 D GENACK^HLMA1(HL("EID"),$G(HLMTIENS),HL("EIDS"),"LM",1,PRCVRES)
 I $P($G(PRCVRES),U,2) D
 . K XMB,XMZ
 . S XMB="PRCV HL7 ERROR"
 . S XMB(1)="PRCVIB"
 . S XMB(2)="Application Acknowledgement"
 . S XMB(3)="PRCV_IFCAP_06_SU_IB_PROC"
 . S XMB(4)=PRCVRES
 . S XMDUZ="PRCV HL7 Generator"
 . D ^XMB
 . K XMB,XMDUZ,XMZ
 . Q
 ;
 K HLA("HLA"),^TMP("HLA",$J)
 K PRCVAC,X
 Q
 ;
ADDERR(PRCVER,PRCVFD) ;
 ; PRCVER - Error message
 ; PRCVFD - Field number, if any 
 ;
 S PRCVK=PRCVK+1
 S PRCVEA=PRCVK
 S:'$G(PRCVLID) PRCVLID=1
 S:'$G(PRCVFD) PRCVLID="",PRCVFD=""
 S PRCVEA(PRCVK)=PRCVFS_$G(PRCVSEG)_U_PRCVLID_U_PRCVFD_PRCVFS_"207^Application Internal Error^HL70357"_PRCVFS_"E"_PRCVFS_PRCVER_PRCVFS_PRCVLID
 Q
 ;
XTMP(AC) ; Move ^TMP(PRCVSUB,$j) to ^XTMP
 ;
 ; AC - Acknowledgement
 ;
 S ^XTMP(PRCVSUB,0)=$$FMADD^XLFDT(PRCVDT,14)_U_PRCVDT_U_"IB Data from DynaMed with error"
 F PRCVI=1,2 S ^XTMP(PRCVSUB,PRCVI)=^TMP(PRCVSUB,$J,PRCVI)
 I $D(^TMP(PRCVSUB,$J,3,0)) D
 . S ^XTMP(PRCVSUB,3,0)=^TMP(PRCVSUB,$J,3,0)
 . S PRCVI=0
 . F  S PRCVI=$O(^TMP(PRCVSUB,$J,3,PRCVI)) Q:'PRCVI  D
 .. S ^XTMP(PRCVSUB,3,PRCVI)=^TMP(PRCVSUB,$J,3,PRCVI,0)
 .. Q
 D GENACK(AC,HL("MID"),PRCVDT,.PRCVEA)
 S ^XTMP(PRCVSUB,4,0)=PRCVEA
 S PRCVI=0
 F  S PRCVI=$O(PRCVEA(PRCVI)) Q:'PRCVI  D
 . S ^XTMP(PRCVSUB,4,PRCVI)=PRCVEA(PRCVI)
 . Q
 Q
 ;
FIN ; Clean up
 ;
 ; K ^TMP($J,"PRCVIB")
 ; K ^TMP(PRCVSUB,$J)
 K PRCVEA
 Q
 ;
TXT ; 
EVN1 ;;^EVN^^Missing segment ^100^Missing line item info.
PID1 ;;EVN^^^Missing segment ^100^Missing line item info.
FT11 ;;PID^FT1^^Missing segment ^100^Missing line item info.
