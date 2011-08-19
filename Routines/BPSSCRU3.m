BPSSCRU3 ;BHAM ISC/SS - ECME SCREEN UTILITIES ;05-APR-05
 ;;1.0;E CLAIMS MGMT ENGINE;**1,5,7,8,9**;JUN 2004;Build 18
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;USER SCREEN
 Q
 ;get comment from BPS TRANSACTION file
 ;BP59 - ien in that file
COMMENT(BP59) ;
 N BPCMNT,BPX,BPTXT
 S BPCMNT=$O(^BPST(BP59,11,999999),-1)
 I BPCMNT="" Q ""
 S BPX=$G(^BPST(BP59,11,BPCMNT,0))
 S BPTXT=$P(BPX,U,3) I $L(BPTXT)>60 S BPTXT=$E(BPTXT,1,58)_"..."
 Q $$DATTIM($P(BPX,U,1)\1)_" - "_BPTXT_U_$$USERNAM^BPSCMT01($P(BPX,U,2))
 ;
DATTIM(X) ;Convert FM date to displayable (mm/dd/yy HH:MM) format.
 I +X=0 W ""
 N DATE,YR,BPT,BPM,BPH,BPAP
 I $G(X) S YR=$E(X,2,3)
 I $G(X) S DATE=$S(X:$E(X,4,5)_"/"_$E(X,6,7)_"/"_YR,1:"")
 S BPT=$P(X,".",2) S:$L(BPT)<4 BPT=BPT_$E("0000",1,4-$L(BPT))
 S BPH=$E(BPT,1,2),BPM=$E(BPT,3,4)
 S BPAP="a" I BPH>12 S BPH=BPH-12,BPAP="p" S:$L(BPH)<2 BPH="0"_BPH
 I BPT S:'BPH BPH=12 S DATE=DATE_" "_BPH_":"_BPM_BPAP
 Q $G(DATE)
 ;/**
 ;a wrapper for $$STATUS^BPSOSRX to get the status by BPS TRANSACTION pointer
 ;input BP59 - ptr to 9002313.59
 ;output - pieces 1,2 and 3 of the $$STATUS^BPSOSRX output
 ; example: "E REVERSAL ACCEPTED^3071206.152829^Reversal Accepted"
CLAIMST(BP59) ;*/
 N BPX,BPSTATUS,BPREF,BPSCHED
 N BPCOB S BPCOB=$$COB59^BPSUTIL2(BP59)
 S BPSCHED=0
 S BPX=$$RXREF^BPSSCRU2(BP59)
 S BPREF=$P(BPX,U,2)
 S BPSTATUS=$$STATUS^BPSOSRX(+BPX,BPREF,,,BPCOB)
 ;if the request completed (99%) and there is another active (scheduled, activated, 
 ;in process,completed but not inactivated yet) request then return IN PROGRESS
 I $P(BPSTATUS,U,4)=99,$$ACTREQS^BPSOSRX6(+BPX,BPREF,BPCOB) S BPSCHED=1
 I BPSCHED I ($P(BPSTATUS,U)="E PAYABLE")!($P(BPSTATUS,U)="E REVERSAL ACCEPTED") Q "IN PROGRESS"_U_$P(BPSTATUS,U,2)
 Q $P(BPSTATUS,U,1,3)
 ;
 ;/**
 ;pointers for RESPONSE file (#9002313.03) by pointer in TRANSACTION file #9002313.59
 ;B59 - ptr to #9002313.59
 ;BPRESP - ptr to #9002313.03
 ;BPPOS - position inside #9002313.03 (i.e. the number 
 ;of the claim in the transmission - currently we always have only 1
GRESPPOS(BP59,BPRESP,BPPOS) ;*/
 I $G(^BPST(BP59,4)) D  ; reversal kind of message
 . S BPRESP=+$P(^BPST(BP59,4),U,2)
 . S BPPOS=1
 E  D
 . S BPRESP=+$P($G(^BPST(BP59,0)),U,5)
 . S BPPOS=+$P($G(^BPST(BP59,0)),U,9)
 Q:+BPRESP=0 0
 Q:+BPPOS=0 0
 Q 1
 ;
 ;/**
 ;reject message from RESPONSE file
 ;BP59 - ptr to 9002313.59
 ;BPTOP - top level index (for exmpl "504" for ^BPSR(D0,504)= (#504) Message [1F]
 ;BPDEEP - lower level (for exmpl BPTOP=1000 and BPDEEP=525 for  
 ;  ^BPSR(D0,1000,D1,525)= (#525) DUR Response Data [1F]
 ;
GETMESS(BPTOP,BPDEEP,BP59) ;
 N BP59DAT,BPRESP,BPPOS
 N BP1
 ;S (BPRESP,BPPOS)=0
 ;get response and position in the BPS RESPONSE file
 I $$GRESPPOS(BP59,.BPRESP,.BPPOS)=0 Q ""
 ; -------- transmission specific message ----------
 I BPTOP=504 Q $P($G(^BPSR(BPRESP,504)),U)
 ;
 ; -------claim specific message-----------
 ;assuming there is only one claim/response per transmission
 S BP1=$O(^BPSR(BPRESP,BPTOP,0))
 I BP1=0 Q ""
 ;---525: DUR
 ;---526: Additional Message Information
 ;---504: Message for the claim
 I (BPDEEP=525)!(BPDEEP=526)!(BPDEEP=504) Q $P($G(^BPSR(BPRESP,1000,BPPOS,BPDEEP)),U)
 Q ""
 ;
 ;reject message from RESPONSE file
 ;BP59 - ptr to 9002313.59
 ;BPARR1 - array to return messages (by ref)
 ;BPN1 - index for the array (by ref - will 
 ;  be incremented if more than one node added)
 ;BPMLEN - max length for each string
 ;PBPREF - for prefix string
 ;. D GETMESS^BPSSCRU3(1000,504,BP59,.BPARR,.BPN,50)
 ;compare GETRJCOD from BPSSCRu2
GETRJCOD(BP59,BPARR1,BPN1,BPMLEN,PBPREF) ;
 N BP59DAT S BP59DAT=$G(^BPST(BP59,0))
 N BPRESP,BPPOS
 N BPRJCOD
 N BPRJTXT
 N BPSTR
 N BPRJ
 ;pointers for RESPONSE file (#9002313.03) by pointer in TRANSACTION file #9002313.59
 ;get response and position 
 I $$GRESPPOS(BP59,.BPRESP,.BPPOS)=0 Q
 S BPRJ=0
 S BPSTR=""
 F  S BPRJ=$O(^BPSR(BPRESP,1000,BPPOS,511,BPRJ)) Q:+BPRJ=0  D
 . S BPRJCOD=$P($G(^BPSR(BPRESP,1000,BPPOS,511,BPRJ,0)),U)
 . Q:$L(BPRJCOD)=0
 . S BPRJTXT=$$GETRJNAM(BPRJCOD)
 . S BPN1=BPN1+1,BPARR1(BPN1)=PBPREF_BPRJTXT
 Q BPN1
 ;/**
 ;Input:
 ; BP59 - pointer to file #9002313.59
 ;Output:
 ; BPRCODES - array for reject codes by reference
REJCODES(BP59,BPRCODES) ;get reject codes
 N BPRESP,BPPOS,BPA,BPR
 ;pointers for RESPONSE file (#9002313.03) by pointer in TRANSACTION file #9002313.59
 ;get response and position
 I $$GRESPPOS(BP59,.BPRESP,.BPPOS)=0 Q
 ;
 S BPA=0
 F  S BPA=$O(^BPSR(BPRESP,1000,BPPOS,511,BPA)) Q:'BPA  D
 . S BPR=$P(^BPSR(BPRESP,1000,BPPOS,511,BPA,0),U)
 . I BPR'="" S BPRCODES(BPR)=""
 Q
 ;/**
 ;BPRJCODE - code
GETRJNAM(BPRJCODE) ;*/
 N BPRJIEN
 S BPRJIEN=$O(^BPSF(9002313.93,"B",BPRJCODE,0))
 Q:+BPRJIEN=0 ""
 Q BPRJCODE_":"_$P($G(^BPSF(9002313.93,BPRJIEN,0)),U,2)
 ;/**
 ;BP59 - ptr to 9002313.59
 ;was the claim ever autoreversed ?
AUTOREV(BP59) ;*/
 N BP02
 S BP02=+$P($G(^BPST(BP59,0)),U,4)
 Q +$P($G(^BPSC(BP02,0)),U,7)
 ;
 ;/**
 ;BP59 - ptr to 9002313.59
 ;returns :
 ;0 Waiting to start
 ;10 Gathering claim info
 ;19 Special Grouping
 ;30 Waiting for packet build
 ;31 Wait for retry (insurer asleep)
 ;40 Packet being built
 ;50 Waiting for transmit
 ;51 Wait for retry (comms error)
 ;60 Transmitting
 ;70 Receiving Response
 ;80 Waiting to process response
 ;90 Processing response
 ;99 Done
 ;
PRCNTG(BP59) ;*/
 Q +$P($G(^BPST(BP59,0)),U,2)
 ;
 ;
