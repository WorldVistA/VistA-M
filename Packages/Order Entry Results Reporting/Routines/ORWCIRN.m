ORWCIRN ; slc/dcm,REV - Functions for GUI CIRN ACTIONS ;22-NOV-1999 07:27:24
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**10,101,109,132,141,160,208,239,215,243**;October 28, 1997;Build 242
 ;
FACLIST(ORY,ORDFN) ; Return list of remote facilities for patient
 ;Check to see if CIRN PD/MPI installed
 N X,ORSITES,I,IFN,LOCAL,CTR,HDRFLG
 S X="MPIF001" X ^%ZOSF("TEST")
 I '$T S ORY(0)="-1^CIRN MPI not installed." Q
 S X="VAFCTFU1" X ^%ZOSF("TEST")
 I '$T S ORY(0)="-1^Remote data view not installed." Q
 S X=$$GET^XPAR("ALL","ORWRP CIRN REMOTE DATA ALLOW",1,"I")
 I 'X S ORY(0)="-1^Remote access not allowed" Q
 D TFL^VAFCTFU1(.ORY,ORDFN)
 S I=0 F  S I=$O(ORY(I)) Q:'I  I $P(ORY(I),"^",5)="OTHER",'($P(ORY(I),"^")="200HD") K ORY(I) ;Screen out Type 'OTHER' locations
 S HDRFLG=0
 I $$GET^XPAR("ALL","ORWRP CIRN SITES ALL",1,"I") D
 . S (CTR,I)=0
 . F  S I=$O(ORY(I)) Q:'I  S $P(ORY(I),"^",5)=1,CTR=CTR+1 D
 .. I $P(ORY(I),"^")=200 S $P(ORY(I),"^",2)="DEPT. OF DEFENSE"
 .. I $P(ORY(I),"^")="200HD" D
 ... I +$$GET^XPAR("ALL","ORWRP HDR ON",1,"I")=0 K ORY(I) S CTR=CTR-1 Q
 ... S HDRFLG=I ; Remove commented out code to enable HDR + 1 other site. 
 D GETLST^XPAR(.ORSITES,"ALL","ORWRP CIRN SITES","I")
 S (CTR,I)=0,LOCAL=$P($$SITE^VASITE,"^",3)
 F  S I=$O(ORY(I)) Q:'I  D
 . I +ORY(I)=+LOCAL K ORY(I) Q
 . S IFN=$$IEN^XUAF4(ORY(I)),CTR=CTR+1
 . I IFN,$G(ORSITES(IFN)) S $P(ORY(I),"^",5)=1 I $P(ORY(I),"^")=200 S $P(ORY(I),"^",2)="DEPT. OF DEFENSE"
 . I IFN,$G(ORSITES(IFN)),$P(ORY(I),"^")="200HD" D
 .. I +$$GET^XPAR("ALL","ORWRP HDR ON",1,"I")=0 K ORY(I) S CTR=CTR-1 Q
 .. S HDRFLG=I ; Remove commented out code to enable HDR + 1 other site. 
 I '$L($O(ORY(""))) S ORY(0)="-1^Only local data exists for this patient"
 I $G(HDRFLG),CTR'>1 K ORY(HDRFLG) S ORY(0)="-1^Only HDR has data for this patient"
 Q
RESTRICT(ORY,PATID) ;Check for sensitive patient
 N DFN,ICN,SITE
 I '$G(PATID) S ORY(1)="-1",ORY(2)="Invalid Patient ID" Q
 S ICN=$P(PATID,";",2)
 I 'ICN S ORY(1)="-1",ORY(2)="Invalid ICN" Q
 S SITE=$$SITE^VASITE,SITE=$P(SITE,"^",2)_";"_$P(SITE,"^",3)
 S DFN=+$$GETDFN^MPIF001(ICN)
 I DFN<0 S ORY(1)="-1",ORY(2)="Patient not found on remote system ("_SITE_")" Q
 D PTSEC^DGSEC4(.ORY,DFN)
 Q
CHKLNK(ORY) ;Check for active HL7 TCP link on local system
 S ORY=$$STAT^HLCSLM
 Q
WEBADDR(ORY,PATID) ;Get VistaWeb Address
 S ORY=$$GET^XPAR("ALL","ORWRP VISTAWEB ADDRESS",1,"I")
 I ORY="" S ORY="https://vistaweb.med.va.gov" Q
 I ORY="https://vistaweb.med.va.gov" Q
 S ORY=ORY_"?q9gtw0="_$P($$SITE^VASITE,"^",3)_"&xqi4z="_PATID_"&yiicf="_DUZ
 Q
AUTORDV(ORY) ;Get parameter value for ORWRP CIRN AUTOMATIC
 S ORY=+$$GET^XPAR("ALL","ORWRP CIRN AUTOMATIC",1,"I")
 Q
HDRON(ORY) ;Get parameter value for ORWRP HDR ON
 S ORY=+$$GET^XPAR("ALL","ORWRP HDR ON",1,"I")
 Q
