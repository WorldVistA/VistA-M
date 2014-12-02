IBDUTICD ;ALB/SS - ICD10 UTILITIES ;07/20/11
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**63**;APR 24, 1997;Build 80
 ;
 ;a wrapper for IMPDATE API 
IMPDATE(IBDCDSYS) ;
 Q $$IMPDATE^LEXU(IBDCDSYS)
 ;
 ;
 ;A wrapper for CODELIST API
 ;IBDCSYS - coding system (see #80.4)
 ;IBDSPEC - wild card search string 
 ;IBDSUB - subscript for the ^TMP global
 ;IBDATE - date of interest
 ;IBDLEN - number of returned values
 ;IBDFMT - list format
 ;example:
 ;W $$CODELIST^LEX10CS("10D","E80*","ZZX",3150101,"",1)
 ;1^10
 ;Global ^TMP(,$J
 ;^TMP("IBDFN4_SS",543733994,0)=10
 ; 1)="E80.0"
 ;^TMP("IBDFN4_SS",543733994,1,1)="503506;ICD9(^E80.0^3131001"
 ; 2)="5002981^Hereditary Erythropoietic Porphyria"
CODELIST(IBDCSYS,IBDSPEC,IBDSUB,IBDATE,IBDLEN,IBDFMT) ;
 N IBDRETV
 K ^TMP("IBDCODLST",$J)
 S IBDATE=$S($G(IBDATE)<$$IMPDATE(IBDCSYS):$$IMPDATE(IBDCSYS),1:$G(IBDATE))
 ;don't pass the date to perform the "unversioned lookup"
 S IBDRETV=$$CODELIST^LEX10CS(IBDCSYS,IBDSPEC,"IBDCODLST",,$G(IBDLEN),$G(IBDFMT))
 I $P(IBDRETV,U,1)<1!($P(IBDRETV,U,2)=0) Q IBDRETV
 ;cleanup the output array:
 ; - leave codes if the last status entry is ACTIVE 
 ; - leave codes if the last status entry is INACTIVE but the last INACTIVE status date is greater than the current date
 S IBDRETV=$$REMINTMP("IBDCODLST",IBDSUB,IBDATE)
 K ^TMP("IBDCODLST",$J)
 Q IBDRETV
 ;
 ;for $$CODELIST^LEX10CS
 ; - leave codes if the last status entry is ACTIVE 
 ; - leave codes if the last status entry is INACTIVE but the last INACTIVE status date is greater than the current date
 ; - remove all other codes
 ;and move results to another ^TMP 
REMINTMP(IBDSUB,IBDSUBOU,IBDDT) ;
 N IBDCOUNT,IBDZ1,IBDCODEV
 S IBDCOUNT=0
 S IBDZ1=0 F  S IBDZ1=$O(^TMP(IBDSUB,$J,IBDZ1)) Q:+IBDZ1=0  D
 . S IBDCODEV=$G(^TMP(IBDSUB,$J,IBDZ1))
 . I $$FILTER(IBDCODEV,IBDDT)=1 S IBDCOUNT=IBDCOUNT+1 M ^TMP(IBDSUBOU,$J,IBDCOUNT)=^TMP(IBDSUB,$J,IBDZ1)
 ;set 0th node
 S:IBDCOUNT>0 ^TMP(IBDSUBOU,$J,0)=IBDCOUNT
 Q "1^"_(+IBDCOUNT)
 ;
 ;IBDCODEV - external value of the code
 ;IBDDATE - date of interest
 ;return 1:
 ; if the last status entry for the ICD is ACTIVE
 ; if the last status entry for the ICD is INACTIVE but the date of interest is less than the last status date
 ;return 0:
 ; if the last status entry for the ICD is INACTIVE but the date of interest greater or equal to the last status date
 ; if the status values is not valid
