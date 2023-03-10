RAO7PC1 ;HISC/GJC,SS-Procedure Call utilities. ; Jan 12, 2021@08:36:20
 ;;5.0;Radiology/Nuclear Medicine;**1,16,18,26,36,45,75,143,156,166,178**;Mar 16, 1998;Build 2
 ;
EN1(RADFN,RABDT,RAEDT,RAEXN,RACINC) ;
 ;
 ; DBIA#2043 - Return list of exams within date range
 ;
 ; ** See routines RAO7PC1A and RAO7PC2 for additional comments **
 ; ** and output node descriptions                              **
 ;
 ; Input: RADFN-> Patient IEN        RABDT-> beginning date
 ;        RAEDT-> ending date        RAEXN-> max # of exams
 ;        RACINC-> include cancelled exams? (1 if yes, default no)
 ;
 ; Output:
 ; ^TMP($J,"RAE1",Patient IEN,Exam ID)=Procedure name^Case number^
 ;       Report status^Abnormal alert flag^Report ien^
 ;       Exam status order #~Exam status name^
 ;       Imaging location name^Imaging type abbr~
 ;       Imaging type name^abnormal results flag^CPT Code
 ;       ^CPRS Order ien^Images exist flag
 ;
 ;if there are one or more CPT modifiers:
 ; ^TMP($J,"RAE1",Patient IEN,Exam ID,"CMOD",n)=CPT Mod^CPT Mod Name
 ;                                         n+1)=CPT Mod^CPT Mod Name
 ;
 ;if CPRS asks to display parent procs, and case is descendent of parent:
 ; ^TMP($J,"RAE1",Patient IEN,Exam ID,"CPRS")=memb of set^parent prc name
 ;
 ; Note: It is possible for the ^TMP global data returned to contain
 ;       'No Report' and a Report file ien for the same exam.  This is
 ;       because Imaging can create a report stub in the Report file,
 ;       but no report interpretation exists and no status is assigned
 ;       to the report record.
 ;
 ; Exam ID: exam date/time (inverse) concatenated with the case IEN
 ; Abnormal alert flag:  Y or blank
 ; Abnormal results flag:  Y or blank, may be turned on even if
 ;     abnormal alert flag is not
 ;
 Q:'RADFN!('RABDT)!('RAEDT)
 N RAEXNP S RAEXNP=RAEXN ;save original value of RAEXN
 ; if last char RAEXNP has "P", then count max no. by parent and 
 ; single, not by individual cases
 S RACINC=+$G(RACINC)
 Q:RABDT>RAEDT  ; quit if ending date before beginning date
 K ^TMP($J,"RAE1") S RAEXN=+$G(RAEXN)
 S:$P(RABDT,".",2) RABDT=RABDT\1 S:$P(RAEDT,".",2) RAEDT=RAEDT\1
 N RABNOR,RACNST,RACNT,RACPT,RACSE,RADIAG,RAIBDT,RAIEDT,RAILOC,RAITY
 N RANO,RAPRC,RAREX,RARPT,RARPTST
 N RAXAM,RAXID,RAXIT,RAXSTAT,RABNORMR,RASHOCAN
 S RACNST=9999999.9999
 S RAIBDT=RACNST-(RAEDT+.9999),RAIEDT=RACNST-(RABDT-.0001)
 S (RACNT,RAXIT)=0
 F  S RAIBDT=$O(^RADPT(RADFN,"DT",RAIBDT)) Q:RAIBDT'>0!(RAIBDT>RAIEDT)  D  Q:RAXIT
 . D SETDATA^RAO7PC1A ; obtain exam data, set ^TMP($J,"RAE1",Patient IEN,Exam ID)
 . Q
 Q
EN2(RADFN) ;
 ;
 ; DBIA#2012 - Return last 7 days of non-cancelled exams
 ;
 ; Input: RADFN-> Patient IEN
 ;
 ; Output:
 ; ^TMP($J,"RAE7",Patient IEN,Exam ID)=procedure name^case number^
 ;       report status^imaging location IEN^imaging location name^
 ;       contrast medium or media used
 ;       Note: Single characters in parenthesis indicate contrast
 ;       involvement: (I)=Iodinated ionic; (N)=Iodinated non-ionic;
 ;        (L)=Gadolinium; (C)=Oral Cholecystographic; (G)=Gastrografin;
 ;        (B)=Barium; (M)=unspecified contrast media
 ;
 ; Exam ID: exam date/time (inverse) concatenated with the case IEN
 ;
 Q:'RADFN  D EN2^RAO7PC1A Q
 ;
EN3(X) ; DBIA#2265 - Return narrative text for exam(s)
 ; Input:
 ; X-> Exam id in one of two forms:
 ;   1) Pat. DFN^inv. exam date^Case IEN
 ;      Retrieves a single report for a single exam
 ;   2) Pat. DFN^inv. exam date^
 ;      Retrieves all reports for a set of exams ordered on one order
 ;
 ; Note:  Input delimiter can be any of the following: ^~\&;-
 ;        a delimiter may be a single space i.e, " "
 ;
 ; Output:
 ; ^TMP($J,"RAE2",Patient IEN,case IEN,procedure name)=report status^
 ; abnormal alert flag^CPRS Order ien^amended report?
 ; ^TMP($J,"RAE2",Patient IEN,case IEN,procedure name,"CM",n)=contrast
 ; media used during exam (internal)^contrast media used during exam
 ; (external)
 ; ^TMP($J,"RAE2",Patient IEN,case IEN,procedure name,"D",n)=diagnostic
 ; code (n=1, this is the primary code)
 ; ^TMP($J,"RAE2",Patient IEN,case IEN,procedure name,"H",n)=clin history
 ; (a line of text)
 ; ^TMP($J,"RAE2",Patient IEN,case IEN,procedure name,"I",n)=impression
 ; (a line of text)
 ; ^TMP($J,"RAE2",Patient IEN,case IEN,procedure name,"M",n)=modifier
 ; (external format)
 ; ^TMP($J,"RAE2",Patient IEN,case IEN,procedure name,"P")=primary
 ; interpreting staff IEN^primary interpreting resident IEN^date
 ; report entered
 ; ^TMP($J,"RAE2",Patient IEN,case IEN,procedure name,"R",n)=report
 ; (a line of text)
 ; ^TMP($J,"RAE2",Patient IEN,case IEN,procedure name,"RFS")=REASON
 ; FOR STUDY; the reason the study was conducted (a line of text)
 ; ^TMP($J,"RAE2",Patient IEN,case IEN,procedure name,"V",n)=verifier IEN
 ; ^signature block name
 ; ^TMP($J,"RAE2",Patient IEN,case IEN,procedure name,"TCOM",1)=techno-
 ; logist comment (a line of text)
 ; ^TMP($J,"RAE2",Patient IEN,"PRINT_SET")=null (IFF this is a printset)
 ; ^TMP($J,"RAE2",Patient IEN,"ORD")=name of ordered procedure for
 ;  examsets and printsets
 ; ^TMP($J,"RAE2",Patient IEN,"ORD",case IEN)=name of ordered procedure
 ;  for that case; not part of an examset or printset
 ;
 ; parse out RADFN & RADTI
 N RADELIM,RADFN,RADTI,RACNI,RAINVXDT,RAPSET
 S RADELIM=$$DEL(X) Q:RADELIM=""
 ; Quit if no Pat. DFN -or- no inv. exam DT
 S RADFN=$P(X,RADELIM),RADTI=$P(X,RADELIM,2)
 Q:RADFN'>0  Q:RADTI'>0
 S RAPSET=0 ;referenced in RAO7PC2 
 ;
 ; if RACNI get our single record and quit
 I $L(X,RADELIM)=3 D
 .N RACNI,RAY3,RAQRYST
 .S RACNI=$P(X,RADELIM,3)
 .Q:RACNI'>0  Q:'$D(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0))
 .S RAY3=$G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0))
 .; if the order of the exam status is zero (canceled) quit
 .S RAQRYST=$P($G(^RA(72,+$P(RAY3,U,3),0)),U,3) Q:RAQRYST=0
 .K ^TMP($J,"RAE2") S RAINVXDT=RADTI
 .D CASE^RAO7PC2(RACNI) D SVTCOM^RAUTL11(RADFN,RADTI,RACNI) ;P18 mod by SS
 .Q
 ; if RACNI not present, get RACNI
 E  D
 .K:'$D(RAXSET)#2 ^TMP($J,"RAE2") ;don't kill if called from EN30
 .N RACNI,RAY3,RAQRYST S RACNI=0
 .F  S RACNI=$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI)) Q:'RACNI  D
 ..Q:'$D(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0))
 ..S RAY3=$G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0))
 ..;
 ..; get the exam status pointer, find the order number
 ..; quit if the order number is zero ('canceled')
 ..; even if you allow canceling of 'complete' studies
 ..; & allow reports on canceled studies the 'Cancel an
 ..; Exam' option prevents the cancel action
 ..;
 ..S RAQRYST=$P($G(^RA(72,+$P(RAY3,U,3),0)),U,3) Q:RAQRYST=0
 ..S RAINVXDT=RADTI D CASE^RAO7PC2(RACNI)
 ..D SVTCOM^RAUTL11(RADFN,RADTI,RACNI) ;P18 save TCOM in ^TMP
 ..S RAPSET=0 ;P18 modified
 ..Q 
 .Q
 Q
 ;
