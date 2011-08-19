RGFICLN ;ALB/CJM-MPI/PD NDBI SITE CLEANUP UTILITY ;08/27/99
 ;;1.0; CLINICAL INFO RESOURCE NETWORK ;**9**;30 Apr 99
 ;
 ;Description:
 ;Looks for patients that have the legacy site as a treating facilty or
 ;as the CMOR and replaces it with the primary site.
 ;
 ;This utility can be executed in a test mode by setting the TESTMODE
 ;input parameter to 1.
 ;
CLEAN(LEGACY,PRIMARY,TESTMODE,ERROR) ;
 ;Input:
 ;  LEGACY - station # of legacy site
 ;  PRIMARY - station # of primary site
 ;  TESTMODE - set to 1 if this routine is to be run in interactive mode
 ;Output:
 ;  Function Value:  1 on success, 0 on failure
 ;  ERROR:  optional error msg returned on failure (pass by reference)
 ;  ** Also sends a report to the MPI EXCEPTIONS mailgroup
 ;
 ;Variables:
 ;  LEGACY("PTR"):  ien of the legacy site in the Institution file
 ;  PRIMARY("PTR"): ien of the primary site in the institution file
 ;
 S TESTMODE=+$G(TESTMODE)
 Q:'$$LOOKUP(.LEGACY,.PRIMARY,.ERROR) 0
 D LOOP(.LEGACY,.PRIMARY)
 Q 1
 ;
LOOKUP(LEGACY,PRIMARY,ERROR) ;
 ;Does a lookup on the Institution file for the legacy and primary site
 ;Input:
 ;  LEGACY - station # of legacy site
 ;  PRIMARY - station # of primary site
 ;Output:
 ;  function value - 1 on success, 0 on faiure
 ;  LEGACY("PTR") - the ien (optional, pass LEGACY by reference)
 ;  PRIMARY("PTR") - the ien (optional, pass PRIMARY by reference)
 ;  ERROR - error message on failure (optional, pass by reference)
 ;
 S LEGACY("PTR")=$$LKUP^XUAF4($G(LEGACY))
 I 'LEGACY("PTR") S ERROR="LEGACY STATION NUMBER NOT FOUND UNIQUELY IN THE INSTITUTION FILE!" Q 0
 S PRIMARY("PTR")=$$LKUP^XUAF4($G(PRIMARY))
 I 'PRIMARY("PTR") S ERROR="PRIMARY STATION NUMBER NOT FOUND UNIQUELY IN THE INSTITUTION FILE!" Q 0
 Q 1
 ;
