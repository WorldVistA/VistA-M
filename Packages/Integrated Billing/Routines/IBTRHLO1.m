IBTRHLO1 ;ALB/YMG - Create and send 278 inquiry cont. ;30 Apr 2015  12:29 PM
 ;;2.0;INTEGRATED BILLING;**517**;21-MAR-94;Build 240
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
AUT ; create AUT segment
 N AUT,Z
 S Z=""
 I $P(NODE17,U)'="" S Z="REF 2000E"_HLECH_$P(NODE17,U),$P(Z,HLECH,5)="BB"
 I Z="",$P(NODE17,U,2)'="" S Z="REF 2000E"_HLECH_$P(NODE17,U,2),$P(Z,HLECH,5)="NT"
 I Z="" Q
 S AUT="AUT"_HLFS_HLFS_Z
 S HCT=HCT+1,^TMP("HLS",$J,HCT)=AUT
 Q
 ;
G2ORXA ; create G2O.RXA segment (G2O segment group)
 N RXA,SUBLSTR,TXNUM,TXCNT,Z
 S TXNUM=$P(NODE7,U,5) I TXNUM="" Q  ; missing treatment series number
 S TXCNT=$P(NODE7,U,6) I TXCNT="" Q  ; missing treatment count
 S TXNUM=+TXNUM,TXCNT=+TXCNT,SUBLSTR=""
 S Z=+$P(NODE7,U,7) I Z>0 S SUBLSTR=$$GET1^DIQ(356.012,Z_",",.01)
 S Z=+$P(NODE7,U,8) I Z>0 S SUBLSTR=SUBLSTR_HLREP_$$GET1^DIQ(356.012,Z_",",.01)
 S RXA="RXA"_HLFS_$$ENCHL7^IBCNEHLQ(TXNUM)_HLFS_$$ENCHL7^IBCNEHLQ(TXCNT)_HLFS_$$HLDATE^HLFNC(NOWDT)_HLFS_$$HLDATE^HLFNC(NOWDT)
 S RXA=RXA_HLFS_"1"_HLFS_"0"_HLFS_HLFS_HLFS_SUBLSTR
 S Z=$P(NODE7,U,10),$P(RXA,HLFS,20)=$P(NODE7,U,9)_$S(Z'="":HLREP_Z,1:"")
 S $P(RXA,HLFS,21)=$P(NODE7,U,13)
 S HCT=HCT+1,^TMP("HLS",$J,HCT)=RXA
 D G2ONTE
 Q
 ;
G2ONTE ; create G2O.NTE segments (G2O segment group)
 N CMT,NTE,Z
 F Z=11:1:12 S CMT=$P(NODE7,U,Z) I CMT'="" D
 .S NTE="NTE"_HLFS_HLFS_HLFS_$$ENCHL7^IBCNEHLQ(CMT)_HLFS_"CR2 2000E"
 .S HCT=HCT+1,^TMP("HLS",$J,HCT)=NTE
 .Q
 Q
 ;
RXE ; create RXE segment
 N BGAS,RXE,OXYTST,Z
 S BGAS=+$P(NODE9,U) I 'BGAS Q  ; missing arterial blood gas quantity
 S Z=$$ENCHL7^IBCNEHLQ($P(NODE8,U,7)),$P(Z,HLECH,8)=$$ENCHL7^IBCNEHLQ($P(NODE8,U,8))
 S RXE="RXE"_HLFS_Z_HLFS_"1"_HLFS_$$ENCHL7^IBCNEHLQ(BGAS)_HLFS_HLFS_"1"_HLFS_HLFS_HLECH_$$ENCHL7^IBCNEHLQ($P(NODE8,U,4))
 S $P(RXE,HLFS,11)=$$ENCHL7^IBCNEHLQ($P(NODE9,U,2))
 S $P(RXE,HLFS,15)=$$GET1^DIQ(356.013,+$P(NODE8,U)_",",.01)_HLREP_$$GET1^DIQ(356.013,+$P(NODE8,U,2)_",",.01)
 S $P(RXE,HLFS,17)=$$ENCHL7^IBCNEHLQ($P(NODE9,U,7))
 S $P(RXE,HLFS,20)=$$ENCHL7^IBCNEHLQ($P(NODE8,U,6))
 S $P(RXE,HLFS,24)=$$ENCHL7^IBCNEHLQ($P(NODE8,U,5))
 S Z=+$P(NODE9,U,4) I Z>0 S OXYTST=$$GET1^DIQ(356.015,Z_",",.01)
 S Z=+$P(NODE9,U,5) I Z>0 S OXYTST=$G(OXYTST)_HLREP_HLECH_HLECH_HLECH_$$GET1^DIQ(356.015,Z_",",.01)
 S Z=+$P(NODE9,U,6) I Z>0 S OXYTST=$G(OXYTST)_HLREP_HLECH_HLECH_HLECH_$$GET1^DIQ(356.015,Z_",",.01)
 S Z=$$GET1^DIQ(356.014,+$P(NODE9,U,3)_",",.01) I $G(OXYTST)'="" S $P(Z,HLECH,4)=OXYTST
 S $P(RXE,HLFS,28)=Z
 S $P(RXE,HLFS,30)=$$GET1^DIQ(356.016,+$P(NODE9,U,8)_",",.01)
 S $P(RXE,HLFS,32)=$$GET1^DIQ(356.013,+$P(NODE8,U,3)_",",.01)
 S HCT=HCT+1,^TMP("HLS",$J,HCT)=RXE
 Q
 ;
PRB ; create PRB segment
 N DATESTR,PRB,PROCSTR,Z
 I $TR(NODE10,U)=""!(CERT="") Q
 S PROCSTR=CERT
 S Z=$P(NODE10,U,6) I Z'="" S $P(PROCSTR,HLECH,3)=Z
 S Z=$P(NODE10,U,7) I Z'="" S $P(PROCSTR,HLECH,4)=$$EXTERNAL^DILFD(356.22,10.07,,Z)
 S PRB="PRB"_HLFS_"UC"_HLFS_$$HLDATE^HLFNC(DT)_HLFS_PROCSTR_HLFS_"1"_HLFS_"CR6 2000E"_HLFS_HLFS_$$HLDATE^HLFNC($P(NODE10,U,8))
 S PRB=PRB_HLFS_$$HLDATE^HLFNC($P(NODE10,U,5))_HLFS_$$HLDATE^HLFNC($P(NODE10,U,9))_HLFS_$$GET1^DIQ(356.017,+$P(NODE10,U,13)_",",.01)
 S DATESTR="",Z=$P(NODE10,U,11) I Z'="" S DATESTR=HLECH_$$HLDATE^HLFNC(Z)
 I DATESTR'="" S Z=$P(NODE10,U,12) S:Z'="" DATESTR=DATESTR_"-"_$$HLDATE^HLFNC(Z) S $P(PRB,HLFS,15)=DATESTR ; last admission date range
 S $P(PRB,HLFS,16)=$$HLDATE^HLFNC($P(NODE10,U,10))
 S $P(PRB,HLFS,17)=$$HLDATE^HLFNC($P(NODE10,U))
 S DATESTR="",Z=$P(NODE10,U,2) I Z'="" S DATESTR=$$HLDATE^HLFNC(Z)
 I DATESTR'="" S Z=$P(NODE10,U,3) S:Z'="" DATESTR=DATESTR_"-"_$$HLDATE^HLFNC(Z) S $P(PRB,HLFS,18)=DATESTR ; home health cert. date range
 S $P(PRB,HLFS,23)=$$GET1^DIQ(356.004,+$P(NODE2,U,15)_",",.01)
 S HCT=HCT+1,^TMP("HLS",$J,HCT)=PRB
 Q
 ;
PSL ; create PSL segments
 N NODE0,PSL,SEQ,Z,Z1
 S SEQ=0,Z="" F  S Z=$O(^IBT(356.22,IBTRIEN,11,"B",Z)) Q:Z=""  D
 .S Z1=+$O(^IBT(356.22,IBTRIEN,11,"B",Z,"")) I 'Z1 Q
 .S NODE0=$G(^IBT(356.22,IBTRIEN,11,Z1,0)) I NODE0="" Q  ; 0-node of sub-file 356.2211
 .S SEQ=SEQ+1 I SEQ>10 Q
 .S PSL="PSL"_HLFS_"PWK 2000E"_HLFS_HLFS_SEQ_HLFS_HLFS_HLFS_"1"_HLFS_"1"
 .S $P(PSL,HLFS,20)=$$GET1^DIQ(356.018,+$P(NODE0,U)_",",.01)_HLECH_$$ENCHL7^IBCNEHLQ($P(NODE0,U,3))_HLECH_$$ENCHL7^IBCNEHLQ($P(NODE0,U,4))
 .S $P(PSL,HLFS,21)=$P(NODE0,U,2)
 .S $P(PSL,HLFS,22)="NA"
 .S HCT=HCT+1,^TMP("HLS",$J,HCT)=PSL
 .Q
 Q
 ;
G3OPRD ; create G3O.PRD segments (G3O segment group)
 N ADDR1,ADDR2,NODE0,PCODEPRV,PERSON,PRD,PRVDATA,PRVPTR,SEQ,TMP,Z
 ; create PRD segments for patient event providers
 S (SEQ,Z)=0 F  S Z=$O(^IBT(356.22,IBTRIEN,13,Z)) Q:Z=""!(Z?1.A)  D
 .S NODE0=$G(^IBT(356.22,IBTRIEN,13,Z,0)) I NODE0="" Q  ; 0-node of sub-file 356.2213
 .S SEQ=SEQ+1 I SEQ>14 Q  ; only allow up to 14 providers
 .S PRVPTR=$P(NODE0,U,3) I PRVPTR="" Q  ; missing provider pointer
 .S PERSON=$P(NODE0,U,2) I 'PERSON Q  ; missing person / non-person indicator
 .S PRVDATA=$$PRVDATA^IBTRHLO2(+$P(PRVPTR,";"),$P($P(PRVPTR,"(",2),","))
 .S TMP=$$GET1^DIQ(365.022,+$P(NODE0,U)_",",.01)_HLECH_PERSON_HLECH_HLECH_"NM1 2010EA"
 .S ADDR1=$P(PRVDATA,U,2,3),ADDR2=$P(PRVDATA,U,4,6)
 .S PRD="PRD"_HLFS_TMP_HLFS_$$HLNAME^HLFNC($P(PRVDATA,U))_HLFS_$$ENCHL7^IBCNEHLQ($P($$HLADDR^HLFNC(ADDR1,ADDR2),HLECH,1,5))
 .S $P(PRD,HLFS,8)=$P(PRVDATA,U,7)
 .S HCT=HCT+1,^TMP("HLS",$J,HCT)=PRD
 .; create PRD segment for X12 PRV segment
 .S PCODEPRV=$$PCODECNV^IBTRHLO2($P(TMP,HLECH)) I PCODEPRV'="" D
 ..N XTAX
 ..S XTAX=$P($$GTXNMY^IBTRH3(PRVPTR),"^") ;11/24/15 only code, not description
 ..I XTAX="" Q
 ..S TMP=PCODEPRV_HLECH_HLECH_HLECH_"PRV 2010EA"
 ..S PRD="PRD"_HLFS_TMP
 ..S $P(PRD,HLFS,8)=XTAX
 ..S HCT=HCT+1,^TMP("HLS",$J,HCT)=PRD
 ..Q
 .Q
 ; create PRD segments for patient event transport
 I 'MSGTYPE S (SEQ,Z)=0 F  S Z=$O(^IBT(356.22,IBTRIEN,14,Z)) Q:Z=""!(Z?1.A)  D
 .S NODE0=$G(^IBT(356.22,IBTRIEN,14,Z,0)) I NODE0="" Q  ; 0-node of sub-file 356.2214
 .S SEQ=SEQ+1 I SEQ>5 Q  ; only allow up to 5 transports
 .S TMP=$P(NODE0,U)_HLECH_HLECH_HLECH_"NM1 2010EB"
 .S (ADDR1,ADDR2)=""
 .I $P(NODE0,U,3)'="",$P(NODE0,U,5)'="" S ADDR1=$P(NODE0,U,3,4),ADDR2=$P(NODE0,U,5,7)
 .S PRD="PRD"_HLFS_TMP_HLFS_$$ENCHL7^IBCNEHLQ($P(NODE0,U,2))_HLFS_$$ENCHL7^IBCNEHLQ($P($$HLADDR^HLFNC(ADDR1,ADDR2),HLECH,1,5))
 .S HCT=HCT+1,^TMP("HLS",$J,HCT)=PRD
 .Q
 ; create PRD segments for other UMO
 I 'MSGTYPE S (SEQ,Z)=0 F  S Z=$O(^IBT(356.22,IBTRIEN,15,Z)) Q:Z=""!(Z?1.A)  D
 .S NODE0=$G(^IBT(356.22,IBTRIEN,15,Z,0)) I NODE0="" Q  ; 0-node of sub-file 356.2215
 .S SEQ=SEQ+1 I SEQ>3 Q  ; only allow up to 3 other UMOs
 .S TMP=$P(NODE0,U)_HLECH_HLECH_HLECH_"NM1 2010EC"
 .S PRD="PRD"_HLFS_TMP_HLFS_$$EXTERNAL^DILFD(356.2215,.02,,+$P(NODE0,U,2))
 .S HCT=HCT+1,^TMP("HLS",$J,HCT)=PRD
 .D G3OAUT
 .Q
 Q
 ;
G3OAUT ; create G3O.AUT segment (G3O segment group)
 N AUT,R1,R2,R3,R4,Z
 S R1=$P(NODE0,U,3),R2=$P(NODE0,U,4),R3=$P(NODE0,U,5),R4=$P(NODE0,U,6)
 I R1="",R2="",R3="",R4="" Q  ; no UMO denial reasons to send
 S Z="" I R3'=""!(R4'="") S $P(Z,HLECH,2)=$$ENCHL7^IBCNEHLQ(R3),$P(Z,HLECH,5)=$$ENCHL7^IBCNEHLQ(R4)
 S AUT="AUT"_HLFS_Z_HLFS_"REF 2010EC"_HLECH_$$ENCHL7^IBCNEHLQ(R1)_HLECH_HLECH_HLECH_$$ENCHL7^IBCNEHLQ(R2)
 S HCT=HCT+1,^TMP("HLS",$J,HCT)=AUT
 D G3OZTP
 Q
 ;