LINE(BPN,BPCH) ;
 N BP1
 S $P(BP1,BPCH,BPN+1)=""
 Q BP1
 ;
DTTIME(X) ;Convert FM date to displayable (mm/dd/yy HH:MM) format.
 I +X=0 W ""
 N DATE,YR,BPT,BPM,BPH,BPAP,BPS
 I $G(X) S YR=$E(X,1,3)+1700
 I $G(X) S DATE=$S(X:$E(X,4,5)_"/"_$E(X,6,7)_"/"_YR,1:"")
 S BPT=$P(X,".",2)
 I BPT S:$L(BPT)<6 BPT=BPT_$E("000000",1,6-$L(BPT))
 S BPH=$E(BPT,1,2),BPM=$E(BPT,3,4),BPS=$E(BPT,5,6)
 I BPT S DATE=DATE_"@"_BPH_":"_BPM_":"_BPS
 Q $G(DATE)
 ;
 ;call IB API to get insurance data, then select proper insurance by its name
 ;get its phone number
 ;input: 
 ; DFN - patient IEN in #2
 ; BPDOS - date of service
 ; BPINSNM - insurance name
 ;output: insurance ien^insurance name^phone
GETPHONE(BPDFN,BPDOS,BPINSNM) ;
 N BPX,BPZZ,BP1,BPPHONE
 S BPPHONE=""
 I $$INSUR^IBBAPI(BPDFN,BPDOS,,.BPZZ,"1,6")'=1 Q ""
 S BP1="" F  S BP1=$O(BPZZ("IBBAPI","INSUR",BP1)) Q:+BP1=0  D
 . I BPINSNM=$P($G(BPZZ("IBBAPI","INSUR",BP1,1)),U,2) S BPPHONE=$G(BPZZ("IBBAPI","INSUR",BP1,6)) Q
 Q BPPHONE
 ;
 ;try to get insurance name and phone from #9002313.59, #9002313.57 and from INSUR^IBBAPI 
 ;input: BP59 - ien in #9002313.59
 ;return insurance_name^phone#
