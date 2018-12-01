XUMF04H ;BP/RAM - INSTITUTION Handler ;07/26/18
 ;;8.0;KERNEL;**549,678,698**;Jul 10, 1995;Build 7
 ;;Per VA Directive 6402, this routine should not be modified
 ; This routine handles Institution Master File HL7 messages.
 ;
MAIN ; -- entry point
 ;
 Q:$$KSP^XUPARAM("INST")=12000
 ;
 N X,HLFS,HLCS,ERROR,HLRESLTA,IFN,IEN,KEY,VALUE,ROOT,HLSCS,CDSYS,TEXT,ID
 ;
 D INIT,PROCESS,REPLY,EXIT
 ;
 Q
 ;
INIT ; -- initialize
 ;
 S ERROR=0,IEN=""
 S HLFS=HL("FS"),HLCS=$E(HL("ECH")),HLSCS=$E(HL("ECH"),4)
 ;
 Q
 ;
PROCESS ; -- pull message text
 ;
 F  X HLNEXT Q:HLQUIT'>0  D
 .Q:$P(HLNODE,HLFS)=""
 .D @($P(HLNODE,HLFS))
 ;
 Q
 ;
MSH ; -- MSH segment
 ;
 Q
 ;
MSA ; -- MSA segment
 ;
 Q
 ;
QRD ; -- QRD segment
 ;
 Q
 ;
MFI ; -- MFI segment
 ;
 Q
 ;
MFE ; -- MFE segment
 ;
 S KEY=$P(HLNODE,HLFS,5)
 ;
 S ID=$P(KEY,HLCS)
 S TEXT=$P(KEY,HLCS,2)
 S CDSYS=$P(KEY,HLCS,3)
 ;
 I CDSYS="VASTANUM" D  Q
 .S IEN=$O(^DIC(4,"D",ID,0)) Q:IEN
 .S IEN=$O(^DIC(4,"B",TEXT,0))
 ;
 I CDSYS="NPI" D  Q
 .S IEN=$O(^DIC(4,"ANPI",ID,0)) Q:IEN
 .S IEN=$O(^DIC(4,"B",TEXT,0))
 I CDSYS="DMIS" D  Q
 .S IEN=$O(^DIC(4,"XUMFIDX","DMIS",ID,0)) Q:IEN
 .S IEN=$O(^DIC(4,"B",TEXT,0))
 ;
 Q
 ;
