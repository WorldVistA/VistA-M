XUPCZRT ;BPFO/PB - KERNEL - CALLABLE ENTRY POINTS FOR ZRT SEGMENT ; 15 FEBRUARY 2017 12:58 PM
 ;;8.0;KERNEL;**671**;Jul 10, 1995;Build 16
 ;
 ;
 Q
ZRT ;Manipulate update of MFN ZRT segment for 8932.1 file
 I IEN,((NAME="Term")!(NAME="Status")) K XXIEN ;This is the indication that it's first update for any subfile
 ;S:$D(HLNODE(1)) HLNODE=HLNODE_HLNODE(1)
 G 89321:IFN=8932.1
 Q
 ;
89321 ;Manipulate update of MFN ZRT segment for 8932.1 File
 I NAME="Status" K XXIEN Q  ;XXIEN01 is the .01 of record without IEN
 I NAME="VistA_Textual_Definition" D  S OUT=1 Q
 .I $P(HLNODE,HLFS,3)="""""" D  Q
 ..S $P(HLNODE,HLFS,3)=""
 ..;Q  ;QUIT here means, we put extra NULL line if WP field deleted. its for VETS-Discovery Functionality testing.
 ..D WP^DIE(8932.1,IENS,11,"K","@","ERR")
 ..I $D(ERR) S ERROR="1^Error in delete file: 8932.1 of WP field 11,  IENS="_IENS D EM^XUMF1H(ERROR,.ERR) K ERR
 ..Q
 .;WP ;codng from WP^XUMF1H we need to do so because coding there is: D SEGPRSE^XUMFXHL7("HLNODE","X",HLFS,60)
 .;
 .N X,Y,A,I,CNT,X1,X2,ESC
 .D SEGPRSE^XUMFXHL7("HLNODE","X",HLFS)
 .S CNT=1
 .S A(CNT)=X(2)
 .S I=0
 .F  S I=$O(X(2,I)) Q:'I  D
 ..S Y=X(2,I)
 ..I $E(Y,1)=" " D  Q
 ...S A(CNT)=A(CNT)_" "
 ...Q:$P(Y," ",2)=""
 ...S CNT=CNT+1
 ...S A(CNT)=$P(Y," ",2,99)
 ..S X1=$P(Y," ",1)
 ..S X2=$P(Y," ",2,99)
 ..S A(CNT)=A(CNT)_X1_$S(X2="":"",1:" ")
 ..Q:X2=""
 ..S CNT=CNT+1
 ..S A(CNT)=X2
 .;  
 .D UNESCWP^XUMF0(.A,.HL)
 .; 
 .D WP^DIE(IFN,IENS,11,"K","A","ERR")
 .;
 .I $D(ERR) D
 ..S ERROR="1^wp field error"
 ..D EM^XUMF1H(ERROR,.ERR) K ERR
 .;
 .Q
 ;
 S:$D(HLNODE(1)) HLNODE=HLNODE_HLNODE(1)
 Q:IEN
 I NAME="Term" S XXIEN(.01)=$$UNESC^XUMF0($P(HLNODE,HLFS,3),.HL),OUT=1 Q
 I NAME="VistA_VA_Code" S XXIEN(5)=$P(HLNODE,HLFS,3),OUT=1 S:XXIEN(5)="""""" XXIEN(5)="" Q  ;Field #5  "F" X-ref
 I NAME="VistA_ASC_X12_Code" S XXIEN(6)=$P(HLNODE,HLFS,3),OUT=1 S:XXIEN(6)="""""" XXIEN(6)="" Q  ;Field #6   "G" X-REF
 D  ;Check if all definition fields are included in ZRT segment  
 .N ERMM
 .S:'$D(XXIEN(.01)) ERMM=ERMM_"Term,"
 .S:'$D(XXIEN(5)) ERMM=ERMM_",VistA_VA_Code,"
 .S:'$D(XXIEN(6)) ERMM=ERMM_",VistA_ASC_X12_Code"
 .I $D(ERMM) S ERROR="1^"_ERMM_"^Missing in ZRT Segment"
 N I,X5,X6,XX,NEWIEN
 S NEWIEN=0
 S X5=$S($L(XXIEN(5)):1,1:0) S:'X5 XXIEN(5)=" "
 S X6=$S($L(XXIEN(6)):1,1:0) S:'X6 XXIEN(6)=" "
 I X5 S I=0 F  S I=$O(^USC(8932.1,"F",XXIEN(5),I)) Q:'I  S XXIEN(5,I)=""
 I X6 S I=0 F  S I=$O(^USC(8932.1,"G",XXIEN(6),I)) Q:'I  S XXIEN(6,I)=""
 I 'X5!('X6) S I=0 F  S I=$O(^USC(8932.1,I)) Q:'I  S XX=^(I,0) S:'$L($P(XX,U,6))&'X5 XXIEN(5,I)="" S:'$L($P(XX,U,7))&'X6 XXIEN(6,I)=""
 S I=0 F  S I=$O(XXIEN(5,I)) Q:'I  K:'$D(XXIEN(6,I)) XXIEN(5,I)
 S I=0 F  S I=$O(XXIEN(6,I)) Q:'I  K:'$D(XXIEN(5,I)) XXIEN(6,I)
 ;New entry should be created.
 I '$O(XXIEN(5,0))!'$O(XXIEN(6,0)) D NEW,SM1(IEN,1,0) Q  ;New entry
 ;
 ;So now we have one or multiple results
 K XX S I=0 F  S I=$O(XXIEN(5,I)) Q:'I  S XX(I)=""
 S I=0 F  S I=$O(XXIEN(6,I)) Q:'I  S XX(I)=""
 S I=$O(XX(0)) D SM1(I,1,0) K XX(I) ;First IEN Set master to 0  No status set
 S IEN=I,IENS=IEN_","
 S I=0 F  S I=$O(XX(I)) Q:'I  D SM1(I,0,1)  ;Set master to 0 and status to 0 as well.
 ;I '$O(XXIEN(5,$O(XXIEN(5,0))))  ; Multiple entries in field 6
 ;I '$O(XXIEN(5,$O(XXIEN(6,0))))  ; Multiple entries in field 5
 Q
