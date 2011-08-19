RGJCREC ;SF/JC,LTL-MPI/PD SUBSCRIPTION PROCESSOR ;05/12/98
 ;;1.0;CLINICAL INFO RESOURCE NETWORK;**1,8,19**;30 Apr 99
 ;
 ;Reference to $$UPDATE^MPIFAPI supported by IA #2706
 ;Reference to $$SEND2^VAFCUTL1 supported by IA #2779
 ;Reference to ^DPT( supported by IA #2969
 ;
REC ;Receive inbound MPI/PD Subscription request
 ;Read in message for file 774 Master File Update
 ;
 Q:($G(HL("MTN"))'="MFN")!($G(HL("ETN"))'="Z15")  ;only process MPI/PD MFN/Z15 messages
 K RGS,RGSEG,RGFS,RGCS,RGEC,RGSS,RGFILE,RGACT,RGCD,RGID,RGICN,RGSSN,RGPN,RGLL,RGTP,RGAD,RGTD,RGRAP,RGCMOR,RGDFN,RGPPFI,RGSCN,RGCURI,RGFROM,RGTO,RGSTUB,RGAD1,RGL,RGRC,HLER
 N RGLOG,RGMTXT,X D START^RGHLLOG(HLMTIEN,"SCN_REQ","")
 ;
 S RGS="",U="^" N J
 S RGFS=HL("FS") ;Field
 S RGCS=$E(HL("ECH"),1) ;Component
 S RGRC=$E(HL("ECH"),2) ;Repetition
 S RGEC=$E(HL("ECH"),3) ;Escape
 S RGSS=$E(HL("ECH"),4) ;Sub-component separator
 F RGI=1:1 X HLNEXT Q:HLQUIT'>0  S (RGSEG,RGS(RGI))=HLNODE D
 .S J=0 F  S J=$O(HLNODE(J)) Q:'J  S RGS(RGI,J)=HLNODE(J)
 .D PARS
 ;K RGLL ;TS 3-27-98
 ;D PARS add this to hl7 processing logic above
 I $D(RGFILE) Q:RGFILE'=774
 ;Pt DFN
 S RGDFN=$$GETDFN^MPIF001(+RGICN)
 I +$$SEND2^VAFCUTL1(RGDFN,"T") D CLEAN Q  ;don't process test patients
 ;Validate DFN/ICN/SSN on receiving system
 I RGDFN'>0 D  D CLEAN Q
 . S RGMTXT=""
 . D EXC^RGHLLOG(210,"Msg#"_$G(HL("MID"))_" Bad DFN, "_$G(RGDFN)_", for "_$G(RGPN)_" (ICN#"_$G(RGICN)_")"_RGMTXT,RGDFN) D STOP^RGHLLOG(1) Q
 I $P(^DPT(RGDFN,0),U,9)'=RGSSN D  D CLEAN Q
 . S RGMTXT=" See the Exception Handling document on the MPI/PD web site."
 . D EXC^RGHLLOG(213,"Msg#"_$G(HL("MID"))_" Mismatched SSN,"_$P(^DPT(RGDFN,0),U,9)_"/"_$G(RGSSN)_" for "_$G(RGPN)_" (ICN#"_$G(RGICN)_")"_RGMTXT,RGDFN) D STOP^RGHLLOG(1) Q
 ;Pt CMOR/Subscription Control Number
 S RGPPFI=$$GETVCCI^MPIF001(RGDFN)
 I +RGPPFI<1 D  D CLEAN Q
 . S RGMTXT=""
 . D EXC^RGHLLOG(211,"Msg#"_$G(HL("MID"))_" Bad CMOR "_$G(RGPPFI)_" for DFN#"_$G(RGDFN)_RGMTXT,RGDFN) D STOP^RGHLLOG(1) Q
 ;Verify that sender and receiver agree on CMOR
 I RGCMOR'=RGPPFI D  D CLEAN Q
 . S RGMTXT=""
 . D EXC^RGHLLOG(211,"Msg#"_$G(HL("MID"))_" Mismatched CMOR, "_$G(RGCMOR)_"/"_$G(RGPPFI)_" for "_$G(RGPN)_" (ICN#"_$G(RGICN)_")"_RGMTXT,RGDFN) D STOP^RGHLLOG(1) Q
 S RGSCN=$$GETSCN(RGDFN)
 I RGSCN="" D  D CLEAN Q
 . S RGMTXT=""
 . D EXC^RGHLLOG(228,"Msg#"_$G(HL("MPI"))_" "_$G(RGPN)_" Does not exist in patient database. "_RGMTXT,RGDFN) D STOP^RGHLLOG(1) Q
 ;Current Site ien
 S RGCURI=+$$SITE^VASITE()
 ;If not CMOR, don't update anyone else
 I $$IFVCCI^MPIF001(RGDFN)'=1 D FIL K RGLL Q  ;TS 3-27-98
 ;If filing data at owner site, que update to CLINICAL SUBSCRIBERS
 D REC1
 ;Add new clinical subscriber to local registry
 D FIL
 D REC2
CLEAN K RGSTUB,RGLL ;TS 3-27-98
 D STOP^RGHLLOG(0)
 K RGS,RGSEG,RGFS,RGCS,RGEC,RGSS,RGFILE,RGACT,RGCD,RGID,RGICN,RGSSN,RGPN,RGLL,RGTP,RGAD,RGTD,RGRAP,RGCMOR,RGDFN,RGPPFI,RGSCN,RGCURI,RGFROM,RGTO,RGSTUB,RGAD1,RGL,RGRC,RGI
 Q
REC1 ;Update clinical subscribers with newest one
 D GET^RGRSDYN1(RGDFN,RGSCN,0,"",.RGLL)
 N I S I=0 F  S I=$O(RGLL("LINKS",I)) Q:I<1  D
 .S RGFROM=RGLL ;New Subscriber
 .I $E(RGFROM,1,2)'="VA" D START^RGHLLOG(HLMTIEN,"SCN_REQ","") D EXC^RGHLLOG(224,"MSG#"_$G(HL("MID"))_" Unable to send Subscription Request from "_RGFROM_".  This is not a MPI/PD site.",RGDFN) D CLEAN Q
 .S RGTO=$P(RGLL("LINKS",I),U,2) ;Destination (Clinical Subscriber)
 .I $E(RGTO,1,2)'="VA" D START^RGHLLOG(HLMTIEN,"SCN_REQ","") D EXC^RGHLLOG(224,"MSG#"_$G(HL("MID"))_" Unable to send Subscription Request to "_RGTO_".  This is not a MPI/PD site.",RGDFN) D CLEAN Q
 .S RGSTUB=RGFROM_U_RGTO_U_RGICN_U_RGPN_U_RGTP_U_RGAD_U_$G(RGTD)
 .D:RGFROM'=RGTO EN^RGEQ("SCN_REQ",RGSTUB) ;put on Event Queue
 Q
REC2 ;Update newest subscriber with previous subscribers and CMOR
 ;change 4/10/98 CMC to get links
 K RGLL("LINKS")
 D GET^RGRSDYN1(RGDFN,RGSCN,0,"",.RGLL)
 S I=0 F  S I=$O(RGLL("LINKS",I)) Q:I<1  D
 .S RGTO=RGLL
 .I $E(RGTO,1,2)'="VA" D START^RGHLLOG(HLMTIEN,"SCN_REQ","") D EXC^RGHLLOG(224,"MSG#"_$G(HL("MID"))_" Unable to send Subscription Request to "_RGTO_".  This is not a MPI/PD site.",RGDFN) D CLEAN Q
 .S RGFROM=$P(RGLL("LINKS",I),U,2)
 .I $E(RGFROM,1,2)'="VA" D START^RGHLLOG(HLMTIEN,"SCN_REQ","") D EXC^RGHLLOG(224,"MSG#"_$G(HL("MID"))_" Unable to send Subscription Request from "_RGFROM_".  This is not a MPI/PD site.",RGDFN) D CLEAN Q
 .S RGSTUB=RGFROM_U_RGTO_U_RGICN_U_RGPN_U_RGTP_U_RGAD_U_$G(RGTD)
 .I RGTO'=RGFROM D EN^RGEQ("SCN_REQ",RGSTUB)
 ;Now send current institution (CMOR)
 K RGL
 D LINK^HLUTIL3(RGCURI,.RGL) S RGL=$O(RGL(0)) Q:RGL<1
 ;changed cmc 5/9/98
 S RGSTUB=RGL(RGL)_U_RGLL_U_RGICN_U_RGPN_U_RGTP_U_RGAD_U_$G(RGTD)
 D:RGL(RGL)'=RGLL EN^RGEQ("SCN_REQ",RGSTUB)
 K RGSTUB
 Q
PARS ;Parse it
 I $E(RGSEG,1,3)="MFI" D
 .S RGFILE=+$P(RGSEG,RGFS,2) ;File number
 I $E(RGSEG,1,3)="MFE" D
 .S RGACT=$P(RGSEG,RGFS,2) ;Action
 .S RGCD=$P(RGSEG,RGFS,4) ;creation date
 .S RGID=$P(RGSEG,RGFS,5) D  ;Primary Key
 ..S RGICN=+RGID,RGSSN=$P(RGID,RGSS,2),RGPN=$P(RGID,RGCS,2) ;ICN,Patient Name
 I $E(RGSEG,1,3)="ZSD" D
 .S RGLL=$P(RGSEG,RGFS,2) ;Link
 .S RGTP=$P(RGSEG,RGFS,3) ;Type
 .S RGAD=$P(RGSEG,RGFS,4) ;Activation Date
 .S RGTD=$P(RGSEG,RGFS,5) ;Termination Date
 .S RGRAP=$P(RGSEG,RGFS,6) ;Receiving Application
 .S RGCMOR=$P(RGSEG,RGFS,7) ;Coordinating Master of Record
 Q
GETSCN(RGDPT) ;Return existing SCN or Activate a new subscription for this patient
 ;RGDPT=PATIENT DFN
 N RGAR,RGAN
 ;get subscription control #
 S RGSCN=+$P($$MPINODE^MPIFAPI(RGDPT),"^",5)
 ;if no SCN, create new and update 991.05, then return result
 I 'RGSCN S RGSCN=$$ACT^HLSUB S RGAR(991.05)=RGSCN S RGAN=$$UPDATE^MPIFAPI(RGDPT,"RGAR") I RGAN=-1 S RGSCN=""
 Q RGSCN
FIL ;File message
 ;Normalize dates
 N RGCHK,RGTD1
 S RGAD1=$$DTHF^RGHLUT(RGAD)
 I $G(RGTD)]"" S RGTD1=$$DTHF^RGHLUT(RGTD)
 ;check to see if this subscriber is yourself
 D LINK^HLUTIL3(+$$SITE^VASITE,.RGCHK) Q:$O(RGCHK(0))=""  S RGCHK=RGCHK($O(RGCHK(0)))
 I $G(RGCHK)'=RGLL D UPD^HLSUB(RGSCN,RGLL,RGTP,RGAD1,$G(RGTD1),$G(RGRAP),.HLER)
 Q
GETINST(LINK) ;returns institution ien from logical link
 N DIC,X,Y
 I $G(LINK)="" Q 0
 S DIC=870,DIC(0)="EMQZ",X=LINK D ^DIC
 I Y=-1 Q Y
 Q $P(Y(0),"^",2)
