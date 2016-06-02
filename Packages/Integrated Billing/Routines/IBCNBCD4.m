IBCNBCD4 ;ALB/AWC - MCCF FY14 Subscriber Display Screens ;25 Feb 2015
 ;;2.0;INTEGRATED BILLING;**528**;21-MAR-94;Build 163
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;Input Parameters:
 ;  See routine IBCNBCD1
 ;
SBDISP(IBBUFDA,IBDFN,IBPOLDA,IBSEL,IBRIEN,IBSIEN,IBFNAM,IBVAL,IBHOLD,IBXHOLD) ; Display Subscriber Registration Data - Called from ACSUB^IBCNBAA
 N IBI,IBCNT,IBOUT,IBREL,IBIEN,IBV,DIERR,IBRET
 S IBCNT=1,(IBOUT,IBREL,IBIEN)=0
 ;
 S IBHOLD=$NA(^TMP("IBCNBCD4 SBDISP HOLD DATA",$J)),IBXHOLD=$NA(^TMP("IBCNBCD4 SBDISP HOLD EXTERNAL DATA",$J))
 K @IBHOLD
 K @IBXHOLD
 ;
 N IB1,IB2,IB3,IB4,IB5,IB6,IB7,IB8,IB9,IB10,IB11,IB12,IB13,IB14,IB15,IB16,IB17,IB18,IB19,IB20
 S IB1="Subscriber Id:"
 S IB2="Whose Insurance:"
 S IB3="Relationship:"
 S IB4="Rx Relationship:"
 S IB5="Rx Person Code:"
 S IB6="Subscriber Name:"
 S IB7="Subscriber's DOB:"
 S IB8="Subscriber's SSN:"
 S IB9="Subscriber's SEX:"
 S IB10="Primary Provider:"
 S IB11="Provider Phone:"
 S IB12="Coor of Benefits:"
 S IB13="Patient Id:"
 S IB14="Subscr Str Ln 1:"
 S IB15="Subscr Str Ln 2:"
 S IB16="Subscr City:"
 S IB17="Subscr State:"
 S IB18="Subscr Zip:"
 S IB19="Subscr Country:"
 S IB20="Subscr Phone:"
 ;
 ;
 ; -- get corresponding IEN from the PT. RELATIONSHIP - HIPAA(#2.312,4.03) to the IEN for the RELATIONSHIP FILE(#408.11)
 S IBV=$P($G(IBVAL),U,2) I IBV]"" S IBREL=+$O(^DG(408.11,"B",IBV,0))
 ;
 ; -- get the pointer to where the demographic data is located via the PATIENT RELATION FILE(#408.12)
 I IBV]"",+IBREL F IBI=0:0 S IBI=$O(^DGPR(408.12,"B",IBDFN,IBI)) Q:IBI'>0!(IBOUT)  D  Q:$D(DIERR)
 . ;
 . D GETS^DIQ(408.12,IBI_",",".01;.02;.03","I","IBRET","DIERR") I $D(DIERR) W !,"Error...SBVAL-IBCNBCD4 Cannot access Patient Relationship data!" D PAUSE^VALM1 Q
 . ;
 . I +$G(IBRET(408.12,IBI_",",.02,"I"))=IBREL D
 . . ;
 . . S IBIEN=$P($G(IBRET(408.12,IBI_",",.03,"I")),";"),IBFNAM=$P($P($G(IBRET(408.12,IBI_",",.03,"I")),"("),";",2)
 . . S IBOUT=1
 ;
 ; -- write header
 W !,! D WRTFLD(" Subscriber Data:  Patient Registration            Patient Insurance Policy   ",0,80,"BU")
 ;
 ; -- if relationship demographic data located in patient file(#2)
 I +IBPOLDA,+IBIEN,IBFNAM="DPT" D  Q
 . ;
 . D PDIS^IBCNBCD5(IBBUFDA,IBIEN,IBSIEN,IBSEL,IBV,IB1,IB2,IB3,IB4,IB5,IB6,IB7,IB8,IB9,IB10,IB11,IB12,IB13,IB14,IB15,IB16,IB17,IB18,IB19,IB20,.IBHOLD,.IBXHOLD)
 . ;
 . D WRTBLD
 ;
 ;
 ; -- if relationship demographic data located in income person file(#408.13)
 I +IBPOLDA,+IBIEN,IBFNAM="DGPR" D  Q
 . ;
 . D IDIS^IBCNBCD5(IBBUFDA,IBIEN,IBSIEN,IBSEL,IBV,IB1,IB2,IB3,IB4,IB5,IB6,IB7,IB8,IB9,IB10,IB11,IB12,IB13,IB14,IB15,IB16,IB17,IB18,IB19,IB20,.IBHOLD,.IBXHOLD)
 . ;
 . D WRTBLD
 ;
 ;
 ; -- no relationship patient/income person data found
 I +IBPOLDA,'IBIEN D  Q
 . ;
 . D NDIS^IBCNBCD5(IBBUFDA,IBIEN,IBSIEN,IBSEL,IBV,IB1,IB2,IB3,IB4,IB5,IB6,IB7,IB8,IB9,IB10,IB11,IB12,IB13,IB14,IB15,IB16,IB17,IB18,IB19,IB20,.IBHOLD,.IBXHOLD)
 . ;
 . D WRTBLD
 Q
 ;
BD(IBBUFDA,IBTXT,IBFLD,IBDAT,IBSEL,IBSIEN,IBXFLD,IBXDAT,IBCNT,IBHOLD,IBXHOLD) ; Display Insurance Verification Processor information <and> Insurance Policy information
 N X,Y,IBOVER,IBMERG,IBITER,IBITER1,IBITER2,IBDIS,IBEM,%DT
 S (IBITER1,IBITER2)=0,IBITER=1
 ;
 ; ******* left side of screen BEGIN *****
 S @IBHOLD@(2,IBFLD)=IBDAT
 ;
 ; -- format date of birth
 I IBFLD=".03" D
 . S X=IBDAT K Y S %DT="XP",%DT(0)=-DT D ^%DT K %DT(0) S X=Y K:Y<1 X
 . I $G(X)]"" S IBDAT=$$UP^XLFSTR($$FMTE^XLFDT(X,1)),@IBHOLD@(2,IBFLD)=IBDAT
 ; -- format ssn
 I IBFLD=".09" D
 . I $L(IBDAT)=9 S IBDAT=$E(IBDAT,1,3)_"-"_$E(IBDAT,4,5)_"-"_$E(IBDAT,6,9),@IBHOLD@(2,IBFLD)=IBDAT Q
 . I $L(IBDAT)=11 S IBDAT=$E(IBDAT,10,11)_$E(IBDAT,1,9),@IBHOLD@(2,IBFLD)=IBDAT
 ; -- format phone number
 I IBFLD=".131" D
 . I $L(IBDAT)=7 S IBDAT=$E(IBDAT,1,3)_"-"_$E(IBDAT,4,7),@IBHOLD@(2,IBFLD)=IBDAT Q
 . I $L(IBDAT)=10 S IBDAT="("_$E(IBDAT,1,3)_")"_$E(IBDAT,4,6)_"-"_$E(IBDAT,7,10),@IBHOLD@(2,IBFLD)=IBDAT Q
 . I $L(IBDAT)=11 S IBDAT=$E(IBDAT)_"-"_"("_$E(IBDAT,1,3)_")"_$E(IBDAT,4,6)_"-"_$E(IBDAT,7,10),@IBHOLD@(2,IBFLD)=IBDAT Q
 . I $L(IBDAT)=12,IBDAT?3N."-".3N."-".4N S IBDAT="("_$E(IBDAT,1,3)_")"_$E(IBDAT,4,12),@IBHOLD@(2,IBFLD)=IBDAT
 ;
 ; -- self    whose insurance and relationship
 I IBSEL=18&(IBFLD="60.05") S IBDAT="VETERAN",@IBHOLD@(2,IBFLD)=IBDAT
 I IBSEL=18&(IBFLD="60.14") S IBDAT="SELF",@IBHOLD@(2,IBFLD)=IBDAT
 ;
 ; -- spouse  whose insurance and relationship
 I IBSEL=1&(IBFLD="60.05") S IBDAT="SPOUSE",@IBHOLD@(2,IBFLD)=IBDAT
 I IBSEL=1&(IBFLD="60.14") S IBDAT="SPOUSE",@IBHOLD@(2,IBFLD)=IBDAT
 ;
 ; -- not spouse or self
 I IBSEL'=18&(IBSEL'=1)&(IBFLD="60.14") S IBDAT="",@IBHOLD@(2,IBFLD)=IBDAT
 ;
 ; -- rx relationship
 I IBFLD="60.15",IBDAT]"" D  Q:$D(DIERR)
 . S IBDIS=$S(IBDAT=0:1,IBDAT=1:2,IBDAT=2:3,IBDAT=3:4,IBDAT=4:5,1:IBDAT)
 . I +IBDIS D
 . . S IBDAT=IBDAT_" - "_$$GET1^DIQ(9002313.19,IBDIS_",",".02","E",,"DIERR") I $D(DIERR) D IBQ("Error #2...DISBUF-IBCNBCD4 Cannot access Rx Relationship data!") Q
 S IBITER1=$L(IBDAT)-1\29+1
 ; ******* left side of screen END *****
 ;
 ;
 ; ******* right side of screen BEGIN *****
 ; -- rx relationship
 I IBXFLD="4.05",IBXDAT]"" D  Q:$D(DIERR)
 . S IBDIS=$S(IBXDAT=0:1,IBXDAT=1:2,IBXDAT=2:3,IBXDAT=3:4,IBXDAT=4:5,1:IBXDAT)
 . I +IBDIS D
 . . S IBXDAT=IBXDAT_" - "_$$GET1^DIQ(9002313.19,IBDIS_",",".02","E",,"DIERR") I $D(DIERR) D IBQ("Error #4...DISBUF-IBCNBCD4 Cannot access Rx Relationship data!") Q
 ; ******* right side of screen END *****
 ;
 S @IBXHOLD@(2,IBXFLD)=IBXDAT
 S IBITER2=$L(IBXDAT)-1\29+1
 S IBITER=$S(IBITER2>IBITER1:IBITER2,IBITER1>IBITER2:IBITER1,IBITER1=IBITER2:IBITER1,1:1)
 S IBOVER=$S(IBDAT'=""&(IBDAT'=IBXDAT):"B",1:""),IBMERG=$S(IBXDAT="":"B",1:"")
 D WRTLN(IBTXT,IBDAT,IBXDAT,IBOVER,IBMERG)
 Q
 ;