G3OZTP ; create G3O.ZTP segment (G3O segment group)
 N DATE,ZTP
 S DATE=$P($P(NODE0,U,7),".") I DATE="" Q  ; no date to send, date only 4/6/16
 S ZTP="ZTP"_HLFS_HLFS_"598"_HLFS_$$HLDATE^HLFNC(DATE)_HLFS_"DTP 2010EC"
 S HCT=HCT+1,^TMP("HLS",$J,HCT)=ZTP
 Q
 ;
G5OPRB ; create G5O.PRB segments (G5O segment group)
 N FQUAL,FTYPE,NODE160,PRB,REQCAT,Z1
 S Z1="" F  S Z1=$O(^IBT(356.22,IBTRIEN,16,Z1)) Q:Z1=""!(Z1?1.A)  D
 .S NODE160=$G(^IBT(356.22,IBTRIEN,16,Z1,0)) I NODE160="" Q  ; 0-node of sub-file 356.2216
 .S REQCAT=$$GET1^DIQ(356.001,+$P(NODE160,U,15)_",",.01)
 .I REQCAT'="" D
 ..S REQCAT=$S(REQCAT="HS":"CO",REQCAT="SC":"AD",1:REQCAT)
 ..S PRB="PRB"_HLFS_REQCAT_HLFS_$$HLDATE^HLFNC(DT)
 ..S PRB=PRB_HLFS_$$GET1^DIQ(356.002,+$P(NODE160,U,2)_",",.01)_HLECH_$$GET1^DIQ(365.013,+$P(NODE160,U,3)_",",.01)
 ..S PRB=PRB_HLFS_"1"_HLFS_"UM 2000F"
 ..S FQUAL=$P(NODE160,U,4) I FQUAL'="" D
 ...S FTYPE=$S(FQUAL="A":$P(NODE160,U,6)_$P(NODE160,U,7),1:$$EXTERNAL^DILFD(356.2216,.05,,+$P(NODE160,U,5)))
 ...I FTYPE'="" S $P(PRB,HLFS,11)=$$ENCHL7^IBCNEHLQ(FTYPE)_HLECH_$P(NODE160,U,4)
 ...Q
 ..S HCT=HCT+1,^TMP("HLS",$J,HCT)=PRB
 ..Q
 .D G5OAUT,G5OZTP,G5OPSL
 .I 'MSGTYPE D G5OZHS,G5OPSL2,G5ONTE
 .D G5OPRD
 .Q
 Q
 ;
