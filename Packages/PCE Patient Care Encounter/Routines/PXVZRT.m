PXVZRT ;SLC/PBB - VIMM UTILITY ROUTINE ;01/15/2015  4:44 PM
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**206,215**;Aug 12, 1996;Build 10
 ;
 Q
ZRT ;Manipulate update of MFN ZRT segment for Immunization files
 I IEN,((NAME="Term")!(NAME="Status")) K XXIEN ;This is the indication that it's first update for any subfile
 S:$D(HLNODE(1)) HLNODE=HLNODE_HLNODE(1)
 G 920:IFN=920,99999914:IFN=9999999.14,99999928:IFN=9999999.28,9204:IFN=920.4,99999904:IFN=9999999.04,9201:IFN=920.1
 Q
920 ; Manipulate update of MFN ZRT segment for 920 File
 I IEN,NAME="Term" D  Q
 .N Y,X1
 .S X1=$$UNESC^XUMF0($P(HLNODE,HLFS,3),.HL)
 .;Get Name, Date and Language from Term
 .F I=1:1 S Y=$P(X1," ",I) Q:Y?1N.N1"/"1N.N1"/"1N.N  I '$L(Y),'$L($P(X1," ",I+1,99)) Q
 .I Y="" S ERROR="1^Error - .01 is invalid"_" File #: "_IFN_" HLNODE="_HLNODE Q
 .S X1=$P(X1,Y)
 .S Y=$L(X1) F I=Y:-1 Q:$E(X1,I)'=" "  S X1=$E(X1,1,Y-1) ;Get rid of spaces on end of .01
 .S $P(HLNODE,HLFS,3)=X1
 I IEN,NAME="VistA_VIS_Language" D  Q
 .N DIC,X,IENS
 .S NAME=$$UNESC^XUMF0($P(HLNODE,HLFS,3),.HL)
 .S DIC=.85,DIC(0)="M",X=NAME D ^DIC I Y<0 S ERROR="1^Error - .04 LANGUAGE is invalid"_" File #: "_IFN_" HLNODE="_HLNODE Q
 .S IENS=IEN_","
 .S FDA(IFN,IENS,.04)=+Y
 .S OUT=1
 .Q
 I 'IEN,NAME="Term" D  Q
 .;Assuming that the " " delimiter is used in Term
 .;Assuming MFS Update will be in the form: 
 .; ZRT^Term^ANTHRAX VIS 3/10/2010 ENGLISH
 .; ZRT^VistA_VIS_Edition_Date^3/10/2010     in form:mm/dd/yy
 .; ZRT^VistA_VIS_Language^ENGLISH
 .N DIC,X,X1,X2,X3,Y,XREF,ROOT,FDA,ERR,IENS,IIEN,%DT,I
 .S NAME=$$UNESC^XUMF0($P(HLNODE,HLFS,3),.HL)
 .S ROOT=$$ROOT^DILFD(IFN,,1)
 .;Get Name, Date and Language from Term
 .F I=1:1 S Y=$P(NAME," ",I) Q:Y?1N.N1"/"1N.N1"/"1N.N  I '$L(Y),'$L($P(NAME," ",I+1,99)) Q
 .I Y="" S ERROR="1^Error - .01 is invalid"_" File #: "_IFN_" HLNODE="_HLNODE Q
 .S X1=$P(NAME,Y),X2=Y,X3=$P(NAME,Y,2)
 .F I=1:1 Q:$E(X3,I)'=" "  S X3=$E(X3,I+1,$L(X3)) ;Get rid of leading spaces from Language.
 .S Y=$L(X1) F I=Y:-1 Q:$E(X1,I)'=" "  S X1=$E(X1,1,Y-1) ;Get rid of spaces on end of .01
 .;Get Date from Term
 .;put it into form: 3140819
 .S X=X2 D ^%DT
 .I Y=-1 S ERROR="1^Error - .02 in Term is invalid"_" File #: "_IFN_" HLNODE="_HLNODE Q
 .S X2=Y
 .;
 .S DIC=.85,DIC(0)="M",X=X3 D ^DIC I Y<0 S ERROR="1^Error - .04 LANGUAGE is invalid"_" File #: "_IFN_" HLNODE="_HLNODE Q
 .S X3=+Y
 .;Lookup B x-ref and see if match of date and Language.
 .S IIEN=0
 .F  Q:ERROR  S IIEN=$O(@ROOT@("B",X1,IIEN)) Q:'IIEN  S IENS=IIEN_"," I $$GET1^DIQ(920,IENS,.02,"I")=X2,$$GET1^DIQ(920,IENS,.04,"I")=X3 D:IEN  S IEN=IIEN
 ..;Here the error generated if more as one entry match ,01  and .02 and .04
 ..S ERROR="1^Error - File IENs duplicate: "_IEN_" and "_IIEN_" File #: "_IFN_" HLNODE="_HLNODE Q
 .Q:ERROR
 .;
 .I IEN D
 ..M RECORD("BEFORE")=@ROOT@(IEN)
 ..S RECORD("STATUS")=$$GETSTAT^XTID(IFN,,IEN_",")
 .I 'IEN D  Q:ERROR
 ..D CHK^DIE(IFN,.01,,X1,.X)
 ..I X="^" S ERROR="1^Error - .01 is invalid"_" File #: "_IFN_" HLNODE="_HLNODE Q
 ..K DIC S DIC=IFN,DIC(0)="F" D FILE^DICN K DIC
 ..I Y="-1" S ERROR="1^Error - stub entry IFN: "_IFN_" failed HLNODE: "_HLNODE Q
 ..S IEN=+Y,RECORD("NEW")=1
 .;
 .S:'$G(RECORD("NEW")) ^TMP("XUMF EVENT",$J,IFN,"BEFORE",IEN,"REPLACED BY")=""
 .S:'$G(RECORD("NEW")) ^TMP("XUMF EVENT",$J,IFN,"BEFORE",IEN,"INHERITS FROM")=""
 .;
 .S IENS=IEN_","
 .;
 .S FDA(IFN,IENS,99.99)=VUID
 .S FDA(IFN,IENS,99.98)=1
 .;
 .K ERR
 .;
 .D FILE^DIE("E","FDA","ERR")
 .I $D(ERR) D
 ..S ERROR="1^VUID update error IFN: "_IFN_" IEN: "_IEN_" VUID: "_VUID_" HLNODE: "_HLNODE
 ..D EM^XUMF1H(ERROR,.ERR) K ERR
 .;
 .;Execute Additional coding for  4.001,3  ADD-PROCESSING LOGIC
 .D ADD^XUMF1H
 .;
 .; clean multiple flag
 .K:'$D(XIEN(IEN)) XIEN
 .S XIEN(IEN)=$G(XIEN(IEN))+1
 .S OUT=1
 Q
