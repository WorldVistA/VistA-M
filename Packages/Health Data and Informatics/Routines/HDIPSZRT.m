HDIPSZRT ;DAL/PBB - DOSAGE FORM ENTRY POINTS FOR ZRT SEGMENT MFS UPDATE ;10/13/2017
 ;;1.0;HEALTH DATA & INFORMATICS;**21**;Feb 22, 2005;Build 9
 ;
 Q
ZRT ;Manipulate update of MFN ZRT segment for MED DOSAGE files
 I IEN,((NAME="Term")!(NAME="Status")) K XXIEN ;This is the indication that it's first update for any subfile
 S:$D(HLNODE(1)) HLNODE=HLNODE_HLNODE(1)
 G XX99:IFN=50.60699
 Q
 ;
XX99 ;1399 ;Manipulate update of MFN ZRT segment for MASTER DOSAGE FORM (#50.60699) File
 N X,XX,ERR,IENS,IEN1,IENX,X1,X2,X4,DA,DIK,I,FDAA,VALUE,IFN9
 S IFN9=50.60699901
 I IEN,NAME="VistA_Related_Record" D  Q  ;ZRT^VistA_CodingSystem_Mapping^LOINC:90701,90743
 .S (X,VALUE)=$$UNESC^XUMF0($P(HLNODE,HLFS,3),.HL)
 .I '$L(X)!(X="""""") D DS(IFN9,IEN) S OUT=1 Q  ;Q:$G(OUT)  ;If there is nothing coming from Push, wipe anything was there before
 .I '$G(XXIEN(IFN9)) D DS(IFN9,IEN)  S XXIEN(IFN9)=1 ;CLEAN SUBFILE ENTRY
 .S IENS=IEN_","
 .S IEN1="+1,",FDAA(IFN9,"+1,"_IENS,.01)=X  ;NOT RIGHT
 .S VALUE=$$VAL^XUMF0(IFN9,.01,"",VALUE,"?+1,"_IENS)
 .Q:ERROR  Q:VALUE="^"
 .D:$D(FDAA) UPDATE^DIE("","FDAA",,"ERR")
 .I $D(ERR) D  Q
 ..S ERROR="1^subfile update error SUBFILE#: "_IFN9_"  HLNODE:"_HLNODE
 ..D EM^XUMF1H(ERROR,.ERR)
 .Q:$G(ERROR)
 .S OUT=1
 Q
POST ;Post processing logic
 ; IFN = File #  aka 50.60699
 ; IFNM File associated with IFN aka 50.606
 ;Scan all enries from file 50.606 field 90 and see if some dangling pointers are there, or if entries can be repointed.
 Q:$G(ERROR)
 ;^PS(50.606,"ACMF",2,63)=""
 ;^PS(50.606,63,0)="TAB"
 ;^PS(50.606,63,"MASTER")=2
 ;^PSMDF(50.60699,"AC","Aerosol",2,1)=""
 ;^PSMDF(50.60699,2,"ASSOC",1,0)="Aerosol"
 ;X0=2   N13="Aerosol"   X1=63
 ;IFNA1 = ^PSMDF(IFN,"AC",N13,X0)
 ;IFNA2 = ^PSMDF(IFN,"AC",N13,0)
 ;IFNA3 = ^PSMDF(IFN,Q2,0)
 ;IFNA4 = ^PSMDF(IFN,Q3,0)
 ;IFNA  = ^PSMDF(IFN,"AC",N13)
 ;IFNB1 = ^PS(IFNM,X1)
 ;IFNB2 = ^PS(IFNM,X1,0)
 ;IFNB3 = ^PS(IFNM,"ACMF"
 ;IFNB =  ^PS(IFNM,X1,"MASTER")
 ;Get the pointers from 50.606 to be repointed to 50.60699
 ;first see if we have some NUUL pointer
 N X0,X1,X2,C,TEXT,N13,IFNM,IFNA,IFNA1,IFNA2,IFNA3,IFNA4,IFNB,IFNB1,IFNB2,IFNB3,IFNC,MDF,DUPL,Q1,Q2,Q3
 S C=10,IFNM=50.606,IFNA=^DIC(IFN,0,"GL"),IFNB=^DIC(IFNM,0,"GL")
 S IFNC=IFNB_"X0,0)" ;^PS(50.606,X0,0)
 S IFNA1=IFNA_"""AC"",N13,X0)",IFNA2=IFNA_"""AC"",N13,0)",IFNA3=IFNA_"Q2,0)",IFNA4=IFNA_"Q3,0)",IFNA=IFNA_"""AC"",N13)"
 S IFNB1=IFNB_"X1)",IFNB2=IFNB_"X1,0)",IFNB3=IFNB_"""ACMF"",IENS)",IFNB=IFNB_"X1,""MASTER"")"
 S MDF=90
 ;Check for duplicates in 50.60699,99      ASSOCIATED DOSAGE FORM STATUSES ASSOC;0 Multiple #50.60699901
 S N13="" F  S N13=$O(@IFNA) Q:'$L(N13)  D  ;IFNA  = ^PSMDF(IFN,"AC",N13)
 .K DUPL M DUPL=@IFNA S Q1="DUPL",Q1=$Q(@Q1),Q2=Q1,Q2=+$P(Q2,"(",2),Q1=$Q(@Q1) Q:'$L(Q1)  ;Quit if only one multiple,.. no duplicates.
 .F  D  S Q1=$Q(@Q1) Q:'$L(Q1)
 ..S Q3=+$P(Q1,"(",2),Q3=$P(@(IFNA4),U)
 ..S TEXT="  File: "_IFN_" Local IEN: "_+$P(Q1,"(",2)_" "_Q3_" Associated "_N13_"  Is Duplicate to Ass. in IEN: "_Q2_"  "_$P(@(IFNA3),U)
 ..S C=C+1,ERR("DIERR",1,"TEXT",C)=TEXT
 .Q
 I $D(ERR) D  Q
 .S ERR("DIERR",1,"TEXT",10)="List of Association duplicates in "_IFN_"  Site:"_$$SITE^VASITE()
 .S ERROR="1^Records in file "_IFN_" have Association duplictes.  Listing of duplicates see in MFS ERROR/WARNING/INFO"
 .D EM^XUMF0
 .K ERR
 ;
 S X1=0 F  S X1=$O(@IFNB1) Q:'X1  Q:$G(ERROR)  S N13=$P($G(@IFNB2),U) I $L(N13) S X0=+$G(@IFNB) D:'$D(@IFNA1)  ;X0=Master pointer to 50.60699
 .I $D(@IFNA) D  Q  ;No MASTER pointer into file 50.606 or MASTER needs to be repointed
 ..N FDA,ERR,ZZZ
 ..S X0=$O(@IFNA2)
 ..D GETS^DIQ(IFN,X0_",","99.991*","I","ZZZ","ERR")
 ..I $D(ERR) D  Q
 ...S ERROR="1^Error in Retrievig status of IEN: "_X0_" in file"_IFN
 ...S ERRCNT=+$G(ERRCNT) D EM^XUMF1H(ERROR,.ERR)
 ..;ZZZ(50.6069901,"1,17,",.01,"I")=3170915.170227
 ..;ZZZ(50.6069901,"1,17,",.02,"I")=1
 ..;ZZZ(50.6069901,"2,17,",.01,"I")=3170915.200528
 ..;ZZZ(50.6069901,"2,17,",.02,"I")=0
 ..Q:'@($Q(ZZZ(99999999999),-1))   ; Ignore "Invalid or wrong number of arguments to a function" XINDEX warning.
 ..S FDA(IFNM,X1_",",MDF)=X0
 ..D FILE^DIE(,"FDA","ERR")
 ..I $D(ERR) D
 ...S ERROR="1^Repointing entry: "_X1_" in file"_IFNM_" error."
 ...S ERRCNT=+$G(ERRCNT) D EM^XUMF1H(ERROR,.ERR)
 ...K ERR
 ..Q
 .Q:$G(ERROR)
 .; Local entry in master file doesn't exist send e-mail ito XUMF ERROR
 .S:X0 Q2=X0,Q2=$P($G(@IFNA3),U)
 .S TEXT="  File: "_IFNM_" Local IEN: "_X1_"  "_N13_"  Is missing in file"_IFN_" and can NOT be "_$S('X0:"SET",1:"RESET From: "_Q2) ;
 .S C=C+1,ERR("DIERR",1,"TEXT",C)=TEXT
 .S:X0 C=C+1,ERR("DIERR",1,"TEXT",C)="   Master IEN before: "_X0_"  "_$P($G(@IFNC),U)
 Q:$G(ERROR)
 I $D(ERR) D  Q
 .S ERR("DIERR",1,"TEXT",10)="List of records from file "_IFNM_" not synchronised with file "_IFN_"  Site:"_$$SITE^VASITE()
 .S ERROR="0^Records of file "_IFN_" are not synchronised with File "_IFNM_"  Listing of records see in MFS ERROR/WARNING/INFO"
 .D EM^XUMF0
 .K ERR
 Q
 ;
DS(SUBFILE,IENS) ;Delete subfile
 D DS1(IENS)
 Q:$G(ERROR)
 N ROOT,IDX,X
 ;K @(IFNB3) ;Delete field 90 pointers from 50.606 to 50.60699   K ^PS(50.606,"ACMF",IENS)
 S ROOT=$$ROOT^DILFD(SUBFILE,","_IENS,1)
 S IDX=0 F  S IDX=$O(@ROOT@(IDX)) Q:'IDX  D
 .N DA,DIK,DIC S DA(1)=+IENS,DA=IDX,DIK=$P(ROOT,")")_"," D ^DIK
 Q
DS1(IEN) ; Delete coresponding fields 90 in file 50.606
 N IFNM,FDA,IDX,IFNB,IFNB3
 S IFNM=IFN\1
 S IFNB=^DIC(IFNM,0,"GL"),IFNB3=IFNB_"""ACMF"",IEN,IDX)"
 S IDX=0 F  S IDX=$O(@IFNB3) Q:'IDX  S FDA(IFNM,IDX_",",90)="@"
 Q:'$D(FDA)
 D FILE^DIE(,"FDA","ERR")
 Q:'$D(ERR)
 S ERROR="1^Error in update of field 90 in file: "_IFNM
 S ERRCNT=+$G(ERRCNT) D EM^XUMF1H(ERROR,.ERR)
 ;K ERR
 Q