G5OAUT ; create G5O.AUT segment (G5O segment group)
 N AUT,NODE169,Z
 S NODE169=$G(^IBT(356.22,IBTRIEN,16,Z1,9)) ; 9-node of sub-file 356.2216
 S Z=""
 I $P(NODE169,U)'="" S Z="REF 2000F"_HLECH_$P(NODE169,U),$P(Z,HLECH,5)="BB"
 I Z="",$P(NODE169,U,2)'="" S Z="REF 2000F"_HLECH_$P(NODE169,U,2),$P(Z,HLECH,5)="NT"
 I Z="" Q
 S AUT="AUT"_HLFS_HLFS_Z
 S HCT=HCT+1,^TMP("HLS",$J,HCT)=AUT
 Q
 ;
G5OZTP ; create G5O.ZTP segment (G5O segment group)
 N SRVDATE,ZTP
 S SRVDATE=$P(NODE160,U,11) I SRVDATE="" Q
 S ZTP="ZTP"_HLFS_HLFS_"472"_HLFS_$$HLDATE^HLFNC($P(SRVDATE,"."))_HLFS_"DTP 2000F"
 S HCT=HCT+1,^TMP("HLS",$J,HCT)=ZTP
 Q
 ;
G5OPSL ; create G5O.PSL segments (G5O segment group)
 N NODE161,NODE162,NODE163,NODE1640,NODE1612,PSL,SEQ,SRVTYPE,TMP,Z2
 S NODE161=$G(^IBT(356.22,IBTRIEN,16,Z1,1)) I NODE161="" Q  ; 1-node of sub-file 356.2216
 S NODE162=$G(^IBT(356.22,IBTRIEN,16,Z1,2)) ; 2-node of sub-file 356.2216
 S NODE163=$G(^IBT(356.22,IBTRIEN,16,Z1,3)) ; 3-node of sub-file 356.2216
 S NODE1612=$G(^IBT(356.22,IBTRIEN,16,Z1,12)) ; 12-node of sub-file 356.2216
 S SRVTYPE=$P(NODE161,U,12),SEQ=1
 S PSL="PSL"_HLFS_HLFS_HLFS_SEQ
 S $P(PSL,HLFS,7)="P"
 S TMP=$S(SRVTYPE="D":"AD",1:$P(NODE161,U))
 S $P(TMP,HLECH,2)=$$ENCHL7^IBCNEHLQ($S(TMP="N4":$P(NODE1612,U),1:$$EXTERNAL^DILFD(356.2216,1.02,,$P(NODE161,U,2))))
 S $P(TMP,HLECH,5)=$$ENCHL7^IBCNEHLQ($S(TMP="N4":$P(NODE1612,U,2),1:$$EXTERNAL^DILFD(356.2216,1.03,,$P(NODE161,U,3))))
 S $P(PSL,HLFS,8)=TMP
 I 'MSGTYPE D
 .S TMP=$$ENCHL7^IBCNEHLQ($$EXTERNAL^DILFD(356.2216,1.04,,$P(NODE161,U,4)))_HLECH
 .S TMP=TMP_$$ENCHL7^IBCNEHLQ($$EXTERNAL^DILFD(356.2216,1.05,,$P(NODE161,U,5)))_HLECH_HLECH
 .S TMP=TMP_$$ENCHL7^IBCNEHLQ($$EXTERNAL^DILFD(356.2216,1.06,,$P(NODE161,U,6)))_HLECH
 .S TMP=TMP_$$ENCHL7^IBCNEHLQ($$EXTERNAL^DILFD(356.2216,1.07,,$P(NODE161,U,7)))
 .S $P(PSL,HLFS,9)=TMP
 .S $P(PSL,HLFS,10)=$$ENCHL7^IBCNEHLQ($P(NODE161,U,8))
 .Q
 S $P(PSL,HLFS,13)=$$ENCHL7^IBCNEHLQ($P(NODE161,U,11))_HLECH_$P(NODE161,U,10)
 I 'MSGTYPE S $P(PSL,HLFS,16)=$$ENCHL7^IBCNEHLQ($P(NODE161,U,9))
 I SRVTYPE="I" D
 .S $P(PSL,HLFS,2)="SV2 2000F"
 .S $P(PSL,HLFS,14)=$$ENCHL7^IBCNEHLQ($P(NODE162,U,7))
 .S $P(PSL,HLFS,18)=$$ENCHL7^IBCNEHLQ($$GET1^DIQ(399.2,+$P(NODE162,U,6)_",",.01))
 .I 'MSGTYPE S $P(PSL,HLFS,47)=$$GET1^DIQ(356.011,+$P(NODE162,U,8)_",",.01)
 .Q
 S $P(PSL,HLFS,22)="NA"
 I SRVTYPE="P" D
 .S $P(PSL,HLFS,2)="SV1 2000F"
 .I 'MSGTYPE D
 ..S TMP=$$ENCHL7^IBCNEHLQ($P(NODE162,U))_HLECH_$$ENCHL7^IBCNEHLQ($P(NODE162,U,2))_HLECH_HLECH
 ..S TMP=TMP_$$ENCHL7^IBCNEHLQ($P(NODE162,U,3))_HLECH_$$ENCHL7^IBCNEHLQ($P(NODE162,U,4))
 ..S $P(PSL,HLFS,23)=TMP
 ..S $P(PSL,HLFS,48)=$P(NODE162,U,5)
 ..Q
 .Q
 I SRVTYPE="I"!(SRVTYPE="P") S $P(PSL,HLFS,49)=$$GET1^DIQ(356.019,+$P(NODE162,U,9)_",",.01)
 I SRVTYPE="D",$TR(NODE163,U)'="" D
 .S $P(PSL,HLFS,2)="SV3 2000F"
 .S $P(PSL,HLFS,18)=$$ENCHL7^IBCNEHLQ($P(NODE163,U,6))
 .I 'MSGTYPE D
 ..S TMP="",$P(TMP,HLECH,9)=$$ENCHL7^IBCNEHLQ($P(NODE163,U,7))
 ..S $P(PSL,HLFS,23)=TMP
 ..Q
 .S TMP=$P(NODE163,U)_HLECH_$P(NODE163,U,2)_HLECH_HLECH_$P(NODE163,U,3)_HLECH_$P(NODE163,U,4)
 .S $P(TMP,HLECH,9)=$P(NODE163,U,5)
 .S $P(PSL,HLFS,34)=TMP
 .Q
 S HCT=HCT+1,^TMP("HLS",$J,HCT)=PSL
 ; additional PSL segments for tooth information
 I SRVTYPE="D" S Z2="" F  S Z2=$O(^IBT(356.22,IBTRIEN,16,Z1,4,Z2)) Q:Z2=""!(Z2?1.A)  D
 .S NODE1640=$G(^IBT(356.22,IBTRIEN,16,Z1,4,Z2,0)) I NODE1640="" Q  ; 0-node of sub-file 356.22164
 .S PSL="PSL"_HLFS_"TOO 2000F"
 .S SEQ=SEQ+1,$P(PSL,HLFS,4)=SEQ
 .S $P(PSL,HLFS,7)="P"
 .S $P(PSL,HLFS,8)="JP"_HLECH_$$ENCHL7^IBCNEHLQ($$GET1^DIQ(356.022,+$P(NODE1640,U)_",",.01))
 .S $P(PSL,HLFS,22)="NA"
 .S TMP=$P(NODE1640,U,2)
 .I 'MSGTYPE D
 ..S TMP=TMP_HLECH_$P(NODE1640,U,3)_HLECH_HLECH_$P(NODE1640,U,4)_HLECH_$P(NODE1640,U,5)
 ..S $P(TMP,HLECH,9)=$P(NODE1640,U,6)
 ..Q
 .S $P(PSL,HLFS,34)=TMP
 .S HCT=HCT+1,^TMP("HLS",$J,HCT)=PSL
 .Q
 Q
 ;
