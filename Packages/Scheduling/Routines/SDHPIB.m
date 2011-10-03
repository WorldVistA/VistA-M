SDHPIB ;PKE/ALB - Health Services R&D Caregiver Study Main Routine;
 ;;5.3;Scheduling;**141**;March 12, 1996
 ;
 I $D(DUZ)'=11 DO  Q
 .W !!,"Please set DUZ variables, D ^XUP"
 ;
 S SDTATION=+$$SITE^VASITE()
 I 'SDTATION DO  Q
 . W !!,"Could not find station number from VASITE" Q
 ;
 W !?3,">>> VA HSR&D Caregivers Survey <<< ",!
 W !,"    Please queue to run at a none peak time."
 W !,"    This extract will generate 2 mail messages to you"
 W !,"    and to G.SD HPI EXTRACT@ISC-ALBANY.VA.GOV",!
 ;
 S ZTIO="",ZTRTN="START^SDHPIB"
 S ZTDESC="SD*5.3*141 - VA HSR&D Caregivers Survey"
 D ^%ZTLOAD,HOME^%ZIS
 I $G(ZTSK) W !?30,"Task Number = ",ZTSK,!
 Q
START I $D(DUZ)'=11 W !!,"Please set DUZ variables, D ^XUP" Q
 ;
 S SDTATION=+$$SITE^VASITE()
 I '$D(^XTMP("SDHPI","S",SDTATION)) W:'$D(ZTQUEUED) !,"No STATION data" Q
 ;
 S SDSTART=$$FMTE^XLFDT($$NOW^XLFDT)
 ;
 K ^XTMP("SDHPI",$J,"DATA")
 K ^XTMP("SDHPI",$J,"ERROR")
 K ^XTMP("SDHPI","S",SDTATION,"DFN")
 ;
 I $D(^XTMP("SDHPI","S",SDTATION,"ERROR","NO DATA REQUESTED")) DO  QUIT
 .;
 . D FMAIL(0)
 . I '$D(ZTQUEUED) W !!?3,">>>... all done"
 ;
 I '$D(ZTQUEUED) DO
 .W !?3,">>> Looking up patients DFNs from SSNs  "
 D GETDFN(SDTATION)
 ;
 I '$D(ZTQUEUED) DO
 .W !!?3,">>> Looking up patients data from DFNs  "
 D DIQLOOK(SDTATION)
 ;
 I '$D(ZTQUEUED) DO
 .W !!?3,">>> Creating Mail message of patients data "
 D SENDATA(SDTATION)
 ;
 I '$D(ZTQUEUED) DO
 .W !!?3,">>> ....all done"
 ;
 ;mail summary
 D FMAIL(1)
 ;
 K SDFIELD,SDN,SDP,SDPECE,SDSTART
 K SDZ,SDFLDS,SDDFN,SDTATION,SDSSN,SDLINE
 Q
