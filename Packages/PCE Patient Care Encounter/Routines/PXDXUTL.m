PXDXUTL ;HP/TJH - DX CODE SET UTILITIES FOR PCE ;15 Aug 2012  9:22 AM
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**199**;Aug 12, 1996;Build 51
 ;
 Q  ; Library utilities, do not enter from top.
 ;
ACTIVE(PXCS) ; Return start date for requested coding system
 ;  Input:  Coding system abbreviation from #80.4 or #757.03
 ;          ICD, ICP, 10D, 10P
 ;
 ;  Output:  n^FM date  where
 ;           n = 0 ; requested coding system is not active
 ;           n = 1 ; requested coding system is active
 ;           FM date = starting date of requested code type
 ;      or
 ;           -1^error message ; coding system not valid
 ;
 N PXICDD,PXOUT,X,Y
 S X=PXCS,DIC=80.4,DIC(0)="",D="C" D IX^DIC
 I Y<0 Q "-1^Invalid Coding System"
 S PXICDD=$$IMPDATE^LEXU(PXCS)
 S PXOUT=$S(PXICDD'<DT:0,1:1)_U_PXICDD
 K D,DIC
 Q PXOUT
 ;
AVDX ; Build array of available Diagnosis Sets (Dx only, not Procedure Sets) in PXDXA("DX SET",fm-date)
 ; [1] = IEN in #80.4
 ; [2] = Code Set name
 ; [3] = Code Set abbreviation
 ; [4] = File number holding code set values (always 80 in this function)
 ; [5] = Date that code set becomes active (FM format)
 N PXMSG,PXI,PXD,PXR
 K PXDXA
 D LIST^DIC(80.4,"",".02;.03I;.04I","P","","","","","I $P(^(0),U,3)=80","","PXDXA","PXMSG")
 Q:'$D(PXDXA("DILIST",0))
 F PXI=1:1:$P(PXDXA("DILIST",0),U,1) D
 . S PXR=PXDXA("DILIST",PXI,0),PXD=$P(PXR,U,5)
 . S PXDXA("DX SET",PXD)=PXR
 K PXDXA("DILIST")
 Q
 ;
AVDXT ; AVDX TEST SET
 ;S PXDXA("DX SET",2781001)="1^ICD-9-CM^ICD^80^2781001"
 ;S PXDXA("DX SET",3131001)="30^ICD-10-CM^10D^80^3131001"
 ;S PXDXA("DX SET",3201001)="47^ICD-11-CM^11D^80^3201001"
 ;S PXDXA("DX SET",3501001)="50^ICD-12-CM^12D^80^3501001"
 Q
 ;
ACTDT(PXTRXD) ; Active Dx Code Set for date supplied
 ; Input - a FileMan date
 ; Returns 4 piece value:
 ; [1] = Code Set abbreviation
 ; [2] = IEN into file #80.4
 ; [3] = Long name
 ; [4] = Activation Date (FM)
 ; or
 ; 0 if no active Dx code set is found for the date supplied
 ;
 N PXDT,PXOUT,PXREC
 D AVDX
 I '$D(PXDXA("DX SET")) Q 0
 S PXDT=0,PXOUT=0
 F  S PXDT=$O(PXDXA("DX SET",PXDT)) Q:PXDT=""  D
 . S PXREC=PXDXA("DX SET",PXDT)
 . I PXTRXD'<PXDT S PXOUT=$P(PXREC,U,3)_U_$P(PXREC,U,1)_U_$P(PXREC,U,2)_U_$P(PXREC,U,5)
 K PXDXA
 Q PXOUT
 ;
SDESC(PXPOVIEN) ; Return short description for Computed field .019 - ICD NARRATIVE of file [#9000010.07]
 ; This function is not intended for general use.
 ;   Input:  a pointer to V POV [#9000010.07]
 ;
 ;   Output: the versioned DIAGNOSIS field from ICD DIAGNOSIS file [#80]
 ;           based on the associated Visit Date
 I 'PXPOVIEN Q PXPOVIEN  ; if it's not a numeric IEN just send back the input value
 N PXDX,PXVISD,PXVISIEN,X
 S X="DX not found because Visit Date is not available."
 Q:'$P($G(^AUPNVPOV(PXPOVIEN,0)),U,3) X  ; Quit with error message; must have a visit date ptr.
 S PXDX=$P(^AUPNVPOV(PXPOVIEN,0),U,1) ; get the file #80 IEN for the diagnosis
 S PXVISIEN=$P(^AUPNVPOV(PXPOVIEN,0),U,3) ; get the Visit IEN
 S PXVISD=$$CSDATE(PXVISIEN) ; get Visit Date from VISIT file
 S X=$$ICDDATA^ICDXCODE("DIAG",PXDX,PXVISD,"I") ; feed data to ICDDATA function
 Q $S($P(X,U,1)=-1:$P(X,U,2),1:$P(X,U,4))  ; return error msg or description
 ;
CSDATE(VSITIEN) ; Determine date to be used with diagnosis code look-ups when making ^ICDXCODE calls
 ; Input - Visit IEN for file #9000010
 ; Output - FileMan date (Time element is removed if it exists)
 ; Returns Visit Date unless this is an "E" record, in which case it returns Data Entry Date.
 ; If, for some unknown reason, the Visit record doesn't exist the output will default to Today's date.
 ;
 N PXVREC
 S PXVREC=$S($L(VSITIEN):$G(^AUPNVSIT(VSITIEN,0)),1:"")
 Q $S(PXVREC="":DT,$P(PXVREC,U,7)="E":$P($P(PXVREC,U,2),".",1),1:$P($P(PXVREC,U,1),".",1))
 ;