G5OZHS ; create G5O.ZHS segment (G5O segment group)
 N NODE165,ZHS
 S NODE165=$G(^IBT(356.22,IBTRIEN,16,Z1,5)) I NODE165="" Q  ; 5-node of sub-file 356.2216
 S ZHS="ZHS"_HLFS_"HSD 2000F"_HLFS_$$GET1^DIQ(365.016,+$P(NODE165,U)_",",.01)_HLFS
 S ZHS=ZHS_$$ENCHL7^IBCNEHLQ($P(NODE165,U,2))_HLFS_$P(NODE165,U,3)_HLFS_$$ENCHL7^IBCNEHLQ($P(NODE165,U,4))_HLFS
 S ZHS=ZHS_$$GET1^DIQ(365.015,+$P(NODE165,U,5)_",",.01)_HLFS_$$ENCHL7^IBCNEHLQ($P(NODE165,U,6))_HLFS
 S ZHS=ZHS_$$GET1^DIQ(365.025,+$P(NODE165,U,7)_",",.01)_HLFS_$$GET1^DIQ(356.007,+$P(NODE165,U,8)_",",.01)
 I $TR($P(ZHS,HLFS,3,99),HLFS)="" Q
 S HCT=HCT+1,^TMP("HLS",$J,HCT)=ZHS
 Q
 ;
