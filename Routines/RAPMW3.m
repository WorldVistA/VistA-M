RAPMW3 ;HOIFO/SWM-Radiology Wait Time reports ;3/20/09 14:10
 ;;5.0;Radiology/Nuclear Medicine;**99**;Mar 16, 1998;Build 5
 ;rvd - 3/20/09 p99
 ; Supported IA #2320 reference to ^%ZISH
 Q
EN1 ;
 W !,"*****************************************************************"
 W !,"This routine requires a tab-delimited VMS text file for input."
 W !,"This text file should come from Sherrill Snuggs' Xcel file."
 W !,"ALL DATA FROM FILE 73.2 WILL BE DELETED BEFORE IMPORTING VMS FILE."
 W !,"Only the 1st of duplicate CPT Codes would be imported."
 W !,"*****************************************************************"
 S RADIR="USER$:[TEMP]"
 W !!,"Enter VMS directory :"_RADIR_"//" R X:DTIME
 Q:X="^"  S:X'="" RADIR=X
 R !!,"Enter VMS file name :",RAVMS:DTIME
 Q:"^"[RAVMS
 S RAFILE=RADIR_RAVMS
 W !!,"Full name of input file is ",RAFILE,!
 S DIR(0)="Y",DIR("A",1)="Import includes deletion of all existing data from file 73.2.",DIR("A",2)=" "
 S DIR("A")="Do you want to import data from "_RAFILE
 S DIR("B")="No"
 D ^DIR K DIR I 'Y W !!?5,"Nothing Done." D CLEANUP Q
 D OPEN^%ZISH("FILE",RADIR,RAVMS,"R")
 I POP W !?3,"** This file cannot be opened. **" G ABEND
 D DATDEL ;delete all current data, if any, from file
 S RATAB=$C(9),RACOUNT=0,RAREAD=0
 S RATXT="Loading data into FM file 73.2."
 D DISP
R1 U IO R X:DTIME I $$STATUS^%ZISH G EOF
 K A S RAREAD=RAREAD+1
 F I=1:1:8 S A(I)=$P(X,RATAB,I)
 I A(1)'?5AN D  G R1 ; skip header record
 . S RATXT="First field is "_A(1)_", record is not imported"
 . D DISP
 . Q
 I A(1)="" D  G R1 ; skip null record
 . S RATXT="First field is null, record is not imported"
 . D DISP
 . Q
 I $O(^RA(73.2,"B",A(1),0)) D  G R1 ; skip duplicate CPT Code
 . S RATXT="Duplicate CPT Code not imported = "_A(1)
 . D DISP
 . Q
 S A(5)=$$PARSE(A(5))
 S A(8)=$E(A(8),1) S:A(8)'="Y" A(8)="" ; Y or null only
 D SETREC S RACOUNT=RACOUNT+1 I '(RACOUNT#10) U 0 W "."
 G R1
EOF D CLOSE^%ZISH("FILE")
 S RATXT=RAREAD_" records read, "_RACOUNT_" records loaded." D DISP
 D CLEANUP
 Q
PARSE(RA) ; parse Descriptor -- remove double quotes and trailing blanks if any
 N I,B
 Q:RA="" RA
 S:$E(RA,1)="""" RA=$E(RA,2,$L(RA))
 S:$E(RA,$L(RA))="""" RA=$E(RA,1,($L(RA)-1))
 Q:$E(RA,$L(RA))'=" " RA ; Last char is non-blank
 F I=$L(RA):-1:1 Q:$E(RA,I)'=" "  S B=$E(RA,1,I-1)
 S RA=B
 Q RA
DATDEL ; Delete all data from file 73.2
 S RATXT="File 73.2 hasn't been set up yet, so no data to delete."
 I '$D(^RA(73.2,0))#2 D DISP Q
 S RATXT="File 73.2 doesn't have any data, so nothing to delete."
 I '$O(^RA(73.2,0)) D DISP Q
 S RATXT="Deleting data from FM file #73.2..."
 D DISP
 S I=0 F  S I=$O(^RA(73.2,I)) Q:'I  K ^RA(73.2,I)
 K ^RA(73.2,"B"),^RA(73.2,"AC")
 S $P(^RA(73.2,0),"^",3,4)="^0"
 Q
SETREC ;
 S RA=$P(^RA(73.2,0),"^",3)
S2 S RA=RA+1 I $D(^RA(73.2,RA,0))#2 G S2 ;find next un-used ien
 F I=1,2,3,4,6,7,8 S $P(^RA(73.2,RA,0),"^",I)=A(I)
 S ^RA(73.2,RA,1)=A(5)
 S ^RA(73.2,"B",A(1),RA)=""
 S:A(2)]"" ^RA(73.2,"AC",A(2),RA)=""
 S $P(^RA(73.2,0),"^",3)=RA
 S $P(^RA(73.2,0),"^",4)=$P(^RA(73.2,0),"^",4)+1
 Q