EN30(RAOIFN) ; DBIA#2266 - Return narrative text for exam(s). To be used
 ; with the EN3 entry point above.
 ; Input: RAOIFN -> the ien of Rad/Nuc Med Order
 K ^TMP($J,"RAE2")
 Q:'RAOIFN  ; order passed in as 0 or null
 Q:'$D(^RAO(75.1,RAOIFN,0))  ; no such order
 Q:'$D(^RADPT("AO",RAOIFN))  ; no exam associated with this order
 N RADFN,RADTI,RACNI,RAXSET,RAY2
 S RADFN=+$O(^RADPT("AO",RAOIFN,0)) Q:'RADFN
 ;
 ; This order IEN will be unique for patient 'RADFN'
 ; but this same order could be associated with more
 ; than one study.
 ;
 S RADTI=0 F  S RADTI=$O(^RADPT("AO",RAOIFN,RADFN,RADTI)) Q:RADTI'>0  D
 .S RAY2=$G(^RADPT(RADFN,"DT",RADTI,0)),RAXSET=$P(RAY2,U,5)
 .; if RAXSET=1 we have a exam/printset
 .I RAXSET D EN3(RADFN_"^"_RADTI) Q  ; exam set, hit EN3 code
 .; multiple studies can be tied to the same order when an exam is
 .; canceled (order on 'hold')
 .S RACNI=0
 .F  S RACNI=+$O(^RADPT("AO",RAOIFN,RADFN,RADTI,RACNI)) Q:'RACNI  D
 ..D EN3(RADFN_"^"_RADTI_"^"_RACNI)
 ..Q
 .Q
 Q