GETDFN(SDTATION) ;
 ;From strings of SSNs get DFN's from DPT
 ; go down station array
 S SDN=0
 F  S SDN=$O(^XTMP("SDHPI","S",SDTATION,SDN)) Q:'SDN  DO
 .;;piece out ssn
 .F SDP=1:1 S SDSSN=$P(^XTMP("SDHPI","S",SDTATION,SDN),"^",SDP) Q:'SDSSN  DO
 . . S SDDFN=$$DFN(SDSSN)
 . . I SDDFN S ^XTMP("SDHPI","S",SDTATION,"DFN",SDDFN)=SDSSN
 . . E  S ^XTMP("SDHPI",$J,"ERROR","SSN",SDSSN)=SDDFN
 . .;
 . . I (($P($H,",",2))#20) Q
 . . I '$D(ZTQUEUED) W "."
 Q
DIQLOOK(SDTATION) ;
 ;
 ; get array of fields to lookup
 D INIFLDS
 ; for each dfn call gets^diq
 S SDDFN=0
 F  S SDDFN=$O(^XTMP("SDHPI","S",SDTATION,"DFN",SDDFN)) Q:'SDDFN  DO
 . D GETSDIQ(SDDFN)
 .;
 . I (($P($H,",",2))#3) Q
 . I '$D(ZTQUEUED) W "."
 .;
 Q
SENDATA(SDTATION) ;
 ; sdline is the message line
 S SDLINE=0
 S SDDFN=""
 ; (2,dfn, field  set up from fileman data merge, dfn is dfn_"," 
 F  S SDDFN=$O(^XTMP("SDHPI",$J,"DATA",2,SDDFN)) Q:'SDDFN  DO 
 . D SETMAIL(SDTATION,SDDFN)
 .;
 . I (($P($H,",",2))#10) Q
 . I '$D(ZTQUEUED) W " ."
 .;
 ;final mailman set
 Q:'SDLINE
 D SMAIL(SDLINE)
 ;
 Q
SETMAIL(SDTATION,SDDFN) ;
 I SDLINE=0 D INITMAIL(1)
 ;
 S SDLINE=SDLINE+1
 S SDPECE=1
 ;
 ; set first line of each record to station^ssn
 S ^XMB(3.9,XMZ,2,SDLINE,0)=SDTATION_"^"_$P($G(^DPT(+SDDFN,0)),"^",9)_"^"
 S SDLINE=SDLINE+1
 ;
 S SDFIELD=0
 F  S SDFIELD=$O(^XTMP("SDHPI",$J,"DATA",2,SDDFN,SDFIELD)) Q:'SDFIELD  DO
 . ;set mailmsg for 1 dfn
 . I $$LINECALC(SDFIELD,SDLINE)>80 DO
 . . ; make sure end piece has last ^
 . . S $P(^XMB(3.9,XMZ,2,SDLINE,0),"^",SDPECE)=""
 . . S SDLINE=SDLINE+1
 . . S SDPECE=1
 . D SETLINE
 . S SDPECE=SDPECE+1
 ;
 ; make sure end piece has last ^
 S $P(^XMB(3.9,XMZ,2,SDLINE,0),"^",SDPECE)=""
 S SDLINE=SDLINE+1
 ; set record delimiter
 S ^XMB(3.9,XMZ,2,SDLINE,0)=">>>"
 ;
 Q
LINECALC(SDFIELD,SDLINE) ;
 ; return length that would be set
 Q $L($G(^XTMP("SDHPI",$J,"DATA",2,SDDFN,SDFIELD,"E")))+$L($G(^XMB(3.9,XMZ,2,SDLINE,0)))
 ;
 ;
SETLINE ;set mailmsg from xtmp array
 ; $g will preserve piece position if field returned error
 S $P(^XMB(3.9,XMZ,2,SDLINE,0),"^",SDPECE)=$G(^XTMP("SDHPI",$J,"DATA",2,SDDFN,SDFIELD,"E")) Q
 ;
 ;
GETSDIQ(SDDFN) ;
 K SDDATA,SDERR
 ;
 F SDFLDS=1:1:5 DO
 . D GETS^DIQ(2,SDDFN,SDFLDS(SDFLDS),"E","SDDATA","SDERR")
 .;
 .; merge will set ,2,dfn_",",field,"E")=external value
 .;
 . M ^XTMP("SDHPI",$J,"DATA")=SDDATA
 . K SDDATA
 . I $D(SDERR) DO  K SDERR
 . .;if a field has err whatodo
 . .;
 . .; check to see if each field was set in returned array 
 . . F SDP=1:1 S SDFIELD=$P(SDFLDS(SDFLDS),";",SDP) Q:'SDFIELD  DO
 . . .;
 . . .;  indicates fileman returned error
 . . . I '$D(^XTMP("SDHPI",$J,"DATA",2,SDDFN_",",SDFIELD,"E")) DO
 . . . .;
 . . . .; set it to null to keep the piece position in mail
 . . . . S ^XTMP("SDHPI",$J,"DATA",2,SDDFN_",",SDFIELD,"E")=""
 . . . .;
 . . . .;the sderr array is set by fm in order of missing fields
 . . . . S SDERR=$O(SDERR("DIERR",0)) I 'SDERR K SDERR Q
 . . . . M ^XTMP("SDHPI",$J,"ERROR",SDDFN,SDFIELD)=SDERR("DIERR",SDERR)
 . . . . S ^XTMP("SDHPI",$J,"ERROR",SDDFN,"SSN")=$P($G(^DPT(SDDFN,0)),"^",9)
 . . . .;pop the array
 . . . . K SDERR("DIERR",SDERR)
 . . .;
 ;
 Q
 ;
 Q
INITMAIL(FLAG) ;-- This function will initialize mail variables
 ;
 S XMSUB="SD*5.3*141 "_(+$$SITE^VASITE())_"VA HSR&D CAREGIVERS SURVEY"
 S XMDUZ=.5,XMY(DUZ)="",XMY(XMDUZ)=""
 I $G(FLAG) DO
 . S XMY("G.SD HPI EXTRACT@ISC-ALBANY.VA.GOV")=""
 . S XMY("S.SD HPI EXTRACT@ISC-ALBANY.VA.GOV")=""
 D GET^XMA2
 Q
SMAIL(SDLINE) ;-- Send Mail Message containing records so far
 ;
 ; INPUT TOTAL- Total Lines in Message
 ;
 S ^XMB(3.9,XMZ,2,0)="^3.92A^"_SDLINE_U_SDLINE_U_DT
 D ENT1^XMD
 D KILL^XM
 Q
 ;
FMAIL(DATA) ;- This function will generate a summary mail message.
 ;
 S XMSUB="SD*5.3*141 "_(+$$SITE^VASITE())_"VA HSR&D Error Summary"
 S XMDUZ=.5,XMY(DUZ)="",XMY(XMDUZ)=""
 S XMY("G.SD HPI EXTRACT@ISC-ALBANY.VA.GOV")=""
 S XMY("S.SD HPI EXTRACT@ISC-ALBANY.VA.GOV")=""
 ;
 D GET^XMA2
 S ^XMB(3.9,XMZ,2,1,0)="VA Health Services R&D Caregivers Survey completed."
 S ^XMB(3.9,XMZ,2,2,0)=""
 S ^XMB(3.9,XMZ,2,3,0)="Start Time: "_SDSTART
 S ^XMB(3.9,XMZ,2,4,0)=" Stop Time: "_$$FMTE^XLFDT($$NOW^XLFDT)
 S ^XMB(3.9,XMZ,2,5,0)=""
 ;
 S SDLINE=6
 I 'DATA DO  QUIT
 . S ^XMB(3.9,XMZ,2,SDLINE,0)="No data requested"
 . D SMAIL(SDLINE)
 ;
 S SDZ=$Q(^XTMP("SDHPI",$J,"ERROR"))
 I SDZ]"",SDZ[("""SDHPI"""_","_$J_","_"""ERROR""")
 E  DO  QUIT
 . S ^XMB(3.9,XMZ,2,SDLINE,0)=" Error Summary: No errors Found "
 . D SMAIL(SDLINE)
 ;
 S ^XMB(3.9,XMZ,2,SDLINE,0)=" Error Summary: "
 S SDLINE=SDLINE+1
 S ^XMB(3.9,XMZ,2,SDLINE,0)="""ERR"_$P(SDZ,"ERROR",2)_" = "_@SDZ
 ;
 F  S SDZ=$Q(@SDZ) Q:SDZ']""  Q:SDZ'[("""SDHPI"""_","_$J_","_"""ERROR""")  DO
 . S SDLINE=SDLINE+1
 . S ^XMB(3.9,XMZ,2,SDLINE,0)="""ERR"_$P(SDZ,"ERROR",2)_" = "_@SDZ
 .;
 .;quit if this gets to be too much
 . I SDLINE>500 S SDZ="ZZZEND"
 D SMAIL(SDLINE)
 Q
 ;
DFN(SSN) ;function to lookup DFN from SSN x-ref
 ; input SSN
 ; output DFN or error code
 N DFN
 ; make sure dfn is numeric and not null
 I $O(^DPT("SSN",SSN,0))
 E  Q "No SSN Index for "_SSN
 ;
 I $O(^DPT("SSN",SSN,0))=$O(^DPT("SSN",SSN,""),-1)
 E  Q "Ambiguous SSN cross-ref "_SSN
 ;
 S DFN=$O(^DPT("SSN",SSN,0))
 ;
 I $G(^DPT(DFN,0))]""
 E  Q "No Zero node in DPT for SSN "_SSN
 ;
 I $P($G(^DPT(DFN,0)),"^",9)=SSN
 E  Q "Bad SSN cross-ref "_SSN
 Q DFN
 ;
INIFLDS ; set up array of fields to be used in fm getsdiq call
 S SDFLDS(1)=$P($T(FLDS1),";;",2)
 S SDFLDS(2)=$P($T(FLDS2),";;",2)
 S SDFLDS(3)=$P($T(FLDS3),";;",2)
 S SDFLDS(4)=$P($T(FLDS4),";;",2)
 S SDFLDS(5)=$P($T(FLDS5),";;",2)
 Q
FLDS1 ;;.01;.02;.03;.033;.05;.06;.07;.08;.09;.103;.104;.1041;.105;.111;.1112;.112;.113;.114;.115;.116;.117;.12105;.1211;.12111;.12112;.1212;.1213;.1214;.1215;.1216;.1217;.1218;.1219
FLDS2 ;;.131;.132;.14;.21011;.211;.211011;.212;.2125;.213;.214;.215;.216;.217;.218;.219;.2191;.2192;.21925;.2193;.2194;.2195;.2196;.2197;.2198;.2199
FLDS3 ;;.2401;.2402;.2403;.251;.2514;.2515;.252;.253;.254;.255;.256;.257;.258;.291;.2911;.2912;.2913;.2914;.2915;.2916;.2917;.2918;.2919;.292;.2921;.2922;.2923;.2924;.2925;.2926;.2927;.2928;.2929;.293
FLDS4 ;;.301;.3192;.323;.33011;.3305;.331;.331011;.3311;.3312;.3313;.3314;.3315;.3316;.3317;.3318;.3319;.332;.333;.334;.335;.336;.337;.338;.339;.34011;.3405;.341;.342;.343;.344;.345;.346;.347;.348;.349;.351
FLDS5 ;;.3601;.36205;.3621;.36215;.3622;.36225;.3623;.36235;.3624;.3625;.36255;.3626;.36265;.3627;.36275;.3628;.36285;.3629;.36295;.525;.5291;57.4;148;1901
 Q
