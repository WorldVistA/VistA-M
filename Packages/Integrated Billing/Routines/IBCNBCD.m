IBCNBCD ;ALB/ARH - Ins Buffer: display/compare buffer and existing ins ;1 Jun 97
 ;;2.0;INTEGRATED BILLING;**82,251,361,371,416,438,452,497,528,549**;21-MAR-94;Build 54
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
INS(IBBUFDA,IBINSDA) ; display a buffer entry's insurance company fields and
 ; an existing insurance company's fields for comparison
 N IBEXTDA,IBFLD1,IBFLD2,X I '$G(IBBUFDA) Q
 ;
 S IBEXTDA=$G(IBINSDA)_","
 ;
 I +$P($G(^DIC(36,+IBEXTDA,0)),U,5) W !,?10,"Selected Insurance Company "_$$GET1^DIQ(36,IBEXTDA,.01)_" is Inactive!",!
 ;
 W ! D WRTFLD("  Insurance Data:  Buffer Data                     Selected Insurance Company   ",0,80,"BU")
 S IBFLD1=$$GET1^DIQ(355.33,IBBUFDA,20.01),IBFLD2=$S(+IBEXTDA:$$GET1^DIQ(36,IBEXTDA,.01),1:"<none selected>") D WRTLN("Company Name:",IBFLD1,IBFLD2,"","","")
 S IBFLD1=$$GET1^DIQ(355.33,IBBUFDA,20.05),IBFLD2=$S(+IBEXTDA:$$GET1^DIQ(36,IBEXTDA,1),1:"") D WRTLN("Reimburse?:",IBFLD1,IBFLD2,"","","U")
 ;
 D DISPLAY(20.02,36,.131,"Phone Number:")
 D DISPLAY(20.03,36,.132,"Billing Phone:")
 D DISPLAY(20.04,36,.133,"Pre-Cert Phone:")
 D DISPLAY(21.01,36,.111,"Street [Line 1]:")
 D DISPLAY(21.02,36,.112,"Street [Line 2]:")
 D DISPLAY(21.03,36,.113,"Street [Line 3]:")
 D DISPLAY(21.04,36,.114,"City:")
 D DISPLAY(21.05,36,.115,"State:")
 D DISPLAY(21.06,36,.116,"Zip Code:")
 ;
 S IBFLD1="(bold=accepted on Merge)",IBFLD2="(bold=replaced on Overwrite)" D WRTLN("",IBFLD1,IBFLD2,"","","U")
 Q
 ;
GRP(IBBUFDA,IBGRPDA) ; display a buffer entry's group insurance fields and an existing group/plan's fields for comparison
 N IBEXTDA,IBFLD1,IBFLD2,X I '$G(IBBUFDA) Q
 ;
 S IBEXTDA=$G(IBGRPDA)_","
 ;
 I +$P($G(^IBA(355.3,+IBEXTDA,0)),U,11) W !,?23,"Selected Group/Plan is Inactive!",!
 ;
 W ! D WRTFLD(" Group/Plan Data:  Buffer Data                     Selected Group/Plan          ",0,80,"BU")
 S IBFLD1=$$GET1^DIQ(355.33,IBBUFDA,20.01),IBFLD2=$S(+IBEXTDA:$$GET1^DIQ(355.3,IBEXTDA,.01),1:"<none selected>") D WRTLN("Company Name:",IBFLD1,IBFLD2,"","","")
 S IBFLD1=$$GET1^DIQ(355.33,IBBUFDA,40.01),IBFLD2=$S(+IBEXTDA:$$GET1^DIQ(355.3,IBEXTDA,.02),1:"") D WRTLN("Is Group Plan?:",IBFLD1,IBFLD2,"","","U")
 ;
 D DISPLAY(90.01,355.3,2.01,"Group Name:")
 D DISPLAY(90.02,355.3,2.02,"Group Number:")
 D DISPLAY(40.1,355.3,6.02,"BIN:") ;;Daou/EEN - adding BIN and PCN
 D DISPLAY(40.11,355.3,6.03,"PCN:")
 D DISPLAY(40.04,355.3,.05,"Require UR:")
 D DISPLAY(40.05,355.3,.06,"Require Pre-Cert:")
 D DISPLAY(40.06,355.3,.12,"Require Amb Cert:")
 D DISPLAY(40.07,355.3,.07,"Exclude Pre-Cond:")
 D DISPLAY(40.08,355.3,.08,"Benefits Assign:")
 D DISPLAY(40.09,355.3,.09,"Type of Plan:")
 ;
 S IBFLD1="(bold=accepted on merge)",IBFLD2="(bold=replaced on overwrite)" D WRTLN("",IBFLD1,IBFLD2,"","","U")
 Q
 ;