99999914 ; Manipulate update of MFN ZRT segment for 9999999.14 File
 N X,XX,ERR,IENS,IEN1,IENX,X1,X2,X3,X4,X5,X6,DA,DIK,I,FDAA,II,TMP
 I IEN,NAME="VistA_CVX_Mapping" D  Q  ;ZRT^VistA_CVX_Mapping^CPT:90701,90743
 .S X=$P(HLNODE,HLFS,3) ;X=CPT:90701,90743
 .I '$L(X)!(X="""""") D DS(9999999.143,IEN) S OUT=1 Q  ;Q:$G(OUT)  ;If there is nothing coming from Push, wipe anything was there before
 .I '$G(XXIEN(9999999.143)) D DS(9999999.143,IEN)  S XXIEN(9999999.143)=1 ;CLEAN SUBFILE ENTRY
 .S X1=$P(X,":"),X2=$P(X,":",2)
 .D DUP(9999999.143,X1,X2) ; Checup for duplicate coding system (ICD, 10D, CPT...) and codes
 .Q:$G(ERROR)
 .S IENS=IEN_","
 .S IEN1="+1,",FDAA(9999999.143,"+1,"_IENS,.01)=X1
 .F I=2:1 S X4=$P(X2,",",I-1) Q:'$L(X4)  S IENX="+"_I_","_IEN1_IENS,FDAA(9999999.1431,IENX,.01)=X4
 .D:$D(FDAA) UPDATE^DIE("","FDAA",,"ERR")
 .I $D(ERR) D  Q
 ..S ERROR="1^subfile update error SUBFILE#: 9999999.1431 HLNODE:"_HLNODE
 ..D EM^XUMF1H(ERROR,.ERR)
 .Q:$G(ERROR)
 .S OUT=1
 I IEN,NAME="VistA_CDC_Product_Name" D  Q
 .I $P(HLNODE,HLFS,3)="""""" D DS(9999999.145,IEN) S OUT=1 Q
 .I '$G(XXIEN(9999999.145)) D DS(9999999.145,IEN)  S XXIEN(9999999.145)=1 ;CLEAN SUBFILE ENTRY
 I IEN,NAME="VistA_Synonym" D  Q
 .I $P(HLNODE,HLFS,3)="""""" D DS(9999999.141,IEN) S OUT=1 Q
 .I '$G(XXIEN(9999999.141)) D DS(9999999.141,IEN)  S XXIEN(9999999.141)=1 ;CLEAN SUBFILE ENTRY
 I IEN,NAME="VistA_Inactive_Flag" D  Q
 .S:$P(HLNODE,HLFS,3)'=1 $P(HLNODE,HLFS,3)=""""""
 I IEN,NAME="vista_has_vis" D  Q
 .I $P(HLNODE,HLFS,3)="""""" D DS(9999999.144,IEN) S OUT=1 Q
 .I '$G(XXIEN(9999999.144)) D DS(9999999.144,IEN)  S XXIEN(9999999.144)=1 ;CLEAN SUBFILE ENTRY
 I IEN,NAME="VistA_Immunization_Group" D  Q
 .I $P(HLNODE,HLFS,3)="""""" D DS(9999999.147,IEN) S OUT=1 Q
 .I '$G(XXIEN(9999999.147)) D DS(9999999.147,IEN)  S XXIEN(9999999.147)=1 ;CLEAN SUBFILE ENTRY
 I IEN,NAME="Status" D IFST(.07,"",1) Q
 Q
