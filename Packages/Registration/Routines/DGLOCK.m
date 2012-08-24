DGLOCK ;ALB/MRL,ERC,BAJ,LBD - PATIENT FILE DATA EDIT CHECKS ; 2/14/11 4:36pm
 ;;5.3;Registration;**108,161,247,485,672,673,688,754,797**;Aug 13, 1993;Build 24
FFP ; DGFFP Access key required
 I '$D(^XUSEC("DGFFP ACCESS",DUZ)) D EN^DDIOL("Fugitive Felon Key required to edit this field.","","!!?4") K X
 Q
EK ;EKey Rqrd
 I '$D(^XUSEC("DG ELIGIBILITY",DUZ)) W !?4,$C(7),"Eligibility Key required to edit this field." K X
 Q
EV ;EK rqrd if Elig Ver
 I '$D(^XUSEC("DG ELIGIBILITY",DUZ)),$D(^DPT(DFN,.361)) I $P(^(.361),U,1)="V" D EN^DDIOL("Eligibility verified...Eligibility Key required to edit this field.","","!?4") K X
 Q
EV2 ;if elig is ver Discharged Due to Disability can't be edited - DG 672
 ;if elig is ver P&T and P&T Eff Date can't be edited - DG*5.3*688
 I $D(^DPT(DFN,.361)) I $P(^(.361),U,1)="V" D
 . I $P(^DPT(DFN,.361),U,3)'="H" Q
 . D EN^DDIOL("Eligibility verified at the HEC...NO EDITING!","","!?4") K X
 Q
SV ;EK Rqrd if Svc Rcrd Ver
 I "NU"'[$E(X) D VET Q:'$D(X)
SV1 I '$D(^XUSEC("DG ELIGIBILITY",DUZ)),$D(^DPT(DFN,.32)) I $P(^(.32),U,2)]"" D EN^DDIOL("Service Record verfied...Eligibility Key required to edit this field.","","!?4") K X
 Q
MV ;EK Rqrd if Money Ver
 I "NU"'[$E(X) D VET Q:'$D(X)
 I '$D(^XUSEC("DG ELIGIBILITY",DUZ)),$D(^DPT(DFN,.3)) I $P(^(.3),U,6)]"" W !?4,$C(7),"Monetary Benefits verified...Eligibility Key required to edit this field." K X
 Q
VET ;Veteran
 S DGVV=$S($D(^DPT(DFN,"TYPE")):^("TYPE"),1:""),DGVV=$S($D(^DG(391,+DGVV,0)):$P(^(0),"^",2),1:"")
 I $D(^DPT(DFN,"VET")),^("VET")'="Y",'DGVV D EN^DDIOL("Applicant is NOT a veteran!!","","!?4") K X
 K DGVV Q
VAGE ;Vet Age
 S DGDATA=X,X1=DT,X2=$S($D(DFN):$P(^DPT(DFN,0),U,3),1:DPTIDS(.03)) S X=$E(X1,1,3)-$E(X2,1,3)-($E(X1,4,7)<$E(X2,4,7))
 I X<17 W !?4,$C(7),"Applicant is TOO YOUNG to be a veteran...ONLY ",X," YEARS OLD!!",!?4,"See your supervisor if you require assistance." K X,X1,X2,DGDATA Q
 S X=DGDATA K X1,X2,DGDATA Q
AO ;Agent Orange
 D SV I $D(X),$S('$D(^DPT(DFN,.321)):1,$P(^(.321),U,2)'="Y":1,1:0) W !?4,$C(7),"Exposure to Agent Orange not indicated...NO EDITING!" K X
 Q
EC ;SW Asia Contaminants - name change from Env. Contam. DG*5.3*688
 D SV I $D(X),$S('$D(^DPT(DFN,.322)):1,$P(^(.322),U,13)'="Y":1,1:0) W !?4,$C(7),"Southwest Asia Conditions not indicated...NO EDITING!" K X
 I $D(X) I X<2900802 K X W !?4,$C(7),"Date must be on or after 8/2/1990!"
 Q
COM ;Combat
 D SV I $D(X),$S('$D(^DPT(DFN,.52)):1,$P(^(.52),U,11)'="Y":1,1:0) W !?4,$C(7),"Service in Combat Zone not indicated...NO EDITING!" K X
 Q
INE ;Ineligible
 D EK I $D(X),$S('$D(^DPT(DFN,.15)):1,$P(^(.15),U,2)']"":1,1:0) W !?4,$C(7),"Requirement for 'Ineligible patient' data not indicated...NO EDITING!" K X
 Q
IR ;ION Rad
 D SV I $D(X),$S('$D(^DPT(DFN,.321)):1,$P(^(.321),U,3)'="Y":1,1:0) W !?4,$C(7),"Exposure to Ionizing Radiation is not indicated...NO EDITING!" K X
 Q
