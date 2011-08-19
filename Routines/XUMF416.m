XUMF416 ;ISS/RAM - Load NPI;12/15/05
 ;;8.0;KERNEL;**416**;Jul 10, 1995;Build 5
 ;
 ; $$PARAM^HLCS2 call supported by IA #3552
 ;
 Q
 ;
BG ; -- background job
 ;
 N ZTRTN,ZTDESC,ZTDTH
 ;
 S ZTRTN="EN^XUMF416"
 S ZTDESC="XUMF Load NPI"
 S ZTDTH=$$NOW^XLFDT
 S ZTIO=""
 ;
 D ^%ZTLOAD
 ;
 Q
 ;
EN ; -- entry point
 ;
 K ^TMP("XUMF ARRAY",$J)
 ;
 N PARAM,XUMFLAG,ERROR,TEST
 ;
 S (ERROR,XUMFLAG,TEST)=0
 ;
 I $P($$PARAM^HLCS2,U,3)="T" S TEST=1
 ;
 L +^TMP("XUMF ARRAY",$J):0 D:'$T
 .S ERROR="1^another process is using the Master File Server"
 ;
 I ERROR D EXIT Q
 ;
 D MFS0
 ;
 I ERROR D EXIT Q
 ;
 I '$D(^TMP("XUMF ARRAY",$J)) D
 .S ERROR="1^Connection to master file server failed!"
 ;
 I ERROR D EXIT Q
 ;
 D NPI
 ;
 D EXIT
 ;
 Q
 ;
