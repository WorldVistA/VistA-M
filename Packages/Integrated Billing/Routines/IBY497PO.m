IBY497PO ;ALB/TAZ/KML/YG - Post install routine for patch 497 ; 10 Feb 2013  14:44 PM
 ;;2.0;INTEGRATED BILLING;**497**;21-MAR-94;Build 120
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
EN ;Post Install Routine primary entry point
 D FIXDD
 I $$INSTALDT^XPDUTL("IB*2.0*497")>0 D BMES^XPDUTL("Post-Install already performed.  No need to run again.") Q  ;DBIA#10141   ; don't perform the post installation if the patch has been installed previously 
 N IBY,Y
 F IBY="RMSG","NEWPARAM","REINDEX","RMDEFSTC","RMSSSTC","UPDATE","PROC365","PROC2" D
 . S Y=$$NEWCP^XPDUTL(IBY,IBY_"^IBY497PO")
 . I 'Y D BMES^XPDUTL("ERROR Creating "_IBY_" Checkpoint.")
 Q
 ;
FIXDD ; delete field 365.26/1.01 if it exists
 ; this doesn't do anything for normal install and only affects target account that has field 365.26/1.01 already created
 ; by test version of the build.
 N DIK,DA
 S DIK="^DD(365.26,",DA=1.01,DA(1)=365.26 D ^DIK
 Q
 ;
RMSG ; send site registration message to FSC
 D MES^XPDUTL("Sending site registration message to FSC ... ")
 I '$$PROD^XUPROD(1) D MES^XPDUTL(" N/A - not a production account") G RMSGX  ; only sent reg. message from production account
 D ^IBCNEHLM
RMSGX ;
 Q
 ;
NEWPARAM ;
 ; set new IB site parameter to control length of eIV fields
 ; set IB site parameter DAILY MAILMAN MSG to YES
 ; set IB site parameter DAILY MSG TIME to 07:00
 D MES^XPDUTL("Change values of IB site parameters")
 N DIE,DA,DR,X,Y
 S DIE=350.9,DA=1,DR="62.01///YES;51.02///YES;51.03///0700"
 D ^DIE
 Q
 ;
REINDEX ; run triggers on new eIV fields
 D MES^XPDUTL("Re-index of new eIV fields in the IIV RESPONSE, INSURANCE TYPE,")
 D MES^XPDUTL("INSURANCE BUFFER, and GROUP INSURANCE PLAN files/subfiles ")
 N DA,DIK,FLD,IEN,IEN1,IEN2
 ; file 365, top level
 S DIK="^IBCN(365,"
 F FLD=1.01,1.05,1.06,1.07 S DIK(1)=FLD_"^1" D ENALL^DIK
 ;
 S IEN=0 F  S IEN=$O(^IBCN(365,IEN)) Q:'IEN  D  ; file 365 ien
 .; sub-file 365.03
 .S DA(1)=IEN,DIK="^IBCN(365,"_IEN_",3,"
 .F FLD=.03,.05,.07 S DIK(1)=FLD_"^1" D ENALL^DIK
 .;sub-file 365.26
 .S IEN1=0 F  S IEN1=$O(^IBCN(365,IEN,2,IEN1)) Q:'IEN1  D  ; sub-file 365.02 ien
 ..; sub-file 365.26
 ..S DA(2)=IEN,DA(1)=IEN1,DIK="^IBCN(365,"_IEN_",2,"_IEN1_",6,"
 ..S DIK(1)=".03^1" D ENALL^DIK
 ..Q
 .Q
 ; sub-file 2.312
 S IEN=0 F  S IEN=$O(^DPT(IEN)) Q:'IEN  D  ; file 2 ien
 .S DA(1)=IEN,DIK="^DPT("_IEN_",.312,"
 .S DIK(1)="1^3" D ENALL^DIK
 .S DIK(1)="17^2" D ENALL^DIK
 .S IEN1=0 F  S IEN1=$O(^DPT(IEN,.312,IEN1)) Q:'IEN1  D  ; file 2.312 ien
 ..S IEN2=0 F  S IEN2=$O(^DPT(IEN,.312,IEN1,6,IEN2)) Q:'IEN2  D  ; file 2.322 ien
 ...; sub-file 2.3226
 ...S DA(3)=IEN,DA(2)=IEN1,DA(1)=IEN2,DIK="^DPT("_IEN_",.312,"_IEN1_",6,"_IEN2_",6,"
 ...S DIK(1)=".03^1" D ENALL^DIK
 ...Q
 ..Q
 .Q
 ; file 355.3
 S DIK="^IBA(355.3,"
 S DIK(1)=".03^4" D ENALL^DIK
 S DIK(1)=".04^5" D ENALL^DIK
 ; file 355.33
 S DIK="^IBA(355.33,"
 F FLD=40.02,40.03,60.04 S DIK(1)=FLD_"^2" D ENALL^DIK
 S DIK(1)="60.07^1" D ENALL^DIK
 Q
 ;