POW ;Prisoner of War
 D SV I $D(X),$S('$D(^DPT(DFN,.52)):1,$P(^(.52),U,5)'="Y":1,1:0) W !?5,$C(7),"Not identified as a former Prisoner of War...NO EDITING!" K X
 Q
SER1 ;NTL Svc
 D SV I $D(X),$S('$D(^DPT(DFN,.32)):1,$P(^(.32),U,19)'="Y":1,X="N":0,1:0) W !?4,$C(7),"Other Periods of Service are not indicated...NO EDITING!" K X
 Q
SER2 ;NNTL
 D SV I $D(X),$S('$D(^DPT(DFN,.32)):1,$P(^(.32),U,20)'="Y":1,X="N":0,1:0) W !?4,$C(7),"Third Period of Service is not indicated...NO EDITING!" K X
 Q
TAD ;Temp Add Edit
 I $S('$D(^DPT(DFN,.121)):1,$P(^(.121),U,9)'="Y":1,1:0) W !?4,$C(7),"Requirement for Temporary Address data not indicated...NO EDITING!" K X
 Q
TADD ;Temp Address Delete?
 Q:'$D(^DPT(DFN,.121))  I $P(^(.121),"^",9)="N"!($P(^(.121),"^",1,6)="^^^^^") Q
ASK W !,"Do you want to delete all temporary address data" S %=2 D YN^DICN I %Y["?" W !,"Answer 'Y'es to remove temporary address information, 'N'o to leave data in file" G ASK
 Q:%'=1  D EN^DGCLEAR(DFN,"TEMP") Q
VN ;Viet Svc
 D SV I $D(X),$S('$D(^DPT(DFN,.321)):1,$P(^(.321),U,1)'="Y":1,1:0) I "UN"'[$E(X) W !?4,$C(7),"Service in Republic of Vietnam not indicated...NO EDITING!" K X
 Q
 ;
OEIF ;OIF/ OEF/ UNKNOWN OEF/OIF Svc
 D SV
 Q
SVED ;Lebanon, Grenada, Panama, Persian Gulf & Yugoslavia svc edit
 ;      (from and to dates)
 ;DGX = piece position of corresponding service indicated? field
 ;      for multiple serv indicated dgx=sv1^sv2^...
 ;DGSV= service (sv1, sv2 from above)
 ;DGOK= 1=YES,at least one of the required sv indicated is yes,0=NO
 D SV I '$D(X) K DGX Q
 N DGSV,DGOK,DGPC,PC
 S DGOK=0
 F PC=1:1 S DGSV=$P(DGX,U,PC) Q:DGSV']""  S:$P($G(^DPT(DFN,.322)),U,DGSV)="Y" DGOK=1
 S PC=PC-1
 I DGOK=0 D
 .I "UN"'[$E(X) D
 ..W !?4,$C(7),"Service in "
 ..F DGPC=1:1:PC D
 ...S DGSV=$P(DGX,U,DGPC) W $S(DGSV=1:"Lebanon",DGSV=4:"Grenada",DGSV=7:"Panama",DGSV=10:"Persian Gulf",DGSV=16:"Somalia",DGSV=19:"Yugoslavia",1:"")
 ...W:(DGPC<PC) " or "
 ..W " not indicated...NO EDITING!" K X
 K DGX
 Q
PTDT  ;P&T Effective Date cannot be edited unless P&T is 'YES' - DG*5.3*688
 ;P&T Effective Date cannot be earlier than the DOB or after DOD - DG*5.3*754
 I $S('$D(^DPT(DFN,.3)):1,$P(^(.3),U,4)'="Y":1,1:0) D EN^DDIOL("P&T not indicated...no editing","","!?4") K X Q
 N DGFLD
 S DGFLD=$P(^DD(2,.3013,0),U)
 I $G(X)<$P(^DPT(DFN,0),U,3) D  Q
 . D DOBDOD(DGFLD,1)
 I $P($G(^DPT(DFN,.35)),U)]"" D
 . I $G(X)>$P(^DPT(DFN,.35),U) D
 . . D DOBDOD(DGFLD,2)
 Q
POWV  ;POW Status cannot be edited once it has been verified by the HEC
 ;DG*5.3*688
 I $P($G(^DPT(DFN,.52)),U,9)'="" D EN^DDIOL("POW Status verified at the HEC...NO EDITING!!","","!?4") K X
 Q
INEL ;check ineligible date - cannot be before DOB
 ;DG*5.3*754
 N DGFLD
 I $G(X)<$P(^DPT(DFN,0),U,3) D
 . S DGFLD=$P(^DD(2,.152,0),U)
 . D DOBDOD(DGFLD,1)
 Q
