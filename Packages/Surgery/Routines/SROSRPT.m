SROSRPT ;BIR/ADM - OPERATION REPORT ; [ 10/06/03  2:45 PM ]
 ;;3.0; Surgery ;**100**;24 Jun 93
 ;
 ;** NOTICE: This routine is part of an implementation of a nationally
 ;**         controlled procedure.  Local modifications to this routine
 ;**         are prohibited.
 ;
 ; Reference to EXTRACT^TIULQ supported by DBIA #2693
 ;
 Q
OPTOP(SRTN,SRLAST,SRG) ; send op-top to ^TMP
 ; SRTN   - case number in file 130
 ; SRLAST - (optional)
 ;          0 or null : include summary status at end
 ;          1 : omit summary status at end
 ;          2 : include summary status at end plus summary in TIU
 ; SRG    - (optional) return array
 ;
 Q:'$D(SROVP)
 N J,LOOP,SR,SRALL,SRCASE,SRERR,SRI,SRLF,SRSTAT,SRT,SRTIU
 S SRTIU=$P($G(^SRF(SRTN,"TIU")),"^") Q:'SRTIU
 D STATUS Q:SRSTAT>1
 S SRCASE=SRTN S:'$L($G(SRG)) SRG=$NA(^TMP("SROP",$J,SRCASE)) K @SRG
 S SRI=0,SRLAST=$S($G(SRLAST):SRLAST,1:1),@SRG@(SRI)=3
 I $P($G(^SRF(SRTN,30)),"^")!$P($G(^SRF(SRTN,31)),"^",8) D LINE(1) S @SRG@(SRI)="  * * OPERATION ABORTED * *" D LINE(1)
 S SR(0)=^SRF(SRTN,0)
 D PRIN I $O(^SRF(SRTN,13,0)) D OTHER
 Q
STATUS ; check status of TIU document
 D EXTRACT^TIULQ(SRTIU,"SRT",.SRERR,".05") S SRSTAT=SRT(SRTIU,.05,"I")
 Q
PRIN ; print principal procedure information
 N I,M,MM,MMM,SRJ,SROPER,SROPS
 D LINE(1) S @SRG@(SRI)="Procedure(s) Performed:"
PRIN2 S SROPER=$P(^SRF(SRTN,"OP"),"^")
 I $P($G(^SRF(SRTN,30)),"^")&$P($G(^SRF(SRTN,.2)),"^",10) S SROPER="** ABORTED ** "_SROPER
 K SROPS,MM,MMM S:$L(SROPER)<70 SROPS(1)=SROPER I $L(SROPER)>69 S SROPER=SROPER_"  " F M=1:1 D LOOP Q:MMM=""
 F I=1:1 Q:'$D(SROPS(I))  D LINE(1) S @SRG@(SRI)=$S(I=1:" Principal: ",1:"         ")_SROPS(I)
 Q
OTHER ; other procedures
 N CNT,OTH,OTHER
 S (OTH,CNT)=0 F  S OTH=$O(^SRF(SRTN,13,OTH)) Q:'OTH  S CNT=CNT+1 D OTH
 Q
OTH S OTHER=$P(^SRF(SRTN,13,OTH,0),"^")
 D LINE(1) S @SRG@(SRI)="     Other: "_OTHER
 Q
LOOP ; break procedure if greater than 70 characters
 S SROPS(M)="" F LOOP=1:1 S MM=$P(SROPER," "),MMM=$P(SROPER," ",2,200) Q:MMM=""  Q:$L(SROPS(M))+$L(MM)'<70  S SROPS(M)=SROPS(M)_MM_" ",SROPER=MMM
 Q
LINE(NUM) ;create carriage returns
 I $G(SRLF) S NUM=NUM+1,SRLF=0
 F J=1:1:NUM S SRI=SRI+1,@SRG@(SRI)=" "
 Q
