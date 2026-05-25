PXUTLVST ;ISL/DEE,PKR - Looks up the visit to see if there is already one ;12/01/2024
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**238,248**;Aug 12, 1996;Build 6
 ;
 Q
 ;
FINDVISIT(DFN,VDT,HLOC,SVC,DSS,INS,TYPE,ENCTYPE,CSVC,VISITLIST) ;Use the "AA" index
 ;to search for existing visits. Requires Patient (DFN) and Visit Date and Time (VDT). Hospital Location
 ;is required unless SVC="E". Institution (INS), Type, Encounter Type (ENCTYPE), DSS ID (DSS), and
 ;Service Category (SVC) are optional. If they are passed as "", then they are not
 ;included in the visit matching.
 ;
 ;Credit Stop visits are not returned as a match because they are created and managed by
 ;Scheduling.
 ;
 ;DATA2PCE can change the input value of Service Category depending on if the patient was an
 ;inpatient or outpatient on the date of the encounter. It can also change the Service Category
 ;to "T" if the name of  the Clinic Stop contains "TELE".
 ;If the Stop Code is in file #150.1, the Service Category will be changed to X or D, see SVC^PXKCO.
 ;It can also be changed to A when EN^PXKCO is called from the protocol event SDAM APPOINTMENT EVENTS.
 ;This event is fired as part of SDAM PCE EVENT (D EN^SDPCE) which in turn is run directly from
 ;EVENT^PXKMASC.
 ;If there is a possibility the input value of SVC may not be correct, pass CSVC=1 to bypass Service
 ;Category matching except when SVC="E" is passed.
 ;
 S VDT=$$VFMDATE^PXDATE(VDT,"ST")
 I (+DFN'>0)!('VDT) S VISITLIST(0)=-1 Q
 I (SVC'="E"),(+HLOC'>0) S VISITLIST(0)=-1 Q
 I (+HLOC>0),('$D(^SC(HLOC))) S VISITLIST(0)=-1 Q
 ; 
 N AMCLIST,APPTVST,COSVC,DATE,DECLIST,DSST,DSSTP,ENCTYP,HOSPLOC,INP,INVDT,IPM,NFOUND
 N SERVCAT,STATUS,SVCMATCH,TEMP,TESTSVC,TIME,VISITIEN,VISITS,VLIST,VSIT
 ;
 ;Get the visit for the appointment if there is one.
 S APPTVST=$S(SVC="E":0,1:+$$APPT2VST^PXUTL1(DFN,VDT,HLOC))
 I APPTVST>0 S VISITLIST(0)=1,VISITLIST(1)=APPTVST,VISITLIST(1,"A")="" Q
 ;
 S VSIT("VDT")=VDT
 S VSIT("PAT")=DFN
 S VSIT("LOC")=HLOC
 S VSIT("INS")=$G(INS)
 S VSIT("DSS")=$G(DSS)
 S VSIT("TYPE")=$G(TYPE)
 S VSIT("ENCTYPE")=$G(ENCTYPE)
 S VSIT("SVC")=$G(SVC)
 ;
 S (NFOUND,VISITLIST(0))=0
 ;Build a list of visits based on matching VDT, DFN, and HLOC.
 S DATE=$P(VDT,".",1),TIME=$P(VDT,".",2)
 S INVDT=(9999999-DATE)
 I TIME'="" S INVDT=INVDT_"."_TIME
 S VISITIEN=0
 F  S VISITIEN=+$O(^AUPNVSIT("AA",DFN,INVDT,VISITIEN)) Q:VISITIEN=0  D
 . I $D(VISITS(VISITIEN)) Q
 . S ENCTYP=$P($G(^AUPNVSIT(VISITIEN,150)),U,3)
 .;Ignore Credit Stop encounters.
 . I ENCTYP="C" Q
 . S TEMP=^AUPNVSIT(VISITIEN,0)
 . S SERVCAT=$P(TEMP,U,7)
 .;Service Category is required, if it is NULL, it is a corrupted entry.
 . I SERVCAT="" Q
 .;If SVC=E, match Service Category, otherwise ignore it.
 . I (VSIT("SVC")="E"),(SERVCAT'="E") Q
 . I (VSIT("SVC")'="E"),(SERVCAT="E") Q
 . S HOSPLOC=$P(TEMP,U,22)
 . I (VSIT("LOC")'=""),(VSIT("LOC")'=HOSPLOC) Q
 . I HOSPLOC="" S HOSPLOC=0
 . S VISITS(VISITIEN)=""
 . S NFOUND=NFOUND+1,VISITLIST(NFOUND)=VISITIEN
 S VISITLIST(0)=NFOUND
 ;If there are no matches or an exact match the search is done.
 I NFOUND<2 Q
 ;
 ;When there are multiple matches, use additional criteria
 ;to try to find a unique match.
 ;
 ;Allow for service category being changed depending on the patient's
 ;status (inpatient/outpatient) and the stop code.
 S TESTSVC=""
 I ($G(CSVC)=1),(VSIT("SVC")'="E") D
 .;Use this special check for inpatient status.
 . S IPM=$$IP^VSITCK1(VDT,DFN)
 . S INP=$S(IPM>0:1,1:0)
 . I +VSIT("DSS")>0 S DSSTP=VSIT("DSS")
 . I (VSIT("DSS")=""),(+VSIT("LOC")>0) S DSSTP=+$P(^SC(VSIT("LOC"),0),U,7)
 . I DSSTP>0 S TESTSVC=$$SVC^PXKCO(SVC,DSSTP,INP,VSIT("LOC"))
 ;
 S NFOUND=0,VISITIEN=""
 F  S VISITIEN=$O(VISITS(VISITIEN)) Q:VISITIEN=""  D
 .;Allow for checked out encounters having their service category changed.
 .;If the hospital location's stop code contains "TELE" the service category will always be T.
 .;It is not changed on check out.
 . S COSVC=""
 . S STATUS=$S(VSIT("SVC")="E":0,TESTSVC="T":0,1:+$$STATUS^SDPCE(VISITIEN))
 . I STATUS=2 D
 .. I INP=0 S COSVC=$S(VSIT("SVC")="X":"X",1:"A")
 .. I INP=1 S COSVC=$S(VSIT("SVC")="X":"D",1:"I")
 .;
 . S TEMP=$G(^AUPNVSIT(VISITIEN,0))
 . S SVCMATCH=0
 . I $G(CSVC)=1 D
 .. I (VSIT("SVC")'=""),(VSIT("SVC")=$P(TEMP,U,7)) S SVCMATCH=1
 .. I (SVCMATCH=0),(TESTSVC'=""),(TESTSVC=$P(TEMP,U,7)) S SVCMATCH=1
 .. I (SVCMATCH=0),(COSVC'=""),(COSVC=$P(TEMP,U,7)) S SVCMATCH=1
 . I SVCMATCH=0 Q
 .;
 . I (VSIT("TYPE")'=""),(VSIT("TYPE")'=$P(TEMP,U,3)) Q
 . I (VSIT("DSS")'=""),(VSIT("DSS")'=$P(TEMP,U,8)) Q
 . I (VSIT("INS")'=""),(VSIT("INS")'=$P(TEMP,U,6)) Q
 . I VSIT("ENCTYPE")'="" D  Q:VSIT("ENCTYPE")'=ENCTYP
 .. S ENCTYP=($P($G(^AUPNVSIT(VISITIEN,150)),U,3))
 . S NFOUND=NFOUND+1,AMCLIST(NFOUND)=VISITIEN
 S AMCLIST(0)=NFOUND
 ;If there is an exact match the search is done.
 I AMCLIST(0)=1 D  Q
 . K VISITLIST
 . S VISITLIST(0)=AMCLIST(0),VISITLIST(1)=AMCLIST(1)
 ;
 I (AMCLIST(0)>0),(AMCLIST(0)<VISITLIST(0)) F IND=0:1:AMCLIST(0) S DECLIST(IND)=AMCLIST(IND)
 E  F IND=0:1:VISITLIST(0) S DECLIST(IND)=VISITLIST(IND)
 ;
 ;Process multiple matches.
 N DECOUNT,KEEPIEN,KEEPIND,NREFS,NREFSD,NVISITS,TEMPLIST
 F IND=1:1:DECLIST(0) D
 . S VISITIEN=DECLIST(IND)
 . S DECOUNT=+$P(^AUPNVSIT(VISITIEN,0),U,9)
 . S NREFSD(DECOUNT,IND)=VISITIEN
 ;Order the list based on Dependent Entry Count; largest is first. Remove
 ;visits with no references.
 K VISITLIST
 S NREFS="",NVISITS=0
 F  S NREFS=+$O(NREFSD(NREFS),-1) Q:NREFS=0  D
 . S IND=""
 . F  S IND=$O(NREFSD(NREFS,IND)) Q:IND=""  D
 .. S NVISITS=NVISITS+1,VISITLIST(NVISITS)=DECLIST(IND)
 I NVISITS>0 S VISITLIST(0)=NVISITS Q
 ;
 ;If no visits have references return the first one.
 S KEEPIND=$O(NREFSD(0,""))
 S KEEPIEN=DECLIST(KEEPIND)
 K VISITLIST
 S VISITLIST(0)=1,VISITLIST(1)=KEEPIEN
 Q
 ;
 ;=========
LOOKVSIT(PAT,VDT,LOC,DSS,INS,TYP) ;Calls visit tracking to see if there is
 ;already a visit.
 ;Get the visit for the appointment is there is one
 N APPTVST
 S APPTVST=$$APPT2VST^PXUTL1(PAT,VDT,LOC)
 I APPTVST>0 Q APPTVST
 ;
 N VSIT,VSITPKG
 S VSIT("IEN")=""
 S VSIT("VDT")=VDT
 S VSIT("PAT")=PAT
 S VSIT("LOC")=LOC
 S VSIT("INS")=$G(INS)
 S VSIT("TYP")=$G(TYP)
 S VSIT("DSS")=$G(DSS)
 I VSIT("DSS")="",$P($G(^SC(+VSIT("LOC"),0)),"^",7)>0 S VSIT("DSS")=$P(^SC(+VSIT("LOC"),0),"^",7)
 S VSITPKG="PX"
 S VSIT(0)="D0EM"
 ;
 ;CALL FOR VSIT
 D ^VSIT
 I '$D(VSIT("IEN"))#2 Q -1
 Q $P(VSIT("IEN"),"^",1)
 ;