POLICY(IBBUFDA,IBPOLDA) ; display a buffer entry's patient policy fields and an existing patient policy's fields for comparison
 N DFN,IBEXTDA,IBFLD1,IBFLD2,X,Y,DIR,DIRUT I '$G(IBBUFDA) Q
 S DFN=+$G(^IBA(355.33,IBBUFDA,60))
 ;
 S IBEXTDA=$G(IBPOLDA)_","_DFN_","
 ;
 W ! D WRTFLD("     Policy Data:  Buffer Data                     Selected Policy              ",0,80,"BU")
 S IBFLD1=$$GET1^DIQ(355.33,IBBUFDA,20.01),IBFLD2=$S(+IBEXTDA:$$GET1^DIQ(2.312,IBEXTDA,.01),1:"<none selected>") D WRTLN("Company Name:",IBFLD1,IBFLD2,"","","")
 S IBFLD1=$$GET1^DIQ(355.33,IBBUFDA,90.02),IBFLD2=$S(+IBEXTDA:$$GET1^DIQ(2.312,IBEXTDA,21),1:"") D WRTLN("Group #:",IBFLD1,IBFLD2,"","","")
 S IBFLD1=$$GET1^DIQ(355.33,IBBUFDA,60.01),IBFLD2=$S(+IBEXTDA:$$GET1^DIQ(2,DFN,.01),1:"") D WRTLN("Patient Name:",IBFLD1,IBFLD2,"","","")
 S IBFLD1=$P($$GET1^DIQ(355.33,IBBUFDA,.1),"@"),IBFLD2=$S(+IBEXTDA:$P($$GET1^DIQ(2.312,IBEXTDA,1.03),"@"),1:"") D WRTLN("Last Verified:",IBFLD1,IBFLD2,"","","U")
 ;
 D DISPLAY(60.02,2.312,8,"Effective Date:")
 D DISPLAY(60.03,2.312,3,"Expiration Date:")
 D DISPLAY(90.03,2.312,7.02,"Subscriber Id:")
 D DISPLAY(60.05,2.312,6,"Whose Insurance:")
 D DISPLAY(60.06,2.312,16,"Relationship:")
 D DISPLAY(60.15,2.312,4.05,"Rx Relationship:")
 D DISPLAY(60.16,2.312,4.06,"Rx Person Code:")
 D DISPLAY(91.01,2.312,7.01,"Subscriber Name:")
 D DISPLAY(60.08,2.312,3.01,"Subscriber's DOB:")
 D DISPLAY(60.09,2.312,3.05,"Subscriber's SSN:")
 D DISPLAY(60.13,2.312,3.12,"Subscriber's SEX:")
 D DISPLAY(60.1,2.312,4.01,"Primary Provider:")
 D DISPLAY(60.11,2.312,4.02,"Provider Phone:")
 D DISPLAY(60.12,2.312,.2,"Coor of Benefits:")
 D DISPLAY(61.01,2.312,2.1,"Emp Sponsored?:")
 D DISPLAY(62.01,2.312,5.01,"Patient Id:")
 D DISPLAY(62.02,2.312,3.06,"Subscr Str Ln 1:")
 D DISPLAY(62.03,2.312,3.07,"Subscr Str Ln 2:")
 D DISPLAY(62.04,2.312,3.08,"Subscr City:")
 D DISPLAY(62.05,2.312,3.09,"Subscr State:")
 D DISPLAY(62.06,2.312,3.1,"Subscr Zip:")
 D DISPLAY(62.07,2.312,3.13,"Subscr Country:")
 D DISPLAY(62.08,2.312,3.14,"Subscr Subdiv:")
 D DISPLAY(62.09,2.312,3.11,"Subscr Phone:")  ; 528 - baa
 ;
 I +$G(^IBA(355.33,IBBUFDA,61))!($$GET1^DIQ(2.312,IBEXTDA,2.1)="YES") D ESGHP
 ;
 S IBFLD1="(bold=accepted on merge)",IBFLD2="(bold=replaced on overwrite)" D WRTLN("",IBFLD1,IBFLD2,"","","U")
 ;
 Q
 ;
