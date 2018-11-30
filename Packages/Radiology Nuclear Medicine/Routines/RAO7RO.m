RAO7RO ;HISC/GJC,FPT-Request message from OE/RR. ;9/11/98  11:56
 ;;5.0;Radiology/Nuclear Medicine;**1,2,13,15,75**;Mar 16, 1998;Build 4
 ;
 ;------------------------- Variable List -------------------------------
 ; RAFLG=flag indicates ORC reached     RAHLFS="|"
 ; RAMSG=HL7 message passed in          RAORD=ORC-1 (Order control)
 ; RAPLCHLD=Tracks place holder values for adding entries to sub-files
 ;          in the Rad/Nuc Med Orders file.
 ; RASEG=specific HL7 node              X=subscript of HL7 node
 ; ----------------------------------------------------------------------
 ;
EN1(RAMSG) ; Pass in the message from OE/RR.  Decipher information.
 ; new variables for RAO7RO processing
 N A,AAH,ARR,CHAR,CNT,DFN,ERR,FLG,GMTSTYP,I,J,L,LEN,MSG,RA,RA0
 N RA7003,RA71,RA713,RA783,RAA,RAB,RAC,RACLIN,RACMCODE,RACMNOR
 N RACNT,RACOST,RACPT,RACPTIEN,RAD0,RADATA,RADBS,RADC,RADFN,RADUZ
 N RAECH,RAEMSG,RAERR,RAFDA,RAFLG,RAFNAME,RAFNUM,RAHDR,RAHLFS
 N RAIEN71,RAIL,RAIMGAB,RAIMGTYI,RAINCR,RAION,RAIT,RALDT,RALINEX,RALOC
 N RAMFE,RAMODIEN,RAMSH3,RAMULT,RANEW,RANOW,RANSTAT,RAOBR18,RAOBR19
 N RAOBR30,RAOBR4,RAOBX2,RAOBX3,RAOBX5,RAOIFN,RAORC1,RAORC10,RAORC11
 N RAORC12,RAORC15,RAORC16,RAORC2,RAORC3,RAORC7,RAORC7D,RAORC7P
 N RAORD,RAPGE,RAPLCHLD,RAPREG,RAPHYAP,RAPID3,RAPID5,RAPRCTY
 N RAPV119,RAPV12,RAPV13,RAREA,RARMBED,RASEG,RASTATUS,RASUB
 N RATSTMP,RAVAR,RAWARD,RAWP,RAX,RAXIT,RAXT71,RAY,RAZ,T1,T2,T3
 N VAIP,X,Y,Y1,Y2,Y3,Y4,Y5,Z,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE
 S X=^%ZOSF("ERRTN"),@^%ZOSF("TRAP")
 S (RAFLG,X)=0,RAPLCHLD=1
 D EN1^RAO7UTL ; setup field seperator data (see var list)
 S RALDT=$$NOW^XLFDT() ; setup 'Last Activity Date/Time'
 F  S X=$O(RAMSG(X)) Q:X'>0  D  Q:RAFLG
 . S RASEG=$G(RAMSG(X)) Q:$P(RASEG,RAHLFS)'="ORC"  ; quit if not ORC
 . S RAORD=$P(RASEG,RAHLFS,2),RAFLG=1
 . Q
 I RAORD'="NW"&(RAORD'="DC")&(RAORD'="NA")&(RAORD'="DE")&(RAORD'="Z@") D BRKOUT^RAO7UTL1,REJ^RAO7OKS("OC","Missing/Invalid Order Control") Q
 I RAORD="NW" D EN1^RAO7RON(.RAMSG) D
 .I $G(RAERR) D  Q
 ..S RAERR1="" I RAERR=35 I $G(RANOW) S RAERR1="Now="_RANOW
 ..I RAERR=35 S RAERR1=RAERR1_" Req Entered Dt="_$G(RAORC15)
 ..S RAERR=$$EN1^RAO7RO1(RAERR)_" "_$G(RAERR1) K RAERR1
 ..D REJ^RAO7OKS("OC",RAERR) Q
 .;if CLINICAL HISTORY was passed from CPRS and it failed the CLINICAL HISTORY data
 .;requirements, reject the message
 .I $P(RACLIN,U)=1,$P(RACLIN,U,2)'=1 S RAERR=$$EN1^RAO7RO1(15) D REJ^RAO7OKS("OC",RAERR) Q
 .K ERR
 .; Update 'REQUEST STATUS TIMES' multiple if parameter dictates!
 .I "Yy"[RADIV(.119) D
 ..; make sure that the activity log place holders differ from the
 ..; modifiers place holders
 ..S RAPLCHLD=RAPLCHLD+1
 ..S RANEW(75.12,"+"_RAPLCHLD_",+1,",.01)=RALDT
 ..S RANEW(75.12,"+"_RAPLCHLD_",+1,",2)=5
 ..S RANEW(75.12,"+"_RAPLCHLD_",+1,",3)=+RAORC10
 ..Q
 .D UPDATE^DIE("","RANEW","RAORC3","ERR") S RAORC3=+$G(RAORC3(1))
 .S RAORC3=$G(RAORC3)_"^RA"
 .I $D(ERR) S RAERR=$$EN1^RAO7RO1(21) D REJ^RAO7OKS("OC",RAERR) Q
 .D WP^DIE(75.1,+RAORC3_",",400,"K","^TMP(""RAWP"",$J)","ERR")
 .D ACC^RAO7OKS("OK","","","","")
 .; Prt request on im'g loc req prtr; if no im'g loc on the HL7 msg
 .; check for prtr on first entry in Im'g Loc file; if no prtr on
 .; first entry, don't print request
 . S RAO751=$G(^RAO(75.1,+RAORC3,0))
 . D:$P(RAO751,"^",6)=1!($P(RAO751,"^",6)=2) OENO^RAUTL19(+RAORC3)
 . K RAO751 ; fire off 'stat' or 'urgent' alert if order qualifies
 . ; print the request
 . I +RAOBR19(3)>0 S RAION=$P($G(^RA(79.1,+RAOBR19(3),0)),U,16)
 . ;I +RAOBR19(3)=0 S RAION=$P($G(^RA(79.1,+$O(^RA(79.1,0)),0)),U,16)
 . I +RAOBR19(3)=0 D  S:RAION="" RAION=$P($G(^RA(79.1,+$O(^RA(79.1,0)),0)),U,16)
 .. S (RALOC,RAION)=""
 .. ; Get Imaging Type of Procedure..
 .. S RAIMGTYI=$P(^RAMIS(71,RAOBR4(4),0),U,12) Q:RAIMGTYI=""
 .. F  S RALOC=$O(^RA(79.1,"BIMG",RAIMGTYI,RALOC)) Q:RALOC=""  D  Q:RAION]""
 ... ; Find Imaging Location within Imaging Type with Request device..
 ... Q:$P(^RA(79.1,RALOC,0),U,16)=""
 ... Q:^RA(79.1,RALOC,"DIV")'=+$$KSP^XUPARAM("INST")
 ... S RAION=$P(^RA(79.1,RALOC,0),U,16)
 . I RAION]"" D
 .. D PSETUP Q:RAION']""
 .. S ZTDTH=$H,ZTRTN="PRHS^RAO7RO",ZTIO=RAION
 .. S ZTDESC="Rad/Nuc Med Request print - frontdoor (CPRS)"
 .. D ^%ZTLOAD,HOME^%ZIS
 .. K ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE
 .. Q
 . Q
 ;
 I RAORD="Z@" N RAPUROK D EN2^RAO7PURG(.RAMSG) D  ; RAPUROK set in
 . ; EN2^RAO7PURG.  If RAPUROK=1 send ok msg, else send reject msg
 . I $G(RAERR) D REJ^RAO7OKS("ZU","") Q
 . D:'RAPUROK REJ^RAO7OKS("ZU","")
 . D:RAPUROK ACC^RAO7OKS("ZR","","","","")
 . Q
 I RAORD="DC" D EN1^RAO7RCH(.RAMSG) D
 .I $G(RAERR) S RAERR=$$EN1^RAO7RO1(RAERR) D REJ^RAO7OKS("UD",RAERR) Q
 .K ERR D FILE^DIE("K","RANEW","ERR")
 .I $D(ERR) S RAERR=$$EN1^RAO7RO1(37) D REJ^RAO7OKS("UD",RAERR) Q
 .D OE3^RABUL(+RAORC3) ; rad/nuc med request cancelled bulletin
 .I "Yy"[RADIV(.119) D  Q:$G(RAERR)
 ..N ERR
 ..S ERR=$$EN5^RAO7VLD(+RAORC3,1,+RAORC10,"")
 ..I +$G(ERR) S RAERR=$$EN1^RAO7RO1(30) D REJ^RAO7OKS("UD",RAERR) Q
 ..Q
 .D ACC^RAO7OKS("DR","","","","")
 .; print out the cancelled request
 .S RAIMJLOC=+$P($G(^RAO(75.1,+RAORC3,0)),"^",20)
 .I RAIMJLOC>0 S RAION=$P($G(^RA(79.1,RAIMJLOC,0)),U,24)
 .I RAIMJLOC=0 S RAION=$P($G(^RA(79.1,+$O(^RA(79.1,0)),0)),U,24)
 .I RAION]"" D
 ..D PSETUP Q:RAION']""
 ..S RACRHD="" ; set the cancelled request flag
 ..S ZTDESC="Rad/Nuc Med Cancelled Request print - frontdoor (CPRS)"
 ..S ZTIO=RAION,ZTDTH=$H,ZTRTN="PRHS^RAO7RO",ZTSAVE("RACRHD")=""
 ..D ^%ZTLOAD,HOME^%ZIS
 ..K RACRHD,RAIMJLOC,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE
 ..Q
 .Q
 ;
 ;For an order control of: 'NA', we error if one of these three
 ;conditions are true:
 ;1) if the ien of the Rad/Nuc Med Order is not valid
 ;2) patient file pointer (PID3) evaluates to a different
 ;   patient name than the PID5 value
 ;3) cannot file oerr order ien into file 75.1
 ;
 I RAORD="NA" D EN1^RAO7OKR(.RAMSG) I $G(RAERR) D
 . N RATXT S RATXT="Error for order control: 'NA'"
 . S:RAERR'?1N.N RAERR="error not found in our error table"
 . S:RAERR?1N.N RAERR=$$EN1^RAO7RO1(RAERR)
 . S:$D(XQY0)#2 RAVAR("XQY0")="" S RAVAR("RAERR")=""
 . D ERR^RAO7UTL(RATXT,.RAMSG,.RAVAR)
 . Q
 ;if order control of 'DE', CPRS files data into their OE/RR Errors file
 ;I RAORD="DE"
 ;purge DBS specific variables before exiting
 ;
