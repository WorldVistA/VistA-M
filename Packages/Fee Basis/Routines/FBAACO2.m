FBAACO2 ;AISC/GRR - PAYMENT PROCESS FOR DUPLICATE ;12/19/2014
 ;;3.5;FEE BASIS;**4,55,61,77,116,122,133,108,135,139,123,157**;JAN 30, 1995;Build 1
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;FB*3.5*157 Modify file 162, Diagnosis (field 28) stuff from '///' to '////'
 ;           since needed file 80 dx IEN is already passed back from DX 
 ;           lookup.
 ;
RD S DIR(0)="Y",DIR("A")="Want this payment stored as a Medical Denial",DIR("B")="YES",DIR("?")="Enter 'Yes' to store payment entry as a denial and send a Suspension letter.  Enter 'No' to have nothing happen." D ^DIR K DIR Q:$D(DIRUT)!('Y)
 S FBDEN=1 Q
FILE ;files sp multiple entry
 K DR S TP="" I $G(FBDEN) S FBAMTPD=0
 ; FB*3.5*123 - set IPAC fields .05 and .055 on the next line
 S DR="49///^S X=$G(FBCSID);50///^S X=$G(FBFPPSC);81///^S X=$G(FBUCI135);.05////^S X=$G(FBIA);.055///^S X=$G(FBDODINV);I $G(FBDEN) S Y=1;48;47//1;S FBUNITS=X;S:$G(FBFPPSC)="""" Y=""@11"";S FBX=$$FPPSL^FBUTL5();S:FBX=-1 Y=0;51///^S X=FBX;@11"
 ; fb*3.5*116 do not enable different interest indicator values at line item level; interest indicator set at invoice level
 S DR(1,162.03,1)="34///^S X=$G(FBAAMM);D POS^FBAACO1;S:'$G(FBHCFA(30)) Y=0;1;S J=X;I $G(FBDEN) S Y=2;D FEE^FBAACO0;44////^S X=FBFSAMT;45///^S X=FBFSUSD;2///^S X=FBAMTPD;S K=X"
 S DR(1,162.03,2)="S FBX=$$ADJ^FBUTL2(J-K,.FBADJ,2);S:FBX=0 Y=0;6////^S X=DUZ"
 S DR(1,162.03,3)="7////^S X=FBAABE;8////^S X=BO;13///^S X=FBAAID;14///^S X=FBAAIN;33///^S X=FBAAVID;I $G(FBDEN) S FBTST=1"
 I '$G(FBDEN) D
 . ; FB*3.5*139-JLG/JAS-ICD10 REMEDIATION - Made modifications to DR strings for ICD-10, added FBDXCHK1 and FBDXCHK2 for this
 .N FBCSVSTR S FBCSVSTR="I X]"""" S:$$INPICD9^FBCSV1(X,"""",$G(FBAADT)) Y=""@30"";"
 .N FBDXCHK1 S FBDXCHK1=";@20;S XX1=-1 S XX1=$$FBDXCHK^FBAACO2(FBAADT) S:XX1<0 Y=""@20"";28////^S X=XX1;S Y=""@6"";"   ;FB*3.5*157
 .N FBDXCHK2 S FBDXCHK2=";@25;S XX1=-1 S XX1=$$FBDXCHK^FBAACO2(FBAADT) S:XX1<0 Y=""@25"";28////^S X=XX1;S Y=""@35"";@30;"    ;FB*3.5*157
 .S DR(1,162.03,4)="S:$$EXTPV^FBAAUTL5(FBPOV)=""01"" Y=""@1"";S:FB7078]""""!($D(FB583)) Y=30"_FBDXCHK1_"@6;30////^S X=FBHCFA(30);"
 .S DR(1,162.03,5)="31;32R;S Y=15;@1"_FBDXCHK2_FBCSVSTR_"@35;30////^S X=FBHCFA(30);31;15///^S X=FBPT;S FBX=$$RR^FBUTL4(.FBRRMK,2);S:FBX=0 Y=0"
 . ;end 139
 .S DR(1,162.03,6)="16////^S X=FBPOV;17///^S X=FBTT;18///^S X=FBAAPTC;23////^S X=FBTYPE;26////^S X=FBPSA;S:$D(FBV583) Y=""@2"";27////^S X=FB7078;S Y=""@99"";@2;27////^S X=FBV583;@99;S FBTST=1;54////^S X=FBCNTRP"
 .S DR(1,162.03,7)="73;74;75;58;59;60;61;62;63;64;65;66;67;76;77;78;79;68;69" ;FB*3.5*122 Line Item Provider information ;FB*3.5*133 Provider Information
 S DIE="^FBAAC("_DFN_",1,"_FBV_",1,"_FBSDI_",1,"
 S DA(3)=DFN,DA(2)=FBV,DA(1)=FBSDI,DA=FBAACPI
 D LOCK^FBUCUTL("^FBAAC("_DFN_",1,"_FBV_",1,"_FBSDI_",1,",FBAACPI,1)
 D
 . N ICDVDT S ICDVDT=$G(FBAADT) D ^DIE
 I '$D(DTOUT),$G(FBTST) D
 . D FILEADJ^FBAAFA(FBAACPI_","_FBSDI_","_FBV_","_DFN_",",.FBADJ)
 . D FILERR^FBAAFR(FBAACPI_","_FBSDI_","_FBV_","_DFN_",",.FBRRMK)
 L -^FBAAC(DFN,1,FBV,1,FBSDI,1,FBAACPI)
 I $D(DTOUT) D KILL Q
 I '$G(FBTST),$G(DA) S DIR(0)="YA",DIR("A")="Entering an '^' will delete "_$S($G(FBDEN):"denial",1:"payment")_".  Are you sure you want to delete? ",DIR("B")="No" D ^DIR K DIR G FILE:'$D(DIRUT)&('Y) D KILL Q
 K FBTST,FBDEN,DIE,DR,DA,FBX
 I $D(FBDL) S FBAAOUT=1 Q
 Q
 ;
FBDXCHK(FBAADT) ;DEM;139 Call to ASF if ICD-10.
 ;
 ; This call checks if the payment diagnosis date to
 ; determine if diagnosis code is ICD-9 or ICD-10.
 ; If ICD-9, then call ICD-9 code enhanced for inactive code checks.
 ; Else, call Advanced Search Functionality (ASF).
 ; If user enters "^" to exit, then quit and send calling
 ; routine 999 for exit.
 ;
 ; If no ICD-10 data found, then send calling routine -1 
 ; to indicate no data found.
 ; If data found, then stuff diagnosis into ICD DIAGNOSIS
 ; field, and quit and send the calling routine 10 for ICD-10 code.
 ;
 ; Input:
 ; FBAADT = Date of Interest for FB payments.
 ;
 ; Output:
 ; FB9 = ICD-9 diagnosis
 ; FB99 = User entered "^" to exit payment edit.
 ; -1 = No ICD-10 data found
 ; FB10 = ICD-10 diagnosis 
 ;
 N ICDSYS,IMPDATE,XX1
 S ICDSYS=10,IMPDATE=$$IMPDATE^LEXU("10D")
 S:FBAADT<IMPDATE ICDSYS=9
 S XX1=-1
 I ICDSYS=9 S XX1=$$ASKICD9^FBAACO2(FBAADT) Q XX1  ;ICD-9
 S XX1=$$ASKICD10^FBAACO2(FBAADT) Q XX1  ;ICD-10 IEN CODE
 ;
 ; retrieves existing value in db if exists and prompts user for ICD-9 primary diagnosis 
ASKICD9(INDT,FBFREQ) ;FB*3.5*139-JAS-ICD10 REMEDIATION
 N DPRMPT,FBDX
 S EDATE=INDT  ; edate is the date of interest for ICD10 diagnosis code lookup
 I $G(FBFREQ)="" S FBFREQ="N"  ; force field to be required flag
 N FBDXIEN
 S DPRMPT="PRIMARY DIAGNOSIS"
 S FBDXIEN=$P($G(^FBAAC(DFN,1,FBV,1,FBSDI,1,FBAACPI,0)),U,23) ; retrieve existing DX ien 
 ;S:FBDXIEN>0 DPRMPT=DPRMPT_": "_$$ICD9^FBCSV1(FBDXIEN,EDATE)_"// "  ;obtain current diagnosis and set as default
 S FBDX=-1 S FBDX=$$ENICD9^FBICD9(EDATE,DPRMPT,"Y","","Y",FBDXIEN)
 I FBDXIEN>0,FBDX=-1 S FBDX=FBDXIEN W $$ICD9^FBCSV1(FBDXIEN,EDATE) ; return default value if spaces entered
 K EDATE,INDT
 S FBDX=+FBDX
 Q FBDX
 ;
 ; retrieves existing value in db if exists and prompts user for ICD-10 primary diagnosis 
ASKICD10(INDT,FBFREQ) ;FB*3.5*139-JLG-ICD10 REMEDIATION
 N DP,DPRMPT,FBDCDA,FBDX
 S EDATE=INDT  ; edate is the date of interest for ICD10 diagnosis code lookup
 I $G(FBFREQ)="" S FBFREQ="N"  ; force field to be required flag
 S DP=162.03   ; file number used to check if diagnosis field is required
 S FBDCDA=DA   ; DA equals FBAACPI
 N FBDXIEN
 S DPRMPT="PRIMARY DIAGNOSIS"
 S FBDXIEN=$P($G(^FBAAC(DFN,1,FBV,1,FBSDI,1,FBAACPI,0)),U,23) ; retrieve existing DX ien 
 S:FBDXIEN>0 DPRMPT=DPRMPT_": "_$$ICD9^FBCSV1(FBDXIEN,EDATE)_"// "  ;obtain current diagnosis and set as default
 S FBDX=-1 S FBDX=$$ASKICD10^FBASF(DPRMPT,"","","",FBFREQ) ; returns -1 or ien of icd10 diagnosis code
 I FBDXIEN>0,FBDX=-1 S FBDX=FBDXIEN W $$ICD9^FBCSV1(FBDXIEN,EDATE) ; return default value if spaces entered
 K EDATE,INDT
 Q FBDX
 ;
KILL S DIK=DIE D ^DIK K DIE,DIK I '$G(FBCNP) D Q^FBAACO S FBAAOUT=1
 W !,"Deleted" Q