MFS0 ; -- get NPI from Institution Master File
 ;
 S PARAM("CDSYS")="NPI"
 S PARAM("LLNK")="XUMF MFR^XUMF "_$S('TEST:"FORUM",1:"TEST")
 S PARAM("PROTOCOL")=$O(^ORD(101,"B","XUMF MFQ",0))
 ;
 D MAIN^XUMFP(4,"ALL",7,.PARAM,.ERROR) Q:ERROR
 D MAIN^XUMFI(4,"ALL",7,.PARAM,.ERROR) Q:ERROR
 D MAIN^XUMFH
 ;
 Q
 ;
EXIT ; -- cleanup and quit
 ;
 I '$$FIND1^DIC(4,,"BX","BONHAM PHARMACY") D EM
 ;
 K ^TMP("XUMF ARRAY",$J),^TMP("XUMF MFS",$J),^TMP("DIERR",$J)
 ;
 L -^TMP("XUMF ARRAY",$J)
 ;
 S ZTREQ="@"
 ;
 Q
 ;
NPI ; -- add NPI ID to Institution file
 ;
 N ID,FDA,ERROR,IEN,IENS,HLNODE,ARRAY,XUMF,STANUM,TAX,TAXPC,TAXSTAT,NPI,NPIDT,NPISTAT,X,ERR,VISN
 N NAME,OFNME,AGENCY,FACTYP,STREET,CITY,STATE,ZIP,FDA,PARENT,STRT1,CITY1,STATE1,ZIP1,INACTIVE
 ;
 S XUMF=1
 ;
 S ID=""
 F  S ID=$O(^TMP("XUMF ARRAY",$J,ID)) Q:ID=""  D
 .K HLNODE
 .M HLNODE=^TMP("XUMF ARRAY",$J,ID)
 .D UPDATE
 ;
 Q
 ;
UPDATE ;
 ;
 D SEGPRSE^XUMFXHL7("HLNODE","ARRAY")
 ;
 S NAME=ARRAY(1)
 S STANUM=ARRAY(2)
 S FACTYP=$P(ARRAY(4),"~",1)
 S OFNME=ARRAY(5)
 S INACTIVE=ARRAY(6)
 S STATE=ARRAY(7)
 S VISN=ARRAY(8)
 S PARENT=ARRAY(9)
 S STREET=$P(ARRAY(14),"~",2)
 S CITY=$P(ARRAY(14),"~",3)
 S ZIP=$P(ARRAY(14),"~",5)
 S STRT1=$P(ARRAY(15),"~",2)
 S CITY1=$P(ARRAY(15),"~",3)
 S STATE1=$P(ARRAY(15),"~",4)
 S ZIP1=$P(ARRAY(15),"~",5)
 S AGENCY=$P(ARRAY(16),"~")
 S NPIDT=$$FMDATE^HLFNC(ARRAY(17))
 S NPISTAT=ARRAY(18)
 S NPI=ARRAY(19)
 S TAX=ARRAY(20)
 S TAXPC=ARRAY(21)
 S TAXSTAT=ARRAY(22)
 ;
 S IEN=$$IEN^XUMF(4,"NPI",ID)
 I 'IEN,$G(STANUM)'="" S IEN=$O(^DIC(4,"D",STANUM,0))
 I 'IEN,$D(^DIC(4,"B",NAME)) S IEN=$O(^DIC(4,"B",NAME,0))
 ;
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
 S FDA(4,IENS,1.03)=CITY
 S FDA(4,IENS,1.04)=ZIP
 S FDA(4,IENS,.02)=STATE
 S FDA(4,IENS,4.01)=STRT1
 S FDA(4,IENS,4.03)=CITY1
 S FDA(4,IENS,4.04)=STATE1
 S FDA(4,IENS,4.05)=ZIP1
 S FDA(4,IENS,11)="National"
 S FDA(4,IENS,100)=OFNME
 S FDA(4,IENS,101)=INACTIVE
 S FDA(4,IENS,95)=AGENCY
 D FILE^DIE("E","FDA","ERR")
 ;
 K FDA
 S IENS="?+1,"_IEN_","
 S FDA(4.014,IENS,.01)="VISN"
 S FDA(4.014,IENS,1)=VISN
 D UPDATE^DIE("E","FDA")
 ;
 K FDA
 S IENS="?+2,"_IEN_","
 S FDA(4.014,IENS,.01)="PARENT FACILITY"
 S FDA(4.014,IENS,1)=PARENT
 D UPDATE^DIE("E","FDA")
 ;
 S X=$$NPI^XUSNPI("Organization_ID",IEN,NPIDT)
 I $S(X=0:1,$$UP^XLFSTR($P(X,U,3))'=NPISTAT:1,NPI'=+X:1,1:0) D
 .S X=$$ADDNPI^XUSNPI("Organization_ID",IEN,NPI,NPIDT,$S(NPISTAT="ACTIVE":1,1:0))
 ;
 S IENS="?+1,"_IEN_","
 K FDA
 S FDA(4.9999,IENS,.01)="NPI"
 S FDA(4.9999,IENS,.02)=NPI
 D UPDATE^DIE("E","FDA",,"ERR")
 ;
 K FDA
 S IENS="?+1,"_IEN_","
 S FDA(4.043,IENS,.01)=TAX
 S FDA(4.043,IENS,.02)=TAXPC
 S FDA(4.043,IENS,.03)=TAXSTAT
 D UPDATE^DIE("E","FDA",,"ERR")
 ;
 Q
 ;
POST ;
 ;
 D TAX,STA,OPT
 ;
 Q
 ;
TAX ;
 ;
 N IENS,FDA
 ;
 S IENS="?+954,"
 K FDA
 S FDA(8932.1,IENS,.01)="General Acute Care Hospital"
 S FDA(8932.1,IENS,6)="282N00000X"
 S FDA(8932.1,IENS,90002)="NON-INDIVIDUAL"
 D UPDATE^DIE("E","FDA","IEN","ERR")
 ;
 S IENS="?+955,"
 K FDA
 S FDA(8932.1,IENS,.01)="VA FACILITY"
 S FDA(8932.1,IENS,6)="261QV0200X"
 S FDA(8932.1,IENS,90002)="NON-INDIVIDUAL"
 D UPDATE^DIE("E","FDA","IEN","ERR")
 ;
 S IENS="?+956,"
 K FDA
 S FDA(8932.1,IENS,.01)="Department of Veterans Affairs (VA) Pharmacy"
 S FDA(8932.1,IENS,6)="332100000X"
 S FDA(8932.1,IENS,90002)="NON-INDIVIDUAL"
 D UPDATE^DIE("E","FDA","IEN","ERR")
 ;
 Q
 ;
OPT ;
 ;
 N IEN,FDA,IENS
 ;
 S IEN=$$FIND1^DIC(19,,"B","XUKERNEL")
 K FDA
 S IENS="?+1,"_IEN_","
 S FDA(19.01,IENS,.01)="XUMF LOAD NPI"
 D UPDATE^DIE("E","FDA")
 ;
 Q
 ;
STA ;
 ;
 N STA,IEN,IENS,FDA,FTYP,XUMF
 ;
 S XUMF=1
 ;
 S STA=""
 F  S STA=$O(^DIC(4,"D",STA)) Q:STA=""  D
 .S IEN=$O(^DIC(4,"D",STA,0))
 .S IENS="?+1,"_IEN_","
 .K FDA
 .S FDA(4.9999,IENS,.01)="VASTANUM"
 .S FDA(4.9999,IENS,.02)=STA
 .D
 ..N IEN,STA
 ..D UPDATE^DIE("E","FDA")
 ;
 Q
 ;
DEL ;USE EXTREME CAUTION!!!!
 ;
 N IEN,NPI,IEN1,FDA,ERR
 ;
 S IEN=0
 F  S IEN=$O(^DIC(4,IEN)) Q:'IEN  D
 .;Q:'$G(^DIC(4,IEN,99))
 .S NPI=$G(^DIC(4,IEN,"NPI")) ;Q:'NPI
 .K ^DIC(4,"ANPI",+NPI,IEN)
 .K ^DIC(4,"NPI42",+NPI,IEN)
 .K ^DIC(4,IEN,"NPI")
 .K ^DIC(4,IEN,"NPISTATUS")
 .K ^DIC(4,IEN,"TAXONOMY")
 .K ^DIC(4,"TAXSTATUS","A",IEN)
 ;
XXX ;
 ;
 S NPI=0
 F  S NPI=$O(^DIC(4,"XUMFIDX","NPI",NPI)) Q:'NPI  D
 .S IEN=$O(^DIC(4,"XUMFIDX","NPI",NPI,0)) Q:'IEN
 .S IEN1=$O(^DIC(4,"XUMFIDX","NPI",NPI,IEN,0)) Q:'IEN1
 .;Q:'$G(^DIC(4,IEN,99))
 .K FDA
 .S FDA(4.9999,IEN1_","_IEN_",",.01)="@"
 .D FILE^DIE("E","FDA","ERR")
 ;
YYY ;
 ;
 S IEN=$$FIND1^DIC(870,,"BX","XUMF FORUM")
 S IENS=IEN_","
 ;
 K FDA
 S FDA(870,IENS,4.5)=1
 S FDA(870,IENS,200.04)=60
 S FDA(870,IENS,200.05)=60
 D UPDATE^DIE(,"FDA")
 ;
 Q
 ;
EM ;
 ;
 N X,XMTEXT,XMDUZ,XMSUB
 ;
 S X(1)="The post install of patch XU*8*416 has completed but the NPI values"
 S X(2)="did not get updated in your INSTITUTION (#4) file.  Check your HL LOGICAL"
 S X(3)="LINK (#870) 'XUMF FORUM.' You should be able to PING the link -- stop/start"
 S X(4)="the link if necessary.",X(4.5)=""
 S X(5)="After you have verified your XUMF FORUM link use the 'Load Institution"
 S X(6)="NPI values' [XUMF LOAD NPI] in the [XUKERNEL] menu to load the NPI values."
 S X(7)=""
 S X(8)="NOTE: If you are installing in a TEST ACCOUNT then you may disregard this"
 S X(9)="message.  If you do need to install the NPI values in a test/development"
 S X(10)="environment then you must set up the 'XUMF TEST' logical link to connect"
 S X(11)="to a test server environment.  Hospitals will most likely not wish to update"
 S X(12)="the Institution file using HL7 messaging but rather wait until the mirror"
 S X(13)="image overwrites the file normally.  If you do need to update the test or"
 S X(14)="development account and you don't have a test server available then you'll"
 S X(16)="need to contact the Institution file developer."
 ;
 S XMSUB="XUMF NPI ERROR/WARNING/INFO"
 S XMY("G.XUMF NPI")="",XMY(DUZ)="",XMDUZ=.5
 S XMTEXT="X("
 ;
 D ^XMD
 ;
 Q
 ;