PURGE ; kill & quit
 D CLEAN^DILF
 K ^TMP("RAWP",$J)
 Q
PRHS ; print request and/or health summary
 U IO D ^RAORD5 ; print the request
 S:'$D(RACRHD) GMTSTYP=$P($G(^RAMIS(71,+$G(RAOBR4(4)),0)),U,13)
 I +$G(GMTSTYP) D  ; don't print Health Summary with cancelled requests
 . W:$Y @IOF D ENX^GMTSDVR(RADFN,GMTSTYP)
 . Q
 W ! D CLOSE^RAUTL
 Q
PSETUP ; Define the variables needed to print cancelled and non-cancelled
 ; requests from the frontdoor (CPRS).
 I RAION'?1N.N S RAION=$O(^%ZIS(1,"B",RAION,0)) Q:RAION']""
 S RAION=$P($G(^%ZIS(1,RAION,0)),"^") Q:RAION']""
 S RAOIFN=+RAORC3,RAPAGE=0,RAX="",RADFN=RAPID3
 N RAFOERR S RAFOERR="" ; flag to indicate entry from frontdoor (CPRS)
 F RAI="RADFN","RAOIFN","RAX","RAPGE","RAOBR4(","RAFOERR" S ZTSAVE(RAI)=""
 S:$D(RAIL) ZTSAVE("RAIL")=""
 Q