WRTLN(IBTXT,FLD1,FLD2,OVER,MERG,ATTR) ; write a line of formatted data with label and two fields
 N IBCTR,IBSV,IBEV,IBBUFV,IBSPV
 S IBSV=1,IBEV=29
 S ATTR=$G(ATTR),OVER=ATTR_$G(OVER),MERG=ATTR_$G(MERG)
 S IBTXT=$J(IBTXT,17)_"  "
 W !
 I '$G(IBITER) S IBITER=1
 F IBCTR=1:1:IBITER D
 . S IBBUFV=$E(FLD1,IBSV,IBEV)
 . S IBSPV=$E(FLD2,IBSV,IBEV)
 . I $L(IBBUFV)<29 S IBBUFV=IBBUFV_$J("",29-$L(IBBUFV))
 . I $L(IBSPV)<29 S IBSPV=IBSPV_$J("",29-$L(IBSPV))
 . D:IBCTR=1 WRTFLD(IBTXT,0,19,ATTR)
 . D WRTFLD(IBBUFV,19,29,MERG)
 . D WRTFLD(" | ",48,3,ATTR),WRTFLD(IBSPV,51,29,OVER)
 . I IBITER>1,IBCTR'=IBITER W !
 . S IBSV=IBSV+29
 . S IBEV=IBEV+29
 Q
 ;
WRTFLD(STRING,COL,WD,ATTR) ; write an individual field with display attributes
 N ATTRB,ATTRE,DX,DY,X,Y
 S ATTRB="",ATTRB=$S(ATTR["B":$G(IOINHI),1:"")_$S(ATTR["U":$G(IOUON),1:"")
 S ATTRE="",ATTRE=$S(ATTR["B":$G(IOINORM),1:"")_$S(ATTR["U":$G(IOUOFF),1:"")
 ;
 S DX=COL,DY=$Y X IOXY
 W ATTRB,$E(STRING,1,WD),ATTRE
 S DX=(COL+WD),DY=$Y X IOXY
 Q
 ;
WRTBLD ; Write footer in bold
 N IBF1,IBF2
 S IBF1="(bold=accepted on merge)",IBF2="(bold=replaced on overwrite)"
 D WRTLN("",IBF1,IBF2,"","","U")
 Q
 ;
IBQ(IBEM) ; write error message
 ; Input: IBEM - Error message text
 W !,IBEM
 D PAUSE^VALM1
 Q