99999928  ; Manipulate update of MFN ZRT segment for 9999999.28 File
 N X,ERR,IENS,IEN1,IENX,X1,X2,X4,DA,DIK,I,FDAA
 I IEN,NAME="VistA_Skin_Test_Mapping" D  Q
 .;ZRT^VistA_Skin_Test_Mapping^CPT:90701,90743
 .S X=$P(HLNODE,HLFS,3) ;X=CPT:90701,90743
 .I '$L(X)!(X="""""") D DS(9999999.283,IEN) S OUT=1 Q  ;Q:$G(OUT)  ;If there is nothing coming from Push, wipe anything was there before
 .I '$G(XXIEN(9999999.283)) D DS(9999999.283,IEN)  S XXIEN(9999999.283)=1 ;CLEAN SUBFILE ENTRY
 .S X1=$P(X,":"),X2=$P(X,":",2) ;$$FIND1^DIC(FILE,IENS,FLAGS,[.]VALUE,[.]INDEXES,[.]SCREEN,MSG_ROOT)
 .D DUP(9999999.283,X1,X2) ; Checkup for duplicate coding system (ICD, 10D, CPT...) and codes
 .Q:$G(ERROR)
 .S IENS=IEN_","
 .S IEN1="+1,",FDAA(9999999.283,"+1,"_IENS,.01)=X1
 .F I=2:1 S X4=$P(X2,",",I-1) Q:'$L(X4)  S IENX="+"_I_","_IEN1_IENS,FDAA(9999999.2831,IENX,.01)=X4
 .D:$D(FDAA) UPDATE^DIE("","FDAA",,"ERR")
 .I $D(ERR) D  Q
 ..S ERROR="1^subfile update error SUBFILE#: 9999999.2831 HLNODE:"_HLNODE
 ..D EM^XUMF1H(ERROR,.ERR)
 .Q:$G(ERROR)
 .S OUT=1
 I IEN,NAME="VistA_Inactive_Flag" D  Q
 .S:$P(HLNODE,HLFS,3)'=1 $P(HLNODE,HLFS,3)=""""""
 I IEN,NAME="VistA_CPT_Code" D  Q
 .S OUT=1
 I IEN,NAME="Status" D IFST(.03,"",1) Q
 Q
