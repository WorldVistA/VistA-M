PXRMXD ; SLC/PJH - Reminder Due reports DRIVER ;07/30/2009
 ;;2.0;CLINICAL REMINDERS;**4,6,12**;Feb 04, 2005;Build 73
 ;
START ; Arrays and strings
 N PX,PXRMDEV,PXRMHFIO,PXRMIOP,PXRMXST,PXRMOPT,PXRMQUE,PXRMXTMP,PXRMSEL
 N PXRMFAC,PXRMFACN,PXRMSCAT,PXRMSRT,PXRMTYP
 N REMINDER,PXRMINP,PXRMFCMB,PXRMLCMB,PXRMTCMB,PXRMTOT
 ; Addenda
 N PXRMOTM,PXRMPAT,PXRMPCM,PXRMPRV,PXRMTMP,PXRMRCAT,PXRMREM
 N PXRMCS,PXRMCSN,PXRMLOCN,PXRMLCHL,PXRMLCSC,PXRMCGRP,PXRMCGRN
 N PXRMLIS
 ; Counters
 N NCAT,NFAC,NLOC,NPAT,NPCM,NOTM,NPRV,NREM,NCS,NHL,NCGRP
 ; Flags and Dates
 N PXRMFD,PXRMSDT,PXRMBDT,PXRMEDT,PXRMREP,PXRMPRIM,PXRMFUT,PXRMDLOC
 N PXRMRT,PXRMSSN,PXRMTABC,PXRMTABS,PXRMTMP,TITLE,VALUE
 N DBDOWN,DBDUZ,DBERR,PXRMLIST,PXRMLIS1,Y
 N PLISTPUG
 N PXRMTPAT,PXRMDPAT,PXRMPML,PXRMPER,PXRMCCS,PXRMXCCS,PXRMOWN
 ;
 S PXRMRT="PXRMX",PXRMTYP="X",PXRMFCMB="N",PXRMLCMB="N",PXRMTCMB="N"
 S PXRMCCS=""
 ;
 I '$D(PXRMUSER) N PXRMUSER S PXRMUSER=0
 ;
 ;Guarantee the timestamp is unique.
 H 1
 S PXRMXST=$$NOW^XLFDT
 S PXRMXTMP=PXRMRT_PXRMXST
 S PXRMXCCS=PXRMRT_"SEPCLINIC"_PXRMXST
 S ^XTMP(PXRMXTMP,0)=$$FMADD^XLFDT(DT,7)_U_DT_U_"PXRM Reminder Due Report"
 S ^XTMP(PXRMXCCS,0)=$$FMADD^XLFDT(DT,7)_U_DT_U_"PXRM Reminder Due Report Seperate Clinic Stop"
 ;
 ;Check for existing report templates
REP ;
 S PXRMINP=0
 D:PXRMUSER ^PXRMXTB D:'PXRMUSER ^PXRMXT I $D(DTOUT)!$D(DUOUT) G EXIT
 ;Run report from template details
 I PXRMTMP'="" D  G:$D(DUOUT)&'$D(DTOUT) REP Q
 .D START^PXRMXTA("JOB^PXRMXQUE") K DUOUT,DIRUT,DTOUT
 ;
 ;Select sample criteria
SEL ;
 D SELECT^PXRMXSD(.PXRMSEL) I $D(DTOUT) G EXIT
 I $D(DUOUT) G:PXRMTMP="" EXIT G REP
 ;
FAC ;Get the facility list.
 I "IRPO"'[PXRMSEL D  G:$D(DTOUT) EXIT G:$D(DUOUT) SEL
 .D FACILITY^PXRMXSU(.PXRMFAC) Q:$D(DTOUT)!$D(DUOUT)
 ;
 ;Check if combined facility report is required
COMB I "IRPO"'[PXRMSEL,NFAC>1 D  G:$D(DTOUT) EXIT G:$D(DUOUT) FAC
 .D COMB^PXRMXSD(.PXRMFCMB,"Facilities","N")
 ;
