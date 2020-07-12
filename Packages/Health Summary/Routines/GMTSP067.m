GMTSP067 ;ISP/RFR - HEALTH SUMMARY PATCH 67 INSTALLATION TASKS ;Oct 16, 2019@11:38
 ;;2.7;Health Summary;**67**;Oct 20, 1995;Build 538
 Q
POST ;POST-INSTALL
 N GMTSIN,GMTSLIM,GMTSINST,GMTSTL,GMTSINST,GMTSTOT,GMTSBLD,GMTSCPS,GMTSCP,GMTSQT
 N GMTSCI,INCLUDE,XPDIDTOT
 S GMTSCPS="PREG;LAC;PANDL",XPDIDTOT=$L(GMTSCPS,";")+2
 D UPDATE^XPDID(0)
 F GMTSCI=1:1 Q:'$L($P(GMTSCPS,";",GMTSCI))  D
 . S GMTSCP=$P(GMTSCPS,";",GMTSCI)
 . D ARRAY Q:'$D(GMTSIN)
 . I $L($G(GMTSIN("TIM"))),+($G(GMTSIN(0)))>0 S GMTSLIM(+($G(GMTSIN(0))),"TIM")=$G(GMTSIN("TIM"))
 . I $L($G(GMTSIN("OCC"))),+($G(GMTSIN(0)))>0 S GMTSLIM(+($G(GMTSIN(0))),"OCC")=$G(GMTSIN("OCC"))
 . S GMTSINST=$$ADD^GMTSXPD1(.GMTSIN),GMTSTOT=+($G(GMTSTOT))+($G(GMTSINST))
 . D UPDATE^XPDID(GMTSCI)
 ; Rebuild Ad Hoc Health Summary Type
 I $G(GMTSTOT)>0 S INCLUDE=+$G(XPDQUES("POS1")) D ENPOST^GMTSLOAD
 D LIM
 I $L($T(SEND^GMTSXPS1)) D
 . N GMTSHORT,XPDIDVT S GMTSHORT=1,GMTSINST="",GMTSBLD=XPDNM D SEND^GMTSXPS1,INIT^XPDID
 D UPDATE^XPDID(GMTSCI)
 D TITLE,UPDATE^XPDID(XPDIDTOT)
 Q
