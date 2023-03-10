VSIT ;ISD/MRL,RJP,PKR - Visit Tracking ;03/29/2018
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**76,111,118,164,211**;Aug 12, 1996;Build 454
 ; Patch PX*1*76 changes the 2nd line of all VSIT* routines to reflect
 ; the incorporation of the module into PCE.  For historical reference,
 ; the old (VISIT TRACKING) 2nd line is included below to reference VSIT
 ; patches.
 ;
 ;;2.0;VISIT TRACKING;**1**;Aug 12, 1996
 ;
 ; - pass VSIT          = <visit date [and time] in FM format>
 ;        DFN           = <patient file pointer>
 ;        [VSIT(0)]     = <functional parameters>
 ;        [VSIT("xxx")] = <used in match logic if VSIT(0)["M">
 ; - rtns VSIT("IEN")   = <visit record # in format as Y w/ ^DIC>
 ;       VSIT(##,"XXX") = visit values passed by mnemonics
 ;      If VSIT("IEN")  = -1 Error in creation/lookup.
 ;      If Vsit("IEN")  = -2 Package is turned off or not defined in the
 ;                          Visit Tracking Parameters file.
 S VSIT("IEN")=$$GET($G(VSIT),$G(DFN),$G(VSIT(0)),.VSIT)
EXIT ;
 Q
 ;
GET(VDT,DFN,PRAM,VSIT) ; find or create a visit
 ;
 ; - pass {VDT/VSIT("VDT")} = <visit date [and time] in FM format>
 ;        {DFN/VSIT("PAT")} = <patient file pointer>
 ;        [PRAM/VSIT(0)]    = <functional parameters>
 ;        [VSIT("xxx")]     = <array w/ mnemonic subscript>
 ;                            <used in match logic if VISIT(O)["M">
 ;                            <for SVC, TYP, INS, DSS, ELG , LOC>
 ; - rtns                   = <visit record # in format as Y w/ ^DIC>
 I $G(VSITPKG)]"" S VSIT("PKG")=VSITPKG
 E  S (VSITPKG,VSIT("PKG"))=$G(VSIT("PKG"))
 N PKGP
 S PKGP=$$PKG2IEN^VSIT0($G(VSITPKG))
 I PKGP=-1 S VSIT("IEN")=-2 G DONE
 ;Get the site part of the VISIT ID
 I $P($G(^DIC(150.9,1,4)),"^",2)<1 S VSIT("IEN")=-1 G DONE
 ;
 K VSIT("IEN"),^TMP("VSITDD",$J),^TMP($J,"VSIT-ERROR")
 S:$G(VDT)]"" VSIT("VDT")=VDT
 S:$G(DFN) VSIT("PAT")=+DFN
 S:$G(PRAM)]"" VSIT(0)=PRAM
 ;See if the old CLN nodes needs moved into the DSS node.
 I '($D(VSIT("DSS"))#2),$D(VSIT("CLN"))#2 S VSIT("DSS")=VSIT("CLN")
 ;
 D FLD^VSITFLD
 ;Set all of the VSIT nodes with $GET
 D SETALL^VSITCK
 ;
 ;Inpatient movement
 N VSITIPM S VSITIPM=+$$IP^VSITCK1(+VSIT("VDT"),+VSIT("PAT"))
 ;Do the defaulting of the fields that need to be defaulted for lookup
 I $$REQUIRED^VSITDEF S VSIT("IEN")=-1 G DONE
 ;
 D:'$D(DT) DT^DICRW
 ;
 ;If Force new visit, make the visit and exit
 I VSIT(0)["F" D  G QUIT
 . D DEFAULTS^VSITDEF
 . D ^VSITPUT
 ;
 ;If not forcing new visit try to look up the visit
 D LST^VSITGET("","","",.VSIT,.VSITGET)
 I $$SWSTAT^IBBAPI(),+$G(VSITGET)=1 D  ;PX*1.0*164
 . N ACT
 . I $G(VSIT("ACT"))']0 S VSIT("ACT")=$P($G(^AUPNVSIT(+VSITGET(1),0)),"^",26) Q
 . I $G(VSIT("ACT"))]0 S ACT=VSIT("ACT") K VSIT S VSIT("IEN")=+$P(VSITGET(1),"^"),VSIT("ACT")=ACT D UPD^VSIT ;PX*1.0*164
 ;
 I +$G(VSITGET)=0,VSIT(0)["N" D  G QUIT
 . D DEFAULTS^VSITDEF
 . D ^VSITPUT
 I +$G(VSITGET)=1 S VSIT("IEN")=$P(VSITGET(1),"|")_"^"_$P($P(VSITGET(1),"^"),"|",2) G QUIT
 I +$G(VSITGET)>1,VSIT(0)["I" S Y=$$VSIT^VSITASK(VSIT("PAT"),.VSITGET) S:'+Y Y=1 S VSIT("IEN")=$P(VSITGET(+Y),"|")_"^"_$P($P(VSITGET(+Y),"^"),"|",2) G QUIT
 I +$G(VSITGET)>1,VSIT(0)'["I" S VSIT("IEN")=$P(VSITGET(1),"|")_"^"_$P($P(VSITGET(1),"^"),"|",2) G QUIT
 S VSIT("IEN")=-1
 ;
QUIT ; - end of job
 ; set vsit api
 I +$G(VSIT("IEN"))=0 S VSIT("IEN")=-1
 D:VSIT("IEN")>0 ALL^VSITVAR(+VSIT("IEN"),"B",1)
 ;
DONE I $D(^TMP($J,"VSIT-ERROR")),$G(VSIT("IEN"))'>0,VSIT(0)["N"!(VSIT(0)["F") D SND^VSITBUL
 K VSITGET
 K ^TMP("VSITDD",$J)
 Q VSIT("IEN")
 ;
ADD ; - add to dependency count
 ;   called via cross references on pointer files
 D ADD^AUPNVSIT
 Q
 ;
SUB ; - subtract from dependency count
 ;   called via cross references on pointer files
 D SUB^AUPNVSIT
 Q
 ;
UPD ;Update Visit File
 Q:$G(VSIT("IEN"))<1
 Q:'$D(^AUPNVSIT(VSIT("IEN"),0))
 N FDA,HNC,IENS,MSG,VSITDR,VSITFLD
 S IENS=VSIT("IEN")_","
 S VSIT("MDT")=$$NOW^XLFDT
 D FLD^VSITFLD
 S VSITDR=""
 F  S VSITDR=$O(VSIT(VSITDR)) Q:VSITDR=""  D
 . I $G(^TMP("VSITDD",$J,VSITDR))="" Q
 . S VSITFLD=$P(^TMP("VSITDD",$J,VSITDR),";",2) ;Field
 . S FDA(9000010,IENS,VSITFLD)=VSIT(VSITDR)
 L +^AUPNVSIT(+VSIT("IEN")):DILOCKTM
 D FILE^DIE("","FDA","MSG")
 L -^AUPNVSIT(+VSIT("IEN"))
 I $D(MSG) D  Q
 . N SUBJECT
 . S SUBJECT="UPD^VSIT failed for Visit IEN="_VSIT("IEN")
 . D SENDEMSG^PXMCLINK(SUBJECT,.MSG)
 K ^TMP("VSITDD",$J)
 ;
 ;PX*1*111 - Update NTR file for Head & Neck
 S HNC=$P($G(^AUPNVSIT(VSIT("IEN"),800)),U,6)
 I HNC'=1 Q
 N DGARR,PXDFN,SDRES
 S PXDFN=$P(^AUPNVSIT(VSIT("IEN"),0),U,5)
 I PXDFN="" Q
 S SDRES=$$GETCUR^DGNTAPI(PXDFN,"DGARR")
 I +$G(DGARR("STAT"))'=3 Q  ;NTR File does not require editing
 S SDRES=$$FILEHNC^DGNTAPI1(PXDFN)
 Q
 ;
PKG2IEN(PKG) ;Pass in package name space and
 ;        returns pointer to the package in the Package file #9.4
 Q $$PKG2IEN^VSIT0($G(PKG))
 ;
PKG(PKG,VALUE) ;-Entry point to add package to multiple in tracking parameters
 ;-PKG=Package Name Space
 ;-VALUE=Value on the ON/OFF flag under package multiple 
 ;--1=ON  0=OFF
 Q $$PKG^VSIT0($G(PKG),$G(VALUE))
 ;
PKGON(PKG) ; -- Returns the active flag for the package
 ; 1 the package can create visits
 ; 0 the package cannot create visits
 ; -1 called wrong or could not find package in VT parameters file
 Q $$PKGON^VSIT0($G(PKG))
 ;
IEN2VID(IEN) ; -- Call with Visit IEN and returns the Visit ID
 Q:'($D(^AUPNVSIT(+IEN,150))#2) -1
 Q $P(^AUPNVSIT(IEN,150),"^",1)
 ;
VID2IEN(VID) ; -- Call with Visit's ID and returns the Visit IEN
 N IEN
 S IEN=$O(^AUPNVSIT("VID",VID,0))
 Q $S(IEN]"":IEN,1:-1)
 ;
LOOKUP(IEN,FMT,WITHIEN) ; -- Lookup a visit and return all of its information
 ;DBIA #: 1906
 ;Parameters:
 ; IEN     is the IEN for the Visit OR the Visit's ID
 ; FMT  is the format that you want the output where
 ;          I ::= internal format
 ;          E ::= external format
 ;          B ::= both internal and external format
 ;        B is the default if FMT is anything other than "I" or "E"
 ; WITHIEN is 0 if you do not want the IEN of the VSIT( as the first
 ;         subscript and 1 if you do.  "1" is the default.
 ;
 ;Return:  -1 if IEN was not a valid IEN or Visit ID
 ;         otherwise returns IEN
 ;  VSIT(  an array VSIT(Visit IEN,field) or VSIT(field) depending
 ;         on the value of WITHIEN.  The array is all of the fields
 ;         in the visit file. If B(oth) internal and external format
 ;         are returned the format is:  internal^external.
 ;         If I(nternal) format is requested only the internal part
 ;         is returned.
 ;         If E(xternal) format is requested the format is: ^external
 ;         External values, if requested, are always returned in the
 ;         second pieces of the array elements.
 ;  
 Q:$G(IEN)']"" -1
 S:+IEN'=IEN IEN=$$VID2IEN(IEN) ;PX*1.0*118
 Q:'($D(^AUPNVSIT(+IEN,0))#2) -1
 S FMT=$G(FMT)
 S FMT=$S(FMT["B":"B",FMT["I":"I",FMT["E":"E",1:"B")
 S WITHIEN=$S($G(WITHIEN)=0:0,1:1)
 D ALL^VSITVAR(IEN,FMT,WITHIEN)
 Q IEN
 ;
SELECTED(DFN,SDT,EDT,HOSLOC,ENCTYPE,NENCTYPE,SERVCAT,NSERVCAT,LASTN) ;
 ;  -- Returns selected visits depending on screens passed in.
 D VSITAPI^VSITOE($G(DFN),$G(SDT),$G(EDT),$G(HOSLOC),$G(ENCTYPE),$G(NENCTYPE),$G(SERVCAT),$G(NSERVCAT),$G(LASTN))
 Q
 ;
HISTORIC(IEN) ;  -- Returns 1 if it is an Historical visit ("E" in #.07)
 ;                     0 if it is not an Historical visit.
 ;                    -1 if the IEN is bad
 Q $S('($D(^AUPNVSIT(IEN,0))#2):-1,1:$P($G(^AUPNVSIT(IEN,0)),"^",7)="E")
 ;
MODIFIED(IEN) ;Sets the Date Last Modified (.13) field to NOW
 ;
 N VSIT
 S VSIT("IEN")=IEN
 D UPD
 Q
 ;