OPT ;Variable prompts
 ;
 ;Get Individual Patient list
 I PXRMSEL="I" K PXRMPAT D PAT^PXRMXSU(.PXRMPAT)
 ;Get Patient list #810.5
 I PXRMSEL="R" K PXRMLIST D LIST^PXRMXSU(.PXRMLIST)
 ;Get OE/RRteam list
 I PXRMSEL="O" K PXRMOTM D OERR^PXRMXSU(.PXRMOTM)
 ;Get PCMM team
 I PXRMSEL="T" K PXRMPCM D PCMM^PXRMXSU(.PXRMPCM)
 ;Get provider list
 I PXRMSEL="P" K PXRMPRV D PROV^PXRMXSU(.PXRMPRV)
 ;Get the location list.
 I PXRMSEL="L" K PXRMCS,PXRMCSN,PXRMLOCN,PXRMLCHL,PXRMCGRP,PXRMCGRN D
 .D LOC^PXRMXSU("Determine encounter counts for","HS")
 I $D(DTOUT) G EXIT
 I $D(DUOUT) G:"IRPO"[PXRMSEL SEL G:NFAC>1 COMB G FAC
 ;
 ;Check if inpatient location report
 S PXRMINP=$$INP
 ;
 ; Primary Provider or All (PCMM Provider only)
PRIME ;
 I PXRMSEL="P" D  G:$D(DTOUT) EXIT G:$D(DUOUT) OPT
 .D PRIME^PXRMXSD(.PXRMPRIM)
 ;
DR ; Get the date range.
 S PXRMFD="P"
 ; No prompt if individual patients selected
 ; Single dates only if PCMM teams/providers and OE/RR teams selected
 ; Choice of previous/future date range if location selected
 ;
 ; Prior encounters/future appointments (location only)
PREV I PXRMSEL="L" D PREV^PXRMXSD(.PXRMFD) G:$D(DTOUT) EXIT G:$D(DUOUT) OPT
 ; Date range input (location only)
 I PXRMSEL="L" D  G:$D(DTOUT) EXIT G:$D(DUOUT) PREV
 .I PXRMFD="P" D PDR^PXRMXDUT(.PXRMBDT,.PXRMEDT,"ENCOUNTER")
 .I PXRMFD="F" D FDR^PXRMXDUT(.PXRMBDT,.PXRMEDT,"APPOINTMENT")
 .I PXRMFD="A" D PDR^PXRMXDUT(.PXRMBDT,.PXRMEDT,"ADMISSION")
 .I PXRMFD="C" S PXRMBDT=DT,PXRMEDT=DT
 ; Due Effective Date
DUE D SDR^PXRMXDUT(.PXRMSDT) G:$D(DTOUT) EXIT
 I $D(DUOUT) G:PXRMSEL="L" PREV G OPT
 ;
SCAT ;Get the service categories.
 I PXRMSEL="L",PXRMFD="P" D
 .D SCAT^PXRMXSC
 .I $D(DTOUT)!$D(DUOUT) Q
 I $D(DTOUT) G EXIT
 I $D(DUOUT) G DUE
 ;
TYP ;Determine type of report (detail/summary)
 S PXRMREP="S"
 D REP^PXRMXSD(.PXRMREP) I $D(DTOUT) G EXIT
 I $D(DUOUT) G SCAT
 ;
 ;Check if combined location report is required
LCOMB S NLOC=0
 I PXRMREP="D",PXRMSEL="L" D  G:$D(DTOUT) EXIT G:$D(DUOUT) TYP
 .N DEFAULT,TEXT
 .D NLOC
 .I NLOC>1 D COMB^PXRMXSD(.PXRMLCMB,TEXT,DEFAULT)
 ;
 ;Check if combined OE/RR team report is required
TCOMB I PXRMREP="D",PXRMSEL="O",$G(NOTM)>1 D  G:$D(DTOUT) EXIT G:$D(DUOUT) TYP
 .N DEFAULT,TEXT
 .S DEFAULT="N",TEXT="OE/RR teams"
 .D COMB^PXRMXSD(.PXRMTCMB,TEXT,DEFAULT)
 ;
FUT ;For detailed report give option to display future appointments
 S PXRMFUT="N"
 I PXRMREP="D",'PXRMINP D  G:$D(DTOUT) EXIT I $D(DUOUT) G:(PXRMSEL="L")&(NLOC>1) LCOMB G:(PXRMSEL="O")&($G(NOTM)>1) TCOMB G TYP
 .D FUTURE^PXRMXSD(.PXRMFUT,"Display All Future Appointments: ",5)
 .I PXRMFUT="Y" D  Q:$D(DTOUT)!$D(DUOUT)
 ..D FUTURE^PXRMXSD(.PXRMDLOC,"Display Appointment Location: ",15)
 ;
SRT ;For detailed report give option to sort by appointment date
 S PXRMSRT="N"
 I PXRMREP="D",("RI"'[PXRMSEL) D  G:$D(DTOUT) EXIT I $D(DUOUT) G:(PXRMSEL="L")&(PXRMINP)&(NLOC>1) LCOMB G:PXRMINP TYP G:(PXRMSEL="O")&($G(NOTM)>1) TCOMB G FUT
 .;Option to sort by Bed for inpatients
 .I PXRMSEL="L",PXRMINP D BED^PXRMXSD(.PXRMSRT) Q
 .;Otherwise option to sort by appt. date
 .D SRT^PXRMXSD(.PXRMSRT)
 ;
 ;Option to print full SSN
SSN I PXRMREP="D" D  G:$D(DTOUT) EXIT I $D(DUOUT) G:"IR"[PXRMSEL FUT G SRT
 .D SSN^PXRMXSD(.PXRMSSN)
 ;
 ;Option to print without totals, with totals or totals only
TOT I PXRMREP="S" D  G:$D(DTOUT) EXIT I $D(DUOUT) G TYP
 .;Default is normal report
 .S PXRMTOT="I"
 .;Ignore patient and patient list reports
 .I "RI"[PXRMSEL Q
 .;Only prompt if more than one location, team or provider is selected
 .I PXRMSEL="P",NPRV<2 Q
 .I "OT"[PXRMSEL,NOTM<2 Q
 .;Ignore reports for all locations
 .I PXRMSEL="L",PXRMLCMB="Y" Q
 .I PXRMSEL="L" N DEFAULT,TEXT D NLOC Q:NLOC<2
 .;Prompt for options
 .N LIT1,LIT2,LIT3
 .D LIT,TOTALS^PXRMXSD(.PXRMTOT,LIT1,LIT2,LIT3)
 ;
SEPCS ;Allow users to determine the output of the Clinic Stops report
 D SEPCS^PXRMXSD(.PXRMCCS) G:$D(DTOUT) EXIT I $D(DUOUT) G:PXRMREP="D" SSN G TOT
 ;
MLOC ;Print Locations empty location at the end of the report
 W !
 S DIR(0)="Y",DIR("B")="YES",DIR("A")="Print locations with no patients"
 D ^DIR
 I Y="^^" G EXIT
 I Y=U G:$P(PXRMLCSC,U)="CS" SEPCS G:PXRMREP="D" SSN G TOT
 S PXRMPML=Y
 ;
DPER ;Print percentage with the report outut
 W !
 S DIR(0)="Y",DIR("B")="NO"
 S DIR("A")="Print percentages with the report output"
 D ^DIR
 I Y="^^" G EXIT
 I Y=U G MLOC
 S PXRMPER=Y
 ;
 ;Reminder Category/Individual Reminder Selection
RCAT ;
 D RCAT^PXRMXSU(.PXRMRCAT,.PXRMREM) I $D(DTOUT) G EXIT
 ;I $D(DUOUT) G:PXRMREP="D" SSN G TOT
 I $D(DUOUT) G MLOC
 ;
 ;Create combined reminder list
 D MERGE^PXRMXS1
 ;
SAV ;Option to create a new report template
 I PXRMTMP="" D ^PXRMXTU G:$D(DTOUT) EXIT I $D(DUOUT) G RCAT
 ;
 ;Option to print delimiter separated output
TABS D  G:$D(DTOUT) EXIT I $D(DUOUT) G SAV
 .D TABS^PXRMXSD(.PXRMTABS)
 ;Select chracter
TCHAR I PXRMTABS="Y" D  G:$D(DTOUT) EXIT G:$D(DUOUT) TABS
 .S PXRMTABC=$$DELIMSEL^PXRMXSD
 ;
DPAT ;Ask whether to include deceased and test patients.
 S PXRMDPAT=$$ASKYN^PXRMEUT("N","Include deceased patients on the list")
 N PXRMIDOD I PXRMDPAT>0 S PXRMIDOD=1
 Q:$D(DTOUT)  G:$D(DUOUT) TABS
TPAT ;
 S PXRMTPAT=$$ASKYN^PXRMEUT("N","Include test patients on the list")
 Q:$D(DTOUT)  G:$D(DUOUT) DPAT
PATLIST ;
 K PATCREAT
 N PATLST
 I PXRMSEL'="I"&(PXRMUSER'="Y") D
 . D ASK(.PATLST,"Save due patients to a patient list: ",3)
 . I $G(PATLST)="" Q
 . I $G(PATLST)="N" S PXRMLIS1="" Q
 . I $G(PATLST)="Y" D
 ..S PATCREAT="N"
 ..D ASK(.PATCREAT,"Secure list?: ",3) I $D(DTOUT)!($D(DUOUT)) Q
 ..K PLISTPUG
 ..S PLISTPUG="N" D ASK^PXRMXD(.PLISTPUG,"Purge Patient List after 5 years?: ",5)
 I $G(PATLST)="" G:$D(DTOUT) EXIT I $D(DUOUT) G TPAT
 G:$D(DTOUT) EXIT I $D(DUOUT) G PATLIST
 I $G(PATLST)="Y" S TEXT="Select PATIENT LIST name: " D PLIST^PXRMLCR(.PXRMLIS1,TEXT,"") Q:$D(DUOUT)!$D(DTOUT)
 ;Determine whether the report should be queued.
JOB ;
 D JOB^PXRMXQUE
 Q
 ;
 ;Option PXRM REMINDERS DUE (USER)
USER N PXRMUSER
 S PXRMUSER=+$G(DUZ)
 G START
 ;
 ;
EXIT ;Clean things up.
 D EXIT^PXRMXGUT
 Q
 ;
 ;Check if inpatient report
INP() ;Applies to location reports only
 I PXRMSEL'="L" Q 0
 ;For all inpatient locations default is automatic
 I $P(PXRMLCSC,U)="HAI" Q 1
 ;For selected locations check if all locations are wards
 I $P(PXRMLCSC,U)="HS" Q $$INP^PXRMXAP(PXRMLCSC,.PXRMLOCN)
 ;Otherwise
 Q 0
 ;
 ;Prompt text
LIT N LIT
 S LIT=$S(PXRMSEL="P":"Provider","OT"[PXRMSEL:"Team",1:"Location")
 I PXRMFCMB="N" D
 .S LIT1="Individual "_LIT_"s only"
 .S LIT2="Individual "_LIT_"s plus Totals by Facility"
 .S LIT3="Totals by Facility only"
 I PXRMFCMB="Y" D
 .S LIT1="Individual "_LIT_"s only"
 .S LIT2="Individual "_LIT_"s plus Overall Total"
 .S LIT3="Overall Total only"
 Q
 ;
 ;Check if multiple locations
NLOC S DEFAULT="N",NLOC=1,TEXT="Locations"
 I $P(PXRMLCSC,U)["HA" S DEFAULT="Y",NLOC=999
 I $P(PXRMLCSC,U)="CA" S DEFAULT="Y",NCS=999
 I $E(PXRMLCSC)="C" S TEXT="Clinic Stops",NLOC=NCS
 I $E(PXRMLCSC)="G" S TEXT="Clinic Groups",NLOC=NCGRP
 I $P(PXRMLCSC,U)="HS" S NLOC=NHL S:$$INP TEXT="Inpatient Locations"
 ;Special coding if more than one facility and location
 I $P(PXRMLCSC,U)="HS",NFAC>1,NLOC>1 D
 .N FAC,HLOCIEN,HLNAME,IC,MULT
 .S IC=0 S:PXRMFCMB="Y" FAC="COMBINED"
 .;Build list of locations by facility
 .F  S IC=$O(PXRMLCHL(IC)) Q:'IC  D
 ..S HLOCIEN=$P(PXRMLCHL(IC),U,2),FAC=$$FACL^PXRMXAP(HLOCIEN) Q:'FAC
 ..S HLNAME=$P(PXRMLCHL(IC),U) Q:HLNAME=""
 ..S MULT(FAC,HLNAME)=""
 .S MULT=0,FAC=0
 .;Count locations in each facility
 .F  S FAC=$O(MULT(FAC)) Q:'FAC  D  Q:MULT
 ..S IC=0,HLNAME=""
 ..F  S HLNAME=$O(MULT(FAC,HLNAME)) Q:HLNAME=""  S IC=IC+1
 ..I IC>1 S MULT=1
 .;If only one location per facility suppress combined location option
 .I 'MULT S NLOC=1
 Q
 ;
ASK(YESNO,PROMPT,NUM)      ;
 N X,Y,TEXT
 K DIROUT,DIRUT,DTOUT,DUOUT
 S DIR(0)="YA0"
 S DIR("A")=PROMPT
 S DIR("B")="N"
 S DIR("?")="Enter Y or N. For detailed help type ??"
 S DIR("??")=U_"D HELP^PXRMLCR("_NUM_")"
 W !
 D ^DIR K DIR
 I $D(DIROUT) S DTOUT=1
 I $D(DTOUT)!($D(DUOUT)) Q
 S YESNO=$E(Y(0))
 Q
 ;
