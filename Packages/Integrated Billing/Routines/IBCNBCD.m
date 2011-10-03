IBCNBCD ;ALB/ARH-Ins Buffer: display/compare buffer and existing ins ;1 Jun 97
 ;;2.0;INTEGRATED BILLING;**82,251,361,371,416**;21-MAR-94;Build 58
 ;;Per VHA Directive 2004-038, this routine should not be modified.
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
 D DISPLAY(40.02,355.3,.03,"Group Name:")
 D DISPLAY(40.03,355.3,.04,"Group Number:")
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
 S IBFLD1=$$GET1^DIQ(355.33,IBBUFDA,40.03),IBFLD2=$S(+IBEXTDA:$$GET1^DIQ(2.312,IBEXTDA,21),1:"") D WRTLN("Group #:",IBFLD1,IBFLD2,"","","")
 S IBFLD1=$$GET1^DIQ(355.33,IBBUFDA,60.01),IBFLD2=$S(+IBEXTDA:$$GET1^DIQ(2,DFN,.01),1:"") D WRTLN("Patient Name:",IBFLD1,IBFLD2,"","","")
 S IBFLD1=$P($$GET1^DIQ(355.33,IBBUFDA,.1),"@"),IBFLD2=$S(+IBEXTDA:$P($$GET1^DIQ(2.312,IBEXTDA,1.03),"@"),1:"") D WRTLN("Last Verified:",IBFLD1,IBFLD2,"","","U")
 ;
 D DISPLAY(60.02,2.312,8,"Effective Date:")
 D DISPLAY(60.03,2.312,3,"Expiration Date:")
 D DISPLAY(60.04,2.312,1,"Subscriber Id:")
 D DISPLAY(60.05,2.312,6,"Whose Insurance:")
 D DISPLAY(60.06,2.312,16,"Relationship:")
 D DISPLAY(60.07,2.312,17,"Name of Insured:")
 D DISPLAY(60.08,2.312,3.01,"Insured's DOB:")
 D DISPLAY(60.09,2.312,3.05,"Insured's SSN:")
 D DISPLAY(60.13,2.312,3.12,"Insured's SEX:")
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
 ;
 Q
 ;