ESGHP ; display employee sponsored group health plan
 W ! S DIR(0)="E",DIR("A")="Enter RETURN to continue" D ^DIR W ! Q:$D(DIRUT)
 ;
 D DISPLAY(61.02,2.312,2.015,"Employer Name:")
 D DISPLAY(61.03,2.312,2.11,"Emp Status:")
 D DISPLAY(61.04,2.312,2.12,"Retirement Date:")
 D DISPLAY(61.05,2.312,2.01,"Send to Employer:")
 D DISPLAY(61.06,2.312,2.02,"Emp Street Ln 1:")
 D DISPLAY(61.07,2.312,2.03,"Emp Street Ln 2:")
 D DISPLAY(61.08,2.312,2.04,"Emp Street Ln 3:")
 D DISPLAY(61.09,2.312,2.05,"Emp City:")
 D DISPLAY(61.1,2.312,2.06,"Emp State:")
 D DISPLAY(61.11,2.312,2.07,"Emp Zip Code:")
 D DISPLAY(61.12,2.312,2.08,"Emp Phone:")
 Q
 ;
ELIG(IBBUFDA,IBPOLDA) ; Display eligibility/benefit data
 ; IB*2.0*549 Added EBGSTR,EBGLEN, arranged in alphabetical order
 N ATTR,BRELEN,BRESTR,BRPLEN,BRPSTR,CMPLEN,CMPSTR,DFN,EBDDATA,EBGLEN,EBGSTR,EBILEN,EBISTR
 N ENDSEC,EX,FLD1,FLD2,FLDIDX,GRPLEN,GRPSTR,HCSLEN,HCSSTR,I,I1,I2,IBVEBCOL,IDATA,LEN,NOBLEN
 N NOBSTR,NOCLEN,NOCSTR,NODATA,NOHLEN,NOHSTR,NOIDATA,RDATA,RESPIEN,SECEND,XX
 S EBGSTR="Payer Summary - from Payer's Response",EBGLEN=$L(EBGSTR)  ;IB*2.0*549 Added line
 S GRPSTR="Eligibility/Group Plan Information",GRPLEN=$L(GRPSTR)  ;IB*2*497 
 S EBISTR="Eligibility/Benefit Information",EBILEN=$L(EBISTR)
 S CMPSTR="Composite Medical Procedure Information",CMPLEN=$L(CMPSTR)
 S HCSSTR="Health Care Service Delivery",HCSLEN=$L(HCSSTR)
 S BRESTR="Benefit Related Entity",BRELEN=$L(BRESTR)
 S BRPSTR="Benefit Related Provider Information",BRPLEN=$L(BRPSTR)
 S NOHSTR="   No Health Care Service Delivery data on file for this EB record.",NOHLEN=$L(NOHSTR)
 S NOCSTR="   No Composite Medical Procedure Information data on file for this EB record.",NOCLEN=$L(NOCSTR)
 S NOBSTR="   No Benefit Related Entity data on file for this EB record.",NOBLEN=$L(NOBSTR)
 S EBDDATA="                    eIV Eligibility/Benefit Data Group#"
 S NODATA=1,EX=0
 ;
 ; Get the last response and make sure it contains EB data
 I $G(IBBUFDA) D
 . S RESPIEN=$O(^IBCN(365,"AF",IBBUFDA,""),-1)
 . I RESPIEN S:$O(^IBCN(365,RESPIEN,2,""))'="" NODATA=0
 W !
 S XX="        *** Non-editable Patient Eligibility/Benefit data from payer ***        "
 D WRTFLD(XX,0,80,"B")
 I NODATA D  Q
 . W !
 . S XX="          *** No Patient Eligibility/Benefit data from payer found***           "
 . D WRTFLD(XX,0,80,"B")
 . D ELIGX
 W !
 S XX="                   Payer Response                  VISTA Pt.Insurance           "
 D WRTFLD(XX,0,80,"BU")
 K ^TMP("RESP. EB DATA",$J),^TMP("INS. EB DATA",$J)
 K ^TMP("RESP. PS DATA",$J),^TMP("INS. PS DATA",$J)
 S DFN=+$G(^IBA(355.33,IBBUFDA,60))
 S IBVEBCOL=1,IDATA=""
 ;
 ; Fetch data from both eIV response and pat. insurance
 D INIT^IBCNES(365.02,RESPIEN_",","A",1,"RESP. EB DATA")
 D INIT0^IBCNES4(365.02,RESPIEN_",","RESP. PS DATA")
 D INIT^IBCNES(2.322,IBPOLDA_","_DFN_",","A",1,"INS. EB DATA")
 D INIT0^IBCNES4(2.322,IBPOLDA_","_DFN_",","INS. PS DATA",1)
 ;
 ; Check if there is any existing pat. insurance data
 I $E(^TMP("INS. EB DATA",$J,"DISP",2,0),1,41)="    No eIV Eligibility/Benefit Data Found" D
 . S NOIDATA=1
 ;
 ; Loop through response data and display it
 F FLDIDX=0:1:1 Q:EX  D
 . I +FLDIDX S FLD1=$NA(^TMP("RESP. EB DATA",$J,"DISP")),FLD2=$NA(^TMP("INS. EB DATA",$J,"DISP"))
 . E  S FLD1=$NA(^TMP("RESP. PS DATA",$J)),FLD2=$NA(^TMP("INS. PS DATA",$J))
 . S (I,I1)="",NOIDATA=0
 . F  S I=$O(@FLD1@(I)) Q:I=""!EX  D
 . . I $Y+3>IOSL D PAUSE^VALM1 W @IOF I 'Y S EX=1 Q
 . . S RDATA=@FLD1@(I,0)
 . . ;
 . . ; If group title, display it and quit
 . . I RDATA[EBDDATA D  Q
 . . . W !
 . . . D WRTFLD(RDATA,0,80,"B")
 . . . S IDATA=""
 . . ;
 . . ; If section title, display it and quit
 . . I $E(RDATA,1,EBGLEN)=EBGSTR D  Q         ; IB*2.0*549 Added if statement
 . . . W !!
 . . . D WRTFLD(RDATA,0,80,"U")
 . . . S I1=$$FNDNXT(I1,EBGSTR,EBGLEN),SECEND=0
 . . I $E(RDATA,1,GRPLEN)=GRPSTR D  Q         ;IB*2*497
 . . . W !!
 . . . D WRTFLD(RDATA,0,80,"U")
 . . . S I1=$$FNDNXT(I1,GRPSTR,GRPLEN),SECEND=0
 . . I $E(RDATA,1,EBILEN)=EBISTR D  Q
 . . . W !!
 . . . D WRTFLD(RDATA,0,80,"U")
 . . . S I1=$$FNDNXT(I1,EBISTR,EBILEN),SECEND=0
 . . I $E(RDATA,1,CMPLEN)=CMPSTR D  Q
 . . . W !!
 . . . D WRTFLD(RDATA,0,80,"U")
 . . . S I1=$$FNDNXT(I1,CMPSTR,CMPLEN),SECEND=0
 . . I $E(RDATA,1,HCSLEN)=HCSSTR D  Q
 . . . W !!
 . . . D WRTFLD(RDATA,0,80,"U")
 . . . S I1=$$FNDNXT(I1,HCSSTR,HCSLEN),SECEND=0
 . . I $E(RDATA,1,BRELEN)=BRESTR D  Q
 . . . W !!
 . . . D WRTFLD(RDATA,0,80,"U")
 . . . S I1=$$FNDNXT(I1,BRESTR,BRELEN),SECEND=0
 . . I $E(RDATA,1,BRPLEN)=BRPSTR D  Q
 . . . W !!
 . . . D WRTFLD(RDATA,0,80,"U")
 . . . S I1=$$FNDNXT(I1,BRPSTR,BRPLEN),SECEND=0
 . . I $E(RDATA,1,NOHLEN)=NOHSTR W ! D WRTFLD(RDATA,0,80,"") Q
 . . I $E(RDATA,1,NOCLEN)=NOCSTR W ! D WRTFLD(RDATA,0,80,"") Q
 . . I $E(RDATA,1,NOBLEN)=NOBSTR W ! D WRTFLD(RDATA,0,80,"") Q
 . . ;
 . . ; Build line with both eIV and pat. insurance values to compare
 . . I 'NOIDATA,I1'="",'SECEND S IDATA=$G(@FLD2@(I1,0)) D
 . . . ; if we run out of data for this section in pat. insurance
 . . . I $E(IDATA,1,EBILEN)=EBISTR!($E(IDATA,1,CMPLEN)=CMPSTR)!($E(IDATA,1,HCSLEN)=HCSSTR) D  Q
 . . . . S SECEND=1,IDATA=""
 . . . I $E(IDATA,1,BRELEN)=BRESTR!($E(IDATA,1,BRPLEN)=BRPSTR)!($E(IDATA,1,NOHLEN)=NOHSTR) D  Q
 . . . . S SECEND=1,IDATA=""
 . . . I $E(IDATA,1,GRPLEN)=GRPSTR!(IDATA[EBDDATA) S SECEND=1,IDATA="" Q
 . . . S I1=I1+1
 . . . I '$D(@FLD2@(I1)) S NOIDATA=1
 . . W !
 . . D WRTFLD(RDATA,0,47,""),WRTFLD(" | ",48,3,""),WRTFLD(IDATA,51,29,"")
 . I 'NOIDATA,'SECEND,'EX D  ; Print remaining data in second file, if any
 . . S I2=$O(@FLD2@(999999),-1)
 . . F I=I1:1:I2 S IDATA=$G(@FLD2@(I,0)) I $TR(IDATA," ")'="" D
 . . . W ! D WRTFLD(" | ",48,3,""),WRTFLD(IDATA,51,29,"")
ELIGX ;
 I 'EX D PAUSE^VALM1
 K ^TMP("RESP. EB DATA",$J),^TMP("INS. EB DATA",$J)
 K ^TMP("RESP. PS DATA",$J),^TMP("INS. PS DATA",$J)
 Q
 ;
FNDNXT(IDX,STR,LEN) ; find next node in INS. EB DATA after one that starts with string STR (section title)
 ; IDX - current index
 ; STR - string to find
 ; LEN - length of STR
 ; returns index of the node found or "" if nothing is found
 ;
 N I
 S I=IDX F  S I=$O(@FLD2@(I)) Q:I=""  Q:($E(@FLD2@(I,0),1,LEN)=STR)
 I +I S I=I+1 ; if found a match for section title, return the next index
 Q I
 ;
DISPLAY(BFLD,IFILE,IFLD,LABEL) ; extract, compare, write the two corresponding fields; one from buffer, one from ins files
 N BUFDATA,EXTDATA,IBOVER,IBMERG,IBITER,IBITER1,IBITER2 S EXTDATA=""
 S (IBITER1,IBITER2)=0
 S IBITER=1
 S BUFDATA=$$GET1^DIQ(355.33,IBBUFDA,BFLD)
 ;S IBITER1=$L(BUFDATA)/29
 ;I $P(IBITER1,".",2)>0 S IBITER1=$P(IBITER1,".",1)+1
 S IBITER1=$L(BUFDATA)-1\29+1
 I +IBEXTDA D
 . S EXTDATA=$$GET1^DIQ(IFILE,IBEXTDA,IFLD)
 . ; S IBITER2=$L(EXTDATA)/29
 . ; I $P(IBITER2,".",2)>0 S IBITER2=$P(IBITER2,".",1)+1
 . S IBITER2=$L(EXTDATA)-1\29+1
 ;
 S IBITER=$S(IBITER2>IBITER1:IBITER2,IBITER1>IBITER2:IBITER1,IBITER1=IBITER2:IBITER1,1:1)
 S IBOVER=$S(BUFDATA'=""&(BUFDATA'=EXTDATA):"B",1:""),IBMERG=$S(EXTDATA="":"B",1:"")
 ;
 D WRTLN(LABEL,BUFDATA,EXTDATA,IBOVER,IBMERG)
 Q
 ;
WRTLN(LABEL,FLD1,FLD2,OVER,MERG,ATTR) ; write a line of formatted data with label and two fields
 N IBCTR,IBSV,IBEV,IBBUFV,IBSPV
 S IBSV=1,IBEV=29
 S ATTR=$G(ATTR),OVER=ATTR_$G(OVER),MERG=ATTR_$G(MERG)
 ;S LABEL=$J(LABEL,17)_"  ",FLD1=FLD1_$J("",29-$L(FLD1)),FLD2=FLD2_$J("",29-$L(FLD2))
 S LABEL=$J(LABEL,17)_"  "
 W !
 I '$G(IBITER) S IBITER=1
 F IBCTR=1:1:IBITER D
 . S IBBUFV=$E(FLD1,IBSV,IBEV)
 . S IBSPV=$E(FLD2,IBSV,IBEV)
 . I $L(IBBUFV)<29 S IBBUFV=IBBUFV_$J("",29-$L(IBBUFV))
 . I $L(IBSPV)<29 S IBSPV=IBSPV_$J("",29-$L(IBSPV))
 . D:IBCTR=1 WRTFLD(LABEL,0,19,ATTR)
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