9204 ; Manipulate update of MFN ZRT segment for 920.4 File
 I IEN,NAME="vista_applies_to" D  Q
 .I $P(HLNODE,HLFS,3)="""""" D DS(920.43,IEN) S OUT=1 Q
 .I '$G(XXIEN(920.43)) D DS(920.43,IEN)  S XXIEN(920.43)=1 ;CLEAN SUBFILE ENTRY
 I IEN,NAME="Status" D IFST(.03,0,1) Q
 Q
9201 ; Manipulate update of MFN ZRT Segment for 920.01 File
 I IEN,NAME="Status" D IFST(.03,0,1) Q
 Q
99999904 ; Manipulate update of MFN ZRT Segment for 9999999.04 File
 I IEN,NAME="Status" D IFST(.03,0,1) Q
 Q
M92002 ;Conversion of File:920 field .02  EDITION DATE to VETS form  02/31/2014
 N Y,X ;Date in internal form:  3140231
 ;set Y to HL7 Form:  20140231 and subsequently to: >> 2/31/2014 << 
 S Y=$$FMTHL7^XLFDT(TMP1(LEV,X2,IENS,I)),TMP1(LEV,X2,IENS,I)=" "_+$E(Y,5,6)_"/"_+$E(Y,7,8)_"/"_$E(Y,1,4)_" "
 ;Note that space put at begining and end to get form: >>ADENOVIRUS VIS 6/11/2014 ENGLISH<< 
 Q
