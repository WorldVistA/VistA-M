IVMPTRN5 ;ALB/CPM/GN - NIGHTLY BILLING TRANSMISSION PROCESSING ; 1/15/01 11:21am [12/17/03 3:45pm]
 ;;2.0;INCOME VERIFICATION MATCH;**1,9,24,34,69,78,96**; 21-OCT-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;
 ;IVM*2*96 - break up Z09's by Income year, via new "ATR" xref
 ;
EN ; This routine performs the nightly compilation and transmission
 ; of DHCP billing activity for IVM patients to the IVM Center.
 ;
 K ^TMP("IVMPTRN5",$J)
 D IVMPT ;                                get data for IVM patients
 D INS^IBAMTV4("^TMP(""IVMPTRN5"",$J)") ; get data for Insurance patients
 D UPDATE^IVMPTRN6 ;                      update file #301.61
 D TRNSMT ;                               post transmissions
 D TRNSMT^EASPTRN5            ;If any EDB Z09's to transmit - then send
 Q
 ;
 ;
IVMPT ; Get claims and patient charges for IVM patients
 N DFN,IVMSTART,IVMEND
 S DFN=0 F  S DFN=$O(^IVM(301.61,"C",DFN)) Q:'DFN  D
 .S IVMSTART=$$INIT(DFN) S:'IVMSTART IVMEND=0
 .I IVMSTART S IVMEND=$$FMADD^XLFDT(IVMSTART,364) S:IVMEND>DT IVMEND=DT
 .D ALL^IBAMTV4(DFN,"^TMP(""IVMPTRN5"",$J)",IVMSTART,IVMEND)
 Q
 ;
 ;
TRNSMT ; Transmit required billing activity.
 Q:'$D(^IVM(301.61,"ATR"))
 ;
 N HL,HLDT,HLDT1,HLEID,HLMID,MID,MTIEN,RESULT
 S HLEID="VAMC "_$P($$SITE^VASITE,"^",3)_" ORU-Z09 SERVER"
 S HLEID=$O(^ORD(101,"B",HLEID,0))
 D INIT^IVMUFNC(HLEID,.HL) S HLMTN="ORU"
 ;
 S ICYR=0                                                    ;IVM*2*96
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
 .I $$WHERETO^EASPTRN1(ICYR,DFN) Q          ;Do not send EDB Z09's
 .I IVMCT=0,$G(IVMGTOT) D FILE^HLTF
 .S HLEVN=HLEVN+1
 .;
 .; FIND A SLOT FOR EACH BATCH
 .I HLEVN#100=1 D
 ..K HLDT,HLDT1,HLMID,MTIEN
 ..D CREATE^HLTF(.HLMID,.MTIEN,.HLDT,.HLDT1)
 .;
 .; SET UP MSH SEGMENT
 .S MID=HLMID_"-"_HLEVN
 .D MSH^HLFNC2(.HL,MID,.RESULT)
 .S IVMCT=IVMCT+1,^TMP("HLS",$J,IVMCT)=RESULT
 .;
 .; - re-set msg control id into MSH segment
 .D MSGID^IVMUFNC4(.IVMCT)
 .;
 .; - create PID segment
 .K IVMPID,VAFPID
 .S IVMPID=$$EN^VAFHLPID(DFN,"1,3,5,7,8,19") I $D(VAFPID(1)) S IVMPID(1)=VAFPID(1)
 .;I $P(IVMPID_$G(IVMPID(1)),HLFS,20)["P" D PSEUDO^IVMPTRN1
 .S IVMCT=IVMCT+1,^TMP("HLS",$J,IVMCT)=IVMPID
 .I $D(IVMPID(1)) S IVMCT=IVMCT+1,^TMP("HLS",$J,IVMCT)=IVMPID(1)
 .;
 .; - find the patient's Means Test date and create ZIC segment
 .S IVMTDA=$O(^IVM(301.61,"ATR",ICYR,DFN,0))
 .S IVMMTDT=$S(IVMTDA:$P($G(^IVM(301.61,IVMTDA,0)),"^",5),1:DT)
 .D ALL^DGMTU21(DFN,"V",IVMMTDT,"IPR",+$$LST^DGMTU(DFN,IVMMTDT))
 .S IVMHZIC=$$EN^VAFHLZIC(+$G(DGINC("V")),"1,2")
 .I '$P(IVMHZIC,"^",3) S $P(IVMHZIC,"^",3)=$$HLDATE^HLFNC($O(^IVM(301.5,"APT",DFN,0)))
 .;
 .; - find all transactions for the patient and create FT1 segments
 .S IVMTDA=0 F  S IVMTDA=$O(^IVM(301.61,"ATR",ICYR,DFN,IVMTDA)) Q:'IVMTDA  D
 ..S IVMCT=IVMCT+1,^TMP("HLS",$J,IVMCT)=$$FT1^IVMUFNC3(IVMTDA)
 ..S IVMN=$G(^IVM(301.61,IVMTDA,0))
 ..;
 ..; - if a payment has been made (or if the bill is closed),
 ..; - but the bill has never been transmitted, re-transmit.
 ..I ($P(IVMN,"^",9)!($P(IVMN,"^",10))),'$P(IVMN,"^",13) D
 ...D NOW^%DTC S DA=IVMTDA,DIE="^IVM(301.61,",DR=".13////"_% D ^DIE
 ...S IVMCT=IVMCT+1,^TMP("HLS",$J,IVMCT)=$$FT1^IVMUFNC3(IVMTDA)
 ..;
 ..; - update transmission record
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
 ;
 ;Check DISABLE text in #101 to determine if communications with
 ; Edb are active or not.  Text in this field indicates link is not
 ; active
 ;
EDB(HLEID) S HLEID=$O(^ORD(101,"B",HLEID,0))
 I 'HLEID Q 0                                 ;Protocol not defined
 I $P(^ORD(101,HLEID,0),"^",3)="" Q 1         ;Edb protocol active
 Q 0
