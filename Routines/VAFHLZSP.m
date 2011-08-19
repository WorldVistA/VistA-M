VAFHLZSP ;ALB/RJS,TDM,PJH - ZSP SEGMENT - 3/18/96 ; 5/30/07 4:21pm
 ;;5.3;Registration;**94,106,122,220,653,754**;Aug 13, 1993;Build 46
EN(DFN,VAFNUM,VAFAMB) ;
 N VAROOT,VAFHROOT,VAFY,VAFNODE,VIETSRV,SERVCONN,PERCENT,POS,RETURN
 S VAROOT="VAFHROOT"
 D ELIG^VADPT
 ;- ALB/ESD - Added VAFNUM as part of Ambulatory Care Reporting Project
 ;            requirements.
 S VAFNUM=$S($G(VAFNUM):VAFNUM,1:1)
 S VAFAMB=+$G(VAFAMB,1)
 I $P(VAFHROOT(3),U,1)=1 S SERVCONN="Y",PERCENT=$P(VAFHROOT(3),U,2)
 I $P(VAFHROOT(3),U,1)=0 S SERVCONN="N"
 I VAFHROOT(2)'="" S POS=$P($G(^DIC(21,+VAFHROOT(2),0)),U,3)
 I '$D(SERVCONN) S SERVCONN=""""""
 I '$D(PERCENT) S PERCENT=""""""
 I '$D(POS) S POS=""""""
 ;
 ;- Convert Y/N to 1/0 (HL7 Table VA01)
 I $D(SERVCONN) S SERVCONN=$$YN^VAFHLFNC(SERVCONN)
 S RETURN="ZSP"_HLFS_VAFNUM_HLFS_SERVCONN_HLFS_PERCENT_HLFS_POS
 ;- ALB/ESD - Get 'Vietnam Service Indicated?' field from PATIENT file
 ;            (required by Ambulatory Care Reporting Project).
 ;I +$G(VAFAMB)=1 D
 ;. ;
 ;. ;- 'Vietnam Service Indicated?' field = Y, N, or U (UNKNOWN)
 ;. S VIETSRV=$P($G(^DPT(DFN,.321)),"^")
 ;. I $G(VIETSRV)="" S VIETSRV=""""""
 ;. S RETURN=RETURN_HLFS_VIETSRV
 ;
 ;- DG*5.3*220 REMOVED CHECK FOR VAFAMB PARAMETER
 ;'Vietnam Service Indicated?' field = Y, N, or U (UNKNOWN)
 S VIETSRV=$P($G(^DPT(DFN,.321)),"^")
 I $G(VIETSRV)="" S VIETSRV=""""""
 S RETURN=RETURN_HLFS_VIETSRV
 ;
 ; **** ALB/KCL - Patch DG*5.3*122; Add additional data fields ****
 S VAFNODE=$G(^DPT(DFN,.3))
 S $P(VAFY,HLFS,3)="",HLQ=$S($D(HLQ):HLQ,1:"""""")
 S $P(VAFY,HLFS,1)=$S($P(VAFNODE,"^",4)]"":$$YN^VAFHLFNC($P(VAFNODE,"^",4)),1:HLQ) ; P&T
 S $P(VAFY,HLFS,2)=$S($P(VAFNODE,"^",5)]"":$$YN^VAFHLFNC($P(VAFNODE,"^",5)),1:HLQ) ; Unemployable
 S $P(VAFY,HLFS,3)=$S($P(VAFNODE,"^",12)]"":$$HLDATE^HLFNC($P(VAFNODE,"^",12)),1:HLQ) ; SC Award Date
 S $P(VAFY,HLFS,5)=$S($P(VAFNODE,"^",13)]"":$$HLDATE^HLFNC($P(VAFNODE,"^",13)),1:HLQ) ; P&T Effective Date
 ; **** PJH - Patch DG*5.3*754; Add additional data field ****
 S $P(VAFY,HLFS,6)=$S($P(VAFNODE,"^",14)]"":$$HLDATE^HLFNC($P(VAFNODE,"^",14)),1:HLQ) ; Combined SC percent Effective Date
 ;
 S RETURN=RETURN_HLFS_$G(VAFY)
 ;
 ;
 D KVAR^VADPT
 Q RETURN
