EASPTRN5 ;ALB/CPM/GN - NIGHTLY BILLING TRANSMISSION PROCESSING ; 10/30/01 9:58am [12/17/03 1:09pm]
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**23,33,47**; 21-OCT-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; For Edb Transmission Only - VAMC-to-Edb
 ;
 ;EAS*1*47 - break up Z09's by Income year, via new "ATR" xref
 ;
EN ; This routine performs the nightly compilation and transmission
 ; of DHCP billing activity for IVM patients to the IVM Center.
 ;
TRNSMT ; Transmit required billing activity.
 Q:'$D(^IVM(301.61,"ATR"))
 ; =============
 N HL,HLDT,HLDT1,HLEID,HLMID,MID,MTIEN,RESULT,ICYR
 S HLEID="EAS EDB ORU-Z09 SERVER"
 S HLEID=$O(^ORD(101,"B",HLEID,0))
 D INIT^IVMUFNC(HLEID,.HL) S HLMTN="ORU"
 S NUMS=""
 F I=1:1:30 S NUMS=NUMS_$S(NUMS'="":",",1:"")_I
 S ICYR=0                                                    ;EAS*1*47
 F  S ICYR=$O(^IVM(301.61,"ATR",ICYR)) Q:'ICYR  D
 . D BLDZ09(ICYR)
 D FILE^IVMPTRN3
 K DFN,IVMPID,IVMTDA,IVMMTDT,IVMN,IVMSTOP,IVMEVENT,IVMHZIC,VAFPID,DGREL,DGINC,DGINR,DGDEP
 D CLEAN^IVMUFNC
 Q
 ;
BLDZ09(ICYR) ;create the Z09 per DFN
 S DFN=0
 F  S DFN=$O(^IVM(301.61,"ATR",ICYR,DFN)) Q:'DFN  D
 .I '$$WHERETO^EASPTRN1(ICYR,DFN) Q          ;Do not send legacy Z09's
 .I IVMCT=0,$G(IVMGTOT) D FILE^HLTF
 .S HLEVN=HLEVN+1
 .; ==========
 .; Find a slot for each batch
 .I HLEVN#100=1 D
 ..K HLDT,HLDT1,HLMID,MTIEN
 ..D CREATE^HLTF(.HLMID,.MTIEN,.HLDT,.HLDT1)
 .; ==========
 .;
 .; Setup MSH Segment
 .S MID=HLMID_"-"_HLEVN
 .D MSH^HLFNC2(.HL,MID,.RESULT)
 .S IVMCT=IVMCT+1,^TMP("HLS",$J,IVMCT)=RESULT
 .;
 .; - re-set msg control id into MSH segment
 .D MSGID^IVMUFNC4(.IVMCT)
 .;
 .; - create PID segment
 .K IVMPID,VAFPID
 .S IVMPID=$$EN^VAFCPID(DFN,"1,2,3,4,5,7,8,19")
 .I $D(VAFPID(1)) S IVMPID(1)=VAFPID(1)
 .;I $P(IVMPID_$G(IVMPID(1)),HLFS,20)["P" D PSEUDO^IVMPTRN1
 .S IVMCT=IVMCT+1,^TMP("HLS",$J,IVMCT)=IVMPID
 .I $D(IVMPID(1)) S IVMCT=IVMCT+1,^TMP("HLS",$J,IVMCT)=IVMPID(1)
 .;
 .; - create PD1 segment - Patient CMOR segment <<<<<<<<<<<<<<<<<
 .;S IVMCT=IVMCT+1,^TMP("HLS",$J,IVMCT)=$$EN^VAFHLPD1(DFN,"1,2,3,4")
 .S IVMCT=IVMCT+1,^TMP("HLS",$J,IVMCT)=$$EN^VAFHLPD1(DFN,"1,3")
 .;
 .; - find the patient's Means Test date and create ZIC segment
 .S IVMTDA=$O(^IVM(301.61,"ATR",ICYR,DFN,0))
 .S IVMMTDT=$S(IVMTDA:$P($G(^IVM(301.61,IVMTDA,0)),"^",5),1:DT)
 .D ALL^DGMTU21(DFN,"V",IVMMTDT,"IPR",+$$LST^DGMTU(DFN,IVMMTDT))
 .S IVMHZIC=$$EN^VAFHLZIC(+$G(DGINC("V")),"1,2")
 .;S IVMHZIC=$$EN^VAFHLZIC(+$G(DGINC("V")),$P(NUMS,",",1,23))
 .I '$P(IVMHZIC,"^",3) S $P(IVMHZIC,"^",3)=$$HLDATE^HLFNC($O(^IVM(301.5,"APT",DFN,0)))
 .;
 .; - find all transactions for the patient and create FT1 segments
 .S IVMTDA=0 F  S IVMTDA=$O(^IVM(301.61,"ATR",ICYR,DFN,IVMTDA)) Q:'IVMTDA  D
 ..S IVMCT=IVMCT+1,^TMP("HLS",$J,IVMCT)=$$FT1^EASUFNC3(IVMTDA)
 ..S IVMN=$G(^IVM(301.61,IVMTDA,0))
 ..;
 ..; - if a payment has been made (or if the bill is closed),
 ..; - but the bill has never been transmitted, re-transmit.
 ..I ($P(IVMN,"^",9)!($P(IVMN,"^",10))),'$P(IVMN,"^",13) D
 ...D NOW^%DTC S DA=IVMTDA,DIE="^IVM(301.61,",DR=".13////"_% D ^DIE
 ...S IVMCT=IVMCT+1,^TMP("HLS",$J,IVMCT)=$$FT1^EASUFNC3(IVMTDA)
 ..;
 ..; - update transmission record
 ..;D:ISITESW'["H"
 ..S IVMSTOP=0
 ..I $P(IVMN,"^",10)!$P(IVMN,"^",11) S IVMSTOP=1
 ..I $P(IVMN,"^",4)>1 S IVMSTOP=1
 ..D NOW^%DTC S DR=".12////0;.13////"_%
 ..I IVMSTOP S DR=DR_";.14////1"
 ..S DR=DR_";1.03////"_%_";1.04////"_DUZ
 ..S DA=IVMTDA,DIE="^IVM(301.61," D ^DIE K DA,DR,DIE
 .;
 .; - set ZIC segment
 .S IVMCT=IVMCT+1,^TMP("HLS",$J,IVMCT)=IVMHZIC
 .;
 .S IVMEVENT="Z09"
 .I HLEVN'<100 D FILE^IVMPTRN3
 ;
 Q
 ;
 ;
INIT(DFN) ; Find the initial date for which to return patient charges.
 ;  Input:   DFN  --  Pointer to the patient in file #2
 ; Output:   Date patient became Cat C, or null (for ins. patients)
 ;
 N IVMDATE,X,Y S IVMDATE=0
 I '$G(DFN) G INITQ
 S X=0 F  S X=$O(^IVM(301.61,"C",DFN,X)) Q:'X  S Y=$G(^IVM(301.61,X,0)) I $P(Y,"^",4)>1,$P(Y,"^",5) S IVMDATE=$P(Y,"^",5) Q
 I IVMDATE S IVMDATE=$P($$LST^DGMTU(DFN,IVMDATE),"^",2)
INITQ Q IVMDATE