EN4(RABBRV,RAARY) ; Return Imaging Locations
 ; Input: RABBRV-> Abbreviation for I-Type    RAARY-> data storage array
 ;
 ; Output:
 ; array name(location IEN)=File 79.1 IEN^File 44 name^division IEN
 ; ^division name
 ;
 Q:RABBRV']""  ; quit no I-Type abbreviation
 Q:RAARY']""  ;  quit no data storage array
 N RADIV,RAITY,RALOC,RAX,RASUP
 S RAITY=+$O(^RA(79.2,"C",RABBRV,0)) Q:'RAITY
 S RAX=0 F  S RAX=$O(^RA(79.1,"BIMG",RAITY,RAX)) Q:RAX'>0  D
 . S RADIV(79)=$G(^RA(79.1,RAX,"DIV"))
 . S RALOC(0)=$G(^RA(79.1,RAX,0))
 . Q:$P(RALOC(0),"^",19)]""  ;inactive DT present, can't be a future DT
 . ;p178/KML - Check new I-LOC parameter to suppress sumbitting orders to it in CPRS
 . S RASUP=$$GET1^DIQ(79.1,RAX,.1) Q:$G(RASUP)["Y"
 . S RALOC=$P($G(^SC(+RALOC(0),0)),U)
 . S RALOC=$S(RALOC]"":RALOC,1:"Unknown")
 . S RADIV=+$P($G(^RA(79,+RADIV(79),0)),U),RADIV(4)=$G(^DIC(4,RADIV,0))
 . S RADIV=$S($P(RADIV(4),U)]"":$P(RADIV(4),U),1:"Unknown")
 . S @(RAARY_"("_RAX_")")=RAX_U_RALOC_U_+RADIV(79)_U_RADIV
 . Q
 Q
CASE(RAOIFN,RARRAY) ; Return the case numbers and the total number of
 ; case numbers associated with a particular order.
 ; Input: RAOIFN-order ien (75.1)
 ;        RARRAY-data storage (local array)
 ; Return: RATTL-n^x where n is the number of cases in the array
 ;               x=PRINTSET if a single report covers many cases.
 ;               -1 if error (invalid order ien)
 ;               -2 no registered case to date -OR- case(s) cancelled
 ;               If -1 or -2, second piece of RATTL gives the reason
 ;         RARRAY-local data array, array_name(case #)
 N RATTL S RATTL="" D CASE^RAO7PC1A
 Q RATTL
DEL(X) ; Determine the delimiter used to seperate the data
 ; Input: 'X'-> data seperated by a delimiter (first & second pieces
 ; will follow null)
 N Y,Z
 F Y="^","~","\","&",";","-"," " S Z=$F(X,Y) I +Z Q
 Q $S(+Z>0:Y,1:"") ; pass back the delimiter used, or null if not found
 ;