ELIG(IBBUFDA,IBPOLDA) ; display eligibilty/benefit data
 N ATTR,BRESTR,BRELEN,BRPSTR,BRPLEN,CMPSTR,CMPLEN,DFN,EBISTR,EBILEN,EX,HCSSTR,HCSLEN,I,I1,IBVEBCOL,LEN,RESPIEN
 N RDATA,IDATA,NODATA,NOIDATA,ENDSEC,NOHSTR,NOHLEN,NOCSTR,NOCLEN,NOBSTR,NOBLEN
 S EBISTR="Eligibility/Benefit Information",EBILEN=$L(EBISTR)
 S CMPSTR="Composite Medical Procedure Information",CMPLEN=$L(CMPSTR)
 S HCSSTR="Health Care Service Delivery",HCSLEN=$L(HCSSTR)
 S BRESTR="Benefit Related Entity",BRELEN=$L(BRESTR)
 S BRPSTR="Benefit Related Provider Information",BRPLEN=$L(BRPSTR)
 S NOHSTR="   No Health Care Service Delivery data on file for this EB record.",NOHLEN=$L(NOHSTR)
 S NOCSTR="   No Composite Medical Procedure Information data on file for this EB record.",NOCLEN=$L(NOCSTR)
 S NOBSTR="   No Benefit Related Entity data on file for this EB record.",NOBLEN=$L(NOBSTR)
 S NODATA=1,NOIDATA=0,EX=0
 ; get the last reponse and make sure it contains EB data
 I $G(IBBUFDA) S RESPIEN=$O(^IBCN(365,"AF",IBBUFDA,""),-1) I RESPIEN S:$O(^IBCN(365,RESPIEN,2,""))'="" NODATA=0
 W ! D WRTFLD("        *** Non-editable Patient Eligibility/Benefit data from payer ***        ",0,80,"B")
 I NODATA W ! D WRTFLD("          *** No Patient Eligibility/Benefit data from payer found***           ",0,80,"B") G ELIGX
 W ! D WRTFLD("                   Payer Response                  VISTA Pt.Insurance           ",0,80,"BU")
 K ^TMP("RESP. EB DATA",$J),^TMP("INS. EB DATA",$J)
 S DFN=+$G(^IBA(355.33,IBBUFDA,60))
 S IBVEBCOL=1,IDATA=""
 ; fetch data from both eIV response and pat. insurance
 D INIT^IBCNES(365.02,RESPIEN_",","A",1,"RESP. EB DATA")
 D INIT^IBCNES(2.322,IBPOLDA_","_DFN_",","A",1,"INS. EB DATA")
 ; check if there is any existing pat. insurance data
 I $E(^TMP("INS. EB DATA",$J,"DISP",2,0),1,41)="    No eIV Eligibility/Benefit Data Found" S NOIDATA=1
 ; loop through response data and display it
 S (I,I1)="" F  S I=$O(^TMP("RESP. EB DATA",$J,"DISP",I)) Q:I=""!EX  D
 .I $Y+3>IOSL D PAUSE^VALM1 W @IOF I 'Y S EX=1 Q
 .S RDATA=^TMP("RESP. EB DATA",$J,"DISP",I,0)
 .; skip empty lines
 .I $TR(RDATA," ")="" Q
 .; if group title, display it and quit
 .I RDATA["                    eIV Eligibility/Benefit Data Group#" W ! D WRTFLD(RDATA,0,80,"B") S IDATA="" Q
 .; if section title, display it and quit
 .I $E(RDATA,1,EBILEN)=EBISTR W !! D WRTFLD(RDATA,0,80,"U") S I1=$$FNDNXT(I1,EBISTR,EBILEN),SECEND=0 Q
 .I $E(RDATA,1,CMPLEN)=CMPSTR W !! D WRTFLD(RDATA,0,80,"U") S I1=$$FNDNXT(I1,CMPSTR,CMPLEN),SECEND=0 Q
 .I $E(RDATA,1,HCSLEN)=HCSSTR W !! D WRTFLD(RDATA,0,80,"U") S I1=$$FNDNXT(I1,HCSSTR,HCSLEN),SECEND=0 Q
 .I $E(RDATA,1,BRELEN)=BRESTR W !! D WRTFLD(RDATA,0,80,"U") S I1=$$FNDNXT(I1,BRESTR,BRELEN),SECEND=0 Q
 .I $E(RDATA,1,BRPLEN)=BRPSTR W !! D WRTFLD(RDATA,0,80,"U") S I1=$$FNDNXT(I1,BRPSTR,BRPLEN),SECEND=0 Q
 .I $E(RDATA,1,NOHLEN)=NOHSTR W ! D WRTFLD(RDATA,0,80,"") Q
 .I $E(RDATA,1,NOCLEN)=NOCSTR W ! D WRTFLD(RDATA,0,80,"") Q
 .I $E(RDATA,1,NOBLEN)=NOBSTR W ! D WRTFLD(RDATA,0,80,"") Q
 .; build line with both eIV and pat. insurance values to compare
 .I 'NOIDATA,I1'="",'SECEND S IDATA=$G(^TMP("INS. EB DATA",$J,"DISP",I1,0)) D
 ..; if we run out of data for this section in pat. insurance
 ..I $E(IDATA,1,EBILEN)=EBISTR!($E(IDATA,1,CMPLEN)=CMPSTR)!($E(IDATA,1,HCSLEN)=HCSSTR) S SECEND=1,IDATA="" Q
 ..I $E(IDATA,1,BRELEN)=BRESTR!($E(IDATA,1,BRPLEN)=BRPSTR)!($E(IDATA,1,NOHLEN)=NOHSTR) S SECEND=1,IDATA="" Q
 ..S I1=I1+1 I '$D(^TMP("INS. EB DATA",$J,"DISP",I1)) S NOIDATA=1
 ..Q
 .W ! D WRTFLD(RDATA,0,47,""),WRTFLD(" | ",48,3,""),WRTFLD(IDATA,51,29,"")
 .Q
ELIGX ;
 I 'EX D PAUSE^VALM1
 K ^TMP("RESP. EB DATA",$J),^TMP("INS. EB DATA",$J)
 Q
 ;
FNDNXT(IDX,STR,LEN) ; find next node in INS. EB DATA after one that starts with string STR (section title)
 ; IDX - current index
 ; STR - string to find
 ; LEN - length of STR
 ; returns index of the node found or "" if nothing is found
 ;
 N I
 S I=IDX F  S I=$O(^TMP("INS. EB DATA",$J,"DISP",I)) Q:I=""  Q:($E(^TMP("INS. EB DATA",$J,"DISP",I,0),1,LEN)=STR)
 I +I S I=I+1 ; if found a match for section title, return the next index
 Q I
 ;
DISPLAY(BFLD,IFILE,IFLD,LABEL) ; extract, compare, write the two corresponding fields; one from buffer, one from ins files
 N BUFDATA,EXTDATA,IBOVER,IBMERG S EXTDATA=""
 S BUFDATA=$$GET1^DIQ(355.33,IBBUFDA,BFLD)
 I +IBEXTDA S EXTDATA=$$GET1^DIQ(IFILE,IBEXTDA,IFLD)
 ;
 S IBOVER=$S(BUFDATA'=""&(BUFDATA'=EXTDATA):"B",1:""),IBMERG=$S(EXTDATA="":"B",1:"")
 ;
 D WRTLN(LABEL,BUFDATA,EXTDATA,IBOVER,IBMERG)
 Q
 ;
WRTLN(LABEL,FLD1,FLD2,OVER,MERG,ATTR) ; write a line of formatted data with label and two fields
 S ATTR=$G(ATTR),OVER=ATTR_$G(OVER),MERG=ATTR_$G(MERG)
 S LABEL=$J(LABEL,17)_"  ",FLD1=FLD1_$J("",29-$L(FLD1)),FLD2=FLD2_$J("",29-$L(FLD2))
 W !
 D WRTFLD(LABEL,0,19,ATTR),WRTFLD(FLD1,19,29,MERG)
 D WRTFLD(" | ",48,3,ATTR),WRTFLD(FLD2,51,29,OVER)
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