RMDEFSTC ;Remove Default Service Type Codes except for Type 30
 ;VARIABLES:
 ;D0 = Site IEN
 ;IEN30 - IEN of Service Type Code 30
 ;STC - List of Service Type Codes
 N DA,DIE,DR,STC,IEN30,FIELD
 S DA=0,DIE=350.9
 D MES^XPDUTL("Removing Default Service Type Codes except for Type 30... ")
 S IEN30=$O(^IBE(365.013,"B",30,""))
 ;
 F DA=$O(^IBE(350.9,DA)) Q:DA=""  D
 . ;Set Default Service Type Code 1 to 30
 . S FIELD=60.01,DR="60.01///30" D ^DIE
 . ;Remove all other Default Service Type Codes
 . F FIELD=60.02:.01:60.11 S STC=$$GET1^DIQ(350.9,DA,FIELD,"I") D
 .. I STC="" Q
 .. S DR=FIELD_"///@"
 .. D ^DIE
 Q
 ;
RMSSSTC ;Remove Default Service Type Codes except for Type 30
 ;VARIABLES:
 ;IEN30 - IEN of Service Type Code 30
 N DA,DIE,DR,FIELD,STC
 S DA=0,DIE=350.9
 D MES^XPDUTL("Removing Site Specific Service Type Codes... ")
 ;
 F DA=$O(^IBE(350.9,DA)) Q:DA=""  D
 . F FIELD=61.01:.01:61.09 S STC=$$GET1^DIQ(350.9,DA,FIELD,"I") D
 .. I STC="" Q
 .. S DR=FIELD_"///@"
 .. D ^DIE
 Q
 ;
UPDATE ;Call option to update Insurance Type File
 ; Schedule through TaskMan to run at night?
 N MSG
 D MES^XPDUTL("Creating Task to update the Insurance Type File... ")
 U IO(0)