ZIN ; -- VHA Institution segment
 ;
 W "."
 ;
 N NAME,FACTYP,OFNME,INACTIVE,STATE,VISN,PARENT,STREET,STREET2,CITY,ZIP
 N STRT1,STRT2,CITY1,STATE1,STANUM,BILLNAME,IEN1,IENS,ERR,ERROR1
 N ZIP1,AGENCY,NPIDT,NPISTAT,NPI,TAX,TAXPC,TAXSTAT,MAMMO,CLIA,DMIS,XXXX
 N LOCTZONE,COUNTRY,TZONEX
 ;
 D PARSE^XUMFXHL7("HLNODE","XXXX")
 ;
 S STANUM=XXXX(2)
 ;
 I $G(STANUM),CDSYS'="VASTANUM" Q
 ;
 S XUMF=1,ERROR1=""
 ;
 S NAME=XXXX(1)
 S FACTYP=$P(XXXX(4),"~",1)
 S OFNME=XXXX(5)
 S INACTIVE=XXXX(6)
 S STATE=XXXX(7)
 S VISN=XXXX(8)
 S:VISN'="" VISN=$O(^DIC(4,"B",VISN,0)) ;p698
 S PARENT=XXXX(9)
 S:PARENT'="" PARENT=$O(^DIC(4,"D",PARENT,0)) ;p698
 S STREET=$P(XXXX(14),"~",1)
 S STREET2=$P(XXXX(14),"~",2)
 S CITY=$P(XXXX(14),"~",3)
 S ZIP=$P(XXXX(14),"~",5)
 S COUNTRY=$P(XXXX(14),"~",6)
 S STRT1=$P(XXXX(15),"~",1)
 S STRT2=$P(XXXX(15),"~",2)
 S CITY1=$P(XXXX(15),"~",3)
 S STATE1=$P(XXXX(15),"~",4)
 S ZIP1=$P(XXXX(15),"~",5)
 S AGENCY=$P(XXXX(16),"~")
 S NPI=XXXX(17)
 S NPISTAT=XXXX(18)
 I NPISTAT="ACTIVE" S NPISTAT=1 ;p698
 I NPISTAT="INACTIVE" S NPISTAT=0 ;698
 S NPIDT=$$FMDATE^HLFNC(XXXX(19))
 S TAX=XXXX(20)
 S TAXSTAT=XXXX(21)
 S TAXPC=XXXX(22)
 S CLIA=XXXX(23)
 S MAMMO=XXXX(24)
 S DMIS=XXXX(25)
 S BILLNAME=XXXX(26)
 S LOCTZONE=XXXX(27)
 S TZONEX=XXXX(28)
 ;
 ; -- new entry
 I 'IEN D  Q:'IEN
 .N X,Y S X=NAME
 .K DIC S DIC=4,DIC(0)="F"
 .D FILE^DICN K DIC
 .S IEN=$S(Y="-1":0,1:+Y)
 ;
 S IENS=IEN_","
 ;
 K FDA
 S FDA(4,IENS,.01)=NAME
 S FDA(4,IENS,13)=FACTYP
 S FDA(4,IENS,1.01)=STREET
 S FDA(4,IENS,1.02)=STREET2
 S FDA(4,IENS,1.03)=CITY
 S FDA(4,IENS,1.04)=ZIP
 S FDA(4,IENS,.02)=STATE
 S FDA(4,IENS,4.01)=STRT1
 S FDA(4,IENS,4.02)=STRT2
 S FDA(4,IENS,4.03)=CITY1
 S FDA(4,IENS,4.04)=STATE1
 S FDA(4,IENS,4.05)=ZIP1
 S FDA(4,IENS,11)="National"
 S FDA(4,IENS,100)=OFNME
 S FDA(4,IENS,101)=INACTIVE
 S FDA(4,IENS,95)=AGENCY
 S FDA(4,IENS,99)=STANUM
 S FDA(4,IENS,200)=BILLNAME
 S FDA(4,IENS,800)=LOCTZONE
 S FDA(4,IENS,801)=COUNTRY
 S FDA(4,IENS,802)=TZONEX
 D FILE^DIE("E","FDA","ERR")
 I $D(ERR) D
 .D EM("error updating ZIN",.ERR)
 .K ERR
 ;
 I $G(VISN)'="" D
 .K FDA
 .S IENS="?+1,"_IEN_","
 .S FDAIEN(1)=1
 .S FDA(4.014,IENS,.01)=1
 .S FDA(4.014,IENS,1)=VISN
 .D UPDATE^DIE("","FDA","FDAIEN","ERR")
 I $D(ERR) D
 .D EM("error updating VISN",.ERR)
 .K ERR
 ;
 I $G(PARENT) D
 .S IENS="?+1,"_IEN_","
 .S FDAIEN(1)=2
 .S FDA(4.014,IENS,.01)=2
 .S FDA(4.014,IENS,1)=PARENT
 .D UPDATE^DIE("","FDA","FDAIEN","ERR")
 I $D(ERR) D
 .D EM("error updating PARENT",.ERR)
 .K ERR
 ;
 I $G(NPIDT)'="" D
 .K FDA
 .S IENS="?+2,"_IEN_","
 .S FDA(4.042,IENS,.01)=NPIDT
 .S FDA(4.042,IENS,.02)=NPISTAT
 .S FDA(4.042,IENS,.03)=NPI
 .D UPDATE^DIE("","FDA",,"ERR")
 I $D(ERR) D
 .D EM("error updating NPI",.ERR)
 .K ERR
 ;
 I $G(TAX)'="",$P($$TAXORG^XUSTAX(IEN),U)'=TAX D
 .K FDA,ROOT,IDX
 .S IENS="?+2,"_IEN_","
 .S FDA(4.043,IENS,.01)=TAX
 .S FDA(4.043,IENS,.02)=TAXPC
 .S FDA(4.043,IENS,.03)=TAXSTAT
 .D UPDATE^DIE("E","FDA",,"ERR")
 I $D(ERR) D
 .D EM("error updating TAXANOMY",.ERR)
 .K ERR
 ;
 I $G(CLIA)'="" D
 .S IENS="?+2,"_IEN_","
 .K FDA
 .S FDA(4.9999,IENS,.01)="CLIA"
 .S FDA(4.9999,IENS,.02)=CLIA
 .D UPDATE^DIE("E","FDA",,"ERR")
 I $D(ERR) D
 .D EM("error updating CLIA",.ERR)
 .K ERR
 ;
 I $G(MAMMO)'="" D
 .S IENS="?+2,"_IEN_","
 .K FDA
 .S FDA(4.9999,IENS,.01)="MAMMO"
 .S FDA(4.9999,IENS,.02)=MAMMO
 .D UPDATE^DIE("E","FDA",,"ERR")
 I $D(ERR) D
 .D EM("error updating MAMMO",.ERR)
 .K ERR
 ;
 I $G(DMIS)'="" D
 .S IENS="?+2,"_IEN_","
 .K FDA
 .S FDA(4.9999,IENS,.01)="DMIS"
 .S FDA(4.9999,IENS,.02)=DMIS
 .D UPDATE^DIE("E","FDA",,"ERR")
 I $D(ERR) D
 .D EM("error updating DMIS",.ERR)
 .K ERR
 ;
 Q
 ;
REPLY ; -- master file response
 ;
 Q:HL("MTN")="MFR"
 Q:HL("MTN")="MFK"
 Q:HL("MTN")="ACK"
 ;
 N X
 S X="MSA"_HLFS_$S(ERROR:"AE",1:"AA")_HLFS_HL("MID")_HLFS_$P(ERROR,U,2)
 S ^TMP("HLA",$J,1)=X
 ;
 S HLP("PRIORITY")="I"
 D GENACK^HLMA1(HL("EID"),HLMTIENS,HL("EIDS"),"GM",1,.HLRESLT)
 ;
 ; check for error
 I ($P($G(HLRESLT),U,3)'="") D  Q
 .S ERROR=1_U_$P(HLRESLT,HLFS,3)_U_$P(HLRESLT,HLFS,2)_U_$P(HLRESLT,U)
 ;
 ; successful call, message ID returned
 S ERROR="0^"_$P($G(HLRESLT),U,1)
 ;
 Q
 ;
EXIT ; -- cleanup, and quit
 ;
 Q
 ;
EM(ERROR,ERR) ; -- error message p698
 ;
 N X,XMSUB,XMY,XMTEXT,FLG
 S FLG=0
 D MSG^DIALOG("AM",.X,80,,"ERR")
 ;
 S X(.1)="HL7 message ID: "_$G(HL("MID"))
 S X(.2)="",X(.3)=$G(ERROR),X(.4)=""
 S XMSUB="IMF HANDLER ERROR MESSAGE"
 S XMY="G.XUMF INSTITUTION"
 S XMTEXT="X("
 S X=.9 F  S X=$O(X(X)) Q:'X  D
 .I X(X)="" K X(X) Q
 .I X(X)["DINUMed field cannot" S FLG=1 K X(X) Q
 I FLG Q:'$O(X(.9))
 D ^XMD
 Q
