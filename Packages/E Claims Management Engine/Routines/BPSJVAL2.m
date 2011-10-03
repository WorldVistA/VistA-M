BPSJVAL2 ;BHAM ISC/LJF - Validate Pharmacy data ;3/5/08  11:14
 ;;1.0;E CLAIMS MGMT ENGINE;**1,2,5,7**;JUN 2004;Build 46
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 N PHARMIX,RET,DIR,X
 ;
 S PHARMIX=0,X=""
 F  S PHARMIX=$O(^BPS(9002313.56,PHARMIX)) Q:'PHARMIX  D  Q:X=U
 . W !!,"VERIFY PHARMACY REGISTRATIONS DATA.",!
 . D REG^BPSJPREG(PHARMIX,2)
 . W !
 . S DIR(0)="EO" D ^DIR
 ;
 Q
 ;
 ; Array HL and variable VERBOSE newed/set by calling routine
 ; RETCODE returned to calling routine
VALIDATE(BPSJDDD) ;
 N SEG,SEGIX,ZRP,RAY,RIX,PIX,PIXL,SEGDAT,ZNOTE,ZMAX,CPS,FS,REP
 N VALDATA,TMP
 S ZMAX=17
 ;
 S RETCODE=$G(RETCODE)
 S ZRP="",RIX=0
 ;
 ; Set HL7 Delimiters - use standard defaults if none provided
 S FS=$G(HL("FS")) I FS="" S FS="|"
 S CPS=$E($G(HL("ECH"))) I CPS="" S CPS="^"
 S REP=$E($G(HL("ECH")),2) I REP="" S REP="~"
 ;
 F SEGIX=3:1 S SEG=$G(^TMP("HLS",$J,SEGIX)),PIX=0 Q:SEG=""  D  I ZRP]"" Q
 . I $E(SEG,1,3)="ZRP" S ZRP=$E(SEG,4) S $E(SEG,1,4)=""
 I ZRP="" Q
 F  S RIX=$O(^TMP("HLS",$J,SEGIX,RIX)) Q:'RIX  I RIX<(ZMAX+1) D
 . S TMP=$P($G(^TMP("HLS",$J,SEGIX,RIX)),ZRP)
 . I $G(TMP)="" S RETCODE(RIX)=""
 . I RIX=3 S RETCODE(RIX)=TMP ;capture pharmacy name
 F  S RIX=$O(RETCODE(RIX)) Q:'RIX  D
 . D @RIX
 . I +$G(VERBOSE),$L($G(RETCODE(RIX))) W !,RETCODE(RIX)
 ;
 Q
 ;
 ; NS=Not Supported, R=Required, RE=Required or empty, C=Conditional
 ; CE=Conditional or empty, O=Optional,
 ;
1 ; Set ID - NS
 Q
2 ; NCPDP Number - C
 S ZNOTE="   NCPDP NUMBER - VALID"
 I RETCODE(RIX)="" D
 . I BPSJDDD=0 D
 . . I '$D(RETCODE(17)) Q
 . . S ZNOTE="** NCPDP NUMBER - NCPDP OR NPI - Missing/Invalid",RETCODE=2
 . . S RETCODE(RIX)=ZNOTE_RETCODE(RIX)
 Q
3 ; PHARMACY NAME - R
 S ZNOTE="   PHARMACY NAME"
 I RETCODE(RIX)="" D
 . S ZNOTE="** PHARMACY NAME - Missing/Invalid",RETCODE=3
 I RETCODE(RIX)]"" S RETCODE(RIX)=": "_$$DECODE(RETCODE(RIX))
 S RETCODE(RIX)=ZNOTE_RETCODE(RIX)
 Q
4 ; DEA Number - R
 S ZNOTE="   DEA NUMBER - Required - VALID"
 I RETCODE(RIX)="" D
 . S ZNOTE="** DEA NUMBER - Missing/Invalid",RETCODE=4
 . S RETCODE(RIX)=ZNOTE_RETCODE(RIX)
 Q
5 ; Hour of Operation
 S ZNOTE="" ; not sending anymore
 Q
6 ; Mailing Address - R
 S ZNOTE=$$TRIMTAIL(RETCODE(RIX))
 S VALDATA=($L($P(ZNOTE,CPS,1))<1)          ; Street address
 S VALDATA=($L($P(ZNOTE,CPS,3))<1)+VALDATA  ; City
 S VALDATA=($L($P(ZNOTE,CPS,4))<1)+VALDATA  ; State
 S VALDATA=($L($P(ZNOTE,CPS,5))<1)+VALDATA  ; Zip
 S ZNOTE="   MAILING ADDRESS - Required - VALID"
 I VALDATA D
 . S ZNOTE="** MAILING ADDRESS - Missing/Invalid",RETCODE=6
 . S RETCODE(RIX)=ZNOTE_RETCODE(RIX)
 Q