ABEND U 0 W !,"Processing abended."
 D CLEANUP
 Q
DISP ;display one-line text either interactively or within KIDS installation
 I '$D(XPDNM)#2 U 0 W !!?5,RATXT
 E  D BMES^XPDUTL(RATXT)
 Q
CLEANUP ;
 K A,F,I,POP,RA,RACOUNT,RADIR,RAFILE,RAREAD,RATAB,RATXT,RAVMS,X,Y
 Q
 ;
HD ;Header for email <=30 Days Performance Value Summary.
 ;S RAN=RAN+1,^TMP($J,"RAPM",RAN)=""
 ;S RAN=RAN+1,^TMP($J,"RAPM",RAN)=RAH1_"   Page: 1"
 S RAN=RAN+1,^TMP($J,"RAPM",RAN)="",RAN=RAN+1
 S ^TMP($J,"RAPM",RAN)=RAH3,RAN=RAN+1
 S I=0 F  S I=$O(RAH4(I)) Q:'I  S ^TMP($J,"RAPM",RAN)=RAH4(I),RAN=RAN+1
 S RAN=RAN+1,^TMP($J,"RAPM",RAN)=RAH5_"         "
 S RAN=RAN+1,^TMP($J,"RAPM",RAN)=RAH8_"         "
 Q
HDSUM ;
 S RATOTAL=0
 S:$G(^TMP($J,"RAPM","TOTAL"))>0 RATOTAL=($G(^TMP($J,"RAPM","VR",1))+$G(^(2)))/$G(^TMP($J,"RAPM","TOTAL"))*100
 S RAN=RAN+1,^TMP($J,"RAPM",RAN)=""
 S RAN=RAN+1,^TMP($J,"RAPM",RAN)="PERFORMANCE VALUE SUMMARY"
 S RAN=RAN+1,^TMP($J,"RAPM",RAN)="-------------------------"
 S RAN=RAN+1,^TMP($J,"RAPM",RAN)=""
 S RAN=RAN+1,^TMP($J,"RAPM",RAN)=$J(RATOTAL,0,1)_"% - Report verification timeliness performance value"
 S RAN=RAN+1,^TMP($J,"RAPM",RAN)=""
 S RAN=RAN+1,^TMP($J,"RAPM",RAN)="Wait Time performance values:"
 S RAN=RAN+1,^TMP($J,"RAPM",RAN)=""
 S RAN=RAN+1,^TMP($J,"RAPM",RAN)=" %         %"
 S RAN=RAN+1,^TMP($J,"RAPM",RAN)=" <=14      <=30                      PROCEDURE"
 S RAN=RAN+1,^TMP($J,"RAPM",RAN)=" Days      Days                           TYPE"
 S RAN=RAN+1,^TMP($J,"RAPM",RAN)="----------------------------------------------"
 Q
 ;