G5OPSL2 ; create 2nd group of G5O.PSL segments (G5O segment group)
 N NODE1660,PSL,SEQ,Z2,Z3
 S SEQ=0,Z2="" F  S Z2=$O(^IBT(356.22,IBTRIEN,16,Z1,6,"B",Z2)) Q:Z2=""  D
 .S Z3=+$O(^IBT(356.22,IBTRIEN,16,Z1,6,"B",Z2,"")) I 'Z3 Q
 .S NODE1660=$G(^IBT(356.22,IBTRIEN,16,Z1,6,Z3,0)) I NODE1660="" Q  ; 0-node of sub-file 356.22166
 .S SEQ=SEQ+1 I SEQ>10 Q
 .S PSL="PSL"_HLFS_"PWK 2000F"_HLFS_HLFS_SEQ_HLFS_HLFS_HLFS_"P"_HLFS_"1"
 .S $P(PSL,HLFS,20)=$$GET1^DIQ(356.018,+$P(NODE1660,U)_",",.01)_HLECH_$$ENCHL7^IBCNEHLQ($P(NODE1660,U,3))_HLECH_$$ENCHL7^IBCNEHLQ($P(NODE1660,U,4))
 .S $P(PSL,HLFS,21)=$P(NODE1660,U,2)
 .S $P(PSL,HLFS,22)="NA"
 .S HCT=HCT+1,^TMP("HLS",$J,HCT)=PSL
 .Q
 Q
 ;