ARRAY ; Build Array
 K GMTSIN N GMTSI,GMTSTXT,GMTSEX,GMTSFLD,GMTSUB,GMTSVAL,GMTSPDX S GMTSPDX=1,GMTSCP=$G(GMTSCP) Q:'$L(GMTSCP)
 F GMTSI=1:1 D  Q:'$L(GMTSTXT)
 . S GMTSTXT="",GMTSEX="S GMTSTXT=$T("_GMTSCP_"+"_GMTSI_")" X GMTSEX S:$L(GMTSTXT,";")'>3 GMTSTXT="" Q:'$L(GMTSTXT)
 . S GMTSFLD=$P(GMTSTXT,";",2),GMTSUB=$P(GMTSTXT,";",3),GMTSVAL=$P(GMTSTXT,";",4)
 . S:$E(GMTSFLD,1)=1&(+GMTSFLD<2) GMTSVAL=$P(GMTSTXT,";",4,5)
 . S:$E(GMTSFLD,1)=" "!('$L(GMTSFLD)) GMTSTXT="" Q:GMTSTXT=""
 . S:$L(GMTSFLD)&('$L(GMTSUB)) GMTSIN(GMTSFLD)=GMTSVAL Q:$L(GMTSFLD)&('$L(GMTSUB))
 . S:$L(GMTSFLD)&($L(GMTSUB)) GMTSIN(GMTSFLD,GMTSUB)=GMTSVAL
 . S:$G(GMTSFLD)=7&(+($G(GMTSUB))>0) GMTSPDX=0
 K:+($G(GMTSPDX))=0 GMTSIN("PDX")
 Q
LIM ; Limits
 N GMTSI,GMTST,GMTSO,GMTSA S GMTSI=0 F  S GMTSI=$O(GMTSLIM(GMTSI)) Q:+GMTSI=0  D
 . S GMTSA=$P($G(^GMT(142.1,+($G(GMTSI)),0)),"^",3),GMTST=$G(GMTSLIM(+GMTSI,"TIM")) S:'$L(GMTST) GMTST=$S(GMTSA="Y ":"1Y ",1:"")
 . S GMTSA=$P($G(^GMT(142.1,+($G(GMTSI)),0)),"^",5),GMTSO=$G(GMTSLIM(+GMTSI,"OCC")) S:'$L(GMTSO) GMTSO=$S(GMTSA="Y ":"10 ",1:"")
 . D TO^GMTSXPD3(GMTSI,GMTST,GMTSO)
 Q
TITLE ;set title for HST
 D BMES^XPDUTL(" Setting TITLE for VA-PT RECORD FLAG STATUS")
 N GMTSTTL,GMTSIEN S GMTSTTL="PT RECORD FLAG STATUS"
 S GMTSIEN=$O(^GMT(142,"B","VA-PT RECORD FLAG STATUS",""))
 I +$G(GMTSIEN)'>0 D  Q
 .D BMES^XPDUTL("   Health Summary Type VA-PT RECORD FLAG STATUS not found.")
 .D MES^XPDUTL("   Contact VA National Service Desk for assistance.")
 N DIE,DA,DR
 S DIE=142,DA=GMTSIEN,DR=".02////PT RECORD FLAG STATUS"
 L +^GMT(142,DA):DILOCKTM
 D ^DIE
 L -^GMT(142,DA):DILOCKTM
 D MES^XPDUTL("   TITLE successfully set")
 Q
PREG ;Component Data
 ;0;;259
 ;.01;;WH PREGNANCY DOCUMENTATION
 ;1;;PDOC;GMTSWVC1
 ;1.1;;1
 ;1.1;1;GETDATA;WVRPCPT(SUB,DFN,TYP,BEG,END,NUM)
 ;2;;1
 ;3;;WHP
 ;3.5;;3
 ;3.5;1;This component displays the pregnancy data stored in the Women's Health
 ;3.5;2;package for a particular patient.  The user can specify time and
 ;3.5;3;occurrence limits.
 ;4;;1
 ;5;;
 ;6;;
 ;7;;0
 ;8;;
 ;9;;Pregnancy Status
 ;10;;
 ;11;;
 ;12;;
 ;13;;
 ;14;;
 ;PDX;;1
 Q
 ;
LAC ;Component Data
 ;0;;260
 ;.01;;WH LACTATION DOCUMENTATION
 ;1;;LDOC;GMTSWVC1
 ;1.1;;1
 ;1.1;1;GETDATA;WVRPCPT(SUB,DFN,TYP,BEG,END,NUM)
 ;2;;1
 ;3;;WHL
 ;3.5;;3
 ;3.5;1;This component displays the lactation data stored in the Women's Health
 ;3.5;2;package for a particular patient.  The user can specify time and
 ;3.5;3;occurrence limits.
 ;4;;1
 ;5;;
 ;6;;
 ;7;;0
 ;8;;
 ;9;;Lactation Status
 ;10;;
 ;11;;
 ;12;;
 ;13;;
 ;14;;
 ;PDX;;1
 Q
 ;
PANDL ;Component Data
 ;0;;266
 ;.01;;WH PREGNANCY & LACTATION DOC
 ;1;;ALL;GMTSWVC1
 ;1.1;;1
 ;1.1;1;GETDATA;WVRPCPT(SUB,DFN,TYP,BEG,END,NUM)
 ;2;;1
 ;3;;WHPL
 ;3.5;;3
 ;3.5;1;This component displays the pregnancy and lactation data stored in the
 ;3.5;2;Women's Health package for a particular patient.  The user can specify
 ;3.5;3;time and occurrence limits.
 ;4;;1
 ;5;;
 ;6;;
 ;7;;0
 ;8;;
 ;9;;Preg. & Lac. Status
 ;10;;
 ;11;;
 ;12;;
 ;13;;
 ;14;;
 ;PDX;;1
 Q
 ;