M92004 ;Conversion of File:920 field .04  POINTER TO LANGUAGE FILE (#.85)
 S TMP1(LEV,X2,IENS,I)=$$GET1^DIQ(.85,TMP1(LEV,X2,IENS,I)_",",1)
 Q
M92003 ;Conversion of File:920 field .03 EDITION STATUS
 ;Get:   7/26/2013HISTORICENGLISH
 ;Get .02 _ .03 _ .04   get rid of space on start and end.
 N X,Y,XX,DIC
 S XX=$$GET1^DIQ(.85,TMP1(LEV,X2,IENS,.04)_",",1)
 S TMP1(LEV,X2,IENS,I)=$E(TMP1(LEV,X2,IENS,.02),2,$L(TMP1(LEV,X2,IENS,.02))-1)_TMP1(LEV,X2,IENS,I)_XX
 Q
M999142 ;Conversion of File:9999999.14 FIELD:.2  COMBINATION IMMUNIZATION COMVERT FROM 1 to Y  and from 0 to N
 N X
 S X=TMP1(LEV,X2,IENS,I),TMP1(LEV,X2,IENS,I)=$S(X:"Y",1:"N")
 Q
M9992803 ;Conversion of File:9999999.28 FIELD:.03  INACTIVE FLAG
 S:TMP1(LEV,X2,IENS,I)'=1 TMP1(LEV,X2,IENS,I)=0
 Q
M999283 ;Conversion of File:9999999.28 FIELD: 3  CODING SYSTEM  From: CPT to CPT:00001,00002
 ;TMP1(2,"9999999.283","1,7,",".01")="CPT"    D GETS^DIQ(X2,IENS,"*","","TMP1(LEV)")
 N TMP,X4,X3,II
 S X4=TMP1(LEV,X2,IENS,I)_":" ;X4=CPT:
 D GETS^DIQ(9999999.283,IENS,"**","","TMP") ;TMP(9999999.2831,"1,1,7,",.01)=86485
 S II="" F  S II=$O(TMP(9999999.2831,II)) Q:'II  S X3=$G(TMP(9999999.2831,II,.01)) S:$L(X3) X4=X4_X3_","
 S:$L(X3) X4=$E(X4,1,$L(X4)-1) S TMP1(LEV,X2,IENS,I)=X4
 Q
M999143 ;Conversion of File:9999999.14 FIELD: 3  CODING SYSTEM  From: CPT to CPT:00001,00002
 ;TMP1(2,"9999999.143","1,7,",".01")="CPT"    D GETS^DIQ(X2,IENS,"*","","TMP1(LEV)")
 N TMP,X4,X3,II
 S X4=TMP1(LEV,X2,IENS,I)_":" ;X4=CPT:
 D GETS^DIQ(9999999.143,IENS,"**","","TMP") ;TMP(9999999.1431,"1,1,7,",.01)=86485
 S II="" F  S II=$O(TMP(9999999.1431,II)) Q:'II  S X3=$G(TMP(9999999.1431,II,.01)) S:$L(X3) X4=X4_X3_","
 ;S X4=$S($L(X3):$E(X4,1,$L(X4)-1),1:"") S TMP1(LEV,X2,IENS,I)=X4
 S:$L(X3) X4=$E(X4,1,$L(X4)-1) S TMP1(LEV,X2,IENS,I)=X4
 Q
DS(SUBFILE,IENS) ;Delete subfile
 N ROOT,IDX,X
 S ROOT=$$ROOT^DILFD(SUBFILE,","_IENS,1)
 S IDX=0 F  S IDX=$O(@ROOT@(IDX)) Q:'IDX  D
 .N DA,DIK,DIC S DA(1)=+IENS,DA=IDX,DIK=$P(ROOT,")")_"," D ^DIK
 Q
IFST(FIELD,YES,NO) ;Send AE if Inactive flag doesn't match VUID Status.
 Q:'$D(FDA(IFN,IEN_",",FIELD))
 N X1 S X1=$P(HLNODE,HLFS,3)
 Q:X1=1&(FDA(IFN,IEN_",",FIELD)=YES)  ;Match, both active
 Q:X1=0&(FDA(IFN,IEN_",",FIELD)=NO)  ;Match, both inactive
 S ERROR="1^"_IFN_"99,.02 STATUS HLNODE:"_HLNODE_" Doesn't match "_FIELD_" Inactive Flag "_FDA(IFN,IEN_",",FIELD)
 D EM^XUMF1H(ERROR,.ERR)
 Q
DUP(SUB,X1,X2) ;
 ;Checkup for duplicate coding system (ICD, 10D, CPT...)
 D GETS^DIQ(IFN,IEN_",","**","","TMP") ;TMP(9999999.143 - .128,"1,7,",.01)=86485   X1=CPT   X2=1234,4567,7890
 S II="" F  S II=$O(TMP(SUB,II)) Q:'II  S X3=$G(TMP(SUB,II,.01)) I $L(X3),X3=X1 D  Q
 .S ERROR="1^Error - "_II_" Duplicate Coding System"_" File #: "_IFN_" HLNODE="_HLNODE
 Q:$G(ERROR)
 ;Checkup for duplicate codes. (CPT:90701,90743,90701)
 F I=1:1 S X5=$P(X2,",",I) Q:'$L(X5)  S X6(X5)=$G(X6(X5))+1 I X6(X5)>1 D  Q
 .S ERROR="1^Error - Duplicate Codes in Coding System"_" File #: "_IFN_" HLNODE="_HLNODE
 Q
