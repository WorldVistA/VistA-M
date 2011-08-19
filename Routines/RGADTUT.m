RGADTUT ;HIRMFO/GJC-utility; determine pat. subscriptions (A01/A03) ;09/21/99
 ;;1.0;CLINICAL INFO RESOURCE NETWORK;**17**;30 Apr 99
 ;
 ; Integration Agreements (IAs) utilized in this application:
 ; #2270-call to HLSUB (ACT, GET & UPDATE)
 ; #2271-call to LINK^HLUTIL3
 ; #2541-call to $$KSP^XUPARAM
 ; #2706-call to $$UPDATE^MPIFAPI
 ; #2796-call to RGHLLOG (EXC, START & STOP)
 ; #2988-call to FILE^VAFCTFU
 ;
 ; Note: SHARE function is called from RGADT1 to determine if VistA HL7
 ; messages are to be built (is GENERATE^HLMA to be called?)
 ;
SHARE(RGZSTR) ; determine if the patient is shared:
 ; a) If shared, return one to RGADT1 and call GENERATE^HLMA
 ; b) If not shared and the host facility is the CMOR, update
 ;    host TFL record, do not call GENERATE^HLMA
 ; c) If not shared and the host facility is not the CMOR, add
 ;    the CMOR to the subscription list, return one to RGADT1
 ;    and call GENERATE^HLMA
 ;
 ; input=> RGZSTR-patient_dfn^date_last_treated^event_type
 ; yield=> 0 to prevent calling GENERATE^HLMA, else make the call
 ;
 ; note: 1) Event Type will equal A01 or A03.  This needs to be
 ;          converted a valid ADT/HL7 EVENT REASON (#391.72) entry.
 ;       2) RGSD101 & RGDG101 are assumed to have a global scope
 ;
 N HLDT,HLINKP,HLINKX,RGZCMOR,RGZDFN,RGZDT,RGZEVT,RGZFLG,RGZHLL,RGZMPI
 N RGZSF,RGZSUB
 S RGZDFN=$P(RGZSTR,"^"),RGZDT=$P(RGZSTR,"^",2),RGZEVT=$P(RGZSTR,"^",3)
 S RGZMPI=$$MPINODE^MPIFAPI(RGZDFN),RGZSF=$$KSP^XUPARAM("INST")
 ; note to myself: missing MPI node, update TFL & return 0
 ;I +RGZMPI=-1 D TFL Q 0 <= should never occur, RGADT1 checks for ICN
 S RGZCMOR=$P($G(RGZMPI),"^",3),RGZSUB=$P($G(RGZMPI),"^",5)
 D:RGZSUB GET^HLSUB(RGZSUB,0,,.RGZHLL) ; find shared sites
 S RGZFLG=+$O(RGZHLL("LINKS",$C(32)),-1)
 ; at this point if RGZFLG>0 yield RGZFLG, else evaluate the conditions
 ; listed above (b & c)
 I 'RGZFLG D  ; no shared sites, take action (RGZFLG may be reset)
 .I 'RGZCMOR D TFL Q  ;CMOR not found, subsequent conditions not met
 .;
 .;b) the host site is the CMOR, update local TFL record, quit
 .I RGZSF,(RGZSF=RGZCMOR) D TFL Q
 .;
 .;c) if we're not the CMOR, we'll add the CMOR to the subscription list
 .I RGZSF,(RGZSF'=RGZCMOR) D
 ..N RGZ774,RGZERR,RGZLL
 ..D LINK^HLUTIL3(RGZCMOR,.RGZLL)
 ..;log. link for CMOR missing, log exception, file data in TFL & quit
 ..I '$O(RGZLL(0)) D  Q
 ...D EXC("Cannot add CMOR (#4): "_RGZCMOR_", as a subscriber to: "_RGZSF_" (#4)")
 ...D TFL
 ...Q
 ..;found the CMOR's logical link, add the subscription
 ..S RGZLL=RGZLL($O(RGZLL(0))),RGZ774=$$ACT^HLSUB
 ..D UPD^HLSUB(RGZ774,RGZLL,1,"","","",.RGZERR)
 ..; if update errored: log exception, file data into TFL & quit
 ..I $O(RGZERR(0)) D  Q
 ...D EXC("Subscription add (#774) failed for DFN: "_RGZDFN_", subscriber: "_RGZLL)
 ...D TFL
 ...Q
 ..;subscription added, set flag (HL7 message can be generated)
 ..E  S RGZFLG=1
 ..;update the SUBSCRIPTION CONTROL NUMBER (#991.05) field, file #2
 ..K RGZERR N RGZARR
 ..S RGZARR(991.05)=RGZ774,RGZERR=$$UPDATE^MPIFAPI(RGZDFN,"RGZARR")
 ..;if error updating field, file an exception
 ..I +RGZERR=-1 D EXC("Subscription add (fld: 991.05, file: #2) failed for DFN: "_RGZDFN_", subscriber: "_RGZLL)
 ..Q
 .Q
 Q RGZFLG ;shared site(s) found/added? 0=no, else yes...
 ;
EXC(RGX) ; log an exception because:
 ;a) logical link not found for CMOR
 ;b) new subscription not added to Subscription Control (#774) file
 ;c) subscription control pointer not added to "MPI" node (fld: 991.05)
 ; input: RGX-exception text
 D START^RGHLLOG(),EXC^RGHLLOG(224,RGX,RGZDFN),STOP^RGHLLOG(0)
 Q
TFL ; update the Treating Facility List file on:
 ; an exception -or- no subscribers CMOR data missing -or-
 ; "MPI" node missing -or- no subscribers & host is the CMOR
 ; Note: RGZSF is global in scope
 N RGZEVR I RGZEVT="A01" S RGZEVR="A1"
 E  S RGZEVR=$S(($D(RGSD101))#2:"A3",1:"A2")
 D:RGZSF FILE^VAFCTFU(RGZDFN,RGZSF_"^"_RGZDT_"^"_RGZEVR,1)
 ;3rd param=1, do not involve the ADT/HL7 PIVOT (#391.71) file
 Q
