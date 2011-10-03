HDISVSFX ;CT/GRR ; 24 Jan 2005  10:28 AM
 ;;1.0;HEALTH DATA & INFORMATICS;;Feb 22, 2005
FILE(HDISDOM,HDISFAC,HDISFLFN,HDISARRY) ;
 N HDISQQ,HDISOUT,X,HDIST,HDISY,HDISMD,HDISPROD,HDISFILE,HDISFN,HDISDOMN,HDISSRC,HDERR
 N HDISDA,HDISFIR,HDISTERM,HDISTSD,HDISSTAT,HDISTSDX,HDISVUID,HDISNST,HDISNTLF,HDISTP,Y
 I HDISDOM=""!(HDISFAC="")!(HDISFLFN="")!(HDISARRY="") S HDISOUT=0_"^Parameter Missing" G QUIT
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
 S X=$$GETFAC^HDISVF07(HDISFAC,,.HDISSRC)
 S HDISMD=$P($G(^HDISF(7118.21,HDISFAC,0)),"^",2)
 S HDISPROD=$P($G(^HDISF(7118.21,HDISFAC,0)),"^",3)
 S HDISFILE=$P($G(^HDIS(7115.6,HDISFLFN,0)),"^",2)
 S HDISFN=$P($G(^HDIS(7115.6,HDISFLFN,0)),"^",4)
 ;
 ;Set XML header in output array
 S @HDISARRY@(1)="<?xml version=""1.0"" encoding=""utf-8"" ?>"
 ;S @HDISARRY@(1)=$$XMLHDR^XOBVLIB()
 S @HDISARRY@(2)="<"_$P(HDISY(0),"^",4)_" "_$G(^HDIS(7115.3,HDIST,1))_">"
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
 ;
 ;Write out first 5 xml elements to output array
 ;
 D XMLOUT^HDISXML(HDIST,"10,20,22,25,30,40,45,","Z",HDISARRY,.HDERR)
 ;
 ;Get the node and piece position of term to be standardized
 ;(In most cases it is the .01 field)
 ;
 ;Loop through all file entries, create xml entry for each
 N HDISDA S HDISDA=0 F  S HDISDA=$O(^HDISF(7118.22,"AC",HDISFAC,HDISFLFN,HDISDA)) Q:HDISDA'>0  D
 .S HDISY=^HDISF(7118.22,HDISDA,0)
 .S HDISFIR=$P(HDISY,"^",3),HDISTP=$P(HDISY,"^",4)
 .S HDISTERM=$P($G(^HDISV(7118.11,HDISTP,0)),"^")
 .S HDISNTLF=""
 .S HDISNST=$$GETNTLF^HDISVF04(HDISTP,.HDISNTLF)
 .S HDISTSDX=""
 .S HDISVUID=$P($G(^HDISV(7118.11,HDISTP,"VUID")),"^")
 .S Z(60)=HDISTERM
 .S Z(70)=HDISVUID
 .S Z(80)=HDISNTLF
 .S Z(100)=HDISFIR
 .D XMLOUT^HDISXML(HDIST,"50,60,70,80,100,50/,","Z",HDISARRY,.HDERR)
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