HD1 ;Header for email Wait and Time Performamce Report.
 N I
 S RAN=RAN+1,^TMP($J,"RAPM",RAN)=""
 S RAN=RAN+1,^TMP($J,"RAPM",RAN)="",RAN=RAN+1
 S ^TMP($J,"RAPM",RAN)=RAH1_"    Page: 1"
 S RAN=RAN+1,^TMP($J,"RAPM",RAN)=""
 S RAN=RAN+1
 S ^TMP($J,"RAPM",RAN)=RAH3,RAN=RAN+1
 S I=0 F  S I=$O(RAH4(I)) Q:'I  S ^TMP($J,"RAPM",RAN)=RAH4(I),RAN=RAN+1
 S RAN=RAN+1,^TMP($J,"RAPM",RAN)=RAH5_"       ",RAN=RAN+1
 S I=0 F  S I=$O(RAH6(I)) Q:'I  S ^TMP($J,"RAPM",RAN)=RAH6(I),RAN=RAN+1
 S RAN=RAN+1
 S I=0 F  S I=$O(RAH7(I)) Q:'I  S ^TMP($J,"RAPM",RAN)=RAH7(I),RAN=RAN+1
 S RAN=RAN+1,^TMP($J,"RAPM",RAN)=RAH8_"        "
 Q
HDSUM1 ;
 S RAN=RAN+1,^TMP($J,"RAPM",RAN)="",RAN=RAN+1
 S ^TMP($J,"RAPM",RAN)="Total number of procedures registered during specified exam date range: "_RATOTAL
 Q
 ;
