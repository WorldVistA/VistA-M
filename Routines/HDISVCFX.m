HDISVCFX ;CT/GRR ; 24 Jan 2005  10:26 AM
 ;;1.0;HEALTH DATA & INFORMATICS;**1**;Feb 22, 2005
FILE(HDISDOM,HDISFILE,HDISFN,HDISARRY) ;
 N HDISQQ,HDISGL,HDISNODE,HDISPIC,Y
 N HDISOUT
 I HDISDOM=""!(HDISFILE="")!(HDISFN="")!(HDISARRY="") S HDISOUT=0_"^Parameter Missing" G QUIT
 K @HDISARRY
 ;Lookup VUID XML template to build XML document
 S DIC=7115.3,DIC(0)="Z",X="VUID" D ^DIC K DIC
 I Y<0 S HDISOUT=0_"^VUID Template Missing" G QUIT
 S HDIST=+Y,HDISY=Y,HDISY(0)=Y(0)
 ;
 ;Get Domain name
 S HDISDOMN=$P($G(^HDIS(7115.1,HDISDOM,0)),"^")
 ;
 ;Get Facility Number, MailMan Parameters, and mailMan Domain name
 S HDISSRC=$P($$SITE^VASITE(),"^",3)
 S HDISMD=$G(^XMB("NETNAME"))
 S HDISPROD=$$PROD^XUPROD()
 ;
 ;Set XML header in output array
 S @HDISARRY@(1)="<?xml version=""1.0"" encoding=""utf-8"" ?>"
 ;S @HDISARRY@(1)=$$XMLHDR^XOBVLIB()
 S @HDISARRY@(1)="<"_$P(HDISY(0),"^",4)_" "_$G(^HDIS(7115.3,HDIST,1))_">"
 ;
 ;Initialize Z array which will contain input data for XML routine
 N Z K Z D ZINIT
 ;
 ;Store Domain Name, Facility Number, MailMan Domain, File, and Field Number
 ;in output array
 S Z(10)=HDISDOMN
 S Z(20)=HDISSRC
 S Z(22)=HDISPROD
 S Z(25)=HDISMD
 S Z(40)=HDISFILE
 S Z(45)=HDISFN
 ;
 ;Get global root of file
 S HDISGL=$$ROOT^DILFD(HDISFILE,"",1) D CLEAN^DILF
 ;
 ;Write out first 5 xml elements to output array
 D XMLOUT^HDISXML(HDIST,"10,20,22,25,30,40,45,","Z",HDISARRY,.HDERR)
 ;
 ;Get the node and piece position of term to be standardized
 ;(In most cases it is the .01 field)
 S HDGL=$$GET1^DID(HDISFILE,HDISFN,"","GLOBAL SUBSCRIPT LOCATION")
 S HDISNODE=$P(HDGL,";",1)
 S HDISPIC=$P(HDGL,";",2)
 ;
 ;Loop through all file entries, create xml entry for each
 N HDISDA S HDISDA=0 F  S HDISDA=$O(@HDISGL@(HDISDA)) Q:HDISDA'>0  I $D(@HDISGL@(HDISDA,0)) D
 .S Z(60)=$P(@HDISGL@(HDISDA,HDISNODE),"^",HDISPIC)
 .S Z(70)=""
 .S Z(80)=""
 .S Z(100)=HDISDA_","
 .D XMLOUT^HDISXML(HDIST,"50,60,70,100,50/,","Z",HDISARRY,.HDERR)
 ;
 ;Set final XML closing elements
 D XMLOUT^HDISXML(HDIST,"30/,5/,","Z",HDISARRY,.HDERR)
 S HDISOUT=1
 ;
QUIT Q HDISOUT
 ;
 ;
ZINIT ;
 S Z(22)="" F Z=5:5:100 S Z(Z)=""
 Q
 ;
