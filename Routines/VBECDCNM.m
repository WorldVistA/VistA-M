VBECDCNM ;hoifo/gjc-print unmapped data from 61.3 or 65.4;Nov 21, 2002
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
EN ; entry point for unmapped data report.  this is an evocable entry point
 ; for the option: ???.
 ;
 I $S($D(DUZ)[0:1,$D(DUZ(0))[0:1,'DUZ:1,DUZ=.5:1,1:0) W !!?3,$C(7),"DUZ & DUZ(0) must be defined to an active user (not POSTMASTER) in order to",!?3,"proceed." Q
 ;
RPT6005 ; Select the unmapped VistA attribute you wish to examine. 
 ;
 ; initialize the error trap code
 I $$NEWERR^%ZTER N $ETRAP,$ESTACK S $ETRAP="D ERR^VBECDCU1"
 E  S X="D ERR^VBECDCU1",@^%ZOSF("TRAP")
 ;
 S VBECS=$$ATTR^VBECDCU1() ; select data attribute family
 I VBECS="^" D EXIT Q
 S VBECFILE=$P(VBECS,U),VBECATT=$P(VBECS,U,2)
 ;
 K VBECS S VBECR="GO^VBECDCNM"
 F I="DUZ","VBECFILE","VBECATT" S VBECS(I)=""
 K I S VBECD="VBECS display currently unmapped VistA Blood bank data"
 S VBECZ="MQ" D EN^XUTMDEVQ(VBECR,VBECD,.VBECS,,1)
 I +$G(ZTSK)>0 W !!,"Task Number: "_ZTSK,!
 ;
EXIT ;clean up the symbol table; exit the utility
 K DIR,DIROUT,DIRUT,DTOUT,DUOUT,POP,VBECATT,VBECIEN,VBECD,VBECFILE,VBECR,VBECS,VBECZ,X,Y,ZTSK
 Q
 ;
GO ; print unmapped data from file: 61.3 or 65.4
 ;
 ;Note: VBECFILE will either be 61.3 or 65.4
 Q:'$G(VBECFILE)  S:$D(ZTQUEUED) ZTREQ="@"
 ;
 S PAGE=1,$P(LINE,"-",(IOM+1))="",TODAY=$$FMTE^XLFDT($$DT^XLFDT(),"1P")
 D HDR S (VBECXIT,VBECSTOP)=0 S VBEC02=""
 F  S VBEC02=$O(^VBEC(6005,"N",VBEC02)) Q:VBEC02=""  D  Q:VBECXIT!(VBECSTOP)
 .S VBECIEN=0
 .F  S VBECIEN=$O(^VBEC(6005,"N",VBEC02,VBECIEN)) Q:'VBECIEN  D  Q:VBECXIT!(VBECSTOP)
 ..S VBECY(0)=$G(^VBEC(6005,VBECIEN,0))
 ..Q:+$P(VBECY(0),U)'=VBECFILE  ;sorting by file, printing by alpha
 ..Q:$P(VBECY(0),U,5)'=""  ;GUID chk
 ..S VBECFIEN=$P(VBECY(0),U),VBECNAME=$P(VBECY(0),U,2)
 ..S VBECANTI=$$EXTERNAL^DILFD(6005,.04,,$P(VBECY(0),U,4))
 ..I $$S^%ZTLOAD() S (ZTSTOP,VBECSTOP)=1 Q
 ..;
 ..W !,VBECNAME W:VBECFILE=61.3 ?34,VBECANTI W:VBECFILE=66 ?44,$P(VBECY(0),U,3)
 ..I $Y>(IOSL-4) D EOS
 ..Q
 .Q
 ;
 W:$G(VBECFIEN)="" !,$$CJ^XLFSTR("*** No Records To Print ***",IOM)
 K LINE,PAGE,POP,TODAY,VBEC02,VBECANTI,VBECFIEN,VBECIEN,VBECNAME,VBECXIT,VBECY,VBECSTOP
 Q
 ;
EOS ; end of screen (eos) check & refresh screen action
 ; check to see if additional data, for this particular file,
 ; exists to print, if not exit w/o issuing the eos prompt.
 ;
 Q:$O(^VBEC(6005,"B",VBECFIEN))=""
 ;
 I $E(IOST)="C" K DIR S DIR(0)="E" D ^DIR S VBECXIT=$S(Y'>0:1,1:0)
 K DIR,X,Y Q:VBECXIT
HDR ; draw header
 W:($E(IOST)="C")!(PAGE>1) @IOF
 W !,$$CJ^XLFSTR("VistA Data Not Mapped To Standard SQL Server Attributes",80)
 W !,"Date: ",TODAY,?69,"Page: ",PAGE
 W:VBECFILE=61.3 !,"Antigen/Antibody",?34,"Identifier"
 I VBECFILE=65.4 W !,"Transfusion Reaction"
 W:VBECFILE=66 !,"Blood Product",?44,"Blood Product Code"
 W:VBECFILE=66.01 !,"Supplier"
 W !,LINE S PAGE=PAGE+1
 Q
 ;