RAJOB ;PARTIAL process email wait and time report
 S RAN=1 N I,J
 N RASP3,RASP4,RASP6,RASP8,RASP10,RASP15,RASP20,RASP25,RASP31
 S $P(RASP3," ",3)="",$P(RASP4," ",4)="",$P(RASP6," ",6)="",$P(RASP8," ",8)="",$P(RASP10," ",10)=""
 S $P(RASP15," ",15)="",$P(RASP20," ",20)="",$P(RASP25," ",25)="",$P(RASP31," ",31)=""
 D HD D HDSUM S RAPG=RAPG+1
 S I="" F  S I=$O(RACOL(I)) Q:I=""  D
 .S:$D(RACOL14(I,"FR")) RAPCT(I,"FR")=$S(RATOTAL(I)>0:$J(RACOL14(I,"FR")/RATOTAL(I)*100,5,1),1:$J(0,5,1))
 .F J=1:1:5 S RAPCT(I,J)=$S(RATOTAL(I)>0:$J(RACOL(I,J)/RATOTAL(I)*100,5,1),1:$J(0,5,1)),RACOL(I,J)=$J(RACOL(I,J),7)
 .S RAAVG(I)=$S(RATOTAL(I)>0:$J(RAWAITD(I)/RATOTAL(I),7,0),1:"")
 .I I="unknown",RATOTAL(I)=0 K RATOTAL(I),RACOL(I) Q  ;remove "unknown" row if 0s
 .I RANX="C",RATOTAL(I)=0 K RATOTAL(I),RACOL(I) Q  ;remov 0 row if by CPT
 .I $D(RAXCLUDE(I)) K RATOTAL(I),RACOL(I) Q  ;remove excluded Proc Type
 .S RATOTAL(I)=$J(RATOTAL(I),8)
 S I="" F  S I=$O(RACOL(I)) Q:I=""  D
 .S RAN=RAN+1
 .S ^TMP($J,"RAPM",RAN)=$E(RAPCT(I,"FR")_RASP10,1,10)_$E(RAPCT(I,1)_RASP10,1,10)_$J($S(I="unknown":""""_I_"""",1:I),26)
 S RAN=RAN+1,^TMP($J,"RAPM",RAN)=""
 Q
 ;
COLHDS(X) ; moved from RAPMW1
 I X=1 D
 .S RAN=RAN+1 S ^TMP($J,"RAPM",RAN)="" S RAN=RAN+1
 .S ^TMP($J,"RAPM",RAN)="PROCEDURE                   <=30"
 .S RAN=RAN+1
 .S ^TMP($J,"RAPM",RAN)="TYPE                        Days"
 .S RAN=RAN+1
 .S ^TMP($J,"RAPM",RAN)="------------------------- ------"
 I X=2 D
 .S RAN=RAN+1 S ^TMP($J,"RAPM",RAN)="" S RAN=RAN+1
 .S ^TMP($J,"RAPM",RAN)="PROCEDURE                   <=30"
 .S RAN=RAN+1
 .S ^TMP($J,"RAPM",RAN)="TYPE                        Days"
 .S RAN=RAN+1
 .S ^TMP($J,"RAPM",RAN)="------------------------- ------"
 Q
 ;
FOOTS ;
 I RANEG D
 .S RAN=RAN+1,^TMP($J,"RAPM",RAN)="",RAN=RAN+1
 .S ^TMP($J,"RAPM",RAN)=RASP3_"(There "_$S(RANEG=1:"is",1:"are")_" "_RANEG_" case"_$S(RANEG=1:"",1:"s")_" with negative days wait included in the first column.)"
 .;S RAN=RAN+1,^TMP($J,"RAPM",RAN)="",RAN=RAN+1
 S RAMAX=$S($D(RATOTAL("unknown")):33,1:28)
 S RAN=RAN+1,^TMP($J,"RAPM",RAN)=""
 F I=1:1:RAMAX Q:RAXIT  S ^TMP($J,"RAPM",RAN)=RASP4_$P($T(FOOTS2+I),";;",2),RAN=RAN+1
 Q
 ;
RAJOB1 ;process mail wait and time report
 N RASP3,RASP4,RASP6,RASP8,RASP25,I,J
 S $P(RASP3," ",3)="",$P(RASP4," ",4)="",$P(RASP6," ",6)="",$P(RASP8," ",8)="",$P(RASP25," ",25)=""
 D HD1 D HDSUM1 S RAPG=RAPG+1
 S I="" F  S I=$O(RACOL(I)) Q:I=""  D
 .S:$D(RACOL14(I,"FR")) RAPCT(I,"FR")=$S(RATOTAL(I)>0:$J(RACOL14(I,"FR")/RATOTAL(I)*100,5,1),1:$J(0,5,1)),RACOL14(I,"FR")=$J(RACOL14(I,"FR"),7)
 .F J=1:1:5 S RAPCT(I,J)=$S(RATOTAL(I)>0:$J(RACOL(I,J)/RATOTAL(I)*100,5,1),1:$J(0,5,1)),RACOL(I,J)=$J(RACOL(I,J),7)
 .S RAAVG(I)=$S(RATOTAL(I)>0:$J(RAWAITD(I)/RATOTAL(I),7,0),1:"")
 .I I="unknown",RATOTAL(I)=0 K RATOTAL(I),RACOL(I) Q  ;remove "unknown" row if 0s
 .I RANX="C",RATOTAL(I)=0 K RATOTAL(I),RACOL(I) Q  ;remov 0 row if by CPT
 .I $D(RAXCLUDE(I)) K RATOTAL(I),RACOL(I) Q  ;remove excluded Proc Type
 .S RATOTAL(I)=$J(RATOTAL(I),8)
 S RAN=RAN+1,^TMP($J,"RAPM",RAN)="",RAN=RAN+1
 S ^TMP($J,"RAPM",RAN)="          DAYS WAIT -- PERCENTAGES"
 ;S RAN=RAN+1,^TMP($J,"RAPM",RAN)=""
 D COL1(1)
 S I="" F  S I=$O(RACOL(I)) Q:I=""  D
 .S RAN=RAN+1
 .S ^TMP($J,"RAPM",RAN)=$E($S(I="unknown":""""_I_"""",1:I)_RASP25,1,26)_"   "_RAPCT(I,"FR")_"  "_RAPCT(I,1)_"   "_RAPCT(I,2)_"   "_RAPCT(I,3)_"   "_RAPCT(I,4)_"   "_RAPCT(I,5)
 S RAN=RAN+1,^TMP($J,"RAPM",RAN)=""
 S RAN=RAN+1,^TMP($J,"RAPM",RAN)="          DAYS WAIT -- COUNTS"
 ;S RAN=RAN+1,^TMP($J,"RAPM",RAN)=""
 D COL1(2)
 S I="" F  S I=$O(RACOL(I)) Q:I=""  D
 .S RAN=RAN+1
 .S ^TMP($J,"RAPM",RAN)=$E($S(I="unknown":""""_I_"""",1:I)_RASP25,1,26)_""_RACOL14(I,"FR")_""_RACOL(I,1)_""_RACOL(I,2)_""_RACOL(I,3)_""_RACOL(I,4)_""_RACOL(I,5)_""_RATOTAL(I)_""_$S(RAAVG(I)="":"      -",1:RAAVG(I))
 S RAN=RAN+1,^TMP($J,"RAPM",RAN)=" ",RAN=RAN+1
 F I=1:1 S J=$P($T(DAY14+I),";;",2) Q:J=""  S ^TMP($J,"RAPM",RAN)=J,RAN=RAN+1
 S ^TMP($J,"RAPM",RAN)=" ",RAN=RAN+1
 S ^TMP($J,"RAPM",RAN)="Number of procedures cancelled and re-ordered on the same day = "_RASAME
 D FOOTS
 Q
 ;
COL1(X) ; moved from RAPMW1
 I X=1 D
 .S RAN=RAN+1 S ^TMP($J,"RAPM",RAN)="" S RAN=RAN+1
 .S ^TMP($J,"RAPM",RAN)="PROCEDURE                    <=14   <=30   31-60   61-90   91-120   >120"
 .S RAN=RAN+1
 .S ^TMP($J,"RAPM",RAN)="TYPE                         Days   Days    Days    Days    Days    Days"
 .S RAN=RAN+1
 .S ^TMP($J,"RAPM",RAN)="--------------------------   -----  -----   -----   -----   -----   -----"
 I X=2 D
 .S RAN=RAN+1 S ^TMP($J,"RAPM",RAN)="" S RAN=RAN+1
 .S ^TMP($J,"RAPM",RAN)="PROCEDURE                    <=14   <=30  31-60  61-90  91-120  >120    ROW    Avg."
 .S RAN=RAN+1
 .S ^TMP($J,"RAPM",RAN)="TYPE                         Days   Days   Days   Days   Days   Days   TOTAL   Days"
 .S RAN=RAN+1
 .S ^TMP($J,"RAPM",RAN)="---------------------------  -----  -----  -----  -----  -----  -----  -----   -----"
 Q
 ;
FOOTS2 ;
 ;;
 ;;1. Cancelled, "No Credit", inpatient cases, and not the highest modality
 ;;   of a printset are excluded from this report.  (See 3. below.)
 ;;
 ;;2. Columns represent # of days wait from the Registered date (the date/
 ;;   time entered at the "Imaging Exam Date/Time:" prompt) backwards to the
 ;;   Date Desired for the ordered procedure.  The calculation is based on
 ;;   the number of different days and not rounded off by hours.  The "31-60"
 ;;   column represents those orders that were registered 31 days or more but
 ;;   less than 61 days after the Date Desired.
 ;;
 ;;3. If the user did not select a specific CPT Code or Procedure Name, 
 ;;   then the cases from a printset (group of cases that share the same
 ;;   report) will have only the case with the highest modality printed.  
 ;;   The modalities have this hierarchical order, where (1) is the highest:
 ;;   (1) Interventional, (2) MRI, (3) CT, (4) Cardiac Stress test, 
 ;;   (5) Nuc Med, (6) US, (7) Mammo, (8) General Rad (9) Other
 ;;
 ;;4. "Procedure Types" are assigned by a national CPT code look-up table
 ;;   and may differ from locally defined "Imaging Types."  Therefore the
 ;;   number of procedures in each category may not be the same as other
 ;;   radiology management reports.
 ;;
 ;;5. "Avg. Days" is the average days wait.  It is calculated from the sum
 ;;   of the days wait for that Procedure Type, divided by the count of cases
 ;;   included in this report for that Procedure Type.  Negative days wait
 ;;   is counted as 0.  A "-" means an average cannot be calculated.
 ;;
 ;;6. Procedure Type of "unknown" refers to either cases that have no 
 ;;   matching procedure type in the spreadsheet of CPT Codes provided
 ;;   by the Office of Patient Care Services, or cases that are missing
 ;;   data for the procedure.
 ;;
 ;
DAY14 ;
 ;;   The "<=14 Days" column contains data that is also in the "<=30
 ;;   Days" column. The reason that performance is calculated for both
 ;;   <=14 days and <=30 days is so that facilities can track their
 ;;   performance to a 14 day performance standard rather than a 30
 ;;   day standard if they choose to do so.
 ;;