G5ONTE ; create G5O.NTE segment (G5O segment group)
 N MSG,NTE
 S MSG=$$WP2STR^IBTRHLO2(356.2216,7,Z1_","_IBTRIEN_",",264)
 I MSG="" Q
 S NTE="NTE"_HLFS_HLFS_HLFS_$$ENCHL7^IBCNEHLQ(MSG)_HLFS_"MSG 2000F"
 S HCT=HCT+1,^TMP("HLS",$J,HCT)=NTE
 Q
 ;
G5OPRD ; create G5O.PRD segments (G5O segment group)
 N ADDR1,ADDR2,NODE1680,PCODEPRV,PERSON,PRD,PRVDATA,PRVPTR,SEQ,TMP,Z2,Z3
 S SEQ=0,Z2="" F  S Z2=$O(^IBT(356.22,IBTRIEN,16,Z1,8,"B",Z2)) Q:Z2=""  D
 .S Z3=+$O(^IBT(356.22,IBTRIEN,16,Z1,8,"B",Z2,"")) I 'Z3 Q
 .S NODE1680=$G(^IBT(356.22,IBTRIEN,16,Z1,8,Z3,0)) I NODE1680="" Q  ; 0-node of sub-file 356.22168
 .S SEQ=SEQ+1 I SEQ>14 Q  ; only allow up to 14 providers
 .S PRVPTR=$P(NODE1680,U,3) I PRVPTR="" Q  ; missing provider pointer
 .S PERSON=$P(NODE1680,U,2) I 'PERSON Q  ; missing person / non-person indicator
 .S PRVDATA=$$PRVDATA^IBTRHLO2(+$P(PRVPTR,";"),$P($P(PRVPTR,"(",2),","))
 .S TMP=$$GET1^DIQ(365.022,+$P(NODE1680,U)_",",.01)_HLECH_PERSON_HLECH_HLECH_"NM1 2010F"
 .S ADDR1=$P(PRVDATA,U,2,3),ADDR2=$P(PRVDATA,U,4,6)
 .S PRD="PRD"_HLFS_TMP_HLFS_$$HLNAME^HLFNC($P(PRVDATA,U))_HLFS_$$ENCHL7^IBCNEHLQ($P($$HLADDR^HLFNC(ADDR1,ADDR2),HLECH,1,5))
 .S $P(PRD,HLFS,8)=$P(PRVDATA,U,7)
 .S HCT=HCT+1,^TMP("HLS",$J,HCT)=PRD
 .; create PRD segment for X12 PRV segment
 .S PCODEPRV=$$PCODECNV^IBTRHLO2($P(TMP,HLECH)) I PCODEPRV'="" D
 ..I '$F(",AS,OP,OR,OT,PC,PE",","_PCODEPRV) Q
 ..N XTAX
 ..S XTAX=$P($$GTXNMY^IBTRH3(PRVPTR),"^")  ;11/24/15 only code, not description
 ..I XTAX="" Q
 ..S TMP=PCODEPRV_HLECH_HLECH_HLECH_"PRV 2010F"
 ..S PRD="PRD"_HLFS_TMP
 ..S $P(PRD,HLFS,8)=XTAX_HLECH_"PXC"
 ..S HCT=HCT+1,^TMP("HLS",$J,HCT)=PRD
 ..Q
 .Q 
 Q
 ;
OBR ; create OBR segment
 N OBR,Z,Z1
 I $TR(NODE18,U)="" Q
 S OBR="OBR"
 S $P(OBR,HLFS,5)="CR1 2000E"
 S $P(OBR,HLFS,14)=$P(NODE18,U,4)
 S $P(OBR,HLFS,19)=$$ENCHL7^IBCNEHLQ($P(NODE18,U,9))
 S $P(OBR,HLFS,20)=$$ENCHL7^IBCNEHLQ($P(NODE18,U,10))
 S Z1=""
 S Z=$P(NODE18,U,2) I Z'="" S Z1=$$ENCHL7^IBCNEHLQ(Z)_HLECH_$P(NODE18,U)
 S Z=$P(NODE18,U,6) I Z'="" S Z1=$G(Z1)_HLREP_$$ENCHL7^IBCNEHLQ(Z)_HLECH_$P(NODE18,U,5)
 I Z1'="" S $P(OBR,HLFS,28)=Z1
 S $P(OBR,HLFS,47)=$P(NODE18,U,3)
 S HCT=HCT+1,^TMP("HLS",$J,HCT)=OBR
 Q
