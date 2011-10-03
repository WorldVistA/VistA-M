VSITBUL ;ISD/RJP - Visit Error/Warning Bulletin ;4/21/97
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**76,81**;Aug 12, 1996
 ; Patch PX*1*76 changes the 2nd line of all VSIT* routines to reflect
 ; the incorporation of the module into PCE.  For historical reference,
 ; the old (VISIT TRACKING) 2nd line is included below to reference VSIT
 ; patches.
 ;
 ;;2.0;VISIT TRACKING;**2**;Aug 12, 1996;
 ;
 Q  ; - not an entry point
 ;
VAR(ERR) ; - log error messages
 ; - called by ^VSITPUT
 ;
 ; - pass ERR = <error message text>
 ; - rtns ^TMP($J,"VSIT-ERROR",
 Q:$G(VSIT("IEN"))  ;ADDED TO END UNNECESSARY MESSAGES
 D:'$D(^TMP($J,"VSIT-ERROR")) INI
 Q:$G(ERR)']""  N TXT
 S TXT="",$P(TXT,"-  ",25)="" D TXT(TXT)
 I "LOC,VDT,TYP,PAT,INS,SVC,"[($P(ERR,"^")) D
 . D TXT("*** Fatal Error - Required Variable Not Defined ***")
 E  D TXT("*** Warning - Non required Visit Data Field Invalid")
 D TXT($P(ERR,"^",3)_"  -> "_$P(ERR,"^",2))
 Q
 ;
TXT(TXT) ; - put text
 ;
 N LCT S LCT=$G(^TMP($J,"VSIT-ERROR",0))+1,^(0)=LCT,^(LCT)=$G(TXT)
 Q
 ;
INI ; - initialize message
 ;
 N TXT,X,Y,DIVIEN,DIVISION
 K ^TMP($J,"VSIT-ERROR")
 D NOW^%DTC S Y=% D DD^%DT
 I +$G(DUZ(2)) S DIVIEN=+$G(DUZ(2))_"," S DIVISION=$$GET1^DIQ(4,DIVIEN,.01)
 S:$L($G(DIVISION))<3 DIVISION="Unknown"
 D TXT("   When: "_Y_"         Option: "_$P($G(XQY0),"^"))
 D TXT("   User: "_$S($D(DUZ):$P($G(^VA(200,+DUZ,0)),"^"),1:"Unknown")_"             Division: "_DIVISION)
 S TXT="",$P(TXT,"-  ",25)="" D TXT(TXT)
 ; - required variables
 D TXT("The following are a list of required variables.")
 D TXT("    VSIT = "_$S($G(VSIT)]"":VSIT,1:"Undefined"))
 D TXT("     DFN = "_$S($D(DFN):DFN,1:"Undefined")_"  (patient)")
 D:$G(VSIT(0))]"" TXT(" VSIT(0) = "_VSIT(0))
 D TXT("Hospital Location = "_$G(VSIT("LOC")))
 Q
 ;
SND ; - send bulletin to mail group 'VSIT CREATE ERROR'
 ;   called by ^VSIT
 N TXT I $G(VSIT("IEN"))>0 D
 . S TXT="",$P(TXT,"-  ",25)="" D TXT(TXT)
 . D TXT("*** Reference Visit Record Number "_+$G(VSIT("IEN"))_" on "_$P($G(VSIT("IEN")),"^",2)_" ***")
 ;
 N GRP,MBR,XMSUB,XMTEXT,XMDUZ,XMY
 S XMY("G.VSIT CREATE ERROR")=""
 S XMSUB="ERROR - Visit File Creation"
 S XMTEXT="^TMP($J,""VSIT-ERROR"","
 S XMDUZ=.5
 I '$D(XMY),$D(DUZ)#10 S XMY(DUZ)=""
 S:'$D(XMY) XMY(.5)=""
 D ^XMD
 K ^TMP($J,"VSIT-ERROR"),XMB
 Q