UPDATE1 S MSG=$$TASK^IBCNUPD($D(ZTQUEUED)) I MSG["Aborted" D  G UPDATE1
 . S MSG="You MUST schedule this task in order to continue." D MES^XPDUTL(MSG) H 3
 U IO
 D BMES^XPDUTL(MSG)
 Q
 ; PROC365 and PROC2 subroutines will update the data stored at fields redefined in the data dictionary from a SET OF CODES to a Pointer to a File.
 ; The entries that will receive the data conversion are stored at the ELIGIBILITY/BENEFIT subfiles
 ;  of the IIV RESPONSE file (365) and the INSURANCE TYPE subfile (2.312)
 ; The fields will need to be updated with the CODE ien that is stored in the POINTED-TO-FILE.  
 ; The pointed-to-file will be one of the new X12 271 related files.
 ;
PROC365 ;Process entries in the IIV RESPONSE file (365)
 ; Tag FLDLST documents the specific fields that need to be converted
 ;
 D BMES^XPDUTL("Conversion of data at specific fields in the ELIGIBILITY/BENEFIT file (365.02)")
 D BMES^XPDUTL("started at "_$$FMTE^XLFDT($$NOW^XLFDT))
 N IENS,IEN,SIEN,CNT,RSUPDT,VALUE,FILE,FLD,SFILE,SSIEN
 S CNT=0
 ;  need to create zero node of ^XTMP global per SACC 2.3.2.5.2 for proper XTMP clean-up
 I '$D(^XTMP("IBY497PO")) S ^XTMP("IBY497PO",0)=$$FMADD^XLFDT(DT,30)_"^"_DT_"^file 365.02 and 2.322 data conversions; PROC2 and PROC365 subscripts are last ien processed"
 S IEN=+$G(^XTMP("IBY497PO","PROC365"))    ; restart ien.  in case install is RESTARTED, need to ensure that conversion begins with the next entry
 F  S IEN=$O(^IBCN(365,IEN)) Q:'IEN  D 
 . D 8(IEN,.RSUPDT)
 . S SIEN=0 F  S SIEN=$O(^IBCN(365,IEN,2,SIEN)) Q:'SIEN  D PROCFLDS(365,IEN,SIEN,0)
 . D FILE^DIE("E","RSUPDT")
 . K RSUPDT
 . S CNT=CNT+1
 . S ^XTMP("IBY497PO","PROC365")=IEN  ; record last updated entry
 . I '(CNT#10000) D BMES^XPDUTL("Status: Processed "_CNT_" records")
 D BMES^XPDUTL("Total IIV RESPONSE file PROCESSED "_CNT)
 Q
 ;
PROC2 ; process entries in the ELIGIBILITY/BENEFIT multiple of the INSURANCE TYPE subfile (2.322)
 ; Tag FLDLST documents the specific fields that need to be converted
 ;
 D BMES^XPDUTL("Conversion of data at specific fields in the ELIGIBILITY/BENEFIT file (2.322)")
 D BMES^XPDUTL("started at "_$$FMTE^XLFDT($$NOW^XLFDT))
 N CNT,IENS,DFN,IEN,SIEN,RSUPDT,FLD,FILE,VALUE,SFILE,SSIEN
 S CNT=0
 I '$D(^XTMP("IBY497PO")) S ^XTMP("IBY497PO",0)=$$FMADD^XLFDT(DT,30)_"^"_DT_"^file 365.02 and 2.322 data conversions; PROC2 and PROC365 subscripts are last ien processed"
 S DFN=+$G(^XTMP("IBY497PO","PROC2"))   ; restart ien.  in case install is RESTARTED, need to ensure that conversion begins with the next entry
 F  S DFN=$O(^DPT(DFN)) Q:'DFN  D
 . S (IEN,SIEN)=0 F  S IEN=$O(^DPT(DFN,.312,IEN)) Q:'IEN  S SIEN=+SIEN F  S SIEN=$O(^DPT(DFN,.312,IEN,6,SIEN)) Q:'SIEN  D PROCFLDS(2,IEN,SIEN,DFN)
 . D FILE^DIE("E","RSUPDT")
 . K RSUPDT
 . S CNT=CNT+1
 . S ^XTMP("IBY497PO","PROC2")=DFN ; record last updated entry
 . I '(CNT#10000) D BMES^XPDUTL("Status: Processed "_CNT_" records")
 D BMES^XPDUTL("Total INSURANCE TYPE subfile PROCESSED "_CNT)
 Q
 ;
PROCFLDS(FILE,IEN,SIEN,DFN) ; go through each of the affected flds and convert data
 ;
 ;  input
 ;    FILE - 365 or 2
 ;    IEN - internal entry number at 2.312 or 365
 ;    SIEN - internal entry number at subfile 365.02 or 2.322
 ;    DFN - ien of PATIENT file (#2)  (equals zero for 365 processing)
 ;
 ;  output
 ;    RSUPDT - FDA array that gets passed to the Fileman DBS filer API
 ;
 S IENS=$S('DFN:SIEN_","_IEN_",",1:SIEN_","_IEN_","_DFN_",")
 S FILE=$S(FILE=365:365.02,1:2.322)
 D 12(FILE,IEN,SIEN,DFN,IENS,.RSUPDT)
 D 101(FILE,IEN,SIEN,DFN,IENS,.RSUPDT)
 D 302(FILE,IEN,SIEN,DFN,IENS,.RSUPDT)
 D 408(FILE,IEN,SIEN,DFN,IENS,.RSUPDT)
 D 503(FILE,IEN,SIEN,DFN,IENS,.RSUPDT)
 D 705(FILE,IEN,SIEN,DFN,IENS,.RSUPDT)
 D 804(FILE,IEN,SIEN,DFN,IENS,.RSUPDT)
 D 904(FILE,IEN,SIEN,DFN,IENS,.RSUPDT)
 Q
 ;
8(IEN,RSUPDT) ; converts PT. RELATIONSHIP - HIPAA data at 365,8.01
 ; ^IBCN(365,D0,8)= (#8.01) PT. RELATIONSHIP - HIPAA [1P:365.037] ^
 S VALUE=$P($G(^IBCN(365,IEN,8)),U)
 I VALUE]"",+$O(^IBE(365.037,"B",VALUE,"")) S RSUPDT(365,IEN_",",8.01)=VALUE
 Q
 ;
12(FILE,IEN,SIEN,DFN,IENS,RSUPDT) ; procedure will convert AUTHORIZATION/CERTIFICATION and IN PLAN data at 365.02,.12, 365.02,.13, 2.322,.12, and 2.322,.13
 ; ^IBCN(365,D0,2,D1,0)= ^^^^^^^^^^^(#.12) AUTHORIZATION/CERTIFICATION [12P:365.033] ^ (#.13) IN PLAN [13P:365.033] ^ 
 ; ^DPT(D0,.312,D1,6,D2,0)= ^^^^^^^^^^^(#.12) AUTHORIZATION/CERTIFICATION [12P:365.033] ^ (#.13) IN PLAN [13P:365.033] ^ 
 F FLD=12,13 D
 . I FILE=365.02 S VALUE=$P($G(^IBCN(365,IEN,2,SIEN,0)),U,FLD)
 . E  S VALUE=$P($G(^DPT(DFN,.312,IEN,6,SIEN,0)),U,FLD)
 . I VALUE]"",+$O(^IBE(365.033,"B",VALUE,"")) S RSUPDT(FILE,IENS,"."_FLD)=VALUE  ;update field with ien of valid code in X12 file; otherwise leave with invalid code
 Q
 ;
101(FILE,IEN,SIEN,DFN,IENS,RSUPDT) ; procedure will convert PROCEDURE CODING METHOD data at 365.02, 1.01 and 2.322,1.01
 ; ^IBCN(365,D0,2,D1,1)= (#1.01) PROCEDURE CODING METHOD [1P:365.035] ^
 ; ^DPT(D0,.312,D1,6,D2,1)= (#1.01) PROCEDURE CODING METHOD [1P:365.035] ^
 I FILE=365.02 S VALUE=$P($G(^IBCN(365,IEN,2,SIEN,1)),U)
 E  S VALUE=$P($G(^DPT(DFN,.312,IEN,6,SIEN,1)),U)
 I VALUE]"",+$O(^IBE(365.035,"B",VALUE,"")) S RSUPDT(FILE,IENS,1.01)=VALUE  ;update field with ien of valid code in X12 file; otherwise leave with invalid code
 Q
 ;
302(FILE,IEN,SIEN,DFN,IENS,RSUPDT) ; procedure will convert ENTITY TYPE data at 365.02,3.02 and 2.322,3.02
 ; ^IBCN(365,D0,2,D1,3)=  ^ (#3.02) ENTITY TYPE [2P:365.043]
 ; ^DPT(D0,.312,D1,6,D2,3)=  ^ (#3.02) ENTITY TYPE [2P:365.043]
 I FILE=365.02 S VALUE=$P($G(^IBCN(365,IEN,2,SIEN,3)),U,2)
 E  S VALUE=$P($G(^DPT(DFN,.312,IEN,6,SIEN,3)),U,2)
 I VALUE]"",+$O(^IBE(365.043,"B",VALUE,"")) S RSUPDT(FILE,IENS,3.02)=VALUE  ;update field with ien of valid code in X12 file; otherwise leave with invalid code
 Q
 ;
408(FILE,IEN,SIEN,DFN,IENS,RSUPDT) ; procedure will convert LOCATION QUALIFIER data at 365.02,4.08 and 2.322,4.08
 ; ^IBCN(365,D0,2,D1,4)= ^^^^^^^(#4.08) LOCATION QUALIFIER [8P:365.034] 
 ; ^DPT(D0,.312,D1,6,D2,4)= ^^^^^^^(#4.08) LOCATION QUALIFIER  [8P:365.034]
 I FILE=365.02 S VALUE=$P($G(^IBCN(365,IEN,2,SIEN,4)),U,8)
 E  S VALUE=$P($G(^DPT(DFN,.312,IEN,6,SIEN,4)),U,8)
 I VALUE]"",+$O(^IBE(365.034,"B",VALUE,"")) S RSUPDT(FILE,IENS,4.08)=VALUE  ;update field with ien of valid code in X12 file; otherwise leave with invalid code
 Q
 ;
503(FILE,IEN,SIEN,DFN,IENS,RSUPDT) ; procedure will convert REFERENCE ID QUALIFIER data at 365.02,5.03 and 2.322,5.03
 ; ^IBCN(365,D0,2,D1,5)= ^^ (#5.03) REFERENCE ID QUALIFIER [3P:365.028] 
 ; ^DPT(D0,.312,D1,6,D2,5)= ^^ (#5.03) REFERENCE ID QUALIFIER [3P:365.028] 
 I FILE=365.02 S VALUE=$P($G(^IBCN(365,IEN,2,SIEN,5)),U,3)
 E  S VALUE=$P($G(^DPT(DFN,.312,IEN,6,SIEN,5)),U,3)
 I VALUE]"",+$O(^IBE(365.028,"B",VALUE,"")) S RSUPDT(FILE,IENS,5.03)=VALUE  ;update field with ien of valid code in X12 file; otherwise leave with invalid code
 Q
 ;
705(FILE,IEN,SIEN,DFN,IENS,RSUPDT) ; procedure will convert UNITS OF MEASUREMENT and DELIVERY PATTERN data at 365.27,.05 and .09, 2.3227,.05, and .09
 ; ^IBCN(365,D0,2,D1,7,D2,0)= ^^^^(#.05) UNITS OF MEASUREMENT [5P:365.029]^^^^ (#.09) DELIVERY PATTERN [9P:365.036] ^ 
 ; ^DPT(D0,.312,D1,6,D2,7,D3,0)= ^^^^(#.05) UNITS OF MEASUREMENT [5P:365.029]^^^^ (#.09) DELIVERY PATTERN [9P:365.036] ^ 
 I FILE=365.02 S SFILE=365.27,SSIEN=0 F  S SSIEN=$O(^IBCN(365,IEN,2,SIEN,7,SSIEN)) Q:'SSIEN  F FLD=5,9 S VALUE=$P($G(^IBCN(365,IEN,2,SIEN,7,SSIEN,0)),U,FLD) D MORE705
 I FILE=2.322 S SFILE=2.3227,SSIEN=0 F  S SSIEN=$O(^DPT(DFN,.312,IEN,6,SIEN,7,SSIEN)) Q:'SSIEN  F FLD=5,9 S VALUE=$P($G(^DPT(DFN,.312,IEN,6,SIEN,7,SSIEN,0)),U,FLD) D MORE705
 Q
 ;
MORE705 ;
 I VALUE]"",+$O(^IBE($S(FLD=5:365.029,1:365.036),"B",VALUE,"")) S RSUPDT(SFILE,SSIEN_","_IENS,".0"_FLD)=VALUE  ;update field with ien of valid code in X12 file; otherwise leave with invalid code
 Q
 ;
804(FILE,IEN,SIEN,DFN,IENS,RSUPDT) ; procedure will convert DATE FORMAT data at 365.28,.04 and 2.3228,.04
 ; ^IBCN(365,D0,2,D1,8,D2,0)= ^^^ (#.04) DATE FORMAT [4P:365.032]
 ; ^DPT(D0,.312,D1,6,D2,8,D3,0)= ^^^ (#.04) DATE FORMAT [4P:365.032]
 I FILE=365.02 S SFILE=365.28,SSIEN=0 F  S SSIEN=$O(^IBCN(365,IEN,2,SIEN,8,SSIEN)) Q:'SSIEN  S VALUE=$P($G(^IBCN(365,IEN,2,SIEN,8,SSIEN,0)),U,4) D MORE804
 I FILE=2.322 S SFILE=2.3228,SSIEN=0 F  S SSIEN=$O(^DPT(DFN,.312,IEN,6,SIEN,8,SSIEN)) Q:'SSIEN  S VALUE=$P($G(^DPT(DFN,.312,IEN,6,SIEN,8,SSIEN,0)),U,4) D MORE804
 Q
 ;
MORE804 ;
 I VALUE]"",+$O(^IBE(365.032,"B",VALUE,"")) S RSUPDT(SFILE,SSIEN_","_IENS,.04)=VALUE  ;update field with ien of valid code in X12 file; otherwise leave with invalid code
 Q
 ;
904(FILE,IEN,SIEN,DFN,IENS,RSUPDT) ; procedure will convert QUALIFIER data at 365.29,.04 and 2.3229,.04
 ; ^IBCN(365,D0,2,D1,9,D2,0)= ^^^(#.04) QUALIFIER [4P:365.044]
 ; ^DPT(D0,.312,D1,6,D2,9,D3,0)= ^^^(#.04) QUALIFIER [4P:365.044]
 I FILE=365.02 S SFILE=365.29,SSIEN=0 F  S SSIEN=$O(^IBCN(365,IEN,2,SIEN,9,SSIEN)) Q:'SSIEN  S VALUE=$P($G(^IBCN(365,IEN,2,SIEN,9,SSIEN,0)),U,4) D MORE904
 I FILE=2.322 S SFILE=2.3229,SSIEN=0 F  S SSIEN=$O(^DPT(DFN,.312,IEN,6,SIEN,9,SSIEN)) Q:'SSIEN  S VALUE=$P($G(^DPT(DFN,.312,IEN,6,SIEN,9,SSIEN,0)),U,4) D MORE904
 Q
 ;
MORE904 ;
 I VALUE]"",+$O(^IBE(365.044,"B",VALUE,"")) S RSUPDT(SFILE,SSIEN_","_IENS,.04)=VALUE  ;update field with ien of valid code in X12 file; otherwise leave with invalid code
 Q
 ;
FLDLST ; these are the DD fields that were modified from a set of codes to a Pointer to a file
 ;;file#^field#^field label^pointed-to file#
 ;;365^8.01^PT. RELATIONSHIP - HIPAA^365.037
 ;;365.02^.12^AUTHORIZATION/CERTIFICATION^365.033
 ;;365.02^.13^IN PLAN^365.033
 ;;365.02^1.01^PROCEDURE CODING METHOD^365.035
 ;;365.02^3.02^ENTITY TYPE^365.043
 ;;365.02^4.08^LOCATION QUALIFIER^365.034
 ;;365.02^5.03^REFERENCE ID QUALIFIER^365.028
 ;;365.27^.05^UNITS OF MEASUREMENT^365.029
 ;;365.27^.09^DELIVERY PATTERN^365.036
 ;;365.28^.04^DATE FORMAT^365.032
 ;;365.29^.04^QUALIFIER^365.044
 ;;2.322^.12^AUTHORIZATION/CERTIFICATION^365.033
 ;;2.322^.13^IN PLAN^365.033
 ;;2.322^1.01^PROCEDURE CODING METHOD^365.035
 ;;2.322^3.02^ENTITY TYPE^365.043
 ;;2.322^4.08^LOCATION QUALIFIER^365.034
 ;;2.322^5.03^REFERENCE ID QUALIFIER^365.028
 ;;2.3227^.05^UNITS OF MEASUREMENT^365.029
 ;;2.3227^.09^DELIVERY PATTERN^365.036
 ;;2.3228^.04^DATE FORMAT^365.032
 ;;2.3229^.04^QUALIFIER^365.044
 ;;
 Q
 ;