NAMEPHON(BP59) ;
 N BPHONE,BPINSNM,BPINSID,BP57,BPINSN
 S BPHONE=$P($G(^BPST(BP59,10,+$G(^BPST(BP59,9)),3)),U,2)
 S BPINSNM=$P($G(^BPST(BP59,10,+$G(^BPST(BP59,9)),0)),U,7)
 S BP57=0
 F  Q:(BPHONE'="")&(BPINSNM'="")  S BP57=$O(^BPSTL("B",BP59,BP57)) Q:+BP57=0  D
 . S BPINSN=+$G(^BPSTL(BP57,9))
 . S:BPHONE="" BPHONE=$P($G(^BPSTL(BP57,10,BPINSN,3)),U,2)
 . S:BPINSNM="" BPINSNM=$P($G(^BPSTL(BP57,10,BPINSN,0)),U,7)
 ;
 I (BPINSNM'="")&(BPHONE="") D
 . S BPDOS=+$P($G(^BPST(BP59,12)),U,2)\1
 . I BPDOS=0 S BPDOS=+$P($G(^BPST(BP59,0)),U,8)\1
 . S BPDFN=+$P($G(^BPST(BP59,0)),U,6)
 . S BPHONE=$$GETPHONE(BPDFN,BPDOS,BPINSNM)
 Q BPINSNM_U_BPHONE
 ;