NEW ;New entry
 N X,DIC,Y
 ;
 S XUMF=1
 D CHK^DIE(IFN,.01,,XXIEN(.01),.X,"ERR")
 I $D(ERR) S ERROR="1^Error - .01 is invalid"_" File #: "_IFN_" HLNODE="_HLNODE Q
 K DIC S DIC=IFN,DIC(0)="F" D FILE^DICN K DIC
 I Y="-1" S ERROR="1^Error - stub entry IFN: "_IFN_" failed HLNODE: "_HLNODE Q
 S IEN=+Y,RECORD("NEW")=1
 S IENS=IEN_","
 S NEWIEN=1
 Q
SM1(IEN,XY,X0) ;Set master to one/zero and possibly status to 0
 ;XY=Master Yes/No
 ;If X0=1 Status set to 0?
 N ROOT,IENS,XUMF,X
 D CHK^DIE(IFN,.01,,XXIEN(.01),.X,"ERR")
 I $D(ERR) S ERROR="1^Error - .01 from VETS is invalid"_" File #: "_IFN_"  HLNODE="_HLNODE Q
 S IENS=IEN_","
 S ROOT=$$ROOT^DILFD(IFN,,1)
 M RECORD("BEFORE")=@ROOT@(IEN)
 S RECORD("STATUS")=$$GETSTAT^XTID(IFN,,IEN_",")
 S FDA(IFN,IENS,.01)=XXIEN(.01) ;Validation??
 S FDA(IFN,IENS,5)=$S(XXIEN(5)=" ":"@",1:XXIEN(5))
 S FDA(IFN,IENS,6)=$S(XXIEN(6)=" ":"@",1:XXIEN(6))
 S FDA(IFN,IENS,99.99)=VUID
 S FDA(IFN,IENS,99.98)=XY
 N ERR
 S XUMF=1
 D FILE^DIE("E","FDA","ERR")
 I $D(ERR) D  Q
 .S ERROR="1^VUID update error IFN: "_IFN_"   IEN: "_IEN_"   VUID: "_VUID_"   HLNODE: "_HLNODE
 .D EM^XUMF1H(ERROR,.ERR) K ERR
 D:X0  ;SET STATUS TO 0
 .N FDA,SUBFILE
 .S SUBFILE=8932.199
 .;I VALUE=$P($$GETSTAT^XTID(IFN,,IEN_","),U) Q
 .S FDA(SUBFILE,"?+1,"_IENS,.01)=$$NOW^XLFDT
 .S FDA(SUBFILE,"?+1,"_IENS,.02)=0
 .D UPDATE^DIE(,"FDA",,"ERR")
 .I $D(ERR) D
 ..S ERROR="1^effective date and status error"
 ..D EM^XUMF1H(ERROR,.ERR) K ERR
 ;
 ;
 D ADD^XUMF1H
 ;
 ; clean multiple flag
 K:'$D(XIEN(IEN)) XIEN
 S XIEN(IEN)=$G(XIEN(IEN))+1
 ; 
 Q
 ;