7 ; Remittance Address - R
 S ZNOTE=$$TRIMTAIL(RETCODE(RIX))
 S VALDATA=($L($P(ZNOTE,CPS,1))<1)          ; Street Address
 S VALDATA=($L($P(ZNOTE,CPS,3))<1)+VALDATA  ; City
 S VALDATA=($L($P(ZNOTE,CPS,4))<1)+VALDATA  ; State
 S VALDATA=($L($P(ZNOTE,CPS,5))<1)+VALDATA  ; Zip
 S ZNOTE="   REMITTANCE ADDRESS - Required - VALID"
 I VALDATA D
 . S ZNOTE="** REMITTANCE ADDRESS - Missing/Invalid",RETCODE=7
 . S RETCODE(RIX)=ZNOTE_RETCODE(RIX)
 Q
8 ; Contact Name
 S ZNOTE=$$TRIMTAIL(RETCODE(RIX))
 S VALDATA=($L($P(ZNOTE,CPS,1))<1)  ; Surname
 S ZNOTE="   CONTACT NAME - Required - VALID"
 I VALDATA D
 . S ZNOTE="** CONTACT NAME - Missing/Invalid",RETCODE=8
 . S RETCODE(RIX)=ZNOTE_RETCODE(RIX)
 Q
9 ; Contact Title
 S ZNOTE="   CONTACT TITLE - VALID"
 Q
10 ; Contact means
 S ZNOTE="   CONTACT MEANS - VALID"
 ;S RETCODE(RIX)=ZNOTE_RETCODE(RIX)
 Q
11 ; Alternate Contact Name
 S ZNOTE=$$TRIMTAIL(RETCODE(RIX))
 S VALDATA=($L($P(ZNOTE,CPS,1))<1)  ; Surname
 S ZNOTE="   ALTERNATE CONTACT NAME - Required - VALID"
 I VALDATA D
 . S ZNOTE="** ALTERNATE CONTACT NAME - Missing/Invalid",RETCODE=11
 . S RETCODE(RIX)=ZNOTE_RETCODE(RIX)
 Q
12 ; Alternate Contact Title
 S ZNOTE="   ALTERNATE CONTACT TITLE - VALID"
 Q
13 ; Alternate Contact means
 S ZNOTE="   ALTERNATE CONTACT MEANS - VALID"
 Q
14 ; Lead Pharmacist Name - R
 S ZNOTE=$$TRIMTAIL(RETCODE(RIX))
 S VALDATA=($L($P(ZNOTE,CPS,1))<1)  ; Surname
 S ZNOTE="   LEAD PHARMACIST NAME - Required - VALID"
 I VALDATA D
 . S ZNOTE="** LEAD PHARMACIST NAME - Missing/Invalid",RETCODE=14
 . S RETCODE(RIX)=ZNOTE_RETCODE(RIX)
 Q
15 ; Lead Pharmacist Title
 S ZNOTE="   LEAD PHARMACIST TITLE - VALID"
 Q
16 ; Lead Pharmacist License Number
 S ZNOTE="   LEAD PHARMACIST LICENSE NUMBER - VALID"
 Q
17 ; NPI Number - C (R - AFTER DDD)
 S ZNOTE="   NPI NUMBER - Required - VALID "
 I RETCODE(RIX)="" D
 . I BPSJDDD=0 D
 . . I '$D(RETCODE(2)) S ZNOTE="   NPI NUMBER - Warning NPI NUMBER Missing " Q
 . . S ZNOTE="** NPI NUMBER - NPI OR NCPDP - Missing/Invalid" S RETCODE=17
 . I BPSJDDD>0 D
 . . S ZNOTE="** NPI NUMBER - Missing/Invalid" S RETCODE=17
 . S RETCODE(RIX)=ZNOTE_RETCODE(RIX)
 Q
 ;
TRIMTAIL(INSTR) ;
 N OUTSTR,CHR
 ;
 I $G(INSTR)="" Q ""   ; quit if nothing there
 ;
 S INSTR=$RE(INSTR)
 S CHR=$E($TR(INSTR,CPS_REP))
 I CHR]"" Q $RE($P(INSTR,CHR,2,200))_CHR
 Q ""
 ;
 ; DECODE - Normalize data for display
 ; Input:
 ;   INSTR - String to normalize
 ; Output
 ;   Normalize data
DECODE(INSTR) ;
 N TRCH
 S TRCH("\F\")="|",TRCH("\R\")="~",TRCH("\E\")="\"
 S TRCH("\T\")="&",TRCH("\S\")="^"
 Q $$DECODE^BPSJZPR(INSTR,.TRCH)
