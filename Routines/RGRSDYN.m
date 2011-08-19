RGRSDYN ;ALB/RJS-BUILD DYNAMIC LINK LIST FOR A PATIENT ;03/21/97
 ;;1.0;CLINICAL INFO RESOURCE NETWORK;**4,8,17,23,26,27**;30 Apr 99
 ;
 ;Reference to $$SEND2^VAFCUTL1 supported by IA #2779
 ;
EN(CLIENT,CLASS) ;
 ;CLIENT=HL7 CLIENT PROTOCOL AT TARGET SYSTEM
 ;DATA CLASS (Opt.) = Pull from Subs. Registry ONLY
 ;For now, anything else is both DESCRIPTIVE AND CLINICAL
 S CLASS=$G(CLASS),CLIENT=$G(CLIENT)
 Q:CLIENT=""  ;No receiver
 N PPF,DFN,HERE,ICN,RGRS,PPFIEN
PARS ;Parse local outbound message
 N RGDC
 D INITIZE^RGRSUTIL,EN^RGRSPARS("RGRS")
 ;code to prevent both new and old messaging from being sent out until the old protocols are removed from VAFC ADT-A04/A08 SERVER
 I $G(RGRS("SENDING SITE"))=$P($$SITE^VASITE,"^",3) Q
 I $G(RGRS("SENDING SITE"))="" Q
 ;Get patients owner site
 S PPF=$G(RGRS("SITENUM"))\1 Q:PPF'>0
 S PPFIEN=$$LKUP^XUAF4(PPF)
 ;get ICN
 S ICN=$G(RGRS(991.01)) Q:$G(ICN)']""
 ;Get DFN
 S DFN=$$GETDFN^MPIF001(ICN) Q:$G(DFN)'>0
 Q:+$$SEND2^VAFCUTL1(DFN,"T")  ;quit if test patient
 Q:$$IFLOCAL^MPIF001(DFN)
 ;Where we're at
 S HERE=$P($$SITE^VASITE,"^",3)\1
NOTPPF ; if not ppf send only to ppf
 I PPF'=HERE D  Q
 . N PPFLINK,INDEX
 . D LINK^HLUTIL3(PPFIEN,.PPFLINK)
 . S INDEX=$O(PPFLINK(0))
 . I INDEX]"" S HLL("LINKS",1)=CLIENT_"^"_PPFLINK(INDEX)
ISPPF ;
 I PPF=HERE D  Q
 . N PARENT,INDEX,SUBCONTL,CHILDREN,INDEX1,NODE
 . S NODE=$$MPINODE^MPIFAPI(DFN)
 . S SUBCONTL=$P($G(NODE),"^",5)
 . ;Get subscribers, return updated HLL array
 . ;D GET^RGRSDYN1(DFN,SUBCONTL,+CLASS,CLIENT,.HLL)
 . D GETLINKS^RGRSDYN1(.HLL)
 . ;LAST MINUTE CHANGE MARILYN REQUESTED
 . ;Get MPI link from SITE PARAMETER (when non A01/A03 event, ADT
 . ;message) part of the DG*5.3*261/RG*1.0*4 bundle gjc@2/4/99
 . I '$$ADT0103() D
 . . N MPI S MPI=$$MPILINK^MPIFAPI() D
 . . . I $P($G(MPI),U)'=-1 S HLL("LINKS",9999999999)=CLIENT_"^"_MPI
 . . . I $P($G(MPI),U)=-1 D
 . . . . N RGLOG,RGMTXT
 . . . . D START^RGHLLOG(HLMTIEN,"","")
 . . . . S RGMTXT=""
 . . . . D EXC^RGHLLOG(224,"No MPI link identified in CIRN SITE PARAMETER file (#991.8)"_RGMTXT,$G(DFN))
 . . . . D STOP^RGHLLOG(0)
 ;
 ;the following was commented out because we're not updating all sites
 ;in the VISN anymore
 ;
 ;. ;Get owners PARENT
 ;. D PARENT^XUAF4("PARENT",PPF)
 ;. S INDEX=""
 ;. S INDEX=$O(PARENT("P",INDEX))
 ;. Q:INDEX']""
 ;. D LINK^HLUTIL3(INDEX,.CHILDREN)
 ;. S INDEX=$O(HLL("LINKS",9999999999999),-1)
 ;. Q:INDEX']""
 ;. S INDEX1=0
 ;. F  S INDEX1=$O(CHILDREN(INDEX1)) Q:INDEX1'>0  D
 ;. . S INDEX=INDEX+1
 ;. . S HLL("LINKS",INDEX)=CLIENT_"^"_CHILDREN(INDEX1)
 ;
ADT0103() ; check to see if this is an ADT message type with an
 ; event of A01 -or- A03.  If true, do not broadcast the message
 ; to the MPI.  Part of the DG*5.3*261/RG*1.0*4 bundle.  gjc@2/4/99
 S HL("MTN")=$G(HL("MTN")),HL("ETN")=$G(HL("ETN")) ; just in case
 Q $S(HL("MTN")="ADT"&(HL("ETN")="A01"!(HL("ETN")="A03")):1,1:0)
