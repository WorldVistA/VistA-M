FBPCR4 ;WOIFO/SS-LTC PHASE 3 UTILITIES ;03/17/04
 ;;3.5;FEE BASIS;**48,76**;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 Q
 ;
INSURED(FBDFN,FBINDT1,FBINDT2) ;check if the patient has insurance
 ;FBDFN - patient DFN
 ;FBINDT1 - the treatment date - for outpatients,
 ;    FROM date - for inpatients,
 ;    certified date  - for Pharmacy
 ;FBINDT2 (optional) - TO date for inpatients
 N FBINS1
 S FBINS1=+$$INSUR^IBBAPI(FBDFN,FBINDT1)
 I FBINS1<0 D ADDERR(DFN) Q FBINCUNK  ;error handling
 Q:'$D(FBINDT2) FBINS1
 Q:FBINS1=1 1  ;if was insured for FROM date - don't check TO date
 S FBINS1=+$$INSUR^IBBAPI(FBDFN,FBINDT2) ;otherwise return the state on TO date
 I FBINS1<0 D ADDERR(DFN) Q FBINCUNK  ;error handling
 Q FBINS1
 ;
ADDERR(FBDFN) ;add error to ^TMP, FBDFN - patient DFN
 I FBPARTY=1 Q
 N DFN,FBPNAME,FBPID,FBDOB,FBPI
 S DFN=FBDFN
 D VET^FBPCR
 S ^TMP($J,"FBINSIBAPI")=$G(^TMP($J,"FBINSIBAPI"))+1
 S ^TMP($J,"FBINSIBAPI",DFN)=FBPID_"^"_FBDOB_"^"_FBPNAME
 Q
 ;
ERRHDL ;Error handler called from FBPCR
 I +$G(^TMP($J,"FBINSIBAPI"))=0 Q  ;no errors
 D PRNUNKN
 Q
 ;
PRNUNKN ;write output
 N FBDFN,FBDATA
 D PAGEINS
 I FBPG>1&(($Y+15)>IOSL) D HEADER Q:FBOUT
 S FBDFN=0 F  S FBDFN=$O(^TMP($J,"FBINSIBAPI",FBDFN)) Q:FBDFN']""!(FBOUT)  D  Q:FBOUT
 . I ($Y+6)>IOSL D PAGEINS Q:FBOUT
 . S FBDATA=$G(^TMP($J,"FBINSIBAPI",FBDFN))
 . W !,$P(FBDATA,"^",3),?40,$P(FBDATA,"^",1),?62,$P(FBDATA,"^",2)
 Q
PAGEINS ;new page
 D CHKPAGE Q:FBOUT
 D HEADER Q:FBOUT
 Q
CHKPAGE ;form feed when new station/patient
 S FBSTA=$G(FBPSF)_$G(FBPT)
 I FBCRT&(FBPG'=0) D CR^FBPCR Q:FBOUT
 I FBPG>0!FBCRT W @IOF
 S FBPG=FBPG+1
 Q
HEADER ;main header
 N FBSTR1 S FBSTR1="List of the patients whose insurance information is currently unavailable"
 W !?(IOM-30/2),"POTENTIAL COST RECOVERY REPORT"
 W !?(IOM-$L(FBSTR1)/2),FBSTR1
 W !?71,"Page: ",FBPG
 W !,"Patient",?40,"Pat. ID",?62,"DOB"
 W !,FBDASH
 Q
 ;/**filtering logic
 ;input:
 ; FBPARTY: 1-Patient copay only,2-Insurance only,3-Both
 ; FBCOPAY: 1-LTC copays only,2-MT copays only,3-Both
 ; FBINS:   1- has insurance,0-none
 ; FBCATC:  0 - no copay,1- MT copay,2-LTC copay,3-no 1010EC,4-more analysis is needed
 ;output:
 ; 1 - include to report
 ; 0 - exclude from report
FILTER() ;*/
 I FBPARTY=1,FBCATC=0 Q 0
 I FBPARTY=2,FBINS=0 Q 0
 I FBPARTY=3,FBINS=1 Q 1
 I FBCOPAY=1,FBCATC<2 Q 0
 I FBCOPAY=2,FBCATC'=1 Q 0
 Q 1
 ;
 ;/**
 ; returns LTC status
 ; input:  Patient's DFN, Date of Care
 ;
 ; return values: 
 ; 0 - no1010EC
 ; 1 - exemption from LTC copay
 ; 2 - LTC copay
LTCST(DFN,FBDT) ;*/
 Q +$$COPAY^EASECCAL(DFN,$$LASTDT(FBDT),1)
 ;
LASTDT(X) ; compute the last day of the month in X
 N XM,X1,X2
 I $E(X,4,5)=12 Q $E(X,1,5)_"31"
 S XM=$E(X,4,5)+1
 S:XM<10 XM="0"_XM
 S X1=$E(X,1,3)_XM_"01"
 S X2=-1
 D C^%DTC
 Q X
 ;
 ;
 ;prepares local array with LTC POV codes
 ;input: FBARRLTC must be defined
 ;output: FBARRLTC with POV codes
MKARRLTC ;
 N FBPOV,FBIEN,FBLTCTYP
 S FBPOV="" F  S FBPOV=$O(^FBAA(161.82,"C",FBPOV)) Q:'FBPOV  S FBIEN=+$O(^FBAA(161.82,"C",FBPOV,0)),FBLTCTYP=+$P($G(^FBAA(161.82,FBIEN,0)),"^",4) S:FBLTCTYP=1!(FBLTCTYP=2) FBARRLTC(FBPOV)=FBLTCTYP
 Q
 ;/**
 ; Determine if POV code is related to LTC.
 ;Input:
 ; FBPOV - POV code, pointer to #161.82
 ; FBARRLTC must be defined and populated - array with LTC POV codes (see MKARRLTC) 
 ;Output:
 ; returns 
 ; 0 - it is not LTC service
 ; 1 - this POV code is for LTC and recoverable from LTC copayment 
 ; 2 - this POV code is for LTC but it is not a subject of LTC copayment
ISLTC(FBPOV) ;*/
 Q +$G(FBARRLTC(FBPOV))
 ;