P89321 ;Post processing logic.      4.001,2       POST-PROCESSING LOGIC  2;E1,245 MUMPS
 Q:$G(ERROR)
 N I,X0,X1,X2,C,XV
 S I=0,C=10 F  S I=$O(^USC(8932.1,I)) Q:'I  S XV=$G(^(I,"VUID"),"^"),XV=$P(XV,U) D:'$L(XV)
 .S X0=$G(^USC(8932.1,I,0))
 .S C=C+1,ERR("DIERR",1,"TEXT",C)="EIN="_I_"   .01="_$P(X0,U)_"   VA CODE="_$P(X0,U,6)_"   X12 CODE="_$P(X0,U,7)
 D:$D(ERR)
 .S ERR("DIERR",1,"TEXT",10)="List of records not associated with VUID on site: "_$$SITE^VASITE()
 .S ERROR="1^Missing VUIDs in update of IFN: "_IFN_"  Listing of records see in MFS ERROR/WARNING/INFO"
 .Q
 Q
D89321 ; Discovery coding to get conversion to escape characters.. + set VistA_Individual_Flag to I/N
 N II,CNT,CNT1,VAL,VAL1
 S CNT=0,(VAL,VAL1)=""
 F  S CNT=$O(^TMP("HLA",$J,CNT)) Q:'CNT  S II=$G(^TMP("HLA",$J,CNT)) Q:'$L(II)  Q:$G(ERROR)  D:$P(II,HLFS)="ZRT"
 .S VAL=$P(II,HLFS,3)
 .Q:'$L(VAL)
 .S:$P(II,HLFS,2)="VistA_Individual_Flag" VAL=$E(VAL,1)
 .S VAL=$$ESC(VAL,.HL)
 .S $P(II,HLFS,3)=VAL
 .S ^TMP("HLA",$J,CNT)=II
 .D:$O(^TMP("HLA",$J,CNT,0))
 ..S CNT1=0 F  S CNT1=$O(^TMP("HLA",$J,CNT,CNT1)) Q:'CNT1  D
 ...S VAL=$G(^TMP("HLA",$J,CNT,CNT1))
 ...S ^TMP("HLA",$J,CNT,CNT1)=$$ESC(VAL,.HL)
 Q
ESC(VALUE,HL) ;Escape value
 N ESC,ESCFS,ESCCMP,ESCSUB,ESCREP,ESCESC,ESCSEQ,CVRT
 S ESC=$E(HL("ECH"),3)
 S ESCFS=ESC_"F"_ESC S CVRT("ESCFS")=HL("FS")
 S ESCCMP=ESC_"S"_ESC S CVRT("ESCCMP")=$E(HL("ECH"),1)
 S ESCREP=ESC_"R"_ESC S CVRT("ESCREP")=$E(HL("ECH"),2)
 S ESCESC=ESC_"E"_ESC S CVRT("ESCESC")=ESC
 S ESCSUB=ESC_"T"_ESC S CVRT("ESCSUB")=$E(HL("ECH"),4)
 ;F ESCSEQ="ESCFS","ESCCMP","ESCSUB","ESCREP","ESCESC" D
 F ESCSEQ="ESCFS","ESCCMP","ESCSUB","ESCREP" D
 .F  Q:VALUE'[CVRT(ESCSEQ)  D
 ..S VALUE=$P(VALUE,CVRT(ESCSEQ))_@ESCSEQ_$P(VALUE,CVRT(ESCSEQ),2,9999)
 Q VALUE