INCOM ;check date ruled incompetent (VA) - cannot be before DOB
 ;or after DOD - DG*5.3*754)
 N DGFLD
 S DGFLD=$P(^DD(2,.291,0),U)
 I $G(X)<$P(^DPT(DFN,0),U,3) D  Q
 . D DOBDOD(DGFLD,1)
 I $P($G(^DPT(DFN,.35)),U)]"" D
 . I $G(X)>$P(^DPT(DFN,.35),U) D
 . . D DOBDOD(DGFLD,2)
 Q
INCOM2 ;check date ruled incompetent (civil - cannot be before DOB
 ;or after DOD - DG*5.3*754)
 N DGFLD
 S DGFLD=$P(^DD(2,.292,0),U)
 I $G(X)<$P(^DPT(DFN,0),U,3) D  Q
 . D DOBDOD(DGFLD,1)
 I $P($G(^DPT(DFN,.35)),U)]"" D
 . I $G(X)>$P(^DPT(DFN,.35),U) D
 . . D DOBDOD(DGFLD,2)
 Q
DOBDOD(DGFLD,DGX) ;called from subroutines to check if 
 ;date is before DOB or after DOD.  The subroutines 
 ;are called from the field input transforms. DG*5.3*754
 I $G(DGFLD)']"" Q
 I "12"'[$G(DGX) Q
 D EN^DDIOL(DGFLD_" cannot be "_$S(DGX=1:"prior to",1:"after")_" Date of "_$S(DGX=1:"Birth.",1:"Death."),"","!?4")
 K X
 Q
DEATH ;new date constraints added with ESR 3.1 - DG*5.3*754
 Q:$G(X)'>0
 N DGFLD
 S DGFLD=$P(^DD(2,.351,0),U)
 ;check for DOD before DOB
 I X<$P(^DPT(DFN,0),U,3) D DOBDOD(DGFLD,1) Q
 ;check for DOD before P&T Effective Date
 I X<$P($G(^DPT(DFN,.3)),U,13) D  Q
 . D EN^DDIOL(DGFLD_" cannot be prior to the P&T Effective Date","","!?4")
 . K X
 ;check for DOD before Date Ruled Incompetent (VA)
 I X<$P($G(^DPT(DFN,.29)),U) D  Q
 . D EN^DDIOL(DGFLD_" cannot be prior to the Date Ruled Incompetent (VA)","","!?4")
 . K X
 ;check for DOD before Date Ruled Incompetent (Civil)
 I X<$P($G(^DPT(DFN,.29)),U,2) D  Q
 . D EN^DDIOL(DGFLD_" cannot be prior to the Date Ruled Incompetent (Civil)","","!?4")
 . K X
 ;check for DOD before Enrollment Application Date
 ;I $P($G(^DPT(DFN,"ENR")),U)>0 D
 ;. N DGENR
 ;. S DGENR=$P(^DPT(DFN,"ENR"),U)
 ;. Q:$G(DGENR)']""
 ;. Q:$P($G(^DGEN(27.11,DGENR,0)),U,2)'=DFN
 ;. I X<$P(^DGEN(27.11,DGENR,0),U) D
 ;. . D EN^DDIOL(DGFLD_" cannot be prior to the Enrollment Application Date","","!?4")
 ;. . K X
 Q
BIRTH ;checks for DOB added with DG*5.3*754
 I (($G(EASAPP)'="")&($G(DGADDF)=1)) Q  ;Ignore New 1010EZ patients
 Q:$G(X)'>0
 Q:'$D(DA)
 N DFN
 S DFN=DA
 N DGFLD
 S DGFLD=$P(^DD(2,.03,0),U)
 ;check for DOB after Ineligible Date
 I $P($G(^DPT(DFN,.15)),U,2)]"" D  Q:'$G(X)
 . I X>$P(^DPT(DFN,.15),U,2) D
 . . D EN^DDIOL(DGFLD_" cannot be after the Ineligible Date","","!?4") K X
 ;check for DOB after Enrollment Application Date
 I $P($G(^DPT(DFN,"ENR")),U)>0 D
 . N DGENR
 . S DGENR=$P(^DPT(DFN,"ENR"),U)
 . Q:$G(DGENR)']""
 . Q:$P($G(^DGEN(27.11,DGENR,0)),U,2)'=DFN
 . I X>$P(^DGEN(27.11,DGENR,0),U) D
 . . D EN^DDIOL(DGFLD_" cannot be after the Enrollment Application Date","","!?4")
 . . K X
 Q
MSE ;Military Service Episode data cannot be edited once it has been
 ;verified by the HEC
 ;DG*5.3*797
 I "NU"'[$E(X) D VET Q:'$D(X)
 I $P($G(^DPT(DFN,.3216,DA,0)),U,7)=1 D EN^DDIOL("MSE data verified at the HEC...NO EDITING!!","","!?4") K X
 Q
