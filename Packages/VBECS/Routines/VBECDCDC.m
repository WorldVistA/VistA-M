VBECDCDC ;hoifo/gjc-display data conversion statistics;Nov 21, 2002
 ;;2.0;VBEC;;Jun 05, 2015;Build 4
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
 ;Call to $$FMTE^XLFDT is supported by IA: 10103
 ;Call to $$CJ^XLFSTR is supported by IA: 10104
 ;Call to EN^XUTMDEVQ is supported by IA: 1519
 ;Call to ^DIC is supported by IA: 10006
 ;Call to $$DT^XLFDT is supported by IA: 10103
 ;
EN ;entry point for data conversion report.  this is an evocable entry
 ;point for the option: VBEC PRINT SQL/VISTA MAPPINGS.
 ;
 I $S($D(DUZ)[0:1,$D(DUZ(0))[0:1,'DUZ:1,DUZ=.5:1,1:0) W !!?3,$C(7),"DUZ & DUZ(0) must be defined to an active user (not POSTMASTER) in order to",!?3,"proceed." Q
 ;
 ; initialize the error trap
 I $$NEWERR^%ZTER N $ETRAP,$ESTACK S $ETRAP="D ERR^VBECDCU1"
 E  S X="D ERR^VBECDCU1",@^%ZOSF("TRAP")
 ;
 S DIC="^VBEC(6001,",DIC(0)="QEANZ",DIC("A")="Select the data conversion event date/time: ",DIC("S")="I $P(^(0),""^"",2)" D ^DIC
 I $D(DTOUT)#2!($D(DUOUT)#2)!(+Y'>0) K DIC,DTOUT,DUOUT,X,Y Q
 S VBECIEN=+Y ;data conversion record ien
 S VBECY0=Y(0),VBECY00=Y(0,0)
 K DIC,X,Y
 ;
 S DIR(0)="S^B:Both Individual & Summary;I:Individual Records;S:Summary"
 S DIR("A")="Enter Data Conversion statistics report type",DIR("B")="Summary"
 S DIR("?",1)="Enter 'B' to obtain both individual and overall data element counts"
 S DIR("?",2)="Enter 'I' to obtain individual data element counts"
 S DIR("?",3)="Enter 'S' to obtain overall data element counts"
 S DIR("?")="Enter '^' to stop." D ^DIR K DIR
 I $D(DIRUT) K DIROUT,DIRUT,DTOUT,DUOUT,X,Y D KILL Q
 S VBECTY=Y ;'B' for both, 'S' for summary only, 'I' for individual recs
 ;
 K DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 ;
 S VBECR="START^VBECDCDC"
 F I="VBECIEN","VBECTY","VBECY0","VBECY00" S VBECS(I)=""
 K I S VBECD="VBECS display current data conversion statistics"
 S VBECZ="MQ" D EN^XUTMDEVQ(VBECR,VBECD,.VBECS,,1)
 I +$G(ZTSK)>0 W !!,"Task Number: "_ZTSK,!
 ;
KILL ;clean up symbol table, exit
 K VBECD,VBECIEN,VBECR,VBECTY,VBECY0,VBECY00,VBECZ
 Q
 ;
START ;start the process of displaying how many specific data elements were
 ;FTP'ed by the SQL Server process for the VBECS data conversion
 ;
 S:$D(ZTQUEUED) ZTREQ="@" S:U'="^" U="^"
 K ^TMP("VBEC TOTALS",$J) S $P(^TMP("VBEC TOTALS",$J),"0^",28)=""
 S VBECPG=1,$P(VBECLN,"-",(IOM+1))="",VBECTDAY=$$FMTE^XLFDT($$DT^XLFDT(),"1P")
 S VBECDCFN=$$FMTE^XLFDT($E($P(VBECY0,U,3),1,12),1)
 S VBECUSER=$$EXTERNAL^DILFD(6001,.04,,$P(VBECY0,U,4))
 S (VBECIEN1,VBECNT,VBECXIT)=0 D HDR
 F  S VBECIEN1=$O(^VBEC(6001,VBECIEN,"TOT",VBECIEN1)) Q:VBECIEN1'>0  D  Q:VBECXIT
 .S VBEC0=$G(^VBEC(6001,VBECIEN,"TOT",VBECIEN1,0)) Q:VBEC0=""
 .S VBECNT=VBECNT+1
 .I VBECNT#500=0 I $$S^%ZTLOAD() S (ZTSTOP,VBECXIT)=1 Q:VBECXIT
 .D:VBECTY'="S" PRINT(VBEC0) Q:VBECXIT
 .F VBECI=1:1:27 D
 ..S:VBECI'>2 $P(^TMP("VBEC TOTALS",$J),U,VBECI)=$P(^TMP("VBEC TOTALS",$J),U,VBECI)+1
 ..S:VBECI>2 $P(^TMP("VBEC TOTALS",$J),U,VBECI)=$P(^TMP("VBEC TOTALS",$J),U,VBECI)+$P(VBEC0,U,VBECI)
 ..Q
 .Q
 W:'VBECNT !,$$CJ^XLFSTR("*** No Records To Print ***",IOM)
 I VBECNT,(VBECTY'="I") D
 .W:VBECTY="B" ! ;need the additional line feed to separate data
 .W !,$$CJ^XLFSTR("Total number of data elements converted",IOM)
 .D PRINT(^TMP("VBEC TOTALS",$J))
 .Q
 ;
EXIT ;kill and quit
 K VBEC0,VBECD,VBECDCFN,VBECFLD,VBECI,VBECIEN,VBECIEN1,VBECLN,VBECNT,VBECPG,VBECR,VBECTDAY,VBECUSER,VBECXIT,VBECZ
 K ^TMP("VBEC TOTALS",$J)
 Q
 ;
EOS ; end of screen (eos) check & refresh screen action
 ; check to see if additional data exist to print, if not exit w/o
 ; issuing the eos prompt.
 ;
 I +VBECFLD=27,($O(^VBEC(6001,VBECIEN,"TOT",VBECIEN1))="") Q
 I $E(IOST)="C" K DIR S DIR(0)="E" D ^DIR S VBECXIT=$S(Y'>0:1,1:0)
 K DIR,X,Y Q:VBECXIT
HDR ; draw header
 W:($E(IOST)="C")!(VBECPG>1) @IOF
 W !,$$CJ^XLFSTR("VistA Blood Bank Data Element Summary",IOM)
 W !,"Data Conversion start time: "_VBECY00
 W !,"Data Conversion end time: "_VBECDCFN
 W !,"User: "_VBECUSER
 W !,"Report Run Date: ",VBECTDAY,?69,"Page: ",VBECPG,!,VBECLN
 S VBECPG=VBECPG+1
 Q
 ;
PRINT(VBECDSTR) ;print data
 ;Input: VBECDSTR=data string; each delimited piece indicates the
 ; total number of occurences for a data element.
 F VBECI=1:1 S VBECFLD=$P($T(FORMAT+VBECI),";;",2) Q:VBECFLD=""  D  Q:VBECXIT
 .W !,$P(VBECFLD,";",2)_": "_$P(VBECDSTR,U,VBECI)
 .I $Y>(IOSL-4) D EOS ;sets the variable VBECXIT
 .W:+VBECFLD=27&($O(^VBEC(6001,VBECIEN,"TOT",VBECIEN1))>0) !
 .Q
 Q
 ;
FORMAT ;field names are formatted here
 ;;1;LRDFN
 ;;2;DFN
 ;;3;Family Name
 ;;4;Given Name
 ;;5;Middle Name
 ;;6;Suffix (Name)
 ;;7;Sex
 ;;8;DOB
 ;;9;SSN
 ;;10;ICN
 ;;11;ABO
 ;;12;RH
 ;;13;RBC Antigens Present
 ;;14;RBC Antigens Present Comments
 ;;15;RBC Antigens Present Chars
 ;;16;RBC Antigens Absent
 ;;17;RBC Antigens Absent Comments
 ;;18;RBC Antigens Absent Chars
 ;;19;Antibodies Identified
 ;;20;Antibodies Identified Comments
 ;;21;Antibodies Identified Chars
 ;;22;Transfusion Reaction Date
 ;;23;Transfusion Reaction
 ;;24;Transfusion Reaction Comments
 ;;25;Trans. Reaction Comment Chars
 ;;26;Blood Bank Comments
 ;;27;Blood Bank Comment Chars
 ;;