FILTER(IBDCODEV,IBDDATE) ;
 N IBDARR,IBSTAT
 I $$HIST^ICDEX(IBDCODEV,.IBDARR,30)=-1 Q 0
 S IBSTAT=$$LASTSTAT(.IBDARR)
 I +IBSTAT=1 Q 1
 I +IBSTAT=0 I $P(IBSTAT,U,2)>IBDDATE Q 1
 Q 0
 ;
 ;return the date of the last active status (if there is only one then it is the last too) 
 ;IBDCODEV - external value of the code
 ;return 0 if error
 ; date of the 1st activation status (doesn't matter active or inactive)
LSTACTST(IBDCODEV) ;
 N IBDARR,IBSTAT,IBDT1
 I $$HIST^ICDEX(IBDCODEV,.IBDARR,30)=-1 Q 0
 S IBDT1=99999999
 F  S IBDT1=$O(IBDARR(IBDT1),-1) Q:+IBDT1=0  I IBDARR(IBDT1)=1 Q
 Q +IBDT1
 ;for $$DIAGSRCH^LEX10CS in IBDLXDG
 ; - leave codes if the last status entry is ACTIVE 
 ; - leave codes if the last status entry is INACTIVE but the last INACTIVE status date is greater than the current date
 ; - remove all other codes
 ;and move results to another local array  
REMINARR(IBDINOUT,IBDDT) ;
 Q:(+IBDINOUT)=-1 IBDINOUT
 N IBDCOUNT,IBDZ1,IBDCODEV,IBDINARR,IBD2PIEC
 S IBD2PIEC=+$P($G(IBDINOUT),U,2)
 M IBDINARR=IBDINOUT
 K IBDINOUT
 S IBDCOUNT=0
 S IBDZ1=0 F  S IBDZ1=$O(IBDINARR(IBDZ1)) Q:+IBDZ1=0  D
 . S IBDCODEV=$P($G(IBDINARR(IBDZ1,0)),U)
 . I $$FILTER(IBDCODEV,IBDDT)=1 S IBDCOUNT=IBDCOUNT+1 M IBDINOUT(IBDCOUNT)=IBDINARR(IBDZ1)
 ;set 0th node
 I IBDCOUNT>0 S IBDINOUT(0)=IBDCOUNT_$S(IBD2PIEC>0:U_IBD2PIEC,1:""),IBDINOUT=IBDINOUT(0) Q IBDINOUT
 Q "-1"
 ;
 ;get the last status in the history of status changes
LASTSTAT(IBDARR) ;
 N IBDX1,IBDX2
 S IBDX1=$O(IBDARR(99999999),-1)
 I +IBDX1=0 Q "-1"
 S IBDX2=$G(IBDARR(IBDX1))
 Q IBDX2_U_IBDX1
 ;
 ;A wrapper for the status check API
 ;input:
 ; IBDCDSYS - coding system like 1,30,"10D"
 ; IBDCOD - code value or IEN of files 80 or 80.1
 ; IBDDATE - the date we are checking the status against 
 ;output:
 ; -1 - invalid code
 ; 0 - inactive
 ; 1 - active
 ; 2 - Before implementation date 
STATCHK(IBDCDSYS,IBDCOD,IBDDATE) ;
 N IBDRET
 ;if ICD10 diag or ICD-10 proced
 ;I IBDCDSYS=30!(IBDCDSYS=31)!(IBDCDSYS="10D")!(IBDCDSYS="10P"),IBDDATE<$$IMPDATE(IBDCDSYS) Q 2
 I IBDDATE<$$IMPDATE(IBDCDSYS) Q 2
 S IBDRET=$$ICDDATA^ICDXCODE(IBDCDSYS,IBDCOD,IBDDATE)
 I +IBDRET<0 Q IBDRET
 Q $P(IBDRET,U,10)
 ;
 ;set CODING SYSTEM UPDATE fields in #357
 ;Examples:
 ; ICD10 to incomplete
 ;W $$CSUPD357^IBDUTICD(21,30,"@")
 ; ICD9 to REVIEW
 ;W $$CSUPD357^IBDUTICD(21,1,"R")
 ; create a new ICD10 entry if doesn't exist with incomplete status
 ;W $$CSUPD357^IBDUTICD(21,30,"")
 ; update just date and user
 ;W $$CSUPD357^IBDUTICD(21,30,"",3150101,.5)
 ;
 ;IBD357I - ien in the file #357
 ;IBDCODS - ien of the coding system file #80.4
 ;IBDSTAT - status like "C" or "R" (use "@" to delete the value and make it INCOMPLETE)
 ;IBDDAT - date of the update
 ;IBDUSER - DUZ of the user (ptr to the file #200)
CSUPD357(IBD357I,IBDCODS,IBDSTAT,IBDDAT,IBDUSER) ;
 N IBD35703
 S IBDSTAT=$G(IBDSTAT)
 S IBDDAT=+$G(IBDDAT) S IBDDAT=$S(IBDDAT>0:IBDDAT,1:DT)
 S IBDUSER=+$G(IBDUSER) S IBDUSER=$S(IBDUSER>0:IBDUSER,1:$S($G(DUZ)="":.5,1:+DUZ))
 S IBD35703=+$O(^IBE(357,IBD357I,3,"B",IBDCODS,0))
 I IBD35703=0 S IBD35703=$$NEW35703(IBD357I,IBDCODS,IBDSTAT,IBDDAT,IBDUSER) Q:IBD35703<0  Q $$UPD35703(IBD357I,IBD35703,"",IBDSTAT,IBDDAT,IBDUSER)
 Q $$UPD35703(IBD357I,IBD35703,IBDCODS,IBDSTAT,IBDDAT,IBDUSER)
 ;
 ;update the multiple with the status 
UPD35703(IBD357I,IBD35703,IBDCODS,IBDSTAT,IBDDAT,IBDUSER) ;
 N IBDVALAR,IBDCURST
 S:$G(IBDSTAT)'="" IBDVALAR(.02)=IBDSTAT
 I $G(IBDVALAR(.02))="@" K:$P($G(^IBE(357,IBD357I,3,IBD35703,0)),U,2)="" IBDVALAR(.02)
 S:$G(IBDCODS)'="" IBDVALAR(.01)=IBDCODS
 S:$G(IBDDAT)'="" IBDVALAR(.03)=IBDDAT
 S:$G(IBDUSER)'="" IBDVALAR(.04)=IBDUSER
 Q $$MULTFLDS^IBDUTIL1(357.03,IBD35703_","_IBD357I,.IBDVALAR,"I")
 ;
 ;W $$UPD35703^IBDUTICD(21,1,30,"C",DT,+DUZ)
NEW35703(IBD357I,IBDCODS,IBDSTAT,IBDDAT,IBDUSER) ;
 N IBD35703
 I +$O(^IBE(357,IBD357I,3,"B",IBDCODS,0)) Q 0
 S IBD35703=$$INSREC01^IBDUTIL1(357.03,IBD357I,IBDCODS,"I")
 Q IBD35703
 ;
 ;if date is before the ICD-10 eff date then make it ICD-10 eff date
 ;if greater then leave it as is.
ICD10DT(IBDATE) ;
 N IBD10DT
 S IBD10DT=$$IMPDATE(30)
 S IBDATE=$S($G(IBDATE)<IBD10DT:IBD10DT,1:$G(IBDATE))
 Q IBDATE
 ;
 ;prompt
ACTPRMT() ;
 N DTOUT,DUOUT,DIRUT,DIROUT,DIR
 S DIR("B")="ACTIVE"
 S DIR(0)="SA^A:ACTIVE;I:INACTIVE"
 S DIR("A")="Display codes [A]ctive, [I]nactive: "
 D ^DIR
 I $D(DIRUT) Q -1
 I $D(DUOUT) Q -2
 I $D(DIROUT) Q -3
 Q $G(Y)
 ;
 ;IBDFICD
