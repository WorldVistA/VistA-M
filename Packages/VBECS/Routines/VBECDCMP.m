VBECDCMP ;hoifo/gjc-print mapped data from VBECS MAPPING TABLE (#6005);Nov 21, 2002
 ;;5.2;LAB SERVICE;**335**;Sep 27, 1994;Build 5
 ;
 ;Medical Device #:
 ;Note: The food and Drug Administration classifies this software as a
 ;medical device.  As such, it may not be changed in any way.
 ;Modifications to this software may result in an adulterated medical
 ;device under 21CFR820, the use of which is considered to be a
 ;violation of US Federal Statutes.  Acquiring and implementing this
 ;software through the Freedom of Information Act requires the
 ;implementer to assume total responsibility for the software, and
 ;become a registered manufacturer of a medical device, subject to FDA
 ;regulations.
 ;
 ;Call to $$NEWERR^%ZTER is supported by IA: 1621
 ;Call to $$S^%ZTLOAD is supported by IA: 10063
 ;Call to $$EXTERNAL^DILFD is supported by IA: 2055
 ;Call to ^DIR is supported by IA: 10026
 ;Call to $$DT^XLFDT is supported by IA: 10103
 ;Call to $$FMTE^XLFDT is supported by IA: 10103
 ;Call to $$CJ^XLFSTR is supported by IA: 10104
 ;Call to EN^XUTMDEVQ is supported by IA: 1519
 ;Execution of ^%ZOSF("TEST") is supported by IA: 10096
 ;
EN ; entry point for data mapping report.  this is an evocable entry point
 ; for the option: VBEC PRINT SQL/VISTA MAPPINGS.
 ;
 I $S($D(DUZ)[0:1,$D(DUZ(0))[0:1,'DUZ:1,DUZ=.5:1,1:0) W !!?3,$C(7),"DUZ & DUZ(0) must be defined to an active user (not POSTMASTER) in order to",!?3,"proceed." Q
 ;
 ; initialize the error trap
 I $$NEWERR^%ZTER N $ETRAP,$ESTACK S $ETRAP="D ERR^VBECDCU1"
 E  S X="D ERR^VBECDCU1",@^%ZOSF("TRAP")
 ;
RPT6005 ; Select the mapped VistA attribute you wish to examine. 
 K DIR S DIR(0)="S^AA:Antigen/Antibody;TR:Transfusion Reaction",DIR("A")="Select mapped data attribute to display"
 S DIR("?",1)="Enter 'AA' for Antibodies and Antigens (Vista File: Function Field #61.3)"
 S DIR("?",2)="Enter 'TR' for Transfusion Reaction (VistA File: Blood Bank Utility"
 S DIR("?")="#65.4)" D ^DIR
 I $D(DIRUT) D EXIT Q
 S VBECFILE=$S(Y="AA":61.3,1:65.4),VBECATT=Y(0)
 ;
 ; check to see that data exists in the VBECS MAPPING TABLE (#6005) 
 ; file for the attribute selected.
 I $O(^VBEC(6005,"B",$S(VBECFILE'=66.01:VBECFILE_"-",1:VBECFILE)))="" D  Q
 .W !!,"There is no "_VBECATT_" data in the VBECS MAPPING TABLE (#6005)"
 .W !,"file to be printed.",$C(7)
 .Q
 ;
 S VBECR="GO6005^VBECDCMP"
 F I="DUZ","VBECFILE","VBECATT" S VBECS(I)=""
 K I S VBECD="VBECS display current data mapping relationships"
 S VBECZ="MQ" D EN^XUTMDEVQ(VBECR,VBECD,.VBECS,,1)
 I +$G(ZTSK)>0 W !!,"Task Number: "_ZTSK,!
 ;
EXIT ;clean up the symbol table; exit the utility
 K DIR,DIROUT,DIRUT,DTOUT,DUOUT,POP,VBECATT,VBECFIEN,VBECIEN,VBECD,VBECFILE,VBECR,VBECS,VBECY,VBECZ,X,Y,ZTSK
 Q
 ;
GO6005 ; print mapping data information from the VBECS MAPPING TABLE (#6005)
 ; file.
 Q:'$G(VBECFILE)  S:$D(ZTQUEUED) ZTREQ="@"
 ;
 S PAGE=1,$P(LINE,"-",(IOM+1))="",TODAY=$$FMTE^XLFDT($$DT^XLFDT(),"1P")
 S (VBECXIT,VBECSTOP)=0,VBECGUID="" D HDR
 F  S VBECGUID=$O(^VBEC(6005,"AB",VBECFILE,VBECGUID)) Q:VBECGUID=""  D  Q:VBECXIT!(VBECSTOP)
 .S VBECIEN=0
 .F  S VBECIEN=$O(^VBEC(6005,"AB",VBECFILE,VBECGUID,VBECIEN)) Q:'VBECIEN  D  Q:VBECXIT!(VBECSTOP)
 ..S VBECY(0)=$G(^VBEC(6005,VBECIEN,0))
 ..S VBECFIEN=$P(VBECY(0),U),VBECNAME=$P(VBECY(0),U,2)
 ..S VBECNME=$P($G(^VBEC(6007,VBECGUID,0)),U)
 ..S VBECANTI=$$EXTERNAL^DILFD(6005,.04,,$P(VBECY(0),U,4))
 ..I $$S^%ZTLOAD() S (ZTSTOP,VBECSTOP)=1 Q
 ..W !!,"VistA FileMan File: "_$P(VBECFIEN,"-")
 ..W:$P(VBECFIEN,"-",2) !,"VistA FileMan IEN: "_$P(VBECFIEN,"-",2)
 ..W !,"Standard Record Name: "_VBECNME
 ..I $Y>(IOSL-4) D EOS Q:VBECXIT
 ..W !,"VistA Record Name : "_VBECNAME
 ..W:VBECANTI'="" !,"Antigen/Antibody  : "_VBECANTI
 ..I $Y>(IOSL-4) D EOS
 ..Q
 .Q
 W:$G(VBECFIEN)="" !,$$CJ^XLFSTR("*** No Records To Print ***",IOM)
 ;
 K LINE,PAGE,POP,TODAY,VBEC01,VBECANTI,VBECIEN,VBECGUID,VBECNAME,VBECNME,VBECXIT,VBECSTOP
 Q
 ;
EOS ; end of screen (eos) check & refresh screen action
 ; check to see if additional data exist to print, if not exit w/o
 ; issuing the eos prompt.
 ;
 I $E(IOST)="C" K DIR S DIR(0)="E" D ^DIR S VBECXIT=$S(Y'>0:1,1:0)
 K DIR,X,Y Q:VBECXIT
HDR ; draw header
 W:($E(IOST)="C")!(PAGE>1) @IOF
 W !,$$CJ^XLFSTR("VistA Data Mapped To Standard SQL Server Attributes",IOM)
 W !,"Date: ",TODAY,?69,"Page: ",PAGE,!,LINE
 S PAGE=PAGE+1,HEADER="Attribute being mapped: "_VBECATT
 W !,$$CJ^XLFSTR(HEADER,IOM) K HEADER
 Q
 ;
