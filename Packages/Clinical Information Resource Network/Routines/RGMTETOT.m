RGMTETOT ;BIR/CML-Compile Totals for Site Exceptions ;11/15/01
 ;;1.0;CLINICAL INFO RESOURCE NETWORK;**20,30,43,45,52,57**;30 Apr 99;Build 2
 ;
 ;Reference to ^DPT("AICNL" supported by IA #2070
 ;
 ;Variable RGHLMQ cannot be killed in this routine, it is needed for the remote query
 ;
 ;**57 MPIC_1893; Patch removed references to exception 218, Potential Matches Returned.
 ;Therefore, deleted the PURGE, SETTMP, and DELDUP modules.
 ;
 ;Use this routine to compile totals of a site's exceptions in file #991.1
 S DUMP=0 G START
 ;
DUMP1 ;Use this call to dump all data in ascii format for table
 S DUMP=1 G START
 ;
DUMP2 ;Use this call to dump data in ascii format for table - just for exceptions sites have to deal with
 S DUMP=2
 ;
START ;
 K TYPEARR,^XTMP("RGMT","HLMQETOT")
 S ^XTMP("RGMT",0)=$$FMADD^XLFDT(DT,30)_"^"_$$NOW^XLFDT_"^MPI/PD Maintenance Data"
 ;create type array from file 991.11
 S TYPE=233 F  S TYPE=$O(^RGHL7(991.11,TYPE)) Q:'TYPE  S TYPEARR(TYPE)=0 ;**52 MPIC_772 remove 215, 216, & 217;**57 MPIC_1893 remove 218 reference
 ;
 ;start loop
 S TYPE=233 F  S TYPE=$O(^RGHL7(991.1,"AC",TYPE)) Q:'TYPE  D  ;**52 MPIC_772 remove 215, 216 & 217
 .S IEN1=0 F  S IEN1=$O(^RGHL7(991.1,"AC",TYPE,IEN1)) Q:'IEN1  D
 ..S IEN2=0 F  S IEN2=$O(^RGHL7(991.1,"AC",TYPE,IEN1,IEN2)) Q:'IEN2  D
 ...I '$D(^RGHL7(991.1,IEN1,1,IEN2,0)) Q
 ...S STAT=$P(^RGHL7(991.1,IEN1,1,IEN2,0),"^",5) I STAT<1 S TYPEARR(TYPE)=TYPEARR(TYPE)+1
 ;
PRT ;
 S GRAND=0
 S SITENM=$P($$SITE^VASITE(),"^",2),$P(LN,"-",81)=""
 D NOW^%DTC S RUNDT=$$FMTE^XLFDT($E(%,1,12))
 ;
PRT0 I 'DUMP D
 .W !!,"Exception Totals for ",SITENM
 .W !,"Printed ",RUNDT,!,LN
 .S TYPE=0 F  S TYPE=$O(TYPEARR(TYPE)) Q:'TYPE  I +TYPEARR(TYPE) D
 ..S GRAND=GRAND+TYPEARR(TYPE)
 ..W !!,"TYPE: ",TYPE,?12,$P($T(@TYPE),";;",2),?67,"TOTAL = ",$J(TYPEARR(TYPE),4)
 ..W !,"DESCRIPTION:"
 ..S TXT=0 F  S TXT=$O(^RGHL7(991.11,TYPE,99,TXT)) Q:'TXT  W !,^RGHL7(991.11,TYPE,99,TXT,0)
 .W !!?56,"TOTAL EXCEPTIONS: ",$J(GRAND,5)
 ;
PRT1 I DUMP=1 D
 .W !!,"At this point it is necessary for you to increase the right margin."
 .W !,"At the DEVICE prompt enter=> ;255"
 .W ! D ^%ZIS I POP W !,"DOWNLOAD ABORTED!" Q
 .W !!,"Data string=Site;Run Date;Date CIRN Installed;Exceptions 234" ;**52 MPIC_772 remove 215, 216 & 217;**57 MPIC_1893 remove 218
 .S STR=SITENM_";"_RUNDT_";"
 .S TYPE=0 F  S TYPE=$O(TYPEARR(TYPE)) Q:'TYPE  D
 ..S STR=STR_";"_TYPEARR(TYPE)
 .W !!,STR
 ;
PRT2 I DUMP=2 D
 .S ICN=0,LOCCNT=0 F  S ICN=$O(^DPT("AICNL",1,ICN)) Q:'ICN  S LOCCNT=LOCCNT+1
 .S SITEIEN=+$$SITE^VASITE(),STANUM=$P($$SITE^VASITE(),"^",3)
 .I '$D(RGHLMQ) W !!,"Data string:"
 .I '$D(RGHLMQ) W !,"Site;Sta#;;;LocICNs,234" ;**52 MPIC_772 remove 215, 216 & 217;**57 MPIC_1893 remove 218
 .S STR=SITENM_";"_STANUM_";;;"_LOCCNT
 .F TYPE=234 S STR=STR_";;"_TYPEARR(TYPE) ;**52 MPIC_772 remove 215, 216 & 217;**57 MPIC_1893 remove 218
 .I '$D(RGHLMQ) W !!,STR
 .I $D(RGHLMQ) S ^XTMP("RGMT","HLMQETOT",STANUM,1)=STR
 ;
QUIT ;
 K %,CIRNIEN,CNT,DA,DIK,DUMP,DUPCNT,EXCDT,GRAND,ICN,IEN,IEN1,IEN2,LN,LOCCNT,OLDDT,OLDNODE,PTNM
 K RGDFN,RUNDT,SITEIEN,SITENM,STANUM,STAT,STR,TXT,TYPE,XCNT,HOME,DFN,RCNT,VADM
 K ^XTMP("RGMT","ETOT")
 Q
 ;
234 ;;(Primary View Reject)
