DGPTRNU1 ;ISF/GJW,HIOFO/FT - PTF TRANSMISSION UTILITY ;4/20/15 10:28am
 ;;5.3;Registration;**884**;Aug 13, 1993;Build 31
 ;
 ;no external references
 ;
DXLSONLY(DGPTF) ;no secondary diagnoses
 N IENS,ROOT,MROOT,FIELDS,I,VAL
 S IENS=$G(DGPTF)_","
 S FIELDS="79.16;79.17;79.18;79.19;79.201;79.21;79.22;79.23;79.24;79.241;79.242;79.243;79.244;79.245;79.246;79.247;79.248;79.249;79.2491;79.24911;79.24912;79.24913;79.24914;79.24915"
 D GETS^DIQ(45,IENS,FIELDS,"I","ROOT","MROOT")
 S VAL=1 ;defaault to yes
 F I=1:1:$L(FIELDS,";") D
 .I $G(ROOT(45,IENS,$P(FIELDS,";",I),"I"))'="" S VAL=0
 Q VAL
 ;
TDIS(DGPTF) ;type of disposition
 N IENS
 S IENS=DGPTF_","
 Q $$GET1^DIQ(45,IENS,72,"I")
 ;
JUSTIFY(DGX,DGWIDTH,DGPAD,DGDIR,DGTRUNC) ;justify within a field
 ;DGX - the value to be justified
 ;DGWIDTH - width of the field
 ;DGPAD - pad character (defaults to space)
 ;DGDIR - direction of justification ("L" or "R", defaults to "L")
 ;DGTRUNC - should the value be truncated if it is larger than DGWIDTH Default is 1 (yes).
 N PAD,I,N
 S DGX=$G(DGX),DGDIR=$G(DGDIR,"L"),DGPAD=$G(DGPAD," ")
 S DGPAD=$E(DGPAD,1),DGTRUNC=$G(DGTRUNC,1)
 S PAD="",VAL=$G(DGX)
 I $L(DGX)<DGWIDTH D
 .S N=DGWIDTH-$L(DGX)
 .F I=1:1:N S PAD=PAD_DGPAD
 .S VAL=$S(DGDIR="L":DGX_PAD,1:PAD_DGX)
 I ($L(DGX)'<DGWIDTH)&DGTRUNC S VAL=$E(VAL,1,DGWIDTH)
 Q VAL
 ;
SPEC2PTF(DGSPEC) ;return bed/ward (PTF code) for specialty
 N Y,ARRY,X
 S Y=$$TSDATA^DGACT(42.4,DGSPEC,.ARRY)
 S X=$S(Y'>0:"",1:$G(ARRY(7)))
 S X=$$JUSTIFY(X,2,"0","R")
 Q X
 ;
FMTMPCR(DGX) ;format MPCR code
 Q $E($P(DGX,".")_"0000",1,4)_$E($P(DGX,".",2)_"00",1,2)
 ;
CDATA(PTF,SEG) ;control data (all segments)
 N NODE ;return value
 N IENS,IENS2
 N DFN,SSN,PSR,FAC,SUF,ADATE,ATIME
 S IENS=PTF_","
 S DFN=$$GET1^DIQ(45,IENS,.01,"I"),IENS2=DFN_","
 S SSN=$$GET1^DIQ(2,IENS2,.09,"I")
 S PSR=$$GET1^DIQ(2,IENS2,.0906,"I") ;pseudo-SSN reason
 S NODE=$G(SEG) ;transaction type
 S $E(NODE,6,14)=SSN
 S $E(NODE,5)=$S($L(PSR)>0:"P",1:" ")
 S ADATE=$$GET1^DIQ(45,IENS,2,"I") ;admission date
 S $E(NODE,15,20)=$$FDATE^DGPTRNU($P(ADATE,".")) ;format as MMDDYY
 S ATIME=$$TIME^DGPTRNU(ADATE) ;admission time (HHMM)
 S:ATIME'?4N ATIME="0000"
 S $E(NODE,21,24)=ATIME
 S FAC=$$GET1^DIQ(45,IENS,3,"I") ;facility number
 S $E(NODE,25,27)=FAC ;discharge facility
 S SUF=$$GET1^DIQ(45,IENS,5,"I") ;suffix
 S $E(NODE,28,30)=$E(SUF_"   ",1,3) ;suffix (or blank)
 Q NODE