LOOP(LEGACY,PRIMARY) ;
 ;Description:  Looks for patients having the Legacy site as the CMOR
 ;or as a TF and for each such patient exchanges the legacy site with the
 ;primary site.
 ;
 ;Input:
 ;  LEGACY():  as above
 ;  PRIMARY(): as above
 ;Output:
 ;  MPI/NDBI SITE CLEANUP REPORT mailed to the MPI EXCEPTIONS mailgroup
 ;VARIABLES:
 ;  RGREPORT - @RGREPORT will store interim results for the report
 ;  COUNT("TF") - count of patients found with legacy as TF
 ;  COUNT("CMOR") - count of patients found with legacy as CMOR
 ;  HERE - station # of the site this is running on
 ;  CMOR - patient's CMOR
 ;  CMOR("#") - station # of patient's CMOR
 ;
 N DFN,COUNT,RGREPORT,HERE
 S RGREPORT="^TMP($J,""RG FACILITY INTEGRATION CLEANUP"")"
 K @RGREPORT
 S HERE=$P($$SITE^VASITE(),"^",3)
 ;
 ;don't do this if this is the legacy site
 Q:(HERE=LEGACY)
 ;
 S (COUNT("TF"),COUNT("CMOR"),DFN)=0
 I TESTMODE W !!,"Looking for patients with legacy site as CMOR ..."
 F  S DFN=$O(^DPT("ACMOR",LEGACY("PTR"),DFN)) Q:'DFN  D  I TESTMODE Q:'$$ASKYESNO^RGFIU("Another","YES")
 .N CMOR
 .S CMOR=$$GETFIELD^RGFIU(2,991.03,DFN)
 .Q:(CMOR'=LEGACY("PTR"))
 .I TESTMODE Q:'$$ASKOK(DFN)
 .D PROC
 .D CMORADD(RGREPORT,.COUNT,DFN)
 ;
 I TESTMODE W !!,"Looking for patients with legacy site as treating facility ..."
 S DFN=0
 F  S DFN=$O(^DGCN(391.91,"AINST",LEGACY("PTR"),DFN)) Q:'DFN  D  I TESTMODE Q:'$$ASKYESNO^RGFIU("Another","YES")
 .N CMOR
 .I TESTMODE Q:'$$ASKOK(DFN)
 .S CMOR=$$GETFIELD^RGFIU(2,991.03,DFN)
 .D PROC
 .D TFADD(RGREPORT,.COUNT,DFN)
 I $G(TESTMODE) W !,"Returned mail message number:",$$REPORT(.COUNT,RGREPORT,LEGACY,PRIMARY)
 I '$G(TESTMODE),$$REPORT(.COUNT,RGREPORT,LEGACY,PRIMARY)
 K @RGREPORT
 Q
 ;
PROC ;
 N RES,ERROR,I
 I '$$XCHANGE^RGFIPM(DFN,LEGACY,PRIMARY,.ERROR),TESTMODE W !,"** ERROR: ",$G(ERROR)
 S CMOR("#")=$$STATNUM^RGFIU(CMOR)
 I HERE=CMOR("#") D
 .I TESTMODE D
 ..I $$SEND^RGFIBM(DFN,LEGACY,PRIMARY,.RES,.ERROR) W !,"HL7 Message sent: "
 ..E  W !,"*** HL7 Message NOT sent! :",$G(ERROR)
 ..I $D(RES) S I=0 W !," Msg 1: ",RES F  S I=$O(RES(I)) Q:'I  W !," Msg ",(I+1),": ",RES(I)
 .I 'TESTMODE,$$SEND^RGFIBM(DFN,LEGACY,PRIMARY,.RES,.ERROR)
 Q
 ;
TFADD(RGREPORT,COUNT,DFN) ;
 ;adds patient to list of legacy as TF
 S COUNT("TF")=COUNT("TF")+1
 S @RGREPORT@("TF",DFN)=""
 Q
 ;
CMORADD(RGREPORT,COUNT,DFN) ;
 ;adds patient to list of legacy as CMOR
 ;
 S COUNT("CMOR")=COUNT("CMOR")+1
 S @RGREPORT@("CMOR",DFN)=""
 Q
 ;
ASKOK(DFN) ;
 ;Discription: Displays the CMOR and TF's for a single patient and asks whether to process
 ;
 ;Input:
 ;   DFN - patient that was just processed
 ;Output:
 ;   Function value - 1 to quit, 0 to continue
 ;Variables:
 ;   MPIDATA() - to contain the MPI data
 ;
 N SUB,MPIDATA
 D GETALL^RGFIU(DFN,.MPIDATA)
 W !!
 W !,"Patient DFN:   ",DFN
 W !,"Patient Name:  ",$$NAME^RGFIU(DFN)_"   SSN:  ",$$SSN^RGFIU(DFN)
 W !,"Patient ICN:   ",MPIDATA("ICN"),$S(MPIDATA("LOC"):" (local)",1:""),"   CMOR:  ",MPIDATA("CMOR")
 ;
 W !,"Treating Facilities:"
 S SUB=0
 F  S SUB=$O(MPIDATA("TF",SUB)) Q:'SUB  W !,"    ",SUB
 ;
 Q $$ASKYESNO^RGFIU("Process patient")
 ;
REPORT(COUNT,RGREPORT,LEGACY,PRIMARY) ;
 ;Description: Mails report of cases found requiring cleanup after a site integration
 ;
 ;Input:
 ;  RGREPORT - @RGREPORT is the location of the report data
 ;  COUNT() - contains counts of patients cleaned up (pass by reference)
 ;  LEGACY - legacy site station #
 ;  PRIMARY - primary site station #
 ;Output: none
 ;
 ;
 N DFN,LINECNT
 S (DFN,LINECNT)=0
 K @RGREPORT@("MAILTEXT")
 D HEADER
 D ADDLINE("** Patients with Legacy Site as CMOR **")
 D ADDLINE(" ")
 F  S DFN=$O(@RGREPORT@("CMOR",DFN)) Q:'DFN  D
 .D ADDLINE("Patient: "_$$LJ^XLFSTR($$NAME^RGFIU(DFN),30)_"  SSN: "_$$SSN^RGFIU(DFN)_"  ICN: "_$$ICN^RGFIU(DFN))
 D ADDLINE(" "),ADDLINE(" ")
 D ADDLINE("** Patients with Legacy Site as Treating Facility **")
 D ADDLINE(" ")
 S DFN=0
 F  S DFN=$O(@RGREPORT@("TF",DFN)) Q:'DFN  D
 .D ADDLINE("Patient: "_$$LJ^XLFSTR($$NAME^RGFIU(DFN),30)_"  SSN: "_$$SSN^RGFIU(DFN)_"  ICN: "_$$ICN^RGFIU(DFN))
 D ADDLINE(" "),ADDLINE("** END OF MPI/NDBI SITE CLEANUP REPORT **")
 Q $$MAIL
 ;
HEADER ;
 D ADDLINE("MPI/NDBI SITE CLEANUP REPORT FROM "_$P($$SITE^VASITE(),"^",2)_"       DATE: "_$$FMTE^XLFDT(DT,"1"))
 D ADDLINE("Primary Station: "_PRIMARY_"  Legacy Station: "_LEGACY)
 D ADDLINE("Count of Patients Found with Legacy Site as CMOR: "_COUNT("CMOR"))
 D ADDLINE("Count of Patients Found with Legacy Site as Treating Facility: "_COUNT("TF"))
 D ADDLINE("  ")
 Q
 ;
ADDLINE(LINE) ;
 ;Description: adds one one to the message text
 ;Inputs:
 ;  LINE - the line of text to be added
 ;  RGREPORT - @RGREPORT is the location of the report
 ;  LINECNT - should be defined, the count of lines added to mail msg
 S LINECNT=$G(LINECNT)+1
 S @RGREPORT@("MAILTEXT",LINECNT)=LINE
 Q
MAIL() ;
 N XMY,XMSUB,XMDUZ,XMTEXT,XMZ,XMDUN,DIFROM
 S XMY=.5
 S XMDUZ="MPI/PD at "_$P($$SITE^VASITE(),"^",2)
 I $G(DUZ) S XMY(DUZ)=""
 S XMY("G.MPIF EXCEPTIONS")=""
 S XMTEXT=$P(RGREPORT,")")_",""MAILTEXT"","
 S XMSUB="MPI/NDBI SITE CLEANUP"
 D ^XMD
 Q $G(XMZ)
